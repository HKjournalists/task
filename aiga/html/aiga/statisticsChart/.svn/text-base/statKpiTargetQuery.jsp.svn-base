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
	<title>KPI查询</title>
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
                type: 'String'
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
            url: '<%=request.getContextPath()%>/getSysConstantStore.do?category=STATISTICS',
            reader: {
                type: 'json',
                root: 'data'
            }
        },
        listeners: {
        }
    });
    mapStore.load();
     var kpiTypeCombox = new Ext.form.ComboBox({
        width: 200,
        name:'kpiType',
       store: mapStore,
       labelAlign: 'right',
       fieldLabel: 'KPI类型',
       valueField: 'value',
       displayField: 'show',
        listeners: {
            beforequery: function (queryEvent, eOpts) {
                queryEvent.query = "kpiTypeStore";
            }
        }
    });
     var targetStore = new Ext.data.Store({
			id: 'targetStore',
			fields: ['value','show'],
			proxy: {
			    type: 'ajax',
			    url: '<%=request.getContextPath()%>/getSysParam.do?category=TARGET_TYPE'+'&_='+(new Date()).getTime(),
			    reader: {
			        type: 'json',
			        root: 'data'
			    }
		 }
  });
    targetStore.load();
    var targetTypeCombox = new Ext.form.ComboBox({
        width: 200,
        store: targetStore,
        labelAlign: 'right',
        name: "targetType",
        fieldLabel: '指标类型',
        valueField: 'value',
        displayField: 'show',
        listeners: {
        }
    });
    var btn = new Ext.Button({
	    text: '查询',
	    width: 60,
	    margin: '0 0 0 50px',
	    handler: function() {
			Ext.StoreMgr.get('statKpiTargetStore').loadPage(1);
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
                    {name: 'kpiName',fieldLabel: 'KPI名称'},
                    kpiTypeCombox,
                    targetTypeCombox,
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
	var statKpiTargetStore = Ext.create('Ext.data.Store', {
		storeId:'statKpiTargetStore',
		pageSize: 20,//每页显示条数
		fields:[
	        {name:'kpiId',type:'string'},//kpiID
	 		{name:'kpiName',type:'string'},//kpi名称
	 		{name:'targetAttention',type:'string'},
	 		{name:'targetType',type:'string'},
	 		{name:'kpiDefine',type:'string'},
	 		{name:'computationalFormula',type:'string'},//计算公式
	 		{name:'targetUnit',type:'string'},
	 		{name:'standardValue',type:'string'},
	 		{name:'targetProvideTime',type:'string'},
	 		{name:'targetDepartment',type:'string'},
	 		{name:'statisticsCycleTime',type:'string'},
	 		{name:'changeTime',type:'string'},
	 		{name:'changeStaffName',type:'string'},
	 		{name:'changeStaffId',type:'string'},
	 		{name:'changeReason',type:'string'},
	 		{name:'kpiType',type:'string'},
	 		{name:'remark',type:'string'},//备注
	 		{name:'kpiStatus',type:'string'},
	 		{name:'kpiUuid',type:'string'},
	 		{name:'kpiHisStatus',type:'string'}
 		],
	    proxy: {
	        type: 'ajax',
        	url : '<%=request.getContextPath()%>/getStatKpiTargetList.do',
	        reader: {
	            root:"data",
				type:"json",
            	totalProperty:'total'
	        }
	    }
	});
	statKpiTargetStore.on('beforeload',function(){        // =======翻页时 查询条件     
		Ext.apply(       
			statKpiTargetStore.proxy.extraParams, {
					kpiName: encodeURI(encodeURI(Ext.getCmp('qryForm').getForm().findField('kpiName').getValue())),
					kpiType: encodeURI(encodeURI(Ext.getCmp('qryForm').getForm().findField('kpiType').getValue())),
					targetType: encodeURI(encodeURI(Ext.getCmp('qryForm').getForm().findField('targetType').getValue()))
				}      
			);      
	});
	statKpiTargetStore.loadPage(1);
	
	var statKpiTargetGrid = new Ext.grid.Panel({
        id: 'statKpiTargetGrid',
        cls: 'ui-formPanel',
        width: screenWidth * 0.98,
        height: screenHeight * 0.85,
        renderTo: Ext.getBody(),
        title: 'KPI信息列表',
        store: statKpiTargetStore,
        bbar: Ext.create('Ext.PagingToolbar', { 
			store: statKpiTargetStore, 
			displayInfo: true, 
			displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
			emptyMsg: "没有数据"
		}),
        tbar:[
        	{xtype: 'button',text: '新增',handler: function () {
        		statKpiTargetCreateWin = new top.Ext.window.Window({
			 		id:'statKpiTargetCreateWin',
				    title : '新增KPI',
				    width : 1050,
				    height : 408,
				    modal : true,
				    autoScroll:true,
				    listeners:{
						destroy:function(window,eOpts){
							statKpiTargetStore = Ext.data.StoreManager.lookup("statKpiTargetStore");
							statKpiTargetStore.reload();
						}
				    },
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/statisticsChart/statKpiTargetManage.jsp?flag=create" width="1050" height="356"/>'
            	}).show();
        	}},{xtype: 'button',text: '修改',handler: function () {
        		var models = Ext.getCmp('statKpiTargetGrid').getSelectionModel().getSelection();
 	            if (models.length != 1) {
 	            	Ext.Msg.alert("提示","选择错误!");
 	            }
        		 var statKpiTargetAlterWin = new top.Ext.window.Window({
 	                id: 'statKpiTargetAlterWin',
 	                title: '编辑KPI信息',
 	                width: 1050,
 				    height : 408,
 	                modal: true,
 	                listeners: {
 	                    destroy: function (window, eOpts) {
 							statKpiTargetStore = Ext.data.StoreManager.lookup("statKpiTargetStore");
 							statKpiTargetStore.reload();
 	                    }
 	                },
 	                closeAction: 'destroy',
 				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/statisticsChart/statKpiTargetManage.jsp?flag=alter&kpiId='+models[0].data.kpiId+'" width="1050" height="356"/>'
 	            }).show();
        	}},{xtype: 'button',text: '查看KPI删除历史信息',handler: function () {
        		statKpiTargetLookWin = new top.Ext.window.Window({
			 		id:'statKpiTargetLookWin',
				    title : '查看KPI信息',
				    width : 1000,
				    height : 450,
				    modal : true,
				    autoScroll:true,
				    listeners:{
						destroy:function(window,eOpts){
							statKpiTargetStore = Ext.data.StoreManager.lookup("statKpiTargetStore");
							statKpiTargetStore.reload();
						}
				    },
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/statisticsChart/statKpiTargetHistoryList.jsp" width="100%" height="100%" scrolling="yes"/>'
            	}).show();
        	}}
        ],
        listeners: {
            itemdblclick: function(grid, record, item, index, e, eOpts) {
            	statKpiTargetQueryWin = new top.Ext.window.Window({
			 		id:'statKpiTargetQueryWin',
				    title : '查看KPI详细信息',
				    width : 1050,
				    height : 408,
				    modal : true,
				    autoScroll:true,
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/statisticsChart/statKpiTargetManage.jsp?flag=query&kpiId='+record.raw.kpiId+'" width="1000" height="356"/>'
            	}).show();
            }
        },
        columns: [
            {xtype: 'rownumberer'}, 
         	{header: "KPIID",width: 100,sortable: true,dataIndex: 'kpiId',hidden: true}, 
         	{header: "KPI名称 ",width: 100,sortable: true,dataIndex: 'kpiName'}, 
         	{header: "指标关注",width: 100,sortable: true,dataIndex: 'targetAttention'},
         	{header: "指标类型",width: 100,sortable: true,dataIndex: 'targetType',
         	editor:{xtype:'combo',displayField:'show', valueField:'value', store:'targetStore'},
			    		renderer:function(value){
			    			var rec = Ext.StoreMgr.get('targetStore').find('value',value);
			    			if(rec == -1) {
			    				return '';
			    			}
			    			return Ext.StoreMgr.get('targetStore').getAt(rec).raw.show;
			 }},
	        {header: "KPI类型",width: 100,sortable: true,dataIndex: 'kpiType',renderer: function(value, cellmeta, record) {
 				
	 	        try
	   	          {
		        		var store=Ext.data.StoreManager.lookup("mapStore");
	        		   store.clearFilter(true);
	        		   //console.log(store);
	        		  store.filter("categoryName","kpiTypeStore");
	        		  return store.findRecord("value",value).getData().show+"";
	   	         } catch(e){return ""};
		     }}, 
 			{header: "KPI定义",width: 100,sortable: true,dataIndex: 'kpiDefine'}, 
 			{header: "修改原因",width: 100,sortable: true,dataIndex: 'changeReason'},
 			{header: "计算公式",width:100,sortable: true,dataIndex: 'computationalFormula'}, 
 			{header: "指标单位",width: 100,sortable: true,dataIndex: 'targetUnit'},
 			{header: "达标值",width: 100,sortable: true,dataIndex: 'standardValue'},  
 			{header: "指标提供时间",width: 100,sortable: true,dataIndex: 'targetProvideTime'}, 
 			{header: "提供部门",width: 100,sortable: true,dataIndex: 'targetDepartment'}, 
 			{header: "统计周期",width:100,sortable: true,dataIndex: 'statisticsCycleTime'}, 
 			{header: "修改时间",width: 100,sortable: true,dataIndex: 'changeTime'},
 			{header: "修改人",width: 100,sortable: true,dataIndex: 'changeStaffName'},  
 			{header: "修改人id",width: 100,sortable: true,dataIndex: 'changeStaffId',hidden: true},   
 			{header: "备注",width: 200,sortable: true,dataIndex: 'remark'}, 
 			{header: "是否可用标识(1:可用,0:禁用)",sortable: false,dataIndex: 'kpiStatus',hidden: true},
 			{header: "是否修改标识(1:无,0:是)",sortable: false,dataIndex: 'kpiHisStatus',hidden: true},
       		{header: "操作", width:33,menuDisabled: true,align:'center',xtype:'actioncolumn',sortable:false,items: [
       			{
	       			icon:"<%=request.getContextPath()%>/aiga/label/image/del.gif",
	       			id: 'delComp',  
					tooltip: '删除',  
					handler: function(grid, rowIndex, colIndex) { //rowIndex，colIndex均从0开始  
	       			 Ext.Msg.confirm("警告", "确定要删除吗？", function (button) {  
		                if (button == "yes") {    
				        var kpiId = grid.getStore().getAt(rowIndex).data.kpiId;
						MaskLoading();
				        Ext.Ajax.request({   
							url:'<%=request.getContextPath()%>/deleteStatKpiTargetByKpiId.do',  
							params:{kpiId:kpiId},
							success:function(response,config){ 
								MaskOver();
								Ext.Msg.alert('提示','删除成功！');
								statKpiTargetStore = Ext.data.StoreManager.lookup("statKpiTargetStore");
								statKpiTargetStore.reload();
							}, 
					        failure:function(){  
								MaskOver();
					        	Ext.Msg.alert('提示','删除数据出错');
					        }   
			    		});
		               }  
  				    });  
				  }  
       			}
       		]},{header: "查看修改操作", width:100,menuDisabled: true,align:'center',xtype:'actioncolumn',text: '查看KPI修改信息',sortable:true,items: [
             {
            	 icon:"<%=request.getContextPath()%>/aiga/images/viewReq.png",
            	 tooltip: '查看KPI修改信息',  
	           handler: function(grid, rowIndex, colIndex) {   //rowIndex，colIndex均从0开始  
			    var kpiUuid = grid.getStore().getAt(rowIndex).data.kpiUuid;
	           //console.log(grid.getStore().getAt(rowIndex).data);
         		statKpiTargetLookWin = new top.Ext.window.Window({
 			 		id:'statKpiTargetLookWin',
 				    title : '查看KPI信息',
 				    width : 980,
 				    height : 500,
 				    modal : true,
 				    autoScroll:true,
 				    listeners:{
 						destroy:function(window,eOpts){
 							statKpiTargetStore = Ext.data.StoreManager.lookup("statKpiTargetStore");
 							statKpiTargetStore.reload();
 						}
 				    },
 				    closeAction : 'destroy',
 				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/statisticsChart/statKpiTargetHistoryList.jsp?kpiUuid='+kpiUuid+'" width="100%" height="100%" scrolling="yes"/>'
             	}).show();
         	  }
         	}  
        ]}   
      ]
    });

});
</script>
</html>