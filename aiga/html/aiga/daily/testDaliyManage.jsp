<!DOCTYPE HTML>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");%>
<%@ include file="/aiga/common/common.jsp" %>
<%
	String dailyId = request.getParameter("dailyId");//日志主键
	if(dailyId == null){
		dailyId = "";
	}
%>
 
<html>
<head>
	<title>测试日志管理</title> 
</head>
  
<body>
	<div id="testDaliyPanel"></div>
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
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
        width: 270,
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
        width: 270,
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
   	
   	var dailyForm = Ext.widget('form',{
		id: 'dailyForm',
		layout: 'vbox',
		title: '日报详细信息',
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
	                    	top.Ext.getCmp("testDailyFormWin").close(); 
	                    }
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
		width:screenWidth,
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
				dailyForm.load({
					params:{dailyId :<%=dailyId%>},  
					url:'<%=request.getContextPath()%>/getTestDailyList.do',
					method:'POST',  
					success:function(form,action){
					    Ext.getCmp("editStaffCode").setValue("<%=user.getUserAccount()%>");
					   	Ext.getCmp("editStaffId").setValue("<%=user.getUserId()%>");
					},  
					failure:function(form,action){  
						Ext.Msg.alert('提示',"失败原因是: "+action.result.errorMessage);  
					}
				});
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
			        fieldLabel: '',
			        layout:'vbox',
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
		                	name: 'commitTime',
		                	readOnly:true,
		                    fieldLabel: "日志创建日期",
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
			        		width:270,
		                	name: 'subTaskTag',
		                	id:'subTaskTag',
		                	readOnly:true,
		                    fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>测试子任务编号",
	                    	allowBlank: false
		                },{
				        	width:270,
		                	name:"sumCaseNumber",
		                	regex : /^([0-9]+)$/,
		                	regexText : "对不起，只能输入数字！",
		                    fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>总用例数",
	                    	allowBlank: false
		                },{	
		                	width:270,
		                	name:"passCaseNumber",
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
		                },
		                testOrderlistStatusCombox,
		                mainProcessIsPassCombox
		                ]
		            },{
		            	defaultType: 'textfield', 
		                xtype: 'fieldcontainer', 
		                labelStyle: 'font-weight:bold;padding:0', 
		                fieldLabel: '',
		                layout:'vbox',
		                fieldDefaults: { 
		                    labelAlign: 'right' 
		                },
		                items: [
		                {	
			        		width:270,
		                	name: 'subTaskName',
		                	id:'subTaskName',
		                	readOnly:true,
		                    fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>测试子任务名称",
	                    	allowBlank: false
		                },
		                {
		                	width:270,
		                	name:"deffectSumNumber",
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
		                },{width:270,
		                	name:"deffectFinishendNumber",
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
		                },{width:270,
		                	name: 'deffectUnfinishendNumber',
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
	                	width: 540,
	                	height:170,
	                	xtype:"textareafield",
	                    name: 'testExceptionEffect',
	                    fieldLabel: "测试异常事件"
	            	},
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
   	Ext.create('Ext.Panel', {
    	id:'testElemPanel',
        renderTo: Ext.get('testDaliyPanel'),
        cls: 'ui-formPanel',
        width: screenWidth,
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
        items: [{
            region: 'center',
            items: [dailyForm]
        }]
    });
});
</script>
</html>