<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.asiainfo.csc.matrix.common.ConstDefine"%>
<%@ include file="/csc/common/taglib.jsp" %>

<%
	request.setAttribute("userInfo", g_GetUserInfo());
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>工单列表</title>
    <style type="text/css">
    	.div_title div .G-TableOuterDiv { border:none;}
    </style>
  </head>
  <body>
  <div id="waitDiv" class="div_title" style="display:none;" >
 	<table class="content_title" border="0" width="100%">
		<tr>
			<td class="content_title_text" width="72">待处理工单</td>
			<td class="title_e">项目组：</td>
			<td align="left" valign="top">
				<ai:listbox id="userGroupList" ds="com.asiainfo.aialmJT.testWF.web.DSUserGroup" nullid="" nulltext="全部" onchange="changeToDo" width="<%=aiEdit_3cw %>"/>
			</td>
		</tr>
 	</table>
    <ai:stable tableid="waitWorkorder" setname="com.asiainfo.csc.common.web.SETWorkorderListForTree" 
    	invoke_name="com.asiainfo.csc.common.service.WorkorderSV"
    	invoke_querymethod="getDoWorkorderListTree(String userGroup,long staffId,String status,int $STARTROWINDEX,int $ENDROWINDEX)" 
    	rowheight="-1" footdisplay="none" needrefresh="true" initial="false" 
    	invoke_type="service" editable="false" pagesize="" height="400" width="100%"
    	ondbclick="waitWorkOrderFunc" multiselect="false" rowsequence="true">
    	<ai:col fieldname="ORDER_ID" visible="false"/>
    	<ai:col fieldname="OBJ_ID" visible="false"/>
    	<ai:col fieldname="EXEC_STAFF_ID" visible="false"/>
    	<ai:col fieldname="LINK_NO" visible="false"/>
    	<ai:col fieldname="OBJ_TAG" width="180" visible="true"/>
    	<ai:col fieldname="OBJ_NAME" width="200" visible="true"/>
    	<ai:col fieldname="ORDER_TYPE" width="90" visible="true"/>
    	<ai:col fieldname="VM_TASK_NAME" width="130" visible="true"/>
    	<ai:col fieldname="OBJ_TYPE" width="80" visible="true"/>
    	<ai:col fieldname="CREATE_BEGIN_TIME" width="130" visible="true"/>
    	<ai:col fieldname="STATUS" width="80" visible="true"/>
    	<ai:col fieldname="SUBMIT_STAFF_NAME" width="80" visible="true"/>
    	<ai:col fieldname="USERGROUP_ID" width="120" visible="true"/>
    	<ai:col fieldname="TEMPLATE_ID" visible="false"/>
    </ai:stable>
   
  </div>
   
  <div class="div_title" style="display: none;">
 	<table class="content_title" border="0" width="100%">
		<tr>
			<td class="content_title_text">已处理工单</td>
		</tr>
 	</table>
	<table width="100%" align="center" border="0" class="table_v">
	<tr><td width="100%">
    <ai:stable tableid="doneWorkorder" setname="com.asiainfo.csc.common.web.SETWorkorderList" 
    	invoke_name="com.asiainfo.csc.common.service.WorkorderSV"
    	invoke_querymethod="queryWorkorderList(long staffId,String status,int $STARTROWINDEX,int $ENDROWINDEX)" 
    	invoke_countmethod="countWorkorderList(long staffId,String status)"
    	rowheight="-1" needrefresh="true" initial="false" footdisplay="true" 
    	invoke_type="service" editable="false" pagesize="20" height="160" width="100%" rowsequence="true"
    	ondbclick="doneWorkOrderFunc" multiselect="false" >
    	<ai:col fieldname="ORDER_ID" visible="false"/>
    	<ai:col fieldname="OBJ_ID" visible="false"/>
    	<ai:col fieldname="EXEC_STAFF_ID" visible="false"/>
    	<ai:col fieldname="LINK_NO" visible="false"/>
    	<ai:col fieldname="COND" visible="false"/>
    	
    	<ai:col fieldname="OBJ_TAG" width="150" visible="true"/>
    	<ai:col fieldname="OBJ_NAME" width="200" visible="true"/>
    	<ai:col fieldname="ORDER_TYPE" width="90" visible="true"/>
    	<ai:col fieldname="VM_TASK_NAME" width="130" visible="true"/>
    	<ai:col fieldname="OBJ_TYPE" width="80" visible="true"/>
    	<ai:col fieldname="FINISH_TIME" width="130" visible="true"/>
    	<ai:col fieldname="STATUS" width="80" visible="true"/>
    	<ai:col fieldname="SUBMIT_STAFF_NAME" width="80" visible="true"/>
    	<ai:col fieldname="APPLY_STAFF_NAME" width="80" visible="true"/>
    </ai:stable>
   
    </td></tr>
	</table>
  </div>

  </body>
  <script type="text/javascript">
  var waitOrder = g_TableRowSetManager.get("waitWorkorder");
  var doneOrder = g_TableRowSetManager.get("doneWorkorder");
  showWorkorderList();
  
  function changeToDo() {
		var groupVal = userGroupList.getID();
		showWorkorderList(groupVal);
	}
  
  function waitWorkOrderFunc()
  {
  	var rowIndex = waitOrder.getRow();
 	var orderId = waitOrder.getValue(rowIndex,"ORDER_ID");
 	var orderType = waitOrder.getValue(rowIndex,"ORDER_TYPE");
 	var objId = waitOrder.getValue(rowIndex,"OBJ_ID");
 	var linkNo = waitOrder.getValue(rowIndex,"LINK_NO");
 	var objTag = waitOrder.getValue(rowIndex,"OBJ_TAG");
 	var objName = waitOrder.getValue(rowIndex,"OBJ_NAME");
 	var objType = waitOrder.getValue(rowIndex,"OBJ_TYPE");
 	var templateId = waitOrder.getValue(rowIndex,"TEMPLATE_ID");
 	var tabItemId = orderId;
 	var tabName=objTag;
 	if(tabName.length>20){
 		tabName=tabName.slice(0,15)+"...";
 	}
 	var index = window.parent.getTabItemIdxsByTabItemId("tab1",tabItemId);
 	if(index!=''){
 		window.parent.setTabItem("tab1", tabItemId);
 		return;
 	}
 	switch(objType)
 	{
 	/*	case "1":
	 		if(orderType=="5"){
	 			window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/csc/req/busiSupport/SubmitterResponse.jsp?orderId="+orderId +"&objId="+objId+"&linkNo="+linkNo+"&templateId="+templateId,"true",1);
	 			window.parent.setTabItemLen("tab1",tabItemId,150);
	 		}else{
		 		window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/business/com.asiainfo.csc.req.web.FuncAction?action=requestDispatcher&orderId="+orderId +"&objId="+objId+"&linkNo="+linkNo+"&objType="+objType+"&objName="+objName+"&templateId="+templateId,"true",1);
		 		window.parent.setTabItemLen("tab1",tabItemId,150);
	 		}*/
	 	case "1":
		 	window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/business/com.asiainfo.aialmJT.testWF.web.AlmRequisitionAction?action=requestDispatcher&orderId="+orderId +"&objId="+objId+"&linkNo="+linkNo+"&objType="+objType+"&objName="+objName+"&templateId="+templateId,"true",1);
		 	window.parent.setTabItemLen("tab1",tabItemId,150);
 		break;
 		
 		case "2":
 		window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/business/com.asiainfo.csc.funcPoint.web.FuncPointAction?action=requestDispatcher&orderId="+orderId +"&objId="+objId+"&linkNo="+linkNo+"&objType="+objType+"&objName="+objName,"true",1);
 		window.parent.setTabItemLen("tab1",tabItemId,150);
 		break;	
 	
 		case "3":
 		window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/business/com.asiainfo.csc.funcPoint.web.FuncPointAction?action=requestDispatcher&orderId="+orderId +"&objId="+objId+"&linkNo="+linkNo+"&objType="+objType,"true",1);
 		window.parent.setTabItemLen("tab1",tabItemId,150);
 		break;
 		
 		case "4":
 		//window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/business/com.asiainfo.csc.version.web.VersionAction?action=requestDispatcher&orderId="+orderId +"&objId="+objId+"&linkNo="+linkNo,"true",1);
 		//window.parent.setTabItemLen("tab1",tabItemId,150);
 		window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/business/com.asiainfo.aialmJT.versionWF.web.AlmVerAction?action=requestDispatcher&orderId="+orderId +"&objId="+objId+"&linkNo="+linkNo+"&objType="+objType,"true",1);
 		window.parent.setTabItemLen("tab1",tabItemId,150);
 		break;
 		
 		case "5":
 		window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/business/com.asiainfo.csc.funcPoint.web.FuncPointAction?action=requestDispatcher&orderId="+orderId +"&objId="+objId+"&linkNo="+linkNo,"true",1);
 		window.parent.setTabItemLen("tab1",tabItemId,150);
 		break;
 		
 		case "6":
 		window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/business/com.asiainfo.csc.product.web.ProductAction?action=requestDispatcher&orderId="+orderId +"&objId="+objId+"&linkNo="+linkNo,"true",1);
 		window.parent.setTabItemLen("tab1",tabItemId,150);
 		break;
 		
 		case "8":
 		window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/business/com.asiainfo.aialmJT.resource.web.ApplyAction?action=requestDispatcher&orderId="+orderId +"&objId="+objId+"&linkNo="+linkNo,"true",1);
 		window.parent.setTabItemLen("tab1",tabItemId,150);
 		break;
 		
 		
 		case "9":
 		window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/business/com.asiainfo.csc.dutyProblem.web.DutyProblemAction?action=requestDispatcher&orderId="+orderId +"&objId="+objId+"&linkNo="+linkNo,"true",1);
 		window.parent.setTabItemLen("tab1",tabItemId,150);
 		break;
 		
 		case "10":
 		window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/business/com.asiainfo.csc.subReq.web.SubReqAction?action=requestDispatcher&orderId="+orderId +"&objId="+objId+"&linkNo="+linkNo,"true",1);
 		window.parent.setTabItemLen("tab1",tabItemId,150);
 		break;
 		
 		case "11":
 		window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/business/com.asiainfo.csc.staffTrain.web.StaffTrainAction?action=requestDispatcher&orderId="+orderId +"&objId="+objId+"&linkNo="+linkNo,"true",1);
 		window.parent.setTabItemLen("tab1",tabItemId,150);
 		break;
 		
 		case "12":
 		window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/business/com.asiainfo.csc.funcPoint.web.FuncPointAction?action=requestDispatcher&orderId="+orderId +"&objId="+objId+"&linkNo="+linkNo+"&objType="+objType,"true",1);
 		window.parent.setTabItemLen("tab1",tabItemId,150);
 		break;
 		
 		case "20":
 		window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/csc/common/ReceiveOrder.jsp?orderId="+orderId +"&objId="+objId+"&linkNo="+linkNo,"true",1);
 		window.parent.setTabItemLen("tab1",tabItemId,150);
 		break;
 		
 		case "22":
 		window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/business/com.asiainfo.csc.templateWorkflow.web.WorkflowTemplateAction?action=requestDispatcher&orderId="+orderId +"&objId="+objId+"&linkNo="+linkNo+"&objType="+objType,"true",1);
 		window.parent.setTabItemLen("tab1",tabItemId,150);
 		break;
 		default:
 		break;
 	}
  }
  
  function doneWorkOrderFunc()
  {
  	var rowIndex = doneOrder.getRow();
  	var orderId = doneOrder.getValue(rowIndex,"ORDER_ID");
 	var objId = doneOrder.getValue(rowIndex,"OBJ_ID");
 	var linkNo = doneOrder.getValue(rowIndex,"LINK_NO");
 	var objTag = doneOrder.getValue(rowIndex,"OBJ_TAG");
 	var objName = doneOrder.getValue(rowIndex,"OBJ_NAME");
  	var objType = doneOrder.getValue(rowIndex,"OBJ_TYPE");
 	var cond = doneOrder.getValue(rowIndex,"COND");
 	var tabItemId = orderId;
 	
 	cond = cond.replace(/\"/g,"!");
 	cond = cond + "";
  	var tabName=objTag;
 	if(tabName.length>20){
 		tabName=tabName.slice(0,15)+"...";
 	}
 	var index = window.parent.getTabItemIdxsByTabItemId("tab1",tabItemId);
 	if(index!=''){
 		window.parent.setTabItem("tab1", tabItemId);
 		return;
 	}
 	
 	if(objType == 1)
 	{
 		window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/csc/req/branch/DoneWorkOrderList.jsp?orderId="+orderId +"&objId="+objId +"&linkNo="+linkNo+"&objType="+objType+"&cond="+cond,"true",1);
 		window.parent.setTabItemLen("tab1",tabItemId,150);
 	}
 	if(objType == '2')
 	{
 		window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/csc/viewPages/ViewWOSubReq.jsp?orderId="+orderId +"&objId="+objId +"&linkNo="+linkNo,"true",1);
 		window.parent.setTabItemLen("tab1",tabItemId,150);
 	}
  	if(objType == "3")
 	{
 		window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/csc/req/branch/DoneFunPointWO.jsp?orderId="+orderId +"&funPointId="+objId +"&linkNo="+linkNo+"&objType="+objType+"&cond="+cond,"true",1);
 		window.parent.setTabItemLen("tab1",tabItemId,150);
 	}
 	if(objType == "4")
 	{
 		window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/csc/viewPages/ViewWOVer.jsp?orderId="+orderId +"&objId="+objId +"&linkNo="+linkNo,"true",1);
 		window.parent.setTabItemLen("tab1",tabItemId,150);
 	}
 	if(objType == "5")
 	{
 		window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/csc/viewPages/ViewStatements.jsp?orderId="+orderId +"&objId="+objId +"&linkNo="+linkNo,"true",1);
 		window.parent.setTabItemLen("tab1",tabItemId,150);
 	}
 	if(objType == "9")
 	{
 		window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/csc/viewPages/ViewWODP.jsp?orderId="+orderId +"&objId="+objId +"&linkNo="+linkNo,"true",1);
 		window.parent.setTabItemLen("tab1",tabItemId,150);
 	}
 	if(objType == "10")
 	{
 		window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/csc/viewPages/ViewWOSubReq.jsp?orderId="+orderId +"&objId="+objId +"&linkNo="+linkNo,"true",1);
 		window.parent.setTabItemLen("tab1",tabItemId,150);
 	}
 	if(objType == "11")
 	{
 		window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/csc/viewPages/ViewWOST.jsp?orderId="+orderId +"&objId="+objId +"&linkNo="+linkNo,"true",1);
 		window.parent.setTabItemLen("tab1",tabItemId,150);
 	}
 	if(objType == "12") {
 		window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/business/com.asiainfo.csc.funcPoint.web.FuncPointAction?action=requestDispatcher&orderId="+orderId +"&objId="+objId+"&linkNo="+linkNo+"&objType="+objType+"&isOver="+1,"true",1);
 		window.parent.setTabItemLen("tab1",tabItemId,150);
 	}
 	if(objType == "17") {
 		window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/business/com.asiainfo.csc.templateWorkflow.web.WorkflowTemplateAction?action=requestDispatcher&orderId="+orderId +"&objId="+objId+"&linkNo="+linkNo+"&objType="+objType,"true",1);
 		window.parent.setTabItemLen("tab1",tabItemId,150);
 	}
 	//需求
	//public static final String REQUISITION = "1";

	//版本
	//public static final String VERSION = "4";

	//值班问题管理
	//public static final String DUTYPROBLEM = "9";
	
	//子需求
	//public static final String SUBREQ = "10";
	
	//员工培训管理
	//public static final String STAFFTRAIN = "11";
 	
 	
  }
  
  function showWorkorderList(userGroup)
  {
  	if(userGroup == null) {
  		userGroup = "";
  	}
    waitOrder.refresh(null,"staffId=${userInfo.ID}&userGroup="+userGroup);
  	document.getElementById("waitDiv").style.display = "block";
  	document.getElementById("TableDiv_waitWorkorder").style.height = "400px";
    /*
  	*/
  	
  	//doneOrder.refresh(null,"staffId=${userInfo.ID}&status=3");
  }
  
  function upTree() {
  	var img = event.srcElement;
  	img.src = "<%=request.getContextPath()%>/csc/images/icon_show.gif";
  	img.onclick = function(){downTree()};
  	var list = new Array();
  	for(var i = 0; i < waitOrder.count(); i++){
	 	list.push(i);
	 }
	 for(var i = 0; i < waitOrder.count(); i++){
 		waitOrder.close(i,list,true);
		waitOrder.reDrawTreeCellByField(i,true,"OBJ_TAG");
	 }
  }
  
  function downTree() {
  	var img = event.srcElement;
  	img.src = "<%=request.getContextPath()%>/csc/images/icon_hide.gif";
  	img.onclick = function(){upTree()};
  	var list = new Array();
  	for(var i = 0; i < waitOrder.count(); i++){
	 	list.push(i);
	 }
	 for(var i = 0; i < waitOrder.count(); i++){
 		waitOrder.open(i,list,true);
		waitOrder.reDrawTreeCellByField(i,true,"OBJ_TAG");
	 }
  }
  
  </script>
  
<script type="text/javascript">//<!--
 var runOnLoad = new Array(); // for queuing multiple onLoad event functions
 window.onload = function() { for(var i=0; i<runOnLoad.length; i++) runOnLoad[i]() }
 // hide dotted :focus outlines when mouse is used
 // but NOT when tab key is used
 if(document.getElementsByTagName)
 for(var i in a = document.getElementsByTagName('INPUT')) {
   a[i].onmousedown = function() {
     this.blur(); // most browsers
     this.hideFocus = true; // ie
     this.style.outline = 'none'; // mozilla
   }
   a[i].onmouseout = a[i].onmouseup = function() {
     this.blur(); // most browsers
     this.hideFocus = false; // ie
     this.style.outline = 'none'; // mozilla
   }
 }
 //--></script>
 
</html>
