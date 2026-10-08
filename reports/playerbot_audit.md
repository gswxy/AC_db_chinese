# Playerbot 汉化专项审计报告

> 审计日期：2026-10-08。全部结论基于对下述仓库在对应提交的**实际源码审计**（源码追踪 + 数据统计），
> 未凭仓库名称推测代码基线。私有仓库均可读取，无权限缺失项。

## 一、仓库来源与实际提交

| 仓库 | 分支 | 提交 SHA | 血统判定（源码证据） |
|---|---|---|---|
| [gswxy/mod-playerbots-AzerothCore](https://github.com/gswxy/mod-playerbots-AzerothCore) | main | `49e47431bd83d6835bab92f6efe527985bdc101e` | **旧代际**：liyunfan/mod-playerbots 的 2022-03 快照（唯一提交作者 htc16，旧式 ChatCommand API，模块 SQL 为 `playerbots_text`（id,key,text）无语言列） |
| [gswxy/eryuwow-playerbots](https://github.com/gswxy/eryuwow-playerbots) | main | `c64fe0c48c18bce7d62565c57ce63b1d3afea5e5` | **全源码集成基线**：AzerothCore 核心 + playerbot 以核心侧钩子形式合入 `src/server/`（PlayerbotsDatabase 预处理语句读 `ai_playerbot_texts` 的 text_loc1..loc8），模块本体为构建期外挂目录，**不在仓库内** |
| [gswxy/eryuhaian_playerbot](https://github.com/gswxy/eryuhaian_playerbot) | main | `d5e9e395b153c735f00056d1e57a3bb05d3ee730` | **新代际**：模块在 `src/modules/mod-playerbots/`，其 `docs/上游版本.md` 自锁上游 `mod-playerbots@master 7bae1b5c5` + `azerothcore-wotlk@Playerbot 7f12e89ee`（git subtree squash 导入） |
| 上游参照 | — | — | 本包同时核对了官方 AzerothCore `7b2cecef` 的核心加载机制（Playerbot 相关 DBC/区域名走核心 locale，不随模块） |

## 二、汉化入口定位（源码追踪结论）

| 入口 | 存在形式 | 可否 SQL 汉化 |
|---|---|---|
| 机器人台词（新版） | `acore_playerbots.ai_playerbot_texts`，`text_loc1..loc8` 8 语种列，`PlayerbotTextMgr` 按 key 取列（Mgr/Text/PlayerbotTextMgr.cpp） | ✅ 直接 SQL |
| 机器人喊话 | `acore_playerbots.playerbots_speech`（id,name,text,type），`SayAction.cpp` 读取 | ✅ 直接 SQL（无语言列，内容级替换） |
| 世界频道暗示（旧版） | `acore_playerbots.playerbots_text`（id,key,text），`SuggestWhatToDoAction` 读取 | ✅ 直接 SQL（同上） |
| 机器人/公会/竞技场名池 | `acore_characters.playerbots_names`（10 万行）、`playerbots_guild_names`（400）、`playerbots_arena_team_names`（300），`RandomPlayerbotFactory` 读取 | ✅ SQL（池替换） |
| 命令帮助/反馈/状态/错误 | **C++ 硬编码**：TellMaster/TellMasterNoFacing/TellError/Say/Yell/Whisper/PSendSysMessage 字面量 | ❌ 需源码适配（见第六节） |
| 配置说明 | `playerbots.conf.dist` 约 150 条服主向英文注释 | ❌ 非玩家文本，未处理 |
| 模块内置字符串资源 / gettext | **不存在**（全仓扫描无任何语言接口） | — |

## 三、已有中文（确认可复用）

| 内容 | 位置 | 规模 | 质量 |
|---|---|---|---|
| 新版机器人台词 zhCN | 上游自带，存于 `ai_playerbot_texts.text_loc4`（eryuhaian 基表 1,739 行 + 14 个 updates，重放后 1,790 行中 1,770 行有中文） | 1,755 行入包 | 官译风格、占位符完整；发现并修正 loc4/loc5 互换 1 行；另记录线上库（1,908 行/1,896 中文）比仓库链新 118 行，差异为上游后续批次，不在本轮仓库内 |
| 中文名生成语料 | `eryuhaian_playerbot/tools/gen_pbots_zh.py`：9 族氏字头 × 音译音节 × 收尾字、公会/队名词库 400/300、官译口吻台词池 102+13（语气前缀可扩展约 800 条） | 全量移植 | 生产验证过（2,000 机器人在线），规避三连字校验 |
| 汉化机制经验 | `eryuhaian_playerbot/docs/汉化与运维说明.md`（locale=4 投票、DBC enUS 原则、停服改名、auth country 反序字节） | 已整理进本包 README/docs | — |
| eryuwow-playerbots 核心侧中文 | 仅 2 条玩家可见字符串（命运转生文案），**私服定制** | 未搬运 | 绑定耳语玩法 |

## 四、英文残留（按功能分类）

静态扫描通道：TellMaster(95)/TellMasterNoFacing(32)/TellError(59)/Say(15)/Yell(1)/Whisper(5)/PSendSysMessage(9) 等带字面量调用。

**旧代际（2022 快照）：212 条直译通道字面量**（`reports/playerbot_untranslated_strings.csv`）：

| 功能分类 | 条数 |
|---|---:|
| 动作反馈（strategy/actions/ 下各类动作回报） | 117 |
| 交易/邮件/物品 | 25 |
| 组队/公会交互 | 24 |
| 命令反馈/系统 | 17 |
| 机器人台词 | 12 |
| 任务交互 | 9 |
| 错误与调试 | 5 |
| 状态查询 / 其他 | 3 |

**新代际（上游 7bae1b5c5）：194 条**（`reports/playerbot_untranslated_strings_newgen.csv`），分布类似。
两份清单为**逐条 file:line + 字面量**的可认领格式。

## 五、新增汉化（本轮实际完成）

| 内容 | 规模 | 来源 |
|---|---|---|
| `10_ai_playerbot_texts_zhCN.sql`（新版台词 → text_loc4） | 1,755 行守卫 UPDATE | 上游 zhCN 重放 + 质量修正 |
| `20_playerbots_speech_zhCN.sql`（新版喊话） | 209 行 | 官译台词池（占位符对齐）+ 27 条含占位符台词人工翻译 |
| `30_playerbots_text_zhCN.sql`（旧版暗示台词） | 210 行，**100% 覆盖** | 79 条新版翻译记忆复用 + 131 条人工新译 |
| `40_playerbots_speech_legacy_zhCN.sql`（旧版喊话） | 209 行 | 同 20 号文件机制；原表粗俗台词按官译口吻干净化 |
| `50/51/52_*.sql`（名字/公会/队名池） | 100,000 / 400 / 300 | gen_pbots_zh 语料移植再生成（种子 20260922） |
| 机制文档 / 未翻译清单 / 提取工具 | — | 见 reports 与 scripts |

## 六、C++ 硬编码的适配设计（不在本轮实施）

**结论先行：这批文本无法靠导入 SQL 生效，必须修改模块源码。** 本轮不做大规模改造（避免擅自重构机器人命令解析/AI），只提供设计与清单。

推荐适配路线（改动最小、可审查）：
1. 以现成的 `PlayerbotTextMgr`（key→模板查表，已支持多行随机与占位符）为通道：
   - 新增 `ai_playerbot_texts` 的 key 约定（如 `reply_following`、`reply_stay`、`err_no_ammo`…），把 212/194 条字面量逐条替换为 `sPlayerbotTextMgr->Format("key")`；
   - 本包提供中文文案时只需往该表 INSERT 对应 key 行（SQL 即生效，无需改表结构——表结构无需任何变更）；
   - 英文正文作为 `text` 列默认值，其它语言进 loc 列，与现有机制零冲突。
2. 工作量评估：两代际约 200 条 ×（改调用 + 加表行 + 回归）≈ 中等规模 PR，涉及 80+ 文件，**必须由 mod-playerbots 仓库自身或其 fork 实施**；
3. 本包承诺：不向任何其他仓库推送代码。后续若实施，将按 CONTRIBUTING 流程单独提交 PR 供审查。

## 七、兼容性

| 组合 | 状态 |
|---|---|
| 新代际 SQL × eryuhaian_playerbot `d5e9e395`（上游 `7bae1b5c5`） | **已验证**（基表+更新链重放） |
| 旧代际 SQL × mod-playerbots-AzerothCore `49e47431` | **已验证**（结构级 + 基线行数对账） |
| 新版名称池 × 旧版 names 表 varchar(12) | 已兼容（全部名字 ≤4 汉字 = ≤12 字节，单元测试把关） |
| eryuwow-playerbots `c64fe0c4` | 结构级验证（模块本体不在仓库，见第一节） |
| 未验证 | 实机 MySQL 端到端安装；上游 `7bae1b5c5` 之后的上游新增文本（守卫式 UPDATE 会自动跳过未匹配行，安全但漏翻，需跟版本再生成） |

## 八、限制声明

1. 守卫式 UPDATE 的覆盖依赖模块基线英文原文一致；自定义过基线的服主会有静默跳过行（无副作用）；
2. 名字池替换仅影响新建机器人；存量改名必须停服操作（在线机器人定时保存会回写）；
3. `playerbots.conf.dist` 的英文注释不在汉化范围（服主向配置文档）；
4. 新版台词的 zhCN 覆盖率约 97.9%（1,755/1,792），缺口为上游未译的 `suggest_toxic_links` 等 key，自动回落英文。
