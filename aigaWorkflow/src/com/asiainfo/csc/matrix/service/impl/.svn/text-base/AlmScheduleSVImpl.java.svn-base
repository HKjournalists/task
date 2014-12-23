package com.asiainfo.csc.matrix.service.impl;

import java.util.Map;

import com.asiainfo.csc.matrix.factory.BusiFactory;
import com.asiainfo.csc.matrix.ivalues.IBOScheduleValue;
import com.asiainfo.csc.matrix.service.interfaces.IAlmScheduleSV;

public class AlmScheduleSVImpl implements IAlmScheduleSV {

	
	public void saveSchedule(IBOScheduleValue[] schedules) throws Exception {
		// TODO Auto-generated method stub
		BusiFactory.getAlmScheduleDao().saveSchedule(schedules);
	}

	
	public IBOScheduleValue[] getScheduleByCondition(String condition,
			Map paramter) throws Exception {
		// TODO Auto-generated method stub
		return BusiFactory.getAlmScheduleDao().getScheduleByCondition(condition, paramter);
	}
	
}
