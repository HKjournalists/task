package com.asiainfo.aiga.funPoint.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.funPoint.bo.AigaFunPoint;
import com.asiainfo.aiga.funPoint.bo.AigaKnowledge;

public interface IAigaFunPointDAO {

	public AigaFunPoint[] getFunPointBySql(String querySql)throws Exception;
	
	public AigaFunPoint[] getFunPointByCriteria(DetachedCriteria criteria)throws Exception;
	
	public void saveOrUpdate(Object aValue)throws Exception;
	
	public void saveOrUpdateList(List list) throws Exception;
	
	public AigaKnowledge[] getKnowledgeBySql(String querySql) throws Exception;
	
	public void delete(Object aValue)throws Exception;
}
