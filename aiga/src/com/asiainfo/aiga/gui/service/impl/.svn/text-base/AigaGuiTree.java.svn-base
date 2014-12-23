package com.asiainfo.aiga.gui.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.asiainfo.aiga.common.Tree;
import com.asiainfo.aiga.common.ZTree;
import com.asiainfo.aiga.gui.bo.AigaGui;
import com.asiainfo.aiga.gui.bo.extend.AigaInstGui;
import com.asiainfo.aiga.gui.service.IAigaGuiSV;

/**
 * Created on 2014-6-30
 * <p>Description: [控件树]</p>
*/
public class AigaGuiTree extends ZTree
{

	@Resource(name="aigaGuiSV")
	private IAigaGuiSV aigaGuiSV;
	private short type = 0;


	@Override
	public List<Tree> setTreeChild(HttpServletRequest request, Tree parentTree) throws Exception
	{
		List<Tree> childTrees = new ArrayList<Tree>();
		List<AigaInstGui> aigaGuis = aigaGuiSV.getAigaCaseByHql("from AigaInstGui where parentId=" + parentTree.getId());
		if(aigaGuis.size()!=0){
			for(AigaInstGui aigaGui : aigaGuis){
				Tree childeTree = new Tree();
				if(aigaGui.getGuiPermission()==null)
					aigaGui.setGuiPermission(type);
				if(!aigaGui.getGuiPermission().equals(type)){
					continue;
				}
				if(aigaGui.getIsLeaf().equals("Y")){
		
					childeTree.setQtip("控件作者："+(aigaGui.getGuiAuthor()==null?"":aigaGui.getGuiAuthor()+"<br>")+
									"控件描述：" + (aigaGui.getGuiDesc()==null?"":aigaGui.getGuiDesc()));
					childeTree.setLeaf(true);
				}
				else childeTree.setLeaf(false);
				childeTree.setId(aigaGui.getGuiId());
				childeTree.setText(aigaGui.getGuiName());
				childeTree.setExpanded(false);
				childTrees.add(childeTree);
			}
		
		}
		return childTrees;
	}

	@Override
	public Tree setTreeRoot(HttpServletRequest request) throws Exception
	{
		this.type = Short.valueOf(request.getParameter("type"));
		AigaGui[] aigaGuis = aigaGuiSV.getAigaGuiByParentId(-1,AigaInstGui.class);
		if(aigaGuis.length>1)
			throw new Exception("父节点不唯一");
		if(aigaGuis.length==1){
			Tree root = new Tree();
			root.setId(aigaGuis[0].getGuiId());
			root.setText(aigaGuis[0].getGuiName());
			root.setExpanded(true);
			root.setLeaf(false);
			
			return root;
		}else return null;
		
	}
}
