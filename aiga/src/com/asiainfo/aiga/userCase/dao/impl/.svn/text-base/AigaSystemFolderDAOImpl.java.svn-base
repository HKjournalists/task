package com.asiainfo.aiga.userCase.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.userCase.bo.AigaSystemFolder;
import com.asiainfo.aiga.userCase.dao.IAigaSystemFolderDAO;

public class AigaSystemFolderDAOImpl extends HibernateDaoSupport implements IAigaSystemFolderDAO{

	@Override
	public AigaSystemFolder[] getSystemFolders(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		List<AigaSystemFolder> aigaSystemFolders = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaSystemFolders.toArray(new AigaSystemFolder[0]);
	}
	
	public AigaSystemFolder[] getSystemFolders(String querySql) throws Exception {
		List<AigaSystemFolder> aigaSystemFolders = this.getHibernateTemplate().find(querySql);
		return aigaSystemFolders.toArray(new AigaSystemFolder[0]);
	}

	@Override
	public void saveSystemFolders(AigaSystemFolder aValue) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(aValue);
	}

	@Override
	public void deleteSystemFolders(AigaSystemFolder aValue) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(aValue);
	}
	@Override
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
