-- 本文件包含DDL及示例数据,数据库使用mysql, 数据库名为example
-- example.class_student definition

CREATE TABLE `class_student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_id` int(11) NOT NULL COMMENT '班级id',
  `student_id` int(11) NOT NULL COMMENT '学生id',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;


-- example.class_teacher definition

CREATE TABLE `class_teacher` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_id` int(11) NOT NULL COMMENT '班级id',
  `teacher_id` int(11) NOT NULL COMMENT '教师id',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;


-- example.school_class definition

CREATE TABLE `school_class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '班级名',
  `description` varchar(255) DEFAULT NULL COMMENT '班级开设描述',
  `grade` varchar(255) DEFAULT NULL COMMENT '年级/届',
  `delete_status` varchar(1) NOT NULL DEFAULT '1' COMMENT '删除标志（1-有效，2-失效）',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;


-- example.student definition

CREATE TABLE `student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '学生姓名',
  `sex` varchar(1) DEFAULT NULL COMMENT '性别',
  `id_number` varchar(255) DEFAULT NULL COMMENT '身份证号',
  `phone` varchar(255) DEFAULT NULL COMMENT '联系电话',
  `delete_status` varchar(1) DEFAULT '1' COMMENT '删除标志（1-有效，2-失效）',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;


-- example.sys_permission definition

CREATE TABLE `sys_permission` (
  `id` int(11) NOT NULL COMMENT '权限id',
  `menu_code` varchar(255) NOT NULL COMMENT '菜单码',
  `menu_name` varchar(255) NOT NULL COMMENT '菜单名',
  `permission_code` varchar(255) NOT NULL COMMENT '权限码',
  `permission_name` varchar(255) NOT NULL COMMENT '权限名',
  `required_permission` varchar(255) DEFAULT NULL COMMENT '需求权限',
  `delete_status` varchar(1) DEFAULT '1' COMMENT '删除标志（1-有效，2-失效）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- example.sys_role definition

CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `role_name` varchar(255) NOT NULL COMMENT '角色名',
  `delete_status` varchar(1) DEFAULT '1' COMMENT '删除标志（1-有效，2-失效）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;


-- example.sys_role_permission definition

CREATE TABLE `sys_role_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色权限',
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `permission_id` int(11) NOT NULL COMMENT '权限id',
  `delete_status` varchar(1) DEFAULT '1' COMMENT '删除标志（1-有效，2-失效）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;


-- example.sys_user definition

CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `nickname` varchar(255) NOT NULL COMMENT '别名/昵称/登录名',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `delete_status` varchar(1) NOT NULL DEFAULT '1' COMMENT '删除标志（1-有效，2-失效）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10003 DEFAULT CHARSET=utf8;


-- example.sys_user_role definition

CREATE TABLE `sys_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户角色关联表id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `delete_status` varchar(1) DEFAULT '1' COMMENT '删除标志（1-有效，2-失效）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;


-- example.teacher definition

CREATE TABLE `teacher` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '教师姓名',
  `phone` varchar(255) DEFAULT NULL COMMENT '联系方式',
  `birth` varchar(255) DEFAULT NULL COMMENT '出生日期',
  `sex` varchar(255) DEFAULT NULL COMMENT '性别',
  `first_degree` varchar(255) DEFAULT NULL COMMENT '第一学历',
  `major` varchar(255) DEFAULT NULL COMMENT '专业',
  `title` varchar(255) DEFAULT NULL COMMENT '职称',
  `delete_status` varchar(255) DEFAULT '1' COMMENT '删除标志（1-有效，2-失效）',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- example为本地数据库名,根据实际需求进行修改. 以下为示例数据
INSERT INTO example.class_student (class_id,student_id,create_time,update_time) VALUES
	 (1,1,'2022-07-06 00:45:57.0',NULL),
	 (1,2,'2022-07-06 00:45:57.0',NULL),
	 (2,1,'2022-07-09 16:13:00.0',NULL),
	 (2,2,'2022-07-09 16:13:00.0',NULL),
	 (2,3,'2022-07-09 16:13:00.0',NULL),
	 (2,4,'2022-07-09 16:13:00.0',NULL),
	 (1,3,'2022-07-09 16:14:01.0',NULL),
	 (1,4,'2022-07-09 16:14:01.0',NULL),
	 (3,1,'2022-07-09 16:14:13.0',NULL),
	 (3,2,'2022-07-09 16:14:13.0',NULL);
	 
 INSERT INTO example.class_teacher (class_id,teacher_id,create_time,update_time) VALUES
	 (2,4,'2022-07-09 12:17:32.0',NULL),
	 (2,3,'2022-07-09 16:38:32.0',NULL);
	 
 INSERT INTO example.school_class (name,description,grade,delete_status,create_time,update_time) VALUES
	 ('java开发提高班','涵盖javaEE，springCloud进行底层原理讲解','2022','1','2022-07-06 00:45:57.0','2022-07-06 00:33:44.0'),
	 ('vue提高班','讲解vue底层封装，vue2.x,3.x版本特性分析，及可搭配前端UI框架选择','2022','1','2022-07-06 00:45:57.0','2022-07-06 02:17:28.0'),
	 ('班级6','11111','2022','1','2022-07-06 00:47:03.0',NULL),
	 ('redis提高班','redis特性讲解,redis实战1','2022','1','2022-07-09 16:53:31.0','2022-07-09 16:53:35.0'),
	 ('1','1','1','2','2022-07-09 18:51:53.0','2022-07-09 18:51:54.0'),
	 ('2','2','2','2','2022-07-09 18:51:58.0','2022-07-09 18:52:22.0');
	 
 INSERT INTO example.student (name,sex,id_number,phone,delete_status,create_time,update_time) VALUES
	 ('张三','男','350203199408071998','18066666666','1','2022-07-04 23:47:30.0','2022-07-06 02:12:59.0'),
	 ('李四','女','350203199408071999','18066666667','1','2022-07-04 23:47:30.0','2022-07-05 01:05:34.0'),
	 ('王五','男','350203199408071997','18066666669','1','2022-07-04 23:47:30.0','2022-07-05 01:05:32.0'),
	 ('赵六','男','350781196403075589','18088888888','1','2022-07-05 01:05:27.0','2022-07-05 01:05:30.0'),
	 ('陈平安','男','350203199408071812','18055555552','2','2022-07-09 18:43:31.0','2022-07-09 18:43:59.0'),
	 ('1','1','1','1','2','2022-07-09 18:51:33.0','2022-07-09 18:51:34.0');
	 
 INSERT INTO example.sys_permission (id,menu_code,menu_name,permission_code,permission_name,required_permission,delete_status) VALUES
	 (201,'student','学生信息','student:list','列表','1','1'),
	 (202,'student','学生信息','student:add','新增','0','1'),
	 (203,'student','学生信息','student:update','修改','0','1'),
	 (301,'teacher','教师信息','teacher:list','列表','1','1'),
	 (302,'teacher','教师信息','teacher:add','新增','0','1'),
	 (303,'teacher','教师信息','teacher:update','修改','0','1'),
	 (401,'schoolClass','班级信息','schoolClass:list','列表','1','1'),
	 (402,'schoolClass','班级信息','schoolClass:add','新增','0','1'),
	 (403,'schoolClass','班级信息','schoolClass:update','修改','0','1'),
	 (404,'schoolClass','班级信息','schoolClass:listTeacher','列表班级教师','1','1');
INSERT INTO example.sys_permission (id,menu_code,menu_name,permission_code,permission_name,required_permission,delete_status) VALUES
	 (405,'schoolClass','班级信息','schoolClass:listStudent','列表班级学生','1','1'),
	 (406,'schoolClass','班级信息','schoolClass:addTeacher','新增班级教师','0','1'),
	 (407,'schoolClass','班级信息','schoolClass:addStudent','新增班级学生','0','1'),
	 (408,'schoolClass','班级信息','schoolClass:removeStudent','删除班级学生','0','1'),
	 (409,'schoolClass','班级信息','schoolClass:removeTeacher','删除班级教师','0','1'),
	 (411,'classStudentDetail','班级信息','schoolClass:listStudent','列表班级学生','1','1'),
	 (412,'classTeacherDetail','班级信息','schoolClass:listTeacher','列表班级教师','1','1'),
	 (601,'user','用户','user:list','列表','1','1'),
	 (602,'user','用户','user:add','新增','0','1'),
	 (603,'user','用户','user:update','修改','0','1');
INSERT INTO example.sys_permission (id,menu_code,menu_name,permission_code,permission_name,required_permission,delete_status) VALUES
	 (701,'role','角色权限','role:list','列表','1','1'),
	 (702,'role','角色权限','role:add','新增','0','1'),
	 (703,'role','角色权限','role:update','修改','0','1'),
	 (704,'role','角色权限','role:delete','删除','0','1');
	 
 INSERT INTO example.sys_role_permission (role_id,permission_id,delete_status) VALUES
	 (2,201,'1'),
	 (2,202,'1'),
	 (2,203,'1'),
	 (2,301,'1'),
	 (2,302,'1'),
	 (2,303,'1'),
	 (2,401,'1'),
	 (2,402,'1'),
	 (2,403,'1'),
	 (2,404,'1');
INSERT INTO example.sys_role_permission (role_id,permission_id,delete_status) VALUES
	 (2,405,'1'),
	 (2,406,'1'),
	 (2,407,'1'),
	 (2,408,'1'),
	 (2,409,'1'),
	 (2,411,'1'),
	 (2,412,'1'),
	 (2,601,'1'),
	 (2,602,'1'),
	 (2,603,'1');
INSERT INTO example.sys_role_permission (role_id,permission_id,delete_status) VALUES
	 (2,701,'1'),
	 (2,702,'1'),
	 (2,703,'1'),
	 (2,704,'1');
	 
	 
 INSERT INTO example.sys_user (username,nickname,password,delete_status,create_time,update_time) VALUES
	 ('admin','admin','123456','1','2022-07-03 23:59:46.0','2022-07-03 22:53:26.0'),
	 ('test001','全局测试1号','123456','1','2022-07-09 16:59:40.0',NULL);
	 
 INSERT INTO example.sys_user_role (user_id,role_id,delete_status) VALUES
	 (10001,1,'1'),
	 (10002,2,'1');
	 
 INSERT INTO example.teacher (name,phone,birth,sex,first_degree,major,title,delete_status,create_time,update_time) VALUES
	 ('杨光','18055555555','1990-01-02','男','本科','计算机科学与技术','中级','1','2022-07-05 01:56:49.0','2022-07-05 01:56:56.0'),
	 ('杨磊','18055555556','1990-02-02','男','本科','计算机科学与技术','中级','1','2022-07-05 01:56:49.0','2022-07-05 01:56:56.0'),
	 ('王猛','18055555557','1990-07-02','男','本科','计算机科学与技术','中级','1','2022-07-05 01:56:49.0','2022-07-05 01:56:56.0'),
	 ('吴广','18050051234','1980-02-01','男','本科','计算机科学与技术','中级','1','2022-07-09 18:44:46.0','2022-07-09 18:44:54.0'),
	 ('1','1','1990-01-01','1','1','1','1','2','2022-07-09 18:51:46.0','2022-07-09 18:51:47.0');