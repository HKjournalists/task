package com.asiainfo.aiga.testPlan.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.testPlan.bo.AigaTestPlan;
import com.asiainfo.aiga.testTask.bo.AigaTestTask;

public interface IAigaTestPlanDAO {
	public AigaTestPlan[] getAigaTestPlanBySql(String querySql) throws Exception;

	
	public AigaTestPlan[] getAigaTestPlanByCriteria(DetachedCriteria criteria)
			throws Exception;

	public void saveOrUpdate(Object aValue) throws Exception;

	public void delete(Object aValue) throws Exception;
	public AigaTestTask[] getAigaTestTaskBySql(String querySql)throws Exception;
	public AigaTestTask[] getAigaTestTaskByCriteria(DetachedCriteria criteria) throws Exception;
	public boolean createRel4PlanAndTask(String planId,String planTag, String[] taskIdArray) throws Exception;
	public boolean manageRel4PlanAndTask(String SQL)throws Exception;
	public List getObjectByHQL(String HQL) throws Exception ;
	public List getObjectByHQL(String HQL, int pageSize, int page) throws Exception ;

	boolean updateBySQL(String SQL) throws Exception;
	public List getObjectBySQL(String SQL)throws Exception ;
}
