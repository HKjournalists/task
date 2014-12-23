<!-- function initPackList(_objNo, _type, _linkNo,_zone,_column,_isSelectAttType) 
初始化 返回:NONE 参数:_objNo:对象编号,_type:业务类型,_linkNo:环节编号,_zone:加载区域(对应ALM_ATTACH_TYPE_CONFIG表中的ZONE字段),
_column:附件类型列数,_isSelectAttType:是否必须选择附件类型-->
<!-- function checkAttType(xml) 校验附件类型 返回:true/false 参数:需要校验类型xml，对应ALM_ATTACH_TYPE_CONFIG表中的COND字段-->
<!-- function setAttrWindowWidth(width) 修改附件类型窗口宽度 返回:NONE 参数:width:附件类型窗口宽度-->
<!-- function setAttrWindowHeight(height) 修改附件类型窗口高度 返回:NONE 参数:height:附件类型窗口高度-->

<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/csc/common/taglib.jsp"%>
<%String path = request.getContextPath(); 
request.setAttribute("userInfo", SessionManager.getUser());
String  staffCode = SessionManager.getUser().getCode();
String orgName = request.getSession().getAttribute("orgNameStr").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>文件传输</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/easyui/themes/icon.css">

<script type="text/javascript" src="<%=path%>/easyui/jquery.easyui.min.js"></script>

<link rel="stylesheet" type="text/css" href="<%=path%>/csc/attach/upload/uploadify.css"/>
<script type="text/javascript" src="<%=path%>/csc/attach/upload/jquery.uploadify.js"></script>

</head>
<body>
<!-- <input type="button" class="btn-6word" value="附件校验" onclick="checkTest()"/> -->
<div class="div_title">
		<table class="content_title" width="98%" border="0">
			<tr>
				<td align="left" class="content_title_text">附件操作</td>
				<td align="right" class="content_title_text"> 
					<a style="align: right;" href="javascript:void(0)" onClick="readAttach() "><img src="<%=request.getContextPath()%>/csc/images/pucker/down.gif"  border="0" alt="提示：下载附件"></a> 
					<a style="align: right;" href="javascript:void(0)" onClick="openUploadDialog()"><img src="<%=request.getContextPath()%>/csc/images/pucker/up.gif" border="0" alt="提示：上传附件"></a> 
					<a style="align: right;" href="javascript:void(0)" onClick="deleteAttach()"><img src="<%=request.getContextPath()%>/csc/images/pucker/del.gif" border="0" alt="提示：删除附件"></a>
				</td>
			</tr>
		</table>
	<div id="childattachRelat" style="" >
		<table width="98%" align="center" class="table_context">
			<tr>
				<td width="100%">
					<ai:stable tableid="tblAttPack" setname="com.asiainfo.csc.attach.web.SETQueryAttPack"
		            invoke_type="service" initial="false" footdisplay="none"
		            invoke_name="com.asiainfo.csc.attach.service.AttachService" 
		            invoke_querymethod="queryQueryAttPackNew(String objNo, String type)"
		            editable="false" needrefresh="true" multiselect="true"
		            width="100%" height="80" rowheight="-1" pagesize="100" rowsequence="true"
		            ondbclick="" oncontextmenu="">				
					<ai:col fieldname="ATT_ID"        visible="false"></ai:col>
					<ai:col fieldname="ATT_TYPE"      visible="false"></ai:col>
					<ai:col fieldname="ATT_PACK_ID"   visible="false"></ai:col>
					<ai:col fieldname="OBJ_NO"        visible="true" width="200"></ai:col>
					<ai:col fieldname="ATT_PACK_DESC" visible="false"></ai:col>
					<ai:col fieldname="ATT_PATH"      visible="false"></ai:col>
					<ai:col fieldname="STATUS"        visible="false"></ai:col>
					<ai:col fieldname="SUBMITTER_TAG" visible="false"></ai:col>
					<ai:col fieldname="ATT_NAME"      visible="true" width="300"></ai:col>
					<ai:col fieldname="OBJ_TYPE"      visible="false" width="200"></ai:col>
					<ai:col fieldname="ATT_TYPE_NAME" visible="true" width="180" ></ai:col>
					<ai:col fieldname="ATT_DESC"      visible="false" width="300"></ai:col>
					<ai:col fieldname="EMPLOYEE_NAME" visible="true" width="100"></ai:col>
					<ai:col fieldname="SUBMIT_LINK"   visible="true" width="80" ></ai:col>
					<ai:col fieldname="SUBMIT_TIME"   visible="true" width="120"></ai:col>
				</ai:stable>
				</td>
			</tr>
		</table>
	</div>
</div>

<div id="downloadWindow" class="easyui-window" data-options="closable:true,modal:true,closed:true,iconCls:'icon-save',title:'附件下载',resizable:false,maximizable:false,collapsible:false,minimizable:false" style="width:450px;height:70px;">
	<form  action=""  method="post"  name="dd">
		<table border="0" width="100%">
			<tr>
				<td class="title_e">文件名</td>
				<td><input name="fileName" id="fileName" type="text" style="width:<%=aiEdit_3cw%>" >
				<input name="" type="button" class="btn-2word" value="下载" id="downfile" onclick="download()"/></td>
			</tr>
		</table>
	</form>
</div>
<div id="uploadButton">
	<input type="file" id="uploadify"/>
</div>
<div id="uploadifyWindow" class="easyui-window" data-options="onBeforeClose:function(){$('#uploadifyWindow').window('resize',{width:500,height:70});$('#upButton').attr('disabled','disabled');},tools:'#uploadButton',closable:false,modal:true,closed:true,iconCls:'icon-save',title:'附件上传',resizable:false,maximizable:false,collapsible:false,minimizable:false" style="width:500px;height:70px;">
	<table width="100%" border="0">
		<tr>
			<td align="right">
				<input type="button" class="btn-4word" value="上传附件" onclick="uploadQueue()" id="upButton" disabled="disabled"/>
				<input type="button" class="btn-4word" value="取消/关闭" onclick="cancleQueue()"/>
			</td>
		</tr>
	</table>
	<div id="uploadQueue"></div>
</div>

<div id="attachTypeWindow" class="easyui-window" data-options="closable:false,modal:true,closed:true,iconCls:'icon-save',title:'附件类型',resizable:false,maximizable:false,collapsible:false,minimizable:false" style="width:500px;height:210px;">
	<div id="attchTypeCB"></div>
	<table width="100%" border="0">
		<tr>
			<td align="center">
				<input type="button" class="bigBtn" value="确定" onclick="attachEnter()"/>
				<input type="button" class="bigBtn" value="取消" onclick="attachCancle()"/>
			</td>
		</tr>
	</table>
</div>
</body>
<script type="text/javascript">
var fileNum = 0;
var files = new Array();
    $(function(){
		$('#uploadify').uploadify({
        	width:60,
        	height:19,
            auto:false,
            method:"post",
            buttonText:'选择附件',
            queueID:'uploadQueue',
            swf: "<%=path%>/csc/attach/upload/uploadify.swf",
            uploader:"<%=request.getContextPath()%>/business/com.asiainfo.csc.attach.web.FileUpAction?action=uploadFile",
            onQueueComplete:function(queueData){
            	$.messager.alert('操作提示','上传完成','info',function(){
            		for(var i=0;hasAttType==true&&i<document.all("attachType").length;i++)
					{
					    document.all("attachType")[i].checked = false;
					}
					fileNum=0;
   					checkFileNum();
            		$('#uploadifyWindow').window('close');
            		attachType="";
            		refreshPackList();
            	});
            },
            onUploadStart:function(file){
            	$('#uploadify').uploadify("settings","formData",{attType:attachType,submitUser:'<%=staffCode%>',type:type,objNo:objNo,linkNo:linkNo,orgName:'<%=orgName%>'});
            },
            onSelect:function(file){
            	var url = '<%=path%>/business/com.asiainfo.csc.attach.web.FileUpAction?action=checkFileRepeat&objNo='+objNo+'&type='+type+'&submitTag=<%=staffCode%>'+'&attName='+file.name;
				var rtn = PostInfo(url,null);
				var isRepeat = rtn.getValueByName('isRepeat');
				fileNum++;
				files.push(file.id);
				if(isRepeat=='Y'){
					var msg = '';
					if(hasAttType==true){
						msg = '您已上传附件<font color="red">'+file.name+'</font>,上传该附件将会覆盖附件以及更新附件类型,确定上传?';
					}else{
						msg = '您已上传附件<font color="red">'+file.name+'</font>,上传该附件将会覆盖附件,确定上传?';
					}
					$.messager.confirm('操作提示',msg,function(r){
						if(!r){
							$('#uploadify').uploadify('cancel',file.id);
							checkFileNum();
						}else{
							checkFileNum();
						}
					});
				}else{
					checkFileNum();
				}
            },
            onCancel:function(file){
            	for(var i=0;i<files.length;i++){
            		if(file.id==files[i]){
		            	fileNum--;
		            	checkFileNum();
            		}
            	}
            }
        });
	});
	
function checkFileNum(){
	if(fileNum>0){
		$('#upButton').attr('disabled','');
		$('#uploadifyWindow').window('resize',{width:500,height:210});
	}else{
		$('#upButton').attr('disabled','disabled');
		$('#uploadifyWindow').window('resize',{width:500,height:70});
	}
}

function attachEnter(){
	var attachTypes = new Array();
	for(var i=0;hasAttType==true&&i<document.all("attachType").length;i++)
	{
		if(document.all("attachType")[i].checked)
		{
			attachTypes.push(document.all("attachType")[i].value);
		}
	}
	attachType = attachTypes.join(',');
	if(isSelectAttType==true){
		if(attachType==''){
			$.messager.alert("操作提示","请选择附件类型",'error',function(id){return;});
			return;
		}else{
			$('#attachTypeWindow').window('close');
			$('#uploadifyWindow').window('open');
			$('#uploadifyWindow').window('center');
		}
	}else if(isSelectAttType==false){
		if(attachType==''){
			$.messager.confirm('操作提示','确定该附件无附件类型?',function(r){
				if(r){
					$('#attachTypeWindow').window('close');
					$('#uploadifyWindow').window('open');
					$('#uploadifyWindow').window('center');
				}
			});
		}else{
			$('#attachTypeWindow').window('close');
			$('#uploadifyWindow').window('open');
			$('#uploadifyWindow').window('center');
		}
	}
}

function attachCancle(){
	for(var i=0;hasAttType==true&&i<document.all("attachType").length;i++)
	{
		document.all("attachType")[i].checked = false;
	}
	$('#attachTypeWindow').window('close');
	attachType="";
}

function cancleQueue(){
	$.messager.confirm('操作提示','确定要取消文件上传?',function(r){
		if(r){
			$('#uploadify').uploadify('stop');
			$('#uploadify').uploadify('cancel','*');
			$('#uploadifyWindow').window('close');
			attachType="";
			for(var i=0;i<document.all("attachType").length;i++)
			{
				document.all("attachType")[i].checked = false;
			}
		}
	});
}

function uploadQueue(){
    $('#uploadify').uploadify('upload','*');
}

function download(){
	var fileName = document.dd.fileName.value;
	if(fileName==''){
		$.messager.alert("操作提示","请填写文件名称",'error',function(id){return;});
		return;
	}
	var rowIndexs=getTblAttPack().getSelectedRows();
	var attIds = new Array();
	for(var i=0;i<rowIndexs.length;i++){
		attIds.push(getTblAttPack().getValue(rowIndexs[i],'ATT_ID'));
	}
	
    var url = '<%=path%>/fileDownload?zipFileName='+fileName+'&attIds='+attIds.join(',');
    document.dd.action=url;
	document.dd.submit();
	$('#downloadWindow').window('close');
}
var showAttachReqpNO = "";
var showAttachLinkNO = "";
var showAttachType = "";

var showReqType = "";
var showSysTag = "";
var showSubSysTag = "";

var attachType="";

var changeWidth = 0;
var changeHeight = 0;

function setAttachContextReqpNOAndLinkNO(showReqpNO,Atclink_no){
	showAttachReqpNO=showReqpNO;
	showAttachLinkNO=Atclink_no;
	showAttachType = "1";
}

function setAttachContext(showReqpNO,Atclink_no,reqType,sysTag,subSysTag){
	showAttachReqpNO=showReqpNO;
	showAttachLinkNO=Atclink_no;
	showAttachType = "1";
	showReqType = reqType;
	showSysTag = sysTag;
	showSubSysTag = subSysTag;
}

var objNo = "";
var type = 0;
var linkNo = "";
var zone = "";
var column = "";
var isSelectAttType = false;
var hasAttType = true;

function initPackList(_objNo, _type, _linkNo,_zone,_column,_isSelectAttType){
	if(_objNo==null||_objNo==''||typeof _objNo == 'undefined'){
		if('{param.objNo}'==''){
			alert('初始化错误，缺少_objNo参数值');
			return;
		}
	}
	if(_type==null||_type==''||typeof _type == 'undefined'){
		if('{param.type}'==''){
			alert('初始化错误，缺少_type参数值');
			return;
		}
	}
	if(_linkNo==null||_linkNo==''||typeof _linkNo == 'undefined'){
		if('{param.linkNo}'==''){
			alert('初始化错误，缺少_linkNo参数值');
			return;
		}
	}
	if(_column==null||typeof _column == 'undefined'){
		if('{param.column}'==''){
			alert('初始化错误，缺少_column参数值');
			return;
		}
	}
	if(_zone==null||typeof _zone == 'undefined'){
		if('{param.column}'==''){
			alert('初始化错误，缺少_zone参数值');
			return;
		}
	}
	if(_isSelectAttType==null||typeof _isSelectAttType == 'undefined'){
		if('{param.isSelectAttType}'==''){
		alert('初始化错误，缺少_isSelectAttType参数值');
		return;
		}
	}
	objNo = _objNo;
	type = _type;
	linkNo = _linkNo;
	zone = _zone;
	column = _column;
	isSelectAttType = _isSelectAttType;
	
	showAttachReqpNO = objNo;
	showAttachLinkNO = linkNo;
	showAttachType = type;
	
	if(zone!=''){
		if(column==''){
			alert('加载错误，缺少_column参数值');
			return;
		}
		var url = '<%=path%>/business/com.asiainfo.csc.attach.web.AttachTypeConfigAction?action=getAttachTypeConfig&zone='+zone+'&column='+column;
		var rtn = PostInfo(url,null);
		var str = rtn.getValueByName('html');
	}
	if(str!=null&&str!=''&&typeof str!='undefined'&&zone!=''){
		$('#attchTypeCB').html(str);
		hasAttType = true;
	}else{
		hasAttType = false;
	}
	getTblAttPack().refresh(null, "objNo=" + objNo + "&type=" + type);
}
function refreshPackList(){
	getTblAttPack().refresh(null, "objNo=" + objNo + "&type=" + type);
}
function getTblAttPack(){
	return g_TableRowSetManager.get("tblAttPack");
}
function openUploadDialog() {  
	if(hasAttType==false){
		$('#uploadifyWindow').window('open');
		$('#uploadifyWindow').window('center');
	}else{
		$('#attachTypeWindow').window('open');
		$('#attachTypeWindow').window('center');
		if(changeWidth!=0)
			$('#attachTypeWindow').window('resize',{width:changeWidth});
		if(changeHeight!=0)
			$('#attachTypeWindow').window('resize',{height:changeHeight});
	}
} 

function readAttach(){
	var rowIndexs=getTblAttPack().getSelectedRows();
	if(rowIndexs.length==0){
		$.messager.alert("操作提示","请选择至少一条记录进行下载",'error',function(id){return;});
	 	return;
	}
	if(rowIndexs.length==1){
		var fileName = getTblAttPack().getValue(rowIndexs[0],'ATT_NAME');
		var rowIndexs=getTblAttPack().getSelectedRows();
		var attIds = new Array();
		for(var i=0;i<rowIndexs.length;i++){
			attIds.push(getTblAttPack().getValue(rowIndexs[i],'ATT_ID'));
		}
		
	    var url = '<%=path%>/fileDownload?zipFileName='+fileName+'&attIds='+attIds.join(',');
	    document.dd.action=url;
		document.dd.submit();
	}else{
		$('#downloadWindow').window('open');
		$('#downloadWindow').window('center');
	}
}

function deleteAttach(){
	var rows = getTblAttPack().getSelectedRows();
	
	if(rows.length == 0){
		$.messager.alert("操作提示","请选择附件",'error',function(id){return;});
		return;
	}
	$.messager.confirm('操作提示','确认要删除选择的附件吗？',function(r){
		if(r){
			var ids = new Array();
			for(var i = 0; i < rows.length; i++){
				ids.push(getTblAttPack().getValue(rows[i], "ATT_PACK_ID"));
			}
			var list = new Array();
			list.push(getTblAttPack(false));
			//alert("ids:"+ids);
			var url = "<%=request.getContextPath()%>/business/com.asiainfo.csc.attach.web.FileDeleteAction?action=deleteFile&attPackId="+ids;
		
			var rtn = saveRowSet(url,list,true,false);
			var msg = rtn.getValueByName('msg');
			$.messager.alert("操作提示",msg,'info');
			refreshPackList();
		}
	});
}

function checkAttType(xml){
	if(hasAttType==true){
		if(xml==null||xml==''||typeof xml == 'undefined'){
			alert('校验错误:xml为空');
			return;
		}
		var ids = new Array();
		var rows = getTblAttPack().count();
		for(var i = 0; i < rows; i++){
			if(getTblAttPack().getValue(i, "ATT_TYPE")!='')
				ids.push(getTblAttPack().getValue(i, "ATT_TYPE"));
		}
		var url = '<%=path%>/business/com.asiainfo.csc.attach.web.AttachTypeConfigAction?action=checkAttachType&zone='+zone+'&xml='+xml+'&hasSelectedTypeId='+ids;
		var rtn = PostInfo(url,null);
		var isEqual = rtn.getValueByName('isEqual');
		var noTypeName = rtn.getValueByName('noTypeName');
		var checkAttType = rtn.getValueByName('checkAttType');
		var checkAttTypeName = rtn.getValueByName('checkAttTypeName');
		var noType = rtn.getValueByName('noType');
		var retVal = checkIsCurLinkAndNameUpload(checkAttType);
		if(isEqual=='Y'){
			if(retVal.msg!=''){
				var attTypeName = '';
				for(var i=0;i<retVal.curHasNotType.length;i++){
					var url = '<%=path%>/business/com.asiainfo.csc.attach.web.AttachTypeConfigAction?action=getAttachTypeName&attTypeId='+retVal.curHasNotType[i];
					var rtn = PostInfo(url,null);
					attTypeName += rtn.getValueByName('attTypeName')+',';
				}
				if(confirm(attTypeName.substr(0,attTypeName.length-1)+'类型的文件已由其它环节上传'+',信息：'+retVal.msg+'是否要上传该类型的文件?')){
					openUploadDialog();
					return false;
				}else{
					return true;
				}
			}else{
				return true;
			}
		}
		else if(isEqual=='N'){
			var showMsg = '';
			var noTypes = noType.split(',');
			var curHasNotTypes = retVal.curHasNotType;
			for(var k=0;k<noTypes.length;k++){
				for(var j=0;j<curHasNotTypes.length;j++)
				if(noTypes[k]==curHasNotTypes[j]){
					curHasNotTypes.splice(j,1);
					break;
				}
			} 
			if(retVal.msg!=''){
				var attTypeName = '';
				for(var i=0;i<curHasNotTypes.length;i++){
					var url = '<%=path%>/business/com.asiainfo.csc.attach.web.AttachTypeConfigAction?action=getAttachTypeName&attTypeId='+curHasNotTypes[i];
					var rtn = PostInfo(url,null);
					attTypeName += rtn.getValueByName('attTypeName')+',';
				}
				showMsg = attTypeName.substr(0,attTypeName.length-1)+'类型的文件已由其它环节上传'+',信息：'+retVal.msg+'并且缺少附件类型:'+noTypeName+'的文件';
			}
			else
				showMsg = '缺少附件类型:'+noTypeName+'的文件';
			alert(showMsg);
			openUploadDialog();
			return false;
		}else{
			alert('校验错误');
			return false;
		}
	}
}

function checkIsCurLinkAndNameUpload(attTypeId){
	var rtnMsg = '';
	var curHasSelectType = getCurUploadAttType(attTypeId);
	var rows = getTblAttPack().count();
	var attTypeIds = attTypeId.split(',');
	for(var i = 0; i < rows; i++){
		if(getTblAttPack().getValue(i, "ATT_TYPE")!=''){
			var hasAttTypes = getTblAttPack().getValue(i, "ATT_TYPE").split(',');
			var submitLink = getTblAttPack().getValue(i, "SUBMIT_LINK");
			var submitLinkText = getTblAttPack().getDisplayText(i, "SUBMIT_LINK");
			var submitName = getTblAttPack().getValue(i, "EMPLOYEE_NAME");
			var fileName = getTblAttPack().getValue(i, "ATT_NAME");
			for(var j=0;j<attTypeIds.length;j++){
				var hasUpload = false;
				for(var k=0;k<hasAttTypes.length;k++){
					if(hasAttTypes[k]==attTypeIds[j]){
						if(submitLink==linkNo)
							hasUpload = false;
						else
							hasUpload = true;
						break;
					}
				}
				var isEqual = false;
				for(var l=0;l<curHasSelectType.length;l++){
					if(curHasSelectType[l]==attTypeIds[j]){
						isEqual = true;
						break;
					}
				}
				if(hasUpload==true&&isEqual==false){
					var url = '<%=path%>/business/com.asiainfo.csc.attach.web.AttachTypeConfigAction?action=getAttachTypeName&attTypeId='+attTypeIds[j];
					var rtn = PostInfo(url,null);
					var attTypeName = rtn.getValueByName('attTypeName');
					rtnMsg += '类型['+attTypeName+']的文件已经在['+submitLinkText+']环节由['+submitName+']上传,'+'文件名['+fileName+'];';
				}
			}
		}
	}
	
	if(curHasSelectType.length==attTypeIds.length){
		return {msg:'',curHasType:''};
	}else{
		var curHasNotSelectType = attTypeId.split(',');
		for(var i=0;i<curHasSelectType.length;i++)
			for(var j=0;j<curHasNotSelectType.length;j++)
				if(curHasSelectType[i]==curHasNotSelectType[j]){
					curHasNotSelectType.splice(j,1);
					break;
				}
		return {msg:rtnMsg,curHasNotType:curHasNotSelectType};
	}
}

function getCurUploadAttType(attTypeId){
	var curHasSelectType = new Array();
	var rows = getTblAttPack().count();
	for(var i = 0; i < rows; i++){
		if(getTblAttPack().getValue(i, "ATT_TYPE")!=''){
			var hasAttTypes = getTblAttPack().getValue(i, "ATT_TYPE").split(',');
			var submitLink = getTblAttPack().getValue(i, "SUBMIT_LINK");
			var attTypeIds = attTypeId.split(',');
			for(var j=0;j<attTypeIds.length;j++){
				for(var k=0;k<hasAttTypes.length;k++){
					if(hasAttTypes[k]==attTypeIds[j]&&submitLink==linkNo){
						curHasSelectType.push(attTypeIds[j]);
						break;
					}
				}
			}
		}
	}
	return curHasSelectType;
}

function setAttrWindowWidth(width){
	changeWidth=width;
}

function setAttrWindowHeight(height){
	changeHeight=height;
}
/*test-----------------------------------------------------------------------------------*/
//function checkTest(){
//	var xml = new Array();
//	xml.push("<conds><cond key='bbb' value='2'/><cond value='1' key='aaa'/></conds>");
//	xml.push("<conds><cond key='ddd' value='4'/><cond value='3' key='ccc'/></conds>");
//	xml.push("<conds><cond key='bbb' value='2'/><cond key='ccc' value='3'/><cond value='1' key='aaa'/></conds>");
//	var result = checkAttType(xml);
//	if(result){
//		alert("校验成功");
//	}
//	if(!result){
//		alert("校验失败");
//	}
//}

//initPackList('REQMPAF20130830160406','17','ReqInput',"1","2",true);
//setAttrWindowWidth(1000);
//setAttrWindowHeight(500);
</script>
</html> 

