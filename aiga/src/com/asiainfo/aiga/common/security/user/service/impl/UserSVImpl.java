package com.asiainfo.aiga.common.security.user.service.impl;

import com.asiainfo.aiga.common.security.user.bo.AigaMenu;
import com.asiainfo.aiga.common.security.user.bo.AigaUser;
import com.asiainfo.aiga.common.security.user.dao.IUserDAO;
import com.asiainfo.aiga.common.security.user.service.IUserSV;
import com.asiainfo.aiga.staff.bo.StaffRoleView;

public class UserSVImpl implements IUserSV {
	
	private IUserDAO userDao;
	
	public void setUserDao(IUserDAO userDao) {
		this.userDao = userDao;
	}
	
	public AigaUser getAigaUserByCode(String code) throws Exception {
		return userDao.getAigaUserByCode(code);
	}
	
	public AigaMenu[] getAigaMenuBySql(String querySql) throws Exception {
		return userDao.getAigaMenuBySql(querySql);
	}

	@Override
	public StaffRoleView[] getStaffRoleViewByGroupLeader(String staffId,String roleCode)throws Exception {
		return userDao.getStaffRoleViewByGroupLeader(staffId, roleCode);
	}

	@Override
	public StaffRoleView[] getStaffRoleViewByGroupLeader(String roleCode)
			throws Exception {
		// TODO Auto-generated method stub
		return userDao.getStaffRoleViewByGroupLeader(roleCode);
	}

}
