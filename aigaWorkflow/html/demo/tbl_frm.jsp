<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.ai.appframe2.privilege.UserInfoInterface"%>
<%@include file="/csc/common/taglib.jsp"%>
<%
	String cxt = request.getContextPath();
	request.setAttribute("cxt",cxt);
%>

<html>
	<head>
		<title>demo页面——ai:stable&ai:dbform</title>
	</head>
	
	<body>
		<!-- 加入透明滤镜公共页面开始 -->
		<jsp:include flush="true" page="/csc/common/FilterDiv.jsp"/>
		<!-- 加入透明滤镜公共页面结束 -->
		<%-- div_title上下都有距离，div_title_new只有底边与其他元素有距离 --%>
		<div id="demo_form_div" class="div_title_new">
			<div class="explain_title_div">
				<img alt="" src="<%=request.getContextPath()%>/csc/images/div/select.gif">
				<font>查询条件</font>
				<input type="button" value="查询" class="explain_title_button" onclick="alert('come on!');"/>
			</div>
			<!--  form 中有datamodel="com.ai.appframe2.web.datamodel.MethodModelForService" 这一行时可以用自己写的
			方法刷新，否则按数据库字段刷新-->
			<ai:dbform formid="frmQryWorkOrder" setname="com.asiainfo.csc.req.web.SETWorkOrder"
				implservice_name="com.asiainfo.csc.req.service.AlmWorkOrderSV"
				implservice_querymethod="queryOrderById(String orderId)"
				datamodel="com.ai.appframe2.web.datamodel.MethodModelForService"
				editable="true" initial="false">
				<ai:dbformfield fieldname="PREALARM_TIME" formid="frmQryWorkOrder"  visible="false"/> 
				<ai:dbformfield fieldname="ALARM_TIME" formid="frmQryWorkOrder"  visible="false" />
				<ai:dbformfield fieldname="DELAY_TIME" formid="frmQryWorkOrder"  visible="false" />
				<table align="center" width="100%">
					<tr align="right">
						<td class="title_e">ORDER_ID</td>
						<td class="aiEdit_3col" align="left"><ai:dbformfield fieldname="ORDER_ID" formid="frmQryWorkOrder" editable="true" width="<%=aiEdit_3cw%>"/></td>
						<td class="title_r">OBJ_ID</td>
						<td class="aiEdit_3col" align="left"><ai:dbformfield fieldname="OBJ_ID" formid="frmQryWorkOrder" editable="true" width="<%=aiEdit_3cw%>"/></td>
					</tr>
					<tr align="right">
						<td class="title_e">TIME</td>
						<td class="aiEdit_3col" colspan="2">
							<ai:dbformfield fieldname="CREATE_TIME" formid="frmQryWorkOrder" visible="true" editable="true"></ai:dbformfield>-
							<ai:dbformfield fieldname="FINISH_TIME" formid="frmQryWorkOrder" visible="true" editable="true"></ai:dbformfield>
						</td>
					</tr>
					<tr align="right">
						<td class="title_e">TASK_ID</td>
						<!-- 
							设为textarea时：
						 -->
						<td class="aiEdit_3col" colspan="1">
							<ai:dbformfield fieldname="TASK_ID" formid="frmQryWorkOrder" visible="true" editable=""  height="<%=aiEditArea_high_min%>" width="<%=aiEditArea_4cw%>"></ai:dbformfield>
						</td>
					</tr>
				</table>
			</ai:dbform>
		</div>
		<div id="demo_tbl_div" class="div_title_new">
			<%--
			<table class="content_title" border="0">
				<tr>
					<td class="content_title_text">测试平台日志显示区</td>
				</tr>
			</table>
			 --%>
			<div class="explain_title_div">
				<img alt="" src="<%=request.getContextPath()%>/csc/images/div/context.gif">
				<font>详细信息</font>
			</div>
			<ai:stable tableid="tblDemoOrder" setname="com.asiainfo.csc.req.web.SETWorkOrder"
				height="200" width="100%" footdisplay="true" needrefresh="true" initial="false"
				invoke_type="service" invoke_name="com.asiainfo.csc.req.service.AlmWorkOrderSV"
				invoke_querymethod="queryPileLog(String param1, String param2,String param3, String beginTime, String endTime, int $STARTROWINDEX, int $ENDROWINDEX)"
				invoke_countmethod="queryPileLogCount(String param1, String param2, String param3, String beginTime, String endTime)"
				editable="false" multiselect="false" rowheight="-1" pagesize="10" rowsequence="false"
				oncontextmenu="" ondbclick="displayDemoTbl" >
				<ai:col fieldname="PREALARM_TIME" width="230" editable="false" />
				<ai:col fieldname="ALARM_TIME"  width="150"  visible="true" />
				<ai:col fieldname="DELAY_TIME"  width="210"  visible="true" />
			</ai:stable>
		</div>
	</body>
	<script type="text/javascript">
		var frmQryWorkOrder = g_FormRowSetManager.get("frmQryWorkOrder");
		var tblDemoOrder = g_TableRowSetManager.get("tblDemoOrder");
		
		//init();
		
		function init() {
			qryBtnFunc();
		}
		
		function qryBtnFunc() {
			var param1 = frmQryWorkOrder.getValue("ORDER_ID");
			var param2 = frmQryWorkOrder.getValue("OBJ_ID");
			var param3 = frmQryWorkOrder.getValue("TASK_ID");
			var beginTime = frmQryWorkOrder.getValue("CREATE_TIME");
			var endTime = frmQryWorkOrder.getValue("FINISH_TIME");
			
			var condition = "param1="+param1+"&param2="+param2+"&param3="+param3+"&beginTime="+beginTime+"&endTime="+endTime;
			alert(condition);
			//tblDemoOrder.refresh(null,condition);
		}
		
		function displayDemoTbl() {
			var row = tblDemoOrder.getRow();
			var orderId = tblDemoOrder.getValue(row,"ORDER_ID");
			var condition = "orderId="+orderId;
			frmQryWorkOrder.refresh(condition);
		}
	 	
	</script>
</html>
