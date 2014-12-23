<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai" %>
<%@ include file="/workflow/workflow_css.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/jsv2/AppFrameCss.jsp" type="text/css">
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/TableRowSet.js"></script>
<%
com.ai.appframe2.privilege.UserInfoInterface user = com.ai.appframe2.common.SessionManager.getUser();
long userId = 1;
if(user != null){
 userId = user.getID();
}
%>
<html>
  <head>
  </head>
  
  <body>
  <fieldset>
  <legend>工作任务列表</legend>
  <div align="center">
	  员工编号:<input id="staffid" type="text" style="width:100" value="<%= userId%>"/>
	  岗位(请以;号隔开):<input id="stationid" type="text" style="width:200" />
	  流程编码:<input id="txtWorkflowCode" type="text" style="width:150" />
	  任务编码:<input id="txtTaskTag" type="text" style="width:150" />
	  <ai:button id="btnQry" text="查  询" onclick="qry()"/>
  </div>
  <ul>
  
    <ai:table  tableid="TaskList" setname="com.ai.appframe2.vm.db.TaskView"
			    tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
			    implservice_name="com.ai.comframe.console.WorkflowConsole"
			    implservice_querymethod="getTaskLists(String stations,String staffId,String workflowTemplateCode,String taskTag)"
			    needrefresh="true" multiselect="false" editable="false"  
			    rowheight="-1" initial="false" width="100%" height="300" footdisplay="none" rowsequence="true">
			    <ai:col fieldname="WORKFLOW_NAME" width="100"/>
			    <ai:col fieldname="WORKFLOW_OBJECT_ID" width="150"/>
			    <ai:col fieldname="TASK_ID" width="80"/>
			    <ai:col fieldname="LABEL" width="200"/>
			  	<ai:col fieldname="CREATE_DATE" width="200"/>
			  	<ai:col fieldname="WORKFLOW_CREATE_DATE" width="200"/>
				<ai:col fieldname="WORKFLOW_ID" visible="false"/>
				</ai:table>
				<br>
				<input type="textarea" id = "reason" value="同意" rows="5">
				<ai:button text="同意" id="add"  enable="true" onclick="finish('S')"/>
				<ai:button text="监测" id="edit"  enable="true" onclick="monitor()"/>
				<ai:button text="失败" id="delete"  enable="true" onclick="finish('F')"/>
				<ai:button text="暂缓" id="save"  enable="true" onclick="finish('P')"/>
				<ai:button text="取消" id="save"  enable="true" onclick="finish('D')"/>

	</ul>
	
  </body>
</html>

<SCRIPT LANGUAGE="JavaScript" >
function getTable(){
	return g_TableRowSetManager.get("TaskList");
}
function qry(){
  var staffid=document.all("staffid").value;
  if(staffid == ""){
	  alert("请输入员工编号!");
	  document.all("staffid").focus();
	  return;
	}
	var stationid=document.all("stationid").value;
	var workflowCode = document.all.txtWorkflowCode.value;
	var taskTag = document.all.txtTaskTag.value;
	getTable().refresh("stations="+stationid+"&staffId="+staffid+"&workflowTemplateCode="+workflowCode+"&taskTag="+taskTag);
}
function monitor(){
	if(getTable().getRow()==-1){
		alert("请选择任务!");
		return;
	}
  var a=getTable().getValue(getTable().getRow(),"WORKFLOW_ID");
  window.showModalDialog("WorkflowHandle.jsp?WORKFLOW_ID=" + a,null,'status:no;dialogWidth:650px;dialogHeight:650px');
 
}

function finish(result){
 var staffId = document.all("staffid").value;
 if(staffId == ""){
   staffId = "<%=userId%>";
 }
  
 //S--成功，F--失败，P--停止工作流，D--删除工作流
 var row = getTable().getRow();
 if(row < 0){
   alert("请选择要处理的任务!");
   return;
 }
 var taskId = getTable().getValue(row,"TASK_ID");
 var reason = document.all("reason").value;
 var url = "<%=request.getContextPath()%>/business/com.ai.appframe2.vm.web.UserTaskServlet?action=finish&staff_id=" +staffId +"&taskid=" + taskId + "&result=" + result + "&reason=" + reason;
 var xmlString  =  "";
 var result = PostInfotoServer(url,xmlString);
 alert(result);
 window.location = window.location;
}
</SCRIPT>