package com.asiainfo.csc.common.web;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import com.ai.appframe2.web.action.BaseAction;
import com.asiainfo.csc.common.define.WorkFlowParam;
import com.asiainfo.csc.common.vo.Workflow;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowValue;

public class WorkflowParamAction extends BaseAction {

	public void getWorkflowParam(HttpServletRequest request,HttpServletResponse response)throws Exception{
		
		Map<String,IBOAlmWorkflowValue> workflowParamMap = WorkFlowParam.getInstance().getWorkflowsMap();
		Map<String,Workflow> result = new HashMap<String, Workflow>();
		for(Object key : workflowParamMap.keySet()){
			IBOAlmWorkflowValue almWorkflowValue = workflowParamMap.get(key.toString());
			if(almWorkflowValue!=null){
				Workflow workflow = new Workflow();
				workflow.setLinkId(almWorkflowValue.getLinkId());
				workflow.setLinkNo(almWorkflowValue.getLinkNo());
				workflow.setLinkNoType(almWorkflowValue.getLinkNoType());
				workflow.setLinkUrl(almWorkflowValue.getLinkUrl());
				workflow.setPhaseId(almWorkflowValue.getPhaseId());
				workflow.setPhaseName(almWorkflowValue.getPhaseName());
				workflow.setRoleCode(almWorkflowValue.getRoleCode());
				workflow.setTemplateId(almWorkflowValue.getTemplateId());
				workflow.setTemplateName(almWorkflowValue.getTemplateName());
				workflow.setTemplateType(almWorkflowValue.getTemplateType());
				workflow.setVersion(almWorkflowValue.getVersion());
				workflow.setVmLinkId(almWorkflowValue.getVmLinkId());
				workflow.setVmTaskName(almWorkflowValue.getVmTaskName());
				workflow.setVmTaskNo(almWorkflowValue.getVmTaskNo());
				workflow.setWfItemId(almWorkflowValue.getWfItemId());
				
				result.put(key.toString(), workflow);
			}
		}
		
		JSONObject object = JSONObject.fromObject(result);
		String jsonString = URLEncoder.encode(object.toString(),"UTF-8");
		response.getWriter().write(jsonString);
	}
	
	public void getWorkflowParamByLinkNo(HttpServletRequest request,HttpServletResponse response)throws Exception{
		
		String linkNo = request.getParameter("linkNo");
		IBOAlmWorkflowValue  almWorkflowValue = WorkFlowParam.getInstance().getWorkflowByLinkNo(linkNo);
		
		Workflow workflow = new Workflow();
		workflow.setLinkId(almWorkflowValue.getLinkId());
		workflow.setLinkNo(almWorkflowValue.getLinkNo());
		workflow.setLinkNoType(almWorkflowValue.getLinkNoType());
		workflow.setLinkUrl(almWorkflowValue.getLinkUrl());
		workflow.setPhaseId(almWorkflowValue.getPhaseId());
		workflow.setPhaseName(almWorkflowValue.getPhaseName());
		workflow.setRoleCode(almWorkflowValue.getRoleCode());
		workflow.setTemplateId(almWorkflowValue.getTemplateId());
		workflow.setTemplateName(almWorkflowValue.getTemplateName());
		workflow.setTemplateType(almWorkflowValue.getTemplateType());
		workflow.setVersion(almWorkflowValue.getVersion());
		workflow.setVmLinkId(almWorkflowValue.getVmLinkId());
		workflow.setVmTaskName(almWorkflowValue.getVmTaskName());
		workflow.setVmTaskNo(almWorkflowValue.getVmTaskNo());
		workflow.setWfItemId(almWorkflowValue.getWfItemId());
		
		response.setContentType("application/Json;charset=UTF-8");
		JSONObject object = JSONObject.fromObject(workflow);
		response.getWriter().write(URLEncoder.encode(object.toString(),"UTF-8"));
	}
}
