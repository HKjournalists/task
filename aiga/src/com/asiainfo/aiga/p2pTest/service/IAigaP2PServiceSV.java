package com.asiainfo.aiga.p2pTest.service;

import java.util.List;

import net.sf.json.JSONArray;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.p2pTest.bo.AigaP2pBusiOneLevel;
import com.asiainfo.aiga.p2pTest.bo.AigaP2pBusiTwoLevel;
import com.asiainfo.aiga.p2pTest.bo.AigaP2pCase;
import com.asiainfo.aiga.p2pTest.bo.AigaP2pCaseTemp;
import com.asiainfo.aiga.p2pTest.bo.AigaP2pChannel;
import com.asiainfo.aiga.p2pTest.bo.AigaP2pFunctionPoint;

/**
 * Created on 2014-11-18
 * <p>Description: [描述该类概要功能介绍]</p>
 */
public interface IAigaP2PServiceSV {
	public AigaP2pBusiOneLevel[] getAigaP2pBusiOneLevel(DetachedCriteria criteria)throws Exception;
	public AigaP2pBusiTwoLevel[] getAigaP2pBusiTwoLevel(DetachedCriteria criteria)throws Exception;
	public void saveOrUpdate(Object aValue)throws Exception;
	public void delete(Object aValue)throws Exception;
	public List getObjectByHQL(String HQL ) throws Exception ;
	public JSONArray getBaseFunctionJSONObjs() throws Exception; 
	public JSONArray getChannelJSONObjs() throws Exception; 
	public JSONArray getP2pCaseCollectionCombox(String busiId,String type)throws Exception;
	JSONArray getFunPointCase(String channel) throws Exception;
	JSONArray getP2pPointCaseCombox(String busiTwoLevelId) throws Exception;
	public boolean updateBySQL(String SQL) throws Exception;
	public List getObjectListBySQL(String SQL) throws Exception;
	public boolean moveCaseData(AigaP2pCase aigaP2pCase) throws Exception;
	public boolean updateCaseSomeFields(AigaP2pCaseTemp aigaP2pCaseTemp) throws Exception;
	public void saveP2pCase(AigaP2pCaseTemp aigaP2pCaseTemp)throws Exception;
	public void saveP2pFunPoint(AigaP2pFunctionPoint aigaP2pFunctionPoint)throws Exception;
	JSONArray getNewBusiFunctionPoint(String sysId,String funPointName) throws Exception;
	public JSONArray getAigaNewBusiCase(String funName, String caseName,Integer page,Integer limit)throws Exception;
	public JSONArray getBusiScene(String BusiId)throws Exception;
	JSONArray getP2pCaseCollectByBusiId(String busiTwoLevelId) throws Exception;
	JSONArray getP2pCaseCollectBySceneId(String busiTwoLevelId,String sceneId) throws Exception;
	JSONArray getP2pCaseCollectComplementBySceneId(String busiTwoLevelId,String sceneId) throws Exception;
	public void delSceneCollectRelaBySceneId(String scId)throws Exception;
	public void delSceneBySceneIds(String[] scIds)throws Exception;
	String getAigaNewBusiCaseCount(String funName, String caseName)throws Exception;

}
