<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
%>
<html>
<head>
	<title>测试任务排期</title>
</head>
	<body style="margin:0px;">
		<div>
			<jsp:include page="/aiga/workflow/testPlan/testTaskQuery.jsp">
				<jsp:param name="flag" value="7"/>
			</jsp:include>
			
			<!-- 操作区域浮动层 -->
			<!-- btmFixed -->
			<div class="btmFixed">
				<div class="btmFixedInner"></div>
				<div class="btmFixed_left" id="putongliucheng">
					<ul>
						<li title="批量任务排期" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="appointment()">
							<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/upmng.gif" /></span>
							<p>任务排期</p>
						</li>
					</ul>
				</div>
			</div>
		</div>
     </body>
<script type="text/javascript">

function appointment(){
	   var taskStore=Ext.data.StoreManager.lookup('taskStore');
	   taskStore.filter([{filterFn: function(item) {
		   return item.get("planId")!=null&&item.get("planId").trim()!=''}}]);
	   var data = new Array(); 
       Ext.Array.each(taskStore.data.items, function(record) {  
           data.push(record.data);  
           });
      if(data.length==0){
    	  alert("您没有进行任何排期！请排期！");
    	  window.location.reload();
    	  return;
      }
     
    MaskLoading();
   	Ext.Ajax.request({ 
		method:'POST',
		url:"<%=request.getContextPath()%>/saveTestTaskList.do",
		params : {table :Ext.encode(data)},
		success:function(response,config){
			MaskOver();
			var returnData=Ext.decode(response.responseText,true);
			if(returnData.success){
				/**Ext.Msg.confirm('提示',returnData.message,function(optional){
					if(optional=='yes')	window.location.reload();
				});**/
				alert("排期成功！");window.location.reload();
			}else{
				MaskOver();
				Ext.Msg.alert('提示','操作失败:'+json.flag);
			}
			return;
			
		},
		failure:function(response,config){
			MaskOver();
			Ext.Msg.alert('提示','保存失败');
		}
	});
}
</script>
</html>