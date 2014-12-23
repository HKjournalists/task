<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/workflow/common/publicJSFunction.jsp" %>
<%
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
	String passInfo = "启动性能测试任务流程";
	
	String planFlag = request.getParameter("planFlag");
	String objId = request.getParameter("objId");
	//对象Type
	String objectType = request.getParameter("objType");
	String startTaskId = request.getParameter("startTaskId");
	String includeHead = request.getParameter("includeHead");

%>
<html>
<head>
	<title>性能测试任务启动</title>
</head>
	<body style="">
		<div style="">
			<jsp:include page="/aiga/workflow/perfTestTask/PerfTaskForm.jsp">
				<jsp:param name="flag" value="0"/>
				<jsp:param name="hide" value="true"/>
			</jsp:include>
			
			<!-- 操作区域浮动层 -->
			<!-- btmFixed -->
			<div class="btmFixed">
				<div class="btmFixedInner"></div>
				<div class="btmFixed_left" id="putongliucheng">
					<ul>
						<li title="<%=passInfo %>" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="setWOResult('pass')">
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
var current_linkNo = '<%=WorkflowParam.getWorkflow("createPerfTestTask").getLinkNo()%>';

var	next_linkId ='';
var next_linkNo = '';
var	next_roleCode = '';
var next_templateId = '';

var	create_linkId = '<%=WorkflowParam.getWorkflow("createPerfTestTask").getLinkId()%>';
var create_linkNo = '<%=WorkflowParam.getWorkflow("createPerfTestTask").getLinkNo()%>';
var	create_roleCode = '<%=WorkflowParam.getWorkflow("createPerfTestTask").getRoleCode()%>';
var create_templateId = '<%=WorkflowParam.getWorkflow("createPerfTestTask").getTemplateId()%>';

next_linkId ='<%=WorkflowParam.getWorkflow("factoryMgrRece").getLinkId()%>';
next_linkNo = '<%=WorkflowParam.getWorkflow("factoryMgrRece").getLinkNo()%>';
next_roleCode = '<%=WorkflowParam.getWorkflow("factoryMgrRece").getRoleCode()%>';
next_templateId = '<%=WorkflowParam.getWorkflow("factoryMgrRece").getTemplateId()%>';
		
var orderResult = '';
var orderCond = '';
var resultSelect = '';
var testTaskIds = '';

var setWOResult = function(result){
	staffSelect="submitInfo";
	
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
	
	
	var vRecords = Ext.getCmp('perfPanel').getStore().data.items; // 获取需要校验的数据数据   
  	if(vRecords.length < 1)
  	{
  		alert('性能指标必须大于一条');
  		return;
  	}
  	if(!savePerfTask())
  		return;
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
	var taskForm =Ext.getCmp("taskForm").getForm();
    if(staffSelect=="req"){
    	taskForm.findField("reqPersion").setValue(staffs.employeeName);
    }else{
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
						stdholderStaffId:staffs.staffId,
						stdholderStaffNo:staffs.staffCode,
						stdholderStaffName:staffs.staffName,
						stdholdeType:<%=IStakeholderType.STDHOLDETYPE_APPROVAL%>};
						
		orderCond = initConds();
		if(orderResult=='pass')
		{
			orderCond = setConds(orderCond,"staffId",'<%=user.getUserId()%>');
			resultSelect = '<%=ConstDefine.WO_APPROVAL_RESULT_PASS%>';
		}
		orderCond = setConds(orderCond,"result",orderResult);
					
		var submitJson = {};
		submitJson.stakeholder=[createStaff,nextStaff];
		submitJson.orderDetail={conds:orderCond,opinion:option,orderId:0,result:resultSelect};
		submitJson.testTask={};
		submitJson.startTaskId='<%=startTaskId%>';
		
		var fields = Ext.getCmp('taskForm').getForm().getFields().items;
		for(var i=0,n=fields.length;i<n;i++){
			var field = fields[i].name;
			submitJson.testTask[field]= Ext.getCmp('taskForm').getForm().findField(field).getValue();
		}
			
		MaskLoading();
		Ext.Ajax.request({  
			method:'POST',
			url:"<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.aiga.web.TestPlanAction&action=startPerfTestTaskWorkflow&jsonInfo="+Ext.encode(submitJson)+"&uid=<%=user.getUserAccount()%>",  
			success:function(response,config){
				var json =  Ext.JSON.decode(response.responseText);
				if(json.flag=="success"){
					var json =  Ext.JSON.decode(response.responseText);
					if(json.flag=="success"){
						MaskOver();
						top.Ext.Msg.alert("提示","启动成功!");
						window.parent.Ext.getCmp('perfTaskFormWin').close();
					}else{
						MaskOver();
						Ext.Msg.alert('提示','保存失败:'+json.flag);
					}
					
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
	//alert(Ext.encode(submitJson));
};

</script>
</html>