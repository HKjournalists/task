package com.asiainfo.aiga.manualTask.web;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.manualTask.bo.AigaManualTask;
import com.asiainfo.aiga.manualTask.service.IAigaManualTaskSV;
import com.asiainfo.aiga.userCase.bo.AigaCaseParams;
import com.asiainfo.aiga.userCase.service.IAigaCaseParamSV;

@Controller
public class AigaManualTaskAction extends BaseAction{

	@Resource(name="ManualTaskSV")
	private IAigaManualTaskSV aigaManualTaskSV;
	
	@Resource(name="caseParamSV")
	private IAigaCaseParamSV aigaCaseParamSV;
	
	@RequestMapping(value = "/saveManualTask.do")
	public void saveManualTask(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		try{
			Object[] objects = this.transTableToObj(request,AigaManualTask.class);
			List<AigaManualTask> aigaManualTask = new ArrayList<AigaManualTask>();
			for(Object object: objects){
				if(object instanceof AigaManualTask){
					aigaManualTask.add((AigaManualTask)object);
				}
			}
			aigaManualTaskSV.saveManualTasks(aigaManualTask);
			this.setPostInfo("success", true);
		}catch (Exception e) {
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping(value = "/getManualTask.do")
	public void getManualTask(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		try{
			String caseId = request.getParameter("caseId");
			AigaManualTask[] aigaManualTasks = null; 
			if(caseId!=null&&!caseId.equals(""))
				aigaManualTasks = aigaManualTaskSV.getManualTaskByCaseId(Integer.valueOf(caseId));
			else
				throw new Exception("传递参数缺少caseId");
			this.setTable(aigaManualTasks);
			this.setPostInfo("success", true);
		}catch (Exception e) {
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping(value = "/deleteManualTask.do")
	public void deleteManualTask(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		try{
			String taskId = request.getParameter("taskId");
			if(taskId!=null&&!taskId.equals(""))
				aigaManualTaskSV.deleteManualTaskByTaskId(Integer.valueOf(taskId));
			else
				throw new Exception("传递参数缺少taskId");
			this.setPostInfo("success", true);
		}catch (Exception e) {
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping(value = "/saveRunManual.do")
	public void saveRunManual(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		try{
			String actualResult = request.getParameter("actualResult");
			String preResult = request.getParameter("preResult");
			String preTestData = request.getParameter("preTestData");
			String manualtaskId = request.getParameter("manualtaskId");
			if(manualtaskId==null||manualtaskId.equals(""))
				throw new Exception("缺少请求参数taskId");
			String runId = request.getParameter("runId");
			if(runId==null||runId.equals(""))
				throw new Exception("缺少请求参数runId");
			String runResult = request.getParameter("runResult");
			String runTime = request.getParameter("runTime");
			String caseId = request.getParameter("caseId");
			if(caseId==null||caseId.equals(""))
				throw new Exception("缺少请求参数caseId");
			String taskId = request.getParameter("taskId");
			if(taskId==null||taskId.equals(""))
				throw new Exception("缺少请求参数taskId");
			String stepName = request.getParameter("stepName");
			aigaManualTaskSV.saveManualTaskAndLog(taskId, manualtaskId, runResult, runId, runTime, caseId, preResult, preTestData, actualResult,stepName);
			this.setPostInfo("success", true);
		}catch (Exception e) {
			e.printStackTrace();
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping(value = "/getManualTaskParam.do")
	public void getManualTaskParam(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		try{
			String caseId = request.getParameter("caseId");
			if(caseId==null||caseId.equals(""))
				throw new Exception("错误:缺少参数caseId");
			AigaCaseParams[] aigaCaseParams = aigaCaseParamSV.getAigaCaseParamsById(Integer.valueOf(caseId));
			this.setPostInfo("success", true);
			this.setTable(aigaCaseParams);
		}catch (Exception e) {
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
			e.printStackTrace();
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping(value = "/saveManualTaskParam.do")
	public void saveManualTaskParam(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String caseId = request.getParameter("caseId");
		if(caseId==null||caseId.equals(""))
			throw new Exception("缺少请求参数，caseId");
		Object[] objects = this.transTableToObj(request, AigaCaseParams.class);
		List<AigaCaseParams> aigaCaseParams = new ArrayList<AigaCaseParams>();
		for(Object object : objects){
			aigaCaseParams.add((AigaCaseParams)object);
		}
		if(aigaCaseParams.size()!=0)
			aigaCaseParamSV.saveAigaCaseParamss(aigaCaseParams.toArray(new AigaCaseParams[0]),caseId);
	}
}
