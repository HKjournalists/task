package com.asiainfo.aiga.search.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Stack;

import javax.servlet.http.HttpServletRequest;

import com.asiainfo.aiga.common.DynamicBean;
import com.asiainfo.aiga.common.Tree;
import com.asiainfo.aiga.common.ZTree;
import com.asiainfo.aiga.userCase.bo.AigaCase;

public class LuceneSearchTree extends ZTree {
	private Stack stack;
	private Class clazz;
	

	public Stack getStack() {
		return stack;
	}

	public void setStack(Stack stack) {
		this.stack = stack;
	}

	public Class getClazz() {
		return clazz;
	}

	public void setClazz(Class clazz) {
		this.clazz = clazz;
	}

	@Override
	public List<Tree> setTreeChild(HttpServletRequest request, Tree parentTree) throws Exception {
		List<Tree> childTrees = new ArrayList<Tree>();
		
		if (stack!=null&&stack.size() != 0) {
			AigaCase aigaCase =(AigaCase)stack.pop();
				Tree childeTree = new Tree();
				childeTree.setId(aigaCase.getCaseId());
				childeTree.setText(aigaCase.getCaseName());
				childeTree.setExpanded(true);
				
				if (stack.size()==0) {
					childeTree.setQtip("用例作者："
							+ (aigaCase.getAuthor() == null ? "" : aigaCase
									.getAuthor())
							+ "<br>"
							+ "用例描述："
							+ (aigaCase.getCaseDesc() == null ? "" : aigaCase
									.getCaseDesc()));
					childeTree.setLeaf(true);
				}else if(stack.size()==1){
					childeTree.setExpanded(true);
				}
				else{
					childeTree.setLeaf(false);
				}
				childTrees.add(childeTree);
			
		}
		return childTrees;
	}

	@Override
	public Tree setTreeRoot(HttpServletRequest request) throws Exception {
		if (stack==null&&stack.size()== 0)
			throw new Exception("找不到树结构");
		AigaCase obj = (AigaCase)stack.pop();
			Tree root = new Tree();
			root.setId(obj.getCaseId());
			root.setText(obj.getCaseName());
			root.setExpanded(true);
			root.setLeaf(false);
			return root;
	}

}
