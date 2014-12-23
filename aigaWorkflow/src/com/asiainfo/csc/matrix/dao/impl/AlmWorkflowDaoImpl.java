package com.asiainfo.csc.matrix.dao.impl;

import java.util.Map;

import com.asiainfo.csc.matrix.bo.BOAlmWorkflowEngine;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmWorkflowDao;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowValue;



public class AlmWorkflowDaoImpl implements IAlmWorkflowDao {

	
	public IBOAlmWorkflowValue[] getAlmWorkflowByCondition(String condition,
			Map paramter) throws Exception {
		// TODO Auto-generated method stub
		return BOAlmWorkflowEngine.getBeans(condition,paramter);
	}

	
	public void saveAlmWorkflow(IBOAlmWorkflowValue[] almWorkflows) throws Exception {
		// TODO Auto-generated method stub
		for(IBOAlmWorkflowValue almWorkflow : almWorkflows){
			if(almWorkflow.isNew())
				almWorkflow.setWfItemId(BOAlmWorkflowEngine.getNewId().longValue());
			BOAlmWorkflowEngine.save(almWorkflow);
		}
	}
	
	public void saveWorkflow(IBOAlmWorkflowValue saveVal) throws Exception {
		BOAlmWorkflowEngine.save(saveVal);
	}

	

}
