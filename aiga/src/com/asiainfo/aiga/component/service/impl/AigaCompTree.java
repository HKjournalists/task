package com.asiainfo.aiga.component.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.asiainfo.aiga.common.Tree;
import com.asiainfo.aiga.common.ZTree;
import com.asiainfo.aiga.component.bo.AigaComponent;
import com.asiainfo.aiga.component.bo.extend.AigaBaseComponent;
import com.asiainfo.aiga.component.bo.extend.AigaInstComponent;
import com.asiainfo.aiga.component.service.IAigaComponentSV;

/**
 * Created on 2014-6-30
 * <p>Description: [描述该类概要功能介绍]</p>
*/
public class AigaCompTree extends ZTree
{

	@Resource(name="componentSV")
	IAigaComponentSV componentSV;
	private int type = 0;


	@Override
	public List<Tree> setTreeChild(HttpServletRequest request, Tree parentTree) throws Exception
	{
		List<Tree> childTrees = new ArrayList<Tree>();
		AigaComponent[] aigaComponents = componentSV.getAigaComponentByParentId(parentTree.getId(),AigaInstComponent.class);
		if(aigaComponents.length!=0){
			for(AigaComponent aigaComponent : aigaComponents){
				Tree childeTree = new Tree();
				if(aigaComponent.getPermission()==null)
					aigaComponent.setPermission(type);
				if(!aigaComponent.getPermission().equals(type)){
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
		
		}
		return childTrees;
	}

	@Override
	public Tree setTreeRoot(HttpServletRequest request) throws Exception
	{
		this.type = Integer.valueOf(request.getParameter("type"));
		AigaComponent[] aigaComponents = componentSV.getAigaComponentByParentId(-1,AigaInstComponent.class);
		if(aigaComponents.length>1)
			throw new Exception("父节点不唯一");
		if(aigaComponents.length==1){
			Tree root = new Tree();
			root.setId(aigaComponents[0].getCompId());
			root.setText(aigaComponents[0].getCompName());
			root.setExpanded(true);
			root.setLeaf(false);
			
			return root;
		}else return null;
		
	}
}
