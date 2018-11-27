/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50553
 Source Host           : localhost:3306
 Source Schema         : zy-shop

 Target Server Type    : MySQL
 Target Server Version : 50553
 File Encoding         : 65001

 Date: 27/11/2018 18:56:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sp_article
-- ----------------------------
DROP TABLE IF EXISTS `sp_article`;
CREATE TABLE `sp_article`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cid` int(11) NULL DEFAULT NULL,
  `title` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `origin` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `intro` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '描述',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '1',
  `release_time` int(11) NULL DEFAULT NULL,
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sp_article
-- ----------------------------
INSERT INTO `sp_article` VALUES (1, 5, 'xxx', 'uploads\\images\\article\\20181027\\be3921321f944f9077c13ff3c2374f4d.png', 'xxx', 'xxx', 'xxx', '<img src=\"http://pro.tpshop.com\\uploads\\images\\article\\20181027\\f35af5b4b29b83d623215890404991af.png\" alt=\"undefined\">', 1, 1540634483, 1540633403, 1540634486, 456);
INSERT INTO `sp_article` VALUES (2, 7, 'xxxx', 'uploads\\images\\article\\20181027\\be3921321f944f9077c13ff3c2374f4d.png', 'xxx6', 'xxx7', 'xxx', '<img src=\"http://pro.tpshop.com\\uploads\\images\\article\\20181027\\a8176a96b206b9bff99b280e1b91c130.png\" alt=\"undefined\"><img src=\"http://pro.tpshop.com\\uploads\\images\\article\\20181027\\f35af5b4b29b83d623215890404991af.png\" alt=\"undefined\">', 2, 1539596566, 1540633494, 1540634471, NULL);

-- ----------------------------
-- Table structure for sp_article_cate
-- ----------------------------
DROP TABLE IF EXISTS `sp_article_cate`;
CREATE TABLE `sp_article_cate`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NULL DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `sort` tinyint(4) NULL DEFAULT 100,
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `status` tinyint(4) NULL DEFAULT 1,
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '文章分类' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sp_article_cate
-- ----------------------------
INSERT INTO `sp_article_cate` VALUES (3, 0, '顶级分类一', 100, '', 1, 1540623351, 1540625430, NULL);
INSERT INTO `sp_article_cate` VALUES (4, 0, '顶级分类二', 100, '', 1, 1540623578, 1540625435, NULL);
INSERT INTO `sp_article_cate` VALUES (5, 3, '分类1-1', 100, '', 1, 1540623591, 1540625387, NULL);
INSERT INTO `sp_article_cate` VALUES (7, 3, '分类1-3', 98, '', 1, 1540623600, 1540625362, NULL);

-- ----------------------------
-- Table structure for sp_s_goods
-- ----------------------------
DROP TABLE IF EXISTS `sp_s_goods`;
CREATE TABLE `sp_s_goods`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mch_id` int(11) NULL DEFAULT NULL COMMENT '商户id',
  `cid` int(11) NULL DEFAULT NULL COMMENT '商品分类',
  `bid` int(11) NULL DEFAULT NULL COMMENT '商品品牌',
  `mid` int(11) NULL DEFAULT NULL COMMENT '模型Id',
  `name` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '商品名',
  `subtitle` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '商品副标题',
  `cover_img` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '封面图',
  `status` tinyint(255) NULL DEFAULT 1,
  `sort` smallint(6) NULL DEFAULT 100,
  `intro` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '简介',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '详情',
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cid`(`cid`, `bid`, `mid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sp_s_goods
-- ----------------------------
INSERT INTO `sp_s_goods` VALUES (1, 0, 16, 3, 1, '海尔（Haier) 滚筒洗衣机全自动 ', '【冰洗盛惠 限时嗨抢】成交价仅1899元', 'uploads\\images\\normal\\20181106\\3375fb77f69a8aeb33eff79d54751ad7.jpg', 1, 100, '', '', 1541495440, 1541495440, NULL);
INSERT INTO `sp_s_goods` VALUES (2, 0, 26, 1, 5, 'A21 男装新品衬衫男秋季男士修身立领衬衣以纯色为主白色衬衫免烫衣服4731170013 特白 L', '', 'uploads\\images\\normal\\20181106\\63b01fe11c77e3c9ef80b93c7d1ed095.jpg', 1, 100, '以纯简介', '以纯商品详情', 1541495904, 1541495904, NULL);
INSERT INTO `sp_s_goods` VALUES (16, 0, 16, 3, 1, '海尔（Haier) 滚筒洗衣机全自动 ', '【冰洗盛惠 限时嗨抢】成交价仅1899元', 'uploads\\images\\normal\\20181106\\3375fb77f69a8aeb33eff79d54751ad7.jpg', 1, 100, '', '', 2018, 2018, NULL);
INSERT INTO `sp_s_goods` VALUES (17, 0, 16, 3, 1, '海尔（Haier) 滚筒洗衣机全自动 ', '【冰洗盛惠 限时嗨抢】成交价仅1899元', 'uploads\\images\\normal\\20181106\\3375fb77f69a8aeb33eff79d54751ad7.jpg', 1, 100, '', '', 1541500096, 1541500096, NULL);
INSERT INTO `sp_s_goods` VALUES (18, 0, 26, 1, 5, 'A21 男装新品衬衫男秋季男士修身立领衬衣以纯色为主白色衬衫免烫衣服4731170013 特白 L', '', 'uploads\\images\\normal\\20181106\\63b01fe11c77e3c9ef80b93c7d1ed095.jpg', 1, 100, '以纯简介', '以纯商品详情', 1541500126, 1541500126, NULL);
INSERT INTO `sp_s_goods` VALUES (19, 0, 26, 1, 5, 'A21 男装新品衬衫男秋季男士修身立领衬衣以纯色为主白色衬衫免烫衣服4731170013 特白 L', '', 'uploads\\images\\normal\\20181106\\63b01fe11c77e3c9ef80b93c7d1ed095.jpg', 1, 100, '以纯简介', '以纯商品详情', 1541500171, 1541500171, NULL);
INSERT INTO `sp_s_goods` VALUES (20, 0, 16, 3, 1, '海尔（Haier) 滚筒洗衣机全自动 ', '【冰洗盛惠 限时嗨抢】成交价仅1899元', 'uploads\\images\\normal\\20181106\\3375fb77f69a8aeb33eff79d54751ad7.jpg', 1, 100, '', '', 1541500251, 1541500251, NULL);
INSERT INTO `sp_s_goods` VALUES (21, 0, 16, 3, 1, '海尔（Haier) 滚筒洗衣机全自动 ', '【冰洗盛惠 限时嗨抢】成交价仅1899元', 'uploads\\images\\normal\\20181106\\3375fb77f69a8aeb33eff79d54751ad7.jpg', 1, 100, '', '', 1541500269, 1541500269, NULL);
INSERT INTO `sp_s_goods` VALUES (22, 0, 16, 3, 1, '海尔（Haier) 滚筒洗衣机全自动 ', '【冰洗盛惠 限时嗨抢】成交价仅1899元', 'uploads\\images\\normal\\20181106\\3375fb77f69a8aeb33eff79d54751ad7.jpg', 1, 100, '', '', 1541500285, 1541500285, NULL);
INSERT INTO `sp_s_goods` VALUES (23, 0, 16, 3, 1, '海尔（Haier) 滚筒洗衣机全自动 ', '【冰洗盛惠 限时嗨抢】成交价仅1899元', 'uploads\\images\\normal\\20181106\\3375fb77f69a8aeb33eff79d54751ad7.jpg', 1, 100, '', '', 1541500289, 1541988638, NULL);
INSERT INTO `sp_s_goods` VALUES (24, 0, 26, 1, 5, 'A21 男装新品衬衫男秋季男士修身立领衬衣以纯色为主白色衬衫免烫衣服4731170013 特白 L', '', 'uploads\\images\\normal\\20181106\\63b01fe11c77e3c9ef80b93c7d1ed095.jpg', 1, 100, '以纯简介', '以纯商品详情', 1541500308, 1541500308, NULL);
INSERT INTO `sp_s_goods` VALUES (25, 0, 16, 3, 1, '海尔（Haier) 滚筒洗衣机全自动 ', '【冰洗盛惠 限时嗨抢】成交价仅1899元', 'uploads\\images\\normal\\20181106\\3375fb77f69a8aeb33eff79d54751ad7.jpg', 1, 100, '', '', 1541500315, 1541500315, NULL);
INSERT INTO `sp_s_goods` VALUES (26, 0, 3, 0, 3, '海信（Hisense）HZ65E5A 65英寸 超高清4K HDR Unibody一体超薄 AI人工智能电视', '【价保11.11 优惠提前抢】【下方领券减500，4998元抢购】金属超薄全面屏，无缝无螺钉美背，2+32G大内存', 'uploads\\images\\normal\\20181107\\5eb94dc8745d5c5231b77cf622b03666.jpg', 1, 100, '商品简介-海信（Hisense）', '<p>商品详情-海信（Hisense）</p>', 1541572810, 1541572810, NULL);
INSERT INTO `sp_s_goods` VALUES (27, 1, 39, 7, 7, '小米8 全面屏游戏智能手机 6GB+64GB 蓝色 全网通4G 双卡双待', '【爆品】 骁龙845，红外人脸解锁，AI变焦双摄小米11.11狂欢节，热爱升级！ 选移动，享大流量，不换号购机！', 'uploads\\images\\normal\\20181113\\3f0c4ae9e9dad4a159feb0d77517c4c6.jpg', 1, 100, '【爆品】 骁龙845，红外人脸解锁，AI变焦双摄小米11.11狂欢节，热爱升级！ 选移动，享大流量，不换号购机！xxxx', '小米手机详情', 1542105670, 1542161809, NULL);
INSERT INTO `sp_s_goods` VALUES (28, 1, 39, 7, 7, '小米8 全面屏游戏智能手机 6GB+64GB 蓝色 全网通4G 双卡双待', '【爆品】 骁龙845，红外人脸解锁，AI变焦双摄小米11.11狂欢节，热爱升级！ 选移动，享大流量，不换号购机！', 'uploads\\images\\normal\\20181113\\3f0c4ae9e9dad4a159feb0d77517c4c6.jpg', 1, 100, '【爆品】 骁龙845，红外人脸解锁，AI变焦双摄小米11.11狂欢节，热爱升级！ 选移动，享大流量，不换号购机！xxxx', '小米手机详情', 1542106227, 1542161887, NULL);

-- ----------------------------
-- Table structure for sp_s_goods_attr
-- ----------------------------
DROP TABLE IF EXISTS `sp_s_goods_attr`;
CREATE TABLE `sp_s_goods_attr`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `aid` int(11) NOT NULL COMMENT '商品属性id 关联 goods_model_attr',
  `gid` int(11) NULL DEFAULT NULL COMMENT '关联商品id',
  `val` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '属性值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 715 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品属性' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sp_s_goods_attr
-- ----------------------------
INSERT INTO `sp_s_goods_attr` VALUES (1, 47, 1, '【新升级】 9KG巴式杀菌变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (2, 47, 1, '【新品】 9公斤变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (3, 47, 1, '9公斤只能变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (4, 47, 1, '【爆款】8公斤智能变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (5, 13, 1, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (6, 14, 1, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (7, 15, 1, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (8, 16, 1, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (9, 17, 1, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (10, 18, 1, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (11, 19, 1, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (12, 20, 1, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (13, 21, 1, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (14, 22, 1, '常温');
INSERT INTO `sp_s_goods_attr` VALUES (15, 23, 1, '1级');
INSERT INTO `sp_s_goods_attr` VALUES (16, 24, 1, '672*672*920');
INSERT INTO `sp_s_goods_attr` VALUES (17, 25, 1, '70');
INSERT INTO `sp_s_goods_attr` VALUES (18, 26, 1, '550*595*850');
INSERT INTO `sp_s_goods_attr` VALUES (19, 27, 1, '8');
INSERT INTO `sp_s_goods_attr` VALUES (20, 28, 1, '1200');
INSERT INTO `sp_s_goods_attr` VALUES (21, 29, 1, '混合、超快15’羊毛、衬衣、羽绒、除菌洗、超强净、筒自洁、丝绸/雪纺、大物/窗帘、内衣、童装、休闲装、烫烫净、单脱水、漂洗+脱水');
INSERT INTO `sp_s_goods_attr` VALUES (22, 30, 1, '8');
INSERT INTO `sp_s_goods_attr` VALUES (23, 31, 1, '钢板');
INSERT INTO `sp_s_goods_attr` VALUES (24, 32, 1, '1.03');
INSERT INTO `sp_s_goods_attr` VALUES (25, 33, 1, '400');
INSERT INTO `sp_s_goods_attr` VALUES (26, 34, 1, '200');
INSERT INTO `sp_s_goods_attr` VALUES (27, 35, 1, '滚筒式');
INSERT INTO `sp_s_goods_attr` VALUES (28, 36, 1, '全自动');
INSERT INTO `sp_s_goods_attr` VALUES (29, 37, 1, '银灰色');
INSERT INTO `sp_s_goods_attr` VALUES (30, 38, 1, '海尔（Haier）');
INSERT INTO `sp_s_goods_attr` VALUES (31, 39, 1, '电脑控制');
INSERT INTO `sp_s_goods_attr` VALUES (32, 40, 1, '上排水');
INSERT INTO `sp_s_goods_attr` VALUES (33, 41, 1, '前门式');
INSERT INTO `sp_s_goods_attr` VALUES (34, 42, 1, 'LED数码显示屏');
INSERT INTO `sp_s_goods_attr` VALUES (35, 43, 1, '变频机电');
INSERT INTO `sp_s_goods_attr` VALUES (36, 44, 1, 'XXXXXXX');
INSERT INTO `sp_s_goods_attr` VALUES (37, 45, 1, 'BLDC变频静音电机、双喷淋泡沫0残留');
INSERT INTO `sp_s_goods_attr` VALUES (38, 49, 2, 'M');
INSERT INTO `sp_s_goods_attr` VALUES (39, 49, 2, 'S');
INSERT INTO `sp_s_goods_attr` VALUES (40, 49, 2, 'L');
INSERT INTO `sp_s_goods_attr` VALUES (41, 49, 2, 'XL');
INSERT INTO `sp_s_goods_attr` VALUES (42, 49, 2, 'XXXL');
INSERT INTO `sp_s_goods_attr` VALUES (43, 49, 2, 'XXL');
INSERT INTO `sp_s_goods_attr` VALUES (44, 1, 2, '');
INSERT INTO `sp_s_goods_attr` VALUES (45, 2, 2, '');
INSERT INTO `sp_s_goods_attr` VALUES (46, 3, 2, '青春流行');
INSERT INTO `sp_s_goods_attr` VALUES (47, 4, 2, '');
INSERT INTO `sp_s_goods_attr` VALUES (48, 5, 2, '');
INSERT INTO `sp_s_goods_attr` VALUES (49, 6, 2, '青年');
INSERT INTO `sp_s_goods_attr` VALUES (50, 7, 2, '长袖');
INSERT INTO `sp_s_goods_attr` VALUES (51, 8, 2, '纽扣装饰');
INSERT INTO `sp_s_goods_attr` VALUES (52, 9, 2, '扣领尖领');
INSERT INTO `sp_s_goods_attr` VALUES (53, 10, 2, '棉');
INSERT INTO `sp_s_goods_attr` VALUES (54, 11, 2, '2017秋季');
INSERT INTO `sp_s_goods_attr` VALUES (55, 12, 2, '修身型');
INSERT INTO `sp_s_goods_attr` VALUES (241, 47, 16, '【新升级】 9KG巴式杀菌变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (242, 47, 16, '【新品】 9公斤变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (243, 47, 16, '9公斤只能变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (244, 47, 16, '【爆款】8公斤智能变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (245, 13, 16, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (246, 14, 16, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (247, 15, 16, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (248, 16, 16, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (249, 17, 16, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (250, 18, 16, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (251, 19, 16, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (252, 20, 16, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (253, 21, 16, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (254, 22, 16, '常温');
INSERT INTO `sp_s_goods_attr` VALUES (255, 23, 16, '1级');
INSERT INTO `sp_s_goods_attr` VALUES (256, 24, 16, '672*672*920');
INSERT INTO `sp_s_goods_attr` VALUES (257, 25, 16, '70');
INSERT INTO `sp_s_goods_attr` VALUES (258, 26, 16, '550*595*850');
INSERT INTO `sp_s_goods_attr` VALUES (259, 27, 16, '8');
INSERT INTO `sp_s_goods_attr` VALUES (260, 28, 16, '1200');
INSERT INTO `sp_s_goods_attr` VALUES (261, 29, 16, '混合、超快15’羊毛、衬衣、羽绒、除菌洗、超强净、筒自洁、丝绸/雪纺、大物/窗帘、内衣、童装、休闲装、烫烫净、单脱水、漂洗+脱水');
INSERT INTO `sp_s_goods_attr` VALUES (262, 30, 16, '8');
INSERT INTO `sp_s_goods_attr` VALUES (263, 31, 16, '钢板');
INSERT INTO `sp_s_goods_attr` VALUES (264, 32, 16, '1.03');
INSERT INTO `sp_s_goods_attr` VALUES (265, 33, 16, '400');
INSERT INTO `sp_s_goods_attr` VALUES (266, 34, 16, '200');
INSERT INTO `sp_s_goods_attr` VALUES (267, 35, 16, '滚筒式');
INSERT INTO `sp_s_goods_attr` VALUES (268, 36, 16, '全自动');
INSERT INTO `sp_s_goods_attr` VALUES (269, 37, 16, '银灰色');
INSERT INTO `sp_s_goods_attr` VALUES (270, 38, 16, '海尔（Haier）');
INSERT INTO `sp_s_goods_attr` VALUES (271, 39, 16, '电脑控制');
INSERT INTO `sp_s_goods_attr` VALUES (272, 40, 16, '上排水');
INSERT INTO `sp_s_goods_attr` VALUES (273, 41, 16, '前门式');
INSERT INTO `sp_s_goods_attr` VALUES (274, 42, 16, 'LED数码显示屏');
INSERT INTO `sp_s_goods_attr` VALUES (275, 43, 16, '变频机电');
INSERT INTO `sp_s_goods_attr` VALUES (276, 44, 16, 'XXXXXXX');
INSERT INTO `sp_s_goods_attr` VALUES (277, 45, 16, 'BLDC变频静音电机、双喷淋泡沫0残留');
INSERT INTO `sp_s_goods_attr` VALUES (278, 47, 17, '【新升级】 9KG巴式杀菌变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (279, 47, 17, '【新品】 9公斤变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (280, 47, 17, '9公斤只能变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (281, 47, 17, '【爆款】8公斤智能变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (282, 13, 17, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (283, 14, 17, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (284, 15, 17, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (285, 16, 17, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (286, 17, 17, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (287, 18, 17, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (288, 19, 17, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (289, 20, 17, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (290, 21, 17, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (291, 22, 17, '常温');
INSERT INTO `sp_s_goods_attr` VALUES (292, 23, 17, '1级');
INSERT INTO `sp_s_goods_attr` VALUES (293, 24, 17, '672*672*920');
INSERT INTO `sp_s_goods_attr` VALUES (294, 25, 17, '70');
INSERT INTO `sp_s_goods_attr` VALUES (295, 26, 17, '550*595*850');
INSERT INTO `sp_s_goods_attr` VALUES (296, 27, 17, '8');
INSERT INTO `sp_s_goods_attr` VALUES (297, 28, 17, '1200');
INSERT INTO `sp_s_goods_attr` VALUES (298, 29, 17, '混合、超快15’羊毛、衬衣、羽绒、除菌洗、超强净、筒自洁、丝绸/雪纺、大物/窗帘、内衣、童装、休闲装、烫烫净、单脱水、漂洗+脱水');
INSERT INTO `sp_s_goods_attr` VALUES (299, 30, 17, '8');
INSERT INTO `sp_s_goods_attr` VALUES (300, 31, 17, '钢板');
INSERT INTO `sp_s_goods_attr` VALUES (301, 32, 17, '1.03');
INSERT INTO `sp_s_goods_attr` VALUES (302, 33, 17, '400');
INSERT INTO `sp_s_goods_attr` VALUES (303, 34, 17, '200');
INSERT INTO `sp_s_goods_attr` VALUES (304, 35, 17, '滚筒式');
INSERT INTO `sp_s_goods_attr` VALUES (305, 36, 17, '全自动');
INSERT INTO `sp_s_goods_attr` VALUES (306, 37, 17, '银灰色');
INSERT INTO `sp_s_goods_attr` VALUES (307, 38, 17, '海尔（Haier）');
INSERT INTO `sp_s_goods_attr` VALUES (308, 39, 17, '电脑控制');
INSERT INTO `sp_s_goods_attr` VALUES (309, 40, 17, '上排水');
INSERT INTO `sp_s_goods_attr` VALUES (310, 41, 17, '前门式');
INSERT INTO `sp_s_goods_attr` VALUES (311, 42, 17, 'LED数码显示屏');
INSERT INTO `sp_s_goods_attr` VALUES (312, 43, 17, '变频机电');
INSERT INTO `sp_s_goods_attr` VALUES (313, 44, 17, 'XXXXXXX');
INSERT INTO `sp_s_goods_attr` VALUES (314, 45, 17, 'BLDC变频静音电机、双喷淋泡沫0残留');
INSERT INTO `sp_s_goods_attr` VALUES (315, 49, 18, 'M');
INSERT INTO `sp_s_goods_attr` VALUES (316, 49, 18, 'S');
INSERT INTO `sp_s_goods_attr` VALUES (317, 49, 18, 'L');
INSERT INTO `sp_s_goods_attr` VALUES (318, 49, 18, 'XL');
INSERT INTO `sp_s_goods_attr` VALUES (319, 49, 18, 'XXXL');
INSERT INTO `sp_s_goods_attr` VALUES (320, 49, 18, 'XXL');
INSERT INTO `sp_s_goods_attr` VALUES (321, 1, 18, '');
INSERT INTO `sp_s_goods_attr` VALUES (322, 2, 18, '');
INSERT INTO `sp_s_goods_attr` VALUES (323, 3, 18, '青春流行');
INSERT INTO `sp_s_goods_attr` VALUES (324, 4, 18, '');
INSERT INTO `sp_s_goods_attr` VALUES (325, 5, 18, '');
INSERT INTO `sp_s_goods_attr` VALUES (326, 6, 18, '青年');
INSERT INTO `sp_s_goods_attr` VALUES (327, 7, 18, '长袖');
INSERT INTO `sp_s_goods_attr` VALUES (328, 8, 18, '纽扣装饰');
INSERT INTO `sp_s_goods_attr` VALUES (329, 9, 18, '扣领尖领');
INSERT INTO `sp_s_goods_attr` VALUES (330, 10, 18, '棉');
INSERT INTO `sp_s_goods_attr` VALUES (331, 11, 18, '2017秋季');
INSERT INTO `sp_s_goods_attr` VALUES (332, 12, 18, '修身型');
INSERT INTO `sp_s_goods_attr` VALUES (333, 49, 19, 'M');
INSERT INTO `sp_s_goods_attr` VALUES (334, 49, 19, 'S');
INSERT INTO `sp_s_goods_attr` VALUES (335, 49, 19, 'L');
INSERT INTO `sp_s_goods_attr` VALUES (336, 49, 19, 'XL');
INSERT INTO `sp_s_goods_attr` VALUES (337, 49, 19, 'XXXL');
INSERT INTO `sp_s_goods_attr` VALUES (338, 49, 19, 'XXL');
INSERT INTO `sp_s_goods_attr` VALUES (339, 1, 19, '');
INSERT INTO `sp_s_goods_attr` VALUES (340, 2, 19, '');
INSERT INTO `sp_s_goods_attr` VALUES (341, 3, 19, '青春流行');
INSERT INTO `sp_s_goods_attr` VALUES (342, 4, 19, '');
INSERT INTO `sp_s_goods_attr` VALUES (343, 5, 19, '');
INSERT INTO `sp_s_goods_attr` VALUES (344, 6, 19, '青年');
INSERT INTO `sp_s_goods_attr` VALUES (345, 7, 19, '长袖');
INSERT INTO `sp_s_goods_attr` VALUES (346, 8, 19, '纽扣装饰');
INSERT INTO `sp_s_goods_attr` VALUES (347, 9, 19, '扣领尖领');
INSERT INTO `sp_s_goods_attr` VALUES (348, 10, 19, '棉');
INSERT INTO `sp_s_goods_attr` VALUES (349, 11, 19, '2017秋季');
INSERT INTO `sp_s_goods_attr` VALUES (350, 12, 19, '修身型');
INSERT INTO `sp_s_goods_attr` VALUES (351, 47, 20, '【新升级】 9KG巴式杀菌变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (352, 47, 20, '【新品】 9公斤变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (353, 47, 20, '9公斤只能变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (354, 47, 20, '【爆款】8公斤智能变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (355, 13, 20, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (356, 14, 20, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (357, 15, 20, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (358, 16, 20, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (359, 17, 20, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (360, 18, 20, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (361, 19, 20, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (362, 20, 20, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (363, 21, 20, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (364, 22, 20, '常温');
INSERT INTO `sp_s_goods_attr` VALUES (365, 23, 20, '1级');
INSERT INTO `sp_s_goods_attr` VALUES (366, 24, 20, '672*672*920');
INSERT INTO `sp_s_goods_attr` VALUES (367, 25, 20, '70');
INSERT INTO `sp_s_goods_attr` VALUES (368, 26, 20, '550*595*850');
INSERT INTO `sp_s_goods_attr` VALUES (369, 27, 20, '8');
INSERT INTO `sp_s_goods_attr` VALUES (370, 28, 20, '1200');
INSERT INTO `sp_s_goods_attr` VALUES (371, 29, 20, '混合、超快15’羊毛、衬衣、羽绒、除菌洗、超强净、筒自洁、丝绸/雪纺、大物/窗帘、内衣、童装、休闲装、烫烫净、单脱水、漂洗+脱水');
INSERT INTO `sp_s_goods_attr` VALUES (372, 30, 20, '8');
INSERT INTO `sp_s_goods_attr` VALUES (373, 31, 20, '钢板');
INSERT INTO `sp_s_goods_attr` VALUES (374, 32, 20, '1.03');
INSERT INTO `sp_s_goods_attr` VALUES (375, 33, 20, '400');
INSERT INTO `sp_s_goods_attr` VALUES (376, 34, 20, '200');
INSERT INTO `sp_s_goods_attr` VALUES (377, 35, 20, '滚筒式');
INSERT INTO `sp_s_goods_attr` VALUES (378, 36, 20, '全自动');
INSERT INTO `sp_s_goods_attr` VALUES (379, 37, 20, '银灰色');
INSERT INTO `sp_s_goods_attr` VALUES (380, 38, 20, '海尔（Haier）');
INSERT INTO `sp_s_goods_attr` VALUES (381, 39, 20, '电脑控制');
INSERT INTO `sp_s_goods_attr` VALUES (382, 40, 20, '上排水');
INSERT INTO `sp_s_goods_attr` VALUES (383, 41, 20, '前门式');
INSERT INTO `sp_s_goods_attr` VALUES (384, 42, 20, 'LED数码显示屏');
INSERT INTO `sp_s_goods_attr` VALUES (385, 43, 20, '变频机电');
INSERT INTO `sp_s_goods_attr` VALUES (386, 44, 20, 'XXXXXXX');
INSERT INTO `sp_s_goods_attr` VALUES (387, 45, 20, 'BLDC变频静音电机、双喷淋泡沫0残留');
INSERT INTO `sp_s_goods_attr` VALUES (388, 47, 21, '【新升级】 9KG巴式杀菌变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (389, 47, 21, '【新品】 9公斤变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (390, 47, 21, '9公斤只能变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (391, 47, 21, '【爆款】8公斤智能变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (392, 13, 21, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (393, 14, 21, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (394, 15, 21, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (395, 16, 21, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (396, 17, 21, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (397, 18, 21, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (398, 19, 21, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (399, 20, 21, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (400, 21, 21, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (401, 22, 21, '常温');
INSERT INTO `sp_s_goods_attr` VALUES (402, 23, 21, '1级');
INSERT INTO `sp_s_goods_attr` VALUES (403, 24, 21, '672*672*920');
INSERT INTO `sp_s_goods_attr` VALUES (404, 25, 21, '70');
INSERT INTO `sp_s_goods_attr` VALUES (405, 26, 21, '550*595*850');
INSERT INTO `sp_s_goods_attr` VALUES (406, 27, 21, '8');
INSERT INTO `sp_s_goods_attr` VALUES (407, 28, 21, '1200');
INSERT INTO `sp_s_goods_attr` VALUES (408, 29, 21, '混合、超快15’羊毛、衬衣、羽绒、除菌洗、超强净、筒自洁、丝绸/雪纺、大物/窗帘、内衣、童装、休闲装、烫烫净、单脱水、漂洗+脱水');
INSERT INTO `sp_s_goods_attr` VALUES (409, 30, 21, '8');
INSERT INTO `sp_s_goods_attr` VALUES (410, 31, 21, '钢板');
INSERT INTO `sp_s_goods_attr` VALUES (411, 32, 21, '1.03');
INSERT INTO `sp_s_goods_attr` VALUES (412, 33, 21, '400');
INSERT INTO `sp_s_goods_attr` VALUES (413, 34, 21, '200');
INSERT INTO `sp_s_goods_attr` VALUES (414, 35, 21, '滚筒式');
INSERT INTO `sp_s_goods_attr` VALUES (415, 36, 21, '全自动');
INSERT INTO `sp_s_goods_attr` VALUES (416, 37, 21, '银灰色');
INSERT INTO `sp_s_goods_attr` VALUES (417, 38, 21, '海尔（Haier）');
INSERT INTO `sp_s_goods_attr` VALUES (418, 39, 21, '电脑控制');
INSERT INTO `sp_s_goods_attr` VALUES (419, 40, 21, '上排水');
INSERT INTO `sp_s_goods_attr` VALUES (420, 41, 21, '前门式');
INSERT INTO `sp_s_goods_attr` VALUES (421, 42, 21, 'LED数码显示屏');
INSERT INTO `sp_s_goods_attr` VALUES (422, 43, 21, '变频机电');
INSERT INTO `sp_s_goods_attr` VALUES (423, 44, 21, 'XXXXXXX');
INSERT INTO `sp_s_goods_attr` VALUES (424, 45, 21, 'BLDC变频静音电机、双喷淋泡沫0残留');
INSERT INTO `sp_s_goods_attr` VALUES (425, 47, 22, '【新升级】 9KG巴式杀菌变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (426, 47, 22, '【新品】 9公斤变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (427, 47, 22, '9公斤只能变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (428, 47, 22, '【爆款】8公斤智能变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (429, 13, 22, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (430, 14, 22, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (431, 15, 22, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (432, 16, 22, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (433, 17, 22, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (434, 18, 22, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (435, 19, 22, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (436, 20, 22, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (437, 21, 22, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (438, 22, 22, '常温');
INSERT INTO `sp_s_goods_attr` VALUES (439, 23, 22, '1级');
INSERT INTO `sp_s_goods_attr` VALUES (440, 24, 22, '672*672*920');
INSERT INTO `sp_s_goods_attr` VALUES (441, 25, 22, '70');
INSERT INTO `sp_s_goods_attr` VALUES (442, 26, 22, '550*595*850');
INSERT INTO `sp_s_goods_attr` VALUES (443, 27, 22, '8');
INSERT INTO `sp_s_goods_attr` VALUES (444, 28, 22, '1200');
INSERT INTO `sp_s_goods_attr` VALUES (445, 29, 22, '混合、超快15’羊毛、衬衣、羽绒、除菌洗、超强净、筒自洁、丝绸/雪纺、大物/窗帘、内衣、童装、休闲装、烫烫净、单脱水、漂洗+脱水');
INSERT INTO `sp_s_goods_attr` VALUES (446, 30, 22, '8');
INSERT INTO `sp_s_goods_attr` VALUES (447, 31, 22, '钢板');
INSERT INTO `sp_s_goods_attr` VALUES (448, 32, 22, '1.03');
INSERT INTO `sp_s_goods_attr` VALUES (449, 33, 22, '400');
INSERT INTO `sp_s_goods_attr` VALUES (450, 34, 22, '200');
INSERT INTO `sp_s_goods_attr` VALUES (451, 35, 22, '滚筒式');
INSERT INTO `sp_s_goods_attr` VALUES (452, 36, 22, '全自动');
INSERT INTO `sp_s_goods_attr` VALUES (453, 37, 22, '银灰色');
INSERT INTO `sp_s_goods_attr` VALUES (454, 38, 22, '海尔（Haier）');
INSERT INTO `sp_s_goods_attr` VALUES (455, 39, 22, '电脑控制');
INSERT INTO `sp_s_goods_attr` VALUES (456, 40, 22, '上排水');
INSERT INTO `sp_s_goods_attr` VALUES (457, 41, 22, '前门式');
INSERT INTO `sp_s_goods_attr` VALUES (458, 42, 22, 'LED数码显示屏');
INSERT INTO `sp_s_goods_attr` VALUES (459, 43, 22, '变频机电');
INSERT INTO `sp_s_goods_attr` VALUES (460, 44, 22, 'XXXXXXX');
INSERT INTO `sp_s_goods_attr` VALUES (461, 45, 22, 'BLDC变频静音电机、双喷淋泡沫0残留');
INSERT INTO `sp_s_goods_attr` VALUES (462, 47, 23, '【新升级】 9KG巴式杀菌变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (463, 47, 23, '【新品】 9公斤变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (464, 47, 23, '9公斤只能变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (465, 47, 23, '【爆款】8公斤智能变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (466, 13, 23, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (467, 14, 23, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (468, 15, 23, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (469, 16, 23, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (470, 17, 23, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (471, 18, 23, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (472, 19, 23, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (473, 20, 23, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (474, 21, 23, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (475, 22, 23, '常温');
INSERT INTO `sp_s_goods_attr` VALUES (476, 23, 23, '1级');
INSERT INTO `sp_s_goods_attr` VALUES (477, 24, 23, '672*672*920');
INSERT INTO `sp_s_goods_attr` VALUES (478, 25, 23, '70');
INSERT INTO `sp_s_goods_attr` VALUES (479, 26, 23, '550*595*850');
INSERT INTO `sp_s_goods_attr` VALUES (480, 27, 23, '8');
INSERT INTO `sp_s_goods_attr` VALUES (481, 28, 23, '1200');
INSERT INTO `sp_s_goods_attr` VALUES (482, 29, 23, '混合、超快15’羊毛、衬衣、羽绒、除菌洗、超强净、筒自洁、丝绸/雪纺、大物/窗帘、内衣、童装、休闲装、烫烫净、单脱水、漂洗+脱水');
INSERT INTO `sp_s_goods_attr` VALUES (483, 30, 23, '8');
INSERT INTO `sp_s_goods_attr` VALUES (484, 31, 23, '钢板');
INSERT INTO `sp_s_goods_attr` VALUES (485, 32, 23, '1.03');
INSERT INTO `sp_s_goods_attr` VALUES (486, 33, 23, '400');
INSERT INTO `sp_s_goods_attr` VALUES (487, 34, 23, '200');
INSERT INTO `sp_s_goods_attr` VALUES (488, 35, 23, '滚筒式');
INSERT INTO `sp_s_goods_attr` VALUES (489, 36, 23, '全自动');
INSERT INTO `sp_s_goods_attr` VALUES (490, 37, 23, '银灰色');
INSERT INTO `sp_s_goods_attr` VALUES (491, 38, 23, '海尔（Haier）');
INSERT INTO `sp_s_goods_attr` VALUES (492, 39, 23, '电脑控制');
INSERT INTO `sp_s_goods_attr` VALUES (493, 40, 23, '上排水');
INSERT INTO `sp_s_goods_attr` VALUES (494, 41, 23, '前门式');
INSERT INTO `sp_s_goods_attr` VALUES (495, 42, 23, 'LED数码显示屏');
INSERT INTO `sp_s_goods_attr` VALUES (496, 43, 23, '变频机电');
INSERT INTO `sp_s_goods_attr` VALUES (497, 44, 23, 'XXXXXXX');
INSERT INTO `sp_s_goods_attr` VALUES (498, 45, 23, 'BLDC变频静音电机、双喷淋泡沫0残留');
INSERT INTO `sp_s_goods_attr` VALUES (499, 49, 24, 'M');
INSERT INTO `sp_s_goods_attr` VALUES (500, 49, 24, 'S');
INSERT INTO `sp_s_goods_attr` VALUES (501, 49, 24, 'L');
INSERT INTO `sp_s_goods_attr` VALUES (502, 49, 24, 'XL');
INSERT INTO `sp_s_goods_attr` VALUES (503, 49, 24, 'XXXL');
INSERT INTO `sp_s_goods_attr` VALUES (504, 49, 24, 'XXL');
INSERT INTO `sp_s_goods_attr` VALUES (505, 1, 24, '');
INSERT INTO `sp_s_goods_attr` VALUES (506, 2, 24, '');
INSERT INTO `sp_s_goods_attr` VALUES (507, 3, 24, '青春流行');
INSERT INTO `sp_s_goods_attr` VALUES (508, 4, 24, '');
INSERT INTO `sp_s_goods_attr` VALUES (509, 5, 24, '');
INSERT INTO `sp_s_goods_attr` VALUES (510, 6, 24, '青年');
INSERT INTO `sp_s_goods_attr` VALUES (511, 7, 24, '长袖');
INSERT INTO `sp_s_goods_attr` VALUES (512, 8, 24, '纽扣装饰');
INSERT INTO `sp_s_goods_attr` VALUES (513, 9, 24, '扣领尖领');
INSERT INTO `sp_s_goods_attr` VALUES (514, 10, 24, '棉');
INSERT INTO `sp_s_goods_attr` VALUES (515, 11, 24, '2017秋季');
INSERT INTO `sp_s_goods_attr` VALUES (516, 12, 24, '修身型');
INSERT INTO `sp_s_goods_attr` VALUES (517, 47, 25, '【新升级】 9KG巴式杀菌变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (518, 47, 25, '【新品】 9公斤变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (519, 47, 25, '9公斤只能变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (520, 47, 25, '【爆款】8公斤智能变频滚筒');
INSERT INTO `sp_s_goods_attr` VALUES (521, 13, 25, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (522, 14, 25, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (523, 15, 25, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (524, 16, 25, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (525, 17, 25, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (526, 18, 25, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (527, 19, 25, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (528, 20, 25, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (529, 21, 25, '支持');
INSERT INTO `sp_s_goods_attr` VALUES (530, 22, 25, '常温');
INSERT INTO `sp_s_goods_attr` VALUES (531, 23, 25, '1级');
INSERT INTO `sp_s_goods_attr` VALUES (532, 24, 25, '672*672*920');
INSERT INTO `sp_s_goods_attr` VALUES (533, 25, 25, '70');
INSERT INTO `sp_s_goods_attr` VALUES (534, 26, 25, '550*595*850');
INSERT INTO `sp_s_goods_attr` VALUES (535, 27, 25, '8');
INSERT INTO `sp_s_goods_attr` VALUES (536, 28, 25, '1200');
INSERT INTO `sp_s_goods_attr` VALUES (537, 29, 25, '混合、超快15’羊毛、衬衣、羽绒、除菌洗、超强净、筒自洁、丝绸/雪纺、大物/窗帘、内衣、童装、休闲装、烫烫净、单脱水、漂洗+脱水');
INSERT INTO `sp_s_goods_attr` VALUES (538, 30, 25, '8');
INSERT INTO `sp_s_goods_attr` VALUES (539, 31, 25, '钢板');
INSERT INTO `sp_s_goods_attr` VALUES (540, 32, 25, '1.03');
INSERT INTO `sp_s_goods_attr` VALUES (541, 33, 25, '400');
INSERT INTO `sp_s_goods_attr` VALUES (542, 34, 25, '200');
INSERT INTO `sp_s_goods_attr` VALUES (543, 35, 25, '滚筒式');
INSERT INTO `sp_s_goods_attr` VALUES (544, 36, 25, '全自动');
INSERT INTO `sp_s_goods_attr` VALUES (545, 37, 25, '银灰色');
INSERT INTO `sp_s_goods_attr` VALUES (546, 38, 25, '海尔（Haier）');
INSERT INTO `sp_s_goods_attr` VALUES (547, 39, 25, '电脑控制');
INSERT INTO `sp_s_goods_attr` VALUES (548, 40, 25, '上排水');
INSERT INTO `sp_s_goods_attr` VALUES (549, 41, 25, '前门式');
INSERT INTO `sp_s_goods_attr` VALUES (550, 42, 25, 'LED数码显示屏');
INSERT INTO `sp_s_goods_attr` VALUES (551, 43, 25, '变频机电');
INSERT INTO `sp_s_goods_attr` VALUES (552, 44, 25, 'XXXXXXX');
INSERT INTO `sp_s_goods_attr` VALUES (553, 45, 25, 'BLDC变频静音电机、双喷淋泡沫0残留');
INSERT INTO `sp_s_goods_attr` VALUES (554, 50, 26, '银色');
INSERT INTO `sp_s_goods_attr` VALUES (555, 51, 26, '标准版');
INSERT INTO `sp_s_goods_attr` VALUES (556, 51, 26, '家庭影院版');
INSERT INTO `sp_s_goods_attr` VALUES (557, 82, 26, '55英寸4K 人工智能+HDR+超窄边框');
INSERT INTO `sp_s_goods_attr` VALUES (558, 82, 26, '65英寸4K 人工智能+HDR+超窄边框');
INSERT INTO `sp_s_goods_attr` VALUES (559, 52, 26, '180');
INSERT INTO `sp_s_goods_attr` VALUES (560, 53, 26, '0.5');
INSERT INTO `sp_s_goods_attr` VALUES (561, 54, 26, '220v');
INSERT INTO `sp_s_goods_attr` VALUES (562, 55, 26, '不支持');
INSERT INTO `sp_s_goods_attr` VALUES (563, 56, 26, '');
INSERT INTO `sp_s_goods_attr` VALUES (564, 57, 26, '金属');
INSERT INTO `sp_s_goods_attr` VALUES (565, 58, 26, '');
INSERT INTO `sp_s_goods_attr` VALUES (566, 59, 26, '');
INSERT INTO `sp_s_goods_attr` VALUES (567, 60, 26, '');
INSERT INTO `sp_s_goods_attr` VALUES (568, 61, 26, '');
INSERT INTO `sp_s_goods_attr` VALUES (569, 62, 26, '是');
INSERT INTO `sp_s_goods_attr` VALUES (570, 63, 26, '');
INSERT INTO `sp_s_goods_attr` VALUES (571, 64, 26, '');
INSERT INTO `sp_s_goods_attr` VALUES (572, 65, 26, '');
INSERT INTO `sp_s_goods_attr` VALUES (573, 66, 26, '');
INSERT INTO `sp_s_goods_attr` VALUES (574, 67, 26, '');
INSERT INTO `sp_s_goods_attr` VALUES (575, 68, 26, '');
INSERT INTO `sp_s_goods_attr` VALUES (576, 69, 26, '');
INSERT INTO `sp_s_goods_attr` VALUES (577, 70, 26, '');
INSERT INTO `sp_s_goods_attr` VALUES (578, 71, 26, '');
INSERT INTO `sp_s_goods_attr` VALUES (579, 72, 26, '');
INSERT INTO `sp_s_goods_attr` VALUES (580, 73, 26, '');
INSERT INTO `sp_s_goods_attr` VALUES (581, 74, 26, '');
INSERT INTO `sp_s_goods_attr` VALUES (582, 75, 26, '');
INSERT INTO `sp_s_goods_attr` VALUES (583, 76, 26, '');
INSERT INTO `sp_s_goods_attr` VALUES (584, 77, 26, '1');
INSERT INTO `sp_s_goods_attr` VALUES (585, 78, 26, '1');
INSERT INTO `sp_s_goods_attr` VALUES (586, 79, 26, '0');
INSERT INTO `sp_s_goods_attr` VALUES (587, 80, 26, '0');
INSERT INTO `sp_s_goods_attr` VALUES (588, 81, 26, '2');
INSERT INTO `sp_s_goods_attr` VALUES (589, 83, 27, '黑');
INSERT INTO `sp_s_goods_attr` VALUES (590, 83, 27, '白');
INSERT INTO `sp_s_goods_attr` VALUES (591, 83, 27, '金');
INSERT INTO `sp_s_goods_attr` VALUES (592, 83, 27, '蓝');
INSERT INTO `sp_s_goods_attr` VALUES (593, 84, 27, '6GB+64GB');
INSERT INTO `sp_s_goods_attr` VALUES (594, 84, 27, '6GB+128GB');
INSERT INTO `sp_s_goods_attr` VALUES (595, 84, 27, '6GB+256GB');
INSERT INTO `sp_s_goods_attr` VALUES (596, 84, 27, '8GB+128GB');
INSERT INTO `sp_s_goods_attr` VALUES (597, 86, 27, '全网通');
INSERT INTO `sp_s_goods_attr` VALUES (598, 86, 27, '移动');
INSERT INTO `sp_s_goods_attr` VALUES (599, 86, 27, '联通');
INSERT INTO `sp_s_goods_attr` VALUES (600, 86, 27, '电信');
INSERT INTO `sp_s_goods_attr` VALUES (601, 87, 27, '小米（MI）');
INSERT INTO `sp_s_goods_attr` VALUES (602, 88, 27, '小米8');
INSERT INTO `sp_s_goods_attr` VALUES (603, 89, 27, '以官网信息为准');
INSERT INTO `sp_s_goods_attr` VALUES (604, 90, 27, '2018年');
INSERT INTO `sp_s_goods_attr` VALUES (605, 91, 27, '5月');
INSERT INTO `sp_s_goods_attr` VALUES (606, 92, 27, '蓝色');
INSERT INTO `sp_s_goods_attr` VALUES (607, 93, 27, '154.9');
INSERT INTO `sp_s_goods_attr` VALUES (608, 94, 27, '74.8');
INSERT INTO `sp_s_goods_attr` VALUES (609, 95, 27, '175');
INSERT INTO `sp_s_goods_attr` VALUES (610, 96, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (611, 97, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (612, 98, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (613, 99, 27, 'Android');
INSERT INTO `sp_s_goods_attr` VALUES (614, 100, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (615, 101, 27, '骁龙（Snapdragon)');
INSERT INTO `sp_s_goods_attr` VALUES (616, 102, 27, 'Adreno 630 图形处理器 最高主频 710MHz');
INSERT INTO `sp_s_goods_attr` VALUES (617, 103, 27, '八核');
INSERT INTO `sp_s_goods_attr` VALUES (618, 104, 27, '骁龙845（SDM845）');
INSERT INTO `sp_s_goods_attr` VALUES (619, 105, 27, '双卡双待单通');
INSERT INTO `sp_s_goods_attr` VALUES (620, 106, 27, '2个');
INSERT INTO `sp_s_goods_attr` VALUES (621, 107, 27, 'Nano SIM');
INSERT INTO `sp_s_goods_attr` VALUES (622, 108, 27, '4G：移动（TD-LTE)；4G：联通(FDD-LTE)；4G：电信(FDD-LTE)；4G：联通(TD-LTE)');
INSERT INTO `sp_s_goods_attr` VALUES (623, 109, 27, '3G：移动(TD-SCDMA)；3G：联通(WCDMA)；3G：电信(CDMA2000)；2G：移动（GSM）+联通(GSM)；2G：电信(CDMA)；2G：移动联通(GSM)+电信(CDMA)');
INSERT INTO `sp_s_goods_attr` VALUES (624, 110, 27, '2G：GSM 850/900/1800/1900；2G：CDMA 800；3G：TD-SCDMA 1900/2000；3G：WCDMA 850/900/1900/2100；3G：CDMA2000；2G');
INSERT INTO `sp_s_goods_attr` VALUES (625, 111, 27, '不可同时上网，仅支持卡A上网，卡B通话。');
INSERT INTO `sp_s_goods_attr` VALUES (626, 112, 27, '64GB');
INSERT INTO `sp_s_goods_attr` VALUES (627, 113, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (628, 114, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (629, 115, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (630, 116, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (631, 117, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (632, 118, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (633, 119, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (634, 120, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (635, 121, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (636, 122, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (637, 123, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (638, 124, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (639, 125, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (640, 126, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (641, 127, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (642, 128, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (643, 129, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (644, 130, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (645, 131, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (646, 132, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (647, 133, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (648, 134, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (649, 135, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (650, 136, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (651, 137, 27, '');
INSERT INTO `sp_s_goods_attr` VALUES (652, 83, 28, '黑');
INSERT INTO `sp_s_goods_attr` VALUES (653, 83, 28, '白');
INSERT INTO `sp_s_goods_attr` VALUES (654, 83, 28, '金');
INSERT INTO `sp_s_goods_attr` VALUES (655, 83, 28, '蓝');
INSERT INTO `sp_s_goods_attr` VALUES (656, 84, 28, '6GB+64GB');
INSERT INTO `sp_s_goods_attr` VALUES (657, 84, 28, '6GB+128GB');
INSERT INTO `sp_s_goods_attr` VALUES (658, 84, 28, '6GB+256GB');
INSERT INTO `sp_s_goods_attr` VALUES (659, 84, 28, '8GB+128GB');
INSERT INTO `sp_s_goods_attr` VALUES (660, 86, 28, '全网通');
INSERT INTO `sp_s_goods_attr` VALUES (661, 86, 28, '移动');
INSERT INTO `sp_s_goods_attr` VALUES (662, 86, 28, '联通');
INSERT INTO `sp_s_goods_attr` VALUES (663, 86, 28, '电信');
INSERT INTO `sp_s_goods_attr` VALUES (664, 87, 28, '小米（MI）');
INSERT INTO `sp_s_goods_attr` VALUES (665, 88, 28, '小米8');
INSERT INTO `sp_s_goods_attr` VALUES (666, 89, 28, '以官网信息为准');
INSERT INTO `sp_s_goods_attr` VALUES (667, 90, 28, '2018年');
INSERT INTO `sp_s_goods_attr` VALUES (668, 91, 28, '5月');
INSERT INTO `sp_s_goods_attr` VALUES (669, 92, 28, '蓝色');
INSERT INTO `sp_s_goods_attr` VALUES (670, 93, 28, '154.9');
INSERT INTO `sp_s_goods_attr` VALUES (671, 94, 28, '74.8');
INSERT INTO `sp_s_goods_attr` VALUES (672, 95, 28, '175');
INSERT INTO `sp_s_goods_attr` VALUES (673, 99, 28, 'Android');
INSERT INTO `sp_s_goods_attr` VALUES (674, 101, 28, '骁龙（Snapdragon)');
INSERT INTO `sp_s_goods_attr` VALUES (675, 102, 28, 'Adreno 630 图形处理器 最高主频 710MHz');
INSERT INTO `sp_s_goods_attr` VALUES (676, 103, 28, '八核');
INSERT INTO `sp_s_goods_attr` VALUES (677, 104, 28, '骁龙845（SDM845）');
INSERT INTO `sp_s_goods_attr` VALUES (678, 105, 28, '双卡双待单通');
INSERT INTO `sp_s_goods_attr` VALUES (679, 106, 28, '2个');
INSERT INTO `sp_s_goods_attr` VALUES (680, 107, 28, 'Nano SIM');
INSERT INTO `sp_s_goods_attr` VALUES (681, 108, 28, '4G：移动（TD-LTE)；4G：联通(FDD-LTE)；4G：电信(FDD-LTE)；4G：联通(TD-LTE)');
INSERT INTO `sp_s_goods_attr` VALUES (682, 109, 28, '3G：移动(TD-SCDMA)；3G：联通(WCDMA)；3G：电信(CDMA2000)；2G：移动（GSM）+联通(GSM)；2G：电信(CDMA)；2G：移动联通(GSM)+电信(CDMA)');
INSERT INTO `sp_s_goods_attr` VALUES (683, 110, 28, '2G：GSM 850/900/1800/1900；2G：CDMA 800；3G：TD-SCDMA 1900/2000；3G：WCDMA 850/900/1900/2100；3G：CDMA2000；2G');
INSERT INTO `sp_s_goods_attr` VALUES (684, 111, 28, '不可同时上网，仅支持卡A上网，卡B通话。');
INSERT INTO `sp_s_goods_attr` VALUES (685, 112, 28, '64GB');
INSERT INTO `sp_s_goods_attr` VALUES (686, 96, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (687, 97, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (688, 98, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (689, 100, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (690, 113, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (691, 114, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (692, 115, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (693, 116, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (694, 117, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (695, 118, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (696, 119, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (697, 120, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (698, 121, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (699, 122, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (700, 123, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (701, 124, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (702, 125, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (703, 126, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (704, 127, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (705, 128, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (706, 129, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (707, 130, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (708, 131, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (709, 132, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (710, 133, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (711, 134, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (712, 135, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (713, 136, 28, '');
INSERT INTO `sp_s_goods_attr` VALUES (714, 137, 28, '');

-- ----------------------------
-- Table structure for sp_s_goods_attr_price
-- ----------------------------
DROP TABLE IF EXISTS `sp_s_goods_attr_price`;
CREATE TABLE `sp_s_goods_attr_price`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `gid` int(11) NULL DEFAULT NULL COMMENT '商品id',
  `attr_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '商品属性id(goods_attr) 用 | 分割',
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `bar_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `stock` smallint(6) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `gid`(`gid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 151 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品价格' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sp_s_goods_attr_price
-- ----------------------------
INSERT INTO `sp_s_goods_attr_price` VALUES (1, 1, '1', '7553200', '7553200', 2199.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (2, 1, '2', '6893995', '6893995', 2199.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (3, 1, '3', '5518702', '5518702', 2199.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (4, 1, '4', '2833305', '2833305', 2099.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (5, 2, '38', 'M', 'M', 139.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (6, 2, '39', 'S', 'S', 139.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (7, 2, '40', 'L', 'L', 139.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (8, 2, '41', 'XL', 'XL', 139.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (9, 2, '42', 'XXXL', 'XXXL', 139.00, 0);
INSERT INTO `sp_s_goods_attr_price` VALUES (10, 2, '43', 'XXL', 'XXL', 139.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (11, 16, '241', '7553200', '7553200', 2199.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (12, 16, '242', '6893995', '6893995', 2199.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (13, 16, '243', '5518702', '5518702', 2199.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (14, 16, '244', '2833305', '2833305', 2099.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (15, 17, '278', '7553200', '7553200', 2199.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (16, 17, '279', '6893995', '6893995', 2199.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (17, 17, '280', '5518702', '5518702', 2199.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (18, 17, '281', '2833305', '2833305', 2099.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (19, 18, '315', 'M', 'M', 139.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (20, 18, '316', 'S', 'S', 139.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (21, 18, '317', 'L', 'L', 139.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (22, 18, '318', 'XL', 'XL', 139.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (23, 18, '319', 'XXXL', 'XXXL', 139.00, 0);
INSERT INTO `sp_s_goods_attr_price` VALUES (24, 18, '320', 'XXL', 'XXL', 139.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (25, 19, '333', 'M', 'M', 139.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (26, 19, '334', 'S', 'S', 139.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (27, 19, '335', 'L', 'L', 139.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (28, 19, '336', 'XL', 'XL', 139.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (29, 19, '337', 'XXXL', 'XXXL', 139.00, 0);
INSERT INTO `sp_s_goods_attr_price` VALUES (30, 19, '338', 'XXL', 'XXL', 139.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (31, 20, '351', '7553200', '7553200', 2199.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (32, 20, '352', '6893995', '6893995', 2199.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (33, 20, '353', '5518702', '5518702', 2199.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (34, 20, '354', '2833305', '2833305', 2099.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (35, 21, '388', '7553200', '7553200', 2199.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (36, 21, '389', '6893995', '6893995', 2199.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (37, 21, '390', '5518702', '5518702', 2199.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (38, 21, '391', '2833305', '2833305', 2099.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (39, 22, '425', '7553200', '7553200', 2199.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (40, 22, '426', '6893995', '6893995', 2199.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (41, 22, '427', '5518702', '5518702', 2199.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (42, 22, '428', '2833305', '2833305', 2099.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (43, 23, '462', '7553200', '7553200', 1000.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (44, 23, '463', '6893995', '6893995', 888.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (45, 23, '464', '5518702', '5518702', 999.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (46, 23, '465', '2833305', '2833305', 666.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (47, 24, '499', 'M', 'M', 139.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (48, 24, '500', 'S', 'S', 139.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (49, 24, '501', 'L', 'L', 139.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (50, 24, '502', 'XL', 'XL', 139.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (51, 24, '503', 'XXXL', 'XXXL', 139.00, 0);
INSERT INTO `sp_s_goods_attr_price` VALUES (52, 24, '504', 'XXL', 'XXL', 139.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (53, 25, '517', '7553200', '7553200', 2199.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (54, 25, '518', '6893995', '6893995', 2199.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (55, 25, '519', '5518702', '5518702', 2199.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (56, 25, '520', '2833305', '2833305', 2099.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (57, 26, '554|555|557', '7408721', '7408721', 3988.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (58, 26, '554|555|558', '7195002', '7195002', 6988.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (59, 26, '554|556|557', '8631923', '8631923', 5667.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (60, 26, '554|556|558', '8631924', '8631924', 0.00, 0);
INSERT INTO `sp_s_goods_attr_price` VALUES (61, 27, '589|593|597', '', '', 2499.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (62, 27, '589|593|598', '', '', 2499.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (63, 27, '589|593|599', '', '', 2499.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (64, 27, '589|593|600', '', '', 2499.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (65, 27, '589|594|597', '', '', 2499.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (66, 27, '589|594|598', '', '', 2499.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (67, 27, '589|594|599', '', '', 2499.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (68, 27, '589|594|600', '', '', 2499.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (69, 27, '589|595|597', '', '', 2799.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (70, 27, '589|595|598', '', '', 2799.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (71, 27, '589|595|599', '', '', 2799.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (72, 27, '589|595|600', '', '', 2799.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (73, 27, '589|596|597', '', '', 2799.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (74, 27, '589|596|598', '', '', 2799.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (75, 27, '589|596|599', '', '', 2799.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (76, 27, '589|596|600', '', '', 2799.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (85, 27, '590|595|597', '', '', 3099.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (86, 27, '590|595|598', '', '', 3099.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (87, 27, '590|595|599', '', '', 3099.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (88, 27, '590|595|600', '', '', 3099.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (89, 27, '590|596|597', '', '', 3099.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (125, 28, '652|656|660', '', '', 2499.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (126, 28, '652|656|661', '', '', 2499.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (127, 28, '652|656|662', '', '', 2499.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (128, 28, '652|656|663', '', '', 2499.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (129, 28, '652|657|660', '', '', 2499.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (130, 28, '652|657|661', '', '', 2499.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (131, 28, '652|657|662', '', '', 2499.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (132, 28, '652|657|663', '', '', 2499.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (133, 28, '652|658|660', '', '', 2799.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (134, 28, '652|658|661', '', '', 2799.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (135, 28, '652|658|662', '', '', 2799.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (136, 28, '652|658|663', '', '', 2799.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (137, 28, '652|659|660', '', '', 2799.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (138, 28, '652|659|661', '', '', 2799.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (139, 28, '652|659|662', '', '', 2799.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (140, 28, '652|659|663', '', '', 2799.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (149, 28, '653|658|660', '', '', 3099.00, 100);
INSERT INTO `sp_s_goods_attr_price` VALUES (150, 28, '653|658|661', '', '', 3099.00, 100);

-- ----------------------------
-- Table structure for sp_s_goods_brand
-- ----------------------------
DROP TABLE IF EXISTS `sp_s_goods_brand`;
CREATE TABLE `sp_s_goods_brand`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mch_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `en` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `letter` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '缩写字母',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `intro` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `sort` tinyint(4) NULL DEFAULT 100,
  `status` tinyint(4) NULL DEFAULT 1,
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `letter`(`letter`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品品牌' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sp_s_goods_brand
-- ----------------------------
INSERT INTO `sp_s_goods_brand` VALUES (1, 0, '以纯', 'yishion', 'Y', '', '', 1, 1, 1541492026, 1541499622, 1541499622);
INSERT INTO `sp_s_goods_brand` VALUES (2, 0, '班尼路', 'baleno', 'B', '', '', 1, 1, 1541492077, 1541492077, NULL);
INSERT INTO `sp_s_goods_brand` VALUES (3, 0, '美的', 'midea', 'M', '', '', 1, 1, 1541492105, 1541492105, NULL);
INSERT INTO `sp_s_goods_brand` VALUES (4, 0, '小天鹅', 'LittleSwan', 'X', '', '', 1, 1, 1541492125, 1541492125, NULL);
INSERT INTO `sp_s_goods_brand` VALUES (5, 1, '海马', 'haima', 'H', 'uploads\\images\\goods_brand\\20181113\\b73b7780771c29cb6a20ace09c537e11.png', '', 100, 1, 1542102781, 1542102781, NULL);
INSERT INTO `sp_s_goods_brand` VALUES (6, 1, '华为', 'huawei', 'H', '', '', 100, 1, 1542104907, 1542104907, NULL);
INSERT INTO `sp_s_goods_brand` VALUES (7, 1, '小米', 'MI', 'X', '', '', 100, 1, 1542104921, 1542104921, NULL);
INSERT INTO `sp_s_goods_brand` VALUES (8, 1, '苹果', 'Apple', 'P', '', '', 100, 1, 1542104938, 1542104938, NULL);

-- ----------------------------
-- Table structure for sp_s_goods_cart
-- ----------------------------
DROP TABLE IF EXISTS `sp_s_goods_cart`;
CREATE TABLE `sp_s_goods_cart`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mch_id` int(11) NOT NULL DEFAULT 0,
  `uid` int(11) NULL DEFAULT NULL,
  `gid` int(11) NULL DEFAULT NULL,
  `attr_id` int(11) NULL DEFAULT NULL,
  `num` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uid`(`uid`, `gid`, `attr_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商店购物车' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of sp_s_goods_cart
-- ----------------------------
INSERT INTO `sp_s_goods_cart` VALUES (12, 1, 1, 28, 150, 1);
INSERT INTO `sp_s_goods_cart` VALUES (11, 1, 1, 27, 73, 1);
INSERT INTO `sp_s_goods_cart` VALUES (10, 1, 1, 27, 86, 2);
INSERT INTO `sp_s_goods_cart` VALUES (9, 1, 1, 28, 149, 1);

-- ----------------------------
-- Table structure for sp_s_goods_cate
-- ----------------------------
DROP TABLE IF EXISTS `sp_s_goods_cate`;
CREATE TABLE `sp_s_goods_cate`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mch_id` int(11) UNSIGNED NOT NULL,
  `pid` int(11) NULL DEFAULT 0,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `status` tinyint(4) NULL DEFAULT 1,
  `sort` tinyint(255) NULL DEFAULT 100,
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `mch_id`(`mch_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sp_s_goods_cate
-- ----------------------------
INSERT INTO `sp_s_goods_cate` VALUES (1, 0, 0, '家电', 1, 100, 1541491456, 1541491456, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (2, 0, 0, '服装', 1, 100, 1541491532, 1541491532, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (3, 0, 1, '电视', 1, 100, 1541491540, 1541491540, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (4, 0, 1, '空调', 1, 100, 1541491549, 1541491549, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (5, 0, 1, '洗衣机', 1, 100, 1541491556, 1541491556, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (6, 0, 1, '冰箱', 1, 100, 1541491565, 1541491565, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (7, 0, 2, '鞋子', 1, 100, 1541491613, 1541491613, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (8, 0, 2, '上衣', 1, 100, 1541491627, 1541491627, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (9, 0, 2, '下装', 1, 100, 1541491633, 1541491633, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (10, 0, 2, '头饰', 1, 100, 1541491639, 1541491639, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (11, 0, 3, '曲面电视', 1, 100, 1541491661, 1541491661, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (12, 0, 3, '超薄电视', 1, 100, 1541491697, 1541491697, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (13, 0, 4, '壁挂式空调', 1, 100, 1541491713, 1541491713, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (14, 0, 4, '柜式空调', 1, 100, 1541491722, 1541491722, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (15, 0, 4, '中央空调', 1, 100, 1541491728, 1541491728, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (16, 0, 5, '滚筒洗衣机', 1, 100, 1541491737, 1541491737, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (17, 0, 5, '洗烘一体机', 1, 100, 1541491748, 1541491748, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (18, 0, 5, '波轮洗衣机', 1, 100, 1541491758, 1541491758, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (19, 0, 6, '多门', 1, 100, 1541491765, 1541491765, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (20, 0, 6, '对开门', 1, 100, 1541491770, 1541491770, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (21, 0, 6, '三门', 1, 100, 1541491774, 1541491774, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (22, 0, 7, '运动鞋', 1, 100, 1541491805, 1541491805, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (23, 0, 7, '靴子', 1, 100, 1541491818, 1541491818, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (24, 0, 7, '皮鞋', 1, 100, 1541491823, 1541491823, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (25, 0, 7, '拖鞋', 1, 100, 1541491827, 1541491827, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (26, 0, 8, 'T恤', 1, 100, 1541491844, 1541491844, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (27, 0, 8, '衬衫', 1, 100, 1541491858, 1541491858, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (28, 0, 9, '牛仔裤', 1, 100, 1541491879, 1541491879, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (29, 0, 9, '连衣裙', 1, 100, 1541491893, 1541491893, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (30, 0, 10, '口罩', 1, 100, 1541491918, 1541491918, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (31, 0, 10, '眼睛', 1, 100, 1541491930, 1541491930, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (32, 0, 10, '帽子', 1, 100, 1541491934, 1541491934, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (34, 1, 0, 'bbb', 1, 100, 1542102179, 1542102554, 1542102554);
INSERT INTO `sp_s_goods_cate` VALUES (35, 1, 0, 'vvvv', 1, 100, 1542102287, 1542104823, 1542104823);
INSERT INTO `sp_s_goods_cate` VALUES (36, 1, 0, '手机', 1, 100, 1542104832, 1542104832, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (37, 1, 0, '服装', 1, 100, 1542104836, 1542104836, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (38, 1, 36, '华为', 1, 100, 1542105078, 1542105078, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (39, 1, 36, '小米', 1, 100, 1542105082, 1542105082, NULL);
INSERT INTO `sp_s_goods_cate` VALUES (40, 1, 36, '苹果', 1, 100, 1542105086, 1542105086, NULL);

-- ----------------------------
-- Table structure for sp_s_goods_model
-- ----------------------------
DROP TABLE IF EXISTS `sp_s_goods_model`;
CREATE TABLE `sp_s_goods_model`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mch_id` int(11) NULL DEFAULT 0,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `attr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mch_id`(`mch_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品模型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sp_s_goods_model
-- ----------------------------
INSERT INTO `sp_s_goods_model` VALUES (1, 0, '家电-洗衣机', '颜色\r\n规格\r\n特色功能\r\n主体\r\n特性', 1541492373, 1541493447, NULL);
INSERT INTO `sp_s_goods_model` VALUES (2, 0, '家电-空调', '规格\r\n功能\r\n特性', 1541492421, 1541492421, NULL);
INSERT INTO `sp_s_goods_model` VALUES (3, 0, '家电-电视', '端口参数\r\n外观设计\r\n主体参数\r\n规格参数\r\n核心参数\r\n显示参数\r\nusb支持格式\r\n功耗参数', 1541492531, 1541492531, NULL);
INSERT INTO `sp_s_goods_model` VALUES (4, 0, '家电-冰箱', '主体\r\n功能\r\n规格', 1541492581, 1541492581, NULL);
INSERT INTO `sp_s_goods_model` VALUES (5, 0, '服装-通用', '属性', 1541492774, 1541492774, NULL);
INSERT INTO `sp_s_goods_model` VALUES (6, 1, '服装', '颜色', 1542103577, 1542103577, NULL);
INSERT INTO `sp_s_goods_model` VALUES (7, 1, '手机', '主体\r\n基本信息\r\n操作系统\r\n主芯片\r\n网络支持\r\n存储\r\n屏幕\r\n前置摄像头\r\n后置摄像头\r\n电池信息\r\n数据接口\r\n手机特性\r\n辅助功能', 1542103647, 1542103647, NULL);

-- ----------------------------
-- Table structure for sp_s_goods_model_attr
-- ----------------------------
DROP TABLE IF EXISTS `sp_s_goods_model_attr`;
CREATE TABLE `sp_s_goods_model_attr`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mid` int(11) NOT NULL COMMENT '关联商品模型 id',
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `cate` tinyint(4) NULL DEFAULT 0 COMMENT '0 spu,1 sku ',
  `key` smallint(6) NULL DEFAULT 0 COMMENT '属性分组',
  `type` tinyint(4) NULL DEFAULT 0 COMMENT '0自定义 1枚举',
  `enum` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '枚举值',
  `sort` tinyint(255) NULL DEFAULT NULL,
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 138 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品模型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sp_s_goods_model_attr
-- ----------------------------
INSERT INTO `sp_s_goods_model_attr` VALUES (1, 5, '分类', 0, 0, 0, NULL, 100, 1541492861, 1541492861, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (2, 5, '适用季节', 0, 0, 0, NULL, 100, 1541492883, 1541492883, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (3, 5, '基础风格', 0, 0, 0, NULL, 100, 1541492932, 1541492932, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (4, 5, '工艺', 0, 0, 0, NULL, 100, 1541492939, 1541492939, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (5, 5, '图案', 0, 0, 0, NULL, 100, 1541492990, 1541492990, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (6, 5, '适用人群', 0, 0, 0, NULL, 100, 1541492997, 1541492997, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (7, 5, '袖长', 0, 0, 0, NULL, 100, 1541493007, 1541493007, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (8, 5, '风格', 0, 0, 0, NULL, 100, 1541493013, 1541493013, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (9, 5, '领型', 0, 0, 0, NULL, 100, 1541493040, 1541493040, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (10, 5, '主要材质', 0, 0, 0, NULL, 100, 1541493050, 1541493050, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (11, 5, '上市时间', 0, 0, 0, NULL, 100, 1541493069, 1541493069, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (12, 5, '版型', 0, 0, 0, NULL, 100, 1541493082, 1541493082, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (13, 1, '中途添衣', 0, 2, 1, '支持\r\n不支持', 100, 1541493497, 1541493497, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (14, 1, '脱水功能', 0, 2, 1, '支持\r\n不支持', 100, 1541493510, 1541493510, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (15, 1, '预约功能', 0, 2, 1, '支持\r\n不支持', 100, 1541493517, 1541493517, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (16, 1, '进水阀漏水保护', 0, 2, 1, '支持\r\n不支持', 100, 1541493529, 1541493529, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (17, 1, '排水阀漏水保护', 0, 2, 1, '支持\r\n不支持', 100, 1541493543, 1541493543, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (18, 1, '自动断电', 0, 2, 1, '支持\r\n不支持', 100, 1541493549, 1541493549, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (19, 1, '电辅加热洗涤', 0, 2, 1, '支持\r\n不支持', 100, 1541493567, 1541493567, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (20, 1, '防缠绕', 0, 2, 1, '支持\r\n不支持', 100, 1541493575, 1541493575, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (21, 1, '儿童安全锁', 0, 2, 1, '支持\r\n不支持', 100, 1541493589, 1541493589, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (22, 1, '水温调节范围', 0, 1, 1, '常温\r\n30\r\n40\r\n60\r\n90', 100, 1541493639, 1541493639, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (23, 1, '能效等级', 0, 1, 1, '1级\r\n2级', 100, 1541493663, 1541493663, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (24, 1, '包装尺寸', 0, 1, 0, NULL, 100, 1541493677, 1541493677, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (25, 1, '产品重量', 0, 1, 0, NULL, 100, 1541493685, 1541493685, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (26, 1, '产品尺寸', 0, 1, 0, NULL, 100, 1541493697, 1541493697, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (27, 1, '洗涤容量', 0, 1, 0, NULL, 100, 1541493704, 1541493704, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (28, 1, '脱水转速', 0, 1, 0, NULL, 100, 1541493713, 1541493713, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (29, 1, '洗衣程序', 0, 1, 0, NULL, 100, 1541493724, 1541493724, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (30, 1, '脱水容量', 0, 1, 0, NULL, 100, 1541493732, 1541493732, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (31, 1, '冰箱材质', 0, 1, 0, NULL, 100, 1541493742, 1541493742, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (32, 1, '洗净比', 0, 1, 0, NULL, 100, 1541493755, 1541493755, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (33, 1, '脱水功率', 0, 1, 0, NULL, 100, 1541493761, 1541493761, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (34, 1, '洗涤功率', 0, 1, 0, NULL, 100, 1541493768, 1541493768, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (35, 1, '类别', 0, 3, 0, NULL, 100, 1541493780, 1541493780, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (36, 1, '自动化程度', 0, 3, 1, '全自动\r\n半自动', 100, 1541493802, 1541493802, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (37, 1, '颜色', 0, 3, 0, NULL, 100, 1541493814, 1541493814, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (38, 1, '品牌', 0, 3, 0, NULL, 100, 1541493822, 1541493822, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (39, 1, '控制方式', 0, 3, 0, NULL, 100, 1541493834, 1541493834, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (40, 1, '排水方式', 0, 3, 0, NULL, 100, 1541493843, 1541493843, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (41, 1, '开放方式', 0, 3, 0, NULL, 100, 1541493855, 1541493855, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (42, 1, '显示方式', 0, 3, 0, NULL, 100, 1541493867, 1541493867, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (43, 1, '电机类型', 0, 3, 0, NULL, 100, 1541493877, 1541493877, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (44, 1, '型号', 0, 3, 0, NULL, 100, 1541493882, 1541493882, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (45, 1, '特性', 0, 4, 0, NULL, 100, 1541493892, 1541493892, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (46, 1, '【新升级】9KG巴式杀菌变频滚筒', 1, 0, 0, NULL, 100, 1541493989, 1541494153, 1541494153);
INSERT INTO `sp_s_goods_model_attr` VALUES (47, 1, '系列', 1, 0, 0, NULL, 100, 1541494024, 1541494259, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (48, 1, 'xx', 0, 0, 0, NULL, 100, 1541494165, 1541494174, 1541494174);
INSERT INTO `sp_s_goods_model_attr` VALUES (49, 5, '尺码', 1, 0, 0, NULL, 100, 1541495606, 1541495606, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (50, 3, '颜色', 1, 0, 1, '银色\r\n白色', 100, 1541571842, 1541571842, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (51, 3, '标准版', 1, 0, 1, '标准版\r\n家庭影院版', 100, 1541571887, 1541571887, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (52, 3, '电源功率', 0, 7, 0, NULL, 100, 1541571970, 1541571970, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (53, 3, '待机功率', 0, 7, 0, NULL, 100, 1541571975, 1541571975, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (54, 3, '工作电压', 0, 7, 0, NULL, 100, 1541572003, 1541572003, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (55, 3, '底座旋转', 0, 1, 1, '支持\r\n不支持', 100, 1541572034, 1541572034, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (56, 3, '底座配置', 0, 1, 0, NULL, 100, 1541572050, 1541572050, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (57, 3, '边框材质', 0, 1, 0, NULL, 100, 1541572061, 1541572061, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (58, 3, '边框宽窄', 0, 1, 0, NULL, 100, 1541572081, 1541572081, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (59, 3, '机身厚度', 0, 1, 0, NULL, 100, 1541572096, 1541572096, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (60, 3, '底座材料', 0, 1, 0, NULL, 100, 1541572103, 1541572103, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (61, 3, '安装孔距', 0, 1, 0, NULL, 100, 1541572115, 1541572115, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (62, 3, '曲面', 0, 1, 1, '是\r\n否', 100, 1541572129, 1541572129, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (63, 3, '含底座尺寸(宽*高*厚)mm', 0, 3, 0, NULL, 100, 1541572168, 1541572168, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (64, 3, '单屏尺寸(宽*高*厚)mm', 0, 3, 0, NULL, 100, 1541572182, 1541572182, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (65, 3, '含底座重量（KG）', 0, 3, 0, NULL, 100, 1541572206, 1541572206, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (66, 3, '单屏重量（KG）', 0, 3, 0, NULL, 100, 1541572214, 1541572214, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (67, 3, '外包装尺寸（宽*高*厚）mm', 0, 3, 0, NULL, 100, 1541572242, 1541572242, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (68, 3, '含外包装量(KG)', 0, 3, 0, NULL, 100, 1541572264, 1541572264, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (69, 3, '产品型号', 0, 2, 0, NULL, 100, 1541572277, 1541572277, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (70, 3, '产品颜色', 0, 2, 0, NULL, 100, 1541572292, 1541572292, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (71, 3, '产品类型', 0, 2, 0, NULL, 100, 1541572295, 1541572295, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (72, 3, '产品品牌', 0, 2, 0, NULL, 100, 1541572303, 1541572303, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (73, 3, '上市日期', 0, 2, 0, NULL, 100, 1541572310, 1541572310, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (74, 3, '上市能效等级', 0, 2, 0, NULL, 100, 1541572318, 1541572318, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (75, 3, '推荐观看距离', 0, 2, 0, NULL, 100, 1541572333, 1541572333, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (76, 3, '光纤音频输出', 0, 0, 1, '支持\r\n不支持', 100, 1541572358, 1541572358, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (77, 3, 'USB2.0接口', 0, 0, 0, NULL, 100, 1541572375, 1541572375, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (78, 3, 'USB3.0接口', 0, 0, 0, NULL, 100, 1541572379, 1541572379, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (79, 3, 'HDMI1.3接口', 0, 0, 0, NULL, 100, 1541572390, 1541572390, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (80, 3, 'HDMI1.4接口', 0, 0, 0, NULL, 100, 1541572393, 1541572393, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (81, 3, 'HDMI2.0接口', 0, 0, 0, NULL, 100, 1541572400, 1541572400, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (82, 3, '版本', 1, 0, 0, NULL, 100, 1541572471, 1541572471, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (83, 7, '颜色', 1, 0, 0, NULL, 100, 1542103680, 1542103680, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (84, 7, '选择版本', 1, 0, 0, NULL, 100, 1542103695, 1542103695, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (85, 7, '选择版本', 1, 0, 0, NULL, 100, 1542103868, 1542103944, 1542103944);
INSERT INTO `sp_s_goods_model_attr` VALUES (86, 7, '运营商', 1, 0, 1, '全网通\r\n移动\r\n联通\r\n电信\r\n', 100, 1542103935, 1542103935, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (87, 7, '品牌', 0, 0, 0, NULL, 100, 1542104009, 1542104009, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (88, 7, '型号', 0, 0, 0, NULL, 100, 1542104016, 1542104016, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (89, 7, '入网型号', 0, 0, 0, NULL, 100, 1542104020, 1542104020, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (90, 7, '上市年份', 0, 0, 0, NULL, 100, 1542104025, 1542104025, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (91, 7, '上市月份', 0, 0, 0, NULL, 100, 1542104030, 1542104030, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (92, 7, '机身颜色', 0, 1, 0, NULL, 100, 1542104043, 1542104043, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (93, 7, '机身长度（mm）', 0, 1, 0, NULL, 100, 1542104052, 1542104052, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (94, 7, '机身宽度（mm）', 0, 1, 0, NULL, 100, 1542104061, 1542104061, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (95, 7, '机身重量（g）', 0, 1, 0, NULL, 100, 1542104085, 1542104085, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (96, 7, '输入方式', 0, 1, 1, '触控\r\n按键\r\n其它', 100, 1542104104, 1542104104, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (97, 7, '运营商标志或内容', 0, 1, 0, NULL, 100, 1542104114, 1542104114, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (98, 7, '机身材质分类', 0, 1, 0, NULL, 100, 1542104121, 1542104121, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (99, 7, '操作系统', 0, 2, 0, NULL, 100, 1542104132, 1542104132, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (100, 7, '操作系统版本', 0, 2, 0, NULL, 100, 1542104138, 1542104138, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (101, 7, 'CPU品牌', 0, 3, 0, NULL, 100, 1542104149, 1542104149, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (102, 7, 'CPU频率', 0, 3, 0, NULL, 100, 1542104154, 1542104154, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (103, 7, 'CPU核数', 0, 3, 0, NULL, 100, 1542104159, 1542104159, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (104, 7, 'CPU型号', 0, 3, 0, NULL, 100, 1542104163, 1542104163, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (105, 7, '双卡机类型', 0, 4, 0, NULL, 100, 1542104170, 1542104170, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (106, 7, '最大支持SIM卡数量', 0, 4, 1, '1个\r\n2个', 100, 1542104182, 1542104182, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (107, 7, 'SIM卡类型', 0, 4, 0, NULL, 100, 1542104219, 1542104219, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (108, 7, '4G网络', 0, 4, 0, NULL, 100, 1542104227, 1542104227, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (109, 7, '3G/2G网络', 0, 4, 0, NULL, 100, 1542104232, 1542104232, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (110, 7, '网络频率（2G/3G）', 0, 4, 0, NULL, 100, 1542104239, 1542104239, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (111, 7, '是否支持同时使用联通卡', 0, 4, 0, NULL, 100, 1542104244, 1542104244, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (112, 7, 'ROM', 0, 5, 1, '32GB\r\n64GB\r\n128GB\r\n256GB\r\n512GB', 100, 1542104251, 1542104361, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (113, 7, 'RAM', 0, 5, 1, '2GB\r\n3GB\r\n4GB\r\n8GB', 100, 1542104471, 1542104471, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (114, 7, '最大存储扩展容量', 0, 5, 1, '128GB\r\n256GB\r\n512GB', 100, 1542104492, 1542104492, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (115, 7, '可用空间', 0, 5, 0, NULL, 100, 1542104503, 1542104503, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (116, 7, '主屏幕尺寸（英寸）', 0, 6, 0, NULL, 100, 1542104512, 1542104512, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (117, 7, '分辨率', 0, 6, 0, NULL, 100, 1542104516, 1542104516, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (118, 7, '屏幕像素密度（ppi）', 0, 6, 1, '432', 100, 1542104527, 1542104527, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (119, 7, '屏幕材质类型', 0, 6, 0, NULL, 100, 1542104540, 1542104540, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (120, 7, '摄像头数量', 0, 7, 0, NULL, 100, 1542104553, 1542104553, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (121, 7, '后置摄像头', 0, 7, 0, NULL, 100, 1542104558, 1542104558, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (122, 7, '摄像头光圈大小', 0, 7, 0, NULL, 100, 1542104562, 1542104562, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (123, 7, '拍照特点', 0, 7, 0, NULL, 100, 1542104566, 1542104566, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (124, 7, '功能备注', 0, 7, 0, NULL, 100, 1542104570, 1542104570, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (125, 7, '电池容量（mAh）', 0, 9, 0, NULL, 100, 1542104587, 1542104632, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (126, 7, '电池类型', 0, 9, 0, NULL, 100, 1542104591, 1542104648, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (127, 7, '电池是否可拆卸', 0, 9, 1, '是\r\n否', 100, 1542104595, 1542104669, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (128, 7, '充电器', 0, 9, 0, NULL, 100, 1542104600, 1542104685, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (129, 7, '数据传输接口', 0, 10, 0, NULL, 100, 1542104708, 1542104708, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (130, 7, 'NFC/NFC模式', 0, 10, 0, NULL, 100, 1542104712, 1542104712, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (131, 7, '耳机接口类型', 0, 10, 0, NULL, 100, 1542104717, 1542104717, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (132, 7, '充电接口类型', 0, 10, 0, NULL, 100, 1542104723, 1542104723, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (133, 7, '数据线', 0, 10, 1, 'USB2.0\r\nUSB3.0', 100, 1542104736, 1542104736, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (134, 7, '指纹识别', 0, 11, 1, '支持\r\n不支持', 100, 1542104753, 1542104753, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (135, 7, 'GPS', 0, 11, 1, '支持\r\n不支持', 100, 1542104760, 1542104760, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (136, 7, '陀螺仪', 0, 11, 1, '支持\r\n不支持', 100, 1542104765, 1542104765, NULL);
INSERT INTO `sp_s_goods_model_attr` VALUES (137, 7, '常用功能', 0, 12, 0, NULL, 100, 1542104775, 1542104775, NULL);

-- ----------------------------
-- Table structure for sp_s_merchant
-- ----------------------------
DROP TABLE IF EXISTS `sp_s_merchant`;
CREATE TABLE `sp_s_merchant`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(11) NULL DEFAULT NULL,
  `is_auth` tinyint(4) NULL DEFAULT NULL,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '店铺名',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '1正常 0禁用',
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sp_s_merchant
-- ----------------------------
INSERT INTO `sp_s_merchant` VALUES (1, 1, 1, '商户名', 1, NULL, NULL);

-- ----------------------------
-- Table structure for sp_s_order
-- ----------------------------
DROP TABLE IF EXISTS `sp_s_order`;
CREATE TABLE `sp_s_order`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mch_id` int(11) NOT NULL DEFAULT 0,
  `no` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `uid` int(11) NULL DEFAULT 0,
  `pay_id` int(11) NULL DEFAULT 0 COMMENT '支付方式',
  `rec_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '收货人名称',
  `rec_phone` bigint(20) NULL DEFAULT NULL COMMENT '收货人手机号',
  `rec_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '收货人邮编',
  `province` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '省',
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '市',
  `area` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '区',
  `addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '详细地址',
  `total_num` smallint(6) NULL DEFAULT 0 COMMENT '购买商品总数量',
  `total_money` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '订单实际金额',
  `pay_money` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '订单支付金额',
  `dis_money` decimal(10, 2) NULL DEFAULT NULL COMMENT '订单优惠金额',
  `freight_money` decimal(10, 2) NULL DEFAULT NULL COMMENT '订单运费',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '订单备注',
  `invoice` blob NULL COMMENT '发票信息',
  `order_status` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '0创建订单',
  `status` tinyint(4) NULL DEFAULT 0 COMMENT '0正常订单 ,1退款,2退货 3取消订单',
  `is_auth` tinyint(4) NULL DEFAULT 0 COMMENT '1已审核',
  `is_send` tinyint(4) NULL DEFAULT 0 COMMENT '1已发货  2已确认收货',
  `pay_status` tinyint(4) NULL DEFAULT 0 COMMENT '0未支付',
  `pay_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '支付信息',
  `complete_time` int(11) NULL DEFAULT NULL COMMENT '交易完成时间',
  `cancel_time` int(11) NULL DEFAULT NULL,
  `pay_time` int(11) NULL DEFAULT NULL,
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '订单表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sp_s_order
-- ----------------------------
INSERT INTO `sp_s_order` VALUES (1, 1, '2018112718330238500005', 1, 1, 'abc', 18702783600, '4536', '天津市', '天津市市辖区', '和平区', 'cccc', 1, 3099.00, 3099.00, 0.00, 0.00, 'fghdfghdfghdfgh', 0x7B22696E765F7061796565223A22E68891E79A84E58F91E7A5A8E68AACE5A4B4222C227461785F636F6465223A22E699AEE9809AE7BAB3E7A88EE4BABAE8AF86E588ABE58FB7222C2274797065223A307D, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 1543314782, 1543314782, NULL);

-- ----------------------------
-- Table structure for sp_s_order_goods
-- ----------------------------
DROP TABLE IF EXISTS `sp_s_order_goods`;
CREATE TABLE `sp_s_order_goods`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mch_id` int(11) NULL DEFAULT 0,
  `oid` int(11) NOT NULL COMMENT '订单id',
  `gid` int(11) NOT NULL COMMENT '商品id',
  `attr_id` int(11) NULL DEFAULT NULL COMMENT '商品对应属性',
  `g_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '商品名',
  `g_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '商品价格',
  `g_number` smallint(6) NULL DEFAULT NULL COMMENT '购买数量',
  `g_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '商品图片',
  `g_attr` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '商品属性',
  `total_price` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '总金额',
  `is_send` tinyint(4) NULL DEFAULT 0 COMMENT '0未发货 1已发货',
  `info` blob NULL COMMENT '购买商品时商品所有数据记录',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oid`(`oid`) USING BTREE,
  INDEX `gid`(`gid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sp_s_order_goods
-- ----------------------------
INSERT INTO `sp_s_order_goods` VALUES (1, 1, 1, 28, 150, '小米8 全面屏游戏智能手机 6GB+64GB 蓝色 全网通4G 双卡双待', 3099.00, 1, 'uploads\\images\\normal\\20181113\\3f0c4ae9e9dad4a159feb0d77517c4c6.jpg', '白\r\n6GB+256GB\r\n移动', 3099.00, 0, 0x7B226964223A32382C226D63685F6964223A312C22636964223A33392C22626964223A372C226D6964223A372C226E616D65223A22E5B08FE7B1B33820E585A8E99DA2E5B18FE6B8B8E6888FE699BAE883BDE6898BE69CBA203647422B3634474220E8939DE889B220E585A8E7BD91E9809A344720E58F8CE58DA1E58F8CE5BE85222C227375627469746C65223A22E38090E78886E59381E3809120E9AA81E9BE99383435EFBC8CE7BAA2E5A496E4BABAE884B8E8A7A3E99481EFBC8C4149E58F98E784A6E58F8CE69184E5B08FE7B1B331312E3131E78B82E6ACA2E88A82EFBC8CE783ADE788B1E58D87E7BAA7EFBC8120E98089E7A7BBE58AA8EFBC8CE4BAABE5A4A7E6B581E9878FEFBC8CE4B88DE68DA2E58FB7E8B4ADE69CBAEFBC81222C22636F7665725F696D67223A2275706C6F6164735C5C696D616765735C5C6E6F726D616C5C5C32303138313131335C5C33663063346165396539646164346131353966656230643737353137633463362E6A7067222C22737461747573223A312C22736F7274223A3130302C22696E74726F223A22E38090E78886E59381E3809120E9AA81E9BE99383435EFBC8CE7BAA2E5A496E4BABAE884B8E8A7A3E99481EFBC8C4149E58F98E784A6E58F8CE69184E5B08FE7B1B331312E3131E78B82E6ACA2E88A82EFBC8CE783ADE788B1E58D87E7BAA7EFBC8120E98089E7A7BBE58AA8EFBC8CE4BAABE5A4A7E6B581E9878FEFBC8CE4B88DE68DA2E58FB7E8B4ADE69CBAEFBC8178787878222C22636F6E74656E74223A22E5B08FE7B1B3E6898BE69CBAE8AFA6E68385222C226372656174655F74696D65223A22323031382D31312D31332031383A35303A3237222C227570646174655F74696D65223A22323031382D31312D31342031303A31383A3037222C2264656C6574655F74696D65223A6E756C6C2C226E756D626572223A2231222C22746F74616C5F7072696365223A333039392C226C696E6B5F6F6E655F7072696365223A7B226964223A3135302C22676964223A32382C22617474725F696E666F223A5B22363533222C22363538222C22363631225D2C22636F6465223A22222C226261725F636F6465223A22222C227072696365223A22333039392E3030222C2273746F636B223A3130302C22617474725F696E666F5F6E616D65223A5B22E799BD222C223647422B3235364742222C22E7A7BBE58AA8225D7D7D);

-- ----------------------------
-- Table structure for sp_s_order_reminder
-- ----------------------------
DROP TABLE IF EXISTS `sp_s_order_reminder`;
CREATE TABLE `sp_s_order_reminder`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NULL DEFAULT NULL,
  `oid` int(11) NULL DEFAULT NULL,
  `create_time` int(11) NULL DEFAULT NULL,
  `ip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oid`(`oid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '订单催单' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sp_s_user_addr
-- ----------------------------
DROP TABLE IF EXISTS `sp_s_user_addr`;
CREATE TABLE `sp_s_user_addr`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NULL DEFAULT 0,
  `rec_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `rec_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `province` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `area` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `addr` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '邮编',
  `is_default` tinyint(4) NULL DEFAULT 0,
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sp_s_user_addr
-- ----------------------------
INSERT INTO `sp_s_user_addr` VALUES (1, 0, 'x', '18702783614', '山西省', '大同市', '矿区', 'x', '', 0, 1543203413, 1543203413, NULL);
INSERT INTO `sp_s_user_addr` VALUES (2, 0, 'x', '18702783614', '山西省', '大同市', '矿区', 'x', '', 0, 1543203829, 1543203829, NULL);
INSERT INTO `sp_s_user_addr` VALUES (3, 0, 'x', '18702783614', '山西省', '大同市', '矿区', 'x', '', 0, 1543203956, 1543203956, NULL);
INSERT INTO `sp_s_user_addr` VALUES (4, 1, 'x', '18702783614', '山西省', '大同市', '矿区', 'x', '', 1, 1543203972, 1543212857, 1543212857);
INSERT INTO `sp_s_user_addr` VALUES (5, 1, 'x', '18702783614', '山西省', '大同市', '矿区', 'x234', '2134', 1, 1543203995, 1543217000, NULL);
INSERT INTO `sp_s_user_addr` VALUES (6, 1, 'xx', '18702783600', '上海市', '上海市市辖区', '虹口区', 'cccc', '4536', 1, 1543213320, 1543214538, 1543214538);
INSERT INTO `sp_s_user_addr` VALUES (7, 1, 'x', '18702783600', '天津市', '天津市市辖区', '和平区', 'cccc', '4536', 0, 1543214525, 1543214578, 1543214578);
INSERT INTO `sp_s_user_addr` VALUES (8, 1, 'abc', '18702783600', '天津市', '天津市市辖区', '和平区', 'cccc', '4536', 0, 1543307933, 1543307933, NULL);

-- ----------------------------
-- Table structure for sp_s_user_invoice
-- ----------------------------
DROP TABLE IF EXISTS `sp_s_user_invoice`;
CREATE TABLE `sp_s_user_invoice`  (
  `uid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户表ID',
  `inv_payee` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '发票抬头',
  `tax_code` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '纳税人识别号',
  `zz_company_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单位名(增值)',
  `zz_tax_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '纳税人识别号(增值)',
  `zz_address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '注册地址(增值)',
  `zz_phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '注册电话(增值)',
  `zz_bank` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '开户银行(增值)',
  `zz_bank_card` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '银行账号(增值)',
  `zz_credential` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '一般纳税人资格认定证书',
  PRIMARY KEY (`uid`) USING BTREE,
  INDEX `user_id`(`uid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单发票信息' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sp_s_user_invoice
-- ----------------------------
INSERT INTO `sp_s_user_invoice` VALUES (1, '我的发票抬头', '普通纳税人识别号', '单位名称（增值）', '纳税人识别号（增值）', '注册地址（增值）', '注册电话（增值）', '开户银行（增值）', '银行账户（增值）', 'uploads\\images\\invoice\\20181127\\903540f5ad25262f7e2db70c440ed570.png');

-- ----------------------------
-- Table structure for sp_sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sp_sys_config`;
CREATE TABLE `sp_sys_config`  (
  `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `code` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `store_range` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `store_dir` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `value` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sort` tinyint(3) UNSIGNED NOT NULL DEFAULT 100,
  `status` tinyint(4) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE,
  INDEX `parent_id`(`pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sp_sys_config
-- ----------------------------
INSERT INTO `sp_sys_config` VALUES (1, 0, 'p_t_platform', 'platform', '', '', '', 1, 1);
INSERT INTO `sp_sys_config` VALUES (2, 0, 'p_t_base', 'platform', '', '', '', 1, 1);
INSERT INTO `sp_sys_config` VALUES (3, 0, 'p_t_show', 'platform', '', '', '', 1, 1);
INSERT INTO `sp_sys_config` VALUES (4, 0, 'p_t_shopping', 'platform', '', '', '', 1, 1);
INSERT INTO `sp_sys_config` VALUES (5, 0, 'p_t_goods', 'platform', '', '', '', 1, 0);
INSERT INTO `sp_sys_config` VALUES (6, 0, 'p_t_sms', 'platform', '', '', '', 1, 1);
INSERT INTO `sp_sys_config` VALUES (7, 0, 'p_t_extra', 'platform', '', '', '', 1, 1);
INSERT INTO `sp_sys_config` VALUES (8, 1, 'p_l_shop_name', 'text', '', '', '我的商城', 1, 1);
INSERT INTO `sp_sys_config` VALUES (9, 1, 'p_l_shop_title', 'text', '', '', '店铺标题', 1, 1);
INSERT INTO `sp_sys_config` VALUES (10, 1, 'p_l_shop_intro', 'textarea', '', '', '网站描述', 1, 1);
INSERT INTO `sp_sys_config` VALUES (11, 1, 'p_l_shop_c_s', 'textarea', '', '', '客服1|11047535\r\n客服2|123456', 1, 1);
INSERT INTO `sp_sys_config` VALUES (12, 1, 'p_l_shop_tel', 'text', '', '', '0755-2686489', 1, 1);
INSERT INTO `sp_sys_config` VALUES (13, 1, 'g_state_close_app', 'radio', '1,0', '', '1', 1, 1);
INSERT INTO `sp_sys_config` VALUES (14, 1, 'p_l_shop_logo', 'file', 'logo', 'logo', 'uploads\\logo\\normal\\20181026\\a37685064e76bf6de1026e9e375979a9.png', 1, 1);
INSERT INTO `sp_sys_config` VALUES (15, 1, 'p_l_shop_n_u', 'textarea', '', '', '用户中心公告', 1, 1);
INSERT INTO `sp_sys_config` VALUES (16, 1, 'p_l_shop_n_s', 'textarea', '', '', '商店公告', 1, 1);
INSERT INTO `sp_sys_config` VALUES (17, 1, 'g_state_close_reg', 'radio', '1,0', '', '1', 1, 1);
INSERT INTO `sp_sys_config` VALUES (18, 1, 'p_l_shop_e_x_g', 'text', '', '', '21', 1, 1);
INSERT INTO `sp_sys_config` VALUES (19, 2, 'p_l_language', 'select', 'zh-cn,en-us', '', 'zh-cn', 100, 1);
INSERT INTO `sp_sys_config` VALUES (20, 2, 'p_l_icp_cert', 'text', '', '', '鄂A1354687', 100, 1);
INSERT INTO `sp_sys_config` VALUES (21, 2, 'p_l_icp_cert_file', 'file', 'icp_cert,file', '', 'uploads\\icp_cert\\normal\\20181026\\1b62cc02aceee774ba3a39c949712045.png', 100, 1);
INSERT INTO `sp_sys_config` VALUES (22, 2, 'g_state_auth_comment', 'radio', '1,0', '', '1', 100, 1);
INSERT INTO `sp_sys_config` VALUES (23, 2, 'p_l_default_good_img', 'file', 'default_good', '', 'uploads\\default_good\\normal\\20181026\\c5e982afd01809659200efdcc508d19b.png', 100, 1);
INSERT INTO `sp_sys_config` VALUES (24, 2, 'p_l_code_statistics', 'textarea', '', '', '', 100, 1);
INSERT INTO `sp_sys_config` VALUES (25, 2, 'p_l_u_reg_integral', 'number', '', '', '10', 100, 1);
INSERT INTO `sp_sys_config` VALUES (26, 2, 'p_l_file_max', 'select', '0|不限制,64|64kb,128|128kb,256|256kb,512|512kb,1024|1M,2048|2M,4096|4M', '', '4096', 100, 1);
INSERT INTO `sp_sys_config` VALUES (27, 2, 'p_l_goods_comment_condition', 'radio', '0,1,2,3', '', '3', 100, 1);
INSERT INTO `sp_sys_config` VALUES (28, 3, 'p_l_automatic_receipt', 'radio', '1,0', '', '1', 100, 1);
INSERT INTO `sp_sys_config` VALUES (29, 3, 'p_l_open_location_state', 'radio', '1,0', '', '0', 100, 1);
INSERT INTO `sp_sys_config` VALUES (30, 3, 'p_l_index_search_keyword', 'text', '', '', '移动电源,Sense,数据线,楚乔传,电源适配器', 100, 1);
INSERT INTO `sp_sys_config` VALUES (31, 4, 'p_l_state_publish', 'radio', '1,0', '', '1', 100, 1);
INSERT INTO `sp_sys_config` VALUES (32, 4, 'p_l_state_integral', 'radio', '1,0', '', '1', 100, 1);
INSERT INTO `sp_sys_config` VALUES (33, 4, 'p_l_state_money', 'radio', '1,0', '', '1', 100, 1);
INSERT INTO `sp_sys_config` VALUES (34, 4, 'p_l_publish_select', 'textarea', '', '', '不开发票\r\n明细\r\n办公用品\r\n电脑配件\r\n耗材\r\n爱7', 100, 1);
INSERT INTO `sp_sys_config` VALUES (35, 4, 'p_l_goods_reduce_stock', 'radio', '1,2', '', '2', 100, 1);
INSERT INTO `sp_sys_config` VALUES (36, 4, 'p_l_order_wait_pay_time', 'number', '', '', '30', 100, 1);
INSERT INTO `sp_sys_config` VALUES (37, 6, 'p_l_state_order_pay', 'radio', '1,0', '', '1', 100, 1);
INSERT INTO `sp_sys_config` VALUES (38, 6, 'p_l_state_order_send', 'radio', '1,0', '', '1', 100, 1);
INSERT INTO `sp_sys_config` VALUES (39, 7, 'p_l_goods_price_mode', 'radio', '1,2', '', '2', 100, 1);
INSERT INTO `sp_sys_config` VALUES (40, 7, 'p_l_goods_price_sku_mode', 'radio', '1,2', '', '2', 100, 1);
INSERT INTO `sp_sys_config` VALUES (41, 7, 'p_l_open_coupon', 'radio', '1,0', '', '1', 100, 1);
INSERT INTO `sp_sys_config` VALUES (42, 7, 'p_l_qq_map_key', 'text', '', '', 'sadfasdf', 100, 1);
INSERT INTO `sp_sys_config` VALUES (43, 7, 'p_l_express_100_key', 'text', '', '', 'asdfasdfasdf', 100, 1);

-- ----------------------------
-- Table structure for sp_sys_node
-- ----------------------------
DROP TABLE IF EXISTS `sp_sys_node`;
CREATE TABLE `sp_sys_node`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `url` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `module` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `pid` int(11) NULL DEFAULT 0,
  `status` tinyint(4) NULL DEFAULT 1,
  `actions` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `sort` tinyint(4) NULL DEFAULT 100,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sp_sys_node
-- ----------------------------
INSERT INTO `sp_sys_node` VALUES (26, '商品管理', 'Goods/index', 'shop', NULL, 13, 1, NULL, 1);
INSERT INTO `sp_sys_node` VALUES (24, '角色管理', 'System/role', 'platform', NULL, 5, 1, NULL, 3);
INSERT INTO `sp_sys_node` VALUES (23, '管理员日志', 'System/logs', 'platform', NULL, 5, 1, NULL, 2);
INSERT INTO `sp_sys_node` VALUES (22, '管理员列表', 'System/manager', 'platform', NULL, 5, 1, NULL, 1);
INSERT INTO `sp_sys_node` VALUES (20, '站内信', 'User/siteInfo', 'platform', NULL, 4, 1, NULL, 2);
INSERT INTO `sp_sys_node` VALUES (19, '会员列表', 'User/index', 'platform', NULL, 4, 1, NULL, 1);
INSERT INTO `sp_sys_node` VALUES (18, '文章列表', 'Article/index', 'platform', NULL, 3, 1, NULL, 2);
INSERT INTO `sp_sys_node` VALUES (21, '收货地址列表', 'User/address', 'platform', NULL, 4, 1, NULL, 3);
INSERT INTO `sp_sys_node` VALUES (25, '邮件模版', 'Template/mail', 'platform', NULL, 6, 1, NULL, 1);
INSERT INTO `sp_sys_node` VALUES (15, '订单', NULL, 'shop', 'fa-bar-chart-o', 0, 1, NULL, 3);
INSERT INTO `sp_sys_node` VALUES (14, '促销', NULL, 'shop', 'fa-gavel', 0, 1, NULL, 2);
INSERT INTO `sp_sys_node` VALUES (13, '商品管理', NULL, 'shop', 'fa-shopping-cart', 0, 1, NULL, 1);
INSERT INTO `sp_sys_node` VALUES (12, '用户检索', NULL, 'platform', NULL, 1, 1, NULL, 100);
INSERT INTO `sp_sys_node` VALUES (11, '验证码设置', NULL, 'platform', NULL, 1, 1, NULL, 100);
INSERT INTO `sp_sys_node` VALUES (10, '接口对接', NULL, 'platform', NULL, 1, 1, NULL, 100);
INSERT INTO `sp_sys_node` VALUES (9, '邮件服务器设置', NULL, 'platform', NULL, 1, 1, NULL, 100);
INSERT INTO `sp_sys_node` VALUES (8, '地区&配送', NULL, 'platform', NULL, 1, 1, NULL, 100);
INSERT INTO `sp_sys_node` VALUES (7, '商店设置', 'System/setting', 'platform', NULL, 1, 1, NULL, 100);
INSERT INTO `sp_sys_node` VALUES (6, '模板', NULL, 'platform', 'fa-desktop', 0, 1, NULL, 6);
INSERT INTO `sp_sys_node` VALUES (5, '权限', NULL, 'platform', 'fa-lock', 0, 1, NULL, 5);
INSERT INTO `sp_sys_node` VALUES (4, '会员', NULL, 'platform', 'fa-users', 0, 1, NULL, 4);
INSERT INTO `sp_sys_node` VALUES (17, '文章分类', 'Article/cate', 'platform', NULL, 3, 1, NULL, 1);
INSERT INTO `sp_sys_node` VALUES (16, '铺货', NULL, 'shop', 'fa-coffee', 0, 1, NULL, 4);
INSERT INTO `sp_sys_node` VALUES (3, '文章', NULL, 'platform', 'fa-pencil-square-o', 0, 1, NULL, 3);
INSERT INTO `sp_sys_node` VALUES (2, '广告', NULL, 'platform', 'fa-bullhorn', 0, 0, NULL, 2);
INSERT INTO `sp_sys_node` VALUES (1, '设置', NULL, 'platform', 'fa-cogs', 0, 1, NULL, 1);
INSERT INTO `sp_sys_node` VALUES (27, '类目管理', 'Goods/cate', 'shop', NULL, 13, 1, NULL, 2);
INSERT INTO `sp_sys_node` VALUES (28, '品牌管理', 'Goods/brand', 'shop', NULL, 13, 1, NULL, 3);
INSERT INTO `sp_sys_node` VALUES (29, '商品模型', 'Goods/model', 'shop', NULL, 13, 1, NULL, 4);
INSERT INTO `sp_sys_node` VALUES (30, '订单列表', 'Order/index', 'shop', NULL, 15, 1, NULL, 1);
INSERT INTO `sp_sys_node` VALUES (31, '退款订单', 'Order/refund', 'shop', NULL, 15, 1, NULL, 100);
INSERT INTO `sp_sys_node` VALUES (32, '退货单', 'Order/refundGoods', 'shop', NULL, 15, 1, NULL, 100);

-- ----------------------------
-- Table structure for sp_third_config
-- ----------------------------
DROP TABLE IF EXISTS `sp_third_config`;
CREATE TABLE `sp_third_config`  (
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  PRIMARY KEY (`type`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '第三方配置信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sp_third_config
-- ----------------------------
INSERT INTO `sp_third_config` VALUES ('wechat', NULL);
INSERT INTO `sp_third_config` VALUES ('alipay', NULL);

SET FOREIGN_KEY_CHECKS = 1;
