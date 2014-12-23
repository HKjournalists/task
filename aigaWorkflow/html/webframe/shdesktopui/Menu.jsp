<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>Menu</TITLE>
<%@ include file="/webframe/jspcommon/includedhead.jsp"%>
<%@ page contentType="text/html; charset=GBK" %>
<%
  long staffId = g_GetUserInfo().getID();
%>
<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/jsv2/DBTreeXmlModel.js"></SCRIPT>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsv2/Globe_v2.jsp"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/FieldType_v2.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/UserData_v2.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/DataType_v2.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/NormalRowSet.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/DBTree_v2.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/CommUtil.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/UIRelation_v2.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/Object_v2.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/PopMenu_v2.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/DataSource_v2.js" type="text/javascript"></script>
<script language="JavaScript" src="js/MovePict.js"></script>
<script language="JavaScript">
function openUrl(url,name){
  top.url_position.innerText = name;
  contentFrame.location = url;
  top.url_position_page = url;
}
</script>
</HEAD>
<BODY  ondragenter="window.event.returnValue=false;" ondragleave="window.event.returnValue=false;" ondragover="window.event.returnValue=false;"  ondragstart="startdragFunc()">
<iframe  id="contentFrame" frameborder="0" width="100%" height="100%" src="Desktop.jsp" ></iframe>
</BODY>
</HTML>
<script language="JavaScript" >
/**用户点击菜单时保存点击该菜单的时间，以便记录最近用户使用的菜单
* 用于桌面显示
*/
function logUserMenuClick(aMenuId,aMenuName,aUrlAddr){
	var para = "?action=updateUserRecentFunc&menuid=" + aMenuId
		 + "&operatorId=<%=staffId%>"
		 + "&menuname=" + aMenuName
		 + "&url=" + g_ConditonStrEncode(aUrlAddr);
	PostInfo("<%=request.getContextPath()%>/business/com.ai.frame.desktopui.web.UserVisitControlAction"+para);
}
/**结束**/
</script>