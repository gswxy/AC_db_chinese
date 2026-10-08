#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""tests.test_acparse —— 共享解析器单元测试。"""
import os
import sys
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(HERE), 'scripts'))
import acparse  # noqa: E402


class TestSqlUnquote(unittest.TestCase):
    def test_plain(self):
        self.assertEqual(acparse.sql_unquote("'你好'"), '你好')

    def test_escape(self):
        self.assertEqual(acparse.sql_unquote(r"'它\'s'"), "它's")
        self.assertEqual(acparse.sql_unquote(r"'a\\b'"), 'a\\b')
        self.assertEqual(acparse.sql_unquote("'行1\\n行2'"), '行1\n行2')

    def test_doubled_quote(self):
        self.assertEqual(acparse.sql_unquote("'它''s'"), "它''s")

    def test_non_string(self):
        self.assertIsNone(acparse.sql_unquote('123'))
        self.assertIsNone(acparse.sql_unquote('NULL'))


class TestSplitFields(unittest.TestCase):
    def test_basic(self):
        self.assertEqual(acparse.split_fields("1, 'zhCN', 'a,b'"), ['1', "'zhCN'", "'a,b'"])

    def test_nested_paren(self):
        self.assertEqual(acparse.split_fields("1, (2, 3), 'x'"), ['1', '(2, 3)', "'x'"])

    def test_escaped_comma(self):
        self.assertEqual(acparse.split_fields(r"'a\',b', 2"), [r"'a\',b'", '2'])


class TestIterValuesRows(unittest.TestCase):
    SQL = (
        "-- 头注释\n"
        "INSERT INTO `t` (`id`, `locale`, `txt`) VALUES\n"
        "  (1, 'zhCN', '含\\'引号'),\n"
        "  (2, 'deDE', '含;\\n分号'),\n"
        "  (3, 'zhCN', 'x')\n"
        "ON DUPLICATE KEY UPDATE `txt`=VALUES(`txt`);\n"
    )

    def test_rows_and_on_dup_skip(self):
        out = list(acparse.iter_values_rows(self.SQL, 't'))
        self.assertEqual(len(out), 3)  # ON DUPLICATE 的 VALUES(`txt`) 不计
        cols, r0 = out[0]
        self.assertEqual(cols, ['id', 'locale', 'txt'])
        self.assertEqual(r0[1], "'zhCN'")
        self.assertEqual(acparse.sql_unquote(r0[2]), "含'引号")

    def test_table_filter(self):
        sql = self.SQL + "INSERT INTO `other` VALUES (9);\n"
        out = list(acparse.iter_values_rows(sql, 'other'))
        self.assertEqual(len(out), 1)

    def test_locale_index_multi_pk(self):
        sql = ("INSERT INTO `g` (`MenuID`, `OptionID`, `Locale`, `OptionText`) VALUES\n"
               "  (1, 2, 'zhCN', '你好');\n")
        cols, fields = list(acparse.iter_values_rows(sql, 'g'))[0]
        li = [c.lower() for c in cols].index('locale')
        self.assertEqual(li, 2)
        self.assertEqual(fields[li], "'zhCN'")


class TestPlaceholder(unittest.TestCase):
    PH = __import__('re').compile(r'%(?:[A-Za-z_][A-Za-z0-9_]*)|<[^<>]+>')

    def test_ascii_only(self):
        self.assertEqual(sorted(self.PH.findall('有人想打%instance吗？')), ['%instance'])
        self.assertEqual(sorted(self.PH.findall('还有我的弓……哎呀，<ammo>没了！')), ['<ammo>'])
        self.assertEqual(sorted(self.PH.findall('%item_link吃起来啥味儿')), ['%item_link'])


if __name__ == '__main__':
    unittest.main()
