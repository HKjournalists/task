<%-- 
/**
 *说明：Sys_Directory维护界面
 *功能：增
 *@author: zhanghua2
 *DATE:2007-07-11
**/
 --%>
<%@ page contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<base target="_self">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>新增资源包</title>
	</head>
	<body>
		<br>
		<fieldset id="contentFieldset"
			style="text-align:left;font-size:12;width:80%;height:80%"
			align="center">
			<LEGEND class="FormZName">
				新增资源包
			</LEGEND>
			<p>
				<ai:dbform formid="frmsysmo"
					setname="com.ai.secframe.bo.sysmgr.SysDirectory" editable="true"
					initial="false">
					<table align="center" border="0">
						<tr>
							<td width="30%" align="left">
								域编号：
							</td>
							<td width="70%">
								<input type="text"
									value=""
									style="width:120px;" class="dbform_disable_style" readonly>
								<br>

							</td>
						</tr>
						<tr>
							<td width="30%" align="left">
								资源包名称：
							</td>
							<td>
								<ai:dbformfield fieldname="NAME" formid="frmsysmo"
									editable="true" width="120px"/>
								<ai:dbformfield fieldname="PARENT_ID" formid="frmsysmo"
									visible="false" />
							</td>
						</tr>
						<tr>
							<td colspan="3" align="center">
								<ai:button text=" 保存 "  onclick="return saveDir()" />
								<ai:button text=" 取消 " onclick="window.self.close();" />
							</td>
						</tr>
					</table>
				</ai:dbform>

			</p>
		</fieldset>
	</body>
</html>
<script type="text/javascript">
<!--
var node = window.dialogArguments;
var frmsysmo = g_FormRowSetManager.get("frmsysmo");

function saveDir(){
	frmsysmo.setValue("PARENT_ID",node.value);
	if(frmsysmo.getValue("NAME").length<=0){
		window.alert("请填写资源包名称！");
		return false;
	}
	var list = new Array();
	list[0] = frmsysmo;
	saveRowSet(_gModuleName+"/business/com.ai.secframe.web.sysmgr.SysMoMamageAction?action=saveSysDir",list);
	window.self.close();
}
//-->
</script>
