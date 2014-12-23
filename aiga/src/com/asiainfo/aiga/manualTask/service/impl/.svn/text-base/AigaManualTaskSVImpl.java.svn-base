package com.asiainfo.aiga.manualTask.service.impl;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import com.asiainfo.aiga.log.bo.AigaLogElement;
import com.asiainfo.aiga.log.bo.AigaLogStep;
import com.asiainfo.aiga.log.bo.AigaLogTestCase;
import com.asiainfo.aiga.log.dao.IAigaLogDao;
import com.asiainfo.aiga.manualTask.bo.AigaManualTask;
import com.asiainfo.aiga.manualTask.dao.IAigaManualTaskDao;
import com.asiainfo.aiga.manualTask.service.IAigaManualTaskSV;
import com.asiainfo.aiga.r_case_comp.bo.AigaRCaseComp;
import com.asiainfo.aiga.r_case_comp.bo.extend.AigaInstRCaseComp;
import com.asiainfo.aiga.r_case_comp.dao.IAigaRCaseCompDAO;
import com.asiainfo.aiga.runPlan.bo.AigaRunPlan;
import com.asiainfo.aiga.runPlan.dao.IAigaRunPlanDAO;
import com.asiainfo.aiga.userCase.bo.AigaCase;

public class AigaManualTaskSVImpl implements IAigaManualTaskSV{

	private IAigaManualTaskDao aigaManualTaskDao;
	private IAigaLogDao aigaLogDao;
	private IAigaRunPlanDAO aigaRunPlanDAO;
	private IAigaRCaseCompDAO aigaRCaseCompDAO;
	
	public void setAigaRunPlanDAO(IAigaRunPlanDAO aigaRunPlanDAO) {
		this.aigaRunPlanDAO = aigaRunPlanDAO;
	}

	public void setAigaLogDao(IAigaLogDao aigaLogDao) {
		this.aigaLogDao = aigaLogDao;
	}

	public void setAigaManualTaskDao(IAigaManualTaskDao aigaManualTaskDao) {
		this.aigaManualTaskDao = aigaManualTaskDao;
	}

	public void setAigaRCaseCompDAO(IAigaRCaseCompDAO aigaRCaseCompDAO) {
		this.aigaRCaseCompDAO = aigaRCaseCompDAO;
	}

	@Override
	public void saveManualTask(AigaManualTask aigaManualTask) throws Exception {
		// TODO Auto-generated method stub
		aigaManualTaskDao.saveManualTask(aigaManualTask);
	}

	@Override
	public void deleteManualTask(AigaManualTask aigaManualTask)
			throws Exception {
		// TODO Auto-generated method stub
		aigaManualTaskDao.deleteManualTask(aigaManualTask);
	}

	@Override
	public AigaManualTask[] getManualTask(Integer taskId) throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaManualTask.class);
		criteria.add(Restrictions.eq("taskId", taskId));
		return aigaManualTaskDao.getManualTask(criteria);
	}

	@Override
	public AigaManualTask[] getManualTaskByCaseId(Integer caseId)
			throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaManualTask.class);
		criteria.add(Restrictions.eq("caseId", caseId));
		criteria.addOrder(Order.asc("taskOrder"));
		return aigaManualTaskDao.getManualTask(criteria);
	}

	@Override
	public void saveManualTasks(List<AigaManualTask> aigaManualTasks)
			throws Exception {
		// TODO Auto-generated method stub
		for(AigaManualTask aigaManualTask:aigaManualTasks){
			aigaManualTaskDao.saveManualTask(aigaManualTask);
		}
	}

	@Override
	public void deleteManualTaskByTaskId(Integer taskId) throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaManualTask.class);
		criteria.add(Restrictions.eq("taskId", taskId));
		AigaManualTask[] aigaManualTasks = aigaManualTaskDao.getManualTask(criteria);
		if(aigaManualTasks.length==1){
			aigaManualTaskDao.deleteManualTask(aigaManualTasks[0]);
			DetachedCriteria criteria2 = DetachedCriteria.forClass(AigaInstRCaseComp.class);
			criteria2.add(Restrictions.eq("manualTaskId", aigaManualTasks[0].getTaskId()));
			AigaRCaseComp[] aigaRCaseComps = aigaRCaseCompDAO.getAigaRCaseCompByCriteria(criteria);
			for(AigaRCaseComp aigaRCaseComp : aigaRCaseComps){
				aigaRCaseCompDAO.delete(aigaRCaseComp);
			}
		}
	}

	@Override
	public void saveManualTaskAndLog(String taskId, String manualTaskId,
			String runResult, String runId, String runTime, String caseId,
			String preResult, String preTestData, String actualResult,String stepName)
			throws Exception {
		// TODO Auto-generated method stub
		AigaManualTask[] aigaManualTasks = this.getManualTask(Integer.valueOf(manualTaskId));
		if(aigaManualTasks.length==1){
			aigaManualTasks[0].setActualResult(actualResult);
			aigaManualTasks[0].setPreResult(preResult);
			aigaManualTasks[0].setPreTestData(preTestData);
			this.saveManualTask(aigaManualTasks[0]);
			DetachedCriteria criteria = DetachedCriteria.forClass(AigaRunPlan.class);
			criteria.add(Restrictions.eq("runId", Integer.valueOf(runId)));
			criteria.add(Restrictions.eq("caseId", Integer.valueOf(caseId)));
			AigaRunPlan[] aigaRunPlans = aigaRunPlanDAO.getAigaCaseByCriteria(criteria);
			if(aigaRunPlans.length==1){
				Date time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(runTime);
				aigaRunPlans[0].setRunTime(new Timestamp(time.getTime()));
				aigaRunPlanDAO.saveOrUpdate(aigaRunPlans[0]);
			}
			
			List list = aigaLogDao.getLogsByHql("from AigaLogTestCase as caselog inner join caselog.aigaLogSteps as steplog inner join steplog.aigaLogElements as elemlog where caselog.caseId="+caseId+" and caselog.runId="+runId+" and steplog.manualTaskId="+manualTaskId);
			if(list.size()==0){
				List logCases = aigaLogDao.getLogsByHql("from AigaLogTestCase where caseId="+caseId+" and runId="+runId);
				if(logCases.size()==0){
					AigaLogTestCase aigaLogTestCase = new AigaLogTestCase();
					aigaLogTestCase.setCaseType(2);
					aigaLogTestCase.setRunId(Integer.valueOf(runId));
					aigaLogTestCase.setCaseId(Integer.valueOf(caseId));
					AigaLogStep aigaLogStep = new AigaLogStep();
					aigaLogStep.setManualTaskId(Integer.valueOf(manualTaskId));
					aigaLogStep.setResult(runResult);
					aigaLogStep.setStepName(stepName);
					List list2 = new ArrayList();
					list2.add(aigaLogStep);
					aigaLogTestCase.setAigaLogSteps(list2);
					AigaLogElement aigaLogElement = new AigaLogElement();
					aigaLogElement.setActualValue(actualResult);
					aigaLogElement.setExpectValue(preResult);
					List list3 = new ArrayList();
					list3.add(aigaLogElement);
					aigaLogStep.setAigaLogElements(list3);
					
					aigaLogDao.saveLog(aigaLogTestCase);
				}else if(logCases.size()==1){
					AigaLogTestCase aigaLogTestCase = (AigaLogTestCase)logCases.get(0);
					List steplog = aigaLogDao.getLogsByHql("from AigaLogStep where testId="+aigaLogTestCase.getTestId()+" and manualTaskId="+manualTaskId);
					if(steplog.size()==0){
						AigaLogStep aigaLogStep = new AigaLogStep();
						aigaLogStep.setManualTaskId(Integer.valueOf(manualTaskId));
						aigaLogStep.setResult(runResult);
						aigaLogStep.setStepName(stepName);
						List list2 = new ArrayList();
						list2.add(aigaLogStep);
						aigaLogTestCase.setAigaLogSteps(list2);
						AigaLogElement aigaLogElement = new AigaLogElement();
						aigaLogElement.setActualValue(actualResult);
						aigaLogElement.setExpectValue(preResult);
						List list3 = new ArrayList();
						list3.add(aigaLogElement);
						aigaLogStep.setAigaLogElements(list3);
						
						aigaLogDao.saveLog(aigaLogTestCase);
					}else if(steplog.size()==1){
						AigaLogStep aigaLogStep = (AigaLogStep)steplog.get(0);
						aigaLogStep.setManualTaskId(Integer.valueOf(manualTaskId));
						aigaLogStep.setResult(runResult);
						aigaLogStep.setStepName(stepName);
						
						List list2 = new ArrayList();
						list2.add(aigaLogStep);
						aigaLogTestCase.setAigaLogSteps(list2);
						
						List elemlog = aigaLogDao.getLogsByHql("from AigaLogElement where stepId="+aigaLogStep.getStepId());
						if(elemlog.size()==0){
							AigaLogElement aigaLogElement = new AigaLogElement();
							aigaLogElement.setActualValue(actualResult);
							aigaLogElement.setExpectValue(preResult);
							List list3 = new ArrayList();
							list3.add(aigaLogElement);
							aigaLogStep.setAigaLogElements(list3);
							
							aigaLogDao.saveLog(aigaLogTestCase);
						}else if(elemlog.size()==1){
							AigaLogElement aigaLogElement = (AigaLogElement)elemlog.get(0);
							aigaLogElement.setActualValue(actualResult);
							aigaLogElement.setExpectValue(preResult);
							
							List list3 = new ArrayList();
							list3.add(aigaLogElement);
							aigaLogStep.setAigaLogElements(list3);
							aigaLogDao.saveLog(aigaLogTestCase);
						}else
							throw new Exception("查找到的元素日志不唯一");
					}else
						throw new Exception("查询到的步骤日志不唯一");
				}else
					throw new Exception("查询到的用例日志不唯一");
			}else{
				AigaLogTestCase aigaLogTestCase = null;
				AigaLogStep aigaLogStep = null;
				AigaLogElement aigaLogElement = null;
				Object[] allList = (Object[])list.get(0);
				for(int i=0,n=allList.length;i<n;i++){
					if(allList[i] instanceof AigaLogTestCase){
						aigaLogTestCase = (AigaLogTestCase)allList[i];
					}else if(allList[i] instanceof AigaLogStep){
						aigaLogStep = (AigaLogStep)allList[i];
					}else if(allList[i] instanceof AigaLogElement){
						aigaLogElement = (AigaLogElement)allList[i];
					}
				}
				List list2 = new ArrayList();
				aigaLogStep.setManualTaskId(Integer.valueOf(manualTaskId));
				aigaLogStep.setResult(runResult);
				aigaLogStep.setStepName(stepName);
				list2.add(aigaLogStep);
				aigaLogTestCase.setAigaLogSteps(list2);
				aigaLogElement.setActualValue(actualResult);
				aigaLogElement.setExpectValue(preResult);
				List list3 = new ArrayList();
				list3.add(aigaLogElement);
				aigaLogStep.setAigaLogElements(list3);
				
				aigaLogDao.saveLog(aigaLogTestCase);
			}
		}else
			throw new Exception("未查找到相应的手工用例任务");
	}

	@Override
	public JSONArray getAigaManualTaskJson(Integer caseId) throws Exception {
		// TODO Auto-generated method stub
		JSONArray array = new JSONArray();
		AigaManualTask[] aigaManualTasks = this.getManualTaskByCaseId(caseId);
		for(AigaManualTask aigaManualTask : aigaManualTasks){
			JSONObject object = new JSONObject();
			object.put("id", aigaManualTask.getTaskId());
			object.put("text", aigaManualTask.getTaskName());
			object.put("leaf", false);
			object.put("expanded", true);
			
			object.put("taskId", aigaManualTask.getTaskId());
			object.put("taskName", aigaManualTask.getTaskName());
			object.put("taskDesc", aigaManualTask.getTaskDesc());
			object.put("preResult", aigaManualTask.getPreResult());
			object.put("preTestData", aigaManualTask.getPreTestData());
			object.put("caseId", aigaManualTask.getCaseId());
			object.put("taskOrder", aigaManualTask.getTaskOrder());
			
			array.add(object);
		}
		return array;
	}

}
