package com.asiainfo.aiga.search.service.impl;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.asiainfo.aiga.common.helper.ActionHelper;
import com.asiainfo.aiga.p2pTest.bo.AigaP2pBusiOneLevel;
import com.asiainfo.aiga.p2pTest.bo.AigaP2pBusiTwoLevel;
import com.asiainfo.aiga.requisition.dao.IAigaRequisitionDAO;
import com.asiainfo.aiga.search.dao.ILuceneSearchDAO;
import com.asiainfo.aiga.search.service.ILuceneSearch;
import com.asiainfo.aiga.userCase.bo.AigaFunFolder;
import com.asiainfo.aiga.userCase.bo.AigaSubSysFolder;
import com.asiainfo.aiga.userCase.bo.AigaSystemFolder;
import com.asiainfo.aiga.userCase.bo.extend.AigaInstCase;
import com.asiainfo.aiga.userCase.dao.IAigaCaseDAO;
import com.asiainfo.lucene.LuceneEntities.LuceneManager.LuceneIndexManager;

/**
 * Created on 2014-6-23
 * <p>Description: [luceneËÑË÷service]</p>
*/

public class LuceneSearchSVImpl implements ILuceneSearch
{ 
	private IAigaRequisitionDAO requisitionDAO;
	private IAigaCaseDAO caseDAO;
	private ILuceneSearchDAO searchDAO;
	
	public void setRequisitionDAO(IAigaRequisitionDAO requisitionDAO) {
		this.requisitionDAO = requisitionDAO;
	}
	public void setCaseDAO(IAigaCaseDAO caseDAO) {
		this.caseDAO = caseDAO;
	}
	
	public void setSearchDAO(ILuceneSearchDAO searchDAO) {
		this.searchDAO = searchDAO;
	}
	
	public Object[] searchObjectByKw(Map map,Class clazz) throws Exception{
		LuceneIndexManager lim =new LuceneIndexManager();
		List list = lim.search(map, clazz);
		return list.toArray();
	}
	public List searchObjectByMap(Map map,Class clazz) throws Exception{
		LuceneIndexManager lim =new LuceneIndexManager();
		List list = lim.search(map, clazz);
		return list;
	}
	public void createIndex(HttpServletRequest request) throws Exception{
		LuceneIndexManager lim =new LuceneIndexManager();
//		lim.setAddWords(addWords);
		System.out.println("begin create all index");
		List list = searchDAO.getInitFileList();
		lim.createALL(list);
		System.out.println("end create all index");
	}

	public String[] getLabels(HttpServletRequest request) throws Exception {
		
		return searchDAO.getLabels(request);
	}
	@Override
	public JSONArray searchCaseAndFolder(String keyword) throws Exception {
		Map conMap=ActionHelper.parseJSON2Map(keyword);
		Class clazz=null;
		String HQL="";
		List<Object> list=null;
		JSONArray jsonArray=new JSONArray();
//		jsonObj.put("name", sysFolder.getSysName());
//		jsonObj.put("id", sysFolder.getSysId());
		if(conMap.containsKey("funFolderName")){
			clazz=AigaFunFolder.class;
			String SQL="SELECT aff.sys_name,aff.fun_id,aff.sub_sys_id,(SELECT assf.sys_id FROM aiga_sub_sys_folder assf WHERE aff.sub_sys_id=assf.subsys_id) FROM aiga_fun_folder aff WHERE aff.IS_INVALID =0 and upper(aff.sys_name) LIKE upper('%"+conMap.get("funFolderName")+"%')";
			list=searchDAO.getObjectBySQL(SQL);
			for(Object obj:list){
				Object[] retObjs=(Object[])obj;
				JSONObject jsonObj=new JSONObject();
				if(retObjs[0]==null)continue;
				if(retObjs[1]==null)continue;
				if(retObjs[2]==null)continue;
				if(retObjs[3]==null)continue;
				jsonObj.put("name", retObjs[0]);
				jsonObj.put("id", retObjs[1]);
				jsonObj.put("funId", retObjs[1]);
				jsonObj.put("subSysId", retObjs[2]);
				jsonObj.put("sysId", retObjs[3]);
				jsonObj.put("parentId", retObjs[3]);
				jsonObj.put("type", clazz.getName());
				jsonArray.add(jsonObj);
			}
			}
		else if(conMap.containsKey("subSysFolderName")){
			clazz=AigaSubSysFolder.class;
			HQL="FROM AigaSubSysFolder WHERE upper(sysName) like upper('%"+conMap.get("subSysFolderName")+"%')";
			list=searchDAO.getObjectByHQL(HQL);
			for(Object obj:list){
				JSONObject jsonObj=new JSONObject();
				AigaSubSysFolder assf=(AigaSubSysFolder)obj;
				jsonObj.put("name", assf.getSysName());
				jsonObj.put("id", assf.getSubsysId());
				jsonObj.put("parentId", assf.getSysId());
				jsonObj.put("subSysId", assf.getSubsysId());
				jsonObj.put("sysId", assf.getSysId());
				jsonObj.put("type", clazz.getName());
				jsonArray.add(jsonObj);
			}
			}
		else if(conMap.containsKey("systemFolderName")){
			clazz=AigaSystemFolder.class;
			HQL="FROM AigaSystemFolder WHERE upper(sysName) like upper('%"+conMap.get("systemFolderName")+"%')";
			list=searchDAO.getObjectByHQL(HQL);
			for(Object obj:list){
				JSONObject jsonObj=new JSONObject();
				AigaSystemFolder asf=(AigaSystemFolder)obj;
				jsonObj.put("name", asf.getSysName());
				jsonObj.put("id", asf.getSysId());
				jsonObj.put("sysId", asf.getSysId());
				jsonObj.put("parentId", asf.getSysId());
				jsonObj.put("type", clazz.getName());
				jsonArray.add(jsonObj);
			}
		}
		else if(conMap.containsKey("caseName")){
			clazz=AigaInstCase.class;
			list=searchObjectByMap(conMap,clazz);
			for(Object obj:list){
				JSONObject jsonObj=new JSONObject();
				AigaInstCase aic=(AigaInstCase)obj;
				jsonObj.put("name", aic.getCaseName());
				jsonObj.put("id", aic.getCaseId());
				jsonObj.put("parentId", aic.getFunFolderId());
				jsonObj.put("type", clazz.getName());
				jsonArray.add(jsonObj);
			}
		}
		else if(conMap.containsKey("AigaP2pBusiTwoLevel")){
			clazz=AigaP2pBusiTwoLevel.class;
			/* {type: 'string',name:'name'},
		        {type: 'string',name:'id'},
		        {type: 'string',name:'type'},
		        {type: 'string',name:'AigaP2pBusiTwoLevelId'},
		        {type: 'string',name:'AigaP2pBusiOneLevelId'},
		        {type: 'string',name:'remark'}*/
			HQL="FROM AigaP2pBusiTwoLevel WHERE upper(busiName) like upper('%"+conMap.get("AigaP2pBusiTwoLevel")+"%')";
			list=searchDAO.getObjectByHQL(HQL);
			for(Object obj:list){
				JSONObject jsonObj=new JSONObject();
				AigaP2pBusiTwoLevel apbtl=(AigaP2pBusiTwoLevel)obj;
				jsonObj.put("name", apbtl.getBusiName());
				jsonObj.put("id", apbtl.getP2pBusiId());
				jsonObj.put("AigaP2pBusiTwoLevelId", apbtl.getP2pBusiId());
				jsonObj.put("AigaP2pBusiOneLevelId", apbtl.getBusiType());
				jsonObj.put("type", clazz.getName());
				jsonArray.add(jsonObj);
			}
		}
		else if(conMap.containsKey("AigaP2pBusiOneLevel")){
			clazz=AigaP2pBusiOneLevel.class;
			HQL="FROM AigaP2pBusiOneLevel WHERE upper(busiName) like upper('%"+conMap.get("AigaP2pBusiOneLevel")+"%')";
			list=searchDAO.getObjectByHQL(HQL);
			for(Object obj:list){
				JSONObject jsonObj=new JSONObject();
				AigaP2pBusiOneLevel apbol=(AigaP2pBusiOneLevel)obj;
				jsonObj.put("name", apbol.getBusiName());
				jsonObj.put("id", apbol.getP2pBusiId());
//				jsonObj.put("AigaP2pBusiOneLevelId", apbol.getP2pBusiId());
				jsonObj.put("AigaP2pBusiOneLevelId", apbol.getP2pBusiId());
				jsonObj.put("type", clazz.getName());
				jsonArray.add(jsonObj);
			}
		}
		return jsonArray;
	}

}
