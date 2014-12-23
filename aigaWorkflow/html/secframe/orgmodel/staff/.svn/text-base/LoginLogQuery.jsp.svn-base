<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai"%>
<%@ include file="/secframe/common/common.jsp"%>
<ai:scriptinclude src="/secframe/common/common.js" />
<html>
	<head>
		<title>登陆日志查询</title>
		<script language="javascript"
			src="<%=request.getContextPath()%>/jsv2/Calendar.jsp"
			type="text/javascript"></script>
		<%
					java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(
					"yyyy-MM-dd HH:mm:ss");
			java.util.Date currentTime = new java.util.Date();//得到当前系统时间 		
			String cur_date = formatter.format(currentTime);
		%>
	</head>
	<body onLoad="init();">
	
	
	<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
     <tr>
    <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
        <tr>
          <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
          <td style="height: 20px">查询条件</td>
          <td align="right" style="height: 20px"></td>
        </tr>
      </table></td>
  </tr>
     <tr>
    <td bgcolor="#FFFFFF" align="left" height="100" valign="top">
        <ai:dbform formid="loginLogForm"
				setname="com.ai.secframe.bo.orgmodel.SysLoginLog"
				datamodel="com.ai.appframe2.web.datamodel.QueryModelForService"
				implservice_name="com.ai.secframe.service.orgmodel.SysLoginLog"
				implservice_querymethod="querySysLoginLog" initial="false">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" height="100">
             <tr>
            <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">员工工号</td>
            <td width="1"></td>
            <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="loginLogForm" fieldname="STAFF_CODE"
								width="150" height="20" /></td>
            <td width="1"></td>
            <td bgcolor="#F1F3FB" class="font13pxboldblue1">IP</td>
            <td width="1"></td>
            <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="loginLogForm" fieldname="IP"
								width="150" height="20" /></td>
          </tr>
           
             <tr>
            <td height="1" class="font13pxboldblue1"></td>
            <td width="1"></td>
            <td class="font13pxboldblack"></td>
            <td width="1"></td>
            <td class="font13pxboldblack"></td>
            <td width="1"></td>
            <td class="font13pxboldblack"></td>
          </tr>
		  
		     <tr>
            <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">开始时间</td>
            <td width="1"></td>
            <td bgcolor="#F1F3FB" class="font13pxboldblack"><input type="text" id="startDate" readonly style="width: 150"
								onclick="calendar(document.all.startDate);"></td>
            <td width="1"></td>
            <td bgcolor="#F1F3FB" class="font13pxboldblue1">结束时间</td>
            <td width="1"></td>
            <td bgcolor="#F1F3FB" class="font13pxboldblack"><input type="text" id="endDate" readonly style="width: 150"
								onclick="calendar(document.all.endDate);"></td>
          </tr>
             <tr>
            <td height="1" class="font13pxboldblue1"></td>
            <td width="1"></td>
            <td class="font13pxboldblack"></td>
            <td width="1"></td>
            <td class="font13pxboldblack"></td>
            <td width="1"></td>
            <td class="font13pxboldblack"></td>
          </tr>
		  
             <tr bgcolor="#E1EDFA">
            <td height="1" class="font13pxboldblue1"></td>
            <td width="1"></td>
            <td class="font13pxboldblack"></td>
            <td width="1"></td>
            <td class="font13pxboldblack"></td>
            <td width="1"></td>
            <td class="font13pxboldblack"></td>
          </tr>
             <tr bgcolor="#FFFFFF" height="30">
            <td height="30"  colspan="7"  align="center"><input name="Input" type="button" class="btn-2word" value="查询" id="saveBtn" onClick="queryLoginLog()"/>
               </td>
          </tr>
           </table>
      </ai:dbform></td>
  </tr>
     <tr>
    <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
        <tr>
          <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
          <td style="height: 20px">结果列表</td>
          <td align="right" style="height: 20px"></td>
        </tr>
      </table></td>
  </tr>
     <tr>
    <td bgcolor="#FFFFFF" align="center"><ai:table tableid="loginLogInfo"
							setname="com.ai.secframe.bo.orgmodel.SysLoginLog"
							tablemodel="com.ai.appframe2.web.datamodel.QueryModelForService"
							implservice_name="com.ai.secframe.service.orgmodel.SysLoginLog"
							implservice_querymethod="querySysLoginLog"
							implservice_countmethod="querySysLoginLogCount" initial="false"
							pagesize="20" editable="false" width="950" height="380"
							needrefresh="true">
							<ai:col fieldname="LOG_ID" width="100" visible="true" />
							<ai:col fieldname="STAFF_CODE" width="100" visible="true" />
							<ai:col fieldname="LOGIN_DATE" width="150" visible="true" />
							<ai:col fieldname="LOGOUT_DATE" width="150" visible="true" />
							<ai:col fieldname="IP" width="200" visible="true" />
							<ai:col fieldname="MAC" width="100" visible="true" />
							<ai:col fieldname="STATE" width="120" visible="true" />
							<ai:col fieldname="SESSION_ID" width="100" visible="true" />
						</ai:table>
         </td>
  </tr>
   </table>
	
	</body>
</html>
<script type="text/javascript">
	//初始化页面
	function init(){
  	var curdate = "<%=cur_date%>";
			if(curdate != null && curdate != "" && curdate.length != 0){
				curdate = curdate.split(" ");
			}else{
				alert("未能获取系统时间,请自行选择任务查询的起始时间!");
				return;
			}
			document.all("startDate").value = curdate[0] + " 00:00:00";
		    document.all("endDate").value = curdate[0] + " 23:59:59";    
	}
	function queryLoginLog(){
	var loginQueryForm = g_FormRowSetManager.get("loginLogForm");
	var loginLogInfoTable= g_TableRowSetManager.get("loginLogInfo");
	//alert(loginLogInfoTable);
	var staffCode = loginQueryForm.getValue("STAFF_CODE");
	//var reStaffCode="/^[0-9a-zA-Z]+$/";
	if(staffCode.indexOf(" ")>=0 || staffCode.indexOf("&")>=0)
	{
	  alert("员工工号中间不允许有空字符或者‘&’字符存在")
	  loginQueryForm.setFocus("STAFF_CODE");
	  return;
	}
	//alert(/^[0-9a-zA-Z]$/g.test(staffCode));
	//if((/^[0-9a-zA-Z]$/g.test(staffCode))){
		//alert("员工工号不能有字母数字以外的符号！");
		//return;
	//}
	//alert(OP_ID);
	var ip=loginQueryForm.getValue("IP");
	
	//alert(loginLogType);
	var startDate=document.getElementById("startDate").value;
	//alert(startDate);
	var endDate = document.getElementById("endDate").value;
	//alert(endDate);
	if(g_CompareDate(endDate,startDate)==-1){
   		  		alert("查询的结束时间不能小于开始时间!");
   		  		return;
   		  }
	var param="";
	param="staffCode="+staffCode
		+"&ip="+ip
		+"&startDate="+startDate
		+"&endDate="+endDate;
	loginLogInfoTable.refresh(param);
	}
	
	</script>