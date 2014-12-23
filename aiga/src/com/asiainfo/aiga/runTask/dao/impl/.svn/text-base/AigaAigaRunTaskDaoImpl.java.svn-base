package com.asiainfo.aiga.runTask.dao.impl;

import java.util.Arrays;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.runTask.bo.AigaHisRunTaskResult;
import com.asiainfo.aiga.runTask.bo.AigaRunTask;
import com.asiainfo.aiga.runTask.dao.IAigaRunTaskDAO;

public class AigaAigaRunTaskDaoImpl extends HibernateDaoSupport implements IAigaRunTaskDAO {

	@Override
	public AigaRunTask[] getAigaRunTaskBySql(String querySql) throws Exception {
		List<AigaRunTask> aigaRunPlans = this.getHibernateTemplate().find(querySql);
		return aigaRunPlans.toArray(new AigaRunTask[0]);
	}

	@Override
	public AigaRunTask[] getRunTaskByCriteria(DetachedCriteria criteria)
			throws Exception {
		List<AigaRunTask> aigaRunPlans = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaRunPlans.toArray(new AigaRunTask[0]);
	}

	@Override
	public AigaRunTask[] getUpdateByCriteria(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void saveOrUpdate(AigaRunTask aValue) throws Exception {
		this.getHibernateTemplate().saveOrUpdate(aValue);
	}

	@Override
	public void delete(AigaRunTask aValue) throws Exception {
		this.getHibernateTemplate().delete(aValue);
		
	}

	@Override
	public void saveAigaHisRunTaskResult(AigaHisRunTaskResult[] hisValues)
			throws Exception {
		this.getHibernateTemplate().saveOrUpdateAll(Arrays.asList(hisValues));
	}

}
