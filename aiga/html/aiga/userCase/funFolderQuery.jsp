<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/aiga/common/common.jsp" %>
<%
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
	boolean isFlag = true;
	String flag = "1";
%>
<html>
    
<head>
	<title>功能点查询</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/aiga/workflow/testTask/ajaxFileUpload/ajaxfileupload.js"></script>
	<style type="text/css">
		#uploadForm-body table {
		    float: left;
		}
		#uploadForm-body div {
		    float: left;
		}
		.red {
		    color:red;
		}
	</style>
</head>

<body>
  	<img id="loading" src="<%=request.getContextPath()%>/aiga/workflow/testTask/ajaxFileUpload/loading.gif" style="display:none;">
		<form name="form" action="" method="POST" enctype="multipart/form-data">
		<div id='uploadTestTaskDiv'></div>
		</form>
		<form style="display:none;" id="exportForm" action="<%=request.getContextPath()%>/downloadTemplateExcel.do?templateFileName=funFolder.xls"
			enctype="multipart/form-data" method="post" target="temp">
			<input type="hidden" name="method" value="export" />
			<input type="submit" id="download" class="tmpBtn" value="下载" />
		</form>
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
function ajaxFileUpload(){
	MaskLoading();
	url="<%=request.getContextPath()%>/uploadFunFolderExcel.do";
	$.ajaxFileUpload(
			{
				url:url,
				secureuri:false,
				fileElementId:'fileToUpload',
				dataType: 'json',
			success: function (data, status)
			{
					MaskOver();
					var funFolderStore=Ext.data.StoreManager.lookup('funFolderStore');
					funFolderStore.add(data.data);
					if(typeof(data.msg)=="undefined"){
						Ext.Msg.alert("提示","导入成功！");
					}else{
						Ext.Msg.alert("错误提示",data.msg);
					}
			},
			error: function (data, status, e)
			{	
				MaskOver();
			    Ext.Msg.alert("错误提示",data.msg);
			}
		}
	)
	
	return false;

}
Ext.onReady(function () {
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
		autoLoad: true,
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
		forceSelection:true,
       	typeAhead:true,
		mode: 'local',//申明本属性即可实现过滤  
        name: "efficiencyTestType",
        fieldLabel: "性能测试类型",
        valueField: 'value',
        displayField: 'show',
        listeners: {
            beforequery: function (queryEvent, eOpts) {
                queryEvent.query = "efficiencyTestType";
            }
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
       	typeAhead:true,
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
        },
		listeners:{
			load:function(store,records){
				var blankRecord={show:'--全部--'};
				store.insert(0,blankRecord)
				}
		}
    });
    funTypeStore.load();
    var funTypeCombox = new Ext.form.ComboBox({
    	id:'funTypeCombox',
        width: 200,
        store: funTypeStore,
        labelAlign: 'right',
        name: "funType",
        fieldLabel: "功能点类型",
		forceSelection:true,
       	typeAhead:true,
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
        },
		listeners:{
			load:function(store,records){
				var blankRecord={show:'--全部--'};
				store.insert(0,blankRecord)
				}
		}
    });
    importantClassStore.load();
    var importantClassCombox = new Ext.form.ComboBox({
    	id:'importantClassCombox',
        width: 200,
        store: importantClassStore,
        labelAlign: 'right',
        name: "importantClass",
        fieldLabel: "重要级别",
        valueField: 'value',
		forceSelection:true,
       	typeAhead:true,
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
        },
		listeners:{
			load:function(store,records){
				var blankRecord={show:'--全部--'};
				store.insert(0,blankRecord)
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
        },
        listeners:{
        	load : function(store, records, options ){
		      	var blankRecord={show:'--全部--'};
				store.insert(0,blankRecord)
		    }
        }
    });
    subSysIdStore.load();
    var btn = new Ext.Button({
	    text: '查询',
	    width: 60,
	    margin: '0 0 0 50px',
	    handler: function() {
			Ext.StoreMgr.get('funFolderStore').loadPage(1);
			//Ext.StoreMgr.get('funFolderStore').load();
		}
	});
    var qryForm = new Ext.form.FormPanel({
        id: 'qryForm',
        title: '查询区域',
        cls: 'ui-formPanel',
        defaults: {
            margins: '5 0 5 0',
        },
        renderTo: Ext.getBody(),
        width: screenWidth * 0.98,
        height: screenHeight * 0.15 * 0.99,
        layout: 'vbox',
        bodyBorder: 0,
        items: [{
            xtype: 'fieldcontainer',
            labelStyle: 'font-weight:bold;padding:0',
            fieldDefaults: {
                labelAlign: 'right',
                labelWidth: 90,
                width: 200
            },
            layout: 'hbox',
            defaultType: 'textfield',
            items: [
                    {name: 'sysName',fieldLabel: '功能点名称'},
                    //sysIdCombox,//归属系统
                    //subSysIdCombox,//归属子系统
                    {
                            xtype: "combo",
                            id: "tbarBigType",
					        width: 200,
							forceSelection:true,
					       	typeAhead:true,
                            labelWidth: 60,
                            store: sysIdStore,
                            name: "sysId",
                            fieldLabel: "归属系统",
                            valueField: 'value',
                            displayField: 'show',
			                triggerAction: 'all',
			                queryMode: 'local',
			                minChars:1,
			                selectOnFocus: true,
				           	mode:'local',
				           	value:'',
						    listeners:{
						    	change: function(combo, newValue, oldValue, eOpts) {
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
						    		Ext.StoreMgr.get('subSysIdStore').load();
						    	}
						    }
                        }, {
                            xtype: "combo",
					        width: 200,
							forceSelection:true,
					       	typeAhead:true,
                            labelWidth: 80,
                            id: "subSysIdCombox",
                            store: subSysIdStore,
                            name: "subSysId",
                            fieldLabel: "所属子系统",
                            valueField: 'value',
                            displayField: 'show',
			                triggerAction: 'all',
			                queryMode: 'local',
			                minChars:1,
			                selectOnFocus: true,
				           	mode:'local',
				           	value:''
                        },
            		importantClassCombox,//重要级别
            		funTypeCombox,//功能点类型
					{
			            xtype: 'fieldcontainer',
			            labelStyle: 'font-weight:bold;padding:0',
			            fieldDefaults: {
			                labelAlign: 'right',
			                labelWidth: 90,
			                width: 200
			            },
			            layout: 'hbox',
			            defaultType: 'textfield',
			            items: [
							btn
			            ]
        			}
                ]
            }
        ]
	});
	var funFolderStore = Ext.create('Ext.data.Store', {
		storeId:'funFolderStore',
		pageSize: 20,//每页显示条数
		fields:[
	        {name:'funId',type:'string'},//功能点ID
	 		{name:'sysName',type:'string'},//功能点名称
	 		{name:'dataCheckScript',type:'string'},//数据检查脚本
	 		{name:'baseFunLabel',type:'string'},//基础业务标签
	 		{name:'busiLabel',type:'string'},//业务标签 
	 		{name:'sysId',type:'string'},//所属系统 
	 		{name:'createTime',type:'string'},//创建时间
	 		{name:'updateTime',type:'string'},//更新时间
	 		{name:'importantClass',type:'string'},//重要级别
	 		{name:'efficiencyTestType',type:'string'},//是否性能测试
	 		{name:'isEfficiencyTest',type:'string'},//性能测试类型
	 		{name:'devFirm',type:'string'},//维护厂商
	 		{name:'menuPath',type:'string'},//菜单路径
	 		{name:'funType',type:'string'},//功能点类型
	 		{name:'funDesc',type:'string'},//功能点描述
	 		{name:'isInvalid',type:'string'},//是否已被禁用
	 		{name:'subSysId',type:'string'},//所属子系统
	 		{name:'creatorId',type:'string'},//创建人ID
	 		{name:'creatorName',type:'string'},//创建人名称
	 		{name:'operatorId',type:'string'},//操作人ID
     		{name:'operatorName',type:'string'}//操作人名称
 		],
	    proxy: {
	        type: 'ajax',
        	url : '<%=request.getContextPath()%>/getFunFolderList.do',
	        reader: {
	            root:"data",
				type:"json",
            	totalProperty:'total'
	        }
	    }
	});
	funFolderStore.on('beforeload',function(){        // =======翻页时 查询条件     
		Ext.apply(       
			funFolderStore.proxy.extraParams, {
					sysName: encodeURI(encodeURI(Ext.getCmp('qryForm').getForm().findField('sysName').getValue())),
		           	sysId:Ext.getCmp('qryForm').getForm().findField('sysId').getValue(),
		           	subSysId:Ext.getCmp('qryForm').getForm().findField('subSysId').getValue(),
					importantClass:Ext.getCmp('qryForm').getForm().findField('importantClass').getValue(),
					funType:Ext.getCmp('qryForm').getForm().findField('funType').getValue()    
				}      
			);      
	});
	funFolderStore.load();
	var caseCollectionGrid = new Ext.grid.Panel({
        id: 'caseCollectionGrid',
        cls: 'ui-formPanel',
        width: screenWidth * 0.98,
        height: screenHeight * 0.85,
        renderTo: Ext.getBody(),
        title: '功能点详细信息列表',
        store: funFolderStore,
        bbar: Ext.create('Ext.PagingToolbar', { 
			store: funFolderStore, 
			displayInfo: true, 
			displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
			emptyMsg: "没有数据"
		}),
        tbar:[
        	{xtype: 'button',text: '新增',handler: function () {
        		funFolderCreateWin = new top.Ext.window.Window({
			 		id:'funFolderCreateWin',
				    title : '新增功能点',
				    width : 1050,
				    height : 408,
				    modal : true,
				    autoScroll:true,
				    listeners:{
						destroy:function(window,eOpts){
							funFolderStore = Ext.data.StoreManager.lookup("funFolderStore");
							funFolderStore.reload();
						}
				    },
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/userCase/funFolderCreate.jsp?flag=create" width="1050" height="406"/>'
            	}).show();
        	}},{xtype: 'button',text: '删除选中条目',handler: function () {
					var deleteItems = Ext.getCmp("caseCollectionGrid").getSelectionModel().getSelection();
					if(deleteItems.length == 0){
						Ext.Msg.alert("操作提示","请选择需要删除的功能点");
						return;
					}
					Ext.MessageBox.confirm('操作提示','确定删除选中的功能点?',function(optional){
						if(optional=='yes'){
							var Ids = []; //要删除的id
		                    Ext.each(deleteItems, function (item) {
		                        Ids.push(item.data.funId);
		                    })
		                    MaskLoading();
							Ext.Ajax.request({
								async:false,
								url:"<%=request.getContextPath()%>/deleteFunPoints.do?funIds="+Ids,
								success:function(response,config){
									MaskOver();
									Ext.Msg.alert('提示','删除成功');
									funFolderStore = Ext.data.StoreManager.lookup("funFolderStore");
									funFolderStore.reload();
								},
								failure:function(response,config){
									MaskOver();
									Ext.Msg.alert('操作','数据请求失败');
								}
							});
						}
					});
			}},{
                xtype: 'fileuploadfield',
                id:'fileToUpload',
                fieldLabel: '批量导入功能点',
                buttonText: '选择功能文件',
                listeners:{
                    	change:function(comp,str,eOpts){
                    		if(str.endWith('xls')||str.endWith('xlsx')){
                    			Ext.getCmp("upload").setHandler(function(){ajaxFileUpload();});
                    		}else{
                    			Ext.MessageBox.alert('提示','['+str+']文件不是合法的Excel文件');
                    			Ext.getCmp("upload").setHandler(function () {
                                	Ext.MessageBox.alert('提示','未选择上传文件文件');
                                	});
                    		}
                    	}
                    }
                }, {
                    width: 50,
                    xtype: 'button',
                    text: '导入',
                    id:'upload',
                    handler: function () {
                    	Ext.MessageBox.alert('提示','未选择上传文件文件');
                    },
                    listeners:{
                    	afterrender:function( Component, eOpts ){
                    	}
                    }
                },
                {
                    width: 100,
                    xtype: 'button',
                    text: '下载模版',
                    handler: function () {
                    	$("#exportForm")[0].submit();
                    },
                    listeners:{
                    }
                }
        ],
        listeners: {
            itemdblclick: function(grid, record, item, index, e, eOpts) {
            	funFolderAlterWin = new top.Ext.window.Window({
			 		id:'funFolderAlterWin',
				    title: '编辑功能点信息',
	                width: 1050,
				    height : 408,
	                modal: true,
	                listeners: {
	                    destroy: function (window, eOpts) {
							funFolderStore = Ext.data.StoreManager.lookup("funFolderStore");
							funFolderStore.reload();
	                    }
	                },
	                closeAction: 'destroy',
	                html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/userCase/funFolderCreate.jsp?flag=alter&funId='+record.raw.funId+'" width="1050" height="406"/>'//修改的进入方式
	            	//html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/userCase/funFolderCreate.jsp?flag=alter&funId='+record.raw.funId+'&isViewer=yes" width="1050" height="356"/>'
            	}).show();
            }
			//,itemcontextmenu: rightClickTargetFn
        },
        selModel: Ext.create("Ext.selection.CheckboxModel",{id : 'checkBoxForChoiceCount',mode:"SIMPLE"}),
        columns: [
            {xtype: 'rownumberer'}, 
         	{header: "功能点ID",width: 100,sortable: true,dataIndex: 'funId',hidden: true}, 
         	{header: "功能点名称",width: 100,sortable: true,dataIndex: 'sysName'}, 
         	{header: "功能点类型",width: 100,sortable: true,dataIndex: 'funType',renderer: function(value, cellmeta, record) {
  	        	try{
  	        		var store=Ext.data.StoreManager.lookup("funTypeStore");
 	        		store.clearFilter(true);
 	        		return store.findRecord("value",value).getData().show+"";
  	        	}catch(e){return "未指定"};
  	        }}, 
         	{header: "所属系统 ",width: 100,sortable: true,dataIndex: 'sysId',renderer: function(value, cellmeta, record) {
  	        	try{
  	        		var store=Ext.data.StoreManager.lookup("sysIdStore");
 	        		store.clearFilter(true);
 	        		return store.findRecord("value",value).getData().show+"";
  	        	}catch(e){return "未指定"};
  	        }}, 
         	{header: "所属子系统 ",width: 100,sortable: true,dataIndex: 'subSysId',renderer: function(value, cellmeta, record) {
  	        	try{
  	        		var store=Ext.data.StoreManager.lookup("subSysIdStore");
 	        		store.clearFilter(true);
 	        		return store.findRecord("value",value).getData().show+"";
  	        	}catch(e){return "未指定"};
  	        }},
         	{header: "重要级别",width: 100,sortable: true,dataIndex: 'importantClass',renderer: function(value, cellmeta, record) {
  	        	try{
  	        		var store=Ext.data.StoreManager.lookup("importantClassStore");
 	        		store.clearFilter(true);
 	        		return store.findRecord("value",value).getData().show+"";
  	        	}catch(e){return "未指定"};
  	        }}, 
         	{header: "是否性能测试",width: 100,sortable: true,dataIndex: 'isEfficiencyTest',renderer: function(value, cellmeta, record) {
  	        	try{
  	        		var store=Ext.data.StoreManager.lookup("isEfficiencyTestStore");
 	        		store.clearFilter(true);
 	        		return store.findRecord("value",value).getData().show+"";
  	        	}catch(e){return "未指定"};
  	        }},
         	{header: "性能测试类型",width: 100,sortable: true,dataIndex: 'efficiencyTestType',renderer: function(value, cellmeta, record) {
  	        	try{
  	        		var store=Ext.data.StoreManager.lookup("efficiencyTestTypeStore");
 	        		store.clearFilter(true);
 	        		return store.findRecord("value",value).getData().show+"";
  	        	}catch(e){return "无"};
  	        }},
         	{header: "维护厂商",width: 100,sortable: true,dataIndex: 'devFirm',renderer: function(value, cellmeta, record) {
  	        	try{
  	        		var store=Ext.data.StoreManager.lookup("devFirmStore");
  	        		//console.log(value);
 	        		store.clearFilter(true);
 	        		return store.findRecord("value",value).getData().show+"";
  	        	}catch(e){return "未指定"};
  	        }},
         	{header: "业务标签 ",width: 250,sortable: true,dataIndex: 'busiLabel'}, 
         	{header: "基础业务标签",width: 250,sortable: true,dataIndex: 'baseFunLabel'}, 
 			{header: "菜单路径",width: 133,sortable: true,dataIndex: 'menuPath'}, 
 			{header: "功能点描述",width: 130,sortable: true,dataIndex: 'funDesc'}, 
 			{header: "数据检查脚本",width: 150,sortable: true,dataIndex: 'dataCheckScript'}, 
 			{header: "创建时间",width: 100,sortable: true,dataIndex: 'createTime',renderer: function(value, cellmeta, record) {
  	        	return value.substring(0,10)+"";
  	        }}, 
 			{header: "更新时间",width: 100,sortable: true,dataIndex: 'updateTime',renderer: function(value, cellmeta, record) {
  	        	return value.substring(0,10)+"";
  	        }},  
 			{header: "操作人",width: 100,sortable: true,dataIndex: 'operatorName'},
 			{header: "创建人ID",width: 100,sortable: true,dataIndex: 'creatorId',hidden: true},
 			{header: "创建人",width: 100,sortable: true,dataIndex: 'creatorName'},
 			{header: "是否已被禁用",width: 100,sortable: true,dataIndex: 'isInvalid',hidden: true}
      	]
    });
});
function rightClickTargetFn(view, record, item, index, e, eOpts) {
    e.preventDefault();
    rightTargetReportMenu.showAt(e.getXY());
}
var rightTargetReportMenu = new Ext.menu.Menu({
	items: [
		{
	        id: 'editTask',
	        text: '编辑功能点信息',
	        handler: function () {
	            var models = Ext.getCmp('caseCollectionGrid').getSelectionModel().getSelection();
	            if (models.length == 0 || models.length > 1) {
	            	Ext.Msg.alert("提示","<font style='color:red'>修改时请直接右击需要修改的功能点,<br/>不要勾选前面的删除选择框后再右击!</font>");
	            	return false;
	            }
	            var funFolderAlterWin = new top.Ext.window.Window({
	                id: 'funFolderAlterWin',
	                title: '编辑功能点信息',
	                width: 1050,
				    height : 408,
	                modal: true,
	                listeners: {
	                    destroy: function (window, eOpts) {
							funFolderStore = Ext.data.StoreManager.lookup("funFolderStore");
							funFolderStore.reload();
	                    }
	                },
	                closeAction: 'destroy',
	                html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/userCase/funFolderCreate.jsp?flag=alter&funId='+models[0].data.funId+'" width="1050" height="356"/>'//修改的进入方式
	            }).show();
	        }
    	}
	]
});
</script>
</html>