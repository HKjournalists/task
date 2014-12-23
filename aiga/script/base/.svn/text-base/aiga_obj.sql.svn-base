--------------------------------------------
-- Export file for user AIGA              --
-- Created by York on 2014/11/7, 10:30:21 --
--------------------------------------------

spool aiga.log

prompt
prompt Creating table ABC
prompt ==================
prompt
create table AIGA.ABC
(
  att_type VARCHAR2(60),
  obj_type VARCHAR2(60),
  link_no  VARCHAR2(60),
  rela_id  NUMBER(12) not null
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_ACCOUNT_TEST
prompt ================================
prompt
create table AIGA.AIGA_ACCOUNT_TEST
(
  account_id       NUMBER(20),
  account_type     NUMBER(20),
  account_count    VARCHAR2(255),
  minus_words_rate VARCHAR2(255),
  minus_fee_rate   VARCHAR2(255),
  orgin_bill_rate  VARCHAR2(255),
  orgin_fee_rate   VARCHAR2(255),
  bare_count       VARCHAR2(255),
  bare_fee         VARCHAR2(255),
  average_bare_fee VARCHAR2(255),
  average_bare_dis VARCHAR2(255),
  sub_task_id      NUMBER(20),
  check_status     NUMBER(1)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_ACCOUNT_TEST.account_id
  is '对账ID';
comment on column AIGA.AIGA_ACCOUNT_TEST.account_type
  is '对账类型';
comment on column AIGA.AIGA_ACCOUNT_TEST.account_count
  is '对账记录数';
comment on column AIGA.AIGA_ACCOUNT_TEST.minus_words_rate
  is '话单或账单一致率（剔除合理差异）';
comment on column AIGA.AIGA_ACCOUNT_TEST.minus_fee_rate
  is '费用一致率（剔除合理差异）';
comment on column AIGA.AIGA_ACCOUNT_TEST.orgin_bill_rate
  is '话单或账单一致率（原始差异）';
comment on column AIGA.AIGA_ACCOUNT_TEST.orgin_fee_rate
  is '费用一致率（原始差异）';
comment on column AIGA.AIGA_ACCOUNT_TEST.bare_count
  is '裸差用户数';
comment on column AIGA.AIGA_ACCOUNT_TEST.bare_fee
  is '裸差费用';
comment on column AIGA.AIGA_ACCOUNT_TEST.average_bare_fee
  is '平均用户裸差费用';
comment on column AIGA.AIGA_ACCOUNT_TEST.average_bare_dis
  is '用户裸差费用分档分布';
comment on column AIGA.AIGA_ACCOUNT_TEST.sub_task_id
  is '子任务ID';
comment on column AIGA.AIGA_ACCOUNT_TEST.check_status
  is '是否选中（0为false，1为true）';

prompt
prompt Creating table AIGA_AUDIT
prompt =========================
prompt
create table AIGA.AIGA_AUDIT
(
  audit_id     NUMBER(20) not null,
  audit_type   NUMBER(20),
  audit_count  VARCHAR2(255),
  audit_rate   VARCHAR2(255),
  sub_task_id  NUMBER(20),
  check_status NUMBER(1)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_AUDIT.audit_id
  is '稽核ID';
comment on column AIGA.AIGA_AUDIT.audit_type
  is '稽核类型';
comment on column AIGA.AIGA_AUDIT.audit_count
  is '总记录数';
comment on column AIGA.AIGA_AUDIT.audit_rate
  is '准确率';
comment on column AIGA.AIGA_AUDIT.sub_task_id
  is '关联子任务ID';
comment on column AIGA.AIGA_AUDIT.check_status
  is '是否选中（0为false，1为true）';
alter table AIGA.AIGA_AUDIT
  add constraint PK_AUDIT primary key (AUDIT_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_AUTOTEST_PARAMS
prompt ===================================
prompt
create table AIGA.AIGA_AUTOTEST_PARAMS
(
  param_id    NUMBER(20) not null,
  parent_id   NUMBER(20),
  param_name  VARCHAR2(2000),
  param_value VARCHAR2(4000),
  isleaf      VARCHAR2(2),
  case_id     NUMBER(20),
  param_desc  VARCHAR2(4000),
  exe_sql     VARCHAR2(4000)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_AUTOTEST_PARAMS
  add primary key (PARAM_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_BASE_BUSI
prompt =============================
prompt
create table AIGA.AIGA_BASE_BUSI
(
  busi_id    NUMBER(20) not null,
  busi_name  VARCHAR2(255),
  busi_desc  VARCHAR2(4000),
  is_invalid NUMBER(4)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_BASE_BUSI.busi_id
  is '基础业务ID';
comment on column AIGA.AIGA_BASE_BUSI.busi_name
  is '基础业务名称';
comment on column AIGA.AIGA_BASE_BUSI.busi_desc
  is '业务范围说明';
comment on column AIGA.AIGA_BASE_BUSI.is_invalid
  is '是否已被禁用(1:已被禁用,0:未被禁用)';
create unique index AIGA.INDEX_BASE_BUSI_NAME on AIGA.AIGA_BASE_BUSI (BUSI_NAME)
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_BASE_BUSI
  add constraint PK_AIGA_BASE_BUSI_DEF primary key (BUSI_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_BASE_CASE
prompt =============================
prompt
create table AIGA.AIGA_BASE_CASE
(
  case_id              NUMBER(20) not null,
  case_name            VARCHAR2(255),
  fun_folder_id        NUMBER(20),
  case_desc            VARCHAR2(2048),
  create_time          DATE,
  update_time          DATE,
  author               VARCHAR2(255),
  latest_operator      VARCHAR2(255),
  sys_label            VARCHAR2(512),
  own_label            VARCHAR2(512),
  url                  VARCHAR2(2048),
  author_no            VARCHAR2(512),
  important            NUMBER(2),
  maintenance_fac      NUMBER(2),
  regression_test      NUMBER(2),
  has_test             NUMBER(2),
  test_type            VARCHAR2(2000),
  case_type            NUMBER(2),
  efficiency_test      NUMBER(2),
  efficiency_test_type NUMBER(2),
  teminal_test         NUMBER(2),
  case_pre_cond        VARCHAR2(4000),
  case_operate_inst    VARCHAR2(4000),
  pre_result           VARCHAR2(4000),
  sec_id               NUMBER(20),
  elemvalue            VARCHAR2(4000)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_BASE_CASE.case_id
  is '主键';
comment on column AIGA.AIGA_BASE_CASE.case_name
  is '用例名称';
comment on column AIGA.AIGA_BASE_CASE.fun_folder_id
  is '父目录ID';
comment on column AIGA.AIGA_BASE_CASE.case_desc
  is '用例描述';
comment on column AIGA.AIGA_BASE_CASE.create_time
  is '创建时间';
comment on column AIGA.AIGA_BASE_CASE.update_time
  is '修改时间';
comment on column AIGA.AIGA_BASE_CASE.author
  is '用例作者';
comment on column AIGA.AIGA_BASE_CASE.latest_operator
  is '最后操作人';
comment on column AIGA.AIGA_BASE_CASE.sys_label
  is '系统标签描述';
comment on column AIGA.AIGA_BASE_CASE.own_label
  is '自定义标签描述';
comment on column AIGA.AIGA_BASE_CASE.url
  is '测试地址';
comment on column AIGA.AIGA_BASE_CASE.author_no
  is '用例作者编号';
comment on column AIGA.AIGA_BASE_CASE.important
  is '重要级别';
comment on column AIGA.AIGA_BASE_CASE.maintenance_fac
  is '用例维护厂商';
comment on column AIGA.AIGA_BASE_CASE.regression_test
  is '是否为回归测试';
comment on column AIGA.AIGA_BASE_CASE.has_test
  is '是否已实现自动化';
comment on column AIGA.AIGA_BASE_CASE.test_type
  is '测试类型';
comment on column AIGA.AIGA_BASE_CASE.case_type
  is '用例类型';
comment on column AIGA.AIGA_BASE_CASE.efficiency_test
  is '是否为性能测试';
comment on column AIGA.AIGA_BASE_CASE.efficiency_test_type
  is '性能测试类型';
comment on column AIGA.AIGA_BASE_CASE.teminal_test
  is '是否为端到端测试';
alter table AIGA.AIGA_BASE_CASE
  add primary key (CASE_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_BASE_CASE_COLLECTION
prompt ========================================
prompt
create table AIGA.AIGA_BASE_CASE_COLLECTION
(
  collection_id   NUMBER(20) not null,
  collection_name VARCHAR2(255),
  collection_desc VARCHAR2(255),
  create_time     DATE,
  update_time     DATE,
  author          VARCHAR2(255),
  latest_operator VARCHAR2(255)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_BASE_CASE_COLLECTION.collection_id
  is '主键';
comment on column AIGA.AIGA_BASE_CASE_COLLECTION.collection_name
  is '用例集名称';
comment on column AIGA.AIGA_BASE_CASE_COLLECTION.collection_desc
  is '用例集描述';
comment on column AIGA.AIGA_BASE_CASE_COLLECTION.create_time
  is '创建时间';
comment on column AIGA.AIGA_BASE_CASE_COLLECTION.update_time
  is '修改时间';
comment on column AIGA.AIGA_BASE_CASE_COLLECTION.author
  is '作者';
comment on column AIGA.AIGA_BASE_CASE_COLLECTION.latest_operator
  is '最后修改人';
alter table AIGA.AIGA_BASE_CASE_COLLECTION
  add constraint AIGA_CASE_COLLECTION$PRIMARY primary key (COLLECTION_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_BASE_COMPONENT
prompt ==================================
prompt
create table AIGA.AIGA_BASE_COMPONENT
(
  comp_id         NUMBER(20) not null,
  parent_id       NUMBER(20),
  comp_name       VARCHAR2(255),
  permission      NUMBER(4),
  path            VARCHAR2(255),
  default_val     VARCHAR2(255),
  comp_desc       VARCHAR2(255),
  create_time     DATE,
  update_time     DATE,
  author          VARCHAR2(255),
  latest_operator VARCHAR2(255),
  hashcode        VARCHAR2(255),
  url             VARCHAR2(255),
  extra           VARCHAR2(255),
  is_leaf         VARCHAR2(2),
  author_no       VARCHAR2(512)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_BASE_COMPONENT.comp_id
  is '主键';
comment on column AIGA.AIGA_BASE_COMPONENT.parent_id
  is '父目录ID';
comment on column AIGA.AIGA_BASE_COMPONENT.comp_name
  is '组件名称';
comment on column AIGA.AIGA_BASE_COMPONENT.permission
  is '审批 0.通过 1.不通过';
comment on column AIGA.AIGA_BASE_COMPONENT.path
  is '路径';
comment on column AIGA.AIGA_BASE_COMPONENT.default_val
  is '组件默认值';
comment on column AIGA.AIGA_BASE_COMPONENT.comp_desc
  is '组件描述';
comment on column AIGA.AIGA_BASE_COMPONENT.create_time
  is '创建时间';
comment on column AIGA.AIGA_BASE_COMPONENT.update_time
  is '修改时间';
comment on column AIGA.AIGA_BASE_COMPONENT.author
  is '作者';
comment on column AIGA.AIGA_BASE_COMPONENT.latest_operator
  is '最后操作人';
comment on column AIGA.AIGA_BASE_COMPONENT.hashcode
  is '组件HASHCODE';
comment on column AIGA.AIGA_BASE_COMPONENT.url
  is '组件地址';
comment on column AIGA.AIGA_BASE_COMPONENT.extra
  is '扩展字段';
comment on column AIGA.AIGA_BASE_COMPONENT.is_leaf
  is '是否为叶子节点';
comment on column AIGA.AIGA_BASE_COMPONENT.author_no
  is '作者编号';
alter table AIGA.AIGA_BASE_COMPONENT
  add constraint AIGA_COMPONENT$PRIMARY primary key (COMP_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_BASE_GUI
prompt ============================
prompt
create table AIGA.AIGA_BASE_GUI
(
  gui_id              NUMBER(20) not null,
  gui_selector        VARCHAR2(255),
  gui_url             VARCHAR2(255),
  gui_tag             VARCHAR2(255),
  parent_id           NUMBER(20),
  gui_name            VARCHAR2(255),
  gui_permission      NUMBER(4),
  gui_path            VARCHAR2(255),
  gui_extra           VARCHAR2(255),
  gui_desc            VARCHAR2(255),
  gui_html            VARCHAR2(255),
  gui_create_time     DATE,
  gui_update_time     DATE,
  gui_author          VARCHAR2(255),
  gui_bounds          VARCHAR2(255),
  gui_hashcode        VARCHAR2(255),
  gui_latest_operator VARCHAR2(255),
  gui_thumb_url       VARCHAR2(255)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_BASE_GUI.gui_id
  is '主键';
comment on column AIGA.AIGA_BASE_GUI.gui_selector
  is '控件选择器';
comment on column AIGA.AIGA_BASE_GUI.gui_url
  is '控件地址';
comment on column AIGA.AIGA_BASE_GUI.gui_tag
  is '控件类型';
comment on column AIGA.AIGA_BASE_GUI.parent_id
  is '父目录ID';
comment on column AIGA.AIGA_BASE_GUI.gui_name
  is '控件名称';
comment on column AIGA.AIGA_BASE_GUI.gui_permission
  is '控件审批 0.通过 1.不通过';
comment on column AIGA.AIGA_BASE_GUI.gui_path
  is '控件路径';
comment on column AIGA.AIGA_BASE_GUI.gui_extra
  is '扩展信息';
comment on column AIGA.AIGA_BASE_GUI.gui_desc
  is '控件描述';
comment on column AIGA.AIGA_BASE_GUI.gui_html
  is '控件HTML';
comment on column AIGA.AIGA_BASE_GUI.gui_create_time
  is '创建时间';
comment on column AIGA.AIGA_BASE_GUI.gui_update_time
  is '修改时间';
comment on column AIGA.AIGA_BASE_GUI.gui_author
  is '作者';
comment on column AIGA.AIGA_BASE_GUI.gui_bounds
  is '控件坐标';
comment on column AIGA.AIGA_BASE_GUI.gui_hashcode
  is '控件HASHCODE';
comment on column AIGA.AIGA_BASE_GUI.gui_latest_operator
  is '最后操作人';
comment on column AIGA.AIGA_BASE_GUI.gui_thumb_url
  is '控件预览图片地址';
alter table AIGA.AIGA_BASE_GUI
  add constraint AIGA_GUI$PRIMARY primary key (GUI_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_BASE_R_CASE_COMP
prompt ====================================
prompt
create table AIGA.AIGA_BASE_R_CASE_COMP
(
  ref_id         NUMBER(20) not null,
  case_id        NUMBER(20),
  comp_id        NUMBER(20),
  r_order        NUMBER(4),
  in_val         VARCHAR2(255),
  out_val        VARCHAR2(255),
  expectval      VARCHAR2(255),
  hinge          VARCHAR2(255),
  remark         VARCHAR2(255),
  ref_desc       VARCHAR2(255),
  argu_name      VARCHAR2(255),
  manual_task_id NUMBER(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_BASE_R_CASE_COMP
  add constraint AIGA_R_CASE_COMP$PRIMARY primary key (REF_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_BASE_R_COLLECT_CASE
prompt =======================================
prompt
create table AIGA.AIGA_BASE_R_COLLECT_CASE
(
  ref_id     NUMBER(20) not null,
  collect_id NUMBER(20),
  case_id    NUMBER(20),
  r_order    NUMBER(4)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_BASE_R_COLLECT_CASE
  add constraint AIGA_R_COLLECT_CASE$PRIMARY primary key (REF_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_BASE_R_COMP_GUI
prompt ===================================
prompt
create table AIGA.AIGA_BASE_R_COMP_GUI
(
  rela_id   NUMBER(20) not null,
  comp_id   NUMBER(20),
  gui_id    NUMBER(20),
  gui_order NUMBER(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_BASE_R_COMP_GUI
  add constraint AIGA_GUI_COMP_RELA$PRIMARY primary key (RELA_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_BUSI
prompt ========================
prompt
create table AIGA.AIGA_BUSI
(
  busi_id         NUMBER(20) not null,
  busi_name       VARCHAR2(255),
  busi_type       NUMBER(4),
  important_class NUMBER(4),
  busi_desc       VARCHAR2(4000),
  remarks         VARCHAR2(4000),
  is_invalid      NUMBER(4)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_BUSI.busi_id
  is '业务ID';
comment on column AIGA.AIGA_BUSI.busi_name
  is '业务名称';
comment on column AIGA.AIGA_BUSI.busi_type
  is '业务分类,1:产品类业务，2：服务类业务';
comment on column AIGA.AIGA_BUSI.important_class
  is '重要等级，1：核心，2：重要，3：一般';
comment on column AIGA.AIGA_BUSI.busi_desc
  is '业务说明';
comment on column AIGA.AIGA_BUSI.remarks
  is '备注';
comment on column AIGA.AIGA_BUSI.is_invalid
  is '是否已被禁用(1:已被禁用,0:未被禁用)';
alter table AIGA.AIGA_BUSI
  add constraint PK_AIGA_BUSI_DEF primary key (BUSI_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_BUSI_RULE_LABEL
prompt ===================================
prompt
create table AIGA.AIGA_BUSI_RULE_LABEL
(
  rule_id         NUMBER(20) not null,
  sub_module      VARCHAR2(255),
  rule_type       NUMBER(4),
  important_class NUMBER(4),
  rule_desc       VARCHAR2(4000),
  remarks         VARCHAR2(4000)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_BUSI_RULE_LABEL.rule_id
  is '业务规则ID';
comment on column AIGA.AIGA_BUSI_RULE_LABEL.sub_module
  is '子模块名称';
comment on column AIGA.AIGA_BUSI_RULE_LABEL.rule_type
  is '分类';
comment on column AIGA.AIGA_BUSI_RULE_LABEL.important_class
  is '重要等级';
comment on column AIGA.AIGA_BUSI_RULE_LABEL.rule_desc
  is '规则说明';
comment on column AIGA.AIGA_BUSI_RULE_LABEL.remarks
  is '备注';
alter table AIGA.AIGA_BUSI_RULE_LABEL
  add constraint PK_AIGA_BUSI_RULE_LABEL primary key (RULE_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_CASE_LABEL_RELA
prompt ===================================
prompt
create table AIGA.AIGA_CASE_LABEL_RELA
(
  rela_id  NUMBER(20) not null,
  case_id  NUMBER(20),
  label_id NUMBER(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_CASE_LABEL_RELA
  add constraint AIGA_CASE_LABEL_RELA primary key (RELA_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_CASE_PARAMS
prompt ===============================
prompt
create table AIGA.AIGA_CASE_PARAMS
(
  param_id   NUMBER(20) not null,
  param_desc VARCHAR2(2000),
  exe_sql    VARCHAR2(4000),
  val        VARCHAR2(4000),
  case_id    NUMBER(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_CASE_PARAMS
  add constraint AIGA_CASE_PARAM$PRIMARY primary key (PARAM_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_CASE_WORKORDER
prompt ==================================
prompt
create table AIGA.AIGA_CASE_WORKORDER
(
  order_id        NUMBER(20) not null,
  case_id         NUMBER(20),
  exec_staff_id   NUMBER(20),
  exec_staff_code VARCHAR2(400),
  exec_time       DATE,
  create_time     DATE,
  link_no         VARCHAR2(400),
  link_id         NUMBER(20),
  remark          VARCHAR2(4000),
  status          NUMBER,
  result          VARCHAR2(200),
  case_name       VARCHAR2(4000)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_CASE_WORKORDER.order_id
  is '主键';
comment on column AIGA.AIGA_CASE_WORKORDER.case_id
  is '用例ID';
comment on column AIGA.AIGA_CASE_WORKORDER.exec_staff_id
  is '处理人ID';
comment on column AIGA.AIGA_CASE_WORKORDER.exec_staff_code
  is '处理人CODE';
comment on column AIGA.AIGA_CASE_WORKORDER.exec_time
  is '处理时间';
comment on column AIGA.AIGA_CASE_WORKORDER.create_time
  is '工单创建时间';
comment on column AIGA.AIGA_CASE_WORKORDER.link_no
  is '环节编号';
comment on column AIGA.AIGA_CASE_WORKORDER.link_id
  is '环节ID';
comment on column AIGA.AIGA_CASE_WORKORDER.remark
  is '备注';
comment on column AIGA.AIGA_CASE_WORKORDER.status
  is '工单状态';
comment on column AIGA.AIGA_CASE_WORKORDER.result
  is '工单结果';
comment on column AIGA.AIGA_CASE_WORKORDER.case_name
  is '用例名称';
alter table AIGA.AIGA_CASE_WORKORDER
  add constraint AIGA_CASE_WORKORDER$PRIMARY primary key (ORDER_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_CLIENT_CONFIG
prompt =================================
prompt
create table AIGA.AIGA_CLIENT_CONFIG
(
  conf_id   NUMBER(20) not null,
  nick_name VARCHAR2(2000),
  ip        VARCHAR2(15),
  path_map  VARCHAR2(3000),
  status    NUMBER(3),
  uuid      VARCHAR2(200),
  port      VARCHAR2(6)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_CLIENT_CONFIG
  add primary key (CONF_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_EXCEL
prompt =========================
prompt
create table AIGA.AIGA_EXCEL
(
  id         NUMBER(20) not null,
  filename   VARCHAR2(255),
  subject    VARCHAR2(255),
  submittime DATE,
  htmlfile   VARCHAR2(255),
  subtaskid  NUMBER(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_EXCEL
  add constraint PK_AIGA_EXCEL_ID primary key (ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_EXT_DICT
prompt ============================
prompt
create table AIGA.AIGA_EXT_DICT
(
  id     NUMBER not null,
  key    VARCHAR2(200),
  value  VARCHAR2(200) not null,
  cause  VARCHAR2(200),
  author VARCHAR2(200),
  status NUMBER
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_EXT_DICT
  add constraint AIGA_EXT_DICTIONARY$PRIMARY primary key (ID, VALUE)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_EXT_INDEX
prompt =============================
prompt
create table AIGA.AIGA_EXT_INDEX
(
  ext_id          NUMBER(20) not null,
  index_class     VARCHAR2(255),
  index_id_name   VARCHAR2(255),
  index_id_value  NUMBER(20),
  ext_field_1     VARCHAR2(255),
  ext_field_2     VARCHAR2(255),
  ext_field_1_val VARCHAR2(1024),
  ext_field_2_val VARCHAR2(1024),
  deal_status     NUMBER(4) default 0,
  deal_time       DATE
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_EXT_INDEX.ext_id
  is '主键ID';
comment on column AIGA.AIGA_EXT_INDEX.index_class
  is '索引类';
comment on column AIGA.AIGA_EXT_INDEX.index_id_name
  is '索引ID名';
comment on column AIGA.AIGA_EXT_INDEX.index_id_value
  is '索引ID值';
comment on column AIGA.AIGA_EXT_INDEX.ext_field_1
  is '扩展字段1';
comment on column AIGA.AIGA_EXT_INDEX.ext_field_2
  is '扩展字段2';
comment on column AIGA.AIGA_EXT_INDEX.ext_field_1_val
  is '扩展字段1值';
comment on column AIGA.AIGA_EXT_INDEX.ext_field_2_val
  is '扩展字段2值';
comment on column AIGA.AIGA_EXT_INDEX.deal_status
  is '处理状态（1为处理）';
comment on column AIGA.AIGA_EXT_INDEX.deal_time
  is '处理时间';
alter table AIGA.AIGA_EXT_INDEX
  add constraint PK_EXT_INDEX primary key (EXT_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_EXT_STOPWORD_DICT
prompt =====================================
prompt
create table AIGA.AIGA_EXT_STOPWORD_DICT
(
  id     NUMBER not null,
  key    VARCHAR2(200),
  value  VARCHAR2(200) not null,
  cause  VARCHAR2(200),
  author VARCHAR2(200)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_EXT_STOPWORD_DICT
  add constraint AIGA_EXT_STOPWORD_DICT$PRIMARY primary key (ID, VALUE)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_FUN_FOLDER
prompt ==============================
prompt
create table AIGA.AIGA_FUN_FOLDER
(
  fun_id               NUMBER(20) not null,
  sys_name             VARCHAR2(2000),
  create_time          DATE,
  update_time          DATE,
  sys_id               NUMBER(20),
  busi_label           VARCHAR2(2000),
  base_fun_label       VARCHAR2(2000),
  data_check_script    VARCHAR2(4000),
  important_class      NUMBER(4),
  menu_path            VARCHAR2(2000),
  fun_type             NUMBER(4),
  fun_desc             VARCHAR2(2000),
  is_invalid           NUMBER(4),
  add_reason_type      NUMBER(20),
  add_reason           VARCHAR2(4000),
  efficiency_test_type NUMBER(4),
  is_efficiency_test   NUMBER(4),
  dev_firm             NUMBER(4),
  sys_id_temp          VARCHAR2(255)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_FUN_FOLDER.fun_id
  is '功能点ID';
comment on column AIGA.AIGA_FUN_FOLDER.sys_name
  is '功能点名称';
comment on column AIGA.AIGA_FUN_FOLDER.create_time
  is '创建日期';
comment on column AIGA.AIGA_FUN_FOLDER.update_time
  is '更新日期';
comment on column AIGA.AIGA_FUN_FOLDER.sys_id
  is '归属系统ID';
comment on column AIGA.AIGA_FUN_FOLDER.busi_label
  is '业务标签';
comment on column AIGA.AIGA_FUN_FOLDER.base_fun_label
  is '基础功能标签';
comment on column AIGA.AIGA_FUN_FOLDER.data_check_script
  is '数据检查脚本';
comment on column AIGA.AIGA_FUN_FOLDER.important_class
  is '重要级别';
comment on column AIGA.AIGA_FUN_FOLDER.menu_path
  is '菜单路径';
comment on column AIGA.AIGA_FUN_FOLDER.fun_type
  is '功能点类型';
comment on column AIGA.AIGA_FUN_FOLDER.fun_desc
  is '功能点说明';
comment on column AIGA.AIGA_FUN_FOLDER.is_invalid
  is '是否已被禁用(1:已被禁用,0:未被禁用)';
comment on column AIGA.AIGA_FUN_FOLDER.add_reason_type
  is '新增原因类型';
comment on column AIGA.AIGA_FUN_FOLDER.add_reason
  is '新增原因';
comment on column AIGA.AIGA_FUN_FOLDER.efficiency_test_type
  is '性能测试类型';
comment on column AIGA.AIGA_FUN_FOLDER.is_efficiency_test
  is '是否性能测试';
comment on column AIGA.AIGA_FUN_FOLDER.dev_firm
  is '维护厂商';
comment on column AIGA.AIGA_FUN_FOLDER.sys_id_temp
  is '导入时暂存归属系统数据';
alter table AIGA.AIGA_FUN_FOLDER
  add primary key (FUN_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_FUN_FOLDER_TEMP
prompt ===================================
prompt
create table AIGA.AIGA_FUN_FOLDER_TEMP
(
  fun_id               NUMBER(20) not null,
  sys_name             VARCHAR2(2000),
  create_time          DATE,
  update_time          DATE,
  sys_id               VARCHAR2(255),
  busi_label           VARCHAR2(2000),
  base_fun_label       VARCHAR2(2000),
  data_check_script    VARCHAR2(4000),
  important_class      NUMBER(4),
  menu_path            VARCHAR2(2000),
  fun_type             NUMBER(4),
  fun_desc             VARCHAR2(2000),
  is_invalid           NUMBER(4),
  add_reason_type      NUMBER(20),
  add_reason           VARCHAR2(4000),
  efficiency_test_type NUMBER(4),
  is_efficiency_test   NUMBER(4),
  dev_firm             NUMBER(4)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_FUN_FOLDER_ZCM
prompt ==================================
prompt
create table AIGA.AIGA_FUN_FOLDER_ZCM
(
  fun_id            NUMBER(20),
  sys_name          VARCHAR2(2000),
  create_time       DATE,
  update_time       DATE,
  sys_id            NUMBER(20),
  busi_label        VARCHAR2(2000),
  base_fun_label    VARCHAR2(2000),
  data_check_script VARCHAR2(4000),
  important_class   NUMBER(4),
  menu_path         VARCHAR2(2000),
  fun_type          NUMBER(4),
  fun_desc          VARCHAR2(2000),
  is_invalid        NUMBER(4)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_FUN_POINT
prompt =============================
prompt
create table AIGA.AIGA_FUN_POINT
(
  fun_id            NUMBER(20) not null,
  fun_desc          VARCHAR2(2000),
  fun_type          NUMBER(4),
  sys_name          VARCHAR2(2000),
  create_time       DATE,
  update_time       DATE,
  sys_id            NUMBER(20),
  busi_label        VARCHAR2(2000),
  base_fun_label    VARCHAR2(2000),
  data_check_script VARCHAR2(4000),
  important_class   NUMBER(4),
  menu_path         VARCHAR2(2000),
  is_invalid        NUMBER(4),
  rela_folder_id    NUMBER(20),
  sub_task_id       NUMBER(20),
  fun_tag           VARCHAR2(255)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_FUN_POINT.fun_id
  is '功能点ID';
comment on column AIGA.AIGA_FUN_POINT.fun_desc
  is '功能点说明';
comment on column AIGA.AIGA_FUN_POINT.fun_type
  is '功能点类型';
comment on column AIGA.AIGA_FUN_POINT.sys_name
  is '功能点名称';
comment on column AIGA.AIGA_FUN_POINT.create_time
  is '创建日期';
comment on column AIGA.AIGA_FUN_POINT.update_time
  is '更新日期';
comment on column AIGA.AIGA_FUN_POINT.sys_id
  is '归属系统ID';
comment on column AIGA.AIGA_FUN_POINT.busi_label
  is '业务标签';
comment on column AIGA.AIGA_FUN_POINT.base_fun_label
  is '基础功能标签';
comment on column AIGA.AIGA_FUN_POINT.data_check_script
  is '数据检查脚本';
comment on column AIGA.AIGA_FUN_POINT.important_class
  is '重要级别';
comment on column AIGA.AIGA_FUN_POINT.menu_path
  is '菜单路径';
comment on column AIGA.AIGA_FUN_POINT.is_invalid
  is '是否已被禁用(1:已被禁用,0:未被禁用)';
comment on column AIGA.AIGA_FUN_POINT.rela_folder_id
  is '对应功能点模板ID';
comment on column AIGA.AIGA_FUN_POINT.sub_task_id
  is '对应子任务ID';
comment on column AIGA.AIGA_FUN_POINT.fun_tag
  is '功能点编号';
alter table AIGA.AIGA_FUN_POINT
  add constraint PK_AIGA_FUN_POINT$PRIMARY primary key (FUN_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_GROUP_CASE
prompt ==============================
prompt
create table AIGA.AIGA_GROUP_CASE
(
  case_id        NUMBER(20) not null,
  case_name      VARCHAR2(2000),
  case_desc      VARCHAR2(4000),
  case_type      NUMBER,
  test_purpose   VARCHAR2(2000),
  pre_condition  VARCHAR2(2000),
  AIGA_DATA_desc VARCHAR2(2000),
  test_step      CLOB,
  pre_result     VARCHAR2(2000),
  remark         VARCHAR2(4000),
  is_leaf        VARCHAR2(2),
  parent_id      NUMBER(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_GROUP_CASE.case_id
  is '用例ID';
comment on column AIGA.AIGA_GROUP_CASE.case_name
  is '用例名称';
comment on column AIGA.AIGA_GROUP_CASE.case_desc
  is '用例描述';
comment on column AIGA.AIGA_GROUP_CASE.case_type
  is '用例类型';
comment on column AIGA.AIGA_GROUP_CASE.test_purpose
  is '测试目的';
comment on column AIGA.AIGA_GROUP_CASE.pre_condition
  is '预置条件';
comment on column AIGA.AIGA_GROUP_CASE.AIGA_DATA_desc
  is '测试数据描述';
comment on column AIGA.AIGA_GROUP_CASE.test_step
  is '测试步骤';
comment on column AIGA.AIGA_GROUP_CASE.pre_result
  is '预期结果';
comment on column AIGA.AIGA_GROUP_CASE.remark
  is '备注';
comment on column AIGA.AIGA_GROUP_CASE.is_leaf
  is '是否是叶子节点';
comment on column AIGA.AIGA_GROUP_CASE.parent_id
  is '父节点';
alter table AIGA.AIGA_GROUP_CASE
  add primary key (CASE_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_GROUP_CASE_REQ
prompt ==================================
prompt
create table AIGA.AIGA_GROUP_CASE_REQ
(
  requisition_id   NUMBER(20) not null,
  requisition_name VARCHAR2(300),
  submit_date      DATE
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_GROUP_CASE_REQ.requisition_id
  is '需求ID';
comment on column AIGA.AIGA_GROUP_CASE_REQ.requisition_name
  is '需求名称';
comment on column AIGA.AIGA_GROUP_CASE_REQ.submit_date
  is '提交年月';
create unique index AIGA.FOREIGN_REQ on AIGA.AIGA_GROUP_CASE_REQ (REQUISITION_ID)
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_GROUP_CASE_REQ
  add constraint PRICASE_ID primary key (REQUISITION_ID)
  disable;

prompt
prompt Creating table AIGA_HIS_CASE
prompt ============================
prompt
create table AIGA.AIGA_HIS_CASE
(
  his_case_id          NUMBER(20) not null,
  operator_user        VARCHAR2(300),
  operator_name        VARCHAR2(300),
  operate_time         DATE,
  operator_type        VARCHAR2(200),
  case_id              NUMBER(20),
  case_name            VARCHAR2(255),
  fun_folder_id        NUMBER(20),
  case_desc            VARCHAR2(2048),
  create_time          DATE,
  update_time          DATE,
  author               VARCHAR2(255),
  latest_operator      VARCHAR2(255),
  base_case_id         NUMBER(20),
  sys_label            VARCHAR2(512),
  own_label            VARCHAR2(512),
  url                  VARCHAR2(2048),
  approval_psn         VARCHAR2(512),
  status               NUMBER(2),
  approval_name        VARCHAR2(512),
  author_no            VARCHAR2(512),
  important            NUMBER(2),
  maintenance_fac      NUMBER(2),
  regression_test      NUMBER(2),
  has_test             NUMBER(2),
  test_type            VARCHAR2(2000),
  case_type            NUMBER(2),
  efficiency_test      NUMBER(2),
  efficiency_test_type NUMBER(2),
  teminal_test         NUMBER(2),
  case_pre_cond        VARCHAR2(4000),
  case_operate_inst    VARCHAR2(4000),
  pre_result           VARCHAR2(4000),
  sec_id               NUMBER(20),
  elemvalue            VARCHAR2(4000),
  sub_task_tag         VARCHAR2(300),
  edit_type            NUMBER(2),
  temporary_tag        VARCHAR2(300),
  normal_mac           VARCHAR2(4000),
  is_delete            NUMBER,
  is_finish_auto       NUMBER,
  is_avail_auto        NUMBER
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_HIS_CASE
  add primary key (HIS_CASE_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_HIS_COMPONENT
prompt =================================
prompt
create table AIGA.AIGA_HIS_COMPONENT
(
  comp_id         NUMBER(20) not null,
  parent_id       NUMBER(20),
  comp_name       VARCHAR2(255),
  permission      NUMBER(4),
  path            VARCHAR2(255),
  default_val     VARCHAR2(255),
  comp_desc       VARCHAR2(255),
  create_time     DATE,
  update_time     DATE,
  author          VARCHAR2(255),
  latest_operator VARCHAR2(255),
  hashcode        VARCHAR2(255),
  url             VARCHAR2(255),
  extra           VARCHAR2(255),
  is_leaf         VARCHAR2(2),
  author_no       VARCHAR2(512),
  change_time     DATE
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 8K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_HIS_ELEM
prompt ============================
prompt
create table AIGA.AIGA_HIS_ELEM
(
  his_elem_id           NUMBER(20) not null,
  operator_user         VARCHAR2(300),
  operator_name         VARCHAR2(300),
  operate_time          DATE,
  operator_type         VARCHAR2(200),
  elem_id               NUMBER(20),
  elem_tag              VARCHAR2(2000),
  elem_name             VARCHAR2(4000),
  elem_sys_achieve_type NUMBER,
  applicate_sys         NUMBER,
  is_global_elem        NUMBER,
  sys_id                NUMBER(20),
  fun_id                NUMBER(20),
  staff_id              NUMBER(20),
  staff_name            VARCHAR2(50),
  is_delete             NUMBER,
  add_reason_type       NUMBER(20),
  add_reason            VARCHAR2(4000),
  fun_name              VARCHAR2(250),
  sys_name              VARCHAR2(250),
  sub_task_tag          VARCHAR2(300),
  edit_type             NUMBER(2),
  temporary_tag         VARCHAR2(300),
  normal_mac            VARCHAR2(4000)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_HIS_ELEM
  add primary key (HIS_ELEM_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_HIS_GUI
prompt ===========================
prompt
create table AIGA.AIGA_HIS_GUI
(
  gui_id              NUMBER(20) not null,
  gui_selector        VARCHAR2(255),
  gui_url             VARCHAR2(255),
  gui_tag             VARCHAR2(255),
  parent_id           NUMBER(20),
  gui_name            VARCHAR2(255),
  gui_permission      NUMBER(4),
  gui_path            VARCHAR2(255),
  gui_extra           VARCHAR2(255),
  gui_desc            VARCHAR2(255),
  gui_html            VARCHAR2(255),
  gui_create_time     DATE,
  gui_update_time     DATE,
  gui_author          VARCHAR2(255),
  gui_bounds          VARCHAR2(255),
  gui_hashcode        VARCHAR2(255),
  gui_latest_operator VARCHAR2(255),
  gui_thumb_url       VARCHAR2(255),
  change_time         DATE
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 8K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_HIS_RUN_TASK_RESULT
prompt =======================================
prompt
create table AIGA.AIGA_HIS_RUN_TASK_RESULT
(
  run_id       NUMBER,
  case_id      NUMBER,
  run_name     VARCHAR2(200),
  run_result   VARCHAR2(200),
  run_time     DATE,
  task_id      VARCHAR2(128),
  rela_result  VARCHAR2(4000),
  task_status  VARCHAR2(20),
  sub_task_id  NUMBER(20),
  task_tag     VARCHAR2(128),
  task_name    VARCHAR2(128),
  collect_type NUMBER(2),
  create_time  DATE,
  id           NUMBER not null
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_HIS_RUN_TASK_RESULT.case_id
  is '用例id';
comment on column AIGA.AIGA_HIS_RUN_TASK_RESULT.run_name
  is '执行名称';
comment on column AIGA.AIGA_HIS_RUN_TASK_RESULT.run_result
  is '执行结果';
comment on column AIGA.AIGA_HIS_RUN_TASK_RESULT.run_time
  is '执行时间';
comment on column AIGA.AIGA_HIS_RUN_TASK_RESULT.rela_result
  is '实际结果';
comment on column AIGA.AIGA_HIS_RUN_TASK_RESULT.task_status
  is '测试任务状态';
comment on column AIGA.AIGA_HIS_RUN_TASK_RESULT.sub_task_id
  is '测试子任务id';
comment on column AIGA.AIGA_HIS_RUN_TASK_RESULT.task_tag
  is '测试任务编号';
comment on column AIGA.AIGA_HIS_RUN_TASK_RESULT.task_name
  is '测试任务名称';
comment on column AIGA.AIGA_HIS_RUN_TASK_RESULT.collect_type
  is '测试环境 （1测试；2准发布；3生产）';
comment on column AIGA.AIGA_HIS_RUN_TASK_RESULT.create_time
  is '任务创建时间';
alter table AIGA.AIGA_HIS_RUN_TASK_RESULT
  add constraint PK_HIS_RUN_TASK_RESULT primary key (ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_HIS_SECENE
prompt ==============================
prompt
create table AIGA.AIGA_HIS_SECENE
(
  his_sec_id      NUMBER(20) not null,
  operator_user   VARCHAR2(300),
  operator_name   VARCHAR2(300),
  operate_time    DATE,
  operator_type   VARCHAR2(200),
  sec_id          NUMBER(20),
  secene_name     VARCHAR2(3000),
  analysis_method NUMBER(2),
  sec_order       NUMBER,
  sub_task_tag    VARCHAR2(300),
  edit_type       NUMBER(2),
  temporary_tag   VARCHAR2(300),
  normal_mac      VARCHAR2(4000)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_HIS_SECENE
  add primary key (HIS_SEC_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_HIS_SUB_ELEM
prompt ================================
prompt
create table AIGA.AIGA_HIS_SUB_ELEM
(
  his_sub_elem_id   NUMBER(20) not null,
  operator_user     VARCHAR2(300),
  operator_name     VARCHAR2(300),
  operate_time      DATE,
  operator_type     VARCHAR2(200),
  sub_elem_id       NUMBER(20),
  elem_id           NUMBER(20),
  elem_value        VARCHAR2(4000),
  elem_test_logic   VARCHAR2(4000),
  take_value_method VARCHAR2(4000),
  value_remark      VARCHAR2(4000),
  sub_task_tag      VARCHAR2(300),
  edit_type         NUMBER(2),
  temporary_tag     VARCHAR2(300),
  normal_mac        VARCHAR2(4000)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_HIS_SUB_ELEM.elem_value
  is '要素值';
comment on column AIGA.AIGA_HIS_SUB_ELEM.take_value_method
  is '取数方法';
comment on column AIGA.AIGA_HIS_SUB_ELEM.value_remark
  is '备注';
alter table AIGA.AIGA_HIS_SUB_ELEM
  add primary key (HIS_SUB_ELEM_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_INST_CASE
prompt =============================
prompt
create table AIGA.AIGA_INST_CASE
(
  case_id              NUMBER(20) not null,
  case_name            VARCHAR2(255),
  fun_folder_id        NUMBER(20),
  case_desc            VARCHAR2(2048),
  create_time          DATE,
  update_time          DATE,
  author               VARCHAR2(255),
  latest_operator      VARCHAR2(255),
  base_case_id         NUMBER(20),
  sys_label            VARCHAR2(512),
  own_label            VARCHAR2(512),
  url                  VARCHAR2(2048),
  approval_psn         VARCHAR2(512),
  status               NUMBER(2),
  approval_name        VARCHAR2(512),
  author_no            VARCHAR2(512),
  important            NUMBER(2),
  maintenance_fac      NUMBER(2),
  regression_test      NUMBER(2),
  has_test             NUMBER(2),
  test_type            VARCHAR2(2000),
  case_type            NUMBER(2),
  efficiency_test      NUMBER(2),
  efficiency_test_type NUMBER(2),
  teminal_test         NUMBER(2),
  case_pre_cond        VARCHAR2(4000),
  case_operate_inst    VARCHAR2(4000),
  pre_result           VARCHAR2(4000),
  sec_id               NUMBER(20),
  elemvalue            VARCHAR2(4000),
  is_delete            NUMBER,
  is_finish_auto       NUMBER,
  is_avail_auto        NUMBER,
  need_approval        VARCHAR2(2)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_INST_CASE.case_id
  is '主键';
comment on column AIGA.AIGA_INST_CASE.case_name
  is '用例名称';
comment on column AIGA.AIGA_INST_CASE.fun_folder_id
  is '功能点目录ID';
comment on column AIGA.AIGA_INST_CASE.case_desc
  is '用例描述';
comment on column AIGA.AIGA_INST_CASE.create_time
  is '创建时间';
comment on column AIGA.AIGA_INST_CASE.update_time
  is '修改时间';
comment on column AIGA.AIGA_INST_CASE.author
  is '用例作者';
comment on column AIGA.AIGA_INST_CASE.latest_operator
  is '最后修改人';
comment on column AIGA.AIGA_INST_CASE.base_case_id
  is 'BASE库中用例ID';
comment on column AIGA.AIGA_INST_CASE.sys_label
  is '系统标签描述';
comment on column AIGA.AIGA_INST_CASE.own_label
  is '自定义标签描述';
comment on column AIGA.AIGA_INST_CASE.url
  is '用例执行URL';
comment on column AIGA.AIGA_INST_CASE.approval_psn
  is '用例审批人CODE';
comment on column AIGA.AIGA_INST_CASE.status
  is '审批状态';
comment on column AIGA.AIGA_INST_CASE.approval_name
  is '用例审批人';
comment on column AIGA.AIGA_INST_CASE.author_no
  is '作者CODE';
comment on column AIGA.AIGA_INST_CASE.important
  is '重要级别';
comment on column AIGA.AIGA_INST_CASE.maintenance_fac
  is '用例维护厂商';
comment on column AIGA.AIGA_INST_CASE.regression_test
  is '是否为回归测试';
comment on column AIGA.AIGA_INST_CASE.has_test
  is '是否需要实现自动化';
comment on column AIGA.AIGA_INST_CASE.test_type
  is '测试类型';
comment on column AIGA.AIGA_INST_CASE.case_type
  is '测试类型';
comment on column AIGA.AIGA_INST_CASE.efficiency_test
  is '是否为性能测试';
comment on column AIGA.AIGA_INST_CASE.efficiency_test_type
  is '性能测试类型';
comment on column AIGA.AIGA_INST_CASE.teminal_test
  is '是否为端到端测试';
comment on column AIGA.AIGA_INST_CASE.case_pre_cond
  is '用例前置条件';
comment on column AIGA.AIGA_INST_CASE.case_operate_inst
  is '用例操作说明';
comment on column AIGA.AIGA_INST_CASE.pre_result
  is '预期结果';
comment on column AIGA.AIGA_INST_CASE.sec_id
  is '场景ID';
comment on column AIGA.AIGA_INST_CASE.elemvalue
  is '要素值';
comment on column AIGA.AIGA_INST_CASE.is_delete
  is '是否删除';
comment on column AIGA.AIGA_INST_CASE.is_finish_auto
  is '是否完成自动化';
comment on column AIGA.AIGA_INST_CASE.is_avail_auto
  is '是否可实现自动化';
comment on column AIGA.AIGA_INST_CASE.need_approval
  is '是否需要手工审批';
alter table AIGA.AIGA_INST_CASE
  add primary key (CASE_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_INST_CASE_COLLECTION
prompt ========================================
prompt
create table AIGA.AIGA_INST_CASE_COLLECTION
(
  collection_id      NUMBER(20) not null,
  collection_name    VARCHAR2(255),
  collection_desc    VARCHAR2(255),
  create_time        DATE,
  update_time        DATE,
  author             VARCHAR2(255),
  latest_operator    VARCHAR2(255),
  base_collection_id NUMBER(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_INST_CASE_COLLECTION
  add primary key (COLLECTION_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_INST_COMPONENT
prompt ==================================
prompt
create table AIGA.AIGA_INST_COMPONENT
(
  comp_id         NUMBER(20) not null,
  parent_id       NUMBER(20),
  comp_name       VARCHAR2(255),
  permission      NUMBER(4),
  path            VARCHAR2(255),
  default_val     VARCHAR2(255),
  comp_desc       VARCHAR2(255),
  create_time     DATE,
  update_time     DATE,
  author          VARCHAR2(255),
  latest_operator VARCHAR2(255),
  hashcode        VARCHAR2(255),
  url             VARCHAR2(255),
  extra           VARCHAR2(255),
  base_comp_id    NUMBER(20),
  is_leaf         VARCHAR2(2),
  approval_name   VARCHAR2(512),
  author_no       VARCHAR2(512),
  approval_psn    VARCHAR2(512)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_INST_COMPONENT
  add primary key (COMP_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_INST_GUI
prompt ============================
prompt
create table AIGA.AIGA_INST_GUI
(
  gui_id              NUMBER(20) not null,
  gui_selector        VARCHAR2(255),
  gui_url             VARCHAR2(255),
  gui_tag             VARCHAR2(255),
  parent_id           NUMBER(20),
  gui_name            VARCHAR2(255),
  gui_permission      NUMBER(4),
  gui_path            VARCHAR2(255),
  gui_extra           VARCHAR2(255),
  gui_desc            VARCHAR2(255),
  gui_html            VARCHAR2(255),
  gui_create_time     DATE,
  gui_update_time     DATE,
  gui_author          VARCHAR2(255),
  gui_bounds          VARCHAR2(255),
  gui_hashcode        VARCHAR2(255),
  gui_latest_operator VARCHAR2(255),
  gui_thumb_url       VARCHAR2(255),
  base_gui_id         NUMBER(20),
  is_leaf             VARCHAR2(2)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_INST_GUI
  add primary key (GUI_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_INST_R_CASE_COMP
prompt ====================================
prompt
create table AIGA.AIGA_INST_R_CASE_COMP
(
  ref_id         NUMBER(20) not null,
  case_id        NUMBER(20),
  comp_id        NUMBER(20),
  r_order        NUMBER(4),
  in_val         VARCHAR2(255),
  out_val        VARCHAR2(255),
  expectval      VARCHAR2(255),
  hinge          VARCHAR2(255),
  remark         VARCHAR2(255),
  ref_desc       VARCHAR2(255),
  base_ref_id    NUMBER(20),
  argu_name      VARCHAR2(255),
  manual_task_id NUMBER(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_INST_R_CASE_COMP
  add primary key (REF_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_INST_R_COLLECT_CASE
prompt =======================================
prompt
create table AIGA.AIGA_INST_R_COLLECT_CASE
(
  ref_id      NUMBER(20) not null,
  collect_id  NUMBER(20),
  case_id     NUMBER(20),
  r_order     NUMBER(4),
  base_ref_id NUMBER(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_INST_R_COLLECT_CASE
  add primary key (REF_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_INST_R_COMP_GUI
prompt ===================================
prompt
create table AIGA.AIGA_INST_R_COMP_GUI
(
  rela_id      NUMBER(20) not null,
  comp_id      NUMBER(20),
  gui_id       NUMBER(20),
  gui_order    NUMBER(20),
  base_rela_id NUMBER(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_INST_R_COMP_GUI
  add constraint RELA_ID$PRIMARY primary key (RELA_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_KNOWLEDGE
prompt =============================
prompt
create table AIGA.AIGA_KNOWLEDGE
(
  knowledge_id   NUMBER(20) not null,
  sys_name       VARCHAR2(255),
  sub_sys_name   VARCHAR2(255),
  module_name    VARCHAR2(255),
  knowledge_name VARCHAR2(255),
  knowledge_type NUMBER(4),
  knowledge_desc VARCHAR2(2048)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_KNOWLEDGE.knowledge_id
  is '主键';
comment on column AIGA.AIGA_KNOWLEDGE.sys_name
  is '系统名称';
comment on column AIGA.AIGA_KNOWLEDGE.sub_sys_name
  is '子系统名称';
comment on column AIGA.AIGA_KNOWLEDGE.module_name
  is '模块名称';
comment on column AIGA.AIGA_KNOWLEDGE.knowledge_name
  is '知识点名称';
comment on column AIGA.AIGA_KNOWLEDGE.knowledge_type
  is '知识点类型';
comment on column AIGA.AIGA_KNOWLEDGE.knowledge_desc
  is '知识点描述';
alter table AIGA.AIGA_KNOWLEDGE
  add constraint PK_AIGA_KNOWLEDGE primary key (KNOWLEDGE_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_LABEL
prompt =========================
prompt
create table AIGA.AIGA_LABEL
(
  label_id    NUMBER(20) not null,
  parent_id   NUMBER(20),
  label_name  VARCHAR2(255),
  label_type  NUMBER(4),
  label_level NUMBER(4),
  create_time DATE,
  label_desc  VARCHAR2(255),
  is_leaf     NUMBER(4) default 0
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_LABEL.label_id
  is '主键ID';
comment on column AIGA.AIGA_LABEL.parent_id
  is '父ID';
comment on column AIGA.AIGA_LABEL.label_name
  is '标签名称';
comment on column AIGA.AIGA_LABEL.label_type
  is '标签类型';
comment on column AIGA.AIGA_LABEL.label_level
  is '标签级别';
comment on column AIGA.AIGA_LABEL.create_time
  is '创建时间';
comment on column AIGA.AIGA_LABEL.label_desc
  is '标签描述';
comment on column AIGA.AIGA_LABEL.is_leaf
  is '是否为叶子节点';
alter table AIGA.AIGA_LABEL
  add constraint AIGA_LABEL$PRIMARY primary key (LABEL_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_LINKTME_CONFIG
prompt ==================================
prompt
create table AIGA.AIGA_LINKTME_CONFIG
(
  id      NUMBER(12) not null,
  link_no VARCHAR2(32),
  day_num NUMBER(3),
  mark    VARCHAR2(2),
  operate NUMBER(1),
  base    NUMBER(1)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_LINKTME_CONFIG.id
  is '主键';
comment on column AIGA.AIGA_LINKTME_CONFIG.link_no
  is '环节编号';
comment on column AIGA.AIGA_LINKTME_CONFIG.day_num
  is '处理天数';
comment on column AIGA.AIGA_LINKTME_CONFIG.mark
  is '标示符，标识正常或者紧急流程';
comment on column AIGA.AIGA_LINKTME_CONFIG.operate
  is '运算标识，0为T减。1为T加';
comment on column AIGA.AIGA_LINKTME_CONFIG.base
  is '计算根据，0代表从当前时间开始，1代表从计划完成时间开始';
alter table AIGA.AIGA_LINKTME_CONFIG
  add constraint PK_LC primary key (ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_LOG_ELEMENT
prompt ===============================
prompt
create table AIGA.AIGA_LOG_ELEMENT
(
  element_id       NUMBER not null,
  element_argument VARCHAR2(2000),
  element_method   VARCHAR2(2000),
  element_value    VARCHAR2(2000),
  step_id          NUMBER,
  element_index    NUMBER,
  expect_value     VARCHAR2(2000),
  actual_value     VARCHAR2(2000)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_LOG_ELEMENT
  add constraint AIGA_LOG_ELEMNT$PRIMARY primary key (ELEMENT_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_LOG_STEP
prompt ============================
prompt
create table AIGA.AIGA_LOG_STEP
(
  step_id        NUMBER not null,
  step_name      VARCHAR2(200),
  result         VARCHAR2(200),
  test_id        NUMBER,
  step_index     NUMBER,
  manual_task_id NUMBER
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_LOG_STEP
  add constraint AIGA_LOG_STEP$PRIMARY primary key (STEP_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_LOG_TEST_CASE
prompt =================================
prompt
create table AIGA.AIGA_LOG_TEST_CASE
(
  case_id   NUMBER,
  run_id    NUMBER,
  log_info  VARCHAR2(3000),
  err_info  VARCHAR2(3000),
  test_id   NUMBER not null,
  case_type NUMBER
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_LOG_TEST_CASE
  add constraint AIGA_LOG_TEST_CASE$PRIMARY primary key (TEST_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_MANUAL_TASK
prompt ===============================
prompt
create table AIGA.AIGA_MANUAL_TASK
(
  task_id       NUMBER(20) not null,
  task_name     VARCHAR2(400),
  task_desc     VARCHAR2(3000),
  create_time   DATE,
  update_time   DATE,
  pre_result    VARCHAR2(3000),
  pre_AIGA_DATA VARCHAR2(3000),
  case_id       NUMBER(20),
  describe      VARCHAR2(3000),
  actual_result VARCHAR2(3000),
  task_order    NUMBER(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_MANUAL_TASK
  add constraint MANUAL_TASK$PRIMARY primary key (TASK_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_MENU
prompt ========================
prompt
create table AIGA.AIGA_MENU
(
  menu_id     NUMBER(11) not null,
  parent_id   NUMBER(11),
  sort        NUMBER(11),
  leaf        VARCHAR2(20),
  type        VARCHAR2(20),
  component   VARCHAR2(255),
  menu_text   VARCHAR2(255),
  discription VARCHAR2(255),
  icon_cls    VARCHAR2(255)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_MENU.menu_id
  is '主键ID';
comment on column AIGA.AIGA_MENU.parent_id
  is '父ID';
comment on column AIGA.AIGA_MENU.sort
  is '顺序';
comment on column AIGA.AIGA_MENU.leaf
  is '是否叶子节点';
comment on column AIGA.AIGA_MENU.type
  is '类型';
comment on column AIGA.AIGA_MENU.component
  is '扩展';
comment on column AIGA.AIGA_MENU.menu_text
  is '显示值';
comment on column AIGA.AIGA_MENU.discription
  is '描述';
comment on column AIGA.AIGA_MENU.icon_cls
  is '图标类';
alter table AIGA.AIGA_MENU
  add constraint PK_AIGA_MENU_ID primary key (MENU_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_MONTH_DEL_SLA
prompt =================================
prompt
create table AIGA.AIGA_MONTH_DEL_SLA
(
  sla_id                 NUMBER(20) not null,
  target_attention       VARCHAR2(255),
  sla_name               VARCHAR2(255),
  scope_of_application   VARCHAR2(255),
  sla_define             VARCHAR2(255),
  computational_formula  VARCHAR2(255),
  responsible_person     VARCHAR2(20),
  target_reach_situation VARCHAR2(255),
  remarks                VARCHAR2(4000),
  sla_status             NUMBER(4) default 1
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_MONTH_DEL_SLA.sla_id
  is '衡量交付ID';
comment on column AIGA.AIGA_MONTH_DEL_SLA.target_attention
  is '指标关注';
comment on column AIGA.AIGA_MONTH_DEL_SLA.sla_name
  is 'SLA名称';
comment on column AIGA.AIGA_MONTH_DEL_SLA.scope_of_application
  is '适用范围';
comment on column AIGA.AIGA_MONTH_DEL_SLA.sla_define
  is 'SLA定义';
comment on column AIGA.AIGA_MONTH_DEL_SLA.computational_formula
  is '计算公式';
comment on column AIGA.AIGA_MONTH_DEL_SLA.responsible_person
  is '指标负责人';
comment on column AIGA.AIGA_MONTH_DEL_SLA.target_reach_situation
  is '指标达成情况';
comment on column AIGA.AIGA_MONTH_DEL_SLA.remarks
  is '备注';
comment on column AIGA.AIGA_MONTH_DEL_SLA.sla_status
  is 'SLA状态(1:可用,0:删除)';
alter table AIGA.AIGA_MONTH_DEL_SLA
  add constraint PK_AIGA_MONTH_DEL_SLA primary key (SLA_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_MONTH_REP_KPI
prompt =================================
prompt
create table AIGA.AIGA_MONTH_REP_KPI
(
  kpi_id                NUMBER(20) not null,
  kpi_name              VARCHAR2(255),
  computational_formula VARCHAR2(255),
  kpi_measures          VARCHAR2(255),
  kpi_assessment        VARCHAR2(255),
  kpi_plan              VARCHAR2(255),
  responsible_person    VARCHAR2(255),
  remarks               VARCHAR2(4000),
  kpi_status            NUMBER(4) default 1,
  kpi_question          VARCHAR2(255)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_MONTH_REP_KPI.kpi_id
  is 'KPIID';
comment on column AIGA.AIGA_MONTH_REP_KPI.kpi_name
  is 'KPI名称';
comment on column AIGA.AIGA_MONTH_REP_KPI.computational_formula
  is '计算方式';
comment on column AIGA.AIGA_MONTH_REP_KPI.kpi_measures
  is '措施';
comment on column AIGA.AIGA_MONTH_REP_KPI.kpi_assessment
  is '考核';
comment on column AIGA.AIGA_MONTH_REP_KPI.kpi_plan
  is '计划';
comment on column AIGA.AIGA_MONTH_REP_KPI.responsible_person
  is '负责人';
comment on column AIGA.AIGA_MONTH_REP_KPI.remarks
  is '备注';
comment on column AIGA.AIGA_MONTH_REP_KPI.kpi_status
  is 'kpi状态(1:可用,0:删除)';
comment on column AIGA.AIGA_MONTH_REP_KPI.kpi_question
  is '问题';
alter table AIGA.AIGA_MONTH_REP_KPI
  add constraint PK_AIGA_MONTH_REP_KPI primary key (KPI_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_MONTH_RUN_KPI
prompt =================================
prompt
create table AIGA.AIGA_MONTH_RUN_KPI
(
  kpi_id                NUMBER(20) not null,
  target_attention      VARCHAR2(200),
  kpi_name              VARCHAR2(200),
  kpi_define            VARCHAR2(200),
  computational_formula VARCHAR2(200),
  target_unit           VARCHAR2(20),
  standard_value        VARCHAR2(10),
  target_provide_time   VARCHAR2(50),
  target_department     VARCHAR2(50),
  statistics_cycle_time VARCHAR2(10),
  kpi_status            VARCHAR2(10)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_MONTH_RUN_KPI.kpi_id
  is 'kpi数据id';
comment on column AIGA.AIGA_MONTH_RUN_KPI.target_attention
  is '指标关注';
comment on column AIGA.AIGA_MONTH_RUN_KPI.kpi_name
  is 'kpi名称';
comment on column AIGA.AIGA_MONTH_RUN_KPI.kpi_define
  is 'kpi定义';
comment on column AIGA.AIGA_MONTH_RUN_KPI.computational_formula
  is '计算公式';
comment on column AIGA.AIGA_MONTH_RUN_KPI.target_unit
  is '指标单位';
comment on column AIGA.AIGA_MONTH_RUN_KPI.standard_value
  is '达标值';
comment on column AIGA.AIGA_MONTH_RUN_KPI.target_provide_time
  is '指标提供时间';
comment on column AIGA.AIGA_MONTH_RUN_KPI.target_department
  is '指标负责部门';
comment on column AIGA.AIGA_MONTH_RUN_KPI.statistics_cycle_time
  is '统计周期';
comment on column AIGA.AIGA_MONTH_RUN_KPI.kpi_status
  is '状态';
alter table AIGA.AIGA_MONTH_RUN_KPI
  add constraint AIGA_MONTH_RUN_KPI$PRIMARY primary key (KPI_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_PERFORMANCE_SUB_TASK
prompt ========================================
prompt
create table AIGA.AIGA_PERFORMANCE_SUB_TASK
(
  per_id               NUMBER(20) not null,
  sys_name             VARCHAR2(255),
  busi_name            VARCHAR2(255),
  simple_desc          VARCHAR2(2048),
  accept_channel       VARCHAR2(2048),
  proportion           VARCHAR2(255),
  test_opinion         VARCHAR2(2048),
  average_time_require VARCHAR2(2048),
  tps                  VARCHAR2(255),
  peak_busi            VARCHAR2(255),
  busi_city            VARCHAR2(255),
  peak_desc            VARCHAR2(2048),
  web_server           VARCHAR2(1024),
  inter_server         VARCHAR2(1024),
  app_server           VARCHAR2(1024),
  db_server            VARCHAR2(1024),
  other_server         VARCHAR2(1024),
  rela_sub_task_id     NUMBER(20),
  channel_text         VARCHAR2(1024),
  channel_check        VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_PERFORMANCE_SUB_TASK.per_id
  is '主键ID';
comment on column AIGA.AIGA_PERFORMANCE_SUB_TASK.sys_name
  is '系统名称';
comment on column AIGA.AIGA_PERFORMANCE_SUB_TASK.busi_name
  is '业务/功能名称';
comment on column AIGA.AIGA_PERFORMANCE_SUB_TASK.simple_desc
  is '简要说明';
comment on column AIGA.AIGA_PERFORMANCE_SUB_TASK.accept_channel
  is '受理渠道';
comment on column AIGA.AIGA_PERFORMANCE_SUB_TASK.proportion
  is '渠道业务比例';
comment on column AIGA.AIGA_PERFORMANCE_SUB_TASK.test_opinion
  is '测试建议';
comment on column AIGA.AIGA_PERFORMANCE_SUB_TASK.average_time_require
  is '平均响应时间要求';
comment on column AIGA.AIGA_PERFORMANCE_SUB_TASK.tps
  is '每秒交易数';
comment on column AIGA.AIGA_PERFORMANCE_SUB_TASK.peak_busi
  is '高峰一小时交易量';
comment on column AIGA.AIGA_PERFORMANCE_SUB_TASK.busi_city
  is '业务量最大城市';
comment on column AIGA.AIGA_PERFORMANCE_SUB_TASK.peak_desc
  is '高峰日或高峰小时说明';
comment on column AIGA.AIGA_PERFORMANCE_SUB_TASK.web_server
  is 'web服务器';
comment on column AIGA.AIGA_PERFORMANCE_SUB_TASK.inter_server
  is '接口服务器';
comment on column AIGA.AIGA_PERFORMANCE_SUB_TASK.app_server
  is 'app服务器';
comment on column AIGA.AIGA_PERFORMANCE_SUB_TASK.db_server
  is '数据库服务器';
comment on column AIGA.AIGA_PERFORMANCE_SUB_TASK.other_server
  is '其它服务器';
comment on column AIGA.AIGA_PERFORMANCE_SUB_TASK.rela_sub_task_id
  is '关联子任务ID';
comment on column AIGA.AIGA_PERFORMANCE_SUB_TASK.channel_text
  is '渠道说明';
comment on column AIGA.AIGA_PERFORMANCE_SUB_TASK.channel_check
  is '渠道CHECK选择值';
alter table AIGA.AIGA_PERFORMANCE_SUB_TASK
  add constraint PK_PERFORMANCE_SUB_TASK primary key (PER_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_PERFTEST_TASK
prompt =================================
prompt
create table AIGA.AIGA_PERFTEST_TASK
(
  pft_id        NUMBER(20) not null,
  task_tag      VARCHAR2(255),
  test_obj_type NUMBER(5),
  test_obj_dscr VARCHAR2(4000),
  perf_demand   VARCHAR2(4000)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_PERFTEST_TASK.pft_id
  is '性能测试任务主键id';
comment on column AIGA.AIGA_PERFTEST_TASK.task_tag
  is '测试任务编码';
comment on column AIGA.AIGA_PERFTEST_TASK.test_obj_type
  is '测试对象类型';
comment on column AIGA.AIGA_PERFTEST_TASK.test_obj_dscr
  is '测试对象描述';
comment on column AIGA.AIGA_PERFTEST_TASK.perf_demand
  is '性能要求';
alter table AIGA.AIGA_PERFTEST_TASK
  add primary key (PFT_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_PERF_SUB_RESULT
prompt ===================================
prompt
create table AIGA.AIGA_PERF_SUB_RESULT
(
  result_id      NUMBER(20) not null,
  sub_task_id    NUMBER(20),
  sys_name       VARCHAR2(255),
  fun_name       VARCHAR2(255),
  target_name    VARCHAR2(255),
  count_aperture VARCHAR2(255),
  condition_desc VARCHAR2(255),
  target_value   VARCHAR2(255),
  result_desc    VARCHAR2(255),
  test_value     VARCHAR2(255),
  result_judge   VARCHAR2(255),
  result_review  VARCHAR2(255),
  result_exp     VARCHAR2(255)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_PERF_SUB_RESULT.result_id
  is '主键ID';
comment on column AIGA.AIGA_PERF_SUB_RESULT.sub_task_id
  is '关联子任务ID';
comment on column AIGA.AIGA_PERF_SUB_RESULT.sys_name
  is '系统';
comment on column AIGA.AIGA_PERF_SUB_RESULT.fun_name
  is '功能';
comment on column AIGA.AIGA_PERF_SUB_RESULT.target_name
  is '指标名称';
comment on column AIGA.AIGA_PERF_SUB_RESULT.count_aperture
  is '统计口径';
comment on column AIGA.AIGA_PERF_SUB_RESULT.condition_desc
  is '生产条件说明';
comment on column AIGA.AIGA_PERF_SUB_RESULT.target_value
  is '目标值';
comment on column AIGA.AIGA_PERF_SUB_RESULT.result_desc
  is '测试条件说明';
comment on column AIGA.AIGA_PERF_SUB_RESULT.test_value
  is '测试值';
comment on column AIGA.AIGA_PERF_SUB_RESULT.result_judge
  is '测试判定结果';
comment on column AIGA.AIGA_PERF_SUB_RESULT.result_review
  is '最终评审结果';
comment on column AIGA.AIGA_PERF_SUB_RESULT.result_exp
  is '结果说明';
alter table AIGA.AIGA_PERF_SUB_RESULT
  add constraint PK_AIGA_PERF_SUB_RESULT primary key (RESULT_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_QUALITY_MANAGE
prompt ==================================
prompt
create table AIGA.AIGA_QUALITY_MANAGE
(
  qm_id         NUMBER(20) not null,
  system_type   VARCHAR2(200),
  qm_tag        VARCHAR2(200),
  qm_name       VARCHAR2(2000),
  update_time   DATE,
  update_log    VARCHAR2(2000),
  file_path     VARCHAR2(2000),
  relation_doc  VARCHAR2(2000),
  response_name VARCHAR2(2000),
  approval_name VARCHAR2(2000)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_QUALITY_MANAGE
  add primary key (QM_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_REQUISITION
prompt ===============================
prompt
create table AIGA.AIGA_REQUISITION
(
  req_id                   NUMBER(20) not null,
  req_name                 VARCHAR2(255),
  req_desc                 VARCHAR2(255),
  create_time              DATE,
  resource_list            VARCHAR2(2048),
  other_system_test_needed NUMBER(11),
  performce_test_needed    NUMBER(11),
  importance               NUMBER(11),
  req_no                   VARCHAR2(255),
  system_category          VARCHAR2(512),
  system_sub_category      VARCHAR2(512),
  system_function          VARCHAR2(1024),
  dev                      VARCHAR2(512),
  priority                 NUMBER(4),
  status                   NUMBER(2),
  test_importance          NUMBER(11),
  is_over_circle           NUMBER(11),
  is_client_client         NUMBER(11),
  test_work_days           NUMBER(11),
  dev_work_days            NUMBER(11),
  req_source               VARCHAR2(512),
  req_grade                VARCHAR2(512),
  req_class                VARCHAR2(512),
  req_type                 VARCHAR2(512),
  req_modify_type          VARCHAR2(512),
  req_modify_reason        VARCHAR2(512),
  req_modify_time          TIMESTAMP(6),
  req_end_time             TIMESTAMP(6),
  test_reply               VARCHAR2(4000),
  req_analysis             VARCHAR2(4000),
  now_test_info            VARCHAR2(4000)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_REQUISITION.req_id
  is '主键ID';
comment on column AIGA.AIGA_REQUISITION.req_name
  is '需求名称';
comment on column AIGA.AIGA_REQUISITION.req_desc
  is '需求描述';
comment on column AIGA.AIGA_REQUISITION.create_time
  is '需求创建时间';
comment on column AIGA.AIGA_REQUISITION.resource_list
  is '需要资源列表';
comment on column AIGA.AIGA_REQUISITION.other_system_test_needed
  is '是否需要联调';
comment on column AIGA.AIGA_REQUISITION.performce_test_needed
  is '是否性能测试';
comment on column AIGA.AIGA_REQUISITION.importance
  is '需求重要程度';
comment on column AIGA.AIGA_REQUISITION.req_no
  is '需求编号';
comment on column AIGA.AIGA_REQUISITION.system_category
  is '系统大类';
comment on column AIGA.AIGA_REQUISITION.system_sub_category
  is '系统子类';
comment on column AIGA.AIGA_REQUISITION.system_function
  is '功能模块';
comment on column AIGA.AIGA_REQUISITION.dev
  is '开发商';
comment on column AIGA.AIGA_REQUISITION.priority
  is '需求优先级';
comment on column AIGA.AIGA_REQUISITION.status
  is '需求状态';
comment on column AIGA.AIGA_REQUISITION.test_importance
  is '测试重要程度';
comment on column AIGA.AIGA_REQUISITION.is_over_circle
  is '是否跨周期需求';
comment on column AIGA.AIGA_REQUISITION.is_client_client
  is '是否端到端测试';
comment on column AIGA.AIGA_REQUISITION.test_work_days
  is '测试任务工时';
comment on column AIGA.AIGA_REQUISITION.dev_work_days
  is '开发任务工时';
comment on column AIGA.AIGA_REQUISITION.req_source
  is '需求来源';
comment on column AIGA.AIGA_REQUISITION.req_grade
  is '需求级别';
comment on column AIGA.AIGA_REQUISITION.req_class
  is '需求分类';
comment on column AIGA.AIGA_REQUISITION.req_type
  is '需求类型';
comment on column AIGA.AIGA_REQUISITION.req_modify_type
  is '需求变更类型';
comment on column AIGA.AIGA_REQUISITION.req_modify_reason
  is '变更原因';
comment on column AIGA.AIGA_REQUISITION.req_modify_time
  is '变更时间';
comment on column AIGA.AIGA_REQUISITION.req_end_time
  is '终排时间';
comment on column AIGA.AIGA_REQUISITION.test_reply
  is '测试依据/主要需求描述';
comment on column AIGA.AIGA_REQUISITION.req_analysis
  is '需求分析';
comment on column AIGA.AIGA_REQUISITION.now_test_info
  is '现状测试';
alter table AIGA.AIGA_REQUISITION
  add constraint AIGA_REQUISITION primary key (REQ_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_RES_DEVICE
prompt ==============================
prompt
create table AIGA.AIGA_RES_DEVICE
(
  res_id      NUMBER(20) not null,
  device_name VARCHAR2(1024),
  memo        VARCHAR2(2048),
  res_num     NUMBER(10),
  site        VARCHAR2(2048)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_RES_DEVICE
  add primary key (RES_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_RES_EASILY_CONSUMED
prompt =======================================
prompt
create table AIGA.AIGA_RES_EASILY_CONSUMED
(
  res_id     NUMBER(20) not null,
  res_type   VARCHAR2(1024),
  group_name VARCHAR2(1024),
  res_num    NUMBER(10),
  memo       VARCHAR2(2048)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_RES_EASILY_CONSUMED
  add primary key (RES_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_RES_REALCARD
prompt ================================
prompt
create table AIGA.AIGA_RES_REALCARD
(
  res_id         NUMBER(20) not null,
  group_name     VARCHAR2(1024),
  brand          VARCHAR2(1024),
  phone_no       VARCHAR2(1024),
  cust_name      VARCHAR2(2048),
  used_by        VARCHAR2(1024),
  contact_name   VARCHAR2(1024),
  pay_method     VARCHAR2(1024),
  support_method VARCHAR2(2048),
  memo           VARCHAR2(2048),
  state          VARCHAR2(1024),
  combo          VARCHAR2(1024)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_RES_REALCARD
  add primary key (RES_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_RES_VIRCARD
prompt ===============================
prompt
create table AIGA.AIGA_RES_VIRCARD
(
  res_id     NUMBER(20) not null,
  group_name VARCHAR2(1024),
  phone_no   VARCHAR2(1024),
  imsi       VARCHAR2(1024),
  iccid      VARCHAR2(1024),
  memo       VARCHAR2(2048),
  state      VARCHAR2(1024)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_RES_VIRCARD
  add primary key (RES_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_RUN_PLAN
prompt ============================
prompt
create table AIGA.AIGA_RUN_PLAN
(
  run_id      NUMBER not null,
  run_name    VARCHAR2(200),
  case_id     NUMBER,
  run_info    NVARCHAR2(2000),
  run_result  VARCHAR2(200),
  run_time    DATE,
  task_id     VARCHAR2(128),
  status      NUMBER,
  case_order  NUMBER,
  rela_result VARCHAR2(4000)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_RUN_PLAN.run_id
  is '主键';
comment on column AIGA.AIGA_RUN_PLAN.run_name
  is '执行名称';
comment on column AIGA.AIGA_RUN_PLAN.case_id
  is '用例名称';
comment on column AIGA.AIGA_RUN_PLAN.run_info
  is '执行信息';
comment on column AIGA.AIGA_RUN_PLAN.run_result
  is '执行结果';
comment on column AIGA.AIGA_RUN_PLAN.run_time
  is '执行时间';
comment on column AIGA.AIGA_RUN_PLAN.task_id
  is 'aiga_run_task主键';
comment on column AIGA.AIGA_RUN_PLAN.status
  is '执行状态';
comment on column AIGA.AIGA_RUN_PLAN.case_order
  is '用例顺序';
comment on column AIGA.AIGA_RUN_PLAN.rela_result
  is '实际结果';
alter table AIGA.AIGA_RUN_PLAN
  add constraint AIGA_RUN_PLAN$PRIMARY primary key (RUN_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_RUN_TASK
prompt ============================
prompt
create table AIGA.AIGA_RUN_TASK
(
  task_id      VARCHAR2(128) not null,
  task_status  VARCHAR2(20),
  sub_task_id  NUMBER(20),
  task_flag    NUMBER(20),
  task_result  VARCHAR2(2000),
  task_tag     VARCHAR2(128),
  task_name    VARCHAR2(128),
  collect_type NUMBER(2),
  create_time  DATE,
  update_time  DATE
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_RUN_TASK.task_id
  is '主键';
comment on column AIGA.AIGA_RUN_TASK.task_status
  is '测试任务状态';
comment on column AIGA.AIGA_RUN_TASK.sub_task_id
  is '测试子任务';
comment on column AIGA.AIGA_RUN_TASK.task_result
  is '测试任务结果';
comment on column AIGA.AIGA_RUN_TASK.task_tag
  is '测试任务编号';
comment on column AIGA.AIGA_RUN_TASK.task_name
  is '测试任务名称';
comment on column AIGA.AIGA_RUN_TASK.create_time
  is '创建时间';
comment on column AIGA.AIGA_RUN_TASK.update_time
  is '状态变更时间';
alter table AIGA.AIGA_RUN_TASK
  add constraint AIGA_RUN_TASK$PRIMARY primary key (TASK_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_R_CASE_ELEM
prompt ===============================
prompt
create table AIGA.AIGA_R_CASE_ELEM
(
  rela_id     NUMBER(20) not null,
  case_id     NUMBER(20),
  elem_id     NUMBER(20),
  sub_elem_id NUMBER(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_R_CASE_ELEM
  add primary key (RELA_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_R_CLASS
prompt ===========================
prompt
create table AIGA.AIGA_R_CLASS
(
  ref_id       NUMBER,
  class_a_path VARCHAR2(200),
  class_b_path VARCHAR2(200),
  ref_key      VARCHAR2(100)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_R_ELEM_CASE
prompt ===============================
prompt
create table AIGA.AIGA_R_ELEM_CASE
(
  ref_id     NUMBER(20) not null,
  case_id    NUMBER(20),
  elem_tag   VARCHAR2(100),
  ref_value  VARCHAR2(200),
  case_type  VARCHAR2(200),
  case_order NUMBER(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_R_ELEM_CASE
  add constraint AIGA_ELEM_CASE$PRIMARY primary key (REF_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_R_ELEM_SEC
prompt ==============================
prompt
create table AIGA.AIGA_R_ELEM_SEC
(
  rela_id      NUMBER(20) not null,
  elem_id      NUMBER(20),
  sec_id       NUMBER(20),
  sub_elem_ids VARCHAR2(4000),
  elem_order   NUMBER(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
create index AIGA.INDEX_R_ELEM_SEC_SEC_ID on AIGA.AIGA_R_ELEM_SEC (SEC_ID)
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_R_ELEM_SEC
  add primary key (RELA_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_R_FUN_CASE
prompt ==============================
prompt
create table AIGA.AIGA_R_FUN_CASE
(
  rela_id   NUMBER(20) not null,
  fun_id    NUMBER(20),
  case_id   NUMBER(20),
  ref_value VARCHAR2(200)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_R_FUN_CASE.fun_id
  is '功能点id';
comment on column AIGA.AIGA_R_FUN_CASE.case_id
  is '用例id';
comment on column AIGA.AIGA_R_FUN_CASE.ref_value
  is '环境类型';
alter table AIGA.AIGA_R_FUN_CASE
  add primary key (RELA_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_R_FUN_ELEM
prompt ==============================
prompt
create table AIGA.AIGA_R_FUN_ELEM
(
  rela_id    NUMBER(20) not null,
  elem_id    NUMBER(20),
  fun_id     NUMBER(20),
  rela_order NUMBER
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_R_FUN_ELEM
  add primary key (RELA_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_R_SUB_CASE
prompt ==============================
prompt
create table AIGA.AIGA_R_SUB_CASE
(
  rela_id     NUMBER(20) not null,
  case_id     NUMBER(20),
  sub_task_id NUMBER(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_R_SUB_CASE.rela_id
  is '主键';
comment on column AIGA.AIGA_R_SUB_CASE.case_id
  is '关联用例ID';
comment on column AIGA.AIGA_R_SUB_CASE.sub_task_id
  is '端到端子任务ID';
alter table AIGA.AIGA_R_SUB_CASE
  add constraint PK_AIGA_R_SUB_CASE primary key (RELA_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_SECENE
prompt ==========================
prompt
create table AIGA.AIGA_SECENE
(
  sec_id          NUMBER(20) not null,
  secene_name     VARCHAR2(3000),
  analysis_method NUMBER(2),
  sec_order       NUMBER,
  is_delete       NUMBER
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_SECENE.sec_id
  is '主键';
comment on column AIGA.AIGA_SECENE.secene_name
  is '场景名称';
comment on column AIGA.AIGA_SECENE.analysis_method
  is '分析方法';
comment on column AIGA.AIGA_SECENE.sec_order
  is '场景顺序';
comment on column AIGA.AIGA_SECENE.is_delete
  is '是否删除';
alter table AIGA.AIGA_SECENE
  add primary key (SEC_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_SOLID_TASK
prompt ==============================
prompt
create table AIGA.AIGA_SOLID_TASK
(
  task_id             NUMBER(20) not null,
  task_type           NUMBER(2),
  plan_tag            VARCHAR2(255),
  pl_complete_time    DATE,
  fact_complete_time  DATE,
  create_time         DATE,
  begin_time          DATE,
  is_security_test    NUMBER(4),
  is_code_scan        NUMBER(4),
  is_performance_test NUMBER(4),
  is_regression_test  NUMBER(4),
  version_content     NUMBER(20),
  task_status         NUMBER(20),
  req_time            DATE,
  code_commit_date    DATE,
  on_line_type        NUMBER(20),
  big_type            NUMBER(20),
  change_reason       VARCHAR2(512),
  plan_id             NUMBER(20),
  plan_name           VARCHAR2(255),
  submit_staff_id     NUMBER(20),
  submit_staff_name   VARCHAR2(255),
  plan_dscr           VARCHAR2(4000),
  task_phase          NUMBER(4)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_SOLID_TASK.task_id
  is '主键ID';
comment on column AIGA.AIGA_SOLID_TASK.task_type
  is '固化任务类型';
comment on column AIGA.AIGA_SOLID_TASK.plan_tag
  is '计划编号';
comment on column AIGA.AIGA_SOLID_TASK.pl_complete_time
  is '计划期望上线时间';
comment on column AIGA.AIGA_SOLID_TASK.fact_complete_time
  is '计划实际上线时间';
comment on column AIGA.AIGA_SOLID_TASK.create_time
  is '计划创建时间';
comment on column AIGA.AIGA_SOLID_TASK.begin_time
  is '计划开始时间';
comment on column AIGA.AIGA_SOLID_TASK.is_security_test
  is '是否安全测试';
comment on column AIGA.AIGA_SOLID_TASK.is_code_scan
  is '是否代码扫描';
comment on column AIGA.AIGA_SOLID_TASK.is_performance_test
  is '是否性能测试';
comment on column AIGA.AIGA_SOLID_TASK.is_regression_test
  is '是否回归测试';
comment on column AIGA.AIGA_SOLID_TASK.version_content
  is '版本id';
comment on column AIGA.AIGA_SOLID_TASK.task_status
  is '任务状态+';
comment on column AIGA.AIGA_SOLID_TASK.req_time
  is '需求定定稿时间';
comment on column AIGA.AIGA_SOLID_TASK.code_commit_date
  is '代码截止提交日';
comment on column AIGA.AIGA_SOLID_TASK.on_line_type
  is '上线类型（计划内、计划外）';
comment on column AIGA.AIGA_SOLID_TASK.big_type
  is '系统大类';
comment on column AIGA.AIGA_SOLID_TASK.change_reason
  is '变更原因';
comment on column AIGA.AIGA_SOLID_TASK.plan_id
  is '测试计划主键';
comment on column AIGA.AIGA_SOLID_TASK.plan_name
  is '测试计划名称';
comment on column AIGA.AIGA_SOLID_TASK.submit_staff_id
  is '测试计划提交人编号';
comment on column AIGA.AIGA_SOLID_TASK.submit_staff_name
  is '测试计划提交人名称';
comment on column AIGA.AIGA_SOLID_TASK.plan_dscr
  is '测试计划描述';
comment on column AIGA.AIGA_SOLID_TASK.task_phase
  is '测试任务阶段+';
alter table AIGA.AIGA_SOLID_TASK
  add constraint AIGA_SOLID_TASK primary key (TASK_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_SPECIALDAY_CONFIG
prompt =====================================
prompt
create table AIGA.AIGA_SPECIALDAY_CONFIG
(
  id          NUMBER(12) not null,
  special_day DATE,
  mark        VARCHAR2(1)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_SPECIALDAY_CONFIG.id
  is '主键';
comment on column AIGA.AIGA_SPECIALDAY_CONFIG.special_day
  is '特殊日期';
comment on column AIGA.AIGA_SPECIALDAY_CONFIG.mark
  is '标识，1代表工作日放假；0代表周六日上班';
alter table AIGA.AIGA_SPECIALDAY_CONFIG
  add primary key (ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_ST_CODESCAN
prompt ===============================
prompt
create table AIGA.AIGA_ST_CODESCAN
(
  cs_id                 NUMBER(20) not null,
  st_id                 NUMBER(20),
  validaty_first_scan   VARCHAR2(4000),
  validaty_regr_scan    VARCHAR2(4000),
  validaty_repair_scale VARCHAR2(4000),
  security_first_scan   VARCHAR2(4000),
  security_regr_scan    VARCHAR2(4000),
  security_repair_scale VARCHAR2(4000),
  mainten_first_scan    VARCHAR2(4000),
  mainten_regr_scan     VARCHAR2(4000),
  mainten_repair_scale  VARCHAR2(4000),
  test_env              VARCHAR2(4000),
  test_result           VARCHAR2(10),
  test_remark           VARCHAR2(4000)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_ST_CODESCAN.cs_id
  is '代码扫描主键id';
comment on column AIGA.AIGA_ST_CODESCAN.st_id
  is '固化任务主键id';
comment on column AIGA.AIGA_ST_CODESCAN.validaty_first_scan
  is '正确性初次扫描结果';
comment on column AIGA.AIGA_ST_CODESCAN.validaty_regr_scan
  is '正确性回归扫描结果';
comment on column AIGA.AIGA_ST_CODESCAN.validaty_repair_scale
  is '正确性修复比例';
comment on column AIGA.AIGA_ST_CODESCAN.security_first_scan
  is '安全性初次扫描结果';
comment on column AIGA.AIGA_ST_CODESCAN.security_regr_scan
  is '安全性回归扫描结果';
comment on column AIGA.AIGA_ST_CODESCAN.security_repair_scale
  is '安全性修复比例';
comment on column AIGA.AIGA_ST_CODESCAN.mainten_first_scan
  is '维护性初次扫描结果';
comment on column AIGA.AIGA_ST_CODESCAN.mainten_regr_scan
  is '维护性回归扫描结果';
comment on column AIGA.AIGA_ST_CODESCAN.mainten_repair_scale
  is '维护性修复比例';
comment on column AIGA.AIGA_ST_CODESCAN.test_env
  is '测试环境';
comment on column AIGA.AIGA_ST_CODESCAN.test_result
  is '测试结果';
comment on column AIGA.AIGA_ST_CODESCAN.test_remark
  is '测试备注';
alter table AIGA.AIGA_ST_CODESCAN
  add primary key (CS_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_ST_HWREGRTEST
prompt =================================
prompt
create table AIGA.AIGA_ST_HWREGRTEST
(
  ht_id            NUMBER(20) not null,
  st_id            NUMBER(20),
  test_env         VARCHAR2(4000),
  testcase_num     NUMBER(12),
  test_pass_num    NUMBER(12),
  test_notpass_num NUMBER(12),
  test_result      VARCHAR2(10),
  test_remark      VARCHAR2(4000)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_ST_HWREGRTEST.ht_id
  is '手工回归测试主键id';
comment on column AIGA.AIGA_ST_HWREGRTEST.st_id
  is '固化任务主键id';
comment on column AIGA.AIGA_ST_HWREGRTEST.test_env
  is '手工回归测试环境';
comment on column AIGA.AIGA_ST_HWREGRTEST.testcase_num
  is '测试数量';
comment on column AIGA.AIGA_ST_HWREGRTEST.test_pass_num
  is '测试通过数';
comment on column AIGA.AIGA_ST_HWREGRTEST.test_notpass_num
  is '测试未通过数';
comment on column AIGA.AIGA_ST_HWREGRTEST.test_result
  is '测试结果';
comment on column AIGA.AIGA_ST_HWREGRTEST.test_remark
  is '测试备注';
alter table AIGA.AIGA_ST_HWREGRTEST
  add primary key (HT_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_ST_PERFTEST
prompt ===============================
prompt
create table AIGA.AIGA_ST_PERFTEST
(
  pf_id            NUMBER(20) not null,
  st_id            NUMBER(20),
  test_env         VARCHAR2(4000),
  test_scene_num   NUMBER(12),
  test_pass_num    NUMBER(12),
  test_notpass_num NUMBER(12),
  test_result      VARCHAR2(10),
  test_remark      VARCHAR2(4000)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_ST_PERFTEST.pf_id
  is '性能测试主键id';
comment on column AIGA.AIGA_ST_PERFTEST.st_id
  is '固化任务主键id';
comment on column AIGA.AIGA_ST_PERFTEST.test_env
  is '测试环境';
comment on column AIGA.AIGA_ST_PERFTEST.test_scene_num
  is '测试场景数量';
comment on column AIGA.AIGA_ST_PERFTEST.test_pass_num
  is '测试通过数';
comment on column AIGA.AIGA_ST_PERFTEST.test_notpass_num
  is '测试未通过数';
comment on column AIGA.AIGA_ST_PERFTEST.test_result
  is '测试结果';
comment on column AIGA.AIGA_ST_PERFTEST.test_remark
  is '测试备注';
alter table AIGA.AIGA_ST_PERFTEST
  add primary key (PF_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_ST_REGRTEST
prompt ===============================
prompt
create table AIGA.AIGA_ST_REGRTEST
(
  rt_id            NUMBER(20) not null,
  st_id            NUMBER(20),
  test_env         VARCHAR2(4000),
  testcase_num     NUMBER(12),
  test_pass_num    NUMBER(12),
  test_notpass_num NUMBER(12),
  test_result      VARCHAR2(10),
  test_remark      VARCHAR2(4000)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_ST_REGRTEST.rt_id
  is '自动回归测试主键id';
comment on column AIGA.AIGA_ST_REGRTEST.st_id
  is '固化任务主键id';
comment on column AIGA.AIGA_ST_REGRTEST.test_env
  is '自动回归测试环境';
comment on column AIGA.AIGA_ST_REGRTEST.testcase_num
  is '测试数量';
comment on column AIGA.AIGA_ST_REGRTEST.test_pass_num
  is '测试通过数';
comment on column AIGA.AIGA_ST_REGRTEST.test_notpass_num
  is '测试未通过数';
comment on column AIGA.AIGA_ST_REGRTEST.test_result
  is '测试结果';
comment on column AIGA.AIGA_ST_REGRTEST.test_remark
  is '测试备注';
alter table AIGA.AIGA_ST_REGRTEST
  add primary key (RT_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_ST_SECUTEST
prompt ===============================
prompt
create table AIGA.AIGA_ST_SECUTEST
(
  se_id               NUMBER(20) not null,
  st_id               NUMBER(20),
  sys_id              NUMBER(5),
  test_env            VARCHAR2(4000),
  unger_not_repair    NUMBER(12),
  unger_repaired      NUMBER(12),
  highrisk_not_repair NUMBER(12),
  highrisk_repaired   NUMBER(12),
  midrisk_not_repair  NUMBER(12),
  midhrisk_repaired   NUMBER(12),
  lowrisk_not_repair  NUMBER(12),
  lowrisk_repaired    NUMBER(12),
  test_result         VARCHAR2(10),
  test_remark         VARCHAR2(4000)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_ST_SECUTEST.se_id
  is '安全测试主键id';
comment on column AIGA.AIGA_ST_SECUTEST.st_id
  is '固化任务主键id';
comment on column AIGA.AIGA_ST_SECUTEST.sys_id
  is '系统';
comment on column AIGA.AIGA_ST_SECUTEST.test_env
  is '测试环境';
comment on column AIGA.AIGA_ST_SECUTEST.unger_not_repair
  is '紧急未修复数';
comment on column AIGA.AIGA_ST_SECUTEST.unger_repaired
  is '紧急已修复数';
comment on column AIGA.AIGA_ST_SECUTEST.highrisk_not_repair
  is '高危未修复数';
comment on column AIGA.AIGA_ST_SECUTEST.highrisk_repaired
  is '高危已修复数';
comment on column AIGA.AIGA_ST_SECUTEST.midrisk_not_repair
  is '中危未修复数';
comment on column AIGA.AIGA_ST_SECUTEST.midhrisk_repaired
  is '中危已修复数';
comment on column AIGA.AIGA_ST_SECUTEST.lowrisk_not_repair
  is '低危未修复数';
comment on column AIGA.AIGA_ST_SECUTEST.lowrisk_repaired
  is '低危已修复数';
comment on column AIGA.AIGA_ST_SECUTEST.test_result
  is '测试结果';
comment on column AIGA.AIGA_ST_SECUTEST.test_remark
  is '测试备注';
alter table AIGA.AIGA_ST_SECUTEST
  add primary key (SE_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_SUBTASK_PROBLEM
prompt ===================================
prompt
create table AIGA.AIGA_SUBTASK_PROBLEM
(
  id                NUMBER(12) not null,
  stp_tag           VARCHAR2(255),
  stp_name          VARCHAR2(255),
  stp_phase         NUMBER(4),
  stp_status        NUMBER(4),
  stp_into          NUMBER(4),
  stp_main_class    NUMBER(4),
  stp_sub_class     NUMBER(4),
  defect_dscr       VARCHAR2(4000),
  stp_dscr          VARCHAR2(4000),
  sub_task_id       NUMBER(20),
  sub_task_tag      VARCHAR2(255),
  sub_task_name     VARCHAR2(255),
  create_time       DATE,
  create_staff_id   NUMBER(12),
  create_staff_name VARCHAR2(255),
  start_mark        NUMBER(1),
  sub_task_type     NUMBER(2)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_SUBTASK_PROBLEM.id
  is '主键';
comment on column AIGA.AIGA_SUBTASK_PROBLEM.stp_tag
  is '子任务问题编码';
comment on column AIGA.AIGA_SUBTASK_PROBLEM.stp_name
  is '子任务问题名称';
comment on column AIGA.AIGA_SUBTASK_PROBLEM.stp_phase
  is '子任务问题所处阶段';
comment on column AIGA.AIGA_SUBTASK_PROBLEM.stp_status
  is '子任务问题状态';
comment on column AIGA.AIGA_SUBTASK_PROBLEM.stp_into
  is '子任务问题引入阶段';
comment on column AIGA.AIGA_SUBTASK_PROBLEM.stp_main_class
  is '子任务问题主类型';
comment on column AIGA.AIGA_SUBTASK_PROBLEM.stp_sub_class
  is '子任务问题子类型';
comment on column AIGA.AIGA_SUBTASK_PROBLEM.defect_dscr
  is '缺陷描述';
comment on column AIGA.AIGA_SUBTASK_PROBLEM.stp_dscr
  is '问题备注';
comment on column AIGA.AIGA_SUBTASK_PROBLEM.sub_task_id
  is '子任务ID';
comment on column AIGA.AIGA_SUBTASK_PROBLEM.sub_task_tag
  is '子任务编码';
comment on column AIGA.AIGA_SUBTASK_PROBLEM.sub_task_name
  is '子任务名称';
comment on column AIGA.AIGA_SUBTASK_PROBLEM.create_time
  is '创建时间';
comment on column AIGA.AIGA_SUBTASK_PROBLEM.create_staff_id
  is '创建人id';
comment on column AIGA.AIGA_SUBTASK_PROBLEM.create_staff_name
  is '创建人名称';
comment on column AIGA.AIGA_SUBTASK_PROBLEM.start_mark
  is '流程启动标识，0为未启动，1为启动';
comment on column AIGA.AIGA_SUBTASK_PROBLEM.sub_task_type
  is '子任务类型';
alter table AIGA.AIGA_SUBTASK_PROBLEM
  add primary key (ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_SUB_SYS_FOLDER
prompt ==================================
prompt
create table AIGA.AIGA_SUB_SYS_FOLDER
(
  subsys_id   NUMBER(20) not null,
  sys_name    VARCHAR2(2000),
  create_time DATE,
  update_time DATE,
  sys_id      NUMBER(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_SUB_SYS_FOLDER
  add primary key (SUBSYS_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_SYSTEM_FOLDER
prompt =================================
prompt
create table AIGA.AIGA_SYSTEM_FOLDER
(
  sys_id          NUMBER(20) not null,
  sys_name        VARCHAR2(2000),
  create_time     DATE,
  update_time     DATE,
  remarks         VARCHAR2(4000),
  firm            VARCHAR2(255),
  important_class NUMBER(4),
  sys_of_domain   NUMBER(4),
  is_invalid      NUMBER(4)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_SYSTEM_FOLDER.sys_name
  is '系统名称';
comment on column AIGA.AIGA_SYSTEM_FOLDER.create_time
  is '创建日期';
comment on column AIGA.AIGA_SYSTEM_FOLDER.update_time
  is '更新日期';
comment on column AIGA.AIGA_SYSTEM_FOLDER.remarks
  is '备注';
comment on column AIGA.AIGA_SYSTEM_FOLDER.firm
  is '承建厂家';
comment on column AIGA.AIGA_SYSTEM_FOLDER.important_class
  is '重要级别';
comment on column AIGA.AIGA_SYSTEM_FOLDER.sys_of_domain
  is '系统归属于';
comment on column AIGA.AIGA_SYSTEM_FOLDER.is_invalid
  is '是否已被禁用';
alter table AIGA.AIGA_SYSTEM_FOLDER
  add primary key (SYS_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_TESTLAN_CHANGE
prompt ==================================
prompt
create table AIGA.AIGA_TESTLAN_CHANGE
(
  ac_id              NUMBER(12) not null,
  create_time        DATE,
  change_staff_id    NUMBER(12),
  change_staff_name  VARCHAR2(255),
  change_plan_id     NUMBER(12),
  change_plan_tag    VARCHAR2(20),
  change_reason      VARCHAR2(4000),
  codecommitdate_o   DATE,
  codecommitdate_n   DATE,
  factcompletetime_o DATE,
  factcompletetime_n DATE,
  reqtime_o          DATE,
  reqtime_n          DATE,
  version_content_o  NUMBER(20),
  version_content_n  NUMBER(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_TESTLAN_CHANGE
  add primary key (AC_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_TESTTASK_CHANGE
prompt ===================================
prompt
create table AIGA.AIGA_TESTTASK_CHANGE
(
  atc_id            NUMBER(20) not null,
  create_time       DATE,
  change_staff_id   NUMBER(12),
  chagne_staff_name VARCHAR2(255),
  change_task_id    NUMBER(20),
  change_task_tag   VARCHAR2(200),
  change_reson      VARCHAR2(4000),
  planid_o          NUMBER(12),
  planid_n          NUMBER(12),
  online_time_o     DATE,
  online_time_n     DATE
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_TESTTASK_CHANGE.atc_id
  is '测试任务变更主键id';
comment on column AIGA.AIGA_TESTTASK_CHANGE.create_time
  is '变更时间';
comment on column AIGA.AIGA_TESTTASK_CHANGE.change_staff_id
  is '变更发起人id';
comment on column AIGA.AIGA_TESTTASK_CHANGE.chagne_staff_name
  is '变更发起人名称';
comment on column AIGA.AIGA_TESTTASK_CHANGE.change_task_id
  is '变更任务id';
comment on column AIGA.AIGA_TESTTASK_CHANGE.change_task_tag
  is '变更任务编号';
comment on column AIGA.AIGA_TESTTASK_CHANGE.change_reson
  is '变更原因';
comment on column AIGA.AIGA_TESTTASK_CHANGE.planid_o
  is '原测试排期id';
comment on column AIGA.AIGA_TESTTASK_CHANGE.planid_n
  is '新测试排期id';
comment on column AIGA.AIGA_TESTTASK_CHANGE.online_time_o
  is '原测试上线时间';
comment on column AIGA.AIGA_TESTTASK_CHANGE.online_time_n
  is '新测试上线时间';
alter table AIGA.AIGA_TESTTASK_CHANGE
  add primary key (ATC_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_TEST_DAILY
prompt ==============================
prompt
create table AIGA.AIGA_TEST_DAILY
(
  daily_id                   NUMBER not null,
  sub_task_tag               VARCHAR2(255),
  sub_task_name              VARCHAR2(255),
  sum_case_number            NUMBER,
  pass_case_number           NUMBER,
  staff_id                   VARCHAR2(255),
  staff_code                 NUMBER,
  staff_name                 VARCHAR2(255),
  commit_time                TIMESTAMP(6),
  test_orderlist_status      NUMBER,
  deffect_sum_number         NUMBER,
  deffect_finishend_number   NUMBER,
  deffect_unfinishend_number NUMBER,
  test_exception_effect      VARCHAR2(2000),
  main_process_is_pass       NUMBER,
  sub_task_id                NUMBER
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_TEST_DAILY.daily_id
  is '测试日报id';
comment on column AIGA.AIGA_TEST_DAILY.sub_task_tag
  is '测试子任务编号';
comment on column AIGA.AIGA_TEST_DAILY.sub_task_name
  is '测试子任务名称';
comment on column AIGA.AIGA_TEST_DAILY.sum_case_number
  is '总用例数';
comment on column AIGA.AIGA_TEST_DAILY.pass_case_number
  is '通过用例数（自动生成也允许修改）';
comment on column AIGA.AIGA_TEST_DAILY.staff_id
  is '员工ID';
comment on column AIGA.AIGA_TEST_DAILY.staff_code
  is '员工帐号';
comment on column AIGA.AIGA_TEST_DAILY.staff_name
  is '员工名称';
comment on column AIGA.AIGA_TEST_DAILY.commit_time
  is '提交时间';
comment on column AIGA.AIGA_TEST_DAILY.test_orderlist_status
  is '测试工单状态(1:已完成,2:过程中,3:未开始)';
comment on column AIGA.AIGA_TEST_DAILY.deffect_sum_number
  is '缺陷总数量';
comment on column AIGA.AIGA_TEST_DAILY.deffect_finishend_number
  is '缺陷已完成数量';
comment on column AIGA.AIGA_TEST_DAILY.deffect_unfinishend_number
  is '缺陷未完成数量';
comment on column AIGA.AIGA_TEST_DAILY.test_exception_effect
  is '测试异常事件（影响测试进度的事件或致命缺陷）';
comment on column AIGA.AIGA_TEST_DAILY.main_process_is_pass
  is '测试是否通过';
comment on column AIGA.AIGA_TEST_DAILY.sub_task_id
  is '测试子任务ID';
alter table AIGA.AIGA_TEST_DAILY
  add constraint TESTDAILY$PRIMARY primary key (DAILY_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_TEST_ELEM
prompt =============================
prompt
create table AIGA.AIGA_TEST_ELEM
(
  elem_id               NUMBER(20) not null,
  elem_tag              VARCHAR2(2000),
  elem_name             VARCHAR2(4000),
  elem_sys_achieve_type NUMBER,
  applicate_sys         NUMBER,
  is_global_elem        NUMBER,
  sys_id                NUMBER(20),
  fun_id                NUMBER(20),
  staff_id              NUMBER(20),
  staff_name            VARCHAR2(50),
  is_delete             NUMBER,
  add_reason_type       NUMBER(20),
  add_reason            VARCHAR2(4000),
  fun_name              VARCHAR2(250),
  sys_name              VARCHAR2(250)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_TEST_ELEM.elem_id
  is '测试要素ID';
comment on column AIGA.AIGA_TEST_ELEM.elem_tag
  is '测试要素编号';
comment on column AIGA.AIGA_TEST_ELEM.elem_name
  is '测试要素名称';
comment on column AIGA.AIGA_TEST_ELEM.elem_sys_achieve_type
  is '测试要素类型';
comment on column AIGA.AIGA_TEST_ELEM.applicate_sys
  is '测试要素所属系统(和SYS_ID重复现在暂时没用)';
comment on column AIGA.AIGA_TEST_ELEM.is_global_elem
  is '是否为公共测试要素';
comment on column AIGA.AIGA_TEST_ELEM.sys_id
  is '测试要素所属系统';
comment on column AIGA.AIGA_TEST_ELEM.fun_id
  is '功能点ID';
comment on column AIGA.AIGA_TEST_ELEM.staff_id
  is '评审人ID';
comment on column AIGA.AIGA_TEST_ELEM.staff_name
  is '评审人名字';
comment on column AIGA.AIGA_TEST_ELEM.is_delete
  is '是否为废弃的公共测试要素(1:已经废弃,0:没有废弃)';
comment on column AIGA.AIGA_TEST_ELEM.add_reason_type
  is '新增原因类型';
comment on column AIGA.AIGA_TEST_ELEM.add_reason
  is '新增原因';
comment on column AIGA.AIGA_TEST_ELEM.fun_name
  is '所属功能点名称';
comment on column AIGA.AIGA_TEST_ELEM.sys_name
  is '所属系统名称';
alter table AIGA.AIGA_TEST_ELEM
  add primary key (ELEM_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_TEST_PLAN
prompt =============================
prompt
create table AIGA.AIGA_TEST_PLAN
(
  plan_id              NUMBER(20) not null,
  plan_tag             VARCHAR2(255),
  pl_complete_time     DATE,
  fact_complete_time   DATE,
  create_time          DATE,
  begin_time           DATE,
  is_security_test     NUMBER(4),
  is_code_scan         NUMBER(4),
  is_performance_test  NUMBER(4),
  is_regression_test   NUMBER(4),
  version_content      NUMBER(20),
  plan_status          NUMBER(20) default 99999,
  req_time             DATE,
  code_commit_date     DATE,
  on_line_type         NUMBER(20),
  big_type             NUMBER(20),
  change_reason        VARCHAR2(512),
  plan_name            VARCHAR2(255),
  submit_staff_id      NUMBER(20),
  submit_staff_name    VARCHAR2(255),
  plan_dscr            VARCHAR2(4000),
  plan_phase           NUMBER(4),
  is_hwregression_test NUMBER(4),
  start_mark           NUMBER(4)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_TEST_PLAN.plan_id
  is '主键ID';
comment on column AIGA.AIGA_TEST_PLAN.plan_tag
  is '计划编号';
comment on column AIGA.AIGA_TEST_PLAN.pl_complete_time
  is '计划期望上线时间（已废弃）';
comment on column AIGA.AIGA_TEST_PLAN.fact_complete_time
  is '计划实际上线时间+(现在是上线时间)';
comment on column AIGA.AIGA_TEST_PLAN.create_time
  is '计划创建时间';
comment on column AIGA.AIGA_TEST_PLAN.begin_time
  is '计划开始时间';
comment on column AIGA.AIGA_TEST_PLAN.is_security_test
  is '是否安全测试';
comment on column AIGA.AIGA_TEST_PLAN.is_code_scan
  is '是否代码扫描';
comment on column AIGA.AIGA_TEST_PLAN.is_performance_test
  is '是否性能测试';
comment on column AIGA.AIGA_TEST_PLAN.is_regression_test
  is '是否回归测试';
comment on column AIGA.AIGA_TEST_PLAN.version_content
  is '版本容量';
comment on column AIGA.AIGA_TEST_PLAN.plan_status
  is '计划状态  与流程对应(99999为初始状态)';
comment on column AIGA.AIGA_TEST_PLAN.req_time
  is '需求定稿时间';
comment on column AIGA.AIGA_TEST_PLAN.code_commit_date
  is '代码截止提交日';
comment on column AIGA.AIGA_TEST_PLAN.on_line_type
  is '上线类型  常量表';
comment on column AIGA.AIGA_TEST_PLAN.big_type
  is '系统大类';
comment on column AIGA.AIGA_TEST_PLAN.change_reason
  is '变更原因';
comment on column AIGA.AIGA_TEST_PLAN.plan_name
  is '计划名称';
comment on column AIGA.AIGA_TEST_PLAN.submit_staff_id
  is '计划提交人id';
comment on column AIGA.AIGA_TEST_PLAN.submit_staff_name
  is '计划提交人名称';
comment on column AIGA.AIGA_TEST_PLAN.plan_dscr
  is '计划描述';
comment on column AIGA.AIGA_TEST_PLAN.plan_phase
  is '计划阶段';
comment on column AIGA.AIGA_TEST_PLAN.is_hwregression_test
  is '固化任务手工回归测试';
comment on column AIGA.AIGA_TEST_PLAN.start_mark
  is '启动标识';
create index AIGA.INX_TEST_PLAN_STATUS on AIGA.AIGA_TEST_PLAN (PLAN_STATUS, 20000)
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_TEST_PLAN
  add constraint PK_AIGA_TEST_PLAN primary key (PLAN_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_TEST_RESOURCE
prompt =================================
prompt
create table AIGA.AIGA_TEST_RESOURCE
(
  resource_id   NUMBER(20) not null,
  sub_task_id   NUMBER(20),
  resource_desc VARCHAR2(1024),
  resource_type NUMBER(4)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_TEST_RESOURCE.resource_id
  is '主键ID';
comment on column AIGA.AIGA_TEST_RESOURCE.sub_task_id
  is '子任务ID';
comment on column AIGA.AIGA_TEST_RESOURCE.resource_desc
  is '资源描述';
comment on column AIGA.AIGA_TEST_RESOURCE.resource_type
  is '资源类型';
alter table AIGA.AIGA_TEST_RESOURCE
  add constraint AIGA_TEST_RESOURCE$PRIMARY primary key (RESOURCE_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_TEST_SUB_ELEM
prompt =================================
prompt
create table AIGA.AIGA_TEST_SUB_ELEM
(
  sub_elem_id       NUMBER(20) not null,
  elem_id           NUMBER(20),
  elem_value        VARCHAR2(4000),
  elem_test_logic   VARCHAR2(4000),
  take_value_method VARCHAR2(4000),
  value_remark      VARCHAR2(4000),
  is_delete         NUMBER
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_TEST_SUB_ELEM.sub_elem_id
  is '子要素ID';
comment on column AIGA.AIGA_TEST_SUB_ELEM.elem_id
  is '要素ID';
comment on column AIGA.AIGA_TEST_SUB_ELEM.elem_value
  is '要素值';
comment on column AIGA.AIGA_TEST_SUB_ELEM.elem_test_logic
  is '逻辑值';
comment on column AIGA.AIGA_TEST_SUB_ELEM.take_value_method
  is '取值方式';
comment on column AIGA.AIGA_TEST_SUB_ELEM.value_remark
  is '备注';
comment on column AIGA.AIGA_TEST_SUB_ELEM.is_delete
  is '是否删除';
alter table AIGA.AIGA_TEST_SUB_ELEM
  add primary key (SUB_ELEM_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_TEST_SUB_REASON
prompt ===================================
prompt
create table AIGA.AIGA_TEST_SUB_REASON
(
  reason_id       NUMBER(20) not null,
  reason_type     NUMBER(11),
  reason_desc     VARCHAR2(2048),
  sub_task_id     NUMBER(20),
  reason_env_type NUMBER(11)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_TEST_SUB_REASON.reason_id
  is '主键';
comment on column AIGA.AIGA_TEST_SUB_REASON.reason_type
  is '不可测类型';
comment on column AIGA.AIGA_TEST_SUB_REASON.reason_desc
  is '不可测描述';
comment on column AIGA.AIGA_TEST_SUB_REASON.sub_task_id
  is '关联子任务ID';
comment on column AIGA.AIGA_TEST_SUB_REASON.reason_env_type
  is '对应环境';
alter table AIGA.AIGA_TEST_SUB_REASON
  add constraint PK_SUB_REASON primary key (REASON_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_TEST_SUB_TASK
prompt =================================
prompt
create table AIGA.AIGA_TEST_SUB_TASK
(
  sub_task_id             NUMBER(20) not null,
  sub_task_tag            VARCHAR2(255),
  task_tag                VARCHAR2(255),
  sub_task_name           VARCHAR2(255),
  req_tag                 VARCHAR2(255),
  creator                 VARCHAR2(255),
  sub_task_status         NUMBER(4),
  create_time             DATE,
  pl_complete_time        DATE,
  fact_complete_time      DATE,
  sub_task_priority       NUMBER(4),
  dev_work_day            VARCHAR2(255),
  test_work_day           VARCHAR2(255),
  possible_product        NUMBER(4),
  possible_back           NUMBER(4),
  possible_test           NUMBER(4),
  is_performance          NUMBER(4),
  task_id                 NUMBER(20),
  sub_task_type           NUMBER(2),
  creator_staff           VARCHAR2(255),
  cur_phase               NUMBER(4),
  testor_id               NUMBER(20),
  testor_name             VARCHAR2(255),
  possible_product_reason VARCHAR2(2048),
  possible_back_reason    VARCHAR2(2048),
  possible_test_reason    VARCHAR2(2048),
  is_joint_debug          NUMBER(4),
  joint_environment       NUMBER(4),
  submit_staff_id         NUMBER(12),
  submit_staff_name       VARCHAR2(255),
  big_type                NUMBER(20),
  sub_type                NUMBER(20),
  test_reply              VARCHAR2(2048),
  req_analysis            VARCHAR2(2048),
  now_test_info           VARCHAR2(2048),
  usable                  NUMBER(4),
  sub_task_class          NUMBER(4),
  join_debug_vals         VARCHAR2(512),
  join_type               NUMBER(4),
  review_result           NUMBER(4) default 0,
  oper_id                 NUMBER(12),
  oper_name               VARCHAR2(32),
  review_time             DATE,
  join_debug_vals_other   VARCHAR2(512),
  audit_rate              VARCHAR2(512),
  script_fun_rate         VARCHAR2(512),
  script_per_rate         VARCHAR2(512)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_TEST_SUB_TASK.sub_task_id
  is '主键ID';
comment on column AIGA.AIGA_TEST_SUB_TASK.sub_task_tag
  is '测试子任务编号';
comment on column AIGA.AIGA_TEST_SUB_TASK.task_tag
  is '关联测试任务编号';
comment on column AIGA.AIGA_TEST_SUB_TASK.sub_task_name
  is '测试子任务名称';
comment on column AIGA.AIGA_TEST_SUB_TASK.req_tag
  is '关联需求编号';
comment on column AIGA.AIGA_TEST_SUB_TASK.creator
  is '子任务派发人ID';
comment on column AIGA.AIGA_TEST_SUB_TASK.sub_task_status
  is '子任务状态';
comment on column AIGA.AIGA_TEST_SUB_TASK.create_time
  is '子任务创建时间';
comment on column AIGA.AIGA_TEST_SUB_TASK.pl_complete_time
  is '计划上线时间';
comment on column AIGA.AIGA_TEST_SUB_TASK.fact_complete_time
  is '实际完成时间';
comment on column AIGA.AIGA_TEST_SUB_TASK.sub_task_priority
  is '子任务优先级';
comment on column AIGA.AIGA_TEST_SUB_TASK.dev_work_day
  is '开发任务工时';
comment on column AIGA.AIGA_TEST_SUB_TASK.test_work_day
  is '测试任务工时';
comment on column AIGA.AIGA_TEST_SUB_TASK.possible_product
  is '生产环境可测性';
comment on column AIGA.AIGA_TEST_SUB_TASK.possible_back
  is '准发布环境可测性';
comment on column AIGA.AIGA_TEST_SUB_TASK.possible_test
  is '测试环境可测性';
comment on column AIGA.AIGA_TEST_SUB_TASK.is_performance
  is '是否性能测试';
comment on column AIGA.AIGA_TEST_SUB_TASK.task_id
  is '关联测试任务编号';
comment on column AIGA.AIGA_TEST_SUB_TASK.sub_task_type
  is '子任务类型（正常子任务、端到端任务）';
comment on column AIGA.AIGA_TEST_SUB_TASK.creator_staff
  is '子任务派发人名称';
comment on column AIGA.AIGA_TEST_SUB_TASK.cur_phase
  is '当前阶段';
comment on column AIGA.AIGA_TEST_SUB_TASK.testor_id
  is '测试人ID';
comment on column AIGA.AIGA_TEST_SUB_TASK.testor_name
  is '测试人名称';
comment on column AIGA.AIGA_TEST_SUB_TASK.possible_product_reason
  is '生产环境不可测原因';
comment on column AIGA.AIGA_TEST_SUB_TASK.possible_back_reason
  is '准发布不可测原因';
comment on column AIGA.AIGA_TEST_SUB_TASK.possible_test_reason
  is '测试环境不可测原因';
comment on column AIGA.AIGA_TEST_SUB_TASK.is_joint_debug
  is '是否联调';
comment on column AIGA.AIGA_TEST_SUB_TASK.joint_environment
  is '联调环境（外围平台/集团联调/系统内部）';
comment on column AIGA.AIGA_TEST_SUB_TASK.big_type
  is '系统大类';
comment on column AIGA.AIGA_TEST_SUB_TASK.sub_type
  is '系统子类';
comment on column AIGA.AIGA_TEST_SUB_TASK.test_reply
  is '测试依据';
comment on column AIGA.AIGA_TEST_SUB_TASK.req_analysis
  is '需求分析';
comment on column AIGA.AIGA_TEST_SUB_TASK.now_test_info
  is '现状测试';
comment on column AIGA.AIGA_TEST_SUB_TASK.usable
  is '是否可用';
comment on column AIGA.AIGA_TEST_SUB_TASK.sub_task_class
  is '子任务分类';
comment on column AIGA.AIGA_TEST_SUB_TASK.join_debug_vals
  is '联调系统值';
comment on column AIGA.AIGA_TEST_SUB_TASK.join_type
  is '联调类型';
comment on column AIGA.AIGA_TEST_SUB_TASK.review_result
  is '审批结果（0未审批;1通过;2不通过）';
comment on column AIGA.AIGA_TEST_SUB_TASK.oper_id
  is '评审人id';
comment on column AIGA.AIGA_TEST_SUB_TASK.oper_name
  is '评审人姓名';
comment on column AIGA.AIGA_TEST_SUB_TASK.review_time
  is '评审时间';
comment on column AIGA.AIGA_TEST_SUB_TASK.join_debug_vals_other
  is '联调系统值补充';
comment on column AIGA.AIGA_TEST_SUB_TASK.audit_rate
  is '数据稽核准确率';
comment on column AIGA.AIGA_TEST_SUB_TASK.script_fun_rate
  is '脚本功能测试通过率';
comment on column AIGA.AIGA_TEST_SUB_TASK.script_per_rate
  is '脚本性能测试通过率';
create index AIGA.INDEX_SUB_TASK_TASK_ID on AIGA.AIGA_TEST_SUB_TASK (TASK_ID)
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_TEST_SUB_TASK
  add constraint PK_AIGA_TEST_SUB_TASK primary key (SUB_TASK_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_TEST_TASK
prompt =============================
prompt
create table AIGA.AIGA_TEST_TASK
(
  task_id              NUMBER(20) not null,
  req_id               NUMBER(20),
  current_status       NUMBER(4),
  priority             NUMBER(4),
  task_tag             VARCHAR2(200),
  req_tag              VARCHAR2(200),
  pl_complete_time     DATE,
  fact_complete_time   DATE,
  dev_work_day         VARCHAR2(200),
  test_work_day        VARCHAR2(200),
  create_time          DATE,
  task_name            VARCHAR2(200),
  distribute_staffid   VARCHAR2(200),
  big_type             NUMBER(4),
  is_performance_test  NUMBER(4),
  is_joint_test        NUMBER(4),
  is_cross_cycle       NUMBER(4),
  is_point2point_test  NUMBER(4),
  run_persion          NUMBER(4),
  distribute_time      VARCHAR2(200),
  plan_id              NUMBER(20),
  sub_type             NUMBER(4),
  dev_tag              VARCHAR2(200),
  test_type            NUMBER(20),
  test_firm            NUMBER(4),
  dev_firm             NUMBER(4),
  is_importance_req    NUMBER(4),
  test_persion_opinion VARCHAR2(2000),
  req_persion          VARCHAR2(200),
  distribute_staffname VARCHAR2(200),
  test_progress        VARCHAR2(200),
  test_situation       VARCHAR2(200),
  defect_number        NUMBER(4),
  initial_situation    VARCHAR2(4000),
  test_group           VARCHAR2(200),
  dev_persion          VARCHAR2(200),
  dev_admin            VARCHAR2(200),
  on_line_time         DATE,
  task_phase           NUMBER(4),
  plan_tag             VARCHAR2(200) default '',
  submit_staff_id      NUMBER(20),
  submit_staff_name    VARCHAR2(255),
  uet_task_id          NUMBER(20),
  perf_task_id         NUMBER(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_TEST_TASK.task_id
  is '主键ID';
comment on column AIGA.AIGA_TEST_TASK.req_id
  is '关联需求ID';
comment on column AIGA.AIGA_TEST_TASK.current_status
  is '测试任务状态';
comment on column AIGA.AIGA_TEST_TASK.priority
  is '任务优先级';
comment on column AIGA.AIGA_TEST_TASK.task_tag
  is '测试任务编号';
comment on column AIGA.AIGA_TEST_TASK.req_tag
  is '需求编号';
comment on column AIGA.AIGA_TEST_TASK.pl_complete_time
  is '计划完成时间(已废弃)';
comment on column AIGA.AIGA_TEST_TASK.fact_complete_time
  is '实际完成时间（计划完成时间）';
comment on column AIGA.AIGA_TEST_TASK.dev_work_day
  is '开发任务工时';
comment on column AIGA.AIGA_TEST_TASK.test_work_day
  is '测试任务工时';
comment on column AIGA.AIGA_TEST_TASK.create_time
  is '创建时间';
comment on column AIGA.AIGA_TEST_TASK.task_name
  is '任务名称';
comment on column AIGA.AIGA_TEST_TASK.distribute_staffid
  is '测试管理员ID';
comment on column AIGA.AIGA_TEST_TASK.big_type
  is '系统大类';
comment on column AIGA.AIGA_TEST_TASK.is_performance_test
  is '是否需要性能测试';
comment on column AIGA.AIGA_TEST_TASK.is_joint_test
  is '是否需要联调';
comment on column AIGA.AIGA_TEST_TASK.is_cross_cycle
  is '是否跨周期需求';
comment on column AIGA.AIGA_TEST_TASK.is_point2point_test
  is '是否需要端到端测试';
comment on column AIGA.AIGA_TEST_TASK.run_persion
  is '任务执行人';
comment on column AIGA.AIGA_TEST_TASK.distribute_time
  is '任务派发时间';
comment on column AIGA.AIGA_TEST_TASK.plan_id
  is '测试计划id';
comment on column AIGA.AIGA_TEST_TASK.sub_type
  is '系统子类';
comment on column AIGA.AIGA_TEST_TASK.dev_tag
  is '开发任务编号';
comment on column AIGA.AIGA_TEST_TASK.test_type
  is '测试类型';
comment on column AIGA.AIGA_TEST_TASK.test_firm
  is '测试厂商';
comment on column AIGA.AIGA_TEST_TASK.dev_firm
  is '开发厂商';
comment on column AIGA.AIGA_TEST_TASK.is_importance_req
  is '是否为重点需求';
comment on column AIGA.AIGA_TEST_TASK.test_persion_opinion
  is '测试管理员意见';
comment on column AIGA.AIGA_TEST_TASK.req_persion
  is '需求管理员';
comment on column AIGA.AIGA_TEST_TASK.distribute_staffname
  is '测试组长';
comment on column AIGA.AIGA_TEST_TASK.test_progress
  is '测试进度';
comment on column AIGA.AIGA_TEST_TASK.test_situation
  is '测试情况';
comment on column AIGA.AIGA_TEST_TASK.defect_number
  is '缺陷数量';
comment on column AIGA.AIGA_TEST_TASK.initial_situation
  is '初步情况分析';
comment on column AIGA.AIGA_TEST_TASK.test_group
  is '归属测试组';
comment on column AIGA.AIGA_TEST_TASK.dev_persion
  is '开发人员';
comment on column AIGA.AIGA_TEST_TASK.dev_admin
  is '开发管理员';
comment on column AIGA.AIGA_TEST_TASK.on_line_time
  is '上线时间';
comment on column AIGA.AIGA_TEST_TASK.task_phase
  is '任务阶段';
comment on column AIGA.AIGA_TEST_TASK.plan_tag
  is '计划单编号';
comment on column AIGA.AIGA_TEST_TASK.submit_staff_id
  is '任务提交人ID';
comment on column AIGA.AIGA_TEST_TASK.submit_staff_name
  is '任务提交人名称';
comment on column AIGA.AIGA_TEST_TASK.uet_task_id
  is '用户体验测试任务id';
comment on column AIGA.AIGA_TEST_TASK.perf_task_id
  is '性能测试任务id';
create index AIGA.INDEX_TESTPLAN_PID_PTAG on AIGA.AIGA_TEST_TASK (PLAN_ID, 0, PLAN_TAG, 1)
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.AIGA_TEST_TASK
  add constraint AIGA_TEST_TASK$PRIMARY primary key (TASK_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AIGA_TEST_VERSION
prompt ================================
prompt
create table AIGA.AIGA_TEST_VERSION
(
  version_id          NUMBER(20) not null,
  version_tag         VARCHAR2(255),
  pl_online_time      DATE,
  fact_online_time    DATE,
  version_create_time DATE,
  pl_work_day         VARCHAR2(255),
  fact_work_day       VARCHAR2(255)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.AIGA_TEST_VERSION.version_id
  is '主键ID';
comment on column AIGA.AIGA_TEST_VERSION.version_tag
  is '版本编号';
comment on column AIGA.AIGA_TEST_VERSION.pl_online_time
  is '版本计划上线时间';
comment on column AIGA.AIGA_TEST_VERSION.fact_online_time
  is '版本实际上线时间';
comment on column AIGA.AIGA_TEST_VERSION.version_create_time
  is '版本创建时间';
comment on column AIGA.AIGA_TEST_VERSION.pl_work_day
  is '版本计划容量';
comment on column AIGA.AIGA_TEST_VERSION.fact_work_day
  is '版本实际容量';
alter table AIGA.AIGA_TEST_VERSION
  add constraint PK_AIGA_TEST_VERSION primary key (VERSION_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ALM_ATTACHMENT
prompt =============================
prompt
create table AIGA.ALM_ATTACHMENT
(
  att_id        NUMBER(12) not null,
  att_name      VARCHAR2(1024),
  att_path      VARCHAR2(1024),
  att_type      VARCHAR2(32),
  att_desc      VARCHAR2(1024),
  submitter_tag VARCHAR2(32),
  submit_time   DATE,
  submit_link   VARCHAR2(32)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on table AIGA.ALM_ATTACHMENT
  is '??';
comment on column AIGA.ALM_ATTACHMENT.att_id
  is '??ID';
comment on column AIGA.ALM_ATTACHMENT.att_name
  is '????';
comment on column AIGA.ALM_ATTACHMENT.att_path
  is '????';
comment on column AIGA.ALM_ATTACHMENT.att_type
  is '????';
comment on column AIGA.ALM_ATTACHMENT.att_desc
  is '????';
comment on column AIGA.ALM_ATTACHMENT.submitter_tag
  is '???';
comment on column AIGA.ALM_ATTACHMENT.submit_time
  is '????';
comment on column AIGA.ALM_ATTACHMENT.submit_link
  is '????';
alter table AIGA.ALM_ATTACHMENT
  add constraint BIN$POHJPV2RRVGJXI0TFGYNQ$0 primary key (ATT_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 320K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ALM_ATTACH_TYPE_CONFIG
prompt =====================================
prompt
create table AIGA.ALM_ATTACH_TYPE_CONFIG
(
  att_conf_id NUMBER(20) not null,
  cond        VARCHAR2(4000),
  att_type_id NUMBER(10),
  is_check    VARCHAR2(1),
  zone        NUMBER(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.ALM_ATTACH_TYPE_CONFIG.att_conf_id
  is '??';
comment on column AIGA.ALM_ATTACH_TYPE_CONFIG.cond
  is '<conds><cond key=''reqType'' value=''20''/><cond key=''link_no'' value=''reqAdmin''/>....</conds>';
comment on column AIGA.ALM_ATTACH_TYPE_CONFIG.att_type_id
  is '????ID ?????????';
comment on column AIGA.ALM_ATTACH_TYPE_CONFIG.is_check
  is '????????';
comment on column AIGA.ALM_ATTACH_TYPE_CONFIG.zone
  is '????';
alter table AIGA.ALM_ATTACH_TYPE_CONFIG
  add constraint ATT_CONF_ID$INDEX primary key (ATT_CONF_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ALM_ATT_OBJ_RELA
prompt ===============================
prompt
create table AIGA.ALM_ATT_OBJ_RELA
(
  att_type VARCHAR2(60),
  obj_type VARCHAR2(60),
  link_no  VARCHAR2(60),
  rela_id  NUMBER(12) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.ALM_ATT_OBJ_RELA.att_type
  is '????';
comment on column AIGA.ALM_ATT_OBJ_RELA.obj_type
  is '????';
comment on column AIGA.ALM_ATT_OBJ_RELA.link_no
  is '????';
comment on column AIGA.ALM_ATT_OBJ_RELA.rela_id
  is '??ID';
alter table AIGA.ALM_ATT_OBJ_RELA
  add constraint PK_ALM_ATT_OBJ_RELA primary key (RELA_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ALM_ATT_PACKAGE
prompt ==============================
prompt
create table AIGA.ALM_ATT_PACKAGE
(
  obj_id        NUMBER(12),
  obj_type      NUMBER(12),
  wo_id         NUMBER(12),
  att_pack_id   NUMBER(12) not null,
  att_pack_desc VARCHAR2(128),
  att_id        NUMBER(12),
  obj_no        VARCHAR2(32)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on table AIGA.ALM_ATT_PACKAGE
  is '???';
comment on column AIGA.ALM_ATT_PACKAGE.obj_id
  is '??ID';
comment on column AIGA.ALM_ATT_PACKAGE.obj_type
  is '????';
comment on column AIGA.ALM_ATT_PACKAGE.wo_id
  is '??ID';
comment on column AIGA.ALM_ATT_PACKAGE.att_pack_id
  is '???ID';
comment on column AIGA.ALM_ATT_PACKAGE.att_pack_desc
  is '?????';
comment on column AIGA.ALM_ATT_PACKAGE.att_id
  is '??ID';
comment on column AIGA.ALM_ATT_PACKAGE.obj_no
  is '????';
alter table AIGA.ALM_ATT_PACKAGE
  add constraint PK_ALM_ATT_PACKAGE primary key (ATT_PACK_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 320K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ALM_ATT_TYPE_DEF
prompt ===============================
prompt
create table AIGA.ALM_ATT_TYPE_DEF
(
  att_type_id   NUMBER(20) not null,
  att_type_name VARCHAR2(50),
  att_type_desc VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.ALM_ATT_TYPE_DEF.att_type_id
  is 'ID';
comment on column AIGA.ALM_ATT_TYPE_DEF.att_type_name
  is '??????';
comment on column AIGA.ALM_ATT_TYPE_DEF.att_type_desc
  is '??????';
alter table AIGA.ALM_ATT_TYPE_DEF
  add constraint ATT_TYPE_ID$INDEX primary key (ATT_TYPE_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ALM_HIS_STAKEHOLDER
prompt ==================================
prompt
create table AIGA.ALM_HIS_STAKEHOLDER
(
  his_stdholder_id       NUMBER(12) not null,
  order_id               NUMBER(12),
  stdholder_id           NUMBER(12),
  template_id            NUMBER(12),
  link_id                NUMBER(12),
  link_no                VARCHAR2(32),
  obj_id                 NUMBER(12),
  obj_type               VARCHAR2(2),
  role_id                NUMBER(12),
  role_code              VARCHAR2(100),
  stdholder_staff_org_id NUMBER(12),
  stdholder_staff_id     NUMBER(12),
  stdholder_staff_no     VARCHAR2(32),
  stdholder_staff_name   VARCHAR2(32),
  stdholde_type          VARCHAR2(2),
  create_time            DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table AIGA.ALM_HIS_STAKEHOLDER
  is 'Stakeholder';
comment on column AIGA.ALM_HIS_STAKEHOLDER.his_stdholder_id
  is '?????ID';
comment on column AIGA.ALM_HIS_STAKEHOLDER.order_id
  is '??ID';
comment on column AIGA.ALM_HIS_STAKEHOLDER.stdholder_id
  is '???ID';
comment on column AIGA.ALM_HIS_STAKEHOLDER.template_id
  is '??ID';
comment on column AIGA.ALM_HIS_STAKEHOLDER.link_id
  is '??ID';
comment on column AIGA.ALM_HIS_STAKEHOLDER.link_no
  is '????';
comment on column AIGA.ALM_HIS_STAKEHOLDER.obj_id
  is '??ID';
comment on column AIGA.ALM_HIS_STAKEHOLDER.obj_type
  is '????';
comment on column AIGA.ALM_HIS_STAKEHOLDER.role_id
  is '??ID';
comment on column AIGA.ALM_HIS_STAKEHOLDER.stdholder_staff_org_id
  is '???????ID';
comment on column AIGA.ALM_HIS_STAKEHOLDER.stdholder_staff_id
  is '?????ID';
comment on column AIGA.ALM_HIS_STAKEHOLDER.stdholder_staff_no
  is '???????';
comment on column AIGA.ALM_HIS_STAKEHOLDER.stdholder_staff_name
  is '???????';
comment on column AIGA.ALM_HIS_STAKEHOLDER.stdholde_type
  is '1 ??
2 ??(????)
3 ??(????)
4 ??  5??(????)';
comment on column AIGA.ALM_HIS_STAKEHOLDER.create_time
  is '????';
alter table AIGA.ALM_HIS_STAKEHOLDER
  add constraint PK_HIS_STDHOLDER_ID primary key (HIS_STDHOLDER_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ALM_HIS_WORKORDER
prompt ================================
prompt
create table AIGA.ALM_HIS_WORKORDER
(
  his_order_id      NUMBER(12) not null,
  order_id          NUMBER(12),
  workflow_id       NUMBER(12),
  parent_order_id   NUMBER(12),
  last_order_id     NUMBER(12),
  vm_task_id        NUMBER(12),
  parent_vm_task_id NUMBER(12),
  last_vm_task_id   NUMBER(12),
  link_id           NUMBER(12),
  link_no           VARCHAR2(32),
  link_no_type      VARCHAR2(15),
  is_current_task   VARCHAR2(1),
  order_type        VARCHAR2(4),
  obj_id            NUMBER(12),
  obj_type          VARCHAR2(4),
  deal_type         VARCHAR2(2),
  is_lock           NUMBER(2),
  finish_print      NUMBER(2),
  exec_role_id      NUMBER(12),
  exec_role_code    VARCHAR2(500),
  exec_staff_id     NUMBER(12),
  exec_staff_no     VARCHAR2(32),
  lock_role_id      NUMBER(12),
  lock_role_code    VARCHAR2(500),
  lock_staff_id     NUMBER(12),
  lock_staff_no     VARCHAR2(32),
  result            VARCHAR2(15),
  cond              VARCHAR2(4000),
  status            VARCHAR2(2),
  opinion           VARCHAR2(4000),
  lock_opinion      VARCHAR2(4000),
  create_time       DATE,
  recv_time         DATE,
  lock_time         DATE,
  realse_lock_time  DATE,
  exec_time         DATE,
  finish_time       DATE,
  lock_times        NUMBER(30),
  exec_times        NUMBER(30),
  advice_comp_time  DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 384K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table AIGA.ALM_HIS_WORKORDER
  is '???';
comment on column AIGA.ALM_HIS_WORKORDER.his_order_id
  is '????ID';
comment on column AIGA.ALM_HIS_WORKORDER.order_id
  is '??ID';
comment on column AIGA.ALM_HIS_WORKORDER.workflow_id
  is 'VM??????????ID';
comment on column AIGA.ALM_HIS_WORKORDER.parent_order_id
  is '???ID';
comment on column AIGA.ALM_HIS_WORKORDER.last_order_id
  is '????ID';
comment on column AIGA.ALM_HIS_WORKORDER.vm_task_id
  is 'VM??ID';
comment on column AIGA.ALM_HIS_WORKORDER.parent_vm_task_id
  is 'VM???ID';
comment on column AIGA.ALM_HIS_WORKORDER.last_vm_task_id
  is 'VM????ID';
comment on column AIGA.ALM_HIS_WORKORDER.link_id
  is '??ID';
comment on column AIGA.ALM_HIS_WORKORDER.link_no
  is '????';
comment on column AIGA.ALM_HIS_WORKORDER.link_no_type
  is '???? start\end\user\sign\auto';
comment on column AIGA.ALM_HIS_WORKORDER.is_current_task
  is '???????';
comment on column AIGA.ALM_HIS_WORKORDER.order_type
  is '?????1=??  2=??? 3=??? 4=?? 5=?? 6=?? 7=??';
comment on column AIGA.ALM_HIS_WORKORDER.obj_id
  is '????ID';
comment on column AIGA.ALM_HIS_WORKORDER.obj_type
  is '?????1=??  2=??? 3=??? 4=??';
comment on column AIGA.ALM_HIS_WORKORDER.deal_type
  is '?????2=??????????? 5=???';
comment on column AIGA.ALM_HIS_WORKORDER.is_lock
  is '???? 0=??? 1=???';
comment on column AIGA.ALM_HIS_WORKORDER.finish_print
  is '??????  0=??? 1=??? 2=????';
comment on column AIGA.ALM_HIS_WORKORDER.exec_role_id
  is '??ID';
comment on column AIGA.ALM_HIS_WORKORDER.exec_role_code
  is '????';
comment on column AIGA.ALM_HIS_WORKORDER.exec_staff_id
  is '?????ID';
comment on column AIGA.ALM_HIS_WORKORDER.exec_staff_no
  is '???????';
comment on column AIGA.ALM_HIS_WORKORDER.lock_role_id
  is '??????ID';
comment on column AIGA.ALM_HIS_WORKORDER.lock_role_code
  is '????????';
comment on column AIGA.ALM_HIS_WORKORDER.lock_staff_id
  is '???????ID';
comment on column AIGA.ALM_HIS_WORKORDER.lock_staff_no
  is '?????????';
comment on column AIGA.ALM_HIS_WORKORDER.result
  is '???? Y=???N=????O=???';
comment on column AIGA.ALM_HIS_WORKORDER.cond
  is '???????';
comment on column AIGA.ALM_HIS_WORKORDER.status
  is '?????1=???2=?????3=????';
comment on column AIGA.ALM_HIS_WORKORDER.opinion
  is '?????';
comment on column AIGA.ALM_HIS_WORKORDER.lock_opinion
  is '?????';
comment on column AIGA.ALM_HIS_WORKORDER.create_time
  is '??????';
comment on column AIGA.ALM_HIS_WORKORDER.recv_time
  is '??????';
comment on column AIGA.ALM_HIS_WORKORDER.lock_time
  is '??????';
comment on column AIGA.ALM_HIS_WORKORDER.realse_lock_time
  is '??????';
comment on column AIGA.ALM_HIS_WORKORDER.exec_time
  is '????????';
comment on column AIGA.ALM_HIS_WORKORDER.finish_time
  is '????????';
comment on column AIGA.ALM_HIS_WORKORDER.lock_times
  is '????????????';
comment on column AIGA.ALM_HIS_WORKORDER.exec_times
  is '????????????';

prompt
prompt Creating table ALM_STAKEHOLDER
prompt ==============================
prompt
create table AIGA.ALM_STAKEHOLDER
(
  stdholder_id           NUMBER(12) not null,
  template_id            NUMBER(12),
  link_id                NUMBER(12),
  link_no                VARCHAR2(32),
  obj_id                 NUMBER(12),
  obj_type               VARCHAR2(2),
  role_id                NUMBER(12),
  role_code              VARCHAR2(100),
  stdholder_staff_org_id NUMBER(12),
  stdholder_staff_id     NUMBER(12),
  stdholder_staff_no     VARCHAR2(32),
  stdholder_staff_name   VARCHAR2(32),
  stdholde_type          VARCHAR2(2),
  create_time            DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 5M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table AIGA.ALM_STAKEHOLDER
  is 'Stakeholder';
comment on column AIGA.ALM_STAKEHOLDER.stdholder_id
  is '???ID';
comment on column AIGA.ALM_STAKEHOLDER.template_id
  is '??ID';
comment on column AIGA.ALM_STAKEHOLDER.link_id
  is '??ID';
comment on column AIGA.ALM_STAKEHOLDER.link_no
  is '????';
comment on column AIGA.ALM_STAKEHOLDER.obj_id
  is '??ID';
comment on column AIGA.ALM_STAKEHOLDER.obj_type
  is '????';
comment on column AIGA.ALM_STAKEHOLDER.role_id
  is '??ID';
comment on column AIGA.ALM_STAKEHOLDER.stdholder_staff_org_id
  is '???????ID';
comment on column AIGA.ALM_STAKEHOLDER.stdholder_staff_id
  is '?????ID';
comment on column AIGA.ALM_STAKEHOLDER.stdholder_staff_no
  is '???????';
comment on column AIGA.ALM_STAKEHOLDER.stdholder_staff_name
  is '???????';
comment on column AIGA.ALM_STAKEHOLDER.stdholde_type
  is '1 ??
2 ??(????)
3 ??(????)
4 ??  5??(????)';
comment on column AIGA.ALM_STAKEHOLDER.create_time
  is '????';

prompt
prompt Creating table ALM_TOPOLOGY
prompt ===========================
prompt
create table AIGA.ALM_TOPOLOGY
(
  no         VARCHAR2(15) not null,
  fpoint     NUMBER,
  tpoint     NUMBER,
  result     VARCHAR2(4000),
  drivnos    VARCHAR2(4000),
  drivno_fun VARCHAR2(4000),
  is_def     NUMBER
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.ALM_TOPOLOGY.no
  is '??';
comment on column AIGA.ALM_TOPOLOGY.fpoint
  is '???(???)';
comment on column AIGA.ALM_TOPOLOGY.tpoint
  is '???(??? )';
comment on column AIGA.ALM_TOPOLOGY.result
  is '??';
comment on column AIGA.ALM_TOPOLOGY.drivnos
  is '???';
comment on column AIGA.ALM_TOPOLOGY.drivno_fun
  is '??????????????????????';
comment on column AIGA.ALM_TOPOLOGY.is_def
  is '????????????';
alter table AIGA.ALM_TOPOLOGY
  add constraint PK_ALM_TOPOLOGY primary key (NO)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ALM_TOPO_CON
prompt ===========================
prompt
create table AIGA.ALM_TOPO_CON
(
  no     VARCHAR2(15) not null,
  fun_no VARCHAR2(15),
  cond   VARCHAR2(4000)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table AIGA.ALM_TOPO_CON
  is '???';
comment on column AIGA.ALM_TOPO_CON.no
  is '??';
comment on column AIGA.ALM_TOPO_CON.fun_no
  is '??';
comment on column AIGA.ALM_TOPO_CON.cond
  is '??';
alter table AIGA.ALM_TOPO_CON
  add constraint PK_ALM_TOPO_CON primary key (NO)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ALM_TOPO_FUN
prompt ===========================
prompt
create table AIGA.ALM_TOPO_FUN
(
  no     VARCHAR2(15) not null,
  action VARCHAR2(50),
  fun    VARCHAR2(255),
  servid VARCHAR2(4000)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.ALM_TOPO_FUN.no
  is '??';
comment on column AIGA.ALM_TOPO_FUN.action
  is '??';
comment on column AIGA.ALM_TOPO_FUN.fun
  is '??';
comment on column AIGA.ALM_TOPO_FUN.servid
  is '????';
alter table AIGA.ALM_TOPO_FUN
  add constraint PK_ALM_TOPO_FUN primary key (NO)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ALM_TOPO_RULE
prompt ============================
prompt
create table AIGA.ALM_TOPO_RULE
(
  no          VARCHAR2(15) not null,
  topo_no     VARCHAR2(15),
  topo_con_no VARCHAR2(15),
  stime       DATE,
  etime       DATE,
  driv_con_no VARCHAR2(15)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.ALM_TOPO_RULE.no
  is '??';
comment on column AIGA.ALM_TOPO_RULE.topo_no
  is '????';
comment on column AIGA.ALM_TOPO_RULE.topo_con_no
  is '??????';
comment on column AIGA.ALM_TOPO_RULE.stime
  is '??????';
comment on column AIGA.ALM_TOPO_RULE.etime
  is '??????';
comment on column AIGA.ALM_TOPO_RULE.driv_con_no
  is '??????';
alter table AIGA.ALM_TOPO_RULE
  add constraint PK_ALM_TOPO_RULE primary key (NO)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ALM_WORKFLOW
prompt ===========================
prompt
create table AIGA.ALM_WORKFLOW
(
  wf_item_id          NUMBER(12) not null,
  template_id         NUMBER(12),
  template_name       VARCHAR2(128),
  template_type       NUMBER(2),
  version             VARCHAR2(32),
  phase_id            VARCHAR2(32),
  phase_name          VARCHAR2(128),
  vm_task_name        VARCHAR2(128) not null,
  vm_link_id          NUMBER(12),
  vm_task_no          VARCHAR2(32),
  link_id             NUMBER(12) not null,
  link_no             VARCHAR2(32),
  link_no_type        VARCHAR2(4000),
  role_code           VARCHAR2(40),
  link_url            VARCHAR2(4000),
  next_link_cond_tree NUMBER(20),
  is_display          NUMBER(1),
  is_role             NUMBER(1),
  is_print            NUMBER(1),
  is_reauthorize      NUMBER(1),
  is_terminate        NUMBER(1),
  is_back             NUMBER(1),
  is_notice           NUMBER(1),
  is_discuss          NUMBER(1),
  back_cond           VARCHAR2(4000),
  back_link_no        VARCHAR2(32),
  html_tag_name       VARCHAR2(500),
  html_tag_desc       VARCHAR2(500),
  init_link_no        VARCHAR2(32),
  init_link_id        NUMBER(12),
  need_init_staff     NUMBER,
  create_staff_id     NUMBER(12),
  create_time         DATE,
  start_time          DATE,
  end_time            DATE,
  valid_tag           NUMBER(1),
  is_company          NUMBER(1),
  is_depart           NUMBER(1),
  is_group            NUMBER(1),
  connect_point       VARCHAR2(500)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on table AIGA.ALM_WORKFLOW
  is '??????';
comment on column AIGA.ALM_WORKFLOW.wf_item_id
  is '???ID';
comment on column AIGA.ALM_WORKFLOW.template_id
  is '??? vm_template';
comment on column AIGA.ALM_WORKFLOW.template_name
  is '????';
comment on column AIGA.ALM_WORKFLOW.template_type
  is '????';
comment on column AIGA.ALM_WORKFLOW.version
  is '???';
comment on column AIGA.ALM_WORKFLOW.phase_id
  is '????';
comment on column AIGA.ALM_WORKFLOW.phase_name
  is '????';
comment on column AIGA.ALM_WORKFLOW.vm_task_name
  is '????';
comment on column AIGA.ALM_WORKFLOW.vm_link_id
  is '??ID';
comment on column AIGA.ALM_WORKFLOW.vm_task_no
  is '????';
comment on column AIGA.ALM_WORKFLOW.link_id
  is '??ID';
comment on column AIGA.ALM_WORKFLOW.link_no
  is '????';
comment on column AIGA.ALM_WORKFLOW.link_no_type
  is '???? start\end\user\sign\auto';
comment on column AIGA.ALM_WORKFLOW.role_code
  is '??ID';
comment on column AIGA.ALM_WORKFLOW.link_url
  is '????';
comment on column AIGA.ALM_WORKFLOW.next_link_cond_tree
  is '???????????? ID';
comment on column AIGA.ALM_WORKFLOW.is_display
  is '??????';
comment on column AIGA.ALM_WORKFLOW.is_role
  is '????A-B?????';
comment on column AIGA.ALM_WORKFLOW.is_print
  is '??????';
comment on column AIGA.ALM_WORKFLOW.is_reauthorize
  is '??????';
comment on column AIGA.ALM_WORKFLOW.is_terminate
  is '???????????';
comment on column AIGA.ALM_WORKFLOW.is_back
  is '???????????';
comment on column AIGA.ALM_WORKFLOW.is_notice
  is '????';
comment on column AIGA.ALM_WORKFLOW.is_discuss
  is '????';
comment on column AIGA.ALM_WORKFLOW.back_cond
  is '????';
comment on column AIGA.ALM_WORKFLOW.back_link_no
  is '???????';
comment on column AIGA.ALM_WORKFLOW.html_tag_name
  is '???????????';
comment on column AIGA.ALM_WORKFLOW.html_tag_desc
  is '???????????';
comment on column AIGA.ALM_WORKFLOW.init_link_no
  is '????????????LINK_NO';
comment on column AIGA.ALM_WORKFLOW.init_link_id
  is '????????????LINK_ID';
comment on column AIGA.ALM_WORKFLOW.need_init_staff
  is '??????????';
comment on column AIGA.ALM_WORKFLOW.create_staff_id
  is '???';
comment on column AIGA.ALM_WORKFLOW.create_time
  is '????????';
comment on column AIGA.ALM_WORKFLOW.start_time
  is '???????';
comment on column AIGA.ALM_WORKFLOW.end_time
  is '???????';
comment on column AIGA.ALM_WORKFLOW.valid_tag
  is '1 ?? 2 ?? 3 ??';
comment on column AIGA.ALM_WORKFLOW.is_company
  is '??????????????';
comment on column AIGA.ALM_WORKFLOW.is_depart
  is '??????????????';
comment on column AIGA.ALM_WORKFLOW.is_group
  is '???????????????';
comment on column AIGA.ALM_WORKFLOW.connect_point
  is '????';

prompt
prompt Creating table ALM_WORKFLOW_DRIVING
prompt ===================================
prompt
create table AIGA.ALM_WORKFLOW_DRIVING
(
  driving_id          NUMBER(20) not null,
  passive_point       VARCHAR2(1000),
  active_point        VARCHAR2(1000),
  passive_template_id NUMBER(20),
  active_template_id  NUMBER(20),
  link_relative_phase NUMBER(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.ALM_WORKFLOW_DRIVING
  add constraint DRIVING_ID$INDEX primary key (DRIVING_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ALM_WORKFLOW_TEMPLATE
prompt ====================================
prompt
create table AIGA.ALM_WORKFLOW_TEMPLATE
(
  template_id   NUMBER(10) not null,
  template_type VARCHAR2(4000),
  template_name VARCHAR2(4000),
  obj_type      VARCHAR2(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.ALM_WORKFLOW_TEMPLATE.template_type
  is 'workflow?????????';
comment on column AIGA.ALM_WORKFLOW_TEMPLATE.obj_type
  is '????';
alter table AIGA.ALM_WORKFLOW_TEMPLATE
  add primary key (TEMPLATE_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ALM_WORKORDER
prompt ============================
prompt
create table AIGA.ALM_WORKORDER
(
  order_id          NUMBER(12) not null,
  workflow_id       NUMBER(12),
  parent_order_id   NUMBER(12),
  last_order_id     NUMBER(12),
  vm_task_id        NUMBER(12),
  parent_vm_task_id NUMBER(12),
  last_vm_task_id   NUMBER(12),
  link_id           NUMBER(12),
  link_no           VARCHAR2(32),
  link_no_type      VARCHAR2(15),
  is_current_task   VARCHAR2(1),
  order_type        VARCHAR2(4),
  obj_id            NUMBER(12),
  obj_type          VARCHAR2(4),
  deal_type         VARCHAR2(2),
  is_lock           NUMBER(2),
  finish_print      NUMBER(2),
  exec_role_id      NUMBER(12),
  exec_role_code    VARCHAR2(500),
  exec_staff_id     NUMBER(12),
  exec_staff_no     VARCHAR2(32),
  lock_role_id      NUMBER(12),
  lock_role_code    VARCHAR2(500),
  lock_staff_id     NUMBER(12),
  lock_staff_no     VARCHAR2(32),
  result            VARCHAR2(15),
  cond              VARCHAR2(4000),
  status            VARCHAR2(2),
  opinion           VARCHAR2(4000),
  lock_opinion      VARCHAR2(4000),
  create_time       DATE,
  recv_time         DATE,
  lock_time         DATE,
  realse_lock_time  DATE,
  exec_time         DATE,
  finish_time       DATE,
  lock_times        NUMBER(30),
  exec_times        NUMBER(30),
  advice_comp_time  DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on table AIGA.ALM_WORKORDER
  is '???';
comment on column AIGA.ALM_WORKORDER.order_id
  is '??ID';
comment on column AIGA.ALM_WORKORDER.workflow_id
  is 'VM??????????ID';
comment on column AIGA.ALM_WORKORDER.parent_order_id
  is '???ID';
comment on column AIGA.ALM_WORKORDER.last_order_id
  is '????ID';
comment on column AIGA.ALM_WORKORDER.vm_task_id
  is 'VM??ID';
comment on column AIGA.ALM_WORKORDER.parent_vm_task_id
  is 'VM???ID';
comment on column AIGA.ALM_WORKORDER.last_vm_task_id
  is 'VM????ID';
comment on column AIGA.ALM_WORKORDER.link_id
  is '??ID';
comment on column AIGA.ALM_WORKORDER.link_no
  is '????';
comment on column AIGA.ALM_WORKORDER.link_no_type
  is '???? start\end\user\sign\auto';
comment on column AIGA.ALM_WORKORDER.is_current_task
  is '???????';
comment on column AIGA.ALM_WORKORDER.order_type
  is '?????1=??  2=??? 3=??? 4=?? 5=?? 6=?? 7=??';
comment on column AIGA.ALM_WORKORDER.obj_id
  is '????ID';
comment on column AIGA.ALM_WORKORDER.obj_type
  is '?????1=??  2=??? 3=??? 4=??';
comment on column AIGA.ALM_WORKORDER.deal_type
  is '?????2=??????????? 5=???';
comment on column AIGA.ALM_WORKORDER.is_lock
  is '???? 0=??? 1=???';
comment on column AIGA.ALM_WORKORDER.finish_print
  is '??????  0=??? 1=??? 2=????';
comment on column AIGA.ALM_WORKORDER.exec_role_id
  is '??ID';
comment on column AIGA.ALM_WORKORDER.exec_role_code
  is '????';
comment on column AIGA.ALM_WORKORDER.exec_staff_id
  is '?????ID';
comment on column AIGA.ALM_WORKORDER.exec_staff_no
  is '???????';
comment on column AIGA.ALM_WORKORDER.lock_role_id
  is '??????ID';
comment on column AIGA.ALM_WORKORDER.lock_role_code
  is '????????';
comment on column AIGA.ALM_WORKORDER.lock_staff_id
  is '???????ID';
comment on column AIGA.ALM_WORKORDER.lock_staff_no
  is '?????????';
comment on column AIGA.ALM_WORKORDER.result
  is '???? Y=???N=????O=???';
comment on column AIGA.ALM_WORKORDER.cond
  is '???????';
comment on column AIGA.ALM_WORKORDER.status
  is '?????1=???2=?????3=????';
comment on column AIGA.ALM_WORKORDER.opinion
  is '?????';
comment on column AIGA.ALM_WORKORDER.lock_opinion
  is '?????';
comment on column AIGA.ALM_WORKORDER.create_time
  is '??????';
comment on column AIGA.ALM_WORKORDER.recv_time
  is '??????';
comment on column AIGA.ALM_WORKORDER.lock_time
  is '??????';
comment on column AIGA.ALM_WORKORDER.realse_lock_time
  is '??????';
comment on column AIGA.ALM_WORKORDER.exec_time
  is '????????';
comment on column AIGA.ALM_WORKORDER.finish_time
  is '????????';
comment on column AIGA.ALM_WORKORDER.lock_times
  is '????????????';
comment on column AIGA.ALM_WORKORDER.exec_times
  is '????????????';
comment on column AIGA.ALM_WORKORDER.advice_comp_time
  is '建议完成时间';
alter table AIGA.ALM_WORKORDER
  add constraint ORDER_ID$PRIMARY primary key (ORDER_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table APPFRAME_SERVER
prompt ==============================
prompt
create table AIGA.APPFRAME_SERVER
(
  server_id         VARCHAR2(200) not null,
  server_ip         VARCHAR2(10),
  application_type  VARCHAR2(50),
  jmx_http_url      VARCHAR2(100),
  jmx_rmi_url       VARCHAR2(100),
  create_date       DATE,
  last_refresh_date DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table AIGA.APPFRAME_SERVER
  is '?????????';
comment on column AIGA.APPFRAME_SERVER.server_id
  is '?????';
comment on column AIGA.APPFRAME_SERVER.server_ip
  is '???IP??';
comment on column AIGA.APPFRAME_SERVER.application_type
  is '????';
comment on column AIGA.APPFRAME_SERVER.create_date
  is '???????';
comment on column AIGA.APPFRAME_SERVER.last_refresh_date
  is '????????';

prompt
prompt Creating table APPFRAME_SERVER_HIS
prompt ==================================
prompt
create table AIGA.APPFRAME_SERVER_HIS
(
  server_id         VARCHAR2(200) not null,
  server_ip         VARCHAR2(10),
  application_type  VARCHAR2(50),
  jmx_http_url      VARCHAR2(100),
  jmx_rmi_url       VARCHAR2(100),
  create_date       DATE,
  last_refresh_date DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table AIGA.APPFRAME_SERVER_HIS
  is '?????????';
comment on column AIGA.APPFRAME_SERVER_HIS.server_id
  is '?????';
comment on column AIGA.APPFRAME_SERVER_HIS.server_ip
  is '???IP??';
comment on column AIGA.APPFRAME_SERVER_HIS.application_type
  is '????';
comment on column AIGA.APPFRAME_SERVER_HIS.create_date
  is '???????';
comment on column AIGA.APPFRAME_SERVER_HIS.last_refresh_date
  is '????????';

prompt
prompt Creating table BS_DISTRICT
prompt ==========================
prompt
create table AIGA.BS_DISTRICT
(
  district_id           NUMBER(8) not null,
  region_id             VARCHAR2(6),
  district_name         VARCHAR2(100) not null,
  district_english_name VARCHAR2(100),
  district_type_id      NUMBER(6) not null,
  parent_district_id    NUMBER(8),
  area_code             VARCHAR2(8),
  post_code             NUMBER(6),
  notes                 VARCHAR2(255),
  sort_id               NUMBER(8),
  center_info_code      VARCHAR2(6),
  district_two_number   NUMBER(2),
  course_flag           NUMBER(1)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BS_I18N_RESOURCE
prompt ===============================
prompt
create table AIGA.BS_I18N_RESOURCE
(
  res_key VARCHAR2(15) not null,
  zh_cn   VARCHAR2(1000) not null,
  en_us   VARCHAR2(1000),
  state   CHAR(1) not null,
  remarks VARCHAR2(255)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BS_PARA_DETAIL
prompt =============================
prompt
create table AIGA.BS_PARA_DETAIL
(
  region_id  VARCHAR2(6) not null,
  para_type  VARCHAR2(50) not null,
  para_code  VARCHAR2(50) not null,
  para_name  VARCHAR2(60),
  para1      VARCHAR2(2048),
  para2      VARCHAR2(2048),
  para3      VARCHAR2(2048),
  para4      VARCHAR2(2048),
  para5      VARCHAR2(2048),
  para_desc  VARCHAR2(128),
  state      CHAR(1) not null,
  op_id      NUMBER(12),
  state_date DATE,
  remarks    VARCHAR2(255)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BS_STATIC_DATA
prompt =============================
prompt
create table AIGA.BS_STATIC_DATA
(
  code_type        VARCHAR2(255) not null,
  code_value       VARCHAR2(255) not null,
  code_name        VARCHAR2(255) not null,
  code_desc        VARCHAR2(255),
  code_type_alias  VARCHAR2(255),
  sort_id          NUMBER(3),
  state            CHAR(1) not null,
  extern_code_type VARCHAR2(2000)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CFG_BO_MASK
prompt ==========================
prompt
create table AIGA.CFG_BO_MASK
(
  bo_name             VARCHAR2(255) not null,
  attr_name           VARCHAR2(255) not null,
  mask_function_class VARCHAR2(255) not null,
  state               CHAR(1) not null,
  remarks             VARCHAR2(255)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CFG_DB_ACCT
prompt ==========================
prompt
create table AIGA.CFG_DB_ACCT
(
  db_acct_code     VARCHAR2(255) not null,
  username         VARCHAR2(255),
  password         VARCHAR2(255),
  host             VARCHAR2(255),
  port             NUMBER(5),
  sid              VARCHAR2(255),
  default_conn_min NUMBER(3),
  default_conn_max NUMBER(3),
  state            CHAR(1),
  remarks          VARCHAR2(1000)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CFG_DB_RELAT
prompt ===========================
prompt
create table AIGA.CFG_DB_RELAT
(
  db_acct_code VARCHAR2(255) not null,
  url_name     VARCHAR2(255),
  server_name  VARCHAR2(255) not null,
  state        CHAR(1),
  remarks      VARCHAR2(255)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CFG_DB_URL
prompt =========================
prompt
create table AIGA.CFG_DB_URL
(
  name    VARCHAR2(255) not null,
  url     VARCHAR2(4000),
  state   CHAR(1),
  remarks VARCHAR2(255)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CFG_DYNC_TABLE_SPLIT
prompt ===================================
prompt
create table AIGA.CFG_DYNC_TABLE_SPLIT
(
  group_name      VARCHAR2(255) not null,
  table_name      VARCHAR2(255) not null,
  table_name_expr VARCHAR2(255) not null,
  convert_class   VARCHAR2(255) not null,
  state           CHAR(1) not null,
  remarks         VARCHAR2(255)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CFG_ID_GENERATOR
prompt ===============================
prompt
create table AIGA.CFG_ID_GENERATOR
(
  table_name             VARCHAR2(100),
  domain_id              NUMBER(6) not null,
  generator_type         CHAR(1) not null,
  sequence_name          VARCHAR2(60),
  max_id                 NUMBER(12),
  start_value            NUMBER(12),
  min_value              NUMBER(12),
  max_value              NUMBER(12),
  increment_value        NUMBER(6),
  cycle_flag             CHAR(1),
  cache_size             NUMBER(6),
  sequence_create_script VARCHAR2(1000),
  his_table_name         VARCHAR2(100),
  his_sequence_name      VARCHAR2(60),
  his_data_flag          CHAR(1),
  his_max_id             NUMBER(12),
  his_donecode_flag      CHAR(1),
  step_by                NUMBER(6),
  his_step_by            NUMBER(6)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CFG_ID_GENERATOR_WRAPPER
prompt =======================================
prompt
create table AIGA.CFG_ID_GENERATOR_WRAPPER
(
  table_name                 VARCHAR2(100),
  table_seq_wrapper_impl     VARCHAR2(1000),
  his_table_seq_wrapper_impl VARCHAR2(1000)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CFG_METHOD_CENTER
prompt ================================
prompt
create table AIGA.CFG_METHOD_CENTER
(
  service_impl_classname VARCHAR2(255) not null,
  method_name            VARCHAR2(255) not null,
  parameter_count        NUMBER(6) not null,
  parameter_index        NUMBER(6) not null,
  parameter_function     VARCHAR2(255) not null,
  center_type            VARCHAR2(255) not null,
  state                  CHAR(1) not null,
  remarks                VARCHAR2(255)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CFG_MSG_CLIENT
prompt =============================
prompt
create table AIGA.CFG_MSG_CLIENT
(
  cfg_msg_contral_code VARCHAR2(50) not null,
  url_address          VARCHAR2(255),
  http_connections     NUMBER(10),
  http_timeout         NUMBER(10),
  state                CHAR(1),
  remarks              VARCHAR2(255),
  channel              VARCHAR2(100),
  server_type          VARCHAR2(25),
  server_name          VARCHAR2(100),
  record_log           CHAR(1)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CFG_MSG_SERVER
prompt =============================
prompt
create table AIGA.CFG_MSG_SERVER
(
  server_id       NUMBER(12) not null,
  server_code     VARCHAR2(255) not null,
  server_name     VARCHAR2(4000) not null,
  server_group    VARCHAR2(50),
  server_host     VARCHAR2(50),
  port            NUMBER(5),
  reuse_address   VARCHAR2(255),
  acceptors       VARCHAR2(50),
  minthreads      NUMBER(2),
  maxtheeads      NUMBER(2),
  context_path    VARCHAR2(50),
  context_session CHAR(1),
  state           CHAR(1) not null,
  remarks         VARCHAR2(255),
  comet_path      VARCHAR2(50),
  central_servlet VARCHAR2(500)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CFG_SERVICE_CONTROL
prompt ==================================
prompt
create table AIGA.CFG_SERVICE_CONTROL
(
  server_name  VARCHAR2(1000) not null,
  service_name VARCHAR2(1000) not null,
  method_name  VARCHAR2(1000),
  limit_count  NUMBER(6) not null,
  state        CHAR(1) not null,
  remarks      VARCHAR2(255)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CFG_TABLE_SPLIT
prompt ==============================
prompt
create table AIGA.CFG_TABLE_SPLIT
(
  table_name      VARCHAR2(255),
  table_name_expr VARCHAR2(255) not null,
  state           CHAR(1) not null,
  remarks         VARCHAR2(255)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CFG_TABLE_SPLIT_MAPPING
prompt ======================================
prompt
create table AIGA.CFG_TABLE_SPLIT_MAPPING
(
  mapping_id           NUMBER(12),
  table_name           VARCHAR2(255) not null,
  column_name          VARCHAR2(255) not null,
  column_convert_class VARCHAR2(255) not null,
  state                CHAR(1) not null,
  remarks              VARCHAR2(255)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DACP_VE
prompt ======================
prompt
create table AIGA.DACP_VE
(
  id        VARCHAR2(8) not null,
  name      VARCHAR2(64),
  descr     VARCHAR2(512),
  create_dt TIMESTAMP(6),
  lastupd   TIMESTAMP(6),
  user_id   VARCHAR2(32),
  state     VARCHAR2(32) default '┐фиб'
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.DACP_VE
  add primary key (ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DACP_VE_PAGE
prompt ===========================
prompt
create table AIGA.DACP_VE_PAGE
(
  id             VARCHAR2(16) not null,
  name           VARCHAR2(64),
  ve_id          VARCHAR2(8) not null,
  parent_page_id VARCHAR2(16)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.DACP_VE_PAGE
  add primary key (ID, VE_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DACP_VE_STORE
prompt ============================
prompt
create table AIGA.DACP_VE_STORE
(
  id         VARCHAR2(16) not null,
  name       VARCHAR2(32),
  ve_id      VARCHAR2(8) not null,
  page_id    VARCHAR2(16),
  class_name VARCHAR2(32),
  parameters CLOB
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.DACP_VE_STORE
  add primary key (ID, VE_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DACP_VE_WIDGET
prompt =============================
prompt
create table AIGA.DACP_VE_WIDGET
(
  id         VARCHAR2(32) not null,
  name       VARCHAR2(64),
  ve_id      VARCHAR2(8) not null,
  page_id    VARCHAR2(16) not null,
  class_name VARCHAR2(32),
  parameters CLOB,
  style      CLOB,
  seq        INTEGER
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.DACP_VE_WIDGET
  add primary key (ID, VE_ID, PAGE_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table DISTRICT
prompt =======================
prompt
create table AIGA.DISTRICT
(
  district_id           NUMBER(8) not null,
  region_id             VARCHAR2(6),
  district_name         VARCHAR2(100),
  district_english_name VARCHAR2(100),
  district_type_id      NUMBER(6),
  parent_district_id    NUMBER(8),
  area_code             VARCHAR2(8),
  post_code             NUMBER(6),
  notes                 VARCHAR2(255),
  sort_id               NUMBER(8),
  center_info_code      VARCHAR2(6),
  district_two_number   NUMBER(2),
  course_flag           NUMBER(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 8K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table GJ_AIGA_FUN_FOLDER
prompt =================================
prompt
create table AIGA.GJ_AIGA_FUN_FOLDER
(
  fun_id               NUMBER(20),
  sys_name             VARCHAR2(2000),
  create_time          DATE,
  update_time          DATE,
  sys_id               NUMBER(20),
  busi_label           VARCHAR2(2000),
  base_fun_label       VARCHAR2(2000),
  data_check_script    VARCHAR2(4000),
  important_class      NUMBER(4),
  menu_path            VARCHAR2(2000),
  fun_type             NUMBER(4),
  fun_desc             VARCHAR2(2000),
  is_invalid           NUMBER(4),
  add_reason_type      NUMBER(20),
  add_reason           VARCHAR2(4000),
  efficiency_test_type NUMBER(4),
  is_efficiency_test   NUMBER(4),
  dev_firm             NUMBER(4)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table GJ_AIGA_OPER
prompt ===========================
prompt
create table AIGA.GJ_AIGA_OPER
(
  username VARCHAR2(200),
  userid   VARCHAR2(50),
  rolename VARCHAR2(200)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table GJ_AIGA_SYSTEM_FOLDER
prompt ====================================
prompt
create table AIGA.GJ_AIGA_SYSTEM_FOLDER
(
  sys_id          NUMBER(20) not null,
  sys_name        VARCHAR2(2000),
  create_time     DATE,
  update_time     DATE,
  remarks         VARCHAR2(4000),
  firm            VARCHAR2(255),
  important_class NUMBER(4),
  sys_of_domain   NUMBER(4),
  is_invalid      NUMBER(4),
  order_id        NUMBER(4)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table GJ_AIGA_TEST_ELEM
prompt ================================
prompt
create table AIGA.GJ_AIGA_TEST_ELEM
(
  elem_id               NUMBER(20),
  elem_tag              VARCHAR2(2000),
  elem_name             VARCHAR2(4000),
  elem_sys_achieve_type NUMBER,
  applicate_sys         NUMBER,
  is_global_elem        NUMBER,
  sys_id                NUMBER(20),
  fun_id                NUMBER(20),
  staff_id              NUMBER(20),
  staff_name            VARCHAR2(50),
  is_delete             NUMBER,
  add_reason_type       NUMBER(20),
  add_reason            VARCHAR2(4000),
  fun_name              VARCHAR2(250),
  sys_name              VARCHAR2(250)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table GJ_ASIA_OPER
prompt ===========================
prompt
create table AIGA.GJ_ASIA_OPER
(
  username VARCHAR2(200),
  userid   VARCHAR2(50),
  rolename VARCHAR2(200)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table HIS_VM_TASK
prompt ==========================
prompt
create table AIGA.HIS_VM_TASK
(
  task_id                 NUMBER(12) not null,
  last_task_id            VARCHAR2(500),
  workflow_id             NUMBER(12),
  task_template_id        NUMBER(12),
  engine_workflow_id      VARCHAR2(100),
  engine_task_id          VARCHAR2(100),
  task_type               VARCHAR2(100),
  task_base_type          VARCHAR2(100),
  task_tag                VARCHAR2(100),
  child_workflow_count    NUMBER(10),
  remanent_workflow_count NUMBER(10),
  label                   VARCHAR2(100),
  duration                NUMBER(12),
  decision_result         VARCHAR2(100),
  is_current_task         CHAR(1),
  state                   NUMBER(2),
  state_date              DATE,
  create_date             DATE,
  exe_finish_date         DATE,
  station_id              VARCHAR2(30),
  task_staff_id           VARCHAR2(30),
  lock_staff_id           VARCHAR2(30),
  lock_date               DATE,
  finish_staff_id         VARCHAR2(30),
  finish_date             DATE,
  error_message           VARCHAR2(1000),
  description             VARCHAR2(500),
  warning_date            DATE,
  warning_times           NUMBER(2)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 9M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.HIS_VM_TASK.task_id
  is '????';
comment on column AIGA.HIS_VM_TASK.last_task_id
  is '????????????';
comment on column AIGA.HIS_VM_TASK.workflow_id
  is '?????';
comment on column AIGA.HIS_VM_TASK.task_template_id
  is '??????';
comment on column AIGA.HIS_VM_TASK.engine_task_id
  is '???????????';
comment on column AIGA.HIS_VM_TASK.task_type
  is '????';
comment on column AIGA.HIS_VM_TASK.task_tag
  is '????';
comment on column AIGA.HIS_VM_TASK.child_workflow_count
  is '?????';
comment on column AIGA.HIS_VM_TASK.remanent_workflow_count
  is '????????';
comment on column AIGA.HIS_VM_TASK.label
  is '????';
comment on column AIGA.HIS_VM_TASK.duration
  is '????';
comment on column AIGA.HIS_VM_TASK.decision_result
  is '????';
comment on column AIGA.HIS_VM_TASK.is_current_task
  is '??????';
comment on column AIGA.HIS_VM_TASK.state
  is '???? 1-???? 2-???? 3-???? 4-?? 9-???? 5-???? 6-?? 7-???????? 8-???? 99-???? 21-???????????';
comment on column AIGA.HIS_VM_TASK.state_date
  is '????';
comment on column AIGA.HIS_VM_TASK.create_date
  is '????';
comment on column AIGA.HIS_VM_TASK.exe_finish_date
  is '??????????????';
comment on column AIGA.HIS_VM_TASK.station_id
  is '????';
comment on column AIGA.HIS_VM_TASK.task_staff_id
  is '????';
comment on column AIGA.HIS_VM_TASK.lock_staff_id
  is '????';
comment on column AIGA.HIS_VM_TASK.lock_date
  is '????';
comment on column AIGA.HIS_VM_TASK.finish_staff_id
  is '????';
comment on column AIGA.HIS_VM_TASK.finish_date
  is '????';
comment on column AIGA.HIS_VM_TASK.error_message
  is '????';
comment on column AIGA.HIS_VM_TASK.description
  is '????';
comment on column AIGA.HIS_VM_TASK.warning_date
  is '????';
comment on column AIGA.HIS_VM_TASK.warning_times
  is '????';
alter table AIGA.HIS_VM_TASK
  add constraint BIN$WBOZQXIQIO6RUWMSOBBYW$0 primary key (TASK_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 2M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table HIS_VM_TASK_TRANS
prompt ================================
prompt
create table AIGA.HIS_VM_TASK_TRANS
(
  task_id          NUMBER(12) not null,
  parent_task_id   NUMBER(12),
  workflow_id      NUMBER(12),
  task_template_id NUMBER(12),
  task_type        VARCHAR2(100),
  task_base_type   VARCHAR2(100),
  task_tag         VARCHAR2(100),
  label            VARCHAR2(100),
  duration         NUMBER(12),
  decision_result  VARCHAR2(100),
  is_current_task  CHAR(1),
  state            NUMBER(2),
  state_date       DATE,
  create_date      DATE,
  station_id       VARCHAR2(30),
  task_staff_id    VARCHAR2(30),
  lock_staff_id    VARCHAR2(30),
  lock_date        DATE,
  finish_staff_id  VARCHAR2(30),
  finish_date      DATE,
  error_message    VARCHAR2(1000),
  description      VARCHAR2(500),
  warning_date     DATE,
  warning_times    NUMBER(2)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 448K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.HIS_VM_TASK_TRANS.task_id
  is '????';
comment on column AIGA.HIS_VM_TASK_TRANS.parent_task_id
  is '??????';
comment on column AIGA.HIS_VM_TASK_TRANS.workflow_id
  is '????';
comment on column AIGA.HIS_VM_TASK_TRANS.task_template_id
  is '??????';
comment on column AIGA.HIS_VM_TASK_TRANS.task_type
  is '????';
comment on column AIGA.HIS_VM_TASK_TRANS.task_tag
  is '????';
comment on column AIGA.HIS_VM_TASK_TRANS.label
  is '????';
comment on column AIGA.HIS_VM_TASK_TRANS.duration
  is '????';
comment on column AIGA.HIS_VM_TASK_TRANS.decision_result
  is '????';
comment on column AIGA.HIS_VM_TASK_TRANS.is_current_task
  is '??????';
comment on column AIGA.HIS_VM_TASK_TRANS.state
  is '???? 1-???? 2-???? 3-???? 4-?? 9-???? 5-???? 6-???? 7-???????? 8-???? 99-???? 21-???????????';
comment on column AIGA.HIS_VM_TASK_TRANS.state_date
  is '????';
comment on column AIGA.HIS_VM_TASK_TRANS.create_date
  is '????';
comment on column AIGA.HIS_VM_TASK_TRANS.station_id
  is '????';
comment on column AIGA.HIS_VM_TASK_TRANS.task_staff_id
  is '????';
comment on column AIGA.HIS_VM_TASK_TRANS.lock_staff_id
  is '????';
comment on column AIGA.HIS_VM_TASK_TRANS.lock_date
  is '????';
comment on column AIGA.HIS_VM_TASK_TRANS.finish_staff_id
  is '????';
comment on column AIGA.HIS_VM_TASK_TRANS.finish_date
  is '????';
comment on column AIGA.HIS_VM_TASK_TRANS.error_message
  is '????';
comment on column AIGA.HIS_VM_TASK_TRANS.description
  is '????';
alter table AIGA.HIS_VM_TASK_TRANS
  add constraint BIN$HIKOAIFEQJUSGFJ1TNCLFG$0 primary key (TASK_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table HIS_VM_WORKFLOW_ATTR
prompt ===================================
prompt
create table AIGA.HIS_VM_WORKFLOW_ATTR
(
  attr_id     NUMBER(12) not null,
  workflow_id NUMBER(12),
  attr_code   VARCHAR2(100),
  attr_name   VARCHAR2(100),
  attr_value  VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.HIS_VM_WORKFLOW_ATTR.attr_id
  is '???????????';
comment on column AIGA.HIS_VM_WORKFLOW_ATTR.workflow_id
  is '????';
comment on column AIGA.HIS_VM_WORKFLOW_ATTR.attr_code
  is '????';
comment on column AIGA.HIS_VM_WORKFLOW_ATTR.attr_name
  is '????';
comment on column AIGA.HIS_VM_WORKFLOW_ATTR.attr_value
  is '???';
alter table AIGA.HIS_VM_WORKFLOW_ATTR
  add constraint BIN$Q4LUITTYFP463BHCGW$0 primary key (ATTR_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table HIS_VM_WORK_FLOW
prompt ===============================
prompt
create table AIGA.HIS_VM_WORK_FLOW
(
  task_id                 NUMBER(12) not null,
  task_template_id        NUMBER(12),
  queue_id                VARCHAR2(20),
  engine_workflow_id      VARCHAR2(100),
  engine_type             VARCHAR2(100),
  task_type               VARCHAR2(100),
  task_tag                VARCHAR2(100),
  parent_task_id          NUMBER(12),
  is_exception_workflow   NUMBER(2),
  state                   NUMBER(2),
  state_date              DATE,
  workflow_object_id      VARCHAR2(50),
  workflow_object_type_id VARCHAR2(100),
  user_task_count         NUMBER(12),
  current_task_id         VARCHAR2(100),
  duration                NUMBER(12),
  create_staff_id         VARCHAR2(30),
  create_date             DATE,
  start_date              DATE,
  finish_date             DATE,
  label                   VARCHAR2(100),
  description             VARCHAR2(500),
  vars                    VARCHAR2(4000),
  op_staff_id             VARCHAR2(30),
  error_count             NUMBER(3),
  error_message           VARCHAR2(4000),
  district_id             VARCHAR2(6),
  warning_date            DATE,
  warning_times           NUMBER(2)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 3M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.HIS_VM_WORK_FLOW.task_id
  is '?????';
comment on column AIGA.HIS_VM_WORK_FLOW.task_template_id
  is '???????';
comment on column AIGA.HIS_VM_WORK_FLOW.queue_id
  is '????';
comment on column AIGA.HIS_VM_WORK_FLOW.engine_workflow_id
  is '???????????';
comment on column AIGA.HIS_VM_WORK_FLOW.engine_type
  is '????';
comment on column AIGA.HIS_VM_WORK_FLOW.task_type
  is '?????';
comment on column AIGA.HIS_VM_WORK_FLOW.task_tag
  is '????';
comment on column AIGA.HIS_VM_WORK_FLOW.parent_task_id
  is '?????????????';
comment on column AIGA.HIS_VM_WORK_FLOW.is_exception_workflow
  is '??????0?1-??(PARENT_TASK_ID???????????)';
comment on column AIGA.HIS_VM_WORK_FLOW.state
  is '?? 1-???? 2-???? 3-???? 4-?? 5-???? 7-???????? 8-???? 99-????';
comment on column AIGA.HIS_VM_WORK_FLOW.state_date
  is '????';
comment on column AIGA.HIS_VM_WORK_FLOW.workflow_object_id
  is '?????????';
comment on column AIGA.HIS_VM_WORK_FLOW.workflow_object_type_id
  is '?????????';
comment on column AIGA.HIS_VM_WORK_FLOW.user_task_count
  is '??????';
comment on column AIGA.HIS_VM_WORK_FLOW.current_task_id
  is '????';
comment on column AIGA.HIS_VM_WORK_FLOW.duration
  is '????';
comment on column AIGA.HIS_VM_WORK_FLOW.create_staff_id
  is '???';
comment on column AIGA.HIS_VM_WORK_FLOW.create_date
  is '????';
comment on column AIGA.HIS_VM_WORK_FLOW.start_date
  is '?????????';
comment on column AIGA.HIS_VM_WORK_FLOW.finish_date
  is '????';
comment on column AIGA.HIS_VM_WORK_FLOW.label
  is '?????';
comment on column AIGA.HIS_VM_WORK_FLOW.description
  is '?????';
comment on column AIGA.HIS_VM_WORK_FLOW.vars
  is '????';
comment on column AIGA.HIS_VM_WORK_FLOW.error_message
  is '????';
comment on column AIGA.HIS_VM_WORK_FLOW.warning_date
  is '????';
comment on column AIGA.HIS_VM_WORK_FLOW.warning_times
  is '????';
alter table AIGA.HIS_VM_WORK_FLOW
  add constraint BIN$4H99EQ0ISUY1QCNGQHDNV$0 primary key (TASK_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table METADBCFG
prompt ========================
prompt
create table AIGA.METADBCFG
(
  dbname          VARCHAR2(16),
  cnname          VARCHAR2(32),
  driverclassname VARCHAR2(32),
  url             VARCHAR2(64),
  username        VARCHAR2(32),
  password        VARCHAR2(64),
  jndiname        VARCHAR2(32),
  alias           VARCHAR2(64),
  remark          VARCHAR2(64),
  metaprj         VARCHAR2(32),
  metatype        VARCHAR2(32),
  validationquery VARCHAR2(200)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MXM
prompt ==================
prompt
create table AIGA.MXM
(
  name VARCHAR2(8),
  id   VARCHAR2(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.MXM.name
  is '嘿嘿';

prompt
prompt Creating table OF_CUSTOM_MENU
prompt =============================
prompt
create table AIGA.OF_CUSTOM_MENU
(
  item_id        NUMBER(12) not null,
  item_name      VARCHAR2(50) not null,
  parent_item_id NUMBER(12),
  img_url        VARCHAR2(100),
  relate_func_id NUMBER(12),
  item_desc      VARCHAR2(100),
  open_mode      NUMBER(1),
  fast_key       VARCHAR2(16),
  org_id         NUMBER(12),
  op_id          NUMBER(12),
  done_date      DATE default sysdate,
  item_type      NUMBER(2) default 0,
  is_default     NUMBER(2) default 0,
  seq            NUMBER(3)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table OF_CUST_INFO_ITEM
prompt ================================
prompt
create table AIGA.OF_CUST_INFO_ITEM
(
  item_code      VARCHAR2(32) not null,
  field_name     VARCHAR2(64) not null,
  item_label     VARCHAR2(64) not null,
  label_nls_name VARCHAR2(64) not null,
  own_sys        NUMBER(1) not null,
  is_visible     NUMBER(1) not null,
  input_type     NUMBER(1) not null,
  code_type      VARCHAR2(200),
  read_only      VARCHAR2(200) not null,
  val_chg_fire   VARCHAR2(200),
  sort_no        NUMBER(8) not null,
  img_src        VARCHAR2(200),
  img_hint       VARCHAR2(200),
  page_url       VARCHAR2(200),
  page_title     VARCHAR2(64),
  more_func      VARCHAR2(200),
  verify_mode    VARCHAR2(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table OF_FAVORITE_FOLDER
prompt =================================
prompt
create table AIGA.OF_FAVORITE_FOLDER
(
  folder_id   NUMBER(12) not null,
  house_type  NUMBER(2) not null,
  house_name  VARCHAR2(50),
  parent_id   NUMBER(12) not null,
  done_date   DATE,
  notes       VARCHAR2(255),
  create_date DATE,
  op_id       NUMBER(12)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table OF_FAVORITE_ITEM
prompt ===============================
prompt
create table AIGA.OF_FAVORITE_ITEM
(
  item_id     NUMBER(12) not null,
  item_name   VARCHAR2(256),
  folder_id   NUMBER(12),
  busi_type   NUMBER(2),
  item_url    VARCHAR2(2000),
  see_num     NUMBER(8),
  come_date   DATE,
  done_date   DATE,
  notes       VARCHAR2(255),
  create_date DATE
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table OF_REMIND
prompt ========================
prompt
create table AIGA.OF_REMIND
(
  remind_id          NUMBER(12) not null,
  remind_time        DATE,
  remind_grade       NUMBER(2),
  remind_staff_code  VARCHAR2(20),
  remind_title       VARCHAR2(400),
  remind_content     VARCHAR2(2000),
  org_id             NUMBER(12),
  op_id              NUMBER(12),
  done_date          DATE,
  state              NUMBER(1) not null,
  remind_sender_code VARCHAR2(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table QUEUE_SCHEDULE_LIST
prompt ==================================
prompt
create table AIGA.QUEUE_SCHEDULE_LIST
(
  task_id        VARCHAR2(50) not null,
  task_type      VARCHAR2(50) not null,
  current_server VARCHAR2(50),
  request_server VARCHAR2(50)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table AIGA.QUEUE_SCHEDULE_LIST
  is '????';
comment on column AIGA.QUEUE_SCHEDULE_LIST.task_id
  is '????';
comment on column AIGA.QUEUE_SCHEDULE_LIST.task_type
  is '????';
comment on column AIGA.QUEUE_SCHEDULE_LIST.current_server
  is '???????';
comment on column AIGA.QUEUE_SCHEDULE_LIST.request_server
  is '???????';

prompt
prompt Creating table QUEUE_SCHEDULE_SERVER
prompt ====================================
prompt
create table AIGA.QUEUE_SCHEDULE_SERVER
(
  server_id        VARCHAR2(50) not null,
  server_ip        VARCHAR2(50),
  task_type        VARCHAR2(50),
  thread_num       NUMBER(5),
  create_date      DATE,
  last_modify_date DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table AIGA.QUEUE_SCHEDULE_SERVER
  is '?????????';
comment on column AIGA.QUEUE_SCHEDULE_SERVER.server_id
  is '?????';
comment on column AIGA.QUEUE_SCHEDULE_SERVER.server_ip
  is '???IP??';
comment on column AIGA.QUEUE_SCHEDULE_SERVER.task_type
  is '????';
comment on column AIGA.QUEUE_SCHEDULE_SERVER.thread_num
  is '????';
comment on column AIGA.QUEUE_SCHEDULE_SERVER.create_date
  is '???????';
comment on column AIGA.QUEUE_SCHEDULE_SERVER.last_modify_date
  is '????????';

prompt
prompt Creating table SEC_AUTHOR
prompt =========================
prompt
create table AIGA.SEC_AUTHOR
(
  author_id             NUMBER(12) not null,
  author_entity_id      NUMBER(12),
  role_id               NUMBER(8),
  author_type           VARCHAR2(1),
  parent_role_author_id NUMBER(12),
  author_valid_date     DATE,
  author_expire_date    DATE,
  notes                 VARCHAR2(100),
  state                 NUMBER(2),
  done_code             NUMBER(12),
  create_date           DATE,
  done_date             DATE,
  valid_date            DATE,
  expire_date           DATE,
  op_id                 NUMBER(12),
  org_id                NUMBER(12)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SEC_AUTHOR_ENTITY
prompt ================================
prompt
create table AIGA.SEC_AUTHOR_ENTITY
(
  author_entity_id NUMBER(12) not null,
  obj_type         VARCHAR2(20),
  obj_id           NUMBER(12),
  remarks          VARCHAR2(400),
  state            NUMBER(2),
  done_code        NUMBER(12),
  create_date      DATE,
  done_date        DATE,
  valid_date       DATE,
  expire_date      DATE,
  op_id            NUMBER(12),
  org_id           NUMBER(12)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SEC_ENTITY
prompt =========================
prompt
create table AIGA.SEC_ENTITY
(
  ent_id       NUMBER(12) not null,
  ent_class_id NUMBER(12),
  ent_name     VARCHAR2(100),
  remarks      VARCHAR2(400),
  state        NUMBER(2),
  done_code    NUMBER(12),
  create_date  DATE,
  done_date    DATE,
  valid_date   DATE,
  expire_date  DATE,
  op_id        NUMBER(12),
  org_id       NUMBER(12)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SEC_OPERATOR
prompt ===========================
prompt
create table AIGA.SEC_OPERATOR
(
  operator_id           NUMBER(12) not null,
  staff_id              NUMBER(12),
  code                  VARCHAR2(60) not null,
  tax_code              VARCHAR2(60),
  is_admin              CHAR(1),
  cust_op_id            VARCHAR2(50),
  password              VARCHAR2(48) not null,
  security_id           NUMBER(3),
  recent_password       VARCHAR2(300),
  recent_pass_times     NUMBER(2),
  allow_change_password CHAR(1),
  acct_effect_date      DATE,
  acct_expire_date      DATE,
  last_login_log_id     NUMBER(12),
  try_times             NUMBER(3),
  lock_flag             CHAR(1),
  login_channel         NUMBER(2),
  password_valid_date   DATE,
  chg_passwd_alarm_days NUMBER(10),
  ipmac_flag            VARCHAR2(2),
  is_vpn_login_flag     NUMBER(12),
  chg_passwd_flag       NUMBER(2),
  is_login              CHAR(1),
  notes                 VARCHAR2(400),
  cancel_days           NUMBER(3),
  state                 NUMBER(2),
  done_code             NUMBER(12),
  create_date           DATE not null,
  done_date             DATE not null,
  valid_date            DATE,
  expire_date           DATE,
  op_id                 NUMBER(12),
  org_id                NUMBER(12),
  ex1                   VARCHAR2(50),
  ex2                   VARCHAR2(50)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SEC_OPER_DOMAIN_RELA
prompt ===================================
prompt
create table AIGA.SEC_OPER_DOMAIN_RELA
(
  manager_id      NUMBER(12) not null,
  manager_type    NUMBER(2) not null,
  manager_status  NUMBER(2) not null,
  member_type     NUMBER(2),
  exam_role_id    NUMBER(3),
  rec_status      NUMBER(2),
  province_id     NUMBER(8),
  region_detail   NUMBER(8),
  gender          NUMBER(2),
  iden            NUMBER(2),
  education       NUMBER(2),
  email           VARCHAR2(60),
  office_phone    VARCHAR2(50),
  home_phone      VARCHAR2(50),
  job_name        VARCHAR2(120),
  job_desc        VARCHAR2(100),
  manager_begin   DATE,
  done_date       DATE,
  done_code       NUMBER(15),
  age             NUMBER(3),
  graduate_school VARCHAR2(128),
  graduate_date   DATE,
  profession      VARCHAR2(64),
  boss_org_id     VARCHAR2(255),
  boss_op_id      VARCHAR2(255),
  area_type       NUMBER(2),
  side_type       NUMBER(2),
  is_married      NUMBER(2),
  id_card         VARCHAR2(32),
  birthdate       DATE,
  photo_file      VARCHAR2(256),
  email_password  VARCHAR2(30),
  native_place    VARCHAR2(16),
  blood_type      NUMBER(2),
  health          VARCHAR2(32),
  character       VARCHAR2(32),
  hobbies         VARCHAR2(512),
  star_level      NUMBER(2),
  assess_rec      VARCHAR2(512),
  admin_level     NUMBER(4),
  op_id           NUMBER(8),
  org_id          NUMBER(8)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SEC_OP_LOGIN_ERR
prompt ===============================
prompt
create table AIGA.SEC_OP_LOGIN_ERR
(
  operator_id NUMBER(12) not null,
  login_date  DATE not null,
  err_num     NUMBER(4) not null,
  done_code   NUMBER(12),
  create_date DATE,
  done_date   DATE,
  valid_date  DATE,
  expire_date DATE,
  op_id       NUMBER(12),
  org_id      NUMBER(12)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SEC_OP_SECURITY
prompt ==============================
prompt
create table AIGA.SEC_OP_SECURITY
(
  security_id    NUMBER(3) not null,
  security_desc  VARCHAR2(50) not null,
  passwd_valid   NUMBER(2) not null,
  passwd_length  NUMBER(2) not null,
  passwd_complex NUMBER(1) not null,
  save_his_count NUMBER(1) not null,
  prealert_day   NUMBER(2) not null,
  save_his_days  NUMBER(2),
  max_parataxis  NUMBER(2) not null,
  max_one_para   NUMBER(2) not null
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SEC_OP_STATION
prompt =============================
prompt
create table AIGA.SEC_OP_STATION
(
  op_station_id   NUMBER(12) not null,
  station_id      NUMBER(12) not null,
  operator_id     NUMBER(12) not null,
  is_base_station NUMBER(2) not null,
  notes           VARCHAR2(100),
  ext1            NUMBER(2),
  ext2            VARCHAR2(50),
  state           NUMBER(2),
  done_code       NUMBER(12),
  create_date     DATE,
  done_date       DATE,
  valid_date      DATE,
  expire_date     DATE,
  op_id           NUMBER(12),
  org_id          NUMBER(12),
  op_station_type NUMBER(2),
  organize_id     NUMBER(12)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SEC_ORGANIZE
prompt ===========================
prompt
create table AIGA.SEC_ORGANIZE
(
  organize_id          NUMBER(12) not null,
  org_role_type_id     NUMBER(12),
  organize_name        VARCHAR2(200) not null,
  code                 VARCHAR2(100),
  parent_organize_id   NUMBER(12),
  district_id          VARCHAR2(40) not null,
  short_name           VARCHAR2(200),
  english_name         VARCHAR2(200),
  member_num           NUMBER(6),
  manager_name         VARCHAR2(40),
  email                VARCHAR2(50),
  phone_id             VARCHAR2(50),
  fax_id               VARCHAR2(50),
  org_address          VARCHAR2(255),
  contact_name         VARCHAR2(100),
  contact_card_type    NUMBER(2),
  contact_card_id      VARCHAR2(40),
  contact_bill_id      VARCHAR2(50),
  postcode             NUMBER(6),
  post_province        NUMBER(12),
  post_city            NUMBER(12),
  post_address         VARCHAR2(255),
  post_postcod         NUMBER(6),
  county_id            NUMBER(12) not null,
  is_leaf              VARCHAR2(1),
  org_level            NUMBER(2),
  org_area_type        NUMBER(2),
  org_coop_type        NUMBER(2),
  is_channel           NUMBER(2),
  notes                VARCHAR2(255),
  state                NUMBER(2),
  done_code            NUMBER(12),
  create_date          DATE not null,
  done_date            DATE not null,
  valid_date           DATE,
  expire_date          DATE,
  org_id               NUMBER(12),
  op_id                NUMBER(12),
  ext1                 VARCHAR2(200),
  ext2                 VARCHAR2(200),
  ext3                 VARCHAR2(200),
  ext4                 VARCHAR2(200),
  ext5                 VARCHAR2(200),
  ext6                 VARCHAR2(200),
  owner_area           NUMBER(12),
  sub_org_role_type_id NUMBER(12)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SEC_ROLE
prompt =======================
prompt
create table AIGA.SEC_ROLE
(
  role_id     NUMBER(8) not null,
  role_name   VARCHAR2(60) not null,
  role_type   NUMBER(2) not null,
  domain_id   NUMBER(6) not null,
  notes       VARCHAR2(100),
  state       NUMBER(2),
  done_code   NUMBER(12),
  create_date DATE,
  done_date   DATE,
  valid_date  DATE,
  expire_date DATE,
  op_id       NUMBER(12),
  org_id      NUMBER(12),
  region_code VARCHAR2(100)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SEC_ROLE_GRANT
prompt =============================
prompt
create table AIGA.SEC_ROLE_GRANT
(
  role_grant_id   NUMBER(12) not null,
  role_id         NUMBER(12) not null,
  priv_id         NUMBER(12) not null,
  ent_id          NUMBER(12) not null,
  ent_type        CHAR(1),
  notes           VARCHAR2(100),
  state           NUMBER(2),
  done_code       NUMBER(12),
  create_date     DATE,
  done_date       DATE,
  valid_date      DATE,
  expire_date     DATE,
  op_id           NUMBER(12),
  org_id          NUMBER(12),
  lower_limit     FLOAT(12),
  upper_limit     FLOAT(12),
  ext1            VARCHAR2(40),
  ext2            VARCHAR2(40),
  ent_valid_date  DATE,
  ent_expire_date DATE
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SEC_STAFF
prompt ========================
prompt
create table AIGA.SEC_STAFF
(
  staff_id        NUMBER(12) not null,
  staff_name      VARCHAR2(200) not null,
  organize_id     NUMBER(12) not null,
  parent_staff_id NUMBER(12),
  short_name      VARCHAR2(200),
  english_name    VARCHAR2(200),
  card_type_id    NUMBER(2),
  card_no         VARCHAR2(40),
  birthday        DATE,
  marry_status    NUMBER(2),
  gender          NUMBER(2),
  religion        NUMBER(2),
  national_type   NUMBER(2),
  education_level NUMBER(2),
  income_level    NUMBER(16),
  politics_face   NUMBER(2),
  job_position    VARCHAR2(40),
  job_company     VARCHAR2(255),
  job_desc        VARCHAR2(200),
  home_tel        VARCHAR2(60),
  office_tel      VARCHAR2(60),
  bill_id         VARCHAR2(50),
  wireless_call   VARCHAR2(20),
  email           VARCHAR2(50),
  family_info     VARCHAR2(100),
  contact_address VARCHAR2(60),
  postcode        NUMBER(6),
  security_id     VARCHAR2(30),
  car_no          VARCHAR2(40),
  character_desc  VARCHAR2(100),
  alarm_bill_id   VARCHAR2(60),
  fax_id          VARCHAR2(60),
  staff_level     NUMBER(2),
  staff_type      NUMBER(2),
  bc_mgr          VARCHAR2(20),
  notes           VARCHAR2(255),
  state           NUMBER(2),
  done_code       NUMBER(12),
  create_date     DATE,
  done_date       DATE,
  valid_date      DATE,
  expire_date     DATE,
  op_id           NUMBER(12),
  org_id          NUMBER(12)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SEC_STATIC_DATA
prompt ==============================
prompt
create table AIGA.SEC_STATIC_DATA
(
  code_type     NUMBER(8) not null,
  code_id       NUMBER(12) not null,
  code_name     VARCHAR2(255) not null,
  code_name_nls VARCHAR2(255) not null,
  sort_id       NUMBER(3) not null,
  is_used       NUMBER(1) not null,
  extern_code   VARCHAR2(50) not null
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SEC_STATION
prompt ==========================
prompt
create table AIGA.SEC_STATION
(
  station_id        NUMBER(12) not null,
  parent_station_id NUMBER(12) not null,
  organize_id       NUMBER(12) not null,
  station_type_id   NUMBER(12),
  code              VARCHAR2(100),
  name              VARCHAR2(100) not null,
  work_desc         VARCHAR2(100),
  notes             VARCHAR2(100),
  state             NUMBER(2),
  done_code         NUMBER(12),
  create_date       DATE,
  done_date         DATE,
  valid_date        DATE,
  expire_date       DATE,
  op_id             NUMBER(12),
  org_id            NUMBER(12)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SOFTWARE_EDITION_REC_TEST_SLA
prompt ============================================
prompt
create table AIGA.SOFTWARE_EDITION_REC_TEST_SLA
(
  edition_id                 NUMBER(6) not null,
  online_time                VARCHAR2(20),
  demand_num                 VARCHAR2(20),
  development_task_num       VARCHAR2(20),
  test_task_num              VARCHAR2(20),
  report_time                VARCHAR2(20),
  unified_bil_data           VARCHAR2(1024),
  open_data_crm              VARCHAR2(1024),
  open_data_net              VARCHAR2(1024),
  bil_inter_crm              VARCHAR2(1024),
  bil_inter_user_mdb         VARCHAR2(1024),
  bil_inter_free_mdb         VARCHAR2(1024),
  bil_stop_re                VARCHAR2(1024),
  crm_huawei_inter           VARCHAR2(1024),
  acc_inter_crm              VARCHAR2(1024),
  acc_tt_crm                 VARCHAR2(1024),
  batch_inter_crm            VARCHAR2(1024),
  other_inter                VARCHAR2(1024),
  audit_type_reco            VARCHAR2(20),
  accuracy_rate              VARCHAR2(20),
  cutover_data_rate          VARCHAR2(20),
  cutover_function_test_rate VARCHAR2(20),
  cutover_perform_test_rate  VARCHAR2(20),
  bil_b_rec                  VARCHAR2(1024),
  acc_bil_rec                VARCHAR2(1024),
  rem_bil_rec                VARCHAR2(1024),
  rec_record_num             VARCHAR2(20),
  rea_sing_bil_rate          VARCHAR2(20),
  rea_cost_agree_rate        VARCHAR2(20),
  orig_sing_bil_rate         VARCHAR2(20),
  orig_cost_agree_rate       VARCHAR2(20),
  bare_user_num              VARCHAR2(20),
  bare_cost                  VARCHAR2(20),
  avg_user_cost              VARCHAR2(20),
  user_bare_cost             VARCHAR2(1024)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.edition_id
  is '编号';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.online_time
  is '版本上线时间';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.demand_num
  is '需求数量';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.development_task_num
  is '开发任务单数';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.test_task_num
  is '测试任务单数';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.report_time
  is '报告时间';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.unified_bil_data
  is '稽核类型  统一产品资费数据和计费资费数据稽核';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.open_data_crm
  is '开通数据和CRM稽核';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.open_data_net
  is '开通数据和网元稽核';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.bil_inter_crm
  is '计费接口和CRM稽核';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.bil_inter_user_mdb
  is '计费接口和用户MDB稽核';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.bil_inter_free_mdb
  is '计费接口和免费资源MDB稽核';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.bil_stop_re
  is '计费停复机下发批量稽核';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.crm_huawei_inter
  is 'CRM和华为短信接口稽核';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.acc_inter_crm
  is '账务接口和CRM稽核 ';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.acc_tt_crm
  is '账务TT数据和CRM稽核';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.batch_inter_crm
  is '批量处理进程稽核';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.other_inter
  is '其他接口稽核';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.audit_type_reco
  is '稽核总记录数';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.accuracy_rate
  is '数据稽核  准确率';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.cutover_data_rate
  is '割接数据稽核准确率';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.cutover_function_test_rate
  is '割接脚本功能测试通过率';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.cutover_perform_test_rate
  is '割接脚本性能测试通过率';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.bil_b_rec
  is '对账类型  计费话单对账';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.acc_bil_rec
  is '对账类型   账务账单对账';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.rem_bil_rec
  is '对账类型   酬金账单对账';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.rec_record_num
  is '对账记录数';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.rea_sing_bil_rate
  is '对账测试（剔除合理差异）  话单或账单一致率';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.rea_cost_agree_rate
  is '对账测试（剔除合理差异）  费用一致率';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.orig_sing_bil_rate
  is '对账测试（原始差异）  话单或账单一致率';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.orig_cost_agree_rate
  is '对账测试（原始差异）   费用一致率';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.bare_user_num
  is '对账裸差    裸差用户数';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.bare_cost
  is '对账裸差    裸差费用';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.avg_user_cost
  is '对账裸差     平均用户裸差费用';
comment on column AIGA.SOFTWARE_EDITION_REC_TEST_SLA.user_bare_cost
  is '用户裸差费用分档分布   (以分布图展现)';
alter table AIGA.SOFTWARE_EDITION_REC_TEST_SLA
  add primary key (EDITION_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SOFTWARE_EDITION_SLA
prompt ===================================
prompt
create table AIGA.SOFTWARE_EDITION_SLA
(
  edition_id                     NUMBER(6) not null,
  online_time                    VARCHAR2(20),
  demand_num                     VARCHAR2(20),
  development_task_num           VARCHAR2(20),
  test_task_num                  VARCHAR2(20),
  report_time                    VARCHAR2(20),
  total_defect_num               VARCHAR2(20),
  not_closed_defect_num          VARCHAR2(20),
  new_busin_rate                 VARCHAR2(20),
  project_rate                   VARCHAR2(20),
  performance_test_rate          VARCHAR2(20),
  end_test_rate                  VARCHAR2(20),
  debugging_test_rate            VARCHAR2(20),
  group_in_rate                  VARCHAR2(20),
  group_out_rate                 VARCHAR2(20),
  code_unresolved_problem        VARCHAR2(20),
  safety_unresolved_problem      VARCHAR2(20),
  test_unresolved_problem        VARCHAR2(20),
  new_busin_function_test        VARCHAR2(20),
  project_function_test          VARCHAR2(20),
  routine_function_regression    VARCHAR2(20),
  routine_performance_regression VARCHAR2(20),
  routine_end_regression         VARCHAR2(20),
  routine_interface_regression   VARCHAR2(20),
  prod_fire_open_sit             VARCHAR2(1024),
  prod_network_open_sit          VARCHAR2(1024),
  prod_app_open_sit              VARCHAR2(1024),
  prod_load_equ_con              VARCHAR2(1024),
  not_involve                    VARCHAR2(1024),
  be_opened                      VARCHAR2(1024),
  jur_config                     VARCHAR2(1024),
  number_config                  VARCHAR2(1024),
  products_config                VARCHAR2(1024),
  menu_config                    VARCHAR2(1024),
  system_configure_explain       VARCHAR2(1024),
  key_dev_file_rate              VARCHAR2(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SOFTWARE_EDITION_SLA.edition_id
  is '编号';
comment on column AIGA.SOFTWARE_EDITION_SLA.online_time
  is '版本上线时间';
comment on column AIGA.SOFTWARE_EDITION_SLA.demand_num
  is '需求数量 ';
comment on column AIGA.SOFTWARE_EDITION_SLA.development_task_num
  is '开发任务单数 ';
comment on column AIGA.SOFTWARE_EDITION_SLA.test_task_num
  is '测试任务单数 ';
comment on column AIGA.SOFTWARE_EDITION_SLA.report_time
  is '报告时间 ';
comment on column AIGA.SOFTWARE_EDITION_SLA.total_defect_num
  is '缺陷管理   总缺陷数 ';
comment on column AIGA.SOFTWARE_EDITION_SLA.not_closed_defect_num
  is '缺陷管理   未关闭缺陷数 ';
comment on column AIGA.SOFTWARE_EDITION_SLA.new_busin_rate
  is '功能测试   新业务通过率 ';
comment on column AIGA.SOFTWARE_EDITION_SLA.project_rate
  is '功能测试   项目通过率 ';
comment on column AIGA.SOFTWARE_EDITION_SLA.performance_test_rate
  is '性能测试   通过率 ';
comment on column AIGA.SOFTWARE_EDITION_SLA.end_test_rate
  is '端到端测试  通过率 ';
comment on column AIGA.SOFTWARE_EDITION_SLA.debugging_test_rate
  is '联调测试   通过率 ';
comment on column AIGA.SOFTWARE_EDITION_SLA.group_in_rate
  is '集团联调  对内通过率 ';
comment on column AIGA.SOFTWARE_EDITION_SLA.group_out_rate
  is '集团联调  对外通过率 ';
comment on column AIGA.SOFTWARE_EDITION_SLA.code_unresolved_problem
  is '代码扫描   未解决问题数 ';
comment on column AIGA.SOFTWARE_EDITION_SLA.safety_unresolved_problem
  is '安全扫描   未解决问题数 ';
comment on column AIGA.SOFTWARE_EDITION_SLA.test_unresolved_problem
  is '高可用测试  未解决问题数 ';
comment on column AIGA.SOFTWARE_EDITION_SLA.new_busin_function_test
  is '准发布测试通过率   新业务功能测试 ';
comment on column AIGA.SOFTWARE_EDITION_SLA.project_function_test
  is '准发布测试通过率   项目功能测试 ';
comment on column AIGA.SOFTWARE_EDITION_SLA.routine_function_regression
  is '准发布测试通过率    例行功能回归 ';
comment on column AIGA.SOFTWARE_EDITION_SLA.routine_performance_regression
  is '准发布测试通过率    例行性能回归 ';
comment on column AIGA.SOFTWARE_EDITION_SLA.routine_end_regression
  is '准发布测试通过率    例行端到端回归 ';
comment on column AIGA.SOFTWARE_EDITION_SLA.routine_interface_regression
  is '准发布测试通过率    例行接口稽核回归 ';
comment on column AIGA.SOFTWARE_EDITION_SLA.prod_fire_open_sit
  is '基础环境配置类型    生产防火墙开通情况 ';
comment on column AIGA.SOFTWARE_EDITION_SLA.prod_network_open_sit
  is '基础环境配置类型    生产网络开通情况 ';
comment on column AIGA.SOFTWARE_EDITION_SLA.prod_app_open_sit
  is '基础环境配置类型    生产应用环境变量调整情况 ';
comment on column AIGA.SOFTWARE_EDITION_SLA.prod_load_equ_con
  is '基础环境配置类型    生产负载均衡配置 ';
comment on column AIGA.SOFTWARE_EDITION_SLA.not_involve
  is '基础环境配置类型     不涉及';
comment on column AIGA.SOFTWARE_EDITION_SLA.be_opened
  is '基础环境配置说明     待开通（需说明开通要求）';
comment on column AIGA.SOFTWARE_EDITION_SLA.jur_config
  is '系统运营配置类型     权限配置';
comment on column AIGA.SOFTWARE_EDITION_SLA.number_config
  is '系统运营配置类型      账号配置';
comment on column AIGA.SOFTWARE_EDITION_SLA.products_config
  is '系统运营配置类型      产品配置';
comment on column AIGA.SOFTWARE_EDITION_SLA.menu_config
  is '系统运营配置类型      菜单配置';
comment on column AIGA.SOFTWARE_EDITION_SLA.system_configure_explain
  is '系统运营配置说明';
comment on column AIGA.SOFTWARE_EDITION_SLA.key_dev_file_rate
  is '关键开发文档完备率';
alter table AIGA.SOFTWARE_EDITION_SLA
  add primary key (EDITION_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table STAT_AUTO_COVER
prompt ==============================
prompt
create table AIGA.STAT_AUTO_COVER
(
  stat_id                    NUMBER(20) not null,
  report_month               VARCHAR2(255),
  system_name                VARCHAR2(1024),
  function_point             VARCHAR2(128),
  manual_case                VARCHAR2(128),
  auto_function_point        VARCHAR2(128),
  auto_case                  VARCHAR2(128),
  unrealizable_auto_case     VARCHAR2(128),
  unrealized_auto_case       VARCHAR2(128),
  kernal_function_point      VARCHAR2(128),
  kernal_regress_case        VARCHAR2(128),
  kernal_auto_case           VARCHAR2(128),
  kernal_unrealizable_case   VARCHAR2(128),
  kernal_unrealized_case     VARCHAR2(128),
  kernal_function_cover      VARCHAR2(128),
  kernal_auto_function_cover VARCHAR2(128),
  kernal_regress_auto_cover  VARCHAR2(128),
  auto_function_cover        VARCHAR2(128),
  auto_case_cover            VARCHAR2(128),
  kernal_auto_function       VARCHAR2(128)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.STAT_AUTO_COVER.stat_id
  is '统计ID';
comment on column AIGA.STAT_AUTO_COVER.report_month
  is '月份';
comment on column AIGA.STAT_AUTO_COVER.system_name
  is '系统';
comment on column AIGA.STAT_AUTO_COVER.function_point
  is '总功能点数';
comment on column AIGA.STAT_AUTO_COVER.manual_case
  is '总手工用例数
';
comment on column AIGA.STAT_AUTO_COVER.auto_function_point
  is '总自动化功能点数
';
comment on column AIGA.STAT_AUTO_COVER.auto_case
  is '总自动化用例数
';
comment on column AIGA.STAT_AUTO_COVER.unrealizable_auto_case
  is '不可实现自动化用例数
';
comment on column AIGA.STAT_AUTO_COVER.unrealized_auto_case
  is '未实现自动化用例数
';
comment on column AIGA.STAT_AUTO_COVER.kernal_function_point
  is '核心功能点数
';
comment on column AIGA.STAT_AUTO_COVER.kernal_regress_case
  is '核心回归用例
';
comment on column AIGA.STAT_AUTO_COVER.kernal_auto_case
  is '核心回归用例自动化数
';
comment on column AIGA.STAT_AUTO_COVER.kernal_unrealizable_case
  is '核心回归用例不可实现自动化用例数
';
comment on column AIGA.STAT_AUTO_COVER.kernal_unrealized_case
  is '核心回归用例未实现自动化用例数
';
comment on column AIGA.STAT_AUTO_COVER.kernal_function_cover
  is '核心功能点覆盖率
';
comment on column AIGA.STAT_AUTO_COVER.kernal_auto_function_cover
  is '核心功能点自动化覆盖率
';
comment on column AIGA.STAT_AUTO_COVER.kernal_regress_auto_cover
  is '核心回归用例自动化覆盖率
';
comment on column AIGA.STAT_AUTO_COVER.auto_function_cover
  is '自动化功能覆盖率';
comment on column AIGA.STAT_AUTO_COVER.auto_case_cover
  is '自动化用例覆盖率';
comment on column AIGA.STAT_AUTO_COVER.kernal_auto_function
  is '核心功能点自动化数
';
alter table AIGA.STAT_AUTO_COVER
  add primary key (STAT_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table STAT_CONSTANTS
prompt =============================
prompt
create table AIGA.STAT_CONSTANTS
(
  constant_id     NUMBER(20) not null,
  class_path      VARCHAR2(200),
  property_name   VARCHAR2(200),
  property_class  VARCHAR2(200),
  property_show   VARCHAR2(200),
  memo            VARCHAR2(200),
  author          VARCHAR2(200),
  remark          VARCHAR2(200),
  other1          VARCHAR2(200),
  other2          VARCHAR2(200),
  property_status VARCHAR2(200),
  parent_id       NUMBER(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.STAT_CONSTANTS.constant_id
  is 'id';
comment on column AIGA.STAT_CONSTANTS.class_path
  is '类的路径';
comment on column AIGA.STAT_CONSTANTS.property_name
  is '属性名称';
comment on column AIGA.STAT_CONSTANTS.property_class
  is '属性类型';
comment on column AIGA.STAT_CONSTANTS.property_show
  is '显示的中文名';
comment on column AIGA.STAT_CONSTANTS.property_status
  is '类型';
alter table AIGA.STAT_CONSTANTS
  add constraint STAT_CONSTANTS$PRIMARY primary key (CONSTANT_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table STAT_GRID
prompt ========================
prompt
create table AIGA.STAT_GRID
(
  id             NUMBER(20) not null,
  grid_id        VARCHAR2(200),
  title          VARCHAR2(200),
  width          VARCHAR2(200),
  height         VARCHAR2(200),
  forct_fit      VARCHAR2(200),
  stripe_rows    VARCHAR2(200),
  load_mask      VARCHAR2(200),
  tbar           VARCHAR2(200),
  class_path     VARCHAR2(200),
  remark         VARCHAR2(200),
  grid_proxy_url VARCHAR2(200),
  edit_plugins   VARCHAR2(20) default 'true',
  bbar           VARCHAR2(200)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.STAT_GRID.grid_id
  is 'grid_id';
comment on column AIGA.STAT_GRID.class_path
  is '对于的列';
comment on column AIGA.STAT_GRID.remark
  is '备注';
comment on column AIGA.STAT_GRID.grid_proxy_url
  is 'url';
comment on column AIGA.STAT_GRID.edit_plugins
  is '编辑插件';
alter table AIGA.STAT_GRID
  add constraint STAT_GRID$PRIMARY primary key (ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table STAT_GRID_COLUMNS
prompt ================================
prompt
create table AIGA.STAT_GRID_COLUMNS
(
  column_id           NUMBER(20) not null,
  header              VARCHAR2(200) default '未指定',
  hidden              VARCHAR2(200) default 'false',
  width               NUMBER(20) default 100,
  align               VARCHAR2(200) default 'center',
  sortable            VARCHAR2(200) default 'true',
  data_index          VARCHAR2(200),
  grid_type           VARCHAR2(200),
  parent_id           NUMBER(20) default 0,
  stat_class_constant VARCHAR2(200),
  column_index        NUMBER(20),
  grid_id             NUMBER(20),
  label_width         VARCHAR2(200) default '80',
  xtype               VARCHAR2(200) default 'textfield',
  label_align         VARCHAR2(200) default 'right',
  field_label         VARCHAR2(200),
  tbar_show           VARCHAR2(20) default 'false',
  is_edit             VARCHAR2(20) default 'true'
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.STAT_GRID_COLUMNS.grid_id
  is '关联grid_id';
alter table AIGA.STAT_GRID_COLUMNS
  add constraint STAT_GRID_COLUMNS$PRIMARY primary key (COLUMN_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table STAT_KPI_1ST
prompt ===========================
prompt
create table AIGA.STAT_KPI_1ST
(
  stat_id                       NUMBER(20) not null,
  report_month                  VARCHAR2(20),
  create_time                   DATE default sysdate,
  version_publish_num           VARCHAR2(255),
  version_task_num              VARCHAR2(255),
  version_req_num               VARCHAR2(255),
  quality_dev_problem_num       VARCHAR2(255),
  quality_publish_error_num     VARCHAR2(255),
  quality_terrible_precent      VARCHAR2(255),
  quality_publish_error_precent VARCHAR2(255),
  busi_dev_person_num           VARCHAR2(255),
  busi_project_person_num       VARCHAR2(255),
  dev_publish_est_work          VARCHAR2(255),
  dev_period_from_create        VARCHAR2(255),
  dev_period_from_confirm       VARCHAR2(255),
  dev_period_from_distribute    VARCHAR2(255)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table STAT_KPI_TARGET
prompt ==============================
prompt
create table AIGA.STAT_KPI_TARGET
(
  kpi_id                NUMBER(20) not null,
  target_attention      VARCHAR2(200),
  kpi_name              VARCHAR2(200),
  kpi_define            VARCHAR2(4000),
  computational_formula VARCHAR2(4000),
  target_unit           VARCHAR2(20),
  standard_value        VARCHAR2(20),
  target_provide_time   VARCHAR2(50),
  target_department     VARCHAR2(50),
  statistics_cycle_time VARCHAR2(100),
  remark                VARCHAR2(4000),
  change_time           VARCHAR2(500),
  change_staff_name     VARCHAR2(20),
  change_staff_id       VARCHAR2(20),
  change_reason         VARCHAR2(200),
  kpi_status            VARCHAR2(10),
  kpi_type              VARCHAR2(10),
  kpi_his_status        VARCHAR2(10),
  kpi_uuid              VARCHAR2(200),
  target_type           VARCHAR2(10)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.STAT_KPI_TARGET.kpi_id
  is '';
comment on column AIGA.STAT_KPI_TARGET.target_attention
  is '指标关注';
comment on column AIGA.STAT_KPI_TARGET.kpi_name
  is 'KPI名称';
comment on column AIGA.STAT_KPI_TARGET.kpi_define
  is 'KPI定义';
comment on column AIGA.STAT_KPI_TARGET.computational_formula
  is '计算公式';
comment on column AIGA.STAT_KPI_TARGET.target_unit
  is '指标单位';
comment on column AIGA.STAT_KPI_TARGET.standard_value
  is '达标值';
comment on column AIGA.STAT_KPI_TARGET.target_provide_time
  is '指标提供时间';
comment on column AIGA.STAT_KPI_TARGET.target_department
  is '指标负责部门';
comment on column AIGA.STAT_KPI_TARGET.statistics_cycle_time
  is '统计周期';
comment on column AIGA.STAT_KPI_TARGET.remark
  is '备注';
comment on column AIGA.STAT_KPI_TARGET.change_time
  is '修改时间';
comment on column AIGA.STAT_KPI_TARGET.change_staff_name
  is '修改人';
comment on column AIGA.STAT_KPI_TARGET.change_staff_id
  is '修改人';
comment on column AIGA.STAT_KPI_TARGET.change_reason
  is '修改原因';
comment on column AIGA.STAT_KPI_TARGET.kpi_status
  is 'KPI状态';
comment on column AIGA.STAT_KPI_TARGET.kpi_type
  is '衡量类型(1.衡量过程，2.衡量交付,3.衡量结果)';
comment on column AIGA.STAT_KPI_TARGET.kpi_his_status
  is '历史状态记录';
comment on column AIGA.STAT_KPI_TARGET.kpi_uuid
  is 'KPI UUID';
comment on column AIGA.STAT_KPI_TARGET.target_type
  is '指标类型(1.质量，2.效率，3.容量)';
alter table AIGA.STAT_KPI_TARGET
  add constraint STAT_KPI_TARGET$PRIMARY primary key (KPI_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table STAT_MONTH_DEV_GROUP_KPI
prompt =======================================
prompt
create table AIGA.STAT_MONTH_DEV_GROUP_KPI
(
  stat_id                    NUMBER(20) not null,
  group_id                   NUMBER(20),
  group_name                 VARCHAR2(1024),
  group_admin                VARCHAR2(1024),
  report_month               VARCHAR2(200),
  publish_error_percent      VARCHAR2(20),
  dev_bug_density            VARCHAR2(20),
  dev_req_bug_density        VARCHAR2(20),
  dev_design_bug_density     VARCHAR2(20),
  dev_dev_bug_density        VARCHAR2(20),
  task_bug_percent           VARCHAR2(20),
  unit_test_pass             VARCHAR2(20),
  double_task_percent        VARCHAR2(20),
  distribute_to_publish_time VARCHAR2(20),
  code_commit_timely_percent VARCHAR2(20),
  bug_fix_timely_percent     VARCHAR2(20),
  dev_work_load_percent      VARCHAR2(20),
  est_workover               VARCHAR2(20),
  dev_workover               VARCHAR2(20),
  dev_person_num             VARCHAR2(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.STAT_MONTH_DEV_GROUP_KPI.stat_id
  is '统计ID';
comment on column AIGA.STAT_MONTH_DEV_GROUP_KPI.group_id
  is '组ID';
comment on column AIGA.STAT_MONTH_DEV_GROUP_KPI.group_name
  is '组名';
comment on column AIGA.STAT_MONTH_DEV_GROUP_KPI.group_admin
  is '负责人';
comment on column AIGA.STAT_MONTH_DEV_GROUP_KPI.report_month
  is '月份';
comment on column AIGA.STAT_MONTH_DEV_GROUP_KPI.publish_error_percent
  is '上线故障率';
comment on column AIGA.STAT_MONTH_DEV_GROUP_KPI.dev_bug_density
  is '综合缺陷密度';
comment on column AIGA.STAT_MONTH_DEV_GROUP_KPI.dev_req_bug_density
  is '需求缺陷密度';
comment on column AIGA.STAT_MONTH_DEV_GROUP_KPI.dev_design_bug_density
  is '设计缺陷密度';
comment on column AIGA.STAT_MONTH_DEV_GROUP_KPI.dev_dev_bug_density
  is '开发缺陷密度';
comment on column AIGA.STAT_MONTH_DEV_GROUP_KPI.task_bug_percent
  is '任务单BUG率';
comment on column AIGA.STAT_MONTH_DEV_GROUP_KPI.unit_test_pass
  is '单元测试抽检合格率';
comment on column AIGA.STAT_MONTH_DEV_GROUP_KPI.double_task_percent
  is '二次开单率';
comment on column AIGA.STAT_MONTH_DEV_GROUP_KPI.distribute_to_publish_time
  is '需求分派到需求上线时间';
comment on column AIGA.STAT_MONTH_DEV_GROUP_KPI.code_commit_timely_percent
  is '代码提交及时率';
comment on column AIGA.STAT_MONTH_DEV_GROUP_KPI.bug_fix_timely_percent
  is 'BUG修复及时率';
comment on column AIGA.STAT_MONTH_DEV_GROUP_KPI.dev_work_load_percent
  is '工作负荷程度';
comment on column AIGA.STAT_MONTH_DEV_GROUP_KPI.est_workover
  is '上线版本预估容量';
comment on column AIGA.STAT_MONTH_DEV_GROUP_KPI.dev_workover
  is '开发周期工作容量';
comment on column AIGA.STAT_MONTH_DEV_GROUP_KPI.dev_person_num
  is '开发人员';
alter table AIGA.STAT_MONTH_DEV_GROUP_KPI
  add primary key (STAT_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table STAT_MONTH_ONE_LEVEL_KPI
prompt =======================================
prompt
create table AIGA.STAT_MONTH_ONE_LEVEL_KPI
(
  stat_id                       NUMBER(20) not null,
  report_month                  VARCHAR2(20),
  create_time                   DATE default sysdate,
  version_publish_num           NUMBER(10),
  version_task_num              NUMBER(10),
  version_req_num               NUMBER(10),
  quality_dev_problem_num       NUMBER(10),
  quality_publish_error_num     NUMBER(10),
  quality_terrible_precent      NUMBER(5,2),
  quality_publish_error_precent NUMBER(5,2),
  busi_dev_person_num           NUMBER(10),
  busi_project_person_num       NUMBER(10),
  dev_publish_est_work          NUMBER(10),
  dev_period_from_create        NUMBER(10,2),
  dev_period_from_confirm       NUMBER(10,2),
  dev_period_from_distribute    NUMBER(10,2)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.STAT_MONTH_ONE_LEVEL_KPI.stat_id
  is '统计ID';
comment on column AIGA.STAT_MONTH_ONE_LEVEL_KPI.report_month
  is '月份';
comment on column AIGA.STAT_MONTH_ONE_LEVEL_KPI.create_time
  is '创建时间';
comment on column AIGA.STAT_MONTH_ONE_LEVEL_KPI.version_publish_num
  is '版本发布上线次数';
comment on column AIGA.STAT_MONTH_ONE_LEVEL_KPI.version_task_num
  is '版本发布任务单数';
comment on column AIGA.STAT_MONTH_ONE_LEVEL_KPI.version_req_num
  is '版本发布软件需求数';
comment on column AIGA.STAT_MONTH_ONE_LEVEL_KPI.quality_dev_problem_num
  is '质量指标开发故障次数';
comment on column AIGA.STAT_MONTH_ONE_LEVEL_KPI.quality_publish_error_num
  is '质量指标上线异常事件次数';
comment on column AIGA.STAT_MONTH_ONE_LEVEL_KPI.quality_terrible_precent
  is '质量指标严重故障率';
comment on column AIGA.STAT_MONTH_ONE_LEVEL_KPI.quality_publish_error_precent
  is '质量指标上线故障率';
comment on column AIGA.STAT_MONTH_ONE_LEVEL_KPI.busi_dev_person_num
  is '上线新业务开发人员';
comment on column AIGA.STAT_MONTH_ONE_LEVEL_KPI.busi_project_person_num
  is '上线项目开发人员';
comment on column AIGA.STAT_MONTH_ONE_LEVEL_KPI.dev_publish_est_work
  is '上线版本预估容量';
comment on column AIGA.STAT_MONTH_ONE_LEVEL_KPI.dev_period_from_create
  is '需求开发周期创建到上线天数';
comment on column AIGA.STAT_MONTH_ONE_LEVEL_KPI.dev_period_from_confirm
  is '需求开发周期提出到上线天数';
comment on column AIGA.STAT_MONTH_ONE_LEVEL_KPI.dev_period_from_distribute
  is '需求开发周期提交到上线天数';
alter table AIGA.STAT_MONTH_ONE_LEVEL_KPI
  add primary key (STAT_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table STAT_MONTH_TEST_GROUP_KPI
prompt ========================================
prompt
create table AIGA.STAT_MONTH_TEST_GROUP_KPI
(
  stat_id             NUMBER(20) not null,
  report_month        VARCHAR2(20),
  group_id            NUMBER(20),
  group_name          VARCHAR2(1024),
  group_admin         VARCHAR2(1024),
  bug_left_percent    VARCHAR2(20),
  bug_unvalid_percent VARCHAR2(20),
  case_bug_percent    VARCHAR2(20),
  test_timely_percent VARCHAR2(20),
  test_check_timely   VARCHAR2(20),
  case_p_avg_num      VARCHAR2(20),
  work_load           VARCHAR2(20),
  work_over           VARCHAR2(20),
  tester_num          VARCHAR2(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.STAT_MONTH_TEST_GROUP_KPI.stat_id
  is '统计ID';
comment on column AIGA.STAT_MONTH_TEST_GROUP_KPI.report_month
  is '月份';
comment on column AIGA.STAT_MONTH_TEST_GROUP_KPI.group_id
  is '组ID';
comment on column AIGA.STAT_MONTH_TEST_GROUP_KPI.group_name
  is '组名称';
comment on column AIGA.STAT_MONTH_TEST_GROUP_KPI.group_admin
  is '负责人';
comment on column AIGA.STAT_MONTH_TEST_GROUP_KPI.bug_left_percent
  is '测试缺陷遗漏率';
comment on column AIGA.STAT_MONTH_TEST_GROUP_KPI.bug_unvalid_percent
  is '无效缺陷率';
comment on column AIGA.STAT_MONTH_TEST_GROUP_KPI.case_bug_percent
  is '测试用例BUG率';
comment on column AIGA.STAT_MONTH_TEST_GROUP_KPI.test_timely_percent
  is '测试及时率';
comment on column AIGA.STAT_MONTH_TEST_GROUP_KPI.test_check_timely
  is '测试BUG验证及时率';
comment on column AIGA.STAT_MONTH_TEST_GROUP_KPI.case_p_avg_num
  is '人均测试用例数';
comment on column AIGA.STAT_MONTH_TEST_GROUP_KPI.work_load
  is '工作负荷程度';
comment on column AIGA.STAT_MONTH_TEST_GROUP_KPI.work_over
  is '测试版本预估';
comment on column AIGA.STAT_MONTH_TEST_GROUP_KPI.tester_num
  is '测试人员';
alter table AIGA.STAT_MONTH_TEST_GROUP_KPI
  add primary key (STAT_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table STAT_MONTH_TWO_L_CAPACITY_KPI
prompt ============================================
prompt
create table AIGA.STAT_MONTH_TWO_L_CAPACITY_KPI
(
  stat_id              NUMBER(20) not null,
  report_month         VARCHAR2(20),
  req_anlysis_avg_num  VARCHAR2(20),
  req_person_num       VARCHAR2(20),
  dev_work_load_value  VARCHAR2(20),
  dev_publish_est_work VARCHAR2(20),
  dev_person_num       VARCHAR2(20),
  test_work_load_value VARCHAR2(20),
  test_case_avg        VARCHAR2(20),
  test_person_num      VARCHAR2(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.STAT_MONTH_TWO_L_CAPACITY_KPI.stat_id
  is '统计ID';
comment on column AIGA.STAT_MONTH_TWO_L_CAPACITY_KPI.report_month
  is '月份';
comment on column AIGA.STAT_MONTH_TWO_L_CAPACITY_KPI.req_anlysis_avg_num
  is '人均需求分析数';
comment on column AIGA.STAT_MONTH_TWO_L_CAPACITY_KPI.req_person_num
  is '需求人员数';
comment on column AIGA.STAT_MONTH_TWO_L_CAPACITY_KPI.dev_work_load_value
  is '开发工作负荷度';
comment on column AIGA.STAT_MONTH_TWO_L_CAPACITY_KPI.dev_publish_est_work
  is '上线版本预估容量';
comment on column AIGA.STAT_MONTH_TWO_L_CAPACITY_KPI.dev_person_num
  is '开发人数';
comment on column AIGA.STAT_MONTH_TWO_L_CAPACITY_KPI.test_work_load_value
  is '测试工作负荷度';
comment on column AIGA.STAT_MONTH_TWO_L_CAPACITY_KPI.test_case_avg
  is '人均测试用例数';
comment on column AIGA.STAT_MONTH_TWO_L_CAPACITY_KPI.test_person_num
  is '测试人员';
alter table AIGA.STAT_MONTH_TWO_L_CAPACITY_KPI
  add primary key (STAT_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table STAT_MONTH_TWO_L_EFF_KPI
prompt =======================================
prompt
create table AIGA.STAT_MONTH_TWO_L_EFF_KPI
(
  stat_id                     NUMBER(20) not null,
  report_month                VARCHAR2(20),
  req_period_from_submit      VARCHAR2(20),
  req_period_from_confirm     VARCHAR2(20),
  req_period_from_distribute  VARCHAR2(20),
  plan_succ_percent           VARCHAR2(20),
  plan_change_percent         VARCHAR2(20),
  plan_emergy_publish_percent VARCHAR2(20),
  req_anlysis_timely_percent  VARCHAR2(20),
  dev_code_timely_percent     VARCHAR2(20),
  dev_bug_timely_percent      VARCHAR2(20),
  test_test_timely_percent    VARCHAR2(20),
  test_bug_timely_percent     VARCHAR2(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.STAT_MONTH_TWO_L_EFF_KPI.stat_id
  is '统计ID';
comment on column AIGA.STAT_MONTH_TWO_L_EFF_KPI.report_month
  is '月份';
comment on column AIGA.STAT_MONTH_TWO_L_EFF_KPI.req_period_from_submit
  is '需求实现周期从需求提出到上线';
comment on column AIGA.STAT_MONTH_TWO_L_EFF_KPI.req_period_from_confirm
  is '需求实现周期从需求确认到上线';
comment on column AIGA.STAT_MONTH_TWO_L_EFF_KPI.req_period_from_distribute
  is '需求实现周期从需求分派到上线';
comment on column AIGA.STAT_MONTH_TWO_L_EFF_KPI.plan_succ_percent
  is '计划准确率';
comment on column AIGA.STAT_MONTH_TWO_L_EFF_KPI.plan_change_percent
  is '计划变更率';
comment on column AIGA.STAT_MONTH_TWO_L_EFF_KPI.plan_emergy_publish_percent
  is '紧急上线率';
comment on column AIGA.STAT_MONTH_TWO_L_EFF_KPI.req_anlysis_timely_percent
  is '需求分析及时率';
comment on column AIGA.STAT_MONTH_TWO_L_EFF_KPI.dev_code_timely_percent
  is '代码提交及时率';
comment on column AIGA.STAT_MONTH_TWO_L_EFF_KPI.dev_bug_timely_percent
  is 'BUG修复及时率';
comment on column AIGA.STAT_MONTH_TWO_L_EFF_KPI.test_test_timely_percent
  is '测试及时率';
comment on column AIGA.STAT_MONTH_TWO_L_EFF_KPI.test_bug_timely_percent
  is 'BUG验证及时率';
alter table AIGA.STAT_MONTH_TWO_L_EFF_KPI
  add primary key (STAT_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table STAT_MONTH_TWO_L_QUALITY_KPI
prompt ===========================================
prompt
create table AIGA.STAT_MONTH_TWO_L_QUALITY_KPI
(
  stat_id                  NUMBER(20) not null,
  report_month             VARCHAR2(20),
  publish_error_percent    VARCHAR2(20),
  dev_bug_density          VARCHAR2(20),
  dev_req_bug_density      VARCHAR2(20),
  dev_design_bug_density   VARCHAR2(20),
  dev_dev_bug_density      VARCHAR2(20),
  dev_double_dev_percent   VARCHAR2(20),
  dev_task_bug_percent     VARCHAR2(20),
  dev_unit_test_percent    VARCHAR2(20),
  test_bug_leave_percent   VARCHAR2(20),
  test_bug_unvalid_percent VARCHAR2(20),
  test_bug_valid_percent   VARCHAR2(20)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.STAT_MONTH_TWO_L_QUALITY_KPI.stat_id
  is '统计ID';
comment on column AIGA.STAT_MONTH_TWO_L_QUALITY_KPI.report_month
  is '月份';
comment on column AIGA.STAT_MONTH_TWO_L_QUALITY_KPI.publish_error_percent
  is '上线故障率';
comment on column AIGA.STAT_MONTH_TWO_L_QUALITY_KPI.dev_bug_density
  is '综合缺陷密度';
comment on column AIGA.STAT_MONTH_TWO_L_QUALITY_KPI.dev_req_bug_density
  is '需求缺陷密度';
comment on column AIGA.STAT_MONTH_TWO_L_QUALITY_KPI.dev_design_bug_density
  is '设计缺陷密度';
comment on column AIGA.STAT_MONTH_TWO_L_QUALITY_KPI.dev_dev_bug_density
  is '开发缺陷密度';
comment on column AIGA.STAT_MONTH_TWO_L_QUALITY_KPI.dev_double_dev_percent
  is '二次开发率';
comment on column AIGA.STAT_MONTH_TWO_L_QUALITY_KPI.dev_task_bug_percent
  is '任务单BUG率';
comment on column AIGA.STAT_MONTH_TWO_L_QUALITY_KPI.dev_unit_test_percent
  is '单元测试抽检合格率';
comment on column AIGA.STAT_MONTH_TWO_L_QUALITY_KPI.test_bug_leave_percent
  is '测试缺陷遗漏率';
comment on column AIGA.STAT_MONTH_TWO_L_QUALITY_KPI.test_bug_unvalid_percent
  is '无效缺陷率';
comment on column AIGA.STAT_MONTH_TWO_L_QUALITY_KPI.test_bug_valid_percent
  is '测试用例有效性';
alter table AIGA.STAT_MONTH_TWO_L_QUALITY_KPI
  add primary key (STAT_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table STAT_SLA_NORM_I
prompt ==============================
prompt
create table AIGA.STAT_SLA_NORM_I
(
  stat_id                      NUMBER(20) not null,
  plan_id                      NUMBER(20),
  report_time                  DATE,
  req_num                      NUMBER(10),
  test_task_num                NUMBER(10),
  dev_task_num                 NUMBER(10),
  create_time                  DATE default sysdate,
  bug_sum                      NUMBER(10),
  bug_unclosed                 NUMBER(10),
  func_busi_pass_precent       NUMBER(5,2),
  func_project_pass_precent    NUMBER(5,2),
  perform_pass_precent         NUMBER(5,2),
  end_to_end_pass_precent      NUMBER(5,2),
  combined_test_pass_precent   NUMBER(5,2),
  group_in_pass_precent        NUMBER(5,2),
  group_out_pass_precent       NUMBER(5,2),
  code_scan_problem_num        NUMBER(10),
  safe_scan_problem_num        NUMBER(10),
  usable_problem_num           NUMBER(10),
  publish_busi_pass_precent    NUMBER(5,2),
  publish_project_pass_precent NUMBER(5,2),
  publish_func_pass_precent    NUMBER(5,2),
  publish_perform_pass_precent NUMBER(5,2),
  publish_ete_pass_precent     NUMBER(5,2),
  publish_inter_pass_precent   NUMBER(5,2)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.STAT_SLA_NORM_I.stat_id
  is '统计ID';
comment on column AIGA.STAT_SLA_NORM_I.plan_id
  is '计划ID';
comment on column AIGA.STAT_SLA_NORM_I.report_time
  is '报告时间';
comment on column AIGA.STAT_SLA_NORM_I.req_num
  is '需求数量';
comment on column AIGA.STAT_SLA_NORM_I.test_task_num
  is '测试任务数量';
comment on column AIGA.STAT_SLA_NORM_I.dev_task_num
  is '开发任务数量';
comment on column AIGA.STAT_SLA_NORM_I.create_time
  is '创建时间';
comment on column AIGA.STAT_SLA_NORM_I.bug_sum
  is '缺陷总数';
comment on column AIGA.STAT_SLA_NORM_I.bug_unclosed
  is '未关闭的缺陷数量';
comment on column AIGA.STAT_SLA_NORM_I.func_busi_pass_precent
  is '功能测试新业务通过率';
comment on column AIGA.STAT_SLA_NORM_I.func_project_pass_precent
  is '功能测试项目通过率';
comment on column AIGA.STAT_SLA_NORM_I.perform_pass_precent
  is '性能测试通过率';
comment on column AIGA.STAT_SLA_NORM_I.end_to_end_pass_precent
  is '端对端通过率';
comment on column AIGA.STAT_SLA_NORM_I.combined_test_pass_precent
  is '联调测试通过率';
comment on column AIGA.STAT_SLA_NORM_I.group_in_pass_precent
  is '集团联调对内通过率';
comment on column AIGA.STAT_SLA_NORM_I.group_out_pass_precent
  is '集团联调对外通过率';
comment on column AIGA.STAT_SLA_NORM_I.code_scan_problem_num
  is '代码扫描未解决问题数';
comment on column AIGA.STAT_SLA_NORM_I.safe_scan_problem_num
  is '安全扫描未解决问题数';
comment on column AIGA.STAT_SLA_NORM_I.usable_problem_num
  is '高可用测试未解决问题数';
comment on column AIGA.STAT_SLA_NORM_I.publish_busi_pass_precent
  is '准发布环境新业务能测试通过率';
comment on column AIGA.STAT_SLA_NORM_I.publish_project_pass_precent
  is '准发布环境项目测试通过率';
comment on column AIGA.STAT_SLA_NORM_I.publish_func_pass_precent
  is '准发布环例行性功能回归通过率';
comment on column AIGA.STAT_SLA_NORM_I.publish_perform_pass_precent
  is '准发布环境例行性能测试通过率';
comment on column AIGA.STAT_SLA_NORM_I.publish_ete_pass_precent
  is '准发布环境例行端对端回归通过率';
comment on column AIGA.STAT_SLA_NORM_I.publish_inter_pass_precent
  is '准发布环境例行接口集合回归通过率';
alter table AIGA.STAT_SLA_NORM_I
  add primary key (STAT_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table STAT_SLA_NORM_II
prompt ===============================
prompt
create table AIGA.STAT_SLA_NORM_II
(
  stat_id                NUMBER(20) not null,
  plan_id                NUMBER(20),
  req_num                NUMBER(10),
  dev_task_num           NUMBER(10),
  test_task_num          NUMBER(10),
  create_time            DATE,
  data_type_list         VARCHAR2(2048),
  data_record_sum        NUMBER(10),
  data_right_rate        NUMBER(8,2),
  delivery_succ_rate     NUMBER(8,2),
  delivery_test_rate     NUMBER(8,2),
  delivery_perform_rate  NUMBER(8,2),
  check_type_list        VARCHAR2(2048),
  check_record           NUMBER(8,2),
  check_t_call_same_rate NUMBER(8,2),
  check_t_fee_same_rate  NUMBER(8,2),
  check_o_call_same_rate NUMBER(8,2),
  check_o_fee_same_rate  NUMBER(8,2),
  check_l_user_num       NUMBER(10),
  check_l_fee            NUMBER(8,2),
  check_a_u_fee          NUMBER(8,2)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.STAT_SLA_NORM_II.stat_id
  is '统计ID';
comment on column AIGA.STAT_SLA_NORM_II.plan_id
  is '计划ID';
comment on column AIGA.STAT_SLA_NORM_II.req_num
  is '需求数量';
comment on column AIGA.STAT_SLA_NORM_II.dev_task_num
  is '开发任务单数';
comment on column AIGA.STAT_SLA_NORM_II.test_task_num
  is '测试任务单数';
comment on column AIGA.STAT_SLA_NORM_II.create_time
  is '报告时间';
comment on column AIGA.STAT_SLA_NORM_II.data_type_list
  is '数据稽核类型';
comment on column AIGA.STAT_SLA_NORM_II.data_record_sum
  is '数据稽核总记录数';
comment on column AIGA.STAT_SLA_NORM_II.data_right_rate
  is '数据稽核准确率';
comment on column AIGA.STAT_SLA_NORM_II.delivery_succ_rate
  is '割接数据稽核准确率';
comment on column AIGA.STAT_SLA_NORM_II.delivery_test_rate
  is '割接脚本功能测试通过率';
comment on column AIGA.STAT_SLA_NORM_II.delivery_perform_rate
  is '割接脚本性能测试通过率';
comment on column AIGA.STAT_SLA_NORM_II.check_type_list
  is '对账类型';
comment on column AIGA.STAT_SLA_NORM_II.check_record
  is '对账记录数';
comment on column AIGA.STAT_SLA_NORM_II.check_t_call_same_rate
  is '剔除差异话单或账单一致率';
comment on column AIGA.STAT_SLA_NORM_II.check_t_fee_same_rate
  is '剔除差异费用一致率';
comment on column AIGA.STAT_SLA_NORM_II.check_o_call_same_rate
  is '原始话单或账单一致率';
comment on column AIGA.STAT_SLA_NORM_II.check_o_fee_same_rate
  is '原始费用一致率';
comment on column AIGA.STAT_SLA_NORM_II.check_l_user_num
  is '裸差用户数';
comment on column AIGA.STAT_SLA_NORM_II.check_l_fee
  is '裸差费用';
comment on column AIGA.STAT_SLA_NORM_II.check_a_u_fee
  is '平均用户裸差费用';
alter table AIGA.STAT_SLA_NORM_II
  add primary key (STAT_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table STAT_TABLE_MEMO
prompt ==============================
prompt
create table AIGA.STAT_TABLE_MEMO
(
  memo_id    NUMBER(20),
  table_name VARCHAR2(128),
  col_name   VARCHAR2(128),
  line_id    VARCHAR2(128),
  memo       VARCHAR2(2048)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table STAT_TEST_D_QUALITY
prompt ==================================
prompt
create table AIGA.STAT_TEST_D_QUALITY
(
  stat_id               NUMBER(20) not null,
  summary               VARCHAR2(2048),
  priority              VARCHAR2(1024),
  if_resolve            VARCHAR2(1024),
  dev_name              VARCHAR2(1024),
  report_name           VARCHAR2(1024),
  create_time           DATE,
  modify_time           DATE,
  module_name           VARCHAR2(1024),
  code_review_result    VARCHAR2(1024),
  reg_test_req_a_num    NUMBER(10),
  test_case_problem     VARCHAR2(2048),
  req_a_problem         NUMBER(10),
  test_a_num            NUMBER(10),
  test_a_function       NUMBER(10),
  dev_logic_num         NUMBER(10),
  test_req_same_num     NUMBER(10),
  test_problem_desc     VARCHAR2(2048),
  test_struct_num       NUMBER(10),
  req_test_same_num     NUMBER(10),
  test_audit_result     VARCHAR2(1024),
  req_a_case_num        NUMBER(10),
  req_a_problem_desc    VARCHAR2(1024),
  req_a_data_type_num   NUMBER(10),
  dev_d_function_num    NUMBER(10),
  test_case_problem_num NUMBER(10),
  req_a_problem_desc2   VARCHAR2(2048),
  req_a_logic_num       NUMBER(10),
  test_expect_case_num  NUMBER(10),
  req_a_audit_result    VARCHAR2(1024)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.STAT_TEST_D_QUALITY
  add primary key (STAT_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_ATTACH
prompt =========================
prompt
create table AIGA.SYS_ATTACH
(
  sys_attach_id      NUMBER(12) not null,
  sys_busi_type_code VARCHAR2(200),
  busi_sheet_id      VARCHAR2(20),
  name               VARCHAR2(200),
  file_name          VARCHAR2(200),
  remarks            VARCHAR2(400)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_ATTACH.busi_sheet_id
  is '??????';
comment on column AIGA.SYS_ATTACH.name
  is '????';
comment on column AIGA.SYS_ATTACH.file_name
  is '???';
comment on column AIGA.SYS_ATTACH.remarks
  is '??';

prompt
prompt Creating table SYS_AUTHOR
prompt =========================
prompt
create table AIGA.SYS_AUTHOR
(
  author_id          NUMBER(12) not null,
  station_id         NUMBER(12) not null,
  staff_id           NUMBER(12),
  is_author          CHAR(1),
  is_real_operation  CHAR(1),
  author_type        CHAR(1),
  role_author_id     NUMBER(12),
  parent_author_id   NUMBER(12),
  author_valid_date  DATE,
  author_expire_date DATE,
  notes              VARCHAR2(100),
  state              NUMBER(2),
  done_code          NUMBER(12),
  create_date        DATE,
  done_date          DATE,
  valid_date         DATE,
  expire_date        DATE,
  op_id              NUMBER(12),
  org_id             NUMBER(12)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 896K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_AUTHOR.is_author
  is '????????????????????????????????????????????
';
comment on column AIGA.SYS_AUTHOR.is_real_operation
  is '?????????????????????????????????????????';
comment on column AIGA.SYS_AUTHOR.author_type
  is 'A-???????B???????role_id???Id?C??????AUTHOR_STAFF_ID????ID';
comment on column AIGA.SYS_AUTHOR.state
  is '??
??';
comment on column AIGA.SYS_AUTHOR.done_code
  is '????????';
comment on column AIGA.SYS_AUTHOR.done_date
  is '????????';
comment on column AIGA.SYS_AUTHOR.valid_date
  is '??????';
comment on column AIGA.SYS_AUTHOR.expire_date
  is '??????';

prompt
prompt Creating table SYS_CONSTANT
prompt ===========================
prompt
create table AIGA.SYS_CONSTANT
(
  constant_id   NUMBER(20) not null,
  category_name VARCHAR2(256),
  category      VARCHAR2(256) not null,
  show          VARCHAR2(256),
  value         NUMBER(11) not null,
  other1        VARCHAR2(256),
  other2        VARCHAR2(256),
  memo          VARCHAR2(1025),
  author        VARCHAR2(100),
  remark        VARCHAR2(1025),
  escape_show   VARCHAR2(100),
  escape_field  VARCHAR2(100),
  first_spell   VARCHAR2(100),
  full_spelling VARCHAR2(200),
  status        NUMBER(10) default 0
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_CONSTANT.first_spell
  is '首字母拼音（未填写的话，系统会自动添加，故此处填写特殊情况，比如多音字即可）';
comment on column AIGA.SYS_CONSTANT.full_spelling
  is '全拼（未填写的话，系统会自动添加，故此处填写特殊情况，比如多音字即可）';
comment on column AIGA.SYS_CONSTANT.status
  is '0 可用 1不可用';
create index AIGA.SYS_C_CATE_INX on AIGA.SYS_CONSTANT (CATEGORY)
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.SYS_CONSTANT
  add primary key (CATEGORY, CONSTANT_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_DIRECTORY
prompt ============================
prompt
create table AIGA.SYS_DIRECTORY
(
  dir_id      NUMBER(12) not null,
  name        VARCHAR2(100),
  parent_id   NUMBER(12),
  state       NUMBER(2),
  create_date DATE,
  done_date   DATE,
  done_code   NUMBER(12),
  valid_date  DATE,
  expire_date DATE,
  op_id       NUMBER(12),
  org_id      NUMBER(12),
  ext1        VARCHAR2(100),
  ext3        NUMBER(12),
  ext4        NUMBER(12),
  ext2        VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table AIGA.SYS_DIRECTORY
  is '????MO??????????';
comment on column AIGA.SYS_DIRECTORY.done_code
  is '????????';

prompt
prompt Creating table SYS_EMPLOYEE
prompt ===========================
prompt
create table AIGA.SYS_EMPLOYEE
(
  employee_id     NUMBER(12) not null,
  employee_name   VARCHAR2(200) not null,
  short_name      VARCHAR2(200),
  english_name    VARCHAR2(200),
  card_type_id    NUMBER(2),
  card_no         VARCHAR2(40),
  birthday        DATE,
  marry_status    NUMBER(2),
  gender          NUMBER(2),
  religion        NUMBER(2),
  national_type   NUMBER(2),
  education_level NUMBER(2),
  income_level    NUMBER(16),
  politics_face   NUMBER(2),
  job_position    VARCHAR2(40),
  job_company     VARCHAR2(255),
  job_desc        VARCHAR2(200),
  home_tel        VARCHAR2(60),
  office_tel      VARCHAR2(60),
  bill_id         VARCHAR2(50),
  wireless_call   VARCHAR2(20),
  email           VARCHAR2(50),
  family_info     VARCHAR2(100),
  contact_address VARCHAR2(60),
  postcode        NUMBER(6),
  security_id     VARCHAR2(30),
  car_no          VARCHAR2(40),
  character_desc  VARCHAR2(100),
  alarm_bill_id   VARCHAR2(60),
  fax_id          VARCHAR2(60),
  notes           VARCHAR2(255),
  state           NUMBER(2),
  done_code       NUMBER(12),
  create_date     DATE,
  done_date       DATE,
  valid_date      DATE,
  expire_date     DATE,
  org_id          NUMBER(12),
  op_id           NUMBER(12),
  ext1            VARCHAR2(20),
  ext2            VARCHAR2(20),
  ext3            VARCHAR2(20)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_EMPLOYEE.employee_id
  is '???????????????????????sys_oper_u??oper_id';
comment on column AIGA.SYS_EMPLOYEE.employee_name
  is '???????????????????????????????????????????????????????????';
comment on column AIGA.SYS_EMPLOYEE.fax_id
  is '???';
comment on column AIGA.SYS_EMPLOYEE.state
  is '1 ??';
comment on column AIGA.SYS_EMPLOYEE.done_code
  is '????????';
comment on column AIGA.SYS_EMPLOYEE.done_date
  is '????????';
comment on column AIGA.SYS_EMPLOYEE.valid_date
  is '?????';
comment on column AIGA.SYS_EMPLOYEE.expire_date
  is '?????';
alter table AIGA.SYS_EMPLOYEE
  add constraint PK_EMPLOYEE primary key (EMPLOYEE_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_FUNCTION
prompt ===========================
prompt
create table AIGA.SYS_FUNCTION
(
  func_id     NUMBER(12) not null,
  func_code   VARCHAR2(80),
  name        VARCHAR2(80) not null,
  notes       VARCHAR2(100),
  parent_id   NUMBER(12),
  func_level  NUMBER(2),
  fun_seq     NUMBER(3),
  viewname    VARCHAR2(1000),
  dll_path    VARCHAR2(1000),
  func_img    VARCHAR2(1000),
  func_arg    VARCHAR2(1000),
  func_type   CHAR(1),
  state       NUMBER(2),
  done_code   NUMBER(12),
  create_date DATE,
  done_date   DATE,
  valid_date  DATE,
  expire_date DATE,
  op_id       NUMBER(12),
  org_id      NUMBER(12)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_FUNCTION.func_type
  is 'H-html??C-?????';
comment on column AIGA.SYS_FUNCTION.state
  is '??
??';
comment on column AIGA.SYS_FUNCTION.done_code
  is '????????';
comment on column AIGA.SYS_FUNCTION.done_date
  is '????????';
comment on column AIGA.SYS_FUNCTION.valid_date
  is '??????';
comment on column AIGA.SYS_FUNCTION.expire_date
  is '??????';

prompt
prompt Creating table SYS_ID_GENERATOR
prompt ===============================
prompt
create table AIGA.SYS_ID_GENERATOR
(
  table_name             VARCHAR2(100) not null,
  domain_id              NUMBER(6),
  generator_type         CHAR(1) not null,
  sequence_name          VARCHAR2(60),
  max_id                 NUMBER(12),
  start_value            NUMBER(12),
  min_value              NUMBER(12),
  max_value              NUMBER(12),
  increment_value        NUMBER(6),
  cycle_flag             CHAR(1),
  cache_size             NUMBER,
  sequence_create_script VARCHAR2(1000),
  his_table_name         VARCHAR2(100),
  his_sequence_name      VARCHAR2(60),
  his_data_flag          CHAR(1),
  his_max_id             NUMBER(12),
  his_donecode_flag      CHAR(1),
  skip_type              NUMBER(1),
  deal_class             VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table AIGA.SYS_ID_GENERATOR
  is '???????';
comment on column AIGA.SYS_ID_GENERATOR.table_name
  is '????';
comment on column AIGA.SYS_ID_GENERATOR.generator_type
  is 'M-???,S-???';
comment on column AIGA.SYS_ID_GENERATOR.sequence_name
  is '?????';
comment on column AIGA.SYS_ID_GENERATOR.max_id
  is '???';
comment on column AIGA.SYS_ID_GENERATOR.start_value
  is '???';
comment on column AIGA.SYS_ID_GENERATOR.min_value
  is '???';
comment on column AIGA.SYS_ID_GENERATOR.max_value
  is '???';
comment on column AIGA.SYS_ID_GENERATOR.increment_value
  is '????';
comment on column AIGA.SYS_ID_GENERATOR.cycle_flag
  is 'Y-??N-???';
comment on column AIGA.SYS_ID_GENERATOR.cache_size
  is '????';
comment on column AIGA.SYS_ID_GENERATOR.sequence_create_script
  is 'SEQUENCE????';

prompt
prompt Creating table SYS_LOGIN_LOG
prompt ============================
prompt
create table AIGA.SYS_LOGIN_LOG
(
  log_id      NUMBER(12) not null,
  session_id  VARCHAR2(100),
  staff_code  VARCHAR2(20),
  ip          VARCHAR2(20),
  mac         VARCHAR2(25),
  login_date  DATE,
  logout_date DATE,
  state       NUMBER(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 6M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table AIGA.SYS_LOGIN_LOG
  is '????';
comment on column AIGA.SYS_LOGIN_LOG.log_id
  is '????';
comment on column AIGA.SYS_LOGIN_LOG.session_id
  is 'SESSION??';
comment on column AIGA.SYS_LOGIN_LOG.staff_code
  is '???';
comment on column AIGA.SYS_LOGIN_LOG.ip
  is 'IP??';
comment on column AIGA.SYS_LOGIN_LOG.mac
  is 'MAC??';
comment on column AIGA.SYS_LOGIN_LOG.login_date
  is '????';
comment on column AIGA.SYS_LOGIN_LOG.logout_date
  is '????';
comment on column AIGA.SYS_LOGIN_LOG.state
  is '1 ???
0 ??';

prompt
prompt Creating table SYS_MO
prompt =====================
prompt
create table AIGA.SYS_MO
(
  mo_id         NUMBER(12) not null,
  name          VARCHAR2(100),
  dir_id        NUMBER(12),
  dir_full_name VARCHAR2(100),
  mo_type       VARCHAR2(20),
  remarks       VARCHAR2(400),
  state         NUMBER(2),
  create_date   DATE,
  done_date     DATE,
  done_code     NUMBER(12),
  valid_date    DATE,
  expire_date   DATE,
  op_id         NUMBER(12),
  org_id        NUMBER(12),
  ext1          VARCHAR2(100),
  ext3          NUMBER(12),
  ext4          NUMBER(12),
  ext2          VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_MO.done_code
  is '????????';

prompt
prompt Creating table SYS_MO_ATTR
prompt ==========================
prompt
create table AIGA.SYS_MO_ATTR
(
  attr_id     NUMBER(12) not null,
  mo_id       NUMBER(12),
  title       VARCHAR2(100),
  attr_type   VARCHAR2(20),
  remarks     VARCHAR2(400),
  state       NUMBER(2),
  create_date DATE,
  done_date   DATE,
  done_code   NUMBER(12),
  valid_date  DATE,
  expire_date DATE,
  op_id       NUMBER(12),
  org_id      NUMBER(12),
  ext1        VARCHAR2(100),
  ext3        NUMBER(12),
  ext4        NUMBER(12),
  ext2        VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_MO_ATTR.done_code
  is '????????';

prompt
prompt Creating table SYS_MO_OP
prompt ========================
prompt
create table AIGA.SYS_MO_OP
(
  operate_id  NUMBER(12) not null,
  mo_id       NUMBER(12),
  func_id     NUMBER(12),
  name        VARCHAR2(100),
  is_query    VARCHAR2(2),
  title       VARCHAR2(100),
  state       NUMBER(2),
  create_date DATE,
  done_date   DATE,
  done_code   NUMBER(12),
  valid_date  DATE,
  expire_date DATE,
  op_id       NUMBER(12),
  org_id      NUMBER(12),
  ext1        VARCHAR2(100),
  ext3        NUMBER(12),
  ext4        NUMBER(12),
  ext2        VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_MO_OP.done_code
  is '????????';

prompt
prompt Creating table SYS_OPERATE_LOG
prompt ==============================
prompt
create table AIGA.SYS_OPERATE_LOG
(
  operate_log_id   NUMBER(12) not null,
  content          VARCHAR2(1000),
  operate_type     NUMBER(1),
  done_date        DATE,
  org_id           NUMBER(12),
  op_id            NUMBER(12),
  table_name_op    VARCHAR2(50),
  record_id        VARCHAR2(50),
  clum_id          VARCHAR2(50),
  h_table_name_op  VARCHAR2(50),
  order_id         NUMBER(20),
  func_parent_type VARCHAR2(10),
  func_child_type  VARCHAR2(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 5M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_OPERATE_LOG.content
  is '????';
comment on column AIGA.SYS_OPERATE_LOG.operate_type
  is '1 ??,2 ??,3 ??';
comment on column AIGA.SYS_OPERATE_LOG.done_date
  is '????????';
comment on column AIGA.SYS_OPERATE_LOG.func_parent_type
  is '1 ???? 2 ????
3 ????
4 ??????';

prompt
prompt Creating table SYS_ORGANIZE
prompt ===========================
prompt
create table AIGA.SYS_ORGANIZE
(
  organize_id        NUMBER(12) not null,
  parent_organize_id NUMBER(12),
  organize_name      VARCHAR2(200) not null,
  code               VARCHAR2(100),
  org_role_type_id   NUMBER(6),
  district_id        VARCHAR2(40),
  short_name         VARCHAR2(200),
  english_name       VARCHAR2(200),
  member_num         NUMBER(6),
  manager_name       VARCHAR2(40),
  email              VARCHAR2(50),
  phone_id           VARCHAR2(50),
  fax_id             VARCHAR2(50),
  org_address        VARCHAR2(255),
  contact_name       VARCHAR2(100),
  contact_card_type  NUMBER(2),
  contact_card_id    VARCHAR2(40),
  contact_bill_id    VARCHAR2(50),
  postcode           NUMBER(6),
  post_province      NUMBER(12),
  post_city          NUMBER(12),
  post_address       VARCHAR2(255),
  post_postcod       NUMBER(6),
  notes              VARCHAR2(255),
  state              NUMBER(2),
  done_code          NUMBER(12),
  create_date        DATE,
  done_date          DATE,
  valid_date         DATE,
  expire_date        DATE,
  op_id              NUMBER(12),
  org_id             NUMBER(12),
  old_code           VARCHAR2(30),
  old_parent_code    VARCHAR2(30),
  county_id          NUMBER(12),
  ext1               VARCHAR2(40),
  ext2               VARCHAR2(40),
  ext3               VARCHAR2(40),
  is_leaf            VARCHAR2(1)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_ORGANIZE.organize_name
  is '????????????????????????????????????????????????????????????';
comment on column AIGA.SYS_ORGANIZE.district_id
  is '????';
comment on column AIGA.SYS_ORGANIZE.state
  is '1 ??';
comment on column AIGA.SYS_ORGANIZE.done_code
  is '????????';
comment on column AIGA.SYS_ORGANIZE.done_date
  is '????????';
comment on column AIGA.SYS_ORGANIZE.valid_date
  is '??????';
comment on column AIGA.SYS_ORGANIZE.expire_date
  is '??????';
comment on column AIGA.SYS_ORGANIZE.county_id
  is '????';
alter table AIGA.SYS_ORGANIZE
  add constraint PK_ORGANIZE primary key (ORGANIZE_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_ORG_DISTRICT_RELATE
prompt ======================================
prompt
create table AIGA.SYS_ORG_DISTRICT_RELATE
(
  org_district_relate_id NUMBER(8) not null,
  organize_id            NUMBER(12) not null,
  district_id            NUMBER(12) not null,
  done_code              NUMBER(12),
  create_date            DATE,
  done_date              DATE,
  valid_date             DATE,
  expire_date            DATE,
  op_id                  NUMBER(12),
  org_id                 NUMBER(12),
  state                  NUMBER(1)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_ORG_DISTRICT_RELATE.done_code
  is '????????';
comment on column AIGA.SYS_ORG_DISTRICT_RELATE.done_date
  is '????????';
comment on column AIGA.SYS_ORG_DISTRICT_RELATE.valid_date
  is '??????';
comment on column AIGA.SYS_ORG_DISTRICT_RELATE.expire_date
  is '??????';
alter table AIGA.SYS_ORG_DISTRICT_RELATE
  add constraint PK_ORG_DISTRICT_RELA primary key (ORG_DISTRICT_RELATE_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.SYS_ORG_DISTRICT_RELATE
  add constraint UQ_ORG_DISTRICT_RELA unique (ORGANIZE_ID, DISTRICT_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_ORG_ROLE_TYPE
prompt ================================
prompt
create table AIGA.SYS_ORG_ROLE_TYPE
(
  org_role_type_id   NUMBER(6) not null,
  org_role_type_name VARCHAR2(100) not null,
  code               VARCHAR2(20) not null,
  state              NUMBER(2),
  notes              VARCHAR2(255),
  ext1               VARCHAR2(100),
  ext2               VARCHAR2(100),
  ext3               NUMBER(12),
  ext4               NUMBER(12),
  parent_type_id     NUMBER(6)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_ORG_ROLE_TYPE.state
  is '1 ??';
alter table AIGA.SYS_ORG_ROLE_TYPE
  add constraint PK_ORG_ROLE_TYPE primary key (ORG_ROLE_TYPE_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_PERMISSION
prompt =============================
prompt
create table AIGA.SYS_PERMISSION
(
  permission_id    NUMBER(10) not null,
  staff_id         NUMBER(12),
  station_id       NUMBER(12),
  station_type_id  NUMBER(12),
  mo_id            NUMBER(12),
  operator_name    VARCHAR2(50),
  propertys        VARCHAR2(1000),
  modify_peopertys VARCHAR2(1000),
  extend_object    VARCHAR2(1000),
  condition        VARCHAR2(2000),
  state            NUMBER(2),
  done_code        NUMBER(12),
  create_date      DATE,
  done_date        DATE,
  valid_date       DATE,
  expire_date      DATE,
  op_id            NUMBER(12),
  org_id           NUMBER(12),
  ext1             VARCHAR2(100),
  ext2             VARCHAR2(100),
  ext3             NUMBER(12),
  ext4             NUMBER(12),
  ext5             NUMBER(12,2),
  ext6             NUMBER(12,2)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table AIGA.SYS_PERMISSION
  is 'PERMISSION';
comment on column AIGA.SYS_PERMISSION.staff_id
  is '?????????';
comment on column AIGA.SYS_PERMISSION.operator_name
  is '?????????';
comment on column AIGA.SYS_PERMISSION.state
  is '??
??';
comment on column AIGA.SYS_PERMISSION.done_code
  is '????????';
comment on column AIGA.SYS_PERMISSION.done_date
  is '????????';
comment on column AIGA.SYS_PERMISSION.valid_date
  is '??????';
comment on column AIGA.SYS_PERMISSION.expire_date
  is '?????';

prompt
prompt Creating table SYS_ROLE
prompt =======================
prompt
create table AIGA.SYS_ROLE
(
  role_id     NUMBER(12) not null,
  code        VARCHAR2(40),
  name        VARCHAR2(60) not null,
  notes       VARCHAR2(100),
  state       NUMBER(2),
  done_code   NUMBER(12),
  create_date DATE,
  done_date   DATE,
  valid_date  DATE,
  expire_date DATE,
  op_id       NUMBER(12),
  org_id      NUMBER(12)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_ROLE.role_id
  is '????';
comment on column AIGA.SYS_ROLE.code
  is '??';
comment on column AIGA.SYS_ROLE.name
  is '??';
comment on column AIGA.SYS_ROLE.notes
  is '??';
comment on column AIGA.SYS_ROLE.state
  is '??
??';
comment on column AIGA.SYS_ROLE.done_code
  is '????????';
comment on column AIGA.SYS_ROLE.done_date
  is '???????';
comment on column AIGA.SYS_ROLE.valid_date
  is '?????';
comment on column AIGA.SYS_ROLE.expire_date
  is '??????';
alter table AIGA.SYS_ROLE
  add constraint PK_ROLE primary key (ROLE_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_ROLE_STATIONTYPE
prompt ===================================
prompt
create table AIGA.SYS_ROLE_STATIONTYPE
(
  role_stationtype_relat_id NUMBER(12) not null,
  role_id                   NUMBER(12),
  station_type_id           NUMBER(12),
  is_author                 CHAR(1),
  is_real_operation         CHAR(1),
  notes                     VARCHAR2(100),
  state                     NUMBER(2),
  done_code                 NUMBER(12),
  create_date               DATE,
  done_date                 DATE,
  valid_date                DATE,
  expire_date               DATE,
  op_id                     NUMBER(12),
  org_id                    NUMBER(12)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_ROLE_STATIONTYPE.role_id
  is '????';
comment on column AIGA.SYS_ROLE_STATIONTYPE.is_real_operation
  is '?????????????????????????????????????????';
comment on column AIGA.SYS_ROLE_STATIONTYPE.state
  is '??
??';
comment on column AIGA.SYS_ROLE_STATIONTYPE.done_code
  is '???????';
comment on column AIGA.SYS_ROLE_STATIONTYPE.done_date
  is '????????';
comment on column AIGA.SYS_ROLE_STATIONTYPE.valid_date
  is '?????';
comment on column AIGA.SYS_ROLE_STATIONTYPE.expire_date
  is '??????';
alter table AIGA.SYS_ROLE_STATIONTYPE
  add constraint PK_ROLE_STATIONTYPE primary key (ROLE_STATIONTYPE_RELAT_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_STAFF
prompt ========================
prompt
create table AIGA.SYS_STAFF
(
  staff_id              NUMBER(12) not null,
  code                  VARCHAR2(20),
  password              VARCHAR2(48),
  recent_password       VARCHAR2(300),
  recent_pass_times     NUMBER(2),
  min_passwd_length     NUMBER(2),
  allow_change_password CHAR(1),
  acct_effect_date      DATE,
  acct_expire_date      DATE,
  multi_login_flag      CHAR(1),
  last_login_log_id     NUMBER(12),
  try_times             NUMBER(3),
  lock_flag             CHAR(1),
  is_login              CHAR(1),
  is_super_user         CHAR(1),
  notes                 VARCHAR2(400),
  passwd_valid_days     NUMBER(10),
  cancel_days           NUMBER(3),
  password_valid_date   DATE,
  chg_passwd_alarm_days NUMBER(10),
  done_code             NUMBER(12),
  create_date           DATE,
  done_date             DATE,
  valid_date            DATE,
  expire_date           DATE,
  org_id                NUMBER(12),
  op_id                 NUMBER(12),
  state                 NUMBER(2),
  old_code              VARCHAR2(20),
  op_type               NUMBER(3),
  ext1                  VARCHAR2(40),
  ext2                  VARCHAR2(40),
  ext3                  VARCHAR2(40),
  op_lvl                NUMBER(3),
  band_type             NUMBER(3),
  employee_id           NUMBER(12)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on table AIGA.SYS_STAFF
  is '????????????????';
comment on column AIGA.SYS_STAFF.staff_id
  is '???????????????????????sys_oper_u??oper_id';
comment on column AIGA.SYS_STAFF.passwd_valid_days
  is '?????';
comment on column AIGA.SYS_STAFF.cancel_days
  is '??????
?????????????????????????????????????????????????????????????';
comment on column AIGA.SYS_STAFF.done_code
  is '????????';
comment on column AIGA.SYS_STAFF.done_date
  is '????????';
comment on column AIGA.SYS_STAFF.valid_date
  is '????';
comment on column AIGA.SYS_STAFF.expire_date
  is '??????';
comment on column AIGA.SYS_STAFF.op_type
  is '???? ?????????';
comment on column AIGA.SYS_STAFF.ext1
  is '????1';
comment on column AIGA.SYS_STAFF.ext2
  is '????2';
comment on column AIGA.SYS_STAFF.ext3
  is '????3';
comment on column AIGA.SYS_STAFF.op_lvl
  is '???? ??? ?????';
comment on column AIGA.SYS_STAFF.band_type
  is '????IP,MAC????';
alter table AIGA.SYS_STAFF
  add constraint PK_STAFF primary key (STAFF_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_STAFF_IPMAC_BAND
prompt ===================================
prompt
create table AIGA.SYS_STAFF_IPMAC_BAND
(
  sys_staff_ipmac_band_id NUMBER(12) not null,
  staff_id                NUMBER(12),
  mac                     VARCHAR2(30),
  ip                      VARCHAR2(30),
  band_type               NUMBER(2),
  state                   NUMBER(2),
  done_code               NUMBER(12),
  create_date             DATE,
  done_date               DATE,
  valid_date              DATE,
  expire_date             DATE,
  org_id                  NUMBER(12),
  op_id                   NUMBER(12)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_STAFF_IPMAC_BAND.sys_staff_ipmac_band_id
  is '??';
comment on column AIGA.SYS_STAFF_IPMAC_BAND.band_type
  is '0 ???
1 ??IP
2 ??MAC
3 ????';
comment on column AIGA.SYS_STAFF_IPMAC_BAND.state
  is '0 ??
1??';
comment on column AIGA.SYS_STAFF_IPMAC_BAND.done_code
  is '????????';
comment on column AIGA.SYS_STAFF_IPMAC_BAND.done_date
  is '????????';
comment on column AIGA.SYS_STAFF_IPMAC_BAND.valid_date
  is '?????';
comment on column AIGA.SYS_STAFF_IPMAC_BAND.expire_date
  is '?????';
alter table AIGA.SYS_STAFF_IPMAC_BAND
  add constraint PK_STAFF_IPMAC primary key (SYS_STAFF_IPMAC_BAND_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_STAFF_MANAGER_RELAT
prompt ======================================
prompt
create table AIGA.SYS_STAFF_MANAGER_RELAT
(
  staff_manager_relat_id NUMBER(12) not null,
  staff_id               NUMBER(12) not null,
  staff_name             VARCHAR2(32) not null,
  sys_tag                NUMBER(12) not null,
  req_type               VARCHAR2(2),
  config_dscr            VARCHAR2(100)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_STAFF_MANAGER_RELAT.staff_manager_relat_id
  is '主键';
comment on column AIGA.SYS_STAFF_MANAGER_RELAT.staff_id
  is '人员ID';
comment on column AIGA.SYS_STAFF_MANAGER_RELAT.staff_name
  is '人员名称';
comment on column AIGA.SYS_STAFF_MANAGER_RELAT.sys_tag
  is '所属系统';
comment on column AIGA.SYS_STAFF_MANAGER_RELAT.req_type
  is '需求类型';
comment on column AIGA.SYS_STAFF_MANAGER_RELAT.config_dscr
  is '配置描述';
alter table AIGA.SYS_STAFF_MANAGER_RELAT
  add constraint PK_SMR primary key (STAFF_MANAGER_RELAT_ID)
  using index 
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_STAFF_ORG_RELAT
prompt ==================================
prompt
create table AIGA.SYS_STAFF_ORG_RELAT
(
  staff_org_relat_id NUMBER(12) not null,
  organize_id        NUMBER(12),
  staff_id           NUMBER(12),
  is_admin_staff     CHAR(1),
  is_base_org        CHAR(1),
  state              NUMBER(2),
  notes              VARCHAR2(255),
  done_code          NUMBER(12),
  create_date        DATE,
  done_date          DATE,
  valid_date         DATE,
  expire_date        DATE,
  op_id              NUMBER(12),
  org_id             NUMBER(12)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_STAFF_ORG_RELAT.staff_id
  is '???????????????????????sys_oper_u??oper_id';
comment on column AIGA.SYS_STAFF_ORG_RELAT.state
  is '1 ??';
comment on column AIGA.SYS_STAFF_ORG_RELAT.done_code
  is '????????';
comment on column AIGA.SYS_STAFF_ORG_RELAT.done_date
  is '???????';
comment on column AIGA.SYS_STAFF_ORG_RELAT.valid_date
  is '??????';
comment on column AIGA.SYS_STAFF_ORG_RELAT.expire_date
  is '?????';
alter table AIGA.SYS_STAFF_ORG_RELAT
  add constraint PK_STAFF_ORG primary key (STAFF_ORG_RELAT_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_STAFF_PARAM
prompt ==============================
prompt
create table AIGA.SYS_STAFF_PARAM
(
  staff_id       NUMBER(12) not null,
  param_key      VARCHAR2(1024),
  param_value    VARCHAR2(1024),
  param_category VARCHAR2(1024),
  param_explain  VARCHAR2(1024),
  ext1           VARCHAR2(1024),
  ext2           VARCHAR2(1024),
  ext3           VARCHAR2(1024)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_STAFF_PARAM.staff_id
  is '角色id';
comment on column AIGA.SYS_STAFF_PARAM.param_key
  is 'key';
comment on column AIGA.SYS_STAFF_PARAM.param_value
  is 'value';
comment on column AIGA.SYS_STAFF_PARAM.param_category
  is '种类';
comment on column AIGA.SYS_STAFF_PARAM.param_explain
  is '说明';
comment on column AIGA.SYS_STAFF_PARAM.ext1
  is '扩展1';
comment on column AIGA.SYS_STAFF_PARAM.ext2
  is '扩展2';
comment on column AIGA.SYS_STAFF_PARAM.ext3
  is '扩展3';

prompt
prompt Creating table SYS_STAFF_ROLE_AUTHOR
prompt ====================================
prompt
create table AIGA.SYS_STAFF_ROLE_AUTHOR
(
  role_author_id     NUMBER(12) not null,
  role_id            NUMBER(12),
  staff_id           NUMBER(12),
  organize_id        NUMBER(12),
  author_valid_date  DATE,
  author_expire_date DATE,
  notes              VARCHAR2(100),
  state              NUMBER(2),
  done_code          NUMBER(12),
  create_date        DATE,
  done_date          DATE,
  valid_date         DATE,
  expire_date        DATE,
  op_id              NUMBER(12),
  org_id             NUMBER(12)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_STAFF_ROLE_AUTHOR.role_id
  is '????';
comment on column AIGA.SYS_STAFF_ROLE_AUTHOR.state
  is '??
??';
comment on column AIGA.SYS_STAFF_ROLE_AUTHOR.done_code
  is '????????';
comment on column AIGA.SYS_STAFF_ROLE_AUTHOR.done_date
  is '????????';
comment on column AIGA.SYS_STAFF_ROLE_AUTHOR.valid_date
  is '?????';
comment on column AIGA.SYS_STAFF_ROLE_AUTHOR.expire_date
  is '??????';
create index AIGA.INX_STAFF_AND_ROLE on AIGA.SYS_STAFF_ROLE_AUTHOR (ROLE_ID, STAFF_ID)
  tablespace AIGA_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AIGA.SYS_STAFF_ROLE_AUTHOR
  add constraint PK_STAFF_ROLE_AUTHOR primary key (ROLE_AUTHOR_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_STAFF_VERIFY_CODE
prompt ====================================
prompt
create table AIGA.SYS_STAFF_VERIFY_CODE
(
  verify_id     NUMBER(12) not null,
  verify_code   NUMBER(6),
  valid_start   DATE,
  valid_end     DATE,
  rela_staff_id NUMBER(12)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_STAFF_VERIFY_CODE.verify_id
  is '??';
comment on column AIGA.SYS_STAFF_VERIFY_CODE.verify_code
  is '???';
comment on column AIGA.SYS_STAFF_VERIFY_CODE.valid_start
  is '??????';
comment on column AIGA.SYS_STAFF_VERIFY_CODE.valid_end
  is '??????';
comment on column AIGA.SYS_STAFF_VERIFY_CODE.rela_staff_id
  is '????ID';
alter table AIGA.SYS_STAFF_VERIFY_CODE
  add constraint PK_STAFF_VERIFY primary key (VERIFY_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_STATIC_DATA
prompt ==============================
prompt
create table AIGA.SYS_STATIC_DATA
(
  code_type     NUMBER(8) not null,
  code_id       NUMBER(12) not null,
  code_name     VARCHAR2(255) not null,
  code_name_nls VARCHAR2(255) not null,
  sort_id       NUMBER(3) not null,
  is_used       NUMBER(1) not null,
  extern_code   VARCHAR2(50) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table AIGA.SYS_STATIC_DATA
  is '???????(???)
????????????????????????????????????????????????????????????????????????????????????????????
';
comment on column AIGA.SYS_STATIC_DATA.code_type
  is '???0????????????????????????????';
comment on column AIGA.SYS_STATIC_DATA.code_id
  is '???????0?????????????????????????0????????????????????1??';
comment on column AIGA.SYS_STATIC_DATA.code_name
  is '??????????????';
comment on column AIGA.SYS_STATIC_DATA.sort_id
  is '?????????????sort_id???????????????0?';
comment on column AIGA.SYS_STATIC_DATA.is_used
  is '?????????0 ? ???  ?1 ? ??????????????????????????';
comment on column AIGA.SYS_STATIC_DATA.extern_code
  is '?????????????????????????????????????';
alter table AIGA.SYS_STATIC_DATA
  add constraint BIN$Q4VHSGC3RLWFCUDYBRYKLQ$0 primary key (CODE_TYPE, CODE_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_STATION
prompt ==========================
prompt
create table AIGA.SYS_STATION
(
  station_id      NUMBER(12) not null,
  station_type_id NUMBER(12),
  organize_id     NUMBER(12),
  code            VARCHAR2(100),
  name            VARCHAR2(100) not null,
  work_desc       VARCHAR2(100),
  notes           VARCHAR2(100),
  state           NUMBER(2),
  done_code       NUMBER(12),
  create_date     DATE,
  done_date       DATE,
  valid_date      DATE,
  expire_date     DATE,
  op_id           NUMBER(12),
  org_id          NUMBER(12)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_STATION.state
  is '??
??';
comment on column AIGA.SYS_STATION.done_code
  is '????????';
comment on column AIGA.SYS_STATION.done_date
  is '????????';
comment on column AIGA.SYS_STATION.valid_date
  is '??????';
comment on column AIGA.SYS_STATION.expire_date
  is '??????';
alter table AIGA.SYS_STATION
  add constraint PK_STATION primary key (STATION_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_STATIONTYPE_FUNC
prompt ===================================
prompt
create table AIGA.SYS_STATIONTYPE_FUNC
(
  stationtype_func_relat_id NUMBER(12) not null,
  station_type_id           NUMBER(12),
  func_id                   NUMBER(12),
  notes                     VARCHAR2(100),
  state                     NUMBER(2),
  done_code                 NUMBER(12),
  create_date               DATE,
  done_date                 DATE,
  valid_date                DATE,
  expire_date               DATE,
  op_id                     NUMBER(12),
  org_id                    NUMBER(12)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_STATIONTYPE_FUNC.state
  is '??
??';
comment on column AIGA.SYS_STATIONTYPE_FUNC.done_code
  is '????????';
comment on column AIGA.SYS_STATIONTYPE_FUNC.done_date
  is '???????';
comment on column AIGA.SYS_STATIONTYPE_FUNC.valid_date
  is '????';
comment on column AIGA.SYS_STATIONTYPE_FUNC.expire_date
  is '???';
alter table AIGA.SYS_STATIONTYPE_FUNC
  add constraint PK_STATIONTYPE_FUNC primary key (STATIONTYPE_FUNC_RELAT_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_STATIONTYPE_ORGROLE_RELA
prompt ===========================================
prompt
create table AIGA.SYS_STATIONTYPE_ORGROLE_RELA
(
  stationtype_partyrole_relat_id NUMBER(12) not null,
  station_type_id                NUMBER(12),
  org_role_type_id               NUMBER(6),
  state                          NUMBER(2) not null,
  done_code                      NUMBER(12),
  create_date                    DATE,
  done_date                      DATE,
  valid_date                     DATE,
  expire_date                    DATE,
  op_id                          NUMBER(12),
  org_id                         NUMBER(12)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_STATIONTYPE_ORGROLE_RELA.state
  is '??
??';
comment on column AIGA.SYS_STATIONTYPE_ORGROLE_RELA.done_code
  is '????????';
comment on column AIGA.SYS_STATIONTYPE_ORGROLE_RELA.done_date
  is '????????';
comment on column AIGA.SYS_STATIONTYPE_ORGROLE_RELA.valid_date
  is '??????';
comment on column AIGA.SYS_STATIONTYPE_ORGROLE_RELA.expire_date
  is '??????';
alter table AIGA.SYS_STATIONTYPE_ORGROLE_RELA
  add constraint PK_STATIONTYPE_ORGROLE primary key (STATIONTYPE_PARTYROLE_RELAT_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_STATION_TYPE
prompt ===============================
prompt
create table AIGA.SYS_STATION_TYPE
(
  station_type_id NUMBER(12) not null,
  code            VARCHAR2(40),
  name            VARCHAR2(60) not null,
  kind_id         NUMBER(6),
  sort_id         NUMBER(3),
  notes           VARCHAR2(100),
  state           NUMBER(2),
  done_code       NUMBER(12),
  create_date     DATE,
  done_date       DATE,
  valid_date      DATE,
  expire_date     DATE,
  op_id           NUMBER(12),
  org_id          NUMBER(12)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_STATION_TYPE.state
  is '??
??';
comment on column AIGA.SYS_STATION_TYPE.done_code
  is '????????';
comment on column AIGA.SYS_STATION_TYPE.done_date
  is '????????';
comment on column AIGA.SYS_STATION_TYPE.valid_date
  is '?????';
comment on column AIGA.SYS_STATION_TYPE.expire_date
  is '??????';
alter table AIGA.SYS_STATION_TYPE
  add constraint PK_STATIONTYPE primary key (STATION_TYPE_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_STATION_TYPE_KIND
prompt ====================================
prompt
create table AIGA.SYS_STATION_TYPE_KIND
(
  kind_id        NUMBER(6) not null,
  kind_name      VARCHAR2(100),
  parent_kind_id NUMBER(6),
  sort_id        NUMBER(3),
  state          NUMBER(2),
  done_code      NUMBER(12),
  create_date    DATE,
  done_date      DATE,
  valid_date     DATE,
  expire_date    DATE,
  op_id          NUMBER(12),
  org_id         NUMBER(12)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_STATION_TYPE_KIND.state
  is '??
??';
comment on column AIGA.SYS_STATION_TYPE_KIND.done_code
  is '????????';
comment on column AIGA.SYS_STATION_TYPE_KIND.done_date
  is '????????';
comment on column AIGA.SYS_STATION_TYPE_KIND.valid_date
  is '???';
comment on column AIGA.SYS_STATION_TYPE_KIND.expire_date
  is '??????';
alter table AIGA.SYS_STATION_TYPE_KIND
  add constraint PK_STATIONTYPE_KIND primary key (KIND_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_USERMENU
prompt ===========================
prompt
create table AIGA.SYS_USERMENU
(
  menu_id     NUMBER(6) not null,
  domain_id   NUMBER(6) not null,
  staff_id    NUMBER(12),
  func_id     NUMBER(12),
  menu_title  VARCHAR2(100),
  menu_url    VARCHAR2(1000),
  menu_seq    NUMBER(6),
  state       NUMBER(2) not null,
  done_code   NUMBER(12),
  create_date DATE,
  done_date   DATE,
  valid_date  DATE,
  expire_date DATE,
  op_id       NUMBER(12),
  org_id      NUMBER(12)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_USERMENU.state
  is '0????1???';
comment on column AIGA.SYS_USERMENU.done_code
  is '????????';
comment on column AIGA.SYS_USERMENU.done_date
  is '????????';
comment on column AIGA.SYS_USERMENU.valid_date
  is '??????';
comment on column AIGA.SYS_USERMENU.expire_date
  is '??????';

prompt
prompt Creating table SYS_USER_DESKTOP
prompt ===============================
prompt
create table AIGA.SYS_USER_DESKTOP
(
  desk_pict_id NUMBER(12) not null,
  user_id      NUMBER(12),
  func_id      NUMBER(12),
  pict_url     VARCHAR2(300),
  pos_x        NUMBER(6),
  pos_y        NUMBER(6),
  disp_text    VARCHAR2(300),
  goto_url     VARCHAR2(400),
  state        NUMBER(1),
  domain_id    NUMBER(6),
  done_code    NUMBER(12),
  create_date  DATE,
  done_date    DATE,
  valid_date   DATE,
  expire_date  DATE,
  op_id        NUMBER(12),
  org_id       NUMBER(12)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_USER_DESKTOP.done_code
  is '????????';
comment on column AIGA.SYS_USER_DESKTOP.done_date
  is '???????';
comment on column AIGA.SYS_USER_DESKTOP.valid_date
  is '??????';
comment on column AIGA.SYS_USER_DESKTOP.expire_date
  is '??????';

prompt
prompt Creating table SYS_USER_GROUP
prompt =============================
prompt
create table AIGA.SYS_USER_GROUP
(
  group_id    NUMBER(12) not null,
  group_name  VARCHAR2(50),
  remark      VARCHAR2(250),
  state       NUMBER(2),
  done_code   NUMBER(12),
  create_date DATE,
  done_date   DATE,
  valid_date  DATE,
  expire_date DATE,
  org_id      NUMBER(12),
  op_id       NUMBER(12),
  ext1        VARCHAR2(50),
  ext2        VARCHAR2(50),
  group_kind  NUMBER(12)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_USER_GROUP_RELATE
prompt ====================================
prompt
create table AIGA.SYS_USER_GROUP_RELATE
(
  relate_id   NUMBER(12) not null,
  group_id    NUMBER(12),
  staff_id    NUMBER(12),
  state       NUMBER(2),
  done_code   NUMBER(12),
  create_date DATE,
  done_date   DATE,
  valid_date  DATE,
  expire_date DATE,
  org_id      NUMBER(12),
  op_id       NUMBER(12)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_USER_RECENT_FUNC
prompt ===================================
prompt
create table AIGA.SYS_USER_RECENT_FUNC
(
  user_id     NUMBER(12) not null,
  menu_id     NUMBER(12) not null,
  menu_name   VARCHAR2(300),
  url_addr    VARCHAR2(300),
  state       NUMBER(1),
  state_date  DATE,
  notes       VARCHAR2(100),
  domain_id   NUMBER(6) not null,
  done_code   NUMBER(12),
  create_date DATE,
  done_date   DATE,
  valid_date  DATE,
  expire_date DATE,
  op_id       NUMBER(12),
  org_id      NUMBER(12)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_USER_RECENT_FUNC.done_code
  is '????????';
comment on column AIGA.SYS_USER_RECENT_FUNC.done_date
  is '????????';
comment on column AIGA.SYS_USER_RECENT_FUNC.valid_date
  is '??????';
comment on column AIGA.SYS_USER_RECENT_FUNC.expire_date
  is '?????';

prompt
prompt Creating table SYS_VACATION
prompt ===========================
prompt
create table AIGA.SYS_VACATION
(
  vac_id       NUMBER(8),
  special_date VARCHAR2(8),
  isvacation   NUMBER(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.SYS_VACATION.vac_id
  is '??ID';
comment on column AIGA.SYS_VACATION.special_date
  is '????';
comment on column AIGA.SYS_VACATION.isvacation
  is '?????(0 ?,1 ?)';

prompt
prompt Creating table TEST_FUNC
prompt ========================
prompt
create table AIGA.TEST_FUNC
(
  func_id     NUMBER(8) not null,
  name        VARCHAR2(80) not null,
  func_kind   NUMBER(2),
  func_desc   VARCHAR2(80),
  func_path   VARCHAR2(255),
  func_pri    NUMBER(2),
  func_system VARCHAR2(80),
  check_sql   VARCHAR2(255),
  domain_name VARCHAR2(255),
  domain_id   VARCHAR2(255)
)
tablespace AIGA_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VM_ALARM_CONFIG
prompt ==============================
prompt
create table AIGA.VM_ALARM_CONFIG
(
  alarm_config_id      NUMBER(12) not null,
  vm_template_id       NUMBER(12),
  template_tag         VARCHAR2(100) not null,
  task_tag             VARCHAR2(100),
  duration_time_method VARCHAR2(300),
  alarm_time_method    VARCHAR2(300),
  alarm_deal_method    VARCHAR2(300),
  state                CHAR(1),
  is_holiday           NUMBER(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table AIGA.VM_ALARM_CONFIG
  is '?????????';
comment on column AIGA.VM_ALARM_CONFIG.alarm_config_id
  is '????ID';
comment on column AIGA.VM_ALARM_CONFIG.vm_template_id
  is '??ID';
comment on column AIGA.VM_ALARM_CONFIG.template_tag
  is '????';
comment on column AIGA.VM_ALARM_CONFIG.task_tag
  is '????: ?????????????????';
comment on column AIGA.VM_ALARM_CONFIG.duration_time_method
  is '????????? ???????';
comment on column AIGA.VM_ALARM_CONFIG.alarm_time_method
  is '????????? ???????';
comment on column AIGA.VM_ALARM_CONFIG.alarm_deal_method
  is '????????';
comment on column AIGA.VM_ALARM_CONFIG.state
  is '??';
comment on column AIGA.VM_ALARM_CONFIG.is_holiday
  is '?????????';

prompt
prompt Creating table VM_CONFIG
prompt ========================
prompt
create table AIGA.VM_CONFIG
(
  queue_id      VARCHAR2(20),
  district_id   VARCHAR2(10),
  table_postfix VARCHAR2(20),
  id_postfix    NUMBER(3),
  data_source   VARCHAR2(50)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table AIGA.VM_CONFIG
  is '??????';
comment on column AIGA.VM_CONFIG.queue_id
  is '????';
comment on column AIGA.VM_CONFIG.district_id
  is '????';
comment on column AIGA.VM_CONFIG.table_postfix
  is '???';
comment on column AIGA.VM_CONFIG.id_postfix
  is 'TASK_ID,WORKFLOW_ID??';

prompt
prompt Creating table VM_DEAL_TASK
prompt ===========================
prompt
create table AIGA.VM_DEAL_TASK
(
  task_id       NUMBER(12) not null,
  workflow_id   NUMBER(12) not null,
  queue_id      VARCHAR2(20),
  district_id   VARCHAR2(10),
  deal_type     VARCHAR2(10),
  runtime       DATE,
  state         NUMBER(2),
  create_date   DATE,
  error_message VARCHAR2(2000)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table AIGA.VM_DEAL_TASK
  is '????';
comment on column AIGA.VM_DEAL_TASK.task_id
  is '????';
comment on column AIGA.VM_DEAL_TASK.queue_id
  is '????';
comment on column AIGA.VM_DEAL_TASK.district_id
  is '????';
comment on column AIGA.VM_DEAL_TASK.deal_type
  is '?????TIMER-???,PRINT-????????????';
comment on column AIGA.VM_DEAL_TASK.runtime
  is '??????';
comment on column AIGA.VM_DEAL_TASK.state
  is '???? 2-????,99-????';
comment on column AIGA.VM_DEAL_TASK.create_date
  is '????';
comment on column AIGA.VM_DEAL_TASK.error_message
  is '????';

prompt
prompt Creating table VM_ENGINE_TEMPLATE
prompt =================================
prompt
create table AIGA.VM_ENGINE_TEMPLATE
(
  id                 NUMBER(12) not null,
  vm_template_id     NUMBER(12) not null,
  engine_template_id VARCHAR2(100),
  engine_type        VARCHAR2(100) not null,
  engine_verion      VARCHAR2(100),
  task_tag           VARCHAR2(100) not null,
  label              VARCHAR2(100),
  create_staff_id    VARCHAR2(30),
  modify_desc        VARCHAR2(1000),
  state              NUMBER,
  create_date        DATE,
  valid_date         DATE,
  state_date         DATE,
  expire_date        DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.VM_ENGINE_TEMPLATE.id
  is 'ID ????';
comment on column AIGA.VM_ENGINE_TEMPLATE.vm_template_id
  is 'VM?????ID';
comment on column AIGA.VM_ENGINE_TEMPLATE.engine_template_id
  is '????ID';
comment on column AIGA.VM_ENGINE_TEMPLATE.engine_type
  is '????';
comment on column AIGA.VM_ENGINE_TEMPLATE.engine_verion
  is '?????????';
comment on column AIGA.VM_ENGINE_TEMPLATE.task_tag
  is '????';
comment on column AIGA.VM_ENGINE_TEMPLATE.label
  is '????';
comment on column AIGA.VM_ENGINE_TEMPLATE.create_staff_id
  is '????';
comment on column AIGA.VM_ENGINE_TEMPLATE.modify_desc
  is '??????';
comment on column AIGA.VM_ENGINE_TEMPLATE.state
  is '?? 1???0??';
comment on column AIGA.VM_ENGINE_TEMPLATE.create_date
  is '????';
comment on column AIGA.VM_ENGINE_TEMPLATE.valid_date
  is '????';
comment on column AIGA.VM_ENGINE_TEMPLATE.state_date
  is '??????';
comment on column AIGA.VM_ENGINE_TEMPLATE.expire_date
  is '????';

prompt
prompt Creating table VM_EXCEPTION_CODE
prompt ================================
prompt
create table AIGA.VM_EXCEPTION_CODE
(
  exception_code          VARCHAR2(100) not null,
  exception_name          VARCHAR2(100),
  workflow_object_type_id VARCHAR2(100),
  task_tag                VARCHAR2(100),
  exception_type          VARCHAR2(100),
  create_date             DATE,
  state                   VARCHAR2(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.VM_EXCEPTION_CODE.exception_code
  is '??????';
comment on column AIGA.VM_EXCEPTION_CODE.exception_name
  is '??????';
comment on column AIGA.VM_EXCEPTION_CODE.workflow_object_type_id
  is '?????????';
comment on column AIGA.VM_EXCEPTION_CODE.create_date
  is '????';
comment on column AIGA.VM_EXCEPTION_CODE.state
  is '?? U ???? E ????';

prompt
prompt Creating table VM_EXCEPTION_CODE_DESC_RELATE
prompt ============================================
prompt
create table AIGA.VM_EXCEPTION_CODE_DESC_RELATE
(
  exception_code      VARCHAR2(100) not null,
  exception_desc_code VARCHAR2(100) not null,
  create_date         DATE,
  state               VARCHAR2(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.VM_EXCEPTION_CODE_DESC_RELATE.exception_code
  is '??????';
comment on column AIGA.VM_EXCEPTION_CODE_DESC_RELATE.exception_desc_code
  is '??????';
comment on column AIGA.VM_EXCEPTION_CODE_DESC_RELATE.create_date
  is '????';
comment on column AIGA.VM_EXCEPTION_CODE_DESC_RELATE.state
  is '?? U ???? E ????';

prompt
prompt Creating table VM_EXCEPTION_DESC
prompt ================================
prompt
create table AIGA.VM_EXCEPTION_DESC
(
  exception_desc_code VARCHAR2(100) not null,
  exception_desc_name VARCHAR2(100),
  create_date         DATE,
  state               VARCHAR2(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.VM_EXCEPTION_DESC.exception_desc_code
  is '??????';
comment on column AIGA.VM_EXCEPTION_DESC.exception_desc_name
  is '??????';
comment on column AIGA.VM_EXCEPTION_DESC.create_date
  is '????';
comment on column AIGA.VM_EXCEPTION_DESC.state
  is '?? U ???? E ????';

prompt
prompt Creating table VM_EXCEPTION_RECORD
prompt ==================================
prompt
create table AIGA.VM_EXCEPTION_RECORD
(
  exception_record_id NUMBER(12) not null,
  exception_code      VARCHAR2(100) not null,
  exception_remarks   VARCHAR2(400),
  workflow_id         NUMBER(12),
  task_id             VARCHAR2(400),
  create_date         DATE,
  next_workflow_code  VARCHAR2(100),
  rule_owner          VARCHAR2(2),
  state               VARCHAR2(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.VM_EXCEPTION_RECORD.exception_record_id
  is '??????(??)';
comment on column AIGA.VM_EXCEPTION_RECORD.exception_code
  is '????';
comment on column AIGA.VM_EXCEPTION_RECORD.exception_remarks
  is '??????';
comment on column AIGA.VM_EXCEPTION_RECORD.workflow_id
  is '???????';
comment on column AIGA.VM_EXCEPTION_RECORD.task_id
  is '???????ID';
comment on column AIGA.VM_EXCEPTION_RECORD.create_date
  is '????';
comment on column AIGA.VM_EXCEPTION_RECORD.next_workflow_code
  is '??????(??????????????????)';
comment on column AIGA.VM_EXCEPTION_RECORD.rule_owner
  is '???????(01:COMFRAME 02:????)';
comment on column AIGA.VM_EXCEPTION_RECORD.state
  is '?? U ???? E ????';

prompt
prompt Creating table VM_EXCEPTION_RULE
prompt ================================
prompt
create table AIGA.VM_EXCEPTION_RULE
(
  exception_rule_id      NUMBER(12) not null,
  exception_desc_code    VARCHAR2(100),
  current_work_flow_code VARCHAR2(100),
  next_work_flow_code    VARCHAR2(100),
  exception_rule_remarks VARCHAR2(400),
  create_date            DATE,
  state                  VARCHAR2(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.VM_EXCEPTION_RULE.exception_rule_id
  is '?????????(??)';
comment on column AIGA.VM_EXCEPTION_RULE.exception_desc_code
  is '??????';
comment on column AIGA.VM_EXCEPTION_RULE.current_work_flow_code
  is '????????????';
comment on column AIGA.VM_EXCEPTION_RULE.next_work_flow_code
  is '??????????';
comment on column AIGA.VM_EXCEPTION_RULE.exception_rule_remarks
  is '????????';
comment on column AIGA.VM_EXCEPTION_RULE.create_date
  is '????';
comment on column AIGA.VM_EXCEPTION_RULE.state
  is '?? U ???? E ????';

prompt
prompt Creating table VM_HOLIDAY
prompt =========================
prompt
create table AIGA.VM_HOLIDAY
(
  holiday DATE not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table AIGA.VM_HOLIDAY
  is '????';
comment on column AIGA.VM_HOLIDAY.holiday
  is '??? yyyy-mm-dd';

prompt
prompt Creating table VM_SCHEDULE
prompt ==========================
prompt
create table AIGA.VM_SCHEDULE
(
  workflow_id        NUMBER(12) not null,
  queue_id           VARCHAR2(20),
  engine_workflow_id VARCHAR2(100),
  engine_type        VARCHAR2(100),
  add_date           DATE,
  start_date         DATE,
  state              VARCHAR2(10),
  schedule_id        NUMBER(12),
  schedule_server    VARCHAR2(500),
  schedule_date      DATE,
  district_id        VARCHAR2(6)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.VM_SCHEDULE.workflow_id
  is '?????';
comment on column AIGA.VM_SCHEDULE.queue_id
  is '????';
comment on column AIGA.VM_SCHEDULE.engine_workflow_id
  is '???????????';
comment on column AIGA.VM_SCHEDULE.engine_type
  is '????';
comment on column AIGA.VM_SCHEDULE.add_date
  is '??????';
comment on column AIGA.VM_SCHEDULE.start_date
  is '?????????';
comment on column AIGA.VM_SCHEDULE.state
  is '?????W-????,S-?????,F-????';
comment on column AIGA.VM_SCHEDULE.schedule_id
  is '????';
comment on column AIGA.VM_SCHEDULE.schedule_server
  is '??SERVER';
comment on column AIGA.VM_SCHEDULE.schedule_date
  is '??????';
alter table AIGA.VM_SCHEDULE
  add constraint BIN$M0YU3GPHQ2M0CORQZSLNW$0 primary key (WORKFLOW_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VM_STATIC_DATA
prompt =============================
prompt
create table AIGA.VM_STATIC_DATA
(
  code_type NUMBER(8) not null,
  code_id   VARCHAR2(50) not null,
  code_name VARCHAR2(255) not null,
  sort_id   NUMBER(3) not null,
  is_used   NUMBER(1) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table AIGA.VM_STATIC_DATA
  is '???????(???)';
comment on column AIGA.VM_STATIC_DATA.code_type
  is '????  ?0,???????????????????';
comment on column AIGA.VM_STATIC_DATA.code_id
  is '?????';
comment on column AIGA.VM_STATIC_DATA.code_name
  is '??????????????';
comment on column AIGA.VM_STATIC_DATA.sort_id
  is '?????????????sort_id???????????????0?';
comment on column AIGA.VM_STATIC_DATA.is_used
  is '?????????0 ? ???  ?1 ? ??';

prompt
prompt Creating table VM_TASK
prompt ======================
prompt
create table AIGA.VM_TASK
(
  task_id                 NUMBER(12) not null,
  last_task_id            VARCHAR2(500),
  workflow_id             NUMBER(12),
  task_template_id        NUMBER(12),
  engine_workflow_id      VARCHAR2(100),
  engine_task_id          VARCHAR2(100),
  task_type               VARCHAR2(100),
  task_base_type          VARCHAR2(100),
  task_tag                VARCHAR2(100),
  child_workflow_count    NUMBER(10),
  remanent_workflow_count NUMBER(10),
  label                   VARCHAR2(100),
  duration                NUMBER(12),
  decision_result         VARCHAR2(100),
  is_current_task         CHAR(1),
  state                   NUMBER(2),
  state_date              DATE,
  create_date             DATE,
  exe_finish_date         DATE,
  station_id              VARCHAR2(30),
  task_staff_id           VARCHAR2(30),
  lock_staff_id           VARCHAR2(30),
  lock_date               DATE,
  finish_staff_id         VARCHAR2(30),
  finish_date             DATE,
  error_message           VARCHAR2(1000),
  description             VARCHAR2(500),
  warning_date            DATE,
  warning_times           NUMBER(2)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 9M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.VM_TASK.task_id
  is '????';
comment on column AIGA.VM_TASK.last_task_id
  is '????????????';
comment on column AIGA.VM_TASK.workflow_id
  is '?????';
comment on column AIGA.VM_TASK.task_template_id
  is '??????';
comment on column AIGA.VM_TASK.engine_task_id
  is '???????????';
comment on column AIGA.VM_TASK.task_type
  is '????';
comment on column AIGA.VM_TASK.task_base_type
  is '??????';
comment on column AIGA.VM_TASK.task_tag
  is '????';
comment on column AIGA.VM_TASK.child_workflow_count
  is '?????';
comment on column AIGA.VM_TASK.remanent_workflow_count
  is '????????';
comment on column AIGA.VM_TASK.label
  is '????';
comment on column AIGA.VM_TASK.duration
  is '????';
comment on column AIGA.VM_TASK.decision_result
  is '????';
comment on column AIGA.VM_TASK.is_current_task
  is '??????';
comment on column AIGA.VM_TASK.state
  is '???? 1-???? 2-???? 3-???? 4-?? 9-???? 5-???? 6-?? 7-???????? 8-???? 99-???? 21-???????????';
comment on column AIGA.VM_TASK.state_date
  is '????';
comment on column AIGA.VM_TASK.create_date
  is '????';
comment on column AIGA.VM_TASK.exe_finish_date
  is '??????????????';
comment on column AIGA.VM_TASK.station_id
  is '????';
comment on column AIGA.VM_TASK.task_staff_id
  is '????';
comment on column AIGA.VM_TASK.lock_staff_id
  is '????';
comment on column AIGA.VM_TASK.lock_date
  is '????';
comment on column AIGA.VM_TASK.finish_staff_id
  is '????';
comment on column AIGA.VM_TASK.finish_date
  is '????';
comment on column AIGA.VM_TASK.error_message
  is '????';
comment on column AIGA.VM_TASK.description
  is '????';
comment on column AIGA.VM_TASK.warning_date
  is '????';
comment on column AIGA.VM_TASK.warning_times
  is '????';
alter table AIGA.VM_TASK
  add constraint BIN$MQMUJNR7TBCSF4PDRTNUCQ primary key (TASK_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 2M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table VM_TASK_TRANS
prompt ============================
prompt
create table AIGA.VM_TASK_TRANS
(
  task_id          NUMBER(12) not null,
  parent_task_id   NUMBER(12),
  workflow_id      NUMBER(12),
  task_template_id NUMBER(12),
  task_type        VARCHAR2(100),
  task_base_type   VARCHAR2(100),
  task_tag         VARCHAR2(100),
  label            VARCHAR2(100),
  duration         NUMBER(12),
  decision_result  VARCHAR2(100),
  is_current_task  CHAR(1),
  state            NUMBER(2),
  state_date       DATE,
  create_date      DATE,
  station_id       VARCHAR2(30),
  task_staff_id    VARCHAR2(30),
  lock_staff_id    VARCHAR2(30),
  lock_date        DATE,
  finish_staff_id  VARCHAR2(30),
  finish_date      DATE,
  error_message    VARCHAR2(1000),
  description      VARCHAR2(500),
  warning_date     DATE,
  warning_times    NUMBER(2)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 512K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.VM_TASK_TRANS.task_id
  is '????';
comment on column AIGA.VM_TASK_TRANS.parent_task_id
  is '??????';
comment on column AIGA.VM_TASK_TRANS.workflow_id
  is '????';
comment on column AIGA.VM_TASK_TRANS.task_template_id
  is '??????';
comment on column AIGA.VM_TASK_TRANS.task_type
  is '????';
comment on column AIGA.VM_TASK_TRANS.task_tag
  is '????';
comment on column AIGA.VM_TASK_TRANS.label
  is '????';
comment on column AIGA.VM_TASK_TRANS.duration
  is '????';
comment on column AIGA.VM_TASK_TRANS.decision_result
  is '????';
comment on column AIGA.VM_TASK_TRANS.is_current_task
  is '??????';
comment on column AIGA.VM_TASK_TRANS.state
  is '???? 1-???? 2-???? 3-???? 4-?? 9-???? 5-???? 6-???? 7-???????? 8-???? 99-???? 21-???????????';
comment on column AIGA.VM_TASK_TRANS.state_date
  is '????';
comment on column AIGA.VM_TASK_TRANS.create_date
  is '????';
comment on column AIGA.VM_TASK_TRANS.station_id
  is '????';
comment on column AIGA.VM_TASK_TRANS.task_staff_id
  is '????';
comment on column AIGA.VM_TASK_TRANS.lock_staff_id
  is '????';
comment on column AIGA.VM_TASK_TRANS.lock_date
  is '????';
comment on column AIGA.VM_TASK_TRANS.finish_staff_id
  is '????';
comment on column AIGA.VM_TASK_TRANS.finish_date
  is '????';
comment on column AIGA.VM_TASK_TRANS.error_message
  is '????';
comment on column AIGA.VM_TASK_TRANS.description
  is '????';

prompt
prompt Creating table VM_TEMPLATE
prompt ==========================
prompt
create table AIGA.VM_TEMPLATE
(
  template_id     NUMBER(12) not null,
  task_type       VARCHAR2(100),
  task_tag        VARCHAR2(100),
  label           VARCHAR2(100),
  create_staff_id VARCHAR2(30),
  create_date     DATE,
  state           NUMBER(2),
  state_date      DATE,
  modify_desc     VARCHAR2(1000),
  valid_date      DATE,
  expire_date     DATE,
  content         BLOB
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table AIGA.VM_TEMPLATE
  is '????';
comment on column AIGA.VM_TEMPLATE.template_id
  is '????ID';
comment on column AIGA.VM_TEMPLATE.task_type
  is '???????workflow,process';
comment on column AIGA.VM_TEMPLATE.task_tag
  is '??????';
comment on column AIGA.VM_TEMPLATE.label
  is '??????';
comment on column AIGA.VM_TEMPLATE.create_staff_id
  is '????';
comment on column AIGA.VM_TEMPLATE.create_date
  is '????';
comment on column AIGA.VM_TEMPLATE.state
  is '??:1--?? 0--??';
comment on column AIGA.VM_TEMPLATE.state_date
  is '??????';
comment on column AIGA.VM_TEMPLATE.modify_desc
  is '??????';
comment on column AIGA.VM_TEMPLATE.valid_date
  is '????';
comment on column AIGA.VM_TEMPLATE.expire_date
  is '????';
comment on column AIGA.VM_TEMPLATE.content
  is '????';

prompt
prompt Creating table VM_WORKFLOW_ATTR
prompt ===============================
prompt
create table AIGA.VM_WORKFLOW_ATTR
(
  attr_id     NUMBER(12) not null,
  workflow_id NUMBER(12),
  attr_code   VARCHAR2(100),
  attr_name   VARCHAR2(100),
  attr_value  VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.VM_WORKFLOW_ATTR.attr_id
  is '????????';
comment on column AIGA.VM_WORKFLOW_ATTR.workflow_id
  is '????';
comment on column AIGA.VM_WORKFLOW_ATTR.attr_code
  is '????';
comment on column AIGA.VM_WORKFLOW_ATTR.attr_name
  is '????';
comment on column AIGA.VM_WORKFLOW_ATTR.attr_value
  is '???';

prompt
prompt Creating table VM_WORK_FLOW
prompt ===========================
prompt
create table AIGA.VM_WORK_FLOW
(
  task_id                 NUMBER(12) not null,
  task_template_id        NUMBER(12),
  queue_id                VARCHAR2(20),
  engine_workflow_id      VARCHAR2(100),
  engine_type             VARCHAR2(100),
  task_type               VARCHAR2(100),
  task_tag                VARCHAR2(100),
  parent_task_id          NUMBER(12),
  is_exception_workflow   NUMBER(2),
  state                   NUMBER(2),
  state_date              DATE,
  workflow_object_id      VARCHAR2(50),
  workflow_object_type_id VARCHAR2(100),
  user_task_count         NUMBER(12),
  current_task_id         VARCHAR2(100),
  duration                NUMBER(12),
  create_staff_id         VARCHAR2(30),
  create_date             DATE,
  start_date              DATE,
  finish_date             DATE,
  label                   VARCHAR2(100),
  description             VARCHAR2(500),
  vars                    VARCHAR2(4000),
  op_staff_id             VARCHAR2(30),
  error_count             NUMBER(3),
  error_message           VARCHAR2(4000),
  district_id             VARCHAR2(6),
  warning_date            DATE,
  warning_times           NUMBER(2)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column AIGA.VM_WORK_FLOW.task_id
  is '?????';
comment on column AIGA.VM_WORK_FLOW.task_template_id
  is '???????';
comment on column AIGA.VM_WORK_FLOW.queue_id
  is '????';
comment on column AIGA.VM_WORK_FLOW.engine_workflow_id
  is '???????????';
comment on column AIGA.VM_WORK_FLOW.engine_type
  is '????';
comment on column AIGA.VM_WORK_FLOW.task_type
  is '?????';
comment on column AIGA.VM_WORK_FLOW.task_tag
  is '????';
comment on column AIGA.VM_WORK_FLOW.parent_task_id
  is '?????????????';
comment on column AIGA.VM_WORK_FLOW.is_exception_workflow
  is '??????0?1-??(PARENT_TASK_ID???????????)';
comment on column AIGA.VM_WORK_FLOW.state
  is '?? 1-???? 2-???? 3-???? 4-?? 5-???? 7-???????? 8-???? 99-????';
comment on column AIGA.VM_WORK_FLOW.state_date
  is '????';
comment on column AIGA.VM_WORK_FLOW.workflow_object_id
  is '?????????';
comment on column AIGA.VM_WORK_FLOW.workflow_object_type_id
  is '?????????';
comment on column AIGA.VM_WORK_FLOW.user_task_count
  is '??????';
comment on column AIGA.VM_WORK_FLOW.current_task_id
  is '????';
comment on column AIGA.VM_WORK_FLOW.duration
  is '????';
comment on column AIGA.VM_WORK_FLOW.create_staff_id
  is '???';
comment on column AIGA.VM_WORK_FLOW.create_date
  is '????';
comment on column AIGA.VM_WORK_FLOW.start_date
  is '?????????';
comment on column AIGA.VM_WORK_FLOW.finish_date
  is '????';
comment on column AIGA.VM_WORK_FLOW.label
  is '?????';
comment on column AIGA.VM_WORK_FLOW.description
  is '?????';
comment on column AIGA.VM_WORK_FLOW.vars
  is '????';
comment on column AIGA.VM_WORK_FLOW.error_message
  is '????';
comment on column AIGA.VM_WORK_FLOW.warning_date
  is '????';
comment on column AIGA.VM_WORK_FLOW.warning_times
  is '????';
alter table AIGA.VM_WORK_FLOW
  add constraint BIN$HHH1KSRTCE5XQLXF6UY2G$0 primary key (TASK_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating sequence AIGA_ACCOUNT_TEST$SEQ
prompt =======================================
prompt
create sequence AIGA.AIGA_ACCOUNT_TEST$SEQ
minvalue 1
maxvalue 9999999999999999999999999
start with 380
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_AUDIT$SEQ
prompt ================================
prompt
create sequence AIGA.AIGA_AUDIT$SEQ
minvalue 1
maxvalue 9999999999999999999999999
start with 460
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_AUTOTEST_PARAMS$SEQ
prompt ==========================================
prompt
create sequence AIGA.AIGA_AUTOTEST_PARAMS$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 91
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_BASE_BUSI$SEQ
prompt ====================================
prompt
create sequence AIGA.AIGA_BASE_BUSI$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 37
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_BASE_CASE$SEQ
prompt ====================================
prompt
create sequence AIGA.AIGA_BASE_CASE$SEQ
minvalue 1
maxvalue 10000000000000000000000
start with 1782
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_BASE_CASE_COLLECTION$SEQ
prompt ===============================================
prompt
create sequence AIGA.AIGA_BASE_CASE_COLLECTION$SEQ
minvalue 1
maxvalue 10000000000000000000000
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_BASE_COMPONENT$SEQ
prompt =========================================
prompt
create sequence AIGA.AIGA_BASE_COMPONENT$SEQ
minvalue 1
maxvalue 10000000000000000000000
start with 230
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_BASE_GUI$SEQ
prompt ===================================
prompt
create sequence AIGA.AIGA_BASE_GUI$SEQ
minvalue 1
maxvalue 10000000000000000000000
start with 204
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_BASE_R_CASE_COMP$SEQ
prompt ===========================================
prompt
create sequence AIGA.AIGA_BASE_R_CASE_COMP$SEQ
minvalue 1
maxvalue 10000000000000000000000
start with 451579
increment by 438
cache 20;

prompt
prompt Creating sequence AIGA_BASE_R_COLLECT_CASE$SEQ
prompt ==============================================
prompt
create sequence AIGA.AIGA_BASE_R_COLLECT_CASE$SEQ
minvalue 1
maxvalue 10000000000000000000000
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_BASE_R_COMP_GUI$SEQ
prompt ==========================================
prompt
create sequence AIGA.AIGA_BASE_R_COMP_GUI$SEQ
minvalue 1
maxvalue 10000000000000000000000
start with 142
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_BUSI$SEQ
prompt ===============================
prompt
create sequence AIGA.AIGA_BUSI$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 289
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_BUSI_RULE_LABEL$SEQ
prompt ==========================================
prompt
create sequence AIGA.AIGA_BUSI_RULE_LABEL$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_CASE_LABEL_RELA$SEQ
prompt ==========================================
prompt
create sequence AIGA.AIGA_CASE_LABEL_RELA$SEQ
minvalue 1
maxvalue 10000000000000000000000
start with 82
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_CASE_PARAMS$SEQ
prompt ======================================
prompt
create sequence AIGA.AIGA_CASE_PARAMS$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 28
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_CLIENT_CONFIG$SEQ
prompt ========================================
prompt
create sequence AIGA.AIGA_CLIENT_CONFIG$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 3
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_EXCEL$SEQ
prompt ================================
prompt
create sequence AIGA.AIGA_EXCEL$SEQ
minvalue 1
maxvalue 9999999999999999999999999
start with 420
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_EXT_INDEX$SEQ
prompt ====================================
prompt
create sequence AIGA.AIGA_EXT_INDEX$SEQ
minvalue 1
maxvalue 9999999999999999999999999
start with 86945
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_FUN_FOLDER$SEQ
prompt =====================================
prompt
create sequence AIGA.AIGA_FUN_FOLDER$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 59737
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_FUN_POINT$SEQ
prompt ====================================
prompt
create sequence AIGA.AIGA_FUN_POINT$SEQ
minvalue 1
maxvalue 10000000000000000000000
start with 22943
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_GROUP_CASE$SEQ
prompt =====================================
prompt
create sequence AIGA.AIGA_GROUP_CASE$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 154
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_GROUP_CASE_REQ$SEQ
prompt =========================================
prompt
create sequence AIGA.AIGA_GROUP_CASE_REQ$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 134
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_HIS_CASE$SEQ
prompt ===================================
prompt
create sequence AIGA.AIGA_HIS_CASE$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 181
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_HIS_ELEM$SEQ
prompt ===================================
prompt
create sequence AIGA.AIGA_HIS_ELEM$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 241
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_HIS_RUN_TASK_RESULT$SEQ
prompt ==============================================
prompt
create sequence AIGA.AIGA_HIS_RUN_TASK_RESULT$SEQ
minvalue 1
maxvalue 10000000000000000000000
start with 141
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_HIS_SECENE$SEQ
prompt =====================================
prompt
create sequence AIGA.AIGA_HIS_SECENE$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 341
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_HIS_SUB_ELEM$SEQ
prompt =======================================
prompt
create sequence AIGA.AIGA_HIS_SUB_ELEM$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 361
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_INST_CASE$SEQ
prompt ====================================
prompt
create sequence AIGA.AIGA_INST_CASE$SEQ
minvalue 1
maxvalue 10000000000000000000000
start with 7
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_INST_CASE_COLLECTION$SEQ
prompt ===============================================
prompt
create sequence AIGA.AIGA_INST_CASE_COLLECTION$SEQ
minvalue 1
maxvalue 10000000000000000000000
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_INST_COMPONENT$SEQ
prompt =========================================
prompt
create sequence AIGA.AIGA_INST_COMPONENT$SEQ
minvalue 1
maxvalue 10000000000000000000000
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_INST_GUI$SEQ
prompt ===================================
prompt
create sequence AIGA.AIGA_INST_GUI$SEQ
minvalue 1
maxvalue 10000000000000000000000
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_INST_R_CASE_COMP$SEQ
prompt ===========================================
prompt
create sequence AIGA.AIGA_INST_R_CASE_COMP$SEQ
minvalue 1
maxvalue 10000000000000000000000
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_INST_R_COLLECT_CASE$SEQ
prompt ==============================================
prompt
create sequence AIGA.AIGA_INST_R_COLLECT_CASE$SEQ
minvalue 1
maxvalue 10000000000000000000000
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_INST_R_COMP_GUI$SEQ
prompt ==========================================
prompt
create sequence AIGA.AIGA_INST_R_COMP_GUI$SEQ
minvalue 1
maxvalue 10000000000000000000000
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_KNOWLEDGE$SEQ
prompt ====================================
prompt
create sequence AIGA.AIGA_KNOWLEDGE$SEQ
minvalue 1
maxvalue 9999999999999999999999999
start with 360
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_LABEL$SEQ
prompt ================================
prompt
create sequence AIGA.AIGA_LABEL$SEQ
minvalue 1
maxvalue 10000000000000000000000
start with 215
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_LOG_ELEMENT$SEQ
prompt ======================================
prompt
create sequence AIGA.AIGA_LOG_ELEMENT$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 221
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_LOG_STEP$SEQ
prompt ===================================
prompt
create sequence AIGA.AIGA_LOG_STEP$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 241
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_LOG_TEST_CASE$SEQ
prompt ========================================
prompt
create sequence AIGA.AIGA_LOG_TEST_CASE$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 84
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_MANUAL_TASK$SEQ
prompt ======================================
prompt
create sequence AIGA.AIGA_MANUAL_TASK$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 87
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_MENU$SEQ
prompt ===============================
prompt
create sequence AIGA.AIGA_MENU$SEQ
minvalue 1
maxvalue 9999999999999999999999999
start with 3000
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_MONTH_DEL_SLA$SEQ
prompt ========================================
prompt
create sequence AIGA.AIGA_MONTH_DEL_SLA$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 24
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_MONTH_REP_KPI$SEQ
prompt ========================================
prompt
create sequence AIGA.AIGA_MONTH_REP_KPI$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 42
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_MONTH_RUN_KPI$SEQ
prompt ========================================
prompt
create sequence AIGA.AIGA_MONTH_RUN_KPI$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 22
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_PERFORMANCE_SUB_TASK$SEQ
prompt ===============================================
prompt
create sequence AIGA.AIGA_PERFORMANCE_SUB_TASK$SEQ
minvalue 1
maxvalue 9999999999999999999999999
start with 400
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_PERFTEST_TASK$SEQ
prompt ========================================
prompt
create sequence AIGA.AIGA_PERFTEST_TASK$SEQ
minvalue 1
maxvalue 1111111111111111
start with 1021
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_PERF_SUB_RESULT$SEQ
prompt ==========================================
prompt
create sequence AIGA.AIGA_PERF_SUB_RESULT$SEQ
minvalue 1
maxvalue 99999999999999999999999999
start with 320
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_QUALITY_MANAGE$SEQ
prompt =========================================
prompt
create sequence AIGA.AIGA_QUALITY_MANAGE$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_REQUISITION$SEQ
prompt ======================================
prompt
create sequence AIGA.AIGA_REQUISITION$SEQ
minvalue 1
maxvalue 10000000000000000000000
start with 181
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_RUN_PLAN$SEQ
prompt ===================================
prompt
create sequence AIGA.AIGA_RUN_PLAN$SEQ
minvalue 1
maxvalue 10000000000000000000000
start with 495
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_R_CASE_ELEM$SEQ
prompt ======================================
prompt
create sequence AIGA.AIGA_R_CASE_ELEM$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 340
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_R_ELEM_CASE$SEQ
prompt ======================================
prompt
create sequence AIGA.AIGA_R_ELEM_CASE$SEQ
minvalue 1
maxvalue 10000000000000000000000
start with 322
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_R_ELEM_SEC$SEQ
prompt =====================================
prompt
create sequence AIGA.AIGA_R_ELEM_SEC$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 417
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_R_FUN_CASE$SEQ
prompt =====================================
prompt
create sequence AIGA.AIGA_R_FUN_CASE$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 380
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_R_FUN_ELEM$SEQ
prompt =====================================
prompt
create sequence AIGA.AIGA_R_FUN_ELEM$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 467
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_R_SUB_CASE$SEQ
prompt =====================================
prompt
create sequence AIGA.AIGA_R_SUB_CASE$SEQ
minvalue 1
maxvalue 9999999999999999999999999
start with 300
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_SECENE$SEQ
prompt =================================
prompt
create sequence AIGA.AIGA_SECENE$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 280
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_SOLID_TASK$SEQ
prompt =====================================
prompt
create sequence AIGA.AIGA_SOLID_TASK$SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1938
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_ST_CODESCAN$SEQ
prompt ======================================
prompt
create sequence AIGA.AIGA_ST_CODESCAN$SEQ
minvalue 1
maxvalue 9999999999999999999999999
start with 1020
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_ST_HWREGRTEST$SEQ
prompt ========================================
prompt
create sequence AIGA.AIGA_ST_HWREGRTEST$SEQ
minvalue 1
maxvalue 9999999999999999999999999
start with 1080
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_ST_PERFTEST$SEQ
prompt ======================================
prompt
create sequence AIGA.AIGA_ST_PERFTEST$SEQ
minvalue 1
maxvalue 9999999999999999999999999
start with 1020
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_ST_REGRTEST$SEQ
prompt ======================================
prompt
create sequence AIGA.AIGA_ST_REGRTEST$SEQ
minvalue 1
maxvalue 9999999999999999999999999
start with 1080
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_ST_SECUTEST$SEQ
prompt ======================================
prompt
create sequence AIGA.AIGA_ST_SECUTEST$SEQ
minvalue 1
maxvalue 9999999999999999999999999
start with 1020
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_SUBTASK_PROBLEM$SEQ
prompt ==========================================
prompt
create sequence AIGA.AIGA_SUBTASK_PROBLEM$SEQ
minvalue 1
maxvalue 11111111111111
start with 101
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_SUB_SYS_FOLDER$SEQ
prompt =========================================
prompt
create sequence AIGA.AIGA_SUB_SYS_FOLDER$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_SYSTEM_FOLDER$SEQ
prompt ========================================
prompt
create sequence AIGA.AIGA_SYSTEM_FOLDER$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 105
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_TESTLAN_CHANGE$SEQ
prompt =========================================
prompt
create sequence AIGA.AIGA_TESTLAN_CHANGE$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 176
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_TESTTASK_CHANGE$SEQ
prompt ==========================================
prompt
create sequence AIGA.AIGA_TESTTASK_CHANGE$SEQ
minvalue 1
maxvalue 9999999999999999999999999
start with 1100
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_TEST_DAILY$SEQ
prompt =====================================
prompt
create sequence AIGA.AIGA_TEST_DAILY$SEQ
minvalue 1
maxvalue 10000000000000000000000
start with 369
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_TEST_ELEM$SEQ
prompt ====================================
prompt
create sequence AIGA.AIGA_TEST_ELEM$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 274
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_TEST_PLAN$SEQ
prompt ====================================
prompt
create sequence AIGA.AIGA_TEST_PLAN$SEQ
minvalue 1
maxvalue 999999999999999999999999
start with 1342
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_TEST_RESOURCE$SEQ
prompt ========================================
prompt
create sequence AIGA.AIGA_TEST_RESOURCE$SEQ
minvalue 1
maxvalue 10000000000000000000000
start with 221
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_TEST_SUB_ELEM$SEQ
prompt ========================================
prompt
create sequence AIGA.AIGA_TEST_SUB_ELEM$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 378
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_TEST_SUB_REASON$SEQ
prompt ==========================================
prompt
create sequence AIGA.AIGA_TEST_SUB_REASON$SEQ
minvalue 1
maxvalue 9999999999999999999999999
start with 465
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_TEST_SUB_TASK$SEQ
prompt ========================================
prompt
create sequence AIGA.AIGA_TEST_SUB_TASK$SEQ
minvalue 1
maxvalue 9999999999999999999999999
start with 628
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_TEST_TASK$SEQ
prompt ====================================
prompt
create sequence AIGA.AIGA_TEST_TASK$SEQ
minvalue 1
maxvalue 10000000000000000000000
start with 4288
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_TEST_VERSION$SEQ
prompt =======================================
prompt
create sequence AIGA.AIGA_TEST_VERSION$SEQ
minvalue 1
maxvalue 999999999999999999999999
start with 220
increment by 1
cache 20;

prompt
prompt Creating sequence AIGA_USER$SEQ
prompt ===============================
prompt
create sequence AIGA.AIGA_USER$SEQ
minvalue 1
maxvalue 9999999999999999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating sequence ALM_ATTACHMENT$SEQ
prompt ====================================
prompt
create sequence AIGA.ALM_ATTACHMENT$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 143
increment by 1
cache 20;

prompt
prompt Creating sequence ALM_ATTACH_TYPE_CONFIG$SEQ
prompt ============================================
prompt
create sequence AIGA.ALM_ATTACH_TYPE_CONFIG$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence ALM_ATT_OBJ_RELA$SEQ
prompt ======================================
prompt
create sequence AIGA.ALM_ATT_OBJ_RELA$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence ALM_ATT_PACKAGE$SEQ
prompt =====================================
prompt
create sequence AIGA.ALM_ATT_PACKAGE$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 143
increment by 1
cache 20;

prompt
prompt Creating sequence ALM_ATT_TYPE_DEF$SEQ
prompt ======================================
prompt
create sequence AIGA.ALM_ATT_TYPE_DEF$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence ALM_BALANCE_ITEM$SEQ
prompt ======================================
prompt
create sequence AIGA.ALM_BALANCE_ITEM$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence ALM_HIS_STAKEHOLDER$SEQ
prompt =========================================
prompt
create sequence AIGA.ALM_HIS_STAKEHOLDER$SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 8306
increment by 1
nocache;

prompt
prompt Creating sequence ALM_HIS_WORKORDER$SEQ
prompt =======================================
prompt
create sequence AIGA.ALM_HIS_WORKORDER$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 109
increment by 1
nocache;

prompt
prompt Creating sequence ALM_STAKEHOLDER$SEQ
prompt =====================================
prompt
create sequence AIGA.ALM_STAKEHOLDER$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 11479
increment by 1
nocache;

prompt
prompt Creating sequence ALM_WORKFLOW$SEQ
prompt ==================================
prompt
create sequence AIGA.ALM_WORKFLOW$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence ALM_WORKORDER$SEQ
prompt ===================================
prompt
create sequence AIGA.ALM_WORKORDER$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 108435
increment by 1
nocache;

prompt
prompt Creating sequence DONE_CODE$SEQ
prompt ===============================
prompt
create sequence AIGA.DONE_CODE$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 7490
increment by 1
cache 20;

prompt
prompt Creating sequence MXM$SEQ
prompt =========================
prompt
create sequence AIGA.MXM$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 50
increment by 1
cache 20;

prompt
prompt Creating sequence SQ_SOFTWARE_EDITION_SLA
prompt =========================================
prompt
create sequence AIGA.SQ_SOFTWARE_EDITION_SLA
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence STAT_KPI_TARGET$SEQ
prompt =====================================
prompt
create sequence AIGA.STAT_KPI_TARGET$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 300
increment by 1
cache 20;

prompt
prompt Creating sequence SYS_ATTACH$SEQ
prompt ================================
prompt
create sequence AIGA.SYS_ATTACH$SEQ
minvalue 0
maxvalue 10000
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SYS_AUTHOR$SEQ
prompt ================================
prompt
create sequence AIGA.SYS_AUTHOR$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 1478
increment by 1
nocache;

prompt
prompt Creating sequence SYS_CONSTANT$SEQ
prompt ==================================
prompt
create sequence AIGA.SYS_CONSTANT$SEQ
minvalue 1
maxvalue 10000000000000000000000
start with 3093
increment by 1
cache 20;

prompt
prompt Creating sequence SYS_DIRECTORY$SEQ
prompt ===================================
prompt
create sequence AIGA.SYS_DIRECTORY$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SYS_EMPLOYEE$SEQ
prompt ==================================
prompt
create sequence AIGA.SYS_EMPLOYEE$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 1836
increment by 1
nocache;

prompt
prompt Creating sequence SYS_FUNCTION$SEQ
prompt ==================================
prompt
create sequence AIGA.SYS_FUNCTION$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 123
increment by 1
nocache;

prompt
prompt Creating sequence SYS_LOGIN_LOG$SEQ
prompt ===================================
prompt
create sequence AIGA.SYS_LOGIN_LOG$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 66032
increment by 1
nocache;

prompt
prompt Creating sequence SYS_MO$SEQ
prompt ============================
prompt
create sequence AIGA.SYS_MO$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SYS_MO_ATTR$SEQ
prompt =================================
prompt
create sequence AIGA.SYS_MO_ATTR$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence SYS_MO_OP$SEQ
prompt ===============================
prompt
create sequence AIGA.SYS_MO_OP$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SYS_NOTIFY$SEQ
prompt ================================
prompt
create sequence AIGA.SYS_NOTIFY$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SYS_OPERATE_LOG$SEQ
prompt =====================================
prompt
create sequence AIGA.SYS_OPERATE_LOG$SEQ
minvalue 1
maxvalue 100000000000
start with 11665
increment by 1
nocache;

prompt
prompt Creating sequence SYS_OPERATOR$SEQ
prompt ==================================
prompt
create sequence AIGA.SYS_OPERATOR$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SYS_OP_ACCT$SEQ
prompt =================================
prompt
create sequence AIGA.SYS_OP_ACCT$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SYS_ORGANIZE$SEQ
prompt ==================================
prompt
create sequence AIGA.SYS_ORGANIZE$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 23
increment by 1
nocache;

prompt
prompt Creating sequence SYS_ORG_DISTRICT_RELATE$SEQ
prompt =============================================
prompt
create sequence AIGA.SYS_ORG_DISTRICT_RELATE$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SYS_PERMISSION$SEQ
prompt ====================================
prompt
create sequence AIGA.SYS_PERMISSION$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 3
increment by 1
cache 20;

prompt
prompt Creating sequence SYS_ROLE$SEQ
prompt ==============================
prompt
create sequence AIGA.SYS_ROLE$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 27
increment by 1
nocache;

prompt
prompt Creating sequence SYS_ROLE_STATIONTYPE$SEQ
prompt ==========================================
prompt
create sequence AIGA.SYS_ROLE_STATIONTYPE$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 5
increment by 1
nocache;

prompt
prompt Creating sequence SYS_STAFF$SEQ
prompt ===============================
prompt
create sequence AIGA.SYS_STAFF$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 1936
increment by 1
nocache;

prompt
prompt Creating sequence SYS_STAFF_IPMAC_BAND$SEQ
prompt ==========================================
prompt
create sequence AIGA.SYS_STAFF_IPMAC_BAND$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SYS_STAFF_ORG_RELAT$SEQ
prompt =========================================
prompt
create sequence AIGA.SYS_STAFF_ORG_RELAT$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 1953
increment by 1
nocache;

prompt
prompt Creating sequence SYS_STAFF_ROLE_AUTHOR$SEQ
prompt ===========================================
prompt
create sequence AIGA.SYS_STAFF_ROLE_AUTHOR$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 2081
increment by 1
nocache;

prompt
prompt Creating sequence SYS_STAFF_VERIFY_CODE$SEQ
prompt ===========================================
prompt
create sequence AIGA.SYS_STAFF_VERIFY_CODE$SEQ
minvalue 1
maxvalue 99999999999999999999999
start with 3
increment by 1
cache 20;

prompt
prompt Creating sequence SYS_STATION$SEQ
prompt =================================
prompt
create sequence AIGA.SYS_STATION$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 44
increment by 1
nocache;

prompt
prompt Creating sequence SYS_STATIONTYPE_FUNC$SEQ
prompt ==========================================
prompt
create sequence AIGA.SYS_STATIONTYPE_FUNC$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 5980
increment by 1
nocache;

prompt
prompt Creating sequence SYS_STATIONTYPE_ORGROLE_RE$SEQ
prompt ================================================
prompt
create sequence AIGA.SYS_STATIONTYPE_ORGROLE_RE$SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 103
increment by 1
cache 20;

prompt
prompt Creating sequence SYS_STATION_TYPE$SEQ
prompt ======================================
prompt
create sequence AIGA.SYS_STATION_TYPE$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 43
increment by 1
cache 20;

prompt
prompt Creating sequence SYS_STATION_TYPE_KIND$SEQ
prompt ===========================================
prompt
create sequence AIGA.SYS_STATION_TYPE_KIND$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 43
increment by 1
cache 20;

prompt
prompt Creating sequence SYS_STATTYPE_ORGROLE_RELA$SEQ
prompt ===============================================
prompt
create sequence AIGA.SYS_STATTYPE_ORGROLE_RELA$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SYS_USER_DESKTOP$SEQ
prompt ======================================
prompt
create sequence AIGA.SYS_USER_DESKTOP$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 3
increment by 1
cache 20;

prompt
prompt Creating sequence SYS_USER_GROUP$SEQ
prompt ====================================
prompt
create sequence AIGA.SYS_USER_GROUP$SEQ
minvalue 1
maxvalue 1000000000
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SYS_USER_GROUP_RELATE$SEQ
prompt ===========================================
prompt
create sequence AIGA.SYS_USER_GROUP_RELATE$SEQ
minvalue 1
maxvalue 1000000000
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence VM_ALARM_CONFIG$SEQ
prompt =====================================
prompt
create sequence AIGA.VM_ALARM_CONFIG$SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence VM_ENGINE_TEMPLATE$SEQ
prompt ========================================
prompt
create sequence AIGA.VM_ENGINE_TEMPLATE$SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence VM_EXCEPTION_RECORD$SEQ
prompt =========================================
prompt
create sequence AIGA.VM_EXCEPTION_RECORD$SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence VM_EXCEPTION_RULE$SEQ
prompt =======================================
prompt
create sequence AIGA.VM_EXCEPTION_RULE$SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence VM_TASK$SEQ
prompt =============================
prompt
create sequence AIGA.VM_TASK$SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 996
increment by 1
nocache;

prompt
prompt Creating sequence VM_TEMPLATE$SEQ
prompt =================================
prompt
create sequence AIGA.VM_TEMPLATE$SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence VM_WORKFLOW_ATTR$SEQ
prompt ======================================
prompt
create sequence AIGA.VM_WORKFLOW_ATTR$SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence VM_WORK_FLOW$SEQ
prompt ==================================
prompt
create sequence AIGA.VM_WORK_FLOW$SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 458
increment by 1
nocache;

prompt
prompt Creating view ALM_ATT_PACK_VIEW
prompt ===============================
prompt
create or replace view aiga.alm_att_pack_view as
select a.obj_id,
        a.wo_id,
        a.obj_no,
        a.obj_type,
        a.att_pack_id,
        a.att_pack_desc,
        b.att_id,
        b.att_name,
        b.att_path,
        b.att_type,
        b.att_desc,
        b.submitter_tag,
        b.submit_time,
        b.submit_link,
        e.vm_task_name   as status,
        b.att_name      as att_type_name,
        d.employee_name
   from alm_att_package a, alm_attachment b, sys_staff c, sys_employee d,alm_workflow e
  where a.att_id = b.att_id
    and b.submitter_tag = c.code
    and c.employee_id = d.employee_id
    and e.link_no = b.submit_link
    and a.obj_no is not null;

prompt
prompt Creating view ALM_STAFF_ORGANIZE_VIEW
prompt =====================================
prompt
create or replace view aiga.alm_staff_organize_view as
select g.Aorganize_id,
       g.Aorganize_name,
       g.Acode,
       f.staff_id,
       f.organize_id,
       f.organize_name,
       f.code
  from (select d.organize_id Aorganize_id,
               d.organize_name Aorganize_name,
               d.code Acode,
               b.*
          from sys_organize b,
               (select a.*
                  from sys_organize a
                 where length(a.code) = 2
                   and a.org_role_type_id != 5
                   and a.parent_organize_id != -1) d
         where b.code like d.code || '%'
         order by Aorganize_id, b.parent_organize_id, b.organize_id) g,
       (select c.staff_id, e.*
          from sys_organize e, sys_staff_org_relat c
         where e.organize_id = c.organize_id
           and length(e.code) > 1
           and e.org_role_type_id != 5
         order by e.organize_id) f
 where g.organize_id = f.organize_id;

prompt
prompt Creating view ALM_TOPO_VIEW
prompt ===========================
prompt
create or replace view aiga.alm_topo_view as
select distinct atr.no,atg.fpoint,atg.tpoint,atf.action,atc.cond,atf.fun,atf.servid,atg.drivnos,
        atr.driv_con_no,atg.drivno_fun,awf.template_id
from alm_topo_con atc,alm_topo_fun atf,alm_topo_rule atr,alm_topology atg,alm_workflow awf
where atc.fun_no = atf.no and atr.topo_con_no = atc.no and atg.no = atr.topo_no and(atg.fpoint=awf.link_id or atg.tpoint=awf.link_id);

prompt
prompt Creating view ALM_WORKORDER_LIST
prompt ================================
prompt
create or replace view aiga.alm_workorder_list as
select aw.order_id,atp.plan_id obj_id, aw.obj_type, atp.plan_tag obj_tag,atp.plan_name obj_name,(select phase_id from alm_workflow where link_id=aw.link_id) phase_id,awf.vm_task_name, aw.link_no, aw.link_id, aw.exec_staff_id, aw.exec_staff_no, se.employee_name, aw.create_time, aw.finish_time, aw.order_type, aw.result, aw.status,aw.opinion,atp.submit_staff_name,(select link_no_type from alm_workflow where link_id=aw.link_id) link_no_type,aw.parent_vm_task_id,aw.cond,awf.connect_point,awf.template_id,aw.advice_comp_time,atp.fact_complete_time
    from aiga_test_plan atp, alm_workorder aw, alm_workflow awf, sys_staff ssf, sys_employee se
    where atp.plan_id = aw.obj_id and aw.link_no = awf.link_no and aw.exec_staff_id = ssf.staff_id and ssf.employee_id = se.employee_id and aw.obj_type=1
    union
select aw.order_id,atp.plan_id obj_id, aw.obj_type, atp.plan_tag obj_tag, atp.plan_name obj_name,(select phase_id from alm_workflow where link_id=aw.link_id) phase_id, awf.vm_task_name, aw.link_no, aw.link_id, aw.exec_staff_id, aw.exec_staff_no, se.employee_name, aw.create_time, aw.finish_time, aw.order_type, aw.result, aw.status, aw.opinion,atp.submit_staff_name,(select link_no_type from alm_workflow where link_id=aw.link_id) link_no_type,aw.parent_vm_task_id,aw.cond,awf.connect_point,awf.template_id,aw.advice_comp_time,atp.fact_complete_time
    from aiga_test_plan atp, alm_his_workorder aw, alm_workflow awf, sys_staff ssf, sys_employee se
    where atp.plan_id = aw.obj_id and aw.link_no = awf.link_no and aw.exec_staff_id = ssf.staff_id and ssf.employee_id = se.employee_id and aw.obj_type=1
    union
select aw.order_id,att.task_id obj_id, aw.obj_type, att.task_tag obj_tag,att.task_name obj_name,(select phase_id from alm_workflow where link_id=aw.link_id) phase_id,awf.vm_task_name, aw.link_no, aw.link_id, aw.exec_staff_id, aw.exec_staff_no, se.employee_name, aw.create_time, aw.finish_time, aw.order_type, aw.result, aw.status,aw.opinion,att.submit_staff_name,(select link_no_type from alm_workflow where link_id=aw.link_id) link_no_type,aw.parent_vm_task_id,aw.cond,awf.connect_point,awf.template_id,aw.advice_comp_time,att.fact_complete_time
    from aiga_test_task att, alm_workorder aw, alm_workflow awf, sys_staff ssf, sys_employee se
    where aw.link_no<>'testTaskRunning' and aw.link_no<>'uetTaskRunning' and aw.link_no<>'perTestTaskRunning' and att.task_id = aw.obj_id and aw.link_no = awf.link_no and aw.exec_staff_id = ssf.staff_id and ssf.employee_id = se.employee_id and (aw.obj_type=3 or aw.obj_type=7 or aw.obj_type=9)
    union
select aw.order_id,att.task_id obj_id, aw.obj_type, att.task_tag obj_tag, att.task_name obj_name,(select phase_id from alm_workflow where link_id=aw.link_id) phase_id, awf.vm_task_name, aw.link_no, aw.link_id, aw.exec_staff_id, aw.exec_staff_no, se.employee_name, aw.create_time, aw.finish_time, aw.order_type, aw.result, aw.status, aw.opinion,att.submit_staff_name,(select link_no_type from alm_workflow where link_id=aw.link_id) link_no_type,aw.parent_vm_task_id,aw.cond,awf.connect_point,awf.template_id,aw.advice_comp_time,att.fact_complete_time
    from aiga_test_task att, alm_his_workorder aw, alm_workflow awf, sys_staff ssf, sys_employee se
    where aw.link_no<>'testTaskRunning' and aw.link_no<>'uetTaskRunning' and aw.link_no<>'perTestTaskRunning' and att.task_id = aw.obj_id and aw.link_no = awf.link_no and aw.exec_staff_id = ssf.staff_id and ssf.employee_id = se.employee_id and (aw.obj_type=3 or aw.obj_type=7 or aw.obj_type=9)
    union
select aw.order_id,ast.task_id obj_id, aw.obj_type, ast.plan_tag obj_tag,ast.plan_name obj_name,(select phase_id from alm_workflow where link_id=aw.link_id) phase_id,awf.vm_task_name, aw.link_no, aw.link_id, aw.exec_staff_id, aw.exec_staff_no, se.employee_name, aw.create_time, aw.finish_time, aw.order_type, aw.result, aw.status,aw.opinion,ast.submit_staff_name,(select link_no_type from alm_workflow where link_id=aw.link_id) link_no_type,aw.parent_vm_task_id,aw.cond,awf.connect_point,awf.template_id,aw.advice_comp_time,ast.fact_complete_time
    from aiga_solid_task ast, alm_workorder aw, alm_workflow awf, sys_staff ssf, sys_employee se
    where ast.task_id = aw.obj_id and aw.link_no = awf.link_no and aw.exec_staff_id = ssf.staff_id and ssf.employee_id = se.employee_id and (aw.obj_type=21 or aw.obj_type=22 or aw.obj_type=23 or aw.obj_type=24 or aw.obj_type=25)
    union
select aw.order_id,ast.task_id obj_id, aw.obj_type, ast.plan_tag obj_tag, ast.plan_name obj_name,(select phase_id from alm_workflow where link_id=aw.link_id) phase_id, awf.vm_task_name, aw.link_no, aw.link_id, aw.exec_staff_id, aw.exec_staff_no, se.employee_name, aw.create_time, aw.finish_time, aw.order_type, aw.result, aw.status, aw.opinion,ast.submit_staff_name,(select link_no_type from alm_workflow where link_id=aw.link_id) link_no_type,aw.parent_vm_task_id,aw.cond,awf.connect_point,awf.template_id,aw.advice_comp_time,ast.fact_complete_time
    from aiga_solid_task ast, alm_his_workorder aw, alm_workflow awf, sys_staff ssf, sys_employee se
    where ast.task_id = aw.obj_id and aw.link_no = awf.link_no and aw.exec_staff_id = ssf.staff_id and ssf.employee_id = se.employee_id and (aw.obj_type=21 or aw.obj_type=22 or aw.obj_type=23 or aw.obj_type=24 or aw.obj_type=25)
union
select aw.order_id,atst.sub_task_id obj_id, aw.obj_type, atst.sub_task_tag obj_tag,atst.sub_task_name obj_name,(select phase_id from alm_workflow where link_id=aw.link_id) phase_id,awf.vm_task_name, aw.link_no, aw.link_id, aw.exec_staff_id, aw.exec_staff_no, se.employee_name, aw.create_time, aw.finish_time, aw.order_type, aw.result, aw.status,aw.opinion,atst.submit_staff_name,(select link_no_type from alm_workflow where link_id=aw.link_id) link_no_type,aw.parent_vm_task_id,aw.cond,awf.connect_point,awf.template_id,aw.advice_comp_time,atst.fact_complete_time
    from aiga_test_sub_task atst, alm_workorder aw, alm_workflow awf, sys_staff ssf, sys_employee se
    where atst.sub_task_id = aw.obj_id and aw.link_no = awf.link_no and aw.exec_staff_id = ssf.staff_id and ssf.employee_id = se.employee_id and (aw.obj_type=4 or aw.obj_type=5 or aw.obj_type=6)
    union
select aw.order_id,atst.sub_task_id obj_id, aw.obj_type, atst.sub_task_tag obj_tag, atst.sub_task_name obj_name,(select phase_id from alm_workflow where link_id=aw.link_id) phase_id, awf.vm_task_name, aw.link_no, aw.link_id, aw.exec_staff_id, aw.exec_staff_no, se.employee_name, aw.create_time, aw.finish_time, aw.order_type, aw.result, aw.status, aw.opinion,atst.submit_staff_name,(select link_no_type from alm_workflow where link_id=aw.link_id) link_no_type,aw.parent_vm_task_id,aw.cond,awf.connect_point,awf.template_id,aw.advice_comp_time,atst.fact_complete_time
    from aiga_test_sub_task atst, alm_his_workorder aw, alm_workflow awf, sys_staff ssf, sys_employee se
    where atst.sub_task_id = aw.obj_id and aw.link_no = awf.link_no and aw.exec_staff_id = ssf.staff_id and ssf.employee_id = se.employee_id and (aw.obj_type=4 or aw.obj_type=5 or aw.obj_type=6)
    union
select aw.order_id,asp.id obj_id, aw.obj_type, asp.stp_tag obj_tag,asp.stp_name obj_name,(select phase_id from alm_workflow where link_id=aw.link_id) phase_id,awf.vm_task_name, aw.link_no, aw.link_id, aw.exec_staff_id, aw.exec_staff_no, se.employee_name, aw.create_time, aw.finish_time, aw.order_type, aw.result, aw.status,aw.opinion,asp.create_staff_name,(select link_no_type from alm_workflow where link_id=aw.link_id) link_no_type,aw.parent_vm_task_id,aw.cond,awf.connect_point,awf.template_id,aw.advice_comp_time,null as fact_complete_time
    from aiga_subtask_problem asp, alm_workorder aw, alm_workflow awf, sys_staff ssf, sys_employee se
    where asp.id = aw.obj_id and aw.link_no = awf.link_no and aw.exec_staff_id = ssf.staff_id and ssf.employee_id = se.employee_id and aw.obj_type=8
    union
select aw.order_id,asp.id obj_id, aw.obj_type, asp.stp_tag obj_tag, asp.stp_name obj_name,(select phase_id from alm_workflow where link_id=aw.link_id) phase_id, awf.vm_task_name, aw.link_no, aw.link_id, aw.exec_staff_id, aw.exec_staff_no, se.employee_name, aw.create_time, aw.finish_time, aw.order_type, aw.result, aw.status, aw.opinion,asp.create_staff_name,(select link_no_type from alm_workflow where link_id=aw.link_id) link_no_type,aw.parent_vm_task_id,aw.cond,awf.connect_point,awf.template_id,aw.advice_comp_time,null as fact_complete_time
    from aiga_subtask_problem asp, alm_his_workorder aw, alm_workflow awf, sys_staff ssf, sys_employee se
    where asp.id = aw.obj_id and aw.link_no = awf.link_no and aw.exec_staff_id = ssf.staff_id and ssf.employee_id = se.employee_id and aw.obj_type=8;

prompt
prompt Creating view STAFF_ROLE_ORG_DIST_VIEW
prompt ======================================
prompt
create or replace view aiga.staff_role_org_dist_view as
select distinct ssra.role_id role_id,sr.code role_code,sr.name role_name,ssra.staff_id,
         ss.code code,se.employee_name staff_name,ssor.organize_id,so.organize_name,d.district_id,so.parent_organize_id,sugr.group_id,
       (  select ssp.param_value as workday_coefficient from sys_staff_param ssp where ssp.param_key='workdayCoefficient' and ssp.staff_id= ssra.staff_id )as staff_workday_coefficient
       from sys_staff_role_author ssra,sys_staff_org_relat ssor,sys_organize so, district d,sys_role sr,sys_employee se,sys_staff ss,sys_user_group_relate sugr
   where ssra.staff_id=ssor.staff_id and so.district_id=d.district_id(+) and sr.role_id=ssra.role_id and ssor.organize_id=so.organize_id
   and ssra.staff_id=ss.staff_id and ss.employee_id=se.employee_id and ssra.staff_id !=1 and sugr.staff_id(+)=ssra.staff_id and ssra.state=1;

prompt
prompt Creating view VM_TASK_VIEW
prompt ==========================
prompt
CREATE OR REPLACE VIEW AIGA.VM_TASK_VIEW AS
SELECT A.TASK_ID,-1 PARENT_TASK_ID,a.LAST_TASK_ID ,a.TASK_TAG,A.TASK_TYPE,a.TASK_BASE_TYPE,a.TASK_TEMPLATE_ID,A.DURATION,A.LABEL,A.DECISION_RESULT,A.IS_CURRENT_TASK,A.STATE_DATE,A.CREATE_DATE,A.STATION_ID,
A.TASK_STAFF_ID,A.LOCK_STAFF_ID,A.LOCK_DATE,A.FINISH_STAFF_ID,A.FINISH_DATE,A.ERROR_MESSAGE,A.DESCRIPTION,a.WARNING_DATE,a.WARNING_TIMES,
A.STATE,B.TASK_ID AS WORKFLOW_ID,B.TASK_TEMPLATE_ID AS WORKFLOW_TASK_TEMPLATE_ID,B.PARENT_TASK_ID AS WORKFLOW_PARENT_TASK_ID,B.IS_EXCEPTION_WORKFLOW,B.WORKFLOW_OBJECT_ID,B.WORKFLOW_OBJECT_TYPE_ID,B.TASK_TAG AS WORKFLOW_CODE,B.ERROR_MESSAGE AS WORKFLOW_ERROR_MESSAGE,
B.LABEL AS WORKFLOW_NAME,B.STATE AS WORKFLOW_STATE,B.DURATION AS WORKFLOW_DURATION,B.CREATE_STAFF_ID AS WORKFLOW_CREATE_STAFF_ID,B.CREATE_DATE AS WORKFLOW_CREATE_DATE,B.QUEUE_ID,B.WARNING_DATE AS WORKFLOW_WARNING_DATE,B.WARNING_TIMES AS WORKFLOW_WARNING_TIMES
FROM VM_TASK A,VM_WORK_FLOW B
WHERE A.WORKFLOW_ID = B.TASK_ID
union all
SELECT A.TASK_ID,A.PARENT_TASK_ID,to_char(a.parent_task_id) LAST_TASK_ID,a.TASK_TAG,A.TASK_TYPE,a.TASK_BASE_TYPE,-1 TASK_TEMPLATE_ID,A.DURATION,A.LABEL,A.DECISION_RESULT,A.IS_CURRENT_TASK,A.STATE_DATE,A.CREATE_DATE,A.STATION_ID,
A.TASK_STAFF_ID,A.LOCK_STAFF_ID,A.LOCK_DATE,A.FINISH_STAFF_ID,A.FINISH_DATE,A.ERROR_MESSAGE,A.DESCRIPTION,a.WARNING_DATE,a.WARNING_TIMES,
A.STATE,B.TASK_ID AS WORKFLOW_ID,B.TASK_TEMPLATE_ID AS WORKFLOW_TASK_TEMPLATE_ID,B.PARENT_TASK_ID AS WORKFLOW_PARENT_TASK_ID,B.IS_EXCEPTION_WORKFLOW,B.WORKFLOW_OBJECT_ID,B.WORKFLOW_OBJECT_TYPE_ID,B.TASK_TAG AS WORKFLOW_CODE,B.ERROR_MESSAGE AS WORKFLOW_ERROR_MESSAGE,
B.LABEL AS WORKFLOW_NAME,B.STATE AS WORKFLOW_STATE,B.DURATION AS WORKFLOW_DURATION,B.CREATE_STAFF_ID AS WORKFLOW_CREATE_STAFF_ID,B.CREATE_DATE AS WORKFLOW_CREATE_DATE,B.QUEUE_ID,B.WARNING_DATE AS WORKFLOW_WARNING_DATE,B.WARNING_TIMES AS WORKFLOW_WARNING_TIMES
FROM VM_TASK_TRANS A,VM_WORK_FLOW B
WHERE A.WORKFLOW_ID = B.TASK_ID;

prompt
prompt Creating type CONCATSTRIMPL
prompt ===========================
prompt
create or replace type aiga.ConcatStrImpl as object
(
  default_str varchar2(32767), -- 也只能这么大，再大就越界了
  sep varchar2(100), --定义分隔符，以便以后使用
  static function ODCIAggregateInitialize(sctx IN OUT ConcatStrImpl)
  return number,
  member function ODCIAggregateIterate(self IN OUT ConcatStrImpl,
    value IN varchar2) return number,
  member function ODCIAggregateIterate(self IN OUT ConcatStrImpl,
    value IN ConcatObj) return number,
  member function ODCIAggregateTerminate(self IN ConcatStrImpl,
    returnValue OUT varchar2, flags IN number) return number,
  member function ODCIAggregateMerge(self IN OUT ConcatStrImpl,
    ctx2 IN ConcatStrImpl) return number
)
/

prompt
prompt Creating type STRCAT_TYPE
prompt =========================
prompt
create or replace type aiga.strcat_type as object (
    cat_string varchar2(4000),
    static function ODCIAggregateInitialize(cs_ctx In Out strcat_type) return number,
    member function ODCIAggregateIterate(self In Out strcat_type,value in varchar2) return

number,
    member function ODCIAggregateMerge(self In Out strcat_type,ctx2 In Out strcat_type)

return number,
    member function ODCIAggregateTerminate(self In Out strcat_type,returnValue Out

varchar2,flags in number) return number
)
/

prompt
prompt Creating function ROLE_STRCAT
prompt =============================
prompt
create or replace function aiga.role_strcat(str_in in varchar) return varchar2 is
       str_list varchar2(4000);
       str varchar2(20);
begin
  FOR x IN (select SR.CODE FROM SYS_STAFF_ROLE_AUTHOR SSRA, SYS_ROLE SR WHERE SSRA.ROLE_ID = SR.ROLE_ID AND SSRA.STAFF_ID = str_in )loop
      str_list := str_list || str || to_char(x.code);
      str := ',';
    end loop;
  return(str_list);
end role_strcat;
/

prompt
prompt Creating type body CONCATSTRIMPL
prompt ================================
prompt
create or replace type body aiga.ConcatStrImpl is
static function ODCIAggregateInitialize(sctx IN OUT ConcatStrImpl)
return number is
begin
  sctx:= ConcatStrImpl(null);
  sctx:= ConcatStrImpl(null,null);
  return ODCIConst.Success;
end;

member function ODCIAggregateIterate(self IN OUT ConcatStrImpl,
  value IN varchar2) return number is
begin
  if self.default_str is not null then
    self.default_str := self.default_str || ',' || value; -- 逗号分隔
  else
    self.default_str:= value;
  end if;
  return ODCIConst.Success;
end;

member function ODCIAggregateIterate(self IN OUT ConcatStrImpl,
  value IN ConcatObj) return number is
begin
  if self.default_str is not null and value.fieldValue is not null  then
    self.default_str := self.default_str || self.sep|| value.fieldValue;
  elsif value.fieldValue is not null then
    self.default_str:= value.fieldValue;
    self.sep:= value.separator;
  end if;
  return ODCIConst.Success;
end;

member function ODCIAggregateTerminate(self IN ConcatStrImpl,
    returnValue OUT varchar2, flags IN number) return number is
begin
  returnValue := self.default_str;
  return ODCIConst.Success;
end;

member function ODCIAggregateMerge(self IN OUT ConcatStrImpl,
  ctx2 IN ConcatStrImpl) return number is
begin
  if ctx2.default_str is not null then
    self.default_str := self.default_str || ',' ||ctx2.default_str;
  end if;
  return ODCIConst.Success;
end;
member function ODCIAggregateMerge(self IN OUT ConcatStrImpl,
  ctx2 IN ConcatStrImpl) return number is
begin
  if ctx2.default_str is not null and self.default_str is not null then
    self.default_str := self.default_str || self.sep||ctx2.default_str;
  elsif ctx2.default_str is not null then
    self.default_str := ctx2.default_str;
 end if;
 return ODCIConst.Success;
end;
end;
/

prompt
prompt Creating trigger AIGA_CASE_INDEX_TRIGGER
prompt ========================================
prompt
create or replace trigger AIGA.aiga_case_index_trigger
after insert on aiga_inst_case
for each row
  
begin
    if(true) then
      insert into aiga_ext_index(ext_id,index_class,index_id_name,index_id_value,ext_field_1,ext_field_2,ext_field_1_val,ext_field_2_val)
      values(aiga_ext_index$seq.nextval,'com.asiainfo.aiga.userCase.bo.AigaCase','caseId',:new.case_id,
      'caseName','caseDesc',:new.case_name,:new.case_desc);
         end if;
    end;
/

prompt
prompt Creating trigger AIGA_COMPONENT_TRIGGER
prompt =======================================
prompt
create or replace trigger AIGA.aiga_component_trigger
  after update or delete on aiga.aiga_base_component
  FOR EACH ROW
begin
  insert into AIGA_His_component
    (comp_id,
     parent_id,
     comp_name,
     permission,
     path,
     default_val,
     comp_desc,
     create_time,
     update_time,
     author,
     latest_operator,
     hashcode,
     url,
     extra,
     is_leaf,
     author_no,
     CHANGE_TIME)
  values
    (:old.comp_id,
     :old.parent_id,
     :old.comp_name,
     :old.permission,
     :old.path,
     :old.default_val,
     :old.comp_desc,
     :old.create_time,
     :old.update_time,
     :old.author,
     :old.latest_operator,
     :old.hashcode,
     :old.url,
     :old.extra,
     :old.is_leaf,
     :old.author_no,
     sysdate);
end;
/

prompt
prompt Creating trigger AIGA_FUN_FOLDER_INDEX_TRIGGER
prompt ==============================================
prompt
create or replace trigger AIGA.aiga_fun_folder_index_trigger
after insert on aiga_fun_folder
for each row
  
begin
      insert into aiga_ext_index(ext_id,index_class,index_id_name,index_id_value,ext_field_1,ext_field_2,ext_field_1_val,ext_field_2_val)
      values(aiga_ext_index$seq.nextval,'com.asiainfo.aiga.userCase.bo.AigaFunFolder','funId',:new.fun_id,
      'sysName','funDesc',:new.sys_name||',,,'||:new.menu_path,:new.fun_desc);
    end;
/

prompt
prompt Creating trigger AIGA_GUI_TRIGGER
prompt =================================
prompt
create or replace trigger AIGA.aiga_gui_trigger
  after update or delete on aiga.aiga_base_gui
  FOR EACH ROW
begin
  insert into AIGA_HIS_GUI
    (gui_id,
     gui_selector,
     gui_url,
     gui_tag,
     parent_id,
     gui_name,
     gui_permission,
     gui_path,
     gui_extra,
     gui_desc,
     gui_html,
     gui_create_time,
     gui_update_time,
     gui_author,
     gui_bounds,
     gui_hashcode,
     gui_latest_operator,
     gui_thumb_url,
     change_time)
  values
    (:old.gui_id,
     :old.gui_selector,
     :old.gui_url,
     :old.gui_tag,
     :old.parent_id,
     :old.gui_name,
     :old.gui_permission,
     :old.gui_path,
     :old.gui_extra,
     :old.gui_desc,
     :old.gui_html,
     :old.gui_create_time,
     :old.gui_update_time,
     :old.gui_author,
     :old.gui_bounds,
     :old.gui_hashcode,
     :old.gui_latest_operator,
     :old.gui_thumb_url,
     sysdate);
end;
/

prompt
prompt Creating trigger AIGA_LABEL_INDEX_TRIGGER
prompt =========================================
prompt
create or replace trigger AIGA.aiga_label_index_trigger
after insert on aiga_label
for each row
  
begin
    if(:new.parent_id=51) then
      insert into aiga_ext_index(ext_id,index_class,index_id_name,index_id_value,ext_field_1,ext_field_2,ext_field_1_val,ext_field_2_val)
      values(aiga_ext_index$seq.nextval,'com.asiainfo.aiga.label.bo.AigaLabel','labelId',:new.label_id,
      'labelName','labelDesc',:new.label_name,:new.label_desc);
         end if;
    end;
/

prompt
prompt Creating trigger AIGA_REQUISITION_INDEX_TRIGGER
prompt ===============================================
prompt
create or replace trigger AIGA.aiga_requisition_index_trigger
after insert on aiga_requisition
for each row
  
begin
      insert into aiga_ext_index(ext_id,index_class,index_id_name,index_id_value,ext_field_1,ext_field_2,ext_field_1_val,ext_field_2_val)
      values(aiga_ext_index$seq.nextval,'com.asiainfo.aiga.requisition.bo.AigaRequisition','reqId',:new.req_id,
      'reqName','reqDesc',:new.req_name,:new.req_desc);
    end;
/


spool off
