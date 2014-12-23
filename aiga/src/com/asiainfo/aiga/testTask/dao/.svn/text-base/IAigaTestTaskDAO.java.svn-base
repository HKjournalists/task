package com.asiainfo.aiga.testTask.dao;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.testTask.bo.AigaTestTask;
import com.asiainfo.aiga.testTask.bo.AigaTestTaskChange;

public interface IAigaTestTaskDAO {
public AigaTestTask[] getAigaTestTaskBySql(String querySql)throws Exception;
	
	public AigaTestTask[] getAigaTestTaskByCriteria(DetachedCriteria criteria)throws Exception;
	
	public void saveOrUpdate(AigaTestTask aValue)throws Exception;
	
	public void saveOrUpdateAigaTestTaskChange(AigaTestTaskChange aValue)throws Exception;
	
	public void delete(AigaTestTask aValue)throws Exception;
}
