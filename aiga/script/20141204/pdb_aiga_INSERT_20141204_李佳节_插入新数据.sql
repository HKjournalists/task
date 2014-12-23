insert into sys_constant(constant_id,category_name,category,show,value,status)
values(sys_constant$seq.nextval,'taskType','AigaJointDebugTaskForm','开发类',1001,0);
insert into sys_constant(constant_id,category_name,category,show,value,status)
values(sys_constant$seq.nextval,'taskType','AigaJointDebugTaskForm','非开发类',1002,0);
select t.*,t.rowid from aiga_joint_debug_Task_form t;