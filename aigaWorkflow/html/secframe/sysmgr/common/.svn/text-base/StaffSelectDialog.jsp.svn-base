<%-- 
/**
 *说明：操作员工选择
 *功能：操作员工选择	
 *@author: zhanghua2
 *DATE:2007-07-27
**/
 --%>
<%@ page contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<ai:scriptinclude src="/secframe/common/common.js" />
<ai:scriptinclude src="/jsv2/json.js"/>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>选择员工</title>
	</head>
	<body class="bodyTabPage">
		<span class=modeMenuName style="width:120;left:30;z-index:10;">选择员工</span>
		<div align="center">

			<table border="0" cellspacing="0" cellpadding="0" class=modeContArea
				width="500" align="center">
				<tr>
					<td align="center">
						<form name="dlgFrm">
							<table border="0" width="470" cellspacing="0" cellpadding="0">
								<tr>
									<td colspan=0>
										&nbsp;
									</td>
								</tr>
								<tr height="15">
									<td class="FormTD" colspan="3">
										选择组织:
									</td>
								</tr>
								<tr height="15">
									<td class="FormTD" colspan="4">
										&nbsp;
										<input type="text" class="dbform_disable_style" readonly
											id="orgName"
											value="<%=SessionManager.getUser().getOrgName()%>">
										<input type="hidden" id="orgId"
											value="<%=SessionManager.getUser().getOrgId()%>">
										<input type="button" value="..." id="selOrgBtn"
											onclick="selOrg()">
									</td>
								</tr>
								<tr>
									<td colspan=3>
										&nbsp;
									</td>
								</tr>
								<tr height="15">
									<td class="FormTD">
										可选员工：
									</td>
									<td></td>
									<td class="FormTD">
										已选员工：
									</td>
								</tr>
								<tr>
									<td rowspan="3" align="center">
										<select id="src_list" class="combo-hilite"
											style="width: 187; height: 221" size="10" name="src_list"
											multiple>
										</select>
									</td>
									<td height="72" valign="bottom" align="center">
										<ai:button text=">>" style="cursor:hand;" onclick="addItem()" />
									</td>
									<td rowspan="3" align="center">
										<select id="dst_list" class="combo-hilite"
											style="width: 187; height: 221" size="10" name="dst_list"
											multiple>
										</select>
									</td>
								</tr>
								<tr height="39">
									<td></td>
								</tr>
								<tr height="113">
									<td valign="top" align="center">
										<ai:button text="<<" style=" cursor:hand;" onclick="delItem()" />
									</td>
								</tr>
								<tr height="40">
									<td colspan="3" valign="bottom" align="center" height="60">
										<ai:button text=" 确定 " onclick="affirm()" />
										<ai:button text=" 取消 " onclick="cancel()" />
									</td>
								</tr>
								<tr>
									<td colspan=3>
										&nbsp;
									</td>
								</tr>
							</table>
						</form>
					</td>
				</tr>
			</table>
		</div>
		<p align="center">

		</p>
	</body>
</html>
<script type="text/javascript">
<!--
var paraObj = window.dialogArguments;
var oldOper = paraObj.arrStaff;
var singleFlag = paraObj.singleFlag
var orgName = document.getElementById("orgName");
var orgId = document.getElementById("orgId");

var srcList = document.getElementById("src_list");
var dstList = document.getElementById("dst_list");
//页面初始化
function initial(){
	if(singleFlag){
		srcList.multiple = false;
		dstList.multiple = false;
	}else{
		srcList.multiple = true;
		dstList.multiple = true;
	}
	srcListInit('<%=SessionManager.getUser().getOrgId()%>');	
}

function srcListInit(orgId){
	var url =_gModuleName+'/business/com.ai.secframe.web.sysmgr.PrivilegeAction?action=qrySysStaff&orgId='+orgId;
	var retValue = PostInfotoServer(url,'');
	srcList.length = 0;
	dstList.length = 0;
	if(retValue!="NO"){
		var objJSON = retValue.parseJSON();
		for(var i=0;i<objJSON.Staff.length;i++){
			if(!chkold(objJSON.Staff[i].staffId)){
				srcList[srcList.length] = new Option(objJSON.Staff[i].staffName,objJSON.Staff[i].staffId,false,false);
			}
		}
	}
}
initial();
function selOrg(){
	var ret = orgSelectDialog(<%=com.ai.appframe2.common.SessionManager.getUser().getOrgId()%>);
	if(ret!=null){
		orgName.value = ret[0].orgName;
		orgId.value = ret[0].orgId;
		srcListInit(ret[0].orgId);
	}
}
function cancel(){
	window.self.close();
}
function affirm(){
	if(hasSelect()){
		var list = new Array();
		for(var i=0;i<dstList.length;i++){
			list[i] = new Staff(dstList.options[i].value,dstList.options[i].text,orgId.value,orgName.value,'');
		}
		window.returnValue = list;
		window.self.close();
	}else{
		alert("请选择员工！");
		return false;
	}
}
function addItem(){
	if(singleFlag&&srcList.value!=""){
		for( var i=dstList.length-1;i>=0;i--)        {
          srcList[srcList.length] = new Option(dstList[i].text,dstList[i].value,false,false);
          dstList[i] = null;
        }        
	}
	for (var i=srcList.length-1;i>=0;i--) {
      if (srcList[i].selected) {
        //如果已经选择某个item,就不将其加入
        for(var m=0;m<dstList.length;m++){
            if(srcList[i].value == dstList[m].value)
                return;
        }
        dstList[dstList.length] = new Option(srcList[i].text,srcList[i].value,false,false);
        srcList[i] = null;
      }
    }
}
function delItem(){
	 for (var i=dstList.length-1;i>=0;i--) {
      if (dstList[i].selected) {
        srcList[srcList.length] = new Option(dstList[i].text,dstList[i].value,false,false);
        dstList[i] = null;
      }
    }
}
function Staff(staffId,staffName,orgId,orgName,staffCode){
	this.staffId = staffId;
	this.staffName = staffName;
	this.orgId = orgId;
	this.orgName = orgName;
	this.staffCode = staffCode;
}
function hasSelect(){
	if(dstList.length<=0){
		return false;
	}
	return true;
}
function chkold(staffId){
	for(var i=0;i<oldOper.length;i++){
		if(staffId==oldOper[i])
			return true;
	}
	return false;
}
//-->
</script>
