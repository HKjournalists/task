package com.asiainfo.csc.matrix.dao.interfaces;

import java.util.Map;

import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowValue;

public interface IAlmWorkflowDao {
	
	public IBOAlmWorkflowValue[] getAlmWorkflowByCondition(String condition,Map paramter) throws Exception;
	
	public void saveAlmWorkflow(IBOAlmWorkflowValue[] almWorkflows) throws Exception;
	
	public void saveWorkflow(IBOAlmWorkflowValue saveVal) throws Exception;
}
