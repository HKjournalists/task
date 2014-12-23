<!--<html>
/************************************************

  Created Date:
  Project Name:
  Module Name:       
  Author:             
  Version:            
  begin Version Date: 
  Last Version Date:  

************************************************/
-->
<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<HTML>
	<head>
		<title>当前用户对应的域信息</title>
	</head>

	<body  style="width:100%;height:100%;overflow:auto">
       <fieldset id="contentFieldset" style="text-align:left;font-size:12;width:410" align="center" >
        <LEGEND  class=FormZName>当前用户对应的域信息</LEGEND>
		<table width="320" align="center">
			<tr>
				<td>
					<ai:table setname="com.ai.secframe.bo.sysmgr.SysDomain"
						tableid="sysDomain" needrefresh="true" initial="true"
						multiselect="false" editable="false"  width="410"
						height="40"  footdisplay="none"
						tablemodel="com.ai.appframe2.web.datamodel.QueryModelForService"
						implservice_name="com.ai.secframe.service.sysmgr.SysDomain"
						implservice_querymethod="getSysDomainInfo"
						implservice_countmethod="qrySysDomainCount">
						<ai:col fieldname="DOMAIN_ID"/>
						<ai:col fieldname="CODE" />
						<ai:col fieldname="NAME" />		
						<ai:col fieldname="NOTES" />					
					</ai:table>
				</td>
			</tr>
		</table>
		</fieldset>
		
	</body>
</html>
<script language="javascript">
var rowSet=g_TableRowSetManager.get('sysDomain');

var rowCount=rowSet.getTotalRowCount();

for(var i=0;i<rowCount;i++){
rowSet.rowSelected(i,true);
rowSet.disabledSelect(i,true);

}
</script>

