package com.asiainfo.aiga.testTask.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.testTask.bo.AigaTestTask;
import com.asiainfo.aiga.testTask.bo.AigaTestTaskChange;
import com.asiainfo.aiga.testTask.dao.IAigaTestTaskDAO;

public class AigaTestTaskDAOImpl extends HibernateDaoSupport implements IAigaTestTaskDAO {

	public void delete(AigaTestTask value) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(value);
	}

	public AigaTestTask[] getAigaTestTaskByCriteria(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		List<AigaTestTask> AigaTestTasks = this.getHibernateTemplate().findByCriteria(criteria);
		return AigaTestTasks.toArray(new AigaTestTask[0]);
	}

	public AigaTestTask[] getAigaTestTaskBySql(String querySql)
			throws Exception {
		// TODO Auto-generated method stub
		List<AigaTestTask> AigaTestTasks = this.getHibernateTemplate().find(querySql);
		return AigaTestTasks.toArray(new AigaTestTask[0]);
	}

	public void saveOrUpdate(AigaTestTask value) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(value);
	}

	@Override
	public void saveOrUpdateAigaTestTaskChange(AigaTestTaskChange value)
			throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(value);
	}

}