# AC_db_chinese 覆盖率报告

> 生成于 2026-10-08（scripts/coverage.py 自动生成，勿手改）

## 一、AzerothCore 核心汉化（acore_world）

| 表 | 类型 | 可汉化基数 | 已覆盖 zhCN | 覆盖率 | 说明 |
|---|---|---:|---:|---:|---|
| achievement_reward_locale | locale 表 | 115 | 36 | 31.3% |  |
| broadcast_text_locale | locale 表 | 73039 | 72943 | 99.9% |  |
| creature_template_locale | locale 表 | 29947 | 27288 | 91.1% |  |
| creature_text_locale | locale 表 | 18591 | 14350 | 77.2% |  |
| gameobject_template_locale | locale 表 | 21581 | 20035 | 92.8% |  |
| gossip_menu_option_locale | locale 表 | 4677 | 4557 | 97.4% |  |
| item_set_names_locale | locale 表 | 2481 | 2481 | 100.0% |  |
| item_template_locale | locale 表 | 46096 | 43066 | 93.4% |  |
| npc_text_locale | locale 表 | 8361 | 8231 | 98.4% |  |
| page_text_locale | locale 表 | 1951 | 1946 | 99.7% |  |
| points_of_interest_locale | locale 表 | 463 | 453 | 97.8% |  |
| quest_offer_reward_locale | locale 表 | 8660 | 9461 | 109.2% | 含官方基线已移除的历史任务条目（多余行被核心忽略，无害） |
| quest_request_items_locale | locale 表 | 7757 | 9427 | 121.5% | 同上：含官方已移除的历史任务条目，无害 |
| quest_template_locale | locale 表 | 9464 | 9459 | 99.9% |  |
| acore_string | 系统字符串列 | 1298 | 1298 | 100.0% | locale_zhCN 列 |
| game_event | 主表直译 | 181 | 71 | 39.2% | 主表直译（无 locale 机制，enUS 客户端同样可见） |
| areatrigger_teleport | 主表直译 | 276 | 273 | 98.9% | 主表直译（无 locale 机制，enUS 客户端同样可见） |
| areatrigger_tavern | 主表直译 | 113 | 113 | 100.0% | 主表直译（无 locale 机制，enUS 客户端同样可见） |
| **合计** | | **235051** | **225488** | **95.9%** | |

## 二、Playerbot 可选汉化（独立统计，不计入核心）

| 表 | 目标库 | 基线行数 | 已汉化 | 说明 |
|---|---|---:|---:|---|
| ai_playerbot_texts | acore_playerbots | 1770 | 1750 | 新版基线重放行数；text_loc4=zhCN |
| playerbots_speech | acore_playerbots | 209 | 209 | 新版/旧版基线相同 |
| playerbots_text | acore_playerbots | 210 | 210 | 仅旧代际（2022 快照） |
| playerbots_speech | acore_playerbots | 209 | 209 | 新版/旧版基线相同 |
| playerbots_names | acore_characters | 100000 | 100000 | 新版基线 10 万行名池 |
| playerbots_guild_names | acore_characters | 400 | 400 |  |
| playerbots_arena_team_names | acore_characters | 300 | 300 | 2v2/3v3/5v5 各 100 |
| **合计** | | | **103078** | C++ 硬编码约 250–400 条未汉化，见 playerbot_audit.md |

## 三、官方基线中无 zhCN 数据、本包未覆盖的表

- `quest_greeting_locale`：官方基线与全部来源均无 zhCN 数据（NPC 任务问候语）
- `quest_offer_reward_locale 与 quest_request_items_locale 差额`：部分任务条目在基线中无对应文本行，随上游补齐
- `trainer_locale`：无 zhCN 数据（训练师问候语）
- `module_string_locale`：无 zhCN 数据（模块字符串接口，预留给模块作者）
- `pet_name_generation_locale`：无 zhCN 数据（宠物名生成）
- `command 帮助文本`：command 表无多语列，官方不提供汉化机制，不在本包范围
