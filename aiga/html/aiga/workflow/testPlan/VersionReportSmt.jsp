<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/workflow/common/publicJSFunction.jsp" %>
<%@ include file="/aiga/common/common.jsp" %>
<%
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
	String passInfo = "版本上线报告提交完成，进入上线评审";
	String regnInfo = "转派其他相关人员进行此环节操作";
	//工单Id
	String orderId = request.getParameter("orderId");
	//对象Id
	String objectId = request.getParameter("objId");
	//对象Type
	String objectType = request.getParameter("objType");
%>
<html>
<head>
	<title>版本报告提交</title>
</head>
	<body style="padding:10px 0px 60px 10px">
		<div>
			<jsp:include page="/aiga/workflow/testPlan/TestPlanForm.jsp">
				<jsp:param name="objId" value="<%=objectId %>"/>
				<jsp:param name="objType" value="<%=objectType %>"/>
				<jsp:param name="planFlag" value="1"/>
			</jsp:include>
			
			<!-- 操作区域浮动层 -->
			<!-- btmFixed -->
			<div class="btmFixed">
				<div class="btmFixedInner"></div>
				<div class="btmFixed_left" id="putongliucheng">
					<ul>
						<li title="<%=passInfo %>" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="setWOResult('pass')">
							<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/upmng.gif" /></span>
							<p>提交完成</p>
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
var current_linkNo = '<%=WorkflowParam.getWorkflow("versionReportSmt").getLinkNo()%>';

//下一环节link信息
var	next_linkId ='';
var next_linkNo = '';
var	next_roleCode = '';
var next_templateId = '';

var orderResult = '';
var orderCond = '';
var resultSelect = '';

//选择对应环节编号
function chooseLinkInfo(){
	if(orderResult == 'pass'){
		next_linkId ='<%=WorkflowParam.getWorkflow("onlineVerify").getLinkId()%>';
		next_linkNo = '<%=WorkflowParam.getWorkflow("onlineVerify").getLinkNo()%>';
		next_roleCode = '<%=WorkflowParam.getWorkflow("onlineVerify").getRoleCode()%>';
	}else if(orderResult == 'regn'){
		next_linkId ='<%=WorkflowParam.getWorkflow("versionReportSmt").getLinkId()%>';
		next_linkNo = '<%=WorkflowParam.getWorkflow("versionReportSmt").getLinkNo()%>';
		next_roleCode = '<%=WorkflowParam.getWorkflow("versionReportSmt").getRoleCode()%>';
	}
	next_templateId = '10000';
}
var setWOResult = function(result){
	orderResult = result;
	chooseLinkInfo();
	
	SelectStaff.showWin(next_roleCode,'<%=user.getUserId()%>',-1,-1,2,false,1,0);
};

var afterSelect = function(staffs,option){
	if(staffs==null&&staffs=='')
		return;
	newStaffId = staffs.staffId;
	var nextStaff = {linkId:next_linkId,
					linkNo:next_linkNo,
					templateId:next_templateId,
					stdholderStaffId:staffs.staffId,
					stdholderStaffNo:staffs.staffCode,
					stdholderStaffName:staffs.employeeName,
					stdholdeType:<%=IStakeholderType.STDHOLDETYPE_APPROVAL%>};
	if(orderResult=='pass')
	{
		orderCond = setConds(orderCond,"staffId",staffs.staffId);
		resultSelect = '<%=ConstDefine.WO_APPROVAL_RESULT_PASS%>';
	}else if(orderResult=='regn')
	{
		orderCond = setConds(orderCond,"staffId",staffs.staffId);
		resultSelect = '<%=ConstDefine.WO_APPROVAL_RESULT_PASS%>';
	}
	orderCond = setConds(orderCond,"result",orderResult);
	if(option == null || option =="")
		return;
		
	var submitJson = {};
	submitJson.stakeholder=[nextStaff];
	submitJson.orderDetail={conds:orderCond,opinion:option,orderId:<%=orderId%>,result:resultSelect};
	submitJson.objType= "<%=objectType%>";
	submitJson.testPlanId="<%=objectId%>";	

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