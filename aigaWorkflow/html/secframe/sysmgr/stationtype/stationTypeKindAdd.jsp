<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="java.util.HashMap" %>
<%@include file="/secframe/common/common.jsp"%>
<html>
	<head>
<script language=javascript>
var gParamArray = dialogArguments;
window.returnValue="undefined";
function addAction(){
	var gRowSet = g_FormRowSetManager.get("stationtypekindform");
  if( gRowSet.getValue("KIND_NAME") == null || gRowSet.getValue("KIND_NAME") == "" ){
    alert("分类名称不能为空,请填写分类名称");
    gRowSet.setFocus("NAME");
    return;
  }
  var sortId = gRowSet.getValue("SORT_ID");
  if(!g_IsDigit(sortId)){
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
  var retMsg = saveRowSet("<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysStationTypeModel?action=saveStationTypeKind",list);
  var ret = retMsg.getValueByName("retVal");
  if( ret == 'OK'){
  	alert("岗位类型分类新增成功");
    window.returnValue = ret+"$"+gRowSet.getValue("KIND_NAME");
    closeAction();
  }else{
    alert(ret);
  }
}

function closeAction(){
  top.close();
}

</script>
	<BODY>
		<span class="modeMenuName"  style="width:120;left:30;z-index:10;">
			岗位类型分类增加
		</span>
		<br>
		<div id="MyFormArea" style="display:block;">

			<table border="0" cellspacing="0" cellpadding="0" class=modeContArea width="600" align="center" height="100">
				<ai:dbform formid="stationtypekindform" setname="com.ai.secframe.bo.sysmgr.SysStationTypeKind" 
				           initial="false" datamodel="com.ai.appframe2.web.datamodel.QueryModelForService" 
				           implservice_name="com.ai.secframe.service.sysmgr.SysStationTypeKind"
				           implservice_querymethod="querySysStationTypeKind">
					<tr><td colspan="4" height="15"></td></tr>
					<tr height=20>
						<td width="100" class="FormTDName">
							分类代码:
						</td>
						<td width="200" class="FormTD">
							<ai:dbformfield fieldname="KIND_ID" formid="stationtypekindform" width="180" />
					  </td>
						<td width="100" class="FormTDName">
							分类名称:
						</td>
						<td width="200" class="FormTD">
							<ai:dbformfield fieldname="KIND_NAME" formid="stationtypekindform" width="180" /><span class="pr9">*</span>
					  </td>
					</tr>
					<tr>
						<td width="100" class="FormTDName">
							上级分类:
						</td>
						<td width="200" colclass="FormTD">
							<ai:dbformfield fieldname="PARENT_KIND_ID" formid="stationtypekindform" width="180" />
					  </td>
						<td width="100" class="FormTDName">
							分类序号:
						</td>
						<td width="200" class="FormTD">
							<ai:dbformfield fieldname="SORT_ID" formid="stationtypekindform" width="180" />
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
var gRowSet = g_FormRowSetManager.get("stationtypekindform");
gRowSet.setValue("PARENT_KIND_ID",gParamArray[0],gParamArray[1]);
</script>
</HTML>
