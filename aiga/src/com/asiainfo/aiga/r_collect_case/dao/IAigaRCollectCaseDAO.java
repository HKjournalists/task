package com.asiainfo.aiga.r_collect_case.dao;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.r_collect_case.bo.AigaRCollectCase;

/**
 * Created on 2014-6-25
 * <p>Description: [描述该类概要功能介绍]</p>
*/
public interface IAigaRCollectCaseDAO
{
	public AigaRCollectCase[] getAigaRCollectCaseBySql(String querySql)throws Exception;

	public AigaRCollectCase[] getAigaRCollectCaseByCriteria(DetachedCriteria criteria)throws Exception;
	public AigaRCollectCase[] getUpdateByCriteria(DetachedCriteria criteria)throws Exception;

	public void saveOrUpdate(AigaRCollectCase aValue)throws Exception;

	public void delete(AigaRCollectCase aValue)throws Exception;
	
}
