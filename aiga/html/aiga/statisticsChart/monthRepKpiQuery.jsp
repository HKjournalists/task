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
	<title>衡量过程KPI查询</title>
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
			Ext.StoreMgr.get('monthRepKpiStore').reload();
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
    
	var monthRepKpiStore = Ext.create('Ext.data.Store', {
		storeId:'monthRepKpiStore',
		pageSize: 20,//每页显示条数
		fields:[
	        {name:'kpiId',type:'string'},//kpiID
	 		{name:'kpiName',type:'string'},//kpi名称
	 		{name:'kpiAssessment',type:'string'},//考核
	 		{name:'kpiMeasures',type:'string'},//措施
	 		{name:'computationalFormula',type:'string'},//计算公式
	 		{name:'responsiblePerson',type:'string'},//负责人
	 		{name:'kpiPlan',type:'string'},//计划(请写出公式和值)
	 		{name:'remarks',type:'string'},//备注
	 		{name:'kpiQuestion',type:'string'},//问题
	 		{name:'kpiStatus',type:'string'},//是否可用标识(1:可用,0:禁用)
 		],
	    proxy: {
	        type: 'ajax',
        	url : '<%=request.getContextPath()%>/getMonthRepKpiList.do',
	        reader: {
	            root:"data",
				type:"json",
            	totalProperty:'total'
	        }
	    }
	});
	monthRepKpiStore.on('beforeload',function(){        // =======翻页时 查询条件     
		Ext.apply(       
			monthRepKpiStore.proxy.extraParams, {
					kpiName: encodeURI(encodeURI(Ext.getCmp('qryForm').getForm().findField('kpiName').getValue()))
				}      
			);      
	});
	monthRepKpiStore.loadPage(1);
	
	var monthRepKpiGrid = new Ext.grid.Panel({
        id: 'monthRepKpiGrid',
        cls: 'ui-formPanel',
        width: screenWidth * 0.98,
        height: screenHeight * 0.85,
        renderTo: Ext.getBody(),
        title: '衡量通过KPI信息列表',
        store: monthRepKpiStore,
        bbar: Ext.create('Ext.PagingToolbar', { 
			store: monthRepKpiStore, 
			displayInfo: true, 
			displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
			emptyMsg: "没有数据"
		}),
        tbar:[
        	{xtype: 'button',text: '新增',handler: function () {
        		monthRepKpiCreateWin = new top.Ext.window.Window({
			 		id:'monthRepKpiCreateWin',
				    title : '新增衡量通过KPI',
				    width : 1050,
				    height : 408,
				    modal : true,
				    autoScroll:true,
				    listeners:{
						destroy:function(window,eOpts){
							monthRepKpiStore = Ext.data.StoreManager.lookup("monthRepKpiStore");
							monthRepKpiStore.reload();
						}
				    },
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/statisticsChart/monthRepKpiManage.jsp?flag=create" width="1050" height="356"/>'
            	}).show();
        	}}
        ],
        listeners: {
            itemdblclick: function(grid, record, item, index, e, eOpts) {
            	monthRepKpiQueryWin = new top.Ext.window.Window({
			 		id:'monthRepKpiQueryWin',
				    title : '查看衡量通过KPI详细信息',
				    width : 1050,
				    height : 408,
				    modal : true,
				    autoScroll:true,
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/statisticsChart/monthRepKpiManage.jsp?flag=query&kpiId='+record.raw.kpiId+'" width="1050" height="356"/>'
            	}).show();
            },
        	itemcontextmenu: rightClickTargetFn
        },
        columns: [
            {xtype: 'rownumberer'}, 
         	{header: "KPIID",width: 100,sortable: true,dataIndex: 'kpiId',hidden: true}, 
         	{header: "KPI名称 ",width: 100,sortable: true,dataIndex: 'kpiName'}, 
         	{header: "考核",width: 150,sortable: true,dataIndex: 'kpiAssessment'}, 
 			{header: "措施",width: 150,sortable: true,dataIndex: 'kpiMeasures'}, 
 			{header: "计算公式",width:150,sortable: true,dataIndex: 'computationalFormula'}, 
 			{header: "负责人",width: 100,sortable: true,dataIndex: 'responsiblePerson'},
 			{header: "问题",width: 150,sortable: true,dataIndex: 'kpiQuestion'},  
 			{header: "计划",width: 150,sortable: true,dataIndex: 'kpiPlan'}, 
 			{header: "备注",width: 200,sortable: true,dataIndex: 'remarks'}, 
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
							url:'<%=request.getContextPath()%>/deleteMonthRepKpiByKpiId.do',  
							params:{kpiId:kpiId},
							success:function(response,config){ 
								MaskOver();
								monthRepKpiStore = Ext.data.StoreManager.lookup("monthRepKpiStore");
								monthRepKpiStore.reload();
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
	            var models = Ext.getCmp('monthRepKpiGrid').getSelectionModel().getSelection();
	            if (models.length != 1) {
	            	Ext.Msg.alert("提示","选择错误!");
	            }
	            var monthRepKpiAlterWin = new top.Ext.window.Window({
	                id: 'monthRepKpiAlterWin',
	                title: '编辑KPI信息',
	                width: 1050,
				    height : 408,
	                modal: true,
	                listeners: {
	                    destroy: function (window, eOpts) {
							monthRepKpiStore = Ext.data.StoreManager.lookup("monthRepKpiStore");
							monthRepKpiStore.reload();
	                    }
	                },
	                closeAction: 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/statisticsChart/monthRepKpiManage.jsp?flag=alter&kpiId='+models[0].data.kpiId+'" width="1050" height="356"/>'
	            }).show();
	        }
    	}
	]
});
</script>
</html>