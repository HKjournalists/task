package com.asiainfo.aiga.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asiainfo.aiga.common.security.user.bo.AigaMenu;
import com.asiainfo.aiga.common.security.user.service.IUserSV;
import com.asiainfo.aiga.userCase.bo.AigaCase;
import com.asiainfo.aiga.userCase.bo.extend.AigaInstCase;

@Controller
public class MenuAction extends BaseAction {
	
	@Resource(name="userSV")
	IUserSV userSV;
	
	@RequestMapping(value="/getMenuTreePanelList.do")
	public void getMenuTreePanelList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String querySql = "from AigaMenu where parent_id is null order by sort";
		AigaMenu[] menus = userSV.getAigaMenuBySql(querySql);
		this.setTable(menus);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/getMenuTreeNodeList.do")
	public void getMenuTreeNodeList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String node = request.getParameter("id");
		
		String querySql = "from AigaMenu where parent_id=" + node + " order by sort";
		List<Object> childTrees = new ArrayList<Object>();
		AigaMenu[] menus = userSV.getAigaMenuBySql(querySql);
//		AigaCase[] aigaCases = aigaCaseSV.getAigaCaseByParentId(Integer.valueOf(node));
		for(AigaMenu aigaMenu : menus){
			Tree childeTree = new Tree();
			String con = "from AigaMenu where parent_id=" + aigaMenu.getMenuId();
			AigaMenu[] childMenus = userSV.getAigaMenuBySql(con);
	
			if(childMenus.length==0){
				childeTree.setLeaf(true);
			} else {
				childeTree.setLeaf(false);
			}
			childeTree.setId(Integer.parseInt(aigaMenu.getMenuId()+""));
			childeTree.setText(aigaMenu.getMenuText());
			childeTree.setExpanded(false);
			childeTree.setType(aigaMenu.getType());
			childeTree.setIconCls(aigaMenu.getIconCls());
			childeTree.setParentId(Integer.valueOf(node));
			childeTree.setComponent(aigaMenu.getComponent());
			childTrees.add(childeTree);
		}
		this.setPostInfo("children", childTrees);
		this.postInfo(request, response);
		
	}

}
