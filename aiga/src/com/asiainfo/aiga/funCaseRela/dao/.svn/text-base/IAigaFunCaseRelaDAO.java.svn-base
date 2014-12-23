package com.asiainfo.aiga.funCaseRela.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.funCaseRela.bo.AigaFunCaseRela;
import com.asiainfo.aiga.funCaseRela.bo.AigaHisFunCaseRela;

public interface IAigaFunCaseRelaDAO {

	public void saveOrUpdate(AigaFunCaseRela aigaFunCaseRela)throws Exception;
	
	public AigaFunCaseRela[] getAigaCaseRelaBySql(String querySql)throws Exception;
	
	public AigaFunCaseRela[] getAigaCaseRelaByCriteria(DetachedCriteria criteria)throws Exception;
	
	public void delete(AigaFunCaseRela aigaFunCaseRela)throws Exception;
	
	public void saveOrUpdateAll(AigaFunCaseRela[] aigaFunCaseRelas)throws Exception;
	
	public void deleteAll(AigaFunCaseRela[] aigaFunCaseRelas)throws Exception;
	
	public void saveOrUpdate(AigaHisFunCaseRela aigaHisFunCaseRela)throws Exception;
	
	public void saveOrUpdateAll(AigaHisFunCaseRela[] aigaHisFunCaseRelas)throws Exception;

	public List getObjectBySQL(String SQL) throws Exception;

	public AigaHisFunCaseRela[] getAigaHisCaseRelaBySql(String querySql)throws Exception;
}
