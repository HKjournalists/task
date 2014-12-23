package com.asiainfo.aiga.r_collect_case.web;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.common.Tree;
import com.asiainfo.aiga.common.WorkflowParam;
import com.asiainfo.aiga.r_collect_case.service.IAigaRFunCaseSV;
import com.asiainfo.aiga.requisition.bo.AigaTestSubTask;
import com.asiainfo.aiga.requisition.service.IAigaRequisitionSV;

@Controller
public class AigaCollectCaseAction extends BaseAction {

	@Resource(name="requisitionSV")
	IAigaRequisitionSV aigaRequisitionSV;
	
	@Resource(name="rFunCaseSV")
	IAigaRFunCaseSV aigaRFunCaseSV;
	
	@RequestMapping("/getsubTaskTreeSyn.do")
	public void getsubTaskTreeSyn(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String testorId = request.getParameter("staffId");
		String subTaskStatus = request.getParameter("subTaskStatus");
		if(testorId==null||testorId.equals(""))
			throw new Exception("缺少参数，sttaffId");
		List<Tree> trees = new ArrayList<Tree>();
		StringBuffer hql = new StringBuffer("from AigaTestSubTask t where t.testorId="+testorId);
		if(StringUtils.isBlank(subTaskStatus)){
			throw new Exception("缺少参数，subTaskStatus");
		}else if(subTaskStatus.equals("0")){
			//hql.append(" and t.subTaskStatus<>"+WorkflowParam.getWorkflow("subTaskTaskEnd").getLinkId());
			hql.append(" and t.subTaskStatus not in (699,799,899) ");
		}
		hql.append(" and t.subTaskId in (select distinct c.subTaskId from AigaFunFolder a,AigaRFunCase b,AigaFunPoint c where c.funId=b.funId and c.relaFolderId=a.funId)");
		AigaTestSubTask[] aigaTestSubTasks = aigaRequisitionSV.getAigaTestSubTaskBySql(hql.toString());
		
		for(AigaTestSubTask aigaTestSubTask : aigaTestSubTasks){
			Tree tree = new Tree();
			tree.setId(aigaTestSubTask.getSubTaskId());
			tree.setText(aigaTestSubTask.getSubTaskName());
			tree.setLeaf(true);
			
			trees.add(tree);
		}
		this.setPostInfo("children", trees);
		this.postInfo(request, response);
	}
	
	@RequestMapping("/saveFunCaseRela.do")
	public void saveFunCaseRela(HttpServletRequest request,HttpServletResponse response) throws Exception {
		try{
			String caseIds = request.getParameter("caseIds");
			String funId = request.getParameter("funId");
			if(funId==null||funId.equals(""))
				throw new Exception("缺少请求参数funId");
			if(caseIds==null)
				throw new Exception("缺少请求参数caseIds");
			aigaRFunCaseSV.saveRAigaFunCase(caseIds, funId);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
}
