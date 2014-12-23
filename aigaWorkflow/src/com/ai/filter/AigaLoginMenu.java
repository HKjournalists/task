package com.ai.filter;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.web.action.BaseAction;

public class AigaLoginMenu extends BaseAction {

	public void getMenu(HttpServletRequest request, HttpServletResponse response) throws Exception{
		long domain_id = ServiceManager.getCurrentDomainId();
		String menuXml = com.ai.appframe2.privilege.UserManagerFactory.getUserManager().getUserMenuXml(ServiceManager.getUser().getCode(),"H",domain_id);
		menuXml = URLEncoder.encode(menuXml,"UTF-8");
		response.getWriter().write(menuXml);
	}
}
