<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai" %>
<%@ include file="/workflow/workflow_css.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/jsv2/AppFrameCss.jsp" type="text/css">
<script language="javascript" src="<%=request.getContextPath()%>/jsv2/Globe_v2.jsp" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/jsv2/CommUtil.js" type="text/javascript"></script>
<html>
<head>
  <title>工作流统计图</title>
</head>

<body onload="init()">
  <table align="center" width="100%">
    <tr><td id="treeTD" width="100%" height="100%" valign="top">
      <fieldset style="width:98%;text-align:left;font-size:12">
        <legend class="FormZName">条件</legend>
        流程模板:<ai:listbox id="lbxTag" ds="com.ai.comframe.console.DSAllWorkflowTemplate" width="300" nullid="-1" nulltext="" />
        &nbsp;&nbsp;流程类型:<ai:listbox id="lbxObjType" ds="com.ai.comframe.console.DSStaticData" parameters='<%="codeType="+com.ai.appframe2.vm.common.Constant.STATIC_DATA_WORKFLOW_OBJTYPE %>' width="100" nullid="-1" nulltext=""/>
        &nbsp;&nbsp;数据源:<ai:listbox id="lbxDataSource" ds="com.ai.comframe.console.DSDataSource" width="150"/><br>
        统计类型:<ai:listbox id="lbxType" ds="com.ai.comframe.console.DSWorkflowPeriodType" width="50"/>
        &nbsp;&nbsp;统计时间:<input name="txtStartDate" type="text" class="dbform_dbdate_input_style" style="width:140;height:20"/><input type="button" class="dbform_dbdate_btn_style" style="width:30" id="start" value=".." onClick="getNewDateTime(document.all.item('txtStartDate'))"/>
        ～<input name="txtEndDate" type="text" class="dbform_dbdate_input_style" style="width:140;height:20"/><input type="button" class="dbform_dbdate_btn_style" style="width:30" id="end" value=".." onClick="getNewDateTime(document.all.item('txtEndDate'))"/>
        <ai:button text="统  计" onclick="refresh()"/>
      </fieldset>
    </td></tr>
    <tr><td id="treeTD" width="100%" valign="top">
      <iframe id="subPage" align="left" width="100%" height="560" src="" frameborder="0" scrolling="auto"></iframe>
    </td></tr>
  </table>
</body>
</html>

<script language="javascript">

function init(){
  var mDate = new Date();
  var mYear = mDate.getYear();
  var mMonth = mDate.getMonth()+1;
  var mDay = mDate.getDate();
  
  var lYear = mYear;
  var lMonth = mMonth;
  if(lMonth == 1){
    lMonth = 12;
    lYear = lYear - 1;
  }
  else{
    lMonth = mMonth - 1;
  }
  
  if(mMonth<10){
	mMonth="0"+mMonth;
  }
  if(lMonth<10){
	lMonth="0"+lMonth;
  }
  if(mDay<10){
	mDay="0"+mDay;
  }
  var current = mYear+"-"+mMonth+"-"+mDay;
  var last = lYear+"-"+lMonth+"-01";
  document.all.txtStartDate.value = last+" 00:00:00";
  document.all.txtEndDate.value = current+" 23:59:59";
}

function refresh(){
  var startTime = document.all.txtStartDate.value;
  var endTime = document.all.txtEndDate.value;
  var taskTag = g_getListBox("lbxTag").getID();
  var objType = g_getListBox("lbxObjType").getID();
  var statType = g_getListBox("lbxType").getID();
  if(taskTag == "-1"){
    taskTag = "";
  }
  if(objType == "-1"){
    objType = "";
  }
  if(!g_IsDateTime(startTime)){
    alert("请正确输入起始时间！");
    document.all.txtStartDate.value = "";
    document.all.txtStartDate.focus();
    return;
  }
  if(!g_IsDateTime(endTime)){
    alert("请正确输入截止时间！");
    document.all.txtEndDate.value = "";
    document.all.txtEndDate.focus();
    return;
  }
  var compare =g_CompareDate(startTime,endTime);
if (compare!=-1){
	alert("结束时间应大于开始时间");
	return;
}
  var dataSource = g_getListBox("lbxDataSource").getID();
  var param =  "startTime="+startTime+"&endTime="+endTime+"&taskTag="+taskTag+"&objTypeId="+objType+"&statType="+statType+"&dataSource="+dataSource;
  
  var url = "<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?action=workflowStatByPeriod&width=700&height=450&"
          + param;

  document.all.subPage.src = url;
}
</script>
