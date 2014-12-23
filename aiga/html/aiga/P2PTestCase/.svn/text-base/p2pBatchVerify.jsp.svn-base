<!DOCTYPE HTML>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");%>
<%@ include file="/aiga/common/common.jsp" %>
<html>
<head>
	<title></title>
</head>
  
<body>
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth - 20;
var screenHeight = document.documentElement.clientHeight - 10;
var busiOneLevelId = '${param.busiOneLevelId}';
var busiTwoLevelId = '${param.busiTwoLevelId}';
var creatorId = '<%=user.getUserId()%>';
var creatorName = '<%=user.getUserName()%>';
var required = '<span style="color:red;font-weight:bold" data-qtip="Required">*</span>';
function add2Scene(){
	var records=Ext.getCmp('AigaP2pBusiCaseCollectionGrid').getSelectionModel().getSelection();
}
Ext.onReady(function() {
	Ext.QuickTips.init();
	Ext.tip.QuickTipManager.init();
	
	  /**
	*
	*用例Model
	*
	**/
	var AigaCaseModel = Ext.define('AigaCaseModel', {
	      extend: 'Ext.data.Model',
	      fields: [
	               {name: 'caseId',type: 'int'},
	               {name: 'caseName',type: 'string'},
	               {name: 'caseDesc',type: 'string'},
	               {name: 'precondition',type: 'string'},
	               {name: 'expectation',type: 'string'},
	               {name: 'operateDesc',type: 'string'},
	               {name: 'source',type: 'string'},
	               {name: 'remark',type: 'string'},
	               {name: 'createTime',type: 'string'},
	               {name: 'creatorId',type: 'int'},
	               {name: 'creatorName',type: 'string'},
	               {name: 'cause',type: 'string' }, 
	               {name: 'causeType',type: 'int'}, 
	               {name: 'status',type: 'int'}, 
	               {name: 'verifyStatus',type: 'int'}, 
	               {name: 'isDirty',type: 'int'}, 
	               {name: 'verifyResult',type: 'string'}, 
	               {name: 'caseClass',type: 'string'}
	      ]
	  });
	/**
	*
	*端到端功能点Model
	*
	**/
	var AigaP2pFunctionPointModel = Ext.define('AigaP2pFunctionPointModel', {
	      extend: 'Ext.data.Model',
	      fields: [
	               {name: 'funId',type: 'int'},
	               {name: 'sysName',type: 'string'},
	               {name: 'createTime',type: 'string'},
	               {name: 'updateTime',type: 'string'}, 
	               {name: 'cause',type: 'string' }, 
	               {name: 'causeType',type: 'int'}, 
	               {name: 'remark',type: 'string'}, 
	               {name: 'operatorId',type: 'string'}, 
	               { name: 'operatorName',type: 'string'},
	               { name: 'creatorId',type: 'int'},
	               { name: 'creatorName',type: 'string'}
	      ]
	  });
	  /**
	*
	*端到端场景Model
	*
	**/
	var AigaP2pBusiSceneModel = Ext.define('AigaP2pBusiSceneModel', {
	    extend: 'Ext.data.Model',
	    fields: [
	             {name: 'scId',type: 'string'},
	             {name: 'busiId',type: 'int'},
	             {name: 'busiName',type: 'int'},//
	             {name: 'sceneName',type: 'string'},
	             {name: 'analysisMethod',type: 'int'}, 
	             {name: 'secOrder',type: 'string'}, 
	             {name: 'isDelete',type: 'string' }, 
	             {name: 'createTime',type: 'string' }, 
	             {name: 'caseId',type: 'int'}, 
	             {name: 'caseName',type: 'string'}, 
	             { name: 'cause',type: 'string'},
	             { name: 'casuseType',type: 'int'},
	             { name: 'verifyStatus',type: 'int'},
	             { name: 'verifyStatusName',type: 'string'},
	             { name: 'casuseTypeName',type: 'string'},
	             { name: 'createTime',type: 'string'},
	             { name: 'creatorId',type: 'int'},
	             { name: 'creatorName',type: 'string'}
	    ]
	});
	  
	  
	/**
	*
	*端到端用例Store
	*
	**/
	var AigaP2pCaseStore = new Ext.data.Store({
	  id: 'AigaP2pCaseStore',
	  model: AigaCaseModel,
	  pageSize: 20,
	  proxy: {
	      type: 'ajax',
	      url: '<%=request.getContextPath()%>/getAigaP2pCaseTempUnVerify.do',
	        reader: {
	            type: 'json',
	            root: 'data',
	            totalProperty:'total'
	        }
	    },
	    listeners:{
	    	beforeload:function( store,operation,eOpts ){
	    		var dateTime=Ext.getCmp("searchTime");//上线时间
	    		var planTagSearch=Ext.getCmp("searchPlanTag");//计划编号
	    		var bigTypeSearch=Ext.getCmp("searchBigType");//系统大类
	    		var planTypeSearch=Ext.getCmp("searchPlanType");//上线类型
	    		var planNameSearch=Ext.getCmp("searchPlanName");//计划名称
	    		var planStatusSearch=Ext.getCmp("searchPlanStatus");//计划状态
	    		Ext.apply(
	    				store.proxy.extraParams, {
	    				}      
	    		)
	    	}
	    }
	});
	AigaP2pCaseStore.loadPage(1);
	/**
	*
	*端到端功能点Store
	*
	**/
	var AigaP2pFunctionPointStore = new Ext.data.Store({
	  id: 'AigaP2pFunctionPointStore',
	  model: AigaP2pFunctionPointModel,
	  pageSize: 20,
	  proxy: {
	      type: 'ajax',
	      url: '<%=request.getContextPath()%>/getAigaP2pFunctionPointUnVerify.do',
	      reader: {
	          type: 'json',
	          root: 'data',
	          totalProperty:'total'
	      }
	  },
	  listeners:{
	  }
	});
	AigaP2pFunctionPointStore.load();
	/**
	*
	*端到端场景Store
	*
	**/
	var AigaP2pBusiSceneStore = new Ext.data.Store({
	    id: 'AigaP2pBusiSceneStore',
	    model: AigaP2pBusiSceneModel,
	    pageSize: 20,
	    proxy: {
	        type: 'ajax',
	        url: '<%=request.getContextPath()%>/getAigaP2pBusiSceneUnVerify.do',
	        reader: {
	            type: 'json',
	            root: 'data',
	            totalProperty:'total'
	        }
	    },
	    listeners:{
	  	  add :function( records, index, eOpts ){
	  		  //submitGridStore();
	  	  },
	  	  remove:function( records, index, eOpts ){}
	    }
	});
	AigaP2pBusiSceneStore.load();
	
	/**
	*
	*端到端用例Grid
	*
	**/
	var AigaP2pCaseGrid = Ext.create('Ext.grid.Panel',{
		id:'AigaP2pCaseGrid',
	    cls: 'ui-formPanel',
	    margins : '0 0 0 3',
		height: screenHeight*0.29,
		title:'用户体验测试用例库审核',
	    width: screenWidth,
		forctFit:true,
	    stripeRows:true,
	    loadMask:true, 
		store: AigaP2pCaseStore,
		bbar: Ext.create('Ext.PagingToolbar', { 
				store: AigaP2pCaseStore, 
				displayInfo: true, 
				displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
				emptyMsg: "没有数据"
		}),
		selType:'rowmodel',
		selModel:Ext.create('Ext.selection.CheckboxModel',{mode:'SIMPLE'}),
        tbar:[
              {xtype:'button',text: '提交审核',iconCls: 'save-button',handler: function() {
            	  var grid=Ext.getCmp('AigaP2pCaseGrid');
            	  var store=grid.getStore();
            	  var selections = grid.getSelectionModel().getSelection();
            	  if(selections.length==0){
            		  alert('请选择用例');return;
            	  }
            	  var caseIds=new Array();
            	  for(var i=0,n=selections.length;i<n;i++){
            		  caseIds.push(selections[i].get('caseId'));
            	  }
            	  MaskLoading();
					Ext.Ajax.request({
						url:'<%=request.getContextPath()%>/verifyAigaP2pCases.do',
						params:{
							caseIds: caseIds
							},
						success:function(response,config){
								store.loadPage(1);
						},
						failure:function(response,config){
							Ext.Msg.alert('提示','请求数据失败');
						}
					});
					MaskOver();
              }}
		],
		listeners : {
		},
		columns:[
			  	new Ext.grid.RowNumberer({header : "序号",  width : 40}), 
				{header: "用例Id", width:100, sortable: true, dataIndex: 'funId',hidden:true},
				{header: "用例名称", width:250, sortable: true, dataIndex: 'caseName'},
				{header: "前置条件", width:350, sortable: true, dataIndex: 'precondition'},
				{header: "操作描述", width:350, sortable: true, dataIndex: 'operateDesc'},
				{header: "期望结果", width:350, sortable: true, dataIndex: 'expectation'},
				{header: "用例描述", width:250, sortable: true, dataIndex: 'caseDesc'},
				{header: "创建人", width:100, sortable: true, dataIndex: 'creatorName',hidden:true},
				{header: "创建日期", width:100, sortable: true, dataIndex: 'createTime',hidden:true}
	   	]
	});
	
	/**
	*
	*端到端功能点Grid
	*
	**/
	var AigaFunctionPointGrid = Ext.create('Ext.grid.Panel',{
		id:'AigaFunctionPointGrid',
        cls: 'ui-formPanel',
        margins : '0 0 0 3',
		height: screenHeight*0.29,
		title:'用户体验测试库功能点',
        width: screenWidth,
		forctFit:true,
        stripeRows:true,
        loadMask:true, 
		store: AigaP2pFunctionPointStore,
		bbar: Ext.create('Ext.PagingToolbar', { 
			store: AigaP2pFunctionPointStore, 
			displayInfo: true, 
			displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
			emptyMsg: "没有数据"
		}),
		selType:'rowmodel',
		selModel:Ext.create('Ext.selection.CheckboxModel',{mode:'SIMPLE'}),
        tbar:[
              {xtype:'button',text: '提交审核',iconCls: 'save-button',handler: function() {
            	  var grid=Ext.getCmp('AigaFunctionPointGrid');
            	  var store=grid.getStore();
            	  var selections = grid.getSelectionModel().getSelection();
            	  if(selections.length==0){
            		  alert('请选择功能点');return;
            	  }
            	  var funIds=new Array();
            	  for(var i=0,n=selections.length;i<n;i++){
            		  funIds.push(selections[i].get('funId'));
            	  }
            	  MaskLoading();
					Ext.Ajax.request({
						url:'<%=request.getContextPath()%>/verifyAigaP2pFunctionPoints.do',
						params:{
							funIds: funIds
							},
						success:function(response,config){
								store.loadPage(1);
						},
						failure:function(response,config){
							Ext.Msg.alert('提示','请求数据失败');
						}
					});
					MaskOver();
              }}
		],
		listeners : {
		},
		columns:[
			 new Ext.grid.RowNumberer({header : "序号",  width : 40}), 
			{header: "功能点Id", width:100, sortable: true, dataIndex: 'funId',hidden:true},
			{header: "功能点", width:150, sortable: true, dataIndex: 'sysName'},
			{header: "原因", width:150, sortable: true, dataIndex: 'cause',hidden:true},
			{header: "评审状态", width:100, sortable: true, dataIndex: 'verifyStatusName'},
			{header: "原因类型", width:100, sortable: true, dataIndex: 'casuseTypeName'},
			{header: "创建时间", width:150, sortable: true, dataIndex: 'createTime'},
			{header: "创建ID", width:100, sortable: true, dataIndex: 'creatorId',hidden:true},
			{header: "创建人", width:100, sortable: true, dataIndex: 'creatorName'}
    	]
	});
	/**
	*
	*端到端场景Grid
	*
	**/
	var AigaP2pBusiSceneGrid = Ext.create('Ext.grid.Panel',{
		id:'AigaP2pBusiSceneGrid',
        cls: 'ui-formPanel',
		title:'用户体验测试场景审核',
        margins : '0 0 0 3',
		height: screenHeight*0.39,
        width: screenWidth,
        /**
		**编辑插件
		**/
		plugins:[
			Ext.create('Ext.grid.plugin.CellEditing', {
            triggerEvent:'cellclick'
        })],
        tbar:[
              {xtype:'button',text: '提交审核',iconCls: 'save-button',handler: function() {
            	  var grid=Ext.getCmp('AigaP2pBusiSceneGrid');
            	  var store=grid.getStore();
            	  var selections = grid.getSelectionModel().getSelection();
            	  if(selections.length==0){
            		  alert('请选择场景');return;
            	  }
            	  var scIds=new Array();
            	  for(var i=0,n=selections.length;i<n;i++){
            		  scIds.push(selections[i].get('scId'));
            	  }
            	  MaskLoading();
					Ext.Ajax.request({
						url:'<%=request.getContextPath()%>/verifyAigaP2pBusiScenes.do',
						params:{
							scIds: scIds
							},
						success:function(response,config){
								store.loadPage(1);
						},
						failure:function(response,config){
							Ext.Msg.alert('提示','请求数据失败');
						}
					});
					MaskOver();
              }}
		],
		forctFit:true,
        stripeRows:true,
        loadMask:true, 
		store: AigaP2pBusiSceneStore,
		bbar: Ext.create('Ext.PagingToolbar', { 
			store: AigaP2pBusiSceneStore, 
			displayInfo: true, 
			displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
			emptyMsg: "没有数据"
		}),
		selType:'rowmodel',
		selModel:Ext.create('Ext.selection.CheckboxModel',{mode:'SIMPLE'}),
		listeners : {
		},
		columns:[
		    new Ext.grid.RowNumberer({header: "序号",width :30}), 
			{header: "id", width:100, sortable: true, dataIndex: 'scId',hidden:true},
			{header: "业务ID", width:100, sortable: true, dataIndex: 'busId',hidden:true},
			{header: "场景名称", width:100, sortable: true, dataIndex: 'sceneName'},
			{header: "分析方法", width:100, sortable: true, dataIndex: 'analysisMethod',hidden:true},
			{header: "场景顺序", width:100, sortable: true, dataIndex: 'secOrder',hidden:true},
			{header: "是否被删除", width:100, sortable: true, dataIndex: 'isDelete',hidden:true,renderer: function (value, cellmeta, record) {return value=='true'||value=='on'?'是':'否';}},
			{header: "原因", width:150, sortable: true, dataIndex: 'cause',hidden:true},
			{header: "评审状态", width:100, sortable: true, dataIndex: 'verifyStatusName'},
			{header: "原因类型", width:100, sortable: true, dataIndex: 'casuseTypeName'},
			{header: "创建时间", width:150, sortable: true, dataIndex: 'createTime'},
			{header: "创建ID", width:100, sortable: true, dataIndex: 'creatorId',hidden:true},
			{header: "创建人", width:100, sortable: true, dataIndex: 'creatorName'}
    	]
	});

	//Main Div
	Ext.create('Ext.TabPanel',{
		minWidth: 1200-260,
		minHeight: 350,
		width: screenWidth,
	    height: screenHeight + 5,
	    renderTo: Ext.getBody(),
		minWidth: 1200 - 260 - 22,
		minHeight: 120,
		width: screenWidth - 10,
	    height: screenHeight,
	    cls:"ui-tab-bar",
		bodyCls:"ui-tab-body",
	    frame:true,
		activeTab: 0,
		listeners:{
		},
		items:[AigaP2pCaseGrid,AigaFunctionPointGrid,AigaP2pBusiSceneGrid]
	});
});
</script>
</html>