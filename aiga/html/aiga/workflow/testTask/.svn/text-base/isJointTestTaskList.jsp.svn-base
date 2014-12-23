<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
%>
<html>
<head>
	<title>是否联调</title>
</head>
	<body style="margin:0px;">
		<div>
			<jsp:include page="/aiga/workflow/testPlan/testTaskQuery.jsp">
				<jsp:param name="flag" value="9"/>
			</jsp:include>
			
			<!-- 操作区域浮动层 -->
			<!-- btmFixed -->
			<div class="btmFixed">
				<div class="btmFixedInner"></div>
				<div class="btmFixed_left" id="putongliucheng">
					<ul>
						<li title="提交联调" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="jointTest()">
							<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/upmng.gif" /></span>
							<p>提交</p>
						</li>
					</ul>
				</div>
			</div>
		</div>
     </body>
<script type="text/javascript">

function jointTest(){
		var store=Ext.data.StoreManager.lookup('taskStore');
		var records = store.getUpdatedRecords();// 获取修改的行的数据，无法获取幻影数据  
				var phantoms=store.getNewRecords() ;//获得幻影行  
			records=records.concat(phantoms);//将幻影数据与真实数据合并
		var dataTrue = new Array(); 
		var dataFalse = new Array(); 
			Ext.Array.each(records, function(record) {
				if(record.data.isJointTest=='true')
					dataTrue.push(record.data.taskId);
				else dataFalse.push(record.data.taskId);
				});
    MaskLoading();
   	Ext.Ajax.request({ 
		async:false,
		method:'POST',
		url:"<%=request.getContextPath()%>/jointTestTaskByTasks.do",
		params : {taskTrueArrays :dataTrue,taskFalseArrays:dataFalse},
		success:function(response,config){
			MaskOver();
			var returnData=Ext.decode(response.responseText,true);
			if(returnData.success){
				Ext.Msg.confirm('提示',returnData.message,function(optional){
					if(optional=='yes')	window.location.reload();
				});
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