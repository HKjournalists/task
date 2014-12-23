package com.asiainfo.aiga.common.dao.impl;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.hql.ast.QueryTranslatorImpl;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.common.dao.ICommonPageinationDAO;

public class CommonPageinationDAOImpl extends HibernateDaoSupport implements ICommonPageinationDAO {

	@Override
	public List getObjectList(final int pageNo, final int pageSize, final String HQL)
			throws Exception {
		List list = null;
		try {
			list = this.getHibernateTemplate().executeFind(
					new HibernateCallback() {
						public Object doInHibernate(Session session)throws HibernateException, SQLException {
							Query query = session.createQuery(HQL);
							query.setFirstResult((pageNo-1)*pageSize);
							query.setMaxResults(pageSize);
							List list = query.list();
							return list;
						}
					});
		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	@Override
	public int getTotal(String HQL) throws Exception {
		// TODO Auto-generated method stub
		QueryTranslatorImpl queryTranslator = new QueryTranslatorImpl(HQL, HQL,Collections.EMPTY_MAP, (org.hibernate.engine.SessionFactoryImplementor)this.getSessionFactory());
		queryTranslator.compile(Collections.EMPTY_MAP, false);
		final String getCountSQL= "select count(*) from (" + queryTranslator.getSQLString() + ") tmp_count_t";
		
		 List<Object[]> viewRecordList = this.getHibernateTemplate().executeFind(new HibernateCallback() {  
			    public Object doInHibernate(Session session) throws HibernateException, SQLException {  
			         SQLQuery query = session.createSQLQuery(getCountSQL);    
			    return query.list();  
			            }  
			        });  
		
		
		//List<Object[]> list = getSession().createSQLQuery(getCountSQL).list();
		//Object obj=list.get(0);
		 
		Object obj = viewRecordList.get(0);
		BigDecimal bg=(BigDecimal) obj;
		return bg.intValue();
	}

}
