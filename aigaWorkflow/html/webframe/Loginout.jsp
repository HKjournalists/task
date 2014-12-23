<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/secframe/common/common.jsp"%>

<%@ page  import="com.ai.secframe.service.orgmodel.interfaces.ISysLoginLog"%>
<%@ page  import="com.ai.appframe2.service.ServiceFactory"%>
<%@ page  import="com.ai.secframe.common.Constants"%>
<%@ page  import="com.ai.secframe.ivalues.orgmodel.ISysLoginLogValue"%>
<%@ page import="com.ai.appframe2.privilege.UserInfoInterface" %>
<%@ page  import="java.sql.*"%>

<html>
<head>

<%
	UserInfoInterface user = SessionManager.getUser();
	
   ISysLoginLog sysLoginLog = (ISysLoginLog) ServiceFactory.getService( Constants.SERVICE_SYS_LOGIN_LOG );

    if( user != null ){
      ISysLoginLogValue loginLogValue = sysLoginLog.getSysLoginLogByLogId( Long.parseLong( user.get( Constants.LOGIN_LOG_ID ).toString() ) );
      loginLogValue.setLogoutDate( new Timestamp( System.currentTimeMillis() ) );
      loginLogValue.setState( 0 );
      sysLoginLog.saveSysLoginLog( new ISysLoginLogValue[] { loginLogValue } );
    }
    user = null;
 %>


<title>_LOGIN_OUT</title>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/Globe_v2.jsp"></script>
<script language="JavaScript" >


	alert("当前用户已超时或者被管理员注销，将跳转至登录页面.请重新登录!")
	var winObj = getTopWin();
	if(winObj!=null)
	{
  		winObj.location="<%=request.getContextPath()%>/index.jsp";
	}
</script>
</head>

<body>
</body>

</html>
