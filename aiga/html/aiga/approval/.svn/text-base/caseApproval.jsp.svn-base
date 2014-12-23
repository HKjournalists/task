<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser"); %>
<html>
<head>
	<title>用例审批</title>
<style type="text/css">
			img {
				cursor: pointer;
			}
		</style>
	</head>
	<body>
	</body>
	<script type="text/javascript">
var extjsFolderPath='<%=request.getContextPath()%>/extJs';
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
var caseId = '${param.caseId}';
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
			{name:'createTime',type:'string'},
			{name:'arguName',type:'string'}
			]
	});

Ext.onReady(function() {
Ext.QuickTips.init();
//tooltip初始化
Ext.tip.QuickTipManager.init();
	/***用例表单***/
	var caseForm = Ext.widget('form', {
		id:'caseForm',
		width:764,
		height:200,
		title:'用例',
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
		    	width: 250, 
		    	name: 'caseName', 
		        fieldLabel: '用例名称', 
		        allowBlank: false,
		        emptyText:'请填写用例名称',
		        readOnly:true
		    }, { 
		    	width: 250, 
		        xtype: 'datefield', 
		        name: 'createTime', 
		        fieldLabel: '创建时间',
		        allowBlank: false,
		        readOnly:true
		    }, { 
		    	width: 250, 
		        xtype: 'datefield', 
		        name: 'updateTime',
		        fieldLabel: '更新时间', 
		        readOnly:true
		    },{
		    	xtype: "hidden",
		    	name:"sysLabel"
		    },{
		    	xtype: "hidden",
		    	name:"ownLabel"
		    },{
		    	xtype: "hidden",
		    	name:"caseType"
		    },{
		    	xtype: "hidden",
		    	name:"caseId"
		    },{
		    	xtype: "hidden",
		    	name:"parentId"
		    },{
		    	xtype: "hidden",
		    	name:"elemId"
		    },{
		    	xtype: "hidden",
		    	name:"authorNo"
		    },{
		    	xtype: "hidden",
		    	name:"approvalPsn"
		    },{
		    	xtype: "hidden",
		    	name:"isLeaf"
		    },
		    {
		    	xtype: "hidden",
		    	name:"baseCaseId"
		    }] 
		 }, { 
				xtype: 'fieldcontainer', 
			    labelStyle: 'font-weight:bold;padding:0', 
			    layout: 'hbox', 
			    defaultType: 'textfield', 
			    fieldDefaults: { 
			    	labelAlign: 'right' 
			    }, 
				items:[{
			    	width: 250, 
			        xtype: 'textfield', 
			        name: 'author',
			        fieldLabel: '创建人', 
			        allowBlank: false,
			        readOnly:true
			    }, { 
			        width: 250, 
			        xtype: 'textfield', 
			        name:'latestOperator',
			        fieldLabel: '最后操作人',
			        readOnly:true
			    },
			    { 
			        width: 250, 
			        xtype: 'textfield', 
			        name:'url',
			        fieldLabel: 'URL', 
			        allowBlank: false,
			        emptyText:'请填写测试界面地址',
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
			        width: 250, 
			        xtype: 'textfield', 
			        name:'approvalName',
			        fieldLabel: '用例审批人', 
			        allowBlank: false,
			        readOnly:true,
			        emptyText:'请选择审批人'
			    },
			    { 
			        width: 250, 
			        xtype: 'combo', 
			        name:'status',
			        fieldLabel: '审批结果', 
			        allowBlank: false,
			        emptyText:'请选择审批结果',
			        allowBlank: false,
		        	store:Ext.create('Ext.data.Store', {
						fields:['value','text'],
				        data:[
				            	{'value':3,'text':'通过'},
				            	{'value':2,'text':'不通过'},
				            	{'value':1,'text':'未审批'}
				            ]
					}),
		           displayField:'text',
		           valueField:'value',
		           mode:'local'
			    },
			    { 
			        xtype: 'button', 
			        text:'确定',
			        handler:function(){
			        	var submitForm = caseForm.getForm();
			        	MaskLoading();
				  		submitForm.submit({
				  			clientValidation: true,
				  			url:"<%=request.getContextPath()%>/saveCaseForm.do",
				  			method:'POST',  
	                    	success:function(response,config){
			        			MaskOver();
	                    		Ext.Msg.alert('提示','保存用例成功',function(){
	                    			window.parent.closeCaseWin();
	                    		});
	                        },
	                        failure:function(response,config){
	                        	MaskOver();
								Ext.Msg.alert("提示","数据修改失败!");
							}
				  		});
			        }
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
				width: 750, 
			    xtype: 'textareafield', 
			    name:'caseDesc',
			    fieldLabel: '用例描述', 
			    allowBlank: false,
			    emptyText:'请填写用例描述',
		        readOnly:true
			}]
		}]
	});
	/***工具栏***/
	gridStore = Ext.create('Ext.data.Store', {
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

	compGrid = Ext.create('Ext.grid.Panel',{
		id:'compGrid',
        cls: 'ui-formPanel',
		title:'组件',
        height:300,
        width:764,
        hidden:true,
		forctFit:true,
        stripeRows:true,//斑马线效果
        loadMask:true, 
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
				{header: "变量名", width:100, sortable: true, dataIndex: 'arguName'},
        		{header: "输入值", width:100,sortable: true, dataIndex: 'inVal'},
        		{header: "预期值", width:100, sortable: true, dataIndex: 'expectVal'},
        		{header: "用例步骤描述", width:100, sortable: true, dataIndex: 'compDesc'}
        		]
	});
	
	var manualTaskModel = Ext.regModel("manualTaskModel",{
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
			{name:'taskOrder',type:'string'}]
	});
	
	var manualTaskStore = Ext.create('Ext.data.Store', {
		model: manualTaskModel,
		proxy: {
			url : '<%=request.getContextPath()%>/getManualTask.do',
			type: 'ajax',
			reader: {
				type: 'json',
				root: 'data'
			}
		}
	});
	manualTaskGrid = Ext.create('Ext.grid.Panel',{
		id:'manualTaskGrid',
        cls: 'ui-formPanel',
		title:'手工测试步骤',
        height:300,
        width:764,
        hidden:true,
		forctFit:true,
        stripeRows:true,//斑马线效果
        loadMask:true, 
		store:manualTaskStore,
		selType:'cellmodel',
		columns:[new Ext.grid.RowNumberer(),
				{header: "步骤ID", width:100, sortable: true, dataIndex: 'taskId',hidden:true},
				{header: "步骤名称", width:100, sortable: true, dataIndex: 'taskName'},
        		{header: "测试操作步骤", width:100,sortable: true, dataIndex: 'taskDesc'},
        		{header: "预期", width:100, sortable: true, dataIndex: 'preResult'},
        		{header: "测试数据准备", width:100, sortable: true, dataIndex: 'preTestData'},
        		{header: "步骤描述", width:100, sortable: true, dataIndex: 'describe'},
        		{header: "实际结果", width:100, sortable: true, dataIndex: 'actualResult'}
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
				caseForm.load({
					params:{caseId:caseId},  
					url:'<%=request.getContextPath()%>/getCaseForm.do',
					method:'POST',  
					success:function(form,action){
						form.findField('approvalName').setValue('<%=user.getUserName()%>');
						form.findField('approvalPsn').setValue('<%=user.getUserAccount()%>');
						var caseType = form.findField('caseType').getValue();
						if(caseType=='1'){
							$.getJSON("<%=request.getContextPath()%>/manageCaseDetail.do",{caseId:caseId}, function(data){
								for( var i=0,n=data.data.length;i<n;i++){
									gridStore.add(data.data[i]);
									compGrid.show();
								}
							});
						}else if(caseType=='2'){
							manualTaskStore.load({params:{caseId:caseId}});
							manualTaskGrid.show();
						}else
							Ext.Msg.alert('提示',"未知用例类型");
						caseForm.getForm().findField('approvalName').setValue('<%=user.getUserName()%>');
						caseForm.getForm().findField('approvalPsn').setValue('<%=user.getUserAccount()%>');
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
			items:[caseForm,compGrid,manualTaskGrid]
		}]
	});
});
</script>
</html>