<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.ai.appframe2.web.HttpUtil"%>
<%@ include file="/webframe/common/commonhead.jsp"%>
<HTML>
<HEAD>
<TITLE>

</TITLE>
</HEAD>
<BODY >
<%
 String ObjectItemId=HttpUtil.getParameter(request,"OBJECT_ITEM_ID");
 pageContext.getRequest().setAttribute("OBJECT_ITEM_ID",ObjectItemId);
%>
<ai:table setname="com.ai.comframe.autoform.web.SETQBOObjectItemRelated" tableid="relatTable" 
  implservice_name="com.ai.comframe.autoform.service.AutoFormSV" 
  implservice_querymethod="getObjectItemRelated(String aRelatRelatId,int $STARTROWINDEX,int $ENDROWINDEX)"
  implservice_countmethod=""
  tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService" height="200" width="700" onrowchange=""
  onvalchange="" multiselect="false" editable="false" footdisplay="none" needrefresh="true"
  initial="false">
     <ai:col fieldname="OBJECT_ITEM_ID" visible="true" width="150"></ai:col>
     <ai:col fieldname="NAME" visible="true" editable="" width="250"></ai:col>
     <ai:col fieldname="RELAT_TYPE" visible="true" width="250"></ai:col>
</ai:table>

</BODY>
<script>
function init(){
	var condition = "aRelatRelatId=<%=ObjectItemId%>";
	g_TableRowSetManager.get("relatTable").refresh(condition);
}
init();
</script>
</HTML>
