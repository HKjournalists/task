<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai" %>

<link rel="stylesheet" href="<%=request.getContextPath()%>/jsv2/AppFrameCss.jsp" type="text/css">
<%@ include file="/workflow/workflow_css.jsp"%>

<html>
<head>
  <title>调度信息</title>
</head>
<% 
String rmiurl = (String)request.getParameter("rmiurl");
String type = (String)request.getParameter("item");

String queryMethod = "getQueueScheduleInfo(String rmiUrl)";
if(type.equals("workflow")){
  queryMethod = "getWorkflowScheduleInfo(String rmiUrl)";
}
String initCond = "rmiUrl="+rmiurl;
request.setAttribute("initCond",initCond);
%>
<body onload="init()">
<table align="center" width="90%">
<tr><td>
  <fieldset style="text-align:left;font-size:12">
    <legend class="FormZName">调度信息</legend>
    <ai:table  tableid="tblSchedule" setname="com.ai.comframe.console.action.SETServerInfo"
	    tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
	    implservice_name="com.ai.comframe.console.WorkflowServerMonitor"
	    implservice_querymethod="<%=queryMethod %>"
	    conditionname="initCond" rowsequence="false" needrefresh="true"
	    rowheight="-1" initial="true" editable="true" width="900" height="420" footdisplay="none">
	  <ai:col edittype="DBTree" fieldname="NAME" width="230" editable="false" />
	  <ai:col fieldname="TYPE" width="200" editable="false" />
	  <ai:col fieldname="ACCESS" width="80" editable="false" />
	  <ai:col fieldname="VALUE" width="600"/>
	  <ai:col fieldname="QUEUE_ID" visible="false"/>
	  <ai:col fieldname="SET_METHOD" visible="false"/>
	</ai:table>
  </fieldset>
</td></tr>
<tr><td align="center">
  <ai:button text="新增队列" onclick="addQueue()"/>&nbsp;&nbsp;
  <ai:button text="刷新表格" onclick="refreshTable()"/>
</td></tr>
</table>
</body>

<script language="javascript">

function getTable(){
  return g_TableRowSetManager.get("tblSchedule");
}

function init(){
  var count = getTable().count();
  for(var i=0;i<count;i++){
    var access = getTable().getValue(i,"ACCESS");
    if(access != "是"){
      getTable().setCellEditSts(i,"VALUE",false);
    }
  }
}

function addQueue(){
  var args = window.showModalDialog("VmQueueNew.jsp",null,"resizable:no;status:no;help:no;dialogHeight:250px;dialogWidth:400px");
	if(args == null){
	  return;
	}
  var param = "rmiUrl=<%=rmiurl%>&queueType=<%=type%>&"+args;
  var msg = PostInfo(_gModuleName+"/business/com.ai.comframe.console.action.WorkflowAction?action=createNewQueue&"+param,"");
  var flag=msg.getValueByName("FLAG");
  alert(msg.getValueByName("MESSAGE"));
  if(flag=="INFO"){
	  refreshTable();
	  init();
  }
}

function refreshTable(){
  getTable().refresh("rmiUrl=<%=rmiurl%>");
}

function startSchedule(beanName){
  if(beanName == null || beanName.length == 0){
    alert("beanName为空!");
    return;
  }
  if(!confirm("确定启动?")){
    return;
  }
  var param = "rmiUrl=<%=rmiurl%>&queueType=<%=type%>&beanName="+beanName;
  var msg = PostInfo(_gModuleName+"/business/com.ai.comframe.console.action.WorkflowAction?action=startSchedule&"+param,"");
  var flag=msg.getValueByName("FLAG");
  alert(msg.getValueByName("MESSAGE"));
  if(flag=="INFO"){
	refreshTable();
	init();
  }
}

function stop(beanName){
  if(beanName == null || beanName.length == 0){
    alert("beanName为空!");
    return;
  }
  if(!confirm("确定停止?")){
    return;
  }
  var param = "rmiUrl=<%=rmiurl%>&queueType=<%=type%>&beanName="+beanName;
  var msg = PostInfo(_gModuleName+"/business/com.ai.comframe.console.action.WorkflowAction?action=stopSchedule&"+param,"");
  var flag=msg.getValueByName("FLAG");
  alert(msg.getValueByName("MESSAGE"));
  if(flag=="INFO"){
	refreshTable();
	init();
  }
}

function reset(beanName){
  if(beanName == null || beanName.length == 0){
    alert("beanName为空!");
    return;
  }
  var list = new Array();
  for(var i=0;i<getTable().count();i++){
    var queueId = getTable().getValue(i,"QUEUE_ID");
    if(queueId != null && queueId == beanName){
      if(getTable().getRowSts(i) == "U"){
        list.push(i);
      }
    }
  }
  if(list.length == 0){
    alert("未修改数据!");
    return;
  }
  if(!confirm("确定修改?")){
    return;
  }
  var xml = "<RootInfo>" + getTable().toXmlStringOfRows(list) + "</RootInfo>";
  var param = "rmiUrl=<%=rmiurl%>&queueType=<%=type%>&beanName="+beanName;
  var msg = PostInfo(_gModuleName+"/business/com.ai.comframe.console.action.WorkflowAction?action=reset&"+param,xml);
  var flag=msg.getValueByName("FLAG");
  alert(msg.getValueByName("MESSAGE"));
  if(flag=="INFO"){
	refreshTable();
	init();
  }
}
</script>
