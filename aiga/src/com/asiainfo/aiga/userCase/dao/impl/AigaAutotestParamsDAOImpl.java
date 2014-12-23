package com.asiainfo.aiga.userCase.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.userCase.bo.AigaAutotestParams;
import com.asiainfo.aiga.userCase.dao.IAigaAutotestParamsDAO;

public class AigaAutotestParamsDAOImpl extends HibernateDaoSupport implements IAigaAutotestParamsDAO {

	@Override
	public AigaAutotestParams[] getAigaAutotestParams(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		List<AigaAutotestParams> aigaAutotestParams = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaAutotestParams.toArray(new AigaAutotestParams[0]);
	}

	@Override
	public void saveAigaAutotestParams(AigaAutotestParams aValue)
			throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(aValue);
	}

	@Override
	public void deleteAigaAutotestParams(AigaAutotestParams aValue)
			throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(aValue);
	}

	@Override
	public List getAigaAutotestParamsList(
			DetachedCriteria criteria) throws Exception {
		// TODO Auto-generated method stub
		return this.getHibernateTemplate().findByCriteria(criteria);
	}

}
