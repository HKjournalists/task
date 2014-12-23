<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@page import="com.asiainfo.aiga.common.CommonUtil"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="UTF-8"%>

    <%String planId=request.getParameter("planId"); 
    String taskId=request.getParameter("taskId");
    boolean isShowTask=(taskId!=null&& !taskId.equals(""));
    boolean isShowPlan=(planId!=null&& !planId.equals(""));
    AigaUser user=CommonUtil.getSessionUser(request);
    %>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/extJs/resources/css/ext-all.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/extJs/ext-all.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/extJs/plugin/DateTimePicker.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/extJs/plugin/DateTime.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/extJs/ext.bug.fix.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/base/jquery-1.8.0.js" ></script>
	<title>日报</title>
	<style type="text/css">
		#uploadForm-body table {
			float: left;
		}
		
		#uploadForm-body div {
			float: left;
		}
	</style>
</head>
<body>
</body>

<script type="text/javascript">
var planId="${param.planId}";
var taskId="${param.taskId}";
var extjsFolderPath='<%=request.getContextPath()%>/extJs';
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
function removeHTMLTag(str) {
    str = str.replace(/<\/?[^>]*>/g,''); //去除HTML tag
    str = str.replace(/[ | ]*\n/g,'\n'); //去除行尾空白
    //str = str.replace(/\n[\s| | ]*\r/g,'\n'); //去除多余空行
    str=str.replace(/&nbsp;/ig,'');//去掉&nbsp;
    return str;
}
function rightClickTargetFn(view,record,item,index,e,eOpts){   
 	e.preventDefault();   
	rightTargetReportMenu.showAt(e.getXY());
}
var rightTargetReportMenu = new Ext.menu.Menu({
items: [
{
	id:'editTask',
    text: '编辑日报',
    handler: function(){
     	var models=Ext.getCmp('dailyGrid').getSelectionModel().getSelection();
    	if(models.length!=1){
    		Ext.Msg.alert("提示","选择错误!");
    	}
       var taskFormWin = new top.Ext.window.Window({
		 		id:'taskFormWin',
			    title : '编辑日报',
			    width : 1050,
			    height : 600,
			    modal : true,
			    autoScroll:true,
			    listeners:{
					destroy:function(window,eOpts){
					var planStore=Ext.data.StoreManager.lookup("dailyStore");
						planStore.reload();
					}
			    },
			    closeAction : 'destroy',
			    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/daily/testDailyMain.jsp?formUrl=testDailyList&dailyId='+models[0].data.dailyId+'" width="1050" height="600"/>'
			}).show();
    }
    }]
});
function getArrayBycategoryName(categoryName){
	var  records=new Array();
	$.getJSON("<%=request.getContextPath()%>/getComBoxMap.do",{},function(data){
		records=data.data;
	var bigArray=new Array();
	for(var i=0,n=records.length;i<n;i++){
		if(records[i].categoryName==categoryName){
			var subArray=new Array();
			subArray.push(records[i].value);
			subArray.push(records[i].show);
			bigArray.push(subArray);
		}
	}
	return bigArray;
	});

}
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.tip.QuickTipManager.init();
	/////map 
		var mapModel= Ext.define('mapModel', {
	    extend: 'Ext.data.Model',
	    fields: [
	        {name: 'constantId',  type: 'string'},
	        {name: 'categoryName', type: 'string'},
	        {name: 'category', type: 'string'},
	        {name: 'show', type: 'string'},
	        {name: 'value', type: 'int'},
	        {name: 'other1', type: 'string'},
	        {name: 'other2', type: 'string'},
	        {name: 'memo', type: 'string'}
	    ]
	});
	var mapStore=new  Ext.data.Store({
		autoLoad: true,
		id: 'mapStore',
		model:mapModel,
		groupField: 'categoryName',
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getComBoxMap.do',
			reader: {
				type: 'json',
				root: 'data'
			}
		}
	});
	mapStore.load();

	
	var taskStore = new Ext.data.Store({
		autoLoad: true,
		id: 'priorityStore',
		fields: ['value','show'],
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getComBox.do',
			reader: {
				type: 'json',
				root: 'data'
			}
		}
	});
	var taskStore = new Ext.data.Store({
		autoLoad: true,
		id: 'priorityStore',
		fields: ['value','show'],
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getComBox.do',
			reader: {
				type: 'json',
				root: 'data'
			}
		}
	});
	 Ext.apply(Ext.form.VTypes, {
		  verifycustomer : function(value) {//验证方法名
	 //验证方法
		}
		 });
var dailyForm = Ext.widget('form',{
				id: 'dailyForm',
				layout: 'vbox',
				title: '创建日报',
				
				 tbar: [{
		 xtype: 'button',
		  text: '保存',
		 
		    handler:function(){
		        var form=Ext.getCmp("dailyForm");
		        			MaskLoading();
	                        form.submit({
				  			url:"<%=request.getContextPath()%>/saveTestDailyForm.do",
				  			params : {
	                        },
				  			method:'POST',  
	                    	success:function(response,config){ 
	                    MaskOver();  
	                        	var success = config.result.success;  
	                            // 当后台数据同步成功时  
	                            if (success) {
	                            	Ext.data.StoreManager.lookup('taskStore').reload();
	                            }
	                        },
	                        failure:function(response,config){
	                    MaskOver();  
								Ext.Msg.alert("提示","数据修改失败!");
							}
				  		});  
		 
                }
		  }],
	
				width:screenWidth*0.5,
				bodyBorder: 0,

				fieldDefaults: {
				    labelAlign: 'right', 
				    labelWidth: 60
				}, 
				defaults: {
				    margins: '20 0 0 0' 
				},
				listeners:{
					render : function(render,eOpts){
						 <% if(isShowTask){%>
						taskForm.load({
							params:{taskId :taskId},  
							url:'<%=request.getContextPath()%>/getTaskForm.do',
							method:'POST',  
							success:function(form,action){
							 	
							},  
							failure:function(form,action){  
								Ext.Msg.alert('提示',"失败原因是: "+action.result.errorMessage);  
							}
						});
						<%}%>
					}
				},
				items: [{
	                xtype: 'fieldcontainer', 
	                labelStyle: 'font-weight:bold;padding:0', 
	                layout: 'hbox', 
	                defaultType: 'textfield', 
	                fieldDefaults: { 
	                    labelAlign: 'right' 
	                }, 
	        		
	                items: [
		                {
		                	xtype: "hidden",
		                	name:"dailyId",
		                },{
			            	defaultType: 'textfield', 
			                xtype: 'fieldcontainer', 
			                labelStyle: 'font-weight:bold;padding:0', 
			                fieldLabel: '测试任务进度',
			                layout:'vbox',
			                fieldDefaults: { 
			                    labelAlign: 'right' 
			                },
			                items: [{
			                	width:150,
			                	name:"testProgressFinish",
			                	regex : /^([0-9]+)$/,
			                	regexText : "对不起，只能输入数字！",
			                    fieldLabel: '已完成数量'
			                },{width:150,
			                	name:"testProgressIng",
			                	regex : /^([0-9]+)$/,
			                	regexText : "对不起，只能输入数字！",
			                    fieldLabel: '过程中数量'
			                },{width:150,
			                	name:"testProgressUnfinished",
			                	regex : /^([0-9]+)$/,
			                	regexText : "对不起，只能输入数字！",
			                    fieldLabel: '未开始数量'
			                }]
			            },{
			            	defaultType: 'textfield', 
			                xtype: 'fieldcontainer', 
			                labelStyle: 'font-weight:bold;padding:0', 
			                fieldLabel: '用例执行情况',
			                layout:'vbox',
			                fieldDefaults: { 
			                    labelAlign: 'right' 
			                },
			                items: [{
			                	width:150,
			                	name:"sumCaseNumber",
			                	regex : /^([0-9]+)$/,
			                	regexText : "对不起，只能输入数字！",
			                	fieldLabel : "用例总数"
			                },{width:150,
			                	name:"passCaseNumber",
			                	regex : /^([0-9]+)$/,
			                	regexText : "对不起，只能输入数字！",
			                	fieldLabel : "通过的用例数"
			                },{width:150,
			                	name: 'deffectNumber',
			                	regex : /^([0-9]+)$/,
			                	regexText : "对不起，只能输入数字！",
			                    fieldLabel: '缺陷数量'
			                }]
			            }
		                
	                ]
	            },
	            {
	                xtype: 'fieldcontainer', 
	                labelStyle: 'font-weight:bold;padding:0', 
	                layout: 'hbox', 
	                defaultType: 'textfield', 
	                fieldDefaults: { 
	                    labelAlign: 'right' 
	                }, 
	        		
	                items: [
		                 {
		                	width: 250,
		                	xtype:"textareafield",
		                    name: 'deffectEvent',
		                    fieldLabel: '缺陷事件',
		                    allowBlank: false
		                }, {
		                	width: 250,
		                	xtype:"textareafield",
		                    name: 'deffectSituation',
		                    fieldLabel: '缺陷情况',
		                    allowBlank: false
		                },
		                {	
		                	xtype:"hidden",
		                    name: 'staffId',
		                    value:"<%=user.getUserId()%>",
		                    fieldLabel: '用户id'
		                }
		                
	                ]
	            },
	            {
	                xtype: 'fieldcontainer', 
	                labelStyle: 'font-weight:bold;padding:0', 
	                layout: 'hbox', 
	                defaultType: 'textfield', 
	                fieldDefaults: { 
	                    labelAlign: 'right' 
	                }, 
	        		
	                items: [
		               
	                ]
	            }
]
			});
	/**
	private Integer subTaskId;
	private String subTaskTag;
	private String taskTag;
	private String subTaskName;
	private Integer reqId;
	private String creator;
	private Integer subTaskStatus;
	private Date createTime;
	private Date plCompleteTime;
	private Date factCompleteTime;
	private Integer subTaskPriority;
	private String devWorkDay;
	private String testWorkDay;
	private Integer possibleProduct;
	private Integer possibleBack;
	private Integer possibleTest;
	private Integer isPerformance;
	private Integer testorId;
	private String testorName;*/
	var subTaskStore = Ext.create('Ext.data.Store', {
		storeId:'subTaskStore',
		fields:[
		        {name:'subTaskId',type:'string'}, 
		        {name:'subTaskTag',type:'string'},
		        {name:'taskTag',type:'string'},
		        {name:'subTaskName',type:'string'},
		        {name:'reqId',type:'string'},
		        {name:'creator',type:'string'},
		        {name:'subTaskStatus',type:'string'},
		        {name:'createTime',type:'string'},
		        {name:'plCompleteTime',type:'string'},
		        {name:'factCompleteTime',type:'string'},
		        {name:'subTaskPriority',type:'string'},
		    	{name:'devWorkDay',type:'string'},
		    	{name:'testWorkDay',type:'string'},
		    	{name:'possibleProduct',type:'string'},
		    	{name:'possibleBack',type:'string'},
		    	{name:'possibleTest',type:'string'},
		    	{name:'isPerformance',type:'string'},
		    	{name:'testorId',type:'string'},
		    	{name:'testorName',type:'string'}
		        ],
	    proxy: {
	        type: 'ajax',
        	url : '<%=request.getContextPath()%>/getSubTaskList.do',
	        reader: {
	            root:"data",
				type:"json"
	        }
	    }
	});
	subTaskStore.load({params:{staffId:"<%=user.getUserId()%>"}});
	var subTaskGrid = Ext.create('Ext.grid.Panel',{
		id:'subTaskGrid',
        cls: 'ui-formPanel',
		title:'子任务列表',
        margins : '0 0 0 3',
        height:300,
        width: screenWidth*0.99,
        tbar:[{
			width:200,
	        xtype: 'datefield', 
	        name: 'searchTime',
	        id: 'searchSubTaskTime',
	        format: 'Y-m-d',
		fieldLabel: '提交时间',
	},{xtype:'button',
		text: '搜索',
		handler: function() {
			var dateTime=Ext.getCmp("searchSubTaskTime");
			subTaskStore.reload({params:{staffId:"<%=user.getUserId()%>",commitTime :dateTime.rawValue}});
			}}],
		forctFit:true,
        stripeRows:true,
        loadMask:true, 
		store: subTaskStore,
		selType:'rowmodel',
		columns:[new Ext.grid.RowNumberer(),
					{header: "id", width:100, sortable: true, dataIndex: 'subTaskId',hidden:true},
					{header: "测试子任务编号", width:100, sortable: true, dataIndex: 'subTaskTag'},
					{header: "关联测试任务编号", width:100, sortable: true, dataIndex: 'taskTag'},
					{header: "测试子任务名称", width:100, sortable: true, dataIndex: 'subTaskName'},
					{header: "关联需求编号", width:100, sortable: true, dataIndex: 'reqId',hidden:true},
					{header: "子任务派发人", width:100, sortable: true, dataIndex: 'creator'},
					{header: "子任务状态", width:100, sortable: true, dataIndex: 'subTaskStatus'},
					{header: "子任务创建时间", width:100, sortable: true, dataIndex: 'createTime'},
					{header: "计划完成时间", width:100, sortable: true, dataIndex: 'plCompleteTime'},
					{header: "子任务优先级", width:100, sortable: true, dataIndex: 'subTaskPriority'},
					{header: "开发任务工时", width:100, sortable: true, dataIndex: 'devWorkDay'},
					{header: "测试任务工时", width:100, sortable: true, dataIndex: 'testWorkDay'},
					{header: "生产环境可测性", width:100, sortable: true, dataIndex: 'possibleProduct'},
					{header: "准发布环境可测性", width:100, sortable: true, dataIndex: 'possibleBack'},
					{header: "测试环境可测性", width:100, sortable: true, dataIndex: 'possibleTest'},
					{header: "是否性能测试", width:100, sortable: true, dataIndex: 'isPerformance'},
					{header: "测试人ID", width:100, sortable: true, dataIndex: 'testorId',hidden:true},
					{header: "测试人名称", width:100, sortable: true, dataIndex: 'testorName',hidden:true}
	        		]
	});
	var dailyStore = Ext.create('Ext.data.Store', {
		storeId:'dailyStore',
		fields:[
/**
	private Integer dailyId;
	private String testPlanTag;
	private Integer testProgressFinish;
	private Integer sumCaseNumber;
	private Integer passCaseNumber;
	private Integer deffectNumber;
	private String deffectEvent;
	private String deffectSituation;
	private String staffId;
	private Integer staffCode;
	private String staffName;
	private Integer testProgressUnfinished;
	private Integer testProgressIng;
	private Timestamp commitTime;
	**/
		        {name:'dailyId',type:'string'}, 
		 		{name:'testPlanTag',type:'string'}, 
		 		{name:'testProgressFinish',type:'string'}, 
		 		{name:'sumCaseNumber',type:'string'},
		        {name:'passCaseNumber',type:'string'}, 
		 		{name:'deffectNumber',type:'string'},
		 		{name:'deffectEvent',type:'string'},
		 		{name:'deffectSituation',type:'string'},
		 		{name:'staffName',type:'string'},
		 		{name:'staffId',type:'string'},
		 		{name:'staffCode',type:'string'},
		 		{name:'testProgressUnfinished',type:'string'},
		 		{name:'testProgressIng',type:'string'},
		 		{name:'commitTime',type:'string'}
		 		],
	    proxy: {
	        type: 'ajax',
        	url : '<%=request.getContextPath()%>/getTestDailyList.do',
	        reader: {
	            root:"data",
				type:"json"
	        }
	    }
	});
	
	dailyStore.load({params: {staffId:"<%=user.getUserId()%>"}});
	
	var dailyGrid = Ext.create('Ext.grid.Panel',{
		id:'dailyGrid',
        cls: 'ui-formPanel',
		title:'日报列表',
        margins : '0 0 0 3',
        height:300,
        width: screenWidth*0.99,
        tbar:[{
			width:200,
	        xtype: 'datefield', 
	        name: 'searchTime',
	        id: 'searchTime',
	        format: 'Y-m-d',
		fieldLabel: '上线时间',
	},{xtype:'button',
		text: '搜索',
		handler: function() {
			var dateTime=Ext.getCmp("searchTime");
			dailyStore.reload({params:{staffId:"<%=user.getUserId()%>",commitTime :dateTime.rawValue}});
			}}],
		forctFit:true,
        stripeRows:true,
        loadMask:true, 
		store: dailyStore,
		listeners : {
			itemcontextmenu : rightClickTargetFn,
			itemdblclick:function(grid,record,item,index,e,eOpts){
				var models=Ext.getCmp('planGrid').getSelectionModel().getSelection();
	        	if(models.length!=1){
	        		Ext.Msg.alert("提示","选择错误!");
	        	}
				   var taskFormWin = new top.Ext.window.Window({
				 		id:'taskFormWinShow',
					    title : '查看计划单',
					    width : 1050,
					    height : 600,
					    modal : true,
					    autoScroll:true,
					    listeners:{
							destroy:function(window,eOpts){
							var planStore=Ext.data.StoreManager.lookup("planStore");
								planStore.reload();
								//var parentId = treeNode[0].raw.id; 
			                	//var node =Ext.data.StoreManager.lookup('caseTreeStore').getNodeById(parentId);   
	   							//Ext.data.StoreManager.lookup('caseTreeStore').load({node:node});
							}
					    },
					    closeAction : 'destroy',
					    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/daily/testPlan.jsp?status=show&planId='+models[0].data.planId+'" width="1050" height="600"/>'
					}).show();
			}
		},
		selType:'rowmodel',
		columns:[new Ext.grid.RowNumberer(),
					{header: "id", width:100, sortable: true, dataIndex: 'dailyId',hidden:true},
					{header: "测试计划编号", width:100, sortable: true, dataIndex: 'testPlanTag'},
					{header: "测试进度完成", width:100, sortable: true, dataIndex: 'testProgressFinish'},
					{header: "测试进度未完成", width:100, sortable: true, dataIndex: 'testProgressUnfinished'},
					{header: "测试进度进行中", width:100, sortable: true, dataIndex: 'testProgressIng'},
					{header: "用例总数", width:100, sortable: true, dataIndex: 'sumCaseNumber'},
					{header: "通过用例数", width:100, sortable: true, dataIndex: 'passCaseNumber'},
					{header: "缺陷数量", width:100, sortable: true, dataIndex: 'deffectNumber'},
					{header: "缺陷时间", width:100, sortable: true, dataIndex: 'deffectEvent'},
					{header: "缺陷情况", width:100, sortable: true, dataIndex: 'deffectSituation'},
					{header: "", width:100, sortable: true, dataIndex: 'staffName',hidden:true},
					{header: "", width:100, sortable: true, dataIndex: 'staffId',hidden:true},
					{header: "", width:100, sortable: true, dataIndex: 'staffCode',hidden:true},
					{header: "提交时间", width:100, sortable: true, dataIndex: 'commitTime'}
	        		]
	});
	Ext.create('Ext.Panel', {
		renderTo: Ext.getBody(),
        cls: 'ui-formPanel',
		width: screenWidth*0.99,
		height: screenHeight*0.99,
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
		items: [ {
			region: 'center',
			 items:[dailyGrid]
		}]
    });
});
</script>
</html>