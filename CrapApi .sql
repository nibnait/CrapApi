create database api;
use api;

# 评论表
CREATE TABLE `comment` (
  `id` varchar(50) NOT NULL,
  `webpageId` varchar(50) NOT NULL,
  `content` varchar(200) NOT NULL,
  `userId` varchar(50) DEFAULT NULL,
  `parentId` varchar(50) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sequence` int(11) NOT NULL DEFAULT '0' COMMENT '排序，越大越靠前',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# html网页源码表
DROP TABLE IF EXISTS `webpage`;
CREATE TABLE `webpage` (
  `id` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `brief` varchar(200) DEFAULT NULL,
  `content` text NOT NULL,
  `click` int(11) NOT NULL DEFAULT '0',
  `type` varchar(20) NOT NULL DEFAULT 'PAGE',
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `moduleId` varchar(50) DEFAULT NULL,
  `mkey` varchar(20) DEFAULT NULL COMMENT 'key，唯一键，页面唯一标识',
  `canDelete` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否可删除，可修key，默认可以',
  `category` varchar(50) DEFAULT NULL,
  `canComment` tinyint(4) NOT NULL DEFAULT '1',
  `commentCount` int(11) NOT NULL DEFAULT '0',
  `sequence` int(11) NOT NULL DEFAULT '0' COMMENT '排序，越大越靠前',
  `password` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mkey_UNIQUE` (`mkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# 项目模块表
CREATE TABLE `module` (
  `moduleId` varchar(50) NOT NULL COMMENT '所属模块ID',
  `moduleName` varchar(100) NOT NULL COMMENT '所属模块名称',
  `parentId` varchar(50) DEFAULT NULL COMMENT '父级节点ID',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `password` varchar(20) DEFAULT NULL COMMENT '访问密码',
  `sequence` int(11) NOT NULL DEFAULT '0' COMMENT '排序，越大越靠前',
  PRIMARY KEY (`moduleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# 项目接口表
CREATE TABLE `interface` (
  `id` varchar(50) NOT NULL COMMENT '主键',
  `url` varchar(100) NOT NULL COMMENT 'api链接',
  `method` varchar(30) NOT NULL COMMENT ' 请求方式',
  `param` text COMMENT '参数列表',
  `requestExam` text COMMENT '请求示例',
  `responseParam` text COMMENT '返回参数说明',
  `errorList` text COMMENT '接口错误码列表',
  `trueExam` text COMMENT '正确返回示例',
  `falseExam` text COMMENT '错误返回示例',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否可用;0不可用；1可用;-1 删除',
  `moduleId` varchar(50) NOT NULL COMMENT '所属模块ID',
  `interfaceName` varchar(100) NOT NULL COMMENT '接口名',
  `remark` text,
  `errors` text COMMENT '错误码、错误码信息',
  `updateBy` varchar(100) DEFAULT NULL,
  `updateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createTime` time NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `url` (`url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;



# user表
CREATE TABLE `user` (
  `userId` varchar(50) NOT NULL,
  `userName` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `trueName` varchar(50) DEFAULT NULL,
  `roleId` varchar(1024) DEFAULT NULL,
  `roleName` varchar(1024) DEFAULT NULL,
  `auth` varchar(2048) DEFAULT NULL,
  `authName` varchar(2048) DEFAULT NULL,
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `sequence` int(11) NOT NULL DEFAULT '0' COMMENT '排序，越大越靠前',
  PRIMARY KEY (`userId`),
  UNIQUE KEY `userName` (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# 菜单、公共数据表
CREATE TABLE `menu` (
  `menuId` varchar(50) NOT NULL DEFAULT '导航菜单编号',
  `menuName` varchar(50) NOT NULL COMMENT '菜单名称',
  `menuUrl` varchar(100) DEFAULT NULL COMMENT '菜单链接',
  `roleIds` varchar(512) DEFAULT NULL COMMENT '角色可见集合  （ID之间以逗号分隔）',
  `parentId` varchar(50) DEFAULT '0',
  `iconRemark` varchar(100) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL COMMENT '前端菜单、后台菜单',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `sequence` int(11) NOT NULL DEFAULT '0' COMMENT '排序，越大越靠前',
  PRIMARY KEY (`menuId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# 系统设置表
CREATE TABLE `setting` (
  `id` varchar(50) NOT NULL DEFAULT '',
  `mkey` varchar(20) NOT NULL,
  `value` varchar(100) NOT NULL,
  `remark` text,
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `type` varchar(10) NOT NULL DEFAULT 'TEXT' COMMENT '设置类型（IMAGE,LINK,TEXT）',
  `canDelete` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1：可删除，0：不可删除',
  `sequence` int(11) NOT NULL DEFAULT '0' COMMENT '排序，越大越靠前',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`mkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# 角色表
CREATE TABLE `role` (
  `roleId` varchar(50) NOT NULL COMMENT '角色ID',
  `roleName` varchar(50) NOT NULL COMMENT '角色名称',
  `auth` text NOT NULL,
  `authName` text,
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `sequence` int(11) NOT NULL DEFAULT '0' COMMENT '排序，越大越靠前',
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# 错误码
CREATE TABLE `error` (
  `errorId` varchar(50) NOT NULL COMMENT '主键',
  `errorCode` varchar(50) NOT NULL COMMENT '错误码编码',
  `errorMsg` varchar(128) NOT NULL COMMENT '错误码描述',
  `moduleId` varchar(50) NOT NULL,
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态',
  `sequence` int(11) NOT NULL DEFAULT '0' COMMENT '排序，越大越靠前',
  PRIMARY KEY (`errorId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;