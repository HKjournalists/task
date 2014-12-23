package com.asiainfo.aiga.r_collect_case.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.r_collect_case.bo.AigaRCollectCase;
import com.asiainfo.aiga.r_collect_case.dao.IAigaRCollectCaseDAO;

/**
 * Created on 2014-6-25
 * <p>Description: [��������Ҫ���ܽ���]</p>
*/
public class AigaRCollectCaseDaoImpl  extends HibernateDaoSupport implements IAigaRCollectCaseDAO
{

	
	public AigaRCollectCase[] getAigaRCollectCaseBySql(String querySql) throws Exception
	{
		List<AigaRCollectCase> rCaseCompList = this.getHibernateTemplate().find(querySql);
		return rCaseCompList.toArray(new AigaRCollectCase[0]);
	}

	
	public AigaRCollectCase[] getAigaRCollectCaseByCriteria(DetachedCriteria criteria) throws Exception
	{
		// TODO Auto-generated method stub
		List<AigaRCollectCase> list = this.getHibernateTemplate().findByCriteria(criteria);
		return list.toArray(new AigaRCollectCase[0]);
	}

	
	public AigaRCollectCase[] getUpdateByCriteria(DetachedCriteria criteria) throws Exception
	{
		// TODO Auto-generated method stub
		return null;
	}

	
	public void saveOrUpdate(AigaRCollectCase aValue) throws Exception
	{
		this.getHibernateTemplate().saveOrUpdate(aValue);
		
	}

	
	public void delete(AigaRCollectCase aValue) throws Exception
	{
		this.getHibernateTemplate().delete(aValue);
		
	}


}
