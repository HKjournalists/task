package com.asiainfo.aiga.r_comp_gui.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.r_comp_gui.bo.AigaGuiCompRela;

/**
 * Created on 2014-6-25
 * <p>Description: [描述该类概要功能介绍]</p>
*/
public interface IAigaRCompGuiDAO
{
	public AigaGuiCompRela[] getAigaGuiCompRelaBySql(String querySql)throws Exception;

	public AigaGuiCompRela[] getAigaGuiCompRelaByCriteria(DetachedCriteria criteria)throws Exception;
	
	public AigaGuiCompRela[] getUpdateByCriteria(DetachedCriteria criteria)throws Exception;

	public void saveOrUpdate(AigaGuiCompRela aValue)throws Exception;

	public void delete(AigaGuiCompRela aValue)throws Exception;
	
	public List getAigaGuiCompRelaByHql(String hql)throws Exception;
}
