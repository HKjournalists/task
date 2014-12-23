<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/secframe/common/common.jsp"%>
<!--
页面名称：propertiesType
页面功能：属性类型选择
作者：马进
创建日期：2006-5-8
-->
<html>
<head>
<title>
属性类型选择　
</title>
</head>

<body>
<tr>
	<td>
		<fieldset>
  		<LEGEND  class="FormZName">属性类型</LEGEND>
			<table width=98% border="0" cellspacing="0" cellpadding="0" height="30" align="center">
 				<tr align=center>
 					<td class="FormTD">
 						<input type="checkbox" id="chxView"  checked >可查看<br>
 					</td> 		
 				</tr> 			
 				<tr align=center>
 					<td class="FormTD">
 						<input type="checkbox" id="chxModify" checked >可修改
 					</td>
 				</tr> 				
			</table>
		</fieldset>
	</td>
</tr>
<tr>
	<td>	
		<table cellSpacing=0 cellPadding=0 width="100%">
		  <tr>
		    <td align="center" class="FormTD">
		    	<ai:button text=" 确认 " style="cursor:hand;" id="ok" onclick="okFunc()"/>
			  	<ai:button text=" 取消 " style="cursor:hand;"  id="cancel" onclick="cancelFunc()"/>
		    </td>
		  </tr>
		</table>
	</td>
</tr>
<ai:loginuser/>

</body>
</html>

<SCRIPT LANGUAGE="JavaScript">
function okFunc()
{
	var propertyType = "all";
	if(chxView.checked&&chxModify.checked) propertyType = "all";
	else{
		if(chxView.checked)propertyType = "view";
		else
			if(chxModify.checked)propertyType = "modify";
		else
			propertyType = "none";
	}

	closeWin(propertyType);
}
function cancelFunc()
{
	closeWin("-1");
}
function closeWin(retValue)
{
  window.returnValue = retValue;
  top.close();
}

</script>
