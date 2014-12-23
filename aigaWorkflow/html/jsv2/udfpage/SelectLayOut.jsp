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
<title>选择页面布局
</title>
<head>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/DBListBox.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/UserData_v2.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/Globe_v2.jsp"></script>

</head>
<body  onload="" >

<table align="center">
  <tr align="center">
    <td class="FormTDName">选择业务对象：</td>
    <td class="FormTD"><ai:listbox ds="com.ai.appframe2.udfpage.DSBusinessObject" id="lblBusinessObject" width="200"  onchange="refreshPageLayout();"
      nullid="-1" nulltext="请选择业务对象" /></td>
  </tr>
  <tr align="center">
    <td class="FormTDName">选择业务布局：</td>
    <td class="FormTD"><ai:listbox ds="com.ai.appframe2.udfpage.DSPageLayout" id="lblPageLayout" width="200"
      nullid="-1"  nulltext="请选择页面布局"/></td>
  </tr>
  <tr align="center">
    <td  colspan="2">
      <input type="button"  value="新建页面布局" onclick="newLayout();" class="B" style="width:100"/>
      <input type="button"  value="编辑自定义字段" onclick="udfField();" class="B" style="width:100"/>
    </td>
 </tr>
 <tr align="center">
   <td   colspan="2">
      <input type="button"  value="编辑页面布局" onclick="nextPage();" class="B" style="width:100"/>
      <input type="button"  value="删除页面布局" onclick="deletePage();" class="B" style="width:100"/>
    </td>
  </tr>
</table>

</body>
</html>
<script language="javascript">
 refreshPageLayout();
 function newLayout(){
   aBusinessObjectId=g_getListBox("lblBusinessObject").getID();
   if (aBusinessObjectId&&aBusinessObjectId!=-1){
     BUSINESS_OBJECT_NAME=g_getListBox("lblBusinessObject").getValue();
     var param="?BUSINESS_OBJECT_ID="+aBusinessObjectId+"&BUSINESS_OBJECT_NAME="+BUSINESS_OBJECT_NAME;
     var r=window.showModalDialog("NewPageLayOut.jsp"+param,window,"scroll:no;resizable:no;status:no;dialogHeight:300px;dialogWidth:300px");
     if (r!=null&&r!=-1){
       alert("新增业务布局成功！");
       refreshPageLayout();
     }
   } else{
     alert("请选择业务对象！");
   }
 }

 function refreshPageLayout(){
   aBusinessObjectId=g_getListBox("lblBusinessObject").getID();
   if (aBusinessObjectId&&aBusinessObjectId!=-1){
     BUSINESS_OBJECT_NAME=g_getListBox("lblBusinessObject").getValue();
     refreshListBox("lblPageLayout","pBusinessObjectId="+aBusinessObjectId);
     g_getListBox("lblPageLayout").addItem("-1","请选择页面布局");
   }else{
     g_getListBox("lblPageLayout").setValue("-1");
   }
 }

 function nextPage(){
   PAGE_LAYOUT_ID=g_getListBox("lblPageLayout").getID();
   if (PAGE_LAYOUT_ID&&PAGE_LAYOUT_ID>0){
     PAGE_LAYOUT_NAME=g_getListBox("lblPageLayout").getValue();
     window.location="PageDesign.jsp?PAGE_LAYOUT_ID="+PAGE_LAYOUT_ID
     +"&PAGE_LAYOUT_NAME="+PAGE_LAYOUT_NAME
     +"&BUSINESS_OBJECT_NAME="+BUSINESS_OBJECT_NAME;
   }else{
     alert("请选择一个页面布局！");
     return;
   }
 }

function deletePage(){
   PAGE_LAYOUT_ID=g_getListBox("lblPageLayout").getID();
   PAGE_LAYOUT_NAME=g_getListBox("lblPageLayout").getValue();
   if (PAGE_LAYOUT_ID&&PAGE_LAYOUT_ID>0){
     if (confirm("您确认删除页面布局"+PAGE_LAYOUT_NAME+"吗？")){
       var param="&PAGE_LAYOUT_ID="+PAGE_LAYOUT_ID;
     	var resu=PostInfo("/business/com.ai.appframe2.udfpage.action.UserDefinePageAction?action=deletePageLayout"+param,"").getValueByName("RESU");
        if (resu!="Y"){
          alert(resu);
        }else{
          //刷新列表
          alert("页面布局"+PAGE_LAYOUT_NAME+"删除成功！");
          refreshPageLayout();
        }
     }
   }else{
     alert("请选择一个页面布局！");
     return;
   }
 }

 function udfField(){
   PAGE_LAYOUT_ID=g_getListBox("lblPageLayout").getID();
   aBusinessObjectId=g_getListBox("lblBusinessObject").getID();
   if (PAGE_LAYOUT_ID&&PAGE_LAYOUT_ID>0){
     PAGE_LAYOUT_NAME=g_getListBox("lblPageLayout").getValue();
     window.location="UserDefineFieldQuery.jsp?PAGE_LAYOUT_ID="+PAGE_LAYOUT_ID
     +"&PAGE_LAYOUT_NAME="+PAGE_LAYOUT_NAME
     +"&BUSINESS_OBJECT_ID="+aBusinessObjectId
     +"&BUSINESS_OBJECT_NAME="+BUSINESS_OBJECT_NAME;
   }else{
     alert("请选择一个页面布局！");
     return;
   }
 }
 PAGE_LAYOUT_ID=null;
 PAGE_LAYOUT_NAME=null;
 BUSINESS_OBJECT_NAME=null;
</script>
