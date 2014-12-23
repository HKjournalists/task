package com.asiainfo.aiga.r_elem_case.dao;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.r_elem_case.bo.AigaRElemCase;

/**
 * Created on 2014-6-25
 * <p>Description: []</p>
*/
public interface IAigaRElemCaseDAO
{
	public AigaRElemCase[] getRElemCaseBySql(String querySql)throws Exception;

	public AigaRElemCase[] getRElemCaseByCriteria(DetachedCriteria criteria)throws Exception;
	
	public AigaRElemCase[] getUpdateByCriteria(DetachedCriteria criteria)throws Exception;

	public void saveOrUpdate(AigaRElemCase aValue)throws Exception;

	public void delete(AigaRElemCase aValue)throws Exception;
	
}
