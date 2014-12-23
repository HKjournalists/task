<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
%>
<html>
<head>
	<title>测试任务变更</title>
</head>
	<body style="margin:0px;">
		<div>
			<jsp:include page="/aiga/workflow/testPlan/testTaskQuery.jsp">
				<jsp:param name="flag" value="8"/>
			</jsp:include>
			
			<!-- 操作区域浮动层 -->
			<!-- btmFixed -->
			<div class="btmFixed">
				<div class="btmFixedInner"></div>
				<div class="btmFixed_left" id="putongliucheng">
					<ul>
						<li title="批量任务变更" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="appointment()">
							<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/upmng.gif" /></span>
							<p>任务变更</p>
						</li>
					</ul>
				</div>
			</div>
		</div>
     </body>
<script type="text/javascript">

function appointment(){
	var taskStore=Ext.data.StoreManager.lookup('taskStore');
	var updateStore=taskStore.getUpdatedRecords();

    var data = new Array(); 
    //console.log(updateStore);
    Ext.Array.each(updateStore, function(record) {  
    	data.push(record.data);  
  	});
    MaskLoading();
   	Ext.Ajax.request({ 
		async:false,
		method:'POST',
		url:"<%=request.getContextPath()%>/changeTestTaskList.do?staffId=<%=user.getUserId()%>",
		params : {
			table :Ext.encode(data),
			staffName:'<%=user.getUserName()%>'
		},
		success:function(response,config){
			MaskOver();
			var returnData=Ext.decode(response.responseText,true);
			if(returnData.success){
				alert('保存成功');window.location.reload();
				//Ext.Msg.alert('提示','保存成功');
				/**Ext.Msg.confirm('提示',returnData.message,function(optional){
					if(optional=='yes')	window.location.reload();
				});
				**/
			}else{
				Ext.Msg.alert('提示',returnData.message);
			}
		},
		failure:function(response,config){
			MaskOver();
			Ext.Msg.alert('提示','请求失败');
		}
	});
}
</script>
</html>