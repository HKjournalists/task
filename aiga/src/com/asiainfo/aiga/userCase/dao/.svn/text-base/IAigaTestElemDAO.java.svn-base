package com.asiainfo.aiga.userCase.dao;

import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.userCase.bo.AigaHisElem;
import com.asiainfo.aiga.userCase.bo.AigaTestElem;

public interface IAigaTestElemDAO {

	public AigaTestElem[] getAigaTestElem(DetachedCriteria criteria)throws Exception;
	public AigaHisElem[] getAigaHisElem(DetachedCriteria criteria)throws Exception;
	
	public void saveOrUpdate(AigaTestElem aValue)throws Exception;
	public void approvalsaveOrUpdate(AigaTestElem aValue)throws Exception;
	
	public void deleteAigaTestElem(AigaTestElem aValue)throws Exception;
	
	public AigaHisElem[] getHisElemBySql(String querySql) throws Exception;
	
	public AigaTestElem[] getAigaTestElem(String querySql)throws Exception;
}
