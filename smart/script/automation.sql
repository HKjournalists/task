

--sequence
create sequence AUTO_MODULE$SEQ 
minvalue 1 
maxvalue 999999999999999999999999999 
start with 1 
increment by 1 
nocache;

create sequence AUTO_SUBMODULE$SEQ 
minvalue 1 
maxvalue 999999999999999999999999999 
start with 1 
increment by 1 
nocache;

create sequence AUTO_KEYWORD$SEQ 
minvalue 1 
maxvalue 999999999999999999999999999 
start with 1 
increment by 1 
nocache;

create sequence AUTO_KEYWORDDETAIL$SEQ 
minvalue 1 
maxvalue 999999999999999999999999999 
start with 1 
increment by 1 
nocache;

create sequence AUTO_ACTION$SEQ 
minvalue 1 
maxvalue 999999999999999999999999999 
start with 1 
increment by 1 
nocache;

create sequence AUTO_RULE$SEQ 
minvalue 1 
maxvalue 999999999999999999999999999 
start with 1 
increment by 1 
nocache;

create sequence AUTO_SCRIPT$SEQ 
minvalue 1 
maxvalue 999999999999999999999999999 
start with 1 
increment by 1 
nocache;

create sequence AUTO_SCRIPTDETAIL$SEQ 
minvalue 1 
maxvalue 999999999999999999999999999 
start with 1 
increment by 1 
nocache;

create sequence AUTO_TESTCASE$SEQ 
minvalue 1 
maxvalue 999999999999999999999999999 
start with 1 
increment by 1 
nocache;


create sequence AUTO_TESTCASEDETAIL$SEQ 
minvalue 1 
maxvalue 999999999999999999999999999 
start with 1 
increment by 1 
nocache;

create sequence auto_batch$SEQ 
minvalue 1 
maxvalue 999999999999999999999999999 
start with 1 
increment by 1 
nocache;

create sequence auto_batchdetail$SEQ 
minvalue 1 
maxvalue 999999999999999999999999999 
start with 1 
increment by 1 
nocache;

create sequence AUTO_PLATFORMEXECUTECONFIG$SEQ 
minvalue 1 
maxvalue 999999999999999999999999999 
start with 1 
increment by 1 
nocache;

--table
create table AUTO_MODULE
(
  moduleid   VARCHAR2(20) not null,
  modulename VARCHAR2(20) not null
);
alter table AUTO_MODULE
  add constraint PK_MODULE primary key (MODULEID)
  using index;
  
alter table AUTO_MODULE
  add constraint UK_MODULE unique (MODULENAME)
  using index; 
  
  
  
create table AUTO_SUBMODULE
(
  submoduleid   VARCHAR2(20) not null,
  moduleid      VARCHAR2(20) not null,
  submodulename VARCHAR2(20)
);


alter table AUTO_SUBMODULE
  add constraint PK_SUBMODULE primary key (SUBMODULEID)
  using index;
  
alter table AUTO_SUBMODULE
  add constraint UK_SUBMODULE unique (SUBMODULENAME)
  using index;
  
alter table AUTO_SUBMODULE
  add constraint FK_SUBMODULEID foreign key (MODULEID)
  references AUTO_MODULE (MODULEID) on delete set null;
  
  
  
create table AUTO_KEYWORD
(
  keywordid   VARCHAR2(20) not null,
  submoduleid VARCHAR2(20) not null,
  keywordname VARCHAR2(100),
  version     VARCHAR2(20) not null
);
alter table AUTO_KEYWORD
  add constraint PK_KEYWORD primary key (KEYWORDID)
  using index ;

alter table AUTO_KEYWORD
  add constraint UK_KEYWORD unique (KEYWORDNAME)
  using index;

alter table AUTO_KEYWORD
  add constraint FK_KEYWORD foreign key (SUBMODULEID)
  references AUTO_SUBMODULE (SUBMODULEID) on delete set null;
  
  
create table AUTO_KEYWORDDETAIL
(
  keyworddetailid VARCHAR2(20) not null,
  keywordid       VARCHAR2(20) not null,
  object          VARCHAR2(20) not null,
  operation       VARCHAR2(20) not null,
  parameter       VARCHAR2(20),
  actioniffail    VARCHAR2(20)
);

alter table AUTO_KEYWORDDETAIL
  add constraint PK_KEYWORDDETAIL primary key (KEYWORDDETAILID)
  using index;
alter table AUTO_KEYWORDDETAIL
  add constraint FK_KEYWORDDETAIL foreign key (KEYWORDID)
  references AUTO_KEYWORD (KEYWORDID) on delete set null;
alter table AUTO_KEYWORDDETAIL
  add constraint FK_KEYWORDDETAILACTION foreign key (ACTIONIFFAIL)
  references AUTO_ACTION (ACTIONNAME) on delete set null;
alter table AUTO_KEYWORDDETAIL
  add constraint FK_KEYWORDDETAILOPERATION foreign key (OPERATION)
  references AUTO_RULE (OPERATION);
  
  
  
create table AUTO_ACTION
(
  actionid   VARCHAR2(20) not null,
  actionname VARCHAR2(256)
);
alter table AUTO_ACTION
  add constraint PK_ACTION primary key (ACTIONID)
  using index;
alter table AUTO_ACTION
  add constraint UK_ACTION unique (ACTIONNAME)
  using index;

create table AUTO_RULE
(
  ruleid    VARCHAR2(20) not null,
  operation VARCHAR2(20) not null,
  value     VARCHAR2(20) not null,
  version   VARCHAR2(20) not null
);

alter table AUTO_RULE add parameter varchar2(20);
alter table AUTO_RULE add comments varchar2(1024);

alter table AUTO_RULE
  add constraint PK_RULE primary key (RULEID)
  using index;

alter table AUTO_RULE
  add constraint UK_RULEOPERATION unique (OPERATION)
  using index;

create table AUTO_SCRIPT
(
  scriptid    VARCHAR2(20) not null,
  submoduleid VARCHAR2(20) not null,
  scriptname  VARCHAR2(20) not null
);

alter table AUTO_SCRIPT
  add constraint PK_SCRIPT primary key (SCRIPTID)
  using index;

alter table AUTO_SCRIPT
  add constraint UK_SCRIPT unique (SCRIPTNAME)
  using index;
  
alter table AUTO_SCRIPT
  add constraint FK_SCRIPT foreign key (SUBMODULEID)
  references AUTO_SUBMODULE (SUBMODULEID) on delete set null;
  
create table AUTO_SCRIPTDETAIL
(
  scriptdetailid     VARCHAR2(20) not null,
  scriptid           VARCHAR2(20) not null,
  keywordsubmoduleid VARCHAR2(20) not null,
  keywordid          VARCHAR2(20) not null,
  version            VARCHAR2(20) not null
);

alter table AUTO_SCRIPTDETAIL
  add constraint PK_SCRIPTDETAIL primary key (SCRIPTDETAILID)
  using index;
alter table AUTO_SCRIPTDETAIL
  add constraint FK_SCRIPTDETAIL foreign key (SCRIPTID)
  references AUTO_SCRIPT (SCRIPTID) on delete set null;
alter table AUTO_SCRIPTDETAIL
  add constraint FK_SCRIPTDETAIL2 foreign key (KEYWORDID)
  references AUTO_KEYWORD (KEYWORDID) on delete set null;
alter table AUTO_SCRIPTDETAIL
  add constraint FK_SCRIPTDETAIL3 foreign key (KEYWORDSUBMODULEID)
  references AUTO_SUBMODULE (SUBMODULEID) on delete set null;
  
  
  
create table AUTO_TESTCASE
(
  testcaseid     VARCHAR2(20) not null,
  scriptid       VARCHAR2(20) not null,
  testcasename   VARCHAR2(20) not null,
  testcaselevel  VARCHAR2(20) not null,
  expectedresult VARCHAR2(60) not null
);


alter table AUTO_TESTCASE
  add constraint PK_TESTCASE primary key (TESTCASEID)
  using index;

alter table AUTO_TESTCASE
  add constraint FK_TESTCASE foreign key (SCRIPTID)
  references AUTO_SCRIPT (SCRIPTID) on delete set null;
  
create table AUTO_TESTCASEDETAIL
(
  no           VARCHAR2(20) not null,
  testcaseid   VARCHAR2(20),
  parameter    VARCHAR2(20),
  value        VARCHAR2(20),
  testcasename VARCHAR2(20)
);

alter table AUTO_TESTCASEDETAIL
  add constraint PK_TESTCASEDETAIL primary key (NO)
  using index;

alter table AUTO_TESTCASEDETAIL
  add constraint FK_TESTCASEDEAIL foreign key (TESTCASEID)
  references AUTO_TESTCASE (TESTCASEID) on delete set null;  
  
  
create table AUTO_BATCH
(
  batchid   VARCHAR2(20) not null,
  batchname VARCHAR2(20),
  comments  VARCHAR2(20)
);

alter table AUTO_BATCH
  add constraint PK_BATCH primary key (BATCHID)
  using index;
  
create table AUTO_BATCHDETAIL
(
  batchid       VARCHAR2(20) not null,
  scriptid      VARCHAR2(20) not null,
  submodulename VARCHAR2(20),
  scriptname    VARCHAR2(20),
  modulename    VARCHAR2(20),
  batchdetailid VARCHAR2(20) not null
);


alter table AUTO_BATCHDETAIL
  add constraint PK_BATCHDETAIL primary key (BATCHDETAILID)
  using index;

alter table AUTO_BATCHDETAIL
  add constraint FK_BATCHDETAIL foreign key (BATCHID)
  references AUTO_BATCH (BATCHID) on delete set null;
alter table AUTO_BATCHDETAIL
  add constraint FK_BATCHDETAIL1 foreign key (SCRIPTID)
  references AUTO_SCRIPT (SCRIPTID) on delete set null;
  
  
create table AUTO_PLATFORMEXECUTECONFIG
(
  configid        VARCHAR2(20) not null,
  batchid         VARCHAR2(20) not null,
  execstarttime   VARCHAR2(20),
  execendtime     VARCHAR2(20),
  ruleversion     VARCHAR2(20) not null,
  keywordversion  VARCHAR2(20) not null,
  scriptversion   VARCHAR2(20) not null,
  testcaseversion VARCHAR2(20) not null,
  testcaselevel   VARCHAR2(20),
  execmode        VARCHAR2(20) not null,
  loglevel        VARCHAR2(20),
  runstatus       VARCHAR2(20),
  platformid      VARCHAR2(20) not null
);


comment on column AUTO_PLATFORMEXECUTECONFIG.execmode
  is '0代表更新，1代表执行，2代表更新批次内容';
comment on column AUTO_PLATFORMEXECUTECONFIG.platformid
  is '对应执行测试机器上的机器号';
alter table AUTO_PLATFORMEXECUTECONFIG
  add constraint PK_PLATFORMRUNCONFIG primary key (CONFIGID)
  using index;
  
alter table AUTO_PLATFORMEXECUTECONFIG
  add constraint UK_PLATFORMRUNCONFIG unique (EXECSTARTTIME, EXECENDTIME)
  using index;
  
alter table AUTO_PLATFORMEXECUTECONFIG
  add constraint FK_PLATFORMRUNCONFIG foreign key (BATCHID)
  references AUTO_BATCH (BATCHID) on delete set null;

  
  
  

  