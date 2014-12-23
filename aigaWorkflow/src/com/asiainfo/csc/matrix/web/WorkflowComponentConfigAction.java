package com.asiainfo.csc.matrix.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.web.CustomProperty;
import com.ai.appframe2.web.HttpUtil;
import com.ai.appframe2.web.action.BaseAction;
import com.asiainfo.csc.matrix.service.interfaces.IWorkflowComponentConfigSV;

public class WorkflowComponentConfigAction extends BaseAction {

	public void getComponentConfig(HttpServletRequest request, HttpServletResponse response) throws Exception{
		CustomProperty cp = CustomProperty.getInstance();
		try{
			String currentLinkNo = request.getParameter("currentLinkNo");
			String contextPath = request.getContextPath();
			
			IWorkflowComponentConfigSV componentConfigSV = (IWorkflowComponentConfigSV)ServiceFactory.getService(IWorkflowComponentConfigSV.class);
			String html = componentConfigSV.getWorkflowComponent(currentLinkNo,contextPath);
			cp.set("html", html);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			HttpUtil.showInfo(response, cp);
		}
	}
	
	public void addComponentConfig(HttpServletRequest request, HttpServletResponse response) throws Exception{
		CustomProperty cp = CustomProperty.getInstance();
		try{
			String linkNo = request.getParameter("linkNo");
			String contextPath = request.getContextPath();
			
			IWorkflowComponentConfigSV componentConfigSV = (IWorkflowComponentConfigSV)ServiceFactory.getService(IWorkflowComponentConfigSV.class);
			String html = componentConfigSV.addWorkflowComponent(linkNo,contextPath);
			cp.set("html", html);
		}catch(Exception e){
				e.printStackTrace();
		}finally{
			HttpUtil.showInfo(response, cp);
		}
	}
	
	public void getComponentConfigJson(HttpServletRequest request, HttpServletResponse response) throws Exception{
		CustomProperty cp = CustomProperty.getInstance();
		try{
			String currentLinkNo = request.getParameter("currentLinkNo");
			IWorkflowComponentConfigSV componentConfigSV = (IWorkflowComponentConfigSV)ServiceFactory.getService(IWorkflowComponentConfigSV.class);
			String json = componentConfigSV.getWorkflowComponentJson(currentLinkNo);
			cp.set("json", json);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			HttpUtil.showInfo(response, cp);
		}
	}
}
