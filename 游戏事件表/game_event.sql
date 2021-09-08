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

 Date: 30/03/2021 11:16:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for game_event
-- ----------------------------
DROP TABLE IF EXISTS `game_event`;
CREATE TABLE `game_event`  (
  `eventEntry` tinyint UNSIGNED NOT NULL COMMENT 'Entry of the game event',
  `start_time` timestamp NULL DEFAULT '2000-01-01 07:00:00' COMMENT 'Absolute start date, the event will never start before',
  `end_time` timestamp NULL DEFAULT '2000-01-01 07:00:00' COMMENT 'Absolute end date, the event will never start after',
  `occurence` bigint UNSIGNED NOT NULL DEFAULT 5184000 COMMENT 'Delay in minutes between occurences of the event',
  `length` bigint UNSIGNED NOT NULL DEFAULT 2592000 COMMENT 'Length in minutes of the event',
  `holiday` mediumint UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Client side holiday id',
  `holidayStage` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Description of the event displayed in console',
  `world_event` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 if normal event, 1 if world event',
  `announce` tinyint UNSIGNED NOT NULL DEFAULT 2 COMMENT '0 dont announce, 1 announce, 2 value from config',
  PRIMARY KEY (`eventEntry`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of game_event
-- ----------------------------
INSERT INTO `game_event` VALUES (1, '2014-06-22 06:01:00', '2030-12-31 13:00:00', 525600, 20160, 341, 1, '仲夏焰火节', 0, 2);
INSERT INTO `game_event` VALUES (2, '2015-12-16 08:00:00', '2030-12-31 13:00:00', 525600, 25920, 141, 1, '冬幕节', 0, 2);
INSERT INTO `game_event` VALUES (3, '2020-01-05 07:01:00', '2030-12-31 13:00:00', 131040, 10079, 376, 2, '暗月马戏团（泰罗卡森林）', 0, 2);
INSERT INTO `game_event` VALUES (4, '2014-09-07 07:01:00', '2030-12-31 13:00:00', 131040, 10079, 374, 2, '暗月马戏团（艾尔文森林）', 0, 2);
INSERT INTO `game_event` VALUES (5, '2014-10-05 07:01:00', '2030-12-31 13:00:00', 131040, 10079, 375, 2, '暗月马戏团（莫高雷）', 0, 2);
INSERT INTO `game_event` VALUES (6, '2010-01-01 14:00:00', '2030-12-31 13:00:00', 525600, 120, 0, 0, '除夕', 0, 2);
INSERT INTO `game_event` VALUES (7, '2020-01-24 07:01:00', '2030-12-31 13:00:00', 525600, 20160, 327, 1, '春节', 0, 2);
INSERT INTO `game_event` VALUES (8, '2020-02-08 07:01:00', '2030-12-31 13:00:00', 525600, 20160, 423, 1, '爱意弥漫的天空', 0, 2);
INSERT INTO `game_event` VALUES (9, '2020-04-13 06:01:00', '2030-12-31 13:00:00', 525600, 10080, 181, 1, '贵族花园', 0, 2);
INSERT INTO `game_event` VALUES (10, '2020-05-01 06:01:00', '2030-12-31 13:00:00', 525600, 10080, 201, 1, '儿童周', 0, 2);
INSERT INTO `game_event` VALUES (11, '2020-09-29 06:01:00', '2030-12-31 13:00:00', 525600, 10080, 321, 1, '收获节', 0, 2);
INSERT INTO `game_event` VALUES (12, '2014-10-19 06:00:00', '2030-12-31 13:00:00', 525600, 20160, 324, 1, '万圣节', 0, 2);
INSERT INTO `game_event` VALUES (13, '2000-01-01 15:00:00', '2000-01-01 15:00:00', 525600, 1, 0, 0, '元素生物入侵', 0, 2);
INSERT INTO `game_event` VALUES (14, '2016-10-29 01:00:00', '2030-12-31 07:00:00', 10080, 1440, 0, 0, '荆棘谷激情钓鱼会', 0, 2);
INSERT INTO `game_event` VALUES (15, '2016-10-30 15:00:00', '2030-12-31 07:00:00', 10080, 120, 301, 0, '荆棘谷钓鱼大赛VIP', 0, 2);
INSERT INTO `game_event` VALUES (16, '2007-08-05 11:00:00', '2030-12-31 13:00:00', 180, 120, 0, 0, '古拉巴什竞技场战斗', 0, 2);
INSERT INTO `game_event` VALUES (17, '2000-01-01 15:00:00', '2000-01-01 15:00:00', 525600, 1, 0, 0, '天灾入侵', 0, 2);
INSERT INTO `game_event` VALUES (18, '2010-05-07 14:00:00', '2030-12-31 13:00:00', 60480, 6240, 283, 1, '战斗的召唤：奥特兰克山谷!', 0, 2);
INSERT INTO `game_event` VALUES (19, '2010-04-02 14:00:00', '2030-12-31 13:00:00', 60480, 6240, 284, 1, '战斗的召唤：战歌峡谷!', 0, 2);
INSERT INTO `game_event` VALUES (20, '2010-04-23 14:00:00', '2030-12-31 13:00:00', 60480, 6240, 285, 1, '战斗的召唤：阿拉希盆地!', 0, 2);
INSERT INTO `game_event` VALUES (21, '2010-04-30 14:00:00', '2030-12-31 13:00:00', 60480, 6240, 353, 1, '战斗的召唤：风暴之眼!', 0, 2);
INSERT INTO `game_event` VALUES (22, '2000-01-01 15:00:00', '2000-01-01 15:00:00', 525600, 1, 0, 0, '安其拉之战', 0, 2);
INSERT INTO `game_event` VALUES (23, '2014-09-04 07:01:00', '2030-12-31 13:00:00', 131040, 4320, 374, 1, '暗月马戏团建立（艾尔文森林）', 0, 2);
INSERT INTO `game_event` VALUES (24, '2017-09-20 07:01:00', '2030-12-31 14:00:00', 525600, 21600, 372, 2, '美酒节', 0, 2);
INSERT INTO `game_event` VALUES (25, '2015-07-30 03:00:00', '2030-12-31 13:00:00', 1440, 480, 0, 0, '夜幕', 0, 2);
INSERT INTO `game_event` VALUES (26, '2020-11-23 08:00:00', '2030-12-31 13:00:00', 525600, 10080, 404, 1, '旅人丰年祭', 0, 2);
INSERT INTO `game_event` VALUES (27, '2008-03-24 13:00:00', '2030-12-31 13:00:00', 86400, 21600, 0, 0, '疯狂之刃, 格里雷克', 0, 2);
INSERT INTO `game_event` VALUES (28, '2008-04-07 13:00:00', '2030-12-31 13:00:00', 86400, 21600, 0, 0, '疯狂之刃, 哈扎拉尔', 0, 2);
INSERT INTO `game_event` VALUES (29, '2008-04-21 13:00:00', '2030-12-31 13:00:00', 86400, 21600, 0, 0, '疯狂之刃, 雷纳塔基', 0, 2);
INSERT INTO `game_event` VALUES (30, '2008-05-05 13:00:00', '2030-12-31 13:00:00', 86400, 21600, 0, 0, '疯狂之刃, 乌苏雷', 0, 2);
INSERT INTO `game_event` VALUES (31, '2000-01-01 15:00:00', '2000-01-01 15:00:00', 5184000, 2592000, 0, 0, '锦标赛竞技场', 0, 2);
INSERT INTO `game_event` VALUES (32, '2008-05-16 03:00:00', '2030-12-31 13:00:00', 10080, 5, 0, 0, 'L70ETC牛头酋长乐队', 0, 2);
INSERT INTO `game_event` VALUES (33, '2011-03-22 07:10:00', '2030-12-31 13:00:00', 30, 5, 0, 0, '达拉然 - 冠军邀请', 0, 2);
INSERT INTO `game_event` VALUES (34, '2012-10-01 06:01:00', '2030-12-31 13:00:00', 525600, 44640, 0, 0, '十月的啤酒节', 0, 2);
INSERT INTO `game_event` VALUES (35, '2012-11-01 07:01:00', '2030-12-31 13:00:00', 525600, 43200, 0, 0, '十一月的啤酒节', 0, 2);
INSERT INTO `game_event` VALUES (36, '2012-12-01 07:01:00', '2030-12-31 13:00:00', 525600, 44640, 0, 0, '十二月的啤酒节', 0, 2);
INSERT INTO `game_event` VALUES (37, '2012-01-01 07:01:00', '2030-12-31 13:00:00', 525600, 44640, 0, 0, '一月的啤酒节', 0, 2);
INSERT INTO `game_event` VALUES (38, '2012-02-01 07:01:00', '2030-12-31 13:00:00', 525600, 40320, 0, 0, '二月的啤酒节', 0, 2);
INSERT INTO `game_event` VALUES (39, '2012-03-01 07:01:00', '2030-12-31 13:00:00', 525600, 44640, 0, 0, '三月的啤酒节', 0, 2);
INSERT INTO `game_event` VALUES (40, '2012-04-01 06:01:00', '2030-12-31 13:00:00', 525600, 43200, 0, 0, '四月的啤酒节', 0, 2);
INSERT INTO `game_event` VALUES (41, '2012-05-01 06:01:00', '2030-12-31 13:00:00', 525600, 44640, 0, 0, '五月的啤酒节', 0, 2);
INSERT INTO `game_event` VALUES (42, '2012-06-01 06:01:00', '2030-12-31 13:00:00', 525600, 43200, 0, 0, '六月的啤酒节', 0, 2);
INSERT INTO `game_event` VALUES (43, '2012-07-01 06:01:00', '2030-12-31 13:00:00', 525600, 44640, 0, 0, '七月的啤酒节', 0, 2);
INSERT INTO `game_event` VALUES (44, '2012-08-01 06:01:00', '2030-12-31 13:00:00', 525600, 44640, 0, 0, '八月的啤酒节', 0, 2);
INSERT INTO `game_event` VALUES (45, '2012-09-01 06:01:00', '2030-12-31 13:00:00', 525600, 44640, 0, 0, '九月的啤酒节', 0, 2);
INSERT INTO `game_event` VALUES (48, '2000-01-01 15:00:00', '2000-01-01 15:00:00', 5184000, 2592000, 0, 0, '冬握湖联盟防御战', 5, 2);
INSERT INTO `game_event` VALUES (49, '2000-01-01 15:00:00', '2000-01-01 15:00:00', 5184000, 2592000, 0, 0, '冬握湖部落防御战', 5, 2);
INSERT INTO `game_event` VALUES (50, '2013-09-19 07:01:00', '2030-12-31 13:00:00', 525600, 1440, 398, 1, '海贼日', 0, 2);
INSERT INTO `game_event` VALUES (51, '2013-11-01 09:00:00', '2030-12-31 13:00:00', 525600, 2820, 409, 1, '亡者节', 0, 2);
INSERT INTO `game_event` VALUES (52, '2015-12-25 13:00:00', '2030-12-31 13:00:00', 525600, 11700, 0, 0, '冬幕节:礼物', 0, 2);
INSERT INTO `game_event` VALUES (53, '2010-04-09 14:00:00', '2030-12-31 13:00:00', 60480, 6240, 400, 1, '战斗的召唤：远古海滩!', 0, 2);
INSERT INTO `game_event` VALUES (54, '2010-04-16 14:00:00', '2030-12-31 13:00:00', 60480, 6240, 420, 1, '战斗的召唤:征服之岛', 0, 2);
INSERT INTO `game_event` VALUES (55, '2000-01-01 15:00:00', '2000-01-01 15:00:00', 5184000, 2592000, 0, 0, '竞技场第三赛季', 0, 2);
INSERT INTO `game_event` VALUES (56, '2000-01-01 15:00:00', '2000-01-01 15:00:00', 5184000, 2592000, 0, 0, '竞技场第四赛季', 0, 2);
INSERT INTO `game_event` VALUES (57, '2000-01-01 15:00:00', '2000-01-01 15:00:00', 5184000, 2592000, 0, 0, '竞技场第五赛季', 0, 2);
INSERT INTO `game_event` VALUES (58, '2000-01-01 15:00:00', '2000-01-01 15:00:00', 5184000, 2592000, 0, 0, '竞技场第六赛季', 0, 2);
INSERT INTO `game_event` VALUES (59, '2000-01-01 15:00:00', '2000-01-01 15:00:00', 5184000, 2592000, 0, 0, '竞技场第七赛季', 0, 2);
INSERT INTO `game_event` VALUES (60, '2000-01-01 15:00:00', '2000-01-01 15:00:00', 5184000, 2592000, 0, 0, '竞技场第八赛季', 0, 2);
INSERT INTO `game_event` VALUES (61, '2010-09-07 07:00:00', '2010-10-10 07:00:00', 9999999, 47520, 0, 0, '扎拉赞的沦陷', 0, 2);
INSERT INTO `game_event` VALUES (62, '2016-10-30 15:00:00', '2030-12-31 07:00:00', 10080, 180, 0, 0, '荆棘谷钓鱼大赛', 0, 2);
INSERT INTO `game_event` VALUES (63, '2014-03-22 20:00:00', '2030-12-31 13:00:00', 10080, 180, 0, 0, '卡鲁耶克钓鱼大赛', 0, 2);
INSERT INTO `game_event` VALUES (64, '2014-03-22 21:00:00', '2030-12-31 13:00:00', 10080, 60, 424, 0, '卡鲁耶克钓鱼大赛VIP', 0, 2);
INSERT INTO `game_event` VALUES (65, '2000-01-01 15:00:00', '2030-12-31 13:00:00', 5184000, 2592000, 0, 0, '达拉然 - 冠军邀请', 5, 2);
INSERT INTO `game_event` VALUES (66, '2000-01-01 15:00:00', '2000-01-01 15:00:00', 5184000, 2592000, 0, 0, '风险湾部落防御', 5, 2);
INSERT INTO `game_event` VALUES (67, '2010-01-02 07:40:00', '2030-12-31 13:00:00', 60, 5, 0, 0, 'AT Event Trigger (Tirion Speech)', 0, 2);
INSERT INTO `game_event` VALUES (68, '2010-01-02 07:55:00', '2030-12-31 13:00:00', 60, 5, 0, 0, 'AT Event Trigger (Horde Event)', 0, 2);
INSERT INTO `game_event` VALUES (69, '2010-01-02 07:10:00', '2030-12-31 13:00:00', 60, 5, 0, 0, 'AT Event Trigger (Alliance Event)', 0, 2);
INSERT INTO `game_event` VALUES (70, '2016-09-20 07:01:00', '2030-12-31 13:00:00', 525600, 4320, 0, 0, 'Brewfest Building (Iron Forge)', 0, 2);
INSERT INTO `game_event` VALUES (71, '2013-01-06 08:01:00', '2030-12-31 13:00:00', 131040, 8639, 0, 0, 'Darkmoon Faire Building (Mulgore)', 0, 2);
INSERT INTO `game_event` VALUES (85, '2011-03-22 01:00:00', '2030-12-31 07:00:00', 5184000, 35, 0, 0, 'Stitches Event', 0, 2);
INSERT INTO `game_event` VALUES (86, '2008-01-02 11:55:00', '2030-12-31 06:00:00', 240, 15, 0, 0, 'Perry Gatner', 0, 2);

SET FOREIGN_KEY_CHECKS = 1;
