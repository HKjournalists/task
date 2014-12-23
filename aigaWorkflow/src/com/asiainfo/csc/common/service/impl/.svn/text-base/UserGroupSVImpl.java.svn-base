package com.asiainfo.csc.common.service.impl;

import com.ai.appframe2.service.ServiceFactory;
import com.asiainfo.csc.common.dao.interfaces.IUserGroupDao;
import com.asiainfo.csc.common.ivalues.IBOUserGroupValue;
import com.asiainfo.csc.common.service.interfaces.IUserGroupSV;

public class UserGroupSVImpl implements IUserGroupSV {

	
	public IBOUserGroupValue[] getUserGrupByStaffId(String staffId)
			throws Exception {
		IUserGroupDao iUGDao=(IUserGroupDao)ServiceFactory.getService(IUserGroupDao.class);
		return iUGDao.getUserGroupByStaffId(staffId);
	}

}
