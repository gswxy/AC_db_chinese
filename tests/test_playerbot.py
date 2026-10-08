#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""tests.test_playerbot —— Playerbot 可选汉化模块专项测试。"""
import json
import os
import re
import sys
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(HERE))
sys.path.insert(0, os.path.join(REPO, 'scripts'))
import acparse  # noqa: E402
import gen_bot_names_zh as G  # noqa: E402

SQLDIR = os.path.join(REPO, 'locales', 'modules', 'playerbots', 'sql')


class TestNewGenTexts(unittest.TestCase):
    """新代际（ai_playerbot_texts 8 语种表）汉化。"""

    def setUp(self):
        self.path = os.path.join(SQLDIR, '10_ai_playerbot_texts_zhCN.sql')
        self.sql = open(self.path, encoding='utf-8').read()

    def test_updates_guarded_by_name_and_text(self):
        for m in re.finditer(r"^UPDATE `ai_playerbot_texts` SET `text_loc4`='((?:[^'\\]|\\.)*)' "
                             r"WHERE `name`='((?:[^'\\]|\\.)*)' AND `text`='((?:[^'\\]|\\.)*)';$",
                             acparse.strip_comments(self.sql), re.I | re.M):
            zh = acparse.sql_unquote("'" + m.group(1) + "'")
            self.assertTrue(zh and re.search(r'[\u4e00-\u9fff]', zh), '中文行缺中文: %r' % zh)

    def test_zh_only_targets_loc4(self):
        body = acparse.strip_comments(self.sql)
        self.assertIn('SET `text_loc4`', body)
        self.assertNotRegex(body, r'SET `text`')


class TestLegacyText(unittest.TestCase):
    """旧代际（playerbots_text，2022 快照）汉化覆盖 100%。"""

    def test_all_rows_covered(self):
        """基线 210 行必须全部有对应 UPDATE（覆盖率 100%）。"""
        sql = open(os.path.join(SQLDIR, '30_playerbots_text_zhCN.sql'), encoding='utf-8').read()
        n = len(re.findall(r'^UPDATE `playerbots_text`', acparse.strip_comments(sql), re.I | re.M))
        self.assertEqual(n, 210)

    def test_placeholders_preserved(self):
        ph = re.compile(r'%(?:[A-Za-z_][A-Za-z0-9_]*)')
        for m in re.finditer(r"SET `text`='((?:[^'\\]|\\.)*)' WHERE `key`='[^']*' AND `text`='((?:[^'\\]|\\.)*)';",
                             acparse.strip_comments(
                                 open(os.path.join(SQLDIR, '30_playerbots_text_zhCN.sql'),
                                      encoding='utf-8').read())):
            en = acparse.sql_unquote("'" + m.group(2) + "'")
            zh = acparse.sql_unquote("'" + m.group(1) + "'")
            self.assertEqual(sorted(ph.findall(en)), sorted(ph.findall(zh)), en)


class TestSpeechPools(unittest.TestCase):
    def test_both_generations_present(self):
        for f, n_expect in [('20_playerbots_speech_zhCN.sql', 209),
                            ('40_playerbots_speech_legacy_zhCN.sql', 209)]:
            sql = open(os.path.join(SQLDIR, f), encoding='utf-8').read()
            n = len(re.findall(r'^UPDATE `playerbots_speech`', acparse.strip_comments(sql), re.I | re.M))
            self.assertEqual(n, n_expect, f)


class TestNamePools(unittest.TestCase):
    """机器人名称池：唯一性、长度限制（varchar(12) 字节兼容）、性别分布。"""

    def test_names_unique_and_short(self):
        sql = open(os.path.join(SQLDIR, '50_playerbots_names_zhCN.sql'), encoding='utf-8').read()
        names, genders = set(), {}
        for cols, fields in acparse.iter_values_rows(sql, 'playerbots_names'):
            self.assertEqual(len(fields), 3)
            name = acparse.sql_unquote(fields[1])
            gender = int(fields[2])
            self.assertNotIn(name, names, '重名: %s' % name)
            names.add(name)
            # UTF-8 ≤ 12 字节（旧版 varchar(12)），且无三连字
            self.assertLessEqual(len(name.encode('utf-8')), 12, name)
            for i in range(2, len(name)):
                self.assertFalse(name[i] == name[i - 1] == name[i - 2], name)
            genders[gender] = genders.get(gender, 0) + 1
        self.assertEqual(len(names), 100000)
        self.assertEqual(genders.get(0), 10000)
        self.assertEqual(genders.get(1), 10000)
        for g in range(2, 18):
            self.assertEqual(genders.get(g), 5000, g)

    def test_guild_arena_counts(self):
        g = open(os.path.join(SQLDIR, '51_playerbots_guild_names_zhCN.sql'), encoding='utf-8').read()
        n = sum(1 for _ in acparse.iter_values_rows(g, 'playerbots_guild_names'))
        self.assertEqual(n, 400)
        a = open(os.path.join(SQLDIR, '52_playerbots_arena_team_names_zhCN.sql'), encoding='utf-8').read()
        types = {}
        for cols, fields in acparse.iter_values_rows(a, 'playerbots_arena_team_names'):
            types[fields[2]] = types.get(fields[2], 0) + 1
        self.assertEqual(types, {'2': 100, '3': 100, '5': 100})


class TestGeneratorSanity(unittest.TestCase):
    def test_gen_names_rejects_triple_and_overlong(self):
        rng = G.random.Random(42)
        names = G.gen_names(10, 300, rng=rng, used_global=set())
        self.assertTrue(names)
        for n in names:
            self.assertLessEqual(len(n.encode('utf-8')), 12)
            for i in range(2, len(n)):
                self.assertFalse(n[i] == n[i - 1] == n[i - 2])

    def test_taunt_placeholder_consistency(self):
        self.assertIn('<target>', G.TAUNTS[0])


if __name__ == '__main__':
    unittest.main()
