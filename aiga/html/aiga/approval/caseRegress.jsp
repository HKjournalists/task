<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<html>
<head>
<title>手工用例审批</title>
</head>
<body id="caseRegress"></body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth - 5;
var screenHeight = document.documentElement.clientHeight - 5;
Ext.regModel('extCommboModel', {
    fields: [
        {type: 'int', name: 'value'},
        {type: 'string', name: 'text'}
    ]
});
Ext.onReady(function(){
	var maskerWithHtmlEl = function(htmlEl,msg){
		var mask = new top.Ext.LoadMask(htmlEl, {
			msg : msg,
			disabled : false
		});
		return mask;
	};
	var mapModel = Ext.define('mapModel', {
        extend: 'Ext.data.Model',
        fields: [{
                name: 'constantId',
                type: 'string'
            }, {
                name: 'categoryName',
                type: 'string'
            }, {
                name: 'category',
                type: 'string'
            }, {
                name: 'show',
                type: 'string'
            }, {
                name: 'value',
                type: 'int'
            }, {
                name: 'other1',
                type: 'string'
            }, {
                name: 'other2',
                type: 'string'
            }, {
                name: 'memo',
                type: 'string'
            }
        ]
    });
    var mapStore = new Ext.data.Store({
        id: 'mapStore',
        model: mapModel,
        groupField: 'categoryName',
        proxy: {
        	async:false,
            type: 'ajax',
            url: '<%=request.getContextPath()%>/getMultipleSysConstant.do?categorys=ELEM_TYPE,IS_GLOBAL,ANALYSIS_METHOD,has_test',
            reader: {
                type: 'json',
                root: 'data'
            }
        }
    });
    mapStore.load(function(){
    	var testTypeArray = new Array();
		Ext.Ajax.request({
			async:false,
			url:'<%=request.getContextPath()%>/getCaseParam.do?type=test_type',
			success:function(response,config){
				var json=Ext.JSON.decode(response.responseText);
				if(json!=null)
					json = json.data;
				else
					return;
				for(var i=0,n=json.length;i<n;i++){
					var item = {};
					item.boxLabel = json[i].text;
					item.inputValue = json[i].value;
					item.name = 'testType';
					testTypeArray.push(item);
				}
			},
			failure:function(response,config){
				top.Ext.Msg.alert('操作','当前网络不畅，请稍后再试');
			}
		});
		
		var caseSearchForm = Ext.create('Ext.form.Panel',{
			id:'caseSearchForm',
			width:screenWidth,
			height:screenHeight*0.1,
			title:'用例查询',
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
			    	name:'funName',
			    	xtype:'textfield',
			    	fieldLabel: '功能点名称' 
			    },{
			        store: new Ext.data.Store({
			        	autoLoad:true,
				        fields: ['value', 'show'],
				        proxy: {
				            type: 'ajax',
				            url: '<%=request.getContextPath()%>/getComBoxForSystemFolder.do',
				            reader: {
				            	type: 'json',
				           		root: 'data'
				           	}
				        },
						listeners:{
							load:function(store,records){
								var blankRecord={show:'--全部--'};
								store.insert(0,blankRecord);
							}
						}
				    }),
			        labelAlign: 'right',
					forceSelection:true,
			       	typeAhead:true,
			        valueField: 'value',
			        displayField: 'show',
			    	name:'applicateSys',
			    	queryMode:'local',
			    	xtype:'combo',
			    	fieldLabel: '归属系统',
			    	mode:'remote'
			    },{
			    	name:'important',
			    	xtype:'combo',
			    	fieldLabel: '重要级别',
			    	store: new Ext.data.Store({
			    		autoLoad:true,
				        fields: ['value', 'show'],
				        proxy: {
				            type: 'ajax',
				            url: '<%=request.getContextPath()%>/getComBoxForFunFolder.do?query=importantClass',
				            reader: {
				            	type: 'json',
				           		root: 'data'
				           	}
				        },
						listeners:{
							load:function(store,records){
								var blankRecord={show:'--全部--'};
								store.insert(0,blankRecord);
							}
						}
				    }),
			        labelAlign: 'right',
			        valueField: 'value',
					forceSelection:true,
			       	typeAhead:true,
			        displayField: 'show',
			        mode:'remote',
			        queryMode:'local'
			    },{
			    	name:'caseName',
			    	xtype:'textfield',
			    	fieldLabel: '用例名称' 
			    },{
			    	xtype:'button',
			    	text:'查询',
			    	handler:function(){
			    		caseApprovalStore.loadPage(1);
			    	}
			    }] 
			 }]
		});
		
		var caseApprovalModel = Ext.regModel("caseApprovalModel",{
			fields:[
				{name:'caseId',type:'string'},
				{name:'caseName',type:'string'},
				{name:'casePreCond',type:'string'},
				{name:'caseOperateInst',type:'string'},
				{name:'preResult',type:'string'},
				{name:'elemvalue',type:'string'},
				{name:'hasTest',type:'string'}
			]
		});
		
		var caseApprovalProxy = new Ext.data.proxy.Ajax({
			type:"ajax",
			model:caseApprovalModel,
			url:'<%=request.getContextPath()%>/getCaseForManual.do',
			reader:{
				root:"data",
				type:"json"
			}
		});
		
		var caseApprovalStore = Ext.create('Ext.data.Store',{
			model:caseApprovalModel,
			proxy:caseApprovalProxy,
			pageSize: 40
		});
		
		caseApprovalStore.on('beforeload', function(store, options) {
			var funName = encodeURI(caseSearchForm.getForm().findField('funName').getValue());
			var applicateSys = encodeURI(caseSearchForm.getForm().findField('applicateSys').getValue()==null?'':caseSearchForm.getForm().findField('applicateSys').getValue());
			var important = encodeURI(caseSearchForm.getForm().findField('important').getValue()==null?'':caseSearchForm.getForm().findField('important').getValue());
			var caseName = encodeURI(caseSearchForm.getForm().findField('caseName').getValue());
			Ext.apply(caseApprovalStore.proxy.extraParams,{funName:funName,applicateSys:applicateSys,important:important,caseName:caseName});
		});
		
		caseApprovalStore.load();
		
		var caseWorkorderGrid = Ext.create('Ext.grid.Panel',{
			id:'caseWorkorderGrid',
			bbar: Ext.create('Ext.PagingToolbar', { 
				store:caseApprovalStore, 
				displayInfo: true, 
				displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
				emptyMsg: "没有数据"
			}),
		    cls: 'ui-formPanel',
			title:'用例信息',
			border:1,
			height: screenHeight*0.9,
		    width: screenWidth,
			viewConfig:{
				forctFit:true,
				stripeRows:true
			},
			store:caseApprovalStore,
			selModel:Ext.create("Ext.selection.CheckboxModel",{checkOnly : true,ignoreRightMouseSelection : true}),
			listeners:{
				itemdblclick:function(grid, record, item, index, e, eOpts ){
					var caseForm = top.Ext.create('Ext.form.Panel', {
					tbar:top.Ext.create('Ext.Toolbar',{
						items:['->',{
							text:'保存',
							handler:function(){
								var saveCaseMasker = new maskerWithHtmlEl(top.Ext.getCmp('caseWindow'),'正在保存用例信息，请稍后');
								saveCaseMasker.show();
								var val = [];
						        top.Ext.getCmp('isProgressTestCheck').items.each(function (c) {
						            if (c.getValue() == true)
						                val.push(c.inputValue);
						        });
						  		caseForm.getForm().findField('testType').setValue(val.join(','));
								caseForm.getForm().findField('status').setValue(2);
								caseForm.getForm().findField('needApproval').setValue('N');
						  		caseForm.submit({
						  			clientValidation: true,
						  			method:'POST',
						  			url:'<%=request.getContextPath()%>/saveCaseFormForCaseRegress.do',
						  			success:function(form,config){
						  				saveCaseMasker.hide();
						  				top.Ext.Msg.alert("提示","保存成功",function(){
						  					caseApprovalStore.reload();
						  					top.Ext.getCmp('caseWindow').close();
						  				});
						  			},
						  			failure:function(form,config){
						  				saveCaseMasker.hide();
						  				var errorType = config.failureType;
										if(errorType=="client"){
											top.Ext.Msg.alert("提示","请处理带有红色下划线的字段的错误");
										}else if(config.failureType =="connect"){
											top.Ext.Msg.alert("提示","当前网络不畅，请稍后再试");
										}else
											top.Ext.Msg.alert("提示","<font color='red'>保存失败</font>,在保存时后台出现异常");
						  			}
						  		});
							}
						}]
					}),
					id:'caseForm',
					width:screenWidth*0.74,
					height:screenHeight*0.36,
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
					listeners:{
						afterrender : function(render,eOpts){
							var manualCaseId = record.raw.caseId;
							caseForm.load({
			           			url:'<%=request.getContextPath()%>/getCaseForm.do?caseId='+manualCaseId,
			           			success:function(response,config){
			           				var regressionTest = top.Ext.getCmp('caseForm').getForm().findField('regressionTest').getValue();
									if(regressionTest==null||regressionTest==''||regressionTest=='0')
										top.Ext.getCmp('isProgressTestCheck').disable(true);
									else{
										var val = caseForm.getForm().findField('testType').getValue();
										if (val.split) {
								            val = val.split(',');
								        }
								        top.Ext.getCmp('isProgressTestCheck').reset();
								        for (var i = 0; i < val.length; i++) {
								            top.Ext.getCmp('isProgressTestCheck').items.each(function (c) {
								                if (c.inputValue == val[i]) {
								                    c.setValue(true);
								                }
								            });
								        }
						        	}
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
					    	width: 990, 
					    	name: 'caseName', 
					        fieldLabel: '<font color="red">用例名称</font>', 
					        allowBlank: false,
					        emptyText:'请填写用例名称',
					        maxLength : 255,
					        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
					    },{ 
					    	xtype: "hidden", 
					    	name: 'isFinishAuto', 
					    },{ 
					    	xtype: "hidden", 
					    	name: 'needApproval', 
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
					    }, { 
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
						    	name: 'regressionTest', 
						        fieldLabel: '<font color="red">是否为回归测试</font>',
						        xtype: 'combo',
						        forceSelection: true,
						        allowBlank: false,
						        emptyText:'请选择',
						        listeners:{
						        	change:function(combo,newValue,oldValue,eOpts){
						        		if(newValue==null||newValue==0){
						        			var checks = top.Ext.getCmp('isProgressTestCheck').getChecked();
						        			for(var i=0,n=checks.length;i<n;i++){
						        				checks[i].setValue(false);
						        			} 
						        			top.Ext.getCmp('isProgressTestCheck').disable(true);
						        		}else{
						        			top.Ext.getCmp('isProgressTestCheck').enable(true);
						        		}
						        	}
						        },
						        store:Ext.create('Ext.data.Store', {
						        	autoLoad:true,
									model:"extCommboModel",
									proxy:Ext.create('Ext.data.proxy.Ajax',{
										type:"ajax",
										model:"extCommboModel",
										url:'<%=request.getContextPath()%>/getCaseParam.do?type=case_regress',
										reader:{
											root:"data",
											type:"json"
										}
									})
								}),
					           displayField:'text',
					           valueField:'value',
					           mode:'remote'
					    },{
					    	id:'isProgressTestCheck',
					    	width:500,
					    	xtype: 'checkboxgroup',
					        columns: 5,
					        items: testTypeArray
					    },{ 
						    	width: 250, 
						    	name: 'hasTest', 
						        fieldLabel: '<font color="red">需要实现自动化</font>',
						        xtype: 'combo', 
						        forceSelection: true,
						        allowBlank: false,
						        emptyText:'请选择',
						        store:Ext.create('Ext.data.Store', {
						        	autoLoad:true,
									model:"extCommboModel",
									proxy:Ext.create('Ext.data.proxy.Ajax',{
										type:"ajax",
										model:"extCommboModel",
										url:'<%=request.getContextPath()%>/getCaseParam.do?type=has_test',
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
					    	fieldLabel: '<font color="red">用例前置条件</font>',
					    	width:333,
					    	height:100,
					        maxLength : 4000,
					        allowBlank: false,
					        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
				    	},{
					    	name:'caseOperateInst',
					    	xtype:'textareafield',
					    	fieldLabel: '<font color="red">用例操作说明</font>',
					    	width:333,
					    	height:100,
					        maxLength : 4000,
					        allowBlank: false,
					        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
				    	},{
					    	name:'preResult',
					    	xtype:'textareafield',
					    	fieldLabel: '<font color="red">预期结果</font>',
					    	width:333,
					    	height:100,
					        maxLength : 4000,
					        allowBlank: false,
					        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
				    	}]
					}]
				});
					
					var caseWindow = new top.Ext.window.Window({
						id:'caseWindow',
					    width:screenWidth*0.75,
						height:screenHeight*0.41,
					    modal : true,
					    resizable:false,
					    closeAction : 'destroy',
					    items:[caseForm]
					}).show();
				}
			},
			columns:[
				new top.Ext.grid.RowNumberer({width:30}),
				{header:"主键",width:100,dataIndex:"caseId",sortable:true,hidden:true},
				{header:"用例名称",width:200,dataIndex:"caseName",sortable:true},
				{header:"用例前置条件",width:100,dataIndex:"casePreCond",sortable:true,hidden:true},
				{header:"用例操作说明",width:200,dataIndex:"caseOperateInst",sortable:true},
				{header:"预期结果",width:200,dataIndex:"preResult",sortable:true},
				{header:"要素及要素值",width:200,dataIndex:"elemvalue",sortable:true},
				{header:"需要实现自动化",width:100,dataIndex:"hasTest",sortable:true,renderer: function (value,cellmeta,record){
		             try {
		                 var store = Ext.data.StoreManager.lookup("mapStore");
		                 store.clearFilter(true);
		                 store.filter("categoryName", "是否实现自动化");
		                 return store.findRecord("value", value).getData().show + "";
		             } catch (e) {
		                 return ""+value;
		             };
		        }}
			]
		});
		
		Ext.create('Ext.panel.Panel', {
			renderTo:  Ext.get('caseRegress'),
			width: screenWidth,
			height: screenHeight,
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
				items:[caseSearchForm,caseWorkorderGrid]
			}]
		});
    });
});
</script>
</html>