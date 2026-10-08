# 安装指南

## 前置条件

- Python 3.8+（安装与验证工具）
- 数据库连接方式二选一：
  - `pip install pymysql`（推荐，纯 Python）
  - 或系统装有 `mysql` 命令行客户端并加 `--mysql-cli`
- 已由 AzerothCore 正常完成 base DB 安装（locale 表、acore_string 等基表必须存在）
- 安装 Playerbot 汉化时：mod-playerbots 模块已完成安装（其 `playerbots` 库与 names 表已建）

## 连接参数

| 参数 | 默认值 | 说明 |
|---|---|---|
| `--host` / `--port` | 127.0.0.1 / 3306 | 数据库地址 |
| `--user` / `--password` | root / 空 | 账号 |
| `--world` | acore_world | world 库名（与 worldserver.conf 的 WorldDatabaseInfo 一致） |
| `--characters` | acore_characters | characters 库名 |
| `--playerbots-db` | acore_playerbots | playerbots 模块库名 |
| `--auth` | acore_auth | auth 库名（仅预检用，本包不写 auth） |

## 标准流程

```bash
# 1) dry-run：解析全部 SQL、打印计划（默认模块 = core）
python scripts/install.py --host 127.0.0.1 --user root --password PASS

# 2) 应用核心汉化
python scripts/install.py --host 127.0.0.1 --user root --password PASS --apply

# 3) 应用核心 + Playerbot 汉化
python scripts/install.py --host 127.0.0.1 --user root --password PASS --apply --playerbots
```

不用 Python 依赖时：

```bash
python scripts/install.py --apply --mysql-cli ...
# 或者手工导入（注意按文件名序号顺序）：
mysql --default-character-set=utf8mb4 acore_world < locales/world/10_locale_tables/01_achievement_reward_locale.sql
# ... 依次导入全部文件（手工导入不会记账，也不会自动备份名称池）
```

## install.py 的安全机制

1. **默认 dry-run**：不连接数据库也运行，仅展示计划。
2. **记账幂等**：首次 `--apply` 会在 world 库创建 `ac_db_chinese_log` 表，按 (文件, SHA256) 记录；重复执行同版本自动跳过。强制重装加 `--force`。
3. **自动备份**：`kind=pool` 的文件（机器人名字池等 TRUNCATE/DELETE 类）执行前自动建 `<表>_zhbak` 备份表（仅首次，不覆盖旧备份）。
4. **事务**：非 TRUNCATE 语句逐文件事务包裹，失败自动回滚。
5. **预检**：执行前确认目标库与全部目标表存在，缺表即中止并逐条列出。
6. **白名单**：包内文件只含 INSERT / UPDATE / DELETE / SET / START TRANSACTION / COMMIT / TRUNCATE(pool)，无 DROP/ALTER/CREATE（`validate.py` 在 CI 中把关）。

## 安装后验证

```sql
-- 核心：随机抽任务名
SELECT Title FROM acore_world.quest_template_locale WHERE ID=1 AND locale='zhCN';
-- 期望非空中文

-- 核心：系统字符串
SELECT locale_zhCN FROM acore_world.acore_string WHERE entry=3;
-- 期望 '[服务器] {}'

-- Playerbot（装了扩展时）
SELECT COUNT(*) FROM acore_playerbots.ai_playerbot_texts WHERE text_loc4 <> '';
SELECT COUNT(*) FROM acore_characters.playerbots_names WHERE name REGEXP '[^ -~]';  -- 100000

-- 记账
SELECT file, applied_at FROM acore_world.ac_db_chinese_log;
```

进游戏用 zhCN 客户端登录（或在 auth 库 `UPDATE account SET locale=4 WHERE username='...'`，生效需重新登录）。

## 回滚

- locale 表 / acore_string / 主表直译：重装同文件不会删除任何行；若需彻底还原，直接重装 AzerothCore base 的对应表，或用你自己的备份。
- Playerbot 名称池：
  ```sql
  -- 恢复安装前的英文基线（install.py 已自动备份）
  USE acore_characters;
  RENAME TABLE playerbots_names TO playerbots_names_zh, playerbots_names_zhbak TO playerbots_names;
  -- playerbots_guild_names / playerbots_arena_team_names 同理
  ```
- Playerbot 台词：重跑模块自带的基线 SQL（UPDATE 守卫无法回滚旧值，建议用 zhbak 思路自行备份 `ai_playerbot_texts.text_loc4` 列所在表）。

## 已创建机器人的改名（Playerbot）

名字池替换只影响**之后新创建**的机器人。要给存量机器人改名：

1. 停服：`pkill -TERM -f worldserver`（在线机器人定时保存会覆盖直接改库的名字，必须停服改）；
2. 参照 `UPDATE characters c JOIN playerbots_names n ON ...` 的思路批量改 `characters.name`（保证全局唯一、UTF-8 ≤12 字节、无三连字）；
3. 起服。

## 常见问题

| 现象 | 原因 | 处理 |
|---|---|---|
| `表不存在: acore_world.xxx_locale` | 基线过老，缺新 locale 表 | 升级基线（db_assembler）或跳过对应文件 |
| 导入报 utf8mb4_0900 错误 | 旧版仓库遗留文件 | 本版已杜绝该排序规则，确认没用旧文件 |
| 机器人说英文 | `acore_auth.account.locale` 不是 4 | `UPDATE account SET locale=4` 后重新登录 |
| 机器人名字还是英文 | 只装了台词没装名字池 | `--playerbots` 完整安装（names 在 characters 库） |
| PlayerbotsDatabaseInfo 报错 | playerbots.conf 位置不对 | 必须在 `etc/modules/playerbots.conf` |
