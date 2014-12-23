package com.asiainfo.aiga.r_collect_case.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.r_collect_case.bo.AigaRFunCase;

/**
 * Created on 2014-6-25
 * <p>Description: []</p>
*/
public interface IAigaRFunCaseDAO
{
	public AigaRFunCase[] getRFunCaseBySql(String querySql)throws Exception;

	public AigaRFunCase[] getRFunCaseByCriteria(DetachedCriteria criteria)throws Exception;
	
	public AigaRFunCase[] getUpdateByCriteria(DetachedCriteria criteria)throws Exception;

	public void saveOrUpdate(AigaRFunCase aValue)throws Exception;

	public void delete(AigaRFunCase aValue)throws Exception;
	
	public void saveOrUpdateList(List list) throws Exception;
	
	public List getObjectBySQL(String SQL) throws Exception;
}
