<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<html>
	<head>
		<title>用例管理</title>
	</head>
	<body>
	</body>
	<style>
	 .highlight{color:red;}
	 .not-dis {
	display: none;
	}
	 </style>
	<script type="text/javascript">
var copyCaseId = '',clickFlag='';
var caseField="";
var lastInputValue="";
var funIds=new Array();
var subSysIds=new Array();
var sysIds=new Array();
var types=new Array();
var ids=new Array();
var extjsFolderPath='<%=request.getContextPath()%>/extJs';
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
var loadMask = new Ext.LoadMask(top.window.document.body, {
	msg : '页面加载中，请稍后!',
	disabled : false
});
loadMask.show();
var subTaskTag = '';
var normalMac = '';
var TemporaryTag = '';
Ext.regModel('extCommboModel', {
    fields: [
        {type: 'string', name: 'value'},
        {type: 'string', name: 'text'}
    ]
});
function query(){
	clickFlag='query';
	funIds=new Array();
	subSysIds=new Array();
	sysIds=new Array();
	types=new Array();
	ids=new Array();
	var tp = Ext.getCmp('caseTree');  
	var root = tp.getStore().getProxy();  
		root.extraParams.clickFlag = 'query';
	var searchComBox=Ext.getCmp("searchComBox");
	var caseTreeStore= Ext.data.StoreManager.lookup('caseTreeStore');
	//监听事件
	var searchStore= Ext.data.StoreManager.lookup('searchStore');
	ids=searchComBox.getValue();
	var storeMap=searchStore.data.map;
	//console.log(ids);
	for(var index in  ids){
		try{
			var id=ids[index];
			if(storeMap[id]!='undefined'){
				//console.log(storeMap[id]);
				funIds.push(storeMap[id].raw.funId);
				subSysIds.push(storeMap[id].raw.subSysId);
				sysIds.push(storeMap[id].raw.sysId);
				types.push(storeMap[id].raw.type);
			}
		}catch(e){
			//console.log(e);
		}
	}
	if(ids==null||ids.length==0){
		clickFlag='click';
		caseTreeStore.load({params:{flag:'sysFolder',clickFlag:clickFlag,caseField: caseField,funIds:funIds,subSysIds:subSysIds,sysIds:sysIds,types:types}});
	}else{
		caseTreeStore.load({params:{flag:'sysFolder',clickFlag:clickFlag,caseField: caseField,funIds:funIds,subSysIds:subSysIds,sysIds:sysIds,types:types}});
		
	}
}
function removeHTMLTag(str) {
    str = str.replace(/<\/?[^>]*>/g,''); //去除HTML tag
    str = str.replace(/[ | ]*\n/g,'\n'); //去除行尾空白
    //str = str.replace(/\n[\s| | ]*\r/g,'\n'); //去除多余空行
    str=str.replace(/&nbsp;/ig,'');//去掉&nbsp;
    return str;
}
/******刷新序号******/
function refreshNum(){
caseGrid.getView().refresh();
}
Ext.MessageBox.buttonText = {
		yes:'是',
		ok:'好的',
		no:'否',
		cancle:'取消'
};
/*****右击*******/
function rightClickTargetFn(view,record,item,index,e,eOpts){   
	 	e.preventDefault();   
	 	var treeNode=Ext.getCmp('caseTree').getSelectionModel().getSelection();
        if(treeNode.length==0){
        	Ext.Msg.alert('提示','请选择用例');
         	return;
        }
        if(treeNode[0].raw.type!='funFolder'&&treeNode[0].raw.type!='case')
        	return;
        if(treeNode[0].raw.leaf==false){
         	Ext.getCmp('addManualCase').setVisible(false);
         	Ext.getCmp('addTestCase').setVisible(true);
         	//Ext.getCmp('editManualCase').setVisible(false);
         	//Ext.getCmp('editTestCase').setVisible(false);
         	Ext.getCmp('delCase').setVisible(false);
         	Ext.getCmp('pasteCase').setVisible(true);
         	Ext.getCmp('copyCase').setVisible(false);
         	Ext.getCmp('createFolder').setVisible(false);
         	Ext.getCmp('editFolder').setVisible(false);
         	Ext.getCmp('deleteFolder').setVisible(false);
        }else if(treeNode[0].raw.leaf==true){
        	Ext.getCmp('createFolder').setVisible(false);
         	Ext.getCmp('editFolder').setVisible(false);
         	Ext.getCmp('deleteFolder').setVisible(false);
        	Ext.getCmp('addManualCase').setVisible(false);
        	Ext.getCmp('addTestCase').setVisible(false);
         	//Ext.getCmp('editTestCase').setVisible(false);
         	//Ext.getCmp('editManualCase').setVisible(false);
       		//Ext.getCmp('editTestCase').setVisible(false);
        	//Ext.getCmp('editManualCase').setVisible(false);
       		//Ext.getCmp('editTestCase').setVisible(false);
        	//Ext.getCmp('editManualCase').setVisible(false);
         	Ext.getCmp('delCase').setVisible(false);
         	Ext.getCmp('pasteCase').setVisible(false);
         	Ext.getCmp('copyCase').setVisible(true);
        }else{
        	Ext.Msg.alert('提示','未能获取点击树节点信息');
        	return;
        }
		rightTargetReportMenu.showAt(e.getXY());
	}

var rightTargetReportMenu = new Ext.menu.Menu({
    items: [
    /*
    	{
    	id:'editTestCase',
    	icon: extjsFolderPath+'/resources/themes/images/myicons/edit-plus.gif',
        text: '编辑自动化用例',
        handler: function(){
         	var treeNode=Ext.getCmp('caseTree').getSelectionModel().getSelection();
         	if(treeNode.length==0){
         		Ext.Msg.alert('提示','请选择用例');
         		return;
         	}
         	if(treeNode[0].raw.leaf==false){
         		Ext.Msg.alert('提示','请选择用例');
         		return;
         	}
         	console.log(treeNode);
        	var editWin = new top.Ext.window.Window({
			    id:'editWin',
			    title : '编辑用例',
			    width : '98%',
			    height : '100%',
			    modal : true,
			    listeners:{
					destroy:function(window,eOpts){
						//var caseGrid = Ext.getCmp('caseGrid');
						gridStore.reload({params:{caseId:treeNode[0].raw.id}});
						 //$.getJSON("<%=request.getContextPath()%>/manageCaseDetail.do",{caseId: treeNode[0].raw.id}, function(data){
						//		gridStore.removeAll();
						//		for( var i=0,n=data.length;i<n;i++){
			  			//			gridStore.add(data[i]);
						//		}
						//		}); 
					}
			    },
			    closeAction : 'destroy',
			    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/userCase/comp.jsp?caseId='+treeNode[0].raw.id+'&parentId=" width="100%" height="100%"/>'
		   });
		   editWin.show();
        }
        },{
    	id:'editManualCase',
    	icon: extjsFolderPath+'/resources/themes/images/myicons/edit-plus.gif',
        text: '编辑手工用例',
        handler: function(){
         	var treeNode=Ext.getCmp('caseTree').getSelectionModel().getSelection();
         	if(treeNode.length==0){
         		Ext.Msg.alert('提示','请选择用例');
         		return;
         	}
         	if(treeNode[0].raw.leaf==false){
         		Ext.Msg.alert('提示','请选择用例');
         		return;
         	}
        	var editWin = new top.Ext.window.Window({
			    id:'editWin',
			    title : '编辑用例',
			    width : 950,
			    height : 600,
			    modal : true,
			    listeners:{
					destroy:function(window,eOpts){
						
					}
			    },
			    closeAction : 'destroy',
			    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/manualTask/manualTask.jsp?caseId='+treeNode[0].raw.id+'&parentId=" width="950" height="600"/>'
		   });
		   editWin.show();
        }
        },
        */{
        	id:'addTestCase',
        	icon:'<%=request.getContextPath()%>/aiga/userCase/image/add.gif',
        	text:'新增用例',
        	handler:function(){
        		var treeNode=Ext.getCmp('caseTree').getSelectionModel().getSelection();
	         	if(treeNode.length==0){
	         		Ext.Msg.alert('提示','请选择用例树节点');
	         		return;
	         	}
	         	if(treeNode[0].raw.leaf==true){
	         		Ext.Msg.alert('提示','请选择用例树非叶子节点');
	         		return;
	         	}
	         	/*
	         	var addWin = new Ext.window.Window({
				    id:'addWin',
				    title : '新增用例',
				    width : '98%',
				    height : '100%',
				    modal : true,
				    listeners:{
						destroy:function(window,eOpts){
							var parentId = treeNode[0].raw.id; 
		                	var node =Ext.data.StoreManager.lookup('caseTreeStore').getNodeById(parentId);   
   							Ext.data.StoreManager.lookup('caseTreeStore').load({node:node});
						}
				    },
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="comp.jsp?caseId=&parentId='+treeNode[0].raw.id+'" width="100%" height="100%"/>'
		   		});
		   		addWin.show();
		   		*/
		   		$("#contentFrame").attr('src','comp.jsp?caseId=&parentId='+treeNode[0].raw.id);
        	}
        },
        {
        	id:'addManualCase',
        	icon:'<%=request.getContextPath()%>/aiga/userCase/image/add.gif',
        	text:'新增手工用例',
        	handler:function(){
        		var treeNode=Ext.getCmp('caseTree').getSelectionModel().getSelection();
	         	if(treeNode.length==0){
	         		Ext.Msg.alert('提示','请选择用例树节点');
	         		return;
	         	}
	         	if(treeNode[0].raw.leaf==true){
	         		Ext.Msg.alert('提示','请选择用例树非叶子节点');
	         		return;
	         	}
	         	/*
	         	var addWin = new top.Ext.window.Window({
				    id:'addWin',
				    title : '新增用例',
				    width : 950,
				    height : 600,
				    modal : true,
				    listeners:{
						destroy:function(window,eOpts){
							var parentId = treeNode[0].raw.id; 
		                	var node =Ext.data.StoreManager.lookup('caseTreeStore').getNodeById(parentId);   
   							Ext.data.StoreManager.lookup('caseTreeStore').load({node:node});
						}
				    },
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="../manualTask/manualTask.jsp?caseId=&parentId='+treeNode[0].raw.id+'" width="950" height="600"/>'
		   		});
		   		addWin.show();
		   		*/
		   		$("#contentFrame").attr('src','<%=request.getContextPath()%>/aiga/manualTask/manualTask.jsp?caseId=&parentId='+treeNode[0].raw.id);
        	}
        },{
        	id:'delCase',
        	icon:'<%=request.getContextPath()%>/aiga/userCase/image/del.gif',
        	text:'删除用例',
        	handler:function(){
        		var treeNode=Ext.getCmp('caseTree').getSelectionModel().getSelection();
        		if(treeNode.length==0){
	         		Ext.Msg.alert('提示','请选择用例树节点');
	         		return;
	         	}
	         	if(treeNode[0].raw.leaf==false){
	         		Ext.Msg.alert('提示','请选择用例树叶子节点');
	         		return;
	         	}
        		var caseid = treeNode[0].raw.id;
        		Ext.Msg.show({
				     title:'删除用例',
				     msg: '确定要删除该用例?',
				     buttons:Ext.Msg.YESNO,
				     icon: Ext.Msg.QUESTION,
				     fn: function(btn){
				     	if(btn=='yes'){
				     		MaskLoading();
				     		Ext.Ajax.request({   
								url:"<%=request.getContextPath()%>/deleteCase.do?caseId="+caseid,  
								success:function(response,config){ 
									MaskOver();
									Ext.Msg.alert('提示',"删除成功");
									var parentId = treeNode[0].raw.parentId; 
				                	var node =Ext.data.StoreManager.lookup('caseTreeStore').getNodeById(parentId);   
		   							Ext.data.StoreManager.lookup('caseTreeStore').load({node:node});
								},
								failure:function(response,config){
									MaskOver();
									Ext.Msg.alert('提示',"删除失败");
								}
							});
				     	}
				     }
				});
        	}
        },{
        	id:'copyCase',
        	text:'复制用例',
        	handler:function(){
        		var treeNode = Ext.getCmp('caseTree').getSelectionModel().getSelection();
        		if(treeNode.length==0){
	         		Ext.Msg.alert('提示','请选择用例树节点');
	         		return;
	         	}
	         	if(treeNode[0].raw.leaf==false){
	         		Ext.Msg.alert('提示','请选择用例树叶子节点');
	         		return;
	         	}
        		copyCaseId = treeNode[0].raw.id;
        	}
        },{
        	id:'pasteCase',
        	text:'粘贴用例',
        	handler:function(){
        		var treeNode = Ext.getCmp('caseTree').getSelectionModel().getSelection();
        		if(treeNode.length==0){
	         		Ext.Msg.alert('提示','请选择用例树节点');
	         		return;
	         	}
	         	if(treeNode[0].raw.leaf==true){
	         		Ext.Msg.alert('提示','请选择用例树目录节点');
	         		return;
	         	}
	         	if(copyCaseId==''){
	         		Ext.Msg.alert('操作','请选择要复制的用例');
	         		return;
	         	}
	         	var folderId = treeNode[0].raw.id;
	         	/*命名窗口*/
	         	Ext.Msg.prompt('粘贴', '用例名称', function(btn, text){
				    if (btn == 'ok'){
				        /*请求ajax复制用例*/
		         		if(text==''){
		         			Ext.Msg.alert('提示','请填写用例名称');
		         			return;
		         		}
				        MaskLoading();
		         		Ext.Ajax.request({  
							url:"<%=request.getContextPath()%>/pasteCase.do?parentId="+folderId+"&name="+text+"&caseId="+copyCaseId,  
							success:function(response,config){ 
								MaskOver();
									/*刷新树*/
						         	var node =Ext.data.StoreManager.lookup('caseTreeStore').getNodeById(folderId);   
							   		Ext.data.StoreManager.lookup('caseTreeStore').load({node:node});
							},
							failure:function(response,config){
								MaskOver();
								Ext.Msg.alert('提示','保存要素与用例关联失败');
							}
						});
					}
				});
        	}
        },{
        	id:'createFolder',
        	text:'创建目录',
        	handler:function(){
        		var treeNode = Ext.getCmp('caseTree').getSelectionModel().getSelection();
        		if(treeNode.length==0){
	         		Ext.Msg.alert('提示','请选择用例树节点');
	         		return;
	         	}
	         	if(treeNode[0].raw.leaf==true){
	         		Ext.Msg.alert('提示','请选择用例树目录节点');
	         		return;
	         	}
	         	Ext.Msg.prompt('创建目录', '目录名称', function(btn, text){
				    if (btn == 'ok'){
						var folderName = text;
						if(folderName==null||folderName=='')
							return;
						$.getJSON("<%=request.getContextPath()%>/saveCaseFolder.do",{folderName:folderName,caseId:treeNode[0].raw.id},function(data){
							var parentId = treeNode[0].raw.id; 
			                var node =Ext.data.StoreManager.lookup('caseTreeStore').getNodeById(parentId);   
	   						Ext.data.StoreManager.lookup('caseTreeStore').load({node:node});
						});
				    }
				});
        	}
        },{
        	id:'editFolder',
        	text:'编辑目录',
        	handler:function(){
        		var treeNode = Ext.getCmp('caseTree').getSelectionModel().getSelection();
        		if(treeNode.length==0){
	         		Ext.Msg.alert('提示','请选择用例树节点');
	         		return;
	         	}
	         	if(treeNode[0].raw.leaf==true){
	         		Ext.Msg.alert('提示','请选择用例树目录节点');
	         		return;
	         	}
	         	Ext.Msg.prompt('编辑目录', '目录名称', function(btn, text){
				    if (btn == 'ok'){
				    	var folderName = text;
						if(folderName==null||folderName=='')
							return;
						$.getJSON("<%=request.getContextPath()%>/editCaseFolder.do",{folderName:folderName,caseId:treeNode[0].raw.id},function(data){
							var parentId = treeNode[0].raw.parentId;
			                var node =Ext.data.StoreManager.lookup('caseTreeStore').getNodeById(parentId);   
	   						Ext.data.StoreManager.lookup('caseTreeStore').load({node:node});
						});
				    }
				},undefined,undefined,treeNode[0].raw.text);
        	}
        },{
        	id:'deleteFolder',
        	text:'删除目录',
        	handler:function(){
        		var treeNode=Ext.getCmp('caseTree').getSelectionModel().getSelection();
    			if(treeNode[0].hasChildNodes()==true){
    				Ext.Msg.alert('提示','该目录并不为空，不可删除');
					return;
    			}
				if(treeNode.length==0){
					Ext.Msg.alert('提示','请选择用例树节点');
					return;
				}
				if(treeNode[0].raw.leaf==true){
					Ext.Msg.alert('提示','请选择用例树非叶子节点');
					return;
				}
				var folderName = treeNode[0].raw.text;	
    			$.getJSON("<%=request.getContextPath()%>/deleteCaseFolder.do",{folderName:folderName,caseId:treeNode[0].raw.id},function(data){
					var parentId = treeNode[0].raw.parentId; 
			        var node =Ext.data.StoreManager.lookup('caseTreeStore').getNodeById(parentId);   
	   				Ext.data.StoreManager.lookup('caseTreeStore').load({node:node});
				});
        	}
        }]
});

Ext.onReady(function() {
	
setInterval("hideXMask()",1000);
Ext.QuickTips.init();
//tooltip初始化
Ext.tip.QuickTipManager.init();
var searchField = Ext.create('Ext.data.Store', {
    fields: ['abbr', 'name'],
    data : [
        {"abbr":"funFolderName", "name":"功能点名"}
        ,{"abbr":"subSysFolderName", "name":"子系统名"}
		,{"abbr":"systemFolderName", "name":"系统名"}
    ]
});
	var caseFieldCombox = new Ext.form.ComboBox({
		width: 80,
	  	store: searchField,
    	queryMode: 'local',
    	id:'caseFieldCombox',
    	displayField: 'name',
    	valueField: 'abbr',
    	value:"funFolderName",
		 listeners:{
			 select:function( combo, records, eOpts ){
				 var combox=Ext.getCmp("searchComBox");
				 combox.displayField="funFolderName";
			 }
         }
		});
var compModel = Ext.regModel("compModel",{
	fields:[
		{name:'compId',type:'string'},
		{name:'compName',type:'string',mapping:'compName'},
		{name:'compDesc',type:'string',mapping:'compDesc'},
		{name:'expectVal',type:'string',mapping:'expectVal'},
		{name:'inVal',type:'string',mapping:'inVal'},
		{name:'tag',type:'string'},
		{name:'url',type:'string'},
		{name:'html',type:'string'},
		{name:'createTime',type:'string'}
		
		]
});
gridStore = Ext.create('Ext.data.Store', {
	storeId:'caseStore',
  	model: compModel,
    proxy: {
    	url : '<%=request.getContextPath()%>/manageCaseDetail.do',
        type: 'ajax',
        reader: {
            type: 'json',
            root: 'data'
        }
    }
});
gridStore.load({params:{caseId:0}});
	caseGrid = Ext.create('Ext.grid.Panel',{
		id:'caseGrid',
		title:'组件',
        margins : '0 0 0 3',
        cls: 'ui-formPanel',
        minHeight:500,
        minWidth: 1200-260,
        height:screenHeight,
        width:screenWidth*0.8,
       //tbar:tbar,
        whith:screenWidth,
		forctFit:true,
        stripeRows:true,//斑马线效果   
        loadMask:true, 
		listeners:{
			itemdblclick :function(grid,record,option){
			}
		//itemcontextmenu :rightClickTargetFn
		},
		/**
		**编辑插件
		**/
		plugins:[
			Ext.create('Ext.grid.plugin.CellEditing', {
            clicksToEdit: 2
        })],
		store:Ext.data.StoreManager.lookup('caseStore'),
		selType:'rowmodel',
		columns:[new Ext.grid.RowNumberer(),
					{header: "组件名", width:100, sortable: true, dataIndex: 'compName',renderer: function (value, meta, record) {
					var author = record.raw.author;
					var tag = record.raw.tag;
					var defaultVal = record.raw.defaultVal;
					var selector = new String(record.raw.selector);
					if(selector!=null&&selector.length!=0)
						selector = selector.substr(selector.indexOf('@')+1,selector.length-selector.indexOf('@')-4);
					else
						selector = "";
					var compDesc = record.raw.compDesc;
					var tip = "组件作者:"+author+"<br>组件类型:"+tag+"<br>参考值:"+defaultVal+"<br>关键元素:"+selector.toString()+"<br>组件描述:"+compDesc+"<br>";
                    meta.tdAttr = 'data-qtip="' + tip + '"';
                    return value;
				}},
        		{header: "输入值", width:100,sortable: true, dataIndex: 'inVal'},
        		{header: "预期值", width:100, sortable: true, dataIndex: 'expectVal'},
        		{header: "备注", width:100, sortable: true, dataIndex: 'compDesc'}
        		]
	});
	
	var manualModel = Ext.regModel("manualModel",{
	fields:[
		{name:'taskId',type:'string'},
		{name:'taskName',type:'string'},
		{name:'taskDesc',type:'string'},
		{name:'createTime',type:'string'},
		{name:'updateTime',type:'string'},
		{name:'preResult',type:'string'},
		{name:'preTestData',type:'string'},
		{name:'caseId',type:'string'},
		{name:'describe',type:'string'},
		{name:'actualResult',type:'string'},
		{name:'taskOrder',type:'string'}
		]
	});
	manualStore = Ext.create('Ext.data.Store', {
		storeId:'manualStore',
	  	model: manualModel,
	    proxy: {
	    	url : '<%=request.getContextPath()%>/getManualTask.do',
	        type: 'ajax',
	        reader: {
	            type: 'json',
	            root: 'data'
	        }
	    }
	});
	manualStore.load({params:{caseId:0}});
	
	manualGrid = Ext.create('Ext.grid.Panel',{
		id:'manualGrid',
		title:'测试步骤',
        margins : '0 0 0 3',
        cls: 'ui-formPanel',
        height:screenHeight,
        width:screenWidth*0.8,
       //tbar:tbar,
        whith:screenWidth,
		forctFit:true,
        stripeRows:true,//斑马线效果   
        loadMask:true, 
		store:manualStore,
		selType:'rowmodel',
		columns:[new Ext.grid.RowNumberer(),
				{header: "步骤ID", width:100, sortable: true, dataIndex: 'taskId',hidden:true},
				{header: "步骤名称", width:200, sortable: true, dataIndex: 'taskName',field: {xtype: 'textareafield',allowBlank: false,height:60}},
        		{header: "测试操作步骤", width:300,sortable: true, dataIndex: 'taskDesc',field: {xtype: 'textareafield',allowBlank: false,height:60}},
        		{header: "预期", width:300, sortable: true, dataIndex: 'preResult', field: {xtype: 'textareafield',allowBlank: false,height:60}},
        		{header: "测试数据准备", width:300, sortable: true, dataIndex: 'preTestData', field: {xtype: 'textareafield',allowBlank: false,height:60}},
        		{header: "步骤描述", width:300, sortable: true, dataIndex: 'describe', field: {xtype: 'textareafield',allowBlank: false,height:60}},
        		{header: "实际结果", width:100, sortable: true, dataIndex: 'actualResult',hidden:true}
        		]
	});

	/*******搜索框*****/
		Ext.regModel('searchModel', {
	    fields: [
	        {type: 'string',name:'name'},
	        {type: 'string',name:'id'},
	        {type: 'string',name:'type'},
	        {type: 'string',name:'parentId'},
	        {type: 'string',name:'funId'},
	        {type: 'string',name:'subSysId'},
	        {type: 'string',name:'sysId'},
	        {type: 'string',name:'remark'}
	    ]
	});
	    searchStore = Ext.create('Ext.data.Store', {
			storeId:'searchStore',
			model:"searchModel",
		    proxy: {
		        type: 'ajax',
	        	url : '<%=request.getContextPath()%>/searchCaseAndFolder.do',
		        reader: {
					type:"json",
					root:"data"
		        }
		    }
		});
 
	var searchForm=null;
		searchForm = Ext.widget({
        xtype: 'form',
        layout: 'column',
       // frame: true,
        collapsible: false,
        id: 'searchForm',
        title: '搜索',
        cls: 'ui-formPanel',
        bodyPadding: '5 5 0',
        minWidth: 260,
        minHeight: 100,
       	width: screenWidth*0.2,   
		height: screenHeight*0.2, 
		layout: "hbox", 
        fieldDefaults: {
            msgTarget: 'side',
            labelWidth: 50
        },
        items: [caseFieldCombox,{
        	/**输入comBox配置*****/
            xtype: 'combo',
            id:"searchComBox",
            minChars:10,
            store: searchStore,
            queryCaching :false,
            queryParam : 'kw',
            displayField: 'name',
            valueField:'id',
            typeAhead: true,
            typeAheadDelay : 90800,
            hideLabel: true,
            multiSelect : true,
            hideTrigger:true,
            anchor: '100%',
            listeners:{
            	change:function( _this, newValue, oldValue, eOpts ){
            		if(newValue instanceof Array){
                		var searchBtn=Ext.getCmp('searchBtn');
                		//searchBtn.setVisible(newValue.length>0);
            		}
            		if(newValue==null||newValue=='null'){
            			_this.collapse();
            		}
            		
			},
			focus:function( _this, The, eOpts ){
					_this.focus(true);try{
						if(_this.getValue()!=null&&_this.getValue!='null'&&_this.getValue().length!=0)_this.expand();
					}catch(e){}
			},
           	specialkey:function( _this, e, eOpts ){
           		//console.log(e.getKey());
           		 if (e.getKey() == e.ENTER) {
           			 var queryData={caseField:"",caseValue:""};
					caseField=caseFieldCombox.getValue();
					var searchComBox=Ext.getCmp("searchComBox");
					if(searchComBox.getValue() instanceof Array){
						//alert();
						searchComBox.expand();
						//searchComBox.setValue(lastInputValue);
					}else{
						//searchComBox.expand();
						//lastInputValue=searchComBox.getValue();
						_this.collapse();
						if(caseField!=""&&searchComBox.getValue()!=null&&searchComBox.getValue()!="null"&&searchComBox.getValue()!=""){
						queryData.caseField=caseField;
						queryData.caseValue=searchComBox.getValue();
						var query="{"+caseField+":\""+encodeURI(encodeURI(searchComBox.getValue()))+"\"}";
						searchComBox.doQuery(query, true ); 
                   	//searchStore.load({params:{kw:query}});
                   	}else {
                   		window.query();
                   		return;
                   	}
					}
                    }
           	},
            	beforequery: function( queryEvent,  eOpts ){
            		//console.log(queryEvent);
            		return;
                	var queryData={caseField:"",caseValue:""};
                	var caseField=caseFieldCombox.getValue();
                	var searchComBox=Ext.getCmp("searchComBox");
                	if(caseField!=""&&searchComBox.getValue()!=null&&searchComBox.getValue()!="null"){
                	queryData.caseField=caseField;
                	queryData.caseValue=searchComBox.getValue();
                	queryEvent.query="{"+caseField+":\""+encodeURI(encodeURI(searchComBox.getValue()))+"\"}";
                	}else return;
                	},
            	beforeselect:function( combo, record,index, eOpts ){
            	}
            	},
            listConfig: {
                loadingText: 'Searching...',
                emptyText: '没有搜索到结果',
                itemTpl : Ext.create('Ext.XTemplate','<input type=checkbox>{[values.name]}</input>'),  
                // Custom rendering template for each item
                getInnerTpl: function() {
                    return '{[values.name]}';
                },
           	   listeners:{
		        	itemclick:function(view, record, item, index, e, eOpts ){
		        		 var isSelected = view.isSelected(item);  
		                 var checkboxs = item.getElementsByTagName('input');  
		                  if(checkboxs!=null)  { 
		                	  var checkbox = checkboxs[0];  
		                      if(!isSelected)checkbox.checked = true;
		                      else checkbox.checked = false;  
		                      }  
		                  }
				},
              onItemSelect: function(record) {      
                  var node = this.getNode(record);  
                  if (node) {  
                     Ext.fly(node).addCls(this.selectedItemCls);  
                     var checkboxs = node.getElementsByTagName('input');  
                     if(checkboxs!=null){var checkbox = checkboxs[0]; checkbox.checked = true;}  
                  }  
              }
           }
            //pageSize: 10
        },{xtype:'button',text: '',tooltip:'生成结果树',id:'searchBtn',iconCls: 'search-button',handler: function() {query();}}
        ]
    });

/*****search end *******/
	var caseTreeStore = Ext.create('Ext.data.TreeStore', {  
		id:'caseTreeStore',
		listeners:{
			load:function(){
				//var searchBtn=Ext.getCmp('searchBtn');
        		//searchBtn.setVisible(false);
			}	
		},
		proxy: {
			type: "ajax",
			url: "<%=request.getContextPath()%>/getCaseTreeSyn.do",
			extraParams:{  
				flag:'sysFolder' 
			}
		},
		root: {
			id:'-1',
			text: '用例',
			expanded: true
		},
		reader: { 
			type: 'json', 
			root: 'children' 
		} 
    });
	var caseTree = null;
	caseTree = Ext.create("Ext.tree.Panel", {  
		id :'caseTree',
		minWidth: 260,
		minHeigth: 300,
	    width: screenWidth*0.2,
	    height: screenHeight*0.79 - 10,
        cls: 'ui-formPanel',
	    title : "功能点",   
	    rootVisible : false,
	    useArrows: true,
	    autoScroll:true,
        frame: false,
        flex: 3,
        store: caseTreeStore,
	    viewConfig : {  
	   
	        loadingText : "加载数据..." 
	    },
	  
		listeners : {
			iconclschange:function( Panel , newCls , oldCls ,  eOpts ){
				//alert(newCls);
			},
			itemclick : function(thisView, record, htmlElementItem, indexNo){
			if(record.raw.leaf){
				if(record.raw.type=='funFolder'){
					var subSysId = record.raw.parentId;
					var subNode = caseTreeStore.getNodeById(subSysId);
					$("#contentFrame").attr('src','funPointAnalysis.jsp?funId='+record.raw.id+'&sysId='+subNode.raw.parentId+'&subTaskTag='+subTaskTag+'&normalMac='+encodeURI(encodeURI(normalMac))+'&TemporaryTag='+TemporaryTag);
				}
			}else{
				clickFlag='click';
			}
			
			//else{
			//	var caseId = record.raw.id;
			//	$("#contentFrame").attr('src','comp.jsp?caseId='+caseId+'&parentId=');
			//}
		},
		//itemcontextmenu : rightClickTargetFn,
		beforeitemexpand :function(record,eOpts){  
			//console.log(record);
			if(!record.raw.expanded){
				//手动张开的
				clickFlag='click';
			}else{
				clickFlag='query';
			}
			var tp = Ext.getCmp('caseTree');  
			var root = tp.getStore().getProxy();  
			root.extraParams.funIds = funIds;
			root.extraParams.subSysIds = subSysIds;
			root.extraParams.sysIds = sysIds;
			root.extraParams.types = types;
			root.extraParams.clickFlag = clickFlag;
			//console.log(subSysIds);
			if(record.raw.type=='sysFolder'){
				root.extraParams.flag = 'subSysFolder';
				/**if(caseField=='funFolderName'&&clickFlag=='query'){
				root.extraParams.funIds = parentIds;
				}**/
			}
			if(record.raw.type=='subSysFolder'){
				root.extraParams.flag = 'funFolder';  
				
				//root.extraParams.clickFlag = clickFlag;
				
				/**if(caseField=='funFolderName'&&clickFlag=='query'){
					//console.log(ids);
					root.extraParams.funIds = ids;
				}else if(clickFlag=='query'){
					root.extraParams.funIds = "";
				}	
				**/
			}
		} 
	}
}); 
			
		var leftWidth = 1200 - 260;
		if(leftWidth  < screenWidth * 0.8)
			leftWidth = screenWidth * 0.8;
		Ext.create('Ext.panel.Panel', {
				renderTo : Ext.getBody(),
				minWidth: 1200,
				minHeight: 500,
				width : screenWidth*0.98,
				hieght : screenHeight*0.96,
				border:0,
				listeners:{
					render:function(render,eOpts){
						manualGrid.hide();
						var caseEditForm = Ext.create('Ext.form.Panel',{
					        id: 'caseEditForm',
					        cls: 'ui-formPanel',
					        width: 400,
					        height:350,
					        border:0,
					        listeners:{
					        	render:function(panel,eOpts){
					        		caseEditForm.getForm().findField('TemporaryTag').disable(true);
					        		caseEditForm.getForm().findField('normalMac').disable(true);
					        		caseEditForm.getForm().findField('subTaskTag').enable(true);
					        	}
					        },
					        layout: { 
					               type: 'vbox'
					           }, 
					           fieldDefaults: { 
					               labelAlign: 'right', 
					               labelWidth: 100, 
					               labelStyle: 'font-weight:bold' 
					           },
					        	defaults: { 
					               margins: '15 0 0 0' 
					           }, 
								items: [
								{
						        	xtype: 'fieldcontainer', 
					                labelStyle: 'font-weight:bold;padding:0', 
					                layout: 'hbox', 
					                defaultType: 'textfield', 
					
					                fieldDefaults: { 
					                    labelAlign: 'right' 
					                }, 
						            items: [{
									    	name: 'caseEditType', 
									        xtype: 'combo', 
									        fieldLabel: '修改类型',
									        allowBlank: false,
									        forceSelection: true,
									        emptyText:'请选择修改类型',
									        value : 'subTask',
									        listeners:{
									        	change:function(combo, newValue, oldValue, eOpts ){
									        		if(newValue=='subTask'){
									        			caseEditForm.getForm().findField('TemporaryTag').setValue('');
									        			caseEditForm.getForm().findField('TemporaryTag').disable(true);
									        			caseEditForm.getForm().findField('normalMac').setValue('');
										        		caseEditForm.getForm().findField('normalMac').disable(true);
										        		caseEditForm.getForm().findField('subTaskTag').enable(true);
									        		}
									        		else if(newValue=='temporary'){
									        			caseEditForm.getForm().findField('TemporaryTag').enable(true);
									        			caseEditForm.getForm().findField('normalMac').setValue('');
										        		caseEditForm.getForm().findField('normalMac').disable(true);
										        		caseEditForm.getForm().findField('subTaskTag').setValue('');
										        		caseEditForm.getForm().findField('subTaskTag').disable(true);
									        		}
									        		else if(newValue=='normal'){
									        			caseEditForm.getForm().findField('TemporaryTag').setValue('');
									        			caseEditForm.getForm().findField('TemporaryTag').disable(true);
										        		caseEditForm.getForm().findField('normalMac').enable(true);
										        		caseEditForm.getForm().findField('subTaskTag').setValue('');
										        		caseEditForm.getForm().findField('subTaskTag').disable(true);
									        		}
									        	}
									        },
									        store:Ext.create('Ext.data.Store', {
												fields : ['text','value'],
												data:[{text:'关联子任务',value:'subTask'},{text:'临时任务',value:'temporary'},{text:'常态维护',value:'normal'}]
											}),
								           displayField:'text',
								           valueField:'value',
								           mode:'local'
					            		}
						            ]
								},
								{
						        	xtype: 'fieldcontainer', 
					                labelStyle: 'font-weight:bold;padding:0', 
					                layout: 'hbox', 
					                defaultType: 'textfield', 
					
					                fieldDefaults: { 
					                    labelAlign: 'right' 
					                }, 
						            items: [{
								    	name: 'subTaskTag', 
								        fieldLabel: '测试子任务名称',
								        xtype: 'combo', 
								        forceSelection: true,
								        emptyText:'请选择子任务名称',
								        store:Ext.create('Ext.data.Store', {
								        	autoLoad:true,
											model:"extCommboModel",
											proxy:Ext.create('Ext.data.proxy.Ajax',{
												type:"ajax",
												model:"extCommboModel",
												url:'<%=request.getContextPath()%>/getTestSubTaskParamsForCaseLib.do',
												reader:{
													root:"data",
													type:"json"
												}
											})
										}),
							           displayField:'text',
							           valueField:'value',
							           mode:'remote'
						            }]
						        },
						        {
						        	xtype: 'fieldcontainer', 
					                labelStyle: 'font-weight:bold;padding:0', 
					                layout: 'hbox', 
					                defaultType: 'textfield', 
					
					                fieldDefaults: { 
					                    labelAlign: 'right' 
					                }, 
						            items: [{
						            	xtype:'textfield',
						            	vtype: 'alphanum',
						                name: 'TemporaryTag', 
								        fieldLabel: '临时编号'
						            }]
						        },
						        {
						        	xtype: 'fieldcontainer', 
					                labelStyle: 'font-weight:bold;padding:0', 
					                layout: 'hbox', 
					                defaultType: 'textfield', 
					
					                fieldDefaults: { 
					                    labelAlign: 'right' 
					                }, 
						            items: [{
				            			xtype:'textareafield',
						                name: 'normalMac', 
								        fieldLabel: '常态维护',
								        width:333,
		    							height:100
				 		            }]
						        }
							]
						});
						loadMask.hide();
						var caseEditReasonWin = new Ext.window.Window({
							tbar:[{
								xtype:'button',
								text:'常态维护',
								handler:function(){
									subTaskTag = '';
									normalMac = '无';
									TemporaryTag = '';
									caseEditReasonWin.close();
								}
							},'->',{
								xtype:'button',
								text:'关闭',
								handler:function(){
									window.parent.closeTab();
								}
							},{
							  	xtype: 'button',
								text: '确定',
								handler:function(){
									subTaskTag = '';
									normalMac = '';
									TemporaryTag = '';
									var caseEditType = caseEditForm.getForm().findField('caseEditType').getValue();
									if(caseEditType=='subTask'){
										subTaskTag = caseEditForm.getForm().findField('subTaskTag').getValue();
										if(subTaskTag==null||subTaskTag==''||subTaskTag.length==0){
											Ext.Msg.alert("提示","请选择测试子任务编号");
											return;
										}
									}else if(caseEditType=='temporary'){
										var temporaryTagField = caseEditForm.getForm().findField('TemporaryTag');
										if(!temporaryTagField.isValid()){
											Ext.Msg.alert("提示","临时测试子任务编号只可以<font color=\"red\">包括数字及字母</font>，请正确填写临时测试子任务编号");
											return;
										}
										TemporaryTag = temporaryTagField.getValue();
										if(TemporaryTag==null||TemporaryTag==''||TemporaryTag.length==0){
											Ext.Msg.alert("提示","请填写临时测试子任务编号");
											return;
										}
									}else if(caseEditType=='normal'){
										normalMac = caseEditForm.getForm().findField('normalMac').getValue();
										if(normalMac==null||normalMac==''||normalMac.length==0){
											Ext.Msg.alert("提示","请填写常态维护原因");
											return;
										}
									}
									caseEditReasonWin.close();
								}
							}],
							id:'caseEditReasonWin',
							title:'用例修改',
						    width : 400,
						    height : 350,
						    modal : true,
						    closable:false,
						    resizable:false,
						    closeAction : 'destroy',
						    items:[caseEditForm]
						}).show();
					}
				},
				layout : {
					type : 'hbox',
					align : 'stretch',
					padding : 0
				},
				defaults : {
					split : true,
					collapsible : false,
					bodyStyle : 'padding:0px'
				},
				items : [ {
					region : 'west',
					items : [ searchForm, caseTree ]
				}, {
					region : 'center',
					border:0,
					items : [ {html:'<iframe id="contentFrame" frameBorder="0" scrolling="no" width="'+leftWidth+'" height="'+(screenHeight - 10)+'"></iframe>'} ]
				} ]
			});

		});
	
		function hideXMask() {
			$(".x-mask").each(function() {
				if ($(this).css("visibility") == "hidden") {
					$(this).addClass("not-dis");
				}
			});
		}
		
		function refreshTree(){
			var treeNode=Ext.getCmp('caseTree').getSelectionModel().getSelection();
			var parentId = 0;
			if(treeNode[0].raw.leaf==true)
				parentId = treeNode[0].raw.parentId;
			else
				parentId = treeNode[0].raw.id;
		    var node =Ext.data.StoreManager.lookup('caseTreeStore').getNodeById(parentId);   
   			Ext.data.StoreManager.lookup('caseTreeStore').load({node:node});
		}
	</script>
</html>