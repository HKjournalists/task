package com.asiainfo.aiga.runPlan.service;

import java.util.List;

import com.asiainfo.aiga.runPlan.bo.AigaRunPlan;

public interface IAigaRunPlanSV {
	
	public AigaRunPlan[] getAigaRunPlanBySql(String querySql) throws Exception;
	
	public void saveOrUpdate(AigaRunPlan value) throws Exception;
	
	public void deleteResource(AigaRunPlan value) throws Exception;
	
	public  AigaRunPlan[] getAigaRunPlanBySubTaskId(Integer subTaskId)throws Exception;
	
	public  AigaRunPlan[] getAigaRunPlanByTaskId(String taskId)throws Exception;
	
	public  List getAllRunTaskBySubTaskId(Integer subTaskId)throws Exception;
	
	public List getRunTaskResultByCon(String subTaskId,String taskId)throws Exception;

	public void deleteAll(List list) throws Exception;

}
