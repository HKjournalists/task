package com.asiainfo.aiga.requisition.service.impl;

import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import com.asiainfo.aiga.common.WorkflowParam;
import com.asiainfo.aiga.requisition.bo.AigaAccountTest;
import com.asiainfo.aiga.requisition.bo.AigaAudit;
import com.asiainfo.aiga.requisition.bo.AigaPerfSubResult;
import com.asiainfo.aiga.requisition.bo.AigaPerformanceSubTask;
import com.asiainfo.aiga.requisition.bo.AigaQuestion;
import com.asiainfo.aiga.requisition.bo.AigaRequisition;
import com.asiainfo.aiga.requisition.bo.AigaSubTaskProblem;
import com.asiainfo.aiga.requisition.bo.AigaTestSubReason;
import com.asiainfo.aiga.requisition.bo.AigaTestSubTask;
import com.asiainfo.aiga.requisition.bo.SysOrganize;
import com.asiainfo.aiga.requisition.bo.SysStaffOrgRelat;
import com.asiainfo.aiga.requisition.dao.IAigaRequisitionDAO;
import com.asiainfo.aiga.requisition.service.IAigaRequisitionSV;
import com.asiainfo.aiga.testTask.bo.AigaTestTask;

public class AigaRequisitionSVImpl implements IAigaRequisitionSV {

	private IAigaRequisitionDAO requisitionDAO;
	
	public void setRequisitionDAO(IAigaRequisitionDAO requisitionDAO) {
		this.requisitionDAO = requisitionDAO;
	}

	public void deleteAigaRequisition(AigaRequisition value) throws Exception {
		requisitionDAO.delete(value);
	}
	
	public void delete(Object object) throws Exception {
		requisitionDAO.delete(object);
	}

	public void saveAigaRequisition(AigaRequisition value) throws Exception {
		requisitionDAO.saveOrUpdate(value);
	}
	
	public void saveOrUpdate(Object value) throws Exception {
		requisitionDAO.saveOrUpdate(value);
	}
	
	public AigaRequisition[] getAigaRequisitionBySql(String querySql) throws Exception {
		return requisitionDAO.getAigaRequisitionBySql(querySql);
	}
	
	public AigaAudit[] getAigaAuditBySql(String querySql) throws Exception {
		return requisitionDAO.getAigaAuditBySql(querySql);
	}
	
	public AigaAccountTest[] getAigaAccountTestBySql(String querySql) throws Exception {
		return requisitionDAO.getAigaAccountTestBySql(querySql);
	}
	
	public AigaTestSubTask[] getAigaTestSubTaskBySql(String querySql) throws Exception {
		return requisitionDAO.getAigaTestSubTaskBySql(querySql);
	}
	
	public AigaTestSubReason[] getAigaTestSubReasonBySql(String querySql) throws Exception {
		return requisitionDAO.getAigaTestSubReasonBySql(querySql);
	}
	
	public void deleteAigaTestSubTask(AigaTestSubTask aValue)throws Exception {
		requisitionDAO.delete(aValue);
	}
	
	public void saveAigaTestSubTask(AigaTestSubTask aValue)throws Exception {
		requisitionDAO.saveOrUpdate(aValue);
	}
	
	public void savePerSubTask(AigaPerformanceSubTask aValue) throws Exception {
		requisitionDAO.saveOrUpdate(aValue);
	}
	
	public AigaPerformanceSubTask[] getSubRelaPerFormBySql(String querySql) throws Exception {
		return requisitionDAO.getPerSubTaskBySql(querySql);
	}
	
	public AigaPerfSubResult[] getAigaPerfSubResultBySql(String querySql) throws Exception {
		return requisitionDAO.getAigaPerfSubResultBySql(querySql);
	}
	
	public AigaTestTask[] getAigaTestTaskBySql(String querySql) throws Exception {
		return requisitionDAO.getAigaTestTaskBySql(querySql);
	}
	
	public AigaPerformanceSubTask[] getPerSubTaskBySql(String querySql) throws Exception {
		return requisitionDAO.getPerSubTaskBySql(querySql);
	}

	public void saveAigaSubTaskProblem(AigaSubTaskProblem subTaskProblem)
			throws Exception {
		// TODO Auto-generated method stub
		requisitionDAO.saveOrUpdate(subTaskProblem);
	}

	@Override
	public JSONArray getSubTaskForCaseLib(long staffId) throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaTestSubTask.class);
		criteria.add(Restrictions.eq("testorId", Integer.valueOf(String.valueOf(staffId))));
		criteria.add(Restrictions.ne("subTaskStatus", Integer.valueOf(String.valueOf(WorkflowParam.getWorkflow("subTaskTaskEnd").getLinkId()))));
		AigaTestSubTask[] aigaTestSubTasks = requisitionDAO.getAigaTestSubTaskByCriteria(criteria);
		JSONArray array = new JSONArray();
		for(AigaTestSubTask aigaTestSubTask : aigaTestSubTasks){
			JSONObject json = new JSONObject();
			json.put("text", aigaTestSubTask.getSubTaskName());
			json.put("value", aigaTestSubTask.getSubTaskTag());
			array.add(json);
		}
		return array;
	}

	@Override
	public SysOrganize[] getStaffOrgBySql(String querySql)
			throws Exception {
		// TODO Auto-generated method stub
		return requisitionDAO.getStaffOrganizeBySql(querySql);
	}

	@Override
	public SysStaffOrgRelat[] getTestorIdByOrgId(String querySql) throws Exception {
		// TODO Auto-generated method stub
		return requisitionDAO.getTestorIdByOrgId(querySql);
	}

	@Override
	public JSONArray getSubTaskTestorForSearch() throws Exception {
		// TODO Auto-generated method stub
		JSONArray array = new JSONArray();
		JSONObject object = new JSONObject();
		object.put("text","--«Î—°‘Ò--");
		object.put("value", "");
		array.add(object);
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaTestSubTask.class);
		criteria.setProjection(Projections.distinct(Projections.property("testorName")));
		List testors = requisitionDAO.getAigaTestSubTask(criteria);
		for(int i=0,n=testors.size();testors!=null&&i<n;i++){
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("text", testors.get(i));
			jsonObject.put("value", testors.get(i));
			
			array.add(jsonObject);
		}
		
		return array;
	}

	@Override
	public AigaQuestion[] getAigaQuestionBySql(String querySql) throws Exception {
		// TODO Auto-generated method stub
		return requisitionDAO.getAigaQuestionBySql(querySql);
	}

	@Override
	public void deleteAigaQuestionBySql(AigaQuestion o) throws Exception {
		// TODO Auto-generated method stub
		requisitionDAO.delete(o);
	}

	@Override
	public void saveOrUpdateAigaQuestion(AigaQuestion value) throws Exception {
		// TODO Auto-generated method stub
		requisitionDAO.saveOrUpdate(value);
	}
	@Override
	public boolean updateBySQL(String sql)
		throws Exception {
		return requisitionDAO.updateBySQL(sql);
	}

}
