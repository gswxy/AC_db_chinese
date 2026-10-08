# 贡献指南

## 提交翻译修正

1. **核心 locale 表**（任务/物品/生物等）：直接改 `locales/world/10_locale_tables/XX_*.sql` 中对应行的中文。注意：
   - 只改中文文本，不要动 `ID`、`locale` 列与英文守卫；
   - 占位符（`$B`、`%s`、`{}` 等）必须原样保留；
   - 保持 UTF-8（无 BOM）与 LF 换行。
2. **acore_string**：改 `locales/world/20_acore_string/acore_string_zhCN.sql` 的 UPDATE 值；新增条目请同时确认官方基线里该 entry 存在。
3. **Playerbot**：
   - 新代际台词 → `10_ai_playerbot_texts_zhCN.sql`（SET `text_loc4` 值）；
   - 旧代际暗示文本 → `30_playerbots_text_zhCN.sql`；
   - 喊话（含 `<target>` 等占位符）→ 对应 `*_speech_*.sql`，改后请跑测试（占位符校验会拦截丢失）。
4. 提 PR 前在本地跑一遍：

```bash
python scripts/validate.py      # 静态验证必须全绿
python -m unittest discover -s tests -v
python scripts/coverage.py      # 重新生成覆盖率报告并一并提交
```

## 再生成数据（维护者）

本仓库的 SQL 由构建脚本从参考仓库的审计快照生成，保证可重复：

| 产物 | 来源与脚本 |
|---|---|
| `locales/world/` | 官方 base ∪ eryuwow base ∪ GSWXY_ACore ∪ 旧仓库回收，合并优先级官方 > eryuwow > GSWXY_ACore > 回收 |
| `locales/modules/playerbots/sql/10|20|40` | eryuhaian_playerbot 模块 SQL 更新链重放（含 loc4/loc5 互换修正） |
| `locales/modules/playerbots/sql/30` | 旧版 2022 基线：79 条新版翻译记忆 + 131 条人工翻译 |
| `locales/modules/playerbots/sql/50|51|52` | `scripts/gen_bot_names_zh.py`（种子 20260922，确定性） |
| `data/manifest.json` | 构建产物（sha256 + 行数），validate 会对账 |
| `reports/coverage.*` | `scripts/coverage.py` 依据 `data/reference_counts.json` 生成 |

新增上游内容时：更新对应来源仓库到新提交 → 重跑构建 → validate + tests 全绿 → 在 `docs/COMPATIBILITY.md` 更新已验证提交号。

## 汉化三条军规（历史经验，务必遵守）

1. **DBC 保持 enUS 原版**：Playerbot 的 AI（法术选择/BUFF 判定）依赖英文法术名做键，换中文 DBC 会大面积失效。
2. **玩家可见文本走标准本地化机制**：核心走 `_locale` 表与 `acore_string.locale_zhCN` 列（按客户端语言生效），不要写死在基础列污染 enUS 客户端。例外只有无 locale 机制的三张主表（本包已用英文守卫处理）。
3. **复用已有翻译，不要重翻**：合并冲突时官方 > 生产验证批次 > 历史批次。

## CI

GitHub Actions（`.github/workflows/ci.yml`）在每次 push/PR 时执行：`validate.py` 全量静态验证 + `unittest` 全部测试 + coverage 可复现性检查。任何一项失败即拒绝合并。

## 行为准则

- 不收录任何私服专属内容（自定义 NPC、活动、商城、运营文案）；
- 不收录低俗台词（参考旧版 speech 表的教训，汉化一律官译口吻）；
- 提交信息使用中文。
