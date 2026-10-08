# -*- coding: utf-8 -*-
"""resources/bot_zh_dict.py —— 中文名语料的用户自定义覆盖层（可选）。

scripts/gen_bot_names_zh.py 启动时会尝试加载本文件：
若定义了对应变量（RACE_HEAD / MALE_SYL / FEMALE_SYL / MALE_TAIL / FEMALE_TAIL /
GUILD_ADJ / GUILD_NOUN / ARENA_ADJ / ARENA_NOUN / TAUNTS / YELLS），
则**整表替换**内置词库，便于服主定制本地化风格（如台湾译名、私有词库）。

规则提醒：
- 生成的名字最终须满足：UTF-8 ≤ 12 字节（≤4 个汉字，兼容旧版 varchar(12)）、无三连字；
- 修改后运行 `python scripts/gen_bot_names_zh.py --out custom.sql` 生成 SQL 再导入。
"""

# 示例（默认注释状态；取消注释即生效）：
# RACE_HEAD = {
#     'generic': ['洛', '米奈', '普罗', '乌瑞', '斯托', '雷马', '杜克', '格雷', '莫格', '阿比',
#                 '莱恩', '图拉', '提里', '瓦里', '安度', '麦迪', '艾格', '塞拉', '瑞文', '霍格',
#                 '达尔', '奥蕾', '凡妮', '库德', '埃兰', '洛丹', '瑟兰', '法尔', '艾登', '维恩'],
# }
