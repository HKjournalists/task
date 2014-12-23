<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai" %>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/PopMenu_v2.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/jsv2/Globe_v2.jsp" type="text/javascript"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/jsv2/AppFrameCss.jsp" type="text/css">
<%@ include file="/workflow/workflow_css.jsp"%>

<html>
<head>
<title>开始流程</title>
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
        	 <tr class="FormTDName">
             <td>流程队列:</td>
             <td><ai:dbformfield fieldname="QUEUE_ID"  formid="startworkflowform" width="300" /></td>
             </tr>
             <tr class="FormTDName">
             <td>工作流模板编码:</td>
             <td><ai:listbox ds="com.ai.comframe.console.DSAllWorkflowTemplate" id="lbxTemplate" width="300" onchange="valueChange"/>
               <ai:dbformfield fieldname="TASK_TAG" formid="startworkflowform" width="300" visible="false"/></td>
             </tr>
             <tr class="FormTDName">          
             <td>工单处理对象类型:</td>
             <td><ai:dbformfield fieldname="WORKFLOW_OBJECT_TYPE_ID" formid="startworkflowform" width="300"/></td>
             </tr>
             <tr class="FormTDName"> 
             <td>工单处理对象编号:</td>
             <td><ai:dbformfield fieldname="WORKFLOW_OBJECT_ID" formid="startworkflowform" width="300"/></td>
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
              width="100%" height="150" pagesize="100" needrefresh="true" multiselect="false" editable="true">
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
</table>
</body>
</html>


<SCRIPT LANGUAGE="JavaScript" >
function init(){
	var obj = g_FormRowSetManager.get("startworkflowform");
	obj.setValue("QUEUE_ID","<%=com.ai.appframe2.vm.VMConst.getDefaultQueueId()%>");
  var template = g_getListBox("lbxTemplate").getValue();
  if(template != null && template != ""){
    obj.setValue("TASK_TAG",template);
    g_TableRowSetManager.get("varTable").refresh("templateCode="+template);
  }
  obj.setFocus("WORKFLOW_OBJECT_TYPE_ID");
  obj.setFocus("WORKFLOW_OBJECT_ID");

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
  
	  var list=new Array();
    list.push(g_FormRowSetManager.get("startworkflowform"));
    var rtn = saveRowSet('<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?action=startWorkflow',list,false);
    ret = rtn.getValueByName("FLAG");
    if (ret == "INFO"){
         window.returnValue = 1;
         window.close();
    }
}

function cancelFunc(){
  var template = g_getListBox("lbxTemplate").getValue();
  g_FormRowSetManager.get("startworkflowform").setValue("TASK_TAG",template);
  g_TableRowSetManager.get("varTable").refresh("templateCode="+template);
  
  g_FormRowSetManager.get("startworkflowform").setValue("WORKFLOW_OBJECT_ID","");
	window.close();
}

</SCRIPT>