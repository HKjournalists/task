package com.asiainfo.aiga.common;

import javax.servlet.http.HttpServletRequest;

import com.asiainfo.aiga.common.security.user.bo.AigaUser;

public class CommonUtil {
	
	public static AigaUser getSessionUser(HttpServletRequest request) throws Exception {
		return (AigaUser)request.getSession().getAttribute("aigaUser");
	}

}
