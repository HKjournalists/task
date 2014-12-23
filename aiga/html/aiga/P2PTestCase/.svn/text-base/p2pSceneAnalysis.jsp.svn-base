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
	        url: '<%=request.getContextPath()%>/getAigaP2pBusiScenesBySubTaskId.do?subTaskId=${param.subTaskId}',
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
	AigaP2pBusiSceneStore.loadPage(1);


	/**
	*
	*端到端场景Grid
	*
	**/
	var AigaP2pBusiSceneGrid = Ext.create('Ext.grid.Panel',{
		id:'AigaP2pBusiSceneGrid',
        cls: 'ui-formPanel',
		//title:'用户体验测试场景',
        margins : '0 0 0 3',
		height: screenHeight,
        width: screenWidth,
        /**
		**编辑插件
		**/
		plugins:[
			Ext.create('Ext.grid.plugin.CellEditing', {
            triggerEvent:'cellclick'
        })],
        tbar:[
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
	             {name: 'busiName',type: 'string'},//
	             {name: 'sceneName',type: 'string'},
	             {name: 'analysisMethod',type: 'int'}, 
	             {name: 'scOrder',type: 'string'}, 
	             {name: 'isDelete',type: 'string' }, 
	             {name: 'createTime',type: 'string' }, 
	             {name: 'caseId',type: 'int'}, 
	             {name: 'caseName',type: 'string'}, 
	             { name: 'cause',type: 'string'},
	             { name: 'casuseType',type: 'int'},
	             { name: 'casuseTypeName',type: 'string'},
	             { name: 'caseId',type: 'int'},
	             { name: 'precondition',type: 'string'},
	             { name: 'operateDesc',type: 'string'},
	             { name: 'expectation',type: 'string'},
	             { name: 'caseName',type: 'string'},
	             { name: 'caseClass',type: 'string'},
	             { name: 'caseName',type: 'string'},
	             { name: 'createTime',type: 'string'},
	             { name: 'creatorId',type: 'int'},
	             { name: 'creatorName',type: 'string'}
	    ]
	});
	/**
	*
	*测试场景Store
	*
	**/
	var testSceneStore = new Ext.data.TreeStore({ 
		model: AigaP2pBusiSceneModel,  
		proxy: { 
			type: 'ajax',  
			url: '<%=request.getContextPath()%>/getAigaP2pBusiSceneTable.do?subTaskId='+subTaskId,
		extraParams:{  
		flag:'sec'
			}
		}, 
		root: {
			id:-1,
			text: '测试要素',
			expanded: true
		},
		reader: { 
			type: 'json', 
			root: 'children' 
		},
		listeners:{
			beforeload:function(){
			},
			load:function(){
			}
		}
	});  
	var testSceneGrid = Ext.create('Ext.tree.TreePanel',{
		tbar:Ext.create('Ext.Toolbar',{
			items:[
			       {xtype:'button',text: '管理用例',handler: function() {
		            	  var subTaskTag='';
		            	  MaskLoading();
							Ext.Ajax.request({
								url:'<%=request.getContextPath()%>/getAigaSubTaskBySubTaskId.do?subTaskId=${param.subTaskId}',
								params:{
									},
								success:function(response,config){
									var retJson=Ext.JSON.decode(response.responseText);
									if(retJson.success){
										MaskOver();
										subTaskTag=retJson.data.subTaskTag;
										 var caseManageWin = new top.Ext.window.Window({
						    				    id:'caseManageWin',
						    				    title : '用例管理',
						    				    width : 950,
						    				    height : 500,
						    				    modal : true,
						    				    resizable:false,
						    				    closeAction : 'destroy',
						    				    listeners:{
						    						destroy:function(window,eOpts){
						    							
						    						}
						    				    },
						    				    html:'<iframe id="frame" name="frame" scrolling="no" src="<%=request.getContextPath()%>/aiga/P2PTestCase/p2pTestCaseManage.jsp?subTaskTag='+subTaskTag+'" width="950" height="500"/>'
						    			   });
						            	  caseManageWin.show();
									}
								},
								failure:function(response,config){
									Ext.Msg.alert('提示','请求数据失败');
								}
							});
							MaskOver();
		            	 
		              }},
		              {xtype:'button',text: '关联场景',handler: function() {
		            	  var sceneWin = new top.Ext.window.Window({
		  				    id:'sceneWin',
		  				    title : '关联场景',
		  				    width : 950,
		  				    height : 450,
		  				    modal : true,
		  				    resizable:false,
		  				    closeAction : 'destroy',
		  				    listeners:{
		  						destroy:function(window,eOpts){
		  		                	var testSceneGrid =Ext.getCmp('testSceneGrid'); 
		  		                	testSceneGrid.getStore().load();;
		  						}
		  				    },
		  				    html:'<iframe id="frame_1" name="frame" src="<%=request.getContextPath()%>/aiga/P2PTestCase/p2pSceneRela.jsp?subTaskId='+subTaskId+'" width="950" height="423"/>'
		  			   });
		            	  sceneWin.show();
		              }}
			       ]
	}),
	id:'testSceneGrid',
	cls: 'ui-formPanel',
	title:'测试场景',
	border:0,
	minWidth: 1200 - 260 - 30,
	minHeight: 150,
	width: screenWidth - 20,
    height: screenHeight*0.8 - 10,
	rootVisible: false,
	viewConfig:{
		forctFit:true,
		stripeRows:true,
		listeners:{
		}
	},
	store: testSceneStore,
	listeners:{
		itemclick:function(_this, record, item, index,  e, eOpts){
			treePanelFocusBoolean=true;
		},
	
		beforeitemexpand:function(record,eOpts){  
			var tp = Ext.getCmp('testSceneGrid');  
			var root = tp.getStore().getProxy();  
				root.extraParams.treeId = record.raw.value;  
		}
	},
	columns:[
		{header: "id", width:100, sortable: true, dataIndex: 'scId',hidden:true},
		{header: "业务ID", width:100, sortable: true, dataIndex: 'busId',hidden:true},
		{header: "业务名称", width:100, sortable: true, dataIndex: 'busiName'},
		{header: "场景名称",xtype: 'treecolumn', width:100, sortable: true, dataIndex: 'sceneName',editor:{xtype:'textfield'}},
		/*******用例信息********/
		{header: "用例ID", width:150, sortable: true, dataIndex: 'caseId',hidden:true},
		{header: "用例名称", width:150, sortable: true, dataIndex: 'caseName'},
		{header: "前置条件", width:150, sortable: true, dataIndex: 'precondition'},
		{header: "期望结果", width:150, sortable: true, dataIndex: 'expectation'},
		{header: "操作描述", width:150, sortable: true, dataIndex: 'operateDesc'},
		
		{header: "分析方法", width:100, sortable: true, dataIndex: 'analysisMethod',hidden:true},
		{header: "场景顺序", width:100, sortable: true, dataIndex: 'scOrder',hidden:true},
		{header: "是否被删除", width:100, sortable: true, dataIndex: 'isDelete',hidden:true,renderer: function (value, cellmeta, record) {return value=='true'||value=='on'?'是':'否';}},
		{header: "原因", width:150, sortable: true, dataIndex: 'cause',hidden:true},
		{header: "创建时间", width:150, sortable: true, dataIndex: 'createTime',hidden:true},
		{header: "创建ID", width:100, sortable: true, dataIndex: 'creatorId',hidden:true},
		{header: "创建人", width:100, sortable: true, dataIndex: 'creatorName',hidden:true}
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
			items:[testSceneGrid]
		}]
	});
});
</script>
</html>