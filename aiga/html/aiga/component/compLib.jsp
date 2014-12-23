<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<html>
<head>
	<title>组件库</title>
</head>
<body>
</body>
<script type="text/javascript">
var extjsFolderPath='<%=request.getContextPath()%>/extJs';
function rightClickTargetFn(view,record,item,index,e,eOpts){   
	 e.preventDefault();   
	 var treeNode=Ext.getCmp('compTree').getSelectionModel().getSelection();
     if(treeNode.length==0){
       	Ext.Msg.alert('提示','请选择组件');
       	return;
     }
     if(treeNode[0].raw.leaf==false){
     	Ext.getCmp('addComp').setVisible(true);
		Ext.getCmp('editComp').setVisible(false);
		Ext.getCmp('addFolder').setVisible(true);
		Ext.getCmp('delFolder').setVisible(true);
		Ext.getCmp('editFolder').setVisible(true);
	 }else if(treeNode[0].raw.leaf==true){
		Ext.getCmp('addComp').setVisible(false);
		Ext.getCmp('editComp').setVisible(true);
		Ext.getCmp('addFolder').setVisible(false);
		Ext.getCmp('delFolder').setVisible(false);
		Ext.getCmp('editFolder').setVisible(false);
	 }else{
		Ext.Msg.alert('提示','未能获取点击树节点信息');
		return;
	 }
	 rightTargetReportMenu.showAt(e.getXY());
}
var rightTargetReportMenu = new Ext.menu.Menu({
    items: [{
    		id:'addFolder',
    		icon: '<%=request.getContextPath()%>/aiga/userCase/image/add.gif',
    		text:'新增目录',
    		handler:function(){
    			var treeNode=Ext.getCmp('compTree').getSelectionModel().getSelection();
	         	if(treeNode.length==0){
	         		Ext.Msg.alert('提示','请选择组件树节点');
	         		return;
	         	}
	         	if(treeNode[0].raw.leaf==true){
	         		Ext.Msg.alert('提示','请选择组件树非叶子节点');
	         		return;
	         	}
	         	Ext.Msg.prompt('新增目录', '目录名称', function(btn, text){
				    if (btn == 'ok'){
				    	var treeNode=Ext.getCmp('compTree').getSelectionModel().getSelection();
						var folderName = text;
						if(folderName==null||folderName=='')
							return;
						$.getJSON("<%=request.getContextPath()%>/saveCompFolder.do",{folderName:folderName,compId:treeNode[0].raw.id},function(data){
							var parentId = treeNode[0].raw.id; 
			                var node =Ext.data.StoreManager.lookup('compTreeStore').getNodeById(parentId);   
	   						Ext.data.StoreManager.lookup('compTreeStore').load({node:node});
						});
				    }
				});
    		}
    	},{
    		id:'delFolder',
    		text:'删除目录',
    		handler:function(){
    			var treeNode=Ext.getCmp('compTree').getSelectionModel().getSelection();
    			if(treeNode[0].hasChildNodes()==true){
    				Ext.Msg.alert('提示','该目录并不为空，不可删除');
					return;
    			}
				if(treeNode.length==0){
					Ext.Msg.alert('提示','请选择组件树节点');
					return;
				}
				if(treeNode[0].raw.leaf==true){
					Ext.Msg.alert('提示','请选择组件树非叶子节点');
					return;
				}
				var folderName = treeNode[0].raw.text;	
    			$.getJSON("<%=request.getContextPath()%>/deleteCompFolder.do",{folderName:folderName,compId:treeNode[0].raw.id},function(data){
					var parentId = treeNode[0].raw.parentId; 
			        var node =Ext.data.StoreManager.lookup('compTreeStore').getNodeById(parentId);   
	   				Ext.data.StoreManager.lookup('compTreeStore').load({node:node});
				});
    		}
    	},{
    		id:'editFolder',
    		text:'编辑目录',
    		handler:function(){
    			var treeNode=Ext.getCmp('compTree').getSelectionModel().getSelection();
			 	if(treeNode.length==0){
					Ext.Msg.alert('提示','请选择组件树节点');
				    return;
				}
				if(treeNode[0].raw.leaf==true){
					Ext.Msg.alert('提示','请选择组件树非叶子节点');
					return;
				}
    			Ext.Msg.prompt('编辑目录', '目录名称', function(btn, text){
    				if (btn == 'ok'){
						var folderName = text;
						if(folderName==null||folderName=='')
							return;
						$.getJSON("<%=request.getContextPath()%>/editCompFolder.do",{folderName:folderName,compId:treeNode[0].raw.id},function(data){
							var parentId = treeNode[0].raw.parentId;
			                var node =Ext.data.StoreManager.lookup('compTreeStore').getNodeById(parentId);   
	   						Ext.data.StoreManager.lookup('compTreeStore').load({node:node});
						});
				    }
				},undefined,undefined,treeNode[0].raw.text);
    		}
    	},{
	    	id:'editComp',
	    	icon: extjsFolderPath+'/resources/themes/images/myicons/edit-plus.gif',
	        text: '编辑组件',
	        handler: function(){
	        	var treeNode=Ext.getCmp('compTree').getSelectionModel().getSelection();
	         	if(treeNode.length==0){
	         		Ext.Msg.alert('提示','请选择组件');
	         		return;
	         	}
	         	if(treeNode[0].raw.leaf==false){
	         		Ext.Msg.alert('提示','请选择组件');
	         		return;
	         	}
	        	var editWin = new top.Ext.window.Window({
				    id:'editWin',
				    title : '编辑组件',
				    width : '98%',
				    height : '100%',
				    modal : true,
				    listeners:{
						destroy:function(window,eOpts){
							var guiGrid = Ext.getCmp('guiGrid');
							guiGrid.getStore().reload({
								params:{compId:treeNode[0].raw.id}
							});
							var parentId = treeNode[0].raw.parentId; 
		                	var node =Ext.data.StoreManager.lookup('compTreeStore').getNodeById(parentId);   
   							Ext.data.StoreManager.lookup('compTreeStore').load({node:node});
						}
				    },
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/component/gui.jsp?compId='+treeNode[0].raw.id+'&parentId=" width="100%" height="100%"/>'
			   });
			   editWin.show();
        	}
        },{
        	id:'addComp',
        	icon:'<%=request.getContextPath()%>/aiga/userCase/image/add.gif',
        	text:'新增组件',
        	handler:function(){
        		var treeNode=Ext.getCmp('compTree').getSelectionModel().getSelection();
	         	if(treeNode.length==0){
	         		Ext.Msg.alert('提示','请选择组件树节点');
	         		return;
	         	}
	         	if(treeNode[0].raw.leaf==true){
	         		Ext.Msg.alert('提示','请选择组件树非叶子节点');
	         		return;
	         	}
	         	var addWin = new top.Ext.window.Window({
				    id:'addWin',
				    title : '新增组件',
				    width : 1000,
				    height : 650,
				    modal : true,
				    listeners:{
						destroy:function(window,eOpts){
							var parentId = treeNode[0].raw.id; 
		                	var node =Ext.data.StoreManager.lookup('compTreeStore').getNodeById(parentId);   
   							Ext.data.StoreManager.lookup('compTreeStore').load({node:node});
						}
				    },
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/component/gui.jsp?caseId=&parentId='+treeNode[0].raw.id+'" width=1000 height=650/>'
		   		});
		   		addWin.show();
        	}
        }]
});
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.tip.QuickTipManager.init();
	
	var compForm = Ext.widget('form', {
		id:'compForm',
		width:screenWidth*0.8*0.99,
		height:screenHeight*0.5*0.99,
		title:'组件', 
		layout: {
			type: 'vbox'
		}, 
		bodyBorder: 0, 
		fieldDefaults: { 
			labelAlign: 'right', 
			labelWidth: 60, 
			labelStyle: 'font-weight:bold' 
		}, 
		defaults: { 
			margins: '10 0 10 0' 
		}, 
		items: [{ 
			xtype: 'fieldcontainer', 
		    labelStyle: 'font-weight:bold;padding:0', 
		    layout: 'hbox', 
		    defaultType: 'textfield', 
		    fieldDefaults: { 
		    	labelAlign: 'right' 
		    }, 
		    items: [{ 
		    	width: 220,
		    	name: 'compName', 
		        fieldLabel: '组件名称', 
		        allowBlank: false,
		         emptyText:'请填写组件名称',
		         readOnly:true
		    },{
			   	width: 220, 
			    xtype: 'combo', 
			    name:'permission',
			    fieldLabel: '审批结果', 
			    allowBlank: false,
			    emptyText:'请选择审批结果',
		        store:Ext.create('Ext.data.Store', {
					fields:['value','text'],
				    data:[
				    		{'value':0,'text':'通过'},
				    		{'value':1,'text':'不通过'}
				    ]
				}),
		        displayField:'text',
		        valueField:'value',
		        mode:'local',
		        readOnly:true
		    }, { 
			        width: 220, 
			        xtype: 'textfield', 
			        name:'approvalName',
			        fieldLabel: '组件审批人', 
			        allowBlank: false,
			        readOnly:true,
			        emptyText:'请选择审批人'
			    }] 
		 }, { 
				xtype: 'fieldcontainer', 
			    labelStyle: 'font-weight:bold;padding:0', 
			    layout: 'hbox', 
			    defaultType: 'textfield', 
			    fieldDefaults: { 
			    	labelAlign: 'right' 
			    }, 
				items:[ { 
			        width: 220,
			        name:'defaultVal',
			        fieldLabel: '组件默认值', 
			        allowBlank: false,
			        emptyText:'请填写组件默认值',
			        readOnly:true
			    },{ 
			    	readOnly:true,
			        width: 220,
			        name:'author',
			        fieldLabel: '组件创建人',
			        readOnly:true
			    },
			    {
			    	width: 220,
			        name: 'latestOperator',
			        fieldLabel: '最后修改人', 
			        allowBlank: false,
			        readOnly:true
			    }]
		},{ 
			xtype: 'fieldcontainer', 
			labelStyle: 'font-weight:bold;padding:0', 
			layout: 'hbox', 
			defaultType: 'textfield', 
			fieldDefaults: { 
				labelAlign: 'right' 
			}, 
			items:[{ 
				width: 660, 
				height:35,
			    xtype: 'textareafield', 
			    name:'compDesc',
			    fieldLabel: '组件描述', 
			    allowBlank: false,
			    emptyText:'请填写组件描述',
			    readOnly:true
			}]
		},{ 
				xtype: 'fieldcontainer', 
			    labelStyle: 'font-weight:bold;padding:0', 
			    layout: 'hbox', 
			    defaultType: 'textfield', 
			    fieldDefaults: { 
			    	labelAlign: 'right' 
			    }, 
				items:[ { 
		    	xtype:"hidden",
		    	width: 220,
		        name: 'path', 
		        fieldLabel: '组件path', 
		        allowBlank: false
		    },{ 
			    	xtype: "hidden",
			        width: 220,
			        name:'hashcode',
			        fieldLabel: '组件hashcode', 
			        allowBlank: false 
			    },{
			    	xtype: "hidden",
			    	width: 220,
			        name: 'extra',
			        fieldLabel: '组件extra', 
			        allowBlank: false 
			    },{
					xtype: "hidden",
			    	width: 600, 
			    	height:35,
			        name: 'url',
			        fieldLabel: '组件url', 
			        allowBlank: false 
			    },{
		    	xtype: "hidden",
		    	name:"compId",
		    	fieldLabel : "组件ID"
		    },{
		    	xtype: "hidden",
		    	name:"parentId",
		    	fieldLabel : "父组件ID"
		    },
		    {
		    	xtype: "hidden",
		    	name:"isLeaf",
		    	fieldLabel : "是否为叶子"
		    },{
		    	xtype:'hidden',
		    	name:'authorNo'
		    },{
		    	xtype:'hidden',
		    	name:'approvalPsn'
		    }]
		}]
	});
	
	var compTreeStore = Ext.create('Ext.data.TreeStore', { 
		id:'compTreeStore', 
		proxy: {
			type: "ajax",
			url: "<%=request.getContextPath()%>/getAllTreeSyn.do"
		},
		root: {
			id:'1',
			text: '组件',
			expanded: true
		},
		reader: { 
			type: 'json', 
			root: 'children' 
		} 
    });
	var compTree = Ext.create('Ext.tree.Panel',{
		id:'compTree',
        cls: 'ui-formPanel',
		title: '组件树',
		width: screenWidth*0.2*0.99,
		rootVisible: true,
		height: screenHeight*0.99,
		store: compTreeStore,
		useArrows: true,
		autoScroll:true,
		viewConfig : {  
			loadingText : "加载数据..."
		},
		animate:true,
        autoScroll:true,
        containerScroll:true,
        frame:false,
        listeners:{
        	itemclick : function(thisView, record, htmlElementItem, indexNo){
        		if(record.raw.leaf==true){
        			var compId = record.raw.id;
        			var basic = Ext.getCmp('compForm');  
					basic.load({
						params:{compId:compId},  
					    url:'<%=request.getContextPath()%>/refreshCompById.do',
						method:'POST',  
						success:function(form,action){  
             				guiStore.reload({
             					params:{
             						compId:compId
             					}
             				});
						},  
						failure:function(form,action){  
					 		Ext.Msg.alert('提示',"失败原因是: "+action.result.errorMessage);  
					    }  
					});  
        		}else
        			Ext.getCmp('compForm').getForm().reset();
        	},
        	itemcontextmenu : rightClickTargetFn
        }
	});
	
	var guiStore = Ext.create('Ext.data.Store', {
		storeId:'guiStore',
		fields:[{name:'guiId',type:'string'}, 
		 		{name:'guiSelector',type:'string'}, 
		 		{name:'guiUrl',type:'string'}, 
		 		{name:'guiThumb',type:'string'},
		 		{name:'guiTag',type:'string'},
		 		{name:'parentId',type:'string'},
		 		{name:'guiName',type:'string'},
		 		{name:'guiPermission',type:'string'},
		 		{name:'guiPath',type:'string'},
		 		{name:'guiExtra',type:'string'},
		 		{name:'guiDesc',type:'string'},
		 		{name:'guiHtml',type:'string'},
		 		{name:'guiCreateTime',type:'string'},
		 		{name:'guiUpdateTime',type:'string'},
		 		{name:'guiAuthor',type:'string'},
		 		{name:'guiBounds',type:'string'},
		 		{name:'guiHashCode',type:'string'},
		 		{name:'guiLatestOperator',type:'string'}],
	    proxy: {
	        type: 'ajax',
        	url : '<%=request.getContextPath()%>/getGuiTable.do',
	        reader: {
	            root:"data",
				type:"json"
	        }
	    }
	});
	
	guiStore.load({
		params: {compId:0}
	});
	
	var guiGrid = Ext.create('Ext.grid.Panel',{
		id:'guiGrid',
        cls: 'ui-formPanel',
		title:'控件',
        margins : '0 0 0 3',
        height:'100%',
        width:screenWidth*0.8*0.99,
       //tbar:tbar,
        height:screenHeight*0.5*0.99,
		forctFit:true,
        stripeRows:true,
        loadMask:true, 
		store:guiStore,
		selType:'rowmodel',
		columns:[new Ext.grid.RowNumberer(),
				{header: "控件名ID", width:100, sortable: true, dataIndex: 'guiId',hidden:true},
				{header: "父节点ID", width:100, sortable: true, dataIndex: 'parentId',hidden:true},
				{header: "控件名称", width:100, sortable: true, dataIndex: 'guiName'},
        		{header: "控件Selector", width:100,sortable: true, dataIndex: 'guiSelector',hidden:true},
        		{header: "控件gui", width:100, sortable: true, dataIndex: 'guiUrl',hidden:true},
        		{header: "控件图片", width:100, sortable: true, dataIndex: 'guiThumb',hidden:true},
        		{header: "控件Tag", width:100, sortable: true, dataIndex: 'guiTag',hidden:true},
        		{header: "控件审批", width:100, sortable: true, dataIndex: 'guiPermission',hidden:true},
        		{header: "控件path", width:100, sortable: true, dataIndex: 'guiPath',hidden:true},
        		{header: "控件extra", width:100, sortable: true, dataIndex: 'guiExtra',hidden:true},
        		{header: "控件描述", width:100, sortable: true, dataIndex: 'guiDesc'},
        		{header: "控件Html", width:100, sortable: true, dataIndex: 'guiHtml'},
        		{header: "创建时间", width:100, sortable: true, dataIndex: 'guiCreateTime'},
        		{header: "更新时间", width:100, sortable: true, dataIndex: 'guiUpdateTime'},
        		{header: "控件作者", width:100, sortable: true, dataIndex: 'guiAuthor'},
        		{header: "控件Bounds", width:100, sortable: true, dataIndex: 'guiBounds',hidden:true},
        		{header: "控件hashCode", width:100, sortable: true, dataIndex: 'guiHashCode',hidden:true},
        		{header: "最后操作人", width:100, sortable: true, dataIndex: 'guiLatestOperator'}]
	});
	
	Ext.create('Ext.Panel', {
		renderTo: Ext.getBody(),
        cls: 'ui-formPanel',
		width: screenWidth*0.99,
		height: screenHeight*0.99,
		layout: {
			type: 'hbox',      
			align: 'stretch', 
			padding: 0
		},
		defaults: {
			split: true,           
			collapsible: false,           
			bodyStyle: 'padding:0px'
		},
		items: [{
			region: 'west',
			items:[compTree]
		}, {
			region: 'center',
			items:[compForm,guiGrid]
		}]
    });
});
</script>
</html>