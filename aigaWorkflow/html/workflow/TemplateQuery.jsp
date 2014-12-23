<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai" %>
<%@ include file="/workflow/workflow_css.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/jsv2/AppFrameCss.jsp" type="text/css">
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/PopMenu_v2.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/TableRowSet.js"></script>

<html>
<head>
  <title>流程发布</title>
</head>

<body onload="init()">
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
    <tr>
  <td class="FormTDName">
    生效时间:
  </td>
  <td align="left">
    <input name="txtValidDate" type="text" class="dbform_dbdate_input_style" style="width:150;height:20"/><input type="button" class="dbform_dbdate_btn_style" style="width:30" id="start" value=".." onClick="getNewDateTime(document.all.item('txtValidDate'))"/>
  </td>

  <td class="FormTDName">
    备注:
  </td>
  <td >
    <input id="txtNotes" type="text" style="width:100" value=""/>
  </td>
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
			    needrefresh="true" multiselect="true" editable="false" onrowchange="showContent"  oncontextmenu="buildPopMenu" 
			    rowheight="-1" initial="false" width="100%" height="150" footdisplay="true" rowsequence="true" pagesize="20">
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
		    <TEXTAREA style="width:100%;height:120;text-align:left;font-size:12" ID="txtContent" readonly="readonly"></TEXTAREA>
		  </td></tr>
		  <tr><td align="center">
		    <ai:table  tableid="EngineTem" setname="com.ai.comframe.console.BOVmEngineTemplate"
			    tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
			    implservice_name="com.ai.comframe.console.WorkflowConsole"
			    implservice_querymethod="getPublishedCommercialTemplates(String taskTag)"
			    needrefresh="true" multiselect="false" editable="false"  
			    rowheight="-1" initial="false" width="100%" height="100" footdisplay="none" rowsequence="true">
			    <ai:col fieldname="VM_TEMPLATE_ID" width="100"/>
			    <ai:col fieldname="ENGINE_TEMPLATE_ID" width="150"/>
			    <ai:col fieldname="ENGINE_TYPE" width="80"/>
			    <ai:col fieldname="ENGINE_VERION" width="200"/>
			  	<ai:col fieldname="TASK_TAG" width="200"/>
			  	<ai:col fieldname="LABEL" width="200"/>
			  	<ai:col fieldname="CREATE_STAFF_ID" width="100"/>
			  	<ai:col fieldname="MODIFY_DESC" width="200"/>
			  	<ai:col fieldname="STATE" width="100"/>
			  	<ai:col fieldname="CREATE_DATE" width="200"/>
			 	<ai:col fieldname="VALID_DATE" width="200"/>
			  	<ai:col fieldname="STATE_DATE" width="200" visible="false"/>
			  	<ai:col fieldname="EXPIRE_DATE" width="200" />	
				</ai:table>
		  </td></tr>
	  </table>
</td></tr>
</table>


</body>

<script language="javascript">
var popMenu=null;
document.onclick=hidePopMenu;
function hidePopMenu(){

  if(popMenu){
 	popMenu.hidePopMenu();
  }
}

function buildPopMenu(){
var row = getTable().getRow();
hidePopMenu();
var model= new AIPopMenuModel();
model.addPopMenuItem("1","VM正式版本发布到Fuego",null,"publishCommercial('Fuego')");
model.addPopMenuItem("2","VM正式版本发布到WPS",null,"publishCommercial('WPS')");
model.addPopMenuItem("3","VM正式版本发布到BPS",null,"publishCommercial('BPS')");
model.addSeparator();
model.addPopMenuItem("4","显示单条记录流程图",null,"showSvg('"+row+"')");
 popMenu = new AIPopMenu(model);
  popMenu.showPopMenu();
  return false;
}

function init(){
  var mDate = new Date();
  var mYear = mDate.getYear();
  var mMonth = mDate.getMonth()+1;
  var mDay = mDate.getDate();
  if(mMonth<10){
	mMonth="0"+mMonth;
  }
  if(mDay<10){
	mDay="0"+mDay;
  }
  var current = mYear+"-"+mMonth+"-"+mDay;
  document.all.txtValidDate.value = current+" 00:00:00";
}
function publishCommercial(type){//PopMenu  触发的发布函数


	var selectedrows =getTable().getSelectedRows();
	if (selectedrows.length<1){
		alert("请选中需要发布的模版！");
		return;
	}
	 var validDate = document.all.txtValidDate.value;
  var notes = document.all.txtNotes.value;
  if(validDate == ""){
    alert("请在下方输入生效时间！");
    document.all.txtValidDate.focus();
    return;
  }
  if(!g_IsDateTime(validDate)){
    alert("请正确输入生效时间！");
    document.all.txtValidDate.value = "";
    document.all.txtValidDate.focus();
    return;
  }
	
	 var list=new Array();
  	list.push(getTable());
 	 var url = "<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction"
      +"?action=publishWorkflow&validDate="+validDate+"&notes="+notes+"&EngineType="+type+"&pubType=VMToCommer";
     
 	saveRowSet(url,list,false,false,null,false,true);
	qry();
}



function getForm(){
  return g_FormRowSetManager.get("frmQry");
}

function getTable(){
  return g_TableRowSetManager.get("tblTemplate");
}

function getEngineTable(){
	 return g_TableRowSetManager.get("EngineTem");
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
  
  document.all.txtContent.value = "";
  getEngineTable().clear();
  
  if(getTable().count() == 0){
    alert("未查到数据!");
  }
}

function showContent(){

  var row = getTable().getRow();
  if(row == -1){
    document.all.txtContent.value = "";
  }
  else{
  var selectedrows =getTable().getSelectedRows();
  
  getEngineTable().refresh("taskTag="+getTable().getValue(row,"TASK_TAG"));
  
    document.all.txtContent.value = getTable().getValue(row,"CONTENT");
  }
}


function showSvg(row){

if (row==-1)
	alert("请选中行");
 else{
    var templateId = getTable().getValue(row,"TEMPLATE_ID");
    window.open("SvgView.jsp?template_id="+ templateId,"","scroll=yes,resizable=no,status=no,help=no,height=650px,width=720px");
  }
}





</script>
