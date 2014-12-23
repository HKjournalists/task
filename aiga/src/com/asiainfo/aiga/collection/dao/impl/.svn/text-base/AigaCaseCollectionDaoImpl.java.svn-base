package com.asiainfo.aiga.collection.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.collection.bo.AigaCaseCollection;
import com.asiainfo.aiga.collection.dao.IAigaCaseCollectionDAO;
import com.asiainfo.aiga.userCase.bo.AigaCase;

/**
 * Created on 2014-6-23
 * <p>Description: [��������Ҫ���ܽ���]</p>
*/
public class AigaCaseCollectionDaoImpl extends HibernateDaoSupport implements IAigaCaseCollectionDAO
{

	public AigaCaseCollection[] getAigaCaseCollectionBySql(String querySql) throws Exception
	{
		List<AigaCaseCollection> aigaCaseCollectionList = this.getHibernateTemplate().find(querySql);
		return aigaCaseCollectionList.toArray(new AigaCaseCollection[0]);
	}

	public AigaCaseCollection[] getAigaCaseCollectionByCriteria(DetachedCriteria criteria) throws Exception
	{
		List<AigaCase> aigaCaseCollections = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaCaseCollections.toArray(new AigaCaseCollection[0]);
	}

	public void saveOrUpdate(AigaCaseCollection aValue) throws Exception
	{
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(aValue);
	}

	public void delete(AigaCaseCollection aValue) throws Exception
	{
		// TODO Auto-generated method stub
		
	}

	
	public AigaCaseCollection[] getUpdateByCriteria(DetachedCriteria criteria) throws Exception
	{
		
		return null;
	}

}
