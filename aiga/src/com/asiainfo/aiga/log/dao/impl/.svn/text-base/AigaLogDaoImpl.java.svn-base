package com.asiainfo.aiga.log.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.log.bo.AigaLogTestCase;
import com.asiainfo.aiga.log.dao.IAigaLogDao;

public class AigaLogDaoImpl extends HibernateDaoSupport implements IAigaLogDao {

	@Override
	public void saveLog(AigaLogTestCase aigaLogTestCase) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(aigaLogTestCase);
	}

	@Override
	public AigaLogTestCase[] getLog(DetachedCriteria criteria) throws Exception {
		// TODO Auto-generated method stub
		List<AigaLogTestCase> list = this.getHibernateTemplate().findByCriteria(criteria);
		return list.toArray(new AigaLogTestCase[0]);
	}

	@Override
	public List getLogsByHql(String hql) throws Exception {
		// TODO Auto-generated method stub
		return this.getHibernateTemplate().find(hql);
	}

}
