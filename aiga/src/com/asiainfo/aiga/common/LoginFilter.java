package com.asiainfo.aiga.common;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginFilter implements Filter {
	
	private FilterConfig filterConfig;
	
	private static String workflowUrl = null;

	public void destroy() {
		this.filterConfig = null;
	}
	
	public static String getWorkflowUrl() {
		return workflowUrl;
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		ServletContext context = this.filterConfig.getServletContext();
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse res = (HttpServletResponse)response;
		HttpSession session = req.getSession();
		if(session.getAttribute("hasLogin") != null) {
//			context.log("身份认证通过，进入下一步处理");
			if(workflowUrl!=null&&!workflowUrl.equals("")) {
				session.setAttribute("workflowUrl", workflowUrl);
				session.setMaxInactiveInterval(3600);
			}
			else {
				throw new ServletException("加载workflowUrl失败");
			}
			chain.doFilter(request, response);
		} else {
			context.log("身份认证失败，直接返回");
			req.getSession().setAttribute("error", "请登录后再进行操作");
//			记住请求参数+((req.getQueryString()!=null||!req.getQueryString().equals("null")||!req.getQueryString().equals(""))?"?"+req.getQueryString():"")
			req.getSession().setAttribute("gotoUrl", req.getRequestURL());
			res.sendRedirect(req.getContextPath() + "/index.jsp");
		}
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
		
		InputStream in = LoginFilter.class.getClassLoader().getResourceAsStream("workflowConfig.properties");
		Properties p = new Properties();
		try {
			p.load(in);
			workflowUrl = p.getProperty("workflowUrl");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println("workflowConfig.properties文件加载失败");
			e.printStackTrace();
		}
	}

}
