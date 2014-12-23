package com.lb.app.privilege.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor{
	
	final private static Log log = LogFactory.getLog(LoginInterceptor.class);
	
	private String mappingURL = ".*/router";//利用正则映射到需要拦截的路径    


	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object obj, Exception exception)
			throws Exception {
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object arg2) throws Exception {
        String url=request.getRequestURL().toString();
       
        log.info("====>" + url);
        log.info("--->" + url.matches(this.mappingURL));
        log.info("===>" + request.getSession().getAttribute("user"));
        if(mappingURL==null || url.matches(this.mappingURL)){  
        	if(request.getSession().getAttribute("user") == null){
	        	log.info("用户未登录，已被拦截.");
	        	PrintWriter writer = response.getWriter();
	        	writer.format("{type:\'event\', name: \'login\', message:\'未登录用户\'}");
	        	writer.flush();
	        	response.setStatus(401);
	            return false;   
        	}
        	return true;
        }    
        return true;
	}

}
