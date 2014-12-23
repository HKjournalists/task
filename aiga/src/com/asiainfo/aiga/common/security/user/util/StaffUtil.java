package com.asiainfo.aiga.common.security.user.util;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.springframework.context.ApplicationContext;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.asiainfo.aiga.common.security.user.bo.AigaUser;
import com.asiainfo.aiga.common.security.user.dao.IUserDAO;

public class StaffUtil implements IUtil{
	private static IUserDAO userDao;
	private static Map<String,AigaUser> staffMap;
	public StaffUtil staffUtil=null;
	private StaffUtil(){}
	public StaffUtil getSigletion(HttpServletRequest request){
		ApplicationContext context = RequestContextUtils.getWebApplicationContext(request);
		return (StaffUtil)context.getBean("staffUtilInit");
	}
	public void init()throws Exception{
		staffMap=userDao.initUsers();
	}
	public void setUserDao(IUserDAO userDao) {
		this.userDao = userDao;
	}
	public static AigaUser getUserByAccount(String Account){
		return staffMap.get(Account.trim().toUpperCase());
	}
	
	public static void refreshUserInfo() throws Exception {
		staffMap=userDao.initUsers();
	}
	public static AigaUser getUser(HttpServletRequest request){
		return (AigaUser)request.getSession().getAttribute("aigaUser");
	}
	public static String getUserName(HttpServletRequest request){
		return getUser(request).getUserName();
	}
	public static int getUserId(HttpServletRequest request){
		AigaUser user=getUser(request);
		return (int)user.getUserId();
	}
	public static String getUserAccount(HttpServletRequest request){
		return getUser(request).getUserAccount();
	}
}
