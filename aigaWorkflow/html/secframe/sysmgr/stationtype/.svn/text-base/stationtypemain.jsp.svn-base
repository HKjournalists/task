<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="java.util.HashMap" %>
<%@include file="/secframe/common/common.jsp"%>

<HTML >
<head>
<title>岗位类型管理页面</title>
<script>
 function changeTab(aOldItemId,aNewItemId )
 {
  //alert(aNewItemId);
  refreshTabItem("station_type_main","station_type_sysfuc",null,"stationtypefunc.jsp");
 }
</script>
</head>
<body  class="bodyTab">
<!--====================== 将页面主体放置在页面正中=========================-->
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr><td height=5 width=100%></td></tr>
<tr>
<td width="100%" align="center">
<ai:tab id="station_type_main" height="510" width="100%" type="H" getParameter="changeTab">
<ai:tabitem id="station_type_mgr" src="stationtype.jsp" title="岗位类型定义" initial="true"></ai:tabitem>
<ai:tabitem id="station_type_sysfuc" src="stationtypefunc.jsp" title="包含功能定义" initial="false"></ai:tabitem>
<ai:tabitem id="station_type_orgtype" src="orgtype_stationtype.jsp" title="岗位类型和组织类型关系" initial="false"></ai:tabitem>
</ai:tab>
</td></tr>
</table>

</body>
</html>
