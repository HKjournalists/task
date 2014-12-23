package com.asiainfo.aiga.component.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.common.Tree;
import com.asiainfo.aiga.common.helper.ActionHelper;
import com.asiainfo.aiga.common.security.user.bo.AigaUser;
import com.asiainfo.aiga.component.bo.AigaComponent;
import com.asiainfo.aiga.component.bo.extend.AigaInstComponent;
import com.asiainfo.aiga.component.service.IAigaComponentSV;
import com.asiainfo.aiga.component.service.impl.AigaCompTree;
import com.asiainfo.aiga.gui.bo.AigaGui;
import com.asiainfo.aiga.gui.bo.extend.AigaInstGui;
import com.asiainfo.aiga.gui.service.IAigaGuiSV;
import com.asiainfo.aiga.r_comp_gui.bo.AigaGuiCompRela;
import com.asiainfo.aiga.r_comp_gui.bo.extend.AigaInstRCompGui;
import com.asiainfo.aiga.userCase.service.IAigaCaseSV;

@Controller
@Scope(value="prototype")
public class ComponentAction extends BaseAction {
	
	@Resource(name="componentSV")
	private IAigaComponentSV componentSV;
	
	@Resource(name="caseSV")
	private IAigaCaseSV aigaCaseSV;
	
	@Resource(name="aigaGuiSV")
	private IAigaGuiSV aigaGuiSV;
	
	@RequestMapping("/getCompTreeVerify.do")
	public void getCompTreeVerify(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ApplicationContext context = RequestContextUtils.getWebApplicationContext(request);
		AigaCompTree compTree = (AigaCompTree)context.getBean("compTree");
		this.setTree(compTree,request);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value = "/refreshCompById.do")
	public void refreshCompById(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		try{
			String compId=request.getParameter("compId");
			AigaComponent comp = aigaCaseSV.getCompsByCompId(compId,AigaInstComponent.class);
			this.setFormData(comp);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/deleteComp.do")
	public void deleteComp(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try{
			Object[] results = this.transFormToObj(request, new Class[]{AigaInstComponent.class});
			AigaComponent aigaComp = new AigaInstComponent();
			for(Object result : results){
				if(result instanceof AigaComponent)
					aigaComp = (AigaComponent)result;
			}
			if(aigaComp!=null&&results.length!=0)
				componentSV.deleteAigaComponent(aigaComp);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/saveComp.do")
	public void saveComp(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Object[] results = this.transFormToObj(request, new Class[]{AigaInstComponent.class});
		Object[] guiObjs = this.transTableToObj(request,AigaInstGui.class);
		AigaComponent aigaComp = new AigaInstComponent();
		for(Object result : results){
			if(result instanceof AigaComponent)
				aigaComp = (AigaComponent)result;
		}
		if(aigaComp!=null&&results.length!=0){
			componentSV.saveAigaComponent(aigaComp);
//			删除关系，class是关系表所对应的class
			aigaGuiSV.delRCompGuiByCompId(aigaComp.getCompId(),AigaInstRCompGui.class);
			for(int i=0,n=guiObjs.length;i<n;i++){
				
				if(guiObjs[i] instanceof AigaInstGui){
					AigaGui aigaGui = (AigaInstGui)guiObjs[i];
					aigaGuiSV.saveAigaGui(aigaGui);
					AigaGuiCompRela aigaGuiCompRela=new AigaInstRCompGui();
					aigaGuiCompRela.setCompId(aigaComp.getCompId());
					aigaGuiCompRela.setGuiId(aigaGui.getGuiId());
					aigaGuiCompRela.setGuiOrder(i);
					aigaGuiSV.saveRCompGui(aigaGuiCompRela);
				}
			}
		}else{
			componentSV.saveAigaComponent(aigaComp);
		}
		Map map=new HashMap();
		map.put("success", true);
		map.put("compId", aigaComp.getCompId());
		ActionHelper.returnResponseData(request, response, map);
	}

	@RequestMapping("/getTreeSyn.do")
	public void getTreeSyn(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String node = request.getParameter("node");
		String type = request.getParameter("type");
		List<Tree> childTrees = new ArrayList<Tree>();
		AigaComponent[] aigaComponents = componentSV.getAigaComponentByParentId(Integer.valueOf(node),AigaInstComponent.class);
		for(AigaComponent aigaComponent : aigaComponents){
			Tree childeTree = new Tree();
			if(aigaComponent.getPermission()==null)
				aigaComponent.setPermission(Integer.valueOf(type));
			if(!aigaComponent.getPermission().equals(Integer.valueOf(type))){
				continue;
			}
			if(aigaComponent.getIsLeaf().equals("Y")){
				childeTree.setQtip("组件作者："+(aigaComponent.getAuthor()==null?"":aigaComponent.getAuthor())+"<br>"+
								"参考值：" +(aigaComponent.getDefaultVal()==null?"":aigaComponent.getDefaultVal())+"<br>"+
								"组件描述：" + (aigaComponent.getCompDesc()==null?"":aigaComponent.getCompDesc()));
				childeTree.setLeaf(true);
			}
			else childeTree.setLeaf(false);
			childeTree.setId(aigaComponent.getCompId());
			childeTree.setText(aigaComponent.getCompName());
			childeTree.setExpanded(false);
			childTrees.add(childeTree);
		}
		this.setPostInfo("children", childTrees);
		this.postInfo(request, response);
	}
	@RequestMapping("/getAllTreeSyn.do")
	public void getAllTreeSyn(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String node = request.getParameter("node");
		List<Tree> childTrees = new ArrayList<Tree>();
		AigaComponent[] aigaComponents = componentSV.getAigaComponentByParentId(Integer.valueOf(node),AigaInstComponent.class);
		for(AigaComponent aigaComponent : aigaComponents){
			Tree childeTree = new Tree();
			if(aigaComponent.getIsLeaf().equals("Y")){
				childeTree.setQtip("组件作者："+(aigaComponent.getAuthor()==null?"":aigaComponent.getAuthor())+"<br>"+
								"参考值：" +(aigaComponent.getDefaultVal()==null?"":aigaComponent.getDefaultVal())+"<br>"+
								"组件描述：" + (aigaComponent.getCompDesc()==null?"":aigaComponent.getCompDesc()));
				childeTree.setLeaf(true);
			}
			else childeTree.setLeaf(false);
			childeTree.setId(aigaComponent.getCompId());
			childeTree.setText(aigaComponent.getCompName());
			childeTree.setExpanded(false);
			childTrees.add(childeTree);
		}
		this.setPostInfo("children", childTrees);
		this.postInfo(request, response);
	}
	
	@RequestMapping("/saveCompFolder.do")
	public void saveCompFolder(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try{
			String folderName = new String(request.getParameter("folderName").getBytes("iso8859-1"),"UTF-8");
			String compId = request.getParameter("compId");
			componentSV.saveCompFolder(folderName, compId);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/editCompFolder.do")
	public void editCompFolder(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try{
			String folderName = new String(request.getParameter("folderName").getBytes("iso8859-1"),"UTF-8");
			String compId = request.getParameter("compId");
			componentSV.editCompFolder(folderName, compId);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/deleteCompFolder.do")
	public void deleteCompFolder(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try{
			String folderName = new String(request.getParameter("folderName").getBytes("iso8859-1"),"UTF-8");
			String compId = request.getParameter("compId");
			componentSV.deleteCompFolder(folderName, compId);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/getUnApprovalComp.do")
	public void getUnApprovalComp(HttpServletRequest request,HttpServletResponse response)throws Exception{
		try{
			String currentStaff = request.getParameter("currentStaff");
			AigaComponent[] aigaComponents = componentSV.getUnApprovalComp(currentStaff);
			this.setTable(aigaComponents);
			this.setPostInfo("success", true);
		}catch(Exception e){
			e.printStackTrace();
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getMessage());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/saveApprovalComp.do")
	public void saveApprovalComp(HttpServletRequest request,HttpServletResponse response)throws Exception{
		try{
			Object[] aigaInstComp = this.transFormToObj(request, new Class[]{AigaInstComponent.class});
			if(aigaInstComp!=null&&aigaInstComp.length==1)
				componentSV.saveApprovalComp((AigaInstComponent)aigaInstComp[0]);
			this.setPostInfo("success", true);
		}catch(Exception e){
			e.printStackTrace();
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getMessage());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/batchApprovalComp.do")
	public void batchApprovalComp(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try{
			AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
			if(user==null)
				throw new Exception("未知当前登录人");
			String compIds = request.getParameter("compIds");
			if(compIds!=null&&compIds.length()!=0)
				componentSV.saveBatchApprovalComp(compIds,user);
			this.setPostInfo("success", true);
		}catch (Exception e) {
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
}
