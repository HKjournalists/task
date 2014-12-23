package com.asiainfo.aiga.common.security.user.dao;

import java.util.Map;

import com.asiainfo.aiga.common.security.user.bo.AigaMenu;
import com.asiainfo.aiga.common.security.user.bo.AigaUser;
import com.asiainfo.aiga.staff.bo.StaffRoleView;

public interface IUserDAO {
	
	public AigaUser getAigaUserByCode(String code) throws Exception;
	
	public AigaMenu[] getAigaMenuBySql(String querySql) throws Exception;
	
	public StaffRoleView[] getStaffRoleViewByGroupLeader(String staffId,String roleCode) throws Exception;

	public Map<String, AigaUser> initUsers() throws Exception;
	
	public StaffRoleView[] getStaffRoleViewByGroupLeader(String roleCode) throws Exception;

}
