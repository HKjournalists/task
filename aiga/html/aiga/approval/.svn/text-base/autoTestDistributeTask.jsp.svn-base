<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<%
	String caseId = request.getParameter("caseId");
%>
<html>
<head>
<title>自动化开发任务派发</title>
</head>
<body id="autoTesttDistributeTask"></body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
Ext.onReady(function(){
	//查询区域
	var testCaseSearchForm = top.Ext.create('Ext.form.Panel',{
		id:'testCaseSearchForm',
		width:screenWidth,
		height:screenHeight*0.1,
		title:'自动化任务查询',
        cls: 'ui-formPanel',
		layout: { 
			type: 'vbox'
		},
		bodyBorder: 0, 
		fieldDefaults: { 
			labelAlign: 'right', 
			labelWidth: 60, 
			labelStyle: 'font-weight:bold' 
		}, 
		defaults: { 
			 margins: '5 0 0 0' 
		}, 
		items: [{
			xtype: 'fieldcontainer', 
		    labelStyle: 'font-weight:bold;padding:0',
		    layout: 'hbox',
		    defaultType: 'textfield',
		    fieldDefaults: {
		    	labelAlign: 'right'
		    },
		    items: [{
		    	name:'caseName',
		    	xtype:'textfield',
		    	fieldLabel: '用例名称' 
		    },{
		    	name:'createTime',
		    	xtype:'datefield',
		    	fieldLabel: '任务创建时间' 
		    },{
		    	name:'linkNo',
		    	xtype:'textfield',
		    	fieldLabel: '任务状态' 
		    },{
		    	xtype:'button',
		    	text:'查询',
		    	handler:function(){
		    	
		    	}
		    }] 
		 }]
	});
	
	var caseWorkorderModel = Ext.regModel("caseWorkorderModel",{
		fields:[
			{name:'orderId',type:'string'},
			{name:'caseId',type:'string'},
			{name:'execStaffId',type:'string'},
			{name:'execStaffCode',type:'string'},
			{name:'execTime',type:'string'},
			{name:'createTime',type:'string'},
			{name:'linkNo',type:'string'},
			{name:'linkId',type:'string'},
			{name:'remark',type:'string'},
			{name:'status',type:'string'},
			{name:'result',type:'string'},
			{name:'caseName',type:'string'}
		]
	});
	
	var caseWorkorderProxy = new Ext.data.proxy.Ajax({
		type:"ajax",
		model:caseWorkorderModel,
		url:'',
		reader:{
			root:"data",
			type:"json"
		}
	});
	
	var caseWorkorderStore = Ext.create('Ext.data.Store',{
		model:caseWorkorderModel,
		proxy:caseWorkorderProxy
	});
	
	//caseWorkorderStore.load({params:{elemId:elemId}});
	
	var caseWorkorderGrid = top.Ext.create('Ext.grid.Panel',{
		id:'caseWorkorderGrid',
	    cls: 'ui-formPanel',
		title:'用例开发任务',
		border:0,
		height: screenHeight*0.9,
	    width: screenWidth,
		viewConfig:{
			forctFit:true,
			stripeRows:true
		},
		store:caseWorkorderStore,
		selModel:top.Ext.create("Ext.selection.CheckboxModel",{checkOnly : true,ignoreRightMouseSelection : true}),
		columns:[
			new top.Ext.grid.RowNumberer(),
			{header:"主键",width:100,dataIndex:"orderId",sortable:true,hidden:true},
			{header:"外键",width:100,dataIndex:"caseId",sortable:true,hidden:true},
			{header:"用例名称",width:200,dataIndex:"caseName",sortable:true},
			{header:"处理人ID",width:100,dataIndex:"execStaffId",sortable:true,hidden:true},
			{header:"处理人CODE",width:200,dataIndex:"execStaffCode",sortable:true},
			{header:"处理时间",width:200,dataIndex:"execTime",sortable:true},
			{header:"任务创建时间",width:200,dataIndex:"createTime",sortable:true},
			{header:"任务环节",width:200,dataIndex:"linkNo",sortable:true},
			{header:"环节ID",width:200,dataIndex:"linkId",sortable:true},
			{header:"备注",width:200,dataIndex:"remark",sortable:true},
			{header:"任务状态",width:200,dataIndex:"status",sortable:true},
			{header:"审批结果",width:200,dataIndex:"result",sortable:true}
		]
	});
	
	Ext.create('Ext.panel.Panel', {
		renderTo: Ext.get("autoTesttDistributeTask"),
		width: screenWidth,
		height: screenHeight,
		bodyBorder:0,
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
			items:[testCaseSearchForm,caseWorkorderGrid]
		}]
	});
});
</script>
</html>