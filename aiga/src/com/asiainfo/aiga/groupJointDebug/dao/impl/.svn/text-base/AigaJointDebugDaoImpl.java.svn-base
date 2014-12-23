package com.asiainfo.aiga.groupJointDebug.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.groupCase.bo.AigaRGroupChangeCase;
import com.asiainfo.aiga.groupJointDebug.bo.AigaJointDebugChange;
import com.asiainfo.aiga.groupJointDebug.bo.AigaJointDebugReqForm;
import com.asiainfo.aiga.groupJointDebug.bo.AigaJointDebugSubTaskForm;
import com.asiainfo.aiga.groupJointDebug.bo.AigaJointDebugTaskForm;
import com.asiainfo.aiga.groupJointDebug.dao.IAigaJointDebugDao;

public class AigaJointDebugDaoImpl extends HibernateDaoSupport implements IAigaJointDebugDao {

	@Override
	public void deleteAigaJointDebugReqForm(AigaJointDebugReqForm aValue)
			throws Exception {
		this.getHibernateTemplate().delete(aValue);
	}

	@Override
	public AigaJointDebugReqForm[] getAigaJointDebugReqForm(DetachedCriteria criteria) throws Exception {
		List<AigaJointDebugReqForm> aigaJointDebugReqForm = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaJointDebugReqForm.toArray(new AigaJointDebugReqForm[0]);
	}

	@Override
	public AigaJointDebugReqForm[] getAigaJointDebugReqForm(String querySql)
			throws Exception {
		List<AigaJointDebugReqForm> aigaJointDebugReqForm = this.getHibernateTemplate().find(querySql);
		return aigaJointDebugReqForm.toArray(new AigaJointDebugReqForm[0]);
	}

	@Override
	public void saveAigaJointDebugReqForm(AigaJointDebugReqForm aValue)
			throws Exception {
		this.getHibernateTemplate().saveOrUpdate(aValue);
	}

	@Override
	public void saveAigaJointDebugTaskForm(AigaJointDebugTaskForm aValue)
			throws Exception {
		this.getHibernateTemplate().saveOrUpdate(aValue);
		
	}

	@Override
	public AigaJointDebugTaskForm[] getAigaJointDebugTaskForm(
			DetachedCriteria criteria) throws Exception {
		List<AigaJointDebugTaskForm> aigaJointDebugTaskForm = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaJointDebugTaskForm.toArray(new AigaJointDebugTaskForm[0]);
	}

	@Override
	public AigaJointDebugTaskForm[] getAigaJointDebugTaskForm(String querySql)
			throws Exception {
		List<AigaJointDebugTaskForm> aigaJointDebugTaskForm = this.getHibernateTemplate().find(querySql);
		return aigaJointDebugTaskForm.toArray(new AigaJointDebugTaskForm[0]);
	}

	@Override
	public void deleteAigaJointDebugTaskForm(AigaJointDebugTaskForm aValue)
			throws Exception {
		this.getHibernateTemplate().delete(aValue);
		
	}

	@Override
	public void deleteAigaJointDebugSubTaskForm(AigaJointDebugSubTaskForm aValue)
			throws Exception {
		this.getHibernateTemplate().delete(aValue);
		
	}

	@Override
	public AigaJointDebugSubTaskForm[] getAigaJointDebugSubTaskForm(
			DetachedCriteria criteria) throws Exception {
		List<AigaJointDebugSubTaskForm> aigaJointDebugSubTaskForm = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaJointDebugSubTaskForm.toArray(new AigaJointDebugSubTaskForm[0]);
	}

	@Override
	public AigaJointDebugSubTaskForm[] getAigaJointDebugSubTaskForm(
			String querySql) throws Exception {
		List<AigaJointDebugSubTaskForm> aigaJointDebugSubTaskForm = this.getHibernateTemplate().find(querySql);
		return aigaJointDebugSubTaskForm.toArray(new AigaJointDebugSubTaskForm[0]);
	}

	@Override
	public void saveAigaJointDebugSubTaskForm(AigaJointDebugSubTaskForm aValue)
			throws Exception {
		this.getHibernateTemplate().saveOrUpdate(aValue);
		
	}

	@Override
	public void saveAigaJointDebugChange(AigaJointDebugChange aValue)
			throws Exception {
		this.getHibernateTemplate().saveOrUpdate(aValue);
		
	}

	@Override
	public AigaJointDebugChange[] getAigaJointDebugChange(
			DetachedCriteria criteria) throws Exception {
		List<AigaJointDebugChange> aigaJointDebugChange = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaJointDebugChange.toArray(new AigaJointDebugChange[0]);
	}

	@Override
	public AigaJointDebugChange[] getAigaJointDebugChange(String querySql)
			throws Exception {
		List<AigaJointDebugChange> aigaJointDebugChange = this.getHibernateTemplate().find(querySql);
		return aigaJointDebugChange.toArray(new AigaJointDebugChange[0]);
	}

	@Override
	public void deleteAigaJointDebugChange(AigaJointDebugChange aValue)
			throws Exception {
		this.getHibernateTemplate().delete(aValue);
		
	}

	@Override
	public void saveAigaRGroupChangeCase(AigaRGroupChangeCase aValue)
			throws Exception {
		// TODO Auto-generated method stub

		this.getHibernateTemplate().saveOrUpdate(aValue);
	}

}
