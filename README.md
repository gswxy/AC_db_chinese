# AC_db_chinese —— AzerothCore 简体中文语言包

[![CI](https://github.com/gswxy/AC_db_chinese/actions/workflows/ci.yml/badge.svg)](https://github.com/gswxy/AC_db_chinese/actions/workflows/ci.yml)

面向 **AzerothCore（WotLK 3.3.5）** 的完整简体中文（zhCN）数据库语言包，附带 **Playerbot（mod-playerbots）可选汉化扩展**。

两大模块彻底分离，按需安装：

| 模块 | 内容 | 目标库 | 适合谁 |
|---|---|---|---|
| **核心汉化**（默认安装） | 任务 / 物品 / 生物 / 物件 / NPC 文本 / 对话选项 / 成就邮件 / 世界广播 / 系统字符串等 18 个文件、**225,488 行 zhCN** | `acore_world` | 所有 AzerothCore 服主，**无需 Playerbot** |
| **Playerbot 可选汉化** | 机器人台词表 / 战斗喊话 / 世界频道暗示 / 机器人中文名池 10 万 / 公会名 / 竞技场队名，共 7 个文件、**103,078 行** | `acore_playerbots` + `acore_characters` | 使用 mod-playerbots 的服主，显式选择安装 |

核心覆盖率：**95.9%**（225,488 / 235,051，按官方基线实体数计）。明细见 [reports/coverage.md](reports/coverage.md)。

---

## 亮点

- **安全安装**：全部语句为「INSERT ... ON DUPLICATE KEY UPDATE」「带英文守卫的 UPDATE」或「有范围界定的池替换」，绝不 DROP / ALTER / 触碰非中文列；`install.py` 默认 dry-run、自动记账、自动备份。
- **幂等可重装**：按文件 SHA256 记账到 `ac_db_chinese_log`，重复安装自动跳过，升级版本自动重放。
- **零编译**：全部通过标准数据库机制生效（locale 表按客户端语言返回），不需要重新编译核心。
- **双代际 Playerbot 支持**：新版（`ai_playerbot_texts` 8 语种列）与旧版（2022 `playerbots_text`）各有独立 SQL。
- **自动验证**：`validate.py` + 单元测试 + GitHub Actions CI，覆盖编码、语句白名单、zhCN 唯一性、占位符保留、清单一致性。

## 快速开始

```bash
# 0) 依赖：Python 3.8+，pip install pymysql（或加 --mysql-cli 使用 mysql 客户端）

# 1) 预览核心汉化（默认 dry-run，不写库）
python scripts/install.py --host 127.0.0.1 --user root --password YOUR_PASS

# 2) 确认无误后安装核心汉化
python scripts/install.py --host 127.0.0.1 --user root --password YOUR_PASS --apply

# 3)（可选）安装 Playerbot 汉化扩展
python scripts/install.py --host 127.0.0.1 --user root --password YOUR_PASS --apply --playerbots
```

安装后**中文客户端**（zhCN 客户端或 `account.locale=4` 的账号）即可看到中文。详细参数、库名定制、回滚方法见 [docs/INSTALL.md](docs/INSTALL.md)。

## 目录结构

```text
AC_db_chinese/
├── README.md                        ← 本文件
├── locales/
│   ├── world/                       ← 核心汉化（acore_world）
│   │   ├── 10_locale_tables/        ← 14 张标准 *_locale 表（INSERT ON DUPLICATE，纯 zhCN）
│   │   ├── 20_acore_string/         ← acore_string locale_zhCN 列（守卫 UPDATE，仅填空）
│   │   └── 30_main_tables/          ← game_event / areatrigger_* 主表直译（英文守卫 UPDATE）
│   ├── auth/                        ← auth 库审计结论（无玩家可见文本，无需安装）
│   └── modules/
│       └── playerbots/              ← Playerbot 可选汉化（独立安装、独立统计）
│           ├── README.md            ← 模块说明（代际兼容矩阵、生效条件）
│           ├── sql/                 ← 7 个 SQL（台词/喊话/名字池）
│           └── resources/           ← 生成器字典（官译风格中文名词库）
├── scripts/
│   ├── install.py                   ← 安全安装器（dry-run / --apply / --playerbots / 记账）
│   ├── validate.py                  ← 仓库静态验证（CI 用）
│   ├── coverage.py                  ← 覆盖率报告生成
│   ├── gen_bot_names_zh.py          ← 中文人名/公会名/队名生成器（可独立使用）
│   ├── extract_playerbot_strings.py ← C++ 未翻译字符串提取器
│   └── acparse.py                   ← 共享 SQL 解析库
├── tests/                           ← 单元与集成测试（无数据库依赖）
├── data/
│   ├── manifest.json                ← 文件清单（sha256 / 行数 / 目标库 / 模块）
│   └── reference_counts.json        ← 官方基线实体数（覆盖率分母）
├── reports/
│   ├── coverage.md                  ← 覆盖率报告（自动生成）
│   ├── playerbot_audit.md           ← Playerbot 专项审计报告
│   └── playerbot_untranslated_strings*.csv ← C++ 硬编码英文残留清单
└── docs/
    ├── INSTALL.md / COMPATIBILITY.md / CONTRIBUTING.md
```

## 数据来源与合并优先级

所有参考仓库在本次重构时记录的实际提交：

| 仓库 | 分支 | 提交 | 用途 |
|---|---|---|---|
| [azerothcore/azerothcore-wotlk](https://github.com/azerothcore/azerothcore-wotlk) | master | `7b2cecef` | 结构基准 + zhCN 基线（官方） |
| [gswxy/gswxy-azerothcore](https://github.com/gswxy/gswxy-azerothcore) | master | `61ec8581` | 魔改分支交叉校验（base 与官方一致） |
| [gswxy/eryuwow](https://github.com/gswxy/eryuwow) | main | `badd3910` | 正式服在用的 21.8 万行 zhCN 主体数据 |
| [gswxy/GSWXY_ACore](https://github.com/gswxy/GSWXY_ACore) | main | `09b15992` | 历史补充（broadcast 等 2 行增量） |
| [gswxy/eryu_wow](https://github.com/gswxy/eryu_wow) | main | `89cf9dbb` | 历史校验（与主数据同源） |
| 旧版 AC_db_chinese | master | `3baf350b` | 主表直译 + acore_string.xlsx + creature_text.xlsx 回收 |
| [gswxy/mod-playerbots-AzerothCore](https://github.com/gswxy/mod-playerbots-AzerothCore) | main | `49e47431` | 旧代际 Playerbot（2022 快照）审计基线 |
| [gswxy/eryuwow-playerbots](https://github.com/gswxy/eryuwow-playerbots) | main | `c64fe0c4` | 全源码 Playerbots 基线审计 |
| [gswxy/eryuhaian_playerbot](https://github.com/gswxy/eryuhaian_playerbot) | main | `d5e9e395` | 新代际 Playerbot（上游 7bae1b5c5）+ 中文名语料 |

合并规则：**官方结构优先，通用翻译优先，私服定制隔离**。同一主键内容冲突时按「官方 > eryuwow > GSWXY_ACore > 旧仓库回收」取值（实际对比结果：14 张表 **零内容冲突**，差异全部是覆盖差，纯并集）。耳语魔兽专属内容（KOOK 桥、万灵低语、商城、转生等 Lua/SQL）一律未混入。

## 汉化生效原理（为什么不需要编译）

AzerothCore 核心会把 18 张 `*_locale` 表与 `acore_string` 的各语种内容一次性载入内存，再按**每个玩家客户端的语言**返回对应语种字符串（`ObjectMgr::GetLocaleString`）。因此：

- zhCN 客户端看到中文，enUS 客户端照常英文，互不影响；
- 唯一例外是 3 张无 locale 机制的主表（`game_event` 描述、`areatrigger_teleport` / `areatrigger_tavern` 名称），只能直译主表——本包用「英文原文守卫 UPDATE」将对其他语言客户端的影响降到最低，并在文件头明确标注。

## 与旧版仓库的关系

旧版（`3baf350b`，158MB）按中文表名目录存放 Navicat 全表转储（含 DROP TABLE、全语种、MySQL 8 专有 `utf8mb4_0900_ai_ci` 排序规则）和 Excel。新版完全重建：

- 只保留 zhCN 行，体积降至 ~28MB；
- 杜绝 DROP TABLE 与专有排序规则（MariaDB / MySQL 5.7 也能装）；
- acore_string / trinity_string / creature_text 三个 Excel 的有效内容全部回收（trinity_string 已从现代核心移除，仅按 content_default 对齐回收到 acore_string）；
- 旧中文目录与 Excel 已删除，历史数据以 Git 历史留存。

## 文档

- 安装详解（含回滚、多库改名、常见报错）：[docs/INSTALL.md](docs/INSTALL.md)
- 版本兼容矩阵（已验证 / 未验证）：[docs/COMPATIBILITY.md](docs/COMPATIBILITY.md)
- 贡献指南（如何补翻、如何再生成数据）：[docs/CONTRIBUTING.md](docs/CONTRIBUTING.md)
- Playerbot 专项审计：[reports/playerbot_audit.md](reports/playerbot_audit.md)

## 许可

见 [LICENSE](LICENSE)。数据部分源自 AzerothCore / TrinityCore 社区数据与其上汉化成果，工具脚本为原创。
