<!--
/**************************************************************************************
 *作    者：guanxu
 *创建时间：2009-06-02
 *描    述：autoform任务列表
 *修改记录：
**************************************************************************************/
-->
<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.ai.appframe2.multicenter.CenterFactory" %>
<%@ include file="/webframe/common/commonhead.jsp"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai"%>
<html>
<%
	long staffId = SessionManager.getUser().getID(); //员工ID
	String staffName = SessionManager.getUser().getName();
	String regionId = (String) SessionManager.getUser().get("REGION_ID");

	Integer stations = (Integer)SessionManager.getUser().get("MANAGER_TYPE");       //岗位ID

%>
<head>
<title>任务工单查询主页面</title>
</head>
<body>
<table id="mainTable" align="center">
	<tr>
		<td>
			<ai:dbform formid="taskForm" setname="com.ai.comframe.autoform.web.SETQBOTaskInfo" 
			 datamodel="com.ai.appframe2.web.tag.ActionDataModel" conditionname="" 
				                      parametersname=""
				                      onvalchange="" editable="true" initial="false">
				<table width="100%">
					<tr>
					<td>任务执行人:</td>
		            <td>
		                <ai:dbformfield fieldname="TASK_STAFF_ID" formid="taskForm" visible="true" editable="false" width="120"></ai:dbformfield>
		                		                
		            </td>
		            <td>定单编号：</td>
		            <td>
		                <ai:dbformfield fieldname="WORKFLOW_OBJECT_ID" formid="taskForm" visible="true" editable="true" width="120"></ai:dbformfield>

		            </td>
		            <td align="right">
		            	<input type="button" value="查   询" id="B_QUERY" class="B" onclick="query();">
		            </td>
					</tr>
		  		</table>
	  		</ai:dbform>
		</td>
	</tr>
	<tr><td></td></tr>
  	<tr>
   	 	<td>
	      <!--流程任务信息-->
	      
			   <table border="0" width="100%" align="center">
			      <tr>
			      <td>
			      <fieldset>
					  <legend>
							任务列表信息
					  </legend>
				      <ai:table setname="com.ai.comframe.autoform.web.SETQBOTaskInfo" tableid="SETTaskInfo" 
				         implservice_name="com.ai.comframe.autoform.service.AutoFormSV"
				         implservice_querymethod="getTaskInfo(String stations,String staffId,String state,String orderId, int $STARTROWINDEX,int $ENDROWINDEX)"
				         implservice_countmethod="getTaskInfoCount(String stations,String staffId,String state,String orderId)"
				         tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
				         pagesize="50" editable="true" footdisplay="block" height="300" width="800" rowheight="-1"
				          initial="false" multiselect="false" needrefresh="true" onrowchange="checkBusiTypeAction" >
				          <ai:col fieldname="WORKFLOW_OBJECT_ID" editable="false"  visible="true" width="100"/>
				          <ai:col fieldname="LABEL" editable="false"  visible="true" width="120"/>
				          <ai:col fieldname="DESCRIPTION" editable="false"  visible="true" width="400"/>
				          <ai:col fieldname="CREATE_DATE" editable="false"  visible="true" width="150"/>
				          <ai:col fieldname="DURATION" editable="false"  visible="true" width="100"/>
				          <ai:col fieldname="STATE" editable="false"  visible="true" width="100"/>
				          <ai:col fieldname="TASK_STAFF_ID" editable="false"  visible="false" width="100"/>
				          <ai:col fieldname="STATION_ID" editable="false"  visible="false" width="100"/>
				          <ai:col fieldname="TASK_ID" editable="false"  visible="true" width="100"/>
				          <ai:col fieldname="WORKFLOW_NAME" editable="false"  visible="true" width="120"/>
				          <ai:col fieldname="WORKFLOW_ID" editable="false"  visible="true" width="100"/>
				          <ai:col fieldname="WORKFLOW_OBJECT_TYPE_ID" editable="false"  visible="true" width="150"/>
				          <ai:col fieldname="WORKFLOW_STATE" editable="false"  visible="false" width="100"/>
				          <ai:col fieldname="TASK_TEMPLATE_ID" editable="false"  visible="false" width="100"/>
				          <ai:col fieldname="WORKFLOW_CODE" editable="false"  visible="false" width="120"/>
				          <ai:col fieldname="ROOT_WOEK_FLOW_CODE" editable="false"  visible="false" width="120"/>
			       		  <ai:col fieldname="PARENT_TASK_ID" editable="false"  visible="true" width="100"/>
			       		   <ai:col fieldname="TASK_TAG" editable="false"  visible="false" width="120"/>
			      	</ai:table>
			      	</fieldset>
			      </td>
			      </tr>
			   </table>
	       
   	 	</td>
    </tr>
    <tr>
    	<td>
    	<table border="0" width="100%" align="center">
    		<tr>
	    		<td align="center">
			        
			        <input type="button" value="任务领取" id="B_PRINT" class="B" onclick="dotask('2');">
			        <input type="button" value="处   理" id="B_DO" class="B" onclick="dotask('1');">
		        </td>
		        <td align="right">
		        	<input type="button" value="业务数据查看"  class="B" onclick="dotask('3');">
		        	<input type="button" value="流程图查看"  class="B" onclick="viewWorkFlow();">
		        </td>
	    	</tr>
	    </table>
    	</td>
  </tr>
</table>
</body>


<script>
var stations="";

function getSETTaskInfoTable(){
	return g_TableRowSetManager.get("SETTaskInfo");
}

function getTaskForm(){
	return g_FormRowSetManager.get("taskForm");
}

function refreshTable(){

 var condition = "&stations="+stations+"&staffId=<%=staffId%>"+"&state="+"&regionId=<%=regionId%>&CenterType=RegionId&CenterValue=<%=regionId%>";
 getSETTaskInfoTable().refresh(condition);
}

/*页面初始化*/
function init(){
	var formset = getTaskForm();
		formset.setValue("TASK_STAFF_ID","1","<%=staffName%>",false);
	   		
		stations = <%=stations%>;
		
		refreshTable();
}

function query(){
  var oState = -1;//getTaskForm().getValue("STATE");
  var oOrderId = getTaskForm().getValue("WORKFLOW_OBJECT_ID");
  var condition = "&stations="+stations+"&staffId=<%=staffId%>"+"&state="+"&orderId="+oOrderId+"&regionId=<%=regionId%>&CenterType=RegionId&CenterValue=<%=regionId%>";
  getSETTaskInfoTable().refresh(condition);
}

/*任务回单*/
function dotask(type){
  var selectedRow = -1;
  var tableSet = getSETTaskInfoTable();
  selectedRow = tableSet.getRow();
  //复选框选中
  if(selectedRow < 0){
    alert("请选择一个任务单！");
    return;
  }else{
  	var aWorkFlowCode;
  	var aParentTaskId = tableSet.getValue(selectedRow,"PARENT_TASK_ID");                                //父流程号
  	//if(aParentTaskId > 0){
  		//aWorkFlowCode = tableSet.getValue(selectedRows[0],"ROOT_WOEK_FLOW_CODE");                           //根流程模板号，有子流程
  	//}else{
  		aWorkFlowCode = tableSet.getValue(selectedRow,"WORKFLOW_CODE");                                 //流程模板号，无子流程
  	//}
  	var currentWorkFlowCode = tableSet.getValue(selectedRow,"WORKFLOW_CODE");                           //当前流程模板号
  	var aWorkFlowNodeCode = currentWorkFlowCode+ "." + tableSet.getValue(selectedRow,"TASK_TEMPLATE_ID");      //流程节点号
  	var aOrderId = tableSet.getValue(selectedRow,"WORKFLOW_OBJECT_ID");                                 //工单号
  	var aTaskId = tableSet.getValue(selectedRow,"TASK_ID");                                             //任务编号
  	var aWorkFlowId = tableSet.getValue(selectedRow,"WORKFLOW_ID");                                     //工作流编号
  	
    var param="?WORK_FLOW_CODE="+aWorkFlowCode+"&WORK_FLOW_NODE_CODE="+aWorkFlowNodeCode+"&ORDER_ID="
  			+aOrderId+"&TASK_ID="+aTaskId+"&WORK_FLOW_ID="+aWorkFlowId+"&urlType="+type+"&regionId=<%=regionId%>&CenterType=RegionId&CenterValue=<%=regionId%>";
  //var r=window.showModalDialog("WorkFlowNodeAutoPage.jsp"+param,window,
  //"scroll:no;resizable:no;status:no;dialogHeight:500px;dialogWidth:1000px");
  window.open("WorkFlowNodeAutoPage.jsp"+param,"","height=768,width=1024,resizable=yes,scrollbars=yes");
  //alert(r);
  //if (r&&r=="true"){
    //refreshNode();
  //}
  }
}
init();

function viewWorkFlow(){
  var selectedRow = -1;
  var tableSet = getSETTaskInfoTable();
  selectedRow = tableSet.getRow();
  //复选框选中
  if(selectedRow < 0){
    alert("请选择一个任务单！");
    return;
  }else{
	var tableSet = getSETTaskInfoTable();
	var aWorkFlowId = tableSet.getValue(selectedRow,"WORKFLOW_ID");
	var aTemplateId = tableSet.getValue(selectedRow,"TASK_TEMPLATE_ID");
	var aWorkFlowCode = tableSet.getValue(selectedRow,"WORKFLOW_CODE");          
	var param = "?workflow_id="+aWorkFlowId+"&template_id="+aTemplateId+"&task_tag="+aWorkFlowCode;
	window.open("<%=request.getContextPath()%>/workflow/SvgView.jsp"+param,"","scroll=yes,resizable=no,status=no,help=no,height=650px,width=720px");
  }
}

function checkBusiTypeAction(){
  var selectedRow = -1;
  var tableSet = getSETTaskInfoTable();
  selectedRow = tableSet.getRow();
  if(selectedRow < 0){
  	document.getElementById("B_PRINT").disabled=true;
  	document.getElementById("B_DO").disabled=true; 
  	
  }else {
  	var aTaskId = tableSet.getValue(selectedRow,"TASK_ID"); 
  	var postURL = "/business/com.ai.comframe.autoform.web.AutoFormTempletAction?action=checkBusiTypeAction";
    var param =  "&aTaskId="+aTaskId;
    
    var retObj = sendToServer(postURL+param,"");
    var flag = retObj.getValueByName("retVal");
    if(flag=="N"){
        alert(retObj.getValueByName("retMsg"));
    }else if(flag=="5"){
      document.getElementById("B_PRINT").disabled=true;
  	  document.getElementById("B_DO").disabled=false; 
    }else if(flag=="9"){
      document.getElementById("B_PRINT").disabled=false;
  	  document.getElementById("B_DO").disabled=true; 
    }else{
    	
    }
  }
}


</script>
</html>