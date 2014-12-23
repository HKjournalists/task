<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.sysConstant.bo.SysConstant"%>
<%@page import="com.asiainfo.aiga.sysConstant.util.SysContentUtil"%>
<%@page import="com.asiainfo.aiga.common.WorkflowParam"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");%>
<html>
<head>
	<%@ include file="/aiga/common/include.jsp" %>
	<script type="text/javascript" src="<%=request.getContextPath()%>/chart/FusionCharts.js"></script>
	<title>月度运营二级质量KPI</title>
</head>
<body>
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
var startDate='';
var endDate='';
var fillChart = function(data) {
  	var myChartId = new Date().getTime();
  	var chart = new FusionCharts("<%=request.getContextPath()%>/chart/MSColumn2D.swf", myChartId, screenWidth*0.99, screenHeight*0.4, "0", "1");
  	chart.setJSONData(data);
  	chart.render("orderChart");
};
function loadFusion(){
	startDate=Ext.getCmp('startDate').rawValue;
 	endDate=Ext.getCmp('endDate').rawValue;
	Ext.Ajax.request({
		url:'<%=request.getContextPath()%>/statMonthTwoLQualityKpiFunsionCharts.do',
		params:{
			startDate:startDate,
			endDate:endDate
			},
		success:function(response,config){
			fillChart(Ext.JSON.decode(response.responseText).data);
		},
		failure:function(response,config){
			Ext.Msg.alert('提示','请求数据失败');
		}
	});
}
function query() {
	loadFusion();
 	startDate=Ext.getCmp('startDate').rawValue;
 	endDate=Ext.getCmp('endDate').rawValue;
	Ext.StoreMgr.get('gridStore').on('beforeload',function(){
		Ext.apply(       
			Ext.StoreMgr.get('gridStore').proxy.extraParams, {
				startDate:startDate,
				endDate:endDate
			}      
		);      
	});
	Ext.StoreMgr.get('gridStore').loadPage(1);
}
Ext.require([
             'Ext.grid.*',
             'Ext.toolbar.Paging',
             'Ext.util.*',
             'Ext.data.*'
         ]);
Ext.onReady(function(){
	var storeModel = Ext.regModel("storeModel",{
		fields:[
				{name:'STAT_ID',type:'string'},
				{name:'REPORT_MONTH',type:'string'},
				{name:'PUBLISH_ERROR_PERCENT',type:'string'},
				{name:'DEV_BUG_DENSITY',type:'string'},
				{name:'DEV_REQ_BUG_DENSITY',type:'string'},
				{name:'DEV_DESIGN_BUG_DENSITY',type:'string'},
				{name:'DEV_DEV_BUG_DENSITY',type:'string'},
				{name:'DEV_DOUBLE_DEV_PERCENT',type:'string'},
				{name:'DEV_TASK_BUG_PERCENT',type:'string'},
				{name:'DEV_UNIT_TEST_PERCENT',type:'string'},
				{name:'TEST_BUG_LEAVE_PERCENT',type:'string'},
				{name:'TEST_BUG_UNVALID_PERCENT',type:'string'},
				{name:'TEST_BUG_VALID_PERCENT',type:'string'}
			]
	});
	var gridProxy = new Ext.data.proxy.Ajax({
		type:"ajax",
		model: storeModel,
		url:'<%=request.getContextPath()%>/statMonthTwoLQualityKpiList.do',
		reader:{
			 root:"data",
			 type:"json",
			 totalProperty:'total'
		}
	});
	var gridStore = Ext.create('Ext.data.Store',{
		model: storeModel,
		id:'gridStore',
		pageSize:10,
		listeners:{
		},
		proxy:gridProxy
	});
	gridStore.load();
	var Grid = Ext.create('Ext.grid.Panel',{
		id:'Grid',
	    cls: 'ui-formPanel',
	    width: screenWidth*0.99,
	    height: screenHeight*0.52,
	    title:'月度运营二级质量KPI',
		forctFit:true,
	    stripeRows:true,
	    loadMask:true,
		store: gridStore,
		selType:'rowmodel',
    	tbar:[{
			width:160,
			labelWidth:60,
	        xtype: 'monthfield', 
	        labelAlign: 'right',
	        id: 'startDate',
	        format: 'Y-m',
			fieldLabel: '开始时间'
		},{
			width:160,
			labelWidth:60,
	        xtype: 'monthfield', 
	        labelAlign: 'right',
	        id: 'endDate',
	        format: 'Y-m',
			fieldLabel: '结束时间'
		},{
			xtype:'button',
			text: '搜索',
			handler: function() {
				query();
			}
		}
		],
		bbar: Ext.create('Ext.PagingToolbar', {
			store: gridStore, 
			displayInfo: true, 
			displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
			emptyMsg: "没有数据"
			}),
		listeners:{
		},
		columns:[
				new Ext.grid.RowNumberer(),
				{header: "STAT_ID", hidden:true,align:'center',  width:100, sortable: true, dataIndex: 'STAT_ID'},
				{header: "月份", width:100,align:'center',  sortable: true, dataIndex: 'REPORT_MONTH'},
				{header: "上线故障率", width:100, align:'center', sortable: true, dataIndex: 'PUBLISH_ERROR_PERCENT'},
				{header: "开发过程质量指标",align:'center', 
					columns:[
					         {header: "综合缺陷密度", width:100,align:'center',  sortable: true, dataIndex: 'DEV_BUG_DENSITY'},
					         {header: "需求缺陷密度", width:100,align:'center',  sortable: true, dataIndex: 'DEV_REQ_BUG_DENSITY'},
					         {header: "设计缺陷密度", width:100,align:'center',  sortable: true, dataIndex: 'DEV_DESIGN_BUG_DENSITY'},
					         {header: "开发缺陷密度", width:100,align:'center',  sortable: true, dataIndex: 'DEV_DEV_BUG_DENSITY'},
					         {header: "二次开发率", width:100,align:'center',  sortable: true, dataIndex: 'DEV_DOUBLE_DEV_PERCENT'},
					         {header: "任务单BUG率", width:100,align:'center',  sortable: true, dataIndex: 'DEV_TASK_BUG_PERCENT'},
							 {header: "单元测试抽检合格率", width:100,align:'center',  sortable: true, dataIndex: 'DEV_UNIT_TEST_PERCENT'}
	                       	 ]
				},
				{header: "测试过程质量指标",align:'center', 
					columns:[
							{header: "测试缺陷遗漏率", width:100, align:'center', sortable: true, dataIndex: 'TEST_BUG_LEAVE_PERCENT'},
							{header: "无效缺陷率", width:100,align:'center',  sortable: true, dataIndex: 'TEST_BUG_UNVALID_PERCENT'},
							{header: "测试用例有效性", width:100,align:'center',  sortable: true, dataIndex: 'TEST_BUG_VALID_PERCENT'}]
				}
	    	]
		});
	var chartPanel = Ext.create('Ext.panel.Panel', {
	    width: screenWidth*0.99,
	    height: screenHeight*.5,
	    title:'月度运营二级质量KPI图形',
	    cls: 'ui-formPanel',
	    html:'<div id="orderChart"></div>',
	    listeners:{
	    	render:function(panel,opts){
	    		loadFusion();
	    	}
	    }
	});
	var mainPanel = Ext.create('Ext.panel.Panel', {
		width: screenWidth*.99,
	    height: screenHeight*.96,
	    renderTo: Ext.getBody(),
	    layout: {
	        type: 'vbox',      
	        align: 'stretch', 
	        padding: 0
	    },
	    items:[Grid,chartPanel]
	});
	});
	
</script>
</html>