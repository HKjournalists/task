package com.asiainfo.aiga.testVersion.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.testVersion.bo.AigaTestVersion;
import com.asiainfo.aiga.testVersion.dao.IAigaTestVersionDAO;

public class AigaTestVersionDAOImpl extends HibernateDaoSupport implements IAigaTestVersionDAO {

	public void delete(AigaTestVersion value) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(value);
	}

	public AigaTestVersion[] getAigaTestVersionByCriteria(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		List<AigaTestVersion> AigaTestVersions = this.getHibernateTemplate().findByCriteria(criteria);
		return AigaTestVersions.toArray(new AigaTestVersion[0]);
	}

	public AigaTestVersion[] getAigaTestVersionBySql(String querySql)
			throws Exception {
		// TODO Auto-generated method stub
		List<AigaTestVersion> AigaTestVersions = this.getHibernateTemplate().find(querySql);
		return AigaTestVersions.toArray(new AigaTestVersion[0]);
	}

	public void saveOrUpdate(AigaTestVersion value) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(value);
	}

}