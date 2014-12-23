package com.asiainfo.aiga.userCase.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.userCase.bo.AigaCaseParams;
import com.asiainfo.aiga.userCase.dao.IAigaCaseParamDAO;

public class AigaCaseParamDAOImpl extends HibernateDaoSupport implements IAigaCaseParamDAO{

	@Override
	public AigaCaseParams[] getAigaCaseParams(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		List<AigaCaseParams> aigaCaseParams = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaCaseParams.toArray(new AigaCaseParams[0]);
	}

	@Override
	public void saveAigaCaseParams(AigaCaseParams aValue) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(aValue);
	}

	@Override
	public void deleteAigaCaseParams(AigaCaseParams aValue) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(aValue);
	}

}
