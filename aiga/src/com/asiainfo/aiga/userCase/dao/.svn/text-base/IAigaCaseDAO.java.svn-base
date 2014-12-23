package com.asiainfo.aiga.userCase.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.caseLabelRela.bo.AigaCaseLabelRela;
import com.asiainfo.aiga.r_collect_case.bo.AigaRFunCase;
import com.asiainfo.aiga.userCase.bo.AigaCase;
import com.asiainfo.aiga.userCase.bo.AigaHisCase;
import com.asiainfo.aiga.userCase.bo.AigaRCaseElem;
import com.asiainfo.aiga.userCase.bo.extend.AigaInstCase;

/**
 * Created on 2014-6-23
 * <p>Description: [描述该类概要功能介绍]</p>
*/
public interface IAigaCaseDAO {
	
	public AigaCase[] getAigaCaseBySql(String querySql)throws Exception;
	
	public AigaCase[] getAigaCaseByCriteria(DetachedCriteria criteria)throws Exception;
	
	public AigaCase[] getAigaCaseByCriteria(DetachedCriteria criteria,Integer start,Integer limit)throws Exception;
	
	public AigaCase[] getUpdateByCriteria(DetachedCriteria criteria)throws Exception;
	
	public void saveOrUpdate(AigaCase aValue)throws Exception;
	
	public void delete(AigaCase aValue)throws Exception;
	
	public AigaCaseLabelRela[] getCaseLabelRelaBySql(String querySql) throws Exception;
	
	public void saveCaseLabelRela(AigaCaseLabelRela value) throws Exception;
	
	public void deleteCaseLabelRela(AigaCaseLabelRela value) throws Exception;
	
	public List getCaseByHql(String hql)throws Exception;
	
	public AigaRCaseElem[] getAigaRCaseElem(DetachedCriteria criteria)throws Exception;
	
	public AigaRCaseElem[] getAigaRCaseElem(String querySql)throws Exception;
	
	public void saveAigaRCaseElem(AigaRCaseElem aValue)throws Exception;
	
	public void deleteAigaRCaseElem(AigaRCaseElem aValue)throws Exception;
	
	public AigaInstCase[] getInstCaseBySql(String querySql) throws Exception;
	
	public AigaHisCase[] getHisCaseBySql(String querySql) throws Exception;
	
	public AigaHisCase[] getHisCaseByCriteria(DetachedCriteria criteria) throws Exception;
	
	public AigaRFunCase[] getAigaRFunCaseBySql(String queryString) throws Exception;
	
	public int getAigaCaseCount(DetachedCriteria criteria) throws Exception ;

	public AigaCase[] queryAigaCaseByCriteria(DetachedCriteria criteria)throws Exception;
	
}
