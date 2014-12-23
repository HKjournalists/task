<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/workflow/common/publicJSFunction.jsp" %>
<%
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
	String passInfo = "指派完成";
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
	<title>性能子测试任务创建</title>
</head>
	<body style="padding:10px 0px 60px 10px">
		<div>
			<jsp:include page="/aiga/workflow/testTask/SubTaskForm.jsp">
				<jsp:param name="subTaskId" value="<%=objectId %>"/>
				<jsp:param name="flag" value="1"/>
			</jsp:include>
			
			<!-- 操作区域浮动层 -->
			<!-- btmFixed -->
			<div class="btmFixed">
				<div class="btmFixedInner"></div>
				<div class="btmFixed_left" id="putongliucheng">
					<ul>
						<li title="<%=passInfo %>" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="setWOResult('pass')">
							<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/upmng.gif" /></span>
							<p>完成</p>
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
var current_linkNo = '<%=WorkflowParam.getWorkflow("createPerfSubTest").getLinkNo()%>';

var	create_linkId = '<%=WorkflowParam.getWorkflow("createPerfSubTest").getLinkId()%>';
var create_linkNo = '<%=WorkflowParam.getWorkflow("createPerfSubTest").getLinkNo()%>';
var	create_roleCode = '<%=WorkflowParam.getWorkflow("createPerfSubTest").getRoleCode()%>';
var create_templateId = '<%=WorkflowParam.getWorkflow("createPerfSubTest").getTemplateId()%>';

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
		next_linkId ='<%=WorkflowParam.getWorkflow("perfSubTestAllot").getLinkId()%>';
		next_linkNo = '<%=WorkflowParam.getWorkflow("perfSubTestAllot").getLinkNo()%>';
		next_roleCode = '<%=WorkflowParam.getWorkflow("perfSubTestAllot").getRoleCode()%>';
	}
	next_templateId = '60000';
}

var setWOResult = function(result){
	orderResult = result;
	chooseLinkInfo();
	SelectStaff.showWin(next_roleCode,'<%=user.getUserId()%>',-1,-1,2,false,1,0);
};

function initConds()
{
	var allconds = "";
	allconds = setConds(allconds,"staffId","1");
	allconds = setConds(allconds,"orderType","1");
	allconds = setConds(allconds,"result","pass");
	return allconds;
}

var afterSelect = function(staffs,option){
	var nextStaff = {linkId:next_linkId,
					linkNo:next_linkNo,
					templateId:next_templateId,
					stdholderStaffId:staffs.staffId,
					stdholderStaffNo:staffs.staffCode,
					stdholderStaffName:staffs.employeeName,
					stdholdeType:<%=IStakeholderType.STDHOLDETYPE_APPROVAL%>};
	var submitStaff = {linkId:create_linkId,
					linkNo:create_linkNo,
					templateId:create_templateId,
					stdholderStaffId:'<%=user.getUserId()%>',
					stdholderStaffNo:'<%=user.getUserAccount()%>',
					stdholderStaffName:'<%=user.getUserName()%>',
					stdholdeType:<%=IStakeholderType.STDHOLDETYPE_APPROVAL%>};
					
	orderCond = initConds();
	if(orderResult=='pass')
	{
		orderCond = setConds(orderCond,"staffId",'<%=user.getUserId()%>');
		resultSelect = '<%=ConstDefine.WO_APPROVAL_RESULT_PASS%>';
	}
	orderCond = setConds(orderCond,"result",orderResult);
	if(option == null || option =="")
		return;
										
	var submitJson = {};
	submitJson.stakeholder=[nextStaff,submitStaff];
	submitJson.orderDetail={conds:orderCond,opinion:option,orderId:0,result:resultSelect};
	submitJson.perfSubTask={};
		
	var fields = Ext.getCmp('subTaskForm').getForm().getFields().items;
	for(var i=0,n=fields.length;i<n;i++){
		var field = fields[i].name;
		submitJson.perfSubTask[field]= Ext.getCmp('subTaskForm').getForm().findField(field).getValue();
	}
	MaskLoading();
	Ext.Ajax.request({  
		method:'POST',
		url:"<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.aiga.web.TestPlanAction&action=startPerfTaskWorkflow&jsonInfo="+Ext.encode(submitJson)+"&uid=<%=user.getUserAccount()%>",  
		success:function(response,config){
			MaskOver();
			reLoadOrderList(); 
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