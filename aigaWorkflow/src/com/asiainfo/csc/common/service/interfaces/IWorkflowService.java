package com.asiainfo.csc.common.service.interfaces;

import java.util.Map;

import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowValue;

public interface IWorkflowService {
	/**
	 * workflow≤È—Ø∑Ω∑®
	 * @param cond
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public IBOAlmWorkflowValue[] getWorkflowByCondition(String cond,Map param) throws Exception;
	
	public void saveWorkflow(IBOAlmWorkflowValue saveVal) throws Exception;
	
	public IBOAlmWorkflowValue[] getAllWorkflow() throws Exception;
	
	public void delWorkflow(IBOAlmWorkflowValue delVal) throws Exception;
}
