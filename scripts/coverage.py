#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""coverage.py —— 生成覆盖率报告 reports/coverage.md（无数据库依赖）。

口径说明：
- 「可汉化基数」= 该表在官方基线（azerothcore-wotlk @7b2cecef 基表）中的实体总数；
- 「已覆盖」= 本仓库实际携带的 zhCN 行数（由 SQL 文件实时统计，防手工篡改）；
- Playerbot 独立统计（bot 文本表以新版基线行数为基数），不与核心混算。
"""
import json
import os
import sys
from datetime import date

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.dirname(HERE)
sys.path.insert(0, HERE)
import acparse  # noqa: E402

# 各表可汉化基数（2026-10-08 由官方基线统计，见 data/reference_counts.json 生成说明）
REFERENCE = json.load(open(os.path.join(REPO, 'data', 'reference_counts.json'), encoding='utf-8'))


def rows_in_file(path, kind):
    sql = open(path, encoding='utf-8').read()
    body = acparse.strip_comments(sql)
    if kind in ('update', 'acore_string', 'main'):
        return len([l for l in body.split('\n') if l.startswith('UPDATE ')])
    n = 0
    for _cols, _fields in acparse.iter_values_rows(sql):
        n += 1
    return n


def main():
    manifest = json.load(open(os.path.join(REPO, 'data', 'manifest.json'), encoding='utf-8'))
    core, pb = [], []
    for e in manifest:
        path = os.path.join(REPO, e['file'])
        actual = rows_in_file(path, e.get('kind'))
        entry = dict(e)
        entry['actual'] = actual
        (pb if e['module'] == 'playerbots' else core).append(entry)

    lines = [
        '# AC_db_chinese 覆盖率报告',
        '',
        '> 生成于 %s（scripts/coverage.py 自动生成，勿手改）' % date.today().isoformat(),
        '',
        '## 一、AzerothCore 核心汉化（acore_world）',
        '',
        '| 表 | 类型 | 可汉化基数 | 已覆盖 zhCN | 覆盖率 | 说明 |',
        '|---|---|---:|---:|---:|---|',
    ]
    core_total_ref = core_total_cov = 0
    for e in core:
        ref = REFERENCE['core'].get(e['table'], {})
        base = ref.get('base', e['rows'])
        cov = e['actual']
        pct = ('%.1f%%' % (100.0 * cov / base)) if base else '—'
        core_total_ref += base
        core_total_cov += cov
        note = ref.get('note', '')
        kind_name = {'locale': 'locale 表', 'acore_string': '系统字符串列',
                     'main': '主表直译'}.get(e.get('kind'), e.get('kind'))
        lines.append('| %s | %s | %s | %d | %s | %s |' % (e['table'], kind_name, base, cov, pct, note))
    lines.append('| **合计** | | **%d** | **%d** | **%.1f%%** | |'
                 % (core_total_ref, core_total_cov, 100.0 * core_total_cov / core_total_ref))

    lines += [
        '',
        '## 二、Playerbot 可选汉化（独立统计，不计入核心）',
        '',
        '| 表 | 目标库 | 基线行数 | 已汉化 | 说明 |',
        '|---|---|---:|---:|---|',
    ]
    pb_total = 0
    for e in pb:
        ref = REFERENCE['playerbots'].get(e['table'], {})
        base = ref.get('base', e['rows'])
        pb_total += e['actual']
        note = ref.get('note', '')
        lines.append('| %s | %s | %s | %d | %s |' % (e['table'], e['db'], base, e['actual'], note))
    lines.append('| **合计** | | | **%d** | C++ 硬编码约 250–400 条未汉化，见 playerbot_audit.md |' % pb_total)

    lines += [
        '',
        '## 三、官方基线中无 zhCN 数据、本包未覆盖的表',
        '',
    ]
    for t, v in REFERENCE['core_uncovered'].items():
        lines.append('- `%s`：%s' % (t, v))

    out = os.path.join(REPO, 'reports', 'coverage.md')
    with open(out, 'w', encoding='utf-8', newline='\n') as f:
        f.write('\n'.join(lines) + '\n')
    print('已生成 %s（core %d/%d，playerbot %d 行）'
          % (out, core_total_cov, core_total_ref, pb_total))
    # 同步输出机器可读版本供测试比对
    with open(os.path.join(REPO, 'reports', 'coverage.json'), 'w', encoding='utf-8', newline='\n') as f:
        json.dump({'core_total_ref': core_total_ref, 'core_total_cov': core_total_cov,
                   'playerbots_total': pb_total,
                   'files': [{'file': e['file'], 'rows': e['actual']} for e in core + pb]},
                  f, ensure_ascii=False, indent=1)
        f.write('\n')


if __name__ == '__main__':
    main()
