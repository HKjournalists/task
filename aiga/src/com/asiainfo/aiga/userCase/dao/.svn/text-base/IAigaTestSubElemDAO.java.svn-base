package com.asiainfo.aiga.userCase.dao;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.userCase.bo.AigaHisSubElem;
import com.asiainfo.aiga.userCase.bo.AigaTestSubElem;

public interface IAigaTestSubElemDAO {

	public AigaTestSubElem[] getTestSubElem(DetachedCriteria criteria)throws Exception;
	
	public void saveOrUpdate(AigaTestSubElem aValue)throws Exception;
	
	public void deleteTestSubElem(AigaTestSubElem aValue)throws Exception;
	
	public AigaHisSubElem[] getHisSubElemBySql(String querySql) throws Exception;
	
	public AigaTestSubElem[] getTestSubElemBySql(String querySql)throws Exception;
	
	
}
