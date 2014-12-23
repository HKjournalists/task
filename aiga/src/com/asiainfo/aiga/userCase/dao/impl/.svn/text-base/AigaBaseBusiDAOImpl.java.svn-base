package com.asiainfo.aiga.userCase.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.userCase.bo.AigaBaseBusi;
import com.asiainfo.aiga.userCase.bo.AigaBusi;
import com.asiainfo.aiga.userCase.dao.IAigaBaseBusiDAO;

public class AigaBaseBusiDAOImpl extends HibernateDaoSupport implements IAigaBaseBusiDAO {

	@Override
	public void deleteAigaBaseBusi(AigaBaseBusi aValue) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(aValue);
	}

	@Override
	public AigaBaseBusi[] getAigaBaseBusis(DetachedCriteria criteria) throws Exception {
		// TODO Auto-generated method stub
		List<AigaBaseBusi> aigaBaseBusis = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaBaseBusis.toArray(new AigaBaseBusi[0]);
	}

	@Override
	public void saveAigaBaseBusi(AigaBaseBusi aValue) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(aValue);
	}

	@Override
	public AigaBaseBusi[] getAigaBaseBusiBySql(String querySql)
			throws Exception {
		List<AigaBaseBusi> aigaBaseBusiList = this.getHibernateTemplate().find(querySql);
		return aigaBaseBusiList.toArray(new AigaBaseBusi[0]);
	}

}
