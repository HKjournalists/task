package com.asiainfo.aiga.p2pTest.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.p2pTest.bo.AigaP2pBusiOneLevel;
import com.asiainfo.aiga.p2pTest.bo.AigaP2pBusiTwoLevel;
import com.asiainfo.aiga.p2pTest.dao.IAigaP2PDAO;

/**
 * Created on 2014-11-18
 * <p>Description: [描述该类概要功能介绍]</p>
 */
public class AigaP2PDAOImpl extends HibernateDaoSupport implements IAigaP2PDAO{

	@Override
	public AigaP2pBusiOneLevel[] getAigaP2pBusiOneLevel(DetachedCriteria criteria) throws Exception {
		// TODO Auto-generated method stub
		List<AigaP2pBusiOneLevel> gigaP2pBusiOneLevelList = this.getHibernateTemplate()
				.findByCriteria(criteria);
		return gigaP2pBusiOneLevelList.toArray(new AigaP2pBusiOneLevel[0]);
	}

	@Override
	public AigaP2pBusiTwoLevel[] getAigaP2pBusiTwoLevel(
			DetachedCriteria criteria) throws Exception {
		// TODO Auto-generated method stub
		List<AigaP2pBusiTwoLevel> gigaP2pBusiTwoLevelList = this.getHibernateTemplate()
				.findByCriteria(criteria);
		return gigaP2pBusiTwoLevelList.toArray(new AigaP2pBusiTwoLevel[0]);
	}
	@Override
	public List getObjectListBySQL(final String SQL) throws Exception {
		// TODO Auto-generated method stub
		List<Object[]> resList = this.getHibernateTemplate().executeFind(new HibernateCallback() {  
		    public Object doInHibernate(Session session) throws HibernateException, SQLException {  
		         SQLQuery query = session.createSQLQuery(SQL);    
		         return query.list();  
		            }  
		        });  
		return resList;
	}

	@Override
	public void updateBySQL(final String SQL) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().execute(new HibernateCallback() {  
			public Object doInHibernate(Session session) throws HibernateException, SQLException {  
		         SQLQuery query = session.createSQLQuery(SQL);    
		         return query.executeUpdate();
		            }  
		        });
		
	}

	@Override
	public void saveOrUpdate(Object aValue) throws Exception {
		this.getHibernateTemplate().saveOrUpdate(aValue);
		
	}

	@Override
	public void delete(Object aValue) throws Exception {
		
		this.getHibernateTemplate().delete(aValue);
		
	}

	@Override
	public List getObjectByHQL(String HQL) throws Exception {
		// TODO Auto-generated method stub
		List list= this.getHibernateTemplate().find(HQL);
		return list;
	}

}
