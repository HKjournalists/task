<!DOCTYPE HTML>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");%>
<%@ include file="/aiga/common/common.jsp" %>
<html>
<head>
	<title></title>
</head>
  
<body>
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth - 20;
var screenHeight = document.documentElement.clientHeight - 10;
var busiOneLevelId = ${param.busiOneLevelId};
var busiTwoLevelId = ${param.busiTwoLevelId};
var creatorId = '<%=user.getUserId()%>';
var creatorName = '<%=user.getUserName()%>';
var required = '<span style="color:red;font-weight:bold" data-qtip="Required">*</span>';
var createP2pCasewin;
var createP2pFunPointwin;

/**
 * 在用例集Grid删除选中的某一条
 */
function delGridStore(){
	var grid=Ext.getCmp('AigaP2pBusiCaseCollectionGrid');
	var store=grid.getStore();
	var selections = grid.getSelectionModel().getSelection();
	if(selections.length==0){
		Ext.Msg.alert('提示','请选择要删除的行！');
		return;
	}
	Ext.Msg.confirm('提示','是否删除该条？</br>该删除操作会还原其他未保存数据，建议先保存后删除！',function(optional){
		if(optional=='yes'){
			var collectId=selections[0].get('collectId');
			if(collectId==0&&collectId==''){
					store.loadPage(1);return;
			}
			Ext.Ajax.request({
				url:'<%=request.getContextPath()%>/delP2pCollectIdSceneCheck.do',
				params:{
					collectId: collectId
					},
				success:function(response,config){
					var retJson=Ext.JSON.decode(response.responseText);
					if(retJson.data.length>0){
						Ext.Msg.alert('提示','该用例集关联了【'+retJson.data.join(',')+'】场景,</br>请取消关联关系后删除!');
						return;
					}else {
						MaskLoading();
						Ext.Ajax.request({
							url:'<%=request.getContextPath()%>/delP2pBusiCaseCollection.do',
							params:{
								collectId: collectId
								},
							success:function(response,config){
									store.loadPage(1);
							},
							failure:function(response,config){
								Ext.Msg.alert('提示','请求数据失败');
							}
						});
						MaskOver();
					}
				},
				failure:function(response,config){
					Ext.Msg.alert('提示','请求数据失败');
				}
			});
			
		
		}else return;
	});
}
/**
 * 在用例集Grid添加一行
 */
function addGridStore(){
	var record = Ext.create('AigaP2pBusiCaseCollectionModel');
	var Grid= Ext.getCmp('AigaP2pBusiCaseCollectionGrid');
	var store=Grid.getStore();
	record.set('collectId','');
	record.set('busiTwoLevelId',busiTwoLevelId);
	record.set('creatorId',creatorId);
	record.set('creatorName',creatorName);
	store.insert(0,record);

}
/**
 * 提交用例集Store
 */
function submitGridStore(){
	var Grid= Ext.getCmp('AigaP2pBusiCaseCollectionGrid');
	var store=Grid.getStore();
	var records = store.getUpdatedRecords();// 获取修改的行的数据，无法获取幻影数据  
			var phantoms=store.getNewRecords() ;//获得幻影行  
		records=records.concat(phantoms);//将幻影数据与真实数据合并
	var data = new Array();
	var caseIds = new Array();
	var caseNames = new Array();
       Ext.Array.each(records, function(record) {
    	   if(record.isModified('precondition')||record.isModified('caseName')||record.isModified('operateDesc')||record.isModified('expectation')){
    		   record.set('isDirty',1);
    		   caseIds.push(record.get('caseId'));
    		   caseNames.push(record.get('caseName'));
    	   }
           data.push(record.data);  
           });
       
       MaskLoading();
	   	Ext.Ajax.request({
				url:'<%=request.getContextPath()%>/saveP2pBusiCaseCollection.do',
				params:{
					table:Ext.encode(data)
					},
				success:function(response,config){
						store.loadPage(1);
						Ext.data.StoreManager.lookup('AigaP2pFunctionPointStore').loadPage(1);
						Ext.data.StoreManager.lookup('AigaP2pCaseStore').loadPage(1);
				},
				failure:function(response,config){
					Ext.Msg.alert('提示','请求数据失败');
				}
		});
   	MaskOver();
}
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.tip.QuickTipManager.init();
	/**
	*
	*端到端功能点Model
	*
	**/
	  var AigaP2pFunctionPointModel = Ext.define('AigaP2pFunctionPointModel', {
	        extend: 'Ext.data.Model',
	        fields: [
	                 {name: 'funId',type: 'int'},
	                 {name: 'sysName',type: 'string'},
	                 {name: 'createTime',type: 'string'},
	                 {name: 'updateTime',type: 'string'}, 
	                 {name: 'cause',type: 'string' }, 
	                 {name: 'causeType',type: 'int'}, 
	                 {name: 'remark',type: 'string'}, 
	                 {name: 'operatorId',type: 'string'}, 
	                 { name: 'operatorName',type: 'string'},
	                 { name: 'creatorId',type: 'int'},
	                 { name: 'creatorName',type: 'string'}
	        ]
	    });
	  /**
		*
		*用例Model
		*
		**/
		  var AigaCaseModel = Ext.define('AigaCaseModel', {
		        extend: 'Ext.data.Model',
		        fields: [
		                 {name: 'caseId',type: 'int'},
		                 {name: 'caseName',type: 'string'},
		                 {name: 'caseDesc',type: 'string'},
		                 {name: 'precondition',type: 'string'},
		                 {name: 'expectation',type: 'string'},
		                 {name: 'operateDesc',type: 'string'},
		                 {name: 'source',type: 'string'},
		                 {name: 'remark',type: 'string'},
		                 {name: 'createTime',type: 'string'},
		                 {name: 'creatorId',type: 'int'},
		                 {name: 'creatorName',type: 'string'},
		                 {name: 'cause',type: 'string' }, 
		                 {name: 'causeType',type: 'int'}, 
		                 {name: 'status',type: 'int'}, 
		                 {name: 'verifyStatus',type: 'int'}, 
		                 {name: 'isDirty',type: 'int'}, 
		                 {name: 'verifyResult',type: 'string'}, 
		                 {name: 'caseClass',type: 'string'}
		        ]
		    });
		  /**
			*
			*新业务Store
			*
			**/
		  var AigaNewBusiCaseStore = new Ext.data.Store({
	        id: 'AigaNewBusiCaseStore',
	        model: AigaCaseModel,
	        pageSize: 20,
	        proxy: {
	            type: 'ajax',
	            url: '<%=request.getContextPath()%>/getAigaNewBusiCase.do',
	            reader: {
	            	type: 'json',
	 	            root: 'data',
	 	            totalProperty:'total'
	            }
	        },
	        listeners:{
	        	beforeload:function( store,operation,eOpts ){
		    		 var funPointName=Ext.getCmp('tbarAigaNewBusiCaseFunName').getValue();
					 var caseName=Ext.getCmp('tbarAigaNewBusiCaseName').getValue();

		    		Ext.apply(
		    				store.proxy.extraParams, {
		    					funPointName :encodeURI(encodeURI(funPointName)),
		    					caseName :encodeURI(encodeURI(caseName))
		    				} 
		    		)
		    	}
	        }
	    });
		  /**
			*
			*新业务功能点Grid
			*
			**/
			var AigaNewBusiCaseGrid = Ext.create('Ext.grid.Panel',{
				id:'AigaNewBusiCaseGrid',
		        cls: 'ui-formPanel',
		        margins : '3 3 3 3',
		        width: screenWidth*0.55,
				height: screenHeight*0.59,
				dockedItems: [{
				    xtype: 'toolbar',
				    dock: 'top',
				    items: [
							{xtype: 'textfield',width: 200,id:'tbarAigaNewBusiCaseFunName',labelWidth: 80,fieldLabel: '功能点名称'},
							{xtype: 'textfield',width: 200,id:'tbarAigaNewBusiCaseName',labelWidth: 60,fieldLabel: '用例名称'},
							{xtype:'button',text:'搜索',handler:function(){
								 AigaNewBusiCaseStore.loadPage(1);

							}}
		              ]
				}],
				forctFit:true,
		        stripeRows:true,
		        loadMask:true, 
				store: AigaNewBusiCaseStore,
				selType:'rowmodel',
				bbar: Ext.create('Ext.PagingToolbar', { 
					store: AigaNewBusiCaseStore, 
					displayInfo: true, 
					displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
					emptyMsg: "没有数据"
			}),
				listeners : {
					itemdblclick:function(grid,record,item,index,e,eOpts){
						var caseName=encodeURI(encodeURI(record.get('caseName')));
						var caseDesc=encodeURI(encodeURI(record.get('caseDesc')));
						var precondition=encodeURI(encodeURI(record.get('precondition')));
						var expectation=encodeURI(encodeURI(record.get('expectation')));
						var operateDesc=encodeURI(encodeURI(record.get('operateDesc')));
								MaskLoading();
								Ext.Ajax.request({
									url:"<%=request.getContextPath()%>/checkP2pCase.do?busiTwoLevelId = ${param.busiTwoLevelId}",
									params:{
										caseName: caseName,
										caseDesc: caseDesc,
										precondition: precondition,
										expectation: expectation,
										operateDesc: operateDesc
										},
									success:function(response,config){
										var retJson=Ext.JSON.decode(response.responseText);
										var funPoints=new Array();
										if(retJson.success){
											Ext.getCmp('AigaNewBusiCaseWin').close();
										}else{
											Ext.Msg.alert('提示','已经存在相同的用例名称',function(){
												Ext.getCmp('AigaNewBusiCaseWin').close();
											});
										}
										Ext.data.StoreManager.lookup('AigaP2pCaseStore').removeAll();
										Ext.data.StoreManager.lookup('AigaP2pCaseStore').insert(0,retJson.data[0]);
										MaskOver();
									},
									failure:function(response,config){
										Ext.Msg.alert('提示','保存失败');
										MaskOver();
									}
								});
				
					}
				},
				columns:[
					 new Ext.grid.RowNumberer({header　:　"序号",  width　:　40}), 
					{header: "用例Id", width:100, sortable: true, dataIndex: 'funId',hidden:true},
					{header: "用例名称", width:250, sortable: true, dataIndex: 'caseName'},
					{header: "用例描述", width:250, sortable: true, dataIndex: 'caseDesc'},
					{header: "前置条件", width:250, sortable: true, dataIndex: 'precondition'},
					{header: "操作描述", width:250, sortable: true, dataIndex: 'operateDesc'},
					{header: "期望结果", width:250, sortable: true, dataIndex: 'expectation'},
					{header: "创建人", width:100, sortable: true, dataIndex: 'creatorName',hidden:true},
					{header: "创建日期", width:100, sortable: true, dataIndex: 'createTime',hidden:true}
		    	]
			});
		  /**
			*
			*端到端用例Store
			*
			**/
		  var AigaP2pCaseStore = new Ext.data.Store({
	        id: 'AigaP2pCaseStore',
	        model: AigaCaseModel,
	        proxy: {
	            type: 'ajax',
	            url: '<%=request.getContextPath()%>/getAigaP2pCase.do',
	            reader: {
	                type: 'json',
	                root: 'data'
	            }
	        },
	        listeners:{
	        }
	    });
		AigaP2pCaseStore.load();
		/**
		*
		*新业务功能点Model
		*
		**/
		  var AigaNewFunctionPointModel = Ext.define('AigaNewFunctionPointModel', {
		        extend: 'Ext.data.Model',
		        fields: [
		                 {name: 'funId',type: 'int'},
		                 {name: 'sysName',type: 'string'},
		                 {name: 'createTime',type: 'string'},
		                 {name: 'updateTime',type: 'string'}, 
		                 {name: 'menuPath',type: 'string' }, 
		                 {name: 'baseBusiLabel',type: 'string'}, 
		                 {name: 'busiLabel',type: 'string'}, 
		                 {name: 'operatorId',type: 'string'}, 
		                 { name: 'operatorName',type: 'string'},
		                 { name: 'creatorId',type: 'int'},
		                 { name: 'creatorName',type: 'string'}
		        ]
		    });
		  /**
			*
			*新业务功能点Store
			*
			**/
		  var AigaNewFunctionPointStore = new Ext.data.Store({
	          id: 'AigaNewFunctionPointStore',
	          model: AigaNewFunctionPointModel,
	          proxy: {
	              type: 'ajax',
	              url: '<%=request.getContextPath()%>/getNewFunctionPoint.do',
	              reader: {
	                  type: 'json',
	                  root: 'data'
	              }
	          },
	          listeners:{
	          }
	      });
		/**
		*
		*
		**/
		var tbarGrid=Ext.create('Ext.panel.Panel',{
			id:'tbarGrid',
	        cls: 'ui-formPanel',
	        margins : 0,
	        title:'添加功能体验测试功能点和用例',
	        width: screenWidth,
			height: screenHeight*0.25,
			minWidth: 1200-260,
			bodyBorder:0,
			listeners:{
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
			items: [
			        {
			        	region: 'center',
						items:[
						       {
						    	   xtype: 'fieldcontainer',
						    	   labelStyle: 'font-weight:bold;padding:0',
						    	   fieldDefaults: {labelAlign: 'right',labelWidth: 80},
						    	   layout: 'hbox',
						    	   defaultType: 'textfield',
						    	   items:[
											{xtype:'button',fieldLabel: '来自新业务',margin: '0 0 0 10',tooltip :'查询新业务功能点 ',text: '新业务功能点查询和复制',iconCls: 'add-button',handler: function() {p2pFunctionPointWin.show();}},
											{xtype:'button',fieldLabel: '来自端到端',margin: '0 0 0 100',tooltip :'新增用户体验功能点',text: '新增功能点',iconCls: 'add-button',handler: function() {
												 if (!createP2pFunPointwin) {
											            var createP2pForm = Ext.widget('form', {
											                layout: {
											                    type: 'vbox',
											                    align: 'stretch'
											                },
											                border: false,
											                bodyPadding: 10,

											                fieldDefaults: {
											                    labelAlign: 'top',
											                    labelWidth: 100,
											                    labelStyle: 'font-weight:bold'
											                },
											                items: [{
											                    xtype: 'textfield',
											                    fieldLabel: '功能点名称',
											                    name:'sysName',
											                    afterLabelTextTpl: required,
											                    allowBlank: false
											                }
											                ],

											                buttons: [{
											                    text: '取消',
											                    handler: function() {
											                        this.up('form').getForm().reset();
											                        this.up('window').hide();
											                    }
											                }, {
											                    text: '确定',
											                    handler: function() {
											                        if (this.up('form').getForm().isValid()) {
											                            var jsoncn={};
											                            var json={};
											                            var fields=this.up('form').getForm().getFields();
											                            var _this=this;
											                            fields.each(function(item){
											                            	json[item.getName()]=encodeURI(encodeURI(item.getValue()));
											                            	jsoncn[item.getName()]=item.getValue();
											                            });
											                        	Ext.Ajax.request({
																			url:"<%=request.getContextPath()%>/checkP2pFunctionPonit.do?busiTwoLevelId=${param.busiTwoLevelId}",
																			params: json,
																			success:function(response,config){
																				var retJson=Ext.JSON.decode(response.responseText);
																				var funPoints=new Array();
																				if(retJson.success){
																					 var store=Ext.data.StoreManager.lookup('AigaP2pFunctionPointStore');
															                            store.removeAll();
															                            store.add(jsoncn);
															                            _this.up('form').getForm().reset();
															                            _this.up('window').hide();
																				}else{
																					alert('已经存在相同的功能点名称');
																					_this.up('form').getForm().getFields().items[0].focus(true);
																					};
																				
																				MaskOver();
																			},
																			failure:function(response,config){
																				Ext.Msg.alert('提示','保存失败');
																				MaskOver();
																			}
																		});
											                           
											                        }
											                    }
											                }]
											            });

											            createP2pFunPointwin = Ext.widget('window', {
											                title: '创建用户体验测试功能点',
											                closeAction: 'hide',
											                width: 400,
											                height: 200,
											                layout: 'fit',
											                resizable: true,
											                modal: true,
											                items: createP2pForm
											            });
											        }
												 	createP2pFunPointwin.show();
												
												}},
											{xtype: 'textfield',width: 300,labelWidth: 200,id:'tbarChannelName',emptyText:'请输入渠道名称',tooltip :'搜索用户体验库',fieldLabel: '用户体验库功能点查询和引用'},
											{xtype:'button',tooltip :'搜索用户体验库',text:'搜索',handler:function(){
											 var tbarChannelName=Ext.getCmp('tbarChannelName').getValue();
											 Ext.data.StoreManager.lookup('AigaP2pFunctionPointStore').load({params:{channelName: encodeURI(encodeURI(tbarChannelName))}});
											}}
											
						    	          ]
						    	   },
						    	{
								   xtype: 'fieldcontainer',
						    	   labelStyle: 'font-weight:bold;padding:0',
						    	   fieldDefaults: {labelAlign: 'right',labelWidth: 80},
						    	   layout: 'hbox',
						    	   defaultType: 'textfield',
						    	   items:[
										{xtype:'button',fieldLabel: '来自新业务',margin: '0 0 0 10',tooltip :'查询新业务用例 ',text: '新业务用例查询和复制',iconCls: 'add-button',handler: function() { AigaNewBusiCaseWin.show();}},
										{xtype:'button',fieldLabel: '来自端到端',margin: '0 0 0 100',tooltip :'新增用户体验测试用例',text: '新增用例',iconCls: 'add-button',handler: function() { 
									        if (!createP2pCasewin) {
									            var createP2pForm = Ext.widget('form', {
									                layout: {
									                    type: 'vbox',
									                    align: 'stretch'
									                },
									                border: false,
									                bodyPadding: 10,

									                fieldDefaults: {
									                    labelAlign: 'top',
									                    labelWidth: 100,
									                    labelStyle: 'font-weight:bold'
									                },
									                items: [{
									                    xtype: 'textfield',
									                    fieldLabel: '用例名称',
									                    name:'caseName',
									                    afterLabelTextTpl: required,
									                    allowBlank: false
									                }, {
									                	 xtype: 'textareafield',
										                 fieldLabel: '前置条件',
										                 name:'precondition',
										                 labelAlign: 'top',
										                 flex: 1,
										                 margins: '0',
										                 afterLabelTextTpl: required,
										                 allowBlank: false
									                }, {
									                	 xtype: 'textareafield',
										                 fieldLabel: '操作描述',
										                 name:'operateDesc',
										                 labelAlign: 'top',
											             flex: 1,
											             margins: '0',
											             afterLabelTextTpl: required,
											             allowBlank: false
									                } ,{
									                	 xtype: 'textareafield',
										                 fieldLabel: '预期结果',
										                 name:'expectation',
										                 labelAlign: 'top',
											             flex: 1,
											             margins: '0',
											             afterLabelTextTpl: required,
											             allowBlank: false
									                }, {
									                    xtype: 'textareafield',
									                    fieldLabel: '备注',
									                    name:'caseDesc',
									                    labelAlign: 'top',
											             flex: 1,
											             margins: '0'
									                }
									                ],

									                buttons: [{
									                    text: '取消',
									                    handler: function() {
									                        this.up('form').getForm().reset();
									                        this.up('window').hide();
									                    }
									                }, {
									                    text: '确定',
									                    handler: function() {
									                        if (this.up('form').getForm().isValid()) {
									                            var json={};
									                            var jsoncn={};
									                            var fields=this.up('form').getForm().getFields();
									                            fields.each(function(item){
									                            	jsoncn[item.getName()]=item.getValue();
									                            });
									                        	fields.each(function(item){
									                        		json[item.getName()]=encodeURI(encodeURI(item.getValue()));
									                            });
									                        	var _this=this;
									    						Ext.Ajax.request({
									    							url:"<%=request.getContextPath()%>/checkP2pCase.do?busiTwoLevelId=${param.busiTwoLevelId}",
									    							params: json,
									    							success:function(response,config){
									    								var retJson=Ext.JSON.decode(response.responseText);
									    								if(retJson.success){
									    									var store=Ext.data.StoreManager.lookup('AigaP2pCaseStore');
												                            store.removeAll();
												                            store.add(jsoncn);
												                            _this.up('form').getForm().reset();
												                            _this.up('window').hide();
									    								}else{
									    									alert('已经存在相同的用例名称');
									    									try{
									    										_this.up('form').getForm().getFields().items[0].focus(true);
									    									}catch(e){
									    									}
									    								}
									    							},
									    							failure:function(response,config){
									    								Ext.Msg.alert('提示','请求失败');
									    							}
									    						});
									                        }
									                    }
									                }]
									            });

									            createP2pCasewin = Ext.widget('window', {
									                title: '创建用户体验测试用例',
									                closeAction: 'hide',
									                width: 400,
									                height: 400,
									                layout: 'fit',
									                resizable: true,
									                modal: true,
									                items: createP2pForm
									            });
									        }
									        createP2pCasewin.show();
										}},
										{xtype: 'textfield',width: 300,labelWidth: 200,id:'tbarChannelName4Case',emptyText:'请输入渠道名称',fieldLabel: '用户体验库用例查询和引用'},
										{xtype:'button',text:'搜索',tooltip:'搜索用户体验库',handler:function(){
											  var tbarChannelName=Ext.getCmp('tbarChannelName4Case').getValue();
											  Ext.data.StoreManager.lookup('AigaP2pCaseStore').load({params:{channelName: encodeURI(encodeURI(tbarChannelName))}});

										}}
						              ]
				       },
				       {
						   xtype: 'fieldcontainer',
				    	   labelStyle: 'font-weight:bold;padding:0',
				    	   fieldDefaults: {labelAlign: 'right',labelWidth: 80},
				    	   layout: 'hbox',
				    	   defaultType: 'textfield',
				    	   items:[
				    	      	{xtype: 'label',text: '用例集工具栏:',margin: '0 0 0 10'},
				    	      	{
									 xtype:'combobox',valueField: 'value',displayField: 'show',id:'baseFunCombobox', emptyText: '请选择基础功能',width: 150,labelWidth: 60,
									 store: Ext.create('Ext.data.Store', {
										   fields: ['show', 'value'],
										   proxy: {
											   type: 'ajax',reader: {type: 'json',root: 'data'},
											   url : '<%=request.getContextPath()%>/getP2pCaseCollectionCombox.do?busiTwoLevelId=${param.busiTwoLevelId}&type=baseFunCombobox'
									    }
									 })
									 },
								{
									 xtype:'combobox',valueField: 'value',displayField: 'show',id:'channelCombobox', emptyText: '请选择渠道',width: 150,labelWidth: 60,
									 store: Ext.create('Ext.data.Store', {
										   fields: ['show', 'value'],
										   proxy: {
											   type: 'ajax',reader: {type: 'json',root: 'data'},
											   url : '<%=request.getContextPath()%>/getP2pCaseCollectionCombox.do?busiTwoLevelId=${param.busiTwoLevelId}&type=channelCombobox'
									    }
									 })
									 },
									 {xtype:'textfield',width: 250,labelWidth: 45,fieldLabel:'功能点:',id:'tbarCollectionFunctionName',readOnly:true},
									 {xtype:'textfield',width: 250,labelWidth: 30,fieldLabel:'用例:',id:'tbarCollectionCaseName',readOnly:true},
									 {xtype:'button',text:'添加所选',handler:function(){
											var AigaP2pCaseGrid = Ext.getCmp('AigaP2pCaseGrid');
											var FunctionPointGrid = Ext.getCmp('FunctionPointGrid');
											var FunctionPointRecords = FunctionPointGrid.getSelectionModel().getSelection()[0];
											var AigaP2pCaseRecords = AigaP2pCaseGrid.getSelectionModel().getSelection()[0];
											var baseBusiId=Ext.getCmp('baseFunCombobox').getValue();
											var baseBusiName=Ext.getCmp('baseFunCombobox').getRawValue();
											var channelId=Ext.getCmp('channelCombobox').getValue();
											var channelName=Ext.getCmp('channelCombobox').getRawValue();
									  		var AigaP2pBusiCaseCollectionStore=Ext.data.StoreManager.lookup('AigaP2pBusiCaseCollectionStore');
										  	var newCollection=Ext.create('AigaP2pBusiCaseCollectionModel');
									  		if(baseBusiId==null||baseBusiId==''){alert('基础功能不能为空');return;}
											if(channelId==null ||channelId==''){alert('渠道不能为空'); return;}
											if(FunctionPointRecords==null){alert('功能点不能为空'); return;}
											if(AigaP2pCaseRecords==null ){alert('用例不能为空'); return;}
											newCollection.set('collectId','');
											newCollection.set('channelId',channelId);
											newCollection.set('channelName',channelName);
											newCollection.set('baseBusiId',baseBusiId);
											newCollection.set('baseBusiName',baseBusiName);
											newCollection.set('busiTwoLevelId',busiTwoLevelId);
											newCollection.set('creatorId',creatorId);
											newCollection.set('creatorName',creatorName);
											// newCollection.set('baseBusiId');
											
											 newCollection.set('funId',FunctionPointRecords.get('funId'));
											 newCollection.set('sysName',FunctionPointRecords.get('sysName'));
											 
											 newCollection.set('caseName',AigaP2pCaseRecords.get('caseName'));
											 newCollection.set('caseId',  AigaP2pCaseRecords.get('caseId'));
											 newCollection.set('caseDesc',AigaP2pCaseRecords.get('caseDesc'));
											 newCollection.set('precondition',AigaP2pCaseRecords.get('precondition'));
											 newCollection.set('expectation',AigaP2pCaseRecords.get('expectation'));
											 newCollection.set('operateDesc',AigaP2pCaseRecords.get('operateDesc'));
											 //添加业务下唯一性校验
											 try{
												 AigaP2pBusiCaseCollectionStore.each(function(record){
													 if(record.get('baseBusiId')==newCollection.get('baseBusiId')
															 &&record.get('channelId')==newCollection.get('channelId')
															 &&record.get('sysName')==newCollection.get('sysName')
															 &&record.get('caseName')==newCollection.get('caseName')){
														 throw '用例集唯一性校验失败！';
													 }
												 });
											 }catch (e) {
										            alert(e);
										            return;
										        }
											
											 AigaP2pBusiCaseCollectionStore.add(newCollection);
											 //Ext.getCmp('tbarCollectionFunctionName').setValue('');
											 //Ext.getCmp('tbarCollectionCaseName').setValue('');
									}}
				    	          ]
				       }
				       
				       ]
			}]
		});
		  /**
			*
			*新业务功能点Grid
			*
			**/
			var AigaNewFunctionPointGrid = Ext.create('Ext.grid.Panel',{
				id:'AigaNewFunctionPointGrid',
		        cls: 'ui-formPanel',
		        margins : '3 3 3 3',
		        width: screenWidth*0.55,
				height: screenHeight*0.59,
		        tbar:[
		              {xtype: 'combobox',id:'tbarAigaNewBusiSysNameCombox',width: 200,labelWidth: 60,fieldLabel: '系统名称', valueField: 'sysId',displayField: 'sysName',
		            	forceSelection:true,typeAhead:true, minChars:1,selectOnFocus: true,triggerAction: 'all',queryMode: 'local',
		            	  store:{xtype:'store',autoLoad:true,fields:['sysId','sysName'], 
		            		  proxy: { type: 'ajax',url: '<%=request.getContextPath()%>/getNewBusiSystemCombox.do',
		            			  reader: {type: 'json',root: 'data'}
		            		  },
		            		  listeners:{
		            			  load:function(store, records, successful, eOpts){
		            				  var record={sysId:null,sysName:'--请选择--'}
		            				  store.insert(0,record);
		            			  }
		            		  }
		            		  
		              }
		              },
		              {xtype: 'textfield',width: 200,id:'tbarAigaNewBusiFunctionPoint',labelWidth: 60,fieldLabel: '功能点'},
		              {xtype:'button',text:'搜索',handler:function(){
		            	  var sysId=Ext.getCmp('tbarAigaNewBusiSysNameCombox').getValue();
		            	  var funPointName=Ext.getCmp('tbarAigaNewBusiFunctionPoint').getValue();
		            	  AigaNewFunctionPointStore.load({params:{sysId:sysId,funPointName:encodeURI(encodeURI(funPointName))}});
		              }}
				],
				forctFit:true,
		        stripeRows:true,
		        loadMask:true, 
				store: AigaNewFunctionPointStore,
				selType:'rowmodel',
				listeners : {
					itemdblclick:function(grid,record,item,index,e,eOpts){
						var funName=record.get('sysName');
								MaskLoading();
								Ext.Ajax.request({  
									url:"<%=request.getContextPath()%>/checkP2pFunctionPonit.do?busiTwoLevelId = ${param.busiTwoLevelId}",
									params:{sysName :funName},
									success:function(response,config){
										var retJson=Ext.JSON.decode(response.responseText);
										var funPoints=new Array();
										if(retJson.success){
											Ext.getCmp('p2pFunctionPointWin').close();
										}else{
											Ext.Msg.alert('提示','已经存在相同的功能点名称',function(){
												Ext.getCmp('p2pFunctionPointWin').close();
											});
										}
										Ext.data.StoreManager.lookup('AigaP2pFunctionPointStore').removeAll();
										Ext.data.StoreManager.lookup('AigaP2pFunctionPointStore').insert(0,retJson.data[0]);
										MaskOver();
										
									},
									failure:function(response,config){
										Ext.Msg.alert('提示','保存失败');
										MaskOver();
									}
								});
				
					}
				},
				columns:[
					 new Ext.grid.RowNumberer({header　:　"序号", 　width　:　40}), 
					{header: "功能点Id", width:100, sortable: true, dataIndex: 'funId',hidden:true},
					{header: "功能点", width:250, sortable: true, dataIndex: 'sysName'},
					{header: "创建人", width:100, sortable: true, dataIndex: 'creatorName',hidden:true},
					{header: "创建日期", width:100, sortable: true, dataIndex: 'createTime',hidden:true}
		    	]
			});
			 /**
			*
			*选择新业务功能点窗口
			*
			**/
		var p2pFunctionPointWin = new Ext.window.Window({
		    title : '新业务功能点',
		    id:'p2pFunctionPointWin',
		    width : 600,
		    height : 360,
		    modal : true,
		    resizable:false,
		    closeAction : 'hide',
		    items:[AigaNewFunctionPointGrid]
	  });
		var AigaNewBusiCaseWin = new Ext.window.Window({
		    title : '新业务用例',
		    id:'AigaNewBusiCaseWin',
		    width : 600,
		    height : 360,
		    modal : true,
		    resizable:false,
		    closeAction : 'hide',
		    items:[AigaNewBusiCaseGrid]
	  });
	  /**
		*
		*端到端功能点Store
		*
		**/
	  var AigaP2pFunctionPointStore = new Ext.data.Store({
          id: 'AigaP2pFunctionPointStore',
          model: AigaP2pFunctionPointModel,
          proxy: {
              type: 'ajax',
              url: '<%=request.getContextPath()%>/getP2pFunctionPoint.do',
              reader: {
                  type: 'json',
                  root: 'data'
              }
          },
          listeners:{
          }
      });
	  AigaP2pFunctionPointStore.load();
	  
	/**
	*
	*端到端功能点用例Model
	*
	**/
	  var FunctionPointModel = Ext.define('FunctionPointModel', {
	        extend: 'Ext.data.Model',
	        fields: [
	                 {name: 'funId',type: 'int'},
	                 {name: 'sysName',type: 'string'},
	                 {name: 'caseId',type: 'int'},
	                 {name: 'caseName',type: 'string'}
	        ]
	    });
	  /**
		*
		*端到端功能点Store
		*
		**/
	  var FunctionPointStore = new Ext.data.Store({
        id: 'FunctionPointStore',
        model: FunctionPointModel,
        proxy: {
            type: 'ajax',
            url: '<%=request.getContextPath()%>/getFunPointCase.do',
            reader: {
                type: 'json',
                root: 'data'
            }
        },
        listeners:{
        }
    });
	  //FunctionPointStore.load();
	  /**
		*
		*端到端功能点Grid
		*
		**/
		var FunctionPointGrid = Ext.create('Ext.grid.Panel',{
			id:'FunctionPointGrid',
	        cls: 'ui-formPanel',
	        margins : '0 0 0 3',
			height: screenHeight*0.29,
			//title:'用户体验测试库功能点',
	        width: screenWidth*0.20,
			forctFit:true,
	        stripeRows:true,
	        loadMask:true, 
			store: AigaP2pFunctionPointStore,
			selType:'rowmodel',
			listeners : {
				itemclick:function(_this, record, item, index, e, eOpts){
					Ext.getCmp('tbarCollectionFunctionName').setValue(record.get('sysName'));
				}
			},
			columns:[
				 new Ext.grid.RowNumberer({header　:　"序号", 　width　:　40}), 
				{header: "功能点Id", width:100, sortable: true, dataIndex: 'funId',hidden:true},
				{header: "功能点", width:150, sortable: true, dataIndex: 'sysName'},
				{header: "创建人", width:100, sortable: true, dataIndex: 'creatorName',hidden:true},
				{header: "创建日期", width:100, sortable: true, dataIndex: 'createTime',hidden:true}
	    	]
		});
		  /**
		*
		*端到端用例Grid
		*
		**/
		var AigaP2pCaseGrid = Ext.create('Ext.grid.Panel',{
			id:'AigaP2pCaseGrid',
	        cls: 'ui-formPanel',
	        margins : '0 0 0 3',
			height: screenHeight*0.29,
			//title:'用户体验测试用例库',
	        width: screenWidth*0.80,
			forctFit:true,
	        stripeRows:true,
	        loadMask:true, 
			store: AigaP2pCaseStore,
			selType:'rowmodel',
			listeners : {
				itemclick:function(_this, record, item, index, e, eOpts){
					Ext.getCmp('tbarCollectionCaseName').setValue(record.get('caseName'));
				}
			},
			columns:[
				  	new Ext.grid.RowNumberer({header　:　"序号", 　width　:　40}), 
					{header: "用例Id", width:100, sortable: true, dataIndex: 'funId',hidden:true},
					{header: "用例名称", width:250, sortable: true, dataIndex: 'caseName'},
					{header: "前置条件", width:350, sortable: true, dataIndex: 'precondition'},
					{header: "操作描述", width:350, sortable: true, dataIndex: 'operateDesc'},
					{header: "期望结果", width:350, sortable: true, dataIndex: 'expectation'},
					{header: "用例描述", width:250, sortable: true, dataIndex: 'caseDesc'},
					{header: "创建人", width:100, sortable: true, dataIndex: 'creatorName',hidden:true},
					{header: "创建日期", width:100, sortable: true, dataIndex: 'createTime',hidden:true}
	    	]
		});
	  /**
		*
		*端到端用例集Model
		*
		**/
    var AigaP2pBusiCaseCollectionModel = Ext.define('AigaP2pBusiCaseCollectionModel', {
        extend: 'Ext.data.Model',
        fields: [
                 {name: 'collectId',type: 'string'},
                 {name: 'busiTwoLevelId',type: 'int'},
                 {name: 'baseBusiId',type: 'int'},
                 {name: 'baseBusiName',type: 'string'},//
                 {name: 'channelId',type: 'int'}, 
                 {name: 'channelName',type: 'string'}, //
                 {name: 'funId',type: 'int' }, 
                 {name: 'sysName',type: 'string' }, 
                 {name: 'caseId',type: 'int'}, 
                 {name: 'caseName',type: 'string'}, 
                 {name: 'remark',type: 'string'}, 
                 {name: 'source',type: 'string'}, 
                 { name: 'cause',type: 'string'},
                 { name: 'casuseType',type: 'int'},
                 { name: 'status',type: 'int'},
                 { name: 'verifyStatus',type: 'int'},
                 { name: 'verifyStatusName',type: 'string'},//
                 { name: 'verifyResult',type: 'string'},
                 { name: 'createTime',type: 'string'},
                 { name: 'creatorId',type: 'int'},
                 { name: 'creatorName',type: 'string'},
                 { name: 'precondition',type: 'string'},
                 { name: 'operateDesc',type: 'string'},
                 { name: 'expectation',type: 'string'},
                 { name: 'caseDesc',type: 'string'},
                 { name: 'isDirty',type: 'int'},
                 { name: 'caseClass',type: 'string'},
                 { name: 'caseTwoLevelCount',type: 'int'},
                 { name: 'creatorName',type: 'string'}
        ]
    });
    /**
	*
	*端到端用例集Store
	*
	**/
	  var AigaP2pBusiCaseCollectionStore = new Ext.data.Store({
          id: 'AigaP2pBusiCaseCollectionStore',
          model: AigaP2pBusiCaseCollectionModel,
          proxy: {
              type: 'ajax',
              url: '<%=request.getContextPath()%>/getP2pBusiCaseCollection.do?busiTwoLevelId='+busiTwoLevelId,
              reader: {
                  type: 'json',
                  root: 'data'
              }
          },
          listeners:{
        	  add :function( records, index, eOpts ){
        		  submitGridStore();
        	  },
        	  remove:function( records, index, eOpts ){}
          }
      });
	  AigaP2pBusiCaseCollectionStore.load({params:{busiTwoLevelId:busiTwoLevelId}});
		/**
		*
		*端到端用例集Grid
		*
		**/
		var AigaP2pBusiCaseCollectionGrid = Ext.create('Ext.grid.Panel',{
			id:'AigaP2pBusiCaseCollectionGrid',
	        cls: 'ui-formPanel',
			title:'用户体验测试用例集',
	        margins : '0 0 0 3',
			height: screenHeight*0.39,
	        width: screenWidth,
	        /**
    		**编辑插件
    		**/
    		plugins:[
    			Ext.create('Ext.grid.plugin.CellEditing', {
                triggerEvent:'cellclick'
            })],
	        tbar:[
	              {xtype:'button',text: '',iconCls: 'save-button',handler: function() {submitGridStore();}},
				  //{xtype:'button',text: '',iconCls: 'add-button',handler: function() {addGridStore();}},
				  {xtype:'button',text: '',iconCls: 'del-button',handler: function() {delGridStore();}}
			],
			forctFit:true,
	        stripeRows:true,
	        loadMask:true, 
			store: AigaP2pBusiCaseCollectionStore,
			selType:'rowmodel',
			listeners : {
				itemdblclick:function(grid, record, item, index, e, eOpts ){
					if(record.get('caseTwoLevelCount')>1){
						alert('该用例被一个以上的业务引用，不允许修改!');return;
					}
		            var showP2PcaseForm = Ext.widget('form', {
		                layout: {type: 'vbox',align: 'stretch'},
		                border: false,
		                bodyPadding: 10,
		                fieldDefaults: {
		                    labelAlign: 'top',
		                    labelWidth: 100,
		                    labelStyle: 'font-weight:bold'
		                },
		                items: [{
		                    xtype: 'hidden',
		                    name:'caseId',
		                    value:record.get('caseId')
		                },{
		                    xtype: 'textfield',
		                    fieldLabel: '用例名称',
		                    name:'caseName',
		                    afterLabelTextTpl: required,
		                    value:record.get('caseName'),
		                    allowBlank: false
		                }, {
		                	 xtype: 'textareafield',
			                 fieldLabel: '前置条件',
			                 name:'precondition',
			                 labelAlign: 'top',
			                 flex: 1,
			                 margins: '0',
			                 afterLabelTextTpl: required,
			                 value:record.get('precondition'),
			                 allowBlank: false
		                }, {
		                	 xtype: 'textareafield',
			                 fieldLabel: '操作描述',
			                 name:'operateDesc',
			                 labelAlign: 'top',
				             flex: 1,
				             margins: '0',
				             afterLabelTextTpl: required,
				             value:record.get('operateDesc'),
				             allowBlank: false
		                } ,{
		                	 xtype: 'textareafield',
			                 fieldLabel: '预期结果',
			                 name:'expectation',
			                 labelAlign: 'top',
				             flex: 1,
				             margins: '0',
				             afterLabelTextTpl: required,
				             value:record.get('expectation'),
				             allowBlank: false
		                }, {
		                    xtype: 'textareafield',
		                    fieldLabel: '备注',
		                    name:'caseDesc',
		                    value:record.get('caseDesc'),
		                    labelAlign: 'top',
				             flex: 1,
				             margins: '0'
		                }
		                ],

		                buttons: [{
		                    text: '取消',
		                    handler: function() {
		                        this.up('form').getForm().reset();
		                        this.up('window').hide();
		                    }
		                }, {
		                    text: '确定',
		                    handler: function() {
		                        if (this.up('form').getForm().isValid()) {
		                            var json={};
		                            var fields=this.up('form').getForm().getFields();
		                        	MaskLoading();
		                        	fields.each(function(item){
		                        		json[item.getName()]=encodeURI(encodeURI(item.getValue()));
		                            });
		                        	var _this=this;
		    						Ext.Ajax.request({
		    							url:"<%=request.getContextPath()%>/checkP2pCase.do?busiTwoLevelId=${param.busiTwoLevelId}",
		    							params: json,
		    							success:function(response,config){
		    								var retJson=Ext.JSON.decode(response.responseText);
		    								MaskOver();
		    								if(retJson.success){
		    									fields.each(function(item){
		    		                            	record.set(item.getName(),item.getValue());
		    		                            });
		    									_this.up('form').getForm().reset();
		    									_this.up('window').hide();
		    								}else{
		    									alert('已经存在相同的用例名称');
		    									try{
		    										_this.up('form').getForm().getFields().items[1].focus(true);
		    									}catch(e){
		    									}
		    								}
		    							},
		    							failure:function(response,config){
		    								Ext.Msg.alert('提示','请求失败');
		    							}
		    						});
		    						MaskOver();
		    						return;
		                           
		                        }
		                    }
		                }]
		            });
		            
		         //   该用例被一个以上的业务引用，不允许修改。（使用时可删除关联该用例的记录。）
		            Ext.widget('window', {
		            	title: '创建用户体验测试用例',
		                closeAction: 'hide',
		                width: 400,
		                height: 400,
		                layout: 'fit',
		                resizable: true,
		                modal: true,
		                items: showP2PcaseForm
		                }).show();			
				},
				validateedit:function( editor, e, eOpts ){
					var originalValue=e.record.modified.caseName;
					var caseId=e.record.get('caseId');
					if(e.record.get('collectId')==''||e.record.get('collectId')==0){
						alert('新增的数据不能做变更');return false;
					}
				},
				edit :function( editor, e, eOpts ){
					var originalValue=e.record.modified.caseName;
					var caseId=e.record.get('caseId');
					if(e.record.get('collectId')==''||e.record.get('collectId')==0){
						alert('新增的数据不能做变更');
					}
					if(originalValue!=undefined&&e.field=='caseName'){
						var newValue=e.value;
						MaskLoading();
						Ext.Ajax.request({
							url:"<%=request.getContextPath()%>/checkP2pCase.do?busiTwoLevelId = ${param.busiTwoLevelId}",
							params:{
								caseName: encodeURI(encodeURI(newValue)),caseId :caseId
								},
							success:function(response,config){
								var retJson=Ext.JSON.decode(response.responseText);
								var funPoints=new Array();
								if(retJson.success){
								}else{
								alert('已经存在相同的用例名称');
								e.record.set('caseName',e.originalValue);
								}
							},
							failure:function(response,config){
								Ext.Msg.alert('提示','请求失败');
							}
						});
						MaskOver();
					}
					return;
				
				}
			},
			columns:[
			         new Ext.grid.RowNumberer({header　:　"序号", 　width　:　30}), 
				{header: "id", width:100, sortable: true, dataIndex: 'collectId',hidden:true},
				{header: "二级业务ID", width:100, sortable: true, dataIndex: 'busiTwoLevelId',hidden:true},
				{header: "基础功能", width:100, sortable: true, dataIndex: 'baseBusiName'},
				{header: "渠道", width:100, sortable: true, dataIndex: 'channelName'},
				{header: "功能点Id", width:100, sortable: true, dataIndex: 'funId',hidden:true},
				{header: "功能点", width:100, sortable: true, dataIndex: 'sysName'},
				{header: "用例类型", width:100, sortable: true, dataIndex: 'caseClass',hidden:true},
				{header: "用例ID", width:100, sortable: true, dataIndex: 'caseId',hidden:true},
				{header: "用例", width:200, sortable: true, dataIndex: 'caseName'},
				{header: "前置条件", width:200, sortable: true, dataIndex: 'precondition'},
				{header: "操作描述", width:200, sortable: true, dataIndex: 'operateDesc'},
				{header: "预期结果", width:200, sortable: true, dataIndex: 'expectation'},
				{header: "用例备注", width:200, sortable: true, dataIndex: 'caseDesc'},
				{header: "备注", width:100, sortable: true, dataIndex: 'remark',hidden:true},
				{header: "来源", width:150, sortable: true, dataIndex: 'source',hidden:true},
				{header: "原因", width:150, sortable: true, dataIndex: 'cause',hidden:true},
				{header: "原因类型", width:100, sortable: true, dataIndex: 'casuseTypeName',hidden:true},
				{header: "评审状态", width:100, sortable: true, dataIndex: 'verifyStatusName',hidden:true},
				{header: "评审结果", width:100, sortable: true, dataIndex: 'verifyResult',hidden:true},
				{header: "创建ID", width:100, sortable: true, dataIndex: 'creatorId',hidden:true},
				{header: "创建人", width:100, sortable: true, dataIndex: 'creatorName',hidden:true}
	    	]
		});
		var upPannel=new Ext.create('Ext.panel.Panel',{
			cls: 'ui-formPanel',
	        margins : 0,
	       // title:'添加功能体验测试功能点和用例',
	        width: screenWidth,
			height: screenHeight*0.29,
			minWidth: 1200-260,
			bodyBorder:0,
			listeners:{
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
				items:[{
					xtype:'panel',
					minWidth: 1200-260,
					minHeight: 150,
					width: screenWidth,
				    height: screenHeight*0.39,
				    cls: 'ui-formPanel',
					bodyBorder:0,
					listeners:{
					},
					layout: {
						type: 'vbox',      
						padding: 0
					},
					defaults: {
						split: true,           
						collapsible: false,           
						bodyStyle: 'padding:0px'
					},
					items: [{
						region: 'center',
						 layout: {
						        type: 'hbox',      
						        align: 'stretch', 
						        padding: 0
						    },
						items:[FunctionPointGrid,AigaP2pCaseGrid]
					}]
					
				}]
			}]
		});
	Ext.create('Ext.panel.Panel',{
		minWidth: 1200-260,
		minHeight: 350,
		width: screenWidth,
	    height: screenHeight + 5,
	    renderTo: Ext.getBody(),
	    cls: 'ui-formPanel',
		bodyBorder:0,
		listeners:{
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
			id:'mainItems',
			items:[tbarGrid,upPannel,AigaP2pBusiCaseCollectionGrid]
		}]
	});
});

</script>
</html>