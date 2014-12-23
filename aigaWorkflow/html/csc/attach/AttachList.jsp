<%@ page contentType="text/html; charset=GBK" import="com.ai.appframe2.common.SessionManager"%>
<%
	request.setAttribute("userInfo", SessionManager.getUser());
	String  staffCode = SessionManager.getUser().getCode();
	String orgName = request.getSession().getAttribute("orgNameStr").toString();

%>
<html>
	<head>
		<style type="text/css">
			html,body { margin:0; padding:0;}
		</style>
		<script type="text/javascript" src="<%=request.getContextPath()%>/csc/attach/js/swfupload/swfupload.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/csc/attach/js/swfupload/swfupload.queue.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/csc/attach/js/swfupload/fileprogress.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/csc/attach/js/swfupload/handlers.js"></script>
		
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
			model.addPopMenuItem("btnDelete","删除",null,'deleteAttach');
			var popMenu = new AIPopMenu(model);
			document.onclick = function(){popMenu.hidePopMenu();}
			document.oncontextmenu = function (){return false;}
			
			function deleteAttach(){
				if(!confirm('确认要删除选择的附件吗？')){
					return;
				}
				var url = "<%=request.getContextPath()%>/business/com.asiainfo.csc.attach.web.AttachAction?action=delPackage&attPackId="+attPackId;
				var rtn = PostInfo(url,null);
				u_message(rtn.getValueByName("msg"));
				getDocumentList(objNo,objType);
			}
			
			function downloadAttach(){
				window.open("<%=request.getContextPath()%>/business/com.asiainfo.csc.attach.web.AttachAction?action=doDownload&attName=" + fileName + "&attPath=" + filePath);
			}
			
			function showBtnMenu(_attPackId,_submitterTag,_fileName,_filePath){
				popMenu.setItemHideById("btnDownload",false);
				if("${userInfo.code}"==_submitterTag){
					popMenu.setItemHideById("btnDelete",false);
				}else{
					popMenu.setItemHideById("btnDelete",true);
				}
				popMenu.showPopMenu();
				attPackId=_attPackId;
				fileName=_fileName;
				filePath=_filePath;
			}
			
			function getDocumentList(_objNo,_type,_linkno){
				objNo=_objNo;
				objType=_type;
				linkNo=_linkno;
				$('#attachList').html("");
				var url = "<%=request.getContextPath()%>/business/com.asiainfo.csc.attach.web.AttachAction?action=getAttachList&objNo="	+ objNo + "&type=" + objType;
					var rtn = PostInfo(url, null);
					if (rtn.getValueByName('html') == "") {
						document.getElementById("attachList").style.display = "none";
					} else {
						document.getElementById("attachList").style.display = "block";
						$('#attachList').html(rtn.getValueByName('html'));
					}
				}
			
			//用于测试数据，测试时使用
			//objType="9";
			//objNo="PROBLEM20130128112601";
			//linkNo="b";
			
			//================================upload function=======================================================
			var swfu;
	
			function queueComplete_func(){
				getDocumentList(objNo, objType, linkNo);
			}
			window.onload = function() {
				var settings = {
					flash_url : "<%=request.getContextPath()%>/csc/attach/swfupload/swfupload.swf",
					upload_url: "<%=request.getContextPath()%>/business/com.asiainfo.csc.attach.web.FileUploadAction?action=fileUpload",
					post_params: {"uploadTimer" : new Date(), 
						"SUBMITTER_TAG": "<%=staffCode%>",
						"ATT_PATH": "<%=orgName%>",
						"SUBMIT_LINK" : linkNo,
						"OBJ_NO" : objNo,
						"OBJ_TYPE" : objType
						
						},
					file_size_limit : "100 MB",
					file_types : "*.*",
					file_types_description : "All Files",
					file_upload_limit : 100,
					file_queue_limit : 0,
					custom_settings : {
						progressTarget : "fsUploadProgress",
						cancelButtonId : "btnCancel",
						upload_successful : false
					},
					debug: false,
	
					// Button settings
					button_image_url : "<%=request.getContextPath()%>/csc/attach/images/fla_btn03.png",
					button_placeholder_id : "spanButtonPlaceholder",
					button_width: 90,
					button_height: 22,
					
					// The event handler functions are defined in handlers.js
					file_queued_handler : fileQueued,
					file_queue_error_handler : fileQueueError,
					file_dialog_complete_handler : fileDialogComplete,
					upload_start_handler : uploadStart,
					upload_progress_handler : uploadProgress,
					upload_error_handler : uploadError,
					upload_success_handler : uploadSuccess,
					upload_complete_handler : uploadComplete,
					queue_complete_handler : queueComplete_func	// Queue plugin event
				};
	
				swfu = new SWFUpload(settings);
		     };
	</script>
	</head>
	<body>
		<div id="pucker1" style="margin: 0px;padding: 0px;">
			<table id="pucker_head1" width="100%" cellspacing="0" cellpadding="0" style="margin-top: 6px;">
				<tr>
					<td class="title_e" valign="top" style="line-height:28px;" >需求附件：</td>
					<td id="attachList"></td>
					<td style="">
						<div id="content">
							<form id="form1" action="index.jsp" method="post" enctype="multipart/form-data">
									<div>
										<span id="spanButtonPlaceholder"></span>
										<input id="btnCancel" type="button" value="Cancel All Uploads" onclick="swfu.cancelQueue();" disabled="disabled" style="visibility:hidden; margin-left: 2px; font-size: 8pt; height: 22px;" />
									</div>
									<input id="test" name="test" type="hidden" value="100" />
									<div id="fsUploadProgress">
									</div>
							</form>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</body>

</html>