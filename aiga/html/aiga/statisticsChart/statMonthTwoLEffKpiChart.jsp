<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");%>
<html>
<head>
	<%@ include file="/aiga/common/include.jsp" %>
	<script type="text/javascript" src="<%=request.getContextPath()%>/chart/FusionCharts.js"></script>
	<title>月度运营二级效率KPI</title>
</head>
<body>
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
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
		url:'<%=request.getContextPath()%>/statMonthTwoLEffKpiFunsionCharts.do',
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
Ext.onReady(function(){
	var storeModel = Ext.regModel("storeModel",{
		fields:[
				{name:'STAT_ID',type:'string'},
				{name:'REPORT_MONTH',type:'string'},
				{name:'REQ_PERIOD_FROM_SUBMIT',type:'string'},
				{name:'REQ_PERIOD_FROM_CONFIRM',type:'string'},
				{name:'REQ_PERIOD_FROM_DISTRIBUTE',type:'string'},
				{name:'PLAN_SUCC_PERCENT',type:'string'},
				{name:'PLAN_CHANGE_PERCENT',type:'string'},
				{name:'PLAN_EMERGY_PUBLISH_PERCENT',type:'string'},
				{name:'REQ_ANLYSIS_TIMELY_PERCENT',type:'string'},
				{name:'DEV_CODE_TIMELY_PERCENT',type:'string'},
				{name:'DEV_BUG_TIMELY_PERCENT',type:'string'},
				{name:'TEST_TEST_TIMELY_PERCENT',type:'string'},
				{name:'TEST_BUG_TIMELY_PERCENT',type:'string'}
			]
	});
	var gridProxy = new Ext.data.proxy.Ajax({
		type:"ajax",
		model: storeModel,
		url:'<%=request.getContextPath()%>/statMonthTwoLEffKpiList.do',
		reader:{
			 root:"data",
			 type:"json",
			 totalProperty:'total'
		}
	});
	var gridStore = Ext.create('Ext.data.Store',{
		model: storeModel,
		id:'gridStore',
		pageSize:4,
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
	    title:'月度运营二级效率KPI',
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
			fieldLabel: '上线时间'
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
				{header: "id", hidden:true, align:'center', width:100, sortable: true, dataIndex: 'STAT_ID'},
				{header: "月份", width:100, align:'center', sortable: true, dataIndex: 'REPORT_MONTH'},
				{header: "需求实现周期", width:180, align:'center', sortable: true, dataIndex: 'TEST_WORK_LOAD_VALUE',
						renderer:function(value, cellMeta, record, rowIndex, columnIndex, store){
							var REQ_PERIOD_FROM_SUBMIT=record.get('REQ_PERIOD_FROM_SUBMIT');
							var REQ_PERIOD_FROM_CONFIRM=record.get('REQ_PERIOD_FROM_CONFIRM');
							var REQ_PERIOD_FROM_DISTRIBUTE=record.get('REQ_PERIOD_FROM_DISTRIBUTE');
							var text=(REQ_PERIOD_FROM_SUBMIT!=""?"从需求提出到上线"+REQ_PERIOD_FROM_SUBMIT+"天</br>":"")
									+(REQ_PERIOD_FROM_CONFIRM!=""?"从需求确认到上线"+REQ_PERIOD_FROM_CONFIRM+"天</br>":"")
									+(REQ_PERIOD_FROM_DISTRIBUTE!=""?"从需求分派到上线"+REQ_PERIOD_FROM_DISTRIBUTE+"天":"");
							return text;
							}
				},
				{header: "需求过程效率指标",
					columns:[
					         {header: "计划准确性",
					        	 columns:[
											{header: "计划准确性</br>(95%)", width:100, align:'center', sortable: true, dataIndex: 'PLAN_SUCC_PERCENT',renderer:function(value, cellMeta, record, rowIndex, columnIndex, store){return value+"%";}},
											{header: "计划变更率", width:100, align:'center', sortable: true, dataIndex: 'PLAN_CHANGE_PERCENT',renderer:function(value, cellMeta, record, rowIndex, columnIndex, store){return value+"%";}},
											{header: "紧急上线率", width:100, align:'center', sortable: true, dataIndex: 'PLAN_EMERGY_PUBLISH_PERCENT',renderer:function(value, cellMeta, record, rowIndex, columnIndex, store){return value+"%";}}
											]
					         },
					         {header: "需求分析</br>及时率</br>(7天)" ,width:100, align:'center', sortable: true, dataIndex: 'REQ_ANLYSIS_TIMELY_PERCENT',renderer:function(value, cellMeta, record, rowIndex, columnIndex, store){return value+"%";}}
	                       	 ]
				},
				{header: "开发过程效率指标",
					columns:[
							{header: "代码提交</br>及时率</br>(前4天95%)",align:'center',width:100, sortable: true, dataIndex: 'DEV_CODE_TIMELY_PERCENT',renderer:function(value, cellMeta, record, rowIndex, columnIndex, store){return value+"%";}},
							{header: "BUG修复</br>及时率</br>(1天)", width:100, align:'center', sortable: true, dataIndex: 'DEV_BUG_TIMELY_PERCENT',renderer:function(value, cellMeta, record, rowIndex, columnIndex, store){return value+"%";}}
							]
				},
				{header: "测试过程效率指标",
					columns:[
							{header: "测试</br>及时率</br>(100%)", width:100, align:'center', sortable: true, dataIndex: 'TEST_TEST_TIMELY_PERCENT',renderer:function(value, cellMeta, record, rowIndex, columnIndex, store){return value+"%";}},
							{header: "BUG验证</br>及时率(0.5天)", width:100, align:'center', sortable: true, dataIndex: 'TEST_BUG_TIMELY_PERCENT',renderer:function(value, cellMeta, record, rowIndex, columnIndex, store){return value+"%";}}
							]
				}
				 
	    	]
		});
	var chartPanel = Ext.create('Ext.panel.Panel', {
	    width: screenWidth*.99,
	    height: screenHeight*0.5,
	    title:'月度运营二级效率KPI趋势图',
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