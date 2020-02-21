CREATE TABLE `t_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loginacct` varchar(255) NOT NULL,
  `userpswd` char(32) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `createtime` char(19) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='';

insert  into `t_admin`(`id`,`loginacct`,`userpswd`,`username`,`email`,`createtime`) values (1,'superadmin','e10adc3949ba59abbe56e057f20f883e','超级管理员','admin@atguigu.com','2019-01-12 17:18:00'),(3,'lisi','e10adc3949ba59abbe56e057f20f883e','lisi','lisi@atguigu.com','2019-01-12 17:18:00'),(4,'wangwu','f1887d3f9e6ee7a32fe5e76f4ab80d63','wangwu','wangwu@163.com','2019-01-12 17:18:00'),(8,'aaa','123456','aaa','aaa@atguigu.com','2019-01-12 17:18:00'),(12,'xxxx','e10adc3949ba59abbe56e057f20f883e','xxxx','xxxx@163.com','2019-01-21 10:54:36'),(13,'yy','e10adc3949ba59abbe56e057f20f883e','yy','yy@atguigu.com','2019-01-21 10:56:49'),(14,'qqq','e10adc3949ba59abbe56e057f20f883e','qqqq','qqq@atguigu.com','2019-01-21 11:00:01'),(15,'qqq456','e10adc3949ba59abbe56e057f20f883e','测试中文123','qqq654@atguigu.com','2019-01-21 11:15:53');

CREATE TABLE `t_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='';

insert  into `t_menu`(`id`,`pid`,`name`,`icon`,`url`) values (1,0,'控制面板','glyphicon glyphicon-dashboard','main.html'),(2,0,'权限管理','glyphicon glyphicon glyphicon-tasks',NULL),(3,2,'用户维护','glyphicon glyphicon-user','admin/index.html'),(4,2,'角色维护','glyphicon glyphicon-king','role/index.html'),(5,2,'权限维护','glyphicon glyphicon-lock','permission/index.html'),(6,2,'菜单维护','glyphicon glyphicon-th-list','menu/index.html'),(7,0,'业务审核','glyphicon glyphicon-ok',NULL),(8,7,'实名认证审核','glyphicon glyphicon-check','auth_cert/index.html'),(9,7,'广告审核','glyphicon glyphicon-check','auth_adv/index.html'),(10,7,'项目审核','glyphicon glyphicon-check','auth_project/index.html'),(11,0,'业务管理','glyphicon glyphicon-th-large',NULL),(12,11,'资质维护','glyphicon glyphicon-picture','cert/index.html'),(13,11,'分类管理','glyphicon glyphicon-equalizer','certtype/index.html'),(14,11,'流程管理','glyphicon glyphicon-random','process/index.html'),(15,11,'广告管理','glyphicon glyphicon-hdd','advert/index.html'),(16,11,'消息模板','glyphicon glyphicon-comment','message/index.html'),(17,11,'项目分类','glyphicon glyphicon-list','projectType/index.html'),(18,11,'项目标签','glyphicon glyphicon-tags','tag/index.html'),(19,0,'参数管理','glyphicon glyphicon-list-alt','param/index.html');

CREATE TABLE `t_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `name` varchar(255) DEFAULT NULL COMMENT '',
  `title` varchar(255) DEFAULT NULL COMMENT '',
  `icon` varchar(255) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL COMMENT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='';

insert  into `t_permission`(`id`,`name`,`title`,`icon`,`pid`) values (1,NULL,'用户模块','glyphicon glyphicon-user',0),(2,'user:add','新增','glyphicon glyphicon-plus',1),(3,'user:delete','删除','glyphicon glyphicon-remove',1),(4,'user:update','更新','glyphicon glyphicon-pencil',1),(5,'user:get','查询','glyphicon glyphicon-zoom-in',1),(6,'user:assign:role','授予角色','glyphicon glyphicon-user',1),(7,NULL,'角色模块','glyphicon glyphicon-heart',0),(8,'role:add','新增','glyphicon glyphicon-plus',7),(9,'role:delete','删除','glyphicon glyphicon-remove',7),(10,'role:get','查询','glyphicon glyphicon-zoom-in',7),(11,'role:update','修改','glyphicon glyphicon-pencil',7),(12,'role:assign:permission','授予权限','glyphicon glyphicon-user',7),(13,NULL,'菜单模块','glyphicon glyphicon-th-list',0),(14,'menu:add','新增','glyphicon glyphicon-plus',13),(15,'menu:delete','删除','glyphicon glyphicon-remove',13),(16,'menu:update','修改','glyphicon glyphicon-pencil',13),(17,'menu:get','查询','glyphicon glyphicon-zoom-in',13),(18,'menu:assign:permission','授予权限','glyphicon glyphicon-user',13);

CREATE TABLE `t_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COMMENT='';

insert  into `t_role`(`id`,`name`) values (1,'PM - 项目经理'),(2,'SE - 软件工程师'),(3,'PG - 程序员'),(4,'TL - 组长'),(5,'GL - 组长'),(6,'QA - 品质保证'),(7,'QC - 品质控制'),(8,'SA - 软件架构师'),(9,'CMO / CMS - 配置管理员'),(10,'测试工程师'),(11,'审批人员');

CREATE TABLE `t_role_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleid` int(11) DEFAULT NULL,
  `permissionid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_3` (`roleid`),
  KEY `FK_Reference_4` (`permissionid`),
  CONSTRAINT `FK_Reference_4` FOREIGN KEY (`permissionid`) REFERENCES `t_permission` (`id`),
  CONSTRAINT `FK_Reference_3` FOREIGN KEY (`roleid`) REFERENCES `t_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='';

insert  into `t_role_permission`(`id`,`roleid`,`permissionid`) values (7,1,1),(8,1,2),(9,1,6),(10,1,13),(11,1,16),(12,1,17),(13,1,18);

CREATE TABLE `t_admin_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `adminid` int(11) DEFAULT NULL,
  `roleid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_1` (`adminid`),
  KEY `FK_Reference_2` (`roleid`),
  CONSTRAINT `FK_Reference_2` FOREIGN KEY (`roleid`) REFERENCES `t_role` (`id`),
  CONSTRAINT `FK_Reference_1` FOREIGN KEY (`adminid`) REFERENCES `t_admin` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='';

insert  into `t_admin_role`(`id`,`adminid`,`roleid`) values (2,1,2),(9,1,4),(11,1,8),(12,15,1),(13,15,2),(14,15,3);


CREATE TABLE `t_permission_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menuid` int(11) DEFAULT NULL,
  `permissionid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_10` (`menuid`),
  KEY `FK_Reference_9` (`permissionid`),
  CONSTRAINT `FK_Reference_10` FOREIGN KEY (`menuid`) REFERENCES `t_menu` (`id`),
  CONSTRAINT `FK_Reference_9` FOREIGN KEY (`permissionid`) REFERENCES `t_permission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='';

insert  into `t_permission_menu`(`id`,`menuid`,`permissionid`) values (7,2,1),(8,2,2),(9,2,3),(10,2,4),(11,2,5),(12,2,6),(13,2,7),(14,2,8),(15,2,9),(16,2,10),(17,2,11),(18,2,12);
