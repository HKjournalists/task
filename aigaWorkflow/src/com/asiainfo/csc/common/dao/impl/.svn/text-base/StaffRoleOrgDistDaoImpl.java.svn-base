package com.asiainfo.csc.common.dao.impl;

import java.util.Map;

import com.asiainfo.csc.common.bo.BOOrganizeEngine;
import com.asiainfo.csc.common.bo.BOStaffRoleOrgDistViewEngine;
import com.asiainfo.csc.common.dao.interfaces.IStaffRoleOrgDistDao;
import com.asiainfo.csc.common.ivalues.IBOOrganizeValue;
import com.asiainfo.csc.common.ivalues.IBOStaffRoleOrgDistViewValue;

public class StaffRoleOrgDistDaoImpl implements IStaffRoleOrgDistDao {

	public IBOStaffRoleOrgDistViewValue[] queryStaffRoleViewByCondition(
			String condition, Map map) throws Exception {
		return BOStaffRoleOrgDistViewEngine.getBeans(condition,map);
	}

	public IBOOrganizeValue[] queryOrganizeVlaueByCondition(String condition,
			Map map) throws Exception {
		return BOOrganizeEngine.getBeans(condition,map);
	}

}
