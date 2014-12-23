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
	<title>功能点归属系统查询</title>
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
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;

Ext.onReady(function () {
	Ext.QuickTips.init();
    Ext.tip.QuickTipManager.init();
    
    /**
     * 重要级别下拉框
     */
	var importantClassStore = new Ext.data.Store({
        id: 'importantClassStore',
        fields: ['value', 'show'],
        proxy: {
            type: 'ajax',
            url: '<%=request.getContextPath()%>/getComBoxForSysFolder.do?query=importantClass',
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
        forceSelection:true,
        typeAhead:true,
        minChars:1,
        selectOnFocus: true,
        triggerAction: 'all',
        queryMode: 'local',
        valueField: 'value',
        displayField: 'show'
    });
    
    /**
     * 系统归属域
     */
    var sysOfDomainStore = new Ext.data.Store({
        id: 'sysOfDomainStore',
        fields: ['value', 'show'],
        proxy: {
            type: 'ajax',
            url: '<%=request.getContextPath()%>/getComBoxForSysFolder.do?query=sysOfDomain',
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
    sysOfDomainStore.load();
    var sysOfDomainCombox = Ext.create('Ext.form.field.ComboBox',{
    	id:'sysOfDomainCombox',
        store: sysOfDomainStore,
        labelAlign: 'right',
        id: "sysOfDomain",
        name: "sysOfDomain",
        width: 250,
        forceSelection:true,
        typeAhead:true,
        minChars:1,
        selectOnFocus: true,
        triggerAction: 'all',
        queryMode: 'local',
        fieldLabel: "系统归属域",
        valueField: 'value',
        displayField: 'show'
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
        width: screenWidth*0.999,
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
                    {name: 'sysName',fieldLabel: '系统名称'},
            		importantClassCombox,//重要级别
            		sysOfDomainCombox,//归属系统域
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
	        {name:'sysId',type:'string'},//系统ID
	 		{name:'sysName',type:'string'},//系统名称
	 		{name:'createTime',type:'string'},//创建时间
	 		{name:'updateTime',type:'string'},//更新时间
	 		{name:'remarks',type:'string'},//备注
	 		{name:'firm',type:'string'},//厂商
	 		{name:'importantClass',type:'string'},//重要级别
	 		{name:'sysOfDomain',type:'string'},//归属域
	 		{name:'isInvalid',type:'string'}//是否已经删除
 		],
	    proxy: {
	        type: 'ajax',
        	url : '<%=request.getContextPath()%>/getSysFolderList.do',
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
					importantClass:Ext.getCmp('qryForm').getForm().findField('importantClass').getValue(),
					sysOfDomain:Ext.getCmp('qryForm').getForm().findField('sysOfDomain').getValue()
				}      
			);      
	});
	funFolderStore.load();
	var caseCollectionGrid = new Ext.grid.Panel({
        id: 'caseCollectionGrid',
        cls: 'ui-formPanel',
        width: screenWidth*0.999,
        height: screenHeight * 0.85,
        renderTo: Ext.getBody(),
        title: '系统详细信息列表',
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
				    title : '新增(功能点)归属系统',
				    width : 600,
				    height : 308,
				    modal : true,
				    autoScroll:true,
				    listeners:{
						destroy:function(window,eOpts){
							funFolderStore = Ext.data.StoreManager.lookup("funFolderStore");
							funFolderStore.reload();
						}
				    },
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/userCase/sysFolderCreate.jsp?flag=create" width="588" height="273"/>'
            	}).show();
        	}},{xtype: 'button',text: '删除选中条目',handler: function () {
					var deleteItems = Ext.getCmp("caseCollectionGrid").getSelectionModel().getSelection();
					if(deleteItems.length == 0){
						Ext.Msg.alert("操作提示","请选择需要删除的系统");
						return;
					}
					Ext.MessageBox.confirm('操作提示','确定删除选中的系统?',function(optional){
						if(optional=='yes'){
							var Ids = []; //要删除的id
		                    Ext.each(deleteItems, function (item) {
		                        Ids.push(item.data.sysId);
		                    })
		                    MaskLoading();
							Ext.Ajax.request({
								async:false,
								url:'<%=request.getContextPath()%>/deleteSystemFolders.do?sysIds='+Ids,
								success:function(response,config){
									MaskOver();
									var caseIdJson = Ext.JSON.decode(response.responseText);
									var success = caseIdJson.success;
									if (success) {
										Ext.Msg.alert('提示','删除成功');
										funFolderStore = Ext.data.StoreManager.lookup('funFolderStore');
										funFolderStore.reload();
									}else{
										Ext.Msg.alert('提示',caseIdJson.message);
										funFolderStore = Ext.data.StoreManager.lookup('funFolderStore');
										funFolderStore.reload();
									}
								},
								failure:function(response,config){
									MaskOver();
									Ext.Msg.alert('操作','数据请求失败');
								}
							});
						}
					});
			}}
        ],
        listeners: {
            itemdblclick: function(grid, record, item, index, e, eOpts) {
            	funFolderAlterWin = new top.Ext.window.Window({
			 		id:'funFolderAlterWin',
				    title: '编辑系统信息',
	                width: 600,
				    height : 308,
	                modal: true,
	                listeners: {
	                    destroy: function (window, eOpts) {
							funFolderStore = Ext.data.StoreManager.lookup("funFolderStore");
							funFolderStore.reload();
	                    }
	                },
	                closeAction: 'destroy',
	                html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/userCase/sysFolderCreate.jsp?flag=alter&sysId='+record.raw.sysId+'" width="588" height="273"/>'//修改的进入方式
	            }).show();
            }
        },
        selModel: Ext.create("Ext.selection.CheckboxModel",{id : 'checkBoxForChoiceCount',mode:"SIMPLE"}),
        columns: [
            {xtype: 'rownumberer'}, 
         	{header: "系统ID",width: 100,sortable: true,dataIndex: 'sysId',hidden: true}, 
         	{header: "系统名称",width: 300,sortable: true,dataIndex: 'sysName'}, 
         	{header: "创建时间",width: 100,sortable: true,dataIndex: 'createTime',renderer: function(value, cellmeta, record) {
	 	    	return value.substring(0,10)+"";
		    }}, 
         	{header: "更新时间",width: 100,sortable: true,dataIndex: 'updateTime',renderer: function(value, cellmeta, record) {
	 	    	return value.substring(0,10)+"";
		    }},
         	{header: "重要级别",width: 100,sortable: true,dataIndex: 'importantClass',renderer: function(value, cellmeta, record) {
	 	    	try{
		        	var store=Ext.data.StoreManager.lookup("importantClassStore");
	        		store.clearFilter(true);
	        		return store.findRecord("value", value).getData().show + "";
	   	    	} catch(e){return ""};
		    }},
         	{header: "归属域",width: 100,sortable: true,dataIndex: 'sysOfDomain',renderer: function(value, cellmeta, record) {
	 	    	try{
		        	var store=Ext.data.StoreManager.lookup("sysOfDomainStore");
	        		store.clearFilter(true);
	        		return store.findRecord("value", value).getData().show + "";
	   	    	} catch(e){return ""};
		    }},
         	{header: "备注 ",width: 579,sortable: true,dataIndex: 'remarks'}
      	]
    });
});
</script>
</html>