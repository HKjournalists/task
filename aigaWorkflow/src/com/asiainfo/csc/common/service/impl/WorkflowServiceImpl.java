package com.asiainfo.csc.common.service.impl;

import java.util.Map;

import com.ai.appframe2.service.ServiceFactory;
import com.asiainfo.csc.common.service.interfaces.IWorkflowService;
import com.asiainfo.csc.matrix.bo.BOAlmWorkflowEngine;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmWorkflowDao;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowValue;

public class WorkflowServiceImpl implements IWorkflowService {

	private IAlmWorkflowDao iwd = (IAlmWorkflowDao)ServiceFactory.getService(IAlmWorkflowDao.class);
	public IBOAlmWorkflowValue[] getWorkflowByCondition(String cond,Map param) throws Exception {
		try{
			return iwd.getAlmWorkflowByCondition(cond, param);
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("获取workflow配置数据时出错，错误在SV层，getWorkflowByCondition函数");
		}
	}
	
	public void saveWorkflow(IBOAlmWorkflowValue saveVal) throws Exception {
		if(saveVal.getWfItemId() == 0) {
			saveVal.setStsToNew();
			long newId = BOAlmWorkflowEngine.getNewId().longValue();
			saveVal.setWfItemId(newId);
		}
		iwd.saveWorkflow(saveVal);
	}
	
	public IBOAlmWorkflowValue[] getAllWorkflow() throws Exception {
		return iwd.getAlmWorkflowByCondition(null, null);
	}
	
	public void delWorkflow(IBOAlmWorkflowValue delVal) throws Exception {
		delVal.delete();
		iwd.saveWorkflow(delVal);
	}
}
