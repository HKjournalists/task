delete from sys_station_type_kind;
insert into sys_station_type_kind (KIND_ID, KIND_NAME, PARENT_KIND_ID, SORT_ID, STATE, DONE_CODE, CREATE_DATE, DONE_DATE, VALID_DATE, EXPIRE_DATE, OP_ID, ORG_ID)
values (100000, '部门岗位', 200000, null, 1, null, null, null, null, null, null, null);
insert into sys_station_type_kind (KIND_ID, KIND_NAME, PARENT_KIND_ID, SORT_ID, STATE, DONE_CODE, CREATE_DATE, DONE_DATE, VALID_DATE, EXPIRE_DATE, OP_ID, ORG_ID)
values (200000, '岗位分类', null, 1, 1, null, null, null, null, null, null, null);

update sys_station_type set kind_id = 100000 where kind_id = 1;
update sys_station_type set kind_id = 200000 where kind_id = 2;

drop sequence SYS_STATION_TYPE_KIND$SEQ;
create sequence SYS_STATION_TYPE_KIND$SEQ
minvalue 1
maxvalue 1000000000000000000000000000
start with 300000
increment by 1
cache 20;