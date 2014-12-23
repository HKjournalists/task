package com.asiainfo.aiga.userCase.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.userCase.bo.AigaRFunElem;
import com.asiainfo.aiga.userCase.dao.IAigaRFunElemDAO;

public class AigaRFunElemDAOImpl extends HibernateDaoSupport implements IAigaRFunElemDAO {

	@Override
	public AigaRFunElem[] getRFunElem(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		List<AigaRFunElem> aigaRFunElems = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaRFunElems.toArray(new AigaRFunElem[0]);
	}

	@Override
	public void saveOrUpdate(AigaRFunElem aValue) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(aValue);
	}

	@Override
	public void deleteRFunElem(AigaRFunElem aValue) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(aValue);
	}

}
