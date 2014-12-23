<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<ai:scriptinclude src="/jsv2/json.js" />
<HTML>
	<head>
		<title>MO管理</title>
	</head>

<script>
 function changeTab(aOldItemId,aNewItemId )
 {
  //alert(aNewItemId);
  refreshTabItem("tab","managemo",null,"Privilege.jsp");
 }
</script>
	
	<body style="overflow:scroll;overflow-x:hidden">
		<table border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td>
					<ai:tab id="tab" width="910" height="600" getParameter="changeTab">
						<ai:tabitem id="momanage" src="SysMoManage.jsp" title="MO信息维护" />
						<ai:tabitem id="managemo" src="Privilege.jsp" title="MO授权管理"/>
					</ai:tab>
				</td>
			</tr>
		</table>
	</body>
</html>
<script>
setTabItem("tab","momanage");
</script>