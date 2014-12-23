package com.asiainfo.aiga.search.web;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.common.helper.ActionHelper;
import com.asiainfo.aiga.requisition.bo.AigaRequisition;
import com.asiainfo.aiga.search.service.ILuceneSearch;
import com.asiainfo.aiga.userCase.bo.AigaCase;
import com.asiainfo.aiga.userCase.bo.AigaFunFolder;
import com.asiainfo.aiga.userCase.bo.AigaSystemFolder;
import com.asiainfo.aiga.userCase.bo.AigaSubSysFolder;
import com.asiainfo.aiga.userCase.bo.extend.AigaInstCase;
import com.asiainfo.aiga.userCase.service.IAigaCaseSV;
import com.asiainfo.aiga.userCase.service.IAigaFunFolderSV;
import com.asiainfo.aiga.userCase.service.IAigaSubSysFolderSV;
import com.asiainfo.aiga.userCase.service.IAigaSystemFolderSV;

/**
 * Created on 2014-6-23
 * <p>Description: [用例Action]</p>
*/

@Controller
public class LuceneSearchAction extends BaseAction
{
	private static Logger logger = Logger.getLogger(LuceneSearchAction.class);
	public static String caseField="";
	
	@Resource(name="searchSV")
	private ILuceneSearch searchSV;
	
	@Resource(name="caseSV")
	private IAigaCaseSV aigaCaseSV;
	
	@Resource(name="funFolderSV")
	private IAigaFunFolderSV aigaFunFolderSV;
	
	@Resource(name="sysFolderSV")
	private IAigaSystemFolderSV aigaSystemFolderSV;
	
	@Resource(name="subSysFolderSV")
	private IAigaSubSysFolderSV aigaSubSystemFolderSV;
	
	@RequestMapping(value = "/searchCaseTree.do")
	public void showCase(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String keyword=request.getParameter("kw");
		Map conMap=new HashMap();
		logger.info("--------------------->"+keyword);
		conMap.put("caseName", keyword.trim());
		Object objs= searchSV.searchObjectByKw(conMap, AigaCase.class);
		
		JSON json=new JSONArray();
		json=JSONArray.fromObject(objs);
		logger.info(json.toString());
		ActionHelper.responseData4JSON(request, response, json);
	}
	@RequestMapping(value = "/searchCaseByMoreInfo.do")
	public void searchCaseByMoreInfo(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String keyword=request.getParameter("kw");
		keyword =new String(keyword.getBytes("ISO-8859-1"),"UTF-8");
		JSONObject jsonStr=JSONObject.fromObject(keyword);
		JSON json=new JSONArray();
		Map conMap=ActionHelper.parseJSON2Map(jsonStr.toString());
		Object objs=null;
		logger.info("--------------------->"+keyword);
		if(conMap.containsKey("funFolderName")){
			objs= searchSV.searchObjectByKw(conMap, AigaFunFolder.class);
			json=JSONArray.fromObject(objs);
		}else if(conMap.containsKey("systemFolderName")){
			 objs= searchSV.searchObjectByKw(conMap, AigaSystemFolder.class);
			json=JSONArray.fromObject(objs);
		}else{
			objs=searchSV.searchObjectByKw(conMap, AigaInstCase.class);
			json=JSONArray.fromObject(objs);
		}
		logger.info(json.toString());
		ActionHelper.responseData4JSON(request, response, json);
	}
	@RequestMapping(value = "/searchCaseAndFolder.do")
	public void searchCaseAndFolder(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String keyword=request.getParameter("kw");
		keyword =decodeCN(keyword);
		JSONObject retJSON=new JSONObject();
		try{
			Map conMap=ActionHelper.parseJSON2Map(keyword);
			Set<String> keys = conMap.keySet();
			Iterator<String> it=keys.iterator();
			caseField=it.next();
			JSONArray jsonArray=searchSV.searchCaseAndFolder(keyword);
			retJSON.put("data", jsonArray);
			retJSON.put("success", true);
		}catch (Exception e) {
			retJSON.put("success", false);
		}
		ActionHelper.responseData4JSON(request, response, retJSON);
	}
	@RequestMapping(value = "/searchCaseMoreInfo.do")
	public void searchCaseMoreInfo(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		Map conMap=new HashMap();
		JSONArray json=new JSONArray();
		String keyword=request.getParameter("kw");
		String labelStr=request.getParameter("label");
		String caseType=request.getParameter("caseType");
		if(keyword!=null&&!keyword.equals("")){
		keyword =new String(keyword.getBytes("ISO-8859-1"),"UTF-8");
		JSONObject jsonStr=JSONObject.fromObject(keyword);
		
		 conMap=ActionHelper.parseJSON2Map(jsonStr.toString());
		System.out.println("--------------------->"+keyword);
//		conMap.put("caseName", keyword.trim());

		}
		if(labelStr!=null&&!labelStr.equals("")){
//			labelStr=new String(labelStr.getBytes("ISO-8859-1"),"UTF-8");
			conMap.put("sysLabel", labelStr+"+");
		}
		if(caseType!=null&&!caseType.equals("")){
			caseType=new String(caseType.getBytes("ISO-8859-1"),"UTF-8");
			conMap.put("caseType", caseType+"+");
		}
		
		Object objs= searchSV.searchObjectByKw(conMap, AigaCase.class);
		json=JSONArray.fromObject(objs);
		System.out.println(json.toString());
		ActionHelper.responseData4JSON(request, response, json);
	}
	@RequestMapping(value = "/searchOwnLabel.do")
	public void showOwnLabel(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String keyword=request.getParameter("kw");
		Map conMap=new HashMap();
		keyword =new String(keyword.getBytes("ISO-8859-1"),"UTF-8");
		System.out.println("--------------------->"+keyword);
		conMap.put("labelName", keyword.trim());
		Object objs= searchSV.searchObjectByKw(conMap, AigaCase.class);
		
		JSON json=new JSONArray();
		json=JSONArray.fromObject(objs);
		System.out.println(json.toString());
		ActionHelper.responseData4JSON(request, response, json);
	}
	
	@RequestMapping(value = "/reproductionTree.do")
	public void reproductionTree(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
	}
//	
	@RequestMapping(value = "/searchRequistion.do")
	public void searchRequistion(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String keyword=request.getParameter("kw");
		Map conMap=new HashMap();
		JSON json=new JSONArray();
		keyword =new String(keyword.trim().getBytes("ISO-8859-1"),"UTF-8");
		System.out.println("--------------------->"+keyword);
		if(!keyword.equals("")){
			conMap.put("reqName", keyword);
			Object objs= searchSV.searchObjectByKw(conMap, AigaRequisition.class);
			json=JSONArray.fromObject(objs);
		}
		
		System.out.println(json.toString());
		ActionHelper.responseData4JSON(request, response, json);
	}
	@RequestMapping(value = "/createIndex.do")
	public void createIndex(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		Map<String, Object> map =new HashMap<String, Object>();
		try{
			searchSV.createIndex(request);
			map.put("success", true);
			map.put("message", "刷新成功");
		}catch (Exception e) {
			map.put("success", false);
			map.put("message", e.getMessage());
		}finally{
			ActionHelper.returnResponseJsonMap(request, response, map);
		}
	}
	@RequestMapping(value = "/getLabels.do")
	public void getLabels(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String[] strArray=searchSV.getLabels(request);
		JSON json=JSONArray.fromObject(strArray);
//		System.out.println(json);
		ActionHelper.responseData4JSON(request, response,json);
	}
	
	@RequestMapping(value = "/searchFunFolder.do")
	public void searchFunFolder(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String keyword = request.getParameter("kw");
		String subTaskId = request.getParameter("subTaskId");
		Map conMap=new HashMap();
		keyword =new String(keyword.getBytes("ISO-8859-1"),"UTF-8");
		System.out.println("--------------------->"+keyword);
		
		String querySql = "from AigaFunFolder where funId not in (select relaFolderId from AigaFunPoint where subTaskId=" +
			subTaskId + ") and sysName like '%" + keyword + "%'";
		AigaFunFolder[] funFolders = aigaFunFolderSV.getAigaFunFolderBySql(querySql);
		AigaFunFolder[] results = new AigaFunFolder[funFolders.length];
		for(int i = 0; i < funFolders.length; i++) {
			int sysId = funFolders[i].getSysId();
			int subSysId = funFolders[i].getSubSysId();
			String sysSql = "from AigaSystemFolder where sysId=" + sysId;
			String subSysSql = "from AigaSubSysFolder where subsysId=" + subSysId;
			AigaSystemFolder[] sysVals = aigaSystemFolderSV.getSystemFolder(sysSql);
			AigaSubSysFolder[] subSysVals = aigaSubSystemFolderSV.getSubSysFolder(subSysSql);
			
			String sysVal = (sysVals.length==1)?(sysVals[0].getSysName()+"->"):"";
			String subSysVal = (subSysVals.length==1)?(subSysVals[0].getSysName()+"->"):"";
			
			results[i] = new AigaFunFolder();
			results[i].setFunId(funFolders[i].getFunId());
			String menuPath = sysVal + subSysVal + funFolders[i].getSysName();
			
			results[i].setSysName(menuPath);
		}
		
//		conMap.put("sysName", keyword.trim());
//		Object objs= searchSV.searchObjectByKw(conMap, AigaFunFolder.class);
		System.out.println("-----------"+results.length);
		JSON json=new JSONArray();
		json=JSONArray.fromObject(results);
		System.out.println(json.toString());
		ActionHelper.responseData4JSON(request, response, json);
	}
	
}
