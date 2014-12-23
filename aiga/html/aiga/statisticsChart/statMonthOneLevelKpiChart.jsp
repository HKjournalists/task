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
	<title>月度运营一级KPI报表</title>
</head>
<body>
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
var fillChart = function(data) {
  	var myChartId = new Date().getTime();
  	var chart = new FusionCharts("<%=request.getContextPath()%>/chart/MSLine.swf", myChartId, screenWidth*0.99, screenHeight*0.4, "0", "1");
  	chart.setJSONData(data);
  	chart.render("orderChart");
};
function fusionChartsFunction(){
	alert();
}
function submitGridStore(){
	var Grid= Ext.getCmp("Grid");
	var store=Grid.getStore();
	var records = store.getUpdatedRecords();// 获取修改的行的数据，无法获取幻影数据  
			var phantoms=store.getNewRecords() ;//获得幻影行  
		records=records.concat(phantoms);//将幻影数据与真实数据合并
	var data = new Array(); 
       Ext.Array.each(records, function(record) {  
           data.push(record.data);  
           }); 
	Ext.Ajax.request({
		url:'<%=request.getContextPath()%>/submitStatisticsGridStore.do',
		params:{
			table:Ext.encode(data),
			stroeName:'com.asiainfo.aiga.statistics.bo.StatMonthOneLevelKpi'
			},
		success:function(response,config){
			Ext.Msg.alert('提示','保存成功！',function(){
    			
    		});
		},
		failure:function(response,config){
			MaskOver();
			Ext.Msg.alert('提示','请求数据失败');
		}
	});
}
function loadFusion(){
	startDate=Ext.getCmp('startDate').rawValue;
 	endDate=Ext.getCmp('endDate').rawValue;
	Ext.Ajax.request({
		url:'<%=request.getContextPath()%>/statMonthOneLevelKpiFunsionCharts.do',
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
	        	{name:'statId',type:'string'},
				{name:'reportMonth',type:'string'},
				{name:'createTime',type:'string'},
				{name:'versionPublishNum',type:'string'},
				{name:'versionTaskNum',type:'string'},
				{name:'versionReqNum',type:'string'},
				{name:'qualityDevProblemNum',type:'string'},
				{name:'qualityPublishErrorNum',type:'string'},
				{name:'qualityTerriblePrecent',type:'string'},
				{name:'qualityPublishErrorPrecent',type:'string'},
				{name:'devPeriodFromCreate',type:'string'},
				{name:'busiDevPersonNum',type:'string'},
				{name:'busiProjectPersonNum',type:'string'},
				{name:'devPeriodFromConfirm',type:'string'},
				{name:'devPeriodFromDistribute',type:'string'},
				{name:'devPublishEstWork',type:'string'}
			]
	});
	var gridProxy = new Ext.data.proxy.Ajax({
		type:"ajax",
		model: storeModel,
		url:'<%=request.getContextPath()%>/statMonthOneLevelKpiList.do',
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
	    title:'月度运营一级KPI',
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
		},
		{
			xtype:'button',
			text: '保存',
			handler: function() {
				submitGridStore();
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
		 plugins: [
		           Ext.create('Ext.grid.plugin.CellEditing', {
		               clicksToEdit: 2
		           })
		       ],
		columns:[
				new Ext.grid.RowNumberer({header:"序号",width:30}),
				{header: "id", hidden:true, width:100, sortable: false, dataIndex: 'statId'},
				{header: "createTime", hidden:true, width:100, sortable: false, dataIndex: 'createTime'},
				{header: "月份", width:100, sortable: true, dataIndex: 'reportMonth'},
				{header: "版本发布情况",
					columns:[
					         {header: "上线次数", width:100, sortable: true, dataIndex: 'versionPublishNum',editor:{xtype:'textfield'}},
							 {header: "任务单数", width:100, sortable: true, dataIndex: 'versionTaskNum',editor:{xtype:'textfield'}},
					         {header: "软件需求数", width:100, sortable: true, dataIndex: 'versionReqNum',editor:{xtype:'textfield'}}
	                       	 ]
				},
				{header: "质量指标",
					columns:[
							{header: "开发</br>故障次数", width:100, sortable: true, dataIndex: 'qualityDevProblemNum',editor:{xtype:'textfield'}},
							{header: "上线</br>异常事件次数", width:100, sortable: true, dataIndex: 'qualityPublishErrorNum',editor:{xtype:'textfield'}},
							{header: "严重故障率", width:100, sortable: true, dataIndex: 'qualityTerriblePrecent',editor:{xtype:'textfield'},renderer:function(value, cellMeta, record, rowIndex, columnIndex, store){return value+"%";}},
							{header: "上线故障率", width:100, sortable: true, dataIndex: 'qualityPublishErrorPrecent',editor:{xtype:'textfield'},renderer:function(value, cellMeta, record, rowIndex, columnIndex, store){return value+"%";}}
							]
				},
				{header: "效率指标",
					columns:[{header: "需求开发周期", width:150, sortable: true,//editor:{xtype:'textareafield',height:100},
						renderer:function(value, cellMeta, record, rowIndex, columnIndex, store){
							var DEV_PERIOD_FROM_CREATE=record.get('devPeriodFromCreate');
							var DEV_PERIOD_FROM_CONFIRM=record.get('devPeriodFromConfirm');
							var DEV_PERIOD_FROM_DISTRIBUTE=record.get('devPeriodFromDistribute');
							var text=(DEV_PERIOD_FROM_CREATE!=""?"从需求提出到上线:"+DEV_PERIOD_FROM_CREATE+"天</br>":"")
									+(DEV_PERIOD_FROM_CONFIRM!=""?"从需求确认到上线:"+DEV_PERIOD_FROM_CONFIRM+"天</br>":"")
									+(DEV_PERIOD_FROM_DISTRIBUTE!=""?"从需求分派到上线:"+DEV_PERIOD_FROM_DISTRIBUTE+"天":"");
							return text;
							}
					}]
				},
				{header: "容量指标",
					columns:[
							{header: "上线版本</br>预估容量", width:100, sortable: true, dataIndex: 'devPublishEstWork',editor:{xtype:'textfield'}},
							{header: "上线新业务</br>开发人员", width:100, sortable: true, dataIndex: 'busiDevPersonNum',editor:{xtype:'textfield'}},
							{header: "上线项目</br>开发人员", width:100, sortable: true, dataIndex: 'busiProjectPersonNum',editor:{xtype:'textfield'}}
							]
				}
				 
	    	]
		});
	var chartPanel = Ext.create('Ext.panel.Panel', {
	    width: screenWidth*.99,
	    height: screenHeight*0.5,
	    title:'月度运营一级KPI趋势图',
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