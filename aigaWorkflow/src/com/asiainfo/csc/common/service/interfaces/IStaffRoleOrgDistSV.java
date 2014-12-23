package com.asiainfo.csc.common.service.interfaces;

import java.util.Map;

import com.asiainfo.csc.common.ivalues.IBOOrganizeValue;
import com.asiainfo.csc.common.ivalues.IBOStaffRoleOrgDistViewValue;

public interface IStaffRoleOrgDistSV {

	public IBOStaffRoleOrgDistViewValue[] queryStaffRoleViewByCondition(String condition, Map map) throws Exception;
	
	public IBOOrganizeValue[] queryOrganizeVlaueByCondition(String condition,Map map) throws Exception;
}
