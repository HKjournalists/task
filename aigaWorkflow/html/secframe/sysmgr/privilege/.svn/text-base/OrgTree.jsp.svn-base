<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<ai:scriptinclude src="/secframe/common/common.js" />
<HTML>
<head>
<title>组织结构树</title>
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
  <tr>
    <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
        <tr>
          <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
          <td style="height: 20px">组织选择</td>
          <td align="right" style="height: 20px"></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"  align="center" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" height="50">
        <tr>
          <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">组织编号</td>
          <td width="1"></td>
          <td bgcolor="#F1F3FB" class="font13pxboldblack" colspan="5"><input type="text" class="dbform_disable_style" readonly
										id="orgId" value="<%=SessionManager.getUser().getOrgId()%>"></td>
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
          <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">组织名称</td>
          <td width="1"></td>
          <td bgcolor="#F1F3FB" class="font13pxboldblack" colspan="5"><input type="text" class="dbform_disable_style" readonly
										id="orgName"
										value="<%=SessionManager.getUser().getOrgName()%>">
            <input type="button" value="..." class="btn-1word" id="selOrgBtn"
										onclick="selOrg()"></td>
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
</table>
</body>
<script language="javascript">
var flag = 1;
var orgName = document.getElementById("orgName");
var orgId = document.getElementById("orgId");
init();
function selOrg(){
	var ret = orgSelectDialog(-1);
	if(ret!=null){
		orgName.value = ret[0].orgName;
		orgId.value = ret[0].orgId;
	}
	init();
}
function init(){
	window.parent.qryObj(orgId.value);
}
</script>
</html>