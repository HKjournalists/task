<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");%>
<%@ include file="/aiga/common/common.jsp" %>
<%
	String planFlag = "0";
	if(request.getParameter("objId")!=null && !request.getParameter("objId").equals(""))
		planFlag = "3";
	System.out.println("planFlag="+planFlag);
	String workOrderFlag = request.getParameter("workOrderFlag");//判断是否为在待办工单列表中打开的界面
	String createTestPlanFlag = request.getParameter("createTestPlanFlag");//判断是否为创建测试计划
 %>
<jsp:include page="/aiga/workflow/common/publicJSFunction.jsp">
	<jsp:param name="workOrderFlag" value="<%=workOrderFlag %>"/>
</jsp:include>
<html>
<head>
	<title>创建测试计划</title>
</head>
	<body style="">
		<div>
			<jsp:include page="/aiga/workflow/testPlan/TestPlanForm.jsp">
				<jsp:param name="planFlag" value="<%=planFlag %>"/>
				<jsp:param name="createTestPlanFlag" value="<%=createTestPlanFlag %>"/>
			</jsp:include>
			<div style="width:0px; height:56px"></div>
			
			<!-- 操作区域浮动层 -->
			<!-- btmFixed -->
			<div class="btmFixed">
				<div class="btmFixedInner"></div>
				<div class="btmFixed_left" id="putongliucheng">
					<%if(!(createTestPlanFlag!=null&&createTestPlanFlag.equals("1"))){
						%>
					<ul>
						<li title="" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="setWOResult('pass')">
							<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/upmng.gif" /></span>
							<p>启动</p>
						</li>
					</ul>	
						<%
					} %>
					<ul>
						<li title="" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="saveTestPlan()">
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
//创建环节信息
var current_linkNo = '<%=WorkflowParam.getWorkflow("createTestPlan").getLinkNo()%>';

var	create_linkId = '<%=WorkflowParam.getWorkflow("createTestPlan").getLinkId()%>';
var create_linkNo = '<%=WorkflowParam.getWorkflow("createTestPlan").getLinkNo()%>';
var	create_roleCode = '<%=WorkflowParam.getWorkflow("createTestPlan").getRoleCode()%>';
var create_templateId = '<%=WorkflowParam.getWorkflow("createTestPlan").getTemplateId()%>';
//下一环节link信息
var	next_linkId ='';
var next_linkNo = '';
var	next_roleCode = '';
var next_templateId = '';

var orderResult = '';
var orderCond = '';
var resultSelect = '';
var testTaskIds = '';

function getTestTaskIds()
{
	var store = Ext.getCmp('taskGrid').getStore();

	for (var i = 0; i < store.getCount(); i++) 
	{        
		var record = store.getAt(i);   
		testTaskIds = testTaskIds + record.get('taskId') + ',';
    }
}

//选择对应环节编号
function chooseLinkInfo(){
	if(orderResult == 'pass'){
		next_linkId ='<%=WorkflowParam.getWorkflow("planRunning").getLinkId()%>';
		next_linkNo = '<%=WorkflowParam.getWorkflow("planRunning").getLinkNo()%>';
		next_roleCode = '<%=WorkflowParam.getWorkflow("planRunning").getRoleCode()%>';
	}
	next_templateId = '10000';
}


var setWOResult = function(result){
	orderResult = result;
	chooseLinkInfo();
	if(!confirm("版本测试任务选择是否确定完成？"))
		return;
	submitData();
	//SelectStaff.showWin(next_roleCode,'<%=user.getUserId()%>',-1,-1,2,false,3,0);
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
	//if(staffs==null&&staffs=='')
	//	return;
	var nextStaff = {linkId:next_linkId,
					linkNo:next_linkNo,
					templateId:next_templateId,
					stdholderStaffId:'<%=user.getUserId()%>',
					stdholderStaffNo:'<%=user.getUserAccount()%>',
					stdholderStaffName:'<%=user.getUserName()%>',
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
	submitJson.testPlan={};
	
	getTestTaskIds();
	submitJson.testTaskIds= testTaskIds;
	
	var fields = Ext.getCmp('testPlanForm').getForm().getFields().items;
	for(var i=0,n=fields.length;i<n;i++){
		var field = fields[i].name;
		submitJson.testPlan[field]= Ext.getCmp('testPlanForm').getForm().findField(field).getValue();
	}
	MaskLoading();
	Ext.Ajax.request({  
		method:'POST',
		url:"<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.aiga.web.TestPlanAction&action=startTPWorkflow&jsonInfo="+Ext.encode(submitJson)+"&uid=<%=user.getUserAccount()%>",  
		success:function(response,config){
			var json =  Ext.JSON.decode(response.responseText);
			if(json.flag=="success"){
				MaskOver();
				$('div.btmFixed').remove();
				var fields = Ext.getCmp('testPlanForm').getForm().getFields().items;
				for(var i=0,n=fields.length;i<n;i++){
					fields[i].setReadOnly(true);
				}
				Ext.Msg.alert('提示','启动成功',function(){
					top.closeTab();
				});
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
	//alert(Ext.encode(submitJson));
};

function submitData(){
	var nextStaff = {linkId:next_linkId,
					linkNo:next_linkNo,
					templateId:next_templateId,
					stdholderStaffId:'<%=user.getUserId()%>',
					stdholderStaffNo:'<%=user.getUserAccount()%>',
					stdholderStaffName:'<%=user.getUserName()%>',
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
										
	var submitJson = {};
	submitJson.stakeholder=[nextStaff,submitStaff];
	submitJson.orderDetail={conds:orderCond,opinion:"启动",orderId:0,result:resultSelect};
	submitJson.testPlan={};
	
	getTestTaskIds();
	submitJson.testTaskIds= testTaskIds;
	
	var fields = Ext.getCmp('testPlanForm').getForm().getFields().items;
	for(var i=0,n=fields.length;i<n;i++){
		var field = fields[i].name;
		submitJson.testPlan[field]= Ext.getCmp('testPlanForm').getForm().findField(field).getValue();
	}
	MaskLoading();
	Ext.Ajax.request({  
		method:'POST',
		url:"<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.aiga.web.TestPlanAction&action=startTPWorkflow&jsonInfo="+Ext.encode(submitJson)+"&uid=<%=user.getUserAccount()%>",  
		success:function(response,config){
			var json =  Ext.JSON.decode(response.responseText);
			if(json.flag=="success"){
				MaskOver();
				$('div.btmFixed').remove();
				var fields = Ext.getCmp('testPlanForm').getForm().getFields().items;
				for(var i=0,n=fields.length;i<n;i++){
					fields[i].setReadOnly(true);
				}
				Ext.Msg.alert('提示','启动成功');
			}else{
				MaskOver();
				Ext.Msg.alert('提示','保存失败:'+json.flag);
			}
			
			//reLoadOrderList(); 
		},
		failure:function(response,config){
			MaskOver();
			Ext.Msg.alert('提示','保存失败');
		}
	});

}

function saveTestPlan()
{
	chooseLinkInfo();
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
						
	var submitJson = {};
	submitJson.stakeholder=[submitStaff];
	submitJson.orderDetail={conds:orderCond,orderId:0,result:resultSelect};
	submitJson.testPlan={};
	
	getTestTaskIds();
	submitJson.testTaskIds= testTaskIds;
		
	var fields = Ext.getCmp('testPlanForm').getForm().getFields().items;
	for(var i=0,n=fields.length;i<n;i++){
		var field = fields[i].name;
		var xtype=Ext.getCmp('testPlanForm').getForm().findField(field).xtype;
		var isHidden=Ext.getCmp('testPlanForm').getForm().findField(field).isHidden( );
		var value=Ext.getCmp('testPlanForm').getForm().findField(field).getValue();
		if(
				typeof(value)=='undefined'||
				typeof(value)==undefined||
				(
						(typeof(value)=='string')
							&&(value.trim()==''||value==undefined||value=='null')
				)
				||(typeof(value)=='object'&&value==null)
		   ){
			if(xtype!='checkbox'&&xtype!='hidden'&&field!='planDscr'&&!isHidden){
				Ext.getCmp('testPlanForm').getForm().findField(field).focus(true,true);
				Ext.Msg.alert("提示","请填写" + Ext.getCmp('testPlanForm').getForm().findField(field).fieldLabel + "后，提交表单。")
				return;
			}
			
		}
		submitJson.testPlan[field]= Ext.getCmp('testPlanForm').getForm().findField(field).getValue();
	}
	if(Ext.getCmp('testPlanForm').getForm().findField('planName').getValue()==""){
		Ext.Msg.alert("提示","请填写测试计划名称");
		return false;
	}
	MaskLoading();
	Ext.Ajax.request({ 
		clientValidation: true, 
		method:'POST',
		url:"<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.aiga.web.TestPlanAction&action=saveTestPlanFirstOrder&jsonInfo="+Ext.encode(submitJson)+"&uid=<%=user.getUserAccount()%>",  
		success:function(response,config){
			var json =  Ext.JSON.decode(response.responseText);
			if(json.flag=="success"){
				MaskOver();
				$('div.btmFixed').remove();
				var fields = Ext.getCmp('testPlanForm').getForm().getFields().items;
				for(var i=0,n=fields.length;i<n;i++){
					fields[i].setReadOnly(true);
				}
				Ext.Msg.alert('提示','保存成功',function(){
					top.closeTab();
				});
			}else{
				MaskOver();
				Ext.Msg.alert('提示','保存失败:'+json.flag);
			}
			
			//reLoadOrderList(); 
		},
		failure:function(response,config){
			MaskOver();
			Ext.Msg.alert('提示','保存失败');
		}
	});
}
</script>
</html>