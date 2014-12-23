package com.asiainfo.csc.common.dao.impl;

import java.util.Map;

import com.asiainfo.csc.common.bo.BOWorkflowEngine;
import com.asiainfo.csc.common.dao.interfaces.IWorkflowDao;
import com.asiainfo.csc.common.ivalues.IBOWorkflowValue;

public class WorkflowDaoImpl implements IWorkflowDao{

	public IBOWorkflowValue[] getWorkflows(String cond,Map param)throws Exception
	{
		try{
			return BOWorkflowEngine.getBeans(cond, param);
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("��ȡworkflow��������ʱ����������Dao�㣬getWorkflows����");
		}
	}
}
