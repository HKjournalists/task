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
	<title>衡量交付SLA查询</title>
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
			Ext.StoreMgr.get('monthDelSlaStore').reload();
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
                    {name: 'slaName',fieldLabel: 'SLA名称'},
                    {name: 'targetAttention',fieldLabel: '指标关注'},
                    {name: 'responsiblePerson',fieldLabel: '指标负责人'},
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
    
	var monthDelSlaStore = Ext.create('Ext.data.Store', {
		storeId:'monthDelSlaStore',
		pageSize: 20,//每页显示条数
		fields:[
	        {name:'slaId',type:'string'},//衡量交付SLA_ID
	 		{name:'targetAttention',type:'string'},//指标关注
	 		{name:'slaName',type:'string'},//sla名称
	 		{name:'scopeOfApplication',type:'string'},//适用范围
	 		{name:'slaDefine',type:'string'},//sla定义
	 		{name:'computationalFormula',type:'string'},//计算公式
	 		{name:'responsiblePerson',type:'string'},//指标负责人
	 		{name:'targetReachSituation',type:'string'},//指标达成情况(请写出公式和值)
	 		{name:'remarks',type:'string'},//备注
	 		{name:'slaStatus',type:'string'},//是否可用标识(1:可用,0:禁用)
 		],
	    proxy: {
	        type: 'ajax',
        	url : '<%=request.getContextPath()%>/getMonthDelSlaList.do',
	        reader: {
	            root:"data",
				type:"json",
            	totalProperty:'total'
	        }
	    }
	});
	monthDelSlaStore.on('beforeload',function(){        // =======翻页时 查询条件     
		Ext.apply(       
			monthDelSlaStore.proxy.extraParams, {
					slaName: encodeURI(encodeURI(Ext.getCmp('qryForm').getForm().findField('slaName').getValue())),
					targetAttention: encodeURI(encodeURI(Ext.getCmp('qryForm').getForm().findField('targetAttention').getValue())),
					responsiblePerson: encodeURI(encodeURI(Ext.getCmp('qryForm').getForm().findField('responsiblePerson').getValue()))
				}      
			);      
	});
	monthDelSlaStore.loadPage(1);
	
	var monthDelSlaGrid = new Ext.grid.Panel({
        id: 'monthDelSlaGrid',
        cls: 'ui-formPanel',
        width: screenWidth * 0.98,
        height: screenHeight * 0.85,
        renderTo: Ext.getBody(),
        title: '衡量交付SLA信息列表',
        store: monthDelSlaStore,
        bbar: Ext.create('Ext.PagingToolbar', { 
			store: monthDelSlaStore, 
			displayInfo: true, 
			displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
			emptyMsg: "没有数据"
		}),
        tbar:[
        	{xtype: 'button',text: '新增',handler: function () {
        		monthDelSlaCreateWin = new top.Ext.window.Window({
			 		id:'monthDelSlaCreateWin',
				    title : '新增衡量交付SLA',
				    width : 1050,
				    height : 408,
				    modal : true,
				    autoScroll:true,
				    listeners:{
						destroy:function(window,eOpts){
							monthDelSlaStore = Ext.data.StoreManager.lookup("monthDelSlaStore");
							monthDelSlaStore.reload();
						}
				    },
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/statisticsChart/monthDelSlaManage.jsp?flag=create" width="1050" height="356"/>'
            	}).show();
        	}}
        ],
        listeners: {
            itemdblclick: function(grid, record, item, index, e, eOpts) {
            	monthDelSlaQueryWin = new top.Ext.window.Window({
			 		id:'monthDelSlaQueryWin',
				    title : '查看衡量交付SLA详细信息',
				    width : 1050,
				    height : 408,
				    modal : true,
				    autoScroll:true,
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/statisticsChart/monthDelSlaManage.jsp?flag=query&slaId='+record.raw.slaId+'" width="1050" height="356"/>'
            	}).show();
            },
        	itemcontextmenu: rightClickTargetFn
        },
        columns: [
            {xtype: 'rownumberer'}, 
         	{header: "SLA_ID",width: 100,sortable: true,dataIndex: 'slaId',hidden: true}, 
         	{header: "指标关注",width: 100,sortable: true,dataIndex: 'targetAttention'}, 
         	{header: "SLA名称 ",width: 100,sortable: true,dataIndex: 'slaName'}, 
         	{header: "适用范围",width: 100,sortable: true,dataIndex: 'scopeOfApplication'}, 
 			{header: "SLA定义",width: 220,sortable: true,dataIndex: 'slaDefine'}, 
 			{header: "计算公式",width: 220,sortable: true,dataIndex: 'computationalFormula'}, 
 			{header: "指标负责人",width: 100,sortable: true,dataIndex: 'responsiblePerson'}, 
 			{header: "指标达成情况(请写出公式和值)",width: 220,sortable: true,dataIndex: 'targetReachSituation'}, 
 			{header: "备注",width: 220,sortable: true,dataIndex: 'remarks'}, 
 			{header: "是否可用标识(1:可用,0:禁用)",sortable: false,dataIndex: 'slaStatus',hidden: true},
       		{header: "操作", width:33,menuDisabled: true,align:'center',xtype:'actioncolumn',sortable:false,items: [
       			{
	       			icon:"<%=request.getContextPath()%>/aiga/label/image/del.gif",
	       			id: 'delComp',  
					tooltip: '删除',  
					handler: function(grid, rowIndex, colIndex) {   //rowIndex，colIndex均从0开始  
				        var slaId = grid.getStore().getAt(rowIndex).data.slaId;
						MaskLoading();
				        Ext.Ajax.request({   
							url:'<%=request.getContextPath()%>/deleteMonthDelSlaBySlaId.do',  
							params:{slaId:slaId},
							success:function(response,config){ 
								MaskOver();
								monthDelSlaStore = Ext.data.StoreManager.lookup("monthDelSlaStore");
								monthDelSlaStore.reload();
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
	        text: '编辑衡量交付SLA信息',
	        handler: function () {
	            var models = Ext.getCmp('monthDelSlaGrid').getSelectionModel().getSelection();
	            if (models.length != 1) {
	            	Ext.Msg.alert("提示","选择错误!");
	            }
	            var monthDelSlaAlterWin = new top.Ext.window.Window({
	                id: 'monthDelSlaAlterWin',
	                title: '编辑衡量交付SLA信息',
	                width: 1050,
				    height : 408,
	                modal: true,
	                listeners: {
	                    destroy: function (window, eOpts) {
							monthDelSlaStore = Ext.data.StoreManager.lookup("monthDelSlaStore");
							monthDelSlaStore.reload();
	                    }
	                },
	                closeAction: 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/statisticsChart/monthDelSlaManage.jsp?flag=alter&slaId='+models[0].data.slaId+'" width="1050" height="356"/>'
	            }).show();
	        }
    	}
	]
});
</script>
</html>