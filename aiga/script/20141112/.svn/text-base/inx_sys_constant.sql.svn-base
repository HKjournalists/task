
--在sys_constant表的status字段上建立索引(status 0可用 1不可用)
create index INX_sys_constant_status on sys_constant (status)
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