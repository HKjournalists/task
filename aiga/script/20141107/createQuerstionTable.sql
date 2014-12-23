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
  is '��������';
comment on column AIGA_QUESTION.AQ_REVIEW_TAG
  is '����������';
comment on column AIGA_QUESTION.AQ_NAME
  is '��������';
comment on column AIGA_QUESTION.AQ_SUBMITSTAFF
  is '���������';
comment on column AIGA_QUESTION.AQ_STATE
  is '����״̬';
comment on column AIGA_QUESTION.AQ_SUBTIME
  is '�������ʱ��';
comment on column AIGA_QUESTION.AQ_INTO
  is '��������׶�';
comment on column AIGA_QUESTION.STP_MAIN_CLASS
  is '����������';
comment on column AIGA_QUESTION.STP_SUB_CLASS
  is '����������';
comment on column AIGA_QUESTION.DEFECT_DSCR
  is 'ȱ������';
comment on column AIGA_QUESTION.STP_DSCR
  is '���ⱸע';
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