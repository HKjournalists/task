<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>版本测试任务单列表</title>
	<%
		String flag = request.getParameter("flag");
		boolean isSearch = (flag!=null&&flag.equals("search"))?true:false;
		boolean isClose= (flag!=null&&flag.equals("close"))?true:false;
	%>
</head>
<body>
<div id="solidPannel"></div>
</body>
<script type="text/javascript">
var planId="${param.planId}";
var parentForm="${param.parentForm}";

var extjsFolderPath='<%=request.getContextPath()%>/extJs';
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
testSolidTaskList=screenHeight;
if(parentForm!=null&&parentForm=='TestPlanForm'){
	testSolidTaskList=200;
}
Ext.onReady(function(){
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
					    width : 1050,
					    height : 600,
					    modal : true,
					    autoScroll:true,
					    listeners:{
							destroy:function(window,eOpts){
							var planStore=Ext.data.StoreManager.lookup("planStore");
								planStore.reload();
							}
					    },
					    closeAction : 'destroy',
					    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/workflow/testPlan/TestPlanForm.jsp?planId='+models[0].data.planId+'&planFlag=1" width="1050" height="600"/>'
					}).show();
	        }
	        },
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
	        }]
	});
	Ext.QuickTips.init();
	Ext.tip.QuickTipManager.init();
	var solidTaskStore = Ext.create('Ext.data.Store', {
		storeId:'solidTaskStore',
		pageSize:20, //每页显示条数
		fields:[
		        {name:'taskId',type:'string'}, 
		        {name:'taskType',type:'string'}, 
		 		{name:'planTag',type:'string'}, 
		 		{name:'plCompleteTime',type:'string'}, 
		 		{name:'factCompleteTime',type:'string'},
		 		{name:'createTime',type:'string'},
		 		{name:'beginTime',type:'string'},
		 		{name:'isSecurityTest',type:'string'},
		 		{name:'isCodeScan',type:'string'},
		 		{name:'isPerformanceTest',type:'string'},
		 		{name:'isRegressionTest',type:'string'},
		 		{name:'versionContent',type:'string'},
		 		{name:'taskStatus',type:'string'},
		 		{name:'reqTime',type:'string'},
		 		{name:'codeCommitDate',type:'string'},
		 		{name:'onLineType',type:'string'},
		 		{name:'bigType',type:'string'},
		 		{name:'changeReason',type:'string'},
		        {name:'planId',type:'string'}, 
		        {name:'planName',type:'string'}, 
		 		{name:'submitStaffId',type:'string'}, 
		 		{name:'submitStaffName',type:'string'}, 
		 		{name:'planDscr',type:'string'},
		 		{name:'taskPhase',type:'string'}
		 		],
	    proxy: {
	        type: 'ajax',
	        <% 
	        	if(isSearch||isClose){
	        		%>
	       url : '<%=request.getContextPath()%>/getTestSolidList.do', 		
	        		<%
	        	}else{
	        		%>
	       url : '<%=request.getContextPath()%>/getTestSolidListByPlanId.do', 		
	        		<%
	        	}
	        %>
        	
	        reader: {
	            root:"data",
				type:"json",
            	totalProperty:'total'
	        }
	    }
	    <%
			if(isSearch||isClose){
			%>
				,remoteSort: true
			<%
			}
		%>
	});
	
	<% 
       	if(isSearch||isClose){
       		%>
	Ext.StoreMgr.get('solidTaskStore').on('beforeload',function(){        // =======翻页时 查询条件     
      	var planName = Ext.getCmp('qryForm').getForm().findField('planName').getValue();
		var planTag = Ext.getCmp('qryForm').getForm().findField('planTag').getValue();
		var taskType = Ext.getCmp('qryForm').getForm().findField('taskType').getValue();
		var submitStaffId = Ext.getCmp('qryForm').getForm().findField('submitStaffId').getValue();
		//var codeCommitDate = Ext.getCmp('qryForm').getForm().findField('codeCommitDate').getValue();
		var factCompleteTime = Ext.getCmp('qryForm').getForm().findField('factCompleteTime').getValue();
		/* var reqTime = Ext.getCmp('qryForm').getForm().findField('reqTime').getValue(); */
		var bigType=Ext.getCmp('qryForm').getForm().findField('bigType').getValue();
		<%if(isSearch){%>
			var isClose = Ext.getCmp('qryForm').getForm().findField('isClose').getValue();
			var flag=(isClose)?"close":"";
		<%}else if(isClose){%>
			var flag='<%=flag%>';
		<%}%>
		
		Ext.apply(       
			Ext.StoreMgr.get('solidTaskStore').proxy.extraParams, {
				planName:encodeURI(encodeURI(planName)),planTag:planTag,taskType:encodeURI(encodeURI(taskType)),submitStaffId:submitStaffId,factCompleteTime:factCompleteTime,bigType:bigType,flag:flag
			}      
		);      
	});	
		<%
   		}
    %>
	
	
	var sysContentModel= Ext.define('sysContentModel', {
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
	var sysContentStore=new  Ext.data.Store({
		id: 'sysContentStore',
		model: sysContentModel,
		groupField: 'categoryName',
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getMultipleSysConstant.do',
			reader: {
				type: 'json',
				root: 'data'
			}
		},
		listeners:{
			load:function(){
				solidTaskStore.load({params:{planId:planId}});
			}
		}
	});
	
	var workflowParamStore4Grid=new  Ext.data.Store({
		id: 'workflowParamStore4Grid',
		groupField: 'templateId',
		fields: ['linkId','phaseId','phaseName','vmTaskName','templateId'],
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getWorkflowParamByCategorys.do?categorys=SOLID_TASK_TYPE',
			reader: {
				type: 'json',
				root: 'data'
			}
		},
		listeners:{
			load:function(){
				sysContentStore.load({params:{categorys:'SOLID_TASK_TYPE,AIGA_TEST_PLAN'}});
			}
		}
	});
	workflowParamStore4Grid.load({params:{categorys:'SOLID_TASK_TYPE'}});
	var solidTaskGrid = Ext.create('Ext.grid.Panel',{
		id:'solidTaskGrid',
        cls: 'ui-formPanel',
        
        renderTo: Ext.get("solidPannel"),
        margins : '0 0 0 3',
        <% 
        	if(isSearch||isClose){
        		%>
        height: screenHeight*0.78*0.99,
        title: '版本测试任务单',
        bbar: Ext.create('Ext.PagingToolbar', { 
			store: solidTaskStore, 
			displayInfo: true, 
			displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
			emptyMsg: "没有数据"
		}),
        		<%
        	}else{
        		%>
        height: testSolidTaskList,		
        		<%
        	}
        %>
        width:screenWidth*0.98,
        minHeight: 150,
		forctFit:true,
        stripeRows:true,
		store: solidTaskStore,
		selType:'rowmodel',
		listeners : {
			<%if(!isClose){%>
			itemdblclick:function(grid,record,item,index,e,eOpts){
				var models=Ext.getCmp('solidTaskGrid').getSelectionModel().getSelection();
	        	if(models.length!=1){
	        		Ext.Msg.alert("提示","选择错误!");
	        	}else{
	        		var record=models[0].data;
	        		var taskId=record.taskId;
	        		var taskType=record.taskType;
	        		var taskTypeName="";
	        		var templateId="";
	        		var sysContentStore,sysCurrentModel;
	        		try{
	        			sysContentStore=Ext.data.StoreManager.lookup("sysContentStore");
	        			sysContentStore.clearFilter(true);
	        			sysContentStore.filter("category",'SOLID_TASK_TYPE');
		        		sysCurrentModel=sysContentStore.findRecord("other1",taskType );
		        		templateId=sysCurrentModel.data.other2;
		        		taskTypeName=sysCurrentModel.data.show;
	        			var url="<%=request.getContextPath()%>/aiga/workflow/testPlan/TestSolidTaskForm.jsp?taskId="+taskId+"&taskTypeName="+encodeURI(encodeURI(taskTypeName))+"&templateId="+templateId+"&isEditor=false&objId="+taskId+"&objType="+taskType;
				   var taskFormWin = new top.Ext.window.Window({
				 		id:'taskFormWinShow',
					    title : '查看版本测试任务单',
					    width : screenWidth * 0.9,
					    height : screenHeight * 0.9,
					    modal : true,
					    autoScroll:false,
					    listeners:{
							destroy:function(window,eOpts){
							}
					    },
					    closeAction : 'destroy',
					    html:'<iframe id="frame" name="frame" src="'+url+'" width="100%" height="100%" scrolling="yes"/>'
						}).show();
	        		}catch(e){
	        			Ext.Msg.alert('提示', "失败原因是: " + e.message);
	        		}
			}
			}
			<%}%>
		},
		<%if(isClose){%>
			selModel:top.Ext.create('Ext.selection.CheckboxModel',{mode:"SIMPLE"}),
		<%}%>
		columns:[new Ext.grid.RowNumberer(),
					{header: "任务id", width:100, sortable: true, dataIndex: 'taskId',hidden:true},
					{header: "版本测试任务名称", width:200, sortable: true, dataIndex: 'planName'},
					{header: "测试计划编号", width:180, sortable: true, dataIndex: 'planTag'},
					{header: "任务类型", width:110, sortable: true, dataIndex: 'taskType',renderer: function(value, cellmeta, record) {
		 	        	try
		     	          {
			        		var store=Ext.data.StoreManager.lookup("sysContentStore");
			        		store.clearFilter(true);
			        		store.filter("category","SOLID_TASK_TYPE");
				        	return store.findRecord("other1",value).getData().show+"";
		     	         } catch(e){return "未指定"+value+"的类型,请配置";}
			        }},
			       {header: "任务阶段", width:110,sortable: true, dataIndex: 'taskPhase',renderer: function(value, cellmeta, record) {
		 	        	try
		     	          {
		 	        		var sysContentStore=Ext.data.StoreManager.lookup("sysContentStore");
		 	        		sysContentStore.clearFilter(true);
		 	        		sysContentStore.filter('category','SOLID_TASK_TYPE');
		 	        		var sysCurrentModel=sysContentStore.findRecord("other1",record.getData().taskType );
		 	        		var templateId=sysCurrentModel.data.other2;
			        		var store=Ext.data.StoreManager.lookup("workflowParamStore4Grid");
		 	        		store.clearFilter(true);
	      	        		store.filter("templateId",templateId);
			        		 return store.findRecord("phaseId",value).getData().phaseName+"";
		     	         } catch(e){return "未指定{"+value+"},请配置";}
			        },hidden:true},
			       	{header: "任务单状态", width:110,sortable: true, dataIndex: 'taskStatus',renderer: function(value, cellmeta, record) {
         	        	try
	         	          {
         	        		var sysContentStore=Ext.data.StoreManager.lookup("sysContentStore");
		 	        		sysContentStore.clearFilter(true);
		 	        		sysContentStore.filter('category','SOLID_TASK_TYPE');
		 	        		if(value==-1){
			        		  	return "已关闭";
			        		}else{
			 	        		var sysCurrentModel=sysContentStore.findRecord("other1",record.getData().taskType );
			 	        		var templateId=sysCurrentModel.data.other2;
				        		var store=Ext.data.StoreManager.lookup("workflowParamStore4Grid");
			 	        		store.clearFilter(true);
		      	        		store.filter("templateId",templateId);
				        		return store.findRecord("linkId",value).getData().vmTaskName+"";
			        		}
		     	         } catch(e){return "未指定{"+value+"},请配置";}
       	        }},
					{header: "计划提交人", width:120, sortable: true, dataIndex: 'submitStaffName'},
	         		{header: "创建时间", width:150, sortable: true, dataIndex: 'createTime'},
					{header: "期望上线时间", width:100, sortable: true, dataIndex: 'plCompleteTime',hidden:true},
	            	{header: "开始时间", width:100,sortable: true, dataIndex: 'beginTime',hidden:true},
					{header: "代码截止提交日", width:120, sortable: true, dataIndex: 'codeCommitDate',hidden:true},
					{header: "计划上线时间", width:110, sortable: true, dataIndex: 'factCompleteTime'},
	        		{header: "需求定稿时间", width:110, sortable: true, dataIndex: 'reqTime',hidden:true},
	        		{header: "系统大类", width:100, sortable: true, dataIndex: 'bigType',renderer: function(value, cellmeta, record) {
         	        	try
	         	          {
       	        		var store=Ext.data.StoreManager.lookup("sysContentStore");
      	        		store.clearFilter(true);
      	        		  store.filter("categoryName","bigTypeStore");
      	        		  return store.findRecord("value",value).getData().show+"";
	         	         } catch(e){return "未指定"+value+",请配置";}
       	        }},
       	     {header: "上线类型", width:100, sortable: true, dataIndex: 'onLineType',renderer: function(value, cellmeta, record) {
  	        	try
      	          {
  	        		var store=Ext.data.StoreManager.lookup("sysContentStore");
 	        		store.clearFilter(true);
 	        		  store.filter("categoryName","onLineTypeStore");
 	        		  return store.findRecord("value",value).getData().show+"";
      	        } catch(e){return "未指定"+value+",请配置";}
  	        }},
	            	{header: "测试可用工时", width:100,sortable: true, dataIndex: 'versionContent'},
	        		{ header: '是否安全测试',dataIndex: 'isSecurityTest', width: 60,align: 'center',renderer: function(value, cellmeta, record) {if(value==1||value=='on')return "是";else return "否"; },hidden:true},
	        		{ header: '是否代码扫描',dataIndex: 'isCodeScan', width: 60,align: 'center',renderer: function(value, cellmeta, record) {if(value==1||value=='on')return "是";else return "否"; },hidden:true},
	        		{ header: '是否性能测试',dataIndex: 'isPerformanceTest', width: 60,align: 'center',renderer: function(value, cellmeta, record) {if(value==1||value=='on')return "是";else return "否"; },hidden:true},
	        		{ header: '是否回归测试',dataIndex: 'isRegressionTest', width: 60,align: 'center',renderer: function(value, cellmeta, record) {if(value==1||value=='on')return "是";else return "否"; },hidden:true},
	        		{header: "计划描述", width:200, sortable: true, dataIndex: 'planDscr'},
	        		{header: "变更原因", width:100, sortable: true, dataIndex: 'changeReason',hidden:true}
	        		]
	});
});
</script>
</html>