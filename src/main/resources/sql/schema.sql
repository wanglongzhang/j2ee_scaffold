/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 80011
Source Host           : localhost:3306
Source Database       : scaffold_project

Target Server Type    : MYSQL
Target Server Version : 80011
File Encoding         : 65001

Date: 2018-06-13 13:46:50
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `goods_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `title` varchar(120) NOT NULL COMMENT '商品名称',
  `state` int(11) NOT NULL COMMENT '商品状态',
  `price` float NOT NULL COMMENT '商品价格',
  `number` int(11) NOT NULL COMMENT '商品数量',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`goods_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1002 DEFAULT CHARSET=utf8 COMMENT='商品表';

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('1000', 'iphone7', '1', '3999', '99', '2018-06-13 09:31:05', '2018-06-13 09:31:05');
INSERT INTO `goods` VALUES ('1001', 'ipad3', '1', '1999', '2000', '2018-06-13 09:31:05', '2018-06-13 09:31:05');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `order_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `goods_id` bigint(20) NOT NULL COMMENT '商品ID',
  `title` varchar(120) NOT NULL COMMENT '订单名称',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`order_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_goods_id` (`goods_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8 COMMENT='订单表';

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES ('1000', '1000', '1000', '抢购iphone', '2018-06-13 09:31:14');

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '自定id,主要供前端展示权限列表分类排序使用.',
  `menu_code` varchar(255) DEFAULT '' COMMENT '归属菜单,前端判断并展示菜单使用,',
  `menu_name` varchar(255) DEFAULT '' COMMENT '菜单的中文释义',
  `permission_code` varchar(255) DEFAULT '' COMMENT '权限的代码/通配符,对应代码中@RequiresPermissions 的value',
  `permission_name` varchar(255) DEFAULT '' COMMENT '本权限的中文释义',
  `required_permission` tinyint(1) DEFAULT '2' COMMENT '是否本菜单必选权限, 1.必选 2非必选 通常是"列表"权限是必选',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='后台权限表';

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES ('101', 'article', '文章管理', 'article:list', '列表', '1');
INSERT INTO `permission` VALUES ('102', 'article', '文章管理', 'article:add', '新增', '2');
INSERT INTO `permission` VALUES ('103', 'article', '文章管理', 'article:update', '修改', '2');
INSERT INTO `permission` VALUES ('601', 'user', '用户', 'user:list', '列表', '1');
INSERT INTO `permission` VALUES ('602', 'user', '用户', 'user:add', '新增', '2');
INSERT INTO `permission` VALUES ('603', 'user', '用户', 'user:update', '修改', '2');
INSERT INTO `permission` VALUES ('701', 'role', '角色权限', 'role:list', '列表', '1');
INSERT INTO `permission` VALUES ('702', 'role', '角色权限', 'role:add', '新增', '2');
INSERT INTO `permission` VALUES ('703', 'role', '角色权限', 'role:update', '修改', '2');
INSERT INTO `permission` VALUES ('704', 'role', '角色权限', 'role:delete', '删除', '2');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(20) DEFAULT NULL COMMENT '角色名',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_status` varchar(1) DEFAULT '1' COMMENT '是否有效  1有效  2无效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='后台角色表';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '管理员', '2017-11-22 16:24:34', '2017-11-22 16:24:52', '1');
INSERT INTO `role` VALUES ('2', '作家', '2017-11-22 16:24:34', '2017-11-22 16:24:52', '1');
INSERT INTO `role` VALUES ('3', '程序员', '2017-11-22 16:28:47', '2017-11-22 16:28:47', '1');

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL COMMENT '角色id',
  `permission_id` int(11) DEFAULT NULL COMMENT '权限id',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_status` varchar(1) DEFAULT '1' COMMENT '是否有效 1有效     2无效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='角色-权限关联表';

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES ('1', '2', '101', '2017-11-22 16:26:21', '2017-11-22 16:26:32', '1');
INSERT INTO `role_permission` VALUES ('2', '2', '102', '2017-11-22 16:26:21', '2017-11-22 16:26:32', '1');
INSERT INTO `role_permission` VALUES ('5', '2', '602', '2017-11-22 16:28:28', '2017-11-22 16:28:28', '1');
INSERT INTO `role_permission` VALUES ('6', '2', '601', '2017-11-22 16:28:28', '2017-11-22 16:28:28', '1');
INSERT INTO `role_permission` VALUES ('7', '2', '603', '2017-11-22 16:28:28', '2017-11-22 16:28:28', '1');
INSERT INTO `role_permission` VALUES ('8', '2', '703', '2017-11-22 16:28:28', '2017-11-22 16:28:28', '1');
INSERT INTO `role_permission` VALUES ('9', '2', '701', '2017-11-22 16:28:28', '2017-11-22 16:28:28', '1');
INSERT INTO `role_permission` VALUES ('10', '2', '702', '2017-11-22 16:28:28', '2017-11-22 16:28:28', '1');
INSERT INTO `role_permission` VALUES ('11', '2', '704', '2017-11-22 16:28:31', '2017-11-22 16:28:31', '1');
INSERT INTO `role_permission` VALUES ('12', '2', '103', '2017-11-22 16:28:31', '2017-11-22 16:28:31', '1');
INSERT INTO `role_permission` VALUES ('13', '3', '601', '2017-11-22 16:28:47', '2017-11-22 16:28:47', '1');
INSERT INTO `role_permission` VALUES ('14', '3', '701', '2017-11-22 16:28:47', '2017-11-22 16:28:47', '1');
INSERT INTO `role_permission` VALUES ('15', '3', '702', '2017-11-22 16:35:01', '2017-11-22 16:35:01', '1');
INSERT INTO `role_permission` VALUES ('16', '3', '704', '2017-11-22 16:35:01', '2017-11-22 16:35:01', '1');
INSERT INTO `role_permission` VALUES ('17', '3', '102', '2017-11-22 16:35:01', '2017-11-22 16:35:01', '1');
INSERT INTO `role_permission` VALUES ('18', '3', '101', '2017-11-22 16:35:01', '2017-11-22 16:35:01', '1');
INSERT INTO `role_permission` VALUES ('19', '3', '603', '2017-11-22 16:35:01', '2017-11-22 16:35:01', '1');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `phone_number` bigint(20) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `nickname` varchar(255) DEFAULT NULL COMMENT '昵称',
  `integral` varchar(255) DEFAULT NULL,
  `role_id` int(11) DEFAULT '0' COMMENT '角色ID',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `delete_status` varchar(1) DEFAULT '1' COMMENT '是否有效  1有效  2无效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10008 DEFAULT CHARSET=utf8 COMMENT='运营后台用户表';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('10003', 'admin', '12222222222', '123456', '超级用户23', '1600', '1', '2017-10-30 11:52:38', '2018-06-13 13:46:00', '1');
INSERT INTO `user` VALUES ('10004', 'user', '13333333333', '123456', '莎士比亚', '1610', '2', '2017-10-30 16:13:02', '2018-06-13 13:46:00', '1');
INSERT INTO `user` VALUES ('10005', 'aaa', '18768128888', '123456', 'abba', '1643', '1', '2017-11-15 14:02:56', '2018-06-13 13:46:00', '1');
INSERT INTO `user` VALUES ('10007', 'test', '18768128889', '123456', '就看看列表', '1566', '3', '2017-11-22 16:29:41', '2018-06-13 13:46:00', '1');

-- ----------------------------
-- Procedure structure for execute_buy
-- ----------------------------
DROP PROCEDURE IF EXISTS `execute_buy`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `execute_buy`(IN  v_user_id BIGINT,
 IN  v_goods_id BIGINT,
 IN  v_title VARCHAR(120),
 OUT r_result INT)
BEGIN
		DECLARE insert_count INT DEFAULT 0;
		START TRANSACTION;
		INSERT INTO `order` (user_id, goods_id, title)
		VALUES(v_user_id, v_goods_id, v_title);
		SELECT ROW_COUNT() INTO insert_count;
		IF (insert_count = 0) THEN
			ROLLBACK;
			SET r_result = -1;
		ELSEIF (insert_count < 0) THEN
			ROLLBACK ;
			SET r_result = -2;
		ELSE
			UPDATE goods SET number = number - 1
			WHERE goods_id = v_goods_id
			AND number > 0;
			SELECT ROW_COUNT() INTO insert_count;
			IF (insert_count = 0) THEN
				ROLLBACK;
				SET r_result = 0;
			ELSEIF (insert_count < 0) THEN
				ROLLBACK;
				SET r_result = -2;
			ELSE
				COMMIT;
			SET r_result = 1;
			END IF;
		END IF;
	END
;;
DELIMITER ;
