-- Add/modify columns 
alter table AIGA_FUN_FOLDER add creator_id NUMBER(20);
alter table AIGA_FUN_FOLDER add creator_name VARCHAR2(255);
-- Add comments to the columns 
comment on column AIGA_FUN_FOLDER.creator_id
  is '创建人ID';
comment on column AIGA_FUN_FOLDER.creator_name
  is '创建人名称';