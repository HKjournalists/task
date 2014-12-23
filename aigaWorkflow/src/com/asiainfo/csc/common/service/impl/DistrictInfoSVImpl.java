package com.asiainfo.csc.common.service.impl;

import com.ai.appframe2.service.ServiceFactory;
import com.asiainfo.csc.common.dao.interfaces.IDistrictInfoDao;
import com.asiainfo.csc.common.ivalues.IBODistrictInfoValue;
import com.asiainfo.csc.common.service.interfaces.IDistrictInfoSV;

public class DistrictInfoSVImpl implements IDistrictInfoSV {
	IDistrictInfoDao iDistrictInfoDao = (IDistrictInfoDao)ServiceFactory.getService(IDistrictInfoDao.class);
	public IBODistrictInfoValue[] getDistrictInfo(long districtId) throws Exception {
		return iDistrictInfoDao.getDistrictInfo(districtId);
	}
	public String getDistrictName(long districtId) throws Exception {
		return iDistrictInfoDao.getDistrictInfo(districtId)[0].getDistrictName();
	}

	
}

