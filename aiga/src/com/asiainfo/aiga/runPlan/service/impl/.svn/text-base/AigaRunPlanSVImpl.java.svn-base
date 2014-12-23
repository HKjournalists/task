package com.asiainfo.aiga.runPlan.service.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import com.asiainfo.aiga.runPlan.bo.AigaRunPlan;
import com.asiainfo.aiga.runPlan.dao.IAigaRunPlanDAO;
import com.asiainfo.aiga.runPlan.service.IAigaRunPlanSV;

public class AigaRunPlanSVImpl implements IAigaRunPlanSV {

	private IAigaRunPlanDAO aigaRunPlanDAO;
	
	public void setAigaRunPlanDAO(IAigaRunPlanDAO aigaRunPlanDAO) {
		this.aigaRunPlanDAO = aigaRunPlanDAO;
	}

	@Override
	public AigaRunPlan[] getAigaRunPlanBySql(String querySql)
			throws Exception {
		return aigaRunPlanDAO.getAigaRunPlanBySql(querySql);
	}

	@Override
	public void saveOrUpdate(AigaRunPlan value) throws Exception {
		aigaRunPlanDAO.saveOrUpdate(value);

	}

	@Override
	public void deleteResource(AigaRunPlan value) throws Exception {
		aigaRunPlanDAO.delete(value);

	}

	@Override
	public AigaRunPlan[] getAigaRunPlanBySubTaskId(Integer subTaskId) throws Exception {
		String HQL=" FROM AigaRunPlan as p , AigaRunTask as t where p.taskId = t.taskId ";
		if(!subTaskId.equals(""))HQL+=" and t.subTaskId="+subTaskId +"order by p.runId";
		return  aigaRunPlanDAO.getAigaRunPlanBySql(HQL);
	}

	@Override
	public List getAllRunTaskBySubTaskId(Integer subTaskId) throws Exception {
		String HQL=" FROM AigaRunPlan as p , AigaRunTask as t where p.taskId = t.taskId ";
		if(!subTaskId.equals(""))HQL+=" and t.subTaskId="+subTaskId;
		return  aigaRunPlanDAO.getAllRunTaskBySql(HQL);
	}

	@Override
	public AigaRunPlan[] getAigaRunPlanByTaskId(String taskId)
			throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaRunPlan.class);
		criteria.add(Restrictions.eq("taskId", taskId));
		criteria.addOrder(Order.asc("caseOrder"));
		AigaRunPlan[] aigaRunPlans = aigaRunPlanDAO.getAigaCaseByCriteria(criteria);
		return aigaRunPlans;
	}

	@Override
	public List getRunTaskResultByCon(String subTaskId, String taskId)
			throws Exception {
		return  aigaRunPlanDAO.getRunTaskResultByCon(subTaskId,taskId);
		
	}
	
	@Override
	public void deleteAll(List list) throws Exception {
		aigaRunPlanDAO.deleteAll(list);

	}

}
