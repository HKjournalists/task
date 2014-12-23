package com.asiainfo.csc.matrix.dao.impl;

import java.util.Map;

import com.asiainfo.csc.matrix.bo.BOAlmWorkflowCaseEngine;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmWorkflowCaseDao;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowCaseValue;

public class AlmWorkflowCaseDaoImpl implements IAlmWorkflowCaseDao {

	
	public IBOAlmWorkflowCaseValue[] getAlmWorkflowCaseByCondition(
			String condition, Map paramter) throws Exception {
		// TODO Auto-generated method stub
		return BOAlmWorkflowCaseEngine.getBeans(condition,paramter);
	}

	
	public void saveAlmWorkflowCase(IBOAlmWorkflowCaseValue[] almWorkflowCases) throws Exception {
		// TODO Auto-generated method stub
		for(IBOAlmWorkflowCaseValue almWorkflowCase : almWorkflowCases){
			if(almWorkflowCase.isNew())
				almWorkflowCase.setTaskId(BOAlmWorkflowCaseEngine.getNewId().longValue());
			BOAlmWorkflowCaseEngine.save(almWorkflowCase);
		}
	}

}
