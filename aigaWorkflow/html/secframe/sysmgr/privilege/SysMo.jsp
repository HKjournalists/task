<%@ page contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>������Դ�ļ�</title>
	</head>
	<body>
		<br>
		<fieldset id="contentFieldset"
			style="text-align:left;font-size:12;width:80%;height:80%"
			align="center">
			<LEGEND class="FormZName">
				������Դ�ļ�
			</LEGEND>
			<p>
				<ai:dbform formid="frmsysmo"
				datamodel="com.ai.appframe2.web.datamodel.QueryModelForService"
				implservice_name="com.ai.secframe.service.sysmgr.SysMo"
				implservice_querymethod="querySysMo"	
					setname="com.ai.secframe.bo.sysmgr.SysMo" editable="true"
					initial="false">
					
			<table align="center" border="0">
						<tr>
							<td width="30%" align="left">
								���ţ�
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
				��Դ�ļ����ƣ�</td><td><ai:dbformfield width="120" fieldname="NAME" formid="frmsysmo"
						editable="true" />
					<ai:dbformfield fieldname="DIR_ID" formid="frmsysmo"
						visible="false" />
					<ai:dbformfield fieldname="DIR_FULL_NAME" formid="frmsysmo"
						visible="false" />
						</td>
						</tr>
						<tr>
							<td colspan="3" align="center">
								<ai:button text=" ���� " onclick="return saveDir()" />
								<ai:button text=" ȡ�� " onclick="window.self.close();" />
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
var arrNode = window.dialogArguments;
var frmsysmo = g_FormRowSetManager.get("frmsysmo");
function saveDir(){
	if(frmsysmo.getValue("NAME").length<=0){
		alert("����д��Դ�ļ����ƣ�");
		return false;
	}
	var dirFullName = (arrNode[1]==''?'':(arrNode[1]+'.'))+frmsysmo.getValue("NAME");
	frmsysmo.setValue("DIR_FULL_NAME",dirFullName);
	frmsysmo.setValue("DIR_ID",arrNode[0]);
	var list = new Array();
	list[0] =frmsysmo;
	saveRowSet(_gModuleName+"/business/com.ai.secframe.web.sysmgr.SysMoMamageAction?action=saveMo",list);
	window.self.close();
}
//-->
</script>
