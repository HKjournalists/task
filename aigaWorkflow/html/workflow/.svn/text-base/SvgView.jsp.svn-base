<%@ page language="java" import="java.util.*" pageEncoding="gbk"%> 
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai" %>
<script language="javascript" src="<%=request.getContextPath()%>/jsv2/Globe_v2.jsp" type="text/javascript"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/jsv2/AppFrameCss.jsp" type="text/css">
<%@ include file="/workflow/workflow_css.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%String workflow_id =request.getParameter("workflow_id");
  String template_id = request.getParameter("template_id");
  String task_tag = request.getParameter("task_tag");
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
    <div id="instDiv" align="center" style="display:none">
    <fieldset style="width:100%;text-align:center;font-size:12">
      <legend class="FormZName">子流程实例列表</legend>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr><td align="center">
           <ai:table tableid="workflowTable" setname="com.ai.comframe.console.SETVmWorkFlow"
                    tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
                    implservice_name="com.ai.comframe.console.WorkflowConsole"
                    implservice_querymethod="queryChildWorkflow(long taskId,int $STARTROWINDEX,int $ENDROWINDEX)"
                    implservice_countmethod="queryChildWorkflowCount(long taskId)"
					onlyquery="true" width="98%" height="150" pagesize="100" onrowchange="showChildSVG" ondbclick="showChildSVG"
					needrefresh="true" multiselect="false" initial="false" editable="false" >
            <ai:col fieldname="TASK_ID" width="100" visible="true" />
						<ai:col fieldname="LABEL" width="120" visible="true" />
						<ai:col fieldname="TASK_TAG" width="165" visible="true" />
						<ai:col fieldname="WORKfLOW_OBJECT_ID" width="100" visible="true" />
						<ai:col fieldname="WORKFLOW_OBJECT_TYPE_ID" width="100" visible="true" />
						<ai:col fieldname="QUEUE_ID" width="100" visible="true" />
						<ai:col fieldname="STATE" width="100" visible="true" />
						<ai:col fieldname="CREATE_DATE" width="150" visible="true" />
						<ai:col fieldname="STATE_DATE" width="150" visible="true" />
						<ai:col fieldname="CURRENT_TASK_ID" width="165" visible="true" />
						<ai:col fieldname="CREATE_STAFF_ID" width="165" visible="true" />
						<ai:col fieldname="VARS" width="200" visible="false" />
						<ai:col fieldname="ERROR_MESSAGE" width="165" visible="false" />
						<ai:col fieldname="ENGINE_WORKFLOW_ID" width="165" visible="true" />
						<ai:col fieldname="ENGINE_TYPE" width="165" visible="true" />
			      <ai:col fieldname="PARENT_TASK_ID" width="100" visible="true" />
			      <ai:col fieldname="TASK_TEMPLATE_ID" width="100" visible="true" />
        </ai:table>
      </td></tr>
      </table>
    </fieldset>
    </div>
  	<div id="btnDiv1" align="right" style="display:none"><ai:button text="返  回" onclick="goBack()"/></div>
  	<div id="graphDiv" align="center"></div>
  	<div id="btnDiv2" align="right" style="display:none"><ai:button text="返  回" onclick="goBack()"/></div>
  	<table id="tblInfo">
  	  <TR><TD class="FormTD">
        如果流程图无法显示，或者任务块中的汉字为问号或者方块, 您需要安装附件以显示流程图，安装汉字字体以显示汉字。
      </TD></TR>
    <TR><TD class="FormTD"> <b>1.安装附件</b><br>
        请鼠标<span class="pr9">左键</span>点击这里：<a href="workflow/SVGView.exe" >SVG安装文件</a><br>
        如有弹出的对话框，请选择打开或者安装。附件会自动安装到您的机器上.
    </TD></TR>
    <TR><TD class="FormTD"> <b>2.安装字体</b><br>
        请鼠标<span class="pr9">右键</span>点击这里：<a href="workflow/ARIALUNI.TTF" >字体文件</a><br>
        在弹出菜单中选择“目标另存为”，将字体文件下载到本地计算机(注意请保存为<span class="pr9">TTF</span>格式)。<br>
        进入控制面板，选择“字体”，打开。在菜单条中选择“安装新字体”，进入。<br>
        在“安装新字体”的对话框中，选择刚才下载的字体文件，选中，点击“确定”按钮。<br>
        在安装完成以后，退出程序界面，再重新进入IE，就可以看见正常显示的流程图。<br>
    </TD></TR>
  	</table>
  </body>
</html>
<script type="text/javascript">

function getTbl(){
  return g_TableRowSetManager.get("workflowTable");
}

function init(){
	var workflow_id="<%=workflow_id %>";
	var template_id = "<%=template_id%>";
	var task_tag = "<%=task_tag%>";
  var url = "<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?";
  if(isBlank(workflow_id) == false){
    url += "action=workflowInst2Svg&workflow_id=" + workflow_id;
  }
  else{
    url += "action=template2Svg&template_id=" + template_id + "&task_tag="+task_tag;
  }
  showSVG(url);
}

function onSvgClick(taskTemplateId,taskLabel,taskId,childCode){
  var workflow_id="<%=workflow_id %>";
	var template_id = "<%=template_id%>";
	if(isBlank(childCode) == false){
	  //流程实例
	  if(isBlank(workflow_id) == false && taskId > 0){
	    //查询出全部子流程
		  getTbl().refresh("taskId="+taskId);
		  if(getTbl().count() > 1){
	    	document.all.instDiv.style.display = "block";
		  	document.all.tblInfo.style.display = "none";
		  	document.all.btnDiv1.style.display = "block";
		  	document.all("graphDiv").innerHTML ="";
		    return;
		  }
		  else{
		    //如果只有一个子流程实例则直接显示
		    document.all.instDiv.style.display = "none";
			  document.all.tblInfo.style.display = "none";
			  document.all.btnDiv1.style.display = "none";
			  document.all.btnDiv2.style.display = "block";
			  var workflowId = getTbl().getValue(0,"TASK_ID");
  			var url = "<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?"
		            + "action=workflowInst2Svg&workflow_id="+workflowId;
			  showSVG(url);
			  return;
		  }
		}
		//流程模板，尚未执行到该子流程节点，该子流程节点未创建出子流程
//		else{
		  document.all.instDiv.style.display = "none";
		  document.all.tblInfo.style.display = "none";
		  document.all.btnDiv1.style.display = "none";
		  document.all.btnDiv2.style.display = "block";
		  var url = "<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?"
		      + "action=template2Svg&template_id=-1&task_tag="+childCode;
		  showSVG(url);
//		}
	}
}

function showParentSVG(parentWorkflowId){
  var url = "<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?"
		      + "action=workflowInst2Svg&workflow_id="+parentWorkflowId;
	showSVG(url);
}

function showChildSVG(){
  var rowIndex = getTbl().getRow();
  var workflowId = getTbl().getValue(rowIndex,"TASK_ID");
  var url = "<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?"
		      + "action=workflowInst2Svg&workflow_id="+workflowId;
	showSVG(url);
}

function showSVG(url){
  document.all("graphDiv").innerHTML ="";
	var s = "<object type='image/svg+xml' width='650' height='500'>"
                          + "<param name='src' value='" + url + "'/>"
                          + "</object>";
  document.all("graphDiv").innerHTML = s;
}

function goBack(){
  location.reload();
}

function isBlank(param){
  if(param == null || param == undefined || param == "" || param == "null"){
    return true;
  }
  return false;
}
</script>
