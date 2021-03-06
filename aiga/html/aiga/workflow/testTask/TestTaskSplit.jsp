<!DOCTYPE html>

<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/workflow/common/publicJSFunction.jsp" %>
<%
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
	String passInfo = "测试任务拆分";
	String regnInfo = "转派其他相关人员进行此环节操作";
	//工单Id
	String orderId = request.getParameter("orderId");
	//对象Id
	String objectId = request.getParameter("objId");
	//对象Type
	String objectType = request.getParameter("objType");
	System.out.println("objId="+objectId);
%>

<html>
<head>
	<title>测试任务拆分</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ie-tab.css">
	
</head>
	<body>
		<div>
			<jsp:include page="/aiga/workflow/testTask/TestTaskForm.jsp">
				<jsp:param name="taskId" value="<%=objectId %>"/>
			</jsp:include>
			
			<!-- 操作区域浮动层 -->
			<!-- btmFixed -->
			<div class="btmFixed">
				<div class="btmFixedInner"></div>
				<div class="btmFixed_left" id="putongliucheng">
					<ul>
						<li title="<%=passInfo %>" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="setWOResult('pass')">
							<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/upmng.gif" /></span>
							<p>分派</p>
						</li>
						<li title="<%=regnInfo %>" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="setWOResult('regn')">
							<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/turn.gif" /></span>
							<p>转派</p>
						</li>
					</ul>
				</div>
				<div class="btmFixed_right">
					<div class="processRight">
						<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/btm_process.gif"/></span>
						<p>查看流程</p>
					</div>
				</div>
			</div>
		</div>
     </body>
<script type="text/javascript">
//下一环节link信息
var	next_linkId ='';
var next_linkNo = '';
var	next_roleCode = '';
var next_templateId = '';

var current_linkNo = '<%=WorkflowParam.getWorkflow("testTaskSplit").getLinkNo()%>';

var orderResult = '';
var orderCond = '';
var resultSelect = '';

var stdMark1='';
var stdMark2='';
var subTaskIds = '';

//选择对应环节编号
function chooseLinkInfo(){
	if(orderResult == 'pass'){
		next_linkId ='<%=WorkflowParam.getWorkflow("testTaskRunning").getLinkId()%>';
		next_linkNo = '<%=WorkflowParam.getWorkflow("testTaskRunning").getLinkNo()%>';
		next_roleCode = '<%=WorkflowParam.getWorkflow("testTaskRunning").getRoleCode()%>';
		stdMark1 = '1';
		stdMark2 = '1';
	}else if(orderResult == 'regn'){
		next_linkId ='<%=WorkflowParam.getWorkflow("testTaskSplit").getLinkId()%>';
		next_linkNo = '<%=WorkflowParam.getWorkflow("testTaskSplit").getLinkNo()%>';
		next_roleCode = '<%=WorkflowParam.getWorkflow("testTaskSplit").getRoleCode()%>';
		stdMark1 = '1';
		stdMark2 = '0';
	}
	next_templateId = '30000';
}

function getSubTaskIds()
{
	var store = Ext.getCmp('subTaskGrid').getStore();

	for (var i = 0; i < store.getCount(); i++) 
	{        
		var record = store.getAt(i);   
		subTaskIds = subTaskIds + record.get('subTaskId') + ',';
    }
}

var setWOResult = function(result){
	orderResult = result;
	chooseLinkInfo();
	SelectStaff.showWin(next_roleCode,'<%=user.getUserId()%>',-1,-1,2,false,stdMark1,stdMark2);
};

var afterSelect = function(staffs,option){
	if(staffs==null || staffs=='')
		return;
	var nextStaff = null;
	var subTaskStaffs = null;
	var staffIds = "";
	var staffNos = "";
	var staffNames = "";
	if(orderResult == 'pass'){
		nextStaff = {linkId:next_linkId,
					linkNo:next_linkNo,
					templateId:next_templateId,
					stdholderStaffId:'<%=user.getUserId()%>',
					stdholderStaffNo:'<%=user.getUserAccount()%>',
					stdholderStaffName:'<%=user.getUserName()%>',
					stdholdeType:<%=IStakeholderType.STDHOLDETYPE_APPROVAL%>};
		for(var i=0;i<staffs.length;i++)
		{
			staffIds = staffIds + staffs[i].data.staffId  +  ";";
			staffNos = staffNos + staffs[i].data.staffCode  +  ";";
			staffNames = staffNames + staffs[i].data.staffName  +  ";";
		}
		subTaskStaffs = {taskId:"<%=objectId%>",
						 staffIds:staffIds,	
						 staffNos:staffNos,
						 staffNames:staffNames};
	}else if(orderResult == 'regn'){
		nextStaff = {linkId:next_linkId,
					linkNo:next_linkNo,
					templateId:next_templateId,
					stdholderStaffId:staffs.staffId,
					stdholderStaffNo:staffs.staffCode,
					stdholderStaffName:staffs.staffName,
					stdholdeType:<%=IStakeholderType.STDHOLDETYPE_APPROVAL%>};
	}
					
	if(orderResult=='pass')
	{
		orderCond = setConds(orderCond,"staffId",'<%=user.getUserId()%>');
		resultSelect = '<%=ConstDefine.WO_APPROVAL_RESULT_PASS%>';
	}else if(orderResult=='regn')
	{
		orderCond = setConds(orderCond,"staffId",staffs.staffId);
		resultSelect = '<%=ConstDefine.WO_APPROVAL_RESULT_PASS%>';
	}
	orderCond = setConds(orderCond,"result",orderResult);

	var submitJson = {};
	submitJson.stakeholder = [nextStaff];
	submitJson.orderDetail = {conds:orderCond,opinion:option,orderId:<%=orderId%>,result:resultSelect};
	submitJson.objType = "<%=objectType%>";
	submitJson.testTaskIds = "<%=objectId%>";	
	if(orderResult=='pass')
		submitJson.subTaskStaffs = [subTaskStaffs];
	MaskLoading();
	Ext.Ajax.request({  
		method:'POST',
		url:"<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.aiga.web.TestPlanAction&action=splitTestTaskToSubTask&jsonInfo="+Ext.encode(submitJson)
			+"&uid=<%=user.getUserAccount()%>" + "&",  
		success:function(response,config){
			var json =  Ext.JSON.decode(response.responseText);
			if(json.flag=="success"){
				MaskOver();
				top.Ext.Msg.alert("提示","操作成功!");
				window.parent.closeTab();
			}else{
				MaskOver();
				Ext.Msg.alert('提示','保存失败:'+json.flag);
			}
		},
		failure:function(response,config){
			MaskOver();
			Ext.Msg.alert('提示','保存失败');
		}
	});
//	alert(Ext.encode(submitJson));
};
</script>
</html>