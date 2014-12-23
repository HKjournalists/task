package com.asiainfo.aiga.dao.impl;

import java.util.Map;

import com.asiainfo.aiga.bo.BOAigaSubTaskProblemEngine;
import com.asiainfo.aiga.bo.BOAigaTestSubTaskEngine;
import com.asiainfo.aiga.dao.interfaces.IAigaTestSubTaskDao;
import com.asiainfo.aiga.ivalues.IBOAigaSubTaskProblemValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestSubTaskValue;

public class AigaTestSubTaskDaoImpl implements IAigaTestSubTaskDao{

	@Override
	public IBOAigaTestSubTaskValue getAigaTestSubTaskBySubTaskId(String taskId)
			throws Exception {
		// TODO Auto-generated method stub
		return BOAigaTestSubTaskEngine.getBean(Long.valueOf(taskId));
	}

	@Override
	public IBOAigaTestSubTaskValue[] getAigaTestSubTasks(String conditions,
			Map params) throws Exception {
		// TODO Auto-generated method stub
		return BOAigaTestSubTaskEngine.getBeans(conditions, params);
	}

	@Override
	public IBOAigaTestSubTaskValue saveAigaTestSubTask(IBOAigaTestSubTaskValue o)
			throws Exception {
		// TODO Auto-generated method stub
		if(o.getSubTaskId() ==0 )
		{
			o.setSubTaskId(BOAigaTestSubTaskEngine.getNewId().longValue());
		}
		BOAigaTestSubTaskEngine.save(o);
		return o;
	}

	@Override
	public IBOAigaSubTaskProblemValue[] getAigaSubTaskProblems(
			String conditions, Map params) throws Exception {
		// TODO Auto-generated method stub
		return BOAigaSubTaskProblemEngine.getBeans(conditions, params);
	}

	@Override
	public IBOAigaSubTaskProblemValue saveAigaSubTaskProblem(
			IBOAigaSubTaskProblemValue o) throws Exception {
		// TODO Auto-generated method stub
		
		if(o.getId() ==0 )
		{
			o.setId(BOAigaSubTaskProblemEngine.getNewId().longValue());
		}
		BOAigaSubTaskProblemEngine.save(o);
		return o;
	}

	@Override
	public IBOAigaSubTaskProblemValue getAigaSubTaskProblemById(String id)
			throws Exception {
		// TODO Auto-generated method stub
		return BOAigaSubTaskProblemEngine.getBean(Long.valueOf(id));
	}

}
