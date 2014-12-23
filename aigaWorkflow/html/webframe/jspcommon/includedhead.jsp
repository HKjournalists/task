<%@ include file="commonhead.jsp"%>
<%@ page language="java" import="java.sql.*,java.io.*,java.util.*,com.ai.appframe2.web.*,com.ai.appframe2.common.SessionManager,com.ai.appframe2.privilege.*"%>
<%@ page import="com.ai.appframe2.service.ServiceFactory, com.asiainfo.csc.common.service.interfaces.IPermissionSV,com.asiainfo.csc.common.service.impl.PermissionSVImpl"%>
<%!
//begin
public UserInfoInterface g_GetUserInfo()
{
  return SessionManager.getUser();
}
//end
%>
<%
String g_ServerPort = request.getServerPort()+"";
if ("80".equals(g_ServerPort))
{
  g_ServerPort = "";
}
else
{
  g_ServerPort = ":"+g_ServerPort;
}

String  g_RootPath = "";//    "http://"+request.getServerName()+g_ServerPort+request.getContextPath();
String  g_LoginPageName = BaseServer.getLoginHTML();
String  g_LogoutPageName = BaseServer.getLogoutHTML();
UserInfoInterface global_UserInfo = null;
try
{
  global_UserInfo = BaseServer.getCurUser(request);
}
catch(Exception ex)
{
  out.println("<B>[ERROR]includedhead.jsp. getUserInfo Error.ex:"+ex.getMessage()+"</B>");
  return;
}
SessionManager.setUser(global_UserInfo);
%>
<%
		IPermissionSV isv = (IPermissionSV)ServiceFactory.getService(IPermissionSV.class);

		long userId = g_GetUserInfo().getID();
		String[] ss = isv.getProjectId(userId);
		long reqsource=isv.getReqSource(userId);
//		System.out.println(reqsource);
		request.getSession().setAttribute("porjectId", ss);
		request.getSession().setAttribute("reqSource",String.valueOf(reqsource));
		request.getSession().setAttribute("orgAndisMgr",isv.getOrgRole(userId));
		request.getSession().setAttribute("orgType",isv.getOrgType(userId));
		String orgNameStr = isv.getOrgName(g_GetUserInfo().getOrgId());
		request.getSession().setAttribute("orgNameStr", orgNameStr);	
%>