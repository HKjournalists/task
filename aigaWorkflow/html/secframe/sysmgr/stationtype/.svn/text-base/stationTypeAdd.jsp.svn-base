<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="java.util.HashMap" %>
<%@include file="/secframe/common/common.jsp"%>
<HTML>
<head>
<script language=javascript>
var gParamArray = dialogArguments;
window.returnValue="undefined";
function addAction(){
	var gRowSet = g_FormRowSetManager.get("stationtypeform");
  if( gRowSet.getValue("CODE") == null || gRowSet.getValue("CODE") == "" ){
  	alert("岗位类型代码不能为空,请填写岗位类型代码");
    gRowSet.setFocus("CODE");
    return;
  }
  if( gRowSet.getValue("NAME") == null || gRowSet.getValue("NAME") == "" ){
    alert("岗位类型名称不能为空,请填写岗位类型名称");
    gRowSet.setFocus("NAME");
    return;
  }
  var sortId = gRowSet.getValue("SORT_ID");
  if(g_IsDigit(sortId)==false){
  	alert("序号只能为数字！");
  	gRowSet.setValue("SORT_ID","");
  	gRowSet.setFocus("SORT_ID");
  	return;
  }
  if(g_GetStrLen(sortId)>3){
  	alert("序号的长度必须小于等于3位");
  	gRowSet.setValue("SORT_ID","");
  	gRowSet.setFocus("SORT_ID");
  	return;
  }
  gRowSet.setStsToNew();
  var list = new Array();
  list.push(gRowSet);
  var retMsg = saveRowSet("<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysStationTypeModel?action=saveStationType&parentKindId="+gParamArray[0],list);
  var ret = retMsg.getValueByName("retVal");
  if( ret == 'OK'){
  	alert("岗位类型新增成功");
    window.returnValue = ret+"$"+gRowSet.getValue("NAME");
    closeAction();
  }else{
    alert(ret);
  }
}

function closeAction(){
  top.close();
}

</script>
</head>
	<BODY class="bodyTabPage">
		<span class=modeMenuName style="width:100;left:30;z-index:10;">
			岗位类型增加
		</span>
		<br>
		<div id="MyFormArea" style="display:block;">

			<table border="0" cellspacing="0" cellpadding="0" class=modeContArea width="600" align="center" height="110">
				<ai:dbform formid="stationtypeform" setname="com.ai.secframe.bo.sysmgr.SysStationType" initial="false" datamodel="com.ai.appframe2.web.datamodel.QueryModelForService" implservice_name="com.ai.secframe.service.sysmgr.SysStationType"
					implservice_querymethod="queryStationType">
					<tr><td colspan="4" height="10"></td></tr>
					<tr height=20>
						<td width="100" class="FormTDName">
							岗位类型代码:
						</td>
						<td width="200" class="FormTD">
							<ai:dbformfield fieldname="CODE" formid="stationtypeform" width="180" /><span class="pr9">*</span>
					  </td>
						<td width="100" class="FormTDName">
							岗位类型名称:
						</td>
						<td width="200" class="FormTD">
							<ai:dbformfield fieldname="NAME" formid="stationtypeform" width="180" /><span class="pr9">*</span>
					  </td>
					</tr>
					<tr>
						<td width="100" class="FormTDName">
							岗位类型分类:
						</td>
						<td width="200" colclass="FormTD">
							<ai:dbformfield fieldname="KIND_ID" formid="stationtypeform" width="180" />
					  </td>
						<td width="100" class="FormTDName">
							岗位类型序号:
						</td>
						<td width="200" class="FormTD">
							<ai:dbformfield fieldname="SORT_ID" formid="stationtypeform" width="180" />
					  </td>
					</tr>
					<tr>
						<td width="100" class="FormTDName">
							岗位类型备注:
						</td>
						<td colspan="3" class="FormTD">
							<ai:dbformfield fieldname="NOTES" formid="stationtypeform" editable="true" width="480" />
						</td>
					</tr>
				</ai:dbform>
		  </table>
			<div id="buttonDiv" style="position:absolute;right:250;bottom:10;">
				<ai:button text="保  存" id="addChildBtn" onclick="addAction()" style="cursor:hand"></ai:button>
				&nbsp;&nbsp;
				<ai:button text="取  消" id="updateChildBtn" onclick="closeAction()" style="cursor:hand"></ai:button>
			</div>
		</div>
	</BODY>
<script language="JavaScript">
var gRowSet = g_FormRowSetManager.get("stationtypeform");
gRowSet.setValue("KIND_ID",gParamArray[0],gParamArray[1]);
</script>
</HTML>
