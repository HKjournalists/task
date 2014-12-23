package com.asiainfo.aiga.r_case_comp.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.r_case_comp.bo.AigaRCaseComp;

/**
 * Created on 2014-6-25
 * <p>Description: [描述该类概要功能介绍]</p>
*/
public interface IAigaRCaseCompDAO
{
	public AigaRCaseComp[] getAigaRCaseCompBySql(String querySql)throws Exception;

	public AigaRCaseComp[] getAigaRCaseCompByCriteria(DetachedCriteria criteria)throws Exception;
	public AigaRCaseComp[] getUpdateByCriteria(DetachedCriteria criteria)throws Exception;

	public void saveOrUpdate(AigaRCaseComp aValue)throws Exception;

	public void delete(AigaRCaseComp aValue)throws Exception;
	
	public List getAigaRCaseByHql(String hql)throws Exception;
}
