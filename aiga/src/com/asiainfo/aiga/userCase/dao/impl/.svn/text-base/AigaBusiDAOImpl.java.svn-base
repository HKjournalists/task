package com.asiainfo.aiga.userCase.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.collection.bo.AigaCaseCollection;
import com.asiainfo.aiga.userCase.bo.AigaBusi;
import com.asiainfo.aiga.userCase.dao.IAigaBusiDAO;

public class AigaBusiDAOImpl extends HibernateDaoSupport implements IAigaBusiDAO {

	@Override
	public void deleteAigaBusi(AigaBusi aValue) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(aValue);
	}

	@Override
	public AigaBusi[] getAigaBusis(DetachedCriteria criteria) throws Exception {
		// TODO Auto-generated method stub
		List<AigaBusi> aigaBusis = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaBusis.toArray(new AigaBusi[0]);
	}

	@Override
	public void saveAigaBusi(AigaBusi aValue) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(aValue);
	}

	@Override
	public List getBusiIdByCriteria(DetachedCriteria criteria) throws Exception {
		// TODO Auto-generated method stub
		return this.getHibernateTemplate().findByCriteria(criteria);
	}

	@Override
	public AigaBusi[] getAigaBusiByCriteria(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		List<AigaBusi> aigaBusis = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaBusis.toArray(new AigaBusi[0]);
	}

	@Override
	public AigaBusi[] getAigaBusiBySql(String querySql) throws Exception {
		List<AigaBusi> aigaBusiList = this.getHibernateTemplate().find(querySql);
		return aigaBusiList.toArray(new AigaBusi[0]);
	}

}
