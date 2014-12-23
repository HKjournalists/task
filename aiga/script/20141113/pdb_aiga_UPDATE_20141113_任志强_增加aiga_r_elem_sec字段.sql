--目标数据库 aiga@pdb_aiga
--脚本说明：
--依赖脚本: 
 
set define off;
alter session set current_schema=aiga;
ALTER TABLE aiga_r_elem_sec
ADD fun_id NUMBER(20);