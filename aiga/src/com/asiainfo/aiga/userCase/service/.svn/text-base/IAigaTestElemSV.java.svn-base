package com.asiainfo.aiga.userCase.service;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;

import net.sf.json.JSONArray;

import com.asiainfo.aiga.userCase.bo.AigaHisElem;
import com.asiainfo.aiga.userCase.bo.AigaHisSubElem;
import com.asiainfo.aiga.userCase.bo.AigaTestElem;
import com.asiainfo.aiga.userCase.bo.AigaTestSubElem;

public interface IAigaTestElemSV {

	public AigaTestElem[] getTestElemByFunId(Integer funId)throws Exception;
	public AigaHisElem[] getHisElemByElemId(Integer elemId)throws Exception;
	public void saveTestElem(AigaTestElem aValue)throws Exception;
	

	public void approvalTestElem(AigaTestElem aValue)throws Exception;
	
	public AigaTestElem getTestElemById(Integer id)throws Exception;
	
	public JSONArray getTestElemTreeGrid(Integer funId)throws Exception;
	
	public JSONArray getSubTestElemTreeGrid(Integer testElemId,String type)throws Exception;
	public JSONArray getSubTestElemTreeGridByCondition(Integer testElemId,String type,String elemName,String elemValue)throws Exception;
	
	public JSONArray getTestElemRTreeGrid(Integer funId,Integer sysId)throws Exception;
	
	public JSONArray getTestElemRTreeGridByCondition(Integer funId,Integer sysId,String elemName,String elemValue)throws Exception;
	
	public JSONArray getTestElemBySecId(Integer secId,Integer caseId)throws Exception;
	
	public AigaTestSubElem[] getSubElemByIds(List<Integer> ids)throws Exception;
	
	public AigaTestSubElem[] getSubElemByElemId(Integer elemId)throws Exception;
	

	public AigaTestElem[] getTestElemByCriteria(DetachedCriteria criteria)throws Exception;
	
	public Integer saveTestElemAndRelaFun(AigaTestElem aValue,Integer funId)throws Exception;
	
	public void saveAigaSubElem(AigaTestSubElem aValue)throws Exception;
	
	public void deleteAigaElem(Integer funId,String elemIds)throws Exception;
	
	public AigaTestSubElem getAigaTestSubElemById(Integer SubElemId)throws Exception;
	
	public String saveFunElemRela(Integer funId,String elemIds)throws Exception;
	
	public void saveElemRelaOrder(Integer funId,String orderJson)throws Exception;
	
	public String getDeleteElemMsg(String elemIds, String funId)throws Exception;
	
	public String deleteSubElemByIds(String ids)throws Exception;
	
	public AigaHisSubElem[] getHisSubElemBySql(String querySql) throws Exception;
	
	public AigaHisElem[] getHisElemBySql(String querySql) throws Exception;
	
}
