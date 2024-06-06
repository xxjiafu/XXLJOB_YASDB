SET DEFINE OFF;
--创建数据库内的表,列默认值,自增序列,列注释
CREATE TABLE XXL_JOB.xxl_job_group (
	id bigint,
	app_name varchar(64 char),
	title varchar(12 char),
	address_type smallint default 0,
	address_list clob,
	update_time timestamp
);
COMMENT ON COLUMN XXL_JOB.xxl_job_group.app_name IS '执行器AppName';
COMMENT ON COLUMN XXL_JOB.xxl_job_group.title IS '执行器名称';
COMMENT ON COLUMN XXL_JOB.xxl_job_group.address_type IS '执行器地址类型：0=自动注册、1=手动录入';
COMMENT ON COLUMN XXL_JOB.xxl_job_group.address_list IS '执行器地址列表，多地址逗号分隔';
CREATE SEQUENCE XXL_JOB.SEQ_XXL_JOB_GROUP_ID START WITH 2 INCREMENT BY 1;
ALTER TABLE XXL_JOB.xxl_job_group MODIFY id DEFAULT XXL_JOB.SEQ_XXL_JOB_GROUP_ID.NEXTVAL;
CREATE TABLE XXL_JOB.xxl_job_info (
	id bigint,
	job_group bigint,
	job_desc varchar(255 char),
	add_time timestamp,
	update_time timestamp,
	author varchar(64 char),
	alarm_email varchar(255 char),
	schedule_type varchar(50 char) default 'NONE',
	schedule_conf varchar(128 char),
	misfire_strategy varchar(50 char) default 'DO_NOTHING',
	executor_route_strategy varchar(50 char),
	executor_handler varchar(255 char),
	executor_param varchar(512 char),
	executor_block_strategy varchar(50 char),
	executor_timeout bigint default 0,
	executor_fail_retry_count bigint default 0,
	glue_type varchar(50 char),
	glue_source clob,
	glue_remark varchar(128 char),
	glue_updatetime timestamp,
	child_jobid varchar(255 char),
	trigger_status smallint default 0,
	trigger_last_time number(19, 0) default '0',
	trigger_next_time number(19, 0) default '0'
);
COMMENT ON COLUMN XXL_JOB.xxl_job_info.author IS '作者';
COMMENT ON COLUMN XXL_JOB.xxl_job_info.misfire_strategy IS '调度过期策略';
COMMENT ON COLUMN XXL_JOB.xxl_job_info.glue_remark IS 'GLUE备注';
COMMENT ON COLUMN XXL_JOB.xxl_job_info.schedule_conf IS '调度配置，值含义取决于调度类型';
COMMENT ON COLUMN XXL_JOB.xxl_job_info.executor_route_strategy IS '执行器路由策略';
COMMENT ON COLUMN XXL_JOB.xxl_job_info.executor_param IS '执行器任务参数';
COMMENT ON COLUMN XXL_JOB.xxl_job_info.trigger_status IS '调度状态：0-停止，1-运行';
COMMENT ON COLUMN XXL_JOB.xxl_job_info.trigger_next_time IS '下次调度时间';
COMMENT ON COLUMN XXL_JOB.xxl_job_info.executor_handler IS '执行器任务handler';
COMMENT ON COLUMN XXL_JOB.xxl_job_info.executor_timeout IS '任务执行超时时间，单位秒';
COMMENT ON COLUMN XXL_JOB.xxl_job_info.executor_fail_retry_count IS '失败重试次数';
COMMENT ON COLUMN XXL_JOB.xxl_job_info.glue_source IS 'GLUE源代码';
COMMENT ON COLUMN XXL_JOB.xxl_job_info.child_jobid IS '子任务ID，多个逗号分隔';
COMMENT ON COLUMN XXL_JOB.xxl_job_info.trigger_last_time IS '上次调度时间';
COMMENT ON COLUMN XXL_JOB.xxl_job_info.glue_updatetime IS 'GLUE更新时间';
COMMENT ON COLUMN XXL_JOB.xxl_job_info.job_group IS '执行器主键ID';
COMMENT ON COLUMN XXL_JOB.xxl_job_info.alarm_email IS '报警邮件';
COMMENT ON COLUMN XXL_JOB.xxl_job_info.schedule_type IS '调度类型';
COMMENT ON COLUMN XXL_JOB.xxl_job_info.executor_block_strategy IS '阻塞处理策略';
COMMENT ON COLUMN XXL_JOB.xxl_job_info.glue_type IS 'GLUE类型';
CREATE SEQUENCE XXL_JOB.SEQ_XXL_JOB_INFO_ID START WITH 2 INCREMENT BY 1;
ALTER TABLE XXL_JOB.xxl_job_info MODIFY id DEFAULT XXL_JOB.SEQ_XXL_JOB_INFO_ID.NEXTVAL;
CREATE TABLE XXL_JOB.xxl_job_lock (
	lock_name varchar(50 char)
);
COMMENT ON COLUMN XXL_JOB.xxl_job_lock.lock_name IS '锁名称';
CREATE TABLE XXL_JOB.xxl_job_log (
	id number(19, 0),
	job_group bigint,
	job_id bigint,
	executor_address varchar(255 char),
	executor_handler varchar(255 char),
	executor_param varchar(512 char),
	executor_sharding_param varchar(20 char),
	executor_fail_retry_count bigint default 0,
	trigger_time timestamp,
	trigger_code bigint,
	trigger_msg clob,
	handle_time timestamp,
	handle_code bigint,
	handle_msg clob,
	alarm_status smallint default 0
);
COMMENT ON COLUMN XXL_JOB.xxl_job_log.executor_handler IS '执行器任务handler';
COMMENT ON COLUMN XXL_JOB.xxl_job_log.executor_param IS '执行器任务参数';
COMMENT ON COLUMN XXL_JOB.xxl_job_log.trigger_time IS '调度-时间';
COMMENT ON COLUMN XXL_JOB.xxl_job_log.handle_time IS '执行-时间';
COMMENT ON COLUMN XXL_JOB.xxl_job_log.handle_code IS '执行-状态';
COMMENT ON COLUMN XXL_JOB.xxl_job_log.handle_msg IS '执行-日志';
COMMENT ON COLUMN XXL_JOB.xxl_job_log.job_group IS '执行器主键ID';
COMMENT ON COLUMN XXL_JOB.xxl_job_log.executor_address IS '执行器地址，本次执行的地址';
COMMENT ON COLUMN XXL_JOB.xxl_job_log.alarm_status IS '告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败';
COMMENT ON COLUMN XXL_JOB.xxl_job_log.executor_sharding_param IS '执行器任务分片参数，格式如 1/2';
COMMENT ON COLUMN XXL_JOB.xxl_job_log.trigger_msg IS '调度-日志';
COMMENT ON COLUMN XXL_JOB.xxl_job_log.job_id IS '任务，主键ID';
COMMENT ON COLUMN XXL_JOB.xxl_job_log.executor_fail_retry_count IS '失败重试次数';
COMMENT ON COLUMN XXL_JOB.xxl_job_log.trigger_code IS '调度-结果';
CREATE SEQUENCE XXL_JOB.SEQ_XXL_JOB_LOG_ID START WITH 1 INCREMENT BY 1;
ALTER TABLE XXL_JOB.xxl_job_log MODIFY id DEFAULT XXL_JOB.SEQ_XXL_JOB_LOG_ID.NEXTVAL;
CREATE TABLE XXL_JOB.xxl_job_log_report (
	id bigint,
	trigger_day timestamp,
	running_count bigint default 0,
	suc_count bigint default 0,
	fail_count bigint default 0,
	update_time timestamp
);
COMMENT ON COLUMN XXL_JOB.xxl_job_log_report.fail_count IS '执行失败-日志数量';
COMMENT ON COLUMN XXL_JOB.xxl_job_log_report.trigger_day IS '调度-时间';
COMMENT ON COLUMN XXL_JOB.xxl_job_log_report.running_count IS '运行中-日志数量';
COMMENT ON COLUMN XXL_JOB.xxl_job_log_report.suc_count IS '执行成功-日志数量';
CREATE SEQUENCE XXL_JOB.SEQ_XXL_JOB_LOG_REPORT_ID START WITH 1 INCREMENT BY 1;
ALTER TABLE XXL_JOB.xxl_job_log_report MODIFY id DEFAULT XXL_JOB.SEQ_XXL_JOB_LOG_REPORT_ID.NEXTVAL;
CREATE TABLE XXL_JOB.xxl_job_logglue (
	id bigint,
	job_id bigint,
	glue_type varchar(50 char),
	glue_source clob,
	glue_remark varchar(128 char),
	add_time timestamp,
	update_time timestamp
);
COMMENT ON COLUMN XXL_JOB.xxl_job_logglue.job_id IS '任务，主键ID';
COMMENT ON COLUMN XXL_JOB.xxl_job_logglue.glue_type IS 'GLUE类型';
COMMENT ON COLUMN XXL_JOB.xxl_job_logglue.glue_source IS 'GLUE源代码';
COMMENT ON COLUMN XXL_JOB.xxl_job_logglue.glue_remark IS 'GLUE备注';
CREATE SEQUENCE XXL_JOB.SEQ_XXL_JOB_LOGGLUE_ID START WITH 1 INCREMENT BY 1;
ALTER TABLE XXL_JOB.xxl_job_logglue MODIFY id DEFAULT XXL_JOB.SEQ_XXL_JOB_LOGGLUE_ID.NEXTVAL;
CREATE TABLE XXL_JOB.xxl_job_registry (
	id bigint,
	registry_group varchar(50 char),
	registry_key varchar(255 char),
	registry_value varchar(255 char),
	update_time timestamp
);
CREATE SEQUENCE XXL_JOB.SEQ_XXL_JOB_REGISTRY_ID START WITH 1 INCREMENT BY 1;
ALTER TABLE XXL_JOB.xxl_job_registry MODIFY id DEFAULT XXL_JOB.SEQ_XXL_JOB_REGISTRY_ID.NEXTVAL;
CREATE TABLE XXL_JOB.xxl_job_user (
	id bigint,
	username varchar(50 char),
	password varchar(50 char),
	role smallint,
	permission varchar(255 char)
);
COMMENT ON COLUMN XXL_JOB.xxl_job_user.username IS '账号';
COMMENT ON COLUMN XXL_JOB.xxl_job_user.password IS '密码';
COMMENT ON COLUMN XXL_JOB.xxl_job_user.role IS '角色：0-普通用户、1-管理员';
COMMENT ON COLUMN XXL_JOB.xxl_job_user.permission IS '权限：执行器ID列表，多个逗号分割';
CREATE SEQUENCE XXL_JOB.SEQ_XXL_JOB_USER_ID START WITH 2 INCREMENT BY 1;
ALTER TABLE XXL_JOB.xxl_job_user MODIFY id DEFAULT XXL_JOB.SEQ_XXL_JOB_USER_ID.NEXTVAL;


--创建表的非空约束语句
ALTER TABLE XXL_JOB.xxl_job_group modify id NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_group modify app_name NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_group modify title NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_group modify address_type NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_info modify id NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_info modify job_group NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_info modify job_desc NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_info modify schedule_type NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_info modify misfire_strategy NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_info modify executor_timeout NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_info modify executor_fail_retry_count NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_info modify glue_type NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_info modify trigger_status NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_info modify trigger_last_time NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_info modify trigger_next_time NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_lock modify lock_name NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_log modify id NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_log modify job_group NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_log modify job_id NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_log modify executor_fail_retry_count NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_log modify trigger_code NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_log modify handle_code NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_log modify alarm_status NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_log_report modify id NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_log_report modify running_count NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_log_report modify suc_count NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_log_report modify fail_count NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_logglue modify id NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_logglue modify job_id NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_logglue modify glue_remark NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_registry modify id NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_registry modify registry_group NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_registry modify registry_key NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_registry modify registry_value NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_user modify id NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_user modify username NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_user modify password NOT NULL;
ALTER TABLE XXL_JOB.xxl_job_user modify role NOT NULL;

--创建数据库内的索引
ALTER TABLE XXL_JOB.xxl_job_group ADD PRIMARY KEY (id);
ALTER TABLE XXL_JOB.xxl_job_info ADD PRIMARY KEY (id);
ALTER TABLE XXL_JOB.xxl_job_lock ADD PRIMARY KEY (lock_name);
ALTER TABLE XXL_JOB.xxl_job_log ADD PRIMARY KEY (id);
CREATE INDEX XXL_JOB.idx_xxl_job_log_trigger_time ON XXL_JOB.xxl_job_log (trigger_time);
CREATE INDEX XXL_JOB.idx_xxl_job_log_handle_code ON XXL_JOB.xxl_job_log (handle_code);
ALTER TABLE XXL_JOB.xxl_job_log_report ADD PRIMARY KEY (id);
CREATE UNIQUE INDEX XXL_JOB.idx_xxl_job_log_report_trigger_day ON XXL_JOB.xxl_job_log_report (trigger_day);
ALTER TABLE  XXL_JOB.xxl_job_log_report ADD CONSTRAINT idx_xxl_job_log_report_trigger_day UNIQUE (trigger_day);
ALTER TABLE XXL_JOB.xxl_job_logglue ADD PRIMARY KEY (id);
ALTER TABLE XXL_JOB.xxl_job_registry ADD PRIMARY KEY (id);
CREATE INDEX XXL_JOB.idx_xxl_job_registry_registry_group_registry_key_registry_value ON XXL_JOB.xxl_job_registry (registry_group, registry_key, registry_value);
ALTER TABLE XXL_JOB.xxl_job_user ADD PRIMARY KEY (id);
CREATE UNIQUE INDEX XXL_JOB.idx_xxl_job_user_username ON XXL_JOB.xxl_job_user (username);
ALTER TABLE  XXL_JOB.xxl_job_user ADD CONSTRAINT idx_xxl_job_user_username UNIQUE (username);

--创建外键约束

--创建视图




INSERT INTO XXL_JOB.XXL_JOB_GROUP (ID,APP_NAME,TITLE,ADDRESS_TYPE,ADDRESS_LIST,UPDATE_TIME) VALUES (1,'xxl-job-executor-sample','示例执行器',0,NULL,'2018-11-03 22:21:31.0');
INSERT INTO XXL_JOB.XXL_JOB_INFO (ID,JOB_GROUP,JOB_DESC,ADD_TIME,UPDATE_TIME,AUTHOR,ALARM_EMAIL,SCHEDULE_TYPE,SCHEDULE_CONF,MISFIRE_STRATEGY,EXECUTOR_ROUTE_STRATEGY,EXECUTOR_HANDLER,EXECUTOR_PARAM,EXECUTOR_BLOCK_STRATEGY,EXECUTOR_TIMEOUT,EXECUTOR_FAIL_RETRY_COUNT,GLUE_TYPE,GLUE_SOURCE,GLUE_REMARK,GLUE_UPDATETIME,CHILD_JOBID,TRIGGER_STATUS,TRIGGER_LAST_TIME,TRIGGER_NEXT_TIME) VALUES (1,1,'测试任务1','2018-11-03 22:21:31.0','2018-11-03 22:21:31.0','XXL',NULL,'CRON','0 0 0 * * ? *','DO_NOTHING','FIRST','demoJobHandler',NULL,'SERIAL_EXECUTION',0,0,'BEAN',NULL,'GLUE代码初始化','2018-11-03 22:21:31.0',NULL,0,0,0);

INSERT INTO XXL_JOB.XXL_JOB_USER (ID,USERNAME,PASSWORD,"ROLE",PERMISSION) VALUES (1,'admin','e10adc3949ba59abbe56e057f20f883e',1,NULL);


INSERT INTO XXL_JOB.XXL_JOB_LOCK (LOCK_NAME) VALUES ('schedule_lock');
