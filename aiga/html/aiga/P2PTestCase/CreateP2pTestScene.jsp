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
	var tbarSceneText=Ext.getCmp('tbarSceneName');
	var tbarSceneName=tbarSceneText.getValue();
	var tbarSceneCombobox=Ext.getCmp('tbarSceneCombobox');
	var tbarSceneId=tbarSceneCombobox.getValue();
	if(tbarSceneName==null||tbarSceneName.trim()==''){
		alert('请输入场景名称');tbarSceneText.focus(); return;
	}
	if((tbarSceneId==null||tbarSceneId==''||tbarSceneId==0)&&tbarSceneCombobox.getStore().find('sceneName',tbarSceneName+"")!=-1){
		alert('该业务下已经存在【'+tbarSceneName+'】这个场景');tbarSceneText.focus();return;
	}
	var records=Ext.getCmp('AigaP2pBusiCaseCollectionGrid').getSelectionModel().getSelection();
	tbarSceneName=encodeURI(encodeURI(tbarSceneName));
	var collectIds=new Array();
	for(var i=0,n=records.length;i<n;i++){
		collectIds.push(records[i].get('collectId'));
	}
	if(collectIds.length==0){
		alert('至少选择一个用例集');return;
	}
	MaskLoading();
	Ext.Ajax.request({
		url:'<%=request.getContextPath()%>/saveAigaP2pBusiScene.do?busiTwoLevelId=${param.busiTwoLevelId}',
		params:{scId:tbarSceneId,sceneName:tbarSceneName,collectIds:collectIds},
		success:function(response,config){
			var json=Ext.JSON.decode(response.responseText);
			tbarSceneCombobox.getStore().load();
			tbarSceneCombobox.setValue(json.data.scId);
			tbarSceneText.setReadOnly(true);
			Ext.data.StoreManager.lookup('AigaP2pSceneCollectionStore').load({params:{busiTwoLevelId:busiTwoLevelId,scId:json.data.scId}});
			Ext.data.StoreManager.lookup('AigaP2pBusiSceneStore').load({params:{busiTwoLevelId:busiTwoLevelId}});
			Ext.data.StoreManager.lookup('AigaP2pBusiCaseCollectionStore').load({params:{busiTwoLevelId:busiTwoLevelId,scId:json.data.scId}});
		},
		failure:function(response,config){
			Ext.Msg.alert('提示','请求数据失败');
		}
	});
	MaskOver();
}

function saveCollectIndex(flag){
	var tbarSceneText=Ext.getCmp('tbarSceneName');
	var tbarSceneCombobox=Ext.getCmp('tbarSceneCombobox');
	var AigaP2pSceneCollectionGrid=Ext.getCmp('AigaP2pSceneCollectionGrid');
	var tbarSceneId=tbarSceneCombobox.getValue();
	var store=AigaP2pSceneCollectionGrid.getStore();
	var collectIds=new Array();
	store.each(function(record){
		collectIds.push(record.get('collectId'));
	});
	MaskLoading();
	Ext.Ajax.request({
		url:'<%=request.getContextPath()%>/saveCollectIndex.do?busiTwoLevelId=${param.busiTwoLevelId}',
		params:{scId: tbarSceneId,collectIds:collectIds},
		success:function(response,config){
			var json=Ext.JSON.decode(response.responseText);
			if(json.success){
				if(flag==delCollect){
					Ext.getCmp('AigaP2pBusiCaseCollectionGrid').getStore().load({params:{busiTwoLevelId:busiTwoLevelId,scId:tbarSceneId}});
				}else{
					Ext.Msg.alert('提示','保存成功');
				}
					
			}
			store.load({params:{busiTwoLevelId:busiTwoLevelId,scId: tbarSceneId}});
			},
		failure:function(response,config){
			Ext.Msg.alert('提示','请求数据失败');
		}
	});
	MaskOver();
}
function delCollect(){
	var AigaP2pSceneCollectionGrid=Ext.getCmp('AigaP2pSceneCollectionGrid');
	var records=AigaP2pSceneCollectionGrid.getSelectionModel().getSelection();
	AigaP2pSceneCollectionGrid.getStore().remove(records);
	saveCollectIndex(delCollect);
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
	             {name: 'scOrder',type: 'string'}, 
	             {name: 'isDelete',type: 'string' }, 
	             {name: 'createTime',type: 'string' }, 
	             {name: 'caseId',type: 'int'}, 
	             {name: 'caseName',type: 'string'}, 
	             { name: 'cause',type: 'string'},
	             { name: 'casuseType',type: 'int'},
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
	    proxy: {
	        type: 'ajax',
	        url: '<%=request.getContextPath()%>/getAigaP2pBusiScene.do?busiTwoLevelId='+busiTwoLevelId,
	        reader: {
	            type: 'json',
	            root: 'data'
	        }
	    },
	    listeners:{
	  	  add :function( records, index, eOpts ){
	  		  //submitGridStore();
	  	  },
	  	  remove:function( records, index, eOpts ){}
	    }
	});
	AigaP2pBusiSceneStore.load({params:{busiTwoLevelId:busiTwoLevelId}});
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
		height: screenHeight*0.20,
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
		selType:'rowmodel',
		listeners : {
		},
		columns:[
		    new Ext.grid.RowNumberer({header: "序号",width :30}), 
			{header: "id", width:100, sortable: true, dataIndex: 'scId',hidden:true},
			{header: "业务ID", width:100, sortable: true, dataIndex: 'busId',hidden:true},
			{header: "场景名称", width:100, sortable: true, dataIndex: 'sceneName'},
			{header: "分析方法", width:100, sortable: true, dataIndex: 'analysisMethod',hidden:true},
			{header: "场景顺序", width:100, sortable: true, dataIndex: 'scOrder',hidden:true},
			{header: "是否被删除", width:100, sortable: true, dataIndex: 'isDelete',hidden:true,renderer: function (value, cellmeta, record) {return value=='true'||value=='on'?'是':'否';}},
			{header: "原因", width:150, sortable: true, dataIndex: 'cause',hidden:true},
			{header: "原因类型", width:100, sortable: true, dataIndex: 'casuseTypeName'},
			{header: "创建时间", width:150, sortable: true, dataIndex: 'createTime'},
			{header: "创建ID", width:100, sortable: true, dataIndex: 'creatorId',hidden:true},
			{header: "创建人", width:100, sortable: true, dataIndex: 'creatorName'}
    	]
	});
	
	  /**
	*
	*端到端用例集Model
	*
	**/
var AigaP2pBusiCaseCollectionModel = Ext.define('AigaP2pBusiCaseCollectionModel', {
    extend: 'Ext.data.Model',
    fields: [
             {name: 'collectId',type: 'string'},
             {name: 'busiTwoLevelId',type: 'int'},
             {name: 'baseBusiId',type: 'int'},
             {name: 'baseBusiName',type: 'string'},//
             {name: 'channelId',type: 'int'}, 
             {name: 'channelName',type: 'string'}, //
             {name: 'funId',type: 'int' }, 
             {name: 'sysName',type: 'string' }, 
             {name: 'caseId',type: 'int'}, 
             {name: 'caseName',type: 'string'}, 
             {name: 'remark',type: 'string'}, 
             {name: 'source',type: 'string'}, 
             { name: 'cause',type: 'string'},
             { name: 'casuseType',type: 'int'},
             { name: 'status',type: 'int'},
             { name: 'verifyStatus',type: 'int'},
             { name: 'verifyStatusName',type: 'string'},//
             { name: 'verifyResult',type: 'string'},
             { name: 'createTime',type: 'string'},
             { name: 'creatorId',type: 'int'},
             { name: 'creatorName',type: 'string'},
             { name: 'precondition',type: 'string'},
             { name: 'operateDesc',type: 'string'},
             { name: 'expectation',type: 'string'},
             { name: 'isDirty',type: 'int'},
             { name: 'caseClass',type: 'string'},
             { name: 'creatorName',type: 'string'}
    ]
});
/**
*
*端到端用例集Store
*
**/
  var AigaP2pBusiCaseCollectionStore = new Ext.data.Store({
      id: 'AigaP2pBusiCaseCollectionStore',
      model: AigaP2pBusiCaseCollectionModel,
      proxy: {
          type: 'ajax',
          url: '<%=request.getContextPath()%>/getP2pTestSceneCollect.do?flag=create&busiTwoLevelId='+busiTwoLevelId,
          reader: {
              type: 'json',
              root: 'data'
          }
      },
      listeners:{
    	  add :function( records, index, eOpts ){
    		  //submitGridStore();
    	  },
    	  remove:function( records, index, eOpts ){}
      }
  });
  AigaP2pBusiCaseCollectionStore.load({params:{busiTwoLevelId:busiTwoLevelId}});
  var AigaP2pSceneCollectionStore = new Ext.data.Store({
      id: 'AigaP2pSceneCollectionStore',
      model: AigaP2pBusiCaseCollectionModel,
      proxy: {
          type: 'ajax',
          url: '<%=request.getContextPath()%>/getP2pTestSceneCollect.do?flag=select&busiTwoLevelId='+busiTwoLevelId,
          reader: {
              type: 'json',
              root: 'data'
          }
      },
      listeners:{
    	  add :function( records, index, eOpts ){
    		  //submitGridStore();
    	  },
    	  remove:function( records, index, eOpts ){}
      }
  });
	/**
	*
	*端到端用例集Grid
	*
	**/
	var AigaP2pBusiCaseCollectionGrid = Ext.create('Ext.grid.Panel',{
		id:'AigaP2pBusiCaseCollectionGrid',
        cls: 'ui-formPanel',
		//title:'添加用例到场景',
        margins : '0 0 0 3',
		height: screenHeight*0.35,
        width: screenWidth,
        /**
		**编辑插件
		**/
		plugins:[
			Ext.create('Ext.grid.plugin.CellEditing', {
            triggerEvent:'cellclick'
        })],
        tbar:[
              {xtype:'combobox',valueField: 'scId',displayField: 'sceneName',id:'tbarSceneCombobox', emptyText: '请选择测试场景',width: 150,labelWidth: 60,
            	  store: Ext.create('Ext.data.Store', {fields: ['sceneName', 'scId'],autoLoad:true,
            		  listeners:{
            			  load:function(store,  records, successful, eOpts){
            				  store.insert(0,{scId:'',sceneName:'--请选择--'});
            			  }
            		  },
            		  proxy: {type: 'ajax',reader: {type: 'json',root: 'data'},url : '<%=request.getContextPath()%>/getP2pTestSceneCombobox.do?busiTwoLevelId=${param.busiTwoLevelId}&type=baseFunCombobox'}
            	  }),
				 listeners:{
					 select:function( combo, records, eOpts ){
						 var tbarSceneName=Ext.getCmp('tbarSceneName');
						 var scId=combo.getValue();
						 var readOnyBoolean=!(scId==null||scId==''||scId==0);
						 tbarSceneName.setReadOnly(readOnyBoolean);
						 tbarSceneName.setValue(readOnyBoolean?records[0].get('sceneName'):'');
						 AigaP2pBusiCaseCollectionStore.load({params:{busiTwoLevelId:busiTwoLevelId,scId:scId}});
						 AigaP2pSceneCollectionStore.load({params:{busiTwoLevelId:busiTwoLevelId,scId:scId}});
					 }
				 }
					 },
              {xtype:'textfield',id:'tbarSceneName',fieldLabel:'场景名称:',emptyText: '请输入场景名称',width:200,labelWidth:70},
              {xtype:'label',width:0},
              {xtype:'button',text: '添加到场景',iconCls: 'add-button',handler: function() {add2Scene();}}
		],
		forctFit:true,
        stripeRows:true,
        loadMask:true, 
		store: AigaP2pBusiCaseCollectionStore,
		selType:'rowmodel',
		selModel:Ext.create('Ext.selection.CheckboxModel',{mode:"SIMPLE"}),
		listeners : {
		},
		columns:[
		     new Ext.grid.RowNumberer({header : "序号",  width : 30}), 
			{header: "id", width:100, sortable: true, dataIndex: 'collectId',hidden:true},
			{header: "二级业务ID", width:100, sortable: true, dataIndex: 'busiTwoLevelId',hidden:true},
			{header: "基础功能", width:100, sortable: true, dataIndex: 'baseBusiName'},
			{header: "渠道", width:100, sortable: true, dataIndex: 'channelName'},
			{header: "功能点Id", width:100, sortable: true, dataIndex: 'funId',hidden:true},
			{header: "功能点", width:100, sortable: true, dataIndex: 'sysName'},
			{header: "用例类型", width:100, sortable: true, dataIndex: 'caseClass',hidden:true},
			{header: "用例ID", width:100, sortable: true, dataIndex: 'caseId',hidden:true},
			{header: "用例", width:100, sortable: true, dataIndex: 'caseName'},
			{header: "前置条件", width:100, sortable: true, dataIndex: 'precondition'},
			{header: "操作描述", width:100, sortable: true, dataIndex: 'operateDesc'},
			{header: "期望结果", width:100, sortable: true, dataIndex: 'expectation'},
			{header: "备注", width:100, sortable: true, dataIndex: 'remark'},
			{header: "来源", width:150, sortable: true, dataIndex: 'source'},
			{header: "原因", width:150, sortable: true, dataIndex: 'cause'},
			{header: "原因类型", width:100, sortable: true, dataIndex: 'casuseTypeName'},
			{header: "评审状态", width:100, sortable: true, dataIndex: 'verifyStatusName'},
			{header: "评审结果", width:100, sortable: true, dataIndex: 'verifyResult'},
			{header: "是否性能测试", width:100, sortable: true, dataIndex: 'createTime'},
			{header: "创建ID", width:100, sortable: true, dataIndex: 'creatorId',hidden:true},
			{header: "创建人", width:100, sortable: true, dataIndex: 'creatorName'}
    	]
	});
	var AigaP2pSceneCollectionGrid = Ext.create('Ext.grid.Panel',{
		id:'AigaP2pSceneCollectionGrid',
        cls: 'ui-formPanel',
		//title:'用户体验场景用例集',
        margins : '0 0 0 3',
		height: screenHeight*0.39,
        width: screenWidth,
    	viewConfig:{
			//forctFit:true,
			stripeRows:true,
			plugins: {
				ptype: 'gridviewdragdrop'        
			},
			listeners:{
	        } 
		},
        /**
		**编辑插件
		**/
		plugins:[
			Ext.create('Ext.grid.plugin.CellEditing', {
            triggerEvent:'cellclick'
        })],
        tbar:[
			  {xtype:'button',text: '用例顺序',iconCls: 'save-button',handler: function() {saveCollectIndex();}},
			  {xtype:'button',text: '场景用例',iconCls: 'del-button',handler: function() {delCollect();}}
		],
		forctFit:true,
        stripeRows:true,
        loadMask:true, 
		store: AigaP2pSceneCollectionStore,
		selType:'rowmodel',
		listeners : {
		},
		columns:[
		     new Ext.grid.RowNumberer({header : "序号",  width : 30}), 
			{header: "id", width:100, sortable: true, dataIndex: 'collectId',hidden:true},
			{header: "二级业务ID", width:100, sortable: true, dataIndex: 'busiTwoLevelId',hidden:true},
			{header: "基础功能", width:100, sortable: true, dataIndex: 'baseBusiName'},
			{header: "渠道", width:100, sortable: true, dataIndex: 'channelName'},
			{header: "功能点Id", width:100, sortable: true, dataIndex: 'funId',hidden:true},
			{header: "功能点", width:100, sortable: true, dataIndex: 'sysName'},
			{header: "用例类型", width:100, sortable: true, dataIndex: 'caseClass',hidden:true},
			{header: "用例ID", width:100, sortable: true, dataIndex: 'caseId',hidden:true},
			{header: "用例", width:100, sortable: true, dataIndex: 'caseName'},
			{header: "前置条件", width:100, sortable: true, dataIndex: 'precondition'},
			{header: "操作描述", width:100, sortable: true, dataIndex: 'operateDesc'},
			{header: "期望结果", width:100, sortable: true, dataIndex: 'expectation'},
			{header: "备注", width:100, sortable: true, dataIndex: 'remark'},
			{header: "来源", width:150, sortable: true, dataIndex: 'source'},
			{header: "原因", width:150, sortable: true, dataIndex: 'cause'},
			{header: "原因类型", width:100, sortable: true, dataIndex: 'casuseTypeName'},
			{header: "评审状态", width:100, sortable: true, dataIndex: 'verifyStatusName'},
			{header: "评审结果", width:100, sortable: true, dataIndex: 'verifyResult'},
			{header: "是否性能测试", width:100, sortable: true, dataIndex: 'createTime'},
			{header: "创建ID", width:100, sortable: true, dataIndex: 'creatorId',hidden:true},
			{header: "创建人", width:100, sortable: true, dataIndex: 'creatorName'}
    	]
	});
	//Main Div
	Ext.create('Ext.panel.Panel',{
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
		items: [{
			region: 'center',
			id:'mainItems',
			items:[AigaP2pBusiCaseCollectionGrid,AigaP2pSceneCollectionGrid,AigaP2pBusiSceneGrid]
		}]
	});
});
</script>
</html>