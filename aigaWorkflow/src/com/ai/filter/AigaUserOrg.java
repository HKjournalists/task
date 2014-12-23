package com.ai.filter;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.web.action.BaseAction;

public class AigaUserOrg extends BaseAction {

	public void getUserOrg(HttpServletRequest httpServletRequest,HttpServletResponse httpServletResponse)throws Exception{
		String orgName = ServiceManager.getUser().getOrgName();
		orgName = URLEncoder.encode(orgName,"UTF-8");
		httpServletResponse.getWriter().write(orgName);
	}
}
