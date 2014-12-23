<%-- 
/**
 *说明：功能选择
 *功能：功能选择	
 *@author: xingxj
 *DATE:2007-07-27
**/
 --%>
<%@ page contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>选择功能</title>
	</head>
	<body>
		<table border=0 width=250 align="center">
			<tr>
				<td width="240">
					<ai:dbtree_new id="funcTree"
						datamodel="com.ai.secframe.web.sysmgr.SysStationTypeFunctionModel"
						multiselect="false" height="360" width="270" ishaveline="true" ondblclick="chkCur"/>
				</td>
			</tr>
		</table>
		<p align="center"><ai:button text=" 确定 " onclick="affirm()"/>
		<ai:button text=" 取消 " onclick="cancel()"/></p>
	</body>
</html>
<script type="text/javascript">
<!--
var curNode = null;
var dbTree = g_DBTreeNewManager.get("funcTree");
dbTree.refresh(null,-1,"stationTypeId=100000");

function affirm(){
	curNode = dbTree.getCurNodeInfo();
	if(curNode == null){
		alert("请选择菜单！");
		return false;
	}
	var v_org = new Func(curNode.value,curNode.text);
	var list = new Array();
	list[0] = v_org
	window.returnValue = list;
	window.self.close();
}
function Func(funcId,funcName){
	this.funcId = funcId;
	this.funcName = funcName;
}
function cancel(){	
	window.self.close();
}
function chkCur(){
	affirm();
}
//-->
</script>
