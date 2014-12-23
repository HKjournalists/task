<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai"%>
<%@include file="/secframe/common/common.jsp"%>
<ai:scriptinclude src="/secframe/common/common.js" />
<html>
	<head>
		<title>操作记录查询</title>
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
        <ai:dbform formid="operateQueryForm"
				setname="com.ai.secframe.bo.orgmodel.SysOperateLog"
				datamodel="com.ai.appframe2.web.datamodel.QueryModelForService"
				implservice_name="com.ai.secframe.service.orgmodel.SysOperateLog"
				implservice_querymethod="querySysOperateLog" initial="false">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" height="100">
             <tr>
            <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">员工工号</td>
            <td width="1"></td>
            <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="operateQueryForm" fieldname="CONTENT"
								width="150" height="20" /></td>
            <td width="1"></td>
            <td bgcolor="#F1F3FB" class="font13pxboldblue1">增删改类型</td>
            <td width="1"></td>
            <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:listbox ds="com.ai.secframe.bo.orgmodel.OperateType"
								id="operateType" width="150" /></td>
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
            <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">操作类型</td>
            <td width="1"></td>
            <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:listbox ds="com.ai.secframe.bo.orgmodel.OperateLogType"
								id="operateLogType" width="150" /></td>
            <td width="1"></td>
            <td bgcolor="#F1F3FB" class="font13pxboldblue1">所属组织</td>
            <td width="1"></td>
            <td bgcolor="#F1F3FB" class="font13pxboldblack">
			<ai:dbformfield formid="operateQueryForm" fieldname="ORG_ID"
								width="150" height="20" visible="false" />
							<ai:dbformfield formid="operateQueryForm" fieldname="TABLE_NAME_OP"
								width="150" height="20" visible="true" editable="false" />
							
							<input type="button" class="btn-1word" value="..." id="selOrgBtn"
								onClick="org_select()"></td>
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
            <td height="30"  colspan="7"  align="center"><input name="Input" type="button" class="btn-2word" value="查询" id="saveBtn" onClick="queryOperateLog()"/>
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
    <td bgcolor="#FFFFFF" align="center"><ai:table tableid="operateLogInfo"
							setname="com.ai.secframe.bo.orgmodel.SysOperateLog"
							tablemodel="com.ai.appframe2.web.datamodel.QueryModelForService"
							implservice_name="com.ai.secframe.service.orgmodel.SysOperateLog"
							implservice_querymethod="querySysOperateLog"
							implservice_countmethod="querySysOperateLogCount" initial="false"
							pagesize="20" editable="false" width="950" height="380"
							needrefresh="true">
							<ai:col fieldname="OPERATE_LOG_ID" width="100" visible="true" />
							<ai:col fieldname="ORDER_ID" width="100" visible="true" />
							<ai:col fieldname="ORG_ID" width="100" visible="true" />
							<ai:col fieldname="OP_ID" width="100" visible="true" />
							<ai:col fieldname="CONTENT" width="200" visible="true" />
							<ai:col fieldname="DONE_DATE" width="100" visible="true" />
							<ai:col fieldname="RECORD_ID" width="120" visible="true" />
							<ai:col fieldname="CLUM_ID" width="100" visible="true" />
							<ai:col fieldname="OPERATE_TYPE" width="100" visible="true" />
							<ai:col fieldname="TABLE_NAME_OP" width="100" visible="true" />
							<ai:col fieldname="H_TABLE_NAME_OP" width="100" visible="true" />
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
	function queryOperateLog(){
	var operateQueryForm = g_FormRowSetManager.get("operateQueryForm");
	var operateLogInfoTable= g_TableRowSetManager.get("operateLogInfo");
	//alert(operateLogInfoTable);
	var staffCode = operateQueryForm.getValue("CONTENT");
	//var reStaffCode="/^[0-9a-zA-Z]+$/";
	if(staffCode.indexOf(" ")>=0 || staffCode.indexOf("&")>=0)
	{
	  alert("员工工号中间不允许有空字符或者‘&’字符存在")
	  operateQueryForm.setFocus("CONTENT");
	  return;
	}
	//alert(/^[0-9a-zA-Z]$/g.test(staffCode));
	//if((/^[0-9a-zA-Z]$/g.test(staffCode))){
		//alert("员工工号不能有字母数字以外的符号！");
		//return;
	//}
	//alert(OP_ID);
	var ORG_ID=operateQueryForm.getValue("ORG_ID");
	//alert(ORG_ID);
	var operateType=g_getListBox("operateType").getID();
	//alert(operateType);
	var operateLogType=g_getListBox("operateLogType").getID();
	//alert(operateLogType);
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
		+"&orgID="+ORG_ID
		+"&operateType="+operateType
		+"&operateLogType="+operateLogType
		+"&startDate="+startDate
		+"&endDate="+endDate;
	//alert(param);
	operateLogInfoTable.refresh(param);
	}
		function org_select(){
		var operateQueryForm = g_FormRowSetManager.get("operateQueryForm");	 
	 	var result = orgSelectDialog(<%=com.ai.appframe2.common.SessionManager.getUser()
							.getOrgId()%>);
		//重新装载岗位
		if(result!=null ){
		//alert(result[0].orgName);
		//alert(result[0].orgId);
			var temp=result[0].orgName.indexOf("|");
			var orgName=result[0].orgName.substring(0,temp);
			//alert(temp);
			//alert(orgName);
			operateQueryForm.setValue("TABLE_NAME_OP",orgName,null);
			operateQueryForm.setValue("ORG_ID",result[0].orgId,null);
         	//document.all("ORG_ID").value = result[0].orgId;
		}
	}
	
	</script>