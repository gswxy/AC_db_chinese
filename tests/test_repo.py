#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""tests.test_repo —— 仓库级集成测试：validate / install dry-run / manifest 一致性。

全部无数据库依赖，CI 可直接跑。
"""
import json
import os
import subprocess
import sys
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.dirname(HERE)
PY = sys.executable


def run(args, **kw):
    return subprocess.run([PY] + args, capture_output=True, text=True, cwd=REPO,
                          encoding='utf-8', errors='replace', **kw)


class TestValidate(unittest.TestCase):
    def test_validate_passes(self):
        r = run([os.path.join('scripts', 'validate.py')])
        self.assertEqual(r.returncode, 0, 'validate 未通过:\n' + r.stdout[-3000:] + r.stderr[-500:])

    def test_manifest_files_exist(self):
        manifest = json.load(open(os.path.join(REPO, 'data', 'manifest.json'), encoding='utf-8'))
        for e in manifest:
            self.assertTrue(os.path.exists(os.path.join(REPO, e['file'])), e['file'])


class TestModuleSeparation(unittest.TestCase):
    """Playerbot 独立可选模块：与核心汉化彻底分离。"""

    def test_playerbots_files_isolated(self):
        manifest = json.load(open(os.path.join(REPO, 'data', 'manifest.json'), encoding='utf-8'))
        for e in manifest:
            if e['module'] == 'playerbots':
                self.assertIn('locales/modules/playerbots/', e['file'], e['file'])
                self.assertNotEqual(e['db'], 'acore_world', e['file'])
            else:
                self.assertNotIn('modules/playerbots', e['file'], e['file'])

    def test_core_pack_installs_without_playerbot(self):
        """默认（core 模块）dry-run 不得出现 playerbots 文件。"""
        r = run([os.path.join('scripts', 'install.py')])
        self.assertEqual(r.returncode, 0)
        self.assertNotIn('locales/modules/playerbots', r.stdout)
        self.assertNotIn('acore_characters', r.stdout)
        self.assertIn('acore_world', r.stdout)

    def test_playerbots_module_opt_in(self):
        r = run([os.path.join('scripts', 'install.py'), '--playerbots'])
        self.assertEqual(r.returncode, 0)
        self.assertIn('ai_playerbot_texts', r.stdout)
        self.assertIn('acore_characters', r.stdout)


class TestInstalDryRun(unittest.TestCase):
    def test_dry_run_no_write_hint(self):
        r = run([os.path.join('scripts', 'install.py')])
        self.assertIn('dry-run', r.stdout)
        self.assertIn('--apply', r.stdout)


class TestCoverage(unittest.TestCase):
    def test_coverage_regenerates_identically(self):
        before = open(os.path.join(REPO, 'reports', 'coverage.json'), encoding='utf-8').read()
        r = run([os.path.join('scripts', 'coverage.py')])
        self.assertEqual(r.returncode, 0)
        after = open(os.path.join(REPO, 'reports', 'coverage.json'), encoding='utf-8').read()
        self.assertEqual(before, after, 'coverage 输出不稳定（数据与参考计数不一致）')

    def test_core_pb_separate_totals(self):
        d = json.load(open(os.path.join(REPO, 'reports', 'coverage.json'), encoding='utf-8'))
        self.assertGreater(d['core_total_cov'], 200000)
        self.assertGreater(d['playerbots_total'], 100000)


class TestDocs(unittest.TestCase):
    def test_required_docs_exist(self):
        for f in ['README.md', 'LICENSE', 'docs/INSTALL.md', 'docs/COMPATIBILITY.md',
                  'docs/CONTRIBUTING.md', 'reports/coverage.md', 'reports/playerbot_audit.md',
                  'locales/auth/README.md', 'locales/modules/playerbots/README.md']:
            self.assertTrue(os.path.exists(os.path.join(REPO, f)), f)

    def test_no_legacy_dirs(self):
        """旧版目录（中文表名目录与 Excel）必须已清除。"""
        for name in os.listdir(REPO):
            self.assertFalse(name.endswith(('.xlsx', '.xls')), '残留 Excel: %s' % name)
        for legacy in ['NPC_text表', '任务表', '物品表', '生物表', '系统表', '信封表',
                       '套装表', '成就奖励表', '旅馆名称表', '游戏事件表', '物体表',
                       'NPC对话表', '生物喊话表', '副本传送点表']:
            self.assertFalse(os.path.exists(os.path.join(REPO, legacy)), legacy)
        self.assertFalse(os.path.exists(os.path.join(REPO, '.vs')), '.vs 残留')


if __name__ == '__main__':
    unittest.main()
