package com.asiainfo.aiga.runPlan.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.runPlan.bo.AigaRunPlan;

public interface IAigaRunPlanDAO {
	public AigaRunPlan[] getAigaRunPlanBySql(String querySql)throws Exception;
	
	public List getAllRunTaskBySql(String querySql)throws Exception;
	
	public AigaRunPlan[] getAigaCaseByCriteria(DetachedCriteria criteria)throws Exception;
	
	public AigaRunPlan[] getUpdateByCriteria(DetachedCriteria criteria)throws Exception;
	
	public void saveOrUpdate(AigaRunPlan aValue)throws Exception;
	
	public void delete(AigaRunPlan aValue)throws Exception;
	
	public List getRunTaskResultByCon(String subTaskId, String taskId)throws Exception;
	
	public void saveAigaRunPlan(List list)throws Exception;
	
	public void deleteAll(List list)throws Exception;
	
}
