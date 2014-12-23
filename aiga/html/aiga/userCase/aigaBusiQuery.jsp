<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/aiga/common/common.jsp" %>
<%
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
	boolean isFlag = true;
	String flag = "1";
%>
<html>
    
<head>
	<title>业务标签查询</title>
	<style type="text/css">
		#uploadForm-body table {
		    float: left;
		}
		#uploadForm-body div {
		    float: left;
		}
		.red {
		    color:red;
		}
	</style>
</head>

<body>
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
Ext.onReady(function () {
	Ext.QuickTips.init();
    Ext.tip.QuickTipManager.init();
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
            url: '<%=request.getContextPath()%>/getSysConstantStore.do?category=AigaBusi',
            reader: {
                type: 'json',
                root: 'data'
            }
        },
        listeners: {
        }
    });
    mapStore.load();
    var btn = new Ext.Button({
	    text: '查询',
	    width: 60,
	    margin: '0 0 0 50px',
	    handler: function() {
			Ext.StoreMgr.get('aigaBusiStore').reload();
		}
	});
    var qryForm = new Ext.form.FormPanel({
        id: 'qryForm',
        title: '查询区域',
        cls: 'ui-formPanel',
        defaults: {
            margins: '5 0 5 0',
        },
        renderTo: Ext.getBody(),
        width: screenWidth * 0.98,
        height: screenHeight * 0.15 * 0.99,
        layout: 'vbox',
        bodyBorder: 0,
        items: [{
            xtype: 'fieldcontainer',
            labelStyle: 'font-weight:bold;padding:0',
            fieldDefaults: {
                labelAlign: 'right',
                labelWidth: 90,
                width: 200
            },
            layout: 'hbox',
            defaultType: 'textfield',
            items: [
                    {name: 'busiName',fieldLabel: '业务名称'},
					{
			            xtype: 'fieldcontainer',
			            labelStyle: 'font-weight:bold;padding:0',
			            fieldDefaults: {
			                labelAlign: 'right',
			                labelWidth: 90,
			                width: 200
			            },
			            layout: 'hbox',
			            defaultType: 'textfield',
			            items: [
							btn
			            ]
        			}
                ]
            }
        ]
	});
    
	var aigaBusiStore = Ext.create('Ext.data.Store', {
		storeId:'aigaBusiStore',
		pageSize: 20,//每页显示条数
		fields:[
	        {name:'busiId',type:'string'},//业务ID
	 		{name:'busiName',type:'string'},//业务名称
	 		{name:'busiType',type:'string'},//业务类型
	 		{name:'importantClass',type:'string'},//重要等级
	 		{name:'busiDesc',type:'string'},//业务说明
	 		{name:'remarks',type:'string'},//备注
	 		{name:'isInvalid',type:'string'},//是否可用标识(0:可用,1:禁用)
 		],
	    proxy: {
	        type: 'ajax',
        	url : '<%=request.getContextPath()%>/getAigaBusiList.do',
	        reader: {
	            root:"data",
				type:"json",
            	totalProperty:'total'
	        }
	    }
	});
	aigaBusiStore.on('beforeload',function(){        // =======翻页时 查询条件     
		Ext.apply(       
				aigaBusiStore.proxy.extraParams, {
					busiName: encodeURI(encodeURI(Ext.getCmp('qryForm').getForm().findField('busiName').getValue()))
				}      
			);      
	});
	aigaBusiStore.loadPage(1);
	
	var aigaBusiGrid = new Ext.grid.Panel({
        id: 'aigaBusiGrid',
        cls: 'ui-formPanel',
        width: screenWidth * 0.98,
        height: screenHeight * 0.85,
        renderTo: Ext.getBody(),
        title: '业务列表',
        store: aigaBusiStore,
        bbar: Ext.create('Ext.PagingToolbar', { 
			store: aigaBusiStore, 
			displayInfo: true, 
			displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
			emptyMsg: "没有数据"
		}),
        tbar:[
        	{xtype: 'button',text: '新增',handler: function () {
        		aigaBusiCreateWin = new top.Ext.window.Window({
			 		id:'aigaBusiCreateWin',
				    title : '新增业务',
				    width : 1050,
				    height : 408,
				    modal : true,
				    autoScroll:true,
				    listeners:{
						destroy:function(window,eOpts){
        			        aigaBusiStore = Ext.data.StoreManager.lookup("aigaBusiStore");
        			        aigaBusiStore.reload();
						}
				    },
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/userCase/aigaBusiManage.jsp?flag=create" width="1050" height="356"/>'
            	}).show();
        	}}
        ],
        listeners: {
            itemdblclick: function(grid, record, item, index, e, eOpts) {
            	aigaBusiQueryWin = new top.Ext.window.Window({
			 		id:'aigaBusiQueryWin',
				    title : '查看业务详细信息',
				    width : 1050,
				    height : 408,
				    modal : true,
				    autoScroll:true,
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/userCase/aigaBusiManage.jsp?flag=query&busiId='+record.raw.busiId+'" width="1050" height="356"/>'
            	}).show();
            },
        	itemcontextmenu: rightClickTargetFn
        },
        columns: [
            {xtype: 'rownumberer'}, 
         	{header: "业务ID",width: 100,sortable: true,dataIndex: 'busiId',hidden: true}, 
         	{header: "业务名称 ",width: 150,sortable: true,dataIndex: 'busiName'}, 
         	{header: "业务分类",width: 150,sortable: true,dataIndex: 'busiType',renderer: function(Value, cellmeta, record) {
     	        try
     	          {
  	        		var store=Ext.data.StoreManager.lookup("mapStore");
          		   store.clearFilter(true);
          		  store.filter("categoryName","busiType");
          		  return store.findRecord("value",Value).getData().show+"";
     	         } catch(e){return "未指定"};
  	        }}, 
 			{header: "重要等级",width: 150,sortable: true,dataIndex: 'importantClass',renderer: function(classValue, cellmeta, record) {
  	 	        try
     	          {
  	        		var store=Ext.data.StoreManager.lookup("mapStore");
          		   store.clearFilter(true);
          		  store.filter("categoryName","importantClass");
          		  return store.findRecord("value",classValue).getData().show+"";
     	         } catch(e){return "未指定"};
  	        }}, 
 			{header: "业务说明",width:400,sortable: true,dataIndex: 'busiDesc'}, 
 			{header: "备注",width: 300,sortable: true,dataIndex: 'remarks'},
 			{header: "是否可用标识(0:可用,1:禁用)",sortable: false,dataIndex: 'isInvalid',hidden: true},
       		{header: "操作", width:33,menuDisabled: true,align:'center',xtype:'actioncolumn',sortable:false,items: [
       			{
	       			icon:"<%=request.getContextPath()%>/aiga/label/image/del.gif",
	       			id: 'delComp',  
					tooltip: '删除',  
					handler: function(grid, rowIndex, colIndex) {   //rowIndex，colIndex均从0开始  
				        var busiId = grid.getStore().getAt(rowIndex).data.busiId;
						MaskLoading();
				        Ext.Ajax.request({   
							url:'<%=request.getContextPath()%>/deleteAigaBusiByBusiId.do',  
							params:{busiId:busiId},
							success:function(response,config){ 
								MaskOver();
								aigaBusiStore = Ext.data.StoreManager.lookup("aigaBusiStore");
								aigaBusiStore.reload();
							}, 
					        failure:function(){  
								MaskOver();
					        	Ext.Msg.alert('提示','删除数据出错');
					        }   
			    		});
					}  
       			}
       		]}
      	]
    });
});
function rightClickTargetFn(view, record, item, index, e, eOpts) {
    e.preventDefault();
    rightTargetReportMenu.showAt(e.getXY());
}
var rightTargetReportMenu = new Ext.menu.Menu({
	items: [
		{
	        id: 'editTask',
	        text: '编辑业务信息',
	        handler: function () {
	            var models = Ext.getCmp('aigaBusiGrid').getSelectionModel().getSelection();
	            if (models.length != 1) {
	            	Ext.Msg.alert("提示","选择错误!");
	            }
	            var aigaBusiAlterWin = new top.Ext.window.Window({
	                id: 'aigaBusiAlterWin',
	                title: '编辑业务信息',
	                width: 1050,
				    height : 408,
	                modal: true,
	                listeners: {
	                    destroy: function (window, eOpts) {
	            	        aigaBusiStore = Ext.data.StoreManager.lookup("aigaBusiStore");
	            	        aigaBusiStore.reload();
	                    }
	                },
	                closeAction: 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/userCase/aigaBusiManage.jsp?flag=alter&busiId='+models[0].data.busiId+'" width="1050" height="356"/>'
	            }).show();
	        }
    	}
	]
});
</script>
</html>