package com.asiainfo.csc.common.service.interfaces;

import com.asiainfo.csc.common.ivalues.IBODistrictInfoValue;


public interface IDistrictInfoSV {
	//根据员工id 
	public IBODistrictInfoValue[] getDistrictInfo( long districtId) throws Exception;
	public String getDistrictName(long districtId) throws Exception;
	
}
