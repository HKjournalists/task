<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>测试计划</title>
</head>
<body>
	<div id="planPanel"></div>
	<%
	String planId=request.getParameter("planId");
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
	//0 创建  1查看  2编辑
	String planFlag=request.getParameter("planFlag");
	boolean isHasPlanId=(planId!=null&&!planId.equals(""));
	%>
	<jsp:include page="/aiga/workflow/common/SelectStaff.jsp"></jsp:include>
	<!-- 不可重复引用,嵌入时注释-->
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/extJs/resources/css/ext-all.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/extJs/ext-all.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/extJs/plugin/DateTimePicker.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/extJs/plugin/DateTime.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/extJs/ext.bug.fix.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/base/jquery-1.8.0.js" ></script>
	 
</body>
<script type="text/javascript">
var extjsFolderPath='<%=request.getContextPath()%>/extJs';
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
var planId="${param.planId}";
var planFlag="${param.planFlag}";
var planTag="";
/*****右击*******/
function rightClickTargetFn(view,record,item,index,e,eOpts){   
	 	e.preventDefault();   
		rightTargetReportMenu.showAt(e.getXY());
	}
function closeWindow(windowId){
	var _taskWin=Ext.getCmp(windowId);
	_taskWin.close();
}
var rightTargetReportMenu = new Ext.menu.Menu({
    items: [
    {
    	id:'editTask',
        text: '编辑任务单',
        handler: function(){
         	var models=Ext.getCmp('taskGrid').getSelectionModel().getSelection();
        	if(models.length!=1){
        		Ext.Msg.alert("提示","选择错误!");
        	}
           var taskFormWin = new top.Ext.window.Window({
			 		id:'taskFormWin',
				    title : '编辑任务单',
				    width : 1100,
				    height : 400,
				    modal : true,
				    listeners:{
						destroy:function(window,eOpts){
						var taskStore=Ext.data.StoreManager.lookup("taskStore");
							taskStore.reload({params:{planTag: planTag,planFlag:planFlag,planId:planId}});
							//var parentId = treeNode[0].raw.id; 
		                	//var node =Ext.data.StoreManager.lookup('caseTreeStore').getNodeById(parentId);   
   							//Ext.data.StoreManager.lookup('caseTreeStore').load({node:node});
						}
				    },
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/workflow/testPlan/TaskList.jsp?flag=2&taskId='+models[0].data.taskId+'" width="1100" height="400"/>'
				}).show();
        }
        },
    	{
    	id:'delRel',
        text: '删除关联',
        handler: function(){
        	var models=Ext.getCmp('taskGrid').getSelectionModel().getSelection();
        	if(models.length!=1){
        		Ext.Msg.alert("提示","选择错误!");
        	}
    		$.getJSON("<%=request.getContextPath()%>/delRelTaskList.do",{planId: planId,taskId :models[0].data.taskId}, function(data){
           		if(data.success==true){
           			alert("error");
           			Ext.data.StoreManager.lookup('taskStore').reload({params:{planTag: planTag,planFlag:planFlag,planId:planId}});
           		}
           	});
    	// 
        }
        }]
});
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.tip.QuickTipManager.init();
	var dateFormat= Ext.Date.format(new Date, 'YmdHisu');
	planTag="TP"+dateFormat;
	var planTagTitle="参数有误";
	if("<%=planFlag%>"==0&&"<%=isHasPlanId%>"=="false")
		{planTagTitle="测试计划创建&nbsp;&nbsp;("+planTag+")";}
	if("<%=isHasPlanId%>"=="true"&&"<%=planFlag%>"==2){
		planTagTitle="创建计划编辑";
	}
	if("<%=isHasPlanId%>"=="true"&&"<%=planFlag%>"==1){
		planTagTitle="创建计划查看";
	}
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
		}
	});
	bigTypeStore.load();
	var bigTypeCombox = new Ext.form.ComboBox({
		width: 250,
		store: bigTypeStore ,
		name:"bigType",
		fieldLabel : "系统大类",
		valueField: 'value',
		displayField: 'show',
		 listeners:{
			 beforequery:function( queryEvent,eOpts ){
				//console.log(queryEvent);
				queryEvent.query="bigTypeStore";
			 }
         }
		});
	var onLineTypeStore=new Ext.data.Store({
		id: 'planTypeStore',
		fields: ['value','show'],
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getComBox.do?query=onLineTypeStore',
			reader: {
				type: 'json',
				root: 'data'
			}
		}
	});
	onLineTypeStore.load();
	var onLineTypeCombox = new Ext.form.ComboBox({
		width: 250,
		store: onLineTypeStore ,
		name:'onLineType',
		fieldLabel : "上线类型",
		valueField: 'value',
		displayField: 'show',
		 listeners:{
			 beforequery:function( queryEvent,eOpts ){
					//console.log(queryEvent);
					queryEvent.query="onLineTypeStore";
				 }
         }
		});
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
		}
	});
		workflowParamStore.load();
	var planStatusCombox = new Ext.form.ComboBox({
		width: 250,
		store: workflowParamStore,
		name:'planStatus',
		fieldLabel : "计划单状态",
		valueField: 'linkId',
		displayField: 'vmTaskName',
		 listeners:{
         }
		});

	var planPhaseCombox = new Ext.form.ComboBox({
		width: 250,
		store: workflowParamStore,
		name:'planPhase',
		fieldLabel : "计划所处阶段",
		valueField: 'phaseId',
		displayField: 'phaseName',
		 listeners:{
         }
		});
	var taskStore = Ext.create('Ext.data.Store', {
		storeId:'taskStore',
		fields:[
		        {name:'taskId',type:'string'}, 
		 		{name:'reqId',type:'string'}, 
		 		{name:'currentStatus',type:'string'}, 
		 		{name:'priority',type:'string'},
		        {name:'createTime',type:'string'}, 
		 		{name:'taskTag',type:'string'},
		 		{name:'devTag',type:'string'},
		 		{name:'reqTag',type:'string'},
		 		{name:'plCompleteTime',type:'string'},
		 		{name:'factCompleteTime',type:'string'},
		 		{name:'devWorkDay',type:'string'},
		 		{name:'testWorkDay',type:'string'},
		 		{name:'createTime',type:'string'},
		 		{name:'taskName',type:'string'},
		 		{name:'distributePersion',type:'string'},
		 		{name:'distributeTime',type:'string'},
		 		{name:'bigType',type:'string'},
		 		{name:'subType',type:'string'},    
		 		{name:'taskHour',type:'string'},
		 		{name:'performanceTest',type:'string'},
		 		{name:'crossCycle',type:'string'},
		 		{name:'devFirm',type:'string'},
		 		{name:'testFirm',type:'string'},
		 		{name:'testType',type:'string'},
		 		{name:'testPersion',type:'string'},
		 		{name:'runPersion',type:'string'},
		 		{name:'reqPersion',type:'string'},
		 		{name:'isImportanceReq',type:'string'},
		 		{name:'point2pointTest',type:'string'},
		 		{name:'testPersionOpinion',type:'string'},
		 		{name:'jointTest',type:'string'}],
	    proxy: {
	        type: 'ajax',
        	url : '<%=request.getContextPath()%>/getTestTaskList.do',
	        reader: {
	            root:"data",
				type:"json"
	        }
	    }
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
				taskStore.load({params: {planId: planId,planFlag: planFlag}});
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
	var taskGrid = Ext.create('Ext.grid.Panel',{
		id:'taskGrid',
        cls: 'ui-formPanel',
		title:'任务列表',
        margins : '0 0 0 3',
        height:180,
        width:screenWidth*0.98,
       	tbar:[
       	 <%if(planFlag!=null && planFlag.equals("0")){%>
		  {
		 xtype: 'button',
		  text: '关联任务单',
		    handler:function(){
                  var taskGridWin = new top.Ext.window.Window({
			 		id:'taskGridWin',
				    title : '任务单',
				    width : 980,
				    height : 520,
				    modal : true,
				    autoScroll:true,
				    listeners:{
						destroy:function(window,eOpts){
							taskStore.reload({params:{planTag: planTag,planFlag :planFlag,planId:planId}});
						}
				    },
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/workflow/testPlan/TaskList.jsp?flag=3&planTag='+planTag+'&planId='+planId+'" width="950" height="480"/>'
				}).show();
                }
		  },
		  {
				 xtype: 'button',
				  text: '新建任务单',
				    handler:function(){
		                  var taskGridWin = new top.Ext.window.Window({
					 		id:'taskGridWinCreate',
						    title : '新建任务单',
						    width : 1100,
						    height : 520,
						    modal : true,
						    autoScroll:true,
						    listeners:{
								destroy:function(window,eOpts){
									taskStore.reload({params:{planTag: planTag,planFlag :planFlag,planId:planId}});
								}
						    },
						    closeAction : 'destroy',
						    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/workflow/testPlan/TaskList.jsp?flag=0&planTag='+planTag+'&planId='+planId+'" width="1100" height="480"/>'
						}).show();
		                }
				  }
		  ,
		  {
				 xtype: 'button',
				  text: '导入Excel',
				    handler:function(){
		                  var taskGridWin = new top.Ext.window.Window({
					 		id:'taskGridWinExcel',
						    title : '导入任务单Excel',
						    width : 500,
						    height : 200,
						    modal : true,
						    autoScroll:true,
						    listeners:{
								destroy:function(window,eOpts){
									//planFlag=0
									taskStore.reload({params:{planTag: planTag,planFlag:planFlag,planId:planId}});
								}
						    },
						    closeAction : 'destroy',
						    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/workflow/testPlan/TaskList.jsp?flag=4&planTag='+planTag+'&planId='+planId+'" width="480" height="160"/>'
						}).show();
		                }
				  }
		  <%}%>
		  ],
		forctFit:true,
        stripeRows:true,
        loadMask:true, 
		store: taskStore,
		selType:'rowmodel',
		listeners : {
			itemdblclick:function( eventObject, htmlElement, eOpts ){
			 	var models=Ext.getCmp('taskGrid').getSelectionModel().getSelection();
	        	if(models.length!=1){
	        		Ext.Msg.alert("提示","选择错误!");
	        	}
			    var taskFormWin = new top.Ext.window.Window({
			 		id:'taskFormWinLookOver',
				    title : '查看任务单',
				    width : 1100,
				    height : 400,
				    modal : true,
				    listeners:{
						destroy:function(window,eOpts){
						var taskStore=Ext.data.StoreManager.lookup("taskStore");
							taskStore.reload({params:{planTag: planTag,planFlag:planFlag,planId:planId}});
						}
				    },
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/workflow/testPlan/TaskList.jsp?flag=1&taskId='+models[0].data.taskId+'" width="1100" height="400"/>'
				}).show();
			},
			itemcontextmenu : rightClickTargetFn
		},
		columns:[new Ext.grid.RowNumberer(),
					{header: "计划id", width:100, sortable: true, dataIndex: 'taskId',hidden:true},
					{header: "测试任务编号", width:100, sortable: true, dataIndex: 'taskTag'},
					{header: "测试任务名称", width:100, sortable: true, dataIndex: 'taskName'},
					{header: "需求编号", width:100, sortable: true, dataIndex: 'reqId',hidden:true},
			
	        		{
	        	           header: '系统大类',
	        	           dataIndex: 'bigType',
	        	           width: 60,
	        	           align: 'center',
	        	        renderer: function(value, cellmeta, record) {
	        	        	
	        	        	
	        	        	try
	        	          {
	        	        		var store=Ext.data.StoreManager.lookup("mapStore");
	        	        		store.clearFilter(true);
	        	        		
	        	        		  store.filter("categoryName","bigTypeStore");
	        	        		  return store.findRecord("value",value).getData().show+"";
	        	          }catch(e){return "未指定"};
	        	        }},
	        	        {
	         	           header: '系统子类',
	         	           dataIndex: 'subType',
	         	           width: 60,
	         	           align: 'center',
	         	        renderer: function(value, cellmeta, record) {
	         	        	
	         	        	try
	         	          {
	         	        		var store=Ext.data.StoreManager.lookup("mapStore");
	        	        		store.clearFilter(true);
	        	        		  store.filter("categoryName","subTypeStore");
	        	        		  return store.findRecord("value",value).getData().show+"";
	         	         }catch(e){return "未指定"};
	         	        }},
	        	        {
	         	           header: '测试类型',
	         	           dataIndex: 'testType',
	         	           width: 100,
	         	           align: 'center',
	         	        renderer: function(value, cellmeta, record) {
	         	        	try
	         	          {
	         	        		var store=Ext.data.StoreManager.lookup("mapStore");
	        	        		store.clearFilter(true);
	        	        		  store.filter("categoryName","testTypeStore");
	        	        		  return store.findRecord("value",value).getData().show+"";
	         	          } catch(e){return "未指定"};
	         	        }},
	         	       {
	         	           header: '测试厂商',
	         	           dataIndex: 'testFirm',
	         	           width: 60,
	         	           align: 'center',
	         	        renderer: function(value, cellmeta, record) {
	         	        	
	         	        	try
		         	          {
	         	        		var store=Ext.data.StoreManager.lookup("mapStore");
	        	        		store.clearFilter(true);
	        	        		  store.filter("categoryName","testFirmStore");
	        	        		 
	        	        		  return store.findRecord("value",value).getData().show+"";
		         	         } catch(e){return "未指定"};
	         	        }},
	         	       {
	         	           header: '开发厂商',
	         	           dataIndex: 'devFirm',
	         	           width: 60,
	         	           align: 'center',
	         	        renderer: function(value, cellmeta, record) {
	         	        	
	         	        try{
	         	        	
	         	        
	         	        		var store=Ext.data.StoreManager.lookup("mapStore");
	        	        		store.clearFilter(true);
	        	        		  store.filter("categoryName","devFirmStore");
	        	        		  return store.findRecord("value",value).getData().show+"";
	         	       }catch(e){return "未指定"};
	         	        }},
	         	       {
	          	           header: '测试任务状态',
	          	           dataIndex: 'currentStatus',
	          	           width: 60,
	          	           align: 'center',
	          	        renderer: function(value, cellmeta, record) {
	          	          		try{
	          	        		var store=Ext.data.StoreManager.lookup("mapStore");
	        	        		store.clearFilter(true);
	        	        		  store.filter("categoryName","currentStatusStore");
	        	        		
	        	        		  return store.findRecord("value",value).getData().show+"";
	        	        			  
	        	        		  }catch(e){return "未指定"};
	          	          
	          	        }},
	         		{header: "测试任务派发人", width:100, sortable: true, dataIndex: 'distributePersion'},
	            	{header: "测试任务执行人", width:100,sortable: true, dataIndex: 'runPersion'},
	            	//，是否需求端到端测试，是否为重点需求、是否为跨周期需求、测试管理员意见；
	            	{header: "测试任务派发时间", width:100, sortable: true, dataIndex: 'distributeTime',hidden:true},
	            	{header: "测试任务计划完成时间", width:100, sortable: true, dataIndex: 'plCompleteTime',hidden:true},
	            	{header: "测试任务实际完成时间", width:100, sortable: true, dataIndex: 'factCompleteTime',hidden:true},
	        		{header: "需求重要程度", width:100, sortable: true, dataIndex: 'isImportanceReq'},
	        		{ header: '是否需要联调',dataIndex: 'jointTest', width: 60,align: 'center',
	          	        renderer: function(value, cellmeta, record) {
	          	        	if(value==0)return "是";
          	          		else return "否";
	          	        }},
	        		{ header: '是否跨周期需求',dataIndex: 'crossCycle', width: 60,align: 'center',
	          	        renderer: function(value, cellmeta, record) {
	          	          		if(value==0)return "是";
	          	          		else return "否";
	          	        }},
	        		{ header: '是否需要端到端测试',dataIndex: 'point2pointTest', width: 60,align: 'center',
	          	        renderer: function(value, cellmeta, record) {
	          	        	if(value==0)return "是";
          	          		else return "否";  
	          	        }},
	        		{header: "开发任务工时", width:100, sortable: true, dataIndex: 'devWorkDay'},
	        		{header: "测试任务工时", width:100, sortable: true, dataIndex: 'testWorkDay'}
	        		]
	});

	Ext.create('Ext.Panel', {
		renderTo: Ext.get('planPanel'),
        cls: 'ui-formPanel',
		width: screenWidth*0.98,
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
			items:[taskGrid]
		}]
    });
});
</script>
</html>