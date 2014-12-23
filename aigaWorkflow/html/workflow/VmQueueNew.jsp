<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai" %>
<script language="javascript" src="<%=request.getContextPath()%>/jsv2/Globe_v2.jsp" type="text/javascript"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/jsv2/AppFrameCss.jsp" type="text/css">
<%@ include file="/workflow/workflow_css.jsp"%>
<html>
<head>
  <title>设置处理人员信息</title>
</head>
<body>
<div align="center"><br>
<fieldset style="width:90%;text-align:center;font-size:12">
<table align="center">
  <tr>
    <td class="FormTDName">队列类型:</td>
    <td class="FormTD"><input type="text" name="txtTaskType" width="100"/></td>
  </tr>
  <tr>
    <td class="FormTDName">调度类型:</td>
    <td class="FormTD"><ai:listbox ds="com.ai.comframe.console.DSVmDealType" id="lbxDealType" width="150"/></td>
  </tr>
  <tr>
    <td class="FormTDName">处理类型:</td>
    <td class="FormTD"><input type="text" name="txtQueueId" value="<%=com.ai.appframe2.vm.VMConst.getDefaultQueueId()%>" width="100"/></td>
  </tr>
  <tr>
    <td colspan="2"><ai:button text="确  定" id="btnOk" onclick="saveFunc()"/>&nbsp;&nbsp;&nbsp;&nbsp;
      <ai:button text="取  消" id="btnQuit" onclick="cancelFunc()"/>
    </td>
  </tr>
</table>     
</fieldset>
</div>
</body>
</html>

<script type="text/javascript">
function saveFunc(){
  var taskType = document.all.txtTaskType.value;
  if(taskType == null || taskType == ""){
    alert("请输入队列类型!");
    return;
  }
  var dealType = g_getListBox("lbxDealType").getValue();
  var queueId = document.all.txtQueueId.value;
  if(queueId == null){
    queueId = "";
  }
  var param = "taskType="+taskType+"&dealType="+dealType+"&queueId="+queueId;
  window.returnValue = param;
  window.close();  
}

function cancelFunc(){
  window.returnValue = null;
  window.close();
}
</script>