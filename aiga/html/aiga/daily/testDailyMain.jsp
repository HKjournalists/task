<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@page import="com.asiainfo.aiga.common.CommonUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<%
	String formUrl=request.getParameter("formUrl"); 
	String dailyId=request.getParameter("dailyId");
	boolean isShowGrid=(formUrl!=null&& !formUrl.equals(""));
	AigaUser user=CommonUtil.getSessionUser(request);
%>
<html>
<head>
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

function cleanFormValue(){
   	Ext.getCmp("passCaseNumber").setValue(null);
   	Ext.getCmp("sumCaseNumber").setValue(null); 
   	Ext.getCmp("deffectFinishendNumber").setValue(null); 
   	Ext.getCmp("deffectUnfinishendNumber").setValue(null); 
   	Ext.getCmp("deffectSumNumber").setValue(null); 
   	Ext.getCmp("testExceptionEffect").setValue(null);
   	Ext.getCmp("testOrderlistStatusCombox").setValue(null);
   	Ext.getCmp("mainProcessIsPassCombox").setValue(null);
}
var rightTargetReportMenu = new Ext.menu.Menu({
	items: [{
		id:'editTask',
    	text: '修改日报',
    	handler: function(){
     		var models=Ext.getCmp('dailyGrid').getSelectionModel().getSelection();
    		if(models.length!=1){
    			Ext.Msg.alert("提示","选择错误!");
    		}
	        var testDailyFormWin = new top.Ext.window.Window({
			 	id:'testDailyFormWin',
				title : '修改日报',
				width : 610,
				height : 400,
				modal : true,
				autoScroll:true,
				listeners:{
					destroy:function(window,eOpts){
						var planStore=Ext.data.StoreManager.lookup("dailyStore");
						planStore.reload();
					}
				},
				closeAction : 'destroy',
				html:'<iframe  style="overflow:hidden;" id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/daily/testDaliyManage.jsp?dailyId='+models[0].data.dailyId+'" width="600" height="398"/>'
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
Ext.define('EmptyStaffForDaily', {
	extend: 'Ext.data.Model',
	fields:[
		{name:'staffId', type:'int', convert: null,defaultValue:null},
		{name:'staffName', type:'string', defaultValue: '-查自己-'},
		{name:'displayName', type:'string', defaultValue: '-查自己-'}
	]
});
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.tip.QuickTipManager.init();
	
	var testOrderlistStatusModel= Ext.define('mapModel', {
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
	var testOrderlistStatusStore=new  Ext.data.Store({
		autoLoad: true,
		id: 'testOrderlistStatusStore',
		model:testOrderlistStatusModel,
		groupField: 'categoryName',
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getMultipleSysConstant.do?categorys=AIGA_TEST_DAILY',
			reader: {
				type: 'json',
				root: 'data'
			}
		}
	});
	testOrderlistStatusStore.load();
	var mainProcessIsPassModel= Ext.define('mapModel', {
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
	var mainProcessIsPassStore=new  Ext.data.Store({
		autoLoad: true,
		id: 'mainProcessIsPassStore',
		model:mainProcessIsPassModel,
		groupField: 'categoryName',
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getMultipleSysConstant.do?categorys=MAIN_PROCESS_IS_PASS',
			reader: {
				type: 'json',
				root: 'data'
			}
		}
	});
	mainProcessIsPassStore.load();
	var testOrderlistStatusCombox = new Ext.form.ComboBox({
    	id:'testOrderlistStatusCombox',
        width: 240,
        store: testOrderlistStatusStore,
        allowBlank: false,
        labelAlign: 'right',
		forceSelection: true,
		mode: 'local',//申明本属性即可实现过滤  
        name: "testOrderlistStatus",
        fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>测试工单状态",
        valueField: 'value',
        displayField: 'show',
        listeners: {
            beforequery: function (queryEvent, eOpts) {
                queryEvent.query = "testOrderlistStatus";
            }
        }
    });
	var mainProcessIsPassCombox = new Ext.form.ComboBox({
    	id:'mainProcessIsPassCombox',
        width: 240,
        store: mainProcessIsPassStore,
        allowBlank: false,
        labelAlign: 'right',   
		forceSelection: true,
		mode: 'local',//申明本属性即可实现过滤  
        name: "mainProcessIsPass",
        fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>测试主流程是否通过",
        valueField: 'value',
        displayField: 'show',
        listeners: {
            beforequery: function (queryEvent, eOpts) {
                queryEvent.query = "mainProcessIsPass";
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
	//add by yinsx 添加子任务类型查询条件
	var subTaskTypeStore = new Ext.data.Store({
	 	autoLoad: true,
	 	id: 'subTaskTypeStore',
	    fields: ['value','show','other2'],
	    proxy: {
	    	type: 'ajax',
	        url: '<%=request.getContextPath()%>/getSysParam.do?category=SUB_TASK_TYPE'+'&_='+(new Date()).getTime(),
	        reader: {
	        	type: 'json',
	        	root: 'data'
	        }
	    },
	    listeners:{
	    	load:function(store,records){
	    		var blankRecord={
	    				show:'--请选择--'
        		}
        		store.insert(0,blankRecord);
	    	}
	    
	    }
	});
	 var workflowParamStore = new Ext.data.Store({
         id: 'workflowParamStore',
         fields: ['phaseId', 'linkId', 'phaseName', 'vmTaskName'],
         proxy: {
             type: 'ajax',
             url: '<%=request.getContextPath()%>/getWorkflowParam.do',
             reader: {
                 type: 'json',
                 root: 'data'
             }
         },
         listeners:{
         	load:function(store,records,successful,eOpts){
         		var blankRecord={
         				phaseName:'--全部--',
         				vmTaskName:'--全部--'
         		}
         		store.insert(0,blankRecord);
         	}
         }
     });
	//add by yinsx 添加子任务状态查询条件
	 var testTaskStatusCombox = new Ext.form.ComboBox({
			width:210,
	        labelWidth: 70,
            labelAlign: 'right',
            id:'subTaskStatus',
            store: workflowParamStore,
            name: 'subTaskStatus',
            fieldLabel: '子任务状态',
            forceSelection:true,
            typeAhead:true,
            minChars:1,
            selectOnFocus: true,
            triggerAction: 'all',
            queryMode: 'local',
            valueField: 'linkId',
            displayField: 'vmTaskName',
            listeners: {}
    });
 	
	var dailyForm = Ext.widget('form',{
		id: 'dailyForm',
		layout: 'vbox',
		title: '创建日报',
		width: screenWidth*0.99*0.41,
		height: screenHeight*0.58,
		tbar: [{
			xtype: 'button',
		    text: '保存',
		 	handler:function(){
		        var form=Ext.getCmp("dailyForm");
		        MaskLoading();
	            form.submit({
					url:"<%=request.getContextPath()%>/saveTestDailyForm.do",
				  	params : {},
				  	method:'POST',  
	                success:function(response,config){
		 				MaskOver();
	                    var success = config.result.success;// 当后台数据同步成功时  
	                    if (success) {
	                    	Ext.data.StoreManager.lookup('dailyStore').reload();
	                    }
					   	Ext.getCmp("subTaskId").setValue(null);
					   	Ext.getCmp("subTaskTag").setValue(null);  
					   	Ext.getCmp("subTaskName").setValue(null); 
	                    cleanFormValue();
	                    Ext.Msg.alert("提示","保存成功!");
	                },
	                failure:function(response,config){
		 		    	MaskOver();
		 		    	if(config.failureType=="client"){
                    		Ext.Msg.alert("提示","请填写完所有(<font style='color: red; font-weight:bold;'>*</font>)必填项!");
                    	}else if(config.failureType =="connect"){
                    		Ext.Msg.alert("提示","网络连接失败,请联系网络管理员!");
                    	}else{
                    		Ext.Msg.alert("错误提示",config.result.msg);
                    	}
						
					}
	            });
			}
		}],
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
				<% if(isShowGrid){%>
				dailyForm.load({
					params:{dailyId :<%=dailyId%>,staffId:'<%=user.getUserId()%>'},  
					url:'<%=request.getContextPath()%>/getTestDailyList.do',
					method:'POST',  
					success:function(form,action){},  
					failure:function(form,action){  
						Ext.Msg.alert("提示","失败原因是: "+action.result.errorMessage);  
					}
				});
				<%}%>
			}
		},
		items: [{
	        xtype: 'fieldcontainer', 
	        labelStyle: 'font-weight:bold;padding:0', 
	        layout: 'vbox', 
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
			        fieldLabel: '',
			        layout:'hbox',
			        fieldDefaults: { 
			            labelAlign: 'right' 
			        },
			        items: [
			        	{	
		                	name: 'staffName',
		                	id:'staffName',
		                	readOnly:true,
		                    fieldLabel: "测试人员(日志所有者)",
		                    hidden:true
		                },{	
		                	name: 'editStaffId',
		                	id:'editStaffId',
		                	readOnly:true,
		                    fieldLabel: "日志填写人员ID",
		                    hidden:true
		                },{	
		                	name: 'editStaffName',
		                	id:'editStaffName',
		                	readOnly:true,
		                    fieldLabel: "日志填写人员名称",
		                    hidden:true
		                },{	
		                	name: 'editStaffCode',
		                	id:'editStaffCode',
		                	readOnly:true,
		                    fieldLabel: "日志填写人员帐号",
		                    hidden:true
		                },{	
		                	name: 'staffId',
		                	id:'staffId',
		                	readOnly:true,
		                    fieldLabel: "测试Id(日志所有者)",
		                    hidden:true
		                },{	
		                	name: 'subTaskTag',
		                	id:'subTaskTag',
		                	readOnly:true,
		                    fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>测试子任务编号",
	                    	allowBlank: false
		                },
		                {	
			        		width:240,
		                	name: 'subTaskName',
		                	id:'subTaskName',
		                	readOnly:true,
		                    fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>测试子任务名称",
	                    	allowBlank: false
		                }
		                ]
		            },{
			        defaultType: 'textfield', 
			        xtype: 'fieldcontainer', 
			        labelStyle: 'font-weight:bold;padding:0', 
			        fieldLabel: '',
			        layout:'hbox',
			        fieldDefaults: { 
			            labelAlign: 'right' 
			        },
			        items: [{
				        	width:240,
		                	name:"sumCaseNumber",
		                	id:"sumCaseNumber",
		                	regex : /^([0-9]+)$/,
		                	regexText : "对不起，只能输入数字！",
		                    fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>总用例数",
	                    	allowBlank: false
		                },{	
		                	width:240,
		                	name:"passCaseNumber",
		                	id:"passCaseNumber",
		                	regex : /^([0-9]+)$/,
		                	regexText : "对不起，只能输入数字！",
		                    fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>通过用例数",
	                    	allowBlank: false,
	                    	listeners : {
		                    	change:function( field,newValue,oldValue,eOpts ){
		                    		var sumCaseNumber=Ext.getCmp('dailyForm').getForm().findField('sumCaseNumber').getValue();
		                    		if(Number(sumCaseNumber)<Number(newValue)&&sumCaseNumber!=""){
		                    			Ext.Msg.alert("提示","通过用例数必须小于等于总用例数");field.setValue('') ;
		                    			Ext.getCmp('dailyForm').getForm().findField('sumCaseNumber').setValue('');
		                    		}
		                    	}
	                    	}
		                } ]
		            },{
			        defaultType: 'textfield', 
			        xtype: 'fieldcontainer', 
			        labelStyle: 'font-weight:bold;padding:0', 
			        fieldLabel: '',
			        layout:'hbox',
			        fieldDefaults: { 
			            labelAlign: 'right' 
			        },
			        items: [{
		                	width:240,
		                	name:"deffectSumNumber",
		                	id:"deffectSumNumber",
		                	regex : /^([0-9]+)$/,
		                	regexText : "对不起，只能输入数字！",
		                	fieldLabel : "<font style='color: red; font-weight:bold;'>*</font>缺陷总数",
	                    	allowBlank: false,
	                    	listeners : {
		                    	change:function( field,newValue,oldValue,eOpts ){
               						var deffectUnfinishendNumber=Ext.getCmp('dailyForm').getForm().findField('deffectUnfinishendNumber').getValue();
		                    		var deffectFinishendNumber=Ext.getCmp('dailyForm').getForm().findField('deffectFinishendNumber').getValue();
		                    		if((Number(deffectUnfinishendNumber)+Number(deffectFinishendNumber))>Number(newValue)&&deffectUnfinishendNumber!=""&&deffectFinishendNumber!=""){
		                    			Ext.Msg.alert("提示","已解决缺陷数与未解决缺陷数之和必须小于等于缺陷总数");field.setValue('') ;
		                    			Ext.getCmp('dailyForm').getForm().findField('deffectUnfinishendNumber').setValue('');
		                    			Ext.getCmp('dailyForm').getForm().findField('deffectFinishendNumber').setValue('');
		                    		}
		                    	}
	                    	}
		                },{width:240,
		                	name:"deffectFinishendNumber",
		                	id:"deffectFinishendNumber",
		                	regex : /^([0-9]+)$/,
		                	regexText : "对不起，只能输入数字！",
		                	fieldLabel : "<font style='color: red; font-weight:bold;'>*</font>已解决缺陷数",
	                    	allowBlank: false,
	                    	listeners : {
		                    	change:function( field,newValue,oldValue,eOpts ){
		                    		var deffectUnfinishendNumber=Ext.getCmp('dailyForm').getForm().findField('deffectUnfinishendNumber').getValue();
		                    		var deffectSumNumber=Ext.getCmp('dailyForm').getForm().findField('deffectSumNumber').getValue();
		                    		if((Number(deffectUnfinishendNumber)+Number(newValue))>Number(deffectSumNumber)&&deffectSumNumber!=""){
		                    			Ext.Msg.alert("提示","已解决缺陷数与未解决缺陷数之和必须小于等于缺陷总数");field.setValue('') ;
		                    		}
		                    	}
	                    	}
		                }]
		            },{
		            	defaultType: 'textfield', 
		                xtype: 'fieldcontainer', 
		                labelStyle: 'font-weight:bold;padding:0', 
		                fieldLabel: '',
		                layout:'hbox',
		                fieldDefaults: { 
		                    labelAlign: 'right' 
		                },
		                items: [
		                {width:240,
		                	name: 'deffectUnfinishendNumber',
		                	id: 'deffectUnfinishendNumber',
		                	regex : /^([0-9]+)$/,
		                	regexText : "对不起，只能输入数字！",
		                    fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>未解决缺陷数",
	                    	allowBlank: false,
	                    	listeners : {
		                    	change:function( field,newValue,oldValue,eOpts ){
		                    		var deffectFinishendNumber=Ext.getCmp('dailyForm').getForm().findField('deffectFinishendNumber').getValue();
		                    		var deffectSumNumber=Ext.getCmp('dailyForm').getForm().findField('deffectSumNumber').getValue();
		                    		if((Number(deffectFinishendNumber)+Number(newValue))>Number(deffectSumNumber)&&deffectSumNumber!=""){
		                    			Ext.Msg.alert("提示","已解决缺陷数与未解决缺陷数之和必须小于等于缺陷总数");field.setValue('') ;
		                    		}
		                    	}
	                    	}
		                },
		                testOrderlistStatusCombox]
		            },{
		            	defaultType: 'textfield', 
		                xtype: 'fieldcontainer', 
		                labelStyle: 'font-weight:bold;padding:0', 
		                fieldLabel: '',
		                layout:'hbox',
		                fieldDefaults: { 
		                    labelAlign: 'right' 
		                },
		                items: [
		                mainProcessIsPassCombox]
		            },{
		            	defaultType: 'textfield', 
		                xtype: 'fieldcontainer', 
		                labelStyle: 'font-weight:bold;padding:0', 
		                fieldLabel: '',
		                layout:'hbox',
		                fieldDefaults: { 
		                    labelAlign: 'right' 
		                },
		                items: [
		                {
	                	width: 500,
	                	height:70,
	                	xtype:"textareafield",
	                    name: 'testExceptionEffect',
	                    id: 'testExceptionEffect',
	                    fieldLabel: "测试异常事件"
	            	}]
		            }
	                
                ]
            },{
                xtype: 'fieldcontainer', 
                labelStyle: 'font-weight:bold;padding:0', 
                layout: 'hbox', 
                defaultType: 'textfield', 
                fieldDefaults: { 
                    labelAlign: 'right' 
                }, 
        		items: [
	            	
	                {	
	                	xtype:"hidden",
	                    name: 'staffId',
	                    value:"<%=user.getUserId()%>",
	                    fieldLabel: '用户id',
	                    allowBlank: false
	                },
	                {	
	                	xtype:"hidden",
	                    name: 'subTaskId',
	                    id: 'subTaskId',
	                    fieldLabel: '测试子任务id',
	                    allowBlank: false
	                }
                ]
            }
		]
	});
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
	 		{name:'subTaskType',type:'string'}, 
	 		{name:'subTaskStatus',type:'int'},
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
	var StaffRoleViewModel = Ext.define('StaffRoleViewModel', {
        extend: 'Ext.data.Model',
        fields: [{
                name: 'staffId',
                type: 'string'
            },{
                name: 'staffCode',
                type: 'string'
            }, {
                name: 'staffName',
                type: 'string'
            }, {
                name: 'roleCode',
                type: 'string'
            }, {
                name: 'organizeId',
                type: 'string'
            }, {
                name: 'organizeName',
                type: 'string'
            }, {
                name: 'parentOrganizeId',
                type: 'string'
            }, {
                name: 'staffWorkdayCoefficient',
                type: 'int'
            }, {
                name: 'displayName',
                type: 'Srting'
            }
        ]
    });
	var testorStore = Ext.create('Ext.data.Store', {
	    id: 'testorStore',
		model:StaffRoleViewModel,
		proxy:Ext.create('Ext.data.proxy.Ajax',{
			type:"ajax",
			url:'<%=request.getContextPath()%>/getStaffRoleViews.do?roleCode=WF_TEST_PFR',
			reader:{
				root:"data",
				type:"json"
			}
		}),
       listeners:{
           load : function(store, records, options ){
               store.each(function(record){
   		           record.set('displayName',record.get('staffCode')+':'+record.get('staffName'));
   		   	   });
               var rs = Ext.create("EmptyStaffForDaily");
               store.insert(0,rs);  
               return true;
           }
        }
	});
	testorStore.load();
	
	var testorStoreForDaily = Ext.create('Ext.data.Store', {
	    id: 'testorStoreForDaily',
		model:StaffRoleViewModel,
		proxy:Ext.create('Ext.data.proxy.Ajax',{
			type:"ajax",
			url:'<%=request.getContextPath()%>/getStaffRoleViews.do?roleCode=WF_TEST_PFR',
			reader:{
				root:"data",
				type:"json"
			}
		}),
       listeners:{
           load : function(store, records, options ){
               store.each(function(record){
   		           record.set('displayName',record.get('staffCode')+':'+record.get('staffName'));
   		   	   });
               var rs = Ext.create("EmptyStaffForDaily");
               store.insert(0,rs);
               return true;
           }
        }
	});
	testorStoreForDaily.load({params:{roleCode:'WF_TEST_PFR'}});
	var other2Type = "";
	var subTaskGrid = Ext.create('Ext.grid.Panel',{
		id:'subTaskGrid',
        cls: 'ui-formPanel',
		title:'子任务列表',
        margins : '0 0 0 3',
        height:227,
		height: screenHeight*0.399,
        width: screenWidth,
        tbar:[
        	{ 
				width:240,
		        labelWidth: 100,
		        xtype: 'textfield', 
		        name: 'searchSubTaskName',
		        id: 'searchSubTaskName',
				fieldLabel: '测试子任务名称',
			},{ 
				width:240,
		        labelWidth: 100,
		        xtype: 'textfield', 
		        name: 'searchSubTaskTag',
		        id: 'searchSubTaskTag',
				fieldLabel: '测试子任务编号',
			},{
			    name: "searchStaffForSubTask",
			    id: "searchStaffForSubTask",
	    		fieldLabel:'测试人员',
	    		xtype:'combo',
				width:200,
		        labelWidth: 60,
	    		forceSelection:true,
                typeAhead:true,
                minChars:1,
                selectOnFocus: true,
                triggerAction: 'all',
                queryMode: 'local',
	    		store:testorStoreForDaily,
	           	displayField:'displayName',
	           	valueField:'staffId',
	           	mode:'local'
	    	},{
	    		xtype:'combo',
	    		name:'subTaskType',
	    		id:'subTaskType',
	    		fieldLabel:'子任务类型',
				width:210,
		        labelWidth: 70,
	    		store:'subTaskTypeStore',
	    		displayField:'show',
	    		valueField:'value',
	    		listeners:{
			    	change: function(combo, newValue, oldValue, eOpts) {
		    			Ext.getCmp('subTaskStatus').clearValue();
		    			var other2 = "";
		    			for(var s = 0; s < Ext.StoreMgr.get('subTaskTypeStore').getCount(); s++) {
		    				var tempVal = Ext.StoreMgr.get('subTaskTypeStore').getAt(s).get('value');
		    				if(tempVal == newValue) {
		    					other2 = Ext.StoreMgr.get('subTaskTypeStore').getAt(s).get("other2");
		    					other2Type=other2;
			    				break;
		    				}
			    		}
		    	    	Ext.StoreMgr.get('workflowParamStore').setProxy(
		    		    {
		    			     type: 'ajax',
				             url: '<%=request.getContextPath()%>/getWorkflowParam.do?query='+other2,
				             reader: {
				        	 type: 'json',
				        	 root: 'data'
				    	   	 }
				        });
		    		    Ext.StoreMgr.get('workflowParamStore').load();
		    	}
		    }},
		    testTaskStatusCombox,
	    	{
    			width: 40,
    			margin: '0 0 0 20px',
				xtype:'button',
				text: '搜索',
				handler: function() {
					var searchSubTaskName=Ext.getCmp("searchSubTaskName");
					var searchSubTaskTag=Ext.getCmp("searchSubTaskTag");
					var searchSubTaskType=other2Type;
					var searchSubTaskStatus=Ext.getCmp('subTaskStatus').getValue();
					subTaskStore.reload({params:{staffId:'<%=user.getUserId()%>',subTaskName:encodeURI(encodeURI(searchSubTaskName.rawValue)),searchStaffId:Ext.getCmp('searchStaffForSubTask').getValue(),subTaskTag:encodeURI(encodeURI(searchSubTaskTag.rawValue)),subTaskType:searchSubTaskType,subTaskStatus:searchSubTaskStatus}});
				}
			}
		],
		forctFit:true,
        stripeRows:true,
        loadMask:true, 
		store: subTaskStore,
		selType:'rowmodel',
		listeners : {
			itemdblclick:function(grid,record,item,index,e,eOpts){
				var models=Ext.getCmp('subTaskGrid').getSelectionModel().getSelection();
	        	if(models.length!=1){
	        		Ext.Msg.alert("提示","选择错误!");
	        		return false;
	        	}
	        	var flag = "false";
	        	Ext.Ajax.request({
					async:false,
					url:'<%=request.getContextPath()%>/checkTestDailyWriteable.do?staffId='+models[0].data.testorId+'&subTaskId='+models[0].data.subTaskId,
					success:function(response,config){
						var json=Ext.JSON.decode(response.responseText);
						if(json.success==true){//已经填写
							flag=json.msg;
							var testDailyFormWin = new top.Ext.window.Window({
							 	id:'testDailyFormWin',
								title : '修改日报',
								width : 615,
								height : 489,
								modal : true,
								autoScroll:true,
								listeners:{
									destroy:function(window,eOpts){
										var planStore=Ext.data.StoreManager.lookup("dailyStore");
										planStore.reload();
									}
								},
								closeAction : 'destroy',
								html:'<iframe  style="overflow:hidden;" id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/daily/testDaliyManage.jsp?dailyId='+flag+'" width="600" height="450"/>'
							}).show();
							flag="false";
						}
					}
				});
	        	if(flag!="false"){
	        		return false;
	        	}else{
	        		Ext.getCmp("subTaskId").setValue(models[0].data.subTaskId);
				   	Ext.getCmp("subTaskTag").setValue(models[0].data.subTaskTag);  
				   	Ext.getCmp("subTaskName").setValue(models[0].data.subTaskName);
				   	Ext.getCmp("staffName").setValue(models[0].data.testorName);
				   	Ext.getCmp("staffId").setValue(models[0].data.testorId);
				    Ext.getCmp("editStaffCode").setValue("<%=user.getUserAccount()%>");
				   	Ext.getCmp("editStaffId").setValue("<%=user.getUserId()%>");
		        	cleanFormValue();
	        	}
	        	/*
	        	if(models[0].data.testorId==<%=user.getUserId()%>){
		        	Ext.getCmp("subTaskId").setValue(models[0].data.subTaskId);
		        	Ext.getCmp("subTaskTag").setValue(models[0].data.subTaskTag);  
		        	Ext.getCmp("subTaskName").setValue(models[0].data.subTaskName);
	        	}else{
	        		Ext.Msg.alert("提示","请不要填写别人的日报!");
	        		return false;
	        	} 
				*/
			}
		},
		columns:[
			new Ext.grid.RowNumberer(),
			{header: "id", width:100, sortable: true, dataIndex: 'subTaskId',hidden:true},
			{header: "测试子任务编号", width:200, sortable: true, dataIndex: 'subTaskTag'},
			{header: "关联测试任务编号", width:200, sortable: true, dataIndex: 'taskTag'},
			{header: "测试子任务名称", width:200, sortable: true, dataIndex: 'subTaskName'},
			{header: "关联需求编号", width:100, sortable: true, dataIndex: 'reqId',hidden:true},
			{header: "子任务派发人", width:100, sortable: true, dataIndex: 'creator',hidden:true},
			{header: "子任务状态", width:100, sortable: true, dataIndex: 'subTaskStatus',hidden:true},
			{header: "子任务创建时间", width:200, sortable: true, dataIndex: 'createTime'},
			{header: "计划上线时间", width:200, sortable: true, dataIndex: 'factCompleteTime'},
			{header: "子任务优先级", width:100, sortable: true, dataIndex: 'subTaskPriority',hidden:true},
			{header: "开发任务工时", width:150, sortable: true, dataIndex: 'devWorkDay',hidden:true},
			{header: "测试任务工时", width:150, sortable: true, dataIndex: 'testWorkDay',hidden:true},
			{header: "生产环境可测性", width:100, sortable: true, dataIndex: 'possibleProduct',hidden:true},
			{header: "准发布环境可测性", width:100, sortable: true, dataIndex: 'possibleBack',hidden:true},
			{header: "测试环境可测性", width:100, sortable: true, dataIndex: 'possibleTest',hidden:true},
			{header: "是否性能测试", width:100, sortable: true, dataIndex: 'isPerformance',hidden:true},
			{header: "测试人ID", width:100, sortable: true, dataIndex: 'testorId',hidden:true},
			{header: "测试人员", width:100, sortable: true, dataIndex: 'testorName'},
			{header: "子任务单状态", width:100, sortable: true, dataIndex: 'subTaskType'}
	    	]
    	
	});
	
	var dailyStore = Ext.create('Ext.data.Store', {
		storeId:'dailyStore',
		fields:[
	        {name:'dailyId',type:'string'}, 
	 		{name:'subTaskTag',type:'string'}, 
	 		{name:'subTaskName',type:'string'}, 
	 		{name:'sumCaseNumber',type:'string'},
	        {name:'passCaseNumber',type:'string'}, 
	 		{name:'testOrderlistStatus',type:'string'},
	 		{name:'subTaskType',type:'string'}, 
	 		{name:'deffectSumNumber',type:'string'},
	 		{name:'deffectFinishendNumber',type:'string'},
	 		{name:'deffectUnfinishendNumber',type:'string'},
	 		{name:'testExceptionEffect',type:'string'},
	 		{name:'mainProcessIsPass',type:'string'},
	 		{name:'testProgressUnfinished',type:'string'},
	 		{name:'staffId',type:'string'},
	 		{name:'staffCode',type:'string'},
	 		{name:'staffName',type:'string'},
	 		{name:'commitTime',type:'string'},
	        {name:'subTaskId',type:'string'},
	 		{name:'subTaskStatus',type:'int'}
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
		width: screenWidth*0.99*0.6,
		height: screenHeight*0.589,
        tbar:[
        	{
				width:200,
		        xtype: 'datefield', 
		        name: 'searchTime',
		        id: 'searchTime',
		        format: 'Y-m-d',
				fieldLabel: '日报日期',
			},{
			    name: "searchStaffForDaily",
			    id: "searchStaffForDaily",
	    		fieldLabel:'测试人员',
	    		xtype:'combo',
	    		forceSelection:true,
                typeAhead:true,
                minChars:1,
                selectOnFocus: true,
                triggerAction: 'all',
                queryMode: 'local',
	    		store:testorStore,
	           	displayField:'displayName',
	           	valueField:'staffId',
	           	mode:'local'
	    	},{
				xtype:'button',
				text: '搜索',
				handler: function() {
					var dateTime=Ext.getCmp("searchTime");
					var staffId = Ext.getCmp("searchStaffForDaily").getValue();
					if(staffId!=""&&staffId!=null&&staffId!=undefined){
						dailyStore.reload({params:{staffId:staffId,commitTime :dateTime.rawValue}});
					}else{
						dailyStore.reload({params:{staffId:"<%=user.getUserId()%>",commitTime :dateTime.rawValue}});
					}
					
				}
			}
		],
		forctFit:true,
        stripeRows:true,
        loadMask:true, 
		store: dailyStore,
		listeners : {
			//itemcontextmenu : rightClickTargetFn,
			itemdblclick:function(grid,record,item,index,e,eOpts){
				var models=Ext.getCmp('dailyGrid').getSelectionModel().getSelection();
	    		if(models.length!=1){
	    			Ext.Msg.alert("提示","选择错误!");
	    			return false;
	    		}
	    		var d = new Date();
				var str = d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
	    		if((models[0].data.commitTime+"").substr(0,10)==str){
	    			var testDailyFormWin = new top.Ext.window.Window({
					 	id:'testDailyFormWin',
						title : '修改日报',
						width : 615,
						height : 489,
						modal : true,
						autoScroll:true,
						listeners:{
							destroy:function(window,eOpts){
								var planStore=Ext.data.StoreManager.lookup("dailyStore");
								planStore.reload();
							}
						},
						closeAction : 'destroy',
						html:'<iframe  style="overflow:hidden;" id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/daily/testDaliyManage.jsp?dailyId='+models[0].data.dailyId+'" width="600" height="450"/>'
					}).show();
	    		}else{
	    			Ext.Msg.alert("提示","对不起该条日志已经过期,不可修改!");
	    			return false;
	    		}
		        
			}
		},
		selType:'rowmodel',
		columns:[new Ext.grid.RowNumberer(),
			{header: "测试日报id", width:100, sortable: true, dataIndex: 'dailyId',hidden:true},
			{header: "测试子任务编号", width:100, sortable: true, dataIndex: 'subTaskTag'},
			{header: "测试子任务名称", width:100, sortable: true, dataIndex: 'subTaskName'},
			{header: "总用例数", width:80, sortable: true, dataIndex: 'sumCaseNumber'},
			{header: "通过用例数", width:80, sortable: true, dataIndex: 'passCaseNumber'},
			{header: "测试工单状态", width:80, sortable: true, dataIndex: 'testOrderlistStatus',renderer: function (value, cellmeta, record) {
                try {
                    var store = Ext.data.StoreManager.lookup("testOrderlistStatusStore");
                    store.clearFilter(true);
                    store.filter("categoryName", "testOrderlistStatus");
                    return store.findRecord("value", new RegExp("^" + value + "$")).getData().show + "";
                } catch (e) {
                    return "数据异常";
                };
            }},
			{header: "缺陷相关数据",align:'center', 
				columns:[
					    {header: "总数量", width:50, sortable: true, dataIndex: 'deffectSumNumber'},
						{header: "已完成", width:50, sortable: true, dataIndex: 'deffectFinishendNumber'},
						{header: "未完成", width:50, sortable: true, dataIndex: 'deffectUnfinishendNumber'}
						]
			},
			{header: "测试异常事件", width:100, sortable: true, dataIndex: 'testExceptionEffect'},
			{header: "测试测试主流程是否通过", width:100, sortable: true, dataIndex: 'mainProcessIsPass',renderer: function (value, cellmeta, record) {
                try {
                    var store = Ext.data.StoreManager.lookup("mainProcessIsPassStore");
                    store.clearFilter(true);
                    store.filter("categoryName", "mainProcessIsPass");
                    return store.findRecord("value", new RegExp("^" + value + "$")).getData().show + "";
                } catch (e) {
                    return "数据异常";
                };
            }},
			{header: "员工ID", width:100, sortable: true, dataIndex: 'staffId',hidden:true},
			{header: "员工帐号", width:100, sortable: true, dataIndex: 'staffCode',hidden:true},
			{header: "员工名称", width:100, sortable: true, dataIndex: 'staffName'},
			{header: "提交时间", width:100, sortable: true, dataIndex: 'commitTime'},
			{header: "测试子任务ID", width:100, sortable: true, dataIndex: 'subTaskId',hidden:true}
      	]
	});
	
	var daliyPanel = Ext.create('Ext.Panel', {
		id:'daliyPanel',
        cls: 'ui-formPanel',
		width: screenWidth,
		height: screenHeight*0.59,
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
			 items:[dailyForm]
		},{
			region: 'center',
			 items:[dailyGrid]
		}]
    });
	var subPanel = Ext.create('Ext.Panel', {
		id:'subPanel',
        cls: 'ui-formPanel',
		width: screenWidth,
		height: screenHeight*0.4,
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
			 items:[subTaskGrid]
		}]
    });
	Ext.create('Ext.Panel', {
		renderTo: Ext.getBody(),
        cls: 'ui-formPanel',
		width: screenWidth*0.999,
		height: screenHeight,
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
			 items:[subPanel,daliyPanel]
		}]
    });
});
</script>
</html>