<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai" %>
<script language="javascript" src="<%=request.getContextPath()%>/jsv2/Globe_v2.jsp" type="text/javascript"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/jsv2/AppFrameCss.jsp" type="text/css">
<%@ include file="/workflow/workflow_css.jsp"%>
<html>
<head>
  <title>���ô�����Ա��Ϣ</title>
</head>
<body>
<div align="center"><br>
<fieldset style="width:90%;text-align:center;font-size:12">
<table align="center">
  <tr>
    <td style="font-size:9pt;" colspan="2">
      <input type="radio" name="radioType" checked="checked">Ա��
      <input type="radio" name="radioType">��λ
    </td>
  </tr>
  <tr>
    <td class="FormTDName">ID:</td>
    <td class="FormTD"><input type="text" name="txtId"/></td>
  </tr>
  <tr>
    <td colspan="2"><ai:button text="ȷ  ��" id="btnOk" onclick="saveFunc()"/>&nbsp;&nbsp;&nbsp;&nbsp;
      <ai:button text="ȡ  ��" id="btnQuit" onclick="cancelFunc()"/>
    </td>
  </tr>
</table>     
</fieldset>
</div>
</body>
</html>

<script type="text/javascript">
function saveFunc(){
  var id = document.all.txtId.value;
  if(id == ""){
    alert("������IDֵ!");
    return;
  }
  var param = new Array(2);
  if(radioType[0].checked){
    param[0] = id;
    param[1] = "-1";
  }
  else{
    param[0] = "-1";
    param[1] = id;
  }
  window.returnValue = param;
  window.close();  
}

function cancelFunc(){
  window.close();
}
</script>