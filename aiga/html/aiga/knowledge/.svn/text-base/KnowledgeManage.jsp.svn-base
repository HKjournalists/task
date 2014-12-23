<!DOCTYPE HTML>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
  <head>
    <title>知识点管理</title>
  </head>
  
  <body>
  	<div id="base"></div>
  </body>
  <script type="text/javascript">
  	Ext.onReady(function(){
        Ext.QuickTips.init();
        Ext.tip.QuickTipManager.init();
        var knowledgeType = new Ext.data.Store({
			autoLoad: true,
		 	id: 'knowledgeType',
		    fields: ['value','show'],
		    proxy: {
			   	type: 'ajax',
		        url: '<%=request.getContextPath()%>/getSysParam.do?category=knowledge_type'+'&_='+(new Date()).getTime(),
		        reader: {
		        	type: 'json',
		        	root: 'data'
		        }
		   }
		});
        Ext.define('Knowledge',{
        	extend: 'Ext.data.Model',
        	fields:[
        		{name:'knowledgeId', type:'int', convert: null},
        		{name:'sysName', type:'string'},
        		{name:'subSysName', type:'string'},
        		{name:'moduleName', type:'string'},
        		{name:'knowledgeName', type:'string'},
        		{name:'knowledgeType', type:'int', convert: null},
        		{name:'knowledgeDesc', type:'string'}
        	]
        });
        
        var knowledgeGridStore = new Ext.data.Store({
        	model: 'Knowledge',
        	id: 'knowledgeGridStore',
        	proxy: {
				type: 'ajax',
			    reader: {
			        type: 'json',
			        root: 'data'
			    }
			}
        });
        
        var queryForm = new Ext.form.Panel({
        	id: 'queryKnowledgeForm',
        	title: '查询信息',
        	cls: 'ui-formPanel',
        	renderTo: Ext.get('base'),
        	width: 960,
  			defaults: {margins: '5 0 0 0'},
  			layout: 'vbox',
  			items:[
				{
				    xtype: 'fieldcontainer',
				    layout: 'hbox',
				    defaultType: 'textfield',
				    fieldDefaults: { 
				        labelAlign: 'right',
				        labelWidth: 100,
				        width: 230
				    },
				    items: [
				    	{name: 'knowledgeName',fieldLabel: '知识点名称'},
				        {name: 'sysName',fieldLabel:'系统名称'},
				        {name: 'subSysName',fieldLabel:'子系统名称'},
				       	{name: 'moduleName',fieldLabel: '模块名称'},
				       	{xtype: 'hidden',name: 'knowledgeId',fieldLabel: '知识点ID'}
				    ]
				},
				{
				    xtype: 'fieldcontainer',
				    layout: 'hbox',
				    defaultType: 'textfield',
				    fieldDefaults: { 
				        labelAlign: 'right',
				        labelWidth: 100,
				        width: 230
				    },
				    items: [
				    	{xtype:'combo',valueField:'value',displayField:'show',store:'knowledgeType',name: 'knowledgeType',fieldLabel: '知识点类型'},
				        {name: 'knowledgeDesc',fieldLabel:'知识点描述'},
				        {xtype:'button',margin:'0 0 0 35',width:60,height: 25,text:'查询',handler: function() {queryKnowledge();}}
				    ]
				}
  			]
        });
       	
        var knowledgeGrid = new Ext.grid.Panel({
        	id: 'knowledgeGrid',
        	title: '知识点列表',
        	cls: 'ui-formPanel',
        	renderTo: Ext.get('base'),
        	layout: 'fit',
        	width: 960,
        	height: 200,
        	store: 'knowledgeGridStore',
        	columns: [
        		{xtype:'rownumberer'},
        		{header:'系统名称',dataIndex:'sysName',field:'textfield',width:100},
        		{header:'子系统名称',dataIndex:'subSysName',field:'textfield',width:100},
        		{header:'模块名称',dataIndex:'moduleName',field:'textfield',width:100},
        		{header:'知识点名称',dataIndex:'knowledgeName',field:'textfield',width:100},
        		{header:'知识点类型',dataIndex:'knowledgeType',field:'textfield',width:100,editor:{xtype:'combo',displayField:'show', valueField:'value', store:'knowledgeType'},
        			renderer:function(value){
		    			var rec = Ext.StoreMgr.get('knowledgeType').find('value',value);
		    			if(rec == -1) {
		    				return '';
		    			}
		    			return Ext.StoreMgr.get('knowledgeType').getAt(rec).raw.show;
		    		}
        		},
        		{header:'知识点描述',dataIndex:'knowledgeDesc',field:'textfield',width:300}
        	],
        	listeners: {
        		dblclick: {
  					element: 'body',
  					fn: function() {
  						refreshKnowledge();
  					}
  				}
        	}
        });
        
        var knowledgeForm = new Ext.form.Panel({
        	id: 'knowledgeForm',
        	title: '编辑区域',
        	cls: 'ui-formPanel',
        	renderTo: Ext.get('base'),
        	bodyBorder: 0,
        	width: 960,
  			defaults: {margins: '5 0 0 0'},
  			layout: 'vbox',
  			items:[
 				{
				    xtype: 'fieldcontainer',
				    layout: 'hbox',
				    defaultType: 'textfield',
				    fieldDefaults: { 
				        labelAlign: 'right',
				        labelWidth: 100,
				        width: 230
				    },
				    items: [
				    	{name: 'knowledgeName',fieldLabel: '知识点名称'},
			            {name: 'sysName',fieldLabel:'系统名称'},
			            {name: 'subSysName',fieldLabel:'子系统名称'},
			        	{name: 'moduleName',fieldLabel: '模块名称'},
			        	{xtype: 'hidden',name: 'knowledgeId',fieldLabel: '知识点ID'}
				    ]
				},
				{
				    xtype: 'fieldcontainer',
				    layout: 'hbox',
				    defaultType: 'textfield',
				    fieldDefaults: { 
				        labelAlign: 'right',
				        labelWidth: 100,
				        width: 230
				    },
				    items: [
				    	{xtype:'combo',valueField:'value',displayField:'show',store:'knowledgeType',name: 'knowledgeType',fieldLabel: '知识点类型'},
			            {name: 'knowledgeDesc',fieldLabel:'知识点描述'}
				    ]
				}
  			]
        });
        var knowledgeFormSel = Ext.select('#knowledgeForm');
        knowledgeFormSel.insertHtml("afterBegin",'<div style="position: absolute; right: 100px; top: 0px; z-index: 2;"><a href="javascript:;" class="W_btn_a fn-mr-20" onclick="addKnowledge();return false;"><span>新增/重置</span></a></div>');
		knowledgeFormSel.insertHtml("afterBegin",'<div style="position: absolute; right: 40px; top: 0px; z-index: 2;"><a href="javascript:;" class="W_btn_b fn-mr-20" onclick="saveKnowledge();return false;"><span>保存</span></a></div>');
		knowledgeFormSel.insertHtml("afterBegin",'<div style="position: absolute; right: -16px; top: 0px; z-index: 2;"><a href="javascript:;" class="W_btn_c fn-mr-20" onclick="deleteKnowledge();return false;"><span>删除</span></a></div>');
        
    });
    
    function queryKnowledge() {
    	var sysName = Ext.getCmp('queryKnowledgeForm').getForm().findField('sysName').getValue();
    	var subSysName = Ext.getCmp('queryKnowledgeForm').getForm().findField('subSysName').getValue();
    	var moduleName = Ext.getCmp('queryKnowledgeForm').getForm().findField('moduleName').getValue();
    	var knowledgeName = Ext.getCmp('queryKnowledgeForm').getForm().findField('knowledgeName').getValue();
    	var knowledgeType = Ext.getCmp('queryKnowledgeForm').getForm().findField('knowledgeType').getValue();
    	
    	Ext.getCmp('knowledgeGrid').getStore().load({
    		url:'<%=request.getContextPath()%>/getKnowledgeByCon.do',
  			params:{sysName:sysName,subSysName:subSysName,moduleName:moduleName,knowledgeName:knowledgeName,
  				knowledgeType:knowledgeType},
  			success: function(form, action) {
  				
			}
    	});
    }
    
    function refreshKnowledge() {
    	var curSel = Ext.getCmp('knowledgeGrid').getSelectionModel().getSelection();
    	if(curSel == null || curSel.length == 0) {
    		return;
    	}
    	var knowledgeId = curSel[0].get('knowledgeId');
    	
    	Ext.getCmp('knowledgeForm').getForm().load({
    		url:'<%=request.getContextPath()%>/getKnowledgeById.do',
  			params:{knowledgeId:knowledgeId},
  			success: function(form, action) {
  				
			}
    	});
    }
    
    function addKnowledge() {
    	Ext.getCmp('knowledgeForm').getForm().reset();
    }
    
    function saveKnowledge() {
    	MaskLoading();
    	Ext.getCmp('knowledgeForm').getForm().submit({
    		url:'<%=request.getContextPath()%>/saveKnowledge.do',
    		method: 'POST',
  			success: function(response, config) {
    	MaskOver();
  				Ext.MessageBox.alert('提示','数据保存成功!');
  				addKnowledge();
				queryKnowledge();
			}
    	});
    }
    
    function deleteKnowledge() {
    	var knowledgeId = Ext.getCmp('knowledgeForm').getForm().findField('knowledgeId').getValue();
    	if(knowledgeId == null || knowledgeId == "") {
    		Ext.MessageBox.alert('提示','请先双击列表以刷新数据');
    		return;
    	}
    	MaskLoading();
    	$.ajax({
    		async: false,
    		url:'<%=request.getContextPath()%>/deleteKnowledge.do',
    		type: 'POST',
    		data: 'knowledgeId='+knowledgeId,
    		dataType: 'json',
  			success: function(json) {
  				Ext.MessageBox.alert('提示','数据删除成功!');
  				addKnowledge();
				queryKnowledge();
			}
    	});
    	MaskOver();
    }
    
  </script>
</html>
