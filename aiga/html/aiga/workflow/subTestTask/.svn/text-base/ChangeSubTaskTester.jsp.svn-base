<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
%>
<html>
<head>
	<title>子任务测试改派</title>
</head>
	<body style="margin:0px;">
		<div>
			<jsp:include page="/aiga/workflow/subTestTask/SubTaskTesterChange.jsp">
				<jsp:param name="flag" value="8"/>
			</jsp:include>
			
			<!-- 操作区域浮动层 -->
			<!-- btmFixed -->
			<div class="btmFixed">
				<div class="btmFixedInner"></div>
				<div class="btmFixed_left" id="putongliucheng">
					<ul>
						<li title="批量子任务改派" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="saveChange()">
							<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/upmng.gif" /></span>
							<p>任务改派</p>
						</li>
					</ul>
				</div>
			</div>
		</div>
     </body>
<script type="text/javascript">


function saveChange(){
	var grid = Ext.getCmp("subTaskGrid");
    var subTaskStaffsArray = new Array();
    var subTaskStaffsStore=grid.getStore();
    
    subTaskStaffsStore.filter([{filterFn: function(item) {
    	return item.get("changeStaffId") !="";}}]);

    subTaskStaffsStore.each( function(record) {
        var subTaskChangeStaffs = {subTaskId:"",changeStaffId: ""};
        subTaskChangeStaffs.subTaskId=record.data.subTaskId;
        subTaskChangeStaffs.changeStaffId=record.data.changeStaffId;
        subTaskStaffsArray.push(subTaskChangeStaffs);
    });
    if(subTaskStaffsArray.length == 0){
		alert('没有需要改派子任务');
		window.location.reload();
		return;
    }
	var submitJson = {};
	submitJson.subTaskChangeStaffs = subTaskStaffsArray;
	MaskLoading();
	Ext.Ajax.request({ 
		async:false, 
		method:'POST',
		url:"<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.aiga.web.TestPlanAction&action=batchSubTaskTestorChange&jsonInfo="+Ext.encode(submitJson)
			+"&uid=<%=user.getUserAccount()%>" + "&",  
		success:function(response,config){ 
			var json =  Ext.JSON.decode(response.responseText);
			if(json.flag=="success"){
				MaskOver();
				top.Ext.Msg.alert("提示","改派成功!");
				window.location.reload();
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