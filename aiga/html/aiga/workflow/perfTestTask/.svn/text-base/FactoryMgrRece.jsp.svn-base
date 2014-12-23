<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/workflow/common/publicJSFunction.jsp" %>
<%
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
	String passInfo = "接收性能测试任务并将此任务提交接口人进行处理";
	String notPassInfo = "性能测试不合理，返回开单人确认";
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
	<title>局方性能测试任务评审</title>
</head>
	<body style="">
		<div>
			<jsp:include page="/aiga/workflow/perfTestTask/PerfTaskForm.jsp">
				<jsp:param name="flag" value="1"/>
				<jsp:param name="hide" value="true"/>
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
							<p>评审通过</p>
						</li>
						<li title="<%=notPassInfo %>" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="setWOResult('notPass')">
							<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/upmng.gif" /></span>
							<p>评审驳回</p>
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
var current_linkNo = '<%=WorkflowParam.getWorkflow("factoryMgrRece").getLinkNo()%>';
//下一环节link信息
var	next_linkId ='';
var next_linkNo = '';
var	next_roleCode = '';
var next_templateId = '';

var orderResult = '';
var orderCond = '';
var resultSelect = '';
var stdMark='';

//选择对应环节编号
function chooseLinkInfo(){
	if(orderResult == 'pass'){
		next_linkId ='<%=WorkflowParam.getWorkflow("interfaceAllot").getLinkId()%>';
		next_linkNo = '<%=WorkflowParam.getWorkflow("interfaceAllot").getLinkNo()%>';
		next_roleCode = '<%=WorkflowParam.getWorkflow("interfaceAllot").getRoleCode()%>';
		stdMark='1';
	}else if(orderResult == 'notPass'){
		next_linkId ='<%=WorkflowParam.getWorkflow("drafterModify").getLinkId()%>';
		next_linkNo = '<%=WorkflowParam.getWorkflow("drafterModify").getLinkNo()%>';
		next_roleCode = '<%=WorkflowParam.getWorkflow("drafterModify").getRoleCode()%>';
		stdMark='3';
	}
	next_templateId = '90000';
}

var setWOResult = function(result){
	orderResult = result;
	chooseLinkInfo();
	
	if(orderResult == 'pass'){
		SelectStaff.showWin(next_roleCode,'<%=user.getUserId()%>',-1,-1,2,false,stdMark,0);
	}else if(orderResult == 'notPass'){
		submitData();
	}
};

var afterSelect = function(staffs,option){
	var submitStaffId = Ext.getCmp('taskForm').getForm().findField('submitStaffId').getValue();
    var submitStaffName = Ext.getCmp('taskForm').getForm().findField('submitStaffName').getValue();
	if(staffs==null&&staffs=='')
		return;

	var nextStaff = null;
	if(orderResult == 'pass')
    {
		nextStaff = {linkId:next_linkId,
					linkNo:next_linkNo,
					templateId:next_templateId,
					stdholderStaffId:staffs.staffId,
					stdholderStaffNo:staffs.staffCode,
					stdholderStaffName:staffs.staffName,
					stdholdeType:<%=IStakeholderType.STDHOLDETYPE_APPROVAL%>};
		newStaffId = staffs.staffId;
	}else if(orderResult == 'notPass')
    {
		nextStaff = {linkId:next_linkId,
					linkNo:next_linkNo,
					templateId:next_templateId,
					stdholderStaffId:submitStaffId,
					stdholderStaffName:submitStaffName,
					stdholdeType:<%=IStakeholderType.STDHOLDETYPE_APPROVAL%>};
		newStaffId = submitStaffId;
	}
	if(orderResult=='pass')
	{
		orderCond = setConds(orderCond,"staffId",staffs.staffId);
		resultSelect = '<%=ConstDefine.WO_APPROVAL_RESULT_PASS%>';
	}else if(orderResult=='notPass')
	{
		orderCond = setConds(orderCond,"staffId",submitStaffId);
		resultSelect = '<%=ConstDefine.WO_APPROVAL_RESULT_PASS%>';
	}
	orderCond = setConds(orderCond,"result",orderResult);

	var submitJson = {};
	submitJson.stakeholder=[nextStaff];
	submitJson.orderDetail={conds:orderCond,opinion:option,orderId:<%=orderId%>,result:resultSelect};
	submitJson.objType= "<%=objectType%>";
	submitJson.testTaskId="<%=objectId%>";	
	var urlString = "";
	if(orderResult=='pass')
	{
		submitJson.distribute={distributeStaffId:staffs.staffId,distributeStaffName:staffs.staffName};
		urlString = "<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.aiga.web.TestPlanAction&action=perfSubTaskFunctionSub&jsonInfo="+Ext.encode(submitJson)
			+"&uid=<%=user.getUserAccount()%>" + "&";
	}else if(orderResult=='notPass')
	{
		urlString = "<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.aiga.web.TestPlanAction&action=orderSubmitPublicFun&jsonInfo="+Ext.encode(submitJson)
			+"&uid=<%=user.getUserAccount()%>" + "&";
	}
	MaskLoading();
	Ext.Ajax.request({  
		method:'POST',
		url:urlString,  
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

function submitData(){
	var submitStaffId = Ext.getCmp('taskForm').getForm().findField('submitStaffId').getValue();
    var submitStaffName = Ext.getCmp('taskForm').getForm().findField('submitStaffName').getValue();

	var nextStaff = null;
	if(orderResult == 'notPass')
    {
		nextStaff = {linkId:next_linkId,
					linkNo:next_linkNo,
					templateId:next_templateId,
					stdholderStaffId:submitStaffId,
					stdholderStaffName:submitStaffName,
					stdholdeType:<%=IStakeholderType.STDHOLDETYPE_APPROVAL%>};
	}
	if(orderResult=='notPass')
	{
		orderCond = setConds(orderCond,"staffId",submitStaffId);
		resultSelect = '<%=ConstDefine.WO_APPROVAL_RESULT_PASS%>';
	}
	orderCond = setConds(orderCond,"result",orderResult);

	var submitJson = {};
	submitJson.stakeholder=[nextStaff];
	submitJson.orderDetail={conds:orderCond,opinion:"完成",orderId:<%=orderId%>,result:resultSelect};
	submitJson.objType= "<%=objectType%>";
	submitJson.testTaskId="<%=objectId%>";	
	var urlString = "";
	if(orderResult=='notPass')
	{
		urlString = "<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.aiga.web.TestPlanAction&action=orderSubmitPublicFun&jsonInfo="+Ext.encode(submitJson)
			+"&uid=<%=user.getUserAccount()%>" + "&";
	}
	MaskLoading();
	Ext.Ajax.request({  
		method:'POST',
		url:urlString,  
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
}
</script>
</html>