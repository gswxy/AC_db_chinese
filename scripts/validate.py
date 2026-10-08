#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""validate.py —— 仓库 SQL 与清单的静态验证（无数据库依赖，CI 可用）。

检查项：
1. 所有 locales/**/*.sql 为严格 UTF-8、无 BOM、LF 换行。
2. 语句白名单：INSERT/UPDATE/DELETE/SET/START TRANSACTION/COMMIT/TRUNCATE(池文件)。
   禁止 DROP/ALTER/CREATE/LOCK/RENAME 及 MySQL 8 专有 utf8mb4_0900 排序规则。
3. locale 表文件每行的 locale 列必须全是 'zhCN'。
4. 守卫式 UPDATE（playerbots 文件）中文文本必须保留英文原文中的占位符（%xxx 与 <xxx>）。
5. data/manifest.json 与实际文件一一对应、行数一致、模块/目标库分离。
"""
import json
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.dirname(HERE)
sys.path.insert(0, HERE)
import acparse  # noqa: E402

ALLOWED = re.compile(r'^(SET NAMES|START TRANSACTION|COMMIT|INSERT INTO|UPDATE|DELETE FROM|TRUNCATE TABLE)\b', re.I)
FORBIDDEN = re.compile(r'\b(DROP\s+TABLE|ALTER\s+TABLE|CREATE\s+TABLE|LOCK\s+TABLES|RENAME\s+TABLE|utf8mb4_0900)\b', re.I)
PLACEHOLDER = re.compile(r'%(?:[A-Za-z_][A-Za-z0-9_]*)|<[^<>]+>')


def read_bytes(path):
    with open(path, 'rb') as f:
        return f.read()


def check_file(path, entry):
    problems = []
    raw = read_bytes(path)
    if raw.startswith(b'\xef\xbb\xbf'):
        problems.append('含 BOM')
    if b'\r' in raw:
        problems.append('含 CR（必须 LF）')
    try:
        raw.decode('utf-8', errors='strict')
    except UnicodeDecodeError as e:
        problems.append('非严格 UTF-8: %s' % e)
        return problems
    sql = raw.decode('utf-8')
    is_playerbot = entry['module'] == 'playerbots'
    is_pool = entry.get('kind') == 'pool'

    if not sql.lstrip().startswith('-- AC_db_chinese'):
        problems.append('缺少标准文件头')

    body = acparse.strip_comments(sql)
    for st in [s.strip() for s in body.split(';\n') if s.strip()]:
        head = st.split('(')[0].strip()
        if not ALLOWED.match(head):
            problems.append('白名单外语句: %s...' % head[:50])
        if FORBIDDEN.search(st):
            problems.append('禁用语句/排序规则: %s...' % st[:60])

    # locale 表：zhCN 唯一语种
    if '_locale' in entry['file'] and entry.get('kind') != 'pool':
        table = entry['table']
        li = None
        for cols, fields in acparse.iter_values_rows(sql, table):
            if li is None and cols:
                lc = [c.lower() for c in cols]
                li = lc.index('locale') if 'locale' in lc else 1
            if len(fields) <= li or fields[li].strip() != "'zhCN'":
                problems.append('locale 表出现非 zhCN 行: %s...' % fields[0][:40])
                break

    # playerbots 守卫 UPDATE 占位符保留：SET 的中文必须保留 WHERE 英文原文中的占位符
    if is_playerbot:
        upd_re = re.compile(r"^UPDATE `(\w+)` SET (.*?) WHERE (.*?);$", re.I | re.S | re.M)
        for m in upd_re.finditer(body):
            set_part, where_part = m.group(2), m.group(3)
            zh_m = re.search(r"`(?:text|text_loc4)`='((?:[^'\\]|\\.)*)'", set_part)
            en_m = re.search(r"`text`='((?:[^'\\]|\\.)*)'", where_part)
            if not zh_m or not en_m:
                continue
            zh = acparse.sql_unquote("'" + zh_m.group(1) + "'") or ''
            en = acparse.sql_unquote("'" + en_m.group(1) + "'") or ''
            if sorted(PLACEHOLDER.findall(en)) != sorted(PLACEHOLDER.findall(zh)):
                problems.append('占位符不一致: en=%s zh=%s' % (
                    sorted(PLACEHOLDER.findall(en)), sorted(PLACEHOLDER.findall(zh))))

    # 模块分离：playerbots 不得写 world 库；文件头目标库与 manifest 一致
    if is_playerbot and entry['db'] == 'acore_world':
        problems.append('playerbots 文件不得写入 acore_world')
    return problems


def main():
    manifest_path = os.path.join(REPO, 'data', 'manifest.json')
    manifest = json.load(open(manifest_path, encoding='utf-8'))
    manifest_files = {e['file']: e for e in manifest}
    seen = set()
    failed = 0
    rows_by_table = {}

    for path in iter_sql():
        rel = rel_of(path)
        seen.add(rel)
        entry = manifest_files.get(rel)
        if not entry:
            print('FAIL %s' % rel)
            print('   - 文件有但清单缺')
            failed += 1
            continue
        ps = check_file(path, entry)
        # 行数对账
        sql = read_bytes(path).decode('utf-8')
        n = count_rows(sql, entry)
        if n != entry['rows']:
            ps.append('行数与清单不符: 实际 %d vs 清单 %d' % (n, entry['rows']))
        rows_by_table[rel] = n
        if ps:
            failed += 1
            print('FAIL %s' % rel)
            for p in ps:
                print('   -', p)
        else:
            print('PASS %s (%d 行)' % (rel, n))

    for f in sorted(set(manifest_files) - seen):
        print('FAIL 清单有但文件缺: %s' % f)
        failed += 1

    total = sum(rows_by_table.values())
    print('\n=== 校验结果: %s（文件 %d，总行数 %d）==='
          % ('通过' if failed == 0 else '未通过', len(seen), total))
    sys.exit(0 if failed == 0 else 1)


def iter_sql():
    for root, _dirs, files in os.walk(os.path.join(REPO, 'locales')):
        for f in sorted(files):
            if f.endswith('.sql'):
                yield os.path.join(root, f)


def rel_of(path):
    return os.path.relpath(path, REPO).replace('\\', '/')


def count_rows(sql, entry):
    """清单行数口径：locale/insert 元组数；update 语句数；pool 按 INSERT 元组数。"""
    kind = entry.get('kind')
    if kind in ('update',):
        return len(re.findall(r'^UPDATE ', acparse.strip_comments(sql), re.I | re.M))
    if kind in ('main',):
        return len(re.findall(r'^UPDATE ', acparse.strip_comments(sql), re.I | re.M))
    if kind == 'acore_string':
        return len(re.findall(r'^UPDATE ', acparse.strip_comments(sql), re.I | re.M))
    n = 0
    for _cols, _fields in acparse.iter_values_rows(sql):
        n += 1
    return n


if __name__ == '__main__':
    main()
