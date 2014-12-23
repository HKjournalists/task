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
var busiOneLevelId = ${param.busiOneLevelId};
var busiTwoLevelId = ${param.busiTwoLevelId};
function loadForm(){
	 MaskLoading();
	 Ext.getCmp('AigaP2pTestElemForm').getForm().load({
           params: {
           	busiTwoLevelId: busiTwoLevelId
           },
           url: '<%=request.getContextPath()%>/getAigaP2pTestElem.do',
           method: 'POST',
           success: function (form, action) {
        	   MaskOver();
           	var _baseFunctionIds=new Array();
           	var _channelIds=new Array();
       		var strBaseFunctionIds=action.result.data.baseFunctionIds;
       		var strChannelIds=action.result.data.channelIds;
       		if(strBaseFunctionIds!=''){
       			var baseFunctionIds=strBaseFunctionIds.split(',');
           		for(var i=0,n=baseFunctionIds.length;i<n;i++)_baseFunctionIds.push(parseInt(baseFunctionIds[i]));
           		Ext.getCmp('_baseFunctionIds').setValue(_baseFunctionIds);
       		}
       		if(strChannelIds!=''){
       			var channelIds=strChannelIds.split(',');
       			for(var i=0,n=channelIds.length;i<n;i++)_channelIds.push(parseInt(channelIds[i]));
               	Ext.getCmp('_channelIds').setValue(_channelIds);
       		}
           },
           failure: function (form, action) {
               Ext.Msg.alert('提示', '失败 ');
        	   MaskOver();
           }
           });
}
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.tip.QuickTipManager.init();

	
    var AigaP2pBusiCaseCollectionModel = Ext.define('AigaP2pBusiCaseCollectionModel', {
        extend: 'Ext.data.Model',
        fields: [
                 {name: 'collectId',type: 'int'},
                 {name: 'busiTwoLevelId',type: 'int'},
                 {name: 'baseBusiId',type: 'int'},
                 {name: 'channelId',type: 'int'}, 
                 {name: 'funId',type: 'int' }, 
                 {name: 'caseId',type: 'int'}, 
                 {name: 'remark',type: 'string'}, 
                 {name: 'source',type: 'string'}, 
                 { name: 'cause',type: 'int'},
                 { name: 'casuseType',type: 'int'},
                 { name: 'status',type: 'int'},
                 { name: 'verifyStatus',type: 'int'},
                 { name: 'verifyResult',type: 'string'},
                 { name: 'createTime',type: 'string'},
                 { name: 'creatorId',type: 'int'},
                 { name: 'creatorName',type: 'string'}
        ]
    });
	  var AigaP2pBusiCaseCollectionStore = new Ext.data.Store({
          id: 'AigaP2pBusiCaseCollectionStore',
          model: AigaP2pBusiCaseCollectionModel,
          proxy: {
              type: 'ajax',
              url: '<%=request.getContextPath()%>/getP2pBusiCaseCollection.do',
              reader: {
                  type: 'json',
                  root: 'data'
              }
          },
          listeners:{
          }
      });
		var p2pCaseCollectMapStore=new Ext.data.Store({
			storeId:'p2pCaseCollectMapStore',
			fields: ['value',  'show','group'],
		    proxy: {
		        type: 'ajax',
	        	url : '<%=request.getContextPath()%>/getP2pCaseCollectionCombox.do?busiTwoLevelId=${param.busiTwoLevelId}',
		        reader: {
					type:'json',
					root:'data'
		        }
		    },
		    listeners:{
		    	load:function(store, records, successful, eOpts ){
		    		AigaP2pBusiCaseCollectionStore.load({params:{busiTwoLevelId:busiTwoLevelId}});
		    		var AigaP2pChannelArray=new Array();
		    		for(var i=0,n= records.length;i<n;i++){
		    			var group=records[i].raw.group;
		    			if(group=='AigaP2pChannel'){
		    				AigaP2pChannelArray.push({show:records[i].raw.show,value:records[i].raw.value});
		    			}
		    			
		    		}
		    		var states = Ext.create('Ext.data.Store', {
				    fields: ['show', 'value'],
				    data : AigaP2pChannelArray
				});
		    		var p2pCaseCollectMapCombox=new Ext.form.ComboBox({
		    				  width: 250,
		    		          store: states,
		    		          labelAlign: 'right',
		    		          name: "bigType",
		    		          fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>系统大类",
		    		          allowBlank: false,
		    		          valueField: 'value',
		    		          displayField: 'show'
		    			});
		    			//Ext.getCmp('mainItems').add(p2pCaseCollectMapCombox);
		    	}
		    }
		});
		p2pCaseCollectMapStore.load({params:{busiTwoLevelId : busiTwoLevelId}});
		var AigaP2pBusiCaseCollectionGrid = Ext.create('Ext.grid.Panel',{
			id:'AigaP2pBusiCaseCollectionGrid',
	        cls: 'ui-formPanel',
			title:'用户体验测试用例集',
	        margins : '0 0 0 3',
			height: screenHeight*0.89,
	        width: screenWidth,
	        tbar:[
	              {
	            	  xtype:'button',
	            	  text:'关联',
	            	  handler:function(){
	            		  
	            	  }
	            	  }
			],
			forctFit:true,
	        stripeRows:true,
	        loadMask:true, 
			store: AigaP2pBusiCaseCollectionStore,
			selType:'rowmodel',
			listeners : {
			},
			columns:[
				new Ext.grid.RowNumberer(),
				{header: "id", width:100, sortable: true, dataIndex: 'collectId',hidden:true},
				{header: "二级业务ID", width:100, sortable: true, dataIndex: 'busiTwoLevelId',hidden:true},
				{header: "基础业务", width:100, sortable: true, dataIndex: 'baseBusiId',
					renderer: function (value, cellmeta, record) {
	                    try {
	                        var store = Ext.data.StoreManager.lookup("p2pCaseCollectMapStore");
	                        store.clearFilter(true);
	                        store.filter("group", "AigaP2pBaseFunction");
	                        console.log(store.findRecord("value",value ));
	                        return store.findRecord("value",value ).getData().show + "";
	                    } catch (e) {
	                        return "未指定";
	                    };
                }
				},
				{header: "渠道", width:100, sortable: true, dataIndex: 'channelId',
					renderer: function (value, cellmeta, record) {
	                    try {
	                        var store = Ext.data.StoreManager.lookup("p2pCaseCollectMapStore");
	                        store.clearFilter(true);
	                        store.filter("group", "AigaP2pChannel");
	                        console.log(store.findRecord("value",value ));
	                        return store.findRecord("value",value ).getData().show + "";
	                    } catch (e) {
	                        return "未指定";
	                    };
                }
				},
				{header: "功能点", width:100, sortable: true, dataIndex: 'funId',
					renderer: function (value, cellmeta, record) {
	                    try {
	                        var store = Ext.data.StoreManager.lookup("p2pCaseCollectMapStore");
	                        store.clearFilter(true);
	                        store.filter("group", "AigaP2pFunctionPoint");
	                        console.log(store.findRecord("value",value ));
	                        return store.findRecord("value",value ).getData().show + "";
	                    } catch (e) {
	                        return "未指定";
	                    };
                }
				},
				{header: "用例", width:100, sortable: true, dataIndex: 'caseId',
					renderer: function (value, cellmeta, record) {
	                    try {
	                        var store = Ext.data.StoreManager.lookup("p2pCaseCollectMapStore");
	                        store.clearFilter(true);
	                        store.filter("group", "AigaP2pCase");
	                        console.log(store.findRecord("value",value ));
	                        return store.findRecord("value",value ).getData().show + "";
	                    } catch (e) {
	                        return "未指定";
	                    };
                }},
				{header: "备注", width:100, sortable: true, dataIndex: 'remark'},
				{header: "来源", width:150, sortable: true, dataIndex: 'source'},
				{header: "原因", width:150, sortable: true, dataIndex: 'cause'},
				{header: "原因类型", width:100, sortable: true, dataIndex: 'casuseType'},
				{header: "评审状态", width:100, sortable: true, dataIndex: 'verifyStatus'},
				{header: "评审结果", width:100, sortable: true, dataIndex: 'verifyResult'},
				{header: "是否性能测试", width:100, sortable: true, dataIndex: 'createTime'},
				{header: "创建ID", width:100, sortable: true, dataIndex: 'creatorId',hidden:true},
				{header: "创建人", width:100, sortable: true, dataIndex: 'creatorName'}
	    	]
		});
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
			items:[AigaP2pBusiCaseCollectionGrid]
		}]
	});
});

</script>
</html>