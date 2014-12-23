<%@ page import="com.ai.appframe2.common.SessionManager"%>
<%
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);
%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai" %>
<%SessionManager.setContextName(request.getContextPath());
 SessionManager.setRequest(request);
 %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/webframe/common/AIFrameDBCSS_css.jsp" type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/jsv2/AppFrameCss.jsp" type="text/css">
