<%@ page contentType="text/html; charset=GBK"%>
<%
//request.setAttribute("userInfo", g_GetUserInfo());

String orgName = request.getSession().getAttribute("orgNameStr").toString();

%>
<html>
	<head>
		<script src="<%=request.getContextPath()%>/jsv2/PopMenu_v2.js"></script>
		<script>
			var attPackId="";
			var objNo="";
			var objType="";
			var linkNo="";
			var fileName="";
			var filePath="";
			var model = new AIPopMenuModel();
			model.addPopMenuItem("btnDownload","下载",null,'downloadAttach');
			var popMenu = new AIPopMenu(model);
			document.onclick = function(){popMenu.hidePopMenu();}
			document.oncontextmenu = function (){return false;}
			
			function downloadAttach(){
				window.open("<%=request.getContextPath()%>/business/com.asiainfo.csc.attach.web.AttachAction?action=doDownload&attName=" + fileName + "&attPath=" + filePath);
			}
			
			function showBtnMenu(_attPackId,_submitterTag,_fileName,_filePath){
				popMenu.setItemHideById("btnDownload",false);
				popMenu.showPopMenu();
				attPackId=_attPackId;
				fileName=_fileName;
				filePath=_filePath;
			}
			
			function getDocumentListDisplay(_objNo,_type,_linkno){
				objNo=_objNo;
				objType=_type;
				linkNo=_linkno;
				$('#attachList2').html("");
				var url = "<%=request.getContextPath()%>/business/com.asiainfo.csc.attach.web.AttachAction?action=getAttachList&objNo="	+ objNo + "&type=" + objType;
					var rtn = PostInfo(url, null);
					if (rtn.getValueByName('html') == "") {
						document.getElementById("pucker2").style.display = "none";
						document.getElementById("attachList2").style.display = "none";
					} else {
						document.getElementById("pucker2").style.display = "block";
						document.getElementById("attachList2").style.display = "block";
						$('#attachList2').html(rtn.getValueByName('html'));
					}
				}
	</script>
	</head>
	<body>
		<div id="pucker2" >
			<table id="pucker_head2" width="100%">
				<tr>
					<td class="title_e">附件信息：</td>
					<td id="attachList2"></td>
				</tr>
			</table>
		</div>
	</body>

</html>