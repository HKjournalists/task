<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.ai.appframe2.web.HttpUtil"%>
<%@ include file="/webframe/common/commonhead.jsp"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai"%>
<HTML>
	<HEAD>
		<TITLE>对象分类</TITLE>
	</HEAD>
	<%
		 /**
		 * 传入参数：
		 * 1、ITEM_KIND_ID,分类编号：-1为新增，其余为显示
		 * 2、ITEM_TYPE,所属对象类型 用于新增
		 * 3、PARENT_KIND_ID,上级分类编号 用于新增
		 *
		 **/
		String aItemKindId = HttpUtil.getParameter(request, "ITEM_KIND_ID");
		String aItemTypeEditable = "true";
		if (aItemKindId.equals("-1")) {
			aItemTypeEditable = "false";
		}
		String aItemType = HttpUtil.getParameter(request, "ITEM_TYPE");
		String aParentKindId = HttpUtil.getParameter(request, "PARENT_ITEM_KIND_ID");
	%>
	<BODY bgcolor="#ffffff" onload="refreshObjectItemKind();">
		<ai:dbform formid="objectItemKind"
			setname="com.ai.comframe.autoform.web.SETObjectItemKind"
			implservice_name="com.ai.comframe.autoform.service.AutoFormSV"
			implservice_querymethod="getObjectItemKindDetail(String aObjectItemKindId)"
			initial="false"
			datamodel="com.ai.appframe2.web.datamodel.MethodModelForService">
			<table>
				<tr>
					<td width="100" class="FormTDName">
						对象分类编号：
					</td>
					<td width="140" class="FormTD">
						<ai:dbformfield fieldname="KIND_ID" formid="objectItemKind"
							editable="false"></ai:dbformfield>
					</td>
				<tr>
				<tr>
					<td width="100" class="FormTDName">
						对象分类名称：
					</td>
					<td width="140" class="FormTD">
						<ai:dbformfield fieldname="ITEM_KIND_NAME" formid="objectItemKind"></ai:dbformfield>
					</td>
				<tr>
				<tr>
					<td width="100" class="FormTDName">
						对象分类编码：
					</td>
					<td width="140" class="FormTD">
						<ai:dbformfield fieldname="ITEM_KIND_CODE" formid="objectItemKind"></ai:dbformfield>
					</td>
				<tr>
				<tr>
					<td width="100" class="FormTDName">
						所属对象类型：
					</td>
					<td width="140" class="FormTD">
						<ai:dbformfield fieldname="OBJECT_ITEM_TYPE"
							formid="objectItemKind" editable="<%=aItemTypeEditable%>"
							visible=""></ai:dbformfield>
					</td>
				<tr>
				<tr>
					<td width="100" class="FormTDName">
						上级分类编号：
					</td>
					<td width="140" class="FormTD">
						<ai:dbformfield fieldname="PARENT_KIND_ID" formid="objectItemKind"
							editable="false"></ai:dbformfield>
					</td>
				<tr>
				<tr>
					<td width="100" class="FormTDName">
						顺序号：
					</td>
					<td width="140" class="FormTD">
						<ai:dbformfield fieldname="SORTBY" formid="objectItemKind"></ai:dbformfield>
					</td>
				<tr>
				<tr align="center">
					<td colspan="2">
						<input type="button" value="保存" onclick="saveObjectItemKind();">
					</td>
				</tr>
			</table>
		</ai:dbform>
	</BODY>

	<script>
function gObjectItemKindRowSet(){
  return g_FormRowSetManager.get("objectItemKind");
}

function refreshObjectItemKind(){
  if ("<%=aItemKindId%>"=="-1"){
    gObjectItemKindRowSet().newRow();
    gObjectItemKindRowSet().setValue("OBJECT_ITEM_TYPE","<%=aItemType%>");
    gObjectItemKindRowSet().setValue("PARENT_KIND_ID","<%=aParentKindId%>");
  }
  else{
    var cond = "aObjectItemKindId=<%=aItemKindId%>";
    gObjectItemKindRowSet().refresh(cond);
  }
}
function saveObjectItemKind(){
  var sform = g_FormRowSetManager.get("objectItemKind");
  if (sform.toXmlString()==""){
    alert("您没有修改任何数据！");
    return;
  }
  var aKindName=sform.getValue("ITEM_KIND_NAME");
  if (aKindName==null||aKindName==""){
    alert("请输入分类名称！");
    return;
  }
  var aKindCode=sform.getValue("ITEM_KIND_CODE");
  if (aKindCode==null||aKindCode==""){
    alert("请输入分类编码！");
    return;
  }
  
  var strUrl = "<%=request.getContextPath()%>/business/com.ai.comframe.autoform.web.AutoFormAction?action=saveObjectItemKind";
  var list = new Array();
  list.push(sform);
  var msg = saveRowSet(strUrl, list, false, true);
  //var list = new Array();
  //list[0]=gObjectItemKindRowSet();
  //var msg = saveRowSet(_gModuleName+"/business/com.ai.comframe.autoform.web.AutoFormAction?action=saveObjectItemKind",list,false);
  var ret = msg.getValueByName("retVal");
  if ("<%=aItemKindId%>"=="-1"){
  	window.returnValue = "true";
    top.close();
  }
}
</script>
</HTML>
