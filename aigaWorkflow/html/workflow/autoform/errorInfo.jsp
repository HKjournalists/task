<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.ai.appframe2.web.HttpUtil"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
</head>
<body>
	<%
			String[] urlName ={"其他","回单","任务领取","业务数据查看"};
			String aWorkFlowCode = HttpUtil.getAsString(request, "WORK_FLOW_CODE");//
			String aWorkFlowNodeCode = HttpUtil.getAsString(request, "WORK_FLOW_NODE_CODE");//
			int urlBusiType =  HttpUtil.getAsInt(request, "urlType");
	
	 %>
	 错误！
	 <p>
	 流程模板：【<%=aWorkFlowCode%>】
	 <p>
	 节点：【<%=aWorkFlowNodeCode %>】 
	 <p>
	 <%=urlName[urlBusiType]%>的URL 尚未配置！
	 <p align="center">
	 <input type="button" value="关  闭"  onclick="window.close();">
</body>
</html>