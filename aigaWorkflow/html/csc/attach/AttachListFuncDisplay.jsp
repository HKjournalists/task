<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai" %>
<%@include file="/csc/common/taglib.jsp"%>
<%
//request.setAttribute("userInfo", g_GetUserInfo());

String  staffCode = g_GetUserInfo().getCode();
String orgName = request.getSession().getAttribute("orgNameStr").toString();

%>
<html>
	<head>
		<script src="<%=request.getContextPath()%>/jsv2/PopMenu_v2.js"></script>
		<script>
			var attPackId1="";
			var objNo1="";
			var objType1="";
			var linkNo1="";
			var fileName1="";
			var filePath1="";
			var model = new AIPopMenuModel();
			model.addPopMenuItem("btnDownload","下载",null,'downloadAttach');
			var popMenu = new AIPopMenu(model);
			document.onclick = function(){popMenu.hidePopMenu();}
			//document.oncontextmenu = function (){return false;}
			
			function downloadAttach(){
				window.open("<%=request.getContextPath()%>/business/com.asiainfo.csc.attach.web.AttachAction?action=doDownload&attName=" + fileName + "&attPath=" + filePath);
			}
			
			function showBtnMenu(_attPackId,_submitterTag,_fileName,_filePath){
				popMenu.setItemHideById("btnDownload",false);
				popMenu.showPopMenu();
				attPackId1=_attPackId;
				fileName1=_fileName;
				filePath1=_filePath;
			}
			
			function getDocumentListFuncDisplay(_objNo,_type,_linkno){
				objNo1=_objNo;
				objType1=_type;
				linkNo1=_linkno;
				$('#attachList3').html("");
				var url = "<%=request.getContextPath()%>/business/com.asiainfo.csc.attach.web.AttachAction?action=getAttachList&objNo="	+ objNo1 + "&type=" + objType1;
					var rtn = PostInfo(url, null);
					if (rtn.getValueByName('html') == "") {
						document.getElementById("pucker3").style.display = "none";
						document.getElementById("attachList3").style.display = "none";
					} else {
						document.getElementById("pucker3").style.display = "block";
						document.getElementById("attachList3").style.display = "block";
						$('#attachList3').html(rtn.getValueByName('html'));
					}
				}
	</script>
	</head>
	<body>
		<div id="pucker3" >
			<table id="pucker_head3" width="100%" height="10" style="padding: 0 0 0 0;margin: 0 0 0 0 ;">
				<!--  <tr style="cursor:hand;">-->
				<tr>
					<td class="title_e">附件信息</td>
					<td id="attachList3"></td>
				</tr>
			</table>
		</div>
	</body>

</html>