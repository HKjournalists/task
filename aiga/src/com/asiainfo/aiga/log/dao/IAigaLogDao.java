package com.asiainfo.aiga.log.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.log.bo.AigaLogTestCase;

public interface IAigaLogDao {

	public void saveLog(AigaLogTestCase aigaLogTestCase)throws Exception;
	
	public AigaLogTestCase[] getLog(DetachedCriteria criteria)throws Exception;
	
	public List getLogsByHql(String hql)throws Exception;
}
