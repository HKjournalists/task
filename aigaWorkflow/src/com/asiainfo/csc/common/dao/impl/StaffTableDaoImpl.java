package com.asiainfo.csc.common.dao.impl;

import java.util.Map;

import com.asiainfo.csc.common.bo.BOStaffTableEngine;
import com.asiainfo.csc.common.dao.interfaces.IStaffTableDao;
import com.asiainfo.csc.common.ivalues.IBOStaffTableValue;

public class StaffTableDaoImpl implements IStaffTableDao{

	public IBOStaffTableValue[] getStaffs(String condition,Map param)throws Exception
	{
		try{
			return BOStaffTableEngine.getBeans(condition, param);
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("在获取选干系人列表的信息时出错，错误在Dao层getStaffs函数");
		}
	}
}
