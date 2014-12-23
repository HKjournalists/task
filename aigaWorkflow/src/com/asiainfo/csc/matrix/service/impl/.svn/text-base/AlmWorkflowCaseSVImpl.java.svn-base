package com.asiainfo.csc.matrix.service.impl;

import java.util.Map;

import com.asiainfo.csc.matrix.factory.BusiFactory;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowCaseValue;
import com.asiainfo.csc.matrix.service.interfaces.IAlmWorkflowCaseSV;

public class AlmWorkflowCaseSVImpl implements IAlmWorkflowCaseSV {

	
	public IBOAlmWorkflowCaseValue[] getAlmWorkflowCaseByCondition(
			String condition, Map paramter) throws Exception {
		// TODO Auto-generated method stub
		return BusiFactory.getAlmWorkflowCaseDao().getAlmWorkflowCaseByCondition(condition, paramter);
	}

	
	public void saveAlmWorkflowCase(IBOAlmWorkflowCaseValue[] almWorkflowCases) throws Exception {
		// TODO Auto-generated method stub
		BusiFactory.getAlmWorkflowCaseDao().saveAlmWorkflowCase(almWorkflowCases);
	}

}
