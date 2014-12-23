package com.asiainfo.aiga.common;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.asiainfo.aiga.common.security.user.PassUtil;
import com.asiainfo.aiga.common.security.user.bo.AigaUser;
import com.asiainfo.aiga.common.security.user.service.IUserSV;
import com.asiainfo.aiga.common.security.user.util.StaffUtil;

@Controller
public class LoginAction extends BaseAction {
	
	@Resource(name="userSV")
	private IUserSV userSV;
	
	@RequestMapping(value="/login.do")
	public void login(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String userAcc = request.getParameter("userAcc");
		String pwd = request.getParameter("pwd");
		String msg = "";
		if(userAcc != null) {
			userAcc = userAcc.toUpperCase();
		}
		AigaUser user = StaffUtil.getUserByAccount(userAcc);
		if(user != null && PassUtil.getOrinPass(user.getUserPassword()).equals(pwd)) {
			ApplicationContext context = RequestContextUtils.getWebApplicationContext(request);
			WorkflowParam workflowParam = (WorkflowParam)context.getBean("workflowParam");
			request.getSession().setAttribute("workflowParam", workflowParam);
			request.getSession().setAttribute("hasLogin", true);
			request.getSession().setAttribute("aigaUser", user);
			msg = "登录成功";
			Object gotoUrl = request.getSession().getAttribute("gotoUrl");
			if(gotoUrl == null) {
				gotoUrl = request.getContextPath() + "/aiga/Desktop_new.jsp";
			}
			request.getSession().removeAttribute("gotoUrl");
			response.sendRedirect(gotoUrl.toString());
		} else {
			msg = "用户名或密码不正确";
			request.getSession().setAttribute("error", msg);
			response.sendRedirect(request.getContextPath() + "/index.jsp");
		}
	}
	
	@RequestMapping(value="/refreshUserInfo.do")
	public void refreshUserInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		StaffUtil.refreshUserInfo();
	}
	
	@RequestMapping(value="/logout.do")
	public void logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.getSession().removeAttribute("hasLogin");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}

}
