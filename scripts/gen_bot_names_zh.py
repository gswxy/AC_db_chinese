#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""gen_bot_names_zh.py —— 生成「魔兽官方译名风格」的中文机器人名字 / 公会名 / 竞技场队名 / 喊话池。

移植自耳语海岸 eryuhaian_playerbot/tools/gen_pbots_zh.py（2026-09-22 版语料），
通用化：去除部署路径依赖，输出与上游 mod-playerbots 基表结构完全对应的 SQL。

命名思路（对齐 zhCN 官方译名习惯）：
   名字 = 种族氏族前缀(1~2 字) + 音译名(1~2 字)
   音译字取自魔兽官译常用字（萨/尔/斯/玛/法/里/奥/洛/丹/吉/安/娜/希/瓦 ...），
   前缀按种族气质区分（矮人: 铜/铁/锤/炉；暗夜: 月/影/星/风；兽人: 血/战/霜/碎 ...）。
   女名收尾偏 娜/莉/丝/薇/露/莎/黛/珊，男名收尾偏 斯/尔/德/洛/恩/托/姆/克。

生成必须规避服务端 CHAR_NAME_THREE_CONSECUTIVE（三连字）校验与长度上限。
"""
import argparse
import os
import random

DEFAULT_SEED = 20260922

# ---------------- 用户自定义语料覆盖层（locales/modules/playerbots/resources/bot_zh_dict.py） ----------------
_OVERLAY_PATHS = [
    os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                 'locales', 'modules', 'playerbots', 'resources', 'bot_zh_dict.py'),
]


def _load_overlay():
    """若用户覆盖文件定义了对应词库变量，则整表替换内置值。"""
    import importlib.util
    for p in _OVERLAY_PATHS:
        if not os.path.exists(p):
            continue
        spec = importlib.util.spec_from_file_location('bot_zh_dict', p)
        mod = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(mod)
        g = globals()
        for name in ('RACE_HEAD', 'MALE_SYL', 'FEMALE_SYL', 'MALE_TAIL', 'FEMALE_TAIL',
                     'GUILD_ADJ', 'GUILD_NOUN', 'ARENA_ADJ', 'ARENA_NOUN', 'TAUNTS', 'YELLS'):
            if hasattr(mod, name):
                g[name] = getattr(mod, name)


_load_overlay()

# ---------------- 种族氏族前缀（按 NameRaceAndGender 顺序） ----------------
RACE_HEAD = {
    # 人类 / 亡灵 / 通用
    'generic':  ['洛', '米奈', '普罗', '乌瑞', '斯托', '雷马', '杜克', '格雷', '莫格', '阿比',
                 '莱恩', '图拉', '提里', '瓦里', '安度', '麦迪', '艾格', '塞拉', '瑞文', '霍格',
                 '达尔', '奥蕾', '凡妮', '库德', '埃兰', '洛丹', '瑟兰', '法尔', '艾登', '维恩'],
    # 侏儒
    'gnome':    ['吉兹', '图克', '斯佩', '米洛', '比克', '兹尔', '温克', '里克', '波普', '蒂克',
                 '诺姆', '泽塔', '库克', '菲兹', '洛克', '邦克', '韦兹', '希姆', '达克', '莫兹',
                 '夏克', '威兹', '塔克', '尼克'],
    # 矮人
    'dwarf':    ['巴尔', '杜林', '格瑞', '索林', '托林', '弗力', '莫林', '达因', '洛肯', '库德',
                 '布拉', '弗斯', '穆拉', '斯坦', '罗德', '格里', '铁兰', '山铎', '熔恩', '岩德',
                 '铜须', '雷酒', '索瑞', '巴林'],
    # 暗夜精灵
    'nightelf': ['泰兰', '玛法', '伊利', '塞纳', '奥蕾', '艾露', '希洛', '黛莉', '鲁纳', '艾索',
                 '兰达', '温蕾', '露娜', '瑟兰', '卡多', '奥恩', '弥拉', '希尔', '洛玛', '梵妮',
                 '月歌', '星风', '影歌', '怒风'],
    # 德莱尼
    'draenei':  ['维伦', '阿卡', '玛尔', '纳鲁', '泽拉', '伊瑞', '奥纳', '瑞文', '塔尔', '塞莉',
                 '米拉', '乌鲁', '卡兰', '艾瑞', '诺拉', '洛玛', '迪兰', '萨恩', '菲雅', '玛维',
                 '先知', '守誓', '努波', '哈达'],
    # 兽人
    'orc':      ['格罗', '萨尔', '杜隆', '奥格', '基尔', '布洛', '扎尔', '卡加', '雷德', '索尔',
                 '玛格', '霍尔', '德拉', '洛克', '加尔', '塔隆', '格鲁', '巴洛', '祖尔', '克洛',
                 '血拳', '碎手', '霜狼', '黑掌'],
    # 巨魔
    'troll':    ['森金', '沃金', '扎拉', '祖尔', '加兹', '洛坎', '玛兹', '布罗', '卡兹', '雷兹',
                 '希克', '祖玛', '塔兹', '甘兹', '穆罗', '维兹', '赞吉', '洛卡', '扎兹', '恩基',
                 '金度', '血顶', '暗矛', '碎颅'],
    # 牛头人
    'tauren':   ['凯恩', '贝恩', '哈缪', '玛格', '塔伦', '乌兰', '洛坎', '加尔', '图兰', '穆萨',
                 '达戈', '索恩', '卡哈', '兰恩', '泰兰', '霍尔', '布兰', '雷戈', '格姆', '山恩',
                 '血蹄', '雷蹄', '风鬃', '石牛'],
    # 血精灵
    'bloodelf': ['凯尔', '洛瑟', '莉亚', '瓦雷', '艾萨', '塞洛', '希尔', '玛维', '奥蕾', '塔莉',
                 '兰娜', '菲尔', '维洛', '达兹', '洛玛', '萨恩', '艾兰', '瑟兰', '卡兹', '弥斯',
                 '逐日', '远行者', '日冕', '晨锋'],
}

# 性别 -> 种族（NameRaceAndGender: 0/1 通用, 2/3 侏儒, 4/5 矮人, 6/7 暗夜, 8/9 德莱尼,
#               10/11 兽人, 12/13 巨魔, 14/15 牛头人, 16/17 血精灵）
GENDER_RACE = {
    0: 'generic',   1: 'generic',
    2: 'gnome',     3: 'gnome',
    4: 'dwarf',     5: 'dwarf',
    6: 'nightelf',  7: 'nightelf',
    8: 'draenei',   9: 'draenei',
    10: 'orc',      11: 'orc',
    12: 'troll',    13: 'troll',
    14: 'tauren',   15: 'tauren',
    16: 'bloodelf', 17: 'bloodelf',
}

MALE_SYL = ['斯', '尔', '德', '洛', '恩', '托', '姆', '克', '丁', '萨', '奥', '里',
            '丹', '雷', '格', '兹', '诺', '罗', '什', '安', '瑟', '达', '伦', '迪',
            '穆', '巴', '卡', '图', '汉', '森', '杰', '翰']
FEMALE_SYL = ['娜', '莉', '丝', '薇', '露', '莎', '妮', '黛', '珊', '蒂', '兰', '雅',
              '瑞', '温', '琳', '芙', '蕾', '蜜', '婕', '安', '拉', '伊', '瑟', '菲',
              '希', '雪', '月', '梦', '西', '彩', '鸢', '瑶']

# 收尾字（让名字读起来更像官译人名）
MALE_TAIL = ['斯', '尔', '德', '恩', '洛', '托', '姆', '克', '丁', '萨', '奥', '兹', '伦', '登']
FEMALE_TAIL = ['娜', '莉', '丝', '薇', '露', '莎', '妮', '黛', '珊', '蒂', '雅', '拉', '雅', '琳']


def gen_names(gender, need, rng=None, used_global=None):
    """生成 need 个指定性别的中文名（全局去重通过 used_global 集合）。"""
    rng = rng or random
    used_global = used_global if used_global is not None else set()
    race = GENDER_RACE[gender]
    heads = RACE_HEAD[race]
    syl = MALE_SYL if gender % 2 == 0 else FEMALE_SYL
    tail = MALE_TAIL if gender % 2 == 0 else FEMALE_TAIL

    out = []

    def add(n):
        if n in used_global or n in out:
            return False
        # 上限 4 个汉字 = 12 字节（UTF-8），兼容旧版 playerbots_names varchar(12)
        if len(n) < 2 or len(n) > 4:
            return False
        # 规避服务端 CHAR_NAME_THREE_CONSECUTIVE 校验
        for i in range(2, len(n)):
            if n[i] == n[i - 1] == n[i - 2]:
                return False
        out.append(n)
        return True

    cands = [p + a + b for p in heads for a in syl for b in tail if a != b]
    extra = [p + a + b + c for p in heads for a in syl for b in tail for c in syl
             if a != b and b != c]
    rng.shuffle(cands)
    rng.shuffle(extra)
    for n in cands + extra:
        add(n)
        if len(out) >= need:
            break
    return out[:need]


# ---------------- 公会名 / 竞技场队名 ----------------
GUILD_ADJ = ['荣耀', '永恒', '苍穹', '黎明', '血色', '暗影', '圣光', '龙啸', '铁血', '星辰',
             '霜寒', '雷霆', '烈焰', '幽月', '黄金', '白银', '赤焰', '深蓝', '苍狼', '极夜']
GUILD_NOUN = ['战歌', '远征', '守护', '审判', '骑士团', '军团', '同盟', '锋刃', '圣殿', '传说',
              '誓言', '雄心', '铁律', '光辉', '之翼', '之刃', '之怒', '先锋', '遗族', '轮回']

ARENA_ADJ = ['死亡', '血腥', '无敌', '狂暴', '暗影', '雷霆', '烈焰', '寒冰', '黄金', '白银',
             '幽冥', '疾风', '铁血', '破晓', '苍穹']
ARENA_NOUN = ['之刃', '审判', '风暴', '猎手', '终结者', '斗士', '战神', '死神', '双刃', '咆哮',
              '铁拳', '十字', '之矛', '之盾', '烈酒', '之影', '裁决', '囚笼', '绝杀', '狂澜']


def gen_guild_names(need=400, rng=None):
    rng = rng or random
    out, seen = [], set()
    pairs = [(a, n) for a in GUILD_ADJ for n in GUILD_NOUN]
    rng.shuffle(pairs)
    for a, n in pairs:
        nm = a + n
        if nm not in seen and len(nm) <= 24:
            seen.add(nm)
            out.append(nm)
        if len(out) >= need:
            break
    return out


def gen_arena_names(need=300, rng=None):
    rng = rng or random
    out, seen = [], set()
    pairs = [(a, n) for a in ARENA_ADJ for n in ARENA_NOUN]
    rng.shuffle(pairs)
    for a, n in pairs:
        nm = a + n
        if nm not in seen and len(nm) <= 24:
            seen.add(nm)
            out.append(nm)
        if len(out) >= need:
            break
    return out


# ---------------- 机器人喊话（官译口吻，非低俗） ----------------
TAUNTS = [
    "你的末日到了，<target>！", "我盯上你了，<target>。", "站住，<target>，你无路可逃！",
    "别挣扎了，<target>，认命吧。", "你的运气到头了，<target>。", "来啊，<target>，让我看看你的本事。",
    "你这样的对手，我一只手就能对付。", "我见过更强的，你差的远呢。", "你的装备救不了你。",
    "拔出武器吧，别让我等太久。", "你的传说到此为止了。", "我数三声，你最好开始跑。",
    "这片土地不欢迎你。", "你踩到我的地盘了。", "你的名字，我不会记住的。",
    "战斗吧，让命运来决定。", "你的生命，我收下了。", "别怪我，怪你自己选错了路。",
    "你以为你能赢？", "我比你想象的要强得多。", "再靠近一步，我就不客气了。",
    "你的勇气可嘉，可惜实力不够。", "送你上路，不用谢。", "这一击，是为了荣耀！",
    "你的倒下，只是时间问题。", "别跑了，跑不掉的。", "我见过你的同类，都倒下了。",
    "你挡了我的路，那就让开吧。", "来战！别磨蹭！", "你的护甲，挡不住我的怒火。",
    "让我看看你到底有几斤几两。", "你不是我的对手，趁早认输。", "这一战，我会记住的。",
    "你最好祈祷运气站在你那边。", "命运已经为你写好结局了。", "我的耐心可不多了。",
    "你的身影，将会消失在这片荒野。", "别逼我动手，虽然我很想。", "你听见战鼓了吗？那是为你敲的。",
    "我等这一天等了很久。", "你的名字将被遗忘。", "来吧，让我送你一程。",
    "你的挣扎毫无意义。", "我从不留活口，你也不例外。", "你最好现在就逃。",
    "这一刀，敬你的勇气。", "你的血，将染红这片土地。", "我知道你的弱点在哪。",
    "别用那种眼神看我，没用的。", "你的同伴不会来救你的。", "现在投降还来得及。",
    "你以为你能活着离开？", "让我教你什么叫真正的战斗。", "你的死，将成为一个传说。",
    "我踏过无数战场，你只是其中一个。", "你的骄傲会害死你。", "来啊，让我看看你的极限。",
    "你的武器，在我面前形同废铁。", "我闻到恐惧的味道了。", "你跑得再快也没用。",
    "这一战之后，不会再有人记得你。", "你的命运，已经被注定。", "别浪费我的时间。",
    "你的抵抗，只是徒劳。", "我会让你后悔站在这里。", "你的勇气值得尊敬，但仅此而已。",
    "记住我的名字，因为你会死在它之下。", "你的招式，我早就看穿了。", "这一刻，你已经输了。",
    "你的结局，我早已预见。", "别挣扎了，接受现实吧。", "我给你最后一次机会：滚。",
    "你的存在，是个错误。", "让我结束这一切。", "你的生命，只剩下最后一息。",
    "你的故事，到此为止。", "我会替这片土地清理掉你。", "你的傲慢，就是你最大的破绽。",
    "我见过太多像你这样的人。", "你的时间不多了。", "这是你最后的选择。",
    "你的努力，在我面前一文不值。", "别再挣扎，安静地倒下吧。", "你的命运，握在我手里。",
    "我会让你见识真正的力量。", "你的名字，将刻在我的战利品上。", "放弃吧，你赢不了的。",
    "你的每一次呼吸，都在倒计时。", "这场战斗，从一开始就没有悬念。", "你的影子，将被黑暗吞噬。",
    "我为你准备的，只有死亡。", "你的坚持，让我觉得可笑。", "这一击，将是你的终结。",
    "你认为的强者，在我面前不堪一击。", "别做梦了，醒醒吧。", "你的末路，就是这里。",
    "我等你很久了。", "你的死亡，将是最好的谢幕。", "现在，跪下。",
    "你的故事，我来写结局。", "这将是你最后一次战斗。", "你的传说，由我终结。",
]
YELLS = [
    "还有谁不服？站出来！", "这片战场，由我主宰！", "听到了吗？这就是我的回答！",
    "让所有人都知道，谁才是强者！", "颤抖吧，懦夫们！", "我的名字将响彻这片土地！",
    "胜利属于我！", "谁还想试试？", "这就是与我为敌的下场！",
    "来啊，全都上吧！", "让风暴见证我的力量！", "我不在乎你们有多少人！",
    "今天，这里将血流成河！",
]

TAUNT_PREFIX = ['', '哼，', '哈！', '听着，', '喂，', '哼哼，', '哈哈，']


def gen_taunt_text(idx, kind):
    pool = YELLS if kind == 'yell' else TAUNTS
    base = pool[idx % len(pool)]
    # 需要更多不重复文案时，用语气前缀做区分
    turn = idx // len(pool)
    if turn == 0:
        return base
    return TAUNT_PREFIX[turn % len(TAUNT_PREFIX)] + base


def esc(s):
    return s.replace('\\', '\\\\').replace("'", "\\'")


def build_names_sql(gender_counts, rng=None):
    """按 {gender: count} 生成 playerbots_names 的 DELETE+INSERT SQL 行列表。"""
    rng = rng or random
    used = set()
    lines = ["DELETE FROM `playerbots_names` WHERE `name_id` < 1000000;"]
    vals = []
    nid = 0
    for g in sorted(gender_counts):
        need = gender_counts[g]
        names, want = [], need
        while len(names) < need:
            batch = gen_names(g, want + 2000, rng=rng, used_global=used)
            for n in batch:
                if n not in used and n not in names:
                    names.append(n)
                    used.add(n)
                    if len(names) >= need:
                        break
            want += 20000
        for i, n in enumerate(names):
            vals.append('(%d,\'%s\',%d)' % (nid + i, esc(n), g))
        nid += len(names)
    for i in range(0, len(vals), 1000):
        lines.append('INSERT INTO `playerbots_names` (`name_id`,`name`,`gender`) VALUES\n  '
                     + ',\n  '.join(vals[i:i + 1000]) + ';')
    return lines, nid


def main():
    ap = argparse.ArgumentParser(description='生成中文机器人名字/公会名/竞技场队名 SQL（对应 mod-playerbots 基表结构）')
    ap.add_argument('--names', type=int, default=100000, help='名字总量（默认与上游新版基表一致）')
    ap.add_argument('--guilds', type=int, default=400)
    ap.add_argument('--arenas', type=int, default=300)
    ap.add_argument('--seed', type=int, default=DEFAULT_SEED)
    ap.add_argument('--out', default='-', help='输出 SQL 文件，- 为 stdout')
    args = ap.parse_args()
    rng = random.Random(args.seed)
    # 性别分布对齐上游新版基表：0/1 各 1 万，2~17 各 5 千
    per = (args.names - 20000) // 16
    gender_counts = {0: 10000, 1: 10000}
    for g in range(2, 18):
        gender_counts[g] = per
    lines = ['SET NAMES utf8mb4;', '']
    nlines, nid = build_names_sql(gender_counts, rng=rng)
    lines += nlines
    guilds = gen_guild_names(args.guilds, rng=rng)
    lines.append('TRUNCATE TABLE `playerbots_guild_names`;')
    vals = ["(%d,'%s')" % (j + 1, esc(n)) for j, n in enumerate(guilds)]
    for i in range(0, len(vals), 200):
        lines.append('INSERT INTO `playerbots_guild_names` (`name_id`,`name`) VALUES\n  '
                     + ',\n  '.join(vals[i:i + 200]) + ';')
    arenas = gen_arena_names(args.arenas, rng=rng)
    lines.append('TRUNCATE TABLE `playerbots_arena_team_names`;')
    types = [2, 3, 5]
    vals = ["(%d,'%s',%d)" % (j + 1, esc(n), types[j % 3]) for j, n in enumerate(arenas)]
    for i in range(0, len(vals), 200):
        lines.append('INSERT INTO `playerbots_arena_team_names` (`name_id`,`name`,`type`) VALUES\n  '
                     + ',\n  '.join(vals[i:i + 200]) + ';')
    sql = '\n'.join(lines) + '\n'
    if args.out == '-':
        print(sql)
    else:
        with open(args.out, 'w', encoding='utf-8', newline='\n') as f:
            f.write(sql)
        print('已生成: %s（名字 %d / 公会 %d / 竞技场 %d）' % (args.out, nid, len(guilds), len(arenas)))


if __name__ == '__main__':
    main()
