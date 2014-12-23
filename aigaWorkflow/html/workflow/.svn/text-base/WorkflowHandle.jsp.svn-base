<%@ page contentType="text/html; charset=GBK" %>
<%@ page import ="com.ai.appframe2.common.*" %>
<html>
<head>
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
<title>任务处理流程</title>
</head>
<SCRIPT LANGUAGE="JavaScript" for="window" even="onload">
<%
   long workflowId = Long.parseLong(request.getParameter("WORKFLOW_ID"));
    com.ai.appframe2.vm.db.TaskViewBean[] tasks = com.ai.appframe2.vm.web.UserTaskServlet.queryTaskByWorkflowId(workflowId);
%>
var workflow_id = <%=workflowId%>;
var workflowHandleString ="";
function showTable(){
    document.all("myTable").innerHTML = workflowHandleString;
}
function showGraph(){
    document.all("myTable").innerHTML ="";
    var url = "<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?action=workflowInst2Svg&workflow_id=" + workflow_id;
    var s = "<object type='image/svg+xml' width='400' height='800'>"
                          + "<param name='src' value='" + url + "'/>"
                          + "</object>";
    document.all("myTable").innerHTML =s;

}
</SCRIPT>

<body bgcolor="#C6DCEE"  style=" overflow:auto;"  >
<!--====================== 将页面主体放置在页面正中=========================-->
<br/>
<p align="center" >

    <font size="5"> <b>工作已经经过的处理环节</b> </font>
<br/>
<br/>
<table>
<tr><td>
  <div id="myTable"   align="center">

   <table border="1" style="BORDER-RIGHT: 1px solid; BORDER-TOP: 0px solid; BORDER-LEFT: 1px solid;BORDER-BOTTOM: 0px solid; TABLE-LAYOUT: fixed;BORDER-COLLAPSE: collapse">
     <tr >
     <th align="center" width="40">序号</th>
     <th width="150">任务编号</th>
     <th width="150">任务名称</th>
     <th width="100">完成人员</th>
     <th width="160">创建时间</th>
     <th width="160">完成时间</th>
     <th width="200">备注信息</th>
     </tr>
<%
   for(int i=0;i< tasks.length;i++){
%>
  <tr onclick="setCurrentTaskId()">
     <td align="center" width="30"><%=i + 1%></td>
     <td><%=tasks[i].getTaskId()%></td>
     <td><%=tasks[i].getLabel()%></td>
     <td><%=tasks[i].getFinishStaffId()%></td>
     <td><%=DataType.transferToString(tasks[i].getCreateDate(),DataType.DATATYPE_DATETIME)%></td>
     <td><%=DataType.transferToString(tasks[i].getFinishDate(),DataType.DATATYPE_DATETIME)%></td>
     <td><%=DataType.transferToString(tasks[i].getErrorMessage(),DataType.DATATYPE_STRING)%></td>
   </tr>
<%
   }
%>
  </table>

  </div>
</td></tr>
<tr><td align="center" >
  <input type="button" value="图示信息" onclick ="showGraph()" class="B">
  <input type="button" value="详细信息" onclick="showTable()" class="B">
  <input type="button" value="关闭窗口" onclick="window.close()" class="B">
</td></tr>
</table>

</body>
</html>
<SCRIPT LANGUAGE="JavaScript" for="window" even="onload">
var workflowHandleString = document.all("myTable").innerHTML;

var currentRowObject;
function setCurrentTaskId(){
  var obj = window.event.srcElement;
  if ((obj.tagName == "TD")){
    if(currentRowObject != null){
       currentRowObject.style.backgroundColor ="";
    }
    currentRowObject = obj.parentNode;
    currentRowObject.style.backgroundColor ="#FFEE00";
  }
}

</SCRIPT>
