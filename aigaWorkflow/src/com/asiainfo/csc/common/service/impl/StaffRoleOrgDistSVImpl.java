package com.asiainfo.csc.common.service.impl;

import java.util.HashMap;
import java.util.Map;

import com.ai.appframe2.service.ServiceFactory;
import com.asiainfo.csc.common.dao.interfaces.IStaffRoleOrgDistDao;
import com.asiainfo.csc.common.ivalues.IBOOrganizeValue;
import com.asiainfo.csc.common.ivalues.IBOStaffRoleOrgDistViewValue;
import com.asiainfo.csc.common.ivalues.IBOStaffTableValue;
import com.asiainfo.csc.common.service.interfaces.IStaffRoleOrgDistSV;

public class StaffRoleOrgDistSVImpl implements IStaffRoleOrgDistSV {

	IStaffRoleOrgDistDao iStaffRoleOrgDistDao=(IStaffRoleOrgDistDao)ServiceFactory.getService(IStaffRoleOrgDistDao.class);
	public IBOOrganizeValue[] queryOrganizeVlaueByCondition(String condition,
			Map map) throws Exception {
		return iStaffRoleOrgDistDao.queryOrganizeVlaueByCondition(condition, map);
	}

	public IBOStaffRoleOrgDistViewValue[] queryStaffRoleViewByCondition(
			String condition, Map map) throws Exception {
		IBOStaffRoleOrgDistViewValue[] sValue=iStaffRoleOrgDistDao.queryStaffRoleViewByCondition(condition, map);
		Map<Long,IBOStaffRoleOrgDistViewValue> maps=new HashMap<Long,IBOStaffRoleOrgDistViewValue>();
		for(IBOStaffRoleOrgDistViewValue value:sValue){
			if(maps.get(value.getStaffId())==null){
				maps.put(value.getStaffId(),value);
			}
		}
		return maps.values().toArray(new IBOStaffRoleOrgDistViewValue[maps.size()]);
	}

}
