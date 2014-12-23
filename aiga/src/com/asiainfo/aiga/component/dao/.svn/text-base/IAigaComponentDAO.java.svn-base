package com.asiainfo.aiga.component.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.component.bo.AigaComponent;

public interface IAigaComponentDAO {

	public AigaComponent[] getAigaComponentBySql(String querySql)throws Exception;
	
	public AigaComponent[] getAigaComponentByCriteria(DetachedCriteria criteria)throws Exception;
	
	public void saveOrUpdate(AigaComponent aValue)throws Exception;
	
	public void delete(AigaComponent aValue)throws Exception;
	
	public List getAigaComponentByHql(String hql)throws Exception;
}
