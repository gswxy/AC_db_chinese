# Playerbot 可选汉化模块

本目录是 **mod-playerbots（AzerothCore 机器人模块）的独立可选简体中文语言包**，与核心汉化（`locales/world/`）完全分离：

- 普通服主不装本模块，核心汉化一切正常；
- 使用 Playerbot 的服主 `install.py --playerbots` 一并安装；
- 统计口径独立（见 `reports/coverage.md` 第二节），不混入核心覆盖率。

## 按代际选择文件

先判定你的模块代际：

```sql
SHOW TABLES FROM acore_playerbots LIKE '%texts%';
-- 有 ai_playerbot_texts（8 语种列） -> 新版
-- 有 playerbots_text（key/text 两列） -> 旧版
```

| 文件 | 目标库 | 新版 | 旧版 | 内容 |
|---|---|:---:|:---:|---|
| `sql/10_ai_playerbot_texts_zhCN.sql` | playerbots | ✅ | — | 机器人台词 1,755 行（`text_loc4` zhCN 列，守卫 UPDATE） |
| `sql/20_playerbots_speech_zhCN.sql` | playerbots | ✅ | — | 战斗喊话/拾取/AOE 台词 209 行（守卫 UPDATE） |
| `sql/30_playerbots_text_zhCN.sql` | playerbots | — | ✅ | 世界频道暗示台词 210 行，100% 覆盖（守卫 UPDATE） |
| `sql/40_playerbots_speech_legacy_zhCN.sql` | playerbots | — | ✅ | 旧版喊话 209 行（原表含粗俗台词，本包统一替换为官译口吻干净台词） |
| `sql/50_playerbots_names_zhCN.sql` | **characters** | ✅ | ✅ | 机器人名池 100,000 全中文（按种族气质分桶、全局唯一、UTF-8 ≤12 字节兼容旧 varchar(12)） |
| `sql/51_playerbots_guild_names_zhCN.sql` | characters | ✅ | ✅ | 公会名池 400 |
| `sql/52_playerbots_arena_team_names_zhCN.sql` | characters | ✅ | ✅ | 竞技场队名池 300（2v2/3v3/5v5 各 100） |

安装：`python scripts/install.py --apply --playerbots`（自动备份名称池为 `<表>_zhbak`）。

## 让机器人说中文的三个条件

1. 安装上表 SQL（`ai_playerbot_texts.text_loc4` 有值 / speech、text 表替换为中文）；
2. **登录账号的语言必须是 zhCN**：`UPDATE acore_auth.account SET locale=4 WHERE username='...'` 后重新登录——新版 mod-playerbots 的 `PlayerbotTextMgr::GetLocalePriority()` 按**在线真实玩家的语言投票**决定机器人说哪一列；
3. 客户端 DBC 保持 enUS **不要动**：机器人 AI 依赖英文法术名做键，换中文 DBC 会让 AI 大面积失效（耳语海岸实测教训）。

## 哪些内容本包管不了（诚实清单）

- **C++ 硬编码反馈**：模块源码中约 200 条直接发给玩家的英文字面量（命令成功/失败/拒绝反馈、状态报告、组队交互等），SQL 无法覆盖。两代际的完整清单与分类见：
  - `reports/playerbot_untranslated_strings.csv`（旧代际 2022 快照，212 条）
  - `reports/playerbot_untranslated_strings_newgen.csv`（新代际上游 7bae1b5c5，194 条）
  - 适配方案（走 PlayerbotTextMgr 查表的改造设计、工作量与风险）见 `reports/playerbot_audit.md` 第 6 节。
- **模块配置注释**（`playerbots.conf.dist` 约 150 条说明）为服主向英文文档，不影响玩家体验，未汉化。
- **机器人已有的角色名**：名字池替换只影响新建机器人；存量机器人改名需停服批量改 `characters.name`（见 `docs/INSTALL.md`）。

## 生成器

`scripts/gen_bot_names_zh.py` 可独立运行，自定义名字/公会/队名数量与随机种子：

```bash
python scripts/gen_bot_names_zh.py --names 100000 --guilds 400 --arenas 300 --seed 20260922 --out my_names.sql
```

语料字典（`resources/bot_zh_dict.py` 与脚本内嵌）移植自耳语海岸生产环境验证过的官译风格词库。
