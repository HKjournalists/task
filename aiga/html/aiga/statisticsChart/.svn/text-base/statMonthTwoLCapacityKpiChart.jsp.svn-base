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
	<title>月度运营二级容量KPI</title>
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
  	var chart = new FusionCharts("<%=request.getContextPath()%>/chart/MSCombiDY2D.swf", myChartId, screenWidth*0.99, screenHeight*0.4, "0", "1");
  	chart.setJSONData(data);
  	chart.render("orderChart");
};
function loadFusion(){
	startDate=Ext.getCmp('startDate').rawValue;
 	endDate=Ext.getCmp('endDate').rawValue;
	Ext.Ajax.request({
		url:'<%=request.getContextPath()%>/statMonthTwoLCapacityKpiFunsionCharts.do',
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
				{name:'REQ_ANLYSIS_AVG_NUM',type:'string'},
				{name:'REQ_PERSON_NUM',type:'string'},
				{name:'DEV_WORK_LOAD_VALUE',type:'string'},
				{name:'DEV_PUBLISH_EST_WORK',type:'string'},
				{name:'DEV_PERSON_NUM',type:'string'},
				{name:'TEST_WORK_LOAD_VALUE',type:'string'},
				{name:'TEST_CASE_AVG',type:'string'},
				{name:'TEST_PERSON_NUM',type:'string'}
			]
	});
	var gridProxy = new Ext.data.proxy.Ajax({
		type:"ajax",
		model: storeModel,
		url:'<%=request.getContextPath()%>/statMonthTwoLCapacityKpiList.do',
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
	    title:'月度运营二级容量KPI',
		forctFit:true,
	    stripeRows:true,
	    loadMask:true,
	    columnLines: true,
		store: gridStore,
		selType:'rowmodel',
    	tbar:[{
			width:160,
			labelWidth:60,
	        xtype: 'monthfield', 
	        labelAlign: 'right',
	        id: 'startDate',
	        format: 'Y-m',
	        value:new Date(),
			fieldLabel: '开始时间'
		},{
			width:160,
			labelWidth:60,
	        xtype: 'monthfield', 
	        labelAlign: 'right',
	        id: 'endDate',
	        format: 'Y-m',
	        value:new Date(),
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
				new Ext.grid.RowNumberer({header:"序号",width:30}),
				{header: "id", hidden:true, width:100, sortable: true, dataIndex: 'STAT_ID'},
				{header: "月份", width:100, sortable: true, dataIndex: 'REPORT_MONTH'},
				{header: "需求容量指标",
					columns:[
					         {header: "人均需求分析数", width:100, sortable: true, dataIndex: 'REQ_ANLYSIS_AVG_NUM'},
							 {header: "需求人员", width:100, sortable: true, dataIndex: 'REQ_PERSON_NUM'}
	                       	 ]
				},
				{header: "开发容量指标",
					columns:[
							{header: "工作负荷程度", width:100, sortable: true, dataIndex: 'DEV_WORK_LOAD_VALUE'},
							{header: "上线版本预估容量", width:100, sortable: true, dataIndex: 'DEV_PUBLISH_EST_WORK'},
							{header: "开发人数", width:100, sortable: true, dataIndex: 'DEV_PERSON_NUM'}]
				},
				{header: "测试容量指标",
					columns:[
							{header: "工作负荷程度", width:100, sortable: true, dataIndex: 'TEST_WORK_LOAD_VALUE'},
							{header: "人均测试用例数", width:100, sortable: true, dataIndex: 'TEST_CASE_AVG'},
							{header: "测试人员", width:100, sortable: true, dataIndex: 'TEST_PERSON_NUM'}]
				}
				 
	    	]
		});
	var chartPanel = Ext.create('Ext.panel.Panel', {
	    width: screenWidth*0.99,
	    height: screenHeight*.5,
	    title:'月度运营二级容量KPI趋势图',
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