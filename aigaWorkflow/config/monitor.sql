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
'监控数据表';

comment on column MONITOR_DATA.ID is
'唯一ID';

comment on column MONITOR_DATA.LOGPK is
'日志唯一主键';

comment on column MONITOR_DATA.UIID is
'页面主键唯一ID';

comment on column MONITOR_DATA.OPID is
'操作员ID';

comment on column MONITOR_DATA.ORGID is
'操作员所属组织ID';

comment on column MONITOR_DATA.USER_IP is
'客户机的IP';

comment on column MONITOR_DATA.SERVER_IP is
'服务器IP';

comment on column MONITOR_DATA.SERVER_ID is
'服务器标示，bes上为configration名+partition名';

comment on column MONITOR_DATA.CALLID is
'方法调用唯一ID号';

comment on column MONITOR_DATA.PARENT_CALLID is
'方法调用上级唯一ID号';

comment on column MONITOR_DATA.STATEMENT_STRING is
'方法字符串';

comment on column MONITOR_DATA.STATEMENT_PARA is
'方法调用参数';

comment on column MONITOR_DATA.STARTTIME is
'方法调用开始时间';

comment on column MONITOR_DATA.ENDTIME is
'方法调用结束时间';

comment on column MONITOR_DATA.EXECTIME is
'方法执行时间';

comment on column MONITOR_DATA.PROCESS_TYPE is
'日志类型';

comment on column MONITOR_DATA.EXCEPTION_STACK is
'异常栈';