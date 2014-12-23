package com.asiainfo.aiga.collection.dao;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.collection.bo.AigaCaseCollection;

/**
 * Created on 2014-6-23
 * <p>Description: [描述该类概要功能介绍]</p>
*/
public interface IAigaCaseCollectionDAO
{
public AigaCaseCollection[] getAigaCaseCollectionBySql(String querySql)throws Exception;

public AigaCaseCollection[] getAigaCaseCollectionByCriteria(DetachedCriteria criteria)throws Exception;
public AigaCaseCollection[] getUpdateByCriteria(DetachedCriteria criteria)throws Exception;

public void saveOrUpdate(AigaCaseCollection aValue)throws Exception;

public void delete(AigaCaseCollection aValue)throws Exception;

}
