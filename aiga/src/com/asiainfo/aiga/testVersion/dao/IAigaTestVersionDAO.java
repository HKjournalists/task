package com.asiainfo.aiga.testVersion.dao;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.testVersion.bo.AigaTestVersion;

public interface IAigaTestVersionDAO {
public AigaTestVersion[] getAigaTestVersionBySql(String querySql)throws Exception;
	
	public AigaTestVersion[] getAigaTestVersionByCriteria(DetachedCriteria criteria)throws Exception;
	
	public void saveOrUpdate(AigaTestVersion aValue)throws Exception;
	
	public void delete(AigaTestVersion aValue)throws Exception;
}
