<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/workflow/common/publicJSFunction.jsp" %>
<%
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
	String passInfo = "安全测试评审完成，代码扫描完成";
	String regnInfo = "转派其他相关人员进行此环节操作";
	String notPassInfo = "安全测试评审不通过，发送测试人员重新执行";
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
	<title>安全测试分配</title>
</head>
	<body style="padding:10px 0px 60px 10px">
		<div>
			<jsp:include page="/aiga/workflow/testPlan/TestSolidTaskForm.jsp">
				<jsp:param name="taskId" value="<%=objectId %>"/>
				<jsp:param name="taskTypeName" value="安全测试"/>
				<jsp:param name="templateId" value="21000"/>
				<jsp:param name="isEditor" value="false"/>
			</jsp:include>
			
			<!-- 操作区域浮动层 -->
			<!-- btmFixed -->
			<div class="btmFixed">
				<div class="btmFixedInner"></div>
				<div class="btmFixed_left" id="putongliucheng">
					<ul>
						<li title="<%=passInfo %>" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="setWOResult('pass')">
							<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/btm_agree.gif" /></span>
							<p>评审通过</p>
						</li>
						<li title="<%=passInfo %>" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="setWOResult('notPass')">
							<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/btm_disagree.gif" /></span>
							<p>评审驳回</p>
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
var current_linkNo = '<%=WorkflowParam.getWorkflow("secuTestVerify").getLinkNo()%>';
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
		stdMark='3';
	}else if(orderResult == 'regn'){
		next_linkId ='<%=WorkflowParam.getWorkflow("secuTestVerify").getLinkId()%>';
		next_linkNo = '<%=WorkflowParam.getWorkflow("secuTestVerify").getLinkNo()%>';
		next_roleCode = '<%=WorkflowParam.getWorkflow("secuTestVerify").getRoleCode()%>';
		stdMark='1';
	}else if(orderResult == 'notPass'){
		next_linkId ='<%=WorkflowParam.getWorkflow("secuTestRunning").getLinkId()%>';
		next_linkNo = '<%=WorkflowParam.getWorkflow("secuTestRunning").getLinkNo()%>';
		next_roleCode = '<%=WorkflowParam.getWorkflow("secuTestRunning").getRoleCode()%>';
		stdMark='3';
	}
	next_templateId = '21000';
}
var setWOResult = function(result){
	orderResult = result;
	chooseLinkInfo();
	
	if(orderResult == 'pass' || orderResult == 'notPass'){
		submitData();
	}else if(orderResult == 'regn'){
		SelectStaff.showWin(next_roleCode,'<%=user.getUserId()%>',-1,-1,2,false,stdMark,0);
	}
};

var afterSelect = function(staffs,option){
	if(stdMark == 1)
	{
		if(staffs==null || staffs=='')
			return;
	}
	var nextStaff = null;
    if(stdMark == 1)
    {
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
		if(stdMark == 1)
		{
			orderCond = setConds(orderCond,"staffId",staffs.staffId);
		}else if(stdMark == 3)
		{
			orderCond = setConds(orderCond,"staffId",'<%=user.getUserId()%>');
		}
		resultSelect = '<%=ConstDefine.WO_APPROVAL_RESULT_PASS%>';
	}else if(orderResult=='regn')
	{
		orderCond = setConds(orderCond,"staffId",staffs.staffId);
		resultSelect = '<%=ConstDefine.WO_APPROVAL_RESULT_NO_PASS%>';
	}else if(orderResult=='notPass')
	{
		orderCond = setConds(orderCond,"staffId",'<%=user.getUserId()%>');
		resultSelect = '<%=ConstDefine.WO_APPROVAL_RESULT_NO_PASS%>';
	}
	orderCond = setConds(orderCond,"result",orderResult);
		
	var submitJson = {};
	if(nextStaff != null)
		submitJson.stakeholder = [nextStaff];
	submitJson.orderDetail={conds:orderCond,opinion:option,orderId:<%=orderId%>,result:resultSelect};
	submitJson.objType= "<%=objectType%>";
	submitJson.solidTaskId="<%=objectId%>";	
	MaskLoading();
	Ext.Ajax.request({  
		method:'POST',
		url:"<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.aiga.web.TestPlanAction&action=orderSubmitPublicFun&jsonInfo="+Ext.encode(submitJson)
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

function submitData(){		
	if(orderResult=='pass')
	{
		if(stdMark == 3)
		{
			orderCond = setConds(orderCond,"staffId",'<%=user.getUserId()%>');
		}
		resultSelect = '<%=ConstDefine.WO_APPROVAL_RESULT_PASS%>';
	}else if(orderResult=='regn')
	{
		orderCond = setConds(orderCond,"staffId",staffs.staffId);
		resultSelect = '<%=ConstDefine.WO_APPROVAL_RESULT_NO_PASS%>';
	}else if(orderResult=='notPass')
	{
		orderCond = setConds(orderCond,"staffId",'<%=user.getUserId()%>');
		resultSelect = '<%=ConstDefine.WO_APPROVAL_RESULT_NO_PASS%>';
	}
	orderCond = setConds(orderCond,"result",orderResult);
		
	var submitJson = {};
	submitJson.orderDetail={conds:orderCond,opinion:"完成",orderId:<%=orderId%>,result:resultSelect};
	submitJson.objType= "<%=objectType%>";
	submitJson.solidTaskId="<%=objectId%>";	
	MaskLoading();
	Ext.Ajax.request({  
		method:'POST',
		url:"<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.aiga.web.TestPlanAction&action=orderSubmitPublicFun&jsonInfo="+Ext.encode(submitJson)
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
}
</script>
</html>