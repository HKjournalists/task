<!-- function initPackList(_objNo, _type, _linkNo,_zone,_column,_isSelectAttType) 
初始化 返回:NONE 参数:_objNo:对象编号,_type:业务类型,_linkNo:环节编号,_zone:加载区域(对应ALM_ATTACH_TYPE_CONFIG表中的ZONE字段),
_column:附件类型列数,_isSelectAttType:是否必须选择附件类型-->
<!-- function checkAttType(xml) 校验附件类型 返回:true/false 参数:需要校验类型xml，对应ALM_ATTACH_TYPE_CONFIG表中的COND字段-->
<!-- function setAttrWindowWidth(width) 修改附件类型窗口宽度 返回:NONE 参数:width:附件类型窗口宽度-->
<!-- function setAttrWindowHeight(height) 修改附件类型窗口高度 返回:NONE 参数:height:附件类型窗口高度-->

<%@page import="com.asiainfo.aiga.common.security.user.URLConnectUtil"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%String path = request.getContextPath(); 
AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
String workflowUrl = request.getSession().getAttribute("workflowUrl").toString();
String orgName = URLConnectUtil.getStaffOrg(user.getUserAccount(), workflowUrl+"/business/com.ai.filter.AigaUserOrg?action=getUserOrg");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>文件传输</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/aiga/attach/upload/uploadify.css"/>
<script type="text/javascript" src="<%=path%>/aiga/attach/upload/jquery.uploadify.js"></script>
</head>
<body>
<!-- <input type="button" class="btn-6word" value="附件校验" onclick="checkTest()"/> -->
<div class="div_title">
		<table class="content_title" width="98%" border="0">
			<tr>
				<td align="left" class="content_title_text">附件操作</td>
				<td align="right" class="content_title_text"> 
					<a style="align: right;" href="javascript:void(0)" onClick="readAttach() "><img src="<%=request.getContextPath()%>/aiga/images/pucker/down.gif"  border="0" alt="提示：下载附件" title="提示：下载附件"></a> 
					<a style="align: right;" href="javascript:void(0)" onClick="openUploadDialog()"><img src="<%=request.getContextPath()%>/aiga/images/pucker/up.gif" border="0" alt="提示：上传附件" title="提示：上传附件"></a> 
					<a style="align: right;" href="javascript:void(0)" onClick="deleteAttach()"><img src="<%=request.getContextPath()%>/aiga/images/pucker/del.gif" border="0" alt="提示：删除附件" title="提示：删除附件"></a>
				</td>
			</tr>
		</table>
	<div id="childattachRelat" style="" >
		<table width="98%" align="center" class="table_context">
			<tr>
				<td width="100%" height="100%" id="attachTable">
				</td>
			</tr>
		</table>
	</div>
</div>

<div id="downloadWindowd" style="width:450px;height:70px;">
	<form  action=""  method="post"  name="dd">
		<table border="0" width="100%">
			<tr>
				<td class="title_e">文件名:</td>
				<td><input name="fileName" id="fileName" type="text" style="width:200;" >
				<input name="" type="button" class="btn-2word" value="下载" id="downfile" onclick="download()"/></td>
			</tr>
		</table>
	</form>
</div>
<div id="uploadifyWindowd" style="width:497px;height:60px;">
	<table width="100%" border="0">
		<tr>
			<td align="left"><input type="file" id="uploadify"/></td>
			<td align="right" width="500px;">
				<input type="button" class="btn-2word" value="上传附件" onclick="uploadQueue()" id="upButton" disabled="disabled"/>
				<input type="button" class="btn-2word" value="取消/关闭" onclick="cancleQueue()"/>
			</td>
		</tr>
	</table>
	<div id="uploadQueue" style="width: 100%;"></div>
</div>

<div id="attachTypeWindowd" style="width:500px;height:210px;">
	<div id="attchTypeCB"></div>
	<table width="100%" border="0">
		<tr>
			<td align="center">
				<input type="button" class="btn-2word" value="确定" onclick="attachEnter()"/>
				<input type="button" class="btn-2word" value="取消" onclick="attachCancle()"/>
			</td>
		</tr>
	</table>
</div>
</body>
<script type="text/javascript">
var fileNum = 0;
var files = new Array();
	
function checkFileNum(){
	if(fileNum>0){
		$('#upButton').attr('disabled',false);
		Ext.getCmp('uploadifyWindow').setSize(530,213);
	}else{
		$('#upButton').attr('disabled',true);
		Ext.getCmp('uploadifyWindow').setSize(530,100);
	}
}

function attachEnter(){
	var attachTypes = new Array();
	for(var i=0;document.all("attachType")!=null&&hasAttType==true&&i<document.all("attachType").length;i++)
	{
		if(document.all("attachType")[i].checked)
		{
			attachTypes.push(document.all("attachType")[i].value);
		}
	}
	attachType = attachTypes.join(',');
	if(isSelectAttType==true){
		if(attachType==''){
			Ext.Msg.alert("操作提示","请选择附件类型");
			return;
		}else{
			Ext.getCmp('attachTypeWindow').close();
			Ext.getCmp('uploadifyWindow').show();
		}
	}else if(isSelectAttType==false){
		if(attachType==''){
			Ext.MessageBox.confirm('操作提示','确定该附件无附件类型?',function(optional){
				if(optional=='yes'){
					Ext.getCmp('attachTypeWindow').close();
					Ext.getCmp('uploadifyWindow').show();
				}
			});
		}else{
			Ext.getCmp('attachTypeWindow').close();
			Ext.getCmp('uploadifyWindow').show();
		}
	}
}

function attachCancle(){
	for(var i=0;document.all("attachType")!=null&&hasAttType==true&&i<document.all("attachType").length;i++)
	{
		document.all("attachType")[i].checked = false;
	}
	Ext.getCmp('attachTypeWindow').close();
	attachType="";
}

function cancleQueue(){
	Ext.MessageBox.confirm('操作提示','确定要取消上传?',function(optional){
		if(optional=='yes'){
			$('#uploadify').uploadify('stop');
			$('#uploadify').uploadify('cancel','*');
			Ext.getCmp('uploadifyWindow').close();
			attachType="";
			for(var i=0;document.all("attachType")!=null&&i<document.all("attachType").length;i++)
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
		Ext.Msg.alert("操作提示","请填写文件名称");
		return;
	}
	var selectAttach=Ext.getCmp("attachGrid").getSelectionModel().getSelection();
	var attIds = new Array();
	for(var i=0;i<selectAttach.length;i++){
		attIds.push(selectAttach[i].raw.attId);
	}
	
    var url = '<%=request.getContextPath()%>/downloadFile.do?zipFileName='+fileName+'&attIds='+attIds.join(',')+"&uid=<%=user.getUserAccount()%>";
    document.dd.action=url;
	document.dd.submit();
	Ext.getCmp('downloadWindow').close();
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
		alert('初始化错误，缺少_objNo参数值');
		return;
	}
	if(_type==null||_type==''||typeof _type == 'undefined'){
		alert('初始化错误，缺少_type参数值');
		return;
	}
	if(_linkNo==null||_linkNo==''||typeof _linkNo == 'undefined'){
		alert('初始化错误，缺少_linkNo参数值');
		return;
	}
	if(_column==null||typeof _column == 'undefined'){
		alert('初始化错误，缺少_column参数值');
		return;
	}
	if(_zone==null||typeof _zone == 'undefined'){
		alert('初始化错误，缺少_zone参数值');
		return;
	}
	if(_isSelectAttType==null||typeof _isSelectAttType == 'undefined'){
		alert('初始化错误，缺少_isSelectAttType参数值');
		return;
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
		var url = '<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.csc.attach.web.AttachTypeConfigAction&action=getAttachTypeConfig&zone='+zone+'&column='+column+"&uid=<%=user.getUserAccount()%>";
		MaskLoading();
		Ext.Ajax.request({   
			url:url,  
			success:function(response,config){
				MaskOver();
				var json=Ext.JSON.decode(response.responseText);
				var str = json.html;
				if(str!=null&&str!=''&&typeof str!='undefined'&&zone!=''){
					$('#attchTypeCB').html(str);
					hasAttType = true;
				}else{
					hasAttType = false;
				}
				Ext.getCmp('attachGrid').getStore().load({params:{objNo:objNo,type:type}});
			},
			failure:function(response,config){
				MaskOver();
				Ext.Msg.alert("提示","数据请求失败");
			}
		});
	}
	
}
function refreshPackList(){
	Ext.getCmp('attachGrid').getStore().reload({params:{objNo:objNo,type:type}});
}
function getTblAttPack(){
	return Ext.getCmp('attachGrid');
}
function openUploadDialog() {  
	if(hasAttType==false){
		Ext.getCmp('uploadifyWindow').show();
	}else{
		Ext.getCmp('attachTypeWindow').show();
		if(changeWidth!=0)
			Ext.getCmp('attachTypeWindow').setWidth(changeWidth);
		if(changeHeight!=0)
			Ext.getCmp('attachTypeWindow').setHeight(changeHeight);
	}
} 

function readAttach(){
	var selectAttach=getTblAttPack().getSelectionModel().getSelection();
	if(selectAttach.length==0){
		Ext.Msg.alert("操作提示","请选择至少一条记录进行下载");
	 	return;
	}
	if(selectAttach.length==1){
		var fileName = selectAttach[0].raw.attName;
		var selectAttach=getTblAttPack().getSelectionModel().getSelection();
		var attIds = new Array();
		for(var i=0;i<selectAttach.length;i++){
			attIds.push(selectAttach[i].raw.attId);
		}
		
	    var url = '<%=request.getContextPath()%>/downloadFile.do?zipFileName='+fileName+'&attIds='+attIds.join(',')+"&uid=<%=user.getUserAccount()%>";
	    document.dd.action=url;
		document.dd.submit();
	}else{
		Ext.getCmp('downloadWindow').show();
	}
}

function deleteAttach(){
	var selectAttach = getTblAttPack().getSelectionModel().getSelection();
	
	if(selectAttach.length == 0){
		Ext.Msg.alert("操作提示","请选择附件");
		return;
	}
	Ext.MessageBox.confirm('操作提示','确定要删除选中的附件?',function(optional){
		if(optional=='yes'){
			var ids = new Array();
			for(var i = 0; i < selectAttach.length; i++){
				ids.push(selectAttach[i].raw.attPackId);
			}
			var url = "<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.csc.attach.web.FileDeleteAction&action=deleteFile&attPackId="+ids+"&uid=<%=user.getUserAccount()%>";
			MaskLoading();
			Ext.Ajax.request({   
				url:url,  
				success:function(response,config){
				MaskOver();
					var json=Ext.JSON.decode(response.responseText);
					Ext.Msg.alert("操作提示",json.msg);
					refreshPackList();
				}, 
				failure:function(){ 
				MaskOver();
					Ext.Msg.alert('提示','删除失败');
				}   
			});    	
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
		var rows = getTblAttPack().getStore().count();
		for(var i = 0; i < rows; i++){
			if(getTblAttPack().getStore().data.items[i].raw.attType!='')
				ids.push(getTblAttPack().getStore().data.items[i].raw.attType);
		}
		var url = '<%=request.getContextPath()%>/getDomainJsonData.do';
		var resultJson = null;
		MaskLoading();
		Ext.Ajax.request({ 
			async:false, 
			url:url,  
			params:{
				urlJava:'/business/com.asiainfo.csc.attach.web.AttachTypeConfigAction',
				action:'checkAttachType',
				zone:zone,
				xml:xml,
				hasSelectedTypeId:ids,
				uid:'<%=user.getUserAccount()%>'
			},
			success:function(response,config){
				MaskOver();
				resultJson=Ext.JSON.decode(response.responseText);
			}, 
			failure:function(){ 
				MaskOver();
				Ext.Msg.alert('提示','删除失败');
			}   
		});
		
		var isEqual = resultJson.isEqual;
		var noTypeName = resultJson.noTypeName;
		var checkAttType = resultJson.checkAttType;
		var checkAttTypeName = resultJson.checkAttTypeName;
		var noType = resultJson.noType;
		var retVal = checkIsCurLinkAndNameUpload(checkAttType);
		if(isEqual=='Y'){
			if(retVal.msg!=''){
				var attTypeName = '';
				for(var i=0;i<retVal.curHasNotType.length;i++){
					var url = '<%=request.getContextPath()%>/getDomainJsonData.do';
					MaskLoading();
					Ext.Ajax.request({  
						async:false, 
						url:url,  
						params:{urlJava:'/business/com.asiainfo.csc.attach.web.AttachTypeConfigAction',
						action:'getAttachTypeName',
						attTypeId:retVal.curHasNotType[i],
						uid:'<%=user.getUserAccount()%>'
						},
						success:function(response,config){
				MaskOver();
							var json2=Ext.JSON.decode(response.responseText);
							attTypeName += json2.attTypeName+',';
						},
						failure:function(response,config){
				MaskOver();
							Ext.Msg.alert("提示","数据请求失败");
						}
					});
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
					var url = '<%=request.getContextPath()%>/getDomainJsonData.do';
					var rtn = PostInfo(url,null);
					MaskLoading();
					Ext.Ajax.request({  
						async:false, 
						url:url,  
						params:{urlJava:'/business/com.asiainfo.csc.attach.web.AttachTypeConfigAction',
						action:'getAttachTypeName',
						attTypeId:curHasNotTypes[i],
						uid:'<%=user.getUserAccount()%>'
						},
						success:function(response,config){
				MaskOver();
							var json3=Ext.JSON.decode(response.responseText);
							attTypeName += json3.attTypeName+',';
							showMsg = attTypeName.substr(0,attTypeName.length-1)+'类型的文件已由其它环节上传'+',信息：'+retVal.msg+'并且缺少附件类型:'+noTypeName+'的文件';
						},
						failure:function(response,config){
				MaskOver();
							Ext.Msg.alert("提示","数据请求失败");
						}
					});
				}
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
	var rows = getTblAttPack().getStore().count();
	var attTypeIds = attTypeId.split(',');
	for(var i = 0; i < rows; i++){
		if(getTblAttPack().getStore().data.items[i].raw.attType!=''){
			var hasAttTypes = getTblAttPack().getStore().data.items[i].raw.attType.split(',');
			var submitLink = getTblAttPack().getStore().data.items[i].raw.submitLink;
			var submitLinkText = getTblAttPack().getStore().data.items[i].raw.submitLink;//aaaaaaa
			var submitName = getTblAttPack().getStore().data.items[i].raw.employeeName;
			var fileName = getTblAttPack().getStore().data.items[i].raw.attName;
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
					var url = '<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.csc.attach.web.AttachTypeConfigAction&action=getAttachTypeName&attTypeId='+attTypeIds[j]+"&uid=<%=user.getUserAccount()%>";
					MaskLoading();
					Ext.Ajax.request({   
						async:false,
						url:url,  
						success:function(response,config){
						MaskOver();
							var json4=Ext.JSON.decode(response.responseText);
							var attTypeName = json4.attTypeName;
							rtnMsg += '类型['+attTypeName+']的文件已经在['+submitLinkText+']环节由['+submitName+']上传,'+'文件名['+fileName+'];';
						},
						failure:function(response,config){
							MaskOver();
							Ext.Msg.alert("提示","数据请求失败");
						}
					});
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
	var rows = getTblAttPack().getStore().count();
	for(var i = 0; i < rows; i++){
		if(getTblAttPack().getStore().data.items[i].raw.attType!=''){
			var hasAttTypes = getTblAttPack().getStore().data.items[i].raw.attType.split(',');
			var submitLink = getTblAttPack().getStore().data.items[i].raw.submitLink;
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

Ext.onReady(function(){
	
	var attachModel = Ext.regModel("attachModel",{
			fields:[
				{name:'attId',type:'string'},
				{name:'attName',type:'string'},
				{name:'objId',type:'string'},
				{name:'attDesc',type:'string'},
				{name:'status',type:'string'},
				{name:'attTypeName',type:'string'},
				{name:'objNo',type:'string'},
				{name:'woId',type:'string'},
				{name:'submitterTag',type:'string'},
				{name:'submitTime',type:'string'},
				{name:'objType',type:'string'},
				{name:'attPackDesc',type:'string'},
				{name:'employeeName',type:'string'},
				{name:'submitLink',type:'string'},
				{name:'attPackId',type:'string'},
				{name:'attPath',type:'string'},
				{name:'attType',type:'string'}]
		});
		
		var attachProxy = new Ext.data.proxy.Ajax({
			type:"ajax",
			model:attachModel,
			url:'<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.csc.attach.web.FileUpAction&action=queryQueryAttPackNew'+'&uid=<%=user.getUserAccount()%>',
			reader:{
				root:"data",
				type:"json"
			}
		});
		var attachStore = Ext.create('Ext.data.Store',{
			model:attachModel,
			proxy:attachProxy
		});
		var attachGrid = Ext.create('Ext.grid.Panel',{
			id:'attachGrid',
			renderTo:Ext.get('attachTable'),
			height: 140,
		    autoWidth : true,
			viewConfig:{
				forctFit:true,
				stripeRows:true
			},
			store:attachStore,
			selModel:Ext.create("Ext.selection.CheckboxModel",{mode:"SIMPLE"}),
			columns:[
				new Ext.grid.RowNumberer(),
				{header:"ID",width:100,dataIndex:"attId",sortable:true,hidden:true},
				{header:"编号",width:100,dataIndex:"objNo",sortable:true},
				{header:"附件名称",width:100,dataIndex:"attName",sortable:true},
				{header:"附件类型",width:100,dataIndex:"attTypeName",sortable:true},
				{header:"objId",width:100,dataIndex:"objId",sortable:true,hidden:true},
				{header:"附件描述",width:100,dataIndex:"attDesc",sortable:true,hidden:true},
				{header:"woId",width:100,dataIndex:"woId",sortable:true,hidden:true},
				{header:"提交人",width:100,dataIndex:"submitterTag",sortable:true,hidden:true},
				{header:"上传时间",width:100,dataIndex:"submitTime",sortable:true},
				{header:"类型",width:100,dataIndex:"objType",sortable:true,hidden:true},
				{header:"附件描述",width:100,dataIndex:"attPackDesc",sortable:true,hidden:true},
				{header:"提交人",width:100,dataIndex:"employeeName",sortable:true},
				{header:"提交环节",width:100,dataIndex:"submitLink",sortable:true,hidden:true},
				{header:"提交环节",width:100,dataIndex:"status",sortable:true},
				{header:"附件ID",width:100,dataIndex:"attPackId",sortable:true,hidden:true},
				{header:"附件路径",width:100,dataIndex:"attPath",sortable:true,hidden:true},
				{header:"附件类型",width:100,dataIndex:"attType",sortable:true,hidden:true}]
		});
		
		var uploadifyWindow = new Ext.window.Window({
			id:'uploadifyWindow',
			title : '附件上传',
	 		cls: 'ui-formPanel',
	 		autoScroll : true,
			width : 530,
			height : 213,
			resizable:false,
			modal : true,
			closable:false,
			closeAction : 'hide',
			contentEl:'uploadifyWindowd',
			listeners:{
				beforeclose : function(panel,eOpts){
					Ext.getCmp('uploadifyWindow').setSize(530,100);
					$('#upButton').attr('disabled',true);
				}
			}
		}).show();
		
		uploadifyWindow.close();
		
		var downloadWindow = new Ext.window.Window({
			id:'downloadWindow',
			title : '下载附件',
	 		cls: 'ui-formPanel',
			width : 450,
			height : 70,
			resizable:false,
			modal : true,
			closeAction : 'hide',
			contentEl:'downloadWindowd'
		}).show();
		
		downloadWindow.close();
		
		var attachTypeWindow = new Ext.window.Window({
			id:'attachTypeWindow',
			title : '附件类型',
	 		cls: 'ui-formPanel',
	 		autoScroll : true,
			width : 500,
			height : 210,
			resizable:false,
			modal : true,
			closeAction : 'hide',
			contentEl:'attachTypeWindowd'
		}).show();
		attachTypeWindow.close();
		
		$('#uploadify').uploadify({
        	width:70,
        	height:19,
            auto:false,
            method:"post",
            buttonText:'选择附件',
            queueID:'uploadQueue',
            swf: "<%=path%>/aiga/attach/upload/uploadify.swf",
            uploader:"<%=request.getContextPath()%>/uploadFile.do?urlJava=/business/com.asiainfo.csc.attach.web.FileUpAction&action=uploadFile&uid=<%=user.getUserAccount()%>",
            onQueueComplete:function(queueData){
            	Ext.Msg.alert('操作提示','上传完成',function(){
            		for(var i=0;document.all("attachType")!=null&&hasAttType==true&&i<document.all("attachType").length;i++)
					{
					    document.all("attachType")[i].checked = false;
					}
					fileNum=0;
   					checkFileNum();
            		Ext.getCmp('uploadifyWindow').close();
            		attachType="";
            		refreshPackList();
            	});
            },
            onUploadStart:function(file){
            	$('#uploadify').uploadify("settings","formData",{attType:attachType,submitUser:'<%=user.getUserAccount()%>',type:type,objNo:objNo,linkNo:linkNo,orgName:'<%=orgName%>'});
            },
            onSelect:function(file){
            	var url = '<%=request.getContextPath()%>/getDomainJsonData.do';
            	MaskLoading();
				Ext.Ajax.request({   
					url:url,  
					params:{urlJava:'/business/com.asiainfo.csc.attach.web.FileUpAction',
							action:'checkFileRepeat',
							objNo:objNo,
							type:type,
							submitTag:'<%=user.getUserAccount()%>',
							attName:file.name,
							uid:'<%=user.getUserAccount()%>'
							},
					success:function(response,config){
						MaskOver();
						var json=Ext.JSON.decode(response.responseText);
						var isRepeat = json.isRepeat;
						fileNum++;
						files.push(file.id);
						if(isRepeat=='Y'){
							var msg = '';
							if(hasAttType==true){
								msg = '您已上传附件<font color="red">'+file.name+'</font>,上传该附件将会覆盖附件以及更新附件类型,确定上传?';
							}else{
								msg = '您已上传附件<font color="red">'+file.name+'</font>,上传该附件将会覆盖附件,确定上传?';
							}
							Ext.MessageBox.confirm('操作提示',msg,function(optional){
								if(optional=='yes'){
									checkFileNum();
								}else{
									$('#uploadify').uploadify('cancel',file.id);
									checkFileNum();
								}
							});
						}else{
							checkFileNum();
						}
					},
					failure:function(response,config){
						MaskOver();
						Ext.Msg.alert("提示","获取数据失败");
					}
				});
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

/*test-----------------------------------------------------------------------------------*/
//function checkTest(){
//	var xml = new Array();
//	xml.push("<conds><cond key='aaa' value='1'/></conds>");
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

