package com.asiainfo.aiga.common.client.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.common.client.bo.AigaClientConfig;
import com.asiainfo.aiga.common.client.dao.IRecieveClientConfigDAO;

public class RecieveClientConfigDAOImpl extends HibernateDaoSupport implements IRecieveClientConfigDAO{

	@Override
	public void saveRecieveClientConfig(AigaClientConfig aValue)
			throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(aValue);
	}

	@Override
	public AigaClientConfig[] getRecieveClientConfig(
			DetachedCriteria criteria) throws Exception {
		// TODO Auto-generated method stub
		List<AigaClientConfig> clientConfigs = this.getHibernateTemplate().findByCriteria(criteria);
		return clientConfigs.toArray(new AigaClientConfig[0]);
	}

	@Override
	public void deleteRecieveClientConfig(AigaClientConfig aValue)
			throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(aValue);
	}

}
