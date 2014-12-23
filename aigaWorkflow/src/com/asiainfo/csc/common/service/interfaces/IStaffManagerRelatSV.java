package com.asiainfo.csc.common.service.interfaces;

import java.util.Map;

import com.asiainfo.csc.common.ivalues.IBOStaffManagerRelatValue;


public interface IStaffManagerRelatSV {
	public IBOStaffManagerRelatValue[] getStaffManagerByCondition(String condition,Map parameter) throws Exception;
}
