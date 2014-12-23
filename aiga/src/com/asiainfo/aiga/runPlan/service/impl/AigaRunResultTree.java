package com.asiainfo.aiga.runPlan.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.asiainfo.aiga.common.Tree;
import com.asiainfo.aiga.common.ZTree;
import com.asiainfo.aiga.requisition.bo.AigaRequisition;
import com.asiainfo.aiga.requisition.bo.AigaTestSubTask;
import com.asiainfo.aiga.requisition.service.IAigaRequisitionSV;
import com.asiainfo.aiga.runTask.bo.AigaRunTask;
import com.asiainfo.aiga.runTask.dao.IAigaRunTaskDAO;
import com.asiainfo.aiga.testPlan.dao.IAigaTestPlanDAO;
import com.asiainfo.aiga.testTask.bo.AigaTestTask;

public class AigaRunResultTree extends ZTree{

	@Resource(name="requisitionSV")
	IAigaRequisitionSV requisitionSV;
	@Resource(name="testPlanDao")
	IAigaTestPlanDAO testPlanDao;
	@Resource(name="aigaRunTaskDao")
	IAigaRunTaskDAO aigaRunTaskDAO;
	private int i=2;
	@Override
	public List<Tree> setTreeChild(HttpServletRequest request, Tree parentTree)
			throws Exception {
		// TODO Auto-generated method stub
		List<Tree> childTree = new ArrayList<Tree>();
		if(parentTree.getType().equals("REQ")){
			AigaRequisition[] requisitions = requisitionSV.getAigaRequisitionBySql("from AigaRequisition");
			for(AigaRequisition requisition : requisitions){
				Tree child = new Tree();
				child.setId(i++);
				child.setExpanded(false);
				child.setLeaf(false);
				child.setText(requisition.getReqName());
				child.setValue(requisition.getReqId().toString());
				child.setType("TESTTASK");
				childTree.add(child);
			}
		}
		else if(parentTree.getType().equals("TESTTASK")){
			AigaTestTask[] aigaTestTasks = testPlanDao.getAigaTestTaskBySql("from AigaTestTask where reqId="+parentTree.getValue());
			for(AigaTestTask aigaTestTask : aigaTestTasks){
				Tree child = new Tree();
				child.setId(i++);
				child.setExpanded(false);
				child.setLeaf(false);
				child.setText(aigaTestTask.getTaskName());
				child.setValue(aigaTestTask.getTaskTag());
				child.setType("TESTSUBTASK");
				childTree.add(child);
			}
		}
		else if(parentTree.getType().equals("TESTSUBTASK")){
			AigaTestSubTask[] aigaTestSubTasks = requisitionSV.getAigaTestSubTaskBySql("from AigaTestSubTask where taskTag='"+parentTree.getValue()+"'");
			for(AigaTestSubTask aigaTestSubTask : aigaTestSubTasks){
				Tree child = new Tree();
				child.setId(i++);
				child.setExpanded(false);
				child.setLeaf(false);
				child.setText(aigaTestSubTask.getSubTaskName());
				child.setType("TASK");
				child.setValue(aigaTestSubTask.getSubTaskId().toString());
				childTree.add(child);
			}
		}
		else if(parentTree.getType().equals("TASK")){
			AigaRunTask[] aigaRunTasks = aigaRunTaskDAO.getAigaRunTaskBySql("from AigaRunTask where subTaskId="+parentTree.getValue());
			for(AigaRunTask aigaRunTask : aigaRunTasks){
				Tree child = new Tree();
				child.setId(i++);
				child.setExpanded(false);
				child.setLeaf(true);
				child.setText(aigaRunTask.getTaskName());
				child.setType(aigaRunTask.getSubTaskId().toString());
				child.setValue(aigaRunTask.getTaskId().toString());
				childTree.add(child);
			}
		}
		return childTree;
	}

	@Override
	public Tree setTreeRoot(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		Tree root = new Tree();
		root.setId(1);
		root.setLeaf(false);
		root.setText("–Ë«Û");
		root.setType("REQ");
		return root;
	}

	
}
