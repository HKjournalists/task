<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai" %>
<%@ include file="/workflow/workflow_css.jsp"%>
<%@ include file="/webframe/common/commonhead.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/jsv2/AppFrameCss.jsp" type="text/css">

<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/TableRowSet.js"></script>

<html>
<head>
  <title>告警维护</title>
</head>
<table align="center" border="0">
<tr><td>
  <fieldset style="text-align:left;font-size:12">
    <legend class="FormZName">模板查询条件</legend>
  <table align="center">
  <ai:dbform formid="frmQry" setname="com.ai.comframe.console.SETVmTemplate" initial="false">
    <tr>
      <td class="FormTDName">模板编号:</td>
      <td><ai:dbformfield formid="frmQry" fieldname="TEMPLATE_ID" width="100" /></td>
      <td class="FormTDName">模板编码:</td>
      <td><ai:dbformfield formid="frmQry" fieldname="TASK_TAG" width="150" /></td>
      <td class="FormTDName">有效时间:</td>
      <td><ai:dbformfield formid="frmQry" fieldname="VALID_DATE" width="150" /></td>
      <td align="center">～</td>
      <td><ai:dbformfield formid="frmQry" fieldname="EXPIRE_DATE" width="150" /></td>
      <td><ai:button id="btnQry" text="查  询" onclick="qry()"/></td>
    </tr>
  </ai:dbform>
  </table>
  </fieldset>
</td></tr>
<tr><td align="center" colspan="2">
    <table width="100%" align="center">
	    <tr><td align="center">
		    <ai:table  tableid="tblTemplate" setname="com.ai.comframe.console.SETVmTemplate"
			    tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
			    implservice_name="com.ai.comframe.console.WorkflowConsole"
			    implservice_querymethod="getPublishedTemplates(long templateId,String taskTag,String sValidDate,String eValidDate,int $STARTROWINDEX,int $ENDROWINDEX)"
			    implservice_countmethod="getPublishedTemplatesCount(long templateId,String taskTag,String sValidDate,String eValidDate)"
			    needrefresh="true" multiselect="false" editable="false" ondbclick="qryAlarm"  
			    rowheight="-1" initial="false" width="100%" height="100" footdisplay="true" rowsequence="true" pagesize="20">
			    <ai:col fieldname="TEMPLATE_ID" width="100"/>
			    <ai:col fieldname="TASK_TAG" width="150"/>
			    <ai:col fieldname="TASK_TYPE" width="80"/>
			    <ai:col fieldname="LABEL" width="200"/>
			  	<ai:col fieldname="VALID_DATE" width="200"/>
			  	<ai:col fieldname="EXPIRE_DATE" width="200"/>
			  	<ai:col fieldname="CREATE_STAFF_ID" width="100"/>
			  	<ai:col fieldname="CREATE_DATE" width="200"/>
			  	<ai:col fieldname="STATE" width="100"/>
			  	<ai:col fieldname="STATE_DATE" width="200"/>
			 	<ai:col fieldname="MODIFY_DESC" width="200"/>
			  	<ai:col fieldname="CONTENT" width="200" visible="false"/>
				</ai:table>
		  </td></tr>
		  <tr><td align="center">
		    <ai:table  tableid="Alarm" setname="com.ai.comframe.console.BOVmAlarm"
			    tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
			    implservice_name="com.ai.comframe.console.WorkflowConsole"
			    implservice_querymethod="getAlarmConfigs(String templateTag)"
			    needrefresh="true" multiselect="true" editable="false"  
			    rowheight="-1" initial="false" width="100%" height="100" footdisplay="none" rowsequence="true">
			    <ai:col fieldname="ALARM_CONFIG_ID" width="100" title="告警配置ID" visible="false"/>
			    <ai:col fieldname="VM_TEMPLATE_ID" width="80" title="模板编号"/>
			    <ai:col fieldname="TEMPLATE_TAG" width="150" title="模板编码"/>
			    <ai:col fieldname="TASK_TAG" width="100" title="任务编码"/>
			  	<ai:col fieldname="DURATION_TIME_METHOD" width="300" title="计算正常时长方法"/>
			  	<ai:col fieldname="ALARM_TIME_METHOD" width="300" title="计算告警时间方法"/>
			  	<ai:col fieldname="ALARM_DEAL_METHOD" width="300" title="告警处理方法"/>
			  	<ai:col fieldname="STATE" editable="false" width="100"/>
			  	<ai:col fieldname="IS_HOLIDAY" width="120"/>
				</ai:table>
		  </td></tr>
		  <tr><td align="center">
		  <ai:button id="btnAdd" text="新  增" onclick="add()"/>
		  <ai:button id="btnEdit" text="修  改" onclick="edit()"/>
		  <ai:button id="btnDel" text="删  除" onclick="dele()"/>
		  <ai:button id="btnSave" text="保  存" onclick="save()"/>
		  </td></tr>
		  <tr><td>*请注意，只有异步节点(人工任务、子流程)才能配置告警。</td></tr>
	  </table>
	  
</td></tr>
</table>

<script language="javascript">
function getForm(){
  return g_FormRowSetManager.get("frmQry");
}
function getTable(){
  return g_TableRowSetManager.get("tblTemplate");
}
function getAlarmTable(){
	 return g_TableRowSetManager.get("Alarm");
}
function qry(){
  var templateId = getForm().getValue("TEMPLATE_ID");
  var taskTag = getForm().getValue("TASK_TAG");
  var sValidDate = getForm().getValue("VALID_DATE");
  var eValidDate = getForm().getValue("EXPIRE_DATE");
  
  if(!g_IsDateTime(sValidDate)){
    alert("请正确输入起始时间！");
    return;
  }
  if(!g_IsDateTime(eValidDate)){
    alert("请正确输入截止时间！");
    return;
  }
  var compare =g_CompareDate(sValidDate,eValidDate);
	if ((sValidDate!="")&&(eValidDate!="")&&(compare!=-1)){
		alert("有效时间结束时间应大于开始时间");
		return;
	}
  if(templateId == null || templateId == ""){
    templateId = "0";
  }
  getTable().refresh("templateId="+templateId+"&taskTag="+taskTag+"&sValidDate="+sValidDate+"&eValidDate="+eValidDate);
  
  if(getTable().count() == 0){
    alert("未查到数据!");
  }
  clear();
}

function qryAlarm(){

	var row = getTable().getRow();
	  if(row == -1){
	    	return;
	  }
 	 else{
		getAlarmTable().refresh("templateTag="+getTable().getValue(row,"TASK_TAG"));
		 if(getAlarmTable().count() == 0){
	    	alert("未查到数据!");
	 	 }
 	 }
 	 
}
function save(){
  if(!confirm("确认保存?")){
	  return;
	}
	var grid=getAlarmTable();
	if (grid.getTotalRowCount()>0){
		for (var i=0;i<grid.getTotalRowCount();i++)
		{
			if(grid.getValue(i,"TEMPLATE_TAG")==""){
				alert("模板编号不能为空");
				return;
			}
		}
	}
	var list = new Array(); 
	list.push(getAlarmTable());
	var url = _gModuleName+"/business/com.ai.comframe.console.action.WorkflowAction?action=saveAlarmConfig";
	var rtn=saveRowSet(url,list,false,false);
	getAlarmTable().setEditSts(false);
	clear();
	alert("请注意清理各服务器缓存数据!");
}
function add(){
	getAlarmTable().newRow();
	var templateRow = getTable().getRow();
	var alarmRow = getAlarmTable().getRow();
	if(templateRow != -1){
	  getAlarmTable().setValue(alarmRow,"VM_TEMPLATE_ID",getTable().getValue(templateRow,"TEMPLATE_ID"));
	  getAlarmTable().setValue(alarmRow,"TEMPLATE_TAG",getTable().getValue(templateRow,"TASK_TAG"));
	}
	edit();
}
function edit(){
	getAlarmTable().setEditSts(true);
}

function dele(){
	var AlarmGird=getAlarmTable();
	var selectedRows=AlarmGird.getSelectedRows();
  if(selectedRows.length == 0){
    alert("请选择要删除的记录");
    return;
  }
	if(!confirm("确认删除?")){
	  return;
	}
  
	for (var i=selectedRows.length-1;i>=0;i--){
    AlarmGird.deleteRow(selectedRows[i]);
	}
}

function clear(){
	var AlarmGird=getAlarmTable();
		for (var i=AlarmGird.getTotalRowCount()-1;i>=0;i--){
			AlarmGird.deleteRow(i);
		}
}
</script>