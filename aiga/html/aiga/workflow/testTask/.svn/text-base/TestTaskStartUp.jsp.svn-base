<!DOCTYPE HTML>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/workflow/common/publicJSFunction.jsp" %>
<%
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
	String passInfo = "启动测试任务流程";
	
	String planFlag = request.getParameter("planFlag");
	String objId = request.getParameter("objId");
	//对象Type
	String objectType = request.getParameter("objType");
	
	String includeHead = request.getParameter("includeHead");

%>
<html>
<head>
	<title>测试任务启动</title>
</head>
	<body>
		<div>
		<jsp:include page="/aiga/workflow/testPlan/TaskList.jsp">
			<jsp:param name="flag" value="0"/>
			<jsp:param name="hide" value="true"/>
		</jsp:include>
		</div>
		<!-- 操作区域浮动层 -->
		<!-- btmFixed -->
		<div class="btmFixed" >
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
		
		<div style = "width:0px;height;57px;">
		
		</div>
     </body>
<script type="text/javascript">
//下一环节link信息
var current_linkNo = '<%=WorkflowParam.getWorkflow("planRunning").getLinkNo()%>';

var	next_linkId ='';
var next_linkNo = '';
var	next_roleCode = '';
var next_templateId = '';

var	create_linkId = '<%=WorkflowParam.getWorkflow("createTestTask").getLinkId()%>';
var create_linkNo = '<%=WorkflowParam.getWorkflow("createTestTask").getLinkNo()%>';
var	create_roleCode = '<%=WorkflowParam.getWorkflow("createTestTask").getRoleCode()%>';
var create_templateId = '<%=WorkflowParam.getWorkflow("createTestTask").getTemplateId()%>';

var orderResult = '';
var orderCond = '';
var resultSelect = '';
var testTaskIds = '';

function startUpTestTaskWF(){
	var submitJson = {};
	submitJson.testTask={};
	submitJson.testTaskIds= testTaskIds;
	
	var fields = Ext.getCmp('taskForm').getForm().getFields().items;
	for(var i=0,n=fields.length;i<n;i++){
		var field = fields[i].name;
		var xtype=Ext.getCmp('taskForm').getForm().findField(field).xtype;
		var value=Ext.getCmp('taskForm').getForm().findField(field).getValue();
		if(typeof(value)=='object'||typeof(value)=='undefined'||typeof(value)==undefined||(typeof(value)=='string'&&(value.trim()==''||value==undefined||value.trim()=='null'))){
			if(xtype!='checkbox'&&xtype!='hidden'&&Ext.getCmp('taskForm').getForm().findField(field).name!='planTag'&&Ext.getCmp('taskForm').getForm().findField(field).name!='initialSituation'){
				alert('【'+removeHTMLTag(Ext.getCmp('taskForm').getForm().findField(field).fieldLabel).replace("*", "")+'】不能为空');
				return;
			}
			
		}
		submitJson.testTask[field]= Ext.getCmp('taskForm').getForm().findField(field).getValue();
	}
	if(Ext.getCmp('taskForm').getForm().findField('taskName').getValue()==""){
		Ext.Msg.alert("提示","请填写测试任务名称");
		return false;
	}
	MaskLoading();
	Ext.Ajax.request({ 
		async:false, 
		method:'POST',
		url:"<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.aiga.web.TestPlanAction&action=startTestTaskWorkflow&jsonInfo="+Ext.encode(submitJson)
			+"&uid=<%=user.getUserAccount()%>" + "&",  
		success:function(response,config){
			var json =  Ext.JSON.decode(response.responseText);
			if(json.flag=="success"){
				MaskOver();
				Ext.Msg.alert('提示','启动成功',function(){
					top.closeTab();
				});
				try{
				$('div.btmFixed').remove();
					var fields=Ext.getCmp('taskForm').getForm().getFields().items;
					for(var fieldIndex in fields){
						fields[fieldIndex].setReadOnly(true);
					}	
				}catch(e){
					
				}
				
				//top.window.clickMenu("工作台","待处理工单");
				//top.window.closeTabByText("测试任务启动");
				//window.parent.window.location.href = '<%=request.getContextPath()%>/aiga/workflow/common/WorkorderList.jsp';
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

function getTestTaskIds()
{
	var store = Ext.getCmp('taskGrid').getStore();

	for (var i = 0; i < store.getCount(); i++) 
	{        
		var record = store.getAt(i);   
		testTaskIds = testTaskIds + record.get('taskId') + ',';
    }
}

</script>
</html>