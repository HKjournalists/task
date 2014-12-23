<!DOCTYPE HTML>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");%>
<%@ include file="/aiga/common/common.jsp" %>
<%
	String flag = request.getParameter("flag");//判断是添加还是修改 create alter
	if(flag == null){
		flag = "";
	}
	String isViewer = request.getParameter("isViewer");//判断是否只读 yes
	if(isViewer == null){
		isViewer = "";
	}
%>
 
<html>
<head>
	<title>创建功能点定义</title>
</head>
  
<body>
	<div id="funPountPanel"></div>
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
Ext.onReady(function(){
	Ext.QuickTips.init();
    Ext.tip.QuickTipManager.init();
    //性能测试类型
    var efficiencyTestTypeModel= Ext.define('mapModel', {
	    extend: 'Ext.data.Model',
	    fields: [
	        {name: 'constantId',  type: 'string'},
	        {name: 'categoryName', type: 'string'},
	        {name: 'category', type: 'string'},
	        {name: 'show', type: 'string'},
	        {name: 'value', type: 'int'},
	        {name: 'other1', type: 'string'},
	        {name: 'other2', type: 'string'},
	        {name: 'memo', type: 'string'}
	    ]
	});
	var efficiencyTestTypeStore=new  Ext.data.Store({
		autoLoad: false,
        remoteSort:true,
		id: 'efficiencyTestTypeStore',
		model:efficiencyTestTypeModel,
		groupField: 'categoryName',
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getMultipleSysConstant.do?categorys=efficiency_test_type',
			reader: {
				type: 'json',
				root: 'data'
			}
		}
	});
	var efficiencyTestTypeCombox = new Ext.form.ComboBox({
    	id:'efficiencyTestTypeCombox',
        width: 250,
        store: efficiencyTestTypeStore,
        labelAlign: 'right',
        allowBlank: false,
		forceSelection: true,
        queryMode: 'local',  //申明本属性即可实现过滤  
        name: "efficiencyTestType",
        fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>性能测试类型",
        valueField: 'value',
        displayField: 'show',
        listeners: {
            expand: function (queryEvent, eOpts) {
        		//queryEvent.query = "efficiencyTestTypeStore";
				var index =Ext.data.StoreManager.lookup("efficiencyTestTypeStore").find('show','无');
    			Ext.data.StoreManager.lookup("efficiencyTestTypeStore").removeAt(index );
    			//alert();
            },
            
        }
    });
	//是否为性能测试
    var isEfficiencyTestModel= Ext.define('mapModel', {
	    extend: 'Ext.data.Model',
	    fields: [
	        {name: 'constantId',  type: 'string'},
	        {name: 'categoryName', type: 'string'},
	        {name: 'category', type: 'string'},
	        {name: 'show', type: 'string'},
	        {name: 'value', type: 'int'},
	        {name: 'other1', type: 'string'},
	        {name: 'other2', type: 'string'},
	        {name: 'memo', type: 'string'}
	    ]
	});
	var isEfficiencyTestStore=new  Ext.data.Store({
		autoLoad: true,
		id: 'isEfficiencyTestStore',
		model:isEfficiencyTestModel,
		groupField: 'categoryName',
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getMultipleSysConstant.do?categorys=efficiency_test',
			reader: {
				type: 'json',
				root: 'data'
			}
		}
	});
	var isEfficiencyTestCombox = new Ext.form.ComboBox({
    	id:'isEfficiencyTestCombox',
        width: 250,
        store: isEfficiencyTestStore,
        allowBlank: false,
        labelAlign: 'right',
		forceSelection: true,
		mode: 'local',//申明本属性即可实现过滤  
        name: "isEfficiencyTest",
        fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>是否性能测试",
        valueField: 'value',
        displayField: 'show',
        listeners: {
            beforequery: function (queryEvent, eOpts) {
                queryEvent.query = "isEfficiencyTest";
            },
            change:function( field, newValue, oldValue, eOpts ){
            	if(newValue==1){
            		Ext.getCmp("efficiencyTestTypeCombox").enable(true);
            	}
				if(newValue==0){
					<%if(!(isViewer!=null&&!isViewer.equals("")&&isViewer.equals("yes"))){%>
					Ext.getCmp("efficiencyTestTypeCombox").setValue("3");
            		Ext.getCmp("efficiencyTestTypeCombox").disable(true);
					<%}%>
            	}
            },
            select:function(){
            	 try{
                     var efficiencyTest = Ext.getCmp("efficiencyTestTypeCombox");
                     efficiencyTest.clearValue();
                     efficiencyTest.store.load();
                 }
                 catch(ex){
                     Ext.MessageBox.alert("错误","数据加载失败。");
                 }
            }
        }
    });
	//维护厂商
	var devFirmStore = new Ext.data.Store({
        id: 'devFirmStore',
        fields: ['value', 'show'],
        proxy: {
            type: 'ajax',
            url: '<%=request.getContextPath()%>/getComBoxForFirm.do?query=firm',
            reader: {
            	type: 'json',
            	root: 'data'
            }
        }
    });
	devFirmStore.load();
    var devFirmCombox = new Ext.form.ComboBox({
    	id:'devFirmCombox',
        width: 250,
        store: devFirmStore,
        labelAlign: 'right',
		forceSelection: true,
		mode: 'local',//申明本属性即可实现过滤  
        name: "devFirm",
        fieldLabel: "维护厂商",
        valueField: 'value',
        displayField: 'show',
        listeners: {
            beforequery: function (queryEvent, eOpts) {
                queryEvent.query = "firm";
            }
        }
    });
    /**
     * 功能点类型下拉框
     */
    var funTypeStore = new Ext.data.Store({
        id: 'funTypeStore',
        fields: ['value', 'show'],
        proxy: {
            type: 'ajax',
            url: '<%=request.getContextPath()%>/getComBoxForFunFolder.do?query=fun_type',
            reader: {
            	type: 'json',
            	root: 'data'
            }
        }
    });
    funTypeStore.load();
    var funTypeCombox = new Ext.form.ComboBox({
        width: 250,
        store: funTypeStore,
        labelAlign: 'right',
        name: "funType",
		forceSelection: true,
        fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>功能点类型",
        allowBlank: false,
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
        fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>重要级别",
        valueField: 'value',
        displayField: 'show',
		forceSelection: true,
        allowBlank: false,
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
    var sysIdCombox = Ext.create('Ext.form.field.ComboBox',{
    	id:'sysIdCombox',
        store: sysIdStore,
        labelAlign: 'right',
        id: "sysId",
        name: "sysId",
        width: 250,
		forceSelection:true,
       	typeAhead:true,
        fieldLabel: "归属系统",
        valueField: 'value',
        displayField: 'show',
        listeners: {
            beforequery: function (queryEvent, eOpts) {
                queryEvent.query = "sysIdStore";
            }
        }
    });
    /**
     * 所属子系统
     */
    var subSysIdStore = new Ext.data.Store({
        id: 'subSysIdStore',
        fields: ['value', 'show'],
        proxy: {
            type: 'ajax',
            url: '<%=request.getContextPath()%>/getComBoxForSubSystemFolder.do',
            reader: {
                type: 'json',
                root: 'data'
            }
        }
    });
    subSysIdStore.load();
	var funFolderForm = Ext.widget('form', {
        id: 'funFolderForm',
        width: screenWidth,
        border:0,
		<%if((!flag.equals("")&&flag.equals("create"))||(!flag.equals("")&&flag.equals("alter")&&isViewer!=null&&isViewer.equals(""))){%>
        tbar: [{
        	xtype: 'button',
            text: '保存',
            handler: function () {
            	var form = Ext.getCmp('funFolderForm');
            	var formData = form.getValues();
                MaskLoading();
                form.submit({
                	clientValidation: true,
                    url: "<%=request.getContextPath()%>/saveFunFloderForm.do",
                    params: {baseFunLabel:getAllSysLabel(),busiLabel:getAllOwnLabel(),operatorName:'<%=user.getUserName()%>',operatorId:'<%=user.getUserId()%>'},
                    method: 'POST',
                    success: function (response, config) {
                    	MaskOver();
                        var success = config.result.success;
                        // 当后台数据同步成功时  
						if (success) {
                        	Ext.MessageBox.show({        
                        		title: '提示',        
                        		msg: '保存成功!',
        						buttons: Ext.MessageBox.OKCANCEL,        
        						fn: function(btn){           
                        			if(btn=='ok'){
									    <%if(!flag.equals("")&&flag.equals("create")){%>
                        				top.Ext.getCmp("funFolderCreateWin").close(); 
									    <%}if(!flag.equals("")&&flag.equals("alter")){%>
                        				top.Ext.getCmp("funFolderAlterWin").close(); 
									    <%}%> 
                        			} 
                        		},  
                        		icon: Ext.MessageBox.QUESTION    
                        	});
						}
					},
                    failure: function (response, config) {
						//console.log(response);
						//console.log(config);
                    	MaskOver();
                    	if(config.failureType=="client"){
                    		Ext.Msg.alert("提示","<font style='color: red; font-weight:bold;'>*</font>为必填项!");
                    	}else{
                        	Ext.Msg.alert("提示","保存失败!");
                    	}
                    }
                });
			}
        }],
		<%}%>
		<%if(!flag.equals("")&&flag.equals("create")){%>
		title: '新增功能点信息',
	    <%}if(!flag.equals("")&&flag.equals("alter")){%>
		title: '修改功能点信息',
	    <%}if(!flag.equals("")&&flag.equals("alter")&&isViewer!=null&&!isViewer.equals("")&&isViewer.equals("yes")){%>
		title: '查看功能点信息',
	    <%}%> 
        layout: {
        	type: 'vbox'
        },
        listeners: {
			render: function (render, eOpts) {
		    		<%if(!flag.equals("")&&flag.equals("alter")){%>
		    		efficiencyTestTypeStore.load();
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
                    	var subSysId = action.result.data.subSysId;
                    	if(subSysId==0){
                    		Ext.getCmp('funFolderForm').getForm().findField('subSysId').setValue("");
                    	}
                    	<%if(isViewer==null){%>
                    	var fieldAry = Ext.getCmp('funFolderForm').getForm().getFields();
						for(var i = 0; i < fieldAry.length; i++) {
							if(fieldAry.get(i).getName()!="isEfficiencyTest"){
								continue;
							}
                    		if(fieldAry.get(i).getValue()==0){
                    			fieldAry.get(i).disable(true);
                    		}
				  		}
						<%}%>
                    	<%if(isViewer!=null&&!isViewer.equals("")&&isViewer.equals("yes")){%>
                    	var fieldAry = Ext.getCmp('funFolderForm').getForm().getFields();
						for(var i = 0; i < fieldAry.length; i++) {
							//if(fieldAry.get(i).getName()=="reqTime"||fieldAry.get(i).getName()=="codeCommitDate"||fieldAry.get(i).getName()=="factCompleteTime"||fieldAry.get(i).getName()=="changeReason")continue;
							//console.log(fieldAry.get(i).getXTypes());
				  			fieldAry.get(i).setReadOnly(true);
				  		}
                    	<%}%>
                    	loadAutoLabel(action.result.data.baseFunLabel,action.result.data.busiLabel);
                    },
                    failure: function (form, action) {
                        Ext.Msg.alert('提示', "失败原因是: " + action.result.errorMessage);
                    }
                });
		    	<%}if(!flag.equals("")&&flag.equals("create")){%>
		    	var fieldAry = Ext.getCmp('funFolderForm').getForm().getFields();
				for(var i = 0; i < fieldAry.length; i++) {
					if(fieldAry.get(i).getName()!="efficiencyTestType"){
						continue;
					}
					fieldAry.get(i).disable(true);
		  		}
		    	<%}%>
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
		                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>功能点名称",
		                allowBlank: false
	            	},{
		                xtype: 'hidden',
		                id:'funId',
		                name: 'funId',
		                fieldLabel: '功能点id'
	            	},{
		                xtype: 'hidden',
		                id:'creatorId',
		                name: 'creatorId',
		                fieldLabel: '创建人ID'
	            	},{
		                xtype: 'hidden',
		                id:'creatorName',
		                name: 'creatorName',
		                fieldLabel: '创建人名称'
	            	},{
		                xtype: 'hidden',
		                id:'createTime',
		                name: 'createTime',
		                fieldLabel: '创建时间'
	            	},{
		                xtype: 'hidden',
		                id:'isInvalid',
		                name: 'isInvalid',
		                fieldLabel: '是否已被禁用',
		                value:'0'
	            	},
	            	funTypeCombox,
	            	importantClassCombox
	            ]
			},{
	        	xtype: 'fieldcontainer',
	            labelStyle: 'font-weight:bold;padding:0',
	            layout: 'hbox',
	            items: [
	            	{
                        xtype: "combo",
                        id: "tbarBigType",
				        width: 250,
						forceSelection:true,
				       	typeAhead:true,
                        store: sysIdStore,
                        name: "sysId",
                        fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>归属系统",
        				allowBlank: false,
                        valueField: 'value',
        				labelAlign: 'right',
                        displayField: 'show',
		                triggerAction: 'all',
		                queryMode: 'local',
		                minChars:1,
		                selectOnFocus: true,
			           	mode:'local',
			           	value:'',
					    listeners:{
					    	change: function(combo, newValue, oldValue, eOpts) {
	            				//1.get subSys combox value
	            				var subSysId = Ext.getCmp('subSysIdCombox').getValue();
	            				var storeClone = Ext.clone(Ext.StoreMgr.get('subSysIdStore'));//克隆一个原有的Store
	            				storeClone.setProxy(
					    		{
					    			type: 'ajax',
							        url: '<%=request.getContextPath()%>/getComBoxForSubSystemFolder.do?sysId='+newValue,
							        reader: {
							        	type: 'json',
							        	root: 'data'
							    	}
							    });
	            				storeClone.reload();//加载一次最新的Store
	            				//console.log(storeClone.findRecord("value",subSysId));
	            				if(storeClone.findRecord("value",subSysId)==null){
	            					Ext.getCmp('subSysIdCombox').clearValue();
						    		Ext.StoreMgr.get('subSysIdStore').setProxy(
						    		{
						    			type: 'ajax',
								        url: '<%=request.getContextPath()%>/getComBoxForSubSystemFolder.do?sysId='+newValue,
								        reader: {
								        	type: 'json',
								        	root: 'data'
								    	}
								    });
						    		Ext.StoreMgr.get('subSysIdStore').reload();
	            				}
					    		//2.through store , if the new store's values have the old value
					    		//3.if there is, selected; if not , null.
					    	}
					    }
                       }, {
                           xtype: "combo",
					       width: 250,
						   forceSelection:true,
					       typeAhead:true,
        				   labelAlign: 'right',
                           id: "subSysIdCombox",
                           store: subSysIdStore,
                           name: "subSysId",
                           fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>所属子系统",
        				   allowBlank: false,
                           valueField: 'value',
                           displayField: 'show',
			               triggerAction: 'all',
			               queryMode: 'local',
			               minChars:1,
			               selectOnFocus: true,
				           mode:'local',
				           value:''
                       },
	            	isEfficiencyTestCombox,
	            	efficiencyTestTypeCombox,
	            ]
			},{
	        	xtype: 'fieldcontainer',
	            labelStyle: 'font-weight:bold;padding:0',
	            layout: 'hbox',
	            items: [
	            	devFirmCombox
	            ]
			},{
				xtype: 'fieldcontainer',
	            labelStyle: 'font-weight:bold;padding:0',
	            layout: 'hbox',
	            items: [
	                {
	            		html:'<div id="autoLabel" style="border: none"></div>',border:false
	            	}
	            ]
            },{
	        	xtype: 'fieldcontainer',
	            labelStyle: 'font-weight:bold;padding:0',
	            layout: 'hbox',
	            defaultType: 'textfield',
	            items: [
	            	{
		            	width: 1000,
		                labelAlign: 'right',
		                id:'menuPath',
		                name: 'menuPath',
		                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>菜单路径",
		                allowBlank: false
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
                        fieldLabel: '数据检查脚本'
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
                        fieldLabel: '功能点描述'
                    }
                ]
            }
		]
	});
	Ext.create('Ext.Panel', {
    	id:'funPointPanel',
        renderTo: Ext.get('funPountPanel'),
        cls: 'ui-formPanel',
        width: screenWidth,
        height: screenHeight,
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
            items: [funFolderForm]
        }]
    });
	addLabel('autoLabel');
	Ext.getCmp('funFolderForm').doLayout();
});
function addLabel(divId) {
	Ext.QuickTips.init();
	var baseFunLabel = new Ext.data.Store({
		autoLoad: true,
		id: 'baseFunLabel',
		fields: ['show','show'],
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getComBoxForBaseBusi.do',
			reader: {
				type: 'json',
				root: 'data'
			}
		}
	});
	var busiLabel = new Ext.data.Store({
		autoLoad: true,
		id: 'busiLabel',
		fields: ['show','show'],
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getComBoxForBusi.do',
			reader: {
				type: 'json',
				root: 'data'
			}
		}
	});
	var sysAddBtn = new Ext.Button({
		id: 'sysAddBtn',
		text: '添加',
		margin: '0 0 0 20',
		listeners:{
			click: {
				fn:function(){
					addSysLabel();
				}
		}}<% if(isViewer!=null&&!isViewer.equals("")&&isViewer.equals("yes")){%>,hidden:true<%} %>
	});
	var ownAddBtn = new Ext.Button({
		text: '添加',
		margin: '0 0 0 20',
		id:'ownAddBtn',
		listeners:{
			click: {
				fn:function(){
					addOwnLabel();
				}
		}}<% if(isViewer!=null&&!isViewer.equals("")&&isViewer.equals("yes")){%>,hidden:true<%} %>
	});
	var sysLabel = new Ext.form.Panel({
		id: 'sysLabel',
		renderTo: Ext.get(divId),
		width: 900,
		height: 30,
		border: false,
		layout:'hbox',
		items:[
			{xtype:'label',text:'基础业务标签:',margin:'2 5 2 20',width: 80,style:'text-align:right;line-height: 18px;'},
			sysAddBtn
		]
	});
	var ownLabel = new Ext.form.Panel({
		id: 'ownLabel',
		renderTo: Ext.get(divId),
		width: 900,
		height: 28,
		border: false,
		layout:'hbox',
		items:[
			{xtype:'label',text:'业务标签:',margin:'2 5 2 20',width: 80,style:'text-align:right;line-height: 18px;'},
			ownAddBtn
		]
	});
}

function addSysLabel(value) {
	var length = (Ext.getCmp('sysLabel').items.length - 2)/2;
	if(length == 5) {
		return;
	}
	Ext.getCmp('sysLabel').remove(Ext.getCmp('sysAddBtn'));
	var sysAddBtn = new Ext.Button({
		text: '添加',
		id:'sysAddBtn',
		listeners:{
			click: {
				fn:function(){
					addSysLabel();
				}
			}
		}<% if(isViewer!=null&&!isViewer.equals("")&&isViewer.equals("yes")){%>,hidden:true<%} %>
	});
	var delImg = new Ext.Img({
		src:'<%=request.getContextPath()%>/images/del.gif',
		width: 16,
		height: 16,
		margin:'2 10 2 0',
		listeners: {
			el:{
				click:function() {
					removeCurLabel('sysLabel');
				}
			}
		}<% if(isViewer!=null&&!isViewer.equals("")&&isViewer.equals("yes")){%>,hidden:true<%} %>
	});
	Ext.getCmp('sysLabel').doLayout();
	var new_store_Base = Ext.clone(Ext.data.StoreManager.lookup("baseFunLabel"));
	var selectedData = getAllSysLabel();
  	var selectArray= new Array();
  	selectArray = selectedData.split(",");
  	if(selectedData.length <= 0){
  		selectArray = new Array();
  		new_store_Base.load();
  	}
  	        		
	for(var i = 0; i < selectArray.length; i++){
		for(var j = 0; j < new_store_Base.getCount(); j++){
			record = new_store_Base.getAt(j);
			if(record.get('show') == selectArray[i]) {
				//console.log("record:" + j);
				new_store_Base.removeAt(j);break;
			}
		}
	}
	Ext.getCmp('sysLabel').add(new Ext.form.ComboBox({width: 110,
		store:new_store_Base,
		queryMode: 'local',
		valueField: 'show',
		displayField: 'show',
		name:'baseFunLabel',
		forceSelection:true,
       	typeAhead:true,
		value:value,
		<% if(isViewer!=null&&!isViewer.equals("")&&isViewer.equals("yes")){%>readOnly:true,<%} %>
        listeners :{
        	select:function( combo, records, eOpts ){
        		combo.setReadOnly(true);
        	}
        }
	}));
	Ext.getCmp('sysLabel').add(delImg);
	Ext.getCmp('sysLabel').add(sysAddBtn);
}

function addOwnLabel(value) {
	var length = (Ext.getCmp('ownLabel').items.length - 2)/2;
	if(length == 5) {
		return;
	}
	Ext.getCmp('ownLabel').remove(Ext.getCmp('ownAddBtn'));
	var ownAddBtn = new Ext.Button({
		text: '添加',
		id:'ownAddBtn',
		listeners:{
			click: {
				fn:function(){
					addOwnLabel();
				}
		}}<% if(isViewer!=null&&!isViewer.equals("")&&isViewer.equals("yes")){%>,hidden:true<%} %>
	});
	var delImg = new Ext.Img({
		src:'<%=request.getContextPath()%>/images/del.gif',
		width: 16,
		height: 16,
		margin:'2 10 2 0',
		listeners: {
			el:{
				click:function() {
					removeCurLabel('ownLabel');
				}
			}
		}<% if(isViewer!=null&&!isViewer.equals("")&&isViewer.equals("yes")){%>,hidden:true<%} %>
	});
	Ext.getCmp('ownLabel').doLayout();
	
	var new_store = Ext.clone(Ext.data.StoreManager.lookup("busiLabel"));
	var selectedData = getAllOwnLabel();
  	var selectArray= new Array();
  	selectArray = selectedData.split(",");
  	if(selectedData.length <= 0){
  		selectArray = new Array();
  		new_store.load();
  	}
  	        		
	for(var i = 0; i < selectArray.length; i++){
		for(var j = 0; j < new_store.getCount(); j++){
			record = new_store.getAt(j);
			if(record.get('show') == selectArray[i]) {
				//console.log("record:" + j);
				new_store.removeAt(j);break;
			}
		}
	}
	
	Ext.getCmp('ownLabel').add(
		new Ext.form.ComboBox({width: 110,
			store: new_store,
			queryMode: 'local',
			valueField: 'show',
			displayField: 'show',
			name:'busiLabel',
			forceSelection:true,
        	typeAhead:true,
			value:value,
			<% if(isViewer!=null&&!isViewer.equals("")&&isViewer.equals("yes")){%>readOnly:true,<%} %>
  	        listeners :{
  	        	select:function( combo, records, eOpts ){
  	        		combo.setReadOnly(true);
  	        	}
  	        }
	}));
	Ext.getCmp('ownLabel').add(delImg);
	Ext.getCmp('ownLabel').add(ownAddBtn);
}

function removeCurLabel(labelId) {
	Ext.getCmp(labelId).remove(Ext.getCmp($(event.srcElement).prev().attr('id')));
	Ext.getCmp(labelId).remove(Ext.getCmp($(event.srcElement).attr('id')));
	Ext.getCmp(labelId).doLayout();
}

function getAllSysLabel() {
	var ay = new Array();
	$('input[name=baseFunLabel]').each(function(){
		ay.push(Ext.getCmp($(this).attr('id').replace("-inputEl","")).getValue());
	});
	return ay+"";
}

function getAllOwnLabel() {
	var ay = new Array();
	$('input[name=busiLabel]').each(function(){
		ay.push(Ext.getCmp($(this).attr('id').replace("-inputEl","")).getValue());
	});
	return ay+"";
}

function loadAutoLabel(sysLabelData,ownLabelData) {
	$("#autoLabel").html("");
	addLabel('autoLabel');
	var baseForm = Ext.getCmp('funFolderForm').getForm();
	if(sysLabelData != null && sysLabelData != "") {
		var sysAry = sysLabelData.split(",");
		for(var i = 0; i <sysAry.length; i++) {
			addSysLabel(sysAry[i]);
		}
	}
	if(ownLabelData != null && ownLabelData != "") {
		var sysAry = ownLabelData.split(",");
		for(var i = 0; i <sysAry.length; i++) {
			addOwnLabel(sysAry[i]);
		}
	}
}
</script>
</html>