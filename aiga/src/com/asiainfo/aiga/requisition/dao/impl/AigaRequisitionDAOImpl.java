package com.asiainfo.aiga.requisition.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

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
import com.asiainfo.aiga.requisition.dao.IAigaRequisitionDAO;
import com.asiainfo.aiga.testTask.bo.AigaTestTask;

public class AigaRequisitionDAOImpl extends HibernateDaoSupport implements IAigaRequisitionDAO {

	public void delete(Object value) throws Exception {
		this.getHibernateTemplate().delete(value);
	}

	public AigaRequisition[] getAigaRequisitionByCriteria( DetachedCriteria criteria) throws Exception {
		List<AigaRequisition> aigaRequisitions = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaRequisitions.toArray(new AigaRequisition[0]);
	}

	public AigaRequisition[] getAigaRequisitionBySql(String querySql) throws Exception {
		List<AigaRequisition> aigaRequisitions = this.getHibernateTemplate().find(querySql);
		return aigaRequisitions.toArray(new AigaRequisition[0]);
	}
	
	public AigaAudit[] getAigaAuditBySql(String querySql) throws Exception {
		List<AigaAudit> audits = this.getHibernateTemplate().find(querySql);
		return audits.toArray(new AigaAudit[0]);
	}
	
	public AigaPerfSubResult[] getAigaPerfSubResultBySql(String querySql) throws Exception {
		List<AigaPerfSubResult> results = this.getHibernateTemplate().find(querySql);
		return results.toArray(new AigaPerfSubResult[0]);
	}
	
	public AigaAccountTest[] getAigaAccountTestBySql(String querySql) throws Exception {
		List<AigaAccountTest> accounts = this.getHibernateTemplate().find(querySql);
		return accounts.toArray(new AigaAccountTest[0]);
	}
	
	public void saveOrUpdate(Object value) throws Exception {
		this.getHibernateTemplate().saveOrUpdate(value);
	}
	
	public AigaTestSubTask[] getAigaTestSubTaskByCriteria( DetachedCriteria criteria) throws Exception {
		List<AigaTestSubTask> subTasks = this.getHibernateTemplate().findByCriteria(criteria);
		return subTasks.toArray(new AigaTestSubTask[0]);
	}
	
	public List getAigaTestSubTask( DetachedCriteria criteria) throws Exception {
		List subTasks = this.getHibernateTemplate().findByCriteria(criteria);
		return subTasks;
	}

	public AigaTestSubTask[] getAigaTestSubTaskBySql(String querySql) throws Exception {
		List<AigaTestSubTask> subTasks = this.getHibernateTemplate().find(querySql);
		return subTasks.toArray(new AigaTestSubTask[0]);
	}
	
	public AigaTestSubReason[] getAigaTestSubReasonBySql(String querySql) throws Exception {
		List<AigaTestSubReason> reasons = this.getHibernateTemplate().find(querySql);
		return reasons.toArray(new AigaTestSubReason[0]);
	}
	
	public AigaTestTask[] getAigaTestTaskBySql(String querySql) throws Exception {
		List<AigaTestTask> tasks = this.getHibernateTemplate().find(querySql);
		return tasks.toArray(new AigaTestTask[0]);
	}
	
	public AigaPerformanceSubTask[] getSubRelaPerFormBySql(String querySql) throws Exception {
		List<AigaPerformanceSubTask> pers = this.getHibernateTemplate().find(querySql);
		return pers.toArray(new AigaPerformanceSubTask[0]);
	}
	
	public AigaPerformanceSubTask[] getPerSubTaskBySql(String querySql) throws Exception {
		List<AigaPerformanceSubTask> pers = this.getHibernateTemplate().find(querySql);
		return pers.toArray(new AigaPerformanceSubTask[0]);
	}

	@Override
	public SysOrganize[] getStaffOrganizeBySql(String querySql)
			throws Exception {
		// TODO Auto-generated method stub
		List<SysOrganize> staffOrg=this.getHibernateTemplate().find(querySql);
		return staffOrg.toArray(new SysOrganize[0]);
	}

	@Override
	public SysStaffOrgRelat[] getTestorIdByOrgId(String querySql) throws Exception {
		// TODO Auto-generated method stub
		List<SysStaffOrgRelat> staffId=this.getHibernateTemplate().find(querySql);
		return staffId.toArray(new SysStaffOrgRelat[0]);
	}

	@Override
	public AigaQuestion[] getAigaQuestionBySql(String querySql) throws Exception {
		// TODO Auto-generated method stub
		List<AigaQuestion> audits = this.getHibernateTemplate().find(querySql);
		return audits.toArray(new AigaQuestion[0]);
	}

	@Override
	public boolean updateBySQL(String SQL)throws Exception {
		final String sql = SQL;
		this.getHibernateTemplate().execute(new HibernateCallback() {
			    public Object doInHibernate(Session session) throws HibernateException, SQLException {  
			         SQLQuery query = session.createSQLQuery(sql);    
			         return query.executeUpdate();
			   }  
	    });  
		
		return true;
	}
}
