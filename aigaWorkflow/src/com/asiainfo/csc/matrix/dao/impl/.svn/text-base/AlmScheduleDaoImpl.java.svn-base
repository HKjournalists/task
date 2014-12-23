package com.asiainfo.csc.matrix.dao.impl;

import java.util.Map;

import com.asiainfo.csc.matrix.bo.BOScheduleEngine;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmScheduleDao;
import com.asiainfo.csc.matrix.ivalues.IBOScheduleValue;

public class AlmScheduleDaoImpl implements IAlmScheduleDao {

	
	public IBOScheduleValue[] getScheduleByCondition(String condition,
			Map paramter) throws Exception {
		// TODO Auto-generated method stub
		return BOScheduleEngine.getBeans(condition,paramter);
	}

	
	public void saveSchedule(IBOScheduleValue[] schedules) throws Exception {
		// TODO Auto-generated method stub
		for(IBOScheduleValue schedule : schedules){
			if(schedule.isNew())
				schedule.setScheduleId(BOScheduleEngine.getNewId().longValue());
			BOScheduleEngine.save(schedule);
		}
	}
	
}
