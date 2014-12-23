package com.asiainfo.csc.matrix.service.interfaces;

import java.util.Map;

import com.asiainfo.csc.matrix.ivalues.IBOScheduleValue;

public interface IAlmScheduleSV {
	public void saveSchedule(IBOScheduleValue[] schedules) throws Exception;
	
	public IBOScheduleValue[] getScheduleByCondition(String condition,Map paramter) throws Exception;
}
