package com.asiainfo.aiga.common.dao.impl;

import java.util.Iterator;
import java.util.List;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.common.dao.IWorkorderChartDao;

public class WorkorderChartDaoImpl extends HibernateDaoSupport implements IWorkorderChartDao {

	@Override
	public Iterator getChartBySQL(String sql) throws Exception {
		// TODO Auto-generated method stub
		Session session = null;
		try{
			session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
			session.beginTransaction();
			SQLQuery query = session.createSQLQuery(sql);
			return query.list().iterator();
		}catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(session!=null)
				session.close();
		}
		return null;
	}

	@Override
	public List getArrayChartBySQL(String sql) throws Exception {
		// TODO Auto-generated method stub
		Session session = null;
		try{
			session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
			session.beginTransaction();
			SQLQuery query = session.createSQLQuery(sql);
			return query.list();
		}catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(session!=null)
				session.close();
		}
		return null;
	}
}
