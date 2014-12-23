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
	<title>月度运营三级KPI-测试小组KPI达成情况</title>
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
 	groupId=Ext.getCmp('groupId').getValue();
	Ext.Ajax.request({
		url:'<%=request.getContextPath()%>/statMonthTestGroupKpiFunsionCharts.do',
		params:{
			startDate:startDate,
			endDate:endDate,
			groupId:groupId
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
 	groupId=Ext.getCmp('groupId').getValue();
	Ext.StoreMgr.get('gridStore').on('beforeload',function(){
		Ext.apply(       
			Ext.StoreMgr.get('gridStore').proxy.extraParams, {
				startDate:startDate,
				endDate:endDate,
				groupId:groupId
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
	var groupStore=new Ext.data.Store({
		autoLoad: true,
		id: 'groupStore',
		fields: ['value','show'],
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getGroupComBox.do',
			reader: {
				type: 'json',
				root: 'data'
			}
		}
	});
	groupStore.load();
	var groupCombox = new Ext.form.ComboBox({
		width:160,
		labelWidth:60,
		store: groupStore ,
		id:"groupId",
		fieldLabel : "组名称",
		valueField: 'value',
		displayField: 'show',
	 	listeners:{
	    	beforequery:function( queryEvent,eOpts ){
				queryEvent.query="groupStore";
			}
	    }
	});
	var storeModel = Ext.regModel("storeModel",{
		fields:[
				{name:'STAT_ID',type:'string'},
				{name:'REPORT_MONTH',type:'string'},
				{name:'GROUP_ID',type:'string'},
				{name:'GROUP_NAME',type:'string'},
				{name:'GROUP_ADMIN',type:'string'},
				{name:'BUG_LEFT_PERCENT',type:'string'},
				{name:'BUG_UNVALID_PERCENT',type:'string'},
				{name:'CASE_BUG_PERCENT',type:'string'},
				{name:'TEST_TIMELY_PERCENT',type:'string'},
				{name:'TEST_CHECK_TIMELY',type:'string'},
				{name:'CASE_P_AVG_NUM',type:'string'},
				{name:'WORK_LOAD',type:'string'},
				{name:'WORK_OVER',type:'string'},
				{name:'TESTER_NUM',type:'string'}
			]
	});
	var gridProxy = new Ext.data.proxy.Ajax({
		type:"ajax",
		model: storeModel,
		url:'<%=request.getContextPath()%>/statMonthTestGroupKpiList.do',
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
	    title:'月度运营三级KPI-测试小组KPI达成情况',
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
		},
		groupCombox,
		{
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
				{header: "统计ID",hidden:true,align:'center', width:100, sortable: true, dataIndex: 'STAT_ID'},
				{header: "月份", width:100,align:'center',  sortable: true, dataIndex: 'REPORT_MONTH'},
				{header: "组ID",hidden:true,width:100,align:'center',  sortable: true, dataIndex: 'GROUP_ID'},
				{header: "组名称", width:100,align:'center',  sortable: true, dataIndex: 'GROUP_NAME'},
				{header: "负责人", width:100,align:'center',  sortable: true, dataIndex: 'GROUP_ADMIN'},
				{header: "测试过程质量指标",align:'center', 
					columns:[
					         {header: "测试缺陷遗漏率", width:100,align:'center',  sortable: true, dataIndex: 'BUG_LEFT_PERCENT'},
					         {header: "无效缺陷率", width:100,align:'center',  sortable: true, dataIndex: 'BUG_UNVALID_PERCENT'},
					         {header: "测试用例BUG率", width:100,align:'center',  sortable: true, dataIndex: 'CASE_BUG_PERCENT'}
	                       	 ]
				},
				{header: "测试过程效率指标",align:'center', 
					columns:[
							{header: "测试及时率", width:100,align:'center',  sortable: true, dataIndex: 'TEST_TIMELY_PERCENT'},
							{header: "测试BUG验证及时率", width:100, align:'center', sortable: true, dataIndex: 'TEST_CHECK_TIMELY'}]
				},
				{header: "测试容量指标",align:'center', 
					columns:[
							{header: "人均用例数", width:100, align:'center', sortable: true, dataIndex: 'CASE_P_AVG_NUM'},
							{header: "工作负荷程度", width:100,align:'center',  sortable: true, dataIndex: 'WORK_LOAD'},
							{header: "测试版本预估容量", width:100, align:'center', sortable: true, dataIndex: 'WORK_OVER'},
							{header: "测试人员", width:100, align:'center', sortable: true, dataIndex: 'TESTER_NUM'}]
				}
	    	]
		});
	var chartPanel = Ext.create('Ext.panel.Panel', {
	    width: screenWidth*0.99,
	    height: screenHeight*.5,
	    title:'月度运营三级KPI-测试小组KPI达成情况',
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