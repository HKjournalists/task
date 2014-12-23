<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
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
alert(planId);
/*****右击*******/
function rightClickTargetFn(view,record,item,index,e,eOpts){   
	 	e.preventDefault();   
		rightTargetReportMenu.showAt(e.getXY());
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
				    width : 950,
				    height : 400,
				    modal : true,
				    listeners:{
						destroy:function(window,eOpts){
						var taskStore=Ext.data.StoreManager.lookup("taskStore");
							taskStore.reload();
							//var parentId = treeNode[0].raw.id; 
		                	//var node =Ext.data.StoreManager.lookup('caseTreeStore').getNodeById(parentId);   
   							//Ext.data.StoreManager.lookup('caseTreeStore').load({node:node});
						}
				    },
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/testPlan/taskList.jsp?taskId='+models[0].data.taskId+'" width="950" height="400"/>'
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
    		$.getJSON("<%=request.getContextPath()%>/delRelTaskList.do",{planId: planId,taskId :models[0].data.taskId},function(data){
           		if(data.success==true){
           			Ext.data.StoreManager.lookup('taskStore').reload();
           		}
           	});
    	// 
        }
        }]
});
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.tip.QuickTipManager.init();
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
		name:'planType',
		fieldLabel : "上线类型",
		valueField: 'value',
		displayField: 'show',
		 listeners:{
			 beforequery:function( queryEvent,eOpts ){
					queryEvent.query="onLineTypeStore";
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
	var planStatusCombox = new Ext.form.ComboBox({
		width: 250,
		store: planStatusStore,
		name:'planStatus',
		fieldLabel : "计划单状态",
		valueField: 'value',
		displayField: 'show',
		 listeners:{
			 beforequery:function( queryEvent,eOpts ){
					queryEvent.query="planStatusStore";
				 }
         }
		});
	
	var testPlanForm = Ext.widget('form',{
		id:'testPlanForm',
		width:screenWidth,
		height:250,
		tbar:[
<%if(request.getParameter("status")==null){%>
		{
		 xtype: 'button',
		  text: '保存',
		    handler:function(){
                       var form=Ext.getCmp("testPlanForm");
                       MaskLoading();
	                        form.submit({
				  			clientValidation: true,
				  			url:"<%=request.getContextPath()%>/saveTestPlanForm.do",
				  			params : { 
	                        },
				  			method:'POST', 
	                    	success:function(response,config){
                       MaskOver();
	                        	var success = config.result.success;  
	                            // 当后台数据同步成功时  
	                            if (success) {
	                            	
	                            }
	                        },
	                        failure:function(response,config){
                       MaskOver();
								Ext.Msg.alert("提示","数据修改失败!");
							}
				  		});
                }
		  },{
				 xtype: 'button',
				  text: '启动',
				    handler:function(){
		                       var form=Ext.getCmp("testPlanForm");
		                       MaskLoading();
			                        form.submit({
						  			clientValidation: true,
						  			url:"<%=request.getContextPath()%>/runTestPlanForm.do",
						  			params : { 
			                        },
						  			method:'POST', 
			                    	success:function(response,config){ 
			                    MaskOver();
			                        	var success = config.result.success;  
			                            // 当后台数据同步成功时  
			                            if (success) {
			                            	Ext.data.StoreManager.lookup("taskStore").reload();
			                            }
			                        },
			                        failure:function(response,config){
			                    MaskOver();
										Ext.Msg.alert("提示","数据修改失败!");
									}
						  		});
		                }
				  }
		<%}%>
		],
		<%if(request.getParameter("status")!=null){%>
		title:'测试计划查看',
		<%}else{%>
		title:'测试计划编辑',
		<%}%>
		layout: {
			type: 'vbox'
		},
		listeners:{
			render : function(render,eOpts){
				testPlanForm.load({
					params:{planId :planId}, 
					url:'<%=request.getContextPath()%>/getTestPlanForm.do',
					method:'POST', 
					success:function(form,action){
					 	
					}, 
					failure:function(form,action){  
						Ext.Msg.alert('提示',"失败原因是: "+action.result.errorMessage);  
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
			margins: '10 0 10 0'
		},
		

		items: [{
			xtype: 'fieldcontainer',
		    labelStyle: 'font-weight:bold;padding:0',
		    layout: 'hbox',
		    defaultType: 'textfield',
		    items: [
		   {
		  		xtype:'hidden',
				name: 'planId',
				fieldLabel: '测试计划id'
			},{
				width:250,
				name: 'planTag',
				fieldLabel: '测试计划编号',
				allowBlank: false 
			},{		
					width:250,
			        xtype: 'datefield',
			        name: 'createTime',
				fieldLabel: '测试计划创建时间'
				
			},{
					width:250,
			        xtype: 'datefield',
			        name: 'beginTime',
				fieldLabel: '测试计划开始时间'
			},{
				width:250,
		        xtype: 'datefield',
		        name: 'plCompleteTime',
			fieldLabel: '测试计划提交时间'
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
			width:250,
		        xtype: 'datefield',
		        name: 'codeCommitDate',
	    	fieldLabel : "代码截止提交日"
	    },
			bigTypeCombox,
			planStatusCombox,
			onLineTypeCombox]
},{
		xtype: 'fieldcontainer',
        labelStyle: 'font-weight:bold;padding:0',
        layout: 'hbox',
        defaultType: 'textfield',
        fieldDefaults: {
            labelAlign: 'right'
        },
		items:[
		{ 
	    	xtype:'combo',
	    	width: 250,
	        name: 'isSecurityTest',
	        fieldLabel: '是否安全测试',
	        allowBlank: false,
	        store:Ext.create('Ext.data.Store',{
				fields:['value','text'],
		        data:[
		            	{'value':0,'text':'是'},
		            	{'value':1,'text':'否'}
		            ]
				}),
	           displayField:'text',
	           valueField:'value',
	           mode:'local',
	           emptyText:'请选择'
	    },{ 
	xtype:'combo',
	width: 250,
    name: 'isCodeScan',
    fieldLabel: '是否代码扫描',
    allowBlank: false,
    store:Ext.create('Ext.data.Store',{
		fields:['value','text'],
        data:[
            	{'value':0,'text':'是'},
            	{'value':1,'text':'否'}
            ]
		}),
       displayField:'text',
       valueField:'value',
       mode:'local',
       emptyText:'请选择'
},
        { 
	xtype:'combo',
	width: 250,
    name: 'isRegressionTest',
    fieldLabel: '是否性能测试',
    allowBlank: false,
    store:Ext.create('Ext.data.Store',{
		fields:['value','text'],
        data:[
            	{'value':0,'text':'是'},
            	{'value':1,'text':'否'}
            ]
		}),
       displayField:'text',
       valueField:'value',
       mode:'local',
       emptyText:'请选择'
},{ 
	xtype:'combo',
	width: 250,
    name: 'isPerformanceTest',
    fieldLabel: '是否回归扫描',
    allowBlank: false,
    store:Ext.create('Ext.data.Store',{
		fields:['value','text'],
        data:[
            	{'value':0,'text':'是'},
            	{'value':1,'text':'否'}
            ]
		}),
       displayField:'text',
       valueField:'value',
       mode:'local',
       emptyText:'请选择'
}]
},{ 
			xtype: 'fieldcontainer',
		    labelStyle: 'font-weight:bold;padding:0',
		    layout: 'hbox',
		    defaultType: 'textfield',
		    fieldDefaults: {
            labelAlign: 'right'
        },
		    items: [{
		    	xtype:"hidden",
				name: 'versionId',
				fieldLabel: '版本id'
			},{ 
			width:250,
				name:'versionTag',
				fieldLabel: '版本编号',
				allowBlank: false 
			},,{
			  		width:250,
			        xtype: 'datefield',
			        name: 'versionCreateTime',
				fieldLabel: '版本创建时间'
			},{
			  		width:250,
			        xtype: 'datefield',
			        name: 'plOnlineTime',
				fieldLabel: '版本计划上线时间'
				
			}] 
		 },
		 { 
			xtype: 'fieldcontainer',
		    labelStyle: 'font-weight:bold;padding:0',
		    layout: 'hbox',
		    defaultType: 'textfield',
		        fieldDefaults: {
            labelAlign: 'right'
        },
		    items: [{
		      		width:250,
			        xtype: 'datefield',
			        name: 'factOnlineTime',
				fieldLabel: '版本计划实际时间'
			},{
			  	width:250,
				name: 'plWorkDay',
				fieldLabel: '版本计划容量'
			},
			{
		  		width:250,
				name: 'factWorkDay',
				fieldLabel: '版本实际容量'
			}] 
		 }]
	});
	
	
	
	var taskStore = Ext.create('Ext.data.Store',{
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
		 		{name:'importanceReq',type:'string'},
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
	
	
		var mapModel= Ext.define('mapModel',{
	    extend: 'Ext.data.Model',
	    fields: [
	        {name: 'constantId', type: 'string'},
	        {name: 'categoryName',type: 'string'},
	        {name: 'category',type: 'string'},
	        {name: 'show',type: 'string'},
	        {name: 'value',type: 'int'},
	        {name: 'other1',type: 'string'},
	        {name: 'other2',type: 'string'},
	        {name: 'memo',type: 'string'}
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
		taskStore.load({
		params: {planId: planId}
	});
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
        height:'600',
        width:screenWidth*0.99,
       	tbar:[
		  {
		 xtype: 'button',
		  text: '关联任务单',
		    handler:function(){
                  var taskGridWin = new top.Ext.window.Window({
			 		id:'taskGridWin',
				    title : '增加任务单',
				    width : 950,
				    height : 450,
				    modal : true,
				    autoScroll:true,
				    listeners:{
						destroy:function(window,eOpts){
							//taskGridWin.close();
							taskStore.reload();
							//var parentId = treeNode[0].raw.id; 
		                	//var node =Ext.data.StoreManager.lookup('caseTreeStore').getNodeById(parentId);   
   							//Ext.data.StoreManager.lookup('caseTreeStore').load({node:node});
						}
				    },
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/testPlan/taskList.jsp?planId='+planId+'" width="950" height="450"/>'
				}).show();
                }
		  }],
        height:300,
		forctFit:true,
        stripeRows:true,
        loadMask:true,
		store: taskStore,
		selType:'rowmodel',
		listeners : {
			itemcontextmenu : rightClickTargetFn
		},
		columns:[new Ext.grid.RowNumberer(),
					{header: "计划id",width:100,sortable: true,dataIndex: 'taskId',hidden:true},
					{header: "测试任务编号",width:100,sortable: true,dataIndex: 'taskId'},
					{header: "测试任务名称",width:100,sortable: true,dataIndex: 'taskName'},
					{header: "需求编号",width:100,sortable: true,dataIndex: 'reqId',hidden:true},
			
	        		{
	        	           header: '系统大类',
	        	           dataIndex: 'bigType',
	        	           width: 60,
	        	           align: 'center',
	        	        renderer: function(value,cellmeta,record) {
	        	        	
	        	        	
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
	         	        renderer: function(value,cellmeta,record) {
	         	        	
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
	         	        renderer: function(value,cellmeta,record) {
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
	         	        renderer: function(value,cellmeta,record) {
	         	        	
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
	         	        renderer: function(value,cellmeta,record) {
	         	        	
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
	          	        renderer: function(value,cellmeta,record) {
	          	          		try{
	          	        		var store=Ext.data.StoreManager.lookup("mapStore");
	        	        		store.clearFilter(true);
	        	        		  store.filter("categoryName","currentStatusStore");
	        	        		
	        	        		  return store.findRecord("value",value).getData().show+"";
	        	        			  
	        	        		  }catch(e){return "未指定"};
	          	          
	          	        }},
	         		{header: "测试任务派发人",width:100,sortable: true,dataIndex: 'distributePersion'},
	            	{header: "测试任务执行人",width:100,sortable: true,dataIndex: 'runPersion'},
	            	//，是否需求端到端测试，是否为重点需求、是否为跨周期需求、测试管理员意见；
	            	{header: "测试任务派发时间",width:100,sortable: true,dataIndex: 'distributeTime',hidden:true},
	            	{header: "测试任务计划完成时间",width:100,sortable: true,dataIndex: 'plCompleteTime',hidden:true},
	            	{header: "测试任务实际完成时间",width:100,sortable: true,dataIndex: 'factCompleteTime',hidden:true},
	        		{header: "需求重要程度",width:100,sortable: true,dataIndex: 'importanceReq'},
	        		{ header: '是否需要联调',dataIndex: 'jointTest',width: 60,align: 'center',
	          	        renderer: function(value,cellmeta,record) {
	          	        	if(value==0)return "是";
          	          		else return "否";
	          	        }},
	        		{ header: '是否跨周期需求',dataIndex: 'crossCycle',width: 60,align: 'center',
	          	        renderer: function(value,cellmeta,record) {
	          	          		if(value==0)return "是";
	          	          		else return "否";
	          	        }},
	        		{ header: '是否需要端到端测试',dataIndex: 'point2pointTest',width: 60,align: 'center',
	          	        renderer: function(value,cellmeta,record) {
	          	        	if(value==0)return "是";
          	          		else return "否";  
	          	        }},
	        		{header: "开发任务工时",width:100,sortable: true,dataIndex: 'devWorkDay'},
	        		{header: "测试任务工时",width:100,sortable: true,dataIndex: 'testWorkDay'}
	        		]
	});

	Ext.create('Ext.Panel',{
		renderTo: Ext.getBody(),
		width: screenWidth*0.99,
        cls: 'ui-formPanel',
		height: 600,
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
			items:[testPlanForm,taskGrid]
		}]
    });
});
</script>
</html>