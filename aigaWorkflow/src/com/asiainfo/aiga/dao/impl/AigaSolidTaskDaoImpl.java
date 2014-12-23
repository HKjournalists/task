package com.asiainfo.aiga.dao.impl;

import java.util.Map;

import com.asiainfo.aiga.dao.interfaces.IAigaSolidTaskDao;
import com.asiainfo.aiga.ivalues.IBOAigaSolidTaskValue;
import com.asiainfo.aiga.bo.BOAigaSolidTaskEngine;

public class AigaSolidTaskDaoImpl implements IAigaSolidTaskDao{

	@Override
	public IBOAigaSolidTaskValue getAigaSolidTaskByTaskId(String taskId)
			throws Exception {
		// TODO Auto-generated method stub
		return BOAigaSolidTaskEngine.getBean(Long.parseLong(taskId));
	}

	@Override
	public IBOAigaSolidTaskValue[] getAigaSolidTasks(String conditions,
			Map params) throws Exception {
		// TODO Auto-generated method stub
		return BOAigaSolidTaskEngine.getBeans(conditions, params);
	}

	@Override
	public IBOAigaSolidTaskValue saveAigaSolidTask(IBOAigaSolidTaskValue o)
			throws Exception {
		// TODO Auto-generated method stub
		if(o.getTaskId() ==0)
		{
			o.setTaskId(BOAigaSolidTaskEngine.getNewId().longValue());
		}
		BOAigaSolidTaskEngine.save(o);
		return o;
	}

}
