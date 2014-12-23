<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
%>
<html>
<head>
	<title>测试子任务评审</title>
</head>
	<body style="margin:0px;">
		<div>
			<jsp:include page="/aiga/workflow/SubTaskReview.jsp"/>
			<!-- 操作区域浮动层 -->
			<!-- btmFixed -->
			<div class="btmFixed">
				<div class="btmFixedInner"></div>
				<div class="btmFixed_left" id="putongliucheng">
					<ul>
						<li title="批量子任务评审" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="appointment()">
							<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/upmng.gif" /></span>
							<p>评审完成</p>
						</li>
					</ul>
				</div>
			</div>
		</div>
     </body>
<script type="text/javascript">

function appointment(){
	subTaskCellEdit.completeEdit();
	var taskStore=Ext.data.StoreManager.lookup('subTaskStore');
	var updateStore=taskStore.getUpdatedRecords();
	var data = new Array();
    Ext.Array.each(updateStore, function(record) {  
    	data.push(record.data);  
    });
    
    var problemStaff = {problemStaffId:'<%=user.getUserId()%>',
		problemStaffName:'<%=user.getUserName()%>'};

	var submitJson = {};
	submitJson.subTasks = data;
	submitJson.problemStaff = problemStaff;
	MaskLoading();
	Ext.Ajax.request({ 
		async:false, 
		method:'POST',
		url:"<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.aiga.web.TestPlanAction&action=batchSubTaskReview&jsonInfo="+Ext.encode(submitJson)
			+"&uid=<%=user.getUserAccount()%>" + "&",  
		success:function(response,config){ 
			var json =  Ext.JSON.decode(response.responseText);
			if(json.flag=="success"){
				MaskOver();
				top.Ext.Msg.alert("提示","操作成功!");
				taskStore.reload();
			}else{
				MaskOver();
				Ext.Msg.alert('提示','保存失败:'+json.flag);
			}

			/**Ext.Msg.confirm('提示','评审成功，是否刷新页面？',function(optional){
				if(optional=='yes')	
			});
			**/
		},
		failure:function(response,config){
			MaskOver();
			Ext.Msg.alert('提示','保存失败');
		}
	});
}
</script>
</html>