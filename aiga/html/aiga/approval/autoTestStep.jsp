<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<%
	String caseId = request.getParameter("caseId");
%>
<html>
<head>
<title>自动化用例步骤</title>
</head>
<body id="autoTestCaseStep">

</body>
<script type="text/javascript">
var extjsFolderPath='<%=request.getContextPath()%>/extJs';
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;

function rightClickTree(view,record,item,index,e,eOpts){
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
	 rightClickTreeMenu.showAt(e.getXY());
}
var rightClickTreeMenu = new Ext.menu.Menu({
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
	        	var editWin = new top.Ext.window.Window({
				    id:'editWin',
				    title : '编辑组件',
				    width : 950,
				    height : 450,
				    modal : true,
				    resizable:false,
				    closeAction : 'destroy',
				    listeners:{
						destroy:function(window,eOpts){
							var parentId = treeNode[0].raw.parentId; 
		                	var node =Ext.data.StoreManager.lookup('compTreeStore').getNodeById(parentId);   
   							Ext.data.StoreManager.lookup('compTreeStore').load({node:node});
						}
				    },
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/component/gui.jsp?compId='+treeNode[0].raw.id+'&parentId=" width="950" height="423"/>'
			   });
			   editWin.show();
			   $("#editWin").css("left","70px");
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
				    width : 950,
				    height : 450,
				    modal : true,
				    resizable:false,
				    listeners:{
						destroy:function(window,eOpts){
							var parentId = treeNode[0].raw.id; 
		                	var node =Ext.data.StoreManager.lookup('compTreeStore').getNodeById(parentId);   
   							Ext.data.StoreManager.lookup('compTreeStore').load({node:node});
						}
				    },
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/component/gui.jsp?compId=&parentId='+treeNode[0].raw.id+'" width="950px" height="450px"/>'
		   		});
		   		addWin.show();
			   	$("#addWin").css("left","70px");
        	}
        }]
});

Ext.onReady(function(){
	var refreshNum = function(){
		compGrid.getView().refresh();
	};
	
	var isFinishCombo = Ext.create('Ext.form.ComboBox', {
	    fieldLabel: '是否完成',
	    store: Ext.create('Ext.data.Store', {
		    fields: ['text', 'value'],
		    data : [
		        {"text":"否", "value":0},
		        {"text":"是", "value":1}
		    ]
		}),
	    queryMode: 'local',
	    displayField: 'text',
	    valueField: 'value',
	    allowBlank: false
	});
	var caseForm = top.Ext.create('Ext.form.Panel', {
		tbar:Ext.create('Ext.Toolbar',{
			items:[isFinishCombo,{
				text:'保存',
				handler:function(){
					if(!isFinishCombo.isValid()){
						Ext.Msg.alert('提示','请选择是否已完成');
						return;
					}
					var store=compGrid.getStore();
					var records = store.getUpdatedRecords();  
       				var phantoms=store.getNewRecords() ;
        			records=records.concat(phantoms);
					var data = new Array(); 
                    Ext.Array.each(store.data.items, function(record) {  
                        data.push(record.data);  
                    });  
			  		/**提交*/
			  		var submitForm = caseForm.getForm();
			  		if(caseId=='0'){
			  			submitForm.findField('caseId').setValue('');
			  			if(parentId=='0'){
			  				Ext.Msg.alert('提示',"未找到关联用例父节点信息");
			  				return;
			  			}
			  		}
			  		submitForm.submit({
			  			clientValidation: true,
			  			url:"<%=request.getContextPath()%>/saveCase.do",
			  			params : {  
                            table :Ext.encode(data)
                        },
			  			method:'POST',  
                    	success:function(response,config){  
                        	var success = config.result.success;  
                            if (success){
                                Ext.Array.each(records, function(record) {  
                                	record.commit();
                            	});
                            }else{
                            	Ext.Msg.alert("提示","数据修改失败!");
                            }
                        },
                        failure:function(response,config){
							Ext.Msg.alert("提示","数据请求失败!");
						}
			  		});
				}
			}]
		}),
		id:'caseForm',
		width:screenWidth*0.995,
		height:screenHeight*0.99*0.2,
        cls: 'ui-formPanel',
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
			 margins: '-2 0 0 0' 
		}, 
		listeners:{
			afterrender : function(render,eOpts){
				caseForm.load({
           			url:'<%=request.getContextPath()%>/getCaseForm.do?caseId=<%=caseId%>',
           			success:function(response,config){
           				var isFinishAuto = caseForm().getForm().findField('isFinishAuto').getValue();
           				isFinishCombo.setValue(parseInt(isFinishAuto));
           			},
	           		failure:function(response,config){
	             		top.Ext.Msg.alert("操作","获取用例信息失败");
             		}
           		});
			}
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
		    	xtype: "hidden", 
		    	name: 'caseName', 
		    },{ 
		    	xtype: "hidden", 
		    	name: 'isFinishAuto', 
		    },{ 
		    	xtype: "hidden", 
		    	name: 'isAvailAuto', 
		    },{ 
		        xtype: "hidden", 
		        name: 'testType'
		    },{ 
		        xtype: "hidden", 
		        name: 'isDelete'
		    },{ 
		        xtype: "hidden", 
		        name: 'createTime'
		    },{ 
		        xtype: "hidden", 
		        name: 'updateTime'
		    },{
		    	xtype: "hidden",
		    	name:"sysLabel"
		    },{
		    	xtype: "hidden",
		    	name:"ownLabel"
		    },{
		    	xtype: "hidden",
		    	name:"caseId"
		    },{
		    	xtype: "hidden",
		    	name:"funFolderId"
		    },{
		    	xtype: "hidden",
		    	name:"authorNo"
		    },{
		    	xtype: "hidden",
		    	name:"approvalPsn"
		    },{
		    	xtype: "hidden",
		    	name:"status"
		    },{
		    	xtype: "hidden",
		    	name:"baseCaseId"
		    },{
		        xtype: 'hidden', 
		        name: 'author'
		    },{ 
		        xtype: "hidden",
		        name:'latestOperator'
		    },
		    { 
		        xtype: "hidden",
		        name:'secId'
		    },
		    { 
		        xtype: "hidden",
		        name:'elemvalue'
		    },
		    { 
				xtype:'hidden',
		    	name: 'regressionTest'
		    },{ 
		    	xtype:'hidden',
		    	name: 'hasTest' 
		    }] 
		 },{ 
			xtype: 'fieldcontainer', 
		    layout: 'hbox', 
		    defaultType: 'textfield', 
		    fieldDefaults: {
		    	labelAlign: 'top',
		    	labelStyle:'background-color:#1B8ECE;font-weight:bold;font-size:13px;line-height:32px;height:32px;color:white'
		    },
			items:[{
		    	name:'casePreCond',
		    	xtype:'textareafield',
		    	fieldLabel: '用例前置条件',
		    	width:screenWidth*0.995/3,
		    	height:100,
		        maxLength : 4000,
		        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制',
		        readOnly:true
	    	},{
		    	name:'caseOperateInst',
		    	xtype:'textareafield',
		    	fieldLabel: '用例操作说明',
		    	width:screenWidth*0.995/3,
		    	height:100,
		        maxLength : 4000,
		        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制',
		        readOnly:true
	    	},{
		    	name:'preResult',
		    	xtype:'textareafield',
		    	fieldLabel: '预期结果',
		    	width:screenWidth*0.995/3,
		    	height:100,
		        maxLength : 4000,
		        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制',
		        readOnly:true
	    	}]
		}]
	});
	
	var compTreeStore = Ext.create('Ext.data.TreeStore', { 
		id:'compTreeStore', 
		proxy: {
			type: "ajax",
			url: "<%=request.getContextPath()%>/getTreeSyn.do?type=0"
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
		width: screenWidth*0.995*0.2,
		height: screenHeight*0.99*0.75,
		rootVisible: true,
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
				if(!record.raw.leaf)return;
				var compId = record.raw.id;
				$.getJSON("<%=request.getContextPath()%>/getCompById.do",{compId:compId}, function(data){
					for( var i=0,n=data.length;i<n;i++){
	  					gridStore.add(data[i]);
					}
				});
        	},
        	itemcontextmenu : rightClickTree
        }
	});
	
	Ext.regModel('inputValueCommboModel', {
	    fields: [
	        {type: 'string', name: 'value'},
	        {type: 'string', name: 'text'}
	    ]
	});
	
	var paramsInputCombo = Ext.create('Ext.form.field.ComboBox',{
		id:'paramsInputCombo',
        emptyText:'请选择',
        multiSelect:false,
        displayField: 'text',
  		valueField:'value',
	    store:Ext.create('Ext.data.Store', {
	    	id:'inputValueSotre',
      		autoLoad:true,
			model:"inputValueCommboModel",
			proxy:Ext.create('Ext.data.proxy.Ajax',{
				type:"ajax",
				model:"inputValueCommboModel",
				url:'<%=request.getContextPath()%>/getInputValue.do?caseId=<%=caseId%>',
				reader:{
					root:"data",
					type:"json"
				}
			})
		})
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
	
	var gridStore = Ext.create('Ext.data.Store', {
		storeId:'compStore',
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
	
	var compGrid = Ext.create('Ext.grid.Panel',{
		id:'compGrid',
        height:screenHeight*0.99*0.35,
        width:screenWidth*0.995*0.8,
		forctFit:true,
        stripeRows:true,//斑马线效果   
        loadMask:true, 
		viewConfig:{
			plugins: [{
		        ptype: 'gridviewdragdrop',
		        dragGroup: 'gridStore',
		        dropGroup: 'gridStore'
	        }],
	        enableDragDrop: true,  
	        dropConfig: {
	            appendOnly:true  
	        },
	        listeners:{
	        	drop:function(node,Object,overModel,dropPosition,eOpts ){
			        refreshNum();
		    	}
	        },
	        forctFit:true,
			stripeRows:true
		},
		plugins:[
			Ext.create('Ext.grid.plugin.CellEditing', {
            clicksToEdit: 2
        })],
		store:Ext.data.StoreManager.lookup('compStore'),
		selType:'cellmodel',
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
        		{header: "输入值", width:100,sortable: true, dataIndex: 'inVal',field:paramsInputCombo},
        		{header: "预期值", width:100, sortable: true, dataIndex: 'expectVal', field: {xtype: 'textfield',allowBlank: false}},
        		{header: "用例步骤描述", width:100, sortable: true, dataIndex: 'compDesc', field: {xtype: 'textfield',allowBlank: false}},
        		{header: "操作", width:50,menuDisabled: true,xtype:'actioncolumn',sortable:false,items: [{
        			icon:"<%=request.getContextPath()%>/aiga/label/image/del.gif",
        			id: 'delComp',  
					tooltip: '删除组件',  
					handler: function(grid, rowIndex, colIndex) {   //rowIndex，colIndex均从0开始  
				        gridStore.removeAt(rowIndex);
				        refreshNum();
					}  
        		}]}
        	]
	});
	
	var autotestParamsModel = Ext.regModel('autotestParamsModel', { 
		fields: [ 
			{name: 'paramId',type: 'string'}, 
			{name: 'parentId',type: 'string'}, 
			{name: 'paramName',type: 'string'},
			{name: 'paramValue',type: 'string'},
			{name: 'isleaf',type: 'string'},
			{name: 'caseId',type: 'string'},
			{name:'paramDesc',type:'string'},
			{name:'exeSql',type:'string'}
		] 
	});
	
	var autotestParamsStore = new Ext.data.TreeStore({ 
		model: autotestParamsModel,  
		proxy: { 
			type: 'ajax',  
			url: '<%=request.getContextPath()%>/getAutotestParam.do?caseId=<%=caseId%>'
		}, 
		root: {
			id:1,
			text: '参数',
			expanded: true
		},
		reader: { 
			type: 'json', 
			root: 'children' 
		}
	});
	
	var autotestParamsTreeGrid = new Ext.tree.TreePanel({ 
		tbar:Ext.create('Ext.Toolbar',{
			items:[{
				text:'添加组',
				handler:function(){
					var submitForm = caseForm.getForm();
				  	if(caseId=='0'){
				  		Ext.Msg.alert("提示","请先保存用例信息");
				  		return;
				  	}
					Ext.Msg.prompt('添加组', '组名称', function(btn, text){
					    if (btn == 'ok'){
					    	var rootNode = autotestParamsStore.getNodeById(1);
							var newNode = {
								parentId:1,
								leaf:false,
								text:text,
								paramId:'',
								paramName:text,
								paramValue:'',
								isleaf:false,
								caseId:'<%=caseId%>'
							};
							rootNode.appendChild(newNode);
							MaskLoading();
						    var store=autotestParamsStore;
							var records = store.getUpdatedRecords();
		       				var phantoms=store.getNewRecords();
		       				var deleteRecords = store.getRemovedRecords();
		        			records=records.concat(phantoms);
							var saveOrUpdateData = new Array(); 
							var deleteData = new Array();
		                    Ext.Array.each(records, function(record) {  
		                        saveOrUpdateData.push(record.data);  
		                    });
		                     Ext.Array.each(deleteRecords, function(record) {  
		                        deleteData.push(record.data);  
		                    });
		                    Ext.Ajax.request({
		                    	url:'<%=request.getContextPath()%>/saveAutotestParam.do',
		                    	params:{savedata:Ext.encode(saveOrUpdateData),deletedata:Ext.encode(deleteData)},
		                    	success:function(response,config){
				                    Ext.Array.each(records, function(record) {  
				                        record.commit();
				                    });  
				                    var rootNode = autotestParamsStore.getNodeById(1);
				                    autotestParamsStore.load(rootNode);
				                    //Ext.data.StoreManager.lookup('inputValueSotre').reload();
				                    MaskOver();
		                    	},
		                    	failure:function(response,config){
		                    		MaskOver();
		                    		Ext.Msg.alert('提示','保存失败');
		                    	}
		                    });
					    }
				    });
				}
			},{
				text:'添加参数',
				handler:function(){
					var submitForm = caseForm.getForm();
				  	if(caseId=='0'){
				  		Ext.Msg.alert("提示","请先保存用例信息");
				  		return;
				  	}
					var selections = autotestParamsTreeGrid.getSelectionModel().getSelection();
					if(selections.length!=1||selections[0].raw.leaf==true){
						Ext.Msg.alert('提示','请选择参数组节点');
						return;
					}
					Ext.Msg.prompt('添加参数', '参数名称', function(btn, text){
					    if (btn == 'ok'){
							var newNode = {
								parentId:selections[0].raw.paramId,
								leaf:true,
								text:text,
								paramId:'',
								paramName:text,
								paramValue:'',
								isleaf:false,
								caseId:'<%=caseId%>'
							};
							selections[0].appendChild(newNode);
						}
					});
				}
			},{
				text:'保存',
				handler:function(){
					var submitForm = caseForm.getForm();
				  	if(caseId=='0'){
				  		Ext.Msg.alert("提示","请先保存用例信息");
				  		return;
				  	}
				  	MaskLoading();
				  	var store=autotestParamsTreeGrid.getStore();
					var records = store.getUpdatedRecords();
       				var phantoms=store.getNewRecords();
       				var deleteRecords = store.getRemovedRecords();
        			records=records.concat(phantoms);
					var saveOrUpdateData = new Array(); 
					var deleteData = new Array();
                    Ext.Array.each(records, function(record) {  
                        saveOrUpdateData.push(record.data);  
                    });
                     Ext.Array.each(deleteRecords, function(record) {  
                        deleteData.push(record.data);  
                    });
                    Ext.Ajax.request({
                    	url:'<%=request.getContextPath()%>/saveAutotestParam.do',
                    	params:{savedata:Ext.encode(saveOrUpdateData),deletedata:Ext.encode(deleteData)},
                    	success:function(response,config){
                    		Ext.Msg.alert('提示','保存成功');
		                    Ext.Array.each(records, function(record) {  
		                        record.commit();
		                    });  
		                    var rootNode = autotestParamsStore.getNodeById(1);
		                    autotestParamsStore.load(rootNode);
		                    //Ext.data.StoreManager.lookup('inputValueSotre').reload();
		                    MaskOver();
                    	},
                    	failure:function(response,config){
                    		MaskOver();
                    		Ext.Msg.alert('提示','保存失败');
                    	}
                    });
				}
			}]
		}),
		title: '参数集合',        
        width:screenWidth*0.995*0.8,
		height: screenHeight*0.99*0.4, 
		cls: 'ui-formPanel',
		useArrows: true,
		rootVisible: false,
		plugins:[
			Ext.create('Ext.grid.plugin.CellEditing', {
            clicksToEdit: 2,
            listeners:{
            	beforeedit:function(e,eOpts){
            		var column = eOpts.field;
            		var data = eOpts.record.raw;
            		if(column=='paramName'){
            			return true;
            		}else if(column=='paramValue'){
            			if(data.leaf==true){
            				return true;
            			}else{
            				return false;
            			}
            		}else if(column=='paramDesc'){
            			if(data.leaf==true){
            				return true;
            			}else{
            				return false;
            			}
            		}else if(column=='exeSql'){
            			if(data.leaf==true){
            				return true;
            			}else{
            				return false;
            			}
            		}
            		return false;
            	}
            }
        })],  
		store: autotestParamsStore,     
		columns:[
			{text: '主键',flex: 2,dataIndex: 'paramId',hidden:true,sortable: false},
			{text: '父ID',flex: 2,dataIndex: 'parentId',hidden:true,sortable: false},
			{xtype: 'treecolumn',text: '参数名称',flex: 2,dataIndex: 'paramName',field: {xtype: 'textfield',allowBlank: false},sortable:false},
			{text: '参数说明',flex: 2,dataIndex: 'paramDesc',field: {xtype: 'textfield',allowBlank: false},sortable:false},
			{text: '取值SQL',flex: 2,dataIndex: 'exeSql',field: {xtype: 'textfield',allowBlank: false},sortable:false},
			{text: '参数值',flex: 2,dataIndex: 'paramValue',field: {xtype: 'textfield',allowBlank: false},sortable:false},
			{text: '是否为叶子节点',flex: 2,dataIndex: 'isleaf',hidden:true,sortable: false},
			{text: '用例主键',flex: 2,dataIndex: 'caseId',hidden:true,sortable: false},
			{header: "操作", width:50,menuDisabled: true,xtype:'actioncolumn',sortable:false,items: [{
        			icon:"<%=request.getContextPath()%>/aiga/label/image/del.gif",
        			id: 'delAutetestParam',  
					tooltip: '删除',  
					handler: function(treeGrid, rowIndex, colIndex) {
						var currentSotre=treeGrid.getStore().getAt(rowIndex);
						if(currentSotre==null){
							Ext.Msg.alert('提示','请选择组件树节点');
							return;
						}
						if(currentSotre.raw.leaf==false){
							Ext.MessageBox.confirm('提示','确定删除该目录吗?删除该目录将会删除该目录下所有的参数配置',function(optional){
								if(optional=='yes'){
									currentSotre.expand(true,function(){
										currentSotre.eachChild(function(node){
											node.remove();
										});
										currentSotre.remove();
									});
								}
							});
						}else{
							currentSotre.remove();
						}
					}  
        		}]}
		] 
	}); 
	
	var compPanel = Ext.create('Ext.form.Panel', {
		width: screenWidth*0.995,
		height: screenHeight*0.99*0.8,
		cls: 'ui-formPanel',
		title:'用例步骤',
		layout: 'border',
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
			items:[compGrid,autotestParamsTreeGrid]
		}]
	});
	
	Ext.create('Ext.panel.Panel', {
		renderTo:  Ext.get('autoTestCaseStep'),
		width: screenWidth*0.995,
		height: screenHeight*0.99,
		bodyBorder:0,
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
			region: 'center',
			items:[caseForm,compPanel]
		}]
	});
});
</script>
</html>