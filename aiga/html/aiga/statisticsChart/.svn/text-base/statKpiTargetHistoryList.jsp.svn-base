<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/aiga/common/common.jsp" %>
<%
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
	boolean isFlag = true;
	String flag = "1";
	String kpiUuid=request.getParameter("kpiUuid");
%>
<html>
    
<head>
	<title>KPI历史列表</title>
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
			Ext.StoreMgr.get('statKpiTargetHistoryStore').reload();
		}
	});
     var btn = new Ext.Button({
	    text: '查询',
	    width: 60,
	    margin: '0 0 0 50px',
	    handler: function() {
			Ext.StoreMgr.get('statKpiTargetHistoryStore').reload();
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
	var statKpiTargetHistoryStore = Ext.create('Ext.data.Store', {
		storeId:'statKpiTargetHistoryStore',
		pageSize: 10,//每页显示条数
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
	 		{name:'kpiHisStatus',type:'string'}
 		],
	    proxy: {
	        type: 'ajax',
	        url:
	        <%if(kpiUuid!=null&&!kpiUuid.equals("")){%>'<%=request.getContextPath()%>/getStatKpiTargetByKpiUuid.do?kpiUuid=<%=kpiUuid%>',
	        <%}else{%>'<%=request.getContextPath()%>/getStatKpiTargetHistoryList.do',<%}%>
	       reader: {
	            root:"data",
				type:"json",
           	totalProperty:'total'
	        }
	    }
	});
	statKpiTargetHistoryStore.on('beforeload',function(){        // =======翻页时 查询条件     
		Ext.apply(       
			statKpiTargetHistoryStore.proxy.extraParams,{
					kpiName: encodeURI(encodeURI(Ext.getCmp('qryForm').getForm().findField('kpiName').getValue())),
					kpiType: encodeURI(encodeURI(Ext.getCmp('qryForm').getForm().findField('kpiType').getValue())),
					targetType: encodeURI(encodeURI(Ext.getCmp('qryForm').getForm().findField('targetType').getValue()))
				}      
			);      
	});
	statKpiTargetHistoryStore.loadPage(1);
	var statKpiTargetHistoryGrid = new Ext.grid.Panel({
        id: 'statKpiTargetHistoryGrid',
        cls: 'ui-formPanel',
        width: screenWidth,
        height: screenHeight*0.8,
        renderTo: Ext.getBody(),
        title: 'KPI历史表',
        store: statKpiTargetHistoryStore,
        bbar: Ext.create('Ext.PagingToolbar', { 
			store: statKpiTargetHistoryStore, 
			displayInfo: true, 
			displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
			emptyMsg: "没有数据"
		}),
        columns: [
            {xtype: 'rownumberer'}, 
         	{header: "KPIID",width: 100,sortable: true,dataIndex: 'kpiId',hidden: true}, 
         	{header: "KPI名称 ",width: 100,sortable: true,dataIndex: 'kpiName'}, 
         	{header: "KPI类型",width: 100,sortable: true,dataIndex: 'kpiType',renderer: function(value, cellmeta, record) {
 	 	        try{
 		        		var store=Ext.data.StoreManager.lookup("mapStore");
 	        		   store.clearFilter(true);
 	        		  store.filter("categoryName","kpiTypeStore");
 	        		  return store.findRecord("value",value).getData().show+"";
 	   	         } catch(e){return "未指定"};
 		        }}, 
         	{header: "指标关注",width: 100,sortable: true,dataIndex: 'targetAttention'}, 
         	{header: "指标类型",width: 100,sortable: true,dataIndex: 'targetType',
         	editor:{xtype:'combo',displayField:'show', valueField:'value', store:'targetStore'},renderer:function(value){
			    			var rec = Ext.StoreMgr.get('targetStore').find('value',value);
			    			if(rec == -1) {
			    				return '';
			    			}
			    			return Ext.StoreMgr.get('targetStore').getAt(rec).raw.show;
			 }}, 
 			{header: "KPI定义",width: 100,sortable: true,dataIndex: 'kpiDefine'}, 
 			{header: "计算公式",width:100,sortable: true,dataIndex: 'computationalFormula'}, 
 			{header: "指标单位",width: 100,sortable: true,dataIndex: 'targetUnit'},
 			{header: "达标值",width: 100,sortable: true,dataIndex: 'standardValue'},  
 			{header: "指标提供时间",width: 100,sortable: true,dataIndex: 'targetProvideTime'}, 
 			{header: "指标负责部门",width: 100,sortable: true,dataIndex: 'targetDepartment'}, 
 			{header: "统计周期",width:100,sortable: true,dataIndex: 'statisticsCycleTime'}, 
 			{header: "修改时间",width: 100,sortable: true,dataIndex: 'changeTime'},
 			{header: "修改人",width: 100,sortable: true,dataIndex: 'changeStaffName'},  
 			{header: "修改人id",width: 100,sortable: true,dataIndex: 'changeStaffId',hidden: true}, 
 			{header: "修改原因",width: 100,sortable: true,dataIndex: 'changeReason'},  
 			{header: "备注",width: 200,sortable: true,dataIndex: 'remark'}, 
 			{header: "是否可用标识(1:可用,0:禁用)",sortable: false,dataIndex: 'kpiStatus',hidden: true},
 			{header: "是否修改标识(1:无,0:有)",sortable: false,dataIndex: 'kpiHisStatus',hidden: true}
      	]
    });
});
</script>
</html>