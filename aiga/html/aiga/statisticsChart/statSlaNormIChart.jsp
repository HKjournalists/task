<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.sysConstant.bo.SysConstant"%>
<%@page import="com.asiainfo.aiga.sysConstant.util.SysContentUtil"%>
<%@page import="com.asiainfo.aiga.common.WorkflowParam"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");%>
<html>
<head>
	<%@ include file="/aiga/common/include.jsp" %>
	<script type="text/javascript" src="<%=request.getContextPath()%>/chart/FusionCharts.js"></script>
	<title>软件版本SLA(I)-指标达成情况</title>
</head>
<body>
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
var searchReqType='';
var searchBigType='';
var plFactCompleteTime='';
function query() {
	searchReqType=Ext.getCmp('searchReqType').getValue();
	searchBigType=Ext.getCmp('searchBigType').getValue();
	plFactCompleteTime=Ext.getCmp('plFactCompleteTime').rawValue;
	//console.log(searchBigType);
	//console.log(searchReqType);
	Ext.StoreMgr.get('gridStore').on('beforeload',function(){
		Ext.apply(       
			Ext.StoreMgr.get('gridStore').proxy.extraParams, {
				searchReqType:searchReqType,
				searchBigType:searchBigType,
				plFactCompleteTime:plFactCompleteTime
				
			}      
		);      
	});
	Ext.StoreMgr.get('gridStore').loadPage(1);
}
Ext.require([
             'Ext.grid.*',
             'Ext.toolbar.Paging',
             'Ext.util.*',
             'Ext.data.*'
         ]);
Ext.onReady(function(){
	var bigTypeStore=new Ext.data.Store({
		id: 'bigTypeStore',
		fields: ['value','show'],
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getComBox.do?query=bigTypeStore',
			reader: {
				type: 'json',
				root: 'data'
			}
		}
	});
	bigTypeStore.load();
	var bigTypeCombox = new Ext.form.ComboBox({
		width:160,
		labelWidth:60,
		store: bigTypeStore ,
		id:"searchBigType",
		fieldLabel : "系统大类",
		valueField: 'value',
		displayField: 'show',
		 listeners:{
			 beforequery:function( queryEvent,eOpts ){
				queryEvent.query="bigTypeStore";
			 }
         }
		});
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
	var reqTypeCombox = new Ext.form.ComboBox({
		width:160,
		labelWidth:60,
		store: mapStore ,
		id:"searchReqType",
		fieldLabel : "需求类型",
		valueField: 'value',
		displayField: 'show',
		 listeners:{
			 beforequery:function( queryEvent,eOpts ){
				queryEvent.query="reqTypeStore";
			 }
         }
		});
	var storeModel = Ext.regModel("storeModel",{
		fields:[
				{name:'statId',type:'string'},
				{name:'planId',type:'string'},
				{name:'factCompleteTime',type:'string'},
				{name:'reportTime',type:'string'},
				{name:'reqNum',type:'string'},
				{name:'testTaskNum',type:'string'},
				{name:'devTaskNum',type:'string'},
				{name:'createTime',type:'string'},
				{name:'bugSum',type:'string'},
				{name:'bugUnclosed',type:'string'},
				{name:'funcBusiPassPrecent',type:'string'},
				{name:'funcProjectPassPrecent',type:'string'},
				{name:'performPassPrecent',type:'string'},
				{name:'endToEndPassPrecent',type:'string'},
				{name:'combinedTestPassPrecent',type:'string'},
				{name:'groupInPassPrecent',type:'string'},
				{name:'groupOutPassPrecent',type:'string'},
				{name:'codeScanProblemNum',type:'string'},
				{name:'safeScanProblemNum',type:'string'},
				{name:'usableProblemNum',type:'string'},
				{name:'publishBusiPassPrecent',type:'string'},
				{name:'publishProjectPassPrecent',type:'string'},
				{name:'publishFuncPassPrecent',type:'string'},
				{name:'publishPerformPassPrecent',type:'string'},
				{name:'publishEtePassPrecent',type:'string'},
				{name:'publishInterPassPrecent',type:'string'}
			]
	});
	var gridProxy = new Ext.data.proxy.Ajax({
		type:"ajax",
		model: storeModel,
		url:'<%=request.getContextPath()%>/StatSlaNormIList.do',
		reader:{
			 root:"data",
			 type:"json",
			 totalProperty:'total'
		}
	});
	var gridStore = Ext.create('Ext.data.Store',{
		model: storeModel,
		id:'gridStore',
		pageSize:10,
		listeners:{
		},
		proxy:gridProxy
	});
	gridStore.load();
	var Grid = Ext.create('Ext.grid.Panel',{
		id:'Grid',
	    cls: 'ui-formPanel',
	    width: screenWidth*0.99,
	    height: screenHeight*0.90,
	    title:'报表名称：软件版本SLA(I)-指标达成情况',
		forctFit:true,
	    stripeRows:true,
	    loadMask:true,
	    columnLines: true,
		store: gridStore,
		selType:'rowmodel',
    	tbar:[
    	      {width:160,labelWidth:60,xtype: 'datefield', labelAlign: 'right',id: 'plFactCompleteTime',format: 'Y-m-d',fieldLabel: '上线时间'},
    	      bigTypeCombox,
    	      //reqTypeCombox,
    	      {xtype:'button',text: '搜索',handler: function() {query();}
		}
		],
		bbar: Ext.create('Ext.PagingToolbar', {
			store: gridStore, 
			displayInfo: true, 
			displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
			emptyMsg: "没有数据"
			}),
		listeners:{
		},
		columns:[
				new Ext.grid.RowNumberer({header:"序号",width:30}),
				{header: "id", hidden:true, width:100, align:'center',sortable: true, dataIndex: 'statId'},
				{header: "版本上线</br>时间", width:80, align:'center',sortable: true, dataIndex: 'factCompleteTime'},
				{header: "需求</br>数量", width:50, align:'center',sortable: true, dataIndex: 'reqNum'},
				{header: "开发</br>任务单数", width:60, align:'center',sortable: true, dataIndex: 'devTaskNum'},
				{header: "测试</br>任务单数", width:60, align:'center',sortable: true, dataIndex: 'testTaskNum'},
				{header: "报告时间", width:80, align:'center',sortable: true, dataIndex: 'reportTime'},
				{header: "缺陷管理",align:'center',
					columns:[
					         {header: "总缺</br>陷数", width:50, align:'center',sortable: true, dataIndex: 'bugSum'},
							 {header: "未关闭</br>缺陷数", width:50, align:'center',sortable: true, dataIndex: 'bugUnclosed'}
	                       	 ]
				},
				{header: "功能测试",
					columns:[
							{header: "新业务</br>通过率", width:60, align:'center',sortable: true, dataIndex: 'funcBusiPassPrecent',renderer:function(value, cellMeta, record, rowIndex, columnIndex, store){return value+"%";}},
							{header: "项目</br>通过率", width:60, align:'center',sortable: true, dataIndex: 'funcProjectPassPrecent',renderer:function(value, cellMeta, record, rowIndex, columnIndex, store){return value+"%";}}
							]
				},
				{header: "性能测试",align:'center',
					columns:[
							{header: "通过率", width:60, align:'center',sortable: true, dataIndex: 'performPassPrecent',renderer:function(value, cellMeta, record, rowIndex, columnIndex, store){return value+"%";}}
							]
				},
				{header: "端到端测试",align:'center',
					columns:[
							{header: "通过率", width:60, align:'center',sortable: true, dataIndex: 'endToEndPassPrecent',renderer:function(value, cellMeta, record, rowIndex, columnIndex, store){return value+"%";}}
							]
				},
				{header: "联调测试",align:'center',
					columns:[
							{header: "通过率", width:60, align:'center',sortable: true, dataIndex: 'combinedTestPassPrecent',renderer:function(value, cellMeta, record, rowIndex, columnIndex, store){return value+"%";}}
							]
				},
				{header: "集团联调",align:'center',
					columns:[
							{header: "对内</br>通过率", width:60, align:'center',sortable: true, dataIndex: 'groupInPassPrecent',renderer:function(value, cellMeta, record, rowIndex, columnIndex, store){return value+"%";}},
							{header: "对外</br>通过率", width:60, align:'center',sortable: true, dataIndex: 'groupOutPassPrecent',renderer:function(value, cellMeta, record, rowIndex, columnIndex, store){return value+"%";}}
							]
				},
				{header: "代码扫描",align:'center',
					columns:[
							{header: "未解决</br>问题数", width:60, align:'center',sortable: true, dataIndex: 'codeScanProblemNum'}
							]
				},
				{header: "安全扫描",align:'center',
					columns:[
							{header: "未解决</br>问题数", width:60, align:'center',sortable: true, dataIndex: 'safeScanProblemNum'}
							]
				},
				{header: "高可用测试",align:'center',
					columns:[
							{header: "未解决</br>问题数", width:60, align:'center',sortable: true, dataIndex: 'usableProblemNum'}
							]
				},
				{header: "准发布测试通过率",align:'center',
					columns:[
							{header: "新业务</br>功能测试", width:60, align:'center',sortable: true, dataIndex: 'publishBusiPassPrecent',renderer:function(value, cellMeta, record, rowIndex, columnIndex, store){return value+"%";}},
							{header: "项目</br>功能测试", width:60, align:'center',sortable: true, dataIndex: 'publishProjectPassPrecent',renderer:function(value, cellMeta, record, rowIndex, columnIndex, store){return value+"%";}},
							{header: "例行</br>功能回归", width:60, align:'center',sortable: true, dataIndex: 'publishFuncPassPrecent',renderer:function(value, cellMeta, record, rowIndex, columnIndex, store){return value+"%";}},
							{header: "例行</br>性能回归", width:60, align:'center',sortable: true, dataIndex: 'publishPerformPassPrecent',renderer:function(value, cellMeta, record, rowIndex, columnIndex, store){return value+"%";}},
							{header: "例行</br>端到端回归", width:60, align:'center',sortable: true, dataIndex: 'publishEtePassPrecent',renderer:function(value, cellMeta, record, rowIndex, columnIndex, store){return value+"%";}},
							{header: "例行</br>接口稽核回归", width:60, align:'center',sortable: true, dataIndex: 'publishInterPassPrecent',renderer:function(value, cellMeta, record, rowIndex, columnIndex, store){return value+"%";}}
							]
				}
				 
	    	]
		});
	var mainPanel = Ext.create('Ext.panel.Panel', {
		width: screenWidth*.99,
	    height: screenHeight*.96,
	    renderTo: Ext.getBody(),
	    layout: {
	        type: 'vbox',      
	        align: 'stretch', 
	        padding: 0
	    },
	    items:[Grid]
	});
	});
	
</script>
</html>