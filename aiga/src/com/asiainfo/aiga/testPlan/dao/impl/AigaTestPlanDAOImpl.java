package com.asiainfo.aiga.testPlan.dao.impl;

import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.testPlan.bo.AigaTestPlan;
import com.asiainfo.aiga.testPlan.dao.IAigaTestPlanDAO;
import com.asiainfo.aiga.testTask.bo.AigaTestTask;
import com.asiainfo.aiga.userCase.bo.AigaFunFolder;

public class AigaTestPlanDAOImpl extends HibernateDaoSupport implements IAigaTestPlanDAO{
	public void delete(Object value) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(value);
	}

	public AigaTestPlan[] getAigaTestPlanByCriteria(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		List<AigaTestPlan> AigaTestPlans = this.getHibernateTemplate().findByCriteria(criteria);
		return AigaTestPlans.toArray(new AigaTestPlan[0]);
	}

	public AigaTestPlan[] getAigaTestPlanBySql(String querySql)
			throws Exception {
		// TODO Auto-generated method stub
		List<AigaTestPlan> AigaTestPlans = this.getHibernateTemplate().find(querySql);
		return AigaTestPlans.toArray(new AigaTestPlan[0]);
	}

	public void saveOrUpdate(Object value) throws Exception {
		this.getHibernateTemplate().saveOrUpdate(value);
	}

	@Override
	public AigaTestTask[] getAigaTestTaskBySql(String querySql)
			throws Exception {
		List<AigaTestTask> aigaTestTasks = this.getHibernateTemplate().find(querySql);
		return aigaTestTasks.toArray(new AigaTestTask[0]);
	}
	public AigaTestTask[] getAigaTestTaskByCriteria(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		List<AigaTestTask> aigaTestTasks = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaTestTasks.toArray(new AigaTestTask[0]);
	}

	@Override
	public boolean createRel4PlanAndTask(String planId,String planTag, String[] taskIdArray)throws Exception {
		String querySql="update aiga_test_task set task_id=task_id ";
		if(planId!=null &&!planId.equals(""))querySql+=" ,plan_id= "+planId ;
		if(planTag!=null &&!planTag.equals(""))querySql+=", plan_tag= '"+planTag+"'" ;
		querySql+=" where task_id in (" ;
		for(int i=0,n=taskIdArray.length;i<n;i++)
		{
			querySql+=taskIdArray[i]+(i!=n-1?",":"");
		}
		querySql+=")";
		System.out.println(querySql);
		if((planId!=null &&!planId.equals(""))||(planTag!=null&&!planTag.equals(""))){
			final String sql = querySql;
			this.getHibernateTemplate().execute(new HibernateCallback() {
			    public Object doInHibernate(Session session) throws HibernateException, SQLException {  
			         SQLQuery query = session.createSQLQuery(sql);    
			         return query.executeUpdate();
			   }  
			}); 
		
		
			return true;
		}else{
			return false;
			
		}
	}

	@Override
	public boolean manageRel4PlanAndTask(String SQL)
			throws Exception {
		
		final String sql = SQL;
		this.getHibernateTemplate().execute(new HibernateCallback() {
			    public Object doInHibernate(Session session) throws HibernateException, SQLException {  
			         SQLQuery query = session.createSQLQuery(sql);    
			         return query.executeUpdate();
			   }  
	    });  
		
		return true;
	}
	@Override
	public boolean updateBySQL(String SQL)throws Exception {

		final String sql = SQL;
		this.getHibernateTemplate().execute(new HibernateCallback() {
			    public Object doInHibernate(Session session) throws HibernateException, SQLException {  
			         SQLQuery query = session.createSQLQuery(sql);    
			         return query.executeUpdate();
			   }  
	    });  
		
		return true;
	}
	@Override
	public List getObjectByHQL(String HQL)
			throws Exception {
		final String querySql = HQL;
		List list= this.getHibernateTemplate().find(HQL);
		return list;
	}

	@Override
	public List getObjectByHQL(String HQL, int pageSize, int page)
			throws Exception {
		
		final String querySql = HQL;
		final int p=page;
		final int s=pageSize;

		List list= this.getHibernateTemplate().executeFind(new HibernateCallback() {  
	    public Object doInHibernate(Session session) throws HibernateException, SQLException {  
	         SQLQuery query = session.createSQLQuery(querySql);    
	         query.setFirstResult((p)*s);
	         query.setMaxResults(s); 
	         return query.list();  
	            }  
	        });  
		return list;
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
