package com.asiainfo.aiga.common.security.user.service;

import com.asiainfo.aiga.common.security.user.bo.AigaMenu;
import com.asiainfo.aiga.common.security.user.bo.AigaUser;
import com.asiainfo.aiga.staff.bo.StaffRoleView;

public interface IUserSV {
	
	public AigaUser getAigaUserByCode(String code) throws Exception;
	
	public AigaMenu[] getAigaMenuBySql(String querySql) throws Exception;
	
	public StaffRoleView[] getStaffRoleViewByGroupLeader(String staffId,String roleCode)throws Exception;
	
	public StaffRoleView[] getStaffRoleViewByGroupLeader(String roleCode)throws Exception;
}
