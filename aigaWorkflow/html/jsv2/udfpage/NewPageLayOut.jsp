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
<title>新建页面布局
</title>
<head>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/UserData_v2.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/Globe_v2.jsp"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/HtmlParameter.js"></script>

</head>
<body  onload="" >

<table>
  <tr>
    <td class="FormTDName">所属业务对象：</td>
    <td class="FormTD"><label id="lblBusinessObjectName"></label></td>
  </tr>
  <tr>
    <td class="FormTDName">业务布局名称：</td>
    <td class="FormTD"><input type="text" id="txtName"></td>
  </tr>
  <tr>
    <td class="FormTDName">业务布局编码：</td>
    <td class="FormTD"><input type="text" id="txtCode"></td>
  </tr>
  <tr>
    <td ><input type="button"  value="确定" onclick="save();"/></td>
    <td ><input type="button"  value="退出" onclick="top.close();"/></td>
  </tr>
</table>

</body>
</html>
<script language="javascript">
 BUSINESS_OBJECT_NAME=gHtmlParameter.getParameter("BUSINESS_OBJECT_NAME");
 BUSINESS_OBJECT_ID=gHtmlParameter.getParameter("BUSINESS_OBJECT_ID");
 document.all.item("lblBusinessObjectName").innerText=BUSINESS_OBJECT_NAME;
 function save(){
   PAGE_LAYOUT_NAME=document.all.item("txtName").value;
   if (PAGE_LAYOUT_NAME==null||PAGE_LAYOUT_NAME==""){
     alert("请输入页面布局名称！");
     return;
   }
   PAGE_LAYOUT_CODE=document.all.item("txtCode").value;
   if (PAGE_LAYOUT_CODE==null||PAGE_LAYOUT_CODE==""){
     alert("请输入页面布局编码！");
     return;
   }
   if (BUSINESS_OBJECT_ID&&BUSINESS_OBJECT_ID!=-1){
   	var parameter="&BUSINESS_OBJECT_ID="+BUSINESS_OBJECT_ID;
	parameter+="&PAGE_LAYOUT_NAME="+PAGE_LAYOUT_NAME;
        parameter+="&PAGE_LAYOUT_CODE="+PAGE_LAYOUT_CODE;
	var r=PostInfo('/business/com.ai.appframe2.udfpage.action.UserDefinePageAction?action=NewPageLayout'+parameter,"");
        if (r!=null){
          var LayoutId=r.getValueByName("PAGE_LAYOUT_ID");
          if (LayoutId=="-1"){
            alert(r.getValueByName("MSG"));
            return;
          }
          top.returnValue=LayoutId;

        }

   	top.close();
   }else{
     alert("请选择业务对象！");
   }
 }


</script>
