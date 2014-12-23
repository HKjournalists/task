<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<%request.getSession().setAttribute("subTaskTag", request.getParameter("subTaskTag"));
request.getSession().setAttribute("normalMac", request.getParameter("normalMac"));
request.getSession().setAttribute("TemporaryTag", request.getParameter("TemporaryTag"));
request.getSession().setAttribute("funFolderId", request.getParameter("funId"));
 %>
<html>
<head>
<title>功能点</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ie-tab.css">
</head>
<body id="funBody">
</body>
<script type="text/javascript">
var isRefresh = false;
var isAppend = false;
var screenWidth = document.documentElement.clientWidth - 20;
var screenHeight = document.documentElement.clientHeight - 10;
var showTestSeceneWindow = function(secId){
	var list = getScene(secId,'copy');
	var testSeceneForm = list[0];
	var testElemGrid = list[1];
	var testSeceneWindow = new top.Ext.window.Window({
		id:'testSeceneWindow',
	    width : screenWidth*0.98,
	    height : screenHeight*0.98,
	    modal : true,
	    resizable:false,
	    autoScroll: true,
	    closeAction : 'destroy',
	    items:[testSeceneForm,testElemGrid]
	}).show();
};
Ext.regModel('extCommboModel', {
    fields: [
        {type: 'int', name: 'value'},
        {type: 'string', name: 'text'}
    ]
});

var maskerWithHtmlEl = function(htmlEl,msg){
	var mask = new top.Ext.LoadMask(htmlEl, {
		msg : msg,
		minHeight: 33,
		disabled : false
	});
	return mask;
};
var masker = function(msg){
	return maskerWithHtmlEl(top.window.document.body, msg);
};
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.tip.QuickTipManager.init();
	var pageLoadMask = new masker('页面加载中，请稍后');
	pageLoadMask.show();
	var mapModel = Ext.define('mapModel', {
        extend: 'Ext.data.Model',
        fields: [{name: 'constantId',type: 'string'}, 
            {name: 'categoryName',type: 'string'}, 
            {name: 'category',type: 'string'}, 
            {name: 'show', type: 'string'}, 
            {name: 'value',type: 'int'}, 
            {name: 'other1',type: 'string'}, 
            {name: 'other2',type: 'string'}, 
            {name: 'memo',type: 'string'}
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
    	Ext.Ajax.request({
			async:false,
			url:'<%=request.getContextPath()%>/getSeceneShow.do?funId=<%=request.getParameter("funId")%>',
			success:function(response,config){
				var json=Ext.JSON.decode(response.responseText);
				if(json.success==true)
					if(json!=null){
						json = json.data;
						mapStore.add(json);
					}
					else
						return;
				else{
					pageLoadMask.hide();
					Ext.Msg.alert("错误","后台获取用例界面场景下拉框信息失败");
				}
			},
			failure:function(response,config){
				pageLoadMask.hide();
				Ext.Msg.alert('操作','数据请求失败');
			}
		});
	
		Ext.Ajax.request({
			async:false,
			url:'<%=request.getContextPath()%>/getSubElemShow.do?funId=<%=request.getParameter("funId")%>',
			success:function(response,config){
				var json=Ext.JSON.decode(response.responseText);
				if(json.success==true)
					if(json!=null){
						json = json.data;
						mapStore.add(json);
					}
					else
						return;
				else{
					pageLoadMask.hide();
					Ext.Msg.alert("错误","后台获取用例界面要素值下拉框信息失败");
				}
			},
			failure:function(response,config){
				pageLoadMask.hide();
				Ext.Msg.alert('操作','数据请求失败');
			}
		});
    	if(isAppend==true)
    		return;
    	var funTypeStore = new Ext.data.Store({
			id: 'funTypeStore',
			fields: ['value', 'show'],
			proxy: {
				type: 'ajax',
				url: '<%=request.getContextPath()%>/getComBoxForFunFolder.do?query=funType',
				reader: {
					type: 'json',
					root: 'data'
				}
			}
		});
		funTypeStore.load();
		var funTypeCombox = new Ext.form.ComboBox({
		    width: 250,
		    hidden:true,
		    store: funTypeStore,
		    labelAlign: 'right',
		    name: "funType",
		    fieldLabel: "功能点类型",
		    valueField: 'value',
		    displayField: 'show',
		    listeners: {
		        beforequery: function (queryEvent, eOpts) {
		            queryEvent.query = "funTypeStore";
		        }
		    }
		});
		/**
		 * 重要级别
		 */
		var importantClassStore = new Ext.data.Store({
		    id: 'importantClassStore',
		    fields: ['value', 'show'],
		    proxy: {
		        type: 'ajax',
		        url: '<%=request.getContextPath()%>/getComBoxForFunFolder.do?query=importantClass',
		        reader: {
		        	type: 'json',
		       		root: 'data'
		       	}
		    }
		});
		importantClassStore.load();
		var importantClassCombox = new Ext.form.ComboBox({
		    width: 250,
		    store: importantClassStore,
		    labelAlign: 'right',
		    name: "importantClass",
		    fieldLabel: "重要级别",
		    valueField: 'value',
		    displayField: 'show',
		    listeners: {
		        beforequery: function (queryEvent, eOpts) {
		            queryEvent.query = "importantClassStore";
		        }
		    }
		});
		/**
		 * 所属系统
		 */
		var sysIdStore = new Ext.data.Store({
		    id: 'sysIdStore',
		    fields: ['value', 'show'],
		    proxy: {
		        type: 'ajax',
		        url: '<%=request.getContextPath()%>/getComBoxForSystemFolder.do',
		        reader: {
		        	type: 'json',
		       		root: 'data'
		       	}
		    }
		});
		sysIdStore.load();
		var sysIdCombox = new Ext.form.ComboBox({
		    width: 250,
		    hidden:true,
		    store: sysIdStore,
		    labelAlign: 'right',
		    id: "sysId",
		    name: "sysId",
		    fieldLabel: "归属系统",
		    valueField: 'value',
		    displayField: 'show',
		    listeners: {
		        beforequery: function (queryEvent, eOpts) {
		            queryEvent.query = "sysIdStore";
		        }
		    }
		});
	   //------功能点信息---
		var funFolderForm = Ext.widget('form', {
			id: 'funFolderForm',
			minWidth: 1200-260,
			minHeight: 120,
			width: screenWidth,
			height:screenHeight*0.2,
			border:0,
			title: '功能点信息',
			layout: {
				type: 'vbox'
			},
			listeners:{
				render: function (render, eOpts) { 
					funFolderForm.load({
					    params: {
					    	funId: <%=request.getParameter("funId")%>
						},
						url: '<%=request.getContextPath()%>/getFunFolderByFunId.do',
				        method: 'POST',
				        success: function (form, action) {
							var funType = action.result.data.funType;
							if(funType==0){
								Ext.getCmp('funFolderForm').getForm().findField('funType').setValue("");
							}
							var importantClass = action.result.data.importantClass;
							if(importantClass==0){
								Ext.getCmp('funFolderForm').getForm().findField('importantClass').setValue("");
							}
							var sysId = action.result.data.sysId;
							if(sysId==0){
								Ext.getCmp('funFolderForm').getForm().findField('sysId').setValue("");
							}
							Ext.getCmp('funFolderForm').getForm().findField('sysName').setReadOnly(true);
							Ext.getCmp('funFolderForm').getForm().findField('importantClass').setReadOnly(true);
							Ext.getCmp('funFolderForm').getForm().findField('menuPath').setReadOnly(true);
							var value = Ext.getCmp('funFolderForm').getForm().findField('menuPath').getValue();
							value = Ext.util.Format.htmlDecode(value);
							Ext.getCmp('funFolderForm').getForm().findField('menuPath').setValue(value);
							Ext.getCmp('getDetail').enable(true);
						},
						failure: function (form, action) {
						    Ext.Msg.alert('提示', "失败原因是: " + action.result.errorMessage);
						}
					});
				}
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
			items: [
			{
	        	xtype: 'fieldcontainer',
	            labelStyle: 'font-weight:bold;padding:0',
	            layout: 'hbox',
	            defaultType: 'textfield',
	            items: [{
						width: 500,
						labelAlign: 'right',
						id:'sysName',
						name: 'sysName',
						fieldLabel: '功能点名称',
						allowBlank: false
	            	},{
		                xtype: 'hidden',
		                id:'funId',
		                name: 'funId',
		                fieldLabel: '功能点id'
	            	},
	            	funTypeCombox,
	            	importantClassCombox
	            ]
			},{
	        	xtype: 'fieldcontainer',
	            labelStyle: 'font-weight:bold;padding:0',
	            layout: 'hbox',
	            items: [
	            	sysIdCombox
	            ]
			},{
	        	xtype: 'fieldcontainer',
	            labelStyle: 'font-weight:bold;padding:0',
	            layout: 'hbox',
	            defaultType: 'textfield',
	            items: [
	            	{
		            	width: 800,
		                labelAlign: 'right',
		                id:'menuPath',
		                name: 'menuPath',
		                fieldLabel: '菜单路径',
		                allowBlank: false
	            	},
	            	{
	            		id:'getDetail',
	            		xtype:'button',
	            		text:'查看详细信息',
	            		handler:function(){
	            			var funId = funFolderForm.getForm().findField('funId').getValue();
	            			var detailWindow = new Ext.window.Window({
	            				id:'detailWindow',
							    title : '功能点详细信息',
							    width : 1030,
							    height : 400,
							    modal : true,
							    closeAction : 'destroy',
							    html:'<iframe id="frame" scrolling="no" name="frame" src="<%=request.getContextPath()%>/aiga/userCase/funFolderCreate.jsp?funId='+funId+'&flag=alter&isViewer=yes" width="1030" height="400"/>'
	            			}).show();
	            		}
	            	}
	            ]
			},{
	               xtype: 'fieldcontainer',
	               labelStyle: 'font-weight:bold;padding:0',
	               layout: 'hbox',
	               defaultType: 'textarea',
	               fieldDefaults: {
	                   labelAlign: 'right'
	               },
	               items: [{
	                       width: 1000,
	                       height: 50,
	                       labelAlign: 'right',
	                       name: 'dataCheckScript',
	                       fieldLabel: '数据检查脚本',
	                       allowBlank: false,
	                       hidden:true
	                   }
	               ]
	           },{
	               xtype: 'fieldcontainer',
	               labelStyle: 'font-weight:bold;padding:0',
	               layout: 'hbox',
	               defaultType: 'textarea',
	               fieldDefaults: {
	                   labelAlign: 'right'
	               },
	               items: [{
	                       width: 1000,
	                       height: 50,
	                       labelAlign: 'right',
	                       name: 'funDesc',
	                       fieldLabel: '功能点描述',
	                       allowBlank: false,
	                       hidden:true
	                   }
	               ]
	           }
			]
		});
		//------功能点信息---end
		var testElemModel = Ext.regModel('testElemModel', { 
			fields: [
				{name: 'elemId',type: 'string'}, 
				{name: 'elemTag',type: 'string'}, 
				{name: 'elemName',type: 'string'},
				{name: 'elemSysAchieveType',type: 'string'},
				{name: 'applicateSys',type: 'string'},
				{name: 'isGlobalElem',type: 'string'},
				{name:'sysId',type:'string'},
				{name:'subElemId',type:'string'},
				{name:'elemValue',type:'string'},
				{name:'elemTestLogic',type:'string'},
				{name:'takeValueMethod',type:'string'},
				{name:'relaOrder',type:'string'},
				{name:'valueRemark',type:'string'}
			] 
		});
		var elemMasker = new masker('正在加载测试要素信息，请稍后');
		var testElemStore = new Ext.data.TreeStore({ 
			model: testElemModel,  
			proxy: { 
				type: 'ajax',  
				url: '<%=request.getContextPath()%>/getTestElemTable.do?funId=<%=request.getParameter("funId")%>&type=edit'
			}, 
			root: {
				id:-1,
				text: '测试要素',
				expanded: true
			},
			reader: { 
				type: 'json', 
				root: 'children' 
			},
			listeners:{
				beforeload:function(){elemMasker.show();},
				load:function(){elemMasker.hide();}
			}
		});
		//-------测试要素-----
		var testElemGrid = Ext.create('Ext.tree.Panel',{
		//----toobar----------
			tbar:Ext.create('Ext.Toolbar',{
				items:[{
						text:'新增测试要素',
						handler:function(){
							var list = getElem(0,'add');
							var testElemForm = list[0];
							var subElemGrid = list[1];
							testElemForm.getForm().findField('elemTag').setValue('TESTELEM'+Ext.util.Format.date(new Date(),'YmdHisu'));
							var testElemWindow = new top.Ext.window.Window({
								id:'testElemWindow',
							    width : screenWidth*0.891,
							    height : screenHeight*0.88,
							    autoScroll : true,
							    modal : true,
							    resizable:false,
							    closeAction : 'destroy',
							    listeners:{
							    	beforeclose:function(panel,eOpts){
							    		var rootNode = testElemStore.getNodeById(-1);
							    		testElemStore.load(rootNode);
							    		return true;
							    	}
							    },
							    items:[testElemForm,subElemGrid]
							}).show();
						}
					},{
						text:'关联测试要素',
						handler:function(){
							var testElemMasker = new masker('正在加载要素信息，请稍后');
							testElemMasker.show();
							var testElemRStore = new Ext.data.TreeStore({ 
								id:'testElemRStore',
								model: testElemModel,  
								proxy: { 
									type: 'ajax',  
									url: '<%=request.getContextPath()%>/getTestElemRTable.do?funId=<%=request.getParameter("funId")%>&sysId=<%=request.getParameter("sysId")%>'
								}, 
								root: {
									id:-1,
									text: '测试要素',
									expanded: true
								},
								reader: { 
									type: 'json', 
									root: 'children' 
								},
								listeners:{
									load:function(){testElemMasker.hide();}
								}
							});   
							var testElemRGrid = top.Ext.create('Ext.tree.TreePanel',{
								tbar:top.Ext.create('Ext.Toolbar',{
									items:[{
											text:'确定',
											handler:function(){
												var treeNode=top.Ext.getCmp('testElemRGrid').getChecked();
												if(treeNode == null||treeNode.length==0){
													top.Ext.Msg.alert("提示","请选择要关联的要素");					
													return;
												}
												var relaMasker = new maskerWithHtmlEl(testElemWindow,'正在关联要素中,请稍后');
												relaMasker.show();
												var elemIds = new Array();
												for(var i=0,n=treeNode.length;i<n;i++){elemIds.push(treeNode[i].raw.elemId);}
												Ext.Ajax.request({
													url:'<%=request.getContextPath()%>/saveFunElemRela.do?funId=<%=request.getParameter("funId")%>&elemIds='+elemIds.join(","),
													success:function(response,config){
														var json=Ext.JSON.decode(response.responseText);
														if(json.success==true){
															if(json.data.length>0){
																relaMasker.hide();
																top.Ext.Msg.alert("提示",json.data);
															}else{
																var rootNode = testElemStore.getNodeById(-1);
											 					testElemStore.load(rootNode);
																relaMasker.hide();
																top.Ext.Msg.alert("提示","关联成功");
															}
														}else{
															if(json.errorInfo!=null&&json.errorInfo.length>0){
																relaMasker.hide();
																top.Ext.Msg.alert("错误","<font color='red'>关联失败</font>,"+json.errorInfo);
															}else{
																relaMasker.hide();
																top.Ext.Msg.alert("错误","<font color='red'>关联失败</font>,后台关联要素时出现异常");
															}
														}
														testElemWindow.close();
													},
													failure:function(response,config){
														relaMasker.hide();
														top.Ext.Msg.alert("提示","当前网络不畅，请稍后再试");
													}
												});
											}
										},{
										    width: 170,
										    labelWidth: 70,
										    xtype: 'textfield',
										    id: 'tbarElemName',
										    name:'tbarElemName',
										    fieldLabel: '要素名称'
										},{text:'搜索',
											xtype:'button',
											handler:function(){
												var elemName=top.Ext.getCmp("tbarElemName").getValue();
												elemName=encodeURI(encodeURI(elemName));
												var testElemRStore=Ext.data.StoreManager.lookup('testElemRStore');
												testElemRStore.load({params:{elemName:elemName}});
											}
										}
									]
								}),
								id:'testElemRGrid',
						        cls: 'ui-formPanel',
								title:'测试要素',
								border:0,
								minHeight: 130,
								minWidth: 1200-260-50,
								height: 490,
							    width: screenWidth - 20,
								viewConfig:{
									forctFit:true,
									stripeRows:true
								},
								store:testElemRStore,
								rootVisible: false,
								columns:[
									{text:"主键",width:100,dataIndex:"subElemId",sortable:false,hidden:true},
									{text:"主键",width:100,dataIndex:"elemId",sortable:false,hidden:true},
									{text:"外键",width:100,dataIndex:"sysId",sortable:false,hidden:true},
									{xtype: 'treecolumn',text:"要素名称",width:200,dataIndex:"elemName",sortable:false},
									{text:"要素编号",width:150,dataIndex:"elemTag",sortable:false,hidden:true},
									{text:"要素类型",width:120,dataIndex:"elemSysAchieveType",sortable:false,
										renderer: function (value, cellmeta, record){
											try {
											    var store = Ext.data.StoreManager.lookup("mapStore");
											    store.clearFilter(true);
											    store.filter("categoryName", "elemType");
											    return store.findRecord("value", value).getData().show + "";
											} catch (e) {
											    return ""+value;
											};
										}
									},
									{text:"适用系统",width:100,dataIndex:"applicateSys",sortable:false,hidden:true},
									{text:"是否全局要素",width:100,dataIndex:"isGlobalElem",sortable:false,
										renderer: function (value, cellmeta, record) {
											try {
											    var store = Ext.data.StoreManager.lookup("mapStore");
											    store.clearFilter(true);
											    store.filter("categoryName", "isGlobal");
											    return store.findRecord("value", value).getData().show + "";
											} catch (e) {
											    return ""+value;
											};
										}
									},
									{text:"要素值",width:100,dataIndex:"elemValue",sortable:false},
									{text:"要素测试逻辑",width:100,dataIndex:"elemTestLogic",sortable:false,hidden:true},
									{text:"取数方法",width:100,dataIndex:"takeValueMethod",sortable:false},
									{text:"备注",width:100,dataIndex:"valueRemark",sortable:false}
								]
							});
							var testElemWindow = new top.Ext.window.Window({
								id:'testElemWindow',
							    width : 780,
							    height : 536,
							    modal : true,
							    resizable:false,
							    closeAction : 'destroy',
							    items:[testElemRGrid]
							}).show();
						}
					},{
						text:'保存顺序',
						handler:function(){
							var orderMasker = new masker('正在保存要素顺序，请稍后');
							orderMasker.show();
							var orderArray = new Array();
							var rootNode = testElemStore.getNodeById(-1);
							var i=0;
							rootNode.eachChild(function(child){
								var id = child.data.elemId;
								var childJson = {};
								childJson[id]=i;
								orderArray.push(childJson);
								i++;
							});
							Ext.Ajax.request({
								url:'<%=request.getContextPath()%>/saveElemOrder.do?funId=<%=request.getParameter("funId")%>&order='+Ext.encode(orderArray),
								success:function(response,config){
									var json=Ext.JSON.decode(response.responseText);
									if(json.success==true){
										var rootNode = testElemStore.getNodeById(-1);
								    	testElemStore.load(rootNode);
								    	orderMasker.hide();
										top.Ext.Msg.alert("提示","保存成功");
									}else{
										orderMasker.hide();
										top.Ext.Msg.alert("错误","<font color='red'>保存失败</font>,后台保存测试要素顺序出现错误");
									}
								},
								failure:function(response,config){
									orderMasker.hide();
									top.Ext.Msg.alert("提示","当前网络不畅，请稍后再试");
								}
							});
						}
					},{
						text:'删除',
						handler:function(){
							var treeNode=Ext.getCmp('testElemGrid').getChecked();
							var msg = "";
							if(treeNode == null||treeNode.length==0){
								Ext.Msg.alert("提示","请选择要删除的要素");
								return;
							}
							var ids = new Array();
							for(var i=0,n=treeNode.length;i<n;i++){ids.push(treeNode[i].raw.elemId);}
							Ext.Ajax.request({
								async:false,
								url:'<%=request.getContextPath()%>/getElemDeleteMsg.do?funId=<%=request.getParameter("funId")%>&elemIds='+ids.join(","),
								success:function(response,config){
									var json = Ext.JSON.decode(response.responseText);
									if(json.success==true){
										msg = json.data;
										if(msg.length>0){
											top.Ext.Msg.alert("提示",msg);
										}
									}else{
										msg = "<font color='red'>后台获取删除提示信息出错,但该错误并不影响该操作</font>";
									}
								},
								failure:function(response,config){Ext.Msg.alert("提示","请求数据失败,当前网络繁忙,请稍后再试！");}
							});
							if(msg.length==0){
								Ext.MessageBox.confirm('操作提示','确定要删除这些要素吗?',function(optional){
									if(optional=='yes'){
										var deleteMasker = new masker('正在删除要素信息，请稍后');
										deleteMasker.show();
										var elemIds = new Array();
										for(var i=0,n=treeNode.length;i<n;i++){elemIds.push(treeNode[i].raw.elemId);}
										Ext.Ajax.request({
											url:'<%=request.getContextPath()%>/deleteTestElemRela.do?funId=<%=request.getParameter("funId")%>&elemIds='+elemIds.join(","),
											success:function(response,config){
												var json=Ext.JSON.decode(response.responseText);
												if(json.success==true){
													var rootNode = testElemStore.getNodeById(-1);
											    	testElemStore.load(rootNode);
											    	var tp = Ext.getCmp('testSeceneGrid');  
													var testSeceneStore = tp.getStore();
													var root = tp.getStore().getProxy();  
													root.extraParams.flag = 'sec';  
													root.extraParams.treeId = '<%=request.getParameter("funId")%>';  
											    	testSeceneStore.load();
											    	testSeceneRStore.reload({params:{funId:'<%=request.getParameter("funId")%>'}});
											    	deleteMasker.hide();
													Ext.Msg.alert("提示","删除成功");
												}else{
													deleteMasker.hide();
													Ext.Msg.alert("错误","<font color='red'>删除失败</font>,后台删除要素时出现异常");
												}
											},
											failure:function(response,config){
												deleteMasker.hide();
												Ext.Msg.alert("提示","当前网络不畅，请稍后再试");
											}
										});
									}
								});
							}
						}
					}
				]
			}),
			//----toobar----end---
			id:'testElemGrid',
		    //cls: 'ui-formPanel',
			title:'测试要素分析',
			border:0,
			minWidth: 1200 - 260 - 30,
			minHeight: 150,
			width: screenWidth - 20,
		    height: screenHeight*0.8 - 10,
			store:testElemStore,
			rootVisible: false,
			viewConfig:{
				//forctFit:true,
				stripeRows:true,
				plugins: {ptype: 'treeviewdragdrop'},
				listeners:{
		        	beforedrop:function(node,Object,overModel,dropPosition,eOpts){
		        		return (Object.records[0].raw.leaf==false&&overModel.raw.leaf==false)?((dropPosition=='append')?false:true):false;
			    	}
		        } 
			},
			listeners:{
				itemdblclick:function(grid, record, item, index, e, eOpts ){
					var isLeaf = record.raw.leaf;
					if(isLeaf==false){
						var list = getElem(record.raw.elemId,'edit');
						var testElemForm = list[0];
						var subElemGrid = list[1];
						var testElemWindow = new top.Ext.window.Window({
							id:'testElemWindow',
						    width : screenWidth*0.891,
						    height : screenHeight*0.88,
						    autoScroll : true,
						    modal : true,
						    resizable:false,
						    closeAction : 'destroy',
						    listeners:{
						    	beforeclose:function(panel,eOpts){
						    		var rootNode = testElemStore.getNodeById(-1);
						    		testElemStore.load(rootNode);
						    		return true;
						    	}
						    },
						    items:[testElemForm,subElemGrid]
						}).show();
					}
				}
			},
			columns:[
				{text:"主键",width:100,dataIndex:"subElemId",sortable:false,hidden:true},
				{text:"主键",width:100,dataIndex:"elemId",sortable:false,hidden:true},
				{text:"外键",width:100,dataIndex:"sysId",sortable:false,hidden:true},
				{xtype: 'treecolumn',text:"要素名称",width:200,dataIndex:"elemName",sortable:false},
				{text:"要素编号",width:150,dataIndex:"elemTag",sortable:false,hidden:true},
				{text:"要素类型",width:120,dataIndex:"elemSysAchieveType",sortable:false,
					renderer: function (value, cellmeta, record) {
		               try {
		                   var store = Ext.data.StoreManager.lookup("mapStore");
		                   store.clearFilter(true);
		                   store.filter("categoryName", "elemType");
		                   return store.findRecord("value", value).getData().show + "";
		               } catch (e) {
		                   return ""+value;
		               };
		           }
		        },
				{text:"适用系统",width:100,dataIndex:"applicateSys",sortable:false,hidden:true},
				{text:"是否全局要素",width:100,dataIndex:"isGlobalElem",sortable:false,
					renderer: function (value, cellmeta, record) {
		               try {
		                   var store = Ext.data.StoreManager.lookup("mapStore");
		                   store.clearFilter(true);
		                   store.filter("categoryName", "isGlobal");
		                   return store.findRecord("value", value).getData().show + "";
		               } catch (e) {
		                   return ""+value;
		               };
		           }
		        },
				{text:"要素顺序",width:100,dataIndex:"relaOrder",sortable:false,hidden:true},
				{text:"要素值",width:100,dataIndex:"elemValue",sortable:false},
				{text:"要素测试逻辑",width:100,dataIndex:"elemTestLogic",sortable:false,hidden:true},
				{text:"取数方法",width:100,dataIndex:"takeValueMethod",sortable:false},
				{text:"备注",width:100,dataIndex:"valueRemark",sortable:false}
			]
		});
		//-----测试要素----end
		var testSeceneModel = Ext.regModel('testElemModel', {
			fields: [ 
				{name: 'elemId',type: 'string'}, 
				{name: 'elemTag',type: 'string'}, 
				{name: 'elemName',type: 'string'},
				{name: 'elemSysAchieveType',type: 'string'},
				{name: 'applicateSys',type: 'string'},
				{name: 'isGlobalElem',type: 'string'},
				{name:'sysId',type:'string'},
				{name:'subElemId',type:'string'},
				{name:'elemValue',type:'string'},
				{name:'elemTestLogic',type:'string'},
				{name:'takeValueMethod',type:'string'},
				{name:'secId',type:'string'},
				{name:'elemId',type:'string'},
				{name:'seceneName',type:'string'},
				{name:'analysisMethod',type:'string'},
				{name:'secOrder',type:'string'}
			]
		});
		var seceneMasker = new masker('正在加载场景信息，请稍后');
		var testSeceneStore = new Ext.data.TreeStore({ 
			model: testSeceneModel,  
			proxy: {
				type: 'ajax',  
				url: '<%=request.getContextPath()%>/getSeceneTable.do',
				extraParams:{  
					flag:'sec',
					treeId:'<%=request.getParameter("funId")%>'
				}
			}, 
			root: {
				id:-1,
				text: '测试要素',
				expanded: true
			},
			reader: { 
				type: 'json', 
				root: 'children' 
			},
			listeners:{
				beforeload:function(){seceneMasker.show();},
				load:function(){seceneMasker.hide();}
			}
		});
		//-----测试场景-------
		var testSeceneGrid = Ext.create('Ext.tree.TreePanel',{
			tbar:Ext.create('Ext.Toolbar',{
				items:[{
						text:'新增测试场景',
						handler:function(){
							var list = getScene(0,"add");
							var testSeceneForm = list[0];
							var testElemGrid = list[1];
							var testSeceneWindow = new top.Ext.window.Window({
								id:'testSeceneWindow',
							    width : screenWidth * 0.9,
							    height : screenHeight * 0.8,
							    autoScroll: true,
							    modal : true,
							    resizable:false,
							    closeAction : 'destroy',
							    items:[testSeceneForm,testElemGrid]
							}).show();
						}
					},{
						text:'保存场景顺序',
						handler:function(){
							var seceneOrderMasker = new masker('正在保存场景顺序，请稍后');
							seceneOrderMasker.show();
							var orderArray = new Array();
							var rootNode = testSeceneStore.getNodeById(-1);
							var i=0;
							rootNode.eachChild(function(child){
								var id = child.data.secId;
								var childJson = {};
								childJson[id]=i;
								childJson.elemOrder=new Array();
								var j=0;
								child.eachChild(function(childNode){
									var elemJson = {};
									var elemId = childNode.data.elemId;
									elemJson[elemId]=j;
									childJson.elemOrder.push(elemJson);
									j++;
								});
								orderArray.push(childJson);
								i++;
							});
							Ext.Ajax.request({
								url:'<%=request.getContextPath()%>/saveSecOrder.do?funID=<%=request.getParameter("funId")%>&order='+Ext.encode(orderArray),
								success:function(response,config){
									var json = Ext.JSON.decode(response.responseText);
									if(json.success==true){
										var tp = Ext.getCmp('testSeceneGrid');  
										var testSeceneStore = tp.getStore();
										var root = tp.getStore().getProxy();  
										root.extraParams.flag = 'sec';  
										root.extraParams.treeId = '<%=request.getParameter("funId")%>';  
										testSeceneStore.load();
										Ext.data.StoreManager.lookup("mapStore").reload();
										seceneOrderMasker.hide();
										Ext.Msg.alert("提示","保存成功");
									}else{
										seceneOrderMasker.hide();
										Ext.Msg.alert("错误","<font color='red'>保存失败</font>,后台保存场景顺序出现异常");
									}
								},
								failure:function(response,config){
									seceneOrderMasker.hide();
									Ext.Msg.alert("提示","当前网络不畅，请稍后再试");
								}
							});
						}
					},{
						text:'删除',
						handler:function(){
							var delSecArray = new Array();
							var treeNodes=testSeceneGrid.getChecked();
							if(treeNodes==null||treeNodes.length==0){
								Ext.Msg.alert("提示","请选择要删除的场景");			
								return;
							}
							var msg = "";
							var ids = new Array();
							for(var i=0,n=treeNodes.length;i<n;i++){ids.push(treeNodes[i].raw.secId);}
							Ext.Ajax.request({
								async:false,
								url:'<%=request.getContextPath()%>/getSecDeleteMsg.do?secIds='+ids.join(","),
								success:function(response,config){
									var json = Ext.JSON.decode(response.responseText);
									if(json.success==true){
										msg = json.data;
										if(msg.length>0){
											Ext.Msg.alert("提示",msg);
										}
									}else{
										msg = "<font color='red'>获取场景删除提示信息出现异常，该异常并不影响此操作！</font>";
									}
								},
								failure:function(response,config){Ext.Msg.alert("提示","请求删除提示失败");}
							});
							if(msg.length==0){
								Ext.MessageBox.confirm('操作提示','确定要删除这些场景吗?',function(optional){
									if(optional=='yes'){
										var delSecMasker = new masker('正在删除场景信息，请稍后');
										delSecMasker.show();
										for(var i=0,n=treeNodes.length;i<n;i++){delSecArray.push(treeNodes[i].raw.secId);}
										Ext.Ajax.request({
											url:'<%=request.getContextPath()%>/deleteSecAndRela.do?secIds='+delSecArray,
											success:function(response,config){
												var json = Ext.JSON.decode(response.responseText);
												if(json.success==true){
													var tp = Ext.getCmp('testSeceneGrid');  
													var testSeceneStore = tp.getStore();
													var root = tp.getStore().getProxy();  
													root.extraParams.flag = 'sec';  
													root.extraParams.treeId = '<%=request.getParameter("funId")%>';  
													testSeceneStore.load();
													testSeceneRStore.reload({params:{funId:'<%=request.getParameter("funId")%>'}});
													Ext.data.StoreManager.lookup("mapStore").reload();
													delSecMasker.hide();
													Ext.Msg.alert('提示','删除成功');
												}else{
													delSecMasker.hide();
													Ext.Msg.alert("错误","<font color='red'>删除失败</font>,删除场景时后台出现异常");
												}
											},
											failure:function(response,config){
												delSecMasker.hide();
												Ext.Msg.alert('提示','当前网络不畅，请稍后再试');
											}
										});
									}
								});
							}
						}
					}
				]
			}),
			id:'testSeceneGrid',
			cls: 'ui-formPanel',
			title:'测试场景',
			border:0,
			minWidth: 1200 - 260 - 30,
			minHeight: 150,
			width: screenWidth - 20,
			height: screenHeight*0.8 - 10,
			store:testElemStore,
			rootVisible: false,
			viewConfig:{
				forctFit:true,
				stripeRows:true,
				plugins: {ptype: 'treeviewdragdrop'},
				listeners:{
					beforedrop:function(node,Object,overModel,dropPosition,eOpts){
						if(Object.records[0].raw.type=='elem'||Object.records[0].raw.type=='sec'){
							if(Object.records[0].raw.type=='elem'&&overModel.raw.type=='elem'){
								if(dropPosition=='append')
									return false;
								else
									return true;
							}else if(Object.records[0].raw.type=='sec'&&overModel.raw.type=='sec'){
								if(dropPosition=='append')
									return false;
								else
									return true;
							}else
								return false;
						}
						else{
							return false;
						}
					}
				}
			},
			store:testSeceneStore,
			listeners:{
				itemdblclick:function(grid, record, item, index, e, eOpts ){
					if(record.raw.type=='sec'){
						var list = getScene(record.raw.secId,'edit');
						var testSeceneForm = list[0];
						var testElemGrid = list[1];
						var testSeceneWindow = new top.Ext.window.Window({
							id:'testSeceneWindow',
						    width : screenWidth*0.9,
						    height : screenHeight*0.9,
						    modal : true,
						    resizable:false,
						    autoScroll: true,
						    closeAction : 'destroy',
						    items:[testSeceneForm,testElemGrid]
						}).show();
					}
				},
				beforeitemexpand:function(record,eOpts){
					var tp = Ext.getCmp('testSeceneGrid');  
					var root = tp.getStore().getProxy();  
					if(record.raw.type=='sec'){
						root.extraParams.flag = 'elem';  
						root.extraParams.treeId = record.raw.value;  
					}
					if(record.raw.type=='elem'){
						root.extraParams.flag = 'subelem';  
						root.extraParams.treeId = record.raw.value;  
					}
				}
			},
			columns:[
				{text:"主键",width:100,dataIndex:"secId",sortable:false,hidden:true},
				{xtype: 'treecolumn',text:"场景名称",width:150,dataIndex:"seceneName",sortable:false},
				{text:"分析方法",width:100,dataIndex:"analysisMethod",sortable:false,
					renderer: function (value, cellmeta, record) {
					    try {
					        var store = Ext.data.StoreManager.lookup("mapStore");
					        store.clearFilter(true);
					        store.filter("categoryName", "analysisMethod");
					        return store.findRecord("value", value).getData().show + "";
					    } catch (e) {
					        return ""+value;
					    };
					}
				},
				{text:"要素名称",width:150,dataIndex:"elemName",sortable:false},
				{text:"要素值",width:100,dataIndex:"elemValue",sortable:false},
				{text:"场景顺序",width:100,dataIndex:"secOrder",sortable:false,hidden:true},
				{text:'操作', width:50,menuDisabled: true,xtype:'actioncolumn',sortable:false,
					renderer :function(){
						var store = arguments[6].getStore();
						var rowIndex = arguments[3];
						var curRecord = store.getAt(rowIndex);
						var returnHtml = '';
						if(curRecord.raw.type=='sec')
							returnHtml = '<img src="<%=request.getContextPath()%>/css/images/copy-font.gif" onclick="showTestSeceneWindow('+curRecord.raw.secId+')" />';
						return returnHtml;
					}
				}
			]
		});
		//-----测试场景-------end
		var testSeceneRModel = Ext.regModel("testSeceneRModel",{
			fields:[
				{name:'caseId',type:'string'},
				{name:'caseName',type:'string'},
				{name:'secId',type:'string'},
				{name:'casePreCond',type:'string'},
				{name:'caseOperateInst',type:'string'},
				{name:'preResult',type:'string'},
				{name:'hasTest',type:'string'}
			]
		});
		var testSeceneRProxy = new Ext.data.proxy.Ajax({
			type:"ajax",
			model:testSeceneRModel,
			url:'<%=request.getContextPath()%>/getRSeceneCaseTable.do',
			reader:{
				root:"data",
				type:"json"
			}
		});
		var testSeceneRMasker = new masker('正在加载用例信息，请稍后');
		var testSeceneRStore = Ext.create('Ext.data.Store',{
			model:testSeceneRModel,
			proxy:testSeceneRProxy,
			listeners:{
				beforeload:function(){testSeceneRMasker.show();},
				load:function(){testSeceneRMasker.hide();}
			}
		});
		testSeceneRStore.load({params:{funId:'<%=request.getParameter("funId")%>'}});
		//-------测试用例--------
		var testSeceneRGrid = Ext.create('Ext.grid.Panel',{
			tbar:Ext.create('Ext.Toolbar',{
				items:[{
						text:'新增测试用例',
						handler:function(){
							var caseForm = getCaseForm(0,0,'add');
							var caseFormWindow = new top.Ext.window.Window({
								id:'caseFormWindow',
							    width : screenWidth*0.96,
							    height : screenHeight,
							    modal : true,
							    resizable:false,
							    closeAction : 'destroy',
							    autoScroll : true,
							    items:[caseForm],
								listeners:{
									beforeclose:function(panel,eOpts){
										testSeceneRStore.load({params:{funId:'<%=request.getParameter("funId")%>'}});
						 				return true;
									}
								}
							});
							caseFormWindow.show();
						}
					},{
						text:'删除',
						handler:function(){
							var selections = testSeceneRGrid.getSelectionModel().getSelection();
							if(selections==null||selections.length==0){
								Ext.Msg.alert("提示","请选择要删除的用例");
								return;
							}
							var caseIds = new Array();
							for(var i=0,n=selections.length;i<n;i++){caseIds.push(selections[i].data.caseId);}
							Ext.Ajax.request({
								url:'<%=request.getContextPath()%>/checkQuote.do?funId=<%=request.getParameter("funId")%>&caseIds='+caseIds.join(","),
								success:function(response,config){
									var json = Ext.JSON.decode(response.responseText);
									if(json.success==true){
										if(json.isQuoteCase.length>0){
											Ext.MessageBox.confirm('操作提示','用例'+json.isQuoteCase+'已被其他功能点引用，确定要删除吗？',function(optional){
												if(optional=='yes'){
													var delCaseMasker = new masker('正在删除用例信息，请稍后');
													delCaseMasker.show();
													Ext.Ajax.request({
														url:'<%=request.getContextPath()%>/deleteCaseByIdsForNew.do?funId=<%=request.getParameter("funId")%>&caseIds='+caseIds.join(","),
														success:function(response,config){
															var json = Ext.JSON.decode(response.responseText);
															if(json.success==true){
																testSeceneRStore.reload({params:{funId:'<%=request.getParameter("funId")%>'}});
																delCaseMasker.hide();
																Ext.Msg.alert("提示","删除成功");
															}else{
																delCaseMasker.hide();
																Ext.Msg.alert("错误","<font color='red'>删除失败</font>,删除用例时后台出现异常");
															}
														},
														failure:function(response,config){
															delCaseMasker.hide();
															Ext.Msg.alert("提示","当前网络不畅，请稍后再试");
														}
													});
												}
											});
										}else{
											var delCaseMasker = new masker('正在删除用例信息，请稍后');
											delCaseMasker.show();
											Ext.Ajax.request({
												url:'<%=request.getContextPath()%>/deleteCaseByIdsForNew.do?funId=<%=request.getParameter("funId")%>&caseIds='+caseIds.join(","),
												success:function(response,config){
													var json = Ext.JSON.decode(response.responseText);
													if(json.success==true){
														testSeceneRStore.reload({params:{funId:'<%=request.getParameter("funId")%>'}});
														delCaseMasker.hide();
														Ext.Msg.alert("提示","删除成功");
													}else{
														delCaseMasker.hide();
														Ext.Msg.alert("错误","<font color='red'>删除失败</font>,删除用例时后台出现异常");
													}
												},
												failure:function(response,config){
													delCaseMasker.hide();
													Ext.Msg.alert("提示","当前网络不畅，请稍后再试");
												}
											});
										}
									}
								},
								failure:function(response,config){
									Ext.Msg.alert("提示","当前网络不畅，请稍后再试");
								}
							});
						}
					}
				]
			}),
			id:'testSeceneRGrid',
			cls: 'ui-formPanel',
			title:'测试用例列表',
			border:0,
			minWidth: 1200 - 260 - 30,
			minHeight: 150,
			width: screenWidth - 20,
			height: screenHeight*0.8 - 10,
			viewConfig:{
				forctFit:true,
				stripeRows:true
			},
			store:testSeceneRStore,
			listeners:{
				itemdblclick:function(grid,record,item,index,e,eOpts){
					Ext.Ajax.request({
						url:'<%=request.getContextPath()%>/checkQuote.do?funId=<%=request.getParameter("funId")%>&caseIds='+record.data.caseId,
						success:function(response,config){
							var json = Ext.JSON.decode(response.responseText);
							if(json.success==true){
								if(json.isQuoteCase.length>0){
									Ext.MessageBox.confirm('操作提示','用例已被其他功能点引用，确定要进行编辑吗？',function(optional){
										if(optional=='yes'){
											var caseForm = getCaseForm(record.data.secId,record.data.caseId,'edit');
											var caseFormWindow = new top.Ext.window.Window({
												id:'caseFormWindow',
											    width : screenWidth*0.96,
											    height : screenHeight,
											    modal : true,
											    resizable:false,
											    closeAction : 'destroy',
											    autoScroll : true,
											    items:[caseForm],
											    listeners:{
											    	beforeclose:function(panel,eOpts){
											    		testSeceneRStore.load({params:{funId:'<%=request.getParameter("funId")%>'}});
											    		return true;
											    	}
											    }
											});
											caseFormWindow.show();
										}
									});
								}else{
									var caseForm = getCaseForm(record.data.secId,record.data.caseId,'edit');
									var caseFormWindow = new top.Ext.window.Window({
										id:'caseFormWindow',
									    width : screenWidth*0.96,
									    height : screenHeight,
									    modal : true,
									    resizable:false,
									    closeAction : 'destroy',
									    autoScroll : true,
									    items:[caseForm],
									    listeners:{
									    	beforeclose:function(panel,eOpts){
									    		testSeceneRStore.load({params:{funId:'<%=request.getParameter("funId")%>'}});
									    		return true;
									    	}
									    }
									});
									caseFormWindow.show();
								}
							}
						},
						failure:function(response,config){
							Ext.Msg.alert("提示","当前网络不畅，请稍后再试");
						}
					});
					
					
					
				}
			},
			selModel:Ext.create("Ext.selection.CheckboxModel",{checkOnly : true,ignoreRightMouseSelection : true}),
			columns:[
				new Ext.grid.RowNumberer(),
				{header:"主键",width:100,dataIndex:"caseId",sortable:true,hidden:true},
				{header:"测式场景",width:100,dataIndex:"secId",sortable:true,
					renderer: function (value,cellmeta,record){
						try {
						    var store = Ext.data.StoreManager.lookup("mapStore");
						    store.clearFilter(true);
						    store.filter("categoryName", "secene_show");
						    return store.findRecord("value", value).getData().show + "";
						} catch (e) {
						    return ""+value;
						};
					}
				},
				{header:"用例名称",width:100,dataIndex:"caseName",sortable:true},
				{header:"用例前置条件",width:100,dataIndex:"casePreCond",sortable:true},
				{header:"用例操作说明",width:100,dataIndex:"caseOperateInst",sortable:true},
				{header:"预期结果",width:100,dataIndex:"preResult",sortable:true},
				{header:"需要实现自动化",width:100,dataIndex:"hasTest",sortable:true,
					renderer: function (value,cellmeta,record){
						try {
						    var store = Ext.data.StoreManager.lookup("mapStore");
						    store.clearFilter(true);
						    store.filter("categoryName", "是否实现自动化");
						    return store.findRecord("value", value).getData().show + "";
						} catch (e) {
						    return ""+value;
						};
					}
				},
				{header:'操作', width:50,menuDisabled: true,xtype:'actioncolumn',sortable:false,
					items: [{
			      			icon:"<%=request.getContextPath()%>/css/images/copy-font.gif",
							id: 'copySecR',  
							tooltip: '复制用例',
							handler: function(grid, rowIndex, colIndex) {
								var record = grid.getStore().getAt(rowIndex);
								var caseForm = getCaseForm(record.data.secId,record.data.caseId,'copy');
								var caseFormWindow = new top.Ext.window.Window({
									id:'caseFormWindow',
								    layout: 'fit',
								    maxWidth: screenWidth,
								    height : screenHeight*0.97,
								    modal : true,
								    resizable:false,
								    closeAction : 'destroy',
								    autoScroll : true,
								    items:[caseForm],
								    listeners:{
								    	beforeclose:function(panel,eOpts){
								    		testSeceneRStore.load({params:{funId:'<%=request.getParameter("funId")%>'}});
								    		return true;
								    	}
								    }
								});
								caseFormWindow.show();
							}
						}
					]
				}
			]
		});
		//-------测试用例----end---
		var testQuoteCaseModel = Ext.regModel("testQuoteCaseModel",{
			fields:[
				{name:'sysName',type:'string'},
				{name:'sysId',type:'int'},
				{name:'caseName',type:'string'},
				{name:'folderId',type:'int'},
				{name:'relaId',type:'int'},
				{name:'parentFolderId',type:'int'},
				{name:'relaType',type:'string'},
				{name:'hasTest',type:'int'},
				{name:'isFinishAuto',type:'int'},
				{name:'secId',type:'int'},
				{name:'casePreCond',type:'string'},
				{name:'caseOperateInst',type:'string'},
				{name:'preResult',type:'string'},
				{name:'caseId',type:'int'}
			]
		});
	
		var testQuoteCaseProxy = new Ext.data.proxy.Ajax({
			type:"ajax",
			model:testQuoteCaseModel,
			url:'<%=request.getContextPath()%>/getQuoteCase.do',
			reader:{
				root:"data",
				type:"json"
			}
		});
		var testQuoteCaseStore = Ext.create('Ext.data.Store',{
			model:testQuoteCaseModel,
			proxy:testQuoteCaseProxy,
			listeners:{
				//beforeload:function(){testSeceneRMasker.show();},
				//load:function(){testSeceneRMasker.hide();}
			}
		});
		testQuoteCaseStore.load({params:{funFolderId:'<%=request.getParameter("funId")%>',queryType:1}});
		
		//-------引用用例----------houbc---------testQuoteGrid--------quote
		var testQuoteGrid = Ext.create('Ext.grid.Panel',{
			tbar:Ext.create('Ext.Toolbar',{
				items:[{
						text:'引用测试用例',
						handler:function(){
							var testCaseMasker = new masker('正在加载用例信息，请稍后');
							testCaseMasker.show();
							//testQuoteCaseStore.load({params:{funFolderId:'<%=request.getParameter("funId")%>',queryType:0}});
							testCaseMasker.hide();
							
							var testCaseSearchGrid = top.Ext.create('Ext.grid.Panel',{
								tbar:top.Ext.create('Ext.Toolbar',{
									items:[{
											text:'确定',
											handler:function(){
												var selections = testCaseSearchGrid.getSelectionModel().getSelection();
												if(selections==null||selections.length==0){
													Ext.Msg.alert("提示","请选择要引用的用例");
													return;
												}
												var quoteMasker = new maskerWithHtmlEl(testCaseWindow,'正在引用用例,请稍后');
												quoteMasker.show();
												var caseIds = new Array();
												for(var i=0,n=selections.length;i<n;i++){caseIds.push(selections[i].data.caseId);}
												
												Ext.Ajax.request({
													url:'<%=request.getContextPath()%>/quoteCaseByIds.do?funId=<%=request.getParameter("funId")%>&caseIds='+caseIds.join(","),
													success:function(response,config){
														var json=Ext.JSON.decode(response.responseText);
														if(json.success==true){
															quoteMasker.hide();
															top.Ext.Msg.alert("提示","引用成功");
														}else{
															quoteMasker.hide();
															top.Ext.Msg.alert("错误","<font color='red'>引用失败</font>,后台引用用例时出现异常");
														}
														testCaseWindow.close();
													},
													failure:function(response,config){
														quoteMasker.hide();
														top.Ext.Msg.alert("提示","当前网络不畅，请稍后再试");
													}
												});
											}
										},{
										    width: 170,
										    labelWidth: 70,
										    xtype: 'textfield',
										    id: 'tbarUnQuoteCaseName',
										    name:'tbarUnQuoteCaseName',
										    fieldLabel: '用例名称'
										},{
										    width: 200,
										    labelWidth: 100,
										    xtype: 'textfield',
										    id: 'tbarQuoteFunName',
										    name:'tbarQuoteFunName',
										    fieldLabel: '所属功能点名称'
										},{
											xtype: 'combobox',
											fieldLabel: '所属系统',
											name:'sys',
											id:'sys',
											displayField:'show',
											valueField:'value',
											store:sysIdStore,
											triggerAction:'all',
											listeners:{
												beforerender:function(cmp,opts){
													var combo=top.Ext.getCmp("sys");
													combo.select(sysIdStore.getAt(0));
												}
											}
										}
										,{text:'搜索',
											xtype:'button',
											handler:function(){
												var sys=top.Ext.getCmp("sys").getValue();
												var caseName=encodeURI(encodeURI(top.Ext.getCmp("tbarUnQuoteCaseName").getValue()));
												var funName=encodeURI(encodeURI(top.Ext.getCmp("tbarQuoteFunName").getValue()));
												if(sys==null||(sys+"").length==0){
													top.Ext.Msg.alert('提示',"所属系统不能为空！");
												}else if((caseName==null||caseName.trim().length==0)&&(funName==null||funName.trim().length==0)){
													top.Ext.Msg.alert('提示',"查询条件少于两个！");
												}else{
													testQuoteCaseStore.load({params:{funFolderId:'<%=request.getParameter("funId")%>',queryType:0,caseName:caseName,funName:funName,sysId:sys}});
												}
											}
										}
									]
								}),
								id:'testCaseSearchGrid',
						        cls: 'ui-formPanel',
								title:'测试用例',
								border:0,
								minHeight: 130,
								minWidth: 1200,
								height: 490,
							    width: screenWidth - 20,
								viewConfig:{
									forctFit:true,
									stripeRows:true
								},
								store:testQuoteCaseStore,
								rootVisible: false,
								selModel:Ext.create("Ext.selection.CheckboxModel",{checkOnly : true,ignoreRightMouseSelection : true}),
								columns:[
									{header:"主键",width:100,dataIndex:"relaId",sortable:true,hidden:true},
									{header:"用例",width:100,dataIndex:"caseId",sortable:true,hidden:true},
									{header:"用例名称",width:100,dataIndex:"caseName",sortable:true},
									{header:"用例前置条件",width:100,dataIndex:"casePreCond",sortable:true},
									{header:"用例操作说明",width:100,dataIndex:"caseOperateInst",sortable:true},
									{header:"预期结果",width:100,dataIndex:"preResult",sortable:true},
									{header:"所属功能点",width:260,dataIndex:"sysName",sortable:true},
									{header:"所属系统",width:100,dataIndex:"sysId",sortable:true,
										renderer:function(value){
							    			var rec = Ext.StoreMgr.get('sysIdStore').find('value',value);
							    			if(rec == -1) {
							    				return '';
							    			}
							    			return Ext.StoreMgr.get('sysIdStore').getAt(rec).raw.show;
							    		}
									}
								]
							});
						

							var testCaseWindow = new top.Ext.window.Window({
								id:'testCaseWindow',
							    width : 780,
							    height : 536,
							    modal : true,
							    resizable:false,
							    closeAction : 'destroy',
							    items:[testCaseSearchGrid],
							    listeners:{
							    	close:function(panel,opts){
							    		testQuoteCaseStore.load({params:{funFolderId:'<%=request.getParameter("funId")%>',queryType:1}});
							    	}
							    }
							}).show();
							
						}
					},{
						text:'删除引用',
						handler:function(){
							var selections = testQuoteGrid.getSelectionModel().getSelection();
							if(selections==null||selections.length==0){
								Ext.Msg.alert("提示","请选择要删除引用的用例");
								return;
							}
							Ext.MessageBox.confirm('操作提示','确定要删除引用关系吗?',function(optional){
								if(optional=='yes'){
									var delCaseMasker = new masker('正在删除引用关系，请稍后');
									delCaseMasker.show();
									var caseIds = new Array();
									for(var i=0,n=selections.length;i<n;i++){caseIds.push(selections[i].data.caseId);}
									Ext.Ajax.request({
										url:'<%=request.getContextPath()%>/deleteQuoteByIds.do?funId=<%=request.getParameter("funId")%>&caseIds='+caseIds.join(","),
										success:function(response,config){
											var json = Ext.JSON.decode(response.responseText);
											if(json.success==true){
												testQuoteCaseStore.load({params:{funFolderId:'<%=request.getParameter("funId")%>',queryType:1}});
												delCaseMasker.hide();
												Ext.Msg.alert("提示","删除成功");
											}else{
												delCaseMasker.hide();
												Ext.Msg.alert("错误","<font color='red'>删除失败</font>,删除引用关系时后台出现异常");
											}
										},
										failure:function(response,config){
											delCaseMasker.hide();
											Ext.Msg.alert("提示","当前网络不畅，请稍后再试");
										}
									});
								}
							});
						}
					}
				]
			}),
			id:'testQuoteGrid',
			cls: 'ui-formPanel',
			title:'引用用例列表',
			border:0,
			minWidth: 1200 - 260 - 30,
			minHeight: 150,
			width: screenWidth - 20,
			height: screenHeight*0.8 - 10,
			viewConfig:{
				forctFit:true,
				stripeRows:true
			},
			store:testQuoteCaseStore,
			listeners:{
				/*itemdblclick:function(grid,record,item,index,e,eOpts){
					var caseForm = getCaseForm(record.data.secId,record.data.caseId,'edit');
					var caseFormWindow = new top.Ext.window.Window({
						id:'caseFormWindow',
					    width : screenWidth*0.96,
					    height : screenHeight,
					    modal : true,
					    resizable:false,
					    closeAction : 'destroy',
					    autoScroll : true,
					    items:[caseForm],
					    listeners:{
					    	beforeclose:function(panel,eOpts){
					    		testSeceneRStore.load({params:{funId:'<%=request.getParameter("funId")%>'}});
					    		return true;
					    	}
					    }
					});
					caseFormWindow.show();
				}*/
			},
			selModel:Ext.create("Ext.selection.CheckboxModel",{checkOnly : true,ignoreRightMouseSelection : true}),
			columns:[
				new Ext.grid.RowNumberer(),
				{header:"主键",width:100,dataIndex:"relaId",sortable:true,hidden:true},
				{header:"用例名称",width:100,dataIndex:"caseName",sortable:true},
				{header:"用例前置条件",width:100,dataIndex:"casePreCond",sortable:true},
				{header:"用例操作说明",width:100,dataIndex:"caseOperateInst",sortable:true},
				{header:"预期结果",width:100,dataIndex:"preResult",sortable:true},
				{header:"需要实现自动化",width:100,dataIndex:"hasTest",sortable:true,
					renderer: function (value,cellmeta,record){
						try {
						    var store = Ext.data.StoreManager.lookup("mapStore");
						    store.clearFilter(true);
						    store.filter("categoryName", "是否实现自动化");
						    return store.findRecord("value", value).getData().show + "";
						} catch (e) {
						    return ""+value;
						};
					}
				},
				{header:"所属功能点",width:300,dataIndex:"sysName",sortable:true},
				{header:"所属系统",width:100,dataIndex:"sysId",sortable:true,
					renderer:function(value){
		    			var rec = Ext.StoreMgr.get('sysIdStore').find('value',value);
		    			if(rec == -1) {
		    				return '';
		    			}
		    			return Ext.StoreMgr.get('sysIdStore').getAt(rec).raw.show;
		    		}
				}
			]
		});
		//-------引用用例----------houbc---------testQuoteGrid---end--
		var funPointTab = new Ext.TabPanel({
			id: 'funPointTab',
			minWidth: 1200 - 260 - 22,
			minHeight: 120,
			width: screenWidth - 10,
			height: screenHeight*0.8-12,
			cls:"ui-tab-bar",
			bodyCls:"ui-tab-body",
			frame:true,
			activeTab: 0,
			items: [testElemGrid,testSeceneGrid,testSeceneRGrid,testQuoteGrid]
		});
		Ext.create('Ext.panel.Panel',{
			minWidth: 1200-260,
			minHeight: 350,
			width: screenWidth,
			height: screenHeight + 5,
			renderTo: Ext.get('funBody'),
			cls: 'ui-formPanel',
			bodyBorder:0,
			listeners:{
				render:function(panel,eOpts){
					isAppend=true;
					pageLoadMask.hide();
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
				items:[funFolderForm,funPointTab]
			}]
		});
    });
    //-----mapStore.load---end
});
//----onReady---end---
//---场景-------
function getScene(secId,type){
	var list = new Array();
	var testSeceneForm = top.Ext.widget('form', {
		tbar:top.Ext.create('Ext.Toolbar',{
			items:[{
					text:'保存',
					handler:function(){
						var saveSeceneMasker = new maskerWithHtmlEl(top.Ext.getCmp('testSeceneWindow'),'正在保存场景信息，请稍后');
						saveSeceneMasker.show();
						var dataJson = null;
						var treeNodes=top.Ext.getCmp('testRElemSeceneGrid').getChecked();
						if(treeNodes==null){return;}
						for(var i=0,n=treeNodes.length;i<n;i++){
							if(dataJson==null){dataJson = {};}
							var elemId = treeNodes[i].data.elemId;
							if(typeof dataJson[elemId]=='undefined'){dataJson[elemId]=new Array();}
							var subElemId = treeNodes[i].data.subElemId;
							if(treeNodes[i].data.subElemId!=""){dataJson[elemId].push(subElemId);}
						}
						if(dataJson==null){
							saveSeceneMasker.hide();
							top.Ext.Msg.alert('提示',"请选择关联的要素以及要素值");
							return;
						}
						testSeceneForm.submit({
							clientValidation: true,
							url:'<%=request.getContextPath()%>/saveSceneAndRela.do?elemData='+Ext.encode(dataJson) +"&funID=<%=request.getParameter("funId")%>&type="+type,
							method:'POST',
							success:function(response,config){
								var json = Ext.JSON.decode(config.response.responseText);
								if(json.message.length>0){
						 			top.Ext.Msg.alert("操作","存在名称为<font color='red'>"+json.message+"</font>的场景，请重新输入场景名称！");
									saveSeceneMasker.hide();
								}else if(json.data.length>0){
									top.Ext.Msg.alert("操作",json.data);
									saveSeceneMasker.hide();
								}else{
									var tp = Ext.getCmp('testSeceneGrid');
									var testSeceneStore = tp.getStore();
									var root = tp.getStore().getProxy();  
									root.extraParams.flag = 'sec';  
									root.extraParams.treeId = '<%=request.getParameter("funId")%>';  
									testSeceneStore.load();
									Ext.data.StoreManager.lookup("mapStore").reload();
									saveSeceneMasker.hide();
									top.Ext.Msg.alert("提示","保存成功");
									top.Ext.getCmp('testSeceneWindow').close();
								}
							},
							failure:function(response,config){
								saveSeceneMasker.hide();
								var errorType = config.failureType;
								if(errorType=="client"){
									top.Ext.Msg.alert("提示","请处理带有红色下划线的字段的错误");
								}else if(config.failureType =="connect"){
									top.Ext.Msg.alert("提示","当前网络不畅，请稍后再试");
								}else{
									var json = Ext.JSON.decode(config.response.responseText);
									if(json.errorInfo!=null&&json.errorInfo.length>0){
										top.Ext.Msg.alert("提示","<font color='red'>保存失败</font>,"+json.errorInfo);
										top.Ext.getCmp('testSeceneWindow').close();
									}else{
										top.Ext.Msg.alert("提示","<font color='red'>保存失败</font>,在保存时后台出现异常");
									}
								}
							}
						});
					}
				}
			]
		}),
        id: 'testSeceneForm',
        cls: 'ui-formPanel',
        minWidth: 765,
        minHeight: 503*0.25,
        border:0,
		title: '测试场景',
        layout: {type: 'vbox'}, 
		fieldDefaults: { 
		    labelAlign: 'right', 
		    labelWidth: 100, 
		    labelStyle: 'font-weight:bold' 
		},
		defaults: {margins: '15 0 0 0'}, 
 		listeners:{
			render:function(form,eOpts){
				if(type=='edit'||type=='copy'){
					var seceneFormloadMasker = new maskerWithHtmlEl(top.Ext.getCmp('testSeceneWindow'),'正在加载场景信息，请稍后');
					form.load({
						url:'<%=request.getContextPath()%>/getSeceneForm.do?secId='+secId,
						success:function(response,config){
							if(type=='copy'){
								testSeceneForm.getForm().findField('seceneName').setValue(testSeceneForm.getForm().findField('seceneName').getValue()+"-复制"+Ext.util.Format.date(new Date(),'YmdHisu'));
								testSeceneForm.getForm().findField('secOrder').setValue('');
								testSeceneForm.getForm().findField('secId').setValue('');
								seceneFormloadMasker.hide();
							}
						},
						failure:function(response,config){
							seceneFormloadMasker.hide();
							top.Ext.Msg.alert('提示','获取场景数据失败');
						}
					});
				}
			}
		},
		items:[{
				xtype: 'fieldcontainer', 
				labelStyle: 'font-weight:bold;padding:0', 
				layout: 'hbox', 
                defaultType: 'textfield', 
                fieldDefaults: {labelAlign: 'right' }, 
	            items: [
	            	{name: 'secId',xtype: 'hidden'},
	            	{name: 'isDelete',xtype: 'hidden'},
	            	{
	            		name: 'seceneName', 
				        fieldLabel: '<font color="red">*</font>场景名称',
				        allowBlank: false,
				        maxLength : 500,
				        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
	            	},{
				    	name: 'analysisMethod', 
				        fieldLabel: '<font color="red">分析方法</font>',
				        xtype: 'combo', 
				        allowBlank: false,
				        forceSelection: true,
				        emptyText:'请选择分析方法',
				        store:Ext.create('Ext.data.Store', {
							autoLoad:true,
							model:"extCommboModel",
							proxy:Ext.create('Ext.data.proxy.Ajax',{
								type:"ajax",
								model:"extCommboModel",
								url:'<%=request.getContextPath()%>/getCaseParam.do?type=analysis_method',
								reader:{
									root:"data",
									type:"json"
								}
							})
						}),
						displayField:'text',
						valueField:'value',
						mode:'remote'
					},
					{xtype: 'hidden',name: 'secOrder',fieldLabel: '场景顺序'}
				]
			}
		]
	});
	
	var testRElemSeceneModel = Ext.regModel('testRElemSeceneModel', { 
		fields: [ 
			{name: 'elemId',type: 'string'}, 
			{name: 'elemTag',type: 'string'}, 
			{name: 'elemName',type: 'string'},
			{name: 'elemSysAchieveType',type: 'string'},
			{name: 'applicateSys',type: 'string'},
			{name: 'isGlobalElem',type: 'string'},
			{name:'sysId',type:'string'},
			{name:'subElemId',type:'string'},
			{name:'elemValue',type:'string'},
			{name:'elemTestLogic',type:'string'},
			{name:'takeValueMethod',type:'string'},
			{name:'valueRemark',type:'string'}
		] 
	});
	
	var RElemSecMasker = new masker('正在加载测试要素信息,请稍后');
	var testRElemSeceneStore = new Ext.data.TreeStore({ 
		model: testRElemSeceneModel,  
		proxy: { 
			type: 'ajax',  
			url: '<%=request.getContextPath()%>/getTestElemTableForSecEdit.do?funId=<%=request.getParameter("funId")%>&type='+type+'&secId='+secId
		}, 
		root: {
			id:-1,
			text: '测试要素',
			expanded: true
		},
		reader: { 
			type: 'json', 
			root: 'children' 
		},
		listeners:{
			beforeload:function(){RElemSecMasker.show();},
			load:function(){RElemSecMasker.hide();}
		}
	});
	
	var setParentChecked = function(node,checked){
        node.set({checked:checked});
        var parentNode = node.parentNode;
        if(parentNode.raw.id==-1){return;}
        if(parentNode !=null){
			var flag = false;
			parentNode.eachChild(function(child) {
			    if(child.data.checked == true){flag = true;}
			});
			if(checked == false){
			    if(!flag){setParentChecked(parentNode,checked);}
			}else{
			    if(flag){setParentChecked(parentNode,checked);}
			}
		}
    };
    
    var setChildUnChecked = function(node,checked){
    	var hasChild = true;
    	if(!node.isLeaf()){
    		node.expand(true,function(){
   				if(!node.hasChildNodes()){
	    			node.set({checked:false});
					top.Ext.Msg.alert('提示','该要素下未含有测试要素值,不可进行关联');	
					hasChild = false;
	    		}
   			},null);
    	}
    	if(hasChild==true){
	    	node.set({checked:checked});
	   		if(!node.isLeaf()){
	   			node.expand(true,function(){
	   				node.eachChild(function(child) {child.set({checked:checked});});
	   			},null);
	   		}
    	}
    };
    
	var testRElemSeceneGrid = top.Ext.create('Ext.tree.TreePanel',{
		id:'testRElemSeceneGrid',
        cls: 'ui-formPanel',
		title:'关联的测试要素',
		border:0,
		minWidth: 765,
        minHeight: 503*0.75,
		rootVisible: false,
		viewConfig:{
			forctFit:true,
			stripeRows:true
		},
		store:testRElemSeceneStore,
		listeners:{
			checkchange:function (node,checked,eOpts){
				setParentChecked(node,checked);
				setChildUnChecked(node,checked);
			}
		},
		columns:[
			{text:"主键",width:100,dataIndex:"subElemId",sortable:false,hidden:true},
			{text:"主键",width:100,dataIndex:"elemId",sortable:false,hidden:true},
			{text:"外键",width:100,dataIndex:"sysId",sortable:false,hidden:true},
			{xtype: 'treecolumn',text:"要素名称",width:200,dataIndex:"elemName",sortable:false},
			{text:"要素编号",width:150,dataIndex:"elemTag",sortable:false,hidden:true},
			{text:"要素类型",width:120,dataIndex:"elemSysAchieveType",sortable:false,hidden:true},
			{text:"适用系统",width:100,dataIndex:"applicateSys",sortable:false,hidden:true},
			{text:"是否全局要素",width:100,dataIndex:"isGlobalElem",sortable:false,hidden:true},
			{text:"要素值",width:200,dataIndex:"elemValue",sortable:false},
			{text:"要素测试逻辑",width:100,dataIndex:"elemTestLogic",sortable:false,hidden:true},
			{text:"取数方法",width:100,dataIndex:"takeValueMethod",sortable:false,hidden:true},
			{text:"备注",width:100,dataIndex:"valueRemark",sortable:true}
		]
	});
	list.push(testSeceneForm);
	list.push(testRElemSeceneGrid);
	return list;
}
//---场景----end---
//----------------houbc------getQuoteCaseForm
/*	

function getQuoteCaseForm(){
	
	
	
}
*/
//----------------houbc------getQuoteCaseForm
//---用例-------
function getCaseForm(seceneId,manualCaseId,type){
	var store = Ext.data.StoreManager.lookup("mapStore");
	store.clearFilter(true);
    store.filter("category", "SECENE_SHOW");
    var seceneData = new Array;
    var datas = store.data.items;
    for(var i=0,n=datas.length;i<n;i++){seceneData.push({value:datas[i].raw.value,text:datas[i].raw.show});}
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
		failure:function(response,config){top.Ext.Msg.alert('操作','当前网络不畅，请稍后再试');}
	});
	
	var testSeceneRModel = Ext.regModel("testSeceneRModel",{
		fields:[
			{name:'caseId',type:'string'},
			{name:'caseName',type:'string'},
			{name:'secId',type:'string'},
			{name:'casePreCond',type:'string'},
			{name:'caseOperateInst',type:'string'},
			{name:'preResult',type:'string'},
			{name:'elemvalue',type:'string'}
		]
	});
	
	var testSeceneRProxy = new Ext.data.proxy.Ajax({
		type:"ajax",
		model:testSeceneRModel,
		url:'<%=request.getContextPath()%>/getCaseTableForSeceneRela.do',
		reader:{
			root:"data",
			type:"json"
		}
	});
	
	var caseLoadMasker = new masker('正在加载用例信息，请稍后');
	var testSeceneRStore = Ext.create('Ext.data.Store',{
		model:testSeceneRModel,
		proxy:testSeceneRProxy,
		listeners:{
			beforeload:function(){caseLoadMasker.show();},
			load:function(){caseLoadMasker.hide();}
		}
	});
	
	var isHidden = false;
	if(type=='copy'){isHidden = true;}
	var testSeceneRGrid = top.Ext.create('Ext.grid.Panel',{
		cls: 'ui-formPanel',
		title:'测试用例列表',
		width: screenWidth*0.933,
		height: screenHeight*0.3,
		hidden:isHidden,
		viewConfig:{
			forctFit:true,
			stripeRows:true
		},
		store:testSeceneRStore,
		selType:'rowmodel',
		listeners:{
			itemclick:function(grid,record,item,index,e,eOpts){
				caseForm.load({
					url:'<%=request.getContextPath()%>/getCaseForm.do?caseId='+record.data.caseId,
					success:function(response,config){
						var val = caseForm.getForm().findField('testType').getValue();
						if(val!=null&&val!=""){
							if (val.split) {val = val.split(',');}
							Ext.getCmp('isProgressTestCheck').reset();
							for (var i = 0; i < val.length; i++) {
								Ext.getCmp('isProgressTestCheck').items.each(function (c) {
									if (c.inputValue == val[i]) {c.setValue(true);}
								});
							}
						}
	     				isRefresh = true;
						testCaseElemStore.reload({params:{secId:secNameCombox.getValue(),caseId:record.data.caseId}});
					},
					failure:function(response,config){top.Ext.Msg.alert("操作","获取用例信息失败");}
				});
			}
		},
		columns:[
			new top.Ext.grid.RowNumberer(),
			{header:"主键",width:100,dataIndex:"caseId",sortable:true,hidden:true},
			{header:"测式场景",width:100,dataIndex:"secId",sortable:true,hidden:true},
			{header:"用例名称",width:100,dataIndex:"caseName",sortable:true},
			{header:"涉及的要素与要素值",width:350,dataIndex:"elemvalue",sortable:true},
			{header:"用例前置条件",width:100,dataIndex:"casePreCond",sortable:true,hidden:true},
			{header:"用例操作说明",width:100,dataIndex:"caseOperateInst",sortable:true,hidden:true},
			{header:"预期结果",width:100,dataIndex:"preResult",sortable:true,hidden:true}/*,
			{header:'操作', width:50,menuDisabled: true,xtype:'actioncolumn',sortable:false,
				items: [{
						icon:"<%=request.getContextPath()%>/aiga/label/image/del.gif",
						id: 'deleteRSecCase',  
						tooltip: '删除',  
						handler: function(grid, rowIndex, colIndex){
							var deleteRSecCaseMasker = maskerWithHtmlEl(top.Ext.getCmp('caseFormWindow'),"正在删除用例，请稍后");
							deleteRSecCaseMasker.show();
							var record = grid.getStore().getAt(rowIndex);
							var caseId = record.data.caseId;
							Ext.Ajax.request({
								url:'<%=request.getContextPath()%>/deleteCaseForNew.do?caseId='+caseId,
								success:function(response,config){
									var json = Ext.JSON.decode(response.responseText);
									if(json.success==true){
										if(type!='copy'){
							       			testSeceneRStore.reload({params:{secId:secNameCombox.getValue()}});
							       		}
										deleteRSecCaseMasker.hide();
										top.Ext.Msg.alert("提示","删除成功");
									}else{
										deleteRSecCaseMasker.hide();
										top.Ext.Msg.alert("提示","<font color='red'>删除失败</font>,在删除用例时后台出现异常");
									}
								},
								failure:function(response,config){
									deleteRSecCaseMasker.hide();
									top.Ext.Msg.alert("提示","当前网络不畅，请稍后再试");
								}
							});
						}
					}
				]
			}*/
		]
	});
	
	var testCaseElemModel = Ext.regModel("testCaseElemModel",{
		fields:[
			{name:'elemId',type:'string'},
			{name:'elemTag',type:'string'},
			{name:'elemName',type:'string'},
			{name:'elemSysAchieveType',type:'string'},
			{name:'applicateSys',type:'string'},
			{name:'isGlobalElem',type:'string'},
			{name:'sysId',type:'string'},
			{name:'funId',type:'string'},
			{name:'subElemIds',type:'string'},
			{name:'subElemValue',type:'string'}
		]
	});
	
	var testCaseElemProxy = new Ext.data.proxy.Ajax({
		type:"ajax",
		model:testCaseElemModel,
		url:'<%=request.getContextPath()%>/getTestElemTableForCase.do',
		reader:{
			root:"data",
			type:"json"
		}
	});
	
	var caseElemMasker = new masker('正在加载要素信息，请稍后');
	
	var testCaseElemStore = Ext.create('Ext.data.Store',{
		model:testCaseElemModel,
		proxy:testCaseElemProxy,
		listeners:{
			beforeload:function(){
				caseElemMasker.show();
			},
			load:function(store,records,successful,operation,eOpts){
				var testCaseElemArray = testCaseElemStore.data.items;
				for(var i=0,n=testCaseElemArray.length;i<n;i++){
					var subElemValue = testCaseElemArray[i].data.subElemValue;
					if(subElemValue==null||subElemValue==''||subElemValue.length==0){continue;
					}else{
						var selMode = testCaseElemGrid.getSelectionModel();
						selMode.select(testCaseElemArray[i],true,true);
					}
				}
				caseElemMasker.hide();
			}
		}
	});
	
	testCaseElemStore.load({params:{secId:0,caseId:0}});
	testSeceneRStore.load({params:{secId:0}});
	
	var showSubElemRadio = function(record, index, eOpts ){
		var selectModel = testCaseElemGrid.getSelectionModel();
		if(selectModel.isSelected(record)==false){
			top.Ext.Msg.alert('提示','要选择要素值请先选择该要素');
			return;
		}
		var subElemIds = record.data.subElemIds;
		if(subElemIds==''){
			alert("该要素下并未关联要素值,请返回到场景下选择需要关联的要素值");
			selectModel.deselect(record);
			return;
		}
		Ext.Ajax.request({
			url:'<%=request.getContextPath()%>/getCaseParam.do?type=test_sub_elem&subElemIds='+subElemIds,
			success:function(response,config){
				var json=Ext.JSON.decode(response.responseText).data;
				var subElemRadioItem = new Array();
				for(var i=0,n=json.length;i<n;i++){
					var show = json[i].text;
					var value = json[i].value;
					if(i==0){
						subElemRadioItem.push({boxLabel:show,name:'subElemRadioItem',inputValue:value,checked:true});
					}else{
						subElemRadioItem.push({boxLabel:show,name:'subElemRadioItem',inputValue:value});
					}
				}
				var subElemRadio = top.Ext.create('Ext.form.RadioGroup',{
			        fieldLabel: '测试要素值',
			        columns: 1,
			        vertical: true,
			        items: subElemRadioItem
			    });
				var selectSubElemWindow = new top.Ext.window.Window({
					bbar:['->',{
					  	xtype: 'button',
						text: '确定',
						handler:function(){selectSubElemWindow.close();}
					}],
					id:'selectSubElemWindow',
				    width : 400,
				    height : json.length*70+20,
				    title:'要素值选择',
				    modal : true,
				    resizable:false,
				    closable:false,
				    autoScroll : true,
				    closeAction : 'destroy',
				    items:[subElemRadio],
				    listeners:{
				    	beforeclose:function(panel,eOpts){
				    		var subElemId = subElemRadio.getValue();
				    		testCaseElemStore.getAt(index).set('subElemValue',subElemId.subElemRadioItem);
				    		var records = testCaseElemStore.getUpdatedRecords();
				    		Ext.Array.each(records, function(record) {record.commit();});
				    		var selections = selectModel.getSelection();
				    		var caseName = new Array();
							if(selections!=null&&selections.length>0){
								for(var i=0,n=selections.length;i<n;i++){
									var subElemValue = selections[i].data.subElemValue;
									var subElemShow = '';
									try {
										var store = Ext.data.StoreManager.lookup("mapStore");
										store.clearFilter(true);
										store.filter("categoryName", "sub_elem_show");
										subElemShow = store.findRecord("value", subElemValue).getData().show + "";
									} catch (e) {
									    subElemShow = "";
									}
									var elemName = selections[i].data.elemName;
									caseName.push(elemName+":"+subElemShow);
									selectModel.deselect(selections[i],true);
									selectModel.select(selections[i],true,true);
								}
								caseForm.getForm().findField('caseName').setValue(secNameCombox.getRawValue()+'_'+caseName.join(","));
								caseForm.getForm().findField('elemvalue').setValue(caseName.join(","));
							}
						}
					}
				}).show();
			},
			failure:function(response,config){top.Ext.Msg.alert("提示","获取要素值信息错误");}
		});
	};
	
	var testCaseElemGrid = top.Ext.create('Ext.grid.Panel',{
		id:'testCaseElemGrid',
        cls: 'ui-formPanel',
		title:'测试要素',
		width: screenWidth*0.933,
        height: screenHeight*0.3,
		viewConfig:{
			forctFit:true,
			stripeRows:true
		},
		store:testCaseElemStore,
		selModel:top.Ext.create('Ext.selection.CheckboxModel', {
			checkOnly : true,
			ignoreRightMouseSelection : true,
			showHeaderCheckbox : false,
			listeners:{
				beforeselect:function(selModel, record, index, eOpts ){
					var subElemIds = record.data.subElemIds;
					if(subElemIds==''){
						alert("该要素下并未关联要素值,请返回到场景下选择需要关联的要素值");
						return false;
					}
				},
				select:function(selModel, record, index, eOpts ){showSubElemRadio(record, index, eOpts);},
				deselect:function(selModel,record,index,eOpts){
					if(isRefresh==true){return;}
					var selections = selModel.getSelection();
		    		var caseName = new Array();
		    		if(selections!=null&&selections.length>0){
		    			for(var i=0,n=selections.length;i<n;i++){
		    				var subElemValue = selections[i].data.subElemValue;
		    				var subElemShow = '';
		    				try {
			                    var store = Ext.data.StoreManager.lookup("mapStore");
			                    store.clearFilter(true);
			                    store.filter("categoryName", "sub_elem_show");
			                    subElemShow = store.findRecord("value", subElemValue).getData().show + "";
			                } catch (e) {
			                    subElemShow = "";
			                }
			                var elemName = selections[i].data.elemName;
							caseName.push(elemName+":"+subElemShow);
		    			}
		    		}
		    		caseForm.getForm().findField('caseName').setValue(caseName.join(","));
		    		record.set('subElemValue','');
		    		record.commit();
				}
			}
		}),
		listeners:{
			itemdblclick:function(grid, record, item, index, e, eOpts ){showSubElemRadio(record, index, eOpts);}
		},
		columns:[
			new top.Ext.grid.RowNumberer(),
			{header:"主键",width:100,dataIndex:"elemId",sortable:true,hidden:true},
			{header:"外键",width:100,dataIndex:"elemTag",sortable:true,hidden:true},
			{header:"要素名称",width:100,dataIndex:"elemName",sortable:true},
			{header:"要素类型",width:120,dataIndex:"elemSysAchieveType",sortable:false,
				renderer: function (value, cellmeta, record) {
					try {
					    var store = Ext.data.StoreManager.lookup("mapStore");
					    store.clearFilter(true);
					    store.filter("categoryName", "elemType");
					    return store.findRecord("value", value).getData().show + "";
					} catch (e) {
					    return ""+value;
					};
            	}
            },
			{header:"适用系统",width:100,dataIndex:"applicateSys",sortable:false,hidden:true},
			{header:"是否全局要素",width:100,dataIndex:"isGlobalElem",sortable:false,
				renderer: function (value, cellmeta, record) {
	                try {
	                    var store = Ext.data.StoreManager.lookup("mapStore");
	                    store.clearFilter(true);
	                    store.filter("categoryName", "isGlobal");
	                    return store.findRecord("value", value).getData().show + "";
	                } catch (e) {
	                    return ""+value;
	                };
            	}
            },
            {header:"要素值",width:100,dataIndex:"subElemValue",sortable:false,
            	renderer: function (value, cellmeta, record) {
	                try {
	                    var store = Ext.data.StoreManager.lookup("mapStore");
	                    store.clearFilter(true);
	                    store.filter("categoryName", "sub_elem_show");
	                    return store.findRecord("value", value).getData().show + "";
	                } catch (e) {
	                    return ""+value;
	                };
            	}
            },
			{header:"外键",width:100,dataIndex:"sysId",sortable:true,hidden:true},
			{header:"外键",width:100,dataIndex:"funId",sortable:true,hidden:true}
		]
	});
	
	var clearCaseForm = function(){
		caseForm.getForm().findField('caseId').setValue('');
		caseForm.getForm().findField('caseName').setValue('');
		caseForm.getForm().findField('casePreCond').setValue('');
		caseForm.getForm().findField('caseOperateInst').setValue('');
		caseForm.getForm().findField('preResult').setValue('');
		caseForm.getForm().findField('secId').setValue(secNameCombox.getValue());
		caseForm.getForm().findField('regressionTest').setValue('');
		caseForm.getForm().findField('hasTest').setValue('');
		caseForm.getForm().findField('elemvalue').setValue('');
		top.Ext.getCmp('isProgressTestCheck').disable(true);
	};
	
	var secNameCombox = new top.Ext.form.ComboBox({
    	name: 'seceneName', 
        fieldLabel: '<font color="red">*</font>场景名称',
        width:500,
        xtype: 'combo', 
        allowBlank: false,
        forceSelection: true,
        emptyText:'请选择场景名称',
        store:Ext.create('Ext.data.Store', {
			fields: ['value', 'text'],
			data:seceneData
		}),
		listeners:{
        	change:function(combo,newValue,oldValue,eOpts){
        		testCaseElemStore.reload({params:{secId:newValue,caseId:0}});
        		if(type!='copy'){
        			clearCaseForm();
        			testSeceneRStore.reload({params:{secId:newValue}});
        		}
        	},
        	render:function(combo, eOpts ){testCaseElemStore.reload({params:{secId:seceneId,caseId:manualCaseId}});}
	    },
        displayField:'text',
        valueField:'value',
        mode:'local'
    });
	
	var caseFormHeight = screenHeight+89;
	if(type=='copy'){caseFormHeight = screenHeight*0.94;}
	var caseForm = top.Ext.create('Ext.form.Panel', {
		tbar:top.Ext.create('Ext.Toolbar',{
			items:[{
					text:'保存',
					handler:function(){
						if(secNameCombox.getValue()==null||secNameCombox.getValue()==""){
							top.Ext.Msg.alert("提示","请选择场景");
							return;
						}
						var caseElems = testCaseElemGrid.getSelectionModel().getSelection();
						if(caseElems.length==0){
							top.Ext.Msg.alert("提示","请选择测试要素");
							return;
						}
						var saveCaseMasker = new maskerWithHtmlEl(top.Ext.getCmp('caseFormWindow'),'正在保存用例信息，请稍后');
						saveCaseMasker.show();
						var val = [];
				        top.Ext.getCmp('isProgressTestCheck').items.each(function (c) {
				            if (c.getValue() == true)
				                val.push(c.inputValue);
				        });
				  		caseForm.getForm().findField('testType').setValue(val.join(','));
				  		caseForm.getForm().findField('secId').setValue(secNameCombox.getValue());
				  		if(type=='add'){
							caseForm.getForm().findField('hasTest').setValue(0);
							caseForm.getForm().findField('status').setValue(1);
						}
						caseForm.getForm().findField('needApproval').setValue('Y');
						var selections = testCaseElemGrid.getSelectionModel().getSelection();
			    		var caseElemArray = new Array();
			    		if(selections!=null&&selections.length>0){
			    			for(var i=0,n=selections.length;i<n;i++){
			    				var subElemValue = selections[i].data.subElemValue;
				                var elemId = selections[i].data.elemId;
				                var json = {};
				                json[elemId]=subElemValue;
				                caseElemArray.push(json);
			    			}
			    		}
			  			caseForm.submit({
				  			clientValidation: true,
				  			method:'POST',
				  			url:'<%=request.getContextPath()%>/saveCaseFormForNew.do?caseElem='+Ext.encode(caseElemArray),
				  			success:function(form,config){
				  				if(type!='copy'){
				        			testSeceneRStore.reload({params:{secId:secNameCombox.getValue()}});
				        		}
				  				clearCaseForm();
				  				saveCaseMasker.hide();
				  				top.Ext.Msg.alert("提示","保存成功",function(){
				  					if(type=='copy'){top.Ext.getCmp('caseFormWindow').close();}
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
				},
				secNameCombox
			]
		}),
		id:'caseForm',
		width:screenWidth*0.933,
		height:caseFormHeight,
		title:'用例',
        cls: 'ui-formPanel',
		layout: {type: 'vbox'},
		bodyBorder: 0, 
		fieldDefaults: { 
			labelAlign: 'right', 
			labelWidth: 60, 
			labelStyle: 'font-weight:bold' 
		}, 
		defaults: {margins: '5 0 0 0' }, 
		listeners:{
			afterrender : function(render,eOpts){
				if(type=='edit'||type=='copy'){
					if(seceneId==null||seceneId==''){
						top.Ext.Msg.alert("错误","未能获取到场景主键");
						return;
					}
					var secIdInt = parseInt(seceneId);
					secNameCombox.setValue(secIdInt);
					caseForm.load({
	           			url:'<%=request.getContextPath()%>/getCaseForm.do?caseId='+manualCaseId,
	           			success:function(response,config){
	           				var regressionTest = top.Ext.getCmp('caseForm').getForm().findField('regressionTest').getValue();
							if(regressionTest==null||regressionTest==''||regressionTest=='0'){
								top.Ext.getCmp('isProgressTestCheck').disable(true);
							}else{
								var val = caseForm.getForm().findField('testType').getValue();
								if (val.split) {val = val.split(',');}
						        top.Ext.getCmp('isProgressTestCheck').reset();
						        for (var i = 0; i < val.length; i++) {
						            top.Ext.getCmp('isProgressTestCheck').items.each(function (c) {
						                if (c.inputValue == val[i]) {c.setValue(true);}
						            });
						        }
				        	}
				        	testCaseElemStore.reload({params:{secId:seceneId,caseId:manualCaseId}});
				        	if(type=='copy'){top.Ext.getCmp('caseForm').getForm().findField('caseId').setValue('');}
	           			},
		           		failure:function(response,config){
		             		top.Ext.Msg.alert("操作","获取用例信息失败");
	             		}
	           		});
				}else{
					top.Ext.getCmp('isProgressTestCheck').disable(true);
				}
			}
		},
		items: [
				testCaseElemGrid,
			{
				xtype: 'fieldcontainer', 
			    labelStyle: 'font-weight:bold;padding:0',
			    layout: 'hbox',
			    defaultType: 'textfield',
			    fieldDefaults: {labelAlign: 'right'},
			    items: [{
				    	width:screenWidth*0.933,
				    	name: 'caseName', 
				        fieldLabel: '<font color="red">*</font>用例名称', 
				        allowBlank: false,
				        emptyText:'请填写用例名称',
				        maxLength : 255,
				        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
					},
					{xtype: "hidden",name: 'isFinishAuto'},
				    {xtype: "hidden",name: 'needApproval'},
				    {xtype: "hidden",name: 'isAvailAuto' },
				    {xtype: "hidden",name: 'testType'},
				    {xtype: "hidden",name: 'isDelete'},
				    {xtype: "hidden",name: 'createTime'},
				    {xtype: "hidden",name: 'updateTime'},
				    {xtype: "hidden",name:"sysLabel"},
				    {xtype: "hidden",name:"ownLabel"},
				    {xtype: "hidden",name:"caseId"},
				    {xtype: "hidden",name:"funFolderId"},
				    {xtype: "hidden",name:"authorNo"},
				    {xtype: "hidden",name:"approvalPsn"},
				    {xtype: "hidden",name:"status"},
				    {xtype: "hidden",name:"baseCaseId"},
				    {xtype: 'hidden', name: 'author'},
				    {xtype: "hidden",name:'latestOperator'},
				    {xtype: "hidden",name:'secId'},
				    {xtype: "hidden",name:'elemvalue'}
		    	] 
			},{ 
				xtype: 'fieldcontainer', 
			    labelStyle: 'font-weight:bold;padding:0', 
			    layout: 'hbox', 
			    defaultType: 'textfield', 
			    fieldDefaults: {labelAlign: 'right'}, 
				items:[{ 
						hidden:true,
				    	width: 250, 
				    	name: 'regressionTest', 
				        fieldLabel: '<font color="red">是否为回归测试</font>',
				        xtype: 'combo',
				        forceSelection: true,
				        //allowBlank: false,
				        emptyText:'请选择',
				        listeners:{
				        	change:function(combo,newValue,oldValue,eOpts){
				        		if(newValue==null||newValue==0){
				        			var checks = top.Ext.getCmp('isProgressTestCheck').getChecked();
				        			for(var i=0,n=checks.length;i<n;i++){checks[i].setValue(false);}
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
			    		hidden:true,
				    	id:'isProgressTestCheck',
				    	width:500,
				    	xtype: 'checkboxgroup',
				        columns: 5,
				        items: testTypeArray
					},{ 
			    		hidden:true,
				    	width: 250, 
				    	name: 'hasTest', 
				        fieldLabel: '<font color="red">需要实现自动化</font>',
				        xtype: 'combo', 
				        forceSelection: true,
				        //allowBlank: false,
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
		    		}
		    	]
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
					   	fieldLabel: '<font color="red">*</font>用例前置条件',
					   	width:screenWidth*0.933/3,
					   	height: screenHeight*0.3,
						maxLength : 4000,
						allowBlank: false,
						maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
				  	},{
						name:'caseOperateInst',
						xtype:'textareafield',
						fieldLabel: '<font color="red">*</font>用例操作说明',
						width:screenWidth*0.933/3,
						height: screenHeight*0.3,
						maxLength : 4000,
						allowBlank: false,
						maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
				  	},{
						name:'preResult',
						xtype:'textareafield',
						fieldLabel: '<font color="red">*</font>预期结果',
						width:screenWidth*0.933/3,
						height: screenHeight*0.3,
						maxLength : 4000,
						allowBlank: false,
						maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
				  	}
				]
			},
			testSeceneRGrid
		]
	});
	return caseForm;
}
//---用例----end---
//---要素----------
function getElem(elemId,type){
	var testElemForm = top.Ext.widget('form', {
		tbar:top.Ext.create('Ext.Toolbar',{
			items:[{
					text:'保存并关联',
					handler:function(){
						var saveElemMasker = new maskerWithHtmlEl(top.Ext.getCmp('testElemWindow'),'正在保存要素信息，请稍后');
						saveElemMasker.show();
						var valueForm = testElemForm.getForm();
						if(type=='add'){
							valueForm.findField('funId').setValue('<%=request.getParameter("funId")%>');
							valueForm.findField('isGlobalElem').setValue('0');
							valueForm.findField('funName').setValue(Ext.getCmp('funFolderForm').getForm().findField('sysName').getValue());
							valueForm.findField('sysName').setValue(Ext.getCmp('funFolderForm').getForm().findField('sysId').getRawValue());
							if(<%=request.getParameter("sysId")%>==null||'<%=request.getParameter("sysId")%>'==''){
		        				Ext.Msg.alert('提示','未获取到系统信息');
		        				return;
		        			}
							valueForm.findField('sysId').setValue('<%=request.getParameter("sysId")%>');  
						}
						var eName=encodeURI(encodeURI(valueForm.findField('elemName').getValue()));
						testElemForm.submit({
							clientValidation: true,
				  			url:"<%=request.getContextPath()%>/saveTestElemAndRela.do?funId=<%=request.getParameter("funId")%>&sysId=<%=request.getParameter("sysId")%>&eName="+eName+"&type="+type,
				  			method:'POST',  
		                   	success:function(response,config){
		                   		var json = Ext.JSON.decode(config.response.responseText);
		                   		if(json.elemId==0){
		                   			if("edit"==type){
			                   			top.Ext.Msg.alert("操作","存在名称为<font color='red'>"+json.message+"</font>的要素，请重新命名！");
		                   			}else if("add"==type){
		                   				top.Ext.Msg.alert("操作","存在名称为<font color='red'>"+json.message+"</font>的要素，请优先关联此要素！");
		                   			}
		                   		}else{
			                   		top.Ext.Msg.alert("操作","保存并关联成功");
			                   		testElemForm.load({
			                   			url:'<%=request.getContextPath()%>/getTestElemForm.do?elemId='+json.elemId,
			                   			success:function(response,config){},
			                   			failure:function(response,config){top.Ext.Msg.alert("操作","获取要素信息失败");}
			                   		});
		                   		}
			                   	saveElemMasker.hide();
		                   	},
		                   	failure:function(response,config){
		                   		saveElemMasker.hide();
		                   		var errorType = config.failureType;
								if(errorType=="client"){
									top.Ext.Msg.alert("提示","请处理带有红色下划线的字段的错误");
								}else if(config.failureType =="connect"){
									top.Ext.Msg.alert("提示","当前网络不畅，请稍后再试");
								}else{
									var json = Ext.JSON.decode(config.response.responseText);
									if(json.errorInfo!=null&&json.errorInfo.length>0){
										top.Ext.Msg.alert("提示","<font color='red'>保存失败</font>,"+json.errorInfo);
										top.Ext.getCmp('testElemWindow').close();
									}else{
										top.Ext.Msg.alert("提示","<font color='red'>保存失败</font>,在保存时后台出现异常");
									}
								}
		                   	}
						});
					}
				}
			]
		}),
		id: 'testElemForm',
		cls: 'ui-formPanel',
		width : screenWidth*0.878,
		height: screenHeight*0.22,
		minHeight:100,
		border:0,
		title: '测试要素',
		layout:{type: 'vbox'}, 
		fieldDefaults: { 
		    labelAlign: 'right', 
		    labelWidth: 100, 
		    labelStyle: 'font-weight:bold' 
		},
     	defaults: {margins: '15 0 0 0' }, 
        listeners:{
			render:function(form,eOpts){
				if(type=='edit'){
					var caseFormLoadMasker = new maskerWithHtmlEl(top.Ext.getCmp('testElemWindow'),'正在获取要素信息，请稍后');
					form.load({
						url:'<%=request.getContextPath()%>/getTestElemForm.do?elemId='+elemId,
						success:function(response,config){caseFormLoadMasker.hide();},
						failure:function(response,config){
							caseFormLoadMasker.hide();
							top.Ext.Msg.alert("操作","获取要素信息失败");
						}
					});
				}
			}
        },
		items: [{
				xtype: 'fieldcontainer', 
				labelStyle: 'font-weight:bold;padding:0', 
				layout: 'hbox', 
				defaultType: 'textfield', 
				fieldDefaults: {labelAlign: 'right' }, 
				items: [
					{name: 'elemId',xtype: 'hidden'},
	            	{name: 'isDelete',xtype: 'hidden'},
	            	{name: 'sysId',xtype: 'hidden'},
	            	{name: 'funId',xtype: 'hidden'},
	            	{xtype: "textfield",name: "isDelete",hidden :true},
					{xtype: "textfield",name: "funId",hidden :true},
					{xtype: "textfield",name: "sysName",hidden :true},
					{xtype: "textfield",name: "funName",hidden :true},
					{xtype: 'textfield',name: 'elemTag',fieldLabel: '要素编号',readOnly:true},
	            	{
		                xtype: 'textfield',
		                name: 'elemName',
		                fieldLabel: '<font color="red">要素名称</font>',
		                allowBlank: false,
				        maxLength : 500,
				        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
	            	},{
				    	name: 'elemSysAchieveType', 
				        fieldLabel: '<font color="red">要素类型</font>',
				        xtype: 'combo', 
				        allowBlank: false,
				        forceSelection: true,
				        emptyText:'请选择要素类型',
				        store:Ext.create('Ext.data.Store', {
				        	autoLoad:true,
							model:"extCommboModel",
							proxy:Ext.create('Ext.data.proxy.Ajax',{
								type:"ajax",
								model:"extCommboModel",
								url:'<%=request.getContextPath()%>/getCaseParam.do?type=elem_type',
								reader:{
									root:"data",
									type:"json"
								}
							})
						}),
						displayField:'text',
						valueField:'value',
						mode:'remote'
	            	}
				]
			},{
				xtype: 'fieldcontainer', 
				labelStyle: 'font-weight:bold;padding:0', 
				layout: 'hbox', 
				defaultType: 'textfield', 
				fieldDefaults: {labelAlign: 'right' }, 
				items:[
	            	{xtype: 'hidden',name: 'applicateSys',fieldLabel: '适用系统'},
	            	{xtype: 'hidden',name: 'isGlobalElem',fieldLabel: '是否全局要素'},
	            	{
	            		hidden:true,
				    	name: 'addReasonType', 
				        fieldLabel: '<font color="red">新增原因类型</font>',
				        xtype: 'combo', 
				        width:240,
				        //allowBlank: false,
				        forceSelection: true,
				        emptyText:'请选择新增原因类型',
				        store:Ext.create('Ext.data.Store', {
				        	autoLoad:true,
							model:"extCommboModel",
							proxy:Ext.create('Ext.data.proxy.Ajax',{
								type:"ajax",
								model:"extCommboModel",
								url:'<%=request.getContextPath()%>/getAddReasonParam.do',
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
	           			hidden:true,
		                xtype: 'textarea',
		                name: 'addReason',
				        width: 497,
				        height:40,
		                fieldLabel: '新增原因',
				        maxLength : 4000,
				        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
	           		}
				]
			}
		]
	});
	
	var subElemModel = Ext.regModel("subElemModel",{
		fields:[
			{name:'subElemId',type:'string'},
			{name:'elemId',type:'string'},
			{name:'elemValue',type:'string'},
			{name:'elemTestLogic',type:'string'},
			{name:'takeValueMethod',type:'string'},
			{name:'valueRemark',type:'string'}
		]
	});
	
	var subElemProxy = new Ext.data.proxy.Ajax({
		type:"ajax",
		model:subElemModel,
		url:'<%=request.getContextPath()%>/getSubElem.do',
		reader:{
			root:"data",
			type:"json"
		}
	});
	
	var subElemStore = Ext.create('Ext.data.Store',{
		model:subElemModel,
		proxy:subElemProxy
	});
	
	subElemStore.load({params:{elemId:elemId}});
	
	var subElemGrid = top.Ext.create('Ext.grid.Panel',{
		tbar: top.Ext.create('Ext.Toolbar',{
			items:[
				{
					text:'新增',
					handler:function(){
						var elemId = testElemForm.getForm().findField('elemId').getValue();
						if(elemId==""){
							top.Ext.Msg.alert("提示","请先保存要素");
							return;
						}
						var subElemForm = top.Ext.create('Ext.form.Panel',{
							tbar: top.Ext.create('Ext.Toolbar',{
								items:[{
										text:'保存',
										handler:function(){
											var subElemFormMasker = new maskerWithHtmlEl(addSubElemWindow,'正在保存要素值信息，请稍后');
											subElemFormMasker.show();
											var valueForm = subElemForm.getForm();
											valueForm.findField('elemId').setValue(elemId);
											subElemForm.submit({
												clientValidation: true,
									  			url:"<%=request.getContextPath()%>/saveSubElem.do",
									  			method:'POST',  
							                   	success:function(response,config){
							                   		subElemStore.reload({params:{elemId:elemId}});
							                   		subElemFormMasker.hide();
							                   		addSubElemWindow.close();
							                   	},
							                   	failure:function(response,config){
							                   		subElemFormMasker.hide();
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
									}
								]
							}),
							id:'subElemForm',
							width:486,
							height:266,
							cls: 'ui-formPanel',
							layout: {type: 'vbox'},
							bodyBorder: 0, 
							fieldDefaults: { 
								labelAlign: 'right', 
								labelWidth: 60, 
								labelStyle: 'font-weight:bold' 
							}, 
							defaults: {margins: '5 0 0 0' },
							items: [{
									xtype: 'fieldcontainer', 
								    labelStyle: 'font-weight:bold;padding:0',
								    layout: 'hbox',
								    defaultType: 'textfield',
								    fieldDefaults: {labelAlign: 'right'},
						    		items: [
						    			{xtype:'hidden',name: 'subElemId'},
									    {name: 'isDelete',xtype: 'hidden'},
						            	{xtype:'hidden',name: 'elemId'},
									    {xtype:'hidden',name: 'elemTestLogic'},
									    {
									    	width: 486, 
									    	height:70,
									    	name: 'elemValue', 
									    	xtype:'textareafield',
									        fieldLabel: '<font color="red">要素值</font>', 
									        allowBlank: false,
									        emptyText:'请填写要素值',
									        maxLength : 4000,
									        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
									    }
									]
								},{
									xtype: 'fieldcontainer', 
								    labelStyle: 'font-weight:bold;padding:0',
								    layout: 'hbox',
								    defaultType: 'textfield',
								    fieldDefaults: {labelAlign: 'right'},
								    items: [{
								    	width: 486, 
								    	height:70,
								    	name: 'takeValueMethod', 
								    	xtype:'textareafield',
								        fieldLabel: '<font color="red">取数方法</font>', 
								        allowBlank: false,
								        emptyText:'请填写取数方法',
								        maxLength : 4000,
								        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
								    }]
								},{
									xtype: 'fieldcontainer', 
								    labelStyle: 'font-weight:bold;padding:0',
								    layout: 'hbox',
								    defaultType: 'textfield',
								    fieldDefaults: {labelAlign: 'right'},
								    items: [{
								    	width: 486, 
								    	height:60,
								    	name: 'valueRemark', 
								    	xtype:'textareafield',
								        fieldLabel: '备注', 
								        maxLength : 4000,
								        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
								    }]
								}
							]
						});
						var addSubElemWindow = new top.Ext.window.Window({
							id:'addSubElemWindow',
						    width : 500,
						    height : 300,
						    title:'新增要素值',
						    modal : true,
						    resizable:false,
						    autoScroll: true,
						    closeAction : 'destroy',
						    items:[subElemForm]
						});
						addSubElemWindow.show();
					}
				},{
					text:'删除',
					handler:function(){
						var elemId = testElemForm.getForm().findField('elemId').getValue();
						if(elemId==''){
							top.Ext.Msg.alert("提示","未能获取到要素信息");
							return;
						}
						var selections = subElemGrid.getSelectionModel().getSelection();
						if(selections==null||selections.length==0){
							top.Ext.Msg.alert("提示","请选择一条测试要素值进行删除");
							return;
						}
						var deleteSubElemMasker = new maskerWithHtmlEl(top.Ext.getCmp('testElemWindow'),'正在删除要素值信息，请稍后');
						deleteSubElemMasker.show();
						var subElemId = new Array();
						for(var i=0,n=selections.length;i<n;i++){subElemId.push(selections[i].raw.subElemId);}
						Ext.Ajax.request({
							url:'<%=request.getContextPath()%>/deleteSubElem.do?subElemIds='+subElemId.join(","),
							success:function(response,config){
								var json = Ext.JSON.decode(response.responseText);
								if(json.success==true){
									if(json.data.length>0){
										deleteSubElemMasker.hide();
										top.Ext.Msg.alert("提示",json.data);
									}else{
										subElemStore.reload({params:{elemId:elemId}});
										deleteSubElemMasker.hide();
										top.Ext.Msg.alert("提示","删除成功");
									}
								}else{
									deleteSubElemMasker.hide();
									top.Ext.Msg.alert("错误","<font color='red'>删除失败</font>,删除要素值时后台出现错误");
								}
							},
							failure:function(response,config){
								deleteSubElemMasker.hide();
								top.Ext.Msg.alert("提示","数据请求失败");
							}
						});
					}
				}
			]
		}),
		id:'subElemGrid',
	    cls: 'ui-formPanel',
		title:'测试要素值',
		border:0,
		width : screenWidth*0.878,
        height: screenHeight*0.59,
		viewConfig:{
			forctFit:true,
			stripeRows:true
		},
		store:subElemStore,
		selModel:top.Ext.create("Ext.selection.CheckboxModel",{checkOnly : true,ignoreRightMouseSelection : true}),
		listeners:{
			itemdblclick:function(grid, record, item, index, e, eOpts ){
				var subElemId = record.raw.subElemId;
				var elemId = testElemForm.getForm().findField('elemId').getValue();
				if(elemId==""){
					top.Ext.Msg.alert("提示","请先保存要素");
					return;
				}
				var subElemForm = top.Ext.create('Ext.form.Panel',{
					tbar:top.Ext.create('Ext.Toolbar',{
						items:[{
								text:'保存',
								handler:function(){
									var subElemFormMasker = new maskerWithHtmlEl(editSubElemWindow,'正在保存要素值信息，请稍后');
									subElemFormMasker.show();
									var valueForm = subElemForm.getForm();
									valueForm.findField('elemId').setValue(elemId);
									subElemForm.submit({
										clientValidation: true,
							  			url:"<%=request.getContextPath()%>/saveSubElem.do",
							  			method:'POST',  
					                   	success:function(response,config){
					                   		subElemStore.reload({params:{elemId:elemId}});
					                   		subElemFormMasker.hide();
					                   		editSubElemWindow.close();
					                   	},
					                   	failure:function(response,config){
					                   		subElemFormMasker.hide();
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
							}
						]
					}),
					id:'subElemForm',
					width:486,
					height:266,
			        cls: 'ui-formPanel',
					layout: {type: 'vbox'},
					bodyBorder: 0, 
					fieldDefaults: { 
						labelAlign: 'right', 
						labelWidth: 60, 
						labelStyle: 'font-weight:bold' 
					}, 
					defaults: {margins: '5 0 0 0'}, 
					listeners:{
			        	render:function(form,eOpts){
			        		var loadTestSubElemMasker = new maskerWithHtmlEl(editSubElemWindow,'正在加载测试要素值信息，请稍后');
			        		loadTestSubElemMasker.show();
			        		form.load({
			        			url:'<%=request.getContextPath()%>/getTestSubElemForm.do?subElemId='+subElemId,
			             		success:function(response,config){loadTestSubElemMasker.hide();},
			             		failure:function(response,config){
			             			loadTestSubElemMasker.hide();
			                  		top.Ext.Msg.alert("操作","获取要素值信息失败");
			                  	}
			        		});
			        	}
			        },
					items: [{
							xtype: 'fieldcontainer', 
						    labelStyle: 'font-weight:bold;padding:0',
						    layout: 'hbox',
						    defaultType: 'textfield',
						    fieldDefaults: {labelAlign: 'right'},
						    items:[
						    	{xtype:'hidden',name: 'subElemId'},
							    {name: 'isDelete',xtype: 'hidden'},
				            	{xtype:'hidden',name: 'elemId'},
							    {xtype:'hidden',name: 'elemTestLogic'},
							    { 
							    	width: 486, 
							    	height:70,
							    	name: 'elemValue', 
							    	xtype:'textareafield',
							        fieldLabel: '<font color="red">要素值</font>', 
							        allowBlank: false,
							        emptyText:'请填写要素值',
							        maxLength : 4000,
							        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
							    }
						    ] 
						},{
							xtype: 'fieldcontainer', 
						    labelStyle: 'font-weight:bold;padding:0',
						    layout: 'hbox',
						    defaultType: 'textfield',
						    fieldDefaults: {labelAlign: 'right'},
						    items: [{
						    	width: 486, 
						    	height:70,
						    	name: 'takeValueMethod', 
						    	xtype:'textareafield',
						        fieldLabel: '<font color="red">取数方法</font>', 
						        allowBlank: false,
						        emptyText:'请填写取数方法',
						        maxLength : 4000,
						        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
						    }]
						},{
							xtype: 'fieldcontainer', 
						    labelStyle: 'font-weight:bold;padding:0',
						    layout: 'hbox',
						    defaultType: 'textfield',
						    fieldDefaults: {labelAlign: 'right'},
						    items: [{
						    	width: 486, 
						    	height:60,
						    	name: 'valueRemark', 
						    	xtype:'textareafield',
						        fieldLabel: '备注', 
						        maxLength : 4000,
						        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
						    }]
						}
					]
				});
				
				var editSubElemWindow = new top.Ext.window.Window({
					id:'editSubElemWindow',
				    width : 500,
				    height : 300,
				    title:'编辑要素值',
				    modal : true,
				    resizable:false,
				    closeAction : 'destroy',
				    items:[subElemForm]
				});
				editSubElemWindow.show();
			}
		},
		columns:[
			new top.Ext.grid.RowNumberer(),
			{header:"主键",width:100,dataIndex:"subElemId",sortable:true,hidden:true},
			{header:"外键",width:100,dataIndex:"elemId",sortable:true,hidden:true},
			{header:"要素值",width:200,dataIndex:"elemValue",sortable:true},
			{header:"要素测试逻辑",width:100,dataIndex:"elemTestLogic",sortable:true,hidden:true},
			{header:"取数方法",width:200,dataIndex:"takeValueMethod",sortable:true},
			{header:"备注",width:200,dataIndex:"valueRemark",sortable:true},
			{header:'操作', width:50,menuDisabled: true,xtype:'actioncolumn',sortable:false,
				items: [{
		      			icon:"<%=request.getContextPath()%>/css/images/copy-font.gif",
		   				id: 'copySecR',  
						tooltip: '复制要素值',  
						handler: function(grid, rowIndex, colIndex) {
							var record = grid.getStore().getAt(rowIndex);
							var subElemId = record.raw.subElemId;
							var elemId = testElemForm.getForm().findField('elemId').getValue();
							if(elemId==""){
								top.Ext.Msg.alert("提示","请先保存要素");
								return;
							}
							var subElemForm = top.Ext.create('Ext.form.Panel',{
								tbar:top.Ext.create('Ext.Toolbar',{
									items:[{
											text:'保存',
											handler:function(){
												var subElemFormMasker = new maskerWithHtmlEl(editSubElemWindow,'正在保存要素值信息，请稍后');
												subElemFormMasker.show();
												var valueForm = subElemForm.getForm();
												valueForm.findField('elemId').setValue(elemId);
												valueForm.findField('subElemId').setValue('');
												subElemForm.submit({
													clientValidation: true,
										  			url:"<%=request.getContextPath()%>/saveSubElem.do",
										  			method:'POST',  
								                   	success:function(response,config){
								                   		subElemStore.reload({params:{elemId:elemId}});
								                   		subElemFormMasker.hide();
								                   		editSubElemWindow.close();
								                   	},
								                   	failure:function(response,config){
								                   		subElemFormMasker.hide();
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
										}
									]
								}),
								id:'subElemForm',
								width:486,
								height:266,
						        cls: 'ui-formPanel',
								layout: {type: 'vbox'},
								bodyBorder: 0, 
								fieldDefaults: { 
									labelAlign: 'right', 
									labelWidth: 60, 
									labelStyle: 'font-weight:bold' 
								}, 
								defaults: {margins: '5 0 0 0'}, 
								listeners:{
						        	render:function(form,eOpts){
						        		var loadTestSubElemMasker = new maskerWithHtmlEl(editSubElemWindow,'正在加载测试要素值信息，请稍后');
						        		loadTestSubElemMasker.show();
						        		form.load({
						        			url:'<%=request.getContextPath()%>/getTestSubElemForm.do?subElemId='+subElemId,
						             		success:function(response,config){loadTestSubElemMasker.hide();},
						             		failure:function(response,config){
						             			loadTestSubElemMasker.hide();
						                  		top.Ext.Msg.alert("操作","获取要素值信息失败");
						                  	}
						        		});
						        	}
						        },
								items: [{
										xtype: 'fieldcontainer', 
									    labelStyle: 'font-weight:bold;padding:0',
									    layout: 'hbox',
									    defaultType: 'textfield',
							    		fieldDefaults: {labelAlign: 'right'},
									    items: [
									    	{xtype:'hidden',name: 'subElemId'},
										    {name: 'isDelete',xtype: 'hidden'},
							            	{xtype:'hidden',name: 'elemId'},
										    {xtype:'hidden',name: 'elemTestLogic'},
										    {
										    	width: 486, 
										    	height:70,
										    	name: 'elemValue', 
										    	xtype:'textareafield',
										        fieldLabel: '<font color="red">要素值</font>', 
										        allowBlank: false,
										        emptyText:'请填写要素值',
										        maxLength : 4000,
										        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
										    }
										]
									},{
										xtype: 'fieldcontainer', 
									    labelStyle: 'font-weight:bold;padding:0',
									    layout: 'hbox',
									    defaultType: 'textfield',
									    fieldDefaults: {labelAlign: 'right'},
									    items: [{
									    	width: 486, 
									    	height:70,
									    	name: 'takeValueMethod', 
									    	xtype:'textareafield',
									        fieldLabel: '<font color="red">取数方法</font>', 
									        allowBlank: false,
									        emptyText:'请填写取数方法',
									        maxLength : 4000,
									        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
									    }]
									},{
										xtype: 'fieldcontainer', 
									    labelStyle: 'font-weight:bold;padding:0',
									    layout: 'hbox',
									    defaultType: 'textfield',
									    fieldDefaults: {labelAlign: 'right'},
									    items: [{
									    	width: 486, 
									    	height:60,
									    	name: 'valueRemark', 
									    	xtype:'textareafield',
									        fieldLabel: '备注', 
									        maxLength : 4000,
									        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
									    }]
									}
								]
							});
							var editSubElemWindow = new top.Ext.window.Window({
								id:'editSubElemWindow',
							    width : 500,
							    height : 300,
							    title:'复制要素值',
							    modal : true,
							    resizable:false,
							    closeAction : 'destroy',
							    items:[subElemForm]
							});
							editSubElemWindow.show();
						}
					}
				]
			}
		]
	});
	var list = new Array();
	list.push(testElemForm);
	list.push(subElemGrid);
	return list;
}
//---要素----end---
</script>
</html>