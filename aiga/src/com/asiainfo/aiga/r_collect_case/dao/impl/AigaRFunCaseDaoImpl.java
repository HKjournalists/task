package com.asiainfo.aiga.r_collect_case.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.r_collect_case.bo.AigaRFunCase;
import com.asiainfo.aiga.r_collect_case.dao.IAigaRFunCaseDAO;

public class AigaRFunCaseDaoImpl extends HibernateDaoSupport implements IAigaRFunCaseDAO{

	public AigaRFunCase[] getRFunCaseBySql(String querySql)
			throws Exception {
		List<AigaRFunCase> rCaseCompList = this.getHibernateTemplate().find(querySql);
		return rCaseCompList.toArray(new AigaRFunCase[0]);
	}

	public AigaRFunCase[] getRFunCaseByCriteria(
			DetachedCriteria criteria) throws Exception {
		List<AigaRFunCase> aigaCases = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaCases.toArray(new AigaRFunCase[0]);
	}

	public AigaRFunCase[] getUpdateByCriteria(DetachedCriteria criteria)
			throws Exception {
		
		return null;
	}

	public void saveOrUpdate(AigaRFunCase aValue) throws Exception {
		this.getHibernateTemplate().saveOrUpdate(aValue);
	}

	public void delete(AigaRFunCase aValue) throws Exception {
		this.getHibernateTemplate().delete(aValue);
	}
	
	public void saveOrUpdateList(List list) throws Exception {
		this.getHibernateTemplate().saveOrUpdateAll(list);
	}
	
	public List getObjectBySQL(String SQL) throws Exception {
		final String querySql = SQL;

		List list = this.getHibernateTemplate().executeFind(new HibernateCallback() {  
		    public Object doInHibernate(Session session) throws HibernateException, SQLException {  
		         SQLQuery query = session.createSQLQuery(querySql);    
		         return query.list();  
		            }  
		        });  
		return list;
	}

}
