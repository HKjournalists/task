<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");%>
<%@ include file="/aiga/common/common.jsp" %>
<%
	if(request.getParameter("winFlag").equals("alter")){
	    String reqId = "";
		try{ 
			reqId = request.getParameter("reqId");
			if(reqId==null||reqId.equals("")){
			    request.setAttribute("reqId", "");
			}
		}catch(Exception e){
			request.setAttribute("reqId", "");
		}
	}
 %>
<html>
<head>
	<title>创建联调测试需求单</title>
</head>
	<body style="">
		<div>
			<jsp:include page="/aiga/groupJointDebug/reqFormInfo.jsp">
				<jsp:param name="reqId" value='<%=request.getParameter("reqId") %>'/>
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
    if(messageRemarksFlag){
    	var valueTemp = Ext.getCmp("messageRemarks").getValue();
    	if(valueTemp==""||valueTemp==null){
    		MaskOver();
    		Ext.Msg.alert("提示","<font style='color: red; font-weight:bold;'>*</font>为必填项!");
    		return false;
    	}
    }
    if(reasonRemarks){
    	var valueTemp = Ext.getCmp("reasonRemarks").getValue();
    	if(valueTemp==""||valueTemp==null){
    		MaskOver();
    		Ext.Msg.alert("提示","<font style='color: red; font-weight:bold;'>*</font>为必填项!");
    		return false;
    	}
    }
    form.submit({
        clientValidation: true,
        url: "<%=request.getContextPath()%>/saveJointDebugReqForm.do",
        params: {},
        method: 'POST',
        success: function (response, config) {
    		MaskOver();
            var success = config.result.success;
            // 当后台数据同步成功时  
            if (success) {
                Ext.Msg.alert('提示','保存成功',function(){
					<%if(request.getParameter("winFlag").equals("create")){%>
					window.parent.closeTab();
					<%}else if(request.getParameter("winFlag").equals("alter")){%>
					top.Ext.getCmp("alterReqFormWin").close();
					<%}%>
				});
            }
        },
        failure: function (response, config) {
    		MaskOver();
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