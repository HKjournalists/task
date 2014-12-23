<%@ page contentType="text/html;charset=GBK"%>
<%@ page isELIgnored="false" %>
<%@ include file="/secframe/common/common.jsp"%>
<%@ include file="/webframe/common/commonhead.jsp"%>
<%@ include file="/webframe/jspcommon/includedhead.jsp"%>
<%@ include file="/csc/common/css/aialm_style.jsp"%>

<%
	String type = request.getParameter("type");
	String objNo = request.getParameter("objNo");
	String linkNo = request.getParameter("linkNo");
	String  staffCode = g_GetUserInfo().getCode();
	long  staffId = g_GetUserInfo().getID();
%>

<html>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/csc/common/css/aialm_style_css.jsp" type="text/css">
	<head>
	<title>附件上传</title>
	</head>

	<body>
		<div id="provinceFuMangager_div" class="div_file_upload">
			<table align="center" width="100%">
				<ai:dbform formid="frmAttach" setname="com.asiainfo.csc.attach.web.SETAttach"
					initial="false" editable="false" onvalchange="">
					<ai:dbformfield fieldname="ATT_ID" formid="frmAttach" visible="false"/>
					<ai:dbformfield fieldname="ATT_NAME" formid="frmAttach" visible="false"/>
					<ai:dbformfield fieldname="SUBMITTER_TAG" formid="frmAttach" visible="false"/>
					<ai:dbformfield fieldname="ATT_PATH" formid="frmAttach" visible="false"/>
					<ai:dbformfield fieldname="ATT_TYPE" formid="frmAttach" visible="false"/>
					<ai:dbformfield fieldname="SUBMIT_LINK" formid="frmAttach" visible="false"/>						
					<tr>
						<td class="title_e" align="right" width="80">附件描述</td>
						<td class="aiEdit_4col"><ai:dbformfield fieldname="ATT_DESC" formid="frmAttach" editable="false"  height="<%=aiEditArea_high_min%>" width="<%=aiEditArea_2cwmin%>"/></td>
		    		</tr>
		    		<tr>	
						<td class="title_e" align="right" width="80" rowspan="4">附件类型</td>
					</tr>
					<tr>
						<td class="aiEdit_4col">
							<input id="attachType5" type="checkbox"/>原始需求&nbsp;&nbsp;&nbsp;&nbsp;<input id="attachType6" type="checkbox"/>其它类型
						</td>
					</tr>
					<tr>
						<td class="aiEdit_4col">
							<input id="attachType1" type="checkbox"/>详细设计&nbsp;&nbsp;&nbsp;&nbsp;<input id="attachType2" type="checkbox"/>测试报告
						</td>
					</tr>
					<tr>
						<td class="aiEdit_4col">
							<input id="attachType3" type="checkbox"/>维护手册&nbsp;&nbsp;&nbsp;&nbsp;<input id="attachType4" type="checkbox"/>用户手册
						</td>
					</tr>
				</ai:dbform>
				<tr>
                	<td class="title_e" width="80">
                	上传文件
                	</td>
  					<td class="aiEdit_4col" colspan="4">
	                    <ai:fileupload name="frmTestUpload"  fileSavePath="" showProcessBar="false"
                      		submitFuncName="doUpload"   savePathStyle="W" onFinishFuncName="doOnFinish" >
  							<input id="importFile"  name="importFile" style="width:<%=aiEditArea_2cwmin%>" type="file" />   
                    		<input type="hidden" id="frmAttach" name="frmAttach">
                    	</ai:fileupload>
              		</td>
	            </tr>
	            <tr><td width="100%" align="right" colspan="2">
	            	  <input type="submit" value="上 传" style=""/>
	            </td></tr>
			</table>
		</div>
	</body>

<script language="JavaScript">
init();
function init(){
	getFrmAttach().newRow();
	getFrmAttach().setEditSts(true);
	
	getFrmAttach().setValue("SUBMITTER_TAG", "<%=staffCode%>");
	getFrmAttach().setValue("ATT_PATH", "test/<%=staffCode%>_<%=staffId%>");
	getFrmAttach().setValue("SUBMIT_LINK", "<%=linkNo%>");
	getFrmAttach().setColEditSts("ATT_PATH",false);
	getFrmAttach().setColEditSts("SUBMIT_LINK",false);
}

function getFrmAttach(){
  	return g_FormRowSetManager.get("frmAttach");
}

function getAttachForbidType(){
	var url = "<%=request.getContextPath()%>/business/com.asiainfo.csc.attach.web.AttachAction?action=getAttachForbidType";
	var result = PostInfo(url,null);
	return result.getValueByName('attachForbidType');

}
  
//上传附件到服务器 
function doUpload(){
  
     var aFileUploadFormObj=frmTestUpload;
     var aXmlAry = new Array();
     /** 校验上传文件类型开始 */
     var file_full_name = document.getElementById("importFile").value;
     var file_type = file_full_name.substring(file_full_name.lastIndexOf(".")+1);
     if(validateFileType(file_type) != -1){
     	//aialmPrompt(file_type + "为非法文件类型！","error");
     	alert(file_type + "为非法文件类型！");
     	return;
     }
     /** 校验上传文件类型结束 */
   
     var aFormXmlParamName = "frmAttach";
     var aIsXmlForceFlag = null;
     
     getFrmAttach().setValue("ATT_TYPE",getAttachType());
     aXmlAry.push(getFrmAttach(false));
     //var attPath = getFrmAttach().getValue("ATT_PATH");
     //var attName = getFrmAttach().getValue("ATT_NAME");
     var aActionUrl="<%=request.getContextPath()%>/business/com.asiainfo.csc.attach.web.AttachAction?action=doUploadPackage&objNo=<%=objNo%>&type=" + <%=type%>;
     
     PostUploadInfo(aFileUploadFormObj,aActionUrl,aXmlAry,aFormXmlParamName,aIsXmlForceFlag);
  
}

function doUploadCover(){
	var aFileUploadFormObj=frmTestUpload;
     var aXmlAry = new Array();
     /** 校验上传文件类型开始 */
     var file_full_name = document.getElementById("importFile").value;
     var file_type = file_full_name.substring(file_full_name.lastIndexOf(".")+1);
     if(validateFileType(file_type) != -1){
     	//aialmPrompt(file_type + "为非法文件类型！","error");
     	alert(file_type + "为非法文件类型！");
     	return;
     }
     /** 校验上传文件类型结束 */
   
     var aFormXmlParamName = "frmAttach";
     var aIsXmlForceFlag = null;     
     
     getFrmAttach().setValue("ATT_TYPE", getAttachType());
     
     aXmlAry.push(getFrmAttach(false));
     
     //var attPath = getFrmAttach().getValue("ATT_PATH");
     //var attName = getFrmAttach().getValue("ATT_NAME");
     var aActionUrl="<%=request.getContextPath()%>/business/com.asiainfo.csc.attach.web.AttachAction?action=doUploadPackageCover&objNo=<%=objNo%>&type=<%=type%>&submitterTag=<%=staffCode%>";
     PostUploadInfo(aFileUploadFormObj,aActionUrl,aXmlAry,aFormXmlParamName,aIsXmlForceFlag);
}
  
//附件上传完毕后的操作
function doOnFinish(aUserDataXml){

  	var aFlag = getReturnValueByName(aUserDataXml,"IsOk");
  	var aMsg = getReturnValueByName(aUserDataXml,"MESSAGE");
  	
  	if(aFlag=="FALSE"){
  		if(aMsg=="附件上传失败！相同文件名的文件已存在，请重命名后再上传"){
	  		if(confirm('您已经上传过同名附件，是否覆盖？')){
	  			doUploadCover();
	  		} else {
	  			alert(aMsg);
	  			window.dialogArguments.refreshPackList();
	    		window.close();
	  		}
	  	} else {
	  		alert(aMsg);
		  	window.dialogArguments.refreshPackList();
		    window.close();
	  	}
  	}
 	
    if (aFlag=="TRUE"){
	  	alert(aMsg);
	  	window.dialogArguments.refreshPackList();
	    window.close();
    }
  	
  
}

function validateFileType(fileType){
	
	var forbid_type_dict = getAttachForbidType();
	return forbid_type_dict.indexOf(fileType);
}

function getAttachType(){
	var attachType="";
	if(document.getElementById("attachType1").checked == true){
     	attachType = attachType + "1";
     }else{
     	attachType = attachType + "0";
     }
     
     if(document.getElementById("attachType2").checked == true){
     	attachType = attachType + "1";
     }else{
     	attachType = attachType + "0";
     }
     
     if(document.getElementById("attachType3").checked == true){
     	attachType = attachType + "1";
     }else{
     	attachType = attachType + "0";
     }
     
     if(document.getElementById("attachType4").checked == true){
     	attachType = attachType + "1";
     }else{
     	attachType = attachType + "0";
     }
     
     if(document.getElementById("attachType5").checked == true){
     	attachType = attachType + "1";
     }else{
     	attachType = attachType + "0";
     }
     
     if(document.getElementById("attachType6").checked == true){
     	attachType = attachType + "1";
     }else{
     	attachType = attachType + "0";
     }
     return attachType;
}

</SCRIPT>

</html>