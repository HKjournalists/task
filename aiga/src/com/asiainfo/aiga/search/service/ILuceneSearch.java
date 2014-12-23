package com.asiainfo.aiga.search.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public interface ILuceneSearch {
	public Object[] searchObjectByKw(Map map,Class clazz) throws Exception;
	void createIndex(HttpServletRequest request) throws Exception;
	public String[] getLabels(HttpServletRequest request) throws Exception;
	public JSONArray searchCaseAndFolder(String keyword)throws Exception;
}
