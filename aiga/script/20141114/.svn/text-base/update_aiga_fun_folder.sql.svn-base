--drop sequence for aiga.aiga_fun_folder$seq
DROP SEQUENCE aiga.aiga_fun_folder$seq;
--create sequence for aiga.aiga_fun_folder$seq
create sequence aiga.aiga_fun_folder$seq
minvalue 1
maxvalue 9999999999999999999999999999
start with 80000
increment by 1
nocache;
--UPDATE aiga_sub_sys_folder and aiga_fun_folder
UPDATE aiga_sub_sys_folder t SET t.subsys_id =Aiga_Fun_Folder$seq.Nextval WHERE t.subsys_id=21;
UPDATE AIGA_FUN_FOLDER aff SET aff.SUB_SYS_ID = (SELECT ASSF.SUBSYS_ID FROM AIGA_SUB_SYS_FOLDER ASSF WHERE ASSF.SYS_NAME = '后台进程' AND ASSF.SYS_ID = '16') WHERE aff.SUB_SYS_ID = 21;

---aiga.SYS_EMPLOYEE$SEQ
DROP SEQUENCE aiga.SYS_EMPLOYEE$SEQ;
--create sequence for aiga.aiga_fun_folder$seq
create sequence aiga.SYS_EMPLOYEE$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 10000
increment by 1
nocache;

---aiga.SYS_STAFF$SEQ
DROP SEQUENCE aiga.SYS_STAFF$SEQ;
--create sequence for aiga.SYS_STAFF$SEQ
create sequence aiga.SYS_STAFF$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 10000
increment by 1
nocache;

---aiga.SYS_STAFF_IPMAC_BAND$SEQ
DROP SEQUENCE aiga.SYS_STAFF_IPMAC_BAND$SEQ;
--create sequence for aiga.SYS_STAFF_IPMAC_BAND$SEQ
create sequence aiga.SYS_STAFF_IPMAC_BAND$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 10000
increment by 1
nocache;

---aiga.SYS_STAFF_ORG_RELAT$SEQ
DROP SEQUENCE aiga.SYS_STAFF_ORG_RELAT$SEQ;
--create sequence for aiga.SYS_STAFF_ORG_RELAT$SEQ
create sequence aiga.SYS_STAFF_ORG_RELAT$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 10000
increment by 1
nocache;

---aiga.SYS_STAFF_ROLE_AUTHOR$SEQ
DROP SEQUENCE aiga.SYS_STAFF_ROLE_AUTHOR$SEQ;
--create sequence for aiga.SYS_STAFF_ROLE_AUTHOR$SEQ
create sequence aiga.SYS_STAFF_ROLE_AUTHOR$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 10000
increment by 1
nocache;

---aiga.SYS_STAFF_VERIFY_CODE$SEQ
DROP SEQUENCE aiga.SYS_STAFF_VERIFY_CODE$SEQ;
--create sequence for aiga.SYS_STAFF_VERIFY_CODE$SEQ
create sequence aiga.SYS_STAFF_VERIFY_CODE$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 10000
increment by 1
nocache;

---aiga.SYS_ORGANIZE$SEQ
DROP SEQUENCE aiga.SYS_ORGANIZE$SEQ;
--create sequence for aiga.SYS_ORGANIZE$SEQ
create sequence aiga.SYS_ORGANIZE$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 10000
increment by 1
nocache;

---aiga.SYS_ORG_DISTRICT_RELATE$SEQ
DROP SEQUENCE aiga.SYS_ORG_DISTRICT_RELATE$SEQ;
--create sequence for aiga.SYS_ORG_DISTRICT_RELATE$SEQ
create sequence aiga.SYS_ORG_DISTRICT_RELATE$SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 10000
increment by 1
nocache;




insert into aiga_test_sub_elem t(t.sub_elem_id,t.elem_id,t.elem_value,t.take_value_method,t.is_delete)
values(aiga_test_sub_elem$seq.nextval,103,'1：正常','select a.*,rowid from base.bs_static_data a where a.code_type=''SO_USER_STATE'';--用户状态select a.*,rowid from so4.ins_user_573 a where state=1',0);
insert into aiga_test_sub_elem t(t.sub_elem_id,t.elem_id,t.elem_value,t.take_value_method,t.is_delete)
values(aiga_test_sub_elem$seq.nextval,103,'2：帐务预销','select a.*,rowid from so4.ins_user_573 a where state=2',0);
insert into aiga_test_sub_elem t(t.sub_elem_id,t.elem_id,t.elem_value,t.take_value_method,t.is_delete)
values(aiga_test_sub_elem$seq.nextval,103,'3：营业预销','select a.*,rowid from so4.ins_user_573 a where state=3',0);
insert into aiga_test_sub_elem t(t.sub_elem_id,t.elem_id,t.elem_value,t.take_value_method,t.is_delete)
values(aiga_test_sub_elem$seq.nextval,103,'4：预开户','select a.*,rowid from so4.ins_user_573 a where state=4',0);
insert into aiga_test_sub_elem t(t.sub_elem_id,t.elem_id,t.elem_value,t.take_value_method,t.is_delete)
values(aiga_test_sub_elem$seq.nextval,103,'5：营业销户','select a.*,rowid from so4.ins_user_573 a where state=5',0);
insert into aiga_test_sub_elem t(t.sub_elem_id,t.elem_id,t.elem_value,t.take_value_method,t.is_delete)
values(aiga_test_sub_elem$seq.nextval,103,'6：帐务销户','select a.*,rowid from so4.ins_user_573 a where state=6',0);
insert into aiga_test_sub_elem t(t.sub_elem_id,t.elem_id,t.elem_value,t.take_value_method,t.is_delete)
values(aiga_test_sub_elem$seq.nextval,103,'7：套卡销户','select a.*,rowid from so4.ins_user_573 a where state=7',0);
insert into aiga_test_sub_elem t(t.sub_elem_id,t.elem_id,t.elem_value,t.take_value_method,t.is_delete)
values(aiga_test_sub_elem$seq.nextval,103,'8：暂停','select a.*,rowid from so4.ins_user_573 a where state=8',0);
insert into aiga_test_sub_elem t(t.sub_elem_id,t.elem_id,t.elem_value,t.take_value_method,t.is_delete)
values(aiga_test_sub_elem$seq.nextval,103,'9：改号激活','select a.*,rowid from so4.ins_user_573 a where state=9',0);
