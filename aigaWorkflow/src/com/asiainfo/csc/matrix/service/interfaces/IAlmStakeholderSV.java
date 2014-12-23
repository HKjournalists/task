package com.asiainfo.csc.matrix.service.interfaces;

import java.util.Map;

import com.asiainfo.csc.matrix.ivalues.IBOAlmStakeholderValue;

public interface IAlmStakeholderSV {
	public IBOAlmStakeholderValue[] getStakeholderByCondition(String condition,Map paramter) throws Exception;
	public void saveStakeholder(IBOAlmStakeholderValue[] schedules) throws Exception;
	public IBOAlmStakeholderValue[] getStakeholder(String linkNo,String objId,String objType)throws Exception;
}
