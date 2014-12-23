-- Create table
create table AIGA_HIS_FUN_FOLDER
(
  his_fun_id           NUMBER(20) not null,
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
  dev_firm             NUMBER(4),
  sys_id_temp          VARCHAR2(255),
  sub_sys_id           NUMBER(20),
  sub_sys_id_temp      VARCHAR2(255),
  operator_id          NUMBER(20),
  operator_name        VARCHAR2(255)
)
tablespace TEST_DATA
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
-- Add comments to the columns 
comment on column AIGA_HIS_FUN_FOLDER.his_fun_id
  is '历史功能点ID';
comment on column AIGA_HIS_FUN_FOLDER.fun_id
  is '功能点ID';
comment on column AIGA_HIS_FUN_FOLDER.sys_name
  is '功能点名称';
comment on column AIGA_HIS_FUN_FOLDER.create_time
  is '创建日期';
comment on column AIGA_HIS_FUN_FOLDER.update_time
  is '更新日期';
comment on column AIGA_HIS_FUN_FOLDER.sys_id
  is '归属系统ID';
comment on column AIGA_HIS_FUN_FOLDER.busi_label
  is '业务标签';
comment on column AIGA_HIS_FUN_FOLDER.base_fun_label
  is '基础功能标签';
comment on column AIGA_HIS_FUN_FOLDER.data_check_script
  is '数据检查脚本';
comment on column AIGA_HIS_FUN_FOLDER.important_class
  is '重要级别';
comment on column AIGA_HIS_FUN_FOLDER.menu_path
  is '菜单路径';
comment on column AIGA_HIS_FUN_FOLDER.fun_type
  is '功能点类型';
comment on column AIGA_HIS_FUN_FOLDER.fun_desc
  is '功能点说明';
comment on column AIGA_HIS_FUN_FOLDER.is_invalid
  is '是否已被禁用(1:已被禁用,0:未被禁用)';
comment on column AIGA_HIS_FUN_FOLDER.add_reason_type
  is '新增原因类型';
comment on column AIGA_HIS_FUN_FOLDER.add_reason
  is '新增原因';
comment on column AIGA_HIS_FUN_FOLDER.efficiency_test_type
  is '性能测试类型';
comment on column AIGA_HIS_FUN_FOLDER.is_efficiency_test
  is '是否性能测试';
comment on column AIGA_HIS_FUN_FOLDER.dev_firm
  is '维护厂商';
comment on column AIGA_HIS_FUN_FOLDER.sys_id_temp
  is '导入时暂存归属系统数据';
comment on column AIGA_HIS_FUN_FOLDER.sub_sys_id
  is '子系统ID';
comment on column AIGA_HIS_FUN_FOLDER.sub_sys_id_temp
  is '导入时暂存归属子系统数据';
comment on column AIGA_HIS_FUN_FOLDER.operator_id
  is '操作人ID';
comment on column AIGA_HIS_FUN_FOLDER.operator_name
  is '操作人名称';
-- Create/Recreate primary, unique and foreign key constraints 
alter table AIGA_HIS_FUN_FOLDER
  add primary key (HIS_FUN_ID)
  using index 
  tablespace TEST_DATA
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
