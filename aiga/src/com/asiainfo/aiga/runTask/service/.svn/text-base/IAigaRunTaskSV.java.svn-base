package com.asiainfo.aiga.runTask.service;

import com.asiainfo.aiga.log.bo.AigaLogTestCase;
import com.asiainfo.aiga.runTask.bo.AigaHisRunTaskResult;
import com.asiainfo.aiga.runTask.bo.AigaRunTask;

public interface IAigaRunTaskSV {

	public void saveAigaRunTask(AigaRunTask aValue)throws Exception;
	
	public void deleteAigaRunTask(AigaRunTask aValue)throws Exception;
	
	public void deleteAigaRunTask(String taskId)throws Exception;
	
	public AigaLogTestCase[] getAigaLogTestCaseByRunId(Integer runId)throws Exception;
	
	public AigaRunTask[] getAigaRunTaskBySubTaskId(Integer subTaskId)throws Exception;
	
	public AigaRunTask getAigaRunTaskByTaskId(String taskId)throws Exception;
	
	public AigaRunTask[] getAigaRunTask(String querySql)throws Exception;
	
	public void saveStartTask(String taskId) throws Exception;
	
	public void saveRunTask(String subTaskId,String taskName,Object[] objs) throws Exception;
	
	public void saveAigaHisRunTaskResult(AigaHisRunTaskResult[] hisValues)throws Exception;
}
