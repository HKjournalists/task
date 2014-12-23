package com.asiainfo.aiga.resource.service.impl;

import com.asiainfo.aiga.resource.bo.AigaTestResource;
import com.asiainfo.aiga.resource.dao.ITestResourceDAO;
import com.asiainfo.aiga.resource.service.ITestResourceSV;
import com.asiainfo.aiga.testTask.bo.AigaPerftestTask;

public class TestResourceSVImpl implements ITestResourceSV {
	
	private ITestResourceDAO resourceDao;
	
	public void setResourceDao(ITestResourceDAO resourceDao) {
		this.resourceDao = resourceDao;
	}
	
	public AigaTestResource[] getAigaResourcesBySql(String querySql) throws Exception {
		return resourceDao.getAigaResourcesBySql(querySql);
	}
	
	public AigaPerftestTask[] getAigaPerftestTaskBySql(String querySql) throws Exception {
		return resourceDao.getAigaPerftestTaskBySql(querySql);
	}
		
	public void saveOrUpdate(AigaTestResource value) throws Exception {
		resourceDao.saveOrUpdate(value);
	}
	
	public void deleteResource(AigaTestResource value) throws Exception {
		resourceDao.deleteResource(value);
	}
	
	@Override
	public void deleteAigaPerftestTask(AigaPerftestTask value) throws Exception {
		// TODO Auto-generated method stub
		resourceDao.deleteAigaPerftestTask(value);
	}
	
	public void saveOrUpdateAigaPerftestTask(AigaPerftestTask value) throws Exception {
		resourceDao.saveOrUpdateAigaPerftestTask(value);
	}

}
