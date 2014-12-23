<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<%
	String planFlag = request.getParameter("planFlag");
%>
<html>
<head>
	<title>测试计划</title>
</head>
<body>
</body>
<script type="text/javascript">
var extjsFolderPath='<%=request.getContextPath()%>/extJs';
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
var planId="${param.planId}";
/*****右击*******/
function rightClickTargetFn(view,record,item,index,e,eOpts){   
	 	e.preventDefault();   
		rightTargetReportMenu.showAt(e.getXY());
	}
var rightTargetReportMenu = new Ext.menu.Menu({
    items: [
    {
    	id:'editTask',
        text: '编辑计划单',
        handler: function(){
         	var models=Ext.getCmp('planGrid').getSelectionModel().getSelection();
        	if(models.length!=1){
        		Ext.Msg.alert("提示","选择错误!");
        	}
           var taskFormWin = new top.Ext.window.Window({
			 		id:'taskFormWin',
				    title : '编辑计划单',
				    width : screenWidth*0.8,
				    height : screenHeight*0.8,
				    modal : true,
				    autoScroll:true,
				    listeners:{
						destroy:function(window,eOpts){
						var planStore=Ext.data.StoreManager.lookup("planStore");
							planStore.reload();
						}
				    },
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" scrolling="yes" src="<%=request.getContextPath()%>/aiga/workflow/testPlan/TestPlanChange.jsp?objId='+models[0].data.planId+'&planFlag=2&includeHead=false" width="100%" height="100%"/>'
				}).show();
        }
        }
    /**,
    	{
    	id:'delRel',
        text: '删除计划单',
        handler: function(){
        	var models=Ext.getCmp('planGrid').getSelectionModel().getSelection();
        	var planId=models[0].data.planId;
        	if(models.length!=1){
        		Ext.Msg.alert("提示","选择错误!");
        	}
    		$.getJSON("<%=request.getContextPath()%>/delTestPlan.do",{planId: planId}, function(data){
           		if(data.success==true){
           			Ext.data.StoreManager.lookup('planStore').reload();
           		}
           	});
    	// 
        }
        }
    **/
        ]
});
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.tip.QuickTipManager.init();
	Ext.define('EmptyVal', {
		extend: 'Ext.data.Model',
		fields:[
			{name:'value', type:'int', convert: null,defaultValue:''},
			{name:'show', type:'string', defaultValue: '-未选择-'}
		]
	});
	Ext.define('EmptyWorkflowParam', {
		extend: 'Ext.data.Model',
		fields:[
			{name:'linkId', type:'int', convert: null, defaultValue:''},
			{name:'phaseId', type:'int', convert: null, defaultValue:''},
			{name:'phaseName', type:'string', defaultValue: '-未选择-'},
			{name:'vmTaskName', type:'string', defaultValue: '-未选择-'}
		]
	});
	var bigTypeStore=new Ext.data.Store({
		autoLoad: true,
		id: 'bigTypeStore',
		fields: ['value','show'],
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getComBox.do?query=bigTypeStore',
			reader: {
				type: 'json',
				root: 'data'
			}
		},
		listeners:{
            load : function(store, records, options ){
            	var rs = Ext.create("EmptyVal");
                store.insert(0,rs);  
            }
        }  
	});
	bigTypeStore.load();
	var bigTypeCombox = new Ext.form.ComboBox({
		width:160,
		labelWidth:60,
		store: bigTypeStore ,
		id:"searchBigType",
		fieldLabel : "系统大类",
		valueField: 'value',
		displayField: 'show',
		listeners:{
			 beforequery:function( queryEvent,eOpts ){
				queryEvent.query="bigTypeStore";
			 }
         }
		});
	var planTypeStore=new Ext.data.Store({
		id: 'planTypeStore',
		fields: ['value','show'],
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getComBox.do?query=onLineTypeStore',
			reader: {
				type: 'json',
				root: 'data'
			}
		},
		listeners:{
            load : function(store, records, options ){
            	var rs = Ext.create("EmptyVal");
                store.insert(0,rs);  
                return true;
            }
        }
	});
	planTypeStore.load();
	var planTypeCombox = new Ext.form.ComboBox({
		width:160,
		labelWidth:60,
		store: planTypeStore ,
		id:'searchPlanType',
		fieldLabel : "上线类型",
		valueField: 'value',
		displayField: 'show',
		 listeners:{
			 beforequery:function( queryEvent,eOpts ){
					queryEvent.query="planTypeStore";
				 }
         }
		});
	var planStatusStore=new  Ext.data.Store({
		id: 'planStatusStore',
		fields: ['value','show'],
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getComBox.do?query=planStatusStore',
			reader: {
				type: 'json',
				root: 'data'
			}
		}
	});
	planStatusStore.load();
	
	var workflowParamStore=new  Ext.data.Store({
		id: 'workflowParamStore',
		fields: ['linkId','phaseId','phaseName','vmTaskName'],
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getWorkflowParam.do?query=10000',
			reader: {
				type: 'json',
				root: 'data'
			}
		},
		listeners:{
            load : function(store, records, options ){
            	var rs = Ext.create("EmptyWorkflowParam");
                store.insert(0,rs);  
                return true;
            }  
        }
	});
				workflowParamStore.load();
	var planStatusCombox = new Ext.form.ComboBox({
		width:180,
		labelWidth:70,
		store: workflowParamStore,
		id:'searchPlanStatus',
		fieldLabel : "计划单状态",
		valueField: 'phaseId',
		displayField: 'vmTaskName',
		 listeners:{
			 beforequery:function( queryEvent,eOpts ){
					queryEvent.query="workflowParamStore";
			}
         }
	});
	var planStore = Ext.create('Ext.data.Store', {
		storeId:'planStore',
		pageSize:20, //每页显示条数
		fields:[
		        {name:'planId',type:'string'}, 
		 		{name:'planTag',type:'string'}, 
		 		{name:'planName',type:'string'},
		 		{name:'planStatus',type:'string'},
		 		{name:'planPhase',type:'string'},
		 		{name:'submitStaffName',type:'string'}, 
		 		{name:'submitStaffId',type:'string'}, 
		 		{name:'createTime',type:'string'},
		 		{name:'plCompleteTime',type:'string'}, 
		 		{name:'beginTime',type:'string'},
		 		{name:'codeCommitDate',type:'string'},
		 		{name:'factCompleteTime',type:'string'},
		 		{name:'reqTime',type:'string'},
		 		{name:'bigType',type:'string'},
		 		{name:'onLineType',type:'string'},
		 		{name:'versionContent',type:'string'},
		 		{name:'isSecurityTest',type:'string'},
		 		{name:'isCodeScan',type:'string'},
		 		{name:'isPerformanceTest',type:'string'},
		 		{name:'isRegressionTest',type:'string'},
		 		{name:'planDscr',type:'string'},
		 		{name:'changeReason',type:'string'},
		 		{name:'isHwergressionTest',type:'string'}
		 		],
	    proxy: {
	        type: 'ajax',
        	url : '<%=request.getContextPath()%>/getTestPlanList.do?planFlag=<%=planFlag%>',
	        reader: {
	            root:"data",
				type:"json",
            	totalProperty:'total'
	        }
	    }
	});
	Ext.StoreMgr.get('planStore').on('beforeload',function(){        // =======翻页时 查询条件   
		var dateTime=Ext.getCmp("searchTime");//上线时间
		var planTagSearch=Ext.getCmp("searchPlanTag");//计划编号
		var bigTypeSearch=Ext.getCmp("searchBigType");//系统大类
		var planTypeSearch=Ext.getCmp("searchPlanType");//上线类型
		var planNameSearch=Ext.getCmp("searchPlanName");//计划名称
		var planStatusSearch=Ext.getCmp("searchPlanStatus");//计划状态
		Ext.apply(       
			Ext.StoreMgr.get('planStore').proxy.extraParams, {onLineTime :dateTime.rawValue, planTag :　encodeURI(encodeURI(planTagSearch.rawValue)), bigType:encodeURI(encodeURI(bigTypeSearch.getValue())),planType:encodeURI(encodeURI(planTypeSearch.getValue())),planName:encodeURI(encodeURI(planNameSearch.rawValue)),planStatus:encodeURI(encodeURI(planStatusSearch.getValue()))}      
		);      
	});
	
		var mapModel= Ext.define('mapModel', {
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
	var mapStore=new  Ext.data.Store({
		autoLoad: true,
		id: 'mapStore',
		model:mapModel,
		groupField: 'categoryName',
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getComBoxMap.do',
			reader: {
				type: 'json',
				root: 'data'
			}
		},
		listeners:{
		load:function(){
		planStore.load();
		}
		}
	});
	mapStore.load();
		var bigTypeStore=new  Ext.data.Store({
			autoLoad: true,
			id: 'bigTypeStore',
			fields: ['value','show'],
			proxy: {
				type: 'ajax',
				url: '<%=request.getContextPath()%>/getComBox.do?query=bigTypeStore',
				reader: {
					type: 'json',
					root: 'data'
				}
			}
		});
		bigTypeStore.load();
	var planGrid = Ext.create('Ext.grid.Panel',{
		id:'planGrid',
        cls: 'ui-formPanel',
		title:'计划列表',
        margins : '0 0 0 3',
        height:screenHeight*0.985,
        width:screenWidth*0.998,
        bbar: Ext.create('Ext.PagingToolbar', { 
			store: planStore, 
			displayInfo: true, 
			displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
			emptyMsg: "没有数据"
		}),
       	tbar:[{
			width:160,
			labelWidth:60,
	        xtype: 'monthfield', 
	        labelAlign: 'right',
	        name: 'searchTime',
	        id: 'searchTime',
	        format: 'Y-m',
		fieldLabel: '上线月份'
		},{
			width:160,
			labelWidth:60,
	        xtype: 'textfield', 
	        labelAlign: 'right',
	        name: 'searchPlanName',
	        id: 'searchPlanName',
		fieldLabel: '计划名称'
		},{
			width:160,
			labelWidth:60,
	        xtype: 'textfield', 
	        labelAlign: 'right',
	        id: 'searchPlanTag',
		fieldLabel: '计划编号'
			 //计划编号：   系统大类： 上线时间： 上线类型： 计划名称:
		},
		bigTypeCombox,
		planTypeCombox,
		<%if(planFlag!=null&&!planFlag.equals("3")){
			%>
			planStatusCombox,
			<%
		}%>
		{
			xtype:'button',
			text: '搜索',
			handler: function() {
				planStore.loadPage(1);
			}}
		],
		forctFit:true,
        stripeRows:true,
        loadMask:true, 
		store: planStore,
		selType:'rowmodel',
		listeners : {
			//itemcontextmenu : rightClickTargetFn,
			itemdblclick:function(){
         	var models=Ext.getCmp('planGrid').getSelectionModel().getSelection();
        	if(models.length!=1){
        		Ext.Msg.alert("提示","选择错误!");
        	}
           var taskFormWin = new top.Ext.window.Window({
			 		id:'taskFormWin',
				    title : '计划单',
				    width : screenWidth * 0.9,
				    height : screenHeight * 0.9,
				    modal : true,
				    autoScroll:false,
				    listeners:{
						destroy:function(window,eOpts){
						var planStore=Ext.data.StoreManager.lookup("planStore");
							planStore.loadPage(1);
						},
						close:function(p,o){
							if(p.title=='测试计划执行'){
								planStore.loadPage(1);
								//top.$("#one1").trigger("click");
								//window.location.href = '<%=request.getContextPath()%>/aiga/workflow/common/WorkorderList.jsp';
								
							}
						}
				    },
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/workflow/testPlan/TestPlanChange.jsp?objType=1&objId='+models[0].data.planId+'&planFlag=${param.planFlag}&includeHead=false" scrolling="yes"   width="100%" height="100%"/>'
				}).show();
        	}
			
		},
				/*
				function(grid,record,item,index,e,eOpts){
				var models=Ext.getCmp('planGrid').getSelectionModel().getSelection();
	        	if(models.length!=1){
	        		Ext.MessageBox.show({  
	                	title : "提示",  
	                	msg : "选择错误!"  
	                });
	        	}
				   var taskFormWin = new Ext.window.Window({
				 		id:'taskFormWinShow',
					    title : '查看计划单',
					    width : 1050,
					    height : 500,
					    modal : true,
					    autoScroll:true,
					    listeners:{
							destroy:function(window,eOpts){
							var planStore=Ext.data.StoreManager.lookup("planStore");
								planStore.reload();
							}
					    },
					    closeAction : 'destroy',
					    html:'<iframe id="frame" name="frame" src="TestPlanForm.jsp?planFlag=1&includeHead=true&objId='+models[0].data.planId+'" width="1040" height="495"/>'
					}).show();
			}
		}*/
		columns:[new Ext.grid.RowNumberer(),
					{header: "计划id", width:100, sortable: true, dataIndex: 'planId',hidden:true},
					{header: "计划编号", width:100, sortable: true, dataIndex: 'planTag'},
					{header: "测试计划名称", width:100, sortable: true, dataIndex: 'planName'},
					{header: "计划单状态", width:100,sortable: true, dataIndex: 'planStatus',renderer: function(value, cellmeta, record) {
         	        	try
	         	          {
       	        		var store=Ext.data.StoreManager.lookup("workflowParamStore");
      	        		  return store.findRecord("phaseId",value).getData().vmTaskName+"";//原来为.phaseName现根据需求改为.vmTaskName
	         	         } catch(e){return "未指定"};
       	        }},
       	 	{header: "计划阶段", width:100,sortable: true, dataIndex: 'planPhase',renderer: function(value, cellmeta, record) {
 	        	try
     	          {
	        		var store=Ext.data.StoreManager.lookup("workflowParamStore");
	        		 return store.findRecord("linkId",value).getData().vmTaskName+"";
     	         } catch(e){return "未指定"};
	        },hidden:true},
					{header: "计划提交人", width:100, sortable: true, dataIndex: 'submitStaffName'},
	         		{header: "创建时间", width:100, sortable: true, dataIndex: 'createTime'},
					{header: "实际提交时间", width:100, sortable: true, dataIndex: 'plCompleteTime',hidden:true},
	            	{header: "开始时间", width:100,sortable: true, dataIndex: 'beginTime',hidden:true},
					{header: "计划上线时间", width:100, sortable: true, dataIndex: 'factCompleteTime'},
					{header: "代码提交截止时间", width:100, sortable: true, dataIndex: 'codeCommitDate'},
	        		{header: "需求定稿时间", width:100, sortable: true, dataIndex: 'reqTime'},
	        		{header: "系统大类", width:100, sortable: true, dataIndex: 'bigType',renderer: function(value, cellmeta, record) {
         	        	try
	         	          {
       	        		var store=Ext.data.StoreManager.lookup("mapStore");
      	        		store.clearFilter(true);
      	        		  store.filter("categoryName","bigTypeStore");
      	        		  return store.findRecord("value",value).getData().show+"";
	         	         } catch(e){return "未指定"};
       	        }},
       	     {header: "上线类型", width:100, sortable: true, dataIndex: 'onLineType',renderer: function(value, cellmeta, record) {
  	        	try
      	          {
  	        		var store=Ext.data.StoreManager.lookup("mapStore");
 	        		store.clearFilter(true);
 	        		  store.filter("categoryName","onLineTypeStore");
 	        		  return store.findRecord("value",value).getData().show+"";
      	         } catch(e){return "未指定"};
  	        }},
	            	{header: "测试可用工时", width:100,sortable: true, dataIndex: 'versionContent',hidden:true},
	        		{ header: '是否安全测试',dataIndex: 'isSecurityTest', width: 60,align: 'center',renderer: function(value, cellmeta, record) {if(value==1||value=='on')return "是";else return "否"; }},
	        		{ header: '是否代码扫描',dataIndex: 'isCodeScan', width: 60,align: 'center',renderer: function(value, cellmeta, record) {if(value==1||value=='on')return "是";else return "否"; }},
	        		{ header: '是否性能测试',dataIndex: 'isPerformanceTest', width: 60,align: 'center',renderer: function(value, cellmeta, record) {if(value==1||value=='on')return "是";else return "否"; }},
	        		{ header: '是否回归测试',dataIndex: 'isRegressionTest', width: 60,align: 'center',renderer: function(value, cellmeta, record) {if(value==1||value=='on')return "是";else return "否"; }},
	        		{ header: '是否手工回归测试',dataIndex: 'isHwergressionTest', width: 60,align: 'center',renderer: function(value, cellmeta, record) {if(value==1||value=='on')return "是";else return "否"; }},
	        		{header: "计划描述", width:100, sortable: true, dataIndex: 'planDscr',hidden:true},
	        		{header: "变更原因", width:100, sortable: true, dataIndex: 'changeReason',hidden:true}
	        		]
	});
	Ext.create('Ext.Panel', {
		renderTo: Ext.getBody(),
		width: screenWidth*0.998,
		height: screenHeight*0.99,
        cls: 'ui-formPanel',
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
			items:[planGrid]
		}]
    });
});
</script>
</html>