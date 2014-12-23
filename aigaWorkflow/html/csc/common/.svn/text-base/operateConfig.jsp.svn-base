<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.ai.appframe2.privilege.UserInfoInterface,com.asiainfo.csc.common.define.OperateParam"%>
<%@include file="/csc/common/taglib.jsp"%>
<%
	String cxt = request.getContextPath();
	request.setAttribute("cxt",cxt);
	OperateParam op = new OperateParam();
	request.setAttribute("OPERATEPARAM",op);
%>

<html>
	<head>
		<title>配置操作</title>
	</head>
	
	<body>
		<div style="width: 100%; text-align: center;">
			<div style="width: 48%;float: left;">
				<div id="op_tbl_order_div" style="height: 50%;width: 100%;">
					<table class="content_title" border="0">
						<tr>
							<td class="content_title_text">
								讨论关联：<ai:listbox id="boxCurStatus" ds="com.asiainfo.csc.common.web.DSCurStatus" />&nbsp;
								<ai:button text="查询讨论" onclick="qryDiscussRela()" />
								<ai:button text="讨论相关" onclick="refreshTbl('${OPERATEPARAM.DISCUSSOPERATE}')"/>
								<ai:button text="保存讨论" onclick="saveDiscussRela('${OPERATEPARAM.DISCUSSOPERATE}')" />
							</td>
						</tr>
					</table>
					<ai:stable tableid="tblDiscussDisplay" setname="com.asiainfo.csc.meeting.web.SETDiscussOperate"
						height="200" width="100%" footdisplay="true" needrefresh="true" initial="false"
						invoke_type="service" invoke_name="com.asiainfo.csc.common.service.WorkorderSV"
						invoke_querymethod="qryOperate(String relaObjId,String opType)"
						editable="false" multiselect="true" rowheight="-1" pagesize="10" rowsequence="true"
						oncontextmenu="" ondbclick="" >
						<ai:col fieldname="OPERATE_ID" width="230" visible="false" />
						<ai:col fieldname="OPERATE_NAME"  width="100"  visible="true" />
						<ai:col fieldname="OPERATE_FUNC_NAME"  width="150"  visible="true" />
						<ai:col fieldname="OPERATE_TYPE_STR"  width="200"  visible="true" />
					</ai:stable>
				</div>
				<div id="op_tbl_discuss_div" style="height: 50%;width: 100%;">
					<table class="content_title" border="0">
						<tr>
							<td class="content_title_text">
								
							</td>
							<td>
								功能点关联:<ai:listbox id="boxFunPoint" ds="com.asiainfo.csc.common.web.DSCurStatus" width="<%=aiEdit_3cw%>"/>&nbsp;
								<ai:button text="查询功能点" onclick="qryFunPointRela()" />
								<ai:button text="功能点相关" onclick="refreshTbl('${OPERATEPARAM.FUNPOINTOPERATE}')"/>
								<ai:button text="保存功能点" onclick="saveFunPointRela('${OPERATEPARAM.FUNPOINTOPERATE}')" />
							</td>
						</tr>
					</table>
					<ai:stable tableid="tblFunPointDisplay" setname="com.asiainfo.csc.meeting.web.SETDiscussOperate"
						height="200" width="100%" footdisplay="true" needrefresh="true" initial="false"
						invoke_type="service" invoke_name="com.asiainfo.csc.common.service.WorkorderSV"
						invoke_querymethod="qryOperate(String relaObjId,String opType)"
						editable="false" multiselect="true" rowheight="-1" pagesize="10" rowsequence="true"
						oncontextmenu="" ondbclick="" >
						<ai:col fieldname="OPERATE_ID" width="230" visible="false" />
						<ai:col fieldname="OPERATE_NAME"  width="100"  visible="true" />
						<ai:col fieldname="OPERATE_FUNC_NAME"  width="150"  visible="true" />
						<ai:col fieldname="OPERATE_TYPE_STR"  width="200"  visible="true" />
					</ai:stable>
				</div>
			</div>
			<div style="width: 50%;float: left;">
				<div style="height: 150px;"></div>
				<div style="height: 300px;">
					<table class="content_title" border="0">
						<tr>
							<td class="content_title_text">操作显示区</td>
						</tr>
					</table>
					<ai:stable tableid="tblOperate" setname="com.asiainfo.csc.meeting.web.SETDiscussOperate"
						height="200" width="100%" footdisplay="true" needrefresh="true" initial="false"
						invoke_type="service" invoke_name="com.asiainfo.csc.common.service.WorkorderSV"
						invoke_querymethod="getOperateByType(String opType)"
						editable="false" multiselect="true" rowheight="-1" pagesize="10" rowsequence="true"
						oncontextmenu="" ondbclick="" >
						<ai:col fieldname="OPERATE_ID" width="230" visible="false" />
						<ai:col fieldname="OPERATE_NAME"  width="100"  visible="true" />
						<ai:col fieldname="OPERATE_FUNC_NAME"  width="150"  visible="true" />
						<ai:col fieldname="OPERATE_TYPE_STR"  width="200"  visible="true" />
					</ai:stable>
				</div>
			</div>
		</div>
	</body>
	<script type="text/javascript">
		var tblOperate = g_TableRowSetManager.get("tblOperate");
		var tblDiscussDisplay = g_TableRowSetManager.get("tblDiscussDisplay");
		var tblFunPointDisplay = g_TableRowSetManager.get("tblFunPointDisplay");
		var boxCurStatus = g_getListBox("boxCurStatus");
		var boxFunPoint = g_getListBox("boxFunPoint");
		
		init();
		
		function init() {
			
		}
		
		function refreshTbl(opType) {
			tblOperate.refresh(null,"opType=" + opType);
		}
		
		function saveDiscussRela(opType) {
			var objId = boxCurStatus.getID();
			if(objId == "" || objId == null) {
				alert("未选择环节！");
				return;
			}
			var rowsNo = tblOperate.getSelectedRows();
			if(rowsNo == "") {
				if(!confirm("未选择行，是否确定删除当前配置？")) {
					return;
				}
			}
			var ids = "";
			for(var i = 0; i < rowsNo.length; i++) {
				ids += tblOperate.getValue(rowsNo[i],"OPERATE_ID") + ",";
			}
			ids += "0";
			var url = "<%=request.getContextPath()%>/business/com.asiainfo.csc.common.web.OrderAction?action=saveOrderOperateRelaAction&objId=" + objId + "&ids=" + ids + "&opType=" + opType;
			var list = new Array();
			list.push(tblOperate);
			var result = saveRowSet(url,list,true,false);
			var retVal = result.getValueByName("retVal");
			if(retVal == "Y") {
				alert("保存成功！");
				tblOperate.refresh(null,"opType=" + opType);
			} else if(retVal == "N") {
				alert("保存失败！");
			} else {
				alert("保存失败，出现异常！");
			}
			qryDiscussRela();
		}
		
		function saveFunPointRela(opType) {
			var objId = boxFunPoint.getID();
			if(objId == "" || objId == null) {
				alert("未选择功能点！");
				return;
			}
			var rowsNo = tblOperate.getSelectedRows();
			if(rowsNo == "") {
				if(!confirm("未选择行，是否确定删除当前配置？")) {
					return;
				}
			}
			var ids = "";
			for(var i = 0; i < rowsNo.length; i++) {
				ids += tblOperate.getValue(rowsNo[i],"OPERATE_ID") + ",";
			}
			ids += "0";
			var url = "<%=request.getContextPath()%>/business/com.asiainfo.csc.common.web.OrderAction?action=saveOrderOperateRelaAction&objId=" + objId + "&ids=" + ids + "&opType=" + opType;
			var list = new Array();
			list.push(tblOperate);
			var result = saveRowSet(url,list,true,false);
			var retVal = result.getValueByName("retVal");
			if(retVal == "Y") {
				alert("保存成功！");
				tblOperate.refresh(null,"opType=" + opType);
			} else if(retVal == "N") {
				alert("保存失败！");
			} else {
				alert("保存失败，出现异常！");
			}
			qryFunPointRela();
		}
		
		function qryDiscussRela() {
			var relaObjId = boxCurStatus.getID();
			var opType = "${OPERATEPARAM.DISCUSSOPERATE}";
			var condition = "relaObjId=" + relaObjId + "&opType=" + opType;
			tblDiscussDisplay.refresh(null,condition);
		}
		
		function qryFunPointRela() {
			var relaObjId = boxFunPoint.getID();
			var opType = "${OPERATEPARAM.FUNPOINTOPERATE}";
			var condition = "relaObjId=" + relaObjId + "&opType=" + opType;
			tblFunPointDisplay.refresh(null,condition);
		}
	 	
	</script>
</html>
