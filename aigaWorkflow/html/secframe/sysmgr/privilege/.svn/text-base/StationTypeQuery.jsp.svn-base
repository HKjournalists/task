<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<html>
<head>
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
<title>查询岗位类型</title>
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
          <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">组织ID</td>
          <td width="1"></td>
          <td bgcolor="#F1F3FB" class="font13pxboldblack" colspan="5"><input type="text" style="width:150" id="q_code" /></td>
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
          <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">名称</td>
          <td width="1"></td>
          <td bgcolor="#F1F3FB" class="font13pxboldblack" colspan="5"><input type="text" style="width:150" id="q_name" />
          </td>
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
  <tr>
    <td bgcolor="#FFFFFF"  align="center" valign="middle" height="35"><input type="button" value="查询" class="btn-2word" id="selOrgBtn"
										onclick="queryStationType()">
    </td>
  </tr>
</table>
</body>
</html><SCRIPT LANGUAGE="JavaScript">
function queryStationType(){
  var code = document.all.item("q_code").value;
  var name = document.all.item("q_name").value;
  var value = code+"$"+name
  window.parent.qryObj(value);
}
function init(){
	queryStationType();
}
</SCRIPT>
