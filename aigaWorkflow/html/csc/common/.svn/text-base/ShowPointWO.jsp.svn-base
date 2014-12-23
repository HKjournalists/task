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
  <div id="aialm_funcpoint_query_div" class="div_title" style="padding-bottom: 7px;margin-top: 0px; border-style:none; border-bottom: 1px solid #dae4ee">
	<table class="content_title" border="0">
		<tr>
			<td class="content_title_text">正在牵头的功能点</td>
			<td align="right">
				<input name="keyword" id="keyword" type="text" style="display: none; width: <%=aiEdit_3cw%>" onKeyUp="showHint(this.value)">
				<ai:button id="bt_qry" text="功能点查询" onclick="qryFuncPointOrder()" />
			</td>
		</tr>
	</table>
	<ai:dbform formid="queryFuncPointFormOrder" setname="com.asiainfo.csc.funcPoint.web.SETAlmQueryPointOrder" initial="false" editable="true">
		<table align="left" width="960" id="func_point_info">
			<tr>
				<td class="title_e">功能点名称：</td>
				<td> <ai:dbformfield fieldname="FUN_POINT_NAME" formid="queryFuncPointFormOrder" editable="true" width="<%=aiEdit_2cw%>" /> </td>
				<td class="title_e">功能点负责人： </td>
				<td> <ai:dbformfield fieldname="FP_STAFF_NAME" formid="queryFuncPointFormOrder" editable="true" width="<%=aiEdit_2cw%>" /> </td>
				<td class="title_e">所在环节：</td>
				<td > <ai:dbformfield fieldname="CUR_STATUS" formid="queryFuncPointFormOrder" editable="true" width="<%=aiEdit_2cw%>" /> </td>
				<td class="title_e">原始需求信息：</td>
				<td > <ai:dbformfield fieldname="BUSI_LEADER_PHONE" formid="queryFuncPointFormOrder" editable="true" width="<%=aiEdit_2cw%>" /> </td>
			</tr>
		</table>
	</ai:dbform>
</div>
  <div class="div_title" style="margin-top: 0px;border-style: none;">
    <ai:stable tableid="pointShowWorkorder" setname="com.asiainfo.csc.common.web.SETWorkorderList" 
    	invoke_name="com.asiainfo.csc.common.service.WorkorderSV"
    	invoke_querymethod="queryDoWorkorderList(long staffId,String status,int $STARTROWINDEX,int $ENDROWINDEX)" 
    	rowheight="-1" footdisplay="none" needrefresh="true" initial="false" 
    	invoke_type="service" editable="false" pagesize="" height="180" width="100%"
    	ondbclick="pointShowWorkorderFunc" multiselect="false" rowsequence="true">
    	<ai:col fieldname="ORDER_ID" visible="false"/>
    	<ai:col fieldname="OBJ_ID" visible="false"/>
    	<ai:col fieldname="EXEC_STAFF_ID" visible="false"/>
    	<ai:col fieldname="LINK_NO" visible="false"/>
    	<ai:col fieldname="OBJ_TAG" width="150" visible="true"/>
    	<ai:col fieldname="OBJ_NAME" width="200" visible="true"/>
    	<ai:col fieldname="ORDER_TYPE" width="90" visible="true"/>
    	<ai:col fieldname="VM_TASK_NAME" width="130" visible="true"/>
    	<ai:col fieldname="OBJ_TYPE" width="80" visible="true"/>
    	<ai:col fieldname="CREATE_BEGIN_TIME" width="130" visible="true"/>
    	<ai:col fieldname="STATUS" width="80" visible="true"/>
    	<ai:col fieldname="SUBMIT_STAFF_NAME" width="80" visible="true"/>
    	<ai:col fieldname="TEMPLATE_ID" visible="false"/>
    </ai:stable>
   
  </div>
   
  </body>
  <script type="text/javascript">
  var pointShowWorkorder = g_TableRowSetManager.get("pointShowWorkorder");
  var pointFormOrder = g_FormRowSetManager.get("queryFuncPointFormOrder");
  
  function pointShowWorkorderFunc()
  {
  	var rowIndex = pointShowWorkorder.getRow();
 	var orderId = pointShowWorkorder.getValue(rowIndex,"ORDER_ID");
 	var orderType = pointShowWorkorder.getValue(rowIndex,"ORDER_TYPE");
 	var objId = pointShowWorkorder.getValue(rowIndex,"OBJ_ID");
 	var linkNo = pointShowWorkorder.getValue(rowIndex,"LINK_NO");
 	var objTag = pointShowWorkorder.getValue(rowIndex,"OBJ_TAG");
 	var objName = pointShowWorkorder.getValue(rowIndex,"OBJ_NAME");
 	var objType = pointShowWorkorder.getValue(rowIndex,"OBJ_TYPE");
 	var templateId = pointShowWorkorder.getValue(rowIndex,"TEMPLATE_ID");
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
 		case "1":
	 		if(orderType=="5"){
	 			window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/csc/req/busiSupport/SubmitterResponse.jsp?orderId="+orderId +"&objId="+objId+"&linkNo="+linkNo+"&templateId="+templateId,"true",1);
	 			window.parent.setTabItemLen("tab1",tabItemId,150);
	 		}else{
		 		window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/business/com.asiainfo.csc.req.web.FuncAction?action=requestDispatcher&orderId="+orderId +"&objId="+objId+"&linkNo="+linkNo+"&objType="+objType+"&objName="+objName+"&templateId="+templateId,"true",1);
		 		window.parent.setTabItemLen("tab1",tabItemId,150);
	 		}
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
 		window.parent.openNewTabItem("tab1",tabItemId,tabName,"<%=request.getContextPath()%>/business/com.asiainfo.csc.version.web.VersionAction?action=requestDispatcher&orderId="+orderId +"&objId="+objId+"&linkNo="+linkNo,"true",1);
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
 		default:
 		break;
 	}
  }
  
			
  function qryFuncPointOrder(){
  	var pointName = pointFormOrder.getValue("FUN_POINT_NAME");
  	var staffName = pointFormOrder.getValue("FP_STAFF_NAME");
  	var status = pointFormOrder.getValue("CUR_STATUS");
  	var reqName = pointFormOrder.getValue("BUSI_LEADER_PHONE");
  	var condtion = "pointName="+pointName+"&staffName="+staffName+"&status="+status+"&reqName="+reqName ;
  	pointShowWorkorder.refresh(null,condtion);
  }
  
  function showPointorderList()
  {
    pointShowWorkorder.refresh(null,"staffId=${userInfo.ID}&status=1");
  	//doneOrder.refresh(null,"staffId=${userInfo.ID}&status=3");
  }
  
  </script>
</html>
