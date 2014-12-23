-- Add/modify columns 
alter table AIGA_TEST_DAILY modify staff_id number;
alter table AIGA_TEST_DAILY modify staff_code VARCHAR2(255);
alter table AIGA_TEST_DAILY add edit_staff_id number;
alter table AIGA_TEST_DAILY add edit_staff_code VARCHAR2(255);
alter table AIGA_TEST_DAILY add edit_staff_name VARCHAR2(255);
-- Add comments to the columns 
comment on column AIGA_TEST_DAILY.staff_id
  is '员工ID(日志所有者)';
comment on column AIGA_TEST_DAILY.staff_code
  is '员工帐号(日志所有者)';
comment on column AIGA_TEST_DAILY.staff_name
  is '员工名称(日志所有者)';
comment on column AIGA_TEST_DAILY.edit_staff_id
  is '填写人ID';
comment on column AIGA_TEST_DAILY.edit_staff_code
  is '填写人帐号';
comment on column AIGA_TEST_DAILY.edit_staff_name
  is '填写人名称';