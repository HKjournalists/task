package com.asiainfo.aiga.resource.dao.impl;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.resource.bo.AigaTestResource;
import com.asiainfo.aiga.resource.dao.ITestResourceDAO;
import com.asiainfo.aiga.testTask.bo.AigaPerftestTask;

public class TestResourceDAOImpl extends HibernateDaoSupport implements ITestResourceDAO {
	
	public AigaTestResource[] getAigaResourcesBySql(String querySql) throws Exception {
		List<AigaTestResource> resources = this.getHibernateTemplate().find(querySql);
		return resources.toArray(new AigaTestResource[0]);
	}
	
	public AigaPerftestTask[] getAigaPerftestTaskBySql(String querySql) throws Exception {
		List<AigaPerftestTask> resources = this.getHibernateTemplate().find(querySql);
		return resources.toArray(new AigaPerftestTask[0]);
	}
		
	public void saveOrUpdate(AigaTestResource value) throws Exception {
		this.getHibernateTemplate().saveOrUpdate(value);
	}
	
	public void deleteResource(AigaTestResource value) throws Exception {
		this.getHibernateTemplate().delete(value);
	}
	
	public void deleteAigaPerftestTask(AigaPerftestTask value) throws Exception {
		this.getHibernateTemplate().delete(value);
	}
	
	public void saveOrUpdateAigaPerftestTask(AigaPerftestTask value) throws Exception {
		this.getHibernateTemplate().saveOrUpdate(value);
	}

}
