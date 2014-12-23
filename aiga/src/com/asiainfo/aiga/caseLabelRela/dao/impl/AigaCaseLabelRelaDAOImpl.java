package com.asiainfo.aiga.caseLabelRela.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.caseLabelRela.bo.AigaCaseLabelRela;
import com.asiainfo.aiga.caseLabelRela.dao.IAigaCaseLabelRelaDAO;

public class AigaCaseLabelRelaDAOImpl extends HibernateDaoSupport implements
		IAigaCaseLabelRelaDAO {

	public void delete(AigaCaseLabelRela value) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(value);
	}

	public AigaCaseLabelRela[] getAigaCaseLabelRelaByCriteria(
			DetachedCriteria criteria) throws Exception {
		// TODO Auto-generated method stub
		List<AigaCaseLabelRela> list = this.getHibernateTemplate().findByCriteria(criteria);
		return list.toArray(new AigaCaseLabelRela[0]);
	}

	public AigaCaseLabelRela[] getAigaCaseLabelRelaBySql(String querySql)
			throws Exception {
		// TODO Auto-generated method stub
		List<AigaCaseLabelRela> list = this.getHibernateTemplate().find(querySql);
		return list.toArray(new AigaCaseLabelRela[0]);
	}

	public void saveOrUpdate(AigaCaseLabelRela value) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(value);
	}

}
