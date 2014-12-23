package com.asiainfo.aiga.dao.impl;

import java.util.Map;

import com.ai.appframe2.common.ServiceManager;
import com.asiainfo.aiga.bo.BOAigaTestTaskChangeEngine;
import com.asiainfo.aiga.bo.BOAigaTestTaskEngine;
import com.asiainfo.aiga.dao.interfaces.IAigaTestTaskDao;
import com.asiainfo.aiga.ivalues.IBOAigaTestTaskChangeValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestTaskValue;

public class AigaTestTaskDaoImpl implements IAigaTestTaskDao{

	@Override
	public IBOAigaTestTaskValue[] getAigaTestTask(String condition, Map param)
			throws Exception {
		// TODO Auto-generated method stub
		return BOAigaTestTaskEngine.getBeans(condition, param);
	}

	@Override
	public IBOAigaTestTaskValue saveAigaTestTask(IBOAigaTestTaskValue aValue) throws Exception {
		// TODO Auto-generated method stub
		if(aValue.getTaskId() == 0)
		{
			aValue.setTaskId(BOAigaTestTaskEngine.getNewId().longValue());
			aValue.setCreateTime(ServiceManager.getOpDateTime());
		}
		BOAigaTestTaskEngine.save(aValue);
		return aValue;
	}

	@Override
	public IBOAigaTestTaskValue getgetAigaTestTaskByTaskId(String taskId)
			throws Exception {
		// TODO Auto-generated method stub
		return BOAigaTestTaskEngine.getBean(Long.valueOf(taskId));
	}

	@Override
	public IBOAigaTestTaskChangeValue saveAigaTestTaskChange(
			IBOAigaTestTaskChangeValue o) throws Exception {
		// TODO Auto-generated method stub
		if(o.getAtcId() == 0)
		{
			o.setAtcId(BOAigaTestTaskChangeEngine.getNewId().longValue());
		}
		BOAigaTestTaskChangeEngine.save(o);
		return o;
	}

}
