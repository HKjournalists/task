<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
	String passInfo = "批量启动测试任务流程";
	
	String planFlag = request.getParameter("planFlag");
	String objId = request.getParameter("objId");
	//对象Type
	String objectType = request.getParameter("objType");
	
	String includeHead = request.getParameter("includeHead");

%>
<html>
<head>
	<title>测试任务批量启动</title>
	<%@ include file="/aiga/workflow/common/publicJSFunction.jsp" %>
</head>
	<body style="">
		<div>
			<jsp:include page="/aiga/workflow/testTask/UploadForm.jsp"></jsp:include>
			
			<!-- 操作区域浮动层 -->
			<!-- btmFixed -->
			<!--  <div class="btmFixed"style="bottom: 44px;/**fix ifreame bug**/">
				<div class="btmFixedInner"></div>
				<div class="btmFixed_left" id="putongliucheng">
					<ul>
						<li title="<%=passInfo %>" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="batchStartUpTestTaskWF()">
							<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/upmng.gif" /></span>
							<p>启动</p>
						</li>
					</ul>
				</div>
			</div>
			-->
		</div>
     </body>
<script type="text/javascript">
//下一环节link信息

var orderResult = '';
var orderCond = '';
var resultSelect = '';
var testTaskIds = '';

function batchStartUpTestTaskWF(){
	var submitJson = {};
	getTestTaskIds();
	submitJson.testTaskIds= testTaskIds;//传递统一任务列表id序列
	
	submitJson.testPlanInfo={planId:planId,
							planTag:planTag,
							factCompleteTime:factCompleteTime,
							bigType:bigType};//测试任务排期三要素
							
	MaskLoading();
	Ext.Ajax.request({ 
		async:false, 
		method:'POST',
		url:"<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.aiga.web.TestPlanAction&action=batchStartTestTaskWorkflow&jsonInfo="+Ext.encode(submitJson)
			+"&uid=<%=user.getUserAccount()%>" + "&",  
		success:function(response,config){
			var json =  Ext.JSON.decode(response.responseText);
			if(json.flag=="success"){
				MaskOver();
				alert("启动成功,若要重新导入，请刷新页面！");
				//Ext.getCmp('taskGrid').getStore().reload(); 
				//top.Ext.getCmp("taskFormWin").close();
			}else{
				MaskOver();
				Ext.Msg.alert('提示','启动失败');
			}
		},
		failure:function(response,config){
			MaskOver();
			Ext.Msg.alert('提示','启动失败');
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