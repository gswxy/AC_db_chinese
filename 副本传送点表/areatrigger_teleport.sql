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

 Date: 30/03/2021 10:51:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for areatrigger_teleport
-- ----------------------------
DROP TABLE IF EXISTS `areatrigger_teleport`;
CREATE TABLE `areatrigger_teleport`  (
  `ID` mediumint UNSIGNED NOT NULL DEFAULT 0,
  `Name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `target_map` smallint UNSIGNED NOT NULL DEFAULT 0,
  `target_position_x` float NOT NULL DEFAULT 0,
  `target_position_y` float NOT NULL DEFAULT 0,
  `target_position_z` float NOT NULL DEFAULT 0,
  `target_orientation` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE,
  FULLTEXT INDEX `name`(`Name`)
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Trigger System' ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of areatrigger_teleport
-- ----------------------------
INSERT INTO `areatrigger_teleport` VALUES (45, '血色修道院西(墓地)副本起点', 189, 1688.99, 1053.48, 18.6775, 0.00117);
INSERT INTO `areatrigger_teleport` VALUES (78, '死亡矿井(副本)A-西部荒野', 36, -16.4, -383.07, 61.78, 1.86);
INSERT INTO `areatrigger_teleport` VALUES (101, '暴风城监狱-(副本)入口', 34, 54.23, 0.28, -18.34, 6.26);
INSERT INTO `areatrigger_teleport` VALUES (107, '暴风城地窑', 35, -0.91, 40.57, -24.23, 0);
INSERT INTO `areatrigger_teleport` VALUES (109, '暴风城地窑', 0, -8653.45, 606.19, 91.16, 0);
INSERT INTO `areatrigger_teleport` VALUES (119, '死亡矿井A门口-西部荒野', 0, -11208.3, 1672.52, 24.66, 4.55217);
INSERT INTO `areatrigger_teleport` VALUES (121, '死亡矿井B出口-西部荒野', 0, -11339.4, 1571.16, 100.56, 0);
INSERT INTO `areatrigger_teleport` VALUES (145, '影牙城堡(副本)-银松森林', 33, -229.135, 2109.18, 76.8898, 1.267);
INSERT INTO `areatrigger_teleport` VALUES (194, '影牙城堡 -入口', 0, -232.796, 1568.28, 76.8909, 4.398);
INSERT INTO `areatrigger_teleport` VALUES (226, '哀嚎洞穴门口-贫瘠之地', 1, -740.059, -2214.23, 16.1374, 5.68);
INSERT INTO `areatrigger_teleport` VALUES (228, '哀嚎洞穴(副本)-贫瘠之地', 43, -163.49, 132.9, -73.66, 5.83);
INSERT INTO `areatrigger_teleport` VALUES (242, '剃刀沼泽门口-贫瘠之地', 1, -4464.92, -1666.24, 81.8928, 4.28827);
INSERT INTO `areatrigger_teleport` VALUES (244, '剃刀沼泽(副本)-贫瘠之地', 47, 1943, 1544.63, 82, 1.38);
INSERT INTO `areatrigger_teleport` VALUES (257, '黑暗深渊(副本)-灰谷', 48, -151.89, 106.96, -39.87, 4.53);
INSERT INTO `areatrigger_teleport` VALUES (259, '黑暗深渊门口-灰谷', 1, 4247.74, 745.879, -24.5299, 4.5828);
INSERT INTO `areatrigger_teleport` VALUES (286, '奥达曼(副本)A-荒芜之地', 70, -226.8, 49.09, -46.03, 1.39);
INSERT INTO `areatrigger_teleport` VALUES (288, '奥达曼门口', 0, -6066.73, -2955.63, 209.776, 3.20443);
INSERT INTO `areatrigger_teleport` VALUES (322, '诺莫瑞根门口A-丹莫罗', 0, -5163.33, 927.623, 257.188, 0);
INSERT INTO `areatrigger_teleport` VALUES (324, '诺莫瑞根(副本)A-丹莫罗', 90, -332.22, -2.28, -150.86, 2.77);
INSERT INTO `areatrigger_teleport` VALUES (442, '剃刀高地(副本)-贫瘠之地', 129, 2592.55, 1107.5, 51.29, 4.74);
INSERT INTO `areatrigger_teleport` VALUES (444, '剃刀高地门口-贫瘠之地', 1, -4658.12, -2526.35, 81.492, 1.25978);
INSERT INTO `areatrigger_teleport` VALUES (446, '阿塔哈卡神庙(副本)-悲伤沼泽', 109, -319.24, 99.9, -131.85, 3.19);
INSERT INTO `areatrigger_teleport` VALUES (448, '阿塔哈卡神庙门口-悲伤沼泽', 0, -10175.1, -3995.15, -112.9, 2.95938);
INSERT INTO `areatrigger_teleport` VALUES (503, '暴风城监狱-门口', 0, -8764.83, 846.075, 87.4842, 3.77934);
INSERT INTO `areatrigger_teleport` VALUES (523, '诺莫瑞根(副本)B-丹莫罗', 90, -736.51, 2.71, -249.99, 3.14);
INSERT INTO `areatrigger_teleport` VALUES (525, '诺莫瑞根门口B-丹莫罗', 0, -4858.27, 756.435, 244.923, 0);
INSERT INTO `areatrigger_teleport` VALUES (527, '泰达希尔-鲁瑟兰村', 1, 8786.36, 967.445, 30.197, 3.39632);
INSERT INTO `areatrigger_teleport` VALUES (542, '泰达希尔-达纳苏斯', 1, 9945.13, 2616.89, 1316.46, 4.61446);
INSERT INTO `areatrigger_teleport` VALUES (602, '血色修道院西(墓地)门口', 0, 2913.92, -802.404, 160.333, 3.50405);
INSERT INTO `areatrigger_teleport` VALUES (604, '血色修道院西(大教堂)门口', 0, 2906.14, -813.772, 160.333, 1.95739);
INSERT INTO `areatrigger_teleport` VALUES (606, '血色修道院东(军械库)门口', 0, 2884.45, -822.01, 160.333, 1.95268);
INSERT INTO `areatrigger_teleport` VALUES (608, '血色修道院东(图书馆)门口', 0, 2870.9, -820.164, 160.333, 0.387856);
INSERT INTO `areatrigger_teleport` VALUES (610, '血色修道院西(大教堂)副本起点', 189, 855.683, 1321.5, 18.6709, 0.001747);
INSERT INTO `areatrigger_teleport` VALUES (612, '血色修道院东(军械库)副本起点', 189, 1610.83, -323.433, 18.6738, 6.28022);
INSERT INTO `areatrigger_teleport` VALUES (614, '血色修道院东(图书馆)副本起点', 189, 255.346, -209.09, 18.6773, 6.26656);
INSERT INTO `areatrigger_teleport` VALUES (702, '暴风城-巫师圣殿', 0, -9015.76, 874.94, 148.62, 5.211);
INSERT INTO `areatrigger_teleport` VALUES (704, '暴风城-巫师圣殿入口', 0, -9018.56, 887.664, 29.63, 5.346);
INSERT INTO `areatrigger_teleport` VALUES (882, '奥达曼门口B-荒芜之地', 0, -6620.48, -3765.19, 266.226, 3.13531);
INSERT INTO `areatrigger_teleport` VALUES (902, '奥达曼(副本)B-荒芜之地', 70, -214.02, 383.607, -38.7687, 0.5);
INSERT INTO `areatrigger_teleport` VALUES (922, '祖尔法拉克门口-塔纳利斯', 1, -6796.49, -2890.77, 8.88063, 3.30496);
INSERT INTO `areatrigger_teleport` VALUES (924, '祖尔法拉克(副本)-塔纳利斯', 209, 1213.52, 841.59, 8.93, 6.09);
INSERT INTO `areatrigger_teleport` VALUES (943, '信仰的飞跃 - 秋季结束', 1, -5187.47, -2804.32, -8.375, 5.76);
INSERT INTO `areatrigger_teleport` VALUES (1064, '奥妮克希亚的巢穴门口-尘泥沼泽', 1, -4747.17, -3753.27, 49.8122, 0.713271);
INSERT INTO `areatrigger_teleport` VALUES (1466, '黑石深渊(副本)-黑石山', 230, 458.32, 26.52, -70.67, 4.95);
INSERT INTO `areatrigger_teleport` VALUES (1468, '黑石塔-灼热峡谷黑手大厅', 229, 78.5083, -225.044, 49.839, 5.1);
INSERT INTO `areatrigger_teleport` VALUES (1470, '黑石塔-灼热峡谷熔岩之桥', 0, -7524.19, -1230.13, 285.743, 2.09544);
INSERT INTO `areatrigger_teleport` VALUES (1472, '黑石深渊门口-黑石山', 0, -7179.63, -923.667, 166.416, 1.84097);
INSERT INTO `areatrigger_teleport` VALUES (2166, '矿道地铁-铁炉堡', 0, -4838.95, -1318.46, 501.868, 1.42372);
INSERT INTO `areatrigger_teleport` VALUES (2171, '矿道地铁-暴风城', 0, -8364.57, 535.981, 91.7969, 2.24619);
INSERT INTO `areatrigger_teleport` VALUES (2173, '矿道地铁-暴风城', 369, 68.3006, 2490.91, -4.29647, 3.12192);
INSERT INTO `areatrigger_teleport` VALUES (2175, '矿道地铁-铁炉堡', 369, 69.2542, 10.257, -4.29664, 3.09832);
INSERT INTO `areatrigger_teleport` VALUES (2214, '斯坦索姆(副本)B-东瘟疫之地', 329, 3593.15, -3646.56, 138.5, 5.33);
INSERT INTO `areatrigger_teleport` VALUES (2216, '斯坦索姆-东瘟疫之地出口A2', 329, 3395.09, -3380.25, 142.702, 0.1);
INSERT INTO `areatrigger_teleport` VALUES (2217, '斯坦索姆-东瘟疫之地出口A1', 329, 3395.09, -3380.25, 142.702, 0.1);
INSERT INTO `areatrigger_teleport` VALUES (2221, '斯坦索姆门口B-东瘟疫之地', 0, 3235.46, -4050.6, 108.45, 1.93522);
INSERT INTO `areatrigger_teleport` VALUES (2226, '怒焰裂谷门口-奥格瑞玛', 1, 1813.49, -4418.58, -18.57, 1.78);
INSERT INTO `areatrigger_teleport` VALUES (2230, '怒焰裂谷(副本)-奥格瑞玛', 389, 3.81, -14.82, -17.84, 4.39);
INSERT INTO `areatrigger_teleport` VALUES (2406, '影牙城堡 - 南部', 0, -276.241, 1652.68, 77.5589, 3.14159);
INSERT INTO `areatrigger_teleport` VALUES (2407, '影牙城堡 - 南部', 0, -276.241, 1652.68, 77.5589, 3.14159);
INSERT INTO `areatrigger_teleport` VALUES (2408, '影牙城堡 - 前门', 0, -225.34, 1556.53, 93.0454, 4.71239);
INSERT INTO `areatrigger_teleport` VALUES (2409, '影牙城堡 - 前门', 0, -225.34, 1556.53, 93.0454, 4.71239);
INSERT INTO `areatrigger_teleport` VALUES (2410, '影牙城堡 - 南部', 0, -181.26, 1580.65, 97.4466, 6.28319);
INSERT INTO `areatrigger_teleport` VALUES (2411, '影牙城堡 - 南部', 0, -181.26, 1580.65, 97.4466, 6.28319);
INSERT INTO `areatrigger_teleport` VALUES (2530, '奥格瑞玛-(勇者大厅)入口', 1, 1637.32, -4242.7, 56.1827, 4.1927);
INSERT INTO `areatrigger_teleport` VALUES (2534, '暴风城-(勇士大厅)入口', 0, -8762.45, 403.062, 103.902, 5.34463);
INSERT INTO `areatrigger_teleport` VALUES (2547, '通灵学院 - 出口', 0, 1399.42, -2574.59, 107.786, 6.28319);
INSERT INTO `areatrigger_teleport` VALUES (2548, '通灵学院 - 出口', 0, 1399.42, -2574.59, 107.786, 6.28319);
INSERT INTO `areatrigger_teleport` VALUES (2549, '通灵学院 - 出口', 0, 1399.42, -2574.59, 107.786, 6.28319);
INSERT INTO `areatrigger_teleport` VALUES (2567, '通灵学院(副本)-西瘟疫之地', 289, 196.37, 127.05, 134.91, 6.09);
INSERT INTO `areatrigger_teleport` VALUES (2568, '通灵学院门口-西瘟疫之地', 0, 1275.05, -2552.03, 90.3994, 3.6631);
INSERT INTO `areatrigger_teleport` VALUES (2606, 'PVP1奥特兰克山谷-部落入口', 0, 534.868, -1087.68, 106.119, 3.35758);
INSERT INTO `areatrigger_teleport` VALUES (2608, 'PVP1奥特兰克山谷-联盟入口', 0, 98.432, -182.274, 127.52, 5.02654);
INSERT INTO `areatrigger_teleport` VALUES (2848, '奥妮克希亚的巢穴(副本)-尘泥沼泽', 249, 29.1607, -71.3372, -8.18032, 4.58);
INSERT INTO `areatrigger_teleport` VALUES (2886, '熔火之桥', 409, 1096, -467, -104.6, 3.64);
INSERT INTO `areatrigger_teleport` VALUES (2890, '熔火之心 - 入口, 里面', 230, 1115.35, -457.35, -102.7, 0.5);
INSERT INTO `areatrigger_teleport` VALUES (3126, '玛拉顿门口B-凄凉之地', 1, -1186.98, 2875.95, 85.7258, 1.78443);
INSERT INTO `areatrigger_teleport` VALUES (3131, '玛拉顿门口A-凄凉之地', 1, -1471.07, 2618.57, 76.1944, 0);
INSERT INTO `areatrigger_teleport` VALUES (3133, '玛拉顿(副本)A-凄凉之地', 349, 1019.69, -458.31, -43.43, 0.31);
INSERT INTO `areatrigger_teleport` VALUES (3134, '玛拉顿(副本)B-凄凉之地', 349, 752.91, -616.53, -33.11, 1.37);
INSERT INTO `areatrigger_teleport` VALUES (3183, '厄运之槌东A(副本)-菲拉斯', 429, 44.4499, -154.822, -2.71201, 0);
INSERT INTO `areatrigger_teleport` VALUES (3184, '厄运之槌东B(副本)-菲拉斯', 429, -201.11, -328.66, -2.72, 5.22);
INSERT INTO `areatrigger_teleport` VALUES (3185, '厄运之槌东C(副本)-菲拉斯', 429, 9.31119, -837.085, -32.5305, 0);
INSERT INTO `areatrigger_teleport` VALUES (3186, '厄运之槌西B(副本)-菲拉斯', 429, -62.9658, 159.867, -3.46206, 3.14788);
INSERT INTO `areatrigger_teleport` VALUES (3187, '厄运之槌西A(副本)-菲拉斯', 429, 31.5609, 159.45, -3.4777, 0.01);
INSERT INTO `areatrigger_teleport` VALUES (3189, '厄运之槌北(副本)-菲拉斯', 429, 255.249, -16.0561, -2.58737, 4.7);
INSERT INTO `areatrigger_teleport` VALUES (3190, '厄运之槌西B门口-菲拉斯', 1, -3831.79, 1250.23, 160.223, 0);
INSERT INTO `areatrigger_teleport` VALUES (3191, '厄运之槌西A门口-菲拉斯', 1, -3747.96, 1249.18, 160.217, 3.15827);
INSERT INTO `areatrigger_teleport` VALUES (3193, '厄运之槌北门口-菲拉斯', 1, -3520.65, 1077.72, 161.138, 1.5009);
INSERT INTO `areatrigger_teleport` VALUES (3194, '厄运之槌东A门口-菲拉斯', 1, -3737.48, 934.975, 160.973, 3.13864);
INSERT INTO `areatrigger_teleport` VALUES (3195, '厄运之槌东B门口-菲拉斯', 1, -3980.58, 776.193, 161.006, 0);
INSERT INTO `areatrigger_teleport` VALUES (3196, '厄运之槌东C门口-菲拉斯', 1, -4030.21, 127.966, 26.8109, 0);
INSERT INTO `areatrigger_teleport` VALUES (3197, '厄运之槌东D门口-菲拉斯', 1, -3577.67, 841.859, 134.594, 0);
INSERT INTO `areatrigger_teleport` VALUES (3528, '熔火之心之窗 入口', 409, 1096, -467, -104.6, 3.64);
INSERT INTO `areatrigger_teleport` VALUES (3529, '熔火之心之窗 (熔岩) 入口', 409, 1096, -467, -104.6, 3.64);
INSERT INTO `areatrigger_teleport` VALUES (3726, '黑翼之巢入口-灼热峡谷-燃烧平原-东部王国', 469, -7673.03, -1106.08, 396.651, 0.703353);
INSERT INTO `areatrigger_teleport` VALUES (3728, '黑翼之巢出口-黑石山-东部王国', 229, 174.74, -474.77, 116.84, 3.2);
INSERT INTO `areatrigger_teleport` VALUES (3928, '祖尔格拉布(副本)-荆棘谷', 309, -11916.1, -1230.53, 92.5334, 4.71867);
INSERT INTO `areatrigger_teleport` VALUES (3930, '祖尔格拉布门口-荆棘谷', 0, -11916.3, -1208.37, 92.2868, 1.61792);
INSERT INTO `areatrigger_teleport` VALUES (3948, 'PVP4阿拉希盆地联盟出口', 0, -1198, -2533, 22, 0);
INSERT INTO `areatrigger_teleport` VALUES (3949, 'PVP4落锤镇部落入口', 0, -817, -3509, 73, 0);
INSERT INTO `areatrigger_teleport` VALUES (4006, '安其拉废墟门口-希利苏斯', 1, -8418.5, 1505.94, 31.8232, 0);
INSERT INTO `areatrigger_teleport` VALUES (4008, '安其拉废墟(副本)-希利苏斯', 509, -8429.74, 1512.14, 31.9074, 2.58);
INSERT INTO `areatrigger_teleport` VALUES (4010, '安其拉神殿(副本)-希利苏斯', 531, -8231.33, 2010.6, 129.331, 0.929912);
INSERT INTO `areatrigger_teleport` VALUES (4012, '安其拉神殿门口-希利苏斯', 1, -8242.67, 1992.06, 129.072, 4.03066);
INSERT INTO `areatrigger_teleport` VALUES (4131, '卡拉赞门楼(入口处)', 532, -11100, -2003.98, 49.8927, 0.577268);
INSERT INTO `areatrigger_teleport` VALUES (4135, '卡拉赞上层', 532, -11040.1, -1996.85, 94.6837, 2.20224);
INSERT INTO `areatrigger_teleport` VALUES (4145, '碎裂大厅出口', 530, -311.16, 3082.1, -3.71, 4.92);
INSERT INTO `areatrigger_teleport` VALUES (4147, '蒸汽洞窟出口', 530, -303.506, 3164.82, 31.7425, 5.24025);
INSERT INTO `areatrigger_teleport` VALUES (4149, '玛瑟里顿的巢穴出口', 530, -313.679, 3088.35, -116.502, 2.05307);
INSERT INTO `areatrigger_teleport` VALUES (4150, '地狱火壁垒', 543, -1355.24, 1641.12, 68.2491, 0.6687);
INSERT INTO `areatrigger_teleport` VALUES (4151, '破碎大厅', 540, -40.8716, -19.7538, -13.8065, 1.11133);
INSERT INTO `areatrigger_teleport` VALUES (4152, '蒸汽洞窟', 542, -3.9967, 14.6363, -44.8009, 4.88748);
INSERT INTO `areatrigger_teleport` VALUES (4153, '玛瑟里顿的巢穴', 544, 187.843, 35.9232, 67.9252, 4.79879);
INSERT INTO `areatrigger_teleport` VALUES (4156, '纳克萨玛斯（副本出口）', 533, 3500.87, -5339.03, 145, 1.34);
INSERT INTO `areatrigger_teleport` VALUES (4233, '鬼魂之地, 暮萎尖塔, 露台', 530, 9331.49, -7812.27, 136.569, 5.23599);
INSERT INTO `areatrigger_teleport` VALUES (4267, '永歌森林, 暮萎尖塔, 宝珠高台', 530, 9334.03, -7880.02, 74.9095, 2.35619);
INSERT INTO `areatrigger_teleport` VALUES (4297, '地狱火壁垒出口', 530, -360.671, 3071.9, -15.0977, 5.14274);
INSERT INTO `areatrigger_teleport` VALUES (4304, '地狱火城墙 - 无疤者出口', 530, -233.33, 3199.71, -50, 0.785398);
INSERT INTO `areatrigger_teleport` VALUES (4311, '到海家尔人类营地之门', 534, 4954, -1886.2, 1326, 0.13);
INSERT INTO `areatrigger_teleport` VALUES (4312, '从海家尔到部落营地之门', 534, 5497.33, -2971.14, 1537.63, 2.832);
INSERT INTO `areatrigger_teleport` VALUES (4313, '从海家尔到暗夜精灵村庄生命之树之门', 534, 5152.33, -3364.4, 1644.74, 6.2);
INSERT INTO `areatrigger_teleport` VALUES (4319, '海家尔山峰入口', 534, 4259.61, -4233.77, 868.199, 2.53);
INSERT INTO `areatrigger_teleport` VALUES (4320, '黑色沼泽出口', 269, -1496.24, 7034.7, 32.5619, 1.75699);
INSERT INTO `areatrigger_teleport` VALUES (4321, '时光之穴出口', 560, 2741.87, 1315.25, 14.0423, 2.96016);
INSERT INTO `areatrigger_teleport` VALUES (4322, '黑色沼泽出口', 1, -8765.66, -4175, -209.863, 5.53463);
INSERT INTO `areatrigger_teleport` VALUES (4323, '从海家尔到CoT 主门', 1, -8177.5, -4183, -168, 4.5);
INSERT INTO `areatrigger_teleport` VALUES (4324, '时光之穴入口', 1, -8334.98, -4055.32, -207.737, 3.27431);
INSERT INTO `areatrigger_teleport` VALUES (4352, '外域到黑暗之门', 0, -11877.7, -3204.49, -18.49, 0.23);
INSERT INTO `areatrigger_teleport` VALUES (4354, '黑暗之门到外域', 530, -248.149, 921.875, 84.3885, 1.58415);
INSERT INTO `areatrigger_teleport` VALUES (4363, '沼泽洞穴入口', 546, 9.71391, -16.2008, -2.75334, 5.57082);
INSERT INTO `areatrigger_teleport` VALUES (4364, '蒸汽洞窟入口', 545, -13.8425, 6.7542, -4.2586, 0);
INSERT INTO `areatrigger_teleport` VALUES (4365, '奴隶围栏入口', 547, 120.101, -131.957, -0.801547, 1.47574);
INSERT INTO `areatrigger_teleport` VALUES (4366, '蒸汽洞窟出口', 530, 816.59, 6934.67, -80.5446, 4.53174);
INSERT INTO `areatrigger_teleport` VALUES (4367, '沼泽洞穴出口', 530, 777.089, 6763.45, -72.0662, 2.72453);
INSERT INTO `areatrigger_teleport` VALUES (4379, '奴隶围栏出口', 530, 719.508, 6999.34, -73.0743, 4.52702);
INSERT INTO `areatrigger_teleport` VALUES (4386, '逐日岛到东瘟疫之地', 0, 3476.36, -4493.36, 137.49, 2.25566);
INSERT INTO `areatrigger_teleport` VALUES (4397, '暗影迷宫出口', 530, -3645.06, 4943.62, -101.048, 6.27058);
INSERT INTO `areatrigger_teleport` VALUES (4399, '塞泰克大厅出口', 530, -3361.96, 4660.41, -101.048, 1.65638);
INSERT INTO `areatrigger_teleport` VALUES (4401, '法力坟墓出口', 530, -3079.81, 4943.04, -101.047, 3.16432);
INSERT INTO `areatrigger_teleport` VALUES (4403, '奥金顿墓穴出口', 530, -3362.22, 5225.77, -101.049, 4.67224);
INSERT INTO `areatrigger_teleport` VALUES (4404, '奥金顿墓穴入口', 558, -21.8975, 0.16, -0.1206, 0.035341);
INSERT INTO `areatrigger_teleport` VALUES (4405, '法力坟墓入口', 557, 0.0191, 0.9478, -0.9543, 3.03164);
INSERT INTO `areatrigger_teleport` VALUES (4406, '塞泰克大厅入口', 556, -4.6811, -0.09308, 0.0062, 0.035342);
INSERT INTO `areatrigger_teleport` VALUES (4407, '暗影迷宫入口', 555, 0.488033, -0.215935, -1.12788, 3.15888);
INSERT INTO `areatrigger_teleport` VALUES (4409, '东瘟疫之地到逐日岛', 530, 6123, -7005, 138, 5);
INSERT INTO `areatrigger_teleport` VALUES (4416, '盘牙洞穴入口', 548, 2.5343, -0.022318, 821.727, 0.004512);
INSERT INTO `areatrigger_teleport` VALUES (4418, '盘牙洞穴出口', 530, 827.011, 6865.47, -63.7844, 3.06507);
INSERT INTO `areatrigger_teleport` VALUES (4436, '卡拉赞门房 (出口)', 0, -11112.9, -2005.89, 49.3307, 4.02516);
INSERT INTO `areatrigger_teleport` VALUES (4455, '拱廊区出口', 530, 3312.09, 1331.89, 505.559, 2.00554);
INSERT INTO `areatrigger_teleport` VALUES (4457, '凤凰大厅出口', 530, 3087.31, 1373.79, 184.643, 1.52918);
INSERT INTO `areatrigger_teleport` VALUES (4459, '秘术区出口', 530, 3413.65, 1483.32, 182.838, 2.54432);
INSERT INTO `areatrigger_teleport` VALUES (4461, '机械区出口', 530, 2862.41, 1546.09, 252.161, 0.805457);
INSERT INTO `areatrigger_teleport` VALUES (4467, '秘术区入口', 553, 40.0395, -28.613, -1.1189, 2.35856);
INSERT INTO `areatrigger_teleport` VALUES (4468, '拱廊区入口', 552, -1.23165, 0.014346, -0.204293, 0.015712);
INSERT INTO `areatrigger_teleport` VALUES (4469, '机械区入口', 554, -28.906, 0.680314, -1.81282, 0.034551);
INSERT INTO `areatrigger_teleport` VALUES (4470, '凤凰大厅入口', 550, -10.8021, -1.15045, -2.42833, 6.22821);
INSERT INTO `areatrigger_teleport` VALUES (4487, '海家尔峰出口', 1, -8177.5, -4183, -168, 4.5);
INSERT INTO `areatrigger_teleport` VALUES (4520, '卡拉赞, 广场 (出口)', 0, -11034.8, -2003.8, 92.98, 0);
INSERT INTO `areatrigger_teleport` VALUES (4523, '索克雷萨出口', 530, 4773.76, 3451.27, 105.15, 3.84);
INSERT INTO `areatrigger_teleport` VALUES (4534, '格鲁尔巢穴出口', 530, 3549.8, 5085.97, 2.46332, 2.25742);
INSERT INTO `areatrigger_teleport` VALUES (4535, '格鲁尔巢穴入口', 565, 62.7842, 35.462, -3.9835, 1.41844);
INSERT INTO `areatrigger_teleport` VALUES (4561, '侵略点:灾难 (回归)', 530, -3278.63, 2831.31, 123.01, 1.56);
INSERT INTO `areatrigger_teleport` VALUES (4562, '侵略点:灾难 (回归)', 530, -3278.63, 2831.31, 123.01, 1.56);
INSERT INTO `areatrigger_teleport` VALUES (4598, '黑暗神庙', 564, 96.4462, 1002.35, -86.9984, 6.15675);
INSERT INTO `areatrigger_teleport` VALUES (4612, '波塔尼卡 - 麦克纳尔', 530, 3407.11, 1488.48, 182.838, 2.50112);
INSERT INTO `areatrigger_teleport` VALUES (4614, '麦克纳尔 - 波塔尼卡', 530, 2869.89, 1552.76, 252.159, 0.733993);
INSERT INTO `areatrigger_teleport` VALUES (4619, '黑暗神庙出口', 530, -3653.51, 317.493, 36.1671, 6.24941);
INSERT INTO `areatrigger_teleport` VALUES (4738, '祖阿曼入口', 568, 120.7, 1776, 43.46, 4.7713);
INSERT INTO `areatrigger_teleport` VALUES (4739, '祖阿曼出口', 530, 6851.5, -7997.68, 192.36, 1.56688);
INSERT INTO `areatrigger_teleport` VALUES (4741, '俄特加德要塞- 出口', 571, 1228.09, -4862.45, 41.248, 3.443);
INSERT INTO `areatrigger_teleport` VALUES (4743, '俄特加德要塞- 出口', 571, 1237.2, -4859.27, 218.283, 0.274);
INSERT INTO `areatrigger_teleport` VALUES (4745, '俄特加德要塞- 入口', 574, 153.789, -86.548, 12.551, 0.304);
INSERT INTO `areatrigger_teleport` VALUES (4747, '俄特加德要塞- 出口', 575, 584.117, -327.974, 110.138, 3.122);
INSERT INTO `areatrigger_teleport` VALUES (4885, '魔导师平台出口', 530, 12884.6, -7336.17, 65.48, 1.09);
INSERT INTO `areatrigger_teleport` VALUES (4887, '魔导师平台入口', 585, 7.09, -0.45, -2.8, 0.05);
INSERT INTO `areatrigger_teleport` VALUES (4889, '太阳之井高地入口', 580, 1790.65, 925.67, 15.15, 3.1);
INSERT INTO `areatrigger_teleport` VALUES (4891, '太阳之井高地出口', 530, 12560.8, -6774.59, 15.08, 6.25);
INSERT INTO `areatrigger_teleport` VALUES (4917, '竞技场 - 纳格兰竞技场 - 传送目标 - 比赛开始', 559, 4054.57, 2923.23, 13.8179, 0);
INSERT INTO `areatrigger_teleport` VALUES (4919, '竞技场 - 刀锋竞技场 - 传送目标 - 比赛开始', 562, 6238.89, 264.155, 0.894302, 0);
INSERT INTO `areatrigger_teleport` VALUES (4921, '竞技场 - 刀锋竞技场 - 传送目标 - 比赛开始', 562, 6238.89, 264.155, 0.894302, 0);
INSERT INTO `areatrigger_teleport` VALUES (4922, '竞技场 - 刀锋竞技场 - 传送目标 - 比赛开始', 562, 6238.89, 264.155, 0.894302, 0);
INSERT INTO `areatrigger_teleport` VALUES (4923, '竞技场 - 刀锋竞技场 - 传送目标 - 比赛开始', 562, 6238.89, 264.155, 0.894302, 0);
INSERT INTO `areatrigger_teleport` VALUES (4924, '竞技场 - 刀锋竞技场 - 传送目标 - 比赛开始', 562, 6238.89, 264.155, 0.894302, 0);
INSERT INTO `areatrigger_teleport` VALUES (4925, '竞技场 - 刀锋竞技场 - 传送目标 - 比赛开始', 562, 6238.89, 264.155, 0.894302, 0);
INSERT INTO `areatrigger_teleport` VALUES (4927, '竞技场 - 幽暗竞技场 - 传送目标 - 比赛开始', 572, 1286.57, 1667.4, 39.602, 0);
INSERT INTO `areatrigger_teleport` VALUES (4928, '竞技场 - 幽暗竞技场 - 传送目标 - 比赛开始', 572, 1286.57, 1667.4, 39.602, 0);
INSERT INTO `areatrigger_teleport` VALUES (4929, '竞技场 - 幽暗竞技场 - 传送目标 - 比赛开始', 572, 1286.57, 1667.4, 39.602, 0);
INSERT INTO `areatrigger_teleport` VALUES (4930, '竞技场 - 幽暗竞技场 - 传送目标 - 比赛开始', 572, 1286.57, 1667.4, 39.602, 0);
INSERT INTO `areatrigger_teleport` VALUES (4931, '竞技场 - 幽暗竞技场 - 传送目标 - 比赛开始', 572, 1286.57, 1667.4, 39.602, 0);
INSERT INTO `areatrigger_teleport` VALUES (4932, '竞技场 - 幽暗竞技场 - 传送目标 - 比赛开始', 572, 1286.57, 1667.4, 39.602, 0);
INSERT INTO `areatrigger_teleport` VALUES (4933, '竞技场 - 幽暗竞技场 - 传送目标 - 比赛开始', 572, 1286.57, 1667.4, 39.602, 0);
INSERT INTO `areatrigger_teleport` VALUES (4934, '竞技场 - 幽暗竞技场 - 传送目标 - 比赛开始', 572, 1286.57, 1667.4, 39.602, 0);
INSERT INTO `areatrigger_teleport` VALUES (4935, '竞技场 - 幽暗竞技场 - 传送目标 - 比赛开始', 572, 1286.57, 1667.4, 39.602, 0);
INSERT INTO `areatrigger_teleport` VALUES (4936, '竞技场 - 幽暗竞技场 - 传送目标 - 比赛开始', 572, 1286.57, 1667.4, 39.602, 0);
INSERT INTO `areatrigger_teleport` VALUES (4941, '竞技场 - 幽暗竞技场 - 传送目标 - 比赛开始', 572, 1286.57, 1667.4, 39.602, 0);
INSERT INTO `areatrigger_teleport` VALUES (4944, '竞技场 - 刀锋竞技场 - 传送目标 - 比赛开始', 562, 6238.89, 264.155, 0.894302, 0);
INSERT INTO `areatrigger_teleport` VALUES (4981, '奈萨斯 70 出口', 571, 3897.42, 6985.33, 69.487, 3.17);
INSERT INTO `areatrigger_teleport` VALUES (4983, '奈萨斯 70 入口', 576, 145.87, -10.554, -16.636, 1.528);
INSERT INTO `areatrigger_teleport` VALUES (4998, '德拉克萨隆 入口', 600, -517.343, -487.976, 11.01, 4.831);
INSERT INTO `areatrigger_teleport` VALUES (5000, '德拉克萨隆 出口', 571, 4774.47, -2028.04, 229.373, 4.645);
INSERT INTO `areatrigger_teleport` VALUES (5001, '奥核之眼 - 出口', 571, 3876.16, 6984.44, 106.32, 6.279);
INSERT INTO `areatrigger_teleport` VALUES (5010, '奥杜亚, 石之大厅 (入口)', 599, 1153.24, 806.164, 195.937, 4.715);
INSERT INTO `areatrigger_teleport` VALUES (5012, '石之大厅 - 出口', 571, 8921.93, -970.399, 1039.2, 4.726);
INSERT INTO `areatrigger_teleport` VALUES (5051, 'q12710: 1楼', 571, 6159.16, -2028.6, 408.168, 3.74088);
INSERT INTO `areatrigger_teleport` VALUES (5061, 'Zul\'drak - Voltarus, middle floor -> base', 571, 6175.6, -2008.78, 245.255, 1.49857);
INSERT INTO `areatrigger_teleport` VALUES (5080, 'Zul\'drak - Voltarus, upper floor -> middle', 571, 6159.16, -2028.6, 408.168, 3.74088);
INSERT INTO `areatrigger_teleport` VALUES (5091, '雷光大厅 - 出口', 571, 9182.91, -1384.73, 1110.21, 2.431);
INSERT INTO `areatrigger_teleport` VALUES (5093, '雷光大厅 - 入口', 602, 1331.47, 259.619, 53.398, 4.772);
INSERT INTO `areatrigger_teleport` VALUES (5113, '阿兹欧-奈幽 - 出口?', 571, 3820.08, 2035.62, 11.0722, 3.22311);
INSERT INTO `areatrigger_teleport` VALUES (5115, '阿兹欧-奈幽 (出口)', 571, 3678.05, 2166.4, 35.795, 5.58);
INSERT INTO `areatrigger_teleport` VALUES (5117, '阿兹欧-奈幽 (入口)', 601, 413.314, 795.968, 831.351, 5.5);
INSERT INTO `areatrigger_teleport` VALUES (5127, '黑锋要塞 (E.K.) 返回目标', 0, 2462.76, -5598.19, 550.22, 3.66519);
INSERT INTO `areatrigger_teleport` VALUES (5128, '黑锋要塞 (E.K.) 西部目标', 0, 2472.67, -5530.1, 420.642, 4.50295);
INSERT INTO `areatrigger_teleport` VALUES (5129, '黑锋要塞 (E.K.) 返回目标', 0, 2462.76, -5598.19, 550.22, 3.66519);
INSERT INTO `areatrigger_teleport` VALUES (5130, '黑锋要塞 (E.K.) 南部目标', 0, 2397.37, -5581.06, 420.643, 6.07375);
INSERT INTO `areatrigger_teleport` VALUES (5131, '黑锋要塞 (E.K.) 返回目标', 0, 2462.76, -5598.19, 550.22, 3.66519);
INSERT INTO `areatrigger_teleport` VALUES (5132, '黑锋要塞 (E.K.) 北部目标', 0, 2522.45, -5605.7, 420.642, 2.94961);
INSERT INTO `areatrigger_teleport` VALUES (5133, '黑锋要塞 (E.K.) 返回目标', 0, 2462.76, -5598.19, 550.22, 3.66519);
INSERT INTO `areatrigger_teleport` VALUES (5134, '黑锋要塞 (E.K.) 东部目标', 0, 2448.02, -5655.82, 420.643, 1.3439);
INSERT INTO `areatrigger_teleport` VALUES (5135, '黑锋要塞 (E.K.) 中部 -> 底部', 0, 2435.77, -5610.34, 366.82, 0.610865);
INSERT INTO `areatrigger_teleport` VALUES (5136, '黑锋要塞 (E.K.) 中部 -> 底部', 0, 2435.77, -5610.34, 366.82, 0.610865);
INSERT INTO `areatrigger_teleport` VALUES (5137, '黑锋要塞 (E.K.) 底部 -> 中部', 0, 2472.9, -5530.64, 420.643, 4.45059);
INSERT INTO `areatrigger_teleport` VALUES (5138, '黑锋要塞 (E.K.) 底部 -> 陆地', 0, 2415.16, -5733.04, 153.922, 3.64774);
INSERT INTO `areatrigger_teleport` VALUES (5148, '往事启动 出口', 1, -8756.6, -4457.02, -200.481, 1.39626);
INSERT INTO `areatrigger_teleport` VALUES (5150, '往事启动 入口', 595, 1431.1, 556.92, 36.69, 5.16);
INSERT INTO `areatrigger_teleport` VALUES (5181, '斯坦索姆的抉择 (出口)', 1, -8756.87, -4459.29, -200.73, 1.32);
INSERT INTO `areatrigger_teleport` VALUES (5191, '纳克萨玛斯 - 入口 4', 533, 3005.68, -3447.77, 293.93, 4.65);
INSERT INTO `areatrigger_teleport` VALUES (5192, '纳克萨玛斯 - 入口 2', 533, 3019.34, -3434.36, 293.99, 6.27);
INSERT INTO `areatrigger_teleport` VALUES (5193, '纳克萨玛斯 - 入口 3', 533, 3005.9, -3420.58, 294.11, 1.58);
INSERT INTO `areatrigger_teleport` VALUES (5194, '纳克萨玛斯 - 入口 1', 533, 2992.5, -3434.42, 293.94, 3.13);
INSERT INTO `areatrigger_teleport` VALUES (5196, '纳克萨玛斯 - 出口 4', 571, 3679.25, -1278.58, 243.55, 2.39);
INSERT INTO `areatrigger_teleport` VALUES (5197, '纳克萨玛斯 - 出口 2', 571, 3679.03, -1259.68, 243.55, 3.98);
INSERT INTO `areatrigger_teleport` VALUES (5198, '纳克萨玛斯 - 出口 3', 571, 3661.14, -1279.55, 243.55, 0.82);
INSERT INTO `areatrigger_teleport` VALUES (5199, '纳克萨玛斯 - 出口 1', 571, 3660.01, -1260.99, 243.55, 5.51);
INSERT INTO `areatrigger_teleport` VALUES (5205, '刚德拉克 - 入口', 604, 1891.84, 832.169, 176.669, 2.109);
INSERT INTO `areatrigger_teleport` VALUES (5206, '刚德拉克 - 入口', 604, 1894.58, 652.713, 176.666, 4.078);
INSERT INTO `areatrigger_teleport` VALUES (5209, '紫罗兰堡 - 入口', 608, 1808.82, 803.93, 44.364, 6.282);
INSERT INTO `areatrigger_teleport` VALUES (5211, '紫罗兰堡 - 出口', 571, 5680.7, 487.323, 652.418, 0.882);
INSERT INTO `areatrigger_teleport` VALUES (5213, '古王国 - 出口', 571, 3641.84, 2032.94, 2.47, 1.178);
INSERT INTO `areatrigger_teleport` VALUES (5215, '阿兹欧-奈幽: 安卡罕特:古王国 - 入口', 619, 333.351, -1109.94, 69.772, 0.553);
INSERT INTO `areatrigger_teleport` VALUES (5231, '刚德拉克 - 出口 02', 571, 6702.47, -4660.55, 441.568, 0.75);
INSERT INTO `areatrigger_teleport` VALUES (5233, '刚德拉克 - 出口 01', 571, 6970.02, -4402.09, 441.578, 3.845);
INSERT INTO `areatrigger_teleport` VALUES (5235, '安卡罕特:古王国 (出口)', 571, 3817.4, 2032.82, 11.0133, 3.61283);
INSERT INTO `areatrigger_teleport` VALUES (5241, '守护巨龙之间, 黑曜圣所 (出口)', 571, 3448, 261.545, -110.163, 0.097);
INSERT INTO `areatrigger_teleport` VALUES (5243, '守护巨龙之间, 黑曜圣所 (入口)', 615, 3228.58, 385.86, 65.549, 1.578);
INSERT INTO `areatrigger_teleport` VALUES (5246, '永恒之眼 - 入口', 578, 1055.93, 986.85, 361.07, 5.745);
INSERT INTO `areatrigger_teleport` VALUES (5258, '亚夏梵穹殿 (入口)', 624, -505.96, -103.353, 157, 0);
INSERT INTO `areatrigger_teleport` VALUES (5262, '亚夏梵穹殿 (出口)', 571, 5480.88, 2840.47, 418.68, 3.14);
INSERT INTO `areatrigger_teleport` VALUES (5273, '达拉然水井', 571, 5878.56, 666.423, 615.294, 4);
INSERT INTO `areatrigger_teleport` VALUES (5276, '刚德拉克 - 出口 03', 571, 6702.47, -4660.55, 441.568, 0.75);
INSERT INTO `areatrigger_teleport` VALUES (5277, '刚德拉克 - 出口 04', 571, 6970.02, -4402.09, 441.578, 3.845);
INSERT INTO `areatrigger_teleport` VALUES (5290, '永恒之眼 (入口)', 616, 728.055, 1329.03, 275, 5.51524);
INSERT INTO `areatrigger_teleport` VALUES (5326, '竞技场 - 达拉然竞技场 - 传送目标', 617, 1291.57, 792.965, 8.11463, 0);
INSERT INTO `areatrigger_teleport` VALUES (5328, '竞技场 - 达拉然竞技场 - 传送目标', 617, 1291.57, 792.965, 8.11463, 0);
INSERT INTO `areatrigger_teleport` VALUES (5329, '竞技场 - 达拉然竞技场 - 传送目标', 617, 1291.57, 792.965, 8.11463, 0);
INSERT INTO `areatrigger_teleport` VALUES (5330, '竞技场 - 达拉然竞技场 - 传送目标', 617, 1291.57, 792.965, 8.11463, 0);
INSERT INTO `areatrigger_teleport` VALUES (5331, '竞技场 - 达拉然竞技场 - 传送目标', 617, 1291.57, 792.965, 8.11463, 0);
INSERT INTO `areatrigger_teleport` VALUES (5379, '奥杜亚团队 入口', 603, -914.041, -148.98, 463.137, 6.28);
INSERT INTO `areatrigger_teleport` VALUES (5381, '奥杜亚团队 出口', 571, 9345.56, -1114.88, 1245.09, 3.11);
INSERT INTO `areatrigger_teleport` VALUES (5447, '竞技场 - 奥格瑞玛 - 传送目标 3', 618, 763.365, -284.29, 28.2767, 0);
INSERT INTO `areatrigger_teleport` VALUES (5503, '十字军试炼 (入口)', 649, 563.61, 80.6815, 395.2, 1.59);
INSERT INTO `areatrigger_teleport` VALUES (5505, '勇士试炼 (入口)', 650, 805.227, 618.038, 412.393, 3.1456);
INSERT INTO `areatrigger_teleport` VALUES (5508, '十字军试炼 (出口)', 571, 8515.46, 728.92, 558.3, 4.742);
INSERT INTO `areatrigger_teleport` VALUES (5510, '勇士试炼 (出口)', 571, 8577.4, 791.732, 558.235, 0);
INSERT INTO `areatrigger_teleport` VALUES (5635, '众魂熔炉 (入口)', 632, 4922.86, 2175.63, 638.734, 2.00355);
INSERT INTO `areatrigger_teleport` VALUES (5636, '倒影大厅 (入口)', 668, 5239.01, 1932.64, 707.695, 0.800565);
INSERT INTO `areatrigger_teleport` VALUES (5637, '萨伦之渊 (入口)', 658, 435.743, 212.413, 528.709, 6.25646);
INSERT INTO `areatrigger_teleport` VALUES (5642, '众魂熔炉 (出口)', 571, 5667.72, 2007.19, 798.042, 2.31535);
INSERT INTO `areatrigger_teleport` VALUES (5643, '萨伦之渊 (出口)', 571, 5595.92, 2013.02, 798.041, 0.648728);
INSERT INTO `areatrigger_teleport` VALUES (5646, '倒影大厅 (出口)', 571, 5630.59, 1997.55, 798.049, 1.44042);
INSERT INTO `areatrigger_teleport` VALUES (5668, '寒冰皇冠城塞 (出口)', 571, 5790, 2071.48, 636.065, 0.459897);
INSERT INTO `areatrigger_teleport` VALUES (5670, '寒冰皇冠城塞 (入口)', 631, 76.8638, 2211.37, 30, 3.14965);
INSERT INTO `areatrigger_teleport` VALUES (5683, '萨伦之渊 (出口) 倒影大厅 (入口)', 571, 5595.92, 2013.02, 798.041, 0.648728);
INSERT INTO `areatrigger_teleport` VALUES (5688, '众魂熔炉 (出口) 萨伦之渊 (入口)', 571, 5667.72, 2007.19, 798.042, 2.31535);
INSERT INTO `areatrigger_teleport` VALUES (5869, '红玉圣殿 (入口)', 724, 3274, 533.531, 87.665, 3.16);
INSERT INTO `areatrigger_teleport` VALUES (5872, '红玉圣殿 (出口)', 571, 3604.23, 192.083, -110.821, 2.195);

SET FOREIGN_KEY_CHECKS = 1;
