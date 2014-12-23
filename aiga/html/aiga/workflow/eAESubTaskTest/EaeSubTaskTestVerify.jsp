<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/workflow/common/publicJSFunction.jsp" %>
<%
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
	String passInfo = "审核通过，进入准生产环境测试";
	String notPassInfo = "审核不通过，重新进行测试设计";
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
	<title>端到端子任务测试审核</title>
</head>
	<body style="padding:10px 0px 60px 10px">
		<div>
			<jsp:include page="/aiga/workflow/P2PSubTaskAnalysis.jsp">
				<jsp:param name="objId" value="<%=objectId %>"/>
			</jsp:include>
			<jsp:include page="/aiga/workflow/common/SelectStaff.jsp"></jsp:include>
			<!-- 操作区域浮动层 -->
			<!-- btmFixed -->
			<div class="btmFixed">
				<div class="btmFixedInner"></div>
				<div class="btmFixed_left" id="putongliucheng">
					<ul>
						<li title="<%=passInfo %>" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="setWOResult('pass')">
							<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/btm_agree.gif" /></span>
							<p>审核通过</p>
						</li>
						<li title="<%=notPassInfo %>" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="setWOResult('notPass')">
							<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/btm_disagree.gif" /></span>
							<p>审核驳回</p>
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
var current_linkNo = '<%=WorkflowParam.getWorkflow("eaeSubTaskTestVerify").getLinkNo()%>';
//下一环节link信息
var	next_linkId ='';
var next_linkNo = '';
var	next_roleCode = '';
var next_templateId = '';

var orderResult = '';
var orderCond = '';
var resultSelect = '';

var stdMark='';
var subTaskIds = '';

//选择对应环节编号
function chooseLinkInfo(){
	if(orderResult == 'pass'){
		next_linkId ='<%=WorkflowParam.getWorkflow("eaeSubTaskTestFunc").getLinkId()%>';
		next_linkNo = '<%=WorkflowParam.getWorkflow("eaeSubTaskTestFunc").getLinkNo()%>';
		next_roleCode = '<%=WorkflowParam.getWorkflow("eaeSubTaskTestFunc").getRoleCode()%>';
		stdMark='1';
	}else if(orderResult == 'regn'){
		next_linkId ='<%=WorkflowParam.getWorkflow("eaeSubTaskTestVerify").getLinkId()%>';
		next_linkNo = '<%=WorkflowParam.getWorkflow("eaeSubTaskTestVerify").getLinkNo()%>';
		next_roleCode = '<%=WorkflowParam.getWorkflow("eaeSubTaskTestVerify").getRoleCode()%>';
		stdMark='1';
	}else if(orderResult == 'notPass'){
		next_linkId ='<%=WorkflowParam.getWorkflow("eaeSubTaskTestDsgn").getLinkId()%>';
		next_linkNo = '<%=WorkflowParam.getWorkflow("eaeSubTaskTestDsgn").getLinkNo()%>';
		next_roleCode = '<%=WorkflowParam.getWorkflow("eaeSubTaskTestDsgn").getRoleCode()%>';
		stdMark='3';
	}
	next_templateId = '50000';
}

var setWOResult = function(result){
	orderResult = result;
	chooseLinkInfo();
	
	SelectStaff.showWin(next_roleCode,'<%=user.getUserId()%>',-1,-1,2,false,stdMark,0);
	
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
					stdholderStaffName:staffs.employeeName,
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
	if(option == null || option =="")
		return;
		
	var submitJson = {};
	if(nextStaff != null)
		submitJson.stakeholder = [nextStaff];
	submitJson.orderDetail = {conds:orderCond,opinion:option,orderId:<%=orderId%>,result:resultSelect};
	submitJson.objType = "<%=objectType%>";
	submitJson.subTaskId = "<%=objectId%>";	
	funSub();
	MaskLoading();
	Ext.Ajax.request({  
		method:'POST',
		url:"<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.aiga.web.TestPlanAction&action=orderSubmitPublicFun&jsonInfo="+Ext.encode(submitJson)
			+"&uid=<%=user.getUserAccount()%>" + "&",  
		success:function(response,config){
			MaskOver();
			window.parent.closeTab();
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