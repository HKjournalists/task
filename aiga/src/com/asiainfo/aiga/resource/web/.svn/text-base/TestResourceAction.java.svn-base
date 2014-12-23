package com.asiainfo.aiga.resource.web;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.resource.bo.AigaTestResource;
import com.asiainfo.aiga.resource.service.ITestResourceSV;
import com.asiainfo.aiga.testTask.bo.AigaPerftestTask;

@Controller
public class TestResourceAction extends BaseAction {
	
	@Resource(name="resourceSV")
	private ITestResourceSV resourceSV;
	
	@RequestMapping(value="/getResources.do")
	public void getResources(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String subTaskId = request.getParameter("subTaskId");
		String querySql = "from AigaTestResource where sub_task_id=" + subTaskId;
		AigaTestResource[] results = resourceSV.getAigaResourcesBySql(querySql);
		this.setTable(results);
		this.setPostInfo("success", true);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/getPerfTestTask.do")
	public void getPerfTestTask(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String taskTag = request.getParameter("taskTag");
		String querySql = "from AigaPerftestTask where taskTag='" + taskTag+"'";
		AigaPerftestTask[] results = resourceSV.getAigaPerftestTaskBySql(querySql);
		this.setTable(results);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/getPerfTestTaskBySubId.do")
	public void getPerfTestTaskBySubId(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String subTaskId = request.getParameter("subTaskId");
		String querySql = "from AigaPerftestTask where taskTag in (select taskTag from AigaTestSubTask where subTaskId=" + subTaskId+")";
		AigaPerftestTask[] results = resourceSV.getAigaPerftestTaskBySql(querySql);
		this.setTable(results);
		this.postInfo(request, response);
	}
	
	@RequestMapping("/saveResources.do")
	public void saveResources(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Object[] results = this.transTableToObj(request, AigaTestResource.class);
		AigaTestResource resource;
		List<AigaTestResource> resources = new ArrayList<AigaTestResource>();
		for(Object result : results){
			if(result instanceof AigaTestResource) {
				resource = (AigaTestResource)result;
				resources.add(resource);
			}
		}
		for(AigaTestResource res : resources) {
			resourceSV.saveOrUpdate(res);
		}
		this.setPostInfo("success", true);
		this.postInfo(request, response);
	}
	
	@RequestMapping("/deleteResource.do")
	public void deleteResource(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String resId = request.getParameter("resId");
		String querySql = "from AigaTestResource where resource_id=" + resId;
		AigaTestResource[] delVals = resourceSV.getAigaResourcesBySql(querySql);
		for(AigaTestResource delVal : delVals) {
			resourceSV.deleteResource(delVal);
		}
		this.setPostInfo("success", true);
		this.postInfo(request, response);
	}
	
	@RequestMapping("/deleteAigaPerftestTask.do")
	public void deleteAigaPerftestTask(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pftId = request.getParameter("pftId");
		String querySql = "from AigaPerftestTask where pftId=" + pftId;
		AigaPerftestTask[] delVals = resourceSV.getAigaPerftestTaskBySql(querySql);
		for(AigaPerftestTask delVal : delVals) {
			resourceSV.deleteAigaPerftestTask(delVal);
		}
	}
	
	@RequestMapping("/saveAigaPerftestTask.do")
	public void saveAigaPerftestTask(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Object[] results = this.transTableToObj(request, AigaPerftestTask.class);
		AigaPerftestTask resource;
		List<AigaPerftestTask> resources = new ArrayList<AigaPerftestTask>();
		for(Object result : results){
			if(result instanceof AigaPerftestTask) {
				resource = (AigaPerftestTask)result;
				resources.add(resource);
			}
		}
		for(AigaPerftestTask res : resources) {
			resourceSV.saveOrUpdateAigaPerftestTask(res);
		}
	}

}
