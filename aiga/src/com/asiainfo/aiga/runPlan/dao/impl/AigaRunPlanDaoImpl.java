package com.asiainfo.aiga.runPlan.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.runPlan.bo.AigaRunPlan;
import com.asiainfo.aiga.runPlan.dao.IAigaRunPlanDAO;
import com.asiainfo.aiga.runTask.bo.AigaHisRunTaskResult;

public class AigaRunPlanDaoImpl extends HibernateDaoSupport implements IAigaRunPlanDAO {

	@Override
	public AigaRunPlan[] getAigaRunPlanBySql(String querySql) throws Exception {
		List<Object> aigaRunPalns = this.getHibernateTemplate().find(querySql);
		int n=aigaRunPalns.size();
		AigaRunPlan[] array=new AigaRunPlan[n];
		for(int i=0;i<n;i++){
			Object aigaObj=aigaRunPalns.get(i);
			if(aigaObj.getClass().isArray()){
			Object[] objs=(Object[])aigaObj;
			for(Object obj:objs){
				if(obj instanceof AigaRunPlan){
					array[i]=(AigaRunPlan)obj;
				}
			}
			}else{
				array=aigaRunPalns.toArray(new AigaRunPlan[0]);
			}
		}
		
		return array;
	}

	@Override
	public AigaRunPlan[] getAigaCaseByCriteria(DetachedCriteria criteria)
			throws Exception {
		List<AigaRunPlan> aigaRunPlans = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaRunPlans.toArray(new AigaRunPlan[0]);
	}

	@Override
	public AigaRunPlan[] getUpdateByCriteria(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void saveOrUpdate(AigaRunPlan aValue) throws Exception {
		this.getHibernateTemplate().saveOrUpdate(aValue);
	}

	@Override
	public void delete(AigaRunPlan aValue) throws Exception {
		this.getHibernateTemplate().delete(aValue);
		
	}

	@Override
	public List getAllRunTaskBySql(String querySql) throws Exception {
		List<Object> allRunTasks = this.getHibernateTemplate().find(querySql);
	
		
		return allRunTasks;
	}

	@Override
	public List getRunTaskResultByCon(String subTaskId, String taskId)
			throws Exception {
		final String querySql = "select b.run_id,b.case_id,b.run_name,b.run_result,b.run_time,b.task_id," +
				"b.rela_result,a.task_status,a.sub_task_id,a.task_tag,a.task_name,a.collect_type,null as result_id,a.create_time " +
				" from aiga_run_task a, aiga_run_plan b where a.task_id = b.task_id and a.sub_task_id = "+subTaskId+
				" and a.task_id = '"+taskId+"'";
		List<Object[]> viewRecordList = this.getHibernateTemplate().executeFind(new HibernateCallback() {  
			    public Object doInHibernate(Session session) throws HibernateException, SQLException {  
			         SQLQuery query = session.createSQLQuery(querySql);    
			         return query.list();  
			            }  
			        });  
		return viewRecordList;
	}

	@Override
	public void saveAigaRunPlan(List list) throws Exception {
		this.getHibernateTemplate().saveOrUpdateAll(list);
	}
	
	@Override
	public void deleteAll(List list) throws Exception {
		this.getHibernateTemplate().deleteAll(list);
		
	}

}
