<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<%
	String subTaskId = request.getParameter("subTaskId");
	String elemTag = request.getParameter("elemTag");
%>
<html>
<head>
	<title>用例关联</title>
</head>
<body>
</body>
<style>
.highlight{color:red;}
</style>
<script type="text/javascript">
var copyCaseId = '';
var subTaskId = '${param.subTaskId}';
var elemTag = '${param.elemTag}';
var extjsFolderPath='<%=request.getContextPath()%>/extJs';
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
var caseIds = new Array();
caseIds.push(0);
function checkSelect(caseId){
	var isSelect = false;
	for(var i=0;i<caseIds.length;i++){
		if(caseId==caseIds[i]){
			isSelect=true;
			break;
		}
	}
	return isSelect;
}
function deleteSelect(caseId){
	for(var i=0,n=caseIds.length;i<n;i++){
		if(caseIds[i]==caseId)
			caseIds.splice(i,1);
	}
}
function removeHTMLTag(str) {
    str = str.replace(/<\/?[^>]*>/g,''); //去除HTML tag
    str = str.replace(/[ | ]*\n/g,'\n'); //去除行尾空白
    //str = str.replace(/\n[\s| | ]*\r/g,'\n'); //去除多余空行
    str=str.replace(/&nbsp;/ig,'');//去掉&nbsp;
    return str;
}
function checkSelect(caseId){
	var isSelect = false;
	for(var i=0;i<caseIds.length;i++){
		if(caseId==caseIds[i]){
			isSelect=true;
			break;
		}
	}
	return isSelect;
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
         	Ext.getCmp('editManualCase').setVisible(false);
         	Ext.getCmp('editTestCase').setVisible(false);
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
         	Ext.getCmp('editTestCase').setVisible(true);
         	Ext.getCmp('editManualCase').setVisible(false);
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
    	{
    	id:'editTestCase',
    	icon: extjsFolderPath+'/resources/themes/images/myicons/edit-plus.gif',
        text: '编辑用例',
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
         	//console.log(treeNode);
        	var editWin = new top.Ext.window.Window({
			    id:'editWin',
			    title : '编辑用例',
			    width : 1050,
			    height : 600,
			    resizable:false,
			    modal : true,
			    closeAction : 'destroy',
			    listeners:{
					destroy:function(window,eOpts){
						var parentId = treeNode[0].raw.parentId; 
	                	var node =caseTreeStore.getNodeById(parentId);   
  							caseTreeStore.load({node:node});
					}
			    },
			    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/userCase/comp.jsp?caseId='+treeNode[0].raw.id+'&parentId=" width="1055" height="570"/>'
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
         	//console.log(treeNode);
        	var editWin = new top.Ext.window.Window({
			    id:'editWin',
			    title : '编辑用例',
			    width : 1050,
			    height : 600,
			    modal : true,
			    resizable:false,
			    closeAction : 'destroy',
			    listeners:{
					destroy:function(window,eOpts){
						var parentId = treeNode[0].raw.parentId; 
	                	var node =caseTreeStore.getNodeById(parentId);   
  							caseTreeStore.load({node:node});
					}
			    },
			    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/manualTask/manualTask.jsp?caseId='+treeNode[0].raw.id+'&parentId=" width="1055" height="570"/>'
		   });
		   editWin.show();
        }
        },{
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
	         	var addWin = new top.Ext.window.Window({
				    id:'addWin',
				    title : '新增用例',
				    width : 1050,
			   	    height : 600,
				    modal : true,
				    resizable:false,
				    listeners:{
						destroy:function(window,eOpts){
							var parentId = treeNode[0].raw.id; 
		                	var node =caseTreeStore.getNodeById(parentId);   
   							caseTreeStore.load({node:node});
						}
				    },
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/userCase/comp.jsp?caseId=&parentId='+treeNode[0].raw.id+'" width="1055" height="570"/>'
		   		});
		   		addWin.show();
        	}
        },{
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
	         	var addWin = new top.Ext.window.Window({
				    id:'addWin',
				    title : '新增用例',
				    width : 1050,
			   	    height : 600,
				    modal : true,
				    resizable:false,
				    listeners:{
						destroy:function(window,eOpts){
							var parentId = treeNode[0].raw.id; 
		                	var node =caseTreeStore.getNodeById(parentId);   
   							caseTreeStore.load({node:node});
						}
				    },
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/manualTask/manualTask.jsp?caseId=&parentId='+treeNode[0].raw.id+'" width="1055" height="570"/>'
		   		});
		   		addWin.show();
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
				                	var node =caseTreeStore.getNodeById(parentId);   
		   							caseTreeStore.load({node:node});
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
Ext.QuickTips.init();
//tooltip初始化
Ext.tip.QuickTipManager.init();


	/*******搜索框*****/
		Ext.regModel('searchModel', {
	    fields: [
	        {type: 'string',name:'caseName',mapping:'caseName'},
	        {type: 'string',name:'caseId',mapping:'caseId'}
	    ]
	});
	    searchStore = Ext.create('Ext.data.Store', {
			storeId:'searchStore',
			model:"searchModel",
		    proxy: {
		        type: 'ajax',
	        	url : '<%=request.getContextPath()%>/searchCaseTree.do',
		        reader: {
					type:"json"
		        }
		    }
		});
 
	var searchForm=null;
	searchForm = Ext.widget({
        xtype: 'form',
        layout: 'column',
       // frame: true,
        collapsible: true,
        id: 'searchForm',
        title: '搜索',
        bodyPadding: '30 5 5 200',
       	width: screenWidth*0.8*0.985,   
		height: screenHeight*0.2, 
        fieldDefaults: {
            msgTarget: 'side',
            labelWidth: 50,
            width:400
        },
        items: [{
        	/**输入comBox配置*****/
            xtype: 'combo',
            id:"searchComBox",
            minChars:1,
            store: searchStore,
            queryCaching :true,
            queryParam : 'kw',
            displayField: 'caseName',
            typeAhead: true,
            typeAheadDelay : 800,
            hideLabel: true,
            hideTrigger:true,
            anchor: '100%',
            listeners:{
            	select: function(comp, The, eOpts){
            		$.getJSON("<%=request.getContextPath()%>/reproductionTree.do?isMutilSelect=true",{caseId : The[0].raw.caseId},function(data){
            			var caseTree=Ext.getCmp("caseTree");
            			caseTree.setRootNode(data.data.root);
            		});
            		comp.setValue(removeHTMLTag(The[0].raw.caseName));
					return;  
            	},
            	change:function(combo,newValue,oldValue,eOpts ){
            		if(newValue==''){
            			Ext.data.StoreManager.lookup('caseTreeStore').load();
            			return;
            		}
            	}
            },
            listConfig: {
                loadingText: 'Searching...',
                emptyText: '没有搜索到结果',
                // Custom rendering template for each item
                getInnerTpl: function() {
                    return '{[values.caseName]}';
                }
            }
            //pageSize: 10
        },{
            margin:'0 0 0 50',
            html : '<a href="searchCase.jsp?elemTag='+elemTag+'"'+'>详细搜索</a>',
                }]
    });

/*****search end *******/
	caseTreeStore = Ext.create('Ext.data.TreeStore', {  
		id:'caseTreeStore',
		proxy: {
			type: "ajax",
			url: "<%=request.getContextPath()%>/getCaseTreeSyn.do?isMutiSelect=true&type=manage",
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
	    width: screenWidth*0.2*0.99,   
	    height: screenHeight*0.98,   
	    title : "用例树",   
	    rootVisible : true,
	    ines:true,
	    useArrows: true,
	    autoScroll:true,
        frame: false,
        flex: 3,
        store: caseTreeStore,
	    viewConfig : {  
	        loadingText : "加载数据..."
	    },
		listeners : {
		itemcontextmenu : rightClickTargetFn,
		checkchange : function(node,checked,eOpts){
			if(checked==true){
				if(checkSelect(node.raw.id)==false)
					caseIds.push(node.raw.id);
			}else{
				if(checkSelect(node.raw.id)==true)
					caseIds.pop(node.raw.id);
			}
			gridStore.reload({params:{caseIds:caseIds.join(",")}});
		},
		itemexpand : function(p,eOpts){
			for(var i=0,n=caseIds.length;i<n;i++){
				var caseTreeStore = Ext.data.StoreManager.lookup('caseTreeStore');
				var selectNode = caseTreeStore.getNodeById(caseIds[i]);
	            if(typeof selectNode != 'undefined')
	            	selectNode.set('checked',true);
			}
		},
		beforeitemexpand:function(record,eOpts){  
			var tp = Ext.getCmp('caseTree');  
			var root = tp.getStore().getProxy();  
			if(record.raw.type=='sysFolder')
				root.extraParams.flag = 'funFolder';  
			if(record.raw.type=='funFolder')
				root.extraParams.flag = 'case';  
		}  
		   
	}
});
	var caseModel = Ext.regModel("compModel",{
	fields:[
		{name:'caseId',type:'string'},
		{name:'caseName',type:'string'},
		{name:'parentId',type:'string'},
		{name:'caseDesc',type:'string'},
		{name:'createTime',type:'string'},
		{name:'updateTime',type:'string'},
		{name:'author',type:'string'},
		{name:'latestOperator',type:'string'},
		{name:'elemId',type:'string'}
		]
	});
	gridStore = Ext.create('Ext.data.Store', {
		storeId:'caseStore',
	  	model: caseModel,
	    proxy: {
	    	url : '<%=request.getContextPath()%>/getCaseTableByCaseIds.do',
	        type: 'ajax',
	        reader: {
	            type: 'json',
	            root: 'data'
	        }
	    }
	});
	MaskLoading();
	Ext.Ajax.request({  
		url:"<%=request.getContextPath()%>/getRElemCase.do?elemTag="+elemTag,  
		success:function(response,config){
			MaskOver();
			var caseIdJson = Ext.JSON.decode(response.responseText);
			var caseId = caseIdJson.caseIds;
			caseIds = caseId.split(",");
			gridStore.load({params:{caseIds:caseIds.join(",")}});
		},
		failure:function(response,config){ 
			MaskOver();
			Ext.Msg.alert('提示','获取数据失败');
			return;
		}
	});
	var caseGrid = Ext.create('Ext.grid.Panel',{
		id:'caseGrid',
		title:'选择用例',
        margins : '0 0 0 3',
        height:screenHeight*0.8,
        width:screenWidth*0.8*0.985,
       //tbar:tbar,
        whith:screenWidth,
        autoScroll : true,
		forctFit:true,
        stripeRows:true,//斑马线效果   
        loadMask:true,
		listeners:{
			itemdblclick:function(grid,record,item,index,e,eOpts){
				var url = '<%=request.getContextPath()%>/aiga/userCase/comp.jsp?caseId='+record.raw.caseId+'&parentId=';
	        	var editWin = new top.Ext.window.Window({
				    id:'editWin',
				    title : '编辑用例',
				    width : 1050,
			   	    height : 600,
				    resizable:false,
				    modal : true,
				    constrain:true,
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="'+url+'" width="1055" height="570"/>'
			   });
			   editWin.show();
			}
		},
		store:Ext.data.StoreManager.lookup('caseStore'),
		selType:'rowmodel',
		columnLines: true, 
		columns:[new Ext.grid.RowNumberer(),
				{header: "用例ID", width:100, sortable: true, dataIndex: 'caseId',hidden:true},
				{header: "用例名称", width:100, sortable: true, dataIndex: 'caseName'},
				{header: "父ID", width:100, sortable: true, dataIndex: 'parentId',hidden:true},
				{header: "用例描述", width:100, sortable: true, dataIndex: 'caseDesc'},
        		{header: "创建时间", width:100,sortable: true, dataIndex: 'createTime'},
        		{header: "修改时间", width:100, sortable: true, dataIndex: 'updateTime'},
        		{header: "作者", width:100, sortable: true, dataIndex: 'author'},
        		{header: "最后修改人", width:100, sortable: true, dataIndex: 'latestOperator'},
        		{header: "要素ID", width:100, sortable: true, dataIndex: 'elemId',hidden:true},
        		{header: "操作", width:50,menuDisabled: true,xtype:'actioncolumn',sortable:false,items: [{
        				icon:"<%=request.getContextPath()%>/aiga/label/image/del.gif",
        				id:'delVal',
        				tooltip:'删除',
        				handler:function(grid, rowIndex, colIndex){
        					var selectCase = caseGrid.getStore().getAt(rowIndex);
		                    if(checkSelect(selectCase.raw.caseId)==true){
			                    deleteSelect(selectCase.raw.caseId);
			                    var caseTreeStore = Ext.data.StoreManager.lookup('caseTreeStore');
			                    var selectNode = caseTreeStore.getNodeById(selectCase.raw.caseId);
			                    if(typeof selectNode != 'undefined')
			                    	selectNode.set('checked',false);
		                    }
		                    if(elemTag==''){
		                		Ext.Msg.alert('提示','未找到测试元素tag');
		                		return;
		                	}
		                    gridStore.reload({params:{caseIds:caseIds.join(",")}});
		        		}
		        	}]
		        }
        ],
        dockedItems: [{ 
            dock: 'top',
            xtype: 'toolbar',  
            items: [{ 
                id: 'save',
                text:'保存',
                tooltip:'保存要素与用例关联',
                icon:'<%=request.getContextPath()%>/aiga/userCase/image/add.gif',
                handler:function(){
                	if(elemTag==''){
                		Ext.Msg.alert('提示','未找到测试元素tag');
                		return;
                	}
                	MaskLoading();
                    Ext.Ajax.request({  
						url:"<%=request.getContextPath()%>/saveRElemCase.do?elemTag="+elemTag+"&caseIds="+caseIds.join(','),  
						success:function(response,config){
							MaskOver();
						},
						failure:function(response,config){
							MaskOver();
							Ext.Msg.alert('提示','保存要素与用例关联失败');
						}
					});
                } 
            }] 
		}] 
	}); 

	Ext.create('Ext.form.Panel', {
			renderTo : Ext.getBody(),
			width : screenWidth,
			height : screenHeight * 0.99,
			layout : 'border',
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
				items : [caseTree]
			}, {
				region : 'center',
				items : [searchForm,caseGrid]
			} ]
		});
	});
	</script>
</html>