<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai" %>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/PopMenu_v2.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/json.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/jsv2/Globe_v2.jsp" type="text/javascript"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/jsv2/AppFrameCss.jsp" type="text/css">
<%@ include file="/workflow/workflow_css.jsp"%>
<html>
<head>
<title>工作流查询</title>
</head>
<body >
<table width="100%" align="center" border="0">
  <tr><td align="center">
    <fieldset style="width:100%;text-align:center;font-size:12">
      <legend class="FormZName">查询</legend>
      <table border="0" align="center" cellpadding="0" cellspacing="0">
      	<tr>
          <td width="80" class="FormTDName">处理对象编号:</td>
          <td class="FormTD"><input name="txtBusiOrderId" type="text" style="width:100;height:20"/></td>
          <td width="120" class="FormTDName">处理对象类型:</td>
          <td align="left">
           <ai:listbox ds="com.ai.comframe.console.DSStaticData" parameters='<%="codeType="+com.ai.appframe2.vm.common.Constant.STATIC_DATA_WORKFLOW_OBJTYPE %>' id="selBusiOrderType" nullid="-1" nulltext="" width="80" />
          </td>
          <td width="80" class="FormTDName">流程状态:</td>
          <td class="FormTD"><ai:listbox ds="com.ai.comframe.console.DSVmWorkFlowState" id="lbxState" nullid="-1" nulltext="所有" width="120"/></td>
          <td width="80" class="FormTDName">创建时间:</td>
          <td class="FormTD">
            <input name="txtStartDate" type="text" class="dbform_dbdate_input_style" style="width:140;height:20"/><input type="button" class="dbform_dbdate_btn_style" style="width:30" id="start" value=".." onClick="getNewDateTime(document.all.item('txtStartDate'))"/>
          </td>
          <td align="center" class="FormTD">～</td>
          <td class="FormTD">
            <input name="txtEndDate" type="text" class="dbform_dbdate_input_style" style="width:140;height:20"/><input type="button" class="dbform_dbdate_btn_style" style="width:30" id="end" value=".." onClick="getNewDateTime(document.all.item('txtEndDate'))"/>
          </td>
        <td width="80" align="center"><ai:button id="qryBtn" text="查  询" onclick="qry()"/></td>
        </tr>
      </table>
    </fieldset>
  </td></tr>
  <tr><td  align="center" >
    <fieldset style="width:100%;text-align:center;font-size:12">
      <legend class="FormZName">工作流列表</legend>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr><td>
           <ai:table tableid="workflowTable" setname="com.ai.comframe.console.SETVmWorkFlow"
                    tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
                    implservice_name="com.ai.comframe.console.WorkflowConsole"
                    implservice_querymethod="queryWorkflow(String busiOrderId,String busiOrderType,int state,String startTime,
                             String endTime,int $STARTROWINDEX,int $ENDROWINDEX)"
                    implservice_countmethod="getVmWorkflowCount(String busiOrderId,String busiOrderType,int state,String startTime,String endTime)"
					onlyquery="true" width="100%" oncontextmenu="showWorkFlow"
					height="150" pagesize="100" onrowchange="showSrvErrMsg"
					needrefresh="true" multiselect="false" initial="false"
					editable="false" >
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
			      <ai:col fieldname="WARNING_DATE" width="100" visible="true" />
			      <ai:col fieldname="WARNING_TIMES" width="100" visible="true" />
        </ai:table>
      </td></tr>
      <tr>
      <td  align="center"><TEXTAREA style="width:100%;height:70;text-align:left;font-size:12" ID="txtTableErr" readonly="readonly"></TEXTAREA></td>
      </tr>
      </table>
    </fieldset>
  </td></tr>
  <tr><td width="100%" align="center">
    <fieldset style="width:100%;text-align:center;font-size:12">
      <legend class="FormZName">任务列表</legend>
      <table align="center" width="100%">
      <tr>
         <td>
			<ai:table tableid="task" setname="com.ai.comframe.console.SETVmTask"
			tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
            implservice_name="com.ai.comframe.console.WorkflowConsole"
            implservice_querymethod="queryVmTask(long workflowId,int workflowState)"
            width="100%" initial="false" onrowchange="qryTaskTrans"
			height="150" pagesize="20" needrefresh="true" multiselect="false"  oncontextmenu="showTask"
			editable="false">
			<ai:col fieldname="TASK_ID" width="100" visible="true" />
			<ai:col fieldname="WORKFLOW_ID" width="165" visible="false" />
			<ai:col fieldname="TASK_TEMPLATE_ID" width="165" visible="false" />
			<ai:col fieldname="TASK_TYPE" width="80" visible="true" />
			<ai:col fieldname="LABEL" width="100" visible="true" />
			<ai:col fieldname="DECISION_RESULT" width="100" visible="true" />
			<ai:col fieldname="IS_CURRENT_TASK" width="100" />
			<ai:col fieldname="STATE" width="100" visible="true" />
			<ai:col fieldname="CREATE_DATE" width="130" visible="true" />
			<ai:col fieldname="STATE_DATE" width="130" visible="true" />
			<ai:col fieldname="FINISH_STAFF_ID" visible="true" />
			<ai:col fieldname="ERROR_MESSAGE" visible="true" />
			<ai:col fieldname="LOCK_STAFF_ID" visible="true" />
			<ai:col fieldname="LOCK_DATE" width="130" visible="true" />
			<ai:col fieldname="TASK_STAFF_ID" visible="true" />
			<ai:col fieldname="STATION_ID" visible="true" />
			<ai:col fieldname="WARNING_DATE" visible="true" />
			<ai:col fieldname="WARNING_TIMES" visible="true" />
			</ai:table>
  		</td>
  	</tr>
  <tr><td width="100%" align="center">
    <fieldset style="width:100%;text-align:center;font-size:12">
      <legend class="FormZName">分派任务列表</legend>
      <table align="center" width="100%">
      <tr>
         <td>
			<ai:table tableid="tasktrans" setname="com.ai.comframe.console.SETVmTaskTrans"
			tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
            implservice_name="com.ai.comframe.console.WorkflowConsole"
            implservice_querymethod="queryVmTaskTrans(long parentTaskId,long workflowId)"
            width="100%" initial="false"
			height="150" pagesize="20" needrefresh="true" multiselect="false"  oncontextmenu="showTaskTrans"
			editable="false">
			<ai:col fieldname="TASK_ID" width="100" visible="true" />
			<ai:col fieldname="PARENT_TASK_ID" width="100" visible="true" />
			<ai:col fieldname="WORKFLOW_ID" width="165" visible="false" />
			<ai:col fieldname="TASK_TYPE" width="80" visible="true" />
			<ai:col fieldname="LABEL" width="100" visible="true" />
			<ai:col fieldname="DECISION_RESULT" width="100" visible="true" />
			<ai:col fieldname="IS_CURRENT_TASK" width="100" />
			<ai:col fieldname="STATE" width="100" visible="true" />
			<ai:col fieldname="CREATE_DATE" width="130" visible="true" />
			<ai:col fieldname="STATE_DATE" width="130" visible="true" />
			<ai:col fieldname="FINISH_STAFF_ID" visible="true" />
			<ai:col fieldname="ERROR_MESSAGE" visible="true" />
			<ai:col fieldname="LOCK_STAFF_ID" visible="true" />
			<ai:col fieldname="LOCK_DATE" width="130" visible="true" />
			<ai:col fieldname="TASK_STAFF_ID" visible="true" />
			<ai:col fieldname="STATION_ID" visible="true" />
			<ai:col fieldname="WARNING_DATE" visible="true" />
			<ai:col fieldname="WARNING_TIMES" visible="true" />
			</ai:table>
  		</td>
  	</tr>
</table>
</fieldset>
</td>
</tr>
</table>
</body>
</html>

<script language="javascript">

//初始化时间显示
    init();
	var workflowTable = g_TableRowSetManager.get("workflowTable");
	var task = g_TableRowSetManager.get("task");
	var tasktrans = g_TableRowSetManager.get("tasktrans");
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
  	document.all.txtStartDate.value = current+" 00:00:00";
  	document.all.txtEndDate.value = current+" 23:59:59";
}

//双击工作流列表中某一条记录时，在task中显示相应的信息
	function query(){
  		var curRow = workflowTable.getRow();
		var task_id = workflowTable.getValue(curRow,"task_id");
		var workflowState = workflowTable.getValue(curRow,"STATE");
		var condition="workflowId="+task_id+"&workflowState="+workflowState;
		task.refresh(condition);
		g_TableRowSetManager.get("tasktrans").clear();
     }

//在工作流列表中单击某一条记录时，显示其中的Error Message
	function showSrvErrMsg(oldRowIndex,newRowIndex){
                query();
		document.all.txtTableErr.value = workflowTable.getValue(newRowIndex,"error_message");
    }

function qryTaskTrans(){
  var curRow = task.getRow();
  var taskId = task.getValue(curRow,"TASK_ID");
  var workflowId = task.getValue(curRow,"WORKFLOW_ID");
  var taskType = task.getValue(curRow,"TASK_TYPE");
  if(taskType != "user" && taskType != "sign"){
    return;
  }
  tasktrans.refresh("parentTaskId=-1&workflowId="+workflowId);
  
}

//查询

	function qry(){
  		var cond = "";
  		var workflow_object_id = document.all.txtBusiOrderId.value;
  		var workflow_object_type_id=g_getListBox("selBusiOrderType").getID();
  		var sDate = document.all.txtStartDate.value;
  		var eDate = document.all.txtEndDate.value;
  		var State = g_getListBox("lbxState").getID();
  		if(workflow_object_type_id == "-1"){
  		  workflow_object_type_id = "";
  		}
     	if(!g_IsDateTime(sDate)){
    		alert("请正确输入起始时间！");
    		document.all.txtStartDate.value = "";
    		document.all.txtStartDate.focus();
    		return;
  						}
  		if(!g_IsDateTime(eDate)){
    			alert("请正确输入截止时间！");
   				document.all.txtEndDate.value = "";
    			document.all.txtEndDate.focus();
    			return;
  					}
  		if(sDate!="" && eDate!="" && g_CompareDate(sDate ,eDate)=="1"){
   			 alert("起始时间不应大于截止时间！");
   			 return;
		}
		if(workflow_object_id == "" && workflow_object_type_id=="" && State == "-1" && sDate == "" && eDate == ""){
		  alert("请至少输入一个查询条件！");
    	  return;
		}
  		cond += "busiOrderId=" + workflow_object_id
  		      + "&busiOrderType="+ workflow_object_type_id
  		      + "&state="+State+"&startTime="+sDate+"&endTime="+eDate;
		g_TableRowSetManager.get("workflowTable").refresh(cond);
		document.all.txtTableErr.value = "";
		g_TableRowSetManager.get("task").clear();
		g_TableRowSetManager.get("tasktrans").clear();
		if(g_TableRowSetManager.get("workflowTable").count()==0){
		  alert("没有查到数据!");
		}

}

//工作流列表右键菜单
var popMenuWorkFlow =null;

  		function showWorkFlow(){
  		  taskHide();
  		  var index = g_TableRowSetManager.get("workflowTable").getRow();
	      if(index<0){
	        alert('请选中一个工作流实例！');
	        return;
	      }
	      var state= g_TableRowSetManager.get("workflowTable").getValue(index,"STATE");
          buildPopMenuWorkFlow(state);
          if(popMenuWorkFlow != null){
            popMenuWorkFlow.showPopMenu();
          }
		}
		function buildPopMenuWorkFlow(state ){
		 // alert(state);
		  var modelWorkFlow = new AIPopMenuModel();
		  var param ="flow_state="+state
		  var msg = PostInfo(_gModuleName+"/business/com.ai.comframe.console.action.WorkflowAction?action=getWorkflowPopMenu&"+param,"");
                 // alert(msg.getValueByName("MESSAGE"));
		  var strJosn = eval(msg.getValueByName("MESSAGE"));
		   for(var i=0; i<strJosn.length; i++){
		   //  alert(strJosn[i].id+"|"+strJosn[i].name+"|"+strJosn[i].func)
		     modelWorkFlow.addPopMenuItem(i,strJosn[i].name,null,strJosn[i].func);
		   }
   	           popMenuWorkFlow =new AIPopMenu(modelWorkFlow)
		   for(var i=0; i<strJosn.length; i++){
                     if(strJosn[i].enable =='false'){
                       //alert(strJosn[i].id +"：" + strJosn[i].enable);
                       popMenuWorkFlow.setItemEnabledById( i +"",false);
                     }
		   }
		}

//暂停工作流
function suspendWorkflow(){
	var index = g_TableRowSetManager.get("workflowTable").getRow();
	var taskId= g_TableRowSetManager.get("workflowTable").getValue(index,"TASK_ID");
	if (index<0){
		   alert("请先选中一行!");
		   return;
	}

	var rtn = saveRowSet('<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?action=suspendWorkflow&TASK_ID='+taskId,false);
	var ret = rtn.getValueByName("FLAG");
    if (ret == "INFO"){
         qry();
    }
}

//恢复工作流
function resumeWorkflow(){
	var index = g_TableRowSetManager.get("workflowTable").getRow();
	var taskId= g_TableRowSetManager.get("workflowTable").getValue(index,"TASK_ID");
	if (index<0){
		   alert("请先选中一行!");
		   return;
	}
	var rtn = saveRowSet('<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?action=resumeWorkflow&TASK_ID='+taskId,false);
	var ret = rtn.getValueByName("FLAG");
    if (ret == "INFO"){
         qry();
    }
}

//终止工作流
function terminateWorkflow(){
	var index = g_TableRowSetManager.get("workflowTable").getRow();
	var taskId= g_TableRowSetManager.get("workflowTable").getValue(index,"TASK_ID");
	if (index<0){
		   alert("请选择工作流实例!");
		   return;
	}
  if(!confirm("确定终止工作流?")){
    return;
  }
	var rtn = saveRowSet('<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?action=terminateWorkflow&TASK_ID='+taskId,false);
	var ret = rtn.getValueByName("FLAG");
    if (ret == "INFO"){
         qry();
    }
}
//停止工作流告警
function stopWarningWorkflow(){
	var index = g_TableRowSetManager.get("workflowTable").getRow();
	var taskId= g_TableRowSetManager.get("workflowTable").getValue(index,"TASK_ID");
	var warningTimes=g_TableRowSetManager.get("workflowTable").getValue(index,"WARNING_TIMES");
	var warningDate=g_TableRowSetManager.get("workflowTable").getValue(index,"WARNING_DATE");
	
	if (warningDate==null||warningDate=="null"||warningDate=="undefined"||warningDate==""){
		alert("当前工作流实例没有告警时间，不需要停止!");
		return;
	}
	if (warningTimes==null||warningTimes=="null"||warningTimes=="undefined"||warningTimes==""){
		warningTimes=0;
	}
	if (index<0){
		   alert("请选择工作流实例!");
		   return;
	}
  if(!confirm("确定停止对工作流的告警?")){
    return;
  }
	var rtn = saveRowSet('<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?action=stopWarning&TASK_ID='+taskId+'&WARNING_TIMES='+warningTimes+'&TYPE=workflow',false);
	var ret = rtn.getValueByName("FLAG");

    qry();
  
}
//删除流程数据
function dropWorkflow(){
	var index = g_TableRowSetManager.get("workflowTable").getRow();
	var taskId= g_TableRowSetManager.get("workflowTable").getValue(index,"TASK_ID");
	if (index<0){
		   alert("请选择工作流实例!");
		   return;
	}
  if(!confirm("确定删除流程数据?")){
    return;
  }
	var rtn =saveRowSet('<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?action=dropWorkflow&TASK_ID='+taskId,false);
	ret = rtn.getValueByName("FLAG");
	if (ret == "INFO"){
         qry();
    }

}

//生成SVG图
function toSvg(){
	var index = g_TableRowSetManager.get("workflowTable").getRow();
	var workflow_id= g_TableRowSetManager.get("workflowTable").getValue(index,"TASK_ID");
	if (index<0){
		   alert("请选择工作流实例!");
		   return;
	}

 	window.open("SvgView.jsp?workflow_id="+ workflow_id,"","scroll=yes,resizable=no,status=no,help=no,height=650px,width=720px");

}

//获取流程实例变量
function getWorkflowVars(){
var s=Math.random()*10000;
	var index = g_TableRowSetManager.get("workflowTable").getRow();

	if (index<0){
		   alert("请选择工作流实例!");
		   return;
	}

	var workflowId= g_TableRowSetManager.get("workflowTable").getValue(index,"TASK_ID");
	var templateCode= g_TableRowSetManager.get("workflowTable").getValue(index,"TASK_TAG");
	var url = "InstVars.jsp?showType=view&workflowId="+workflowId+"&templateCode="+templateCode+"&rand="+s;

	window.showModalDialog(url,null,"resizable:no;status:no;help:no;dialogHeight:400px;dialogWidth:600px");
}

//设置流程实例变量
function setWorkflowVars(){
	var s=Math.random()*10000;
	
	var index = g_TableRowSetManager.get("workflowTable").getRow();

	if (index<0){
		   alert("请选择工作流实例!");
		   return;
	}

	var workflowId= g_TableRowSetManager.get("workflowTable").getValue(index,"TASK_ID");
	var templateCode= g_TableRowSetManager.get("workflowTable").getValue(index,"TASK_TAG");
	var url = "InstVars.jsp?showType=edit&workflowId="+workflowId+"&templateCode="+templateCode+"&rand="+s;

	window.showModalDialog(url,null,"resizable:no;status:no;help:no;dialogHeight:400px;dialogWidth:600px");
}

//任务列表右键菜单
var popMenu = null;

document.onclick = taskHide;
  	//点击左键 菜单隐藏
		function taskHide(){
		    if(popMenuWorkFlow!=null)
		      popMenuWorkFlow.hidePopMenu();
		    if(popMenu!=null)
     		  popMenu.hidePopMenu();
     		  if(popMenuTrans != null){
     		    popMenuTrans.hidePopMenu();
     		  }
		}
		
  		//点击右键 显示右键菜单
		function showTask(){
		 taskHide();
		 var indexw = g_TableRowSetManager.get("workflowTable").getRow();
	     var workflowstate= g_TableRowSetManager.get("workflowTable").getValue(indexw,"STATE");
		 var index = g_TableRowSetManager.get("task").getRow();
	     if(index<0){
	       alert('请选择工作流任务实例！');
	       return;
	     }
	     var taskstate= g_TableRowSetManager.get("task").getValue(index,"STATE");
	      buildPopMenuTask(workflowstate,taskstate)
              if(popMenu != null){
                popMenu.showPopMenu();
              }
		}


        function buildPopMenuTask(workflowstate,state){

		  var modelTask = new AIPopMenuModel();
		  var param ="flow_state="+workflowstate+"&task_state="+state
		  var msg = PostInfo(_gModuleName+"/business/com.ai.comframe.console.action.WorkflowAction?action=getWorkflowTaskPopMenu&"+param,"");
		 // alert(msg.getValueByName("MESSAGE"));
		  var strJosn = eval(msg.getValueByName("MESSAGE"));
                    for(var i=0; i<strJosn.length; i++){
                     //alert(strJosn[i].id+"|"+strJosn[i].name+"|"+strJosn[i].func)
                      modelTask.addPopMenuItem(strJosn[i].id,strJosn[i].name,null,strJosn[i].func);
                    }
                    popMenu =new AIPopMenu(modelTask)
                    for(var i=0; i<strJosn.length; i++){
                     if(strJosn[i].enable =='false'){
                       popMenu.setItemEnabledById(strJosn[i].id,false);
                     }
		   }
	    }
//任务回单
function finishUserTask(){
var s=Math.random()*10000;
  var indexW = g_TableRowSetManager.get("workflowTable").getRow();
	if (indexW<0){
		   alert("请选择工作流实例!");
		   return;
	}
	var indexT = g_TableRowSetManager.get("task").getRow();
	if (indexT<0){
		   alert("请选择待回单的流程任务!");
		   return;
	}

	var taskId= g_TableRowSetManager.get("task").getValue(indexT,"TASK_ID");
	var state= g_TableRowSetManager.get("task").getValue(indexT,"STATE");

	var workflowId= g_TableRowSetManager.get("workflowTable").getValue(indexW,"TASK_ID");
	var templateCode= g_TableRowSetManager.get("workflowTable").getValue(indexW,"TASK_TAG");
	var url = "InstVars.jsp?showType=dealTask&workflowId="+workflowId+"&templateCode="+templateCode+"&rand="+s;

	var vars = window.showModalDialog(url,null,"resizable:no;status:no;help:no;dialogHeight:400px;dialogWidth:600px");
	if(vars == null){
	  return;
	}
	
	var dealResult=prompt("请输入回单结果:","");
	if(dealResult == null){
    return;
  }
  while(dealResult != null && dealResult.length == 0){
    alert("请输入回单结果!");
    dealResult = prompt("请输入回单结果:","");
  }

	var rtn = saveRowSet("<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?action=finishUserTask&taskId="+taskId+"&vars="+vars+"&result="+dealResult,false);
	var ret = rtn.getValueByName("FLAG");
  if (ret == "INFO"){
    qry();
  }
}
//停止任务告警
function stopWarningTask(){
	var indexW = g_TableRowSetManager.get("workflowTable").getRow();
	if (indexW<0){
		   alert("请选择工作流实例!");
		   return;
	}
	var indexT = g_TableRowSetManager.get("task").getRow();
	if (indexT<0){
		   alert("请选择需要停止告警的流程任务!");
		   return;
	}
	var taskId= g_TableRowSetManager.get("task").getValue(indexT,"TASK_ID");
	var warningTimes=g_TableRowSetManager.get("task").getValue(indexT,"WARNING_TIMES");
	var warningDate=g_TableRowSetManager.get("task").getValue(indexT,"WARNING_DATE");
	if (warningDate==null||warningDate=="null"||warningDate=="undefined"||warningDate==""){
		alert("当前任务没有告警时间，不需要停止!");
		return;
	}
	if (warningTimes==null||warningTimes=="null"||warningTimes=="undefined"||warningTimes==""){
		warningTimes=0;
	}
  if(!confirm("确定停止对流程任务的告警?")){
    return;
  }
	var rtn = saveRowSet('<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?action=stopWarning&TASK_ID='+taskId+'&WARNING_TIMES='+warningTimes+'&TYPE=task',false);
	var ret = rtn.getValueByName("FLAG");
    
    qry();

}
//锁定任务
function lockTask(){
	var index = g_TableRowSetManager.get("task").getRow();
	var taskId= g_TableRowSetManager.get("task").getValue(index,"TASK_ID");
	if (index<0){
		   alert("请选择工作流实例!");
		   return;
	}
	saveRowSet('<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?action=lockTask&TASK_ID='+taskId,false);


}

//释放锁定的任务
function releaseTask(){

	var index = g_TableRowSetManager.get("task").getRow();
	var taskId= g_TableRowSetManager.get("task").getValue(index,"TASK_ID");
	if (index<0){
		   alert("请选择工作流实例!");
		   return;
	}
	saveRowSet('<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?action=releaseTaskLock&TASK_ID='+taskId,false);

}
//跳转到指定任务
function jumpToTask(){
	var indexW = g_TableRowSetManager.get("workflowTable").getRow();
	if (indexW<0){
		   alert("请选择工作流实例!");	
		   return;
	}
	
	var indexT = g_TableRowSetManager.get("task").getRow();
	if (indexT<0){
		   alert("请选择待跳转的流程任务!");	
		   return;
	}
	var workflowId= g_TableRowSetManager.get("workflowTable").getValue(indexW,"TASK_ID");	
	var templateCode= g_TableRowSetManager.get("workflowTable").getValue(indexW,"TASK_TAG");
	var taskId= g_TableRowSetManager.get("task").getValue(indexT,"TASK_ID");	
	var state= g_TableRowSetManager.get("task").getValue(indexT,"STATE");

	var param = window.showModalDialog("GoBackTask.jsp?workflowId="+ workflowId+"&templateCode="+templateCode,null,"resizable:no;status:no;help:no;dialogHeight:750px;dialogWidth:630px");
	if(param == null){
	  return;
	}
	
	var dealInfo=prompt("请输入跳转原因:","");
	if(dealInfo == null){
    return;
  }
  while(dealInfo != null && dealInfo.length == 0){
    alert("请输入跳转原因!");
    dealInfo = prompt("请输入跳转原因:","");
  }
	var tmp = param.split("$$");
	var taskTemplateId = tmp[0];
	var vars = "";
	if(param.length > 1){
	  vars = tmp[1];
	}
	var url = "<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?action=jumpToTask"
	        + "&taskId="+taskId+"&taskTemplateId="+taskTemplateId+"&vars="+vars+"&notes="+dealInfo;
	var rtn = saveRowSet(url,false);
	var ret = rtn.getValueByName("FLAG");
  if (ret == "INFO"){
    qry();
  }
}
//回退到指定任务
function goBackToTask(){
	var indexW = g_TableRowSetManager.get("workflowTable").getRow();
	if (indexW<0){
		   alert("请选择工作流实例!");	
		   return;
	}
	
	var indexT = g_TableRowSetManager.get("task").getRow();
	if (indexT<0){
		   alert("请选择待回退的流程任务!");	
		   return;
	}
	var workflowId= g_TableRowSetManager.get("workflowTable").getValue(indexW,"TASK_ID");	
	var templateCode= g_TableRowSetManager.get("workflowTable").getValue(indexW,"TASK_TAG");
	var taskId= g_TableRowSetManager.get("task").getValue(indexT,"TASK_ID");	
	var state= g_TableRowSetManager.get("task").getValue(indexT,"STATE");

	var param = window.showModalDialog("GoBackTask.jsp?workflowId="+ workflowId+"&templateCode="+templateCode,null,"resizable:no;status:no;help:no;dialogHeight:750px;dialogWidth:630px");
	if(param == null){
	  return;
	}
	
	var dealInfo=prompt("请输入回退原因:","");
	if(dealInfo == null){
    return;
  }
  while(dealInfo != null && dealInfo.length == 0){
    alert("请输入回退原因!");
    dealInfo = prompt("请输入回退原因:","");
  }
	var tmp = param.split("$$");
	var taskTemplateId = tmp[0];
	var vars = "";
	if(param.length > 1){
	  vars = tmp[1];
	}
	var url = "<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?action=goBackToTask"
	        + "&taskId="+taskId+"&taskTemplateId="+taskTemplateId+"&vars="+vars+"&notes="+dealInfo;
	var rtn = saveRowSet(url,false);
	var ret = rtn.getValueByName("FLAG");
  if (ret == "INFO"){
    qry();
  }
}

//设置为已打印
function printUserTask(){
	var indexW = g_TableRowSetManager.get("workflowTable").getRow();
	if (indexW<0){
		   alert("请选择工作流实例!");	
		   return;
	}
	var indexT = g_TableRowSetManager.get("task").getRow();
	if (indexT<0){
		   alert("请选择待打单的流程任务!");	
		   return;
	}
	
	var taskId= g_TableRowSetManager.get("task").getValue(indexT,"TASK_ID");	
	var state= g_TableRowSetManager.get("task").getValue(indexT,"STATE");
		
	var workflowId= g_TableRowSetManager.get("workflowTable").getValue(indexW,"TASK_ID");	
	var templateCode= g_TableRowSetManager.get("workflowTable").getValue(indexW,"TASK_TAG");	
	var url = "InstVars.jsp?showType=dealTask&workflowId="+workflowId+"&templateCode="+templateCode;
	
	var vars = window.showModalDialog(url,null,"resizable:no;status:no;help:no;dialogHeight:400px;dialogWidth:600px");
	if(vars == null){
	  return;
	}
	
	var rtn = saveRowSet("<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?action=printUserTask&taskId="+taskId+"&vars="+vars,false);
	var ret = rtn.getValueByName("FLAG");
  if (ret == "INFO"){
    qry();
  }
}

//释放异常
function fireException(){
	var index = g_TableRowSetManager.get("task").getRow();
	var taskId= g_TableRowSetManager.get("task").getValue(index,"TASK_ID");
	if (index<0){
		   alert("请选择工作流任务实例!");
		   return;
	}
	var dealInfo=prompt("请输入异常原因编码:","");
	if(dealInfo == null){
    return;
  }
  while(dealInfo != null && dealInfo.length == 0){
    alert("请输入异常原因!");
    dealInfo = prompt("请输入异常原因编码:","");
  }
	var rtn = saveRowSet('<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?action=fireException&TASK_ID='+taskId+'&errorCode='+dealInfo,false);
  var ret = rtn.getValueByName("FLAG");
  if (ret == "INFO"){
    qry();
  }
}

//流程撤销
function cancelWorkflow(){
	var index = g_TableRowSetManager.get("workflowTable").getRow();
	var taskId= g_TableRowSetManager.get("workflowTable").getValue(index,"TASK_ID");
	if (index<0){
		   alert("请选择工作流实例!");
		   return;
	}
	var dealInfo=prompt("请输入异常原因编码:","");
	if(dealInfo == null){
    return;
  }
  while(dealInfo != null && dealInfo.length == 0){
    alert("请输入异常原因!");
    dealInfo = prompt("请输入异常原因编码:","");
  }
	var rtn = saveRowSet('<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?action=cancelWorkflow&TASK_ID='+taskId+'&errorCode='+dealInfo,false);
  var ret = rtn.getValueByName("FLAG");
  if (ret == "INFO"){
    qry();
  }
}

//再授权处理
function reAuthorizeTask(){
	var index = g_TableRowSetManager.get("task").getRow();
	if (index<0){
		   alert("请选择工作流任务实例!");
		   return;
	}
	
	var param = window.showModalDialog("StaffSelect.jsp",null,"resizable:no;status:no;help:no;dialogHeight:200px;dialogWidth:400px");
	if(param == null){
	  return;
	}
	if(!confirm("确定转派任务?")){
	  return;
	}
	
	var taskId= g_TableRowSetManager.get("task").getValue(index,"TASK_ID");
	
	var url = "<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?action=reAuthorizeTask&taskId="
	        + taskId + "&staffId="+param[0]+"&stationId="+param[1];
	var rtn = saveRowSet(url,false);
  var ret = rtn.getValueByName("FLAG");
  if (ret == "INFO"){
    qry();
  }
}

function resumeExceptionWorkflow(){
  var curRow = workflowTable.getRow();
  if(curRow<0){
    alert("请选择工作流实例!");
    return;
  }
  var state = workflowTable.getValue(curRow,"state");

  if(!confirm("确定重启此流程?")){
    return;
  }
  var workflow_id = workflowTable.getValue(curRow,"task_id");
  var param = "TASK_ID="+workflow_id;
  var msg = PostInfo(_gModuleName+"/business/com.ai.comframe.console.action.WorkflowAction?action=resumeExceptionWorkflow&"+param,"");
  var flag=msg.getValueByName("FLAG");
  if(flag=="INFO"){
	qry();
  }
  else{
	alert(msg.getValueByName("MESSAGE"));
  }
}

 function startExceptionWorkFlow(){
 	var index = g_TableRowSetManager.get("workflowTable").getRow();
	var taskId= g_TableRowSetManager.get("workflowTable").getValue(index,"TASK_ID");
	var state= g_TableRowSetManager.get("workflowTable").getValue(index,"STATE");
	
	var queueId =g_TableRowSetManager.get("workflowTable").getValue(index,"QUEUE_ID");
	var workFlowTypeId =g_TableRowSetManager.get("workflowTable").getValue(index,"WORKfLOW_OBJECT_TYPE_ID");
	var workFlowObjId =g_TableRowSetManager.get("workflowTable").getValue(index,"WORKfLOW_OBJECT_ID");
	var param ="?task_id="+taskId+"&workflow_obj_type="+workFlowTypeId+"&workflow_obj_id="+workFlowObjId;
	param =param+"&queue_id="+queueId;
	//alert(param);

    var rtn=window.showModalDialog("ManualStartExceptionWorkFlow.jsp"+param,window,"resizable:no;status:no;help:no;dialogHeight:585px;dialogWidth:600px");
    if (rtn == 1)
        qry();

  }
  
//任务列表右键菜单
var popMenuTrans = null;
		
//点击右键 显示右键菜单
function showTaskTrans(){

  taskHide();
		 var indexw = g_TableRowSetManager.get("workflowTable").getRow();
	     var workflowstate= g_TableRowSetManager.get("workflowTable").getValue(indexw,"STATE");
		 var index = g_TableRowSetManager.get("tasktrans").getRow();
	     if(index<0){
	       alert('请选择工作流任务实例！');
	       return;
	     }
	     var taskstate= g_TableRowSetManager.get("tasktrans").getValue(index,"STATE");
	      buildPopMenuTaskTrans(workflowstate,taskstate)
              if(popMenuTrans != null){
                popMenuTrans.showPopMenu();
              }
		}


        function buildPopMenuTaskTrans(workflowstate,state){

		  var modelTask = new AIPopMenuModel();
		  var param ="flow_state="+workflowstate+"&task_state="+state
		  var msg = PostInfo(_gModuleName+"/business/com.ai.comframe.console.action.WorkflowAction?action=getWorkflowTaskTransPopMenu&"+param,"");

		  var strJosn = eval(msg.getValueByName("MESSAGE"));
                    for(var i=0; i<strJosn.length; i++){
                   
                      modelTask.addPopMenuItem(strJosn[i].id,strJosn[i].name,null,strJosn[i].func);
                    }
                    popMenuTrans =new AIPopMenu(modelTask)
                    for(var i=0; i<strJosn.length; i++){
                     if(strJosn[i].enable =='false'){
                       popMenuTrans.setItemEnabledById(strJosn[i].id,false);
                     }
		   }
	    }

//设置为已打印
function printTaskTrans(){
	var indexW = g_TableRowSetManager.get("workflowTable").getRow();
	if (indexW<0){
		   alert("请选择工作流实例!");	
		   return;
	}
	var indexT = g_TableRowSetManager.get("tasktrans").getRow();
	if (indexT<0){
		   alert("请选择待打单的流程任务!");	
		   return;
	}
	
	var taskId= g_TableRowSetManager.get("tasktrans").getValue(indexT,"TASK_ID");	
	var state= g_TableRowSetManager.get("tasktrans").getValue(indexT,"STATE");
		
	var workflowId= g_TableRowSetManager.get("workflowTable").getValue(indexW,"TASK_ID");	
	var templateCode= g_TableRowSetManager.get("workflowTable").getValue(indexW,"TASK_TAG");	
	var url = "InstVars.jsp?showType=dealTask&workflowId="+workflowId+"&templateCode="+templateCode;
	
	var vars = window.showModalDialog(url,null,"resizable:no;status:no;help:no;dialogHeight:400px;dialogWidth:600px");
	if(vars == null){
	  return;
	}
	
	var rtn = saveRowSet("<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?action=printUserTask&taskId="+taskId+"&vars="+vars,false);
	var ret = rtn.getValueByName("FLAG");
  if (ret == "INFO"){
    qry();
  }
}

//任务回单
function finishTaskTrans(){
var s=Math.random()*10000;
  var indexW = g_TableRowSetManager.get("workflowTable").getRow();
	if (indexW<0){
		   alert("请选择工作流实例!");
		   return;
	}
	var indexT = g_TableRowSetManager.get("tasktrans").getRow();
	if (indexT<0){
		   alert("请选择待回单的流程任务!");
		   return;
	}

	var taskId= g_TableRowSetManager.get("tasktrans").getValue(indexT,"TASK_ID");
	var state= g_TableRowSetManager.get("tasktrans").getValue(indexT,"STATE");

	var workflowId= g_TableRowSetManager.get("workflowTable").getValue(indexW,"TASK_ID");
	var templateCode= g_TableRowSetManager.get("workflowTable").getValue(indexW,"TASK_TAG");
	var url = "InstVars.jsp?showType=dealTask&workflowId="+workflowId+"&templateCode="+templateCode+"&rand="+s;

	var vars = window.showModalDialog(url,null,"resizable:no;status:no;help:no;dialogHeight:400px;dialogWidth:600px");
	if(vars == null){
	  return;
	}
	
	var dealResult=prompt("请输入回单结果:","");
	if(dealResult == null){
    return;
  }
  while(dealResult != null && dealResult.length == 0){
    alert("请输入回单结果!");
    dealResult = prompt("请输入回单结果:","");
  }

	var rtn = saveRowSet("<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?action=finishUserTask&taskId="+taskId+"&vars="+vars+"&result="+dealResult,false);
	var ret = rtn.getValueByName("FLAG");
  if (ret == "INFO"){
    qry();
  }
}
//停止任务告警
function stopWarningTaskTrans(){
	var indexW = g_TableRowSetManager.get("workflowTable").getRow();
	if (indexW<0){
		   alert("请选择工作流实例!");
		   return;
	}
	var indexT = g_TableRowSetManager.get("tasktrans").getRow();
	if (indexT<0){
		   alert("请选择需要停止告警的流程任务!");
		   return;
	}
	var taskId= g_TableRowSetManager.get("tasktrans").getValue(indexT,"TASK_ID");
	var warningTimes=g_TableRowSetManager.get("tasktrans").getValue(indexT,"WARNING_TIMES");
	var warningDate=g_TableRowSetManager.get("tasktrans").getValue(indexT,"WARNING_DATE");
	if (warningDate==null||warningDate=="null"||warningDate=="undefined"||warningDate==""){
		alert("当前流程任务没有告警时间，不需要停止!");
		return;
	}
	if (warningTimes==null||warningTimes=="null"||warningTimes=="undefined"||warningTimes==""){
		warningTimes=0;
	}
  if(!confirm("确定停止对流程任务的告警?")){
    return;
  }
	var rtn = saveRowSet('<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?action=stopWarning&TASK_ID='+taskId+'&WARNING_TIMES='+warningTimes+'&TYPE=taskTrans',false);
	var ret = rtn.getValueByName("FLAG");
	
    qry();
}
function lockTaskTrans(){
	var index = g_TableRowSetManager.get("tasktrans").getRow();
	var taskId= g_TableRowSetManager.get("tasktrans").getValue(index,"TASK_ID");
	if (index<0){
		   alert("请选择工作流实例!");
		   return;
	}
	saveRowSet('<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?action=lockTask&TASK_ID='+taskId,false);


}

//释放锁定的流程
function releaseTaskTrans(){
	var index = g_TableRowSetManager.get("tasktrans").getRow();
	var taskId= g_TableRowSetManager.get("tasktrans").getValue(index,"TASK_ID");
	if (index<0){
		   alert("请选择工作流实例!");
		   return;
	}
	saveRowSet('<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?action=releaseTaskLock&TASK_ID='+taskId,false);
}

function reAuthorizeTaskTrans(){
  	var index = g_TableRowSetManager.get("tasktrans").getRow();
	if (index<0){
		   alert("请选择工作流任务实例!");
		   return;
	}
	
	var param = window.showModalDialog("StaffSelect.jsp",null,"resizable:no;status:no;help:no;dialogHeight:200px;dialogWidth:400px");
	if(param == null){
	  return;
	}
	if(!confirm("确定转派任务?")){
	  return;
	}
	
	var taskId= g_TableRowSetManager.get("tasktrans").getValue(index,"TASK_ID");
	
	var url = "<%=request.getContextPath()%>/business/com.ai.comframe.console.action.WorkflowAction?action=reAuthorizeTask&taskId="
	        + taskId + "&staffId="+param[0]+"&stationId="+param[1];
	var rtn = saveRowSet(url,false);
  var ret = rtn.getValueByName("FLAG");
  if (ret == "INFO"){
    qry();
  }
}
</script>
