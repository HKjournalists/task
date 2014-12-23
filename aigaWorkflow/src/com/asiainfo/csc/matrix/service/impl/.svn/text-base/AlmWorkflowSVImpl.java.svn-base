package com.asiainfo.csc.matrix.service.impl;

import java.util.Map;

import com.asiainfo.csc.matrix.factory.BusiFactory;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowValue;
import com.asiainfo.csc.matrix.service.interfaces.IAlmWorkflowSV;

public class AlmWorkflowSVImpl implements IAlmWorkflowSV {

	
	public IBOAlmWorkflowValue[] getAlmWorkflowByCondition(String condition,
			Map paramter) throws Exception {
		// TODO Auto-generated method stub
		return BusiFactory.getAlmWorkflowDao().getAlmWorkflowByCondition(condition, paramter);
	}

	
	public void saveAlmWorkflow(IBOAlmWorkflowValue[] almWorkflows) throws Exception {
		// TODO Auto-generated method stub
		BusiFactory.getAlmWorkflowDao().saveAlmWorkflow(almWorkflows);
	}

}
