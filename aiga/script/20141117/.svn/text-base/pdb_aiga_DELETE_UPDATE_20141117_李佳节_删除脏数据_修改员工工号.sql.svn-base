delete sys_staff_org_relat t where t.staff_id in (select s.staff_id from sys_staff s where s.code in('WANGHAIXIA','LIUJUNFENG','LIXING'));
delete sys_employee t where t.employee_id in (select s.employee_id from sys_staff s where s.code in('WANGHAIXIA','LIUJUNFENG','LIXING'));
delete from sys_staff s where s.code in('WANGHAIXIA','LIUJUNFENG','LIXING');
update sys_staff t set t.code='WANGHAIXIA' where t.code='WANGHAIXIA1';
update sys_staff t set t.code='LIUJUNFENG' where t.code='LIUJUNFENG1';
update sys_staff t set t.code='LIXING' where t.code='LIXING1';