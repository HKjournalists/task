<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/workflow/workflow_css.jsp"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai" %>
<%@ include file="/webframe/common/commonhead.jsp"%>
<%@ include file="/webframe/jspcommon/includedhead.jsp"%>
<%@ include file="/csc/common/css/aialm_style.jsp"%>
<%
	String  staffName = g_GetUserInfo().getName();
	String  staffCode = g_GetUserInfo().getCode();
	java.sql.Timestamp  currentTime =  com.ai.appframe2.common.ServiceManager.getOpDateTime();
%>
<html>
<head>
  <title></title>
  <SCRIPT LANGUAGE="Javascript" SRC="<%=request.getContextPath()%>/aialm/common/JSClass/FusionCharts.js"></SCRIPT>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/aialm/common/css/aialm_style_css.jsp" type="text/css">
</head>
<body>
	<br>
	<div id="aialmHelp_div"  style="height:95%;width:98%">
		<table width="100%" border="0" >
			<tr>
				<td id="tab1" style="background: #f2f6fb;text-align: center;">
					<a id="a_tab1" href='#' title ="需求管控操作手册" onclick="showtab(1)" ><b class="size:18px"> 操作手册 </b></a>
				</td>
				
		</table>
		<div id="div1" style="display:block;background: #f2f6fb; height:95%;">
			<ul>
		　　　　<li><a href="<%=request.getContextPath()%>/csc/common/helpfile/help.rar">操作手册（请单击鼠标右键另存为help.rar）</a></li>

		　　　</ul>
		</div>
		
	</div>
</body>
<script language="javascript">
	var sysPath = "<%=request.getContextPath()%>/aialm/images/helpPic/";
	var imgInfo = document.getElementById("imgInfo");
	function chgPic(){
		var picName = arguments[0];
		imgInfo.src = sysPath + picName + ".JPG";
		document.getElementById("workflowpic").style.display="block";
	}
	function showtab(num){
		for (var i=1; i<=1;i++){
			if(i == num ){
				document.getElementById('div'+i).style.display ='block';
				document.getElementById('tab'+i).style.background='#f2f6fb';
			}else{
				document.getElementById('div'+i).style.display='none';
				document.getElementById('tab'+i).style.background='#ffffff';
			}
		}					
	}	
</script>
</html>