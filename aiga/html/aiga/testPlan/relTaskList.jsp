<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<html>
<head>
	<title>关联</title>
	<style type="text/css">
		#uploadForm-body table {
			float: left;
		}
		
		#uploadForm-body div {
			float: right;
		}
	</style>
</head>
<body>
</body>
<script type="text/javascript">
var extjsFolderPath='<%=request.getContextPath()%>/extJs';
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.tip.QuickTipManager.init();

	
	var taskStore = Ext.create('Ext.data.Store', {
		storeId:'taskStore',
		fields:[{name:'taskId',type:'string'}, 
		 		{name:'reqId',type:'string'}, 
		 		{name:'currentStatus',type:'string'}, 
		 		{name:'priority',type:'string'},
		 		{name:'taskTag',type:'string'},
		 		{name:'reqTag',type:'string'},
		 		{name:'plCompleteTime',type:'string'},
		 		{name:'factCompleteTime',type:'string'},
		 		{name:'devWorkDay',type:'string'},
		 		{name:'testWorkDay',type:'string'},
		 		{name:'createTime',type:'string'},
		 		{name:'taskName',type:'string'},
		 		{name:'distributePersion',type:'string'},
		 		{name:'bigType',type:'string'},
		 		{name:'taskHour',type:'string'},
		 		{name:'performanceTest',type:'string'},
		 		{name:'crossCycle',type:'string'},
		 		{name:'point2pointTest',type:'string'},
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
	
	taskStore.load({
		params: {planId:"${param.planId}"}
	});
	
	var taskGrid = Ext.create('Ext.grid.Panel',{
		id:'taskGrid',
		title:'任务列表',
        margins : '0 0 0 3',
        height:'100%',
        width:screenWidth*0.99,
       //tbar:tbar,
        height:screenHeight*0.5*0.99,
		forctFit:true,
        stripeRows:true,
        loadMask:true, 
		store: taskStore,
		selType:'rowmodel',
		columns:[new Ext.grid.RowNumberer(),
				
				{header: "计划id", width:100, sortable: true, dataIndex: 'taskId',hidden:true},
				{header: "测试任务编号", width:100, sortable: true, dataIndex: 'taskId'},
				{header: "测试任务名称", width:100, sortable: true, dataIndex: 'taskName'},
				{header: "需求编号", width:100, sortable: true, dataIndex: 'reqId'},
				{header: "测试任务派发人", width:100, sortable: true, dataIndex: 'distributePersion'},
        		{header: "测试任务执行人", width:100,sortable: true, dataIndex: 'runPersion'},
        		{header: "测试任务状态", width:100, sortable: true, dataIndex: 'currentStatus'},
        		{header: "测试任务派发时间", width:100, sortable: true, dataIndex: 'distributeTime'},
        		{header: "测试任务计划完成时间", width:100, sortable: true, dataIndex: 'plCompleteTime'},
        		{header: "测试任务实际完成时间", width:100, sortable: true, dataIndex: 'factCompleteTime'},
        		{header: "系统大类", width:100, sortable: true, dataIndex: 'bigType'},
        		{header: "需求重要程度", width:100, sortable: true, dataIndex: ''},
        		{header: "是否需要性能测试", width:100, sortable: true, dataIndex: 'factCompleteTime'},
        		{header: "是否需要联调", width:100, sortable: true, dataIndex: 'jointTest'},
        		{header: "是否跨周期需求", width:100, sortable: true, dataIndex: 'crossCycle'},
        		{header: "是否需要端到端测试", width:100, sortable: true, dataIndex: 'point2pointTest'},
        		{header: "开发任务工时", width:100, sortable: true, dataIndex: 'devWorkDay'},
        		{header: "测试任务工时", width:100, sortable: true, dataIndex: 'testWorkDay'}
        		]
	});
	
	Ext.create('Ext.Panel', {
		renderTo: Ext.getBody(),
		width: screenWidth*0.99,
		height: screenHeight*0.99,
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
		items: [ {
			region: 'center',
			items:[taskGrid]
		}]
    });
});
</script>
</html>