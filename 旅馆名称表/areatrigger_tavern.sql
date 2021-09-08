/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80023
 Source Host           : localhost:3306
 Source Schema         : acore_world

 Target Server Type    : MySQL
 Target Server Version : 80023
 File Encoding         : 65001

 Date: 31/03/2021 11:33:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for areatrigger_tavern
-- ----------------------------
DROP TABLE IF EXISTS `areatrigger_tavern`;
CREATE TABLE `areatrigger_tavern`  (
  `id` mediumint UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Identifier',
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Trigger System' ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of areatrigger_tavern
-- ----------------------------
INSERT INTO `areatrigger_tavern` VALUES (71, '西部荒野 - 哨兵岭旅店');
INSERT INTO `areatrigger_tavern` VALUES (98, '奈辛瓦里远征队营地');
INSERT INTO `areatrigger_tavern` VALUES (178, '斯坦恩布莱德');
INSERT INTO `areatrigger_tavern` VALUES (562, '艾尔文森林 - 闪金镇 - 狮王之傲旅店');
INSERT INTO `areatrigger_tavern` VALUES (682, '赤脊山 - 湖畔旅店');
INSERT INTO `areatrigger_tavern` VALUES (707, '暮色森林 - 夜色 - 血色旅店');
INSERT INTO `areatrigger_tavern` VALUES (708, '希尔斯布莱德丘陵 - 南海镇的旅店');
INSERT INTO `areatrigger_tavern` VALUES (709, '尘泥沼泽 - 塞拉摩岛');
INSERT INTO `areatrigger_tavern` VALUES (712, '洛克莫丹 - 在塞尔萨玛 - 烈酒旅店');
INSERT INTO `areatrigger_tavern` VALUES (713, '湿地 - 米奈希尔港 - 深水酒馆');
INSERT INTO `areatrigger_tavern` VALUES (715, '泰达希尔 - 多兰纳尔');
INSERT INTO `areatrigger_tavern` VALUES (716, '黑海岸 - 奥伯丁');
INSERT INTO `areatrigger_tavern` VALUES (717, '梣谷 - 阿斯特兰纳');
INSERT INTO `areatrigger_tavern` VALUES (719, '提里斯法林地 - 布瑞尔 - 恐惧之末旅店');
INSERT INTO `areatrigger_tavern` VALUES (720, '银松森林');
INSERT INTO `areatrigger_tavern` VALUES (721, '希尔斯布莱德丘陵');
INSERT INTO `areatrigger_tavern` VALUES (722, '莫高雷');
INSERT INTO `areatrigger_tavern` VALUES (742, '贫瘠之地');
INSERT INTO `areatrigger_tavern` VALUES (743, '贫瘠之地');
INSERT INTO `areatrigger_tavern` VALUES (843, '杜洛塔');
INSERT INTO `areatrigger_tavern` VALUES (844, '悲伤沼泽');
INSERT INTO `areatrigger_tavern` VALUES (862, '荆棘谷');
INSERT INTO `areatrigger_tavern` VALUES (982, '贫瘠之地');
INSERT INTO `areatrigger_tavern` VALUES (1022, '石爪山脉');
INSERT INTO `areatrigger_tavern` VALUES (1023, '塔纳利斯');
INSERT INTO `areatrigger_tavern` VALUES (1024, '菲拉斯');
INSERT INTO `areatrigger_tavern` VALUES (1025, '菲拉斯');
INSERT INTO `areatrigger_tavern` VALUES (1042, '蛮锤城堡');
INSERT INTO `areatrigger_tavern` VALUES (1606, '废地');
INSERT INTO `areatrigger_tavern` VALUES (1646, '阿拉希高地');
INSERT INTO `areatrigger_tavern` VALUES (2266, '凄凉之地');
INSERT INTO `areatrigger_tavern` VALUES (2267, '凄凉之地');
INSERT INTO `areatrigger_tavern` VALUES (2286, '千针石林');
INSERT INTO `areatrigger_tavern` VALUES (2287, '冬泉谷');
INSERT INTO `areatrigger_tavern` VALUES (2610, '梣谷');
INSERT INTO `areatrigger_tavern` VALUES (2786, '暴风城休息站');
INSERT INTO `areatrigger_tavern` VALUES (3547, '幽暗城');
INSERT INTO `areatrigger_tavern` VALUES (3690, '恶齿村');
INSERT INTO `areatrigger_tavern` VALUES (3886, '格罗姆高营地');
INSERT INTO `areatrigger_tavern` VALUES (3985, '塞纳里奥城堡');
INSERT INTO `areatrigger_tavern` VALUES (4058, '圣光之愿礼拜堂');
INSERT INTO `areatrigger_tavern` VALUES (4090, '石爪峰');
INSERT INTO `areatrigger_tavern` VALUES (4108, '安宁旅店');
INSERT INTO `areatrigger_tavern` VALUES (4109, '安宁地旅店（上层）');
INSERT INTO `areatrigger_tavern` VALUES (4240, '碧蓝岗哨旅店');
INSERT INTO `areatrigger_tavern` VALUES (4241, '血谜岛 - 血色守望旅店');
INSERT INTO `areatrigger_tavern` VALUES (4265, '晴风村旅店');
INSERT INTO `areatrigger_tavern` VALUES (4300, '塞纳里奥难民 - 外旅店');
INSERT INTO `areatrigger_tavern` VALUES (4336, '萨尔玛旅店');
INSERT INTO `areatrigger_tavern` VALUES (4337, '荣耀堡旅店');
INSERT INTO `areatrigger_tavern` VALUES (4373, '萨布拉金旅店');
INSERT INTO `areatrigger_tavern` VALUES (4374, '泰伦多尔旅店');
INSERT INTO `areatrigger_tavern` VALUES (4375, '如卡拉达尔快捷酒店');
INSERT INTO `areatrigger_tavern` VALUES (4376, '泰拉旅店');
INSERT INTO `areatrigger_tavern` VALUES (4377, '艾兰理堡垒旅店');
INSERT INTO `areatrigger_tavern` VALUES (4378, '石堡旅店');
INSERT INTO `areatrigger_tavern` VALUES (4380, '猎鹰岗哨旅店');
INSERT INTO `areatrigger_tavern` VALUES (4381, '特尔哈曼神庙旅店');
INSERT INTO `areatrigger_tavern` VALUES (4382, '塞纳里奥避难所');
INSERT INTO `areatrigger_tavern` VALUES (4383, '奥雷伯尔港旅店');
INSERT INTO `areatrigger_tavern` VALUES (4486, '猎鹰之翼广场旅店');
INSERT INTO `areatrigger_tavern` VALUES (4494, '雷霆王村旅店');
INSERT INTO `areatrigger_tavern` VALUES (4498, '旧希尔斯布莱德丘陵旅店');
INSERT INTO `areatrigger_tavern` VALUES (4499, '希尔瓦纳旅店');
INSERT INTO `areatrigger_tavern` VALUES (4521, '52区旅店');
INSERT INTO `areatrigger_tavern` VALUES (4526, '影月村旅店');
INSERT INTO `areatrigger_tavern` VALUES (4528, '蛮锤要塞旅店');
INSERT INTO `areatrigger_tavern` VALUES (4555, '风暴之尖旅店');
INSERT INTO `areatrigger_tavern` VALUES (4558, '托斯利基地旅店');
INSERT INTO `areatrigger_tavern` VALUES (4577, '萨塔祭坛');
INSERT INTO `areatrigger_tavern` VALUES (4595, '摩克纳萨尔村旅店');
INSERT INTO `areatrigger_tavern` VALUES (4607, '星光圣所旅店');
INSERT INTO `areatrigger_tavern` VALUES (4608, '圣殿的星星旅店（上层）');
INSERT INTO `areatrigger_tavern` VALUES (4640, '永恒树林旅店');
INSERT INTO `areatrigger_tavern` VALUES (4714, '泥链营地旅店');
INSERT INTO `areatrigger_tavern` VALUES (4753, '镇西旅店');
INSERT INTO `areatrigger_tavern` VALUES (4755, '冬蹄营地旅店');
INSERT INTO `areatrigger_tavern` VALUES (4756, '威德瓦堡垒旅店');
INSERT INTO `areatrigger_tavern` VALUES (4769, '铁炉堡大门');
INSERT INTO `areatrigger_tavern` VALUES (4775, '蕨墙村旅店');
INSERT INTO `areatrigger_tavern` VALUES (4847, '奎尔丹纳斯岛，日境港酒店');
INSERT INTO `areatrigger_tavern` VALUES (4861, '博格洛克前哨旅店');
INSERT INTO `areatrigger_tavern` VALUES (4867, '嘶轴简易机场旅店');
INSERT INTO `areatrigger_tavern` VALUES (4868, '坦卡雷村旅店');
INSERT INTO `areatrigger_tavern` VALUES (4910, '战歌堡');
INSERT INTO `areatrigger_tavern` VALUES (4961, '骁勇要塞旅店');
INSERT INTO `areatrigger_tavern` VALUES (4964, '繁星之眠');
INSERT INTO `areatrigger_tavern` VALUES (4965, '琥珀松小屋旅店');
INSERT INTO `areatrigger_tavern` VALUES (4966, '西荒兵团驻营');
INSERT INTO `areatrigger_tavern` VALUES (4967, '欧尼克瓦营地');
INSERT INTO `areatrigger_tavern` VALUES (4970, '征服堡');
INSERT INTO `areatrigger_tavern` VALUES (4975, '默亚基港');
INSERT INTO `areatrigger_tavern` VALUES (4976, '卡玛廓');
INSERT INTO `areatrigger_tavern` VALUES (4977, '昂纽沛旅店');
INSERT INTO `areatrigger_tavern` VALUES (4979, '毒怨之地');
INSERT INTO `areatrigger_tavern` VALUES (4993, '温特加德要塞');
INSERT INTO `areatrigger_tavern` VALUES (5030, '矛生驻营');
INSERT INTO `areatrigger_tavern` VALUES (5045, '阿格玛之锤');
INSERT INTO `areatrigger_tavern` VALUES (5062, '银白看台');
INSERT INTO `areatrigger_tavern` VALUES (5164, '辛讬加');
INSERT INTO `areatrigger_tavern` VALUES (5182, '霜堡');
INSERT INTO `areatrigger_tavern` VALUES (5183, 'K3');
INSERT INTO `areatrigger_tavern` VALUES (5200, '布伦希尔达村');
INSERT INTO `areatrigger_tavern` VALUES (5204, '石崖避难所');
INSERT INTO `areatrigger_tavern` VALUES (5217, '奈辛瓦里营地');
INSERT INTO `areatrigger_tavern` VALUES (5227, '银白先锋');
INSERT INTO `areatrigger_tavern` VALUES (5314, '龙眠神殿地下室');
INSERT INTO `areatrigger_tavern` VALUES (5315, '龙眠神殿 一层');
INSERT INTO `areatrigger_tavern` VALUES (5316, '龙眠神殿 二层');
INSERT INTO `areatrigger_tavern` VALUES (5317, '龙眠神殿 三层');
INSERT INTO `areatrigger_tavern` VALUES (5323, '坦卡罗营地');
INSERT INTO `areatrigger_tavern` VALUES (5327, '卡萨斯平台');
INSERT INTO `areatrigger_tavern` VALUES (5360, '格罗玛什坠毁点');

SET FOREIGN_KEY_CHECKS = 1;
