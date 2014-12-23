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
<title>设置Section的性质
</title>
<head>

</head>
<body  onload="" >

<table>
  <tr>
    <td>标题：</td>
    <td><input type="text" name="secTitle" size="10"></td>
  </tr>
  <tr>
    <td>每行列数：</td>
    <td><input type="text" name="secCols" size="10" value="2"></td>
  </tr>
  <tr>
    <td>宽度：</td>
    <td><input type="text" name="secWidth" size="10" value="700"></td>
  </tr>
  <tr>
    <td>是否恢复标题：</td>
    <td>
      <select id="secIsDisp">
        <option selected>是</option>
        <option>否</option>
      </select>
    </td>
  </tr>
  <tr align="center">
    <td colspan="2"><input type="button"  class="B" value=" 确 定 " onclick="ok();"/></td>
  </tr>
</table>

</body>
</html>
<script language="javascript">
 var gParamObject = dialogArguments;
 if (gParamObject){
   if (gParamObject.isEdit==true){
     var aTitle=gParamObject.title;
     var aCol=gParamObject.cols;
     var aIsDisp=gParamObject.isDisp;
     var aSecWidth=gParamObject.secWidth;
     document.all.item("secTitle").value=aTitle;
     document.all.item("secCols").value=aCol;
     document.all.item("secWidth").value=aSecWidth;
     document.all.item("secCols").disabled=true;
     if (aIsDisp=="Y"){
       document.all.item("secIsDisp")[0].selected=true;
     }else{
       document.all.item("secIsDisp")[1].selected=true;
     }
   }
 }
 function ok(){
   var aTitle=document.all.item("secTitle").value;
   var aCol=document.all.item("secCols").value;
   var aSecWidth=document.all.item("secWidth").value;
   if (aTitle==null||aTitle==""){
     alert("请输入组成部分标题！");
     return;
   }
  if (aCol==null||aCol==""){
     alert("请输入组成部分每行的列数！");
     return;
   }
  if (aSecWidth==null||aSecWidth==""){
	aSecWidth=0;
   }
   var aIsDisp="N";
   if (document.all.item("secIsDisp")[0].selected==true){
     aIsDisp="Y";
   }
   var retValue=new Object();
   retValue.title=aTitle;
   retValue.cols=aCol;
   retValue.secWidth=aSecWidth;
   retValue.isDisp=aIsDisp;
   top.returnValue=retValue;
   top.close();
 }
</script>
