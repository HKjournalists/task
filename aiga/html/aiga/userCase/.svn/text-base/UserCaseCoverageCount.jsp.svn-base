<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.sysConstant.bo.SysConstant"%>
<%@page import="com.asiainfo.aiga.sysConstant.util.SysContentUtil"%>
<%@page import="com.asiainfo.aiga.common.WorkflowParam"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");%>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/extJs/resources/css/ext-all.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/extJs/ext-all.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/base/jquery-1.8.0.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/base/json2.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/chart/FusionCharts.js"></script>
	<title>用例覆盖率统计</title>
</head>
<body>
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
Ext.onReady(function(){
	var fillChart = function(data) {
	  	var myChartId = new Date().getTime();
	  	var chart = new FusionCharts("<%=request.getContextPath()%>/chart/MSColumn2D.swf", myChartId, screenWidth*0.5, screenHeight*0.4, "0", "1");
	  	chart.setJSONData(data);
	  	chart.render("orderChart");
	};
	var subSysCoverageModel = Ext.regModel("subSysCoverageModel",{
		fields:[
		        <%
		        SysConstant[] sysContants = SysContentUtil.getSysContant("test_type");
		        for (SysConstant sysContant : sysContants) {%>
		        {name:'sys<%=sysContant.getConstantId()%>',type:'string'},
		        <%}%>
				{name:'sysName',type:'string'}
			]
	});
	var gridProxy = new Ext.data.proxy.Ajax({
		type:"ajax",
		model:subSysCoverageModel,
		url:'<%=request.getContextPath()%>/getSysCoverage.do',
		reader:{
			root:"data",
			type:"json"
		}
	});
var gridStore = Ext.create('Ext.data.Store',{
	model:subSysCoverageModel,
	proxy:gridProxy
});
gridStore.load();
var subSysCoverageGrid = Ext.create('Ext.grid.Panel',{
	id:'subSysCoverageGrid',
    cls: 'ui-formPanel',
	height: screenHeight*0.5,
    width: screenWidth*0.5,
    title:'用例覆盖率详情',
    items:[chartPanel],
	viewConfig:{
		forctFit:true,
		stripeRows:true
	},
	store: gridStore,
	selType:'rowmodel',
	listeners:{
	},
	columns:[
			{header: "系统名称", width:100, sortable: true, dataIndex: 'sysName'},
			 <%
		        for (SysConstant sysContant : sysContants) {%>
		    {header: "<%=sysContant.getShow()%>", width:100, sortable: true, dataIndex: 'sys<%=sysContant.getConstantId()%>'},
		        <%}%>
		    {header: "test", width:100,dataIndex: 'orderId',hidden:true}
    	]
	});
		var chartPanel = Ext.create('Ext.panel.Panel', {
		    width: screenWidth*0.5,
		    height: screenHeight*0.5,
		    title:'用例覆盖率统计',
		    cls: 'ui-formPanel',
		    html:'<div id="orderChart"></div>',
		    listeners:{
		    	render:function(panel,opts){
		    		Ext.Ajax.request({
		    			url:'<%=request.getContextPath()%>/caseCoverageCountChart.do',
		    			success:function(response,config){
		    				fillChart(Ext.JSON.decode(response.responseText).data);
		    			},
		    			failure:function(response,config){
		    				Ext.Msg.alert('提示','请求数据失败');
		    			}
		    		});
		    	}
		    }
		});
		var mainPanel = Ext.create('Ext.panel.Panel', {
			width: screenWidth,
		    height: screenHeight*0.5,
		    renderTo: Ext.getBody(),
		    layout: {
		        type: 'hbox',      
		        align: 'stretch', 
		        padding: 0
		    },
		    items:[chartPanel,subSysCoverageGrid]
		});
	});
	
</script>
</html>