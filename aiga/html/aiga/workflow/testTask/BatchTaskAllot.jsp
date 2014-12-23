<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/workflow/common/publicJSFunction.jsp" %>

<%
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
	String passInfo = "批量分配测试任务";
	String objId = request.getParameter("objId");
	String includeHead = request.getParameter("includeHead");

%>
<html>
	<head>
		<title>测试任务批量分配</title>
	</head>
	<body style="margin:0px;">
		<div>
			<jsp:include page="/aiga/workflow/testPlan/TaskList.jsp">
				<jsp:param name="flag" value="5"/>
				<jsp:param name="queryFlag" value="1"/>
			</jsp:include>
			
			<!-- 操作区域浮动层 -->
			<!-- btmFixed -->
			<div class="btmFixed">
				<div class="btmFixedInner"></div>
				<div class="btmFixed_left" id="putongliucheng">
					<ul>
						<li title="<%=passInfo %>" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="saveChange()">
							<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/upmng.gif" /></span>
							<p>批量分配</p>
						</li>
					</ul>
				</div>
			</div>
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
	var grid = Ext.getCmp("taskGrid");
    var subTaskStaffsArray = new Array();
    var subTaskStaffsStore=grid.getStore();
    var models=grid.getStore().getUpdatedRecords();
    if(models.length==0){
    	alert('请选择测试人员！');
    	return;
    }
    subTaskStaffsStore.filter([{filterFn: function(item) {return item.get("staffIds") !="" && item.get("staffNames") !="";}}]);

    subTaskStaffsStore.each( function(record) {
        var subTaskStaffs = {taskId:"",staffIds: "",staffNames: ""};
        
        subTaskStaffs.taskId=record.data.taskId;
        subTaskStaffs.staffIds=record.data.staffIds;
        subTaskStaffs.staffNames=record.data.staffNames;
        subTaskStaffsArray.push(subTaskStaffs);
    });
	var submitJson = {};
	submitJson.subTaskStaffs = subTaskStaffsArray;
	MaskLoading();
	Ext.Ajax.request({ 
		async:false, 
		method:'POST',
		url:"<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.aiga.web.TestPlanAction&action=batchAllotTestTaskToSubTask&jsonInfo="+Ext.encode(submitJson)
			+"&uid=<%=user.getUserAccount()%>" + "&",  
		success:function(response,config){ 
			var json =  Ext.JSON.decode(response.responseText);
			if(json.flag=="success"){
				MaskOver();
				top.Ext.Msg.alert("提示","操作成功!");
				window.location.reload();
			}else{
				MaskOver();
				Ext.Msg.alert('提示','保存失败:'+json.flag);
			}
			//Ext.Msg.confirm('提示','分派成功，是否刷新页面？',function(optional){
				//if(optional=='yes')	
						
					
					
			//});
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