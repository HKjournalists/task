package com.asiainfo.csc.common.dao.impl;

import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.common.bo.BOUserGroupEngine;
import com.asiainfo.csc.common.dao.interfaces.IUserGroupDao;
import com.asiainfo.csc.common.ivalues.IBOUserGroupValue;

public class UserGroupDaoImpl implements IUserGroupDao{

	
	public IBOUserGroupValue[] getUserGroupByStaffId(String staffId) throws Exception {
		Criteria sql=new Criteria();
		sql.addEqual(IBOUserGroupValue.S_StaffId, staffId);
		return BOUserGroupEngine.getBeans(sql);
	}
}
