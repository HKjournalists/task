package com.asiainfo.aiga.requisition.service;

import net.sf.json.JSONArray;

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
import com.asiainfo.aiga.testTask.bo.AigaPerftestTask;
import com.asiainfo.aiga.testTask.bo.AigaTestTask;

public interface IAigaRequisitionSV {

	public void saveAigaRequisition(AigaRequisition aValue)throws Exception;
	
	public void deleteAigaRequisition(AigaRequisition aValue)throws Exception;
	
	public void delete(Object object) throws Exception;
	
	public void saveOrUpdate(Object value) throws Exception;
	
	public AigaRequisition[] getAigaRequisitionBySql(String querySql) throws Exception;
	
	public AigaAudit[] getAigaAuditBySql(String querySql) throws Exception;
	
	public AigaAccountTest[] getAigaAccountTestBySql(String querySql) throws Exception;
	
	public AigaTestSubTask[] getAigaTestSubTaskBySql(String querySql) throws Exception;
	
	public AigaTestSubReason[] getAigaTestSubReasonBySql(String querySql) throws Exception;
	
	public void deleteAigaTestSubTask(AigaTestSubTask aValue)throws Exception;
	
	public void saveAigaTestSubTask(AigaTestSubTask aValue)throws Exception;
	
	public void savePerSubTask(AigaPerformanceSubTask aValue) throws Exception;
	
	public AigaPerformanceSubTask[] getSubRelaPerFormBySql(String querySql) throws Exception;
	
	public AigaPerfSubResult[] getAigaPerfSubResultBySql(String querySql) throws Exception;
	
	public AigaTestTask[] getAigaTestTaskBySql(String querySql) throws Exception;
	
	public AigaPerformanceSubTask[] getPerSubTaskBySql(String querySql) throws Exception;
	
	public void saveAigaSubTaskProblem(AigaSubTaskProblem subTaskProblem)throws Exception;
	
	public JSONArray getSubTaskForCaseLib(long staffId)throws Exception;
	
	public SysOrganize[] getStaffOrgBySql(String querySql) throws Exception;
	
	public SysStaffOrgRelat[] getTestorIdByOrgId(String querySql)throws Exception;
	
	public JSONArray getSubTaskTestorForSearch()throws Exception;
	
	public AigaQuestion[] getAigaQuestionBySql(String querySql) throws Exception;

	public void deleteAigaQuestionBySql(AigaQuestion o) throws Exception;
	
	public void saveOrUpdateAigaQuestion(AigaQuestion value) throws Exception;
	
	public boolean updateBySQL(String sql) throws Exception;

}
