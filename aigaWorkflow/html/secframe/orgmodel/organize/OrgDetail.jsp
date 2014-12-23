<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<%@ page import="com.ai.appframe2.web.HttpUtil"%>
<%@ page import="com.ai.appframe2.service.ServiceFactory"%>
<%@ page import="com.ai.secframe.common.Constants"%>
<%@ page import="com.ai.secframe.service.orgmodel.interfaces.ISysOrganize"%>
<%@ page import="com.ai.secframe.ivalues.orgmodel.ISysOrganizeValue"%>
<html>
<head>
<title>组织基本信息</title>
</head>
<body>
<%
	String org_id = HttpUtil.getParameter(request, "org_id");
	ISysOrganize organizeSv = (ISysOrganize) ServiceFactory.getService( Constants.SERVICE_SYS_ORGANIZE );
    ISysOrganizeValue val = organizeSv.getSysOrganizeById( Long.valueOf(org_id).longValue() );
    long org_state = val.getState();
%>
<ai:dbform setname="com.ai.secframe.bo.orgmodel.SysOrganize"
	formid="partyRoleOrg_form"
	datamodel="com.ai.appframe2.web.datamodel.QueryModelForService"
	implservice_name="com.ai.secframe.service.orgmodel.SysOrganize" 
	implservice_querymethod="querySysOrganize"
	initial="false"
	editable="false">
<ai:dbformfield fieldname="ORGANIZE_ID" formid="partyRoleOrg_form"
	width="150" visible="false" />
<ai:dbformfield fieldname="PARENT_ORGANIZE_ID"
	formid="partyRoleOrg_form" width="150" visible="false" />
<table width="100%" border=0 cellpadding=0 cellspacing=0>
  <tr>
    <td valign="top"  bgcolor="#FFFFFF"><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px"> 组织信息</td>
                <td align="right" style="height: 20px"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="left" valign="top">
		  
		  <table width="100%" border="0" cellpadding="0" cellspacing="0" height="400">
              <tr>
                <td width="140" bgcolor="#E5EFF5" class="font13pxboldblue1">组织名称</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="ORGANIZE_NAME" formid="partyRoleOrg_form" width="150" />
                <span class=pr9>*</span></td>
                <td width="1"></td>
                <td width="140" bgcolor="#E5EFF5" class="font13pxboldblue1">编码</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="CODE" formid="partyRoleOrg_form" width="150" />
                <span class="pr9">*</span></td>
              </tr>
              <tr>
                <td width="140" height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td width="140" class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="140" bgcolor="#E5EFF5" class="font13pxboldblue1">英文名称</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="ENGLISH_NAME" formid="partyRoleOrg_form" width="150" /></td>
                <td width="1"></td>
                <td width="140" bgcolor="#E5EFF5" class="font13pxboldblue1">简称</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="SHORT_NAME" formid="partyRoleOrg_form" width="150" /></td>
              </tr>
              <tr>
                <td width="140" height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td width="140" class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="140" bgcolor="#E5EFF5" class="font13pxboldblue1">负责人名称</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="MANAGER_NAME" formid="partyRoleOrg_form" width="150" /></td>
                <td width="1"></td>
                <td width="140" bgcolor="#E5EFF5" class="font13pxboldblue1">EMAIL</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="EMAIL" formid="partyRoleOrg_form" width="150" /></td>
              </tr>
              <tr>
                <td width="140" height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td width="140" class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="140" bgcolor="#E5EFF5" class="font13pxboldblue1">联系电话</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="PHONE_ID" formid="partyRoleOrg_form" width="150" /></td>
                <td width="1"></td>
                <td width="140" bgcolor="#E5EFF5" class="font13pxboldblue1">传真</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="FAX_ID" formid="partyRoleOrg_form" width="150" /></td>
              </tr>
              <tr>
                <td width="140" height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td width="140" class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="140" bgcolor="#E5EFF5" class="font13pxboldblue1">联系人名称</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="CONTACT_NAME" formid="partyRoleOrg_form" width="150" /></td>
                <td width="1"></td>
                <td width="140" bgcolor="#E5EFF5" class="font13pxboldblue1">联系人手机</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="CONTACT_BILL_ID" formid="partyRoleOrg_form" width="150" /></td>
              </tr>
              <tr>
                <td width="140" height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td width="140" class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="140" bgcolor="#E5EFF5" class="font13pxboldblue1">联系人证件类型</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="CONTACT_CARD_TYPE" formid="partyRoleOrg_form" width="150" /></td>
                <td width="1"></td>
                <td width="140" bgcolor="#E5EFF5" class="font13pxboldblue1">联系人证件号码</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="CONTACT_CARD_ID" formid="partyRoleOrg_form" width="150" /></td>
              </tr>
              <tr>
                <td width="140" height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td width="140" class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="140" bgcolor="#E5EFF5" class="font13pxboldblue1">归属地区</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="DISTRICT_ID"  formid="partyRoleOrg_form" width="150" /></td>
                <td width="1"></td>
                <td width="140" bgcolor="#E5EFF5" class="font13pxboldblue1">区县</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="COUNTY_ID" formid="partyRoleOrg_form" width="150" />
                  <input name="Input" type="button" class="btn-1word" value=".." id="selectDis" onClick="selectDis()"/></td>
              </tr>
              <tr>
                <td width="140" height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td width="140" class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="140" bgcolor="#E5EFF5" class="font13pxboldblue1">组织类型</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield  fieldname="ORG_ROLE_TYPE_ID" formid="partyRoleOrg_form" width="150" visible="true" />
                  <input name="Input" type="button" class="btn-1word" value=".." id="selectOrgType" onClick="selectOrgType()"/>
                </td>
                <td width="1"></td>
                <td width="140" bgcolor="#E5EFF5" class="font13pxboldblue1">人数</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="MEMBER_NUM" formid="partyRoleOrg_form" width="150" /></td>
              </tr>
              <tr>
                <td width="140" height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td width="140" class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="140" bgcolor="#E5EFF5" class="font13pxboldblue1">是否叶子</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="IS_LEAF" formid="partyRoleOrg_form" width="150" /></td>
                <td width="1"></td>
                <td width="140" bgcolor="#E5EFF5" class="font13pxboldblue1">OA组织编号</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="EXT1" formid="partyRoleOrg_form" width="150" /></td>
              </tr>
              <tr>
                <td width="140" height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td width="140" class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="140" bgcolor="#E5EFF5" class="font13pxboldblue1">扩展2</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="EXT2" formid="partyRoleOrg_form" width="150" /></td>
                <td width="1"></td>
                <td width="140" bgcolor="#E5EFF5" class="font13pxboldblue1">扩展3</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="EXT3" formid="partyRoleOrg_form" width="150" /></td>
              </tr>
              <tr>
                <td width="140" height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td width="140" class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="140" bgcolor="#E5EFF5" class="font13pxboldblue1">组织地址</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack" colspan="5"><ai:dbformfield fieldname="ORG_ADDRESS" formid="partyRoleOrg_form" width="400" />
                  </td>
              </tr>
              <tr>
                <td width="140" height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td width="140" class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="140" bgcolor="#E5EFF5" class="font13pxboldblue1">备注</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack" colspan="5"><ai:dbformfield fieldname="NOTES" edittype="DBTextArea" formid="partyRoleOrg_form" width="400" /></td>
              </tr>
              <tr>
                <td width="140" height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td width="140" class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="140" bgcolor="#E5EFF5" class="font13pxboldblue1">邮寄省份</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="POST_PROVINCE" formid="partyRoleOrg_form" width="150" /></td>
                <td width="1"></td>
                <td width="140" bgcolor="#E5EFF5" class="font13pxboldblue1">邮寄地市</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="POST_CITY" formid="partyRoleOrg_form" width="150" /></td>
              </tr>
              <tr>
                <td width="140" height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td width="140" class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="140" bgcolor="#E5EFF5" class="font13pxboldblue1">邮寄邮编</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="POST_POSTCOD" formid="partyRoleOrg_form" width="150" /></td>
                <td width="1"></td>
                <td width="140" bgcolor="#E5EFF5" class="font13pxboldblue1">邮寄地址</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="POST_ADDRESS" formid="partyRoleOrg_form" width="150" /></td>
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
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" style="padding-top:5px; padding-bottom:5px;"><div id="buttonDiv" align="center">
              <input name="Input" type="button" class="btn-2word" value="新增" id="insertOrg" onClick="insertOrg()"/>
              &nbsp;
              <input name="Input2" type="button" class="btn-2word" value="保存" id="saveOrg" onClick="saveOrg()"/>
              &nbsp;
              <input name="Input2" type="button" class="btn-2word" value="删除" id="deleteOrg" onClick="deleteOrg()"/>
            </div></td>
        </tr>
      </table></td>
  </tr>
</table>
</ai:dbform>
</body>
</html><script>
  	var org_id = "<%=org_id%>";
  	var org_state = "<%=org_state%>";
  	var partyRoleOrg_formRowSet = g_FormRowSetManager.get("partyRoleOrg_form");
  
	function refresh_Org_Form(org_id)
	{
     	if(org_id!=""){
     		partyRoleOrg_formRowSet.refresh("ORGANIZE_ID = "+org_id);
     		partyRoleOrg_formRowSet.setEditSts(true);
     		partyRoleOrg_formRowSet.setColEditSts("CODE",false);
     		partyRoleOrg_formRowSet.setColEditSts("ORG_ROLE_TYPE_ID",false);
     		partyRoleOrg_formRowSet.setColEditSts("DISTRICT_ID",false);
     		partyRoleOrg_formRowSet.setColEditSts("COUNTY_ID",false);  
     		var msg;
     		var result; 		
     		
     		if(partyRoleOrg_formRowSet.getValue("DISTRICT_ID")!=''){   		
	     		msg = PostInfo("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysOrganizeAction?"+
					"action=getDisInfo&dis_id="+partyRoleOrg_formRowSet.getValue("DISTRICT_ID"));
				result = msg.getValueByName("retVal"); 
				partyRoleOrg_formRowSet.setValue("DISTRICT_ID",result);
			}
			if(partyRoleOrg_formRowSet.getValue("COUNTY_ID")!=''){ 
				msg = PostInfo("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysOrganizeAction?"+
					"action=getDisInfo&dis_id="+partyRoleOrg_formRowSet.getValue("COUNTY_ID"));
				result = msg.getValueByName("retVal"); 
				partyRoleOrg_formRowSet.setValue("COUNTY_ID",result);			
			}
			if(partyRoleOrg_formRowSet.getValue("ORG_ROLE_TYPE_ID")!=''){ 
				msg = PostInfo("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysOrganizeAction?"+
					"action=getRoleTypeInfo&role_type_id="+partyRoleOrg_formRowSet.getValue("ORG_ROLE_TYPE_ID"));
				result = msg.getValueByName("retVal"); 
	     		partyRoleOrg_formRowSet.setValue("ORG_ROLE_TYPE_ID",result); 
	     	}
	     	document.getElementById("selectDis").disabled = org_state==0?true:false;
			document.getElementById("selectOrgType").disabled = org_state==0?true:false;
			document.getElementById("insertOrg").disabled = org_state==0?true:false;
			document.getElementById("saveOrg").disabled = org_state==0?true:false;
			document.getElementById("deleteOrg").disabled = org_state==0?true:false;  		
		} else {
			document.getElementById("selectDis").disabled = true;
			document.getElementById("selectOrgType").disabled = true;
			document.getElementById("insertOrg").disabled = true;
			document.getElementById("saveOrg").disabled = true;
			document.getElementById("deleteOrg").disabled = true;
		}
	}
	refresh_Org_Form(org_id);
	
	function selectOrgType(){
		var result = window.showModalDialog("OrgTypeTree.jsp","org","scroll:no;resizable:no;status:no;dialogHeight:460px;dialogWidth:300px");
		if(result=='undefined'||result==null){
			result="";
		} else {
			partyRoleOrg_formRowSet.setValue("ORG_ROLE_TYPE_ID",result);	
		}
	}
	
	function selectDis(){
		var result = window.showModalDialog("<%=request.getContextPath()%>/secframe/sysmgr/common/DistrictSelectDialog.jsp","org","scroll:no;resizable:no;status:no;dialogHeight:460px;dialogWidth:300px");
		if(result=='undefined'||result==null){
			result="";
		}else {
			result = result.split('&');
			partyRoleOrg_formRowSet.setValue("DISTRICT_ID",result[0]);	 
			partyRoleOrg_formRowSet.setValue("COUNTY_ID",result[1]);	 
		}
	}

	function insertOrg(){
		if(org_id==''){
			alert('请选择一个所属的上级组织!');
			return;
		}		
		partyRoleOrg_formRowSet.refresh("ORGANIZE_ID = -1");
		partyRoleOrg_formRowSet.setValue("PARENT_ORGANIZE_ID",org_id);
		partyRoleOrg_formRowSet.setEditSts(true);
		partyRoleOrg_formRowSet.setColEditSts("CODE",false);
		partyRoleOrg_formRowSet.setColEditSts("ORG_ROLE_TYPE_ID",false);
		partyRoleOrg_formRowSet.setColEditSts("DISTRICT_ID",false);
		partyRoleOrg_formRowSet.setColEditSts("COUNTY_ID",false);  
		if(org_id!=""&&org_id!=null){
			var msg = PostInfo("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysOrganizeAction?"+
				"action=getOrganizeCodeByJsp&org_id="+org_id);
			var result = msg.getValueByName("retVal"); 
			if(result=="-1"){
				alert("获取regCode失败！");
			}else if(result=="-5"){
				 alert(msg.getValueByName("errorMsg"));
			}
			else{
				 partyRoleOrg_formRowSet.setValue("CODE",result);
			}	
		}
			document.getElementById("insertOrg").disabled = true;
			document.getElementById("saveOrg").disabled = false;
			document.getElementById("deleteOrg").disabled = true;
	}

	function saveOrg(){		
		if( partyRoleOrg_formRowSet.getValue("ORGANIZE_NAME")==null ||
		    partyRoleOrg_formRowSet.getValue("ORGANIZE_NAME") =="" ){
			alert('请输入组织名称!');
			partyRoleOrg_formRowSet.setFocus("ORGANIZE_NAME");
			rturn;
		}
		

	    if(partyRoleOrg_formRowSet.getValue("EMAIL")!=null
	    	&& partyRoleOrg_formRowSet.getValue("EMAIL")!=""
	    	&& !g_IsEmail(partyRoleOrg_formRowSet.getValue("EMAIL"))){
	    	alert("请输入正确的Email格式，形如:test@test.com");
	    	partyRoleOrg_formRowSet.setFocus("EMAIL");
	    	return;
	    }
	    if(partyRoleOrg_formRowSet.getValue("PHONE_ID")!=null
	    	&& partyRoleOrg_formRowSet.getValue("PHONE_ID")!=""
	    	&& !g_IsTeleNumber(partyRoleOrg_formRowSet.getValue("PHONE_ID"))){
	    	alert("请输入正确的普通电话格式，形如:+86-021-12345678");
	    	partyRoleOrg_formRowSet.setFocus("PHONE_ID");
	    	return;
	    }
	    if(partyRoleOrg_formRowSet.getValue("FAX_ID")!=null
	    	&& partyRoleOrg_formRowSet.getValue("FAX_ID")!=""
	    	&& !g_IsTeleNumber(partyRoleOrg_formRowSet.getValue("FAX_ID"))){
	    	alert("请输入正确的传真格式，形如:+86-021-12345678");
	    	partyRoleOrg_formRowSet.setFocus("FAX_ID");
	    	return;
	    }
	    if(partyRoleOrg_formRowSet.getValue("CONTACT_BILL_ID")!=null
	    	&& partyRoleOrg_formRowSet.getValue("CONTACT_BILL_ID")!=""
	    	&& !g_IsMobileNumber(partyRoleOrg_formRowSet.getValue("CONTACT_BILL_ID"))){
	    	alert("请输入正确的手机号码格式，形如:13900000000");
	    	partyRoleOrg_formRowSet.setFocus("CONTACT_BILL_ID");
	    	return;
	    }
	    if(partyRoleOrg_formRowSet.getValue("CONTACT_CARD_TYPE")!=null
	    	&& partyRoleOrg_formRowSet.getValue("CONTACT_CARD_TYPE")!=""){
	    	if(partyRoleOrg_formRowSet.getValue("CONTACT_CARD_ID")==null
	    		|| partyRoleOrg_formRowSet.getValue("CONTACT_CARD_ID")==""){
	    		alert("请填入正确的联系人证件号码");
	    		partyRoleOrg_formRowSet.setFocus("CONTACT_CARD_ID");
	    		return;
	    	}
	      //判断身份证号码
	    	if(partyRoleOrg_formRowSet.getValue("CONTACT_CARD_TYPE")=="1"){
	        var card_id = partyRoleOrg_formRowSet.getValue("CONTACT_CARD_ID");
	
	        if(!g_IDCardNumber(card_id)){
	      		alert("请输入15位或者18位的身份证号码");
	      		partyRoleOrg_formRowSet.setFocus("CONTACT_CARD_ID");
	      		return;
	        }
	    	}
	    }
	
	    //判断是否修改
	    if(partyRoleOrg_formRowSet.toXmlString(true)==""){
				alert('当前的数据尚未被修改，不需要保存！');
				return;
		}
		
    		
     	if(partyRoleOrg_formRowSet.getValue("DISTRICT_ID")!=''){
     		partyRoleOrg_formRowSet.setValue("DISTRICT_ID",partyRoleOrg_formRowSet.getValue("DISTRICT_ID").split('|')[0]);
     	}
     	if(partyRoleOrg_formRowSet.getValue("COUNTY_ID")!=''){
     		partyRoleOrg_formRowSet.setValue("COUNTY_ID",partyRoleOrg_formRowSet.getValue("COUNTY_ID").split('|')[0]);
     	}
     	if(partyRoleOrg_formRowSet.getValue("ORG_ROLE_TYPE_ID")!=''){
     		partyRoleOrg_formRowSet.setValue("ORG_ROLE_TYPE_ID",partyRoleOrg_formRowSet.getValue("ORG_ROLE_TYPE_ID").split('|')[0]);
     	}
    
	    var list = new Array();	
	    list.push(partyRoleOrg_formRowSet);	
	
	    var msg = saveRowSet("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysOrganizeAction?action=saveSysOrganize&org_id="+org_id
	    ,list,false ,false);
	    var ret = msg.getValueByName("retVal");
	 	if( ret == 0 )
		{
		  alert("组织更新成功!");
		  parent.refreshCurNode();
		  var org_id=msg.getValueByName("org_id");
		  
		  var org_name=partyRoleOrg_formRowSet.getValue("ORGANIZE_NAME");
		  if(!isNaN(org_id))
		  refresh_Org_Form(org_id);
		  parent.refreshParentTreeNode(org_id,org_name);
		}else{
		  alert("操作失败:"+msg.getValueByName("errorMsg"));
		}

	}

	//删除
	function deleteOrg(){		
		parent.delOrgByRoleId(org_id);
	}

</script>
