DROP TABLE IF EXISTS QRTZ_FIRED_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_PAUSED_TRIGGER_GRPS;
DROP TABLE IF EXISTS QRTZ_SCHEDULER_STATE;
DROP TABLE IF EXISTS QRTZ_LOCKS;
DROP TABLE IF EXISTS QRTZ_SIMPLE_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_SIMPROP_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_CRON_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_BLOB_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_JOB_DETAILS;
DROP TABLE IF EXISTS QRTZ_CALENDARS;

CREATE TABLE QRTZ_JOB_DETAILS(
SCHED_NAME VARCHAR(60) NOT NULL,
JOB_NAME VARCHAR(80) NOT NULL,
JOB_GROUP VARCHAR(80) NOT NULL,
DESCRIPTION VARCHAR(250) NULL,
JOB_CLASS_NAME VARCHAR(250) NOT NULL,
IS_DURABLE VARCHAR(1) NOT NULL,
IS_NONCONCURRENT VARCHAR(1) NOT NULL,
IS_UPDATE_DATA VARCHAR(1) NOT NULL,
REQUESTS_RECOVERY VARCHAR(1) NOT NULL,
JOB_DATA BLOB NULL,
PRIMARY KEY (SCHED_NAME,JOB_NAME,JOB_GROUP))
ENGINE=InnoDB;

CREATE TABLE QRTZ_TRIGGERS (
SCHED_NAME VARCHAR(60) NOT NULL,
TRIGGER_NAME VARCHAR(80) NOT NULL,
TRIGGER_GROUP VARCHAR(80) NOT NULL,
JOB_NAME VARCHAR(80) NOT NULL,
JOB_GROUP VARCHAR(80) NOT NULL,
DESCRIPTION VARCHAR(250) NULL,
NEXT_FIRE_TIME BIGINT(13) NULL,
PREV_FIRE_TIME BIGINT(13) NULL,
PRIORITY INTEGER NULL,
TRIGGER_STATE VARCHAR(16) NOT NULL,
TRIGGER_TYPE VARCHAR(8) NOT NULL,
START_TIME BIGINT(13) NOT NULL,
END_TIME BIGINT(13) NULL,
CALENDAR_NAME VARCHAR(80) NULL,
MISFIRE_INSTR SMALLINT(2) NULL,
JOB_DATA BLOB NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)
REFERENCES QRTZ_JOB_DETAILS(SCHED_NAME,JOB_NAME,JOB_GROUP))
ENGINE=InnoDB;

CREATE TABLE QRTZ_SIMPLE_TRIGGERS (
SCHED_NAME VARCHAR(60) NOT NULL,
TRIGGER_NAME VARCHAR(80) NOT NULL,
TRIGGER_GROUP VARCHAR(80) NOT NULL,
REPEAT_COUNT BIGINT(7) NOT NULL,
REPEAT_INTERVAL BIGINT(12) NOT NULL,
TIMES_TRIGGERED BIGINT(10) NOT NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
ENGINE=InnoDB;

CREATE TABLE QRTZ_CRON_TRIGGERS (
SCHED_NAME VARCHAR(60) NOT NULL,
TRIGGER_NAME VARCHAR(80) NOT NULL,
TRIGGER_GROUP VARCHAR(80) NOT NULL,
CRON_EXPRESSION VARCHAR(120) NOT NULL,
TIME_ZONE_ID VARCHAR(80),
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
ENGINE=InnoDB;

CREATE TABLE QRTZ_SIMPROP_TRIGGERS
  (          
    SCHED_NAME VARCHAR(60) NOT NULL,
    TRIGGER_NAME VARCHAR(80) NOT NULL,
    TRIGGER_GROUP VARCHAR(80) NOT NULL,
    STR_PROP_1 VARCHAR(512) NULL,
    STR_PROP_2 VARCHAR(512) NULL,
    STR_PROP_3 VARCHAR(512) NULL,
    INT_PROP_1 INT NULL,
    INT_PROP_2 INT NULL,
    LONG_PROP_1 BIGINT NULL,
    LONG_PROP_2 BIGINT NULL,
    DEC_PROP_1 NUMERIC(13,4) NULL,
    DEC_PROP_2 NUMERIC(13,4) NULL,
    BOOL_PROP_1 VARCHAR(1) NULL,
    BOOL_PROP_2 VARCHAR(1) NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP) 
    REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
ENGINE=InnoDB;

CREATE TABLE QRTZ_BLOB_TRIGGERS (
SCHED_NAME VARCHAR(60) NOT NULL,
TRIGGER_NAME VARCHAR(80) NOT NULL,
TRIGGER_GROUP VARCHAR(80) NOT NULL,
BLOB_DATA BLOB NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
INDEX (SCHED_NAME,TRIGGER_NAME, TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
ENGINE=InnoDB;

CREATE TABLE QRTZ_CALENDARS (
SCHED_NAME VARCHAR(60) NOT NULL,
CALENDAR_NAME VARCHAR(80) NOT NULL,
CALENDAR BLOB NOT NULL,
PRIMARY KEY (SCHED_NAME,CALENDAR_NAME))
ENGINE=InnoDB;

CREATE TABLE QRTZ_PAUSED_TRIGGER_GRPS (
SCHED_NAME VARCHAR(60) NOT NULL,
TRIGGER_GROUP VARCHAR(80) NOT NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_GROUP))
ENGINE=InnoDB;

CREATE TABLE QRTZ_FIRED_TRIGGERS (
SCHED_NAME VARCHAR(60) NOT NULL,
ENTRY_ID VARCHAR(95) NOT NULL,
TRIGGER_NAME VARCHAR(80) NOT NULL,
TRIGGER_GROUP VARCHAR(80) NOT NULL,
INSTANCE_NAME VARCHAR(80) NOT NULL,
FIRED_TIME BIGINT(13) NOT NULL,
SCHED_TIME BIGINT(13) NOT NULL,
PRIORITY INTEGER NOT NULL,
STATE VARCHAR(16) NOT NULL,
JOB_NAME VARCHAR(80) NULL,
JOB_GROUP VARCHAR(80) NULL,
IS_NONCONCURRENT VARCHAR(1) NULL,
REQUESTS_RECOVERY VARCHAR(1) NULL,
PRIMARY KEY (SCHED_NAME,ENTRY_ID))
ENGINE=InnoDB;

CREATE TABLE QRTZ_SCHEDULER_STATE (
SCHED_NAME VARCHAR(60) NOT NULL,
INSTANCE_NAME VARCHAR(80) NOT NULL,
LAST_CHECKIN_TIME BIGINT(13) NOT NULL,
CHECKIN_INTERVAL BIGINT(13) NOT NULL,
PRIMARY KEY (SCHED_NAME,INSTANCE_NAME))
ENGINE=InnoDB;

CREATE TABLE QRTZ_LOCKS (
SCHED_NAME VARCHAR(60) NOT NULL,
LOCK_NAME VARCHAR(40) NOT NULL,
PRIMARY KEY (SCHED_NAME,LOCK_NAME))
ENGINE=InnoDB;

CREATE INDEX IDX_QRTZ_J_REQ_RECOVERY ON QRTZ_JOB_DETAILS(SCHED_NAME,REQUESTS_RECOVERY);
CREATE INDEX IDX_QRTZ_J_GRP ON QRTZ_JOB_DETAILS(SCHED_NAME,JOB_GROUP);

CREATE INDEX IDX_QRTZ_T_J ON QRTZ_TRIGGERS(SCHED_NAME,JOB_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_T_JG ON QRTZ_TRIGGERS(SCHED_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_T_C ON QRTZ_TRIGGERS(SCHED_NAME,CALENDAR_NAME);
CREATE INDEX IDX_QRTZ_T_G ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_GROUP);
CREATE INDEX IDX_QRTZ_T_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_N_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_N_G_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_GROUP,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_NEXT_FIRE_TIME ON QRTZ_TRIGGERS(SCHED_NAME,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_ST ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_STATE,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_MISFIRE ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_ST_MISFIRE ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_NFT_ST_MISFIRE_GRP ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_GROUP,TRIGGER_STATE);

CREATE INDEX IDX_QRTZ_FT_TRIG_INST_NAME ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,INSTANCE_NAME);
CREATE INDEX IDX_QRTZ_FT_INST_JOB_REQ_RCVRY ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,INSTANCE_NAME,REQUESTS_RECOVERY);
CREATE INDEX IDX_QRTZ_FT_J_G ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,JOB_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_FT_JG ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_FT_T_G ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP);
CREATE INDEX IDX_QRTZ_FT_TG ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,TRIGGER_GROUP);

/*==============================================================*/
/* Table: cms_ad                                                */
/*==============================================================*/
create table cms_ad
(
   f_ad_id              int not null,
   f_site_id            int not null,
   f_adslot_id          int not null,
   f_name               varchar(150) not null comment '名称',
   f_begin_date         datetime comment '开始时间',
   f_end_date           datetime comment '结束时间',
   f_url                varchar(255) comment '广告url',
   f_text               varchar(255) comment '文字',
   f_script             mediumtext comment '代码',
   f_image              varchar(255) comment '图片',
   f_flash              varchar(255) comment 'flash',
   f_seq                int not null default 1 comment '排序',
   primary key (f_ad_id)
)
engine = innodb;

alter table cms_ad comment '广告表';

/*==============================================================*/
/* Table: cms_ad_slot                                           */
/*==============================================================*/
create table cms_ad_slot
(
   f_adslot_id          int not null,
   f_site_id            int not null,
   f_name               varchar(100) not null comment '名称',
   f_number             varchar(100) comment '编码',
   f_description        varchar(255) comment '描述',
   f_type               int not null comment '类型(1:文字,2:图片,3:FLASH,4:代码)',
   f_template           varchar(255) not null comment '模板',
   f_width              int not null comment '宽度',
   f_height             int not null comment '高度',
   primary key (f_adslot_id)
)
engine = innodb;

alter table cms_ad_slot comment '广告版位表';

/*==============================================================*/
/* Table: cms_attachment                                        */
/*==============================================================*/
create table cms_attachment
(
   f_attachment_id      int not null,
   f_site_id            int not null comment '站点',
   f_user_id            int not null comment '上传人',
   f_name               varchar(150) not null comment '文件名',
   f_length             bigint comment '文件长度',
   f_ip                 varchar(100) comment 'IP',
   f_time               datetime not null comment '时间',
   primary key (f_attachment_id)
)
engine = innodb;

alter table cms_attachment comment '附件表';

/*==============================================================*/
/* Table: cms_attachment_ref                                    */
/*==============================================================*/
create table cms_attachment_ref
(
   f_attachementref_id  int not null,
   f_site_id            int not null,
   f_attachment_id      int not null,
   f_ftype              varchar(100) not null comment '外表标识',
   f_fid                int not null comment '外表ID',
   primary key (f_attachementref_id)
)
engine = innodb;

/*==============================================================*/
/* Table: cms_attribute                                         */
/*==============================================================*/
create table cms_attribute
(
   f_attribute_id       int not null,
   f_site_id            int not null comment '站点',
   f_number             varchar(20) not null comment '代码',
   f_name               varchar(50) not null comment '名称',
   f_seq                int not null default 2147483647 comment '排序',
   f_is_with_image      char(1) not null default '0' comment '是否包含图片',
   f_is_scale           char(1) not null default '0' comment '是否图片压缩',
   f_is_exact           char(1) not null default '0' comment '是否图片拉伸',
   f_is_watermark       char(1) not null default '0' comment '是否图片水印',
   f_image_width        int comment '图片宽度',
   f_image_height       int comment '图片高度',
   primary key (f_attribute_id)
)
engine = innodb;

alter table cms_attribute comment '属性表';

/*==============================================================*/
/* Table: cms_collect                                           */
/*==============================================================*/
create table cms_collect
(
   f_collect_id         int not null,
   f_node_id            int not null,
   f_site_id            int not null,
   f_user_id            int not null,
   f_name               varchar(100) not null comment '名称',
   f_charset            varchar(100) not null default 'UTF-8' comment '字符集',
   f_user_agent         varchar(255) not null default 'Mozilla/5.0' comment '用户代理',
   f_interval_min       int not null default 0 comment '最小间隔时间',
   f_interval_max       int not null default 0 comment '最大间隔时间',
   f_list_pattern       varchar(2000) not null comment '列表地址',
   f_list_next_pattern  varchar(255) comment '下一页列表地址',
   f_is_list_next_reg   char(1) not null default '0' comment '下一页列表地址是否正则',
   f_item_area_pattern  varchar(255) comment '文章地址区域',
   f_is_item_area_reg   char(1) not null default '0' comment '文章地址区域是否正则',
   f_item_pattern       varchar(255) not null comment '文章地址',
   f_is_item_reg        char(1) not null default '0' comment '文章地址是否正则',
   f_block_area_pattern varchar(255) comment '文章块区域',
   f_is_block_area_reg  char(1) not null default '0' comment '文章快区域是否正则',
   f_block_pattern      varchar(255) comment '文章块',
   f_is_block_reg       char(1) not null default '0' comment '文章块是否正则',
   f_page_begin         int not null default 2 comment '起始序号',
   f_page_end           int not null default 10 comment '结束序号',
   f_is_desc            char(1) not null default '1' comment '是否倒序',
   f_is_submit          char(1) not null default '0' comment '是否提交',
   f_is_allow_duplicate char(1) not null default '0' comment '是否允许重复标题',
   f_status             int not null default 0 comment '状态(0:就绪,1:运行中,2:暂停)',
   primary key (f_collect_id)
)
engine = innodb;

alter table cms_collect comment '采集表';

/*==============================================================*/
/* Table: cms_collect_field                                     */
/*==============================================================*/
create table cms_collect_field
(
   f_collectfield_id    int not null,
   f_collect_id         int not null,
   f_site_id            int not null,
   f_name               varchar(100) not null comment '名称',
   f_code               varchar(100) not null comment '代码',
   f_type               int not null default 1 comment '类型(1;系统字段,2:custom字段,3:clob字段)',
   f_source_type        int not null default 1 comment '来源(1:详细页,2:列表页,3:固定值,4:URL)',
   f_source_url         varchar(255) comment '来源URL',
   f_source_text        varchar(255) comment '来源文本',
   f_data_area_pattern  varchar(255) comment '数据区域',
   f_is_data_area_reg   char(1) not null default '0' comment '数据区域是否正则',
   f_data_pattern       varchar(255) comment '匹配规则',
   f_is_data_reg        char(1) not null default '0' comment '匹配规则是否正则',
   f_date_format        varchar(255) comment '日期格式',
   f_download_type      varchar(20) comment '下载类型(为空不下载)',
   f_image_param        varchar(255) comment '图片参数',
   f_filter             varchar(2000) comment '过滤规则',
   f_seq                int not null default 2147483647 comment '排列顺序',
   primary key (f_collectfield_id)
)
engine = innodb;

alter table cms_collect_field comment '采集字段表';

/*==============================================================*/
/* Table: cms_collect_log                                       */
/*==============================================================*/
create table cms_collect_log
(
   f_collectlog_id      int not null,
   f_site_id            int not null,
   f_url                varchar(255) not null comment '采集地址',
   f_title              varchar(255) comment '标题',
   f_message            varchar(255) comment '消息',
   f_time               datetime not null comment '时间',
   f_status             int not null default 0 comment '状态(0:成功,1:失败)',
   primary key (f_collectlog_id)
)
engine = innodb;

alter table cms_collect_log comment '采集日志表';

/*==============================================================*/
/* Table: cms_comment                                           */
/*==============================================================*/
create table cms_comment
(
   f_comment_id         int not null,
   f_parent_id          int comment '父评论ID',
   f_site_id            int not null comment '站点ID',
   f_creator_id         int not null comment '创建人',
   f_auditor_id         int comment '审核人',
   f_ftype              varchar(50) not null comment '外表标识',
   f_fid                int not null comment '外表ID',
   f_creation_date      datetime not null comment '评论时间',
   f_audit_date         datetime comment '审核时间',
   f_ip                 varchar(100) not null default 'localhost' comment 'IP地址',
   f_score              int not null default 0 comment '得分',
   f_status             int not null default 0 comment '0:未审核;1:已审核;2:推荐;3:屏蔽',
   f_text               mediumtext,
   primary key (f_comment_id)
)
engine = innodb;

alter table cms_comment comment '评论表';

/*==============================================================*/
/* Table: cms_friendlink                                        */
/*==============================================================*/
create table cms_friendlink
(
   f_friendlink_id      int not null,
   f_friendlinktype_id  int not null,
   f_site_id            int not null,
   f_name               varchar(100) not null comment '网站名称',
   f_url                varchar(255) not null comment '网站地址',
   f_seq                int not null default 2147483647 comment '排序',
   f_logo               varchar(255) comment '网站Logo',
   f_description        varchar(255) comment '网站描述',
   f_email              varchar(100) comment '站长Email',
   f_is_with_logo       char(1) not null default '0' comment '是否带Logo',
   f_is_recommend       char(1) not null default '0' comment '是否推荐',
   f_status             int not null default 0 comment '状态(0:已审核,1:未审核)',
   primary key (f_friendlink_id)
)
engine = innodb;

alter table cms_friendlink comment '友情链接表';

/*==============================================================*/
/* Table: cms_friendlink_type                                   */
/*==============================================================*/
create table cms_friendlink_type
(
   f_friendlinktype_id  int not null,
   f_site_id            int not null,
   f_name               varchar(100) not null comment '名称',
   f_number             varchar(100) comment '编码',
   f_seq                int not null default 2147483647 comment '排序',
   primary key (f_friendlinktype_id)
)
engine = innodb;

alter table cms_friendlink_type comment '友情链接类型表';

/*==============================================================*/
/* Table: cms_global                                            */
/*==============================================================*/
create table cms_global
(
   f_global_id          int not null,
   f_protocol           varchar(50) not null default 'http' comment '协议',
   f_port               int comment '服务端口号',
   f_context_path       varchar(255) comment '上下文路径',
   f_is_with_domain     char(1) not null default '0' comment '是否URL包含域名',
   f_uploads_publishpoint_id int comment '附件发布点',
   f_captcha_errors     int not null default 3 comment '需要验证码的错误次数(总是需要则为0)',
   f_version            varchar(50) not null comment 'jspxcms版本号',
   primary key (f_global_id)
)
engine = innodb;

alter table cms_global comment '全局表';

/*==============================================================*/
/* Table: cms_global_clob                                       */
/*==============================================================*/
create table cms_global_clob
(
   f_global_id          int not null,
   f_key                varchar(50) not null comment '键',
   f_value              mediumtext comment '值'
)
engine = innodb;

alter table cms_global_clob comment '全局大字段表';

/*==============================================================*/
/* Table: cms_global_custom                                     */
/*==============================================================*/
create table cms_global_custom
(
   f_global_id          int not null,
   f_key                varchar(50) not null comment '键',
   f_value              varchar(2000) comment '值'
)
engine = innodb;

alter table cms_global_custom comment '全局自定义表';

/*==============================================================*/
/* Table: cms_guestbook                                         */
/*==============================================================*/
create table cms_guestbook
(
   f_guestbook_id       int not null,
   f_site_id            int not null comment '站点',
   f_guestbooktype_id   int not null comment '留言类型',
   f_creator_id         int not null comment '创建者',
   f_replyer_id         int comment '回复者',
   f_title              varchar(150) comment '留言标题',
   f_text               mediumtext comment '留言内容',
   f_creation_date      datetime not null comment '留言日期',
   f_creation_ip        varchar(100) not null comment '留言IP',
   f_reply_text         mediumtext comment '回复内容',
   f_reply_date         datetime comment '回复日期',
   f_reply_ip           varchar(100) comment '回复IP',
   f_is_reply           char(1) not null default '0' comment '是否回复',
   f_is_recommend       char(1) not null default '0' comment '是否推荐',
   f_status             int not null default 0 comment '状态(0:已审核,1:未审核,2:屏蔽)',
   f_username           varchar(100) comment '用户名',
   f_gender             char(1) comment '性别',
   f_phone              varchar(100) comment '电话',
   f_mobile             varchar(100) comment '手机',
   f_qq                 varchar(100) comment 'QQ号码',
   f_email              varchar(100) comment '电子邮箱',
   primary key (f_guestbook_id)
)
engine = innodb;

alter table cms_guestbook comment '留言板表';

/*==============================================================*/
/* Table: cms_guestbook_type                                    */
/*==============================================================*/
create table cms_guestbook_type
(
   f_guestbooktype_id   int not null,
   f_site_id            int not null comment '站点',
   f_name               varchar(100) not null comment '名称',
   f_number             varchar(100) comment '编码',
   f_seq                int not null default 2147483647 comment '排序',
   f_description        varchar(255) comment '描述',
   primary key (f_guestbooktype_id)
)
engine = innodb;

alter table cms_guestbook_type comment '留言板类型表';

/*==============================================================*/
/* Table: cms_info                                              */
/*==============================================================*/
create table cms_info
(
   f_info_id            int not null,
   f_org_id             int not null comment '组织',
   f_creator_id         int not null comment '创建者',
   f_site_id            int not null comment '站点',
   f_node_id            int not null comment '栏目',
   f_publish_date       datetime not null comment '发布日期',
   f_off_date           datetime comment '关闭日期',
   f_priority           tinyint not null default 0 comment '优先级',
   f_is_with_image      char(1) not null default '0' comment '是否包含图片',
   f_views              int not null default 0 comment '浏览总数',
   f_downloads          int not null default 0 comment '下载总数',
   f_comments           int not null default 0 comment '评论总数',
   f_diggs              int not null default 0 comment '顶',
   f_score              int not null default 0 comment '得分',
   f_status             char(1) not null default 'A' comment '状态(0:发起者,1-9:审核中,A:已发布,B:草稿,C:投稿,D:退稿,E:采集,F:待发布,G:已过期,X:回收站,Z:归档)',
   f_p0                 tinyint comment '自定义0',
   f_p1                 tinyint comment '自定义1',
   f_p2                 tinyint comment '自定义2',
   f_p3                 tinyint comment '自定义3',
   f_p4                 tinyint comment '自定义4',
   f_p5                 tinyint comment '自定义5',
   f_p6                 tinyint comment '自定义6',
   f_html_status        char(1) not null default '0' comment 'HTML状态(0:未开启,1:待生成,2:待更新,3:已生成)',
   primary key (f_info_id)
)
engine = innodb;

alter table cms_info comment '文档表';

/*==============================================================*/
/* Table: cms_info_attribute                                    */
/*==============================================================*/
create table cms_info_attribute
(
   f_infoattr_id        int not null,
   f_info_id            int not null comment '文档',
   f_attribute_id       int not null comment '属性',
   f_image              varchar(255) comment '属性图片',
   primary key (f_infoattr_id)
)
engine = innodb;

alter table cms_info_attribute comment '文档与属性关联表';

/*==============================================================*/
/* Table: cms_info_buffer                                       */
/*==============================================================*/
create table cms_info_buffer
(
   f_info_id            int not null,
   f_views              int not null default 0 comment '浏览次数',
   f_downloads          int not null default 0 comment '下载次数',
   f_comments           int not null default 0 comment '评论次数',
   f_involveds          int not null default 0 comment '评论参与人数',
   f_diggs              int not null default 0 comment '顶',
   f_burys              int not null default 0 comment '踩',
   f_score              int not null default 0 comment '得分',
   primary key (f_info_id)
)
engine = innodb;

alter table cms_info_buffer comment '文档缓冲表';

/*==============================================================*/
/* Table: cms_info_clob                                         */
/*==============================================================*/
create table cms_info_clob
(
   f_info_id            int not null,
   f_key                varchar(50) not null comment '键',
   f_value              mediumtext comment '值'
)
engine = innodb;

alter table cms_info_clob comment '文档大字段表';

/*==============================================================*/
/* Table: cms_info_custom                                       */
/*==============================================================*/
create table cms_info_custom
(
   f_info_id            int not null,
   f_key                varchar(50) not null comment '键',
   f_value              varchar(2000) comment '值'
)
engine = innodb;

alter table cms_info_custom comment '文档自定义表';

/*==============================================================*/
/* Table: cms_info_detail                                       */
/*==============================================================*/
create table cms_info_detail
(
   f_info_id            int not null,
   f_title              varchar(150) not null comment '主标题',
   f_html               varchar(255) comment 'HTML页面',
   f_subtitle           varchar(150) comment '副标题',
   f_full_title         varchar(150) comment '完整标题',
   f_link               varchar(255) comment '转向链接',
   f_is_new_window      char(1) comment '是否在新窗口打开',
   f_color              varchar(50) comment '颜色',
   f_is_strong          char(1) not null default '0' comment '是否粗体',
   f_is_em              char(1) not null default '0' comment '是否斜体',
   f_info_path          varchar(255) comment '文档路径',
   f_info_template      varchar(255) comment '文档模板',
   f_meta_description   varchar(450) comment 'meta描述',
   f_source             varchar(50) comment '来源名称',
   f_source_url         varchar(255) comment '来源url',
   f_author             varchar(50) comment '作者',
   f_small_image        varchar(255) comment '小图',
   f_large_image        varchar(255) comment '大图',
   f_video              varchar(255) comment '视频url',
   f_video_name         varchar(255) comment '视频名称',
   f_video_length       bigint comment '视频长度',
   f_video_time         varchar(100) comment '视频时间',
   f_file               varchar(255) comment '文件url',
   f_file_name          varchar(255) comment '文件名称',
   f_file_length        bigint comment '文件长度',
   f_doc                varchar(255) comment '文库url',
   f_doc_name           varchar(255) comment '文库名称',
   f_doc_length         varchar(255) comment '文库长度',
   f_doc_pdf            varchar(255) comment '文库PDF',
   f_doc_swf            varchar(255) comment '文库SWF',
   f_is_allow_comment   char(1) comment '是否允许评论',
   f_step_name          varchar(100) comment '审核步骤名称',
   primary key (f_info_id)
)
engine = innodb;

alter table cms_info_detail comment '文档详细表';

/*==============================================================*/
/* Table: cms_info_file                                         */
/*==============================================================*/
create table cms_info_file
(
   f_info_id            int not null,
   f_name               varchar(150) not null comment '文件名称',
   f_length             bigint not null default 0 comment '文件长度',
   f_file               varchar(255) not null comment '文件地址',
   f_index              int not null default 0 comment '文件序号',
   f_downloads          int not null default 0 comment '下载次数'
)
engine = innodb;

alter table cms_info_file comment '文档附件集表';

/*==============================================================*/
/* Table: cms_info_image                                        */
/*==============================================================*/
create table cms_info_image
(
   f_info_id            int not null,
   f_name               varchar(150) comment '图片名称',
   f_image              varchar(255) comment '图片地址',
   f_index              int not null default 0 comment '图片序号',
   f_text               mediumtext comment '图片正文'
)
engine = innodb;

alter table cms_info_image comment '文档图片集表';

/*==============================================================*/
/* Table: cms_info_membergroup                                  */
/*==============================================================*/
create table cms_info_membergroup
(
   f_infomgroup_id      int not null,
   f_membergroup_id     int not null,
   f_info_id            int not null,
   f_is_view_perm       char(1) not null default '0' comment '是否有浏览权限',
   primary key (f_infomgroup_id)
)
engine = innodb;

alter table cms_info_membergroup comment '文档与会员组权限表';

/*==============================================================*/
/* Table: cms_info_node                                         */
/*==============================================================*/
create table cms_info_node
(
   f_infonode_id        int not null,
   f_info_id            int not null comment '文档',
   f_node_id            int not null comment '栏目',
   f_node_index         int not null default 0 comment '栏目顺序',
   primary key (f_infonode_id)
)
engine = innodb;

alter table cms_info_node comment '文档与栏目关联表';

/*==============================================================*/
/* Table: cms_info_org                                          */
/*==============================================================*/
create table cms_info_org
(
   f_infoorg_id         int not null,
   f_info_id            int not null,
   f_org_id             int not null,
   f_is_view_perm       char(1) not null default '0' comment '是否有浏览权限',
   primary key (f_infoorg_id)
)
engine = innodb;

alter table cms_info_org comment '文档与组织权限表';

/*==============================================================*/
/* Table: cms_info_special                                      */
/*==============================================================*/
create table cms_info_special
(
   f_infospecial_id     int not null,
   f_info_id            int not null comment '文档',
   f_special_id         int not null comment '专题',
   f_special_index      int not null comment '专题序号',
   primary key (f_infospecial_id)
)
engine = innodb;

alter table cms_info_special comment '文档与专题关联表';

/*==============================================================*/
/* Table: cms_info_tag                                          */
/*==============================================================*/
create table cms_info_tag
(
   f_infotag_id         int not null,
   f_info_id            int not null comment '文档',
   f_tag_id             int not null comment 'tag',
   f_tag_index          int not null comment 'tag序号',
   primary key (f_infotag_id)
)
engine = innodb;

alter table cms_info_tag comment '文档与tag关联表';

/*==============================================================*/
/* Table: cms_member_group                                      */
/*==============================================================*/
create table cms_member_group
(
   f_membergroup_id     int not null,
   f_name               varchar(100) not null,
   f_description        varchar(255),
   f_ip                 mediumtext comment 'IP',
   f_type               int not null default 0 comment '类型(0:普通组,1:游客组,2:IP组,3:待验证组)',
   f_seq                int not null default 2147483647 comment '排序',
   primary key (f_membergroup_id)
)
engine = innodb;

alter table cms_member_group comment '会员组表';

/*==============================================================*/
/* Table: cms_model                                             */
/*==============================================================*/
create table cms_model
(
   f_model_id           int not null,
   f_site_id            int not null comment '站点',
   f_type               varchar(100) not null comment '类型(info:文档,node:栏目,node_home:首页;special:专题)',
   f_name               varchar(50) not null comment '名称',
   f_number             varchar(100) comment '代码',
   f_seq                int not null default 10 comment '顺序',
   primary key (f_model_id)
)
engine = innodb;

alter table cms_model comment '模型表';

/*==============================================================*/
/* Table: cms_model_custom                                      */
/*==============================================================*/
create table cms_model_custom
(
   f_model_id           int not null,
   f_key                varchar(50) not null comment '键',
   f_value              varchar(2000) comment '值'
)
engine = innodb;

alter table cms_model_custom comment '模型自定义表';

/*==============================================================*/
/* Table: cms_model_field                                       */
/*==============================================================*/
create table cms_model_field
(
   f_modefiel_id        int not null,
   f_model_id           int not null comment '模型',
   f_type               int not null comment '输入类型',
   f_inner_type         int not null default 0 comment '内部类型(0:用户自定义字段;1:系统定义字段;2:预留大文本字段;3:预留可查询字段)',
   f_label              varchar(50) not null comment '字段标签',
   f_name               varchar(50) not null comment '字段名称',
   f_prompt             varchar(255) comment '提示信息',
   f_def_value          varchar(255) comment '默认值',
   f_is_required        char(1) not null default '0' comment '是否必填项',
   f_seq                int not null default 10 comment '顺序',
   f_is_dbl_column      char(1) not null default '0' comment '是否双列布局',
   f_is_disabled        char(1) not null default '0' comment '是否禁用',
   primary key (f_modefiel_id)
)
engine = innodb;

alter table cms_model_field comment '模型字段表';

/*==============================================================*/
/* Table: cms_model_field_custom                                */
/*==============================================================*/
create table cms_model_field_custom
(
   f_modefiel_id        int not null,
   f_key                varchar(50) not null comment '键',
   f_value              varchar(2000) comment '值'
)
engine = innodb;

alter table cms_model_field_custom comment '模型字段自定义信息表';

/*==============================================================*/
/* Table: cms_node                                              */
/*==============================================================*/
create table cms_node
(
   f_node_id            int not null,
   f_site_id            int not null comment '站点',
   f_parent_id          int comment '栏目点',
   f_creator_id         int not null comment '创建者',
   f_node_model_id      int not null comment '栏目模型',
   f_workflow_id        int comment '流程',
   f_info_model_id      int comment '文档模型',
   f_number             varchar(100) comment '代码',
   f_name               varchar(150) not null comment '名称',
   f_tree_number        varchar(100) not null default '0000' comment '树编码',
   f_tree_level         int not null default 0 comment '树级别',
   f_tree_max           varchar(10) not null default '0000' comment '树子节点最大编码',
   f_creation_date      datetime not null comment '创建时间',
   f_refers             int not null default 0 comment '文档数量',
   f_views              int not null default 0 comment '浏览总数',
   f_is_real_node       char(1) not null default '1' comment '是否真实栏目',
   f_is_hidden          char(1) not null default '0' comment '是否隐藏',
   f_html_status        char(1) not null default '0' comment 'HTML状态(0:未开启,1:待生成,2:待更新,3:已生成)',
   f_p0                 tinyint comment '自定义0',
   f_p1                 tinyint comment '自定义1',
   f_p2                 tinyint comment '自定义2',
   f_p3                 tinyint comment '自定义3',
   f_p4                 tinyint comment '自定义4',
   f_p5                 tinyint comment '自定义5',
   f_p6                 tinyint comment '自定义6',
   primary key (f_node_id)
)
engine = innodb;

alter table cms_node comment '栏目表';

/*==============================================================*/
/* Table: cms_node_buffer                                       */
/*==============================================================*/
create table cms_node_buffer
(
   f_node_id            int not null,
   f_views              int not null comment '浏览次数',
   primary key (f_node_id)
)
engine = innodb;

alter table cms_node_buffer comment '栏目缓冲表';

/*==============================================================*/
/* Table: cms_node_clob                                         */
/*==============================================================*/
create table cms_node_clob
(
   f_node_id            int not null,
   f_key                varchar(50) not null comment '键',
   f_value              mediumtext comment '值'
)
engine = innodb;

alter table cms_node_clob comment '栏目大字段表';

/*==============================================================*/
/* Table: cms_node_custom                                       */
/*==============================================================*/
create table cms_node_custom
(
   f_node_id            int not null,
   f_key                varchar(50) not null comment '键',
   f_value              varchar(2000) comment '值'
)
engine = innodb;

alter table cms_node_custom comment '栏目自定义表';

/*==============================================================*/
/* Table: cms_node_detail                                       */
/*==============================================================*/
create table cms_node_detail
(
   f_node_id            int not null,
   f_link               varchar(255) comment '转向链接',
   f_html               varchar(255) comment 'HTML页面',
   f_meta_keywords      varchar(150) comment '关键字',
   f_meta_description   varchar(450) comment '描述',
   f_is_new_window      char(1) comment '是否在新窗口打开',
   f_node_template      varchar(255) comment '栏目模板',
   f_info_template      varchar(255) comment '文档模板',
   f_is_generate_node   char(1) comment '是否生成栏目页',
   f_is_generate_info   char(1) comment '是否生成文档页',
   f_node_extension     varchar(10) comment '栏目页扩展名',
   f_info_extension     varchar(10) comment '文档页扩展名',
   f_node_path          varchar(100) comment '栏目路径',
   f_info_path          varchar(100) comment '文档路径',
   f_is_def_page        char(1) comment '是否默认页',
   f_static_method      int comment '静态页生成方式(0:手动生成;1:自动生成栏目页;2:自动生成文档页及栏目页;3:自动生成文档页、栏目页、父栏目页、首页)',
   f_static_page        int comment '栏目列表静态化页数',
   f_small_image        varchar(255) comment '小图',
   f_large_image        varchar(255) comment '大图',
   primary key (f_node_id)
)
engine = innodb;

alter table cms_node_detail comment '栏目详细表';

/*==============================================================*/
/* Table: cms_node_membergroup                                  */
/*==============================================================*/
create table cms_node_membergroup
(
   f_nodemgroup_id      int not null,
   f_node_id            int not null,
   f_membergroup_id     int not null,
   f_is_view_perm       char(1) not null default '1' comment '是否有浏览权限',
   f_is_contri_perm     char(1) not null default '1' comment '是否有投稿权限',
   f_is_comment_perm    char(1) not null default '1' comment '是否有评论权限',
   primary key (f_nodemgroup_id)
)
engine = innodb;

alter table cms_node_membergroup comment '栏目与用户组权限表';

/*==============================================================*/
/* Table: cms_node_org                                          */
/*==============================================================*/
create table cms_node_org
(
   f_nodeorg_id         int not null,
   f_org_id             int not null,
   f_node_id            int not null,
   f_is_view_perm       char(1) not null default '0' comment '是否有浏览权限',
   primary key (f_nodeorg_id)
)
engine = innodb;

alter table cms_node_org comment '栏目与组织权限表';

/*==============================================================*/
/* Table: cms_node_role                                         */
/*==============================================================*/
create table cms_node_role
(
   f_noderole_id        int not null,
   f_node_id            int not null,
   f_role_id            int not null,
   f_is_node_perm       char(1) not null default '1' comment '栏目权限',
   f_is_info_perm       char(1) not null default '1' comment '文档权限',
   primary key (f_noderole_id)
)
engine = innodb;

alter table cms_node_role comment '栏目与角色权限表';

/*==============================================================*/
/* Table: cms_operation_log                                     */
/*==============================================================*/
create table cms_operation_log
(
   f_operation_id       int not null,
   f_user_id            int not null comment '操作人',
   f_site_id            int not null comment '站点',
   f_name               varchar(150) not null comment '名称',
   f_data_id            int comment '数据ID',
   f_description        varchar(255) comment '描述',
   f_text               mediumtext comment '详情',
   f_ip                 varchar(100) not null comment 'IP',
   f_time               datetime not null comment '时间',
   f_type               int not null default 1 comment '类型(1:操作日志,2:登录日志,3:登录失败)',
   primary key (f_operation_id)
)
engine = innodb;

alter table cms_operation_log comment '操作日志表';

/*==============================================================*/
/* Table: cms_org                                               */
/*==============================================================*/
create table cms_org
(
   f_org_id             int not null,
   f_parent_id          int comment '上级组织',
   f_name               varchar(150) not null comment '名称',
   f_full_name          varchar(150) comment '全称',
   f_description        varchar(255) comment '描述',
   f_contacts           varchar(100) comment '联系人',
   f_number             varchar(100) comment '编码',
   f_phone              varchar(100) comment '电话',
   f_fax                varchar(100) comment '传真',
   f_address            varchar(255) comment '地址',
   f_tree_number        varchar(100) not null default '0000' comment '树编码',
   f_tree_level         int not null default 0 comment '树级别',
   f_tree_max           varchar(10) not null default '0000' comment '树子节点最大编码',
   primary key (f_org_id)
)
engine = innodb;

alter table cms_org comment '组织表';

/*==============================================================*/
/* Table: cms_publish_point                                     */
/*==============================================================*/
create table cms_publish_point
(
   f_publishpoint_id    int not null,
   f_global_id          int not null,
   f_name               varchar(100) not null comment '名称',
   f_description        varchar(255) comment '描述',
   f_store_path         varchar(255) comment '保存路径',
   f_display_path       varchar(255) comment '显示路径',
   f_ftp_hostname       varchar(100) comment 'ftp服务器',
   f_ftp_port           int comment 'ftp端口',
   f_ftp_username       varchar(100) comment 'ftp用户名',
   f_ftp_password       varchar(100) comment 'ftp密码',
   f_seq                int not null default 2147483647 comment '排列顺序',
   f_method             int not null default 1 comment '方式(1:文件系统,2:FTP)',
   f_type               int not null default 1 comment '类型(1:HTML发布,2:附件发布)',
   primary key (f_publishpoint_id)
)
engine = innodb;

alter table cms_publish_point comment '发布点表';

/*==============================================================*/
/* Table: cms_question                                          */
/*==============================================================*/
create table cms_question
(
   f_question_id        int not null,
   f_site_id            int not null comment '站点ID',
   f_title              varchar(150) not null comment '标题',
   f_description        varchar(255) comment '描述',
   f_begin_date         datetime comment '开始日期',
   f_end_date           datetime comment '结束日期',
   f_creation_date      datetime not null comment '创建日期',
   f_mode               int not null default 1 comment '模式(1:独立访客,2:独立IP,3:独立用户)',
   f_interval           int not null default 0 comment '间隔时间（天）',
   f_total              int not null default 0 comment '总票数',
   f_status             int not null default 0 comment '状态(0:启用,1:禁用)',
   primary key (f_question_id)
)
engine = innodb;

alter table cms_question comment '调查问卷表';

/*==============================================================*/
/* Table: cms_question_item                                     */
/*==============================================================*/
create table cms_question_item
(
   f_questionitem_id    int not null,
   f_question_id        int not null,
   f_title              varchar(150) not null,
   f_max_selected       int not null default 1 comment '最多可选几项(0不限制)',
   f_seq                int not null default 2147483647 comment '排序',
   f_is_essay           char(1) not null default '0' comment '是否问答题',
   primary key (f_questionitem_id)
)
engine = innodb;

alter table cms_question_item comment '调查问卷项表';

/*==============================================================*/
/* Table: cms_question_item_rec                                 */
/*==============================================================*/
create table cms_question_item_rec
(
   f_questionitemrec_id int not null,
   f_questionrecord_id  int not null,
   f_questionitem_id    int not null,
   f_answer             mediumtext comment '回答',
   primary key (f_questionitemrec_id)
)
engine = innodb;

alter table cms_question_item_rec comment '调查问卷项与调查问卷记录关联表';

/*==============================================================*/
/* Table: cms_question_opt_rec                                  */
/*==============================================================*/
create table cms_question_opt_rec
(
   f_questionoptrec_id  int not null,
   f_questionrecord_id  int not null,
   f_questionoption_id  int not null,
   primary key (f_questionoptrec_id)
)
engine = innodb;

alter table cms_question_opt_rec comment '调查问卷选项与调查问卷记录关联表';

/*==============================================================*/
/* Table: cms_question_option                                   */
/*==============================================================*/
create table cms_question_option
(
   f_questionoption_id  int not null,
   f_questionitem_id    int not null,
   f_title              varchar(150) comment '标题',
   f_is_input           char(1) not null default '0' comment '是否输入框',
   f_count              int not null default 0 comment '得票数',
   f_seq                int not null default 2147483647 comment '排序',
   primary key (f_questionoption_id)
)
engine = innodb;

alter table cms_question_option comment '调查问卷选项表';

/*==============================================================*/
/* Table: cms_question_record                                   */
/*==============================================================*/
create table cms_question_record
(
   f_questionrecord_id  int not null,
   f_user_id            int comment '用户ID',
   f_question_id        int not null comment '调查问卷ID',
   f_date               datetime not null comment '日期',
   f_ip                 varchar(100) not null comment 'IP',
   f_cookie             varchar(100) not null comment 'Cookie',
   primary key (f_questionrecord_id)
)
engine = innodb;

alter table cms_question_record comment '调查问卷记录表';

/*==============================================================*/
/* Table: cms_role                                              */
/*==============================================================*/
create table cms_role
(
   f_role_id            int not null,
   f_site_id            int not null comment '站点',
   f_name               varchar(100) not null comment '名称',
   f_description        varchar(255) comment '描述',
   f_seq                int not null default 2147483647 comment '排序',
   f_perms              mediumtext comment '功能权限',
   f_is_all_perm        char(1) not null default '1' comment '是否拥有所有功能权限',
   f_is_all_info_perm   char(1) not null default '1' comment '是否拥有所有文档权限',
   f_is_all_node_perm   char(1) not null default '1' comment '是否拥有所有栏目权限',
   f_is_info_final_perm char(1) not null default '0' comment '是否拥有文档终审权限',
   f_info_perm_type     int not null default 1 comment '文档权限类型(1:所有;2:组织;3:自身)',
   primary key (f_role_id)
)
engine = innodb;

alter table cms_role comment '角色表';

/*==============================================================*/
/* Table: cms_schedule_job                                      */
/*==============================================================*/
create table cms_schedule_job
(
   f_schedulejob_id     int not null,
   f_site_id            int not null,
   f_user_id            int not null,
   f_name               varchar(100) not null comment '任务名称',
   f_group              varchar(100) comment '任务组',
   f_code               varchar(100) not null comment '任务代码',
   f_data               mediumtext comment '任务数据',
   f_description        varchar(255) comment '任务描述',
   f_cron_expression    varchar(100) comment 'Cron表达式',
   f_start_time         datetime comment '开始时间',
   f_end_time           datetime comment '结束时间',
   f_start_delay        bigint comment '首次延迟时间(分钟)',
   f_repeat_interval    bigint comment '间隔时间',
   f_unit               int comment '时间单位(1:毫秒,2:秒,3:分,4:时,5:天,6:周,7:月,8:年)',
   f_cycle              int not null default 1 comment '执行周期(1:cron,2:simple)',
   f_status             int not null default 0 comment '状态(0:启用;1:禁用)',
   primary key (f_schedulejob_id)
)
engine = innodb;

alter table cms_schedule_job comment '定时任务表';

/*==============================================================*/
/* Table: cms_score_board                                       */
/*==============================================================*/
create table cms_score_board
(
   f_scoreboard_id      int not null,
   f_scoreitem_id       int not null comment '记分项',
   f_ftype              varchar(50) not null comment '外表标识',
   f_fid                int not null comment '外表ID',
   f_votes              int not null default 0 comment '投票次数',
   primary key (f_scoreboard_id)
)
engine = innodb;

alter table cms_score_board comment '计分牌表';

/*==============================================================*/
/* Table: cms_score_group                                       */
/*==============================================================*/
create table cms_score_group
(
   f_scoregroup_id      int not null,
   f_site_id            int not null comment '站点',
   f_name               varchar(100) not null comment '名称',
   f_number             varchar(100) comment '代码',
   f_description        varchar(255) comment '描述',
   f_seq                int not null default 2147483647 comment '排序',
   primary key (f_scoregroup_id)
)
engine = innodb;

alter table cms_score_group comment '计分组表';

/*==============================================================*/
/* Table: cms_score_item                                        */
/*==============================================================*/
create table cms_score_item
(
   f_scoreitem_id       int not null,
   f_scoregroup_id      int not null comment '计分组',
   f_site_id            int not null comment '站点',
   f_name               varchar(100) not null comment '名称',
   f_score              int not null default 1 comment '分值',
   f_icon               varchar(255) comment '图标',
   f_seq                int not null default 2147483647 comment '排序',
   primary key (f_scoreitem_id)
)
engine = innodb;

alter table cms_score_item comment '计分项表';

/*==============================================================*/
/* Table: cms_sensitive_word                                    */
/*==============================================================*/
create table cms_sensitive_word
(
   f_sensitiveword_id   int not null,
   f_name               varchar(100) not null comment '敏感词',
   f_replacement        varchar(100) comment '替换词',
   f_status             int not null default 0 comment '状态(0:启用,1:禁用)',
   primary key (f_sensitiveword_id)
)
engine = innodb;

alter table cms_sensitive_word comment '敏感词表';

/*==============================================================*/
/* Table: cms_site                                              */
/*==============================================================*/
create table cms_site
(
   f_site_id            int not null,
   f_global_id          int not null comment '全局',
   f_org_id             int not null comment '组织',
   f_html_publishpoint_id int not null comment 'HTML发布点',
   f_parent_id          int comment '上级站点',
   f_name               varchar(100) not null comment '名称',
   f_number             varchar(100) not null comment '代码',
   f_full_name          varchar(100) comment '完整名称',
   f_no_picture         varchar(255) not null default '/img/no_picture.jpg' comment '暂无图片',
   f_template_theme     varchar(100) not null default 'default' comment '模板主题',
   f_domain             varchar(100) not null default 'localhost' comment '域名',
   f_is_identify_domain char(1) not null default '0' comment '是否识别域名',
   f_is_static_home     char(1) not null default '0' comment '是否静态首页',
   f_is_def             char(1) not null default '0' comment '是否默认站点',
   f_status             int not null default 0 comment '状态(0:正常,1:禁用)',
   f_tree_number        varchar(100) not null default '0000' comment '树编码',
   f_tree_level         int not null default 0 comment '树级别',
   f_tree_max           varchar(10) not null default '0000' comment '树子节点最大编码',
   primary key (f_site_id),
   unique key ak_number (f_number)
)
engine = innodb;

alter table cms_site comment '站点表';

/*==============================================================*/
/* Table: cms_site_clob                                         */
/*==============================================================*/
create table cms_site_clob
(
   f_site_id            int not null,
   f_key                varchar(50) not null comment '键',
   f_value              mediumtext comment '值'
)
engine = innodb;

alter table cms_site_clob comment '站点大字段表';

/*==============================================================*/
/* Table: cms_site_custom                                       */
/*==============================================================*/
create table cms_site_custom
(
   f_site_id            int not null,
   f_key                varchar(50) not null comment '键',
   f_value              varchar(2000) comment '值'
)
engine = innodb;

alter table cms_site_custom comment '站点自定义表';

/*==============================================================*/
/* Table: cms_special                                           */
/*==============================================================*/
create table cms_special
(
   f_special_id         int not null,
   f_creator_id         int not null comment '创建者',
   f_model_id           int not null comment '模型',
   f_site_id            int not null comment '站点',
   f_speccate_id        int not null comment '专题类别',
   f_creation_date      datetime not null comment '创建日期',
   f_title              varchar(150) not null comment '标题',
   f_meta_keywords      varchar(150) comment '关键字',
   f_meta_description   varchar(450) comment '描述',
   f_special_template   varchar(255) comment '专题模板',
   f_small_image        varchar(255) comment '小图',
   f_large_image        varchar(255) comment '大图',
   f_video              varchar(255) comment '视频',
   f_video_name         varchar(255) comment '视频名称',
   f_video_length       bigint comment '视频长度',
   f_video_time         varchar(100) comment '视频时间',
   f_refers             int not null default 0 comment '文档数量',
   f_views              int not null default 0 comment '浏览总数',
   f_is_with_image      char(1) not null default '0' comment '是否有图片',
   f_is_recommend       char(1) not null default '0' comment '是否推荐',
   primary key (f_special_id)
)
engine = innodb;

alter table cms_special comment '专题表';

/*==============================================================*/
/* Table: cms_special_category                                  */
/*==============================================================*/
create table cms_special_category
(
   f_speccate_id        int not null,
   f_site_id            int not null comment '站点',
   f_name               varchar(50) not null comment '名称',
   f_seq                int not null default 2147483647 comment '排序',
   f_views              int not null default 0 comment '浏览总数',
   f_meta_keywords      varchar(150) comment '关键字',
   f_meta_description   varchar(450) comment '描述',
   f_creation_date      datetime not null comment '创建日期',
   primary key (f_speccate_id)
)
engine = innodb;

alter table cms_special_category comment '专题类别表';

/*==============================================================*/
/* Table: cms_special_clob                                      */
/*==============================================================*/
create table cms_special_clob
(
   f_special_id         int not null,
   f_key                varchar(50) not null comment '键',
   f_value              mediumtext comment '值'
)
engine = innodb;

alter table cms_special_clob comment '专题大字段表';

/*==============================================================*/
/* Table: cms_special_custom                                    */
/*==============================================================*/
create table cms_special_custom
(
   f_special_id         int not null,
   f_key                varchar(50) comment '键',
   f_value              varchar(2000) comment '值'
)
engine = innodb;

alter table cms_special_custom comment '专题自定义表';

/*==============================================================*/
/* Table: cms_special_file                                      */
/*==============================================================*/
create table cms_special_file
(
   f_special_id         int not null,
   f_name               varchar(150) not null comment '文件名称',
   f_length             bigint not null default 0 comment '文件长度',
   f_file               varchar(255) not null comment '文件地址',
   f_index              int not null default 0 comment '文件序号',
   f_downloads          int not null default 0 comment '下载次数'
)
engine = innodb;

alter table cms_special_file comment '专题附件集表';

/*==============================================================*/
/* Table: cms_special_image                                     */
/*==============================================================*/
create table cms_special_image
(
   f_special_id         int not null,
   f_name               varchar(150) comment '图片名称',
   f_image              varchar(255) comment '图片地址',
   f_index              int not null default 0 comment '图片序号',
   f_text               mediumtext comment '图片正文'
)
engine = innodb;

alter table cms_special_image comment '专题图片集表';

/*==============================================================*/
/* Table: cms_tag                                               */
/*==============================================================*/
create table cms_tag
(
   f_tag_id             int not null,
   f_site_id            int not null comment '站点',
   f_name               varchar(150) not null comment '名称',
   f_creation_date      datetime not null comment '创建日期',
   f_refers             int not null default 0 comment '文档数量',
   primary key (f_tag_id)
)
engine = innodb;

alter table cms_tag comment 'TAG表';

/*==============================================================*/
/* Table: cms_task                                              */
/*==============================================================*/
create table cms_task
(
   f_task_id            int not null,
   f_user_id            int not null,
   f_site_id            int not null,
   f_name               varchar(150) not null comment '名称',
   f_description        mediumtext comment '描述',
   f_begin_time         datetime not null comment '开始时间',
   f_end_time           datetime comment '结束时间',
   f_total              int not null default 0 comment '总完成数量',
   f_type               int not null default 1 comment '类型(1:栏目HTML生成,2:文档HTML生成,3:全文索引生成)',
   f_status             int not null default 0 comment '状态(0:运行中,1:完成,2:中止,3:停止)',
   primary key (f_task_id)
)
engine = innodb;

alter table cms_task comment '任务表';

/*==============================================================*/
/* Table: cms_user                                              */
/*==============================================================*/
create table cms_user
(
   f_user_id            int not null,
   f_org_id             int not null comment '组织',
   f_membergroup_id     int not null comment '会员组',
   f_global_id          int not null comment '全局',
   f_username           varchar(50) not null comment '用户名',
   f_password           varchar(128) comment '密码',
   f_salt               varchar(32) comment '加密混淆码',
   f_email              varchar(100) comment '电子邮箱',
   f_mobile             varchar(100) comment '手机',
   f_real_name          varchar(100) comment '用户实名',
   f_gender             char(1) comment '性别',
   f_birth_date         datetime comment '出生年月',
   f_validation_type    varchar(50) comment '验证类型(用户激活,重置密码,邮箱激活)',
   f_validation_key     varchar(100) comment '验证KEY',
   f_rank               int not null default 999 comment '等级',
   f_type               int not null default 0 comment '类型(0:会员,1:管理员)',
   f_status             int not null default 0 comment '状态(0:正常,1:锁定,2:待验证)',
   f_qq_openid          varchar(64) comment 'qq openid',
   f_weibo_uid          varchar(64) comment 'weibo uid',
   f_weixin_openid      varchar(64) comment 'weixin openid',
   primary key (f_user_id),
   unique key ak_username (f_username)
)
engine = innodb;

alter table cms_user comment '用户表';

/*==============================================================*/
/* Table: cms_user_detail                                       */
/*==============================================================*/
create table cms_user_detail
(
   f_user_id            int not null,
   f_validation_date    datetime comment '验证生成时间',
   f_validation_value   varchar(255) comment '验证值',
   f_login_error_date   datetime comment '登录错误时间',
   f_login_error_count  int not null default 0 comment '登录错误次数',
   f_prev_login_date    datetime comment '上次登录日期',
   f_prev_login_ip      varchar(100) comment '上次登录IP',
   f_last_login_date    datetime comment '最后登录日期',
   f_last_login_ip      varchar(100) comment '最后登录IP',
   f_creation_date      datetime not null comment '加入日期',
   f_creation_ip        varchar(100) not null comment '加入IP',
   f_logins             int not null default 0 comment '登录次数',
   f_is_with_avatar     char(1) not null default '0' comment '是否有头像',
   f_bio                varchar(255) comment '自我介绍',
   f_come_from          varchar(100) comment '来自',
   f_qq                 varchar(100) comment 'QQ',
   f_msn                varchar(100) comment 'MSN',
   f_weixin             varchar(100) comment '微信',
   primary key (f_user_id)
)
engine = innodb;

alter table cms_user_detail comment '用户详细信息表';

/*==============================================================*/
/* Table: cms_user_membergroup                                  */
/*==============================================================*/
create table cms_user_membergroup
(
   f_usermgroup_id      int not null,
   f_user_id            int not null,
   f_membergroup_id     int not null,
   f_group_index        int not null default 0 comment '会员组排列顺序',
   primary key (f_usermgroup_id)
)
engine = innodb;

alter table cms_user_membergroup comment '用户与会员组关联表';

/*==============================================================*/
/* Table: cms_user_org                                          */
/*==============================================================*/
create table cms_user_org
(
   f_userorg_id         int not null,
   f_user_id            int not null,
   f_org_id             int not null,
   f_org_index          int not null default 0 comment '组织顺序',
   primary key (f_userorg_id)
)
engine = innodb;

alter table cms_user_org comment '用户与组织关联表';

/*==============================================================*/
/* Table: cms_user_role                                         */
/*==============================================================*/
create table cms_user_role
(
   f_userrole_id        int not null,
   f_user_id            int not null,
   f_role_id            int not null,
   f_role_index         int not null default 0 comment '角色顺序',
   primary key (f_userrole_id)
)
engine = innodb;

alter table cms_user_role comment '用户与角色关联表';

/*==============================================================*/
/* Table: cms_visit_log                                         */
/*==============================================================*/
create table cms_visit_log
(
   f_visitlog_id        int not null,
   f_site_id            int not null,
   f_url                varchar(255) not null comment '页面URL',
   f_referrer           varchar(255) comment '来源URL',
   f_ip                 varchar(100) comment 'IP地址',
   f_ip_date            varchar(100) comment 'IP地址+日期',
   f_cookie             varchar(100) comment 'COOKIE值',
   f_cookie_date        varchar(100) comment 'COOKIE值+日期',
   f_date               char(10) not null comment '日期（字符串格式）',
   f_time               datetime not null comment '访问时间',
   primary key (f_visitlog_id)
)
engine = innodb;

alter table cms_visit_log comment '访问日志表';

/*==============================================================*/
/* Table: cms_vote                                              */
/*==============================================================*/
create table cms_vote
(
   f_vote_id            int not null,
   f_site_id            int not null,
   f_title              varchar(150) not null comment '标题',
   f_number             varchar(100) comment '代码',
   f_description        varchar(255) comment '描述',
   f_begin_date         datetime comment '开始日期',
   f_end_date           datetime comment '结束日期',
   f_interval           int not null default 0 comment '间隔时间（天）',
   f_max_selected       int not null default 1 comment '最多可选几项(0不限制)',
   f_mode               int not null default 1 comment '模式(1:独立访客,2:独立IP,3:独立用户)',
   f_total              int not null default 0 comment '总票数',
   f_seq                int not null default 2147483647 comment '排序',
   f_status             int not null default 0 comment '状态(0:启用,1:禁用)',
   primary key (f_vote_id)
)
engine = innodb;

alter table cms_vote comment '投票表';

/*==============================================================*/
/* Table: cms_vote_mark                                         */
/*==============================================================*/
create table cms_vote_mark
(
   f_votemark_id        int not null,
   f_ftype              varchar(50) not null comment '外表标识',
   f_fid                int not null comment '外表ID',
   f_date               datetime not null comment '日期',
   f_user_id            int comment '用户',
   f_ip                 varchar(100) not null comment 'IP',
   f_cookie             varchar(100) not null comment 'Cookie',
   primary key (f_votemark_id)
)
engine = innodb;

alter table cms_vote_mark comment '投票标记表';

/*==============================================================*/
/* Table: cms_vote_option                                       */
/*==============================================================*/
create table cms_vote_option
(
   f_voteoption_id      int not null,
   f_vote_id            int not null,
   f_title              varchar(150) not null comment '标题',
   f_count              int not null default 0 comment '得票数',
   f_seq                int not null default 2147483647 comment '排序',
   primary key (f_voteoption_id)
)
engine = innodb;

alter table cms_vote_option comment '投票项表';

/*==============================================================*/
/* Table: cms_workflow                                          */
/*==============================================================*/
create table cms_workflow
(
   f_workflow_id        int not null,
   f_workflowgroup_id   int not null comment '工作流',
   f_site_id            int not null comment '站点',
   f_name               varchar(100) not null comment '名称',
   f_description        varchar(255) comment '描述',
   f_seq                int not null default 2147483647 comment '排序',
   f_status             int not null default 1 comment '状态(1:启用;2:禁用)',
   primary key (f_workflow_id)
)
engine = innodb;

alter table cms_workflow comment '工作流表';

/*==============================================================*/
/* Table: cms_workflow_group                                    */
/*==============================================================*/
create table cms_workflow_group
(
   f_workflowgroup_id   int not null,
   f_site_id            int not null comment '站点',
   f_name               varchar(100) not null comment '名称',
   f_description        varchar(255) comment '描述',
   f_seq                int not null default 2147483647 comment '排序',
   primary key (f_workflowgroup_id)
)
engine = innodb;

alter table cms_workflow_group comment '工作流组表';

/*==============================================================*/
/* Table: cms_workflow_log                                      */
/*==============================================================*/
create table cms_workflow_log
(
   f_workflowlog_id     int not null,
   f_user_id            int not null comment '操作人',
   f_site_id            int not null comment '站点',
   f_workflowprocess_id int not null comment '过程',
   f_from               varchar(100) not null comment '从哪',
   f_to                 varchar(100) not null comment '到哪',
   f_creation_date      datetime not null comment '创建时间',
   f_opinion            varchar(255) comment '意见',
   f_type               int not null comment '类型(1:前进;2后退:;3:原地)',
   primary key (f_workflowlog_id)
)
engine = innodb;

alter table cms_workflow_log comment '工作流流程日志表';

/*==============================================================*/
/* Table: cms_workflow_process                                  */
/*==============================================================*/
create table cms_workflow_process
(
   f_workflowprocess_id int not null,
   f_workflowstep_id    int comment '步骤',
   f_site_id            int not null comment '站点',
   f_workflow_id        int not null comment '流程',
   f_user_id            int not null comment '发起人',
   f_data_id            int not null comment '数据ID',
   f_data_type          int not null comment '数据类型(1:文档)',
   f_begin_date         datetime not null comment '开始时间',
   f_end_date           datetime comment '结束时间',
   f_is_rejection       char(1) not null default '0' comment '是否退回',
   f_is_end             char(1) not null default '0' comment '是否结束',
   primary key (f_workflowprocess_id)
)
engine = innodb;

alter table cms_workflow_process comment '工作流过程表';

/*==============================================================*/
/* Table: cms_workflow_step                                     */
/*==============================================================*/
create table cms_workflow_step
(
   f_workflowstep_id    int not null,
   f_workflow_id        int not null comment '工作流',
   f_name               varchar(100) not null comment '名称',
   f_seq                int not null default 2147483647 comment '排序',
   primary key (f_workflowstep_id)
)
engine = innodb;

alter table cms_workflow_step comment '工作流步骤表';

/*==============================================================*/
/* Table: cms_workflowstep_role                                 */
/*==============================================================*/
create table cms_workflowstep_role
(
   f_wfsteprole_id      int not null,
   f_role_id            int not null,
   f_workflowstep_id    int not null,
   f_role_index         int not null default 0 comment '角色排列顺序',
   primary key (f_wfsteprole_id)
)
engine = innodb;

alter table cms_workflowstep_role comment '审核步骤与角色关联表';

/*==============================================================*/
/* Table: plug_resume                                           */
/*==============================================================*/
create table plug_resume
(
   f_resume_id          int not null,
   f_site_id            int not null,
   f_name               varchar(100) not null comment '姓名',
   f_post               varchar(100) not null comment '应聘职位',
   f_creation_date      datetime not null comment '投递日期',
   f_gender             char(1) not null default 'M' comment '性别',
   f_birth_date         datetime comment '出生日期',
   f_mobile             varchar(100) comment '手机',
   f_email              varchar(100) comment '邮箱',
   f_expected_salary    int comment '期望薪水',
   f_education_experience mediumtext comment '教育经历',
   f_work_experience    mediumtext comment '工作经历',
   f_remark             mediumtext comment '备注',
   primary key (f_resume_id)
)
engine = innodb;

alter table plug_resume comment '简历表';

/*==============================================================*/
/* Table: t_id_table                                            */
/*==============================================================*/
create table t_id_table
(
   f_table              varchar(100) not null comment '表名',
   f_id_value           bigint not null comment 'ID值',
   primary key (f_table)
)
engine = innodb;

alter table t_id_table comment '主键表';