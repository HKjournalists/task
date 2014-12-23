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
var creatorId = '<%=user.getUserId()%>';
var creatorName = '<%=user.getUserName()%>';
var subTaskId='${param.subTaskId}';
var required = '<span style="color:red;font-weight:bold" data-qtip="Required">*</span>';
function add2Scene(){
	var records=Ext.getCmp('AigaP2pBusiCaseCollectionGrid').getSelectionModel().getSelection();
}
Ext.onReady(function() {
	Ext.QuickTips.init();
	Ext.tip.QuickTipManager.init();
	
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
	             {name: 'busiName',type: 'string'}, 
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
	*端到端场景Store
	*
	**/
	var AigaP2pBusiSceneStore = new Ext.data.Store({
	    id: 'AigaP2pBusiSceneStore',
	    model: AigaP2pBusiSceneModel,
	    pageSize: 20,
	    proxy: {
	        type: 'ajax',
	        url: '<%=request.getContextPath()%>/getAigaP2pBusiScenesByCondition.do?subTaskId=${param.subTaskId}',
	        reader: {
	            type: 'json',
	            root: 'data',
	            totalProperty:'total'
	        }
	    },
	    listeners:{
	    	beforeload:function( store,operation,eOpts ){
	    	},
	  	  add :function( records, index, eOpts ){
	  	  },
	  	  remove:function( records, index, eOpts ){}
	    }
	});
	AigaP2pBusiSceneStore.loadPage(1);
	/**
	*
	*端到端场景Store
	*
	**/
	var AigaP2pBusiSceneRelaStore = new Ext.data.Store({
	    id: 'AigaP2pBusiSceneRelaStore',
	    model: AigaP2pBusiSceneModel,
	    pageSize: 20,
	    proxy: {
	        type: 'ajax',
	        url: '<%=request.getContextPath()%>/getAigaP2pBusiScenesBySubTaskId.do?subTaskId=${param.subTaskId}',
	        reader: {
	            type: 'json',
	            root: 'data',
	            totalProperty:'total'
	        }
	    },
	    listeners:{
	    	beforeload:function( store,operation,eOpts ){
	    		
	    	},
	  	  add :function( records, index, eOpts ){
	  		  //submitGridStore();
	  	  },
	  	  remove:function( records, index, eOpts ){}
	    }
	});
	AigaP2pBusiSceneRelaStore.loadPage(1);
	/**
	*
	*端到端场景Grid
	*
	**/
	var AigaP2pBusiSceneGrid = Ext.create('Ext.grid.Panel',{
		id:'AigaP2pBusiSceneGrid',
        cls: 'ui-formPanel',
		title:'关联场景',
        margins : '0 0 0 3',
        height: screenHeight*.5,
        width: screenWidth,
        /**
		**编辑插件
		**/
		plugins:[
			Ext.create('Ext.grid.plugin.CellEditing', {
            triggerEvent:'cellclick'
        })],
        tbar:[
              {xtype:'button',text: '保存关联',iconCls: 'save-button',handler: function() {
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
						url:'<%=request.getContextPath()%>/saveP2pSceneSubTaskRela.do?subTaskId=${param.subTaskId}',
						params:{
							scIds: scIds
							},
						success:function(response,config){
								store.loadPage(1);
								Ext.data.StoreMgr.lookup('AigaP2pBusiSceneRelaStore').loadPage(1);
						},
						failure:function(response,config){
							Ext.Msg.alert('提示','请求数据失败');
						}
					});
					MaskOver();
              }},
              {xtype:'combobox',valueField: 'p2pBusiId',displayField: 'busiName',id:'AigaP2pBusiOneLevelCombox', emptyText: '请选择一级业务',width: 150,labelWidth: 60,
            	  listeners:{
            		  select:function( combo,records, eOpts ){
            			  var oneLevelBusiId=records[0].get('p2pBusiId');
            			  
            			  var AigaP2pBusiTwoLevelCombox=Ext.getCmp('AigaP2pBusiTwoLevelCombox');
            			  AigaP2pBusiTwoLevelCombox.setValue(null);
            			  var AigaP2pBusiTwoLevelStore=Ext.data.StoreMgr.lookup('AigaP2pBusiTwoLevelStore');
            			  AigaP2pBusiTwoLevelStore.load({params:{oneLevelBusiId:oneLevelBusiId}});
            		  }
            	  },
            	  store: Ext.create('Ext.data.Store', 
            			  {fields: ['busiName', 'p2pBusiId'],
            		  proxy: {type: 'ajax',reader: {type: 'json',root: 'data'},url : '<%=request.getContextPath()%>/getP2pBusiLevelCombox.do?flag=AigaP2pBusiOneLevel'},
            		  listeners:{
            			  load:function(store,records,successful,eOpts ){
            				  store.insert(0,{p2pBusiId:null,busiName:'--请选择--'});
            			  }
            		  }
            	  })
			 },
			 {xtype:'combobox',valueField: 'p2pBusiId',displayField: 'busiName',id:'AigaP2pBusiTwoLevelCombox', emptyText: '请选择二级业务',width: 150,labelWidth: 60,
           	  store: Ext.create('Ext.data.Store',
           			  {fields: ['busiName', 'p2pBusiId'],  id:'AigaP2pBusiTwoLevelStore',
           		  proxy: {type: 'ajax',reader: {type: 'json',root: 'data'},url : '<%=request.getContextPath()%>/getP2pBusiLevelCombox.do?flag=AigaP2pBusiTwoLevel'},
           		listeners:{
      			  load:function(store,records,successful,eOpts ){
      				  store.insert(0,{p2pBusiId:null,busiName:'--请选择--'});
      			  }
      		  }
           	  })
			 },
              {xtype:'button',text: '',tooltip:'查找场景',id:'searchBtn',iconCls: 'search-button',handler: function() {
            	  var grid=Ext.getCmp('AigaP2pBusiSceneGrid');
            	  var store=grid.getStore();
            	  store.on('beforeload',function(){
            		  var AigaP2pBusiTwoLevelId=Ext.getCmp('AigaP2pBusiTwoLevelCombox').getValue();
        	    		Ext.apply(
        	    				store.proxy.extraParams, {
        	    					AigaP2pBusiTwoLevelId :AigaP2pBusiTwoLevelId
        	    					} 
        	    		)
            	  });
            	  store.loadPage(1);
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
			{header: "二级业务", width:100, sortable: true, dataIndex: 'busiName'},
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
	/**
	*
	*端到端场景Grid
	*
	**/
	var AigaP2pBusiSceneRelaGrid = Ext.create('Ext.grid.Panel',{
		id:'AigaP2pBusiSceneRelaGrid',
        cls: 'ui-formPanel',
		title:'已经关联的场景',
        margins : '0 0 0 3',
		height: screenHeight*.5,
        width: screenWidth,
        /**
		**编辑插件
		**/
		plugins:[
			Ext.create('Ext.grid.plugin.CellEditing', {
            triggerEvent:'cellclick'
        })],
		forctFit:true,
        stripeRows:true,
        loadMask:true, 
        tbar:[
			{xtype:'button',text: '',iconCls: 'del-button',handler: function() {
			 	  var grid=Ext.getCmp('AigaP2pBusiSceneRelaGrid');
            	  var store=grid.getStore();
            	  var selections = grid.getSelectionModel().getSelection();
            	  if(selections.length==0){
            		  alert('请选择场景');return;
            	  }
            	  var scIds=new Array();
            	  for(var i=0,n=selections.length;i<n;i++){
            		  scIds.push(selections[i].get('scId'));
            	  }
            	  Ext.Msg.confirm('提示','是否删除该场景和业务的关联关系！',function(optional){
            			if(optional=='yes'){
            				  MaskLoading();
          					Ext.Ajax.request({
          						url:'<%=request.getContextPath()%>/delP2pSceneSubTaskRela.do?subTaskId=${param.subTaskId}',
          						params:{
          							scIds: scIds
          							},
          						success:function(response,config){
          							store.loadPage(1);
          							Ext.data.StoreMgr.lookup('AigaP2pBusiSceneStore').loadPage(1);
          						},
          						failure:function(response,config){
          							Ext.Msg.alert('提示','请求数据失败');
          						}
          					});
          					MaskOver();
            			}});
            	
			}}
		],
		store: AigaP2pBusiSceneRelaStore,
		bbar: Ext.create('Ext.PagingToolbar', { 
			store: AigaP2pBusiSceneRelaStore, 
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
			{header: "二级业务", width:100, sortable: true, dataIndex: 'busiName'},
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
	Ext.create('Ext.Panel',{
		minWidth: 1200-260,
		minHeight: 350,
		width: screenWidth,
	    height: screenHeight + 5,
	    renderTo: Ext.getBody(),
	    cls: 'ui-formPanel',
		bodyBorder:0,
		listeners:{
		},
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
		listeners:{
		},
		items:[{
			region: 'center',
			id:'mainItems',
			items:[AigaP2pBusiSceneGrid,AigaP2pBusiSceneRelaGrid]
		}]
	});
});
</script>
</html>