use fp;

/**
2，用户成员基本信息：原表名FAMLIY_MEM_INFO,现表名：USER_INFO
*/
DROP TABLE IF EXISTS USER_INFO; -- FAMLIY_MEM_INFO;
CREATE TABLE USER_INFO (
  pid INTEGER NOT NULL AUTO_INCREMENT COMMENT '户成员基本信息ID',
  did int NOT NULL COMMENT '所属单位部门ID',
  rid int NOT NULL COMMENT '所属角色ID',
  oid int DEFAULT NULL  COMMENT '机构ID',
  pname varchar(50) NOT NULL COMMENT '成员姓名',
  sex char(1) DEFAULT NULL COMMENT '性别。 F-女，M-男',
  relationType int DEFAULT NULL COMMENT '与户主关系',
  cid char(18) DEFAULT NULL COMMENT '身份证号码',
  workType int	DEFAULT NULL COMMENT '就业状况编码',
  marriedType int DEFAULT NULL COMMENT '婚姻状况。0-未婚	1-已婚	2-未知',	  	
  phone varchar(50) DEFAULT NULL COMMENT '联系电话',
  healthyType int DEFAULT NULL COMMENT '健康状况',	  
  isHolder int NOT NULL DEFAULT 0 COMMENT '是否户主 ，默认为0， 0-非户主，1-户主',
  faddr varchar(200) DEFAULT NULL COMMENT '家庭住址',
  oTime timestamp NOT NULL DEFAULT '2017-11-01 00:00:01' COMMENT '操作时间',
  upwd varchar(100) NOT NULL COMMENT '用户密码',
  descb varchar(500) DEFAULT NULL COMMENT '备注',
  isUsed int NOT NULL DEFAULT 1 COMMENT '是否有效，0-失效，1-有效',
  PRIMARY KEY (PID),
  UNIQUE (cid,phone)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT '用户成员基本信息';

/**
3，就业状况编码表：WORK_CD
*/
DROP TABLE IF EXISTS WORK_CD;
CREATE TABLE WORK_CD (
  ID int NOT NULL COMMENT '就业状况ID',
  type_name varchar(50) NOT NULL COMMENT '描述，1-无业、2-学生、3-个体户、4-灵活就业、5-工作、6-儿童、9-未知',
  flag int NOT NULL DEFAULT 1 COMMENT '是否有效，0-失效，1-有效',
  PRIMARY KEY (ID)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT '就业状况编码表';

/**
4，健康状况编码表：HEALTHY_CD
*/
DROP TABLE IF EXISTS HEALTHY_CD;
CREATE TABLE HEALTHY_CD (
  ID int NOT NULL COMMENT '健康状况ID',
  type_name varchar(50) NOT NULL COMMENT '描述，0-健康、1-残疾、2-慢性病、3-生病、4-死亡、9-未知',
  flag int NOT NULL DEFAULT 1 COMMENT '是否有效，0-失效，1-有效',
  PRIMARY KEY (ID)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT '健康状况编码表';

/**
5，与户主关系编码表：RELATION_CD
*/
DROP TABLE IF EXISTS RELATION_CD;
CREATE TABLE RELATION_CD (
  ID int NOT NULL COMMENT '健康状况ID',
  type_name varchar(50) NOT NULL COMMENT '描述，1-户主、2-母子、3-母女、4-兄弟、5-姐弟、6-兄妹、7-姐妹、8-祖孙、9-曾祖孙、10-其他、11--父子、12-父女、13-工作关系',
  flag int NOT NULL DEFAULT 1 COMMENT '是否有效，0-失效，1-有效',
  PRIMARY KEY (ID)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT '与户主关系编码表';

/**
6，教育救助信息表：EDU_ASSIST_INFO
*/
DROP TABLE IF EXISTS EDU_ASSIST_INFO;
CREATE TABLE EDU_ASSIST_INFO (
  ID int NOT NULL AUTO_INCREMENT COMMENT '救助信息ID',
  PID int(10) DEFAULT NULL COMMENT '被救助人员ID',
  EID int DEFAULT NULL COMMENT '被救助人员教育学段ID号',
  eSchool varchar(200) DEFAULT NULL COMMENT '学校名称',
  eclassName varchar(200) DEFAULT NULL COMMENT '所在班级',
  ecost Decimal(15,2) DEFAULT NULL COMMENT '救助金额',
  payment_time timestamp DEFAULT NULL DEFAULT '2017-11-01 00:00:01' COMMENT '发放时间',
  descb varchar(500) DEFAULT NULL COMMENT '说明',
  flag int NOT NULL DEFAULT 1  COMMENT '是否有效，0-失效，1-有效',
  PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '教育救助信息表';

/**
7，救助学段信息：EDU_PHASE_CD
 */
DROP TABLE IF EXISTS EDU_PHASE_CD;
CREATE TABLE EDU_PHASE_CD (
  EID int NOT NULL COMMENT '学段编号',
  phase varchar(50) NOT NULL COMMENT '学习阶段，1-幼儿园、2-小学、3-初中、4-高中、5-大学、10-其他',
  flag int NOT NULL DEFAULT 1 COMMENT '是否有效，0-失效，1-有效',
  PRIMARY KEY (EID)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT '救助学段信息';

/**
8，大病救助信息：HEATHLY_ASSIST_INFO
*/
DROP TABLE IF EXISTS HEATHLY_ASSIST_INFO;
CREATE TABLE HEATHLY_ASSIST_INFO (
  ID int NOT NULL AUTO_INCREMENT COMMENT '救助信息ID',
  PID int(10) NOT NULL COMMENT '被救助人员ID',
  IllnessName varchar(200) DEFAULT NULL COMMENT '大病名称',
  hospital varchar(200) DEFAULT NULL COMMENT '就诊医院',
  cost Decimal(15,2) DEFAULT NULL COMMENT '医疗总费用',
  payment_time timestamp DEFAULT NULL DEFAULT '2017-11-01 00:00:01' COMMENT '发放日期',
  descb varchar(500) DEFAULT NULL COMMENT '说明',
  flag int NOT NULL DEFAULT 1  COMMENT '是否有效，0-失效，1-有效',
  PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '大病救助信息';

/**
9，咨询信息记录表：CONSULTATION_INFO
*/
DROP TABLE IF EXISTS CONSULTATION_INFO;
CREATE TABLE CONSULTATION_INFO (
  id int NOT NULL AUTO_INCREMENT COMMENT '信息ID',
  pid int(10) NOT NULL COMMENT '咨询人ID',
  subTime timestamp DEFAULT CURRENT_TIMESTAMP COMMENT '咨询时间',
  content varchar(10000) DEFAULT NULL COMMENT '咨询内容',
  isAnony int DEFAULT 0 COMMENT '是否匿名，0-非匿名，1匿名',
  questionTypeId int DEFAULT NULL COMMENT '咨询问题类型ID',
  oid int DEFAULT NULL COMMENT '咨询目标机构ID',
  answer varchar(10000) DEFAULT NULL COMMENT '应答内容',
  ansTime timestamp COMMENT '应答时间',
  aid int DEFAULT NULL COMMENT '应答人ID',
  evaluation int DEFAULT NULL COMMENT '答复评价，1-满意、2-比较满意、3-不满意',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '咨询信息记录表';

/**
10，咨询信息类型表：CONSULT_TYPE_CD
*/
DROP TABLE IF EXISTS CONSULT_TYPE_CD;
CREATE TABLE CONSULT_TYPE_CD (
  id int NOT NULL COMMENT '咨询问题类型ID',
  typeName varchar(50) NOT NULL COMMENT '类型描述，1-医疗求助、2-创业就业、3-社会保障、4-扶贫政策、5-教育助学、9-其他',
  PRIMARY KEY (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT '咨询信息类型表';

/**
11，信息发布表：PUBLISH_INFO
*/
DROP TABLE IF EXISTS PUBLISH_INFO;
CREATE TABLE PUBLISH_INFO (
  id int NOT NULL AUTO_INCREMENT COMMENT '信息ID',
  oid int DEFAULT NULL COMMENT '信息发布机构ID',
  title varchar(1000) DEFAULT NULL COMMENT '发布标题',
  content varchar(10000) DEFAULT NULL COMMENT '发布内容',
  typeId int DEFAULT NULL COMMENT '信息类型',
  attachmentId int DEFAULT NULL  COMMENT '附件ID',
  pubTime timestamp  COMMENT '更新日期',
  -- pid int DEFAULT NULL COMMENT '发布人ID',
  -- start_time timestamp DEFAULT NULL DEFAULT '2017-11-01 00:00:01' COMMENT '发布内容起效时间',
  -- stop_time timestamp DEFAULT NULL DEFAULT '2017-11-01 00:00:01' COMMENT '发布内容停止时间',
  stopFlag int NOT NULL DEFAULT 1 COMMENT '立即停止，1-启用，0-立即停止发布公示',
  flag int NOT NULL DEFAULT 1 COMMENT '删除标识，1-正常，0-已删除',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '信息发布表';

/**
12，信息发布附件表：PUBLISH_ATTACH_INFO
*/
DROP TABLE IF EXISTS PUBLISH_ATTACH_INFO;
CREATE TABLE PUBLISH_ATTACH_INFO (
  attachmentId int NOT NULL  COMMENT '附件ID',
  fileName varchar(200) NOT NULL COMMENT '文件名称',
  furl varchar(500) NOT NULL COMMENT '文件存放路径'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT '信息发布附件表';

/**
13，信息推送表：TARGET_INFO  信息通过短信、APP推送
*/
DROP TABLE IF EXISTS TARGET_INFO;
CREATE TABLE TARGET_INFO (
  ID int NOT NULL AUTO_INCREMENT COMMENT '信息ID',
  DID int DEFAULT NULL COMMENT '信息推送单位部门ID',
  content varchar(1000) DEFAULT NULL COMMENT '推送内容',
  UID int DEFAULT NULL COMMENT '推送人ID',
  PID int DEFAULT NULL COMMENT '目标接受人ID',
  pub_flag int DEFAULT NULL COMMENT '推送方式，0-APP，1-短信，2-两者都',
  pub_time timestamp DEFAULT NULL DEFAULT '2017-11-01 00:00:01' COMMENT '推送时间',
  input_time timestamp DEFAULT NULL DEFAULT '2017-11-01 00:00:01' COMMENT '信息记录时间',
  PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '信息推送表';

/**
14，菜单配置表：MENU_MNG
*/
DROP TABLE IF EXISTS MENU_MNG;
CREATE TABLE MENU_MNG (
  MID int NOT NULL COMMENT '菜单配置项ID',
  mname varchar(100) NOT NULL COMMENT '菜单名称',
  murl varchar(1000) NOT NULL COMMENT '菜单地址',
  parent_id int NOT NULL COMMENT '父配置项ID',
  PRIMARY KEY (MID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '菜单配置表';

/**
16，角色信息表：ROLE_MNG
*/
DROP TABLE IF EXISTS ROLE_MNG;
CREATE TABLE ROLE_MNG (
  RID int NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  rname varchar(50) NOT NULL COMMENT '角色名称',
  flag int NOT NULL DEFAULT 1 COMMENT '是否有效，1-有效，0-无效',
  PRIMARY KEY (RID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '角色信息表';

/**
17，单位部门信息表：DEPT_CD，上下级行政机构，如：宿迁市，泗阳县，枸杞乡，幸福村
*/
DROP TABLE IF EXISTS DEPT_CD;
CREATE TABLE DEPT_CD (
  DID int NOT NULL AUTO_INCREMENT COMMENT '单位部门ID',
  dname varchar(50) NOT NULL COMMENT '部门名称',
  ulevel int DEFAULT NULL COMMENT '级别,级别表',
  superDid int NOT NULL COMMENT '上级单位部门ID',
  descb varchar(500) DEFAULT NULL COMMENT '部门描述',
  flag int NOT NULL DEFAULT 1 COMMENT '是否有效，1-有效，0-无效',
  PRIMARY KEY (DID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '单位部门信息表';

/**
 * 只能部门表，如公安局，民政局，社保局，财政局等
 */
DROP TABLE IF EXISTS ORG_CD;
CREATE TABLE ORG_CD (
  oid int NOT NULL AUTO_INCREMENT COMMENT '单位部门ID',
  oname varchar(50) NOT NULL COMMENT '部门名称',
  ulevel int DEFAULT NULL COMMENT '级别,级别表',
  superDid int DEFAULT NULL COMMENT '上级单位部门ID',
  descb varchar(500) DEFAULT NULL COMMENT '部门描述',
  flag int NOT NULL DEFAULT 1 COMMENT '是否有效，1-有效，0-无效',
  PRIMARY KEY (DID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '单位部门信息表';


/**
18，部门级别表：LEVEL_CD
*/
DROP TABLE IF EXISTS LEVEL_CD;
CREATE TABLE LEVEL_CD (
  ulevel int NOT NULL COMMENT '单位部门级别ID',
  dlname varchar(50) NOT NULL COMMENT '部门级别名称，1-村级、2-乡镇级、3-区县级、4-地市级',
  PRIMARY KEY (ulevel)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '部门级别表';

/**
19，角色菜单映射关系表：MENU_ROLE_MNG
 */
DROP TABLE IF EXISTS MENU_ROLE_MNG;
CREATE TABLE MENU_ROLE_MNG (
  RID int NOT NULL COMMENT '角色ID',
  MID int NOT NULL COMMENT '菜单配置项ID',
  descb varchar(100) DEFAULT NULL COMMENT '角色菜单映射关系说明',
  flag int NOT NULL DEFAULT 1 COMMENT '是否有效，1-有效，0-无效'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '角色菜单映射关系表';

