#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""acparse.py —— 共享 SQL 解析工具（validate.py / coverage.py / tests 复用）。"""
import re


def sql_unquote(s):
    """'...' 字面量 -> 原始字符串（处理 \\\\ 与 \\x 与 '' 转义）。非字符串原样返回 None。"""
    if len(s) >= 2 and s[0] == "'" and s[-1] == "'":
        body = s[1:-1]
        out, i = [], 0
        while i < len(body):
            c = body[i]
            if c == '\\' and i + 1 < len(body):
                nxt = body[i + 1]
                out.append({'n': '\n', 'r': '\r', 't': '\t', '0': '\0'}.get(nxt, nxt))
                i += 2
            else:
                out.append(c)
                i += 1
        return ''.join(out)
    return None


def split_fields(row):
    """按顶层逗号切分一行 VALUES 字段（字符串感知 + 括号深度感知）。"""
    fields, cur, in_str, q = [], [], False, None
    depth = 0
    i, n = 0, len(row)
    while i < n:
        c = row[i]
        if in_str:
            if c == '\\' and q == "'":
                cur.append(c)
                if i + 1 < n:
                    cur.append(row[i + 1])
                i += 2
                continue
            if c == q:
                if i + 1 < n and row[i + 1] == q:
                    cur.append(q)
                    i += 2
                    continue
                in_str = False
            cur.append(c)
        else:
            if c in ("'", '"'):
                in_str, q = True, c
                cur.append(c)
            elif c == ',':
                if depth == 0:
                    fields.append(''.join(cur).strip())
                    cur = []
                else:
                    cur.append(c)
            elif c == '(':
                depth += 1
                cur.append(c)
            elif c == ')':
                depth -= 1
                cur.append(c)
            else:
                cur.append(c)
        i += 1
    fields.append(''.join(cur).strip())
    return fields


def iter_values_rows(sql, table=None):
    """产出 (cols, fields)：INSERT 语句中的列名清单与每个元组（字段字符串列表）。

    只匹配 INSERT INTO `table` [cols] VALUES ... ; 结构，跳过列名括号。
    cols 为 None 表示 INSERT 未带列名清单。
    """
    ins_re = re.compile(r'INSERT INTO `(\w+)`(\s*\([^)]*\))?\s*VALUES', re.I)
    pos = 0
    while True:
        m = ins_re.search(sql, pos)
        if not m:
            return
        if table and m.group(1) != table:
            pos = m.end()
            continue
        cols = None
        if m.group(2):
            cols = [c.strip().strip('`') for c in m.group(2).strip().strip('()').split(',')]
        end = sql.find(';\n', m.end())
        if end == -1:
            end = sql.find(';', m.end())
        if end == -1:
            end = len(sql)
        seg = sql[m.end():end]
        # 截掉 ON DUPLICATE KEY UPDATE 子句（其 VALUES(`col`) 会被误当数据元组）
        cut = re.search(r'ON\s+DUPLICATE\s+KEY', seg, re.I)
        if cut:
            seg = seg[:cut.start()]
        i, L = 0, len(seg)
        while i < L:
            if seg[i] != '(':
                i += 1
                continue
            j = i + 1
            depth = 1
            in_str, q = False, None
            while j < L and depth:
                c = seg[j]
                if in_str:
                    if c == '\\' and q == "'":
                        j += 2
                        continue
                    if c == q:
                        if j + 1 < L and seg[j + 1] == q:
                            j += 2
                            continue
                        in_str = False
                elif c in ("'", '"'):
                    in_str, q = True, c
                elif c == '(':
                    depth += 1
                elif c == ')':
                    depth -= 1
                j += 1
            inner = seg[i + 1:j - 1]
            yield cols, split_fields(inner)
            i = j
        pos = end


def strip_comments(sql):
    """去掉 -- 注释行。"""
    return '\n'.join(l for l in sql.split('\n') if not l.strip().startswith('--'))
