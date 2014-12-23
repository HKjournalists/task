<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/webframe/jspcommon/includedhead.jsp"%>
<!--
/**
 * @since 2005.10
 * @author 李新波
 * @version 1.0
 * */
-->
<html>
<head>
<title>
属性值输入窗口
</title>
</head>
<body bgcolor="#ffffff">
<table>
  <tr>
    <br/>
    <td colspan="2" class="FormTD">属性值:<br/>
    <input type="text" name="PropText" style="width:280px"/>
    </td>
  </tr>
  <tr/>
  <tr/>
  <tr/>
  <tr/>
  <tr align="center">
      <td valign="baseline" width="100" align="center">
      <img src=<%=request.getContextPath() + "/image/button/sure.gif"%> style="cursor:hand;" align="absmiddle"  value="" name="btn_Sure" onclick="sure();">
      <td valign="baseline" width="100" align="center">
      <img src=<%=request.getContextPath() + "/image/button/cancel.gif"%> style="cursor:hand;" align="absmiddle"  value="" name="btn_Cancel" onclick="cancel();">
  </tr>
</table>
</body>
</html>
<script language="javascript">

  function sure(){
    var strPropValue = document.all("PropText").value;
    top.returnValue = strPropValue;
    top.close();
  }

  function cancel()
  {
    top.close();
  }
</script>

