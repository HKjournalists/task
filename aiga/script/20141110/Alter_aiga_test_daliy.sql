-- Add/modify columns 
alter table AIGA_TEST_DAILY modify staff_id number;
alter table AIGA_TEST_DAILY modify staff_code VARCHAR2(255);
alter table AIGA_TEST_DAILY add edit_staff_id number;
alter table AIGA_TEST_DAILY add edit_staff_code VARCHAR2(255);
alter table AIGA_TEST_DAILY add edit_staff_name VARCHAR2(255);
-- Add comments to the columns 
comment on column AIGA_TEST_DAILY.staff_id
  is 'Ա��ID(��־������)';
comment on column AIGA_TEST_DAILY.staff_code
  is 'Ա���ʺ�(��־������)';
comment on column AIGA_TEST_DAILY.staff_name
  is 'Ա������(��־������)';
comment on column AIGA_TEST_DAILY.edit_staff_id
  is '��д��ID';
comment on column AIGA_TEST_DAILY.edit_staff_code
  is '��д���ʺ�';
comment on column AIGA_TEST_DAILY.edit_staff_name
  is '��д������';