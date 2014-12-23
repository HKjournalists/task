package com.asiainfo.csc.matrix.dao.interfaces;

import java.util.Map;

import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowCaseValue;

public interface IAlmWorkflowCaseDao {
	public IBOAlmWorkflowCaseValue[] getAlmWorkflowCaseByCondition(String condition,Map paramter) throws Exception;
	public void saveAlmWorkflowCase(IBOAlmWorkflowCaseValue[] almWorkflowCases) throws Exception;
}
