#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""install.py —— AC_db_chinese 安全安装器。

设计原则：
1. 默认 dry-run：只解析与预检，不写数据库；加 --apply 才真正执行。
2. 只装核心是默认行为；Playerbot 可选汉化必须显式 --playerbots。
3. 幂等：每个文件按 (文件, sha256) 记账到 <world库>.ac_db_chinese_log，重复安装自动跳过。
4. 池化文件（TRUNCATE/范围 DELETE）应用前自动建 <表>_zhbak 备份表（仅首次）。
5. 文件内绝无 DROP/ALTER，不触碰任何非中文列。

依赖：apply 需要 pymysql（pip install pymysql）；--mysql-cli 可改用 mysql 客户端。
dry-run / 预检无需任何依赖、无需数据库连接。
"""
import argparse
import hashlib
import json
import os
import re
import sys
import time

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.dirname(HERE)
MANIFEST = os.path.join(REPO, 'data', 'manifest.json')

STMT_RE = re.compile(
    r'(?P<stmt>(?:SET|START\s+TRANSACTION|COMMIT|INSERT|UPDATE|DELETE|TRUNCATE)\b[^;]*?);',
    re.I | re.S)


def sha256_file(path):
    with open(path, 'rb') as f:
        return hashlib.sha256(f.read()).hexdigest()


def load_manifest():
    with open(MANIFEST, encoding='utf-8') as f:
        return json.load(f)


def split_statements(sql_text):
    """按分号切分语句（字符串内分号已被转义处理：走简单状态机）。"""
    stmts, cur, in_str, q = [], [], False, None
    i, n = 0, len(sql_text)
    while i < n:
        c = sql_text[i]
        if in_str:
            if c == '\\' and q == "'":
                cur.append(c)
                if i + 1 < n:
                    cur.append(sql_text[i + 1])
                i += 2
                continue
            if c == q:
                if i + 1 < n and sql_text[i + 1] == q:
                    cur.append(c)
                    cur.append(q)
                    i += 2
                    continue
                in_str = False
            cur.append(c)
        else:
            if c in ("'", '"'):
                in_str, q = True, c
                cur.append(c)
            elif c == ';':
                stmts.append(''.join(cur).strip())
                cur = []
            elif c == '-' and sql_text[i:i + 2] == '--':
                j = sql_text.find('\n', i)
                i = (j if j != -1 else n) - 1
            else:
                cur.append(c)
        i += 1
    tail = ''.join(cur).strip()
    if tail:
        stmts.append(tail)
    return [s for s in stmts if s and not s.startswith('--')]


class DB:
    """MySQL 连接适配：优先 pymysql，其次 mysql 命令行。"""

    def __init__(self, args):
        self.args = args
        self.mode = None
        self.conn = None
        try:
            import pymysql  # noqa: F401
            self.mode = 'pymysql'
        except ImportError:
            if args.mysql_cli:
                self.mode = 'cli'
            else:
                sys.exit('错误: 需要 pymysql（pip install pymysql）或指定 --mysql-cli 使用 mysql 客户端。')

    def connect(self):
        if self.mode == 'pymysql':
            import pymysql
            self.conn = pymysql.connect(
                host=self.args.host, port=self.args.port, user=self.args.user,
                password=self.args.password, charset='utf8mb4', autocommit=False)
        else:
            self._cli_env()
        self._db_for_cli = None

    def _cli_env(self):
        import subprocess
        self._cli = ['mysql', '-h', self.args.host, '-P', str(self.args.port),
                     '-u', self.args.user]
        if self.args.password:
            self._cli += ['-p' + self.args.password]
        self._cli += ['--default-character-set=utf8mb4']

    def execute_file(self, dbname, sql_text):
        """在指定库执行整段 SQL，返回 (语句数)。事务包裹（TRUNCATE 除外，MySQL 无法回滚）。"""
        stmts = split_statements(sql_text)
        if self.mode == 'pymysql':
            cur = self.conn.cursor()
            cur.execute('USE `%s`' % dbname)
            in_tx = False
            for s in stmts:
                up = s.upper()
                if up.startswith('SET') or up.startswith('USE'):
                    cur.execute(s)
                    continue
                if up.startswith('TRUNCATE'):
                    if in_tx:
                        self.conn.commit()
                        in_tx = False
                    cur.execute(s)
                    continue
                if up.startswith('START TRANSACTION'):
                    in_tx = True
                    continue
                if up.startswith('COMMIT'):
                    self.conn.commit()
                    in_tx = False
                    continue
                cur.execute(s)
                if not in_tx:
                    in_tx = True
            self.conn.commit()
        else:
            import subprocess
            cmd = self._cli + [dbname]
            r = subprocess.run(cmd, input=sql_text.encode('utf-8'),
                               capture_output=True)
            if r.returncode != 0:
                raise RuntimeError('mysql 客户端执行失败: %s' % r.stderr.decode('utf-8', 'replace')[:500])
        return len(stmts)

    def fetchall(self, dbname, sql):
        if self.mode == 'pymysql':
            cur = self.conn.cursor()
            cur.execute('USE `%s`' % dbname)
            cur.execute(sql)
            return cur.fetchall()
        import subprocess
        cmd = self._cli + ['-N', '-B', dbname, '-e', sql]
        r = subprocess.run(cmd, capture_output=True)
        if r.returncode != 0:
            return []
        return [line.split('\t') for line in r.stdout.decode('utf-8', 'replace').splitlines() if line]


def precheck(db, args, files):
    """预检：库与表是否存在、字符集。返回问题列表。"""
    problems = []
    need = {}
    for e in files:
        need.setdefault(e['db'], set()).add(e['table'])
    dbmap = {'acore_world': args.world, 'acore_characters': args.characters,
             'acore_playerbots': args.playerbots_db, 'acore_auth': args.auth}
    for logical, tables in need.items():
        real = dbmap[logical]
        dbs = [r[0] for r in (db.fetchall('information_schema',
                                           "SELECT SCHEMA_NAME FROM information_schema.SCHEMATA WHERE SCHEMA_NAME='%s'" % real)
                              or [])]
        if not dbs:
            problems.append('库不存在: %s（逻辑名 %s）' % (real, logical))
            continue
        for t in tables:
            found = db.fetchall(real,
                                "SELECT table_name FROM information_schema.tables "
                                "WHERE table_schema='%s' AND table_name='%s'" % (real, t))
            if not found:
                problems.append('表不存在: %s.%s' % (real, t))
    return problems


def main():
    ap = argparse.ArgumentParser(description='AC_db_chinese 简体中文语言包安装器')
    ap.add_argument('--host', default='127.0.0.1')
    ap.add_argument('--port', type=int, default=3306)
    ap.add_argument('--user', default='root')
    ap.add_argument('--password', default='')
    ap.add_argument('--world', default='acore_world', help='world 库名')
    ap.add_argument('--characters', default='acore_characters', help='characters 库名')
    ap.add_argument('--playerbots-db', default='acore_playerbots', help='playerbots 模块库名')
    ap.add_argument('--auth', default='acore_auth', help='auth 库名')
    ap.add_argument('--playerbots', action='store_true', help='同时安装 Playerbot 可选汉化（默认不装）')
    ap.add_argument('--force', action='store_true', help='忽略记账记录强制重装')
    ap.add_argument('--apply', action='store_true', help='真正执行（默认 dry-run 预览）')
    ap.add_argument('--mysql-cli', action='store_true', help='用 mysql 命令行代替 pymysql')
    ap.add_argument('--module', choices=['core', 'playerbots', 'all'], default=None,
                    help='选择安装模块（默认 core；--playerbots 等价 --module all）')
    args = ap.parse_args()
    if args.playerbots:
        args.module = 'all'
    module = args.module or 'core'

    manifest = load_manifest()
    files = [e for e in manifest
             if (module == 'all' and e['db'] != 'acore_auth')
             or (module == 'core' and e['module'] == 'core')]
    if not files:
        sys.exit('清单中没有匹配的文件（module=%s）' % module)

    total_rows = sum(e['rows'] for e in files)
    print('=== AC_db_chinese 安装预览（module=%s, %d 个文件, 约 %d 行）==='
          % (module, len(files), total_rows))
    for e in files:
        kinds = {'locale': 'locale 表', 'acore_string': '系统字符串', 'main': '主表直译',
                 'update': '守卫 UPDATE', 'pool': '名称池'}
        print('  [%s] %-58s %8s 行  -> %s.%s'
              % (kinds.get(e['kind'], e['kind']), e['file'], e['rows'], e['db'], e['table']))

    db = DB(args)
    if not args.apply:
        print('\n这是 dry-run 预览（未连接数据库、未做任何修改）。')
        print('确认无误后加 --apply 执行；Playerbot 用户加 --playerbots。')
        return

    db.connect()
    problems = precheck(db, args, files)
    if problems:
        print('\n预检失败:')
        for p in problems:
            print('  -', p)
        sys.exit('请先确认数据库结构（基表须由 AzerothCore / mod-playerbots 正常安装）。')

    # 记账表
    logdb = args.world
    db.execute_file(logdb, """
CREATE TABLE IF NOT EXISTS `ac_db_chinese_log` (
  `file` VARCHAR(255) NOT NULL,
  `sha256` CHAR(64) NOT NULL,
  `module` VARCHAR(32) NOT NULL DEFAULT '',
  `rows` INT NOT NULL DEFAULT 0,
  `applied_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`file`, `sha256`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AC_db_chinese 安装记账';
""".strip())
    applied_before = {r[0] + ':' + r[1] for r in (db.fetchall(
        logdb, 'SELECT file, sha256 FROM ac_db_chinese_log') or [])}

    print('\n开始安装...')
    t0 = time.time()
    for e in files:
        key = e['file'] + ':' + e['sha256']
        if key in applied_before and not args.force:
            print('  跳过（已安装同版本）: %s' % e['file'])
            continue
        path = os.path.join(REPO, e['file'])
        with open(path, encoding='utf-8') as f:
            sql_text = f.read()
        real_db = {'acore_world': args.world, 'acore_characters': args.characters,
                   'acore_playerbots': args.playerbots_db, 'acore_auth': args.auth}[e['db']]
        if e['kind'] == 'pool':
            bak = e['table'] + '_zhbak'
            db.execute_file(real_db,
                            'CREATE TABLE IF NOT EXISTS `%s` AS SELECT * FROM `%s`;'
                            % (bak, e['table']))
            print('  备份: %s -> %s' % (e['table'], bak))
        n = db.execute_file(real_db, sql_text)
        esc_file = e['file'].replace("'", "''")
        db.execute_file(logdb,
                        "DELETE FROM `ac_db_chinese_log` WHERE `file`='%s';" % esc_file)
        db.execute_file(logdb,
                        "INSERT INTO `ac_db_chinese_log` (`file`,`sha256`,`module`,`rows`) "
                        "VALUES ('%s','%s','%s',%d);" % (esc_file, e['sha256'], e['module'], e['rows']))
        print('  完成: %-58s %4d 条语句' % (e['file'], n))
    print('\n安装完成，用时 %.1f 秒。' % (time.time() - t0))
    if module == 'core':
        print('提示: 如需机器人汉化，请加 --playerbots 安装可选模块。')


if __name__ == '__main__':
    main()
