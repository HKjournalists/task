<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser"); %>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/extJs/resources/css/ext-all.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/extJs/ext-all.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/base/jquery-1.8.0.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/base/json2.js"></script>
	<title>组件审批</title>
</head>
<body>
</body>
<script type="text/javascript">
var compId = '${param.compId}';
Ext.onReady(function(){
	loadMask = new Ext.LoadMask(Ext.getBody(),{
		msg : '数据处理中!',
		disabled : false
	});
	var compForm = Ext.create('Ext.form.Panel', {
		id:'compForm',
		width:764,
		height:200,
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
			margins: '5 0 0 0' 
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
		    }, { 
			        width: 220, 
			        xtype: 'textfield', 
			        name:'approvalName',
			        fieldLabel: '用例审批人', 
			        readOnly:true,
			        emptyText:'请选择审批人'
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
		           mode:'local'
			    },{
			    	xtype: 'button', 
			        text:'确定',
			        handler:function(){
			        	var submitForm = compForm.getForm();
			        	loadMask.show();
				  		submitForm.submit({
				  			clientValidation: true,
				  			url:"<%=request.getContextPath()%>/saveApprovalComp.do",
				  			method:'POST',  
	                    	success:function(response,config){
	                    		loadMask.hide();
	                    		Ext.Msg.alert('提示','保存成功',function(){
	                    			window.parent.closeCompWin();
	                    		});
	                        },
	                        failure:function(response,config){
	                        	loadMask.hide();
								Ext.Msg.alert("提示","数据修改失败!");
							}
				  		});
			        }
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
		        fieldLabel: '组件path'
		    },{ 
			    	xtype: "hidden",
			        width: 220,
			        name:'hashcode',
			        fieldLabel: '组件hashcode'
			    },{
			    	xtype: "hidden",
			    	width: 220,
			        name: 'extra',
			        fieldLabel: '组件extra'
			    },{
					xtype: "hidden",
			    	width: 600, 
			    	height:35,
			        name: 'url',
			        fieldLabel: '组件url'
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
	
	var guiModel = Ext.regModel("guiModel",{
		fields:[{name:'guiId',type:'string'}, 
		 		{name:'guiSelector',type:'string'}, 
		 		{name:'guiUrl',type:'string'}, 
		 		{name:'guiThumbUrl',type:'string'},
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
		 		{name:'guiLatestOperator',type:'string'}]
	});
	
	gridStore = Ext.create('Ext.data.Store', {
		storeId:'gridStore',
	  	model: guiModel,
	    proxy: {
	    	url : '<%=request.getContextPath()%>/getGuiByCompId.do',
	        type: 'ajax',
	        reader: {
	            type: 'json',
	            root: 'data'
	        }
	    }
	});
	
	gridStore.load({params:{compId:compId}});

	guiGrid = Ext.create('Ext.grid.Panel',{
		id:'guiGrid',
        cls: 'ui-formPanel',
		title:'控件',
        margins : '0 0 0 3',
        height:300,
        width:764,
		forctFit:true,
        stripeRows:true,
        loadMask:true, 
		store: gridStore,
		selType:'rowmodel',
		columns:[new Ext.grid.RowNumberer(),
				{header: "控件名ID", width:100, sortable: true, dataIndex: 'guiId',hidden:true},
				{header: "父节点ID", width:100, sortable: true, dataIndex: 'parentId',hidden:true},
				{header: "控件名称", width:100, sortable: true, dataIndex: 'guiName'},
        		{header: "控件Selector", width:100,sortable: true, dataIndex: 'guiSelector',hidden:true},
        		{header: "控件gui", width:100, sortable: true, dataIndex: 'guiUrl',hidden:true},
        		{header: "控件图片", width:100, sortable: true, dataIndex: 'guiThumb',hidden:true},
        		{header: "控件类型", width:100, sortable: true, dataIndex: 'guiTag',hidden:true},
        		{header: "控件path", width:100, sortable: true, dataIndex: 'guiPath',hidden:true},
        		{header: "控件extra", width:100, sortable: true, dataIndex: 'guiExtra',hidden:true},
        		{header: "控件描述", width:100, sortable: true, dataIndex: 'guiDesc',hidden:true},
        		{header: "控件Html", width:100, sortable: true, dataIndex: 'guiHtml',hidden:true},
        		{header: "创建时间", width:100, sortable: true, dataIndex: 'guiCreateTime',hidden:true},
        		{header: "更新时间", width:100, sortable: true, dataIndex: 'guiUpdateTime'},
        		{header: "控件作者", width:100, sortable: true, dataIndex: 'guiAuthor'},
        		{header: "控件Bounds", width:100, sortable: true, dataIndex: 'guiBounds',hidden:true},
        		{header: "控件hashCode", width:100, sortable: true, dataIndex: 'guiHashCode',hidden:true},
        		{header: "最后操作人", width:100, sortable: true, dataIndex: 'guiLatestOperator'}
        		]
	});
	
	var approvalPanel = Ext.create('Ext.panel.Panel', {
		renderTo:  Ext.getBody(),
        cls: 'ui-formPanel',
		width: 760,
		height: 600,
		layout: 'border',
		listeners:{
			render : function(render,eOpts){
				compForm.load({
					params:{compId:compId},  
					url:'<%=request.getContextPath()%>/refreshCompById.do',
					method:'POST',  
					success:function(form,action){
					},  
					failure:function(form,action){  
						Ext.Msg.alert('提示',"失败原因是: "+action.result.errorMessage);  
					}
				});
			}
		},
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
			items:[compForm,guiGrid]
		}]
	});
});
</script>
</html>