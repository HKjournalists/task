package com.asiainfo.aiga.groupCase.dao;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.groupCase.bo.AigaGroupCase;
import com.asiainfo.aiga.groupCase.bo.AigaHisGroupCase;
import com.asiainfo.aiga.groupCase.bo.AigaRGroupChangeCase;
import com.asiainfo.aiga.groupCase.bo.AigaRGroupSubCase;

public interface IAigaGroupCaseDAO {

	public void saveOrUpdate(AigaGroupCase aValue)throws Exception;
	
	public void saveOrUpdate(AigaHisGroupCase aValue)throws Exception;
	
	public AigaGroupCase[] getGroupCase(DetachedCriteria criteria)throws Exception;
	
	public void delete(AigaGroupCase aValue)throws Exception;
	
	public void saveOrUpdateAigaRGroupSubCase(AigaRGroupSubCase aValue)throws Exception;
	
	public AigaRGroupSubCase[] getAigaRGroupSubCase(DetachedCriteria criteria)throws Exception;

	public AigaRGroupChangeCase[] getAigaRGroupChangeCase(DetachedCriteria criteria)throws Exception;
	
	public void delete(AigaRGroupSubCase aValue)throws Exception;
}
