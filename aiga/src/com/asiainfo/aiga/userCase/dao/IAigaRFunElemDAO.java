package com.asiainfo.aiga.userCase.dao;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.userCase.bo.AigaRFunElem;

public interface IAigaRFunElemDAO {
	
	public AigaRFunElem[] getRFunElem(DetachedCriteria criteria)throws Exception;
	
	public void saveOrUpdate(AigaRFunElem aValue)throws Exception;
	
	public void deleteRFunElem(AigaRFunElem aValue)throws Exception;
	
}
