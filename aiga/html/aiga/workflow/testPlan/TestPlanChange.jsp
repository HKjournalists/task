<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/workflow/common/publicJSFunction.jsp" %>
<%@ include file="/aiga/common/common.jsp" %>
<%
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
	String passInfo = "保存测试计划变更信息";
	
	String planFlag = request.getParameter("planFlag");
	String objId = request.getParameter("objId");
	//对象Type
	String objectType = request.getParameter("objType");
	
	String includeHead = request.getParameter("includeHead");

%>
<html>
<head>
	<title>测试计划变更</title>
</head>
	<body style="">
		<div>
			<jsp:include page="/aiga/workflow/testPlan/TestPlanForm.jsp">
				<jsp:param name="objId" value="<%=objId %>"/>
				<jsp:param name="objType" value="<%=objectType %>"/>
				<jsp:param name="includeHead" value="<%=includeHead %>"/>
				<jsp:param name="planFlag" value="<%=planFlag %>"/>
			</jsp:include>
			<div style="width:0px;height:56px;"></div>
			
			<!-- 操作区域浮动层 -->
			<!-- btmFixed -->
			<%if(planFlag!=null&&planFlag.equals("2")){ %>
			<div class="btmFixed">
				<div class="btmFixedInner"></div>
				<div class="btmFixed_left" id="putongliucheng">
					<ul>
						<li title="<%=passInfo %>" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="saveChange()">
							<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/upmng.gif" /></span>
							<p>变更保存</p>
						</li>
					</ul>
				</div>
			</div>
			<%} %>
		</div>
     </body>
<script type="text/javascript">
//下一环节link信息
var current_linkNo = '<%=WorkflowParam.getWorkflow("planRunning").getLinkNo()%>';

var	next_linkId ='';
var next_linkNo = '';
var	next_roleCode = '';
var next_templateId = '';

var orderResult = '';
var orderCond = '';
var resultSelect = '';

function saveChange(){
	var submitJson = {};
	submitJson.testPlanChange={planId:<%=objId %>,
							codeCommitDate:Ext.getCmp('testPlanForm').getForm().findField("codeCommitDate").getValue(),
							factCompleteTime:Ext.getCmp('testPlanForm').getForm().findField("factCompleteTime").getValue(),
							reqTime:Ext.getCmp('testPlanForm').getForm().findField("reqTime").getValue(),
							changeReason:Ext.getCmp('testPlanForm').getForm().findField("changeReason").getValue(),
							versionContent:Ext.getCmp('testPlanForm').getForm().findField("versionContent").getValue()
							};
	MaskLoading();
	Ext.Ajax.request({ 
		async:false, 
		method:'POST',
		url:"<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.aiga.web.TestPlanAction&action=testPlanChange&jsonInfo="+Ext.encode(submitJson)
			+"&uid=<%=user.getUserAccount()%>" + "&",  
		success:function(response,config){
			var json =  Ext.JSON.decode(response.responseText);
			if(json.flag=="success"){
				var json =  Ext.JSON.decode(response.responseText);
				if(json.flag=="success"){
					MaskOver();
					top.Ext.Msg.alert("提示","变更成功!");
					top.Ext.getCmp("taskFormWin").close();
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
//	alert(Ext.encode(submitJson));
};
</script>
</html>