package com.asiainfo.csc.common.dao.interfaces;

import com.asiainfo.csc.common.ivalues.IBOUserGroupValue;

public interface IUserGroupDao {
	
	public IBOUserGroupValue[] getUserGroupByStaffId(String staffId)throws Exception;
}
