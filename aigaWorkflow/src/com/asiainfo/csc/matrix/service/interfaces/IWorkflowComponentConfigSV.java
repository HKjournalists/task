package com.asiainfo.csc.matrix.service.interfaces;

import com.asiainfo.csc.matrix.ivalues.IBOWorkflowComponentConfigValue;

public interface IWorkflowComponentConfigSV {

	public IBOWorkflowComponentConfigValue[] getWorkflowComponentConfig(String currentLinkNo)throws Exception;
	
	public String getWorkflowComponent(String currentLinkNo,String contextPath)throws Exception;
	
	public String getWorkflowComponentJson(String currentLinkNo)throws Exception;
	
	public String addWorkflowComponent(String linkNo,String contextPath)throws Exception;
	
}
