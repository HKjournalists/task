<%@ page contentType="text/html; charset=GBK" %>

<%@ page import="com.ai.appframe2.service.ServiceFactory"%>
<%@include file="/secframe/common/common.jsp"%>
<%@ include file="/webframe/common/commonhead.jsp"%>
<%@ include file="/webframe/jspcommon/includedhead.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<%
	String cxt = request.getContextPath();
	request.setAttribute("cxt",cxt);
 %>

<html>
<head>
<script src="<%=request.getContextPath()%>/jsv2/TabPage.js"></script>
<title>Ê×Ò³</title>
</head>
<body style='width:100%;height:100%;background-repeat:no-repeat;background-position:right bottom'" bgcolor='#FFFFFF'>
		<table width="99%" height="99%" align="center" border="0">
			<tr><td>
				<!--<ai:tab id="tab1" getParameter="" height="99%">
					<ai:tabitem id='item1' title="¹¤µ¥" initial="true"  src="${cxt }/csc/common/WorkorderList.jsp"/>
				</ai:tab>-->
			</td></tr>
		</table>
</body>
<script type="text/javascript">
	//tabResizeTo("tab1","99%","100%");
</script>
</html>