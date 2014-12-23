<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<html>
  <head>
	<title>关联子任务</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ie-tab.css"> 
	<body id="caseBody">
	</body>
	<script type="text/javascript">
	var screenWidth = document.documentElement.clientWidth - 20;
	var screenHeight = document.documentElement.clientHeight - 10;
	
	Ext.onReady(function(){
        Ext.QuickTips.init();
        Ext.tip.QuickTipManager.init();
        
        var mapModel = Ext.define('mapModel', {
                extend: 'Ext.data.Model',
                fields: [
                	{name: 'constantId',type: 'string'}, 
                    {name: 'categoryName',type: 'string'}, 
                    {name: 'category',type: 'string'}, 
                    {name: 'show',type: 'string'}, 
                    {name: 'value', type: 'String'}, 
                    {name: 'other1',type: 'string'}, 
                    {name: 'other2',type: 'string'}, 
                    {name: 'memo',type: 'string'}
                ]
            });
        var operatorType = new Ext.data.Store({
			autoLoad: true,
			id: 'operatorType',
			fields: ['other1','show'],
			proxy: {
		    	type: 'ajax',
		        url: '<%=request.getContextPath()%>/getSysParam.do?category=operatorType'+'&_='+(new Date()).getTime(),
		        reader: {
		        	type: 'json',
		        	root: 'data'
		        }
		   }
		});
        operatorType.load();
        
		var testCaseModel = Ext.define("testCaseModel",{
			extend: 'Ext.data.Model',
			fields:[
				{name:'hisCaseId',type:'int'},
				{name:'operatorName',type:'string'},
				{name:'operateTime',type:'string'},
				{name:'operatorType',type:'string'},
				{name:'caseId',type:'string'},
				{name:'caseName',type:'string'},
				{name:'temporaryTag',type:'string'}
			]
		});
		
		var testCaseProxy = new Ext.data.proxy.Ajax({
			type:"ajax",
			url:'<%=request.getContextPath()%>/getHisCaseByCon.do',
			reader:{
				root:"data",
				type:"json",
				totalProperty:'total'
			}
		});
		var testCaseStore = Ext.create('Ext.data.Store',{
			storeId:'testCaseStore',
			pageSize:9,
			model : testCaseModel,
			proxy : testCaseProxy,
			listeners:{}
		});
		testCaseStore.loadPage(1);
		
        var btn = new Ext.Button({
   			id: 'qryBtn',
   			text: '查询',
   			width: 60,
   			margin: '0 0 0 50px',
   			handler: function(){
   				queryCase();
   			}
   		});
   		
   		var btn1 = new Ext.Button({
   			id: 'changeBtn',
   			text: '关联子任务',
   			width: 80,
   			margin: '0 0 0 50px',
   			handler: function(){
   				changeCase();
   			}
   		});
		var qryForm = new Ext.form.FormPanel({
			id:'qryForm',
			title:'查询区域',
			cls:'ui-formPanel',
			defaults: {margins: '5 0 5 0',},
			renderTo: Ext.getBody(),
			width: screenWidth*0.98,
			minWidth: 1200,
			height: 80,
			layout: 'vbox',
			bodyBorder: 0, 
			items: [
				{
					xtype: 'fieldcontainer', 
					labelStyle: 'font-weight:bold;padding:0', 
					fieldDefaults: { 
						labelAlign: 'right', 
						labelWidth: 120,
						width: 250
					},
				    layout: 'hbox', 
				    defaultType: 'textfield',
				    items: [
						{name:'caseName',fieldLabel:'用例名称'},
						{name:'operatorName',fieldLabel:'最后操作人'},
						btn,btn1
				    ]
				}
			]
		});
			
			
			
		var hisCaseGrid = Ext.create('Ext.grid.Panel',{
			id:'hisCaseGrid',
	        cls: 'ui-formPanel',
	        renderTo: Ext.get("caseBody"),
	        margins : '0 0 0 3',
			store: testCaseStore,
			height: screenHeight*0.87*0.99,
			width: screenWidth*0.98,
	        title: '手工用例单',
	        bbar: Ext.create('Ext.PagingToolbar', { 
				store: testCaseStore, 
				displayInfo: true, 
				displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
				emptyMsg: "没有数据"
			}),
			selModel:Ext.create("Ext.selection.CheckboxModel",{mode:"SIMPLE"}),
			listeners:{
				itemdblclick:function(grid,record,item,index,e,eOpts){
					getEditForm(record.data.hisCaseId);
				}
			},
			columns:[
				{xtype:'rownumberer', width: 30},
				{header: "用例名称", width:300, sortable: false, dataIndex: 'caseName'},
				{header: "最后操作人", width:80, sortable: false, dataIndex: 'operatorName'},
				{header: "操作类型", width:80, sortable: false, dataIndex: 'operatorType',
					editor:{xtype:'combo',displayField:'show', valueField:'other1', store:'operatorType'},
		    		renderer:function(value){
		    			var rec = Ext.StoreMgr.get('operatorType').find('other1',value);
		    			if(rec == -1) {
		    				return '';
		    			}
		    			return Ext.StoreMgr.get('operatorType').getAt(rec).raw.show;
		    		}
				},
				{header: "操作时间", width:140, sortable: false, dataIndex: 'operateTime'},
				{header: "临时任务编号", width:200, sortable: false, dataIndex: 'temporaryTag'}
			]
		});
	});
	
	function getEditForm(caseIds){
		var caseEditForm = Ext.create('Ext.form.Panel',{
			id: 'caseEditForm',
			cls: 'ui-formPanel',
			width: 287,
			height:167,
			renderTo: Ext.getBody(),
			layout: 'vbox',
			border:0,
			listeners:{},
			fieldDefaults: {
			    labelAlign: 'right', 
			    labelWidth: 100, 
			    labelStyle: 'font-weight:bold' 
			},
			defaults: {margins: '15 0 0 0'}, 
			items:[
	        	{
					xtype: 'fieldcontainer', 
					labelStyle: 'font-weight:bold;padding:0', 
					fieldDefaults: {
						labelAlign: 'left', 
						labelWidth: 120,
						width: 280
					},
				    layout: 'hbox', 
				    defaultType: 'textfield',
				    items: [
						{name:'subTaskTag',fieldLabel:'请输入子任务编号'}
				    ]
				}
			],
			dockedItems:[
				{
					xtype: 'toolbar',
					dock: 'bottom',
					items:[
						{xtype : "tbfill"},
						{
							xtype: 'button',
							text : '确定',
							style: {marginRight: '10px'},
							handler:function(){
								var subTaskTag=Ext.getCmp("caseEditForm").getForm().findField('subTaskTag').getValue();
								if(subTaskTag.length==0){
									top.Ext.Msg.alert("提示","未输入子任务编号！");
								}else{
									Ext.Ajax.request({ 
										async:false,
										method:'POST',
										url:"<%=request.getContextPath()%>/changeTag.do?subTasktag="+subTaskTag+"&caseIds="+caseIds,
										success:function(response,config){
											var json=Ext.decode(response.responseText);
											if(json.success){
												if(json.isQuote){
													top.Ext.Msg.alert('提示',"子任务关联成功");
													caseFormWindow.close();
													queryCase();
												}else{
													top.Ext.Msg.alert('提示',"未查询到要关联的子任务！");
												}
											}else{
												top.Ext.Msg.alert("错误提示",'子任务关联失败！');
											}
										},
										failure:function(response,config){
											top.Ext.Msg.alert('错误提示','子任务关联失败！');
										}
									});
								}
							}
						}
					]
				}
			]
		});
		var caseFormWindow = new top.Ext.window.Window({
			id:'caseFormWindow',
			title:'关联子任务',
		    width : 300,
		    height : 200,
		    modal : true,
		    resizable:false,
		    closeAction : 'destroy',
		    autoScroll : true,
		    items:[caseEditForm]
		});
		caseFormWindow.show();
	}
	function queryCase() {
   		var hisCaseName = Ext.getCmp('qryForm').getForm().findField('caseName').getValue();
   		var operName = Ext.getCmp('qryForm').getForm().findField('operatorName').getValue();
		Ext.StoreMgr.get('testCaseStore').on('beforeload',function(){        // =======翻页时 查询条件     
			Ext.apply(       
				Ext.StoreMgr.get('testCaseStore').proxy.extraParams, {
					caseName:encodeURI(encodeURI(hisCaseName)),operatorName:encodeURI(encodeURI(operName))
				}      
			);      
		});
		Ext.StoreMgr.get('testCaseStore').loadPage(1);
   	}
   	
   	function changeCase(){
   		var hisCaseGrid=Ext.getCmp('hisCaseGrid');
   		var hisCaseStore=hisCaseGrid.getSelectionModel().getSelection();
   		if(hisCaseStore.length==0){
   			Ext.Msg.alert("提示","未选择任何用例");
   		}else{
		    var caseIds = new Array(); 
		    Ext.Array.each(hisCaseStore, function(record) {caseIds.push(record.data.hisCaseId);});
		    getEditForm(caseIds.join(","));
		    
   		}
   	}
   	
   	function quoteSubTask(caseIds){
   		//var editForm = getEditForm(caseIds);
   	}
	</script>
</html>
