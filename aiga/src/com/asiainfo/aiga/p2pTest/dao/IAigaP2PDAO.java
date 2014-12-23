package com.asiainfo.aiga.p2pTest.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.p2pTest.bo.AigaP2pBusiOneLevel;
import com.asiainfo.aiga.p2pTest.bo.AigaP2pBusiTwoLevel;

/**
 * Created on 2014-11-18
 * <p>Description: [描述该类概要功能介绍]</p>
 */
public interface IAigaP2PDAO {
	public AigaP2pBusiOneLevel[] getAigaP2pBusiOneLevel(DetachedCriteria criteria)throws Exception;
	public AigaP2pBusiTwoLevel[] getAigaP2pBusiTwoLevel(DetachedCriteria criteria)throws Exception;
	public List getObjectListBySQL(final String SQL)throws Exception;
	public void updateBySQL(String SQL)throws Exception;
	public void saveOrUpdate(Object aValue)throws Exception;
	public List getObjectByHQL(final String HQL)throws Exception;
	public void delete(Object aValue)throws Exception;
}
