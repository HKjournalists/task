<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/workflow/common/publicJSFunction.jsp" %>
<%
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
	String passInfo = "启动用户体验测试任务流程";
	
	String planFlag = request.getParameter("planFlag");
	String objId = request.getParameter("objId");
	//对象Type
	String objectType = request.getParameter("objType");
	String startTaskId = request.getParameter("startTaskId");
	System.out.println("startTaskId="+startTaskId);
	String includeHead = request.getParameter("includeHead");

%>
<html>
<head>
	<title>测试任务启动</title>
</head>
	<body style="">
		<div style="">
			<jsp:include page="/aiga/workflow/testPlan/P2PTaskForm.jsp">
				<jsp:param name="flag" value="0"/>
				<jsp:param name="hide" value="true"/>
			</jsp:include>
			
			<!-- 操作区域浮动层 -->
			<!-- btmFixed -->
			<div class="btmFixed" style="bottom: 44px; /**fix ifreame bug**/">
				<div class="btmFixedInner"></div>
				<div class="btmFixed_left" id="putongliucheng">
					<ul>
						<li title="<%=passInfo %>" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="startUpTestTaskWF()">
							<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/upmng.gif" /></span>
							<p>启动</p>
						</li>
					</ul>
				</div>
			</div>
		</div>
     </body>
<script type="text/javascript">
//下一环节link信息
var current_linkNo = '<%=WorkflowParam.getWorkflow("createUETTask").getLinkNo()%>';

var	next_linkId ='';
var next_linkNo = '';
var	next_roleCode = '';
var next_templateId = '';

var	create_linkId = '<%=WorkflowParam.getWorkflow("createUETTask").getLinkId()%>';
var create_linkNo = '<%=WorkflowParam.getWorkflow("createUETTask").getLinkNo()%>';
var	create_roleCode = '<%=WorkflowParam.getWorkflow("createUETTask").getRoleCode()%>';
var create_templateId = '<%=WorkflowParam.getWorkflow("createUETTask").getTemplateId()%>';

next_linkId ='<%=WorkflowParam.getWorkflow("uetTaskRunning").getLinkId()%>';
next_linkNo = '<%=WorkflowParam.getWorkflow("uetTaskRunning").getLinkNo()%>';
next_roleCode = '<%=WorkflowParam.getWorkflow("uetTaskRunning").getRoleCode()%>';
next_templateId = '<%=WorkflowParam.getWorkflow("uetTaskRunning").getTemplateId()%>';
		
var orderResult = '';
var orderCond = '';
var resultSelect = '';
var testTaskIds = '';

function startUpTestTaskWF(){
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
	var createStaff = {linkId:create_linkId,
					linkNo:create_linkNo,
					templateId:create_templateId,
					stdholderStaffId:'<%=user.getUserId()%>',
					stdholderStaffNo:'<%=user.getUserAccount()%>',
					stdholderStaffName:'<%=user.getUserName()%>',
					stdholdeType:<%=IStakeholderType.STDHOLDETYPE_APPROVAL%>};
	var nextStaff = {linkId:next_linkId,
					linkNo:next_linkNo,
					templateId:next_templateId,
					stdholderStaffId:'<%=user.getUserId()%>',
					stdholderStaffNo:'<%=user.getUserAccount()%>',
					stdholderStaffName:'<%=user.getUserName()%>',
					stdholdeType:<%=IStakeholderType.STDHOLDETYPE_APPROVAL%>};
	var submitJson = {};
	submitJson.testTask={};
	submitJson.stakeholder=[nextStaff,createStaff];
	submitJson.startTaskId='<%=startTaskId%>';

	for(var i=0,n=fields.length;i<n;i++){
		var field = fields[i].name;
		submitJson.testTask[field]= Ext.getCmp('taskForm').getForm().findField(field).getValue();
	}
	MaskLoading();
	Ext.Ajax.request({ 
		async:false, 
		method:'POST',
		url:"<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.aiga.web.TestPlanAction&action=startUETTaskWorkflow&jsonInfo="+Ext.encode(submitJson)
			+"&uid=<%=user.getUserAccount()%>" + "&",  
		success:function(response,config){
			var json =  Ext.JSON.decode(response.responseText);
			if(json.flag=="success"){
				MaskOver();
				alert("启动成功");
				//window.location.href = '<%=request.getContextPath()%>/aiga/workflow/common/WorkorderList.jsp';
				window.parent.Ext.getCmp('p2pTaskFormWin').close();
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