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
	<title>开单人修改</title>
</head>
	<body style="">
		<div>
			<jsp:include page="/aiga/workflow/perfTestTask/PerfTaskForm.jsp">
				<jsp:param name="flag" value="2"/>
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
							<p>任务结束</p>
						</li>
						<li title="<%=notPassInfo %>" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="setWOResult('notPass')">
							<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/upmng.gif" /></span>
							<p>重新发送</p>
						</li>
						<li title="<%=passInfo %>" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="savePerfTaskInro()">
							<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/btm_save.gif" /></span>
							<p>保存</p>
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
		stdMark='3';
	}else if(orderResult == 'notPass'){
		next_linkId ='<%=WorkflowParam.getWorkflow("factoryMgrRece").getLinkId()%>';
		next_linkNo = '<%=WorkflowParam.getWorkflow("factoryMgrRece").getLinkNo()%>';
		next_roleCode = '<%=WorkflowParam.getWorkflow("factoryMgrRece").getRoleCode()%>';
		stdMark='1';
	}
	next_templateId = '90000';
}


var setWOResult = function(result){
	orderResult = result;
	chooseLinkInfo();
	
	if(!savePerfTask())
  		return;
	if(orderResult == 'pass'){
		submitData();
	}else if(orderResult == 'notPass'){
		SelectStaff.showWin(next_roleCode,'<%=user.getUserId()%>',-1,-1,2,false,stdMark,0);
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
    
	}else if(orderResult == 'notPass')
    {
		nextStaff = {linkId:next_linkId,
					linkNo:next_linkNo,
					templateId:next_templateId,
					stdholderStaffId:staffs.staffId,
					stdholderStaffNo:staffs.staffCode,
					stdholderStaffName:staffs.staffName,
					stdholdeType:<%=IStakeholderType.STDHOLDETYPE_APPROVAL%>};
		newStaffId = staffs.staffId;
	}
	if(orderResult=='pass')
	{
		orderCond = setConds(orderCond,"staffId",submitStaffId);
		resultSelect = '<%=ConstDefine.WO_APPROVAL_RESULT_PASS%>';
	}else if(orderResult=='notPass')
	{
		orderCond = setConds(orderCond,"staffId",staffs.staffId);
		resultSelect = '<%=ConstDefine.WO_APPROVAL_RESULT_NO_PASS%>';
	}
	orderCond = setConds(orderCond,"result",orderResult);

	var submitJson = {};
	if(nextStaff!=null)
		submitJson.stakeholder=[nextStaff];
	submitJson.orderDetail={conds:orderCond,opinion:option,orderId:<%=orderId%>,result:resultSelect};
	submitJson.objType= "<%=objectType%>";
	submitJson.testTaskId="<%=objectId%>";	
	
	MaskLoading();
	Ext.Ajax.request({  
		method:'POST',
		url:"<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.aiga.web.TestPlanAction&action=orderSubmitPublicFun&jsonInfo="+Ext.encode(submitJson)
			+"&uid=<%=user.getUserAccount()%>" + "&",  
		success:function(response,config){
			var json =  Ext.JSON.decode(response.responseText);
			if(json.flag=="success"){
				MaskOver();
				top.Ext.Msg.alert('提示',"提交成功");
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

	if(orderResult=='pass')
	{
		orderCond = setConds(orderCond,"staffId",submitStaffId);
		resultSelect = '<%=ConstDefine.WO_APPROVAL_RESULT_PASS%>';
	}else if(orderResult=='notPass')
	{
		orderCond = setConds(orderCond,"staffId",staffs.staffId);
		resultSelect = '<%=ConstDefine.WO_APPROVAL_RESULT_NO_PASS%>';
	}
	orderCond = setConds(orderCond,"result",orderResult);

	var submitJson = {};
	submitJson.orderDetail={conds:orderCond,opinion:"完成",orderId:<%=orderId%>,result:resultSelect};
	submitJson.objType= "<%=objectType%>";
	submitJson.testTaskId="<%=objectId%>";	
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

function savePerfTaskInro(){
	var fields = Ext.getCmp('taskForm').getForm().getFields().items;
	for(var i=0,n=fields.length;i<n;i++){
		var field = fields[i].name;
		var xtype=Ext.getCmp('taskForm').getForm().findField(field).xtype;
		var value=Ext.getCmp('taskForm').getForm().findField(field).getValue();
		if(typeof(value)=='object'||typeof(value)=='undefined'||typeof(value)==undefined||(typeof(value)=='string'&&(value.trim()==''||value==undefined||value.trim()=='null'))){
			if(xtype!='checkbox'&&xtype!='hidden'&&Ext.getCmp('taskForm').getForm().findField(field).name!='planTag'){
				alert('【'+Ext.getCmp('taskForm').getForm().findField(field).fieldLabel+'】不能为空');
				return;
			}
		}
	}
	if(Ext.getCmp('taskForm').getForm().findField('taskName').getValue()==""){
		Ext.Msg.alert("提示","请填写测试任务名称");
		return false;
	}
	
	if(!savePerfTask())
  		return;
	
	var vRecords = Ext.getCmp('perfPanel').getStore().data.items; // 获取需要校验的数据数据   
  	if(vRecords.length < 1)
  	{
  		alert('性能指标必须大于一条');
  		return;
  	}
  	
  	

	var submitJson = {};
	submitJson.testTask={};
	var fields = Ext.getCmp('taskForm').getForm().getFields().items;
	for(var i=0,n=fields.length;i<n;i++){
		var field = fields[i].name;
		submitJson.testTask[field]= Ext.getCmp('taskForm').getForm().findField(field).getValue();
	}
		
	MaskLoading();
	Ext.Ajax.request({  
		method:'POST',
		url:"<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.aiga.web.TestPlanAction&action=savePerfTestTaskWorkflow&jsonInfo="+Ext.encode(submitJson)+"&uid=<%=user.getUserAccount()%>",  
		success:function(response,config){
			var json =  Ext.JSON.decode(response.responseText);
			if(json.flag=="success"){
				MaskOver();
				alert("保存成功");
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