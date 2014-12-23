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
	<title>历史轨迹</title>
</head>
<body>
</body>
<script type="text/javascript">
var objId="${param.objId}";
var objType="${param.objType}";

var screenWidth = document.documentElement.clientWidth==0?900:document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight==0?170:document.documentElement.clientHeight;

Ext.onReady(function(){
	var workorderModel = Ext.regModel("workorderModel",{
		fields:[
			{name:'orderId',type:'string'},
			{name:'objId',type:'string'},
			{name:'execStaffId',type:'string'},
			{name:'linkNo',type:'string'},
			{name:'objTag',type:'string'},
			{name:'objName',type:'string'},
			{name:'orderType',type:'string'},
			{name:'vmTaskName',type:'string'},
			{name:'objType',type:'string'},
			{name:'createTime',type:'string'},
			{name:'status',type:'int'},
			{name:'submitStaffName',type:'string'},
			{name:'finishTime',type:'string'},
			{name:'opinion',type:'string'},
			{name:'operator',type:'string'},
			{name:'templateId',type:'string'}]
	});
	
	var gridProxy = new Ext.data.proxy.Ajax({
			type:"ajax",
			model:workorderModel,
			url:'<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.csc.common.web.WorkorderListAction&action=getHisToryTrack&uid=<%=user.getUserAccount()%>&objId='+ objId +'&objType='+objType,
			reader:{
				root:"data",
				type:"json"
			}
		});
	var gridStore = Ext.create('Ext.data.Store',{
		model:workorderModel,
		proxy:gridProxy
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
		height: screenHeight,
	    width: screenWidth,
		viewConfig:{
			forctFit:true,
			stripeRows:true
		},
		store: gridStore,
		selType:'rowmodel',
		listeners:{
		},
		columns:[
				new Ext.grid.RowNumberer(),
				{header: "工单ID", width:100, sortable: true, dataIndex: 'orderId',hidden:true},
				{header: "业务ID", width:100, sortable: true, dataIndex: 'objId',hidden:true},
        		{header: "环节编号", width:100, sortable: true, dataIndex: 'linkNo',hidden:true},
        		{header: "编号", width:150, sortable: true, dataIndex: 'objTag',hidden:true},
        		{header: "名称", width:250, sortable: true, dataIndex: 'objName',hidden:true},
        		{header: "工单类型", width:100, sortable: true, dataIndex: 'orderType',hidden:true},
        		{header: "环节名称", width:100, sortable: true, dataIndex: 'vmTaskName'},
        		{header: "类型", width:100, sortable: true, dataIndex: 'objType',hidden:true},
        		{header: "创建时间", width:140, sortable: true, dataIndex: 'createTime'},
        		{header: "完成时间", width:140, sortable: true, dataIndex: 'finishTime'},
        		{header: "工单处理人", width:100,sortable: true, dataIndex: 'operator'},
        		{header: "工单状态", width:100, sortable: true, dataIndex: 'status',renderer: function (value, cellmeta, record) {
                    try {
                        var store = Ext.data.StoreManager.lookup("mapStore");
                        store.clearFilter(true);
                        store.filter("categoryName", "工单状态");
                        return store.findRecord("value",value).getData().show + "";
                    } catch (e) {
                        return "未指定"+value
                    };
                }},
        		{header: "处理意见", width:200, sortable: true, dataIndex: 'opinion'},
        		{header: "创建人", width:100, sortable: true, dataIndex: 'submitStaffName',hidden:true},
        		{header: "模板ID", width:100, sortable: true, dataIndex: 'templateId',hidden:true}
        	]
		});
	
		var tabs = new Ext.Panel({
			id: 'orderTab',
			width: screenWidth,
			frame: true,
			height: screenHeight,
			renderTo: Ext.getBody(),
			activeTab: 0,
			items: [workorderGrid]
		});
	});
	
</script>
</html>