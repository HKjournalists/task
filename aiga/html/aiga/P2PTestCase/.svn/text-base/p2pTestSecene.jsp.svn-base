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
var treePanelFocusBoolean =false;
var required = '<span style="color:red;font-weight:bold" data-qtip="Required">*</span>';
function addP2pTestScene(){
	new top.Ext.window.Window({
	    id:'createP2pTestSceneWin',
	    title : '新建测试场景',
	    width : 950,
	    height : 600,
	    modal : true,
	    resizable:false,
	    closeAction : 'destroy',
	    listeners:{
	    	destroy:function( _this,eOpts ){
	    		//window.location.reload();
	    		treePanelFocusBoolean=false;
	    		Ext.getCmp('testSceneGrid').getStore().load({params:{busiTwoLevelId :busiTwoLevelId}});
	    	}
	    },
	    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/P2PTestCase/CreateP2pTestScene.jsp?busiTwoLevelId=${param.busiTwoLevelId}" width="950" height="600"/>'
		}).show();
}
function saveP2pTestScene(){
	if(!treePanelFocusBoolean){
		alert('请选择场景');return;
	}
	var testSceneGrid=Ext.getCmp('testSceneGrid');
	var records=testSceneGrid.getSelectionModel().getSelection();
	if(records==null||records.length!=1||records[0].get('scId')==null||records[0].get('scId')==''){alert('请至少选择一个场景');return;}
	var scId=records[0].get('scId');
	Ext.MessageBox.prompt('重命名【'+records[0].get('sceneName')+'】','请新的场景名称：',function(bu,txt){
		if(bu=='ok'){
			if(txt==records[0].get('sceneName')){
				alert('新场景名不能和之前的相同');return;
			}
			txt=encodeURI(encodeURI(txt));
			MaskLoading();
			Ext.Ajax.request({
				url:'<%=request.getContextPath()%>/updateScene.do?busiTwoLevelId=${param.busiTwoLevelId}',
				params:{scId:scId ,sceneName: txt},
				success:function(response,config){
					var json=Ext.JSON.decode(response.responseText);
					if(json.success){
						var rootNode = testSceneGrid.getStore().getNodeById(-1);
						testSceneGrid.getStore().load(rootNode);
						treePanelFocusBoolean=false;
						//testSceneGrid.getStore().load({params:{busiTwoLevelId:busiTwoLevelId}});
						//window.location.reload();
					}else{
						var message=json.message;
						if(message!=null&&message!=''){
							alert(message);
						}
					}
					//testSceneGrid.getStore().load({params:{busiTwoLevelId :busiTwoLevelId}});
				},
				failure:function(response,config){
					Ext.Msg.alert('提示','请求数据失败');
				}
			});
			MaskOver();
		}
	}); 
}
function delGridStore(){
	if(!treePanelFocusBoolean){
		alert('请选择场景');return;
	}
	var testSceneGrid=Ext.getCmp('testSceneGrid');
	var records=testSceneGrid.getSelectionModel().getSelection();
	var scIds=new Array();
	for(var i=0,n=records.length;i<n;i++){
		var scId= records[i].get('scId');
		if(scId==''||scId==null){
			break;
		}
		scIds.push(scId);
	}
	
	if(scIds.length==0){alert('请至少选择一个场景');return;}
	Ext.Msg.confirm('提示','是否删除该条?',function(optional){if(optional=='yes'){
		MaskLoading();
		Ext.Ajax.request({
			url:'<%=request.getContextPath()%>/delSceneByScIds.do?busiTwoLevelId=${param.busiTwoLevelId}',
			params:{scIds: scIds},
			success:function(response,config){
				var json=Ext.JSON.decode(response.responseText);
				if(json.success){
					Ext.Msg.alert('提示','删除成功');
					treePanelFocusBoolean=false;
					testSceneGrid.getStore().load({params:{busiTwoLevelId :busiTwoLevelId}});
				}
				},
			failure:function(response,config){
				Ext.Msg.alert('提示','请求数据失败');
			}
		});
		MaskOver();
	}});
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
			url: '<%=request.getContextPath()%>/getAigaP2pBusiSceneTable.do?busiTwoLevelId='+busiTwoLevelId,
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
					{xtype:'button',text: '测试场景',iconCls: 'add-button',handler: function() {addP2pTestScene();}},
					{xtype:'button',id:'renameSceneBtn',text: '重命名场景',iconCls: 'save-button',handler: function() {saveP2pTestScene();}},
					{xtype:'button',text: '场景',iconCls: 'del-button',handler: function() {delGridStore();}}
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
			items:[testSceneGrid]
		}]
	});
});
</script>
</html>