<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/workflow/common/publicJSFunction.jsp" %>
<%
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
	String passInfo = "保存";
	//工单Id
	String orderId = request.getParameter("orderId");
	//对象Id
	String objectId = request.getParameter("objId");
	//对象Type
	String subTaskType = request.getParameter("subTaskType");
%>

<html>
<head>
	<title>测试子任务需求保存</title>
</head>
	<body style="padding:10px 0px 60px 10px">
		<div>
		    <%if(subTaskType.equals("4")) {%>
			<jsp:include page="/aiga/workflow/subTaskAnalysis.jsp">
				<jsp:param name="objId" value="<%=objectId %>"/>
				<jsp:param name="objType" value="<%=subTaskType %>"/>
			</jsp:include>
			<%}else if(subTaskType.equals("5")){ %>
			<jsp:include page="/aiga/workflow/P2PSubTaskAnalysis.jsp">
				<jsp:param name="objId" value="<%=objectId %>"/>
				<jsp:param name="objType" value="<%=subTaskType %>"/>
			</jsp:include>
			<%}else{ %>
			<jsp:include page="/aiga/workflow/perfSubTest/PerfSubTaskForm.jsp">
				<jsp:param name="objId" value="<%=objectId %>"/>
				<jsp:param name="objType" value="<%=subTaskType %>"/>
			</jsp:include>
			<%}%>
			<!-- 操作区域浮动层 -->
			<!-- btmFixed -->
			<div class="btmFixed">
				<div class="btmFixedInner"></div>
				<div class="btmFixed_left" id="putongliucheng">
					<ul>
						<li title="<%=passInfo %>" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="funSave()">
							<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/upmng.gif" /></span>
							<p>保存</p>
						</li>
					</ul>
				</div>
			</div>
		</div>
     </body>
<script type="text/javascript">

</script>
</html>