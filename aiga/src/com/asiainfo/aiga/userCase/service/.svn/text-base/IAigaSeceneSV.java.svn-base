package com.asiainfo.aiga.userCase.service;

import net.sf.json.JSONArray;

import com.asiainfo.aiga.userCase.bo.AigaHisSecene;
import com.asiainfo.aiga.userCase.bo.AigaSecene;

public interface IAigaSeceneSV {

	public JSONArray getAigaSeceneByFunId(Integer funId)throws Exception;
	
	public void saveAigaSecene(AigaSecene aValue)throws Exception;
	
	public AigaSecene getAigaSeceneById(Integer secId)throws Exception;
	
	public JSONArray getAigaElemBySecId(Integer secId)throws Exception;
	
	public JSONArray getAigaSubElemBySubIds(String subIds)throws Exception;
	
	public JSONArray getAigaSeceneShowByFunId(Integer funId)throws Exception;
	
	public JSONArray getAigaSubElemShowByFunId(Integer funId)throws Exception;
	
	public String saveSceneAndRela(AigaSecene aigaSecene,Integer funId, String elemData,String type)throws Exception;

	public JSONArray getTestElemTreeGrid(Integer funId,Integer secId,String type) throws Exception;

	public JSONArray getSubTestElemTreeGrid(Integer elemId,Integer secId, String type) throws Exception;
	
	public void deleteSecAndRela(String secIds)throws Exception;
	
	public void saveSecOrder(String orderJson, Integer funID)throws Exception;
	
	public String getDeleteSecMsg(String secIds)throws Exception;
	
	public AigaHisSecene[] getHisSeceneBySql(String querySql) throws Exception;

	public AigaSecene[] getSeceneBySql(String querySql) throws Exception;
	
}
