package com.asiainfo.aiga.testPlan.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.testPlan.bo.AigaTestPlan;
import com.asiainfo.aiga.testTask.bo.AigaTestTask;

public interface IAigaTestPlanSV {
	public void saveAigaTestPlan(AigaTestPlan aValue) throws Exception;
	public void saveAigaTestObj(Object aValue) throws Exception;
	public void deleteAigaTestObj(Object aValue) throws Exception;

	public AigaTestTask[] getAigaTestTaskByPlanId(String planId)throws Exception;

	public AigaTestPlan[] getAigaTestPlanBySql(String querySql)throws Exception;

	public List getObjectByHQL(String HQL ) throws Exception ;
	public List getObjectByHQL(String HQL,int pageSize,int page ) throws Exception ;
	public boolean createRel4PlanAndTask(String planId,String planTag,String[] taskIdArray) throws Exception ;
	public boolean delRel4PlanAndTask(String planId,String taskId)throws Exception;
	boolean updateBySQL(String SQL) throws Exception;
	public List getObjectBySQL(String SQL)throws Exception ;
}
