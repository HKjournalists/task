package com.asiainfo.aiga.manualTask.service;

import java.util.List;

import net.sf.json.JSONArray;

import com.asiainfo.aiga.manualTask.bo.AigaManualTask;

public interface IAigaManualTaskSV {

	public JSONArray getAigaManualTaskJson(Integer caseId)throws Exception;
	
	public void saveManualTask(AigaManualTask aigaManualTask)throws Exception;
	
	public void saveManualTasks(List<AigaManualTask> aigaManualTasks)throws Exception;
	
	public void deleteManualTask(AigaManualTask aigaManualTask)throws Exception;
	
	public AigaManualTask[] getManualTask(Integer taskId)throws Exception;
	
	public AigaManualTask[] getManualTaskByCaseId(Integer caseId)throws Exception;
	
	public void deleteManualTaskByTaskId(Integer taskId)throws Exception;
	
	public void saveManualTaskAndLog(String taskId,String manualTaskId,String runResult,String runId,String runTime,String caseId,String preResult,String preTestData,String actualResult,String stepName)throws Exception;
}
