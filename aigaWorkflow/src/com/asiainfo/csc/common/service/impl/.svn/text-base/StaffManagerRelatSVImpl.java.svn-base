package com.asiainfo.csc.common.service.impl;

import java.util.Map;

import com.ai.appframe2.service.ServiceFactory;
import com.asiainfo.csc.common.dao.interfaces.IStaffManagerRelatDao;
import com.asiainfo.csc.common.ivalues.IBOStaffManagerRelatValue;
import com.asiainfo.csc.common.service.interfaces.IStaffManagerRelatSV;

public class StaffManagerRelatSVImpl implements IStaffManagerRelatSV{

	
	public IBOStaffManagerRelatValue[] getStaffManagerByCondition(
			String condition, Map parameter) throws Exception {
		// TODO Auto-generated method stub
		IStaffManagerRelatDao iSMRDao=(IStaffManagerRelatDao)ServiceFactory.getService(IStaffManagerRelatDao.class);
		return iSMRDao.getStaffManagerByCondition(condition, parameter);
	}

}
