<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai" %>
<%@include file="/csc/common/taglib.jsp"%>
<html>
	<body>
		<div id="attach_pucker" ><!-- class="popdownMain1" -->
			<div id="pucker" >
				<table id="pucker_head" width="100%" height="10" style="padding: 0 0 0 0;margin: 0 0 0 0 ;">
					<tr onclick="onAttach_HideShow()"  style="cursor:hand;"  >
			 			<td class="title_e">附件信息：</td>
						<td align="center" width="20" >
							<a style="align: center;" href="###"> <img id="show_hide_ico_attach" src="<%=request.getContextPath()%>/csc/images/pucker/show.png" name="show_hide_ico" border="0" alt="提示：展开/隐藏"></a>
						</td>
						<td align="left" class="EXT_line_bottom" >&nbsp;</td>
						<td align="right" id="btn_attRead"   class="EXT_line_bottom" style="display:none"  height="20" width="20"> 
							<a style="align: right;" href="###" onClick="readAttach() "><img id="" src="<%=request.getContextPath()%>/csc/images/pucker/down.gif" name="btn_attRead"  border="0" alt="提示：下载附件"></a> 
						</td>
						<td align="right" id="btn_attUpload" class="EXT_line_bottom" style="display:none"  height="20" width="20"> 
							<a style="align: right;" href="###" onClick="openUploadDialog('csc/common/includes/attach/DoUpload.jsp')"><img id="" src="<%=request.getContextPath()%>/csc/images/pucker/up.gif"  name="btn_attUpload" border="0" alt="提示：上传附件"></a> 
						</td>
						<td align="right" id="btn_attSelect" class="EXT_line_bottom" style="display:none"  height="20" width="20"> 
							<a style="align: right;" href="###" onClick="openSelectDialog('csc/common/includes/attach/Select.jsp')"><img id="" src="<%=request.getContextPath()%>/csc/images/pucker/rela.gif"  name="btn_attSelect" border="0" alt="提示：关联附件"></a> 
						</td>
						<td align="right" id="btn_attDelete" class="EXT_line_bottom" style="display:none"  height="20" width="20"> 
							<a style="align: right;" href="###" onClick="deleteAttach()"><img id="" src="<%=request.getContextPath()%>/csc/images/pucker/del.gif"  name="btn_attDelete" border="0" alt="提示：删除附件"></a>
			           	</td>
					</tr>
				</table>
			</div> 
			<div id="childattachRelat" style="display:none;" >
			<table align="center" width="100%">
				<tr>
   				<td width="120">&nbsp;</td>
   				<td >
				<ai:stable tableid="tblAttPack" setname="com.asiainfo.csc.attach.web.SETQueryAttPack"
		            invoke_type="service" initial="false" footdisplay="none"
		            invoke_name="com.asiainfo.csc.attach.service.AttachService" 
		            invoke_querymethod="queryQueryAttPack(String objNo, String type)"
		            editable="false" needrefresh="true" multiselect="true"
		            width="100%" height="80" rowheight="-1" pagesize="100" rowsequence="true"
		            ondbclick="" oncontextmenu="">				
					<ai:col fieldname="ATT_ID"        visible="false"></ai:col>
					<ai:col fieldname="ATT_TYPE"      visible="false"></ai:col>
					<ai:col fieldname="ATT_PACK_ID"   visible="false"></ai:col>
					<ai:col fieldname="OBJ_ID"        visible="false"></ai:col>
					<ai:col fieldname="OBJ_NO"        visible="true"></ai:col>
					<ai:col fieldname="OBJ_TYPE"      visible="true"></ai:col>
					<ai:col fieldname="ATT_PACK_DESC" visible="false"></ai:col>
					<ai:col fieldname="ATT_PATH"      visible="false"></ai:col>
					<ai:col fieldname="STATUS"        visible="false"></ai:col>
					<ai:col fieldname="SUBMITTER_TAG" visible="false"></ai:col>
					<ai:col fieldname="ATT_NAME"      visible="true" width="300"></ai:col>
					<ai:col fieldname="ATT_TYPE_NAME" visible="true" width="80" ></ai:col>
					<ai:col fieldname="ATT_DESC"      visible="true" width="300"></ai:col>
					<ai:col fieldname="EMPLOYEE_NAME" visible="true" width="100"></ai:col>
					<ai:col fieldname="SUBMIT_LINK"   visible="true" width="80" ></ai:col>
					<ai:col fieldname="SUBMIT_TIME"   visible="true" width="120"></ai:col>
				</ai:stable>
				</td></tr>
			</table>
			</div>
		</div>
	</body>
<script>

var showAttachObjNo = "";
var showAttachLinkNo = "";
var showAttachType = "";
//dxp 10-3-9  按钮状态 可编辑
function attachListAble() {
	attachCount();
	//g_AIButtonManager.get("attUpload").setDisabled(false);
	//g_AIButtonManager.get("attSelect").setDisabled(false);
	document.getElementById("btn_attUpload").style.display = "block";
	document.getElementById("btn_attSelect").style.display = "block";
}
//dxp 10-3-9 按钮状态 不可编辑
function attachListDisable (){
//	g_AIButtonManager.get("attDelete").setDisabled(true);
//	g_AIButtonManager.get("attUpload").setDisabled(true);
//	g_AIButtonManager.get("attSelect").setDisabled(true);
	document.getElementById("btn_attDelete").style.display = "none";
	document.getElementById("btn_attUpload").style.display = "none";
	document.getElementById("btn_attSelect").style.display = "none";
	document.getElementById("btn_attDelete").style.display = "none";
}
function attachCount(){
	var count = getTblAttPack().getTotalRowCount();
	if(count > 0){
//		g_AIButtonManager.get("attDelete").setDisabled(false);
		document.getElementById("btn_attRead").style.display = "block";
		document.getElementById("btn_attDelete").style.display = "block";
	}else{
//		g_AIButtonManager.get("attDelete").setDisabled(true);
		document.getElementById("btn_attRead").style.display = "none";
		document.getElementById("btn_attDelete").style.display = "none";
	}
}	
var objNo = "";
var type = 0;
var linkNo = "";
function initPackList(_objNo, _type, _linkNo){
	objNo = _objNo;
	type = _type;
	linkNo = _linkNo;
	showAttachObjNo = objNo;
	showAttachLinkNo = linkNo;
	showAttachType = type;
	
	getTblAttPack().refresh(null, "objNo=" + objNo + "&type=" + type);
	attachCount();	
}
function refreshPackList(){
	getTblAttPack().refresh(null, "objNo=" + objNo + "&type=" + type);
	attachCount();	
}
function getTblAttPack(){
	return g_TableRowSetManager.get("tblAttPack");
}
function openUploadDialog( url ) {   
	//var name = "网页对话框";  
	url = "<%=request.getContextPath()%>/" + url + "?objNo=" + objNo + "&type=" + type + "&linkNo=" + linkNo;  
	//alert(url);
	width = '500px';     
	height = '280px';   
	window.showModalDialog(url,window,'dialogWidth='+width+';dialogHeight='+height+';toolbar=no;directories=no;status=no;menubar=no;scrollbars=no;resizable=yes;modal=no'); 
} 
function openSelectDialog(url) {   
	//var name = "网页对话框";  
	url = "<%=request.getContextPath()%>/" + url + "?objNo=" + objNo + "&type=" + type;  //需求0，需求点1 版本2,缺陷3 案例4 工程5 计划6
	//alert(url);
	//aialmWin(url,500,300); 
	width = '500px';     
	height = '300px';   
	window.showModalDialog(url,window,'dialogWidth='+width+';dialogHeight='+height+';toolbar=no;directories=no;status=no;menubar=no;scrollbars=no;resizable=yes;modal=no'); 
} 

function readAttach(){
	var newRow = getTblAttPack().getRow();
    if (newRow == -1){
        aialmPrompt("请在附件列表中选择要阅读附件！");
        return;
    }
    var filepath = getTblAttPack().getValue(newRow,"ATT_PATH");
    var filename = getTblAttPack().getValue(newRow,"ATT_NAME");
    //alert(filepath);
    //var filefullname = g_StringTrim(filepath + filename);
    window.open ("<%=request.getContextPath()%>/business/com.asiainfo.csc.attach.web.AttachAction?action=doDownload&attName=" + filename + "&attPath=" + filepath);
}
function deleteAttach(){
	var rows = getTblAttPack().getSelectedRows();
	//alert(rows.length);
	if(rows.length == 0){
		aialmPrompt("请选择附件");
		return;
	}
	if(!confirm('确认要删除选择的附件吗？')){
		return;
	}
	var ids = new Array();
	for(var i = 0; i < rows.length; i++){
		ids.push(getTblAttPack().getValue(rows[i], "ATT_PACK_ID"));
	}
	var list = new Array();
	list.push(getTblAttPack(false));
	var url = "<%=request.getContextPath()%>/business/com.asiainfo.csc.attach.web.AttachAction?action=delPackage&ids="+ids;
	saveRowSet(url,list,true,false);
	refreshPackList();
}
function onAttach_HideShow(){
	if(document.getElementById('childattachRelat').style.display=='none'){
		//initPackList(showAttachObjNo,showAttachType,showAttachLinkNo);
		attachListAble();
		//attachCount();
		document.getElementById('childattachRelat').style.display = 'block';
		document.getElementById('show_hide_ico_attach').src="<%=request.getContextPath()%>/csc/images/pucker/hide.png";
	}else {
		document.getElementById('childattachRelat').style.display='none';
		document.getElementById('show_hide_ico_attach').src="<%=request.getContextPath()%>/csc/images/pucker/show.png";
	}

}
</script>
</html>