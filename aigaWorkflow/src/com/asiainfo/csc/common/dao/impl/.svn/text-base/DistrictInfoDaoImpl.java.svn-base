package com.asiainfo.csc.common.dao.impl;

import java.util.HashMap;
import java.util.Map;

import com.asiainfo.csc.common.bo.BODistrictInfoEngine;
import com.asiainfo.csc.common.dao.interfaces.IDistrictInfoDao;
import com.asiainfo.csc.common.ivalues.IBODistrictInfoValue;

public class DistrictInfoDaoImpl implements IDistrictInfoDao {

	IBODistrictInfoValue[] districtInfoInfo=null;

	public IBODistrictInfoValue[] getDistrictInfo(long districtId) throws Exception {
		try{
		/*	long[] ar = null;*/
			String condition  = "district_id=:districtId";
			Map parameter  = new HashMap();
			parameter.put("districtId",districtId);
			districtInfoInfo = BODistrictInfoEngine.getBeans(condition, parameter);
			/*ar = new long[array.length];
			int i = 0;
		for(IBOGetOrgByStaffValue o : array){
				ar[i] =o.getStaffId();
				i++;
			}*/
			return districtInfoInfo;
		}catch(Exception e){
			throw e;
		}
	}

}
