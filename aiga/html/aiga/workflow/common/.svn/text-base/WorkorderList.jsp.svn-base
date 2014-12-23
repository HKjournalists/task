<!DOCTYPE html>
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
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ie-tab.css">
	<title>工单列表</title>
</head>
<body style="overflow: hidden;">
<form  action=""  method="post"  name="dd" style="display: none"></form>
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth - 5;
var screenHeight = document.documentElement.clientHeight;
Ext.onReady(function(){
	var workorderModel = Ext.regModel("workorderModel",{
		fields:[
			{name:'orderId',type:'string'},
			{name:'objId',type:'string'},
			{name:'execStaffId',type:'string'},
			{name:'linkNo',type:'string'},
			{name:'objTag',type:'string'},
			{name:'objName',type:'string'},
			{name:'orderType',type:'int'},
			{name:'vmTaskName',type:'string'},
			{name:'objType',type:'int'},
			{name:'createTime',type:'string'},
			{name:'adviceCompTime',type:'string'},
			{name:'factCompleteTime',type:'string'},
			{name:'status',type:'int'},
			{name:'submitStaffName',type:'string'},
			{name:'templateId',type:'string'}]
	});
	var gridProxy = new Ext.data.proxy.Ajax({
			type:"ajax",
			model:workorderModel,
			url:'<%=request.getContextPath()%>/getDomainJsonData.do?status=1,2,4&uid=<%=user.getUserAccount()%>&urlJava=/business/com.asiainfo.csc.common.web.WorkorderListAction&action=getDoWorkorderListTree&staffId=<%=user.getUserId()%>',
			reader:{
				root:"data",
				type:"json"
			}
		});
	var gridStore = Ext.create('Ext.data.Store',{
		pageSize: 50,
		id: 'gridStore',
		model:workorderModel,
		proxy:gridProxy,
		remoteSort: true
	});
	
    var mapModel = Ext.define('mapModel', {
        extend: 'Ext.data.Model',
        fields: [{
                name: 'constantId',
                type: 'string'
            }, {
                name: 'categoryName',
                type: 'string'
            }, {
                name: 'category',
                type: 'string'
            }, {
                name: 'show',
                type: 'string'
            }, {
                name: 'value',
                type: 'int'
            }, {
                name: 'other1',
                type: 'string'
            }, {
                name: 'other2',
                type: 'string'
            }, {
                name: 'memo',
                type: 'string'
            }
        ]
    });
    var mapStore = new Ext.data.Store({
        id: 'mapStore',
        model: mapModel,
        groupField: 'categoryName',
        proxy: {
            type: 'ajax',
            url: '<%=request.getContextPath()%>/getMultipleSysConstant.do?categorys=OBJ_TYPE,ORDER_STATUS,ORDER_TYPE',
            reader: {
                type: 'json',
                root: 'data'
            }
        },
        listeners:{
			load:function(){
				gridStore.load();
			}
		}
    });
    mapStore.load();
	var workorderGrid = Ext.create('Ext.grid.Panel',{
		id:'workorderGrid',
        cls: 'ui-formPanel',
        minWidth: 1024,
        minHeight: 200,
		height: screenHeight*0.5*0.98,
	    width: screenWidth,
		viewConfig:{
			forctFit:true,
			stripeRows:true
		},
		store:gridStore,
		selType:'rowmodel',
		bbar: Ext.create('Ext.PagingToolbar', { 
			store: gridStore, 
			displayInfo: true, 
			displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
			emptyMsg: "没有数据"
		}),
		listeners:{
			itemdblclick:function(grid,record,item,index,e,eOpts){
				Ext.Ajax.request({  
					url:"<%=request.getContextPath()%>/getWorkflowParamByUrl.do?linkNo="+record.raw.linkNo,  
					success:function(response,config){ 
						var json=Ext.JSON.decode(response.responseText);
						var url = json.linkUrl;
						if(url==''){
							Ext.Msg.alert('提示','缺少打开界面url');
							return;
						}
						var orderId = record.raw.orderId;
						var objId = record.raw.objId;
						var objType = record.raw.objType;
						
						url+= "?orderId="+orderId+"&objId="+objId+"&objType="+objType;
						var title = record.raw.objName;
						if(title.length>10){
							title = title.substring(0,10)+"...";
						}
						//console.log(url);
						window.parent.addNewTab("<%=request.getContextPath()%>"+ url +"&workOrderFlag=workOrder",title,orderId);
					},
					failure:function(response,config){
						Ext.Msg.alert('提示','获取数据失败');
					}
				});
			}
		},
		columns:[
				{xtype: 'rownumberer',width:30},
				{header: "工单ID", width:100, sortable: true, dataIndex: 'orderId',hidden:true},
				{header: "业务ID", width:100, sortable: true, dataIndex: 'objId',hidden:true},
        		{header: "工单处理人", width:100,sortable: true, dataIndex: 'execStaffId',hidden:true},
        		{header: "环节编号", width:100, sortable: true, dataIndex: 'linkNo',hidden:true},
        		{header: "编号", width:150, sortable: true, dataIndex: 'objTag'},
        		{header: "名称", width:250, sortable: true, dataIndex: 'objName'},
        		{header: "工单类型", hidden:true,width:100, sortable: true, dataIndex: 'orderType', renderer: function (value, cellmeta, record) {
                    try {
                        var store = Ext.data.StoreManager.lookup("mapStore");
                        store.clearFilter(true);
                        store.filter("categoryName", "工单类型");
                        return store.findRecord("value", value).getData().show + "";
                    } catch (e) {
                        return "未指定"+value;
                    };
                }},
        		{header: "环节名称", width:120, sortable: true, dataIndex: 'vmTaskName'},
        		{header: "工单类型", width:100, sortable: true, dataIndex: 'objType',renderer: function (value, cellmeta, record) {
                    try {
                        var store = Ext.data.StoreManager.lookup("mapStore");
                        store.clearFilter(true);
                        store.filter("categoryName", "对象类型");
                        return store.findRecord("value", value).getData().show + "";
                    } catch (e) {
                        return "未指定"+value;
                    };
                }},
                {header: "计划上线时间", width:140, sortable: true, dataIndex: 'factCompleteTime'},
        		{header: "创建时间", width:140, sortable: true, dataIndex: 'createTime'},
        		{header: "建议完成时间", width:140, sortable: true, dataIndex: 'adviceCompTime'},
        		{header: "工单状态", width:100, sortable: true, dataIndex: 'status',renderer: function (value, cellmeta, record) {
                    try {
                        var store = Ext.data.StoreManager.lookup("mapStore");
                        store.clearFilter(true);
                        store.filter("categoryName", "工单状态");
                        return store.findRecord("value", value).getData().show + "";
                    } catch (e) {
                        return "未指定"+value;
                    };
                }},
        		{header: "创建人", width:80, sortable: true, dataIndex: 'submitStaffName'},
        		{header: "模板ID", width:100, sortable: true, dataIndex: 'templateId',hidden:true}
        	]
		});
		
		var fillChart = function(data) {
		  	var myChartId = new Date().getTime();
		  	var chart = new FusionCharts("<%=request.getContextPath()%>/chart/MSColumn2D.swf", myChartId, screenWidth, screenHeight*0.4, "0", "1");
		  	chart.setJSONData(data);
		  	chart.render("orderChart");
		};
		var templateModel = Ext.define('templateModel', {
	        extend: 'Ext.data.Model',
	        fields: [{
	                name: 'qmId',
	                type: 'string'
	            },{
	                name: 'systemType',
	                type: 'string'
	            },
	            {
	                name: 'qmTag',
	                type: 'string'
	            },
	            {
	                name: 'qmName',
	                type: 'string'
	            },
	            {
	                name: 'updateTime',
	                type: 'string'
	            },
	            {
	                name: 'updateLog',
	                type: 'string'
	            },
	            {
	                name: 'filePath',
	                type: 'string'
	            },
	            {
	                name: 'relationDoc',
	                type: 'string'
	            },
	            {
	                name: 'responseName',
	                type: 'string'
	            },
	            {
	                name: 'approvalName',
	                type: 'string'
	            }
	        ]
	    });
		var templateStore = Ext.create('Ext.data.Store', {
			model: templateModel,
			proxy: {
	            type: 'ajax',
	            url: '<%=request.getContextPath()%>/getTemplateFile.do',
	            reader: {
	                type: 'json',
	                root: 'data'
	            }
	        }
		});
		templateStore.load();
		var templateGrid = Ext.create('Ext.grid.Panel',{
			id:'templateGrid',
	        cls: 'ui-formPanel',
	        minWidth: 512,
	        minHeight: 200,
			width: screenWidth*0.5,
	        height: screenHeight*0.5*0.74,
			viewConfig:{
				forctFit:true,
				stripeRows:true
			},
			store:templateStore,
			listeners:{
				itemdblclick:function(grid, record, item, index, e, eOpts ){
					var path = record.raw.filePath;
					var fileName = record.raw.qmName;
					var relationDoc = record.raw.relationDoc;
				    var url = '<%=request.getContextPath()%>/downTemplateFile.do?fileName='+fileName+'&filePath='+path+'&relationDoc='+relationDoc;
				    url=encodeURI(encodeURI(url));
				    document.dd.action=url;
					document.dd.submit();
				}
			},
			columns:[
				new Ext.grid.RowNumberer(),
				{header:"主键",width:100,dataIndex:"qmId",sortable:true,hidden:true},
				{header:"体系分类",width:100,dataIndex:"systemType",sortable:true},
				{header:"编号",width:100,dataIndex:"qmTag",sortable:true},
				{header:"规范名称",width:100,dataIndex:"qmName",sortable:true},
				{header:"最新修改时间",width:100,dataIndex:"updateTime",sortable:true},
				{header:"最新更新记录",width:100,dataIndex:"updateLog",sortable:true},
				{header:"存放地址",width:100,dataIndex:"filePath",sortable:true},
				{header:"相关文档",width:100,dataIndex:"relationDoc",sortable:true},
				{header:"责任人",width:100,dataIndex:"responseName",sortable:true},
				{header:"审核人",width:100,dataIndex:"approvalName",sortable:true}
			]
		});
		
		var templatePanel = Ext.create('Ext.panel.Panel',{
			id:'templatePanel',
			title:'质量管理规定',
	        minWidth: 1024,
	        minHeight: 200,
			width: screenWidth,
		    height: screenHeight*0.5*0.74,
		    layout: {
				type: 'hbox',      
				align: 'stretch', 
				padding: 0
			},
			listeners:{
				render:function(panel,eOpts){
					Ext.Ajax.request({
						url:'<%=request.getContextPath()%>/getHomePageMsg.do',
						success:function(response,config){
							var json = Ext.JSON.decode(response.responseText);
							if(json.success==true){
								var msg = json.data;
								Ext.getCmp('templateMsg').setValue(msg);
							}else{
								Ext.Msg.alert("提示","获取质量管理规定信息后台出现异常");
							}
						},
						failure:function(response,config){
							Ext.Msg.alert("提示","获取质量管理规定信息失败");
						}
					});
				}
			},
		    items: [{
				region: 'west',
				items:[{
					xtype:'textareafield',
					id:'templateMsg',
					name:'templateMsg',
					readOnly:true,
			        minWidth: 512,
			        minHeight: 200,
					width: screenWidth*0.5,
		    		height: screenHeight*0.5*0.74
				}]
			},
			{
				region: 'center',
				items:[templateGrid]
			}]
		});
		
		var chartPanel = Ext.create('Ext.tab.Panel', {
	        minWidth: 1024,
	        minHeight: 200,
		    width: screenWidth,
		    height: screenHeight*0.5*0.88,
		    border:0,
		    cls:"ui-tab-bar",
			bodyCls:"ui-tab-body",
		    items:[{
			    title:'工单统计',html:'<div id="orderChart"></div>'
		    },templatePanel
		    ],
		    listeners:{
		    	render:function(panel,opts){
		    		var mask = new Ext.LoadMask(chartPanel, {
						msg : '正在统计工单信息，请稍后',
						disabled : false
					});
		    		Ext.Ajax.request({
		    			url:'<%=request.getContextPath()%>/getChartData.do',
		    			success:function(response,config){
		    				fillChart(Ext.JSON.decode(response.responseText).data);
		    			},
		    			failure:function(response,config){
		    				Ext.Msg.alert('提示','工单统计信息获取失败');
		    			}
		    		});
		    	}
		    }
		});
		var workorderListPanel = Ext.create('Ext.panel.Panel', {
	        minWidth: 1024,
	        minHeight: 400,
		    width: screenWidth,
		    height: screenHeight,
		    renderTo:Ext.getBody(),
		    title:'待办工单',
		    cls: 'ui-formPanel',
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
		        items:[workorderGrid,chartPanel]
		    }]
		});
			
	});
	
function closeTab(){
	window.parent.closeTab();
}
</script>
</html>