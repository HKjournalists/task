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
	<title>�����ϴ�</title>
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
						<td class="title_e" align="right" width="80">��������</td>
						<td class="aiEdit_4col"><ai:dbformfield fieldname="ATT_DESC" formid="frmAttach" editable="false"  height="<%=aiEditArea_high_min%>" width="<%=aiEditArea_2cwmin%>"/></td>
		    		</tr>
		    		<tr>	
						<td class="title_e" align="right" width="80" rowspan="4">��������</td>
					</tr>
					<tr>
						<td class="aiEdit_4col">
							<input id="attachType5" type="checkbox"/>ԭʼ����&nbsp;&nbsp;&nbsp;&nbsp;<input id="attachType6" type="checkbox"/>��������
						</td>
					</tr>
					<tr>
						<td class="aiEdit_4col">
							<input id="attachType1" type="checkbox"/>��ϸ���&nbsp;&nbsp;&nbsp;&nbsp;<input id="attachType2" type="checkbox"/>���Ա���
						</td>
					</tr>
					<tr>
						<td class="aiEdit_4col">
							<input id="attachType3" type="checkbox"/>ά���ֲ�&nbsp;&nbsp;&nbsp;&nbsp;<input id="attachType4" type="checkbox"/>�û��ֲ�
						</td>
					</tr>
				</ai:dbform>
				<tr>
                	<td class="title_e" width="80">
                	�ϴ��ļ�
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
	            	  <input type="submit" value="�� ��" style=""/>
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
  
//�ϴ������������� 
function doUpload(){
  
     var aFileUploadFormObj=frmTestUpload;
     var aXmlAry = new Array();
     /** У���ϴ��ļ����Ϳ�ʼ */
     var file_full_name = document.getElementById("importFile").value;
     var file_type = file_full_name.substring(file_full_name.lastIndexOf(".")+1);
     if(validateFileType(file_type) != -1){
     	//aialmPrompt(file_type + "Ϊ�Ƿ��ļ����ͣ�","error");
     	alert(file_type + "Ϊ�Ƿ��ļ����ͣ�");
     	return;
     }
     /** У���ϴ��ļ����ͽ��� */
   
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
     /** У���ϴ��ļ����Ϳ�ʼ */
     var file_full_name = document.getElementById("importFile").value;
     var file_type = file_full_name.substring(file_full_name.lastIndexOf(".")+1);
     if(validateFileType(file_type) != -1){
     	//aialmPrompt(file_type + "Ϊ�Ƿ��ļ����ͣ�","error");
     	alert(file_type + "Ϊ�Ƿ��ļ����ͣ�");
     	return;
     }
     /** У���ϴ��ļ����ͽ��� */
   
     var aFormXmlParamName = "frmAttach";
     var aIsXmlForceFlag = null;     
     
     getFrmAttach().setValue("ATT_TYPE", getAttachType());
     
     aXmlAry.push(getFrmAttach(false));
     
     //var attPath = getFrmAttach().getValue("ATT_PATH");
     //var attName = getFrmAttach().getValue("ATT_NAME");
     var aActionUrl="<%=request.getContextPath()%>/business/com.asiainfo.csc.attach.web.AttachAction?action=doUploadPackageCover&objNo=<%=objNo%>&type=<%=type%>&submitterTag=<%=staffCode%>";
     PostUploadInfo(aFileUploadFormObj,aActionUrl,aXmlAry,aFormXmlParamName,aIsXmlForceFlag);
}
  
//�����ϴ���Ϻ�Ĳ���
function doOnFinish(aUserDataXml){

  	var aFlag = getReturnValueByName(aUserDataXml,"IsOk");
  	var aMsg = getReturnValueByName(aUserDataXml,"MESSAGE");
  	
  	if(aFlag=="FALSE"){
  		if(aMsg=="�����ϴ�ʧ�ܣ���ͬ�ļ������ļ��Ѵ��ڣ��������������ϴ�"){
	  		if(confirm('���Ѿ��ϴ���ͬ���������Ƿ񸲸ǣ�')){
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