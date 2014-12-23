package com.asiainfo.aiga.caseLabelRela.dao;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.caseLabelRela.bo.AigaCaseLabelRela;

public interface IAigaCaseLabelRelaDAO {

	public void saveOrUpdate(AigaCaseLabelRela aValue)throws Exception;
	
	public AigaCaseLabelRela[] getAigaCaseLabelRelaBySql(String querySql)throws Exception;
	
	public AigaCaseLabelRela[] getAigaCaseLabelRelaByCriteria(DetachedCriteria criteria)throws Exception;
	
	public void delete(AigaCaseLabelRela aValue)throws Exception;
}
