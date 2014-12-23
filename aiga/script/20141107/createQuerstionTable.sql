-- Create table
create table AIGA_QUESTION
(
  AQ_ID          NUMBER(20) not null,
  AQ_REVIEW_TAG  VARCHAR2(255),
  AQ_NAME        VARCHAR2(400),
  AQ_SUBMITSTAFF VARCHAR2(255),
  AQ_STATE       NUMBER(4) default 0,
  AQ_SUBTIME     DATE,
  AQ_INTO        NUMBER(4),
  STP_MAIN_CLASS NUMBER(4),
  STP_SUB_CLASS  NUMBER(4),
  DEFECT_DSCR    VARCHAR2(4000),
  STP_DSCR       VARCHAR2(4000)
);
-- Add comments to the columns 
comment on column AIGA_QUESTION.AQ_ID
  is '问题主键';
comment on column AIGA_QUESTION.AQ_REVIEW_TAG
  is '评审编码外键';
comment on column AIGA_QUESTION.AQ_NAME
  is '问题名称';
comment on column AIGA_QUESTION.AQ_SUBMITSTAFF
  is '问题提出人';
comment on column AIGA_QUESTION.AQ_STATE
  is '问题状态';
comment on column AIGA_QUESTION.AQ_SUBTIME
  is '问题提出时间';
comment on column AIGA_QUESTION.AQ_INTO
  is '问题引入阶段';
comment on column AIGA_QUESTION.STP_MAIN_CLASS
  is '问题主类型';
comment on column AIGA_QUESTION.STP_SUB_CLASS
  is '问题子类型';
comment on column AIGA_QUESTION.DEFECT_DSCR
  is '缺陷描述';
comment on column AIGA_QUESTION.STP_DSCR
  is '问题备注';
-- Create/Recreate primary, unique and foreign key constraints 
alter table AIGA_QUESTION
  add primary key (AQ_ID);


-- Create sequence 
create sequence AIGA_QUESTION$SEQ
minvalue 1
maxvalue 9999999999999
start with 1
increment by 1
cache 20;