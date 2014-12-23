<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai"%>
<%@include file="/secframe/common/common.jsp"%>
<%
	response.setHeader("Pragma", "No-cache");
 	response.setHeader("Cache-Control", "no-cache");
 	response.setDateHeader("Expires", 0);
 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>切换组织</title>
	</head>
	<body>
		<table width="600" border='0' align="center" valign="top"
			cellpadding="0" cellspacing="0">
			<tr>
				<td colspan=4 align="center" height="40">							
					请选择需要切换的组织--黄色记录为当前登陆所属组织
				</td>
			</tr>
			<tr>
				<td align=center colspan=4 height="100">
					<ai:table tableid="orgtable"
						setname="com.ai.secframe.bo.orgmodel.SysOrganize"
						initial="false" multiselect="true" editable="false"
						tablemodel="com.ai.appframe2.web.datamodel.QueryModelForService"
						implservice_name="com.ai.secframe.service.orgmodel.OrgModelInfo"
						implservice_querymethod="querySysOrganize"
						implservice_countmethod=""
						width="600" height="100" needrefresh="true">										
						<ai:col fieldname="ORGANIZE_ID" width="260" editable="true"
							visible="true" />
						<ai:col fieldname="ORGANIZE_NAME" width="260" editable="true"
							visible="true" />										
					</ai:table>
				</td>
			</tr>
			<tr>
				<td height="10" colspan=4 align="center" valign="bottom">
									<ai:button text="切换员工组织" id="delrelatBtn"
										onclick="changeOrg()" style="cursor:hand"></ai:button>
				</td>
			</tr>
		</table>
									
	</body>
	<script type="text/javascript">
	var staff_id = '<%=com.ai.appframe2.common.SessionManager.getUser().getID()%>';	
	var orgtable = g_TableRowSetManager.get("orgtable");

	
	function changeOrg(){
	
	 if( orgtable.getSelectedRows()!=null&&orgtable.getSelectedRows().length>0){
	  		var selRows = orgtable.getSelectedRows()[0];
	  		var orgId = orgtable.getValue(selRows,"ORGANIZE_ID");
	  		if('<%=com.ai.appframe2.common.SessionManager.getUser().getOrgId()%>'==orgId)
	  		{
	  			alert("已属该组织，无需切换。");
	  			return;
	  		}	
	  		var orgName = orgtable.getValue(selRows,"ORGANIZE_NAME");
	  		var parm = "orgId="+orgId+"&orgName="+orgName;
	  		 parm = encodeURI(parm);
	  		 parm = encodeURI(parm);
	  		var msg = PostInfo("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysStaffAction?"+
			
			"action=changeOrg&"+parm);
			var result = msg.getValueByName("MESSAGE");	       
	       if(result=='1'){
	        window.returnValue = '1';
	        window.close();
	       }else{
	        alert(result);
	       }
	 }
	 else
	 {
	  alert("请选择要切换的组织！");
	 }
	}
	
function init()
{  		
		if(staff_id!=null&&staff_id!=""){			
  			orgtable.refresh(staff_id); 			
		}
		var orgId = '<%=com.ai.appframe2.common.SessionManager.getUser().getOrgId()%>';
		for(var i=0;i< orgtable.count();i++){	  		
	  		if(orgId == orgtable.getValue(i,"ORGANIZE_ID")){
	  			orgtable.setRowBgColor(i,"#FFFF97");
	  		}	  		
	  	}		
} 
init();
</script>
</html>
