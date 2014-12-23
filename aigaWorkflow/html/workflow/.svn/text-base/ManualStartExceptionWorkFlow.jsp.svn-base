<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai" %>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/PopMenu_v2.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/HtmlParameter.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/jsv2/Globe_v2.jsp" type="text/javascript"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/jsv2/AppFrameCss.jsp" type="text/css">
<%@ include file="/workflow/workflow_css.jsp"%>

<html>
<head>
<title>手工启动异常流程</title>
</head>
<body onload="init()">
<table width="100%" align="center" border="0">
	<tr>
    	<td align="center">
     		 <fieldset style="width:580">  
      		 <br>    
           	 <ai:dbform formid="startworkflowform" setname="com.ai.comframe.console.SETVmWorkFlow" 
           	    initial="false">
      		 <table>

        	 <tr class="FormTDName"  >
             <td>流程队列:</td>
             <td><ai:dbformfield fieldname="QUEUE_ID"  formid="startworkflowform" width="300" /></td>
             </tr>
             <tr class="FormTDName" >          
             <td>工单处理对象类型:</td>
             <td><ai:dbformfield fieldname="WORKFLOW_OBJECT_TYPE_ID" formid="startworkflowform" width="300"/></td>
             </tr>
             <tr class="FormTDName" > 
             <td>工单处理对象编号:</td>
             <td><ai:dbformfield fieldname="WORKFLOW_OBJECT_ID" formid="startworkflowform" width="300"/></td>
             </tr> 
             <tr class="FormTDName"> 
             <td>上级工作流编号:</td>
             <td><ai:dbformfield fieldname="PARENT_TASK_ID" formid="startworkflowform" width="300"/></td>
             </tr> 
             <tr class="FormTDName" >
             <td>工作流模板编码:</td>
             <td><ai:listbox ds="com.ai.comframe.console.DSAllWorkflowTemplate" id="lbxTemplate" width="300" onchange="valueChange"/>
               <ai:dbformfield fieldname="TASK_TAG" formid="startworkflowform" width="300" visible="false"/></td>
             </tr>
             <tr class="FormTDName">          
             <td>描述信息:</td>
             <td><ai:dbformfield fieldname="ERROR_MESSAGE" formid="startworkflowform" width="300"/></td>
             </tr>
             <tr class="FormTDName">          
             <td>保存异常处理规则:</td>
             <td align ="left"><input type="checkbox" id ="isMakeRule" ></td>
             </tr>
             <tr class="FormTDName" style="display:none"> 
             <td>流程实例变量:</td>
             <td><ai:dbformfield fieldname="VARS" formid="startworkflowform" width="300"/></td>
             </tr> 
             </table>
             </ai:dbform>
             </fieldset>
        </td>
    </tr>
  <tr><td  align="center" > 
    <fieldset style="width:580;text-align:center;font-size:12">
      <legend class="FormZName">参数列表</legend>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr><td>
           <ai:table tableid="varTable" initial="false" setname="com.ai.comframe.console.action.SETServerInfo" 
                    tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
                    implservice_name="com.ai.comframe.console.WorkflowConsole"
                    implservice_querymethod="getTemplateVars(String templateCode)"
              width="100%" height="80" pagesize="100" needrefresh="true" multiselect="false" editable="true">
						<ai:col fieldname="NAME" width="165" visible="true" editable="false"/>
						<ai:col fieldname="TYPE" width="165" visible="true" editable="false"/>
						<ai:col fieldname="VALUE" width="165" visible="true" editable="true"/>
        </ai:table>
      </td></tr>
      </table>
    </fieldset>
  </td></tr>
  <tr>
    	<td align="center">
    		<fieldset style="width:580"> 
    		<table>
              <tr>
              <td valign="baseline" width="120" align="center">
                <ai:button id="btnsave" text="确  定" onclick="saveFunc()"/>
              </td>
              <td valign="baseline" width=120" align="center">
                <ai:button id="btncancel" text="取  消" onclick="cancelFunc()"/>
              </td>
              </tr>
             </table>
           </fieldset></td></tr>
   <tr><td  align="center" > 
    <fieldset style="width:580;text-align:center;font-size:12">
      <legend class="FormZName">异常原因列表</legend>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr><td>
           <ai:table tableid="exRecordTable" initial="false" setname="com.ai.comframe.exception.db.ExceptionRecord" 
                    tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
                    implservice_name="com.ai.comframe.IComframeForException"
                    implservice_querymethod="getExceptionRecordsByInstanceId(long workflowId)"
              width="100%" height="60" pagesize="100" needrefresh="true" multiselect="false" editable="true">
						<ai:col fieldname="WORKFLOW_ID" width="165" visible="false" editable="false"/>
					    <ai:col fieldname="TASK_ID" width="120" visible="true" editable="false"/>
						<ai:col fieldname="EXCEPTION_CODE" width="165" visible="true" editable="false"/>
						<ai:col fieldname="CREATE_DATE" width="165" visible="true" editable="false"/>					
						<ai:col fieldname="STATE" width="85" visible="true" editable="false"/>
        </ai:table>
      </td></tr>
      </table>
    </fieldset>
  </td></tr>
</table>
</body>
</html>


<SCRIPT LANGUAGE="JavaScript" >
function init(){
	var obj = g_FormRowSetManager.get("startworkflowform");
	var parentWfId =gHtmlParameter.getParameter("task_id");
	var workflowObjType =gHtmlParameter.getParameter("workflow_obj_type");
	var queueId =gHtmlParameter.getParameter("queue_id");
	var workflowObjId =gHtmlParameter.getParameter("workflow_obj_id");
	
	
	obj.setValue("QUEUE_ID",queueId);
	obj.setValue("WORKFLOW_OBJECT_TYPE_ID",workflowObjType);
	obj.setValue("WORKFLOW_OBJECT_ID",workflowObjId);
	obj.setValue("PARENT_TASK_ID",parentWfId);
	obj.setColEditSts("QUEUE_ID",false);
	obj.setColEditSts("WORKFLOW_OBJECT_TYPE_ID",false);
	obj.setColEditSts("WORKFLOW_OBJECT_ID",false);
	obj.setColEditSts("PARENT_TASK_ID",false);
	
	var template = g_getListBox("lbxTemplate").getValue();
  if(template != null && template != ""){
    obj.setValue("TASK_TAG",template);
    g_TableRowSetManager.get("varTable").refresh("templateCode="+template);
  }
	
	var parentWfId =gHtmlParameter.getParameter("task_id");
  var exceptionTable = g_TableRowSetManager.get("exRecordTable");
  exceptionTable.refresh("workflowId="+parentWfId);
}

function valueChange(col){
  var template = g_getListBox("lbxTemplate").getValue();
  g_FormRowSetManager.get("startworkflowform").setValue("TASK_TAG",template);
  g_TableRowSetManager.get("varTable").refresh("templateCode="+template);
}

function saveFunc(){
  var varTable = g_TableRowSetManager.get("varTable");
  var count = varTable.count();
  var vars = "";
  for(var i=0;i<count;i++){
    var name = varTable.getValue(i,"NAME");
    var value = varTable.getValue(i,"VALUE");
    vars += name+":"+value+"#";
  }
  
    g_FormRowSetManager.get("startworkflowform").setValue("VARS",vars);
    var makRule=false;
    if(document.all("isMakeRule").checked)
       makRule=true;
    var errorMessage =g_FormRowSetManager.get("startworkflowform").getValue("ERROR_MESSAGE");
    var para ="&makRule="+makRule+"&ErrorRemark="+errorMessage;
   // alert(para);
   // return;
	var list=new Array();
    list.push(g_FormRowSetManager.get("startworkflowform"));
    var rtn = saveRowSet('<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?action=startExceptionWorkflow'+para,list,false);
    ret = rtn.getValueByName("FLAG");
    if (ret == "INFO"){
         window.returnValue = 1;
         window.close();
    }
}

function cancelFunc(){
	window.close();
}

</SCRIPT>