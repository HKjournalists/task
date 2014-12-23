<%@ page language="java" import="java.util.*" pageEncoding="gbk"%> 
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai" %>
<%@ include file="/workflow/workflow_css.jsp"%>
<script language="javascript" src="<%=request.getContextPath()%>/jsv2/Globe_v2.jsp" type="text/javascript"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/jsv2/AppFrameCss.jsp" type="text/css">
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%String workflowId =request.getParameter("workflowId");
  String templateCode = request.getParameter("templateCode");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>流程图</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body onload="init()" scroll="yes">
  	<div id="graphDiv" align="center"></div>
  	<br>
  	<div id="btnDiv" align="right" style="display:none"><ai:button text="返  回" onclick="goBack()"/></div>
  	<table id="tblParam" width="100%" align="center" border="0">
		  <tr><td align="center" > 
		    <fieldset style="width:580;text-align:center;font-size:12">
		      <legend class="FormZName">参数列表</legend>
		        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
		        <tr><td>
		           <ai:table tableid="varTable" initial="true" setname="com.ai.comframe.console.action.SETServerInfo" 
		                    tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
		                    implservice_name="com.ai.comframe.console.WorkflowConsole"
		                    implservice_querymethod="getWorkflowInstVars(long workflowId,String templateCode)"
		              width="100%" height="150" pagesize="100" needrefresh="true" multiselect="false" editable="true">
								<ai:col fieldname="NAME" width="165" visible="true" editable="false"/>
								<ai:col fieldname="TYPE" width="165" visible="true" editable="false"/>
								<ai:col fieldname="VALUE" width="165" visible="true" editable="true"/>
		        </ai:table>
		      </td></tr>
		      </table>
		    </fieldset>
		  </td></tr>
		</table>
  </body>
</html>
<script type="text/javascript">
var currentWorkflowId = "";

function init(){
  document.all("graphDiv").innerHTML ="";
	var workflowId="<%=workflowId %>";
   var url = "<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?";
   url += "action=workflowInst2Svg&workflow_id=" + workflowId;
   currentWorkflowId = workflowId;
   showSVG(url);
}

function showParentSVG(parentWorkflowId){
  var url = "<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?"
		      + "action=workflowInst2Svg&workflow_id="+parentWorkflowId;
  currentWorkflowId = parentWorkflowId;
	showSVG(url);
	document.all.btnDiv.style.display = "block";
	document.all.tblParam.style.display = "none";
}

function onSvgClick(param1,param2){
  if(param1 == null){
    alert("请单击回退到的任务节点!");
    return;
  }
  if(currentWorkflowId != "<%=workflowId %>"){
//    alert("不能回退到父任务!");
    return;
  }
  if(confirm("确认回退到任务:"+param2+"?")){
    var taskTemplateId = param1;
    
    var varTable = g_TableRowSetManager.get("varTable");
	  var count = varTable.count();
	  var vars = "";
	  for(var i=0;i<count;i++){
	    var name = varTable.getValue(i,"NAME");
	    var value = varTable.getValue(i,"VALUE");
	    vars += name+":"+value+"#";
	  }
    window.returnValue = taskTemplateId + "$$" + vars;
    window.close();
  }
}

function showSVG(url){
  document.all("graphDiv").innerHTML ="";
	var s = "<object type='image/svg+xml' width='650' height='500'>"
                          + "<param name='src' value='" + url + "'/>"
                          + "</object>";
  document.all("graphDiv").innerHTML = s;
}

function goBack(){
  init();
	document.all.btnDiv.style.display = "none";
	document.all.tblParam.style.display = "block";
}
</script>
