package com.asiainfo.aiga.manualTask.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.manualTask.bo.AigaManualTask;
import com.asiainfo.aiga.manualTask.dao.IAigaManualTaskDao;

public class AigaManualTaskDaoImpl extends HibernateDaoSupport implements IAigaManualTaskDao {

	@Override
	public AigaManualTask[] getManualTask(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		List<AigaManualTask> aigaManualTasks = this.getHibernateTemplate().findByCriteria(criteria); 
		return aigaManualTasks.toArray(new AigaManualTask[0]);
	}

	@Override
	public void saveManualTask(AigaManualTask aValue) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(aValue);
	}

	@Override
	public void deleteManualTask(AigaManualTask aValue) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(aValue);
	}

}
