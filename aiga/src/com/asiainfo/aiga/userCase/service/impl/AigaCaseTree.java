package com.asiainfo.aiga.userCase.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.asiainfo.aiga.common.Tree;
import com.asiainfo.aiga.common.ZTree;
import com.asiainfo.aiga.userCase.bo.AigaCase;
import com.asiainfo.aiga.userCase.bo.extend.AigaInstCase;
import com.asiainfo.aiga.userCase.service.IAigaCaseSV;

/**
 * Created on 2014-6-30
 * <p>Description: [���������Ҫ���ܽ���]</p>
*/
public class AigaCaseTree extends ZTree
{
	@Resource(name="caseSV")
	IAigaCaseSV caseSV;

	@Override
	public List<Tree> setTreeChild(HttpServletRequest request, Tree parentTree) throws Exception
	{
		List<Tree> childTrees = new ArrayList<Tree>();
		AigaCase[] aigaCases = caseSV.getAigaCaseByParentId(parentTree.getId(),AigaInstCase.class);
		if(aigaCases.length!=0){
			for(AigaCase aigaCase : aigaCases){
				Tree childeTree = new Tree();
				childeTree.setId(aigaCase.getCaseId());
				childeTree.setText(aigaCase.getCaseName());
				childeTree.setExpanded(false);
				AigaCase[] aigaCas = caseSV.getAigaCaseByParentId(aigaCase.getCaseId(),AigaInstCase.class);
				if(aigaCas.length==0){
					childeTree.setQtip("�������ߣ�"+(aigaCase.getAuthor()==null?"":aigaCase.getAuthor())+"<br>"+
									"����������" + (aigaCase.getCaseDesc()==null?"":aigaCase.getCaseDesc()));
					childeTree.setLeaf(true);
				}
				else
					childeTree.setLeaf(false);
				childTrees.add(childeTree);
			}
		}
		return childTrees;
	}

	@Override
	public Tree setTreeRoot(HttpServletRequest request) throws Exception
	{
		String sql="from AigaCase where parentId=-1";
		
		AigaCase[] aigaCases = caseSV.getAigaCaseBySql(sql);
		if(aigaCases.length>1)
			throw new Exception("���ڵ㲻Ψһ");
		if(aigaCases.length==1){
			Tree root = new Tree();
			root.setId(aigaCases[0].getCaseId());
			root.setText(aigaCases[0].getCaseName());
			root.setExpanded(true);
			root.setLeaf(false);
			return root;
		}else
			return null;
	}
}
