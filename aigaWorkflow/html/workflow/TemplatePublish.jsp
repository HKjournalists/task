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
<table>
<tr>
  <td>
    <select id="upType" onchange="typeChange()">
      <option value="1" selected="selected">远程上传</option>
      <option value="2">本地目录</option>
    </select>
  </td>
  <td id="tdServer" align="left">
    <ai:fileupload name="frmTestUpload" submitFuncName="doUpload" onFinishFuncName="doOnFinish" showProcessBar="true">
      <input name="fileUp" type="file" style="width:200;height:20" contentEditable="false"/>
    </ai:fileupload>
  </td>
  <td id="tdLocal" style="display:none" align="left">
    <input id="txtDir" type="text" style="width:150" value="classpath"/><ai:button text="搜  索" onclick="search()"/>
  </td>
  <td class="FormTDName">
    生效时间:
  </td>
  <td align="left">
    <input name="txtValidDate" type="text" class="dbform_dbdate_input_style" style="width:150;height:20"/><input type="button" class="dbform_dbdate_btn_style" style="width:30" id="start" value=".." onClick="getNewDateTime(document.all.item('txtValidDate'))"/>
  </td>
   <td>
    <select id="EngineType"">
      <option value="VM" selected="selected">发布到VM</option>
      <option value="Fuego">发布到Fuego</option>
      <option value="WPS">发布到WPS</option>
      <option value="BPS">发布到BPS</option>
    </select>
  </td>
  <td class="FormTDName">
    备注:
  </td>
  <td align="center">
    <input id="txtNotes" type="text" style="width:100" value=""/><ai:button text="发  布" onclick="publish()"/>
  </td>
</tr>
<tr><td align="left" colspan="7">
  <input id="txtFilter" type="text" style="width:250" value=""/><ai:button text="过  滤" onclick="tagFilter()"/>
</td></tr>
<tr><td align="center" colspan="7">
  <table width="800" align="center"><tr><td align="center">
    <ai:table  tableid="tblFile" setname="com.ai.comframe.console.SETVmTemplate"
	    tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
	    implservice_name="com.ai.comframe.console.WorkflowConsole"
	    implservice_querymethod="getTemplatesFromDir(String dir)"
	    needrefresh="true" multiselect="true" editable="true" footdisplay="none"
	    rowheight="-1" initial="false" width="100%" height="300" rowsequence="true">
	    <ai:col fieldname="TASK_TAG" width="450"/>
	  </ai:table>
	</td></tr></table>
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
  if(mMonth<10){
	mMonth="0"+mMonth;
  }
  if(mDay<10){
	mDay="0"+mDay;
  }
  var current = mYear+"-"+mMonth+"-"+mDay;
  document.all.txtValidDate.value = current+" 00:00:00";
}

function getFileTable(){
  return g_TableRowSetManager.get("tblFile");
}

function search(){
  var dir = document.all.txtDir.value;
  getFileTable().refresh("dir="+dir);
}

function tagFilter(){
  var tags = document.all.txtFilter.value;
  if(tags == ""){
    return;
  }
  var arrTag = tags.split(";");
  for(var i=getFileTable().count()-1;i>=0;i--){
    var tmp = getFileTable().getValue(i,"TASK_TAG");
    var delFlag = true;
    for(var k=0;k<arrTag.length;k++){
      if(tmp.indexOf(arrTag[k]) >= 0){
        delFlag = false;
        break;
      }
    }
    if(delFlag == true){
      getFileTable().deleteRow(i);
    }
  }
}

function typeChange(){
  var type = document.all.upType.value;
  if(type == 1){
    document.all.tdServer.style.display = "block";
    document.all.tdLocal.style.display = "none";
  }
  else{
    document.all.tdServer.style.display = "none";
    document.all.tdLocal.style.display = "block";
  }
}

function publish(){
  var file = g_StringTrim(document.all.fileUp.value);
  if(file != null && file != ""){
  
    doUpload();
    return;
  }
  var EngineType = document.all.EngineType.value;

  var rows = getFileTable().getSelectedRows();
  if(rows == null || rows.length == 0){
    alert("请选择要发布的模板!");
    return;
  }
  if(confirm("确定发布？") == false){
    return;
  }
  var validDate = document.all.txtValidDate.value;
  var notes = document.all.txtNotes.value;
  if(validDate == ""){
    alert("请输入生效时间！");
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
  list.push(getFileTable());
  var url = "<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction"
      +"?action=publishWorkflow&validDate="+validDate+"&notes="+notes+"&EngineType="+EngineType+"&pubType=localToCommer";
     
  saveRowSet(url,list,false,false,null,false,true);
  document.all.txtNotes.value = "";
  
}

function doUpload(){
  var file = g_StringTrim(document.all.fileUp.value);
  if(file==null||file==""){
    alert("请选择文件！");
    return;
  }
  var fileType = file.substr(file.length-4,4).toLowerCase();
  if(fileType!=".wvm"){
    alert("请上传wvm文件！");
    return;
  }
  if(confirm("确定发布？") == false){
    return;
  }
  var aFileUploadFormObj = frmTestUpload;
  var validDate = document.all.txtValidDate.value;
  var notes = document.all.txtNotes.value;
  if(validDate == ""){
    alert("请输入生效时间！");
    document.all.txtValidDate.focus();
    return;
  }
  if(!g_IsDateTime(validDate)){
    alert("请正确输入生效时间！");
    document.all.txtValidDate.value = "";
    document.all.txtValidDate.focus();
    return;
  }
  var EngineType = document.all.EngineType.value;
  var aActionUrl="<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?"
        +"action=templateUpload&validDate="+validDate+"&notes="+notes+"&EngineType="+EngineType;
        aFileUploadFormObj.action=aActionUrl;
        aFileUploadFormObj.submit();
        
  PostUploadInfo(aFileUploadFormObj,aActionUrl,null,null,null);
}

function doOnFinish(aUserDataXml){
	
  var errMsg = getReturnValueByName(aUserDataXml,"ERRMSG");
  if(errMsg!=null && errMsg!=""){
    alert(errMsg);
  }
  var msg = getReturnValueByName(aUserDataXml,"MESSAGE");
  if(msg!=null && msg!=""){
    document.all.fileUp.value = "";
    document.all.txtNotes.value = "";
    alert(msg);
  }
}
</script>