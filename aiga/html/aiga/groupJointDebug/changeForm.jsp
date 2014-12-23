<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");%>
<%@ include file="/aiga/common/common.jsp" %>
<%
	if(request.getParameter("winFlag").equals("alter")){
		
	}
 %>
<html>
<head>
	<title>联调测试变更</title>
</head>
	<body style="">
		<div>
			<jsp:include page="/aiga/groupJointDebug/changeInfo.jsp">
				<jsp:param name="winFlag" value='<%=request.getParameter("winFlag") %>'/>
			</jsp:include>
			
			<div style="width:0px; height:56px"></div>
			<!-- 操作区域浮动层 -->
			<!-- btmFixed -->
			<div class="btmFixed">
				<div class="btmFixedInner"></div>
				<div class="btmFixed_left" id="putongliucheng">
					<ul>
						<li title="" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="saveTestPlan()">
							<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/btm_save.gif" /></span>
							<p>保存</p>
						</li>
					</ul>
				</div>
			</div>
		</div>
     </body>
<script type="text/javascript">

function saveTestPlan()
{
	var form = Ext.getCmp('testPlanForm');
    MaskLoading();
    if(!changeTaskTagFlag){
    	MaskOver();
		Ext.Msg.alert("提示","<font style='color: red; font-weight:bold;'>*</font>为必填项!");
		return false;
    }
    if(taskTypeFlag==1){//需求
    	var valueTemp = Ext.getCmp("groupReqDevEndTime").getValue();
    	if(valueTemp==""||valueTemp==null){
    		MaskOver();
    		Ext.Msg.alert("提示","<font style='color: red; font-weight:bold;'>*</font>为必填项!");
    		return false;
    	}
    	valueTemp = Ext.getCmp("provincialReqDevEndTime").getValue();
    	if(valueTemp==""||valueTemp==null){
    		MaskOver();
    		Ext.Msg.alert("提示","<font style='color: red; font-weight:bold;'>*</font>为必填项!");
    		return false;
    	}
    	valueTemp = Ext.getCmp("jointDebugPlanBeginTime").getValue();
    	if(valueTemp==""||valueTemp==null){
    		MaskOver();
    		Ext.Msg.alert("提示","<font style='color: red; font-weight:bold;'>*</font>为必填项!");
    		return false;
    	}
    	valueTemp = Ext.getCmp("jointDebugPlanEndTime").getValue();
    	if(valueTemp==""||valueTemp==null){
    		MaskOver();
    		Ext.Msg.alert("提示","<font style='color: red; font-weight:bold;'>*</font>为必填项!");
    		return false;
    	}
    }else if(taskTypeFlag==2){//任务
    	var valueTemp = Ext.getCmp("reqPlanAccomplishTime").getValue();
    	if(valueTemp==""||valueTemp==null){
    		MaskOver();
    		Ext.Msg.alert("提示","<font style='color: red; font-weight:bold;'>*</font>为必填项!");
    		return false;
    	}
    }else if(taskTypeFlag==3){//子任务
    	var valueTemp = Ext.getCmp("changeTypeCombox").getValue();
    	if(valueTemp==""||valueTemp==null){
    		MaskOver();
    		Ext.Msg.alert("提示","<font style='color: red; font-weight:bold;'>*</font>为必填项!");
    		return false;
    	}
    	if(valueTemp==1){//时间
    		var newValueTemp = Ext.getCmp("taskPlanBeginCommitTime").getValue();
        	if(newValueTemp==""||newValueTemp==null){
        		MaskOver();
        		Ext.Msg.alert("提示","<font style='color: red; font-weight:bold;'>*</font>为必填项!");
        		return false;
        	}
        	newValueTemp = Ext.getCmp("taskPlanEndCommitTime").getValue();
        	if(newValueTemp==""||newValueTemp==null){
        		MaskOver();
        		Ext.Msg.alert("提示","<font style='color: red; font-weight:bold;'>*</font>为必填项!");
        		return false;
        	}
    	}else if(valueTemp==2){//内容
    		var newValueTemp = Ext.getCmp("contentsTypeCombox").getValue();
    		if(newValueTemp==""||newValueTemp==null){
        		MaskOver();
        		Ext.Msg.alert("提示","<font style='color: red; font-weight:bold;'>*</font>为必填项!");
        		return false;
        	}
    	}else{
    		MaskOver();
    		Ext.Msg.alert("提示","变更类型在常量表中配置错误");
    		return false;
    	}
    }
    form.submit({
        clientValidation: true,
        url: "<%=request.getContextPath()%>/saveJointDebugChange.do",
        params: {},
        method: 'POST',
        success: function (response, config) {
    		MaskOver();
            var success = config.result.success;
            // 当后台数据同步成功时  
            if (success) {
                Ext.Msg.alert('提示','保存成功',function(){
					<%if(request.getParameter("winFlag").equals("create")){%>
					MaskLoading();
					form.load({
                        params: {
                        	changeTag:Ext.getCmp("changeTag").getValue()
                        },
                        url: '<%=request.getContextPath()%>/getJointDebugChangeByChangeTag.do',
                        method: 'POST',
                        success: function (form, action) {
                            //Ext.Msg.alert('提示', action.result.data.changeId);
				            //加载已经关联的用例
				            //Ext.data.StoreManager.lookup('groupCaseStore').load({params: {subTaskId: action.result.data.subTaskId}});
				           	//显示关联按钮
                        	MaskOver();
                        },
                        failure: function (form, action) {
                        	MaskOver();
                            Ext.Msg.alert('提示', "失败原因是:" + action.result.errorMessage);
                        }
                	});
					//window.parent.closeTab();
					<%}else if(request.getParameter("winFlag").equals("alter")){%>
					top.Ext.getCmp("alterReqFormWin").close();
					<%}%>
				});
            }
        },
        failure: function (response, config) {
    		MaskOver();
    		console.log(config);
          	if(config.failureType=="client"){
          		Ext.Msg.alert("提示","<font style='color: red; font-weight:bold;'>*</font>为必填项!");
          	}else{
              	Ext.Msg.alert("提示","保存失败!");
          	}
        }
    });
}
</script>
</html>