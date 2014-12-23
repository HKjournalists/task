/*==============================================================*/
/* Table: MONITOR_DATA                                          */
/*==============================================================*/
create table MONITOR_DATA  (
   ID                   VARCHAR2(100),
   LOGPK                VARCHAR2(100),
   UIID                 VARCHAR2(500),
   OPID                 NUMBER(12),
   ORGID                NUMBER(12),
   USER_IP              VARCHAR2(20),
   SERVER_IP            VARCHAR2(20),
   SERVER_ID            VARCHAR2(40),
   CALLID               NUMBER(12),
   PARENT_CALLID        NUMBER(12),
   STATEMENT_STRING     VARCHAR2(4000),
   STATEMENT_PARA       VARCHAR2(4000),
   STARTTIME            VARCHAR2(40),
   ENDTIME              VARCHAR2(40),
   EXECTIME             NUMBER(8),
   PROCESS_TYPE         VARCHAR2(25),
   EXCEPTION_STACK      VARCHAR2(4000)
);

comment on table MONITOR_DATA is
'������ݱ�';

comment on column MONITOR_DATA.ID is
'ΨһID';

comment on column MONITOR_DATA.LOGPK is
'��־Ψһ����';

comment on column MONITOR_DATA.UIID is
'ҳ������ΨһID';

comment on column MONITOR_DATA.OPID is
'����ԱID';

comment on column MONITOR_DATA.ORGID is
'����Ա������֯ID';

comment on column MONITOR_DATA.USER_IP is
'�ͻ�����IP';

comment on column MONITOR_DATA.SERVER_IP is
'������IP';

comment on column MONITOR_DATA.SERVER_ID is
'��������ʾ��bes��Ϊconfigration��+partition��';

comment on column MONITOR_DATA.CALLID is
'��������ΨһID��';

comment on column MONITOR_DATA.PARENT_CALLID is
'���������ϼ�ΨһID��';

comment on column MONITOR_DATA.STATEMENT_STRING is
'�����ַ���';

comment on column MONITOR_DATA.STATEMENT_PARA is
'�������ò���';

comment on column MONITOR_DATA.STARTTIME is
'�������ÿ�ʼʱ��';

comment on column MONITOR_DATA.ENDTIME is
'�������ý���ʱ��';

comment on column MONITOR_DATA.EXECTIME is
'����ִ��ʱ��';

comment on column MONITOR_DATA.PROCESS_TYPE is
'��־����';

comment on column MONITOR_DATA.EXCEPTION_STACK is
'�쳣ջ';