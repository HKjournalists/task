package com.asiainfo.csc.common.util;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public abstract class ZTree {

	public JSONObject getTree(HttpServletRequest request) {
		JSONObject ret = new JSONObject();
		try {
			String isMutilSelect = request.getParameter("isMutilSelect");
			boolean select = false;
			if(isMutilSelect!=null){
				if(isMutilSelect.equals("true")){
					select = true;
				}else if(isMutilSelect.equals("false")){
					select = false;
				}else
					throw new Exception("unknow MutilSelect config");
			}
			Tree rootTree = this.setTreeRoot(request);
			JSONObject json = JSONObject.fromObject(rootTree);
			if(rootTree.isLeaf()==true)
				if(select==true)
					json.put("checked", false);
				json.put("children", this.getChildTree(request, rootTree));
			ret.put("root", json);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("º”‘ÿ ˜Ω·ππ ß∞‹");
			e.printStackTrace();
		}
		return ret;
	}
	
	private JSONArray getChildTree(HttpServletRequest request,Tree rootTree)throws Exception{
		String isMutilSelect = request.getParameter("isMutilSelect");
		boolean select = false;
		if(isMutilSelect!=null){
			if(isMutilSelect.equals("true")){
				select = true;
			}else if(isMutilSelect.equals("false")){
				select = false;
			}else
				throw new Exception("unknow MutilSelect config");
		}
		JSONArray jsonArray = new JSONArray();
		if(rootTree!=null){
			JSONObject json = new JSONObject();
			List<Tree> childTrees = this.setTreeChild(request,rootTree);
			for(Tree childTree : childTrees){
				json = JSONObject.fromObject(childTree);
				if(select==true&&childTree.isLeaf()==true)
					json.put("checked", false);
				json.put("children",this.getChildTree(request, childTree));
				jsonArray.put(json);
			}
		}
		return jsonArray;
	}
	
	public abstract List<Tree> setTreeChild(HttpServletRequest request,Tree parentTree)throws Exception;
	
	public abstract Tree setTreeRoot(HttpServletRequest request)throws Exception;
}
