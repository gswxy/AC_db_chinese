#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""extract_playerbot_strings.py —— 提取 mod-playerbots 模块 C++ 源码中玩家可见的英文字面量。

用途：为 Playerbot 的 C++ 硬编码文本建立未翻译清单（reports/playerbot_untranslated_strings.csv），
供后续翻译贡献者按分类认领。仅做静态扫描，不修改任何源码。

用法：
    python scripts/extract_playerbot_strings.py <mod-playerbots 源码目录> [输出.csv]

扫描通道（与审计口径一致）：
  TellMaster / TellMasterNoFacing / TellError 的字符串字面量、
  bot->Say/Yell/Whisper/TextEmote 字面量、ChatHandler::PSendSysMessage/SendSysMessage 字面量。
"""
import csv
import os
import re
import sys

CHANNELS = [
    ('TellMaster', r'\bTellMaster\s*\(\s*"'),
    ('TellMasterNoFacing', r'\bTellMasterNoFacing\s*\(\s*"'),
    ('TellError', r'\bTellError\s*\(\s*"'),
    ('Say', r'->Say\s*\(\s*"'),
    ('Yell', r'->Yell\s*\(\s*"'),
    ('Whisper', r'->Whisper\s*\(\s*"'),
    ('PSendSysMessage', r'\bPSendSysMessage\s*\(\s*"'),
    ('SendSysMessage', r'\bSendSysMessage\s*\(\s*"'),
]

# 常见非玩家可见前缀（日志/调试宏等）
SKIP_FILES = ('./', 'Log.h')


def classify(path, text):
    """按路径与内容粗分类（与 playerbot_audit.md 的分类一致）。"""
    p = path.replace('\\', '/').lower()
    base = os.path.basename(p)
    if 'helpaction' in base:
        return '命令帮助'
    if 'statsaction' in base or 'tellitemcount' in base:
        return '状态查询'
    if 'chatshortcut' in base or 'leavegroup' in base or 'guild' in base or 'readycheck' in base \
            or 'passleadership' in base or 'attack' in base or 'flee' in base:
        return '组队/公会交互'
    if 'trade' in base or 'sendmail' in base or 'rpgsub' in base or 'petition' in base or 'arenateam' in base:
        return '交易/邮件/物品'
    if 'quest' in base:
        return '任务交互'
    if 'debugaction' in base or 'tellcastfailed' in base or 'inventorychangefailure' in base:
        return '错误与调试'
    if 'playerbotmgr' in base or 'playerbotai' in base or 'securitycheck' in base:
        return '命令反馈/系统'
    if 'sayaction' in base or 'emoteaction' in base or 'suggest' in base or 'broadcast' in base:
        return '机器人台词'
    if '/actions/' in p or 'action.cpp' in base:
        return '动作反馈'
    return '其他'


def extract(root):
    rows = []
    for dirpath, _dirs, files in os.walk(root):
        for fn in files:
            if not fn.endswith(('.cpp', '.h')):
                continue
            path = os.path.join(dirpath, fn)
            rel = os.path.relpath(path, root)
            try:
                src = open(path, encoding='utf-8', errors='replace').read()
            except OSError:
                continue
            lines = src.split('\n')
            for lineno, line in enumerate(lines, 1):
                for chan, pat in CHANNELS:
                    if re.search(pat, line):
                        m = re.search(r'"((?:[^"\\]|\\.)*)"', line)
                        if m and m.group(1).strip():
                            rows.append((chan, rel.replace('\\', '/'), lineno,
                                         m.group(1), classify(rel, m.group(1))))
                        break
    return rows


def main():
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    root = sys.argv[1]
    out = sys.argv[2] if len(sys.argv) > 2 else os.path.join(
        os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
        'reports', 'playerbot_untranslated_strings.csv')
    rows = extract(root)
    os.makedirs(os.path.dirname(out), exist_ok=True)
    with open(out, 'w', encoding='utf-8-sig', newline='\n') as f:
        w = csv.writer(f)
        w.writerow(['通道', '文件', '行号', '英文字面量', '功能分类'])
        w.writerows(rows)
    from collections import Counter
    by_cls = Counter(r[4] for r in rows)
    print('提取 %d 条玩家可见英文字面量 -> %s' % (len(rows), out))
    for k, v in by_cls.most_common():
        print('  %-14s %d' % (k, v))


if __name__ == '__main__':
    main()
