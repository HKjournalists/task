package com.asiainfo.aiga.requisition.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.requisition.bo.AigaAccountTest;
import com.asiainfo.aiga.requisition.bo.AigaAudit;
import com.asiainfo.aiga.requisition.bo.AigaPerfSubResult;
import com.asiainfo.aiga.requisition.bo.AigaPerformanceSubTask;
import com.asiainfo.aiga.requisition.bo.AigaQuestion;
import com.asiainfo.aiga.requisition.bo.AigaRequisition;
import com.asiainfo.aiga.requisition.bo.AigaTestSubReason;
import com.asiainfo.aiga.requisition.bo.AigaTestSubTask;
import com.asiainfo.aiga.requisition.bo.SysOrganize;
import com.asiainfo.aiga.requisition.bo.SysStaffOrgRelat;
import com.asiainfo.aiga.testTask.bo.AigaTestTask;

public interface IAigaRequisitionDAO {

	public AigaRequisition[] getAigaRequisitionBySql(String querySql)throws Exception;
	
	public AigaAudit[] getAigaAuditBySql(String querySql) throws Exception;
	
	public AigaPerfSubResult[] getAigaPerfSubResultBySql(String querySql) throws Exception;
	
	public AigaAccountTest[] getAigaAccountTestBySql(String querySql) throws Exception;
	
	public AigaRequisition[] getAigaRequisitionByCriteria(DetachedCriteria criteria)throws Exception;
	
	public void saveOrUpdate(Object aValue)throws Exception;
	
	public void delete(Object aValue)throws Exception;
	
	public AigaTestSubTask[] getAigaTestSubTaskByCriteria( DetachedCriteria criteria) throws Exception;
	
	public List getAigaTestSubTask( DetachedCriteria criteria) throws Exception;
	
	public AigaTestSubTask[] getAigaTestSubTaskBySql(String querySql) throws Exception;
	
	public AigaTestSubReason[] getAigaTestSubReasonBySql(String querySql) throws Exception;
	
	public AigaTestTask[] getAigaTestTaskBySql(String querySql) throws Exception;
	
	public AigaPerformanceSubTask[] getSubRelaPerFormBySql(String querySql) throws Exception;
	
	public AigaPerformanceSubTask[] getPerSubTaskBySql(String querySql) throws Exception;
	
	public SysOrganize[] getStaffOrganizeBySql(String querySql)throws Exception;
	
	public SysStaffOrgRelat[] getTestorIdByOrgId(String querySql)throws Exception;

	public boolean updateBySQL(String SQL) throws Exception;
	
	public AigaQuestion[] getAigaQuestionBySql(String querySql)throws Exception;
	
}
