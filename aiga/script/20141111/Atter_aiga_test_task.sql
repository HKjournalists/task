-- Add/modify columns 
alter table AIGA_TEST_TASK add req_type VARCHAR2(200) ;
-- Add comments to the columns 
comment on column AIGA_TEST_TASK.req_type
  is '需求类型';