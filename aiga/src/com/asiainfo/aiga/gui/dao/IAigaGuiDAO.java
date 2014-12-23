package com.asiainfo.aiga.gui.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.gui.bo.AigaGui;

public interface IAigaGuiDAO {
	public AigaGui[] getAigaGuisByCriteria(DetachedCriteria criteria)throws Exception;
	
	public void saveOrUpdate(AigaGui aValue)throws Exception;
	
	public AigaGui[] getUpdateBySQL(String sql)throws Exception;
	
	public AigaGui[] getUpdateByCriteria(DetachedCriteria criteria)throws Exception;
	
	public void delete(AigaGui aValue)throws Exception;
	
	public List getAigaGuisByHql(String hql)throws Exception;
}
