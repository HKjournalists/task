package com.asiainfo.aiga.userCase.service;

import org.hibernate.criterion.DetachedCriteria;


import com.asiainfo.aiga.userCase.bo.AigaBaseBusi;

public interface IAigaBaseBusiSV {

	public AigaBaseBusi[] getAigaBaseBusi(DetachedCriteria criteria)throws Exception;
	
	public void saveAigaBaseBusi(AigaBaseBusi aValue)throws Exception;
	
	public void deleteAigaBaseBusi(AigaBaseBusi aValue)throws Exception;
	
	public AigaBaseBusi[] getAigaBaseBusi(String querySql)throws Exception;
}
