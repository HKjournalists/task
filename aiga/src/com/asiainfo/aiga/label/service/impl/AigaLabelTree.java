package com.asiainfo.aiga.label.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.asiainfo.aiga.common.Tree;
import com.asiainfo.aiga.common.ZTree;
import com.asiainfo.aiga.label.bo.AigaLabel;
import com.asiainfo.aiga.label.service.IAigaLabelSV;

public class AigaLabelTree extends ZTree{

	@Resource(name="aigalabelSV")
	private IAigaLabelSV aigaLabelSV;

	@Override
	public List<Tree> setTreeChild(HttpServletRequest request,Tree parentTree) throws Exception {
		// TODO Auto-generated method stub
		List<Tree> childTrees = new ArrayList<Tree>();
		AigaLabel[] aigaLabels = aigaLabelSV.getAigaLabelByParentId(parentTree.getId());
		if(aigaLabels.length!=0){
			for(AigaLabel aigaLabel : aigaLabels){
				Tree childeTree = new Tree();
				AigaLabel[] aigaLabs = aigaLabelSV.getAigaLabelByParentId(aigaLabel.getLabelId());
				if(aigaLabs.length==0)
					childeTree.setLeaf(true);
				else
					childeTree.setLeaf(false);
				childeTree.setId(aigaLabel.getLabelId());
				childeTree.setText(aigaLabel.getLabelName());
				childeTree.setExpanded(false);
				childTrees.add(childeTree);
			}
			return childTrees;
		}else
			return new ArrayList<Tree>();
	}

	@Override
	public Tree setTreeRoot(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		AigaLabel[] aigaLabels = aigaLabelSV.getAigaLabelByParentId(-1);
		if(aigaLabels.length>1)
			throw new Exception("查询到根标签不唯一");
		if(aigaLabels.length==1){
			Tree root = new Tree();
			root.setId(aigaLabels[0].getLabelId());
			root.setText(aigaLabels[0].getLabelName());
			root.setExpanded(true);
			root.setLeaf(false);
			
			return root;
		}else{
			return null;
		}
	}
}
