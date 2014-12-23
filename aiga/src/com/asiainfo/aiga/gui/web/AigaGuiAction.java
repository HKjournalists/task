package com.asiainfo.aiga.gui.web;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSON;
import net.sf.json.JSONArray;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.common.Tree;
import com.asiainfo.aiga.common.helper.ActionHelper;
import com.asiainfo.aiga.gui.bo.AigaGui;
import com.asiainfo.aiga.gui.bo.extend.AigaInstGui;
import com.asiainfo.aiga.gui.service.IAigaGuiSV;

@Controller
@Scope(value="prototype")
public class AigaGuiAction extends BaseAction {

	@Resource(name="aigaGuiSV")
	private IAigaGuiSV aigaGuiSV;
	
	@RequestMapping(value="/getGuiTable.do")
	public void getGuiTable(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String compId = request.getParameter("compId");
		AigaGui[] aigaGuis = null;
		if(compId!=null&&!compId.equals(""))
			aigaGuis = aigaGuiSV.getAigaGuiByCompId(Integer.valueOf(compId),AigaInstGui.class);
		this.setTable(aigaGuis);
		this.postInfo(request, response);
	}
	
	@RequestMapping("/getGuiTreeSyn.do")
	public void getGuiTreeSyn(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String node = request.getParameter("node");
		String type = request.getParameter("type");
		List<Tree> childTrees = new ArrayList<Tree>();
		List<AigaInstGui> aigaGuis = aigaGuiSV.getAigaCaseByHql("from AigaInstGui where parentId=" + node);
		for(AigaInstGui aigaGui : aigaGuis){
			Tree childeTree = new Tree();
			if(aigaGui.getGuiPermission()==null)
				aigaGui.setGuiPermission(Short.valueOf(type));
			if(!aigaGui.getGuiPermission().equals(Short.valueOf(type))){
				continue;
			}
			if(aigaGui.getIsLeaf().equals("Y")){
				childeTree.setQtip("控件作者："+(aigaGui.getGuiAuthor()==null?"":aigaGui.getGuiAuthor())+"<br>"+
								"控件描述：" +(aigaGui.getGuiDesc()==null?"":aigaGui.getGuiDesc())+"<br>");
				childeTree.setLeaf(true);
			}
			else childeTree.setLeaf(false);
			childeTree.setId(aigaGui.getGuiId());
			childeTree.setText(aigaGui.getGuiName());
			childeTree.setExpanded(false);
			childeTree.setParentId(Integer.valueOf(node));
			childTrees.add(childeTree);
		}
		this.setPostInfo("children", childTrees);
		this.postInfo(request, response);
	}
	
	@RequestMapping("/getAllGuiTreeSyn.do")
	public void getAllGuiTreeSyn(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String node = request.getParameter("node");
		List<Tree> childTrees = new ArrayList<Tree>();
		List<AigaInstGui> aigaGuis = aigaGuiSV.getAigaCaseByHql("from AigaInstGui where parentId=" + node);
		for(AigaInstGui aigaGui : aigaGuis){
			Tree childeTree = new Tree();
			if(aigaGui.getIsLeaf().equals("Y")){
				childeTree.setQtip("控件作者："+(aigaGui.getGuiAuthor()==null?"":aigaGui.getGuiAuthor())+"<br>"+
								"控件描述：" +(aigaGui.getGuiDesc()==null?"":aigaGui.getGuiDesc())+"<br>");
				childeTree.setLeaf(true);
			}
			else childeTree.setLeaf(false);
			childeTree.setId(aigaGui.getGuiId());
			childeTree.setText(aigaGui.getGuiName());
			childeTree.setExpanded(false);
			childeTree.setParentId(Integer.valueOf(node));
			childTrees.add(childeTree);
		}
		this.setPostInfo("children", childTrees);
		this.postInfo(request, response);
	}
	@RequestMapping(value = "/getGuiById.do")
	public void getGuiById(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String guiId=request.getParameter("guiId");
	
		AigaGui[] aigaGuis=aigaGuiSV.getAigaGuiById(Integer.valueOf(guiId),AigaInstGui.class);
		if(aigaGuis.length>1)throw new Exception("id不唯一");
		JSON json = new JSONArray();
		
		json = JSONArray.fromObject(aigaGuis[0],jsonConfig);
		ActionHelper.responseData4JSON(request, response, json);
	}
	
	@RequestMapping(value = "/getGuiFormById.do")
	public void getGuiFormById(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String guiId=request.getParameter("guiId");
		AigaGui[] aigaGuis=aigaGuiSV.getAigaGuiById(Integer.valueOf(guiId),AigaInstGui.class);
		if(aigaGuis.length>1)throw new Exception("id不唯一");
		this.setFormData(aigaGuis[0]);
		this.postInfo(request, response);
	}
	@RequestMapping(value = "/getGuiByCompId.do")
	public void getGuiByCompId(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String compId=request.getParameter("compId");
		JSON json = new JSONArray();
		AigaGui[] aigaGuis=aigaGuiSV.getAigaGuiByCompId(Integer.valueOf(compId),AigaInstGui.class);
		if(aigaGuis!=null){
		json = JSONArray.fromObject(aigaGuis,this.jsonConfig);
		}
		ActionHelper.responseData4JSON(request, response, json);
	}
	@RequestMapping(value = "/saveGuiForm.do")
	public void saveGuiForm(HttpServletRequest request, HttpServletResponse response) throws Exception{
		try{
			Object[] objects = this.transFormToObj(request, new Class[]{AigaInstGui.class});
			AigaGui guiForm = null;
			for(Object object : objects){
				if(object instanceof AigaInstGui){
					guiForm = (AigaInstGui)object;
				}
			}
			if(guiForm!=null)
				this.aigaGuiSV.saveAigaGui(guiForm);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping(value = "/saveGuiFolder.do")
	public void saveGuiFolder(HttpServletRequest request, HttpServletResponse response) throws Exception{
		try{
			String folderName = request.getParameter("folderName");
			String guiId = request.getParameter("guiId");
			aigaGuiSV.savGuiFolder(folderName, guiId);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping(value = "/deleteGuiFolder.do")
	public void deleteGuiFolder(HttpServletRequest request, HttpServletResponse response) throws Exception{
		try{
			String folderName = request.getParameter("folderName");
			String guiId = request.getParameter("guiId");
			aigaGuiSV.deleteGuiFolder(folderName, guiId);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping(value = "/editGuiFolder.do")
	public void editGuiFolder(HttpServletRequest request, HttpServletResponse response) throws Exception{
		try{
			String folderName = request.getParameter("folderName");
			String guiId = request.getParameter("guiId");
			aigaGuiSV.editGuiFolder(folderName, guiId);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
}
