<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai" %>
<%@ include file="/workflow/workflow_css.jsp"%>
<script language="javascript" src="<%=request.getContextPath()%>/jsv2/Globe_v2.jsp" type="text/javascript"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/jsv2/AppFrameCss.jsp" type="text/css">

<%
String workflowId = request.getParameter("workflowId");
String templateCode = request.getParameter("templateCode");

String type = request.getParameter("showType");
String editable = "true";
String td1 = "block";
String td2 = "none";
if(type != null && type.equals("view")){
  editable = "false";
  td1 = "none";
  td2 = "block";
}
%>
<html>
<head>
<title>���̱���</title>
</head>
<body>
<table width="100%" align="center" border="0">
  <tr><td align="center" >
    <fieldset style="width:580;text-align:center;font-size:12">
      <legend class="FormZName">�����б�</legend>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr><td>
           <ai:table tableid="varTable" initial="true" setname="com.ai.comframe.console.action.SETServerInfo"
                    tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
                    implservice_name="com.ai.comframe.console.WorkflowConsole"
                    implservice_querymethod="getWorkflowInstVars(long workflowId,String templateCode)"
              width="100%" height="200" pagesize="100" needrefresh="true" multiselect="false" editable="true">
						<ai:col fieldname="NAME" width="165" visible="true" editable="false"/>
						<ai:col fieldname="TYPE" width="165" visible="true" editable="false"/>
						<ai:col fieldname="VALUE" width="165" visible="true" editable="<%=editable %>"/>
        </ai:table>
      </td></tr>
      </table>
    </fieldset>
  </td></tr>
  <tr><td align="center" style="display:<%=td1%>">
    <ai:button id="btnsave" text="ȷ  ��" onclick="saveFunc()"/>&nbsp;&nbsp;
    <ai:button id="btncancel" text="ȡ  ��" onclick="cancelFunc()"/>
  </td></tr>
  <tr><td align="center" style="display:<%=td2%>">
    <ai:button id="btnsave" text="��  ��" onclick="cancelFunc()"/>
  </td></tr>
</table>
</body>
</html>
<script language="javascript">
function saveFunc(){
  var varTable = g_TableRowSetManager.get("varTable");
  var count = varTable.count();
  var vars = "";
  for(var i=0;i<count;i++){
    var name = varTable.getValue(i,"NAME");
    var value = varTable.getValue(i,"VALUE");
    vars += name+":"+value+"#";
  }
  vars = g_ConditonStrEncode(vars);

  //����
  if("<%=type%>" == "edit"){
    if(vars == ""){
      alert("������ʵ������!");
      window.close();
    }
	  var url = "<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction"
	          + "?action=setWorkflowVars&workflowId=<%=workflowId%>&vars="+vars;
	  var rtn = sendToServer(url,null);
	  ret = rtn.getValueByName("FLAG");
	  if (ret == "INFO"){
	    window.close();
	  }
  }
  //�ص�
  else{
	  if(!confirm("ȷ������?")){
	    return;
	  }
    window.returnValue = vars;
    window.close();
  }
}

function cancelFunc(){
	window.close();
}
</script>
