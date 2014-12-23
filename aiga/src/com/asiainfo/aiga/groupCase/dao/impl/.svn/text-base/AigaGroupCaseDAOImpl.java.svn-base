package com.asiainfo.aiga.groupCase.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.groupCase.bo.AigaGroupCase;
import com.asiainfo.aiga.groupCase.bo.AigaHisGroupCase;
import com.asiainfo.aiga.groupCase.bo.AigaRGroupChangeCase;
import com.asiainfo.aiga.groupCase.bo.AigaRGroupSubCase;
import com.asiainfo.aiga.groupCase.dao.IAigaGroupCaseDAO;

public class AigaGroupCaseDAOImpl extends HibernateDaoSupport implements IAigaGroupCaseDAO {

	@Override
	public void saveOrUpdate(AigaGroupCase aValue) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(aValue);
	}

	@Override
	public AigaGroupCase[] getGroupCase(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		List<AigaGroupCase> aigaGroupCases = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaGroupCases.toArray(new AigaGroupCase[0]);
	}

	@Override
	public void delete(AigaGroupCase aValue) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(aValue);
	}

	@Override
	public void delete(AigaRGroupSubCase aValue) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(aValue);
		
	}

	@Override
	public AigaRGroupSubCase[] getAigaRGroupSubCase(DetachedCriteria criteria)
			throws Exception {

		List<AigaRGroupSubCase> aigaRGroupSubCases = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaRGroupSubCases.toArray(new AigaRGroupSubCase[0]);
	}

	@Override
	public void saveOrUpdateAigaRGroupSubCase(AigaRGroupSubCase aValue)
			throws Exception {
		this.getHibernateTemplate().saveOrUpdate(aValue);
		
	}

	@Override
	public void saveOrUpdate(AigaHisGroupCase aValue) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(aValue);		
	}

	@Override
	public AigaRGroupChangeCase[] getAigaRGroupChangeCase(
			DetachedCriteria criteria) throws Exception {
		List<AigaRGroupChangeCase> aigaRGroupChangeCases = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaRGroupChangeCases.toArray(new AigaRGroupChangeCase[0]);
	}

}
