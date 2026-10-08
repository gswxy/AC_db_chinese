# 版本兼容性

## 核心汉化（locales/world）

| 目标 | 兼容性 | 说明 |
|---|---|---|
| azerothcore-wotlk `master`（`7b2cecef`，2026-10） | **已验证**（结构级） | 全部列名/主键按官方 base 逐表核对；18 张 locale 表均有核心加载代码（`ObjectMgr` 各 LoadXxxLocales） |
| gswxy-azerothcore `master`（`61ec8581`） | **已验证**（结构级 + 生产在用） | 数据主体即该分支/其上游 2024-12-17 汉化批次与 eryuwow 生产库 |
| eryuwow 正式服（`badd3910`） | **已验证**（数据同源） | 覆盖其 base 全部 zhCN |
| 官方 2023+ 稳定分支 | 预期兼容 | locale 表结构自 2019 年后稳定；新增条目靠 ON DUPLICATE 幂等 |
| MySQL 5.7 / 8.x / MariaDB 10.x | 兼容 | 全部语句为标准 SQL；无 MySQL 8 专有排序规则（旧版的 `utf8mb4_0900_ai_ci` 已清除） |

**未验证项（诚实清单）**：
- 未在实际运行的 MySQL 5.7 / MariaDB 上执行过完整安装（仅在语句层排除了不兼容语法）；
- 对 2019 年以前的老基线（缺 `quest_greeting_locale` 等新表）未做自动降级，`install.py` 预检会缺表报错并指明文件，可按报错跳过对应文件；
- `game_event` / `areatrigger_*` 主表直译带有英文守卫，官方若改动英文原文会自动跳过（安全但漏翻），需要后续对照新基线再生成。

## Playerbot 可选汉化（locales/modules/playerbots）

| Playerbot 代际 | 判定特征 | 兼容文件 | 状态 |
|---|---|---|---|
| **新版**（liyunfan/mod-playerbots `7bae1b5c5` 一线） | 有 `ai_playerbot_texts` 表（`text_loc1..text_loc8` 8 语种列） | `10_ai_playerbot_texts_zhCN.sql`、`20_playerbots_speech_zhCN.sql`、名称池三件套 | **已验证**（eryuhaian_playerbot `d5e9e395`，即上游 `7bae1b5c5` 的 subtree） |
| **旧版**（2022 快照） | 有 `playerbots_text` 表（`key`,`text` 两列，无语言列） | `30_playerbots_text_zhCN.sql`、`40_playerbots_speech_legacy_zhCN.sql`、名称池三件套 | **已验证**（mod-playerbots-AzerothCore `49e47431` 结构级） |
| eryuwow-playerbots 全源码版（`c64fe0c4`） | 核心侧钩子引用 `ai_playerbot_texts` | 新版文件 | 结构级验证（其模块本体为外挂目录，未在本轮审计范围内取得提交） |

判定方法：装包前在数据库里执行
```sql
SHOW TABLES FROM acore_playerbots LIKE '%texts%';
-- ai_playerbot_texts  -> 新版
-- playerbots_text     -> 旧版
```
两个都有就都装（语句互不冲突）。

**未验证项**：
- 新版 SQL 的守卫基于「`name` + 英文原文」精确匹配。若你的模块基线数据被自定义改动过英文原文，对应行会静默跳过（安全但漏翻），行数对不上时先对照模块基线；
- `playerbots_names` 基线为 100,000 行（上游新版规模）。旧版基线只有 10,679 行，装名称池后会扩展到 10 万行中文池（功能正常，池更大）；
- 旧代际 C++ 硬编码反馈文本（约 212 条直译通道字面量）**不在 SQL 可汉化范围内**，见 [reports/playerbot_audit.md](../reports/playerbot_audit.md)。

## 汉化数据版本

- zhCN 主体：2024-12-17 批次（gswxy-azerothcore 归档）∪ 官方 `7b2cecef` base ∪ GSWXY_ACore 零星补充，共 225,488 行；
- Playerbot 台词 zhCN：上游新版自带 1,755 行（含修正）+ 本包人工翻译 210 条（旧代际）；
- 名字池：官译风格生成器 `20260922` 种子，10 万名全中文、全局唯一。

## 需要重编译吗？

**不需要。** 两个模块的全部可 SQL 生效内容均通过数据库本地化机制工作。唯一需要动源码的场景：旧代际模块的 C++ 硬编码反馈文本（本包只提供清单与适配设计，不发布自动补丁）——见审计报告第 6 节。
