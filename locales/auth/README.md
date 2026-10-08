# auth 库审计结论

对 AzerothCore `acore_auth` 库的审计结论：**没有需要汉化的玩家可见文本**，因此本包不为 auth 库提供任何 SQL。

## 审计明细

| auth 表 | 玩家可见文本 | 结论 |
|---|---|---|
| `account` | 无文本字段（`locale` 是语言编号列，不是文本） | 无 |
| `account_access` | 无 | 无 |
| `realm_list` | `name`（登录服列表显示的名字） | **服主私有配置**（每服唯一），不应由语言包统一覆盖 |
| `account_banned` / `ip_banned` | 无 | 无 |
| `autobroadcast`（部分版本在 auth） | `text` | 官方机制本身支持按语种列/广播表配置，属运营内容，属服主私有 |

## 相关提示

- 想让**账号**收到中文系统消息，把账号语言设为 zhCN：
  ```sql
  UPDATE acore_auth.account SET locale = 4 WHERE username = '你的账号';
  ```
  `locale=4` 即 zhCN（LocaleConstant 枚举序号）。
- Playerbot 机器人说中文同样依赖该字段（新版 mod-playerbots 按 `PlayerbotTextMgr::GetLocalePriority()` 对在线玩家语言投票选列），详见 `locales/modules/playerbots/README.md`。
- 登录期客户端国家码是**反序字节**（zhCN 发 `NChz`），这是协议行为，与汉化包无关。
