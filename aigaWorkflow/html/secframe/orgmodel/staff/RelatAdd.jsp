<!--
/************************************************

  Created Date:
  Project Name:
  Module Name:        ���Ա������֯������ϵ
  Author:             ���׽�
  Version:            1.1
  begin Version Date: 2007-07
  Last Version Date:  2007-07

************************************************/
-->
<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai"%>
<%@include file="/secframe/common/common.jsp"%>

<script language="JavaScript"
	src="<%=request.getContextPath()%>/jsv2/CommUtil.js"></script>
<script language="JavaScript"
	src='<%=request.getContextPath()%>/secframe/common/common.js'>
</script>
<html>

	<head>
		<title>����Ա������֯������ϵҳ��</title>
		<SCRIPT LANGUAGE="JavaScript" for="window" even="onload">
          var gParamArray = dialogArguments;

function Relat(organize_id,organize_name, is_admin_staff, is_base_org)
{
    
    this.organize_id = organize_id;
    this.organize_name = organize_name;
    this.is_admin_staff = is_admin_staff;   
    this.is_base_org = is_base_org;  
}

   function insertFunc()
   {
   	
   	
    var dbformRelat = g_FormRowSetManager.get("dbformRelat");
    
    if( dbformRelat.getValue("NOTES") == null ||
        dbformRelat.getValue("NOTES") == ""){
   			alert("����ѡ����֯����");
   			return;
   		}
   	if( dbformRelat.getValue("IS_ADMIN_STAFF") == null ||
        dbformRelat.getValue("IS_ADMIN_STAFF") == ""){
   			alert("����ѡ���Ƿ񱻹���֯");
   			return;
   		}
  // 	if( dbformRelat.getValue("IS_BASE_ORG") == null ||
  //      dbformRelat.getValue("IS_BASE_ORG") == ""){
  // 			alert("����ѡ���Ƿ�ֱ����֯");
  // 			return;
  // 		}
    var objRelat=new Relat(dbformRelat.getValue("ORGANIZE_ID"),dbformRelat.getValue("NOTES"),dbformRelat.getValue("IS_ADMIN_STAFF"),"Y");
    
    window.returnValue = objRelat;
	window.close();    
   }

   function closeWindowFunc()
   {
    top.close();
   }

   function bodyLoad()
   {

   }
</script>
	</head>

	<body onLoad="bodyLoad()" class=modeBody>
		<div id="MyFormArea">
							<fieldset id="content" style="text-align:left;font-size:12"
						align="left">
						<LEGEND class=FormZName>
							Ա����ϸ��Ϣ
						</LEGEND>
			<table border=0 cellpadding=0 cellspacing=0 id=AutoNumber2
				class=modeContArea>

				<ai:dbform formid="dbformRelat"
					setname="com.ai.secframe.bo.orgmodel.SysStaffOrgRelat"
					datamodel="com.ai.appframe2.web.datamodel.QueryModelForService"
					implservice_name="com.ai.secframe.service.orgmodel.SysStaffOrgRelat"
					implservice_querymethod="querySysStaffOrgRelat" initial="false"
					editable="true">
					<ai:dbformfield formid="dbformRelat" fieldname="ORGANIZE_ID"
									width="170" height="20" editable="true" visible="false" />
					<table border=0 cellspacing=0 width="350" cellpadding=0
						class="FormTD" align="center">
						<tr>
							<td colspan=4 align="center" height="10"></td>
						</tr>
						<tr>
							<td width="100" class="FormTDName">
								��֯����:
							</td>
							<td height=20 colspan=3 class="FormTD" width="215">								
								<ai:dbformfield formid="dbformRelat" fieldname="NOTES"
									width="165" height="20" editable="false" visible="true" />
									<input type="button" value="..." onclick="sel_org()">
								<span class="pr9">*</span>
							</td>
							</tr>
							
							<tr>
							<td width="100" class="FormTDName">
								�Ƿ񱻹���֯:
							</td>
							<td width="215" class="FormTD" colspan=3>
								<ai:dbformfield formid="dbformRelat" fieldname="IS_ADMIN_STAFF"
									width="200" height="20" editable="true" visible="true" />
								<span class="pr9">*</span>
							</td>
						</tr>
						<tr style="display:none">
							<td width="100" class="FormTDName">
								�Ƿ�ֱ����֯:
							</td>
							<td height=20 colspan=3 class="FormTD" width="215">
								<ai:dbformfield formid="dbformRelat" fieldname="IS_BASE_ORG"
									width="200" height="20" editable="true" visible="true" />
								<span class="pr9">*</span>
							</td>
							
						</tr>
						<tr></tr><tr></tr>
						<tr>
							<td height=30 colspan='4' align="center">
														<ai:button text="ȷ    ��" id="okBtn"
															onclick="insertFunc()" style="cursor:hand"></ai:button>
														<ai:button text="ȡ    ��" id="cancelBtn"
															onclick="closeWindowFunc()" style="cursor:hand"></ai:button>

							</td>
						</tr>
					</table>
				</ai:dbform>
			</table>
			</fieldset>
		</div>
	</body>
	<script language="javascript">
	var dbformRelat=g_FormRowSetManager.get("dbformRelat");
	function sel_org()
	{
	 
	 var ret = orgSelectDialog(<%=com.ai.appframe2.common.SessionManager.getUser().getOrgId()%>);
     if(ret!=null){
     dbformRelat.setValue("ORGANIZE_ID",ret[0].orgId);
     dbformRelat.setValue("NOTES",ret[0].orgName);
     
     //document.all("ORG_NAME").value=ret[0].orgName;
     //alert(ret[0].orgId+""+ret[0].orgName)
     }
	}
</script>

</html>
