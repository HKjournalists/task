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
	<title>月度运营KPI查询</title>
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
    
    var btn = new Ext.Button({
	    text: '查询',
	    width: 60,
	    margin: '0 0 0 50px',
	    handler: function() {
			Ext.StoreMgr.get('monthRunKpiStore').reload();
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
    
	var monthRunKpiStore = Ext.create('Ext.data.Store', {
		storeId:'monthRunKpiStore',
		pageSize: 20,//每页显示条数
		fields:[
	        {name:'kpiId',type:'string'},//衡量交付kpi_ID
	 		{name:'targetAttention',type:'string'},//指标关注
	 		{name:'kpiName',type:'string'},//kpi名称
	 		{name:'targetUnit',type:'string'},//指标单位
	 		{name:'kpiDefine',type:'string'},//kpi定义
	 		{name:'computationalFormula',type:'string'},//计算公式
	 		{name:'standardValue',type:'string'},//标准值
	 		{name:'targetProvideTime',type:'string'},
	 		{name:'targetDepartment',type:'string'},
	 		{name:'statisticsCycleTime',type:'string'},
	 		{name:'kpiStatus',type:'string'},//是否可用标识(1:可用,0:禁用)
 		],
	    proxy: {
	        type: 'ajax',
        	url : '<%=request.getContextPath()%>/getMonthRunKpiList.do',
	        reader: {
	            root:"data",
				type:"json",
            	totalProperty:'total'
	        }
	    }
	});
	monthRunKpiStore.on('beforeload',function(){        // =======翻页时 查询条件     
		Ext.apply(       
			monthRunKpiStore.proxy.extraParams, {
					kpiName: encodeURI(encodeURI(Ext.getCmp('qryForm').getForm().findField('kpiName').getValue())),
				}      
			);      
	});
	monthRunKpiStore.loadPage(1);
	
	var monthRunKpiGrid = new Ext.grid.Panel({
        id: 'monthRunKpiGrid',
        cls: 'ui-formPanel',
        width: screenWidth * 0.98,
        height: screenHeight * 0.85,
        renderTo: Ext.getBody(),
        title: '衡量结果KPI信息列表',
        store: monthRunKpiStore,
        bbar: Ext.create('Ext.PagingToolbar', { 
			store: monthRunKpiStore, 
			displayInfo: true, 
			displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
			emptyMsg: "没有数据"
		}),
        tbar:[
        	{xtype: 'button',text: '新增',handler: function () {
        		monthRunKpiCreateWin = new top.Ext.window.Window({
			 		id:'monthRunKpiCreateWin',
				    title : '新增KPI',
				    width : 1050,
				    height : 408,
				    modal : true,
				    autoScroll:true,
				    listeners:{
						destroy:function(window,eOpts){
							monthRunKpiStore = Ext.data.StoreManager.lookup("monthRunKpiStore");
							monthRunKpiStore.reload();
						}
				    },
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/statisticsChart/statMonthOneLevelKpiSystem.jsp?flag=create" width="1050" height="356"/>'
            	}).show();
        	}}
        ],
        listeners: {
            itemdblclick: function(grid, record, item, index, e, eOpts) {
            	monthRunKpiQueryWin = new top.Ext.window.Window({
			 		id:'monthRunKpiQueryWin',
				    title : 'KPI详细信息',
				    width : 1050,
				    height : 408,
				    modal : true,
				    autoScroll:true,
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/statisticsChart/statMonthOneLevelKpiSystem.jsp?flag=query&kpiId='+record.raw.kpiId+'" width="1050" height="356"/>'
            	}).show();
            },
        	itemcontextmenu: rightClickTargetFn
        },
        columns: [
            {xtype: 'rownumberer'}, 
         	{header: "KPIID",width: 100,sortable: true,dataIndex: 'kpiId',hidden: true}, 
         	{header: "指标关注",width: 100,sortable: true,dataIndex: 'targetAttention'}, 
         	{header: "KPI名称 ",width: 100,sortable: true,dataIndex: 'kpiName'}, 
         	{header: "指标单位",width: 100,sortable: true,dataIndex: 'targetUnit'}, 
 			{header: "KPI定义",width: 100,sortable: true,dataIndex: 'kpiDefine'}, 
 			{header: "计算公式",width: 100,sortable: true,dataIndex: 'computationalFormula'}, 
 			{header: "达标值",width: 100,sortable: true,dataIndex: 'standardValue'}, 
 			{header: "指标提供时间",width: 100,sortable: true,dataIndex: 'targetProvideTime'}, 
 			{header: "指标负责部门",width: 100,sortable: true,dataIndex: 'targetDepartment'}, 
 			{header: "统计周期",width: 100,sortable: true,dataIndex: 'statisticsCycleTime'}, 
 			{header: "是否可用标识(1:可用,0:禁用)",sortable: false,dataIndex: 'kpiStatus',hidden: true},
       		{header: "操作", width:33,menuDisabled: true,align:'center',xtype:'actioncolumn',sortable:false,items: [
       			{
	       			icon:"<%=request.getContextPath()%>/aiga/label/image/del.gif",
	       			id: 'delComp',  
					tooltip: '删除',  
					handler: function(grid, rowIndex, colIndex) {   //rowIndex，colIndex均从0开始  
				        var kpiId = grid.getStore().getAt(rowIndex).data.kpiId;
						MaskLoading();
				        Ext.Ajax.request({   
							url:'<%=request.getContextPath()%>/deleteMonthRunKpiBykpiId.do',  
							params:{kpiId:kpiId},
							success:function(response,config){ 
								MaskOver();
								monthRunKpiStore = Ext.data.StoreManager.lookup("monthRunKpiStore");
								monthRunKpiStore.reload();
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
	        text: '编辑KPI信息',
	        handler: function () {
	            var models = Ext.getCmp('monthRunKpiGrid').getSelectionModel().getSelection();
	            if (models.length != 1) {
	            	Ext.Msg.alert("提示","选择错误!");
	            }
	            var monthRunKpiAlterWin = new top.Ext.window.Window({
	                id: 'monthRunKpiAlterWin',
	                title: '编辑KPI信息',
	                width: 1050,
				    height : 408,
	                modal: true,
	                listeners: {
	                    destroy: function (window, eOpts) {
							monthRunKpiStore = Ext.data.StoreManager.lookup("monthRunKpiStore");
							monthRunKpiStore.reload();
	                    }
	                },
	                closeAction: 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/statisticsChart/statMonthOneLevelKpiSystem.jsp?flag=alter&kpiId='+models[0].data.kpiId+'" width="1050" height="356"/>'
	            }).show();
	        }
    	}
	]
});
</script>
</html>