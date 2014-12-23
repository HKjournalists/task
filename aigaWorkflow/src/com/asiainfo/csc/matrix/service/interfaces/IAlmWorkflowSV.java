package com.asiainfo.csc.matrix.service.interfaces;

import java.util.Map;

import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowValue;

public interface IAlmWorkflowSV {
	public IBOAlmWorkflowValue[] getAlmWorkflowByCondition(String condition,Map paramter) throws Exception;
	public void saveAlmWorkflow(IBOAlmWorkflowValue[] almWorkflows) throws Exception;
}
