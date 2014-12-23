package com.asiainfo.aiga.node_view.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.asiainfo.aiga.common.Tree;
import com.asiainfo.aiga.common.ZTree;
import com.asiainfo.aiga.node_view.bo.NodeView;
import com.asiainfo.aiga.userCase.service.IAigaCaseSV;

/**
 * Created on 2014-7-7
 * <p>Description: [���������Ҫ���ܽ���]</p>
*/
public class AigaNodeViewTree extends ZTree
{

	private String nodeId="";
	private String nodeTableName="";

	@Resource(name="caseSV")
	IAigaCaseSV caseSV;

	public ZTree setTreeData(HttpServletRequest request) throws Exception
	{
	nodeId=(String)request.getParameter("nodeId");
	nodeTableName=(String)request.getParameter("nodeTable");
	Map currentMap=new HashMap();
	currentMap.put("id.nodeId", Integer.parseInt(nodeId));
	currentMap.put("id.nodeTable", nodeTableName);
	NodeView[] nodeViews = caseSV.getNodeViewsByCondition(currentMap);
	if(nodeViews.length>1)throw new Exception("��ѯ���ı�ǩ��Ψһ");
	Tree currentTree=new Tree();
/**	currentTree.setParentId(String.valueOf(nodeViews[0].getId().getParentId()));
	currentTree.setId(String.valueOf(nodeViews[0].getId().getNodeId()));
	currentTree.setText(nodeViews[0].getId().getNodeName());
	currentTree.setExpanded(true);
	currentTree.setValue(String.valueOf(nodeViews[0].getId().getNodeId()));
	*/
//	����Ϊtrue
	currentTree.setLeaf(true);
//	���ڲ�֪���ڵ�λ����һ���Ҫ�������¶�����
	
	
//	ԭ���߼�
	/**���ϱ���ֱ�����ڵ�*******/
	Tree rootTree=new Tree();
	/**���±���ֱ���Ҳ����ӽڵ�**/
/*	setChild(currentTree.getId(),currentTree);
	
	if(currentTree.getParentId().equals(TreeConstants.ROOT_PARENT_ID)){
		this.setTree(currentTree);
	}else{
		findParent(rootTree,currentTree);
		this.setTree(rootTree);
	}
	*/
		return this;

	}

	/**
	 * 
	 * <p>Discription:[����id�������ڵ�]</p>
	 * @param id
	 * @return
	 * @throws Exception 
	 */
	public void findParent(Tree rootTree,Tree currentTree) throws Exception{
		Map parentMap=new HashMap();
//		���ϱ���
		/*
		parentMap.put("id.nodeId", Integer.parseInt(currentTree.getParentId()));
		parentMap.put("id.nodeTable", nodeTableName);
		NodeView[] nodeViews = caseSV.getNodeViewsByCondition(parentMap);
		if(nodeViews.length==0){
//			rootTree=currentTree;
			rootTree.setChildren(currentTree.getChildren());
			rootTree.setId(currentTree.getId());
			rootTree.setText(currentTree.getText());
			rootTree.setExpanded(currentTree.isExpanded());
			rootTree.setParentId(currentTree.getParentId());
			rootTree.setLeaf(currentTree.isLeaf());
			rootTree.setValue(currentTree.getValue());
		}else
			if(nodeViews.length==1){
				rootTree.setParentId(String.valueOf(nodeViews[0].getId().getParentId()));
				rootTree.setId(String.valueOf(nodeViews[0].getId().getNodeId()));
				rootTree.setText(nodeViews[0].getId().getNodeName());
				rootTree.setExpanded(true);
				rootTree.setValue(String.valueOf(nodeViews[0].getId().getNodeId()));
				List<Tree> childTrees = new ArrayList<Tree>();
				childTrees.add(currentTree);
				rootTree.setChildren(childTrees);
				Tree newTree=(Tree)rootTree.clone();
				findParent(rootTree,newTree);
			}
			else{throw new Exception("��ѯ���ı�ǩ��Ψһ");}
			*/
	}
	private boolean setChild(String parentId,Tree root)throws Exception{
		/*
		List<Tree> childTrees = new ArrayList<Tree>();
		Map childMap=new HashMap();
		childMap.put("id.parentId", Integer.parseInt(parentId));
		childMap.put("id.nodeTable", nodeTableName);
		NodeView[] nodeViews = caseSV.getNodeViewsByCondition(childMap);
		if(nodeViews.length!=0){
			for(NodeView nodeView : nodeViews){
				Tree childeTree = new Tree();
				boolean isLeaf = this.setChild(String.valueOf(nodeView.getId().getNodeId()), childeTree);
				childeTree.setId(String.valueOf(nodeView.getId().getNodeId()));
				childeTree.setText(nodeView.getId().getNodeName());
				childeTree.setExpanded(true);
				childeTree.setValue(String.valueOf(nodeView.getId().getNodeId()));
				childeTree.setLeaf(isLeaf);
				childTrees.add(childeTree);
			}
			root.setChildren(childTrees);
		}
		*/
		return true;
	}

	@Override
	public List<Tree> setTreeChild(HttpServletRequest request, Tree parentTree) throws Exception
	{
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Tree setTreeRoot(HttpServletRequest request) throws Exception
	{
		// TODO Auto-generated method stub
		return null;
	}
}
