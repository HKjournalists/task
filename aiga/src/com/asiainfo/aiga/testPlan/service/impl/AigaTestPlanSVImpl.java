package com.asiainfo.aiga.testPlan.service.impl;


import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.asiainfo.aiga.testPlan.bo.AigaTestPlan;
import com.asiainfo.aiga.testPlan.dao.IAigaTestPlanDAO;
import com.asiainfo.aiga.testPlan.service.IAigaTestPlanSV;
import com.asiainfo.aiga.testTask.bo.AigaTestTask;

public class AigaTestPlanSVImpl implements IAigaTestPlanSV{
	
	IAigaTestPlanDAO testPlanDAO;
	
	public void setTestPlanDAO(IAigaTestPlanDAO aigaTestPlanDAO) {
		this.testPlanDAO = aigaTestPlanDAO;
	}

	public void deleteAigaTestObj(Object value) throws Exception {
		// TODO Auto-generated method stub
		testPlanDAO.delete(value);
	}

	public void saveAigaTestPlan(AigaTestPlan value) throws Exception {
		// TODO Auto-generated method stub
		testPlanDAO.saveOrUpdate(value);
	}

	public AigaTestTask[] getAigaTestTaskByPlanId(String planId) throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaTestTask.class);
		if(planId!=null&&!planId.equals("")){
			criteria.add(Restrictions.eq("planId", Integer.valueOf(planId)));
		}else{
			criteria.add(Restrictions.isNull("planId"));
		}
		return testPlanDAO.getAigaTestTaskByCriteria(criteria);
	}
	
	public AigaTestPlan[] getAigaTestPlanBySql(String querySql) throws Exception {
		return testPlanDAO.getAigaTestPlanBySql(querySql);
	}

	@Override
	public void saveAigaTestObj(Object aValue) throws Exception {
		// TODO Auto-generated method stub
				testPlanDAO.saveOrUpdate(aValue);
		
	}

	@Override
	public boolean createRel4PlanAndTask(String planId,String planTag,String[] taskIdArray) throws Exception {
		return  testPlanDAO.createRel4PlanAndTask(planId, planTag,taskIdArray);
	}

	@Override
	public boolean delRel4PlanAndTask(String planId, String taskId)
			throws Exception {
		String SQL="update aiga_test_task set plan_id= null ,plan_tag =null where task_id ="+taskId;
		return testPlanDAO.manageRel4PlanAndTask(SQL);
	}

	@Override
	public List getObjectByHQL(String HQL ) throws Exception {
	
		return testPlanDAO.getObjectByHQL(HQL);
	}
	@Override
	public boolean updateBySQL(String SQL)throws Exception {
		return testPlanDAO.updateBySQL(SQL);
	}

	@Override
	public List getObjectByHQL(String HQL, int pageSize, int page)
			throws Exception {
		return testPlanDAO.getObjectByHQL(HQL, pageSize, page);
	}

	@Override
	public List getObjectBySQL(String SQL) throws Exception {
		// TODO Auto-generated method stub
		return testPlanDAO.getObjectBySQL(SQL);
	}

}
