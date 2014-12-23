<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/webframe/jspcommon/includedhead.jsp"%>

<!--
/**
 * @since 2005.10
 * @author 张联华
 * @version 1.0
 * */
-->
<html>
<title>test
</title>
<head>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/FormRowSet.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/AICrmAutoForm.js"></script>
</head>
<body  onload="" >
<%
 pageContext.getRequest().setAttribute("condition","CUSTOMER_ID = :CustomerId");
 HashMap map = new HashMap();
 map.put("CustomerId","1211");
 pageContext.getRequest().setAttribute("parameters",map);
%>
  <div >
    <pagelayout:aipagelayoutform formid="testForm" initial="true"  pagelayoutcode="客户布局3_张"
      conditionname="condition"  parametersname="parameters"
      datamodel="com.ai.appframe2.udfpage.impl.TestDataModal"
      editable="true" />
  </div>
  <div align="center">
    <input type="button" onclick="query();" value="刷新">
    <input type="button" onclick="save();" value="保存">
  </div>
</body>
</html>
<script language="javascript">
function save(){
  var arowset=g_FormRowSetManager.get("testForm");
  alert(arowset.toXmlString());
}

function query(){
   var arowset= g_FormRowSetManager.get("testForm");
   arowset.refresh("customer_id=1101");
}
</script>
