<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai" %>
<%@ include file="/workflow/workflow_css.jsp"%>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/PopMenu_v2.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/jsv2/Globe_v2.jsp" type="text/javascript"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/jsv2/AppFrameCss.jsp" type="text/css">
<html>
  <head>
   <script type="text/javascript">
function do_confirm(){
if(document.all.radio[0].checked){
	if(document.all.staffId.value==""){
		alert("请输入员工编号");
		return;
	}
		window.returnValue=document.all.staffId.value;
		window.close();
	}
 if(document.all.radio[1].checked){
	 if(document.all.stationId.value==""){
		 alert("请输入员工编号");
		 return;
	 }
  	window.returnValue=document.all.stationId.value;
  	window.close();
  	}
}
function do_close(){
	window.close();
}

function detect(){
if(document.all.radio[0].checked){
document.all.station.style.display="none";
document.all.staff.style.display="block";
document.all.stationId.value="";
document.all.staffId.value="";
return false;
}
if(document.all.radio[1].checked){
document.all.staff.style.display="none";
document.all.station.style.display="block";
document.all.stationId.value="";
document.all.staffId.value="";
return false;
}
return true;
}
   </script>
  </head>
  
  <body>
 
      <fieldset style="margin-top:1cm" >
    <legend align="center">选择员工编号或岗位编号</legend>
    <table align="center" border="0">
   	 <tr><INPUT type=radio name="radio"  onclick="detect()" ><td>输入员工编号</td></tr>
 	 <tr><INPUT type=radio name="radio" onclick="detect()" ><td>输入岗位编号</td></tr>
	 <tr id="staff"><td><label>员工编号</label><input type="textarea" id = "staffId"  ></td></tr>
	 <tr id="station" style="display:none"><td><label>岗位编号</label><input type="textarea" id = "stationId"  ></td></tr>
	 <tr><td><ai:button text="确定" id="confirm"   onclick="do_confirm()"/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
	 <ai:button text="关闭" id="close" onclick="do_close()"/></td></tr>
    </table>
  </fieldset>
 
  </body>
</html>
