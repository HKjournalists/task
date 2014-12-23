package com.asiainfo.aiga.label.dao;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.label.bo.AigaLabel;

public interface IAigaLabelDAO {

	public AigaLabel[] getAigaLabelBySql(String querySql)throws Exception;
	
	public AigaLabel[] getAigaLabelByCriteria(DetachedCriteria criteria)throws Exception;
	
	public void saveOrUpdate(AigaLabel aValue)throws Exception;
	
	public void delete(AigaLabel aValue)throws Exception;
	
	public AigaLabel[] getAigaLabelLeafBySql(String querySql) throws Exception;
}
