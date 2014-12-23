<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");%>


<html>
<head>
	<%@ include file="/aiga/common/include.jsp" %>
	<title>用例覆盖率统计</title>
	<style>
	.save-button{background: url(<%=request.getContextPath()%>/css/images/save.png) left top no-repeat;   }
	.search-button{background: url(<%=request.getContextPath()%>/css/images/search.png) left top no-repeat;   }
	</style>
	<script type="text/javascript" src="<%=request.getContextPath()%>/chart/FusionCharts.js"></script>
</head>
<body>
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
Ext.require([
             'Ext.grid.*',
             'Ext.toolbar.Paging',
             'Ext.util.*',
             'Ext.data.*'
         ]);
var fillChart = function(data,divId) {
  	var myChartId = new Date().getTime();
  	var chart = new FusionCharts("<%=request.getContextPath()%>/chart/MSColumn2D.swf", myChartId, screenWidth*0.99, screenHeight*0.4, "0", "1");
  	chart.setJSONData(data);
  	chart.render(divId);
};

Ext.onReady(function(){
	Ext.create('Ext.panel.Panel', {
	    title: '',
	    width: screenWidth*.98,
	    height:screenHeight*.55,
	    html:'<iframe id="frame" name="frame_1" frameborder="no"  border=0  marginwidth=0  marginheight=0  scrolling="no" src="<%=request.getContextPath()%>/statCommon.html?className=com.asiainfo.aiga.statistics.bo.StatAutoCover&isEditor=false" width="100%" height="100%"/>',
	    renderTo: Ext.getBody()
	});
	var chartPanel_1=Ext.create('Ext.panel.Panel', {
	    title: '用例覆盖率统计',
	    width: screenWidth*.98,
	    height:screenHeight*.495,
	    cls: 'ui-formPanel',
	    html:'<div id="Chart_1"></div>',
	    listeners:{
	    	render:function(panel,opts){
	    	loadFusion({},'Chart_1');
	    	}
	    }
	});
	var chartPanel_2=Ext.create('Ext.panel.Panel', {
	    title: '自动化覆盖情况',
	    width: screenWidth*.98,
	    height:screenHeight*.495,
	    cls: 'ui-formPanel',
	    html:'<div id="Chart_2"></div>',
	    listeners:{
	    	render:function(panel,opts){
	    		loadFusion_2({},'Chart_2');
	    	}
	    }
	});
	Ext.create('Ext.tab.Panel', {
		width: screenWidth*.98,
	    height:screenHeight*.495,
	    cls: 'ui-formPanel',
	    title: '统计',
	    renderTo: Ext.getBody(),
	    layout: {
	        type: 'vbox',      
	        align: 'stretch', 
	        padding: 0
	    },
	    items:[chartPanel_1,chartPanel_2]
	});

});
function loadFusion(queryData){
	if(queryData!=undefined){
		//console.log(queryData);
		Ext.Ajax.request({
			url:'<%=request.getContextPath()%>/statAutoCoverChart.do',
			params:queryData,
			success:function(response,config){
				fillChart(Ext.JSON.decode(response.responseText).data,'Chart_1');
			},
			failure:function(response,config){
				Ext.Msg.alert('提示','请求数据失败');
			}
		});
	}
}
function loadFusion_2(queryData,divId){
	if(queryData!=undefined){
		//console.log(queryData);
		Ext.Ajax.request({
			url:'<%=request.getContextPath()%>/statAutoCoverCountChart.do',
			params:queryData,
			success:function(response,config){
				fillChart(Ext.JSON.decode(response.responseText).data,divId);
			},
			failure:function(response,config){
				Ext.Msg.alert('提示','请求数据失败');
			}
		});
	}
}
</script>
</html>