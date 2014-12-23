<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");%>
<html>
    
    <head>
        <title>联调测试需求单</title>
    </head>
    <body>
       	<img id="loading" src="<%=request.getContextPath()%>/aiga/workflow/testTask/ajaxFileUpload/loading.gif" style="display:none;">
		<form name="form" action="" method="POST" enctype="multipart/form-data">
			<div id='uploadTestTaskDiv'></div>
		</form>
		<form style="display:none;" id="exportForm" action="<%=request.getContextPath()%>/downloadTemplateExcel.do?templateFileName=testPlanTemplate.xls&fileName=test_Plan_Template.xls"
			enctype="multipart/form-data" method="post" target="temp">
			<input type="hidden" name="method" value="export" />
			<input type="submit" id="download" class="tmpBtn" value="下载" />
		</form>
      	<div id="fileTrans"><jsp:include page="/aiga/attach/fileTrans.jsp"></jsp:include></div>
        <div id="planPanel"></div>
    </body>
    <script type="text/javascript">
        var extjsFolderPath = '<%=request.getContextPath()%>/extJs';
        var screenWidth = document.documentElement.clientWidth*0.999;
        var screenHeight = document.documentElement.clientHeight*0.92;
        var messageRemarksFlag = false;//造报文原因字段校验标识.
        var reasonRemarksFlag = false;//晚于集团要求原因说明.
        Ext.onReady(function () {
            Ext.QuickTips.init();
            Ext.tip.QuickTipManager.init();
            var dateFormat = Ext.Date.format(new Date, 'YmdHisu');
            //选择需求管理员
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
                    },  {
                        name: 'displayName',
                        type: 'string'
                    },{
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
                    }
                ]
            });
            var reqMgrStore = new Ext.data.Store({
                id: 'reqMgrStore',
                model: StaffRoleViewModel,
                proxy: {
                    type: 'ajax',
                    url: '<%=request.getContextPath()%>/getStaffRoleViews.do?staffId=<%=user.getUserId()%>&roleCode=WF_TEST_DMD',
                    reader: {
                        type: 'json',
                        root: 'data'
                    }
                },
                listeners: {
                	load:function(){
            			reqMgrStore.each(function(record){
            				record.set('displayName',record.get('staffCode')+':'+record.get('staffName'));
            			});
                	}
                	
                }
            });
            reqMgrStore.load({params:{staffId:'<%=user.getUserId()%>',roleCode:'WF_TEST_DMD'}});
            var reqMgrComboBox = new Ext.form.ComboBox({
                width: 250,
                mode:'remote',
                store: reqMgrStore,
                name: "reqManagerStaffName",
                id: "reqManagerStaffName",
                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>需求管理员",
                forceSelection:true,
	            typeAhead:true,
	            minChars:1,
	            selectOnFocus: true,
	            triggerAction: 'all',
	            allowBlank :false,
	            queryMode: 'local',
                valueField: 'staffName',
                displayField: 'displayName',
                editable:true,
                listConfig: {
                },
                listeners: {
                	select :function(combo,records, eOpts ){
                		Ext.getCmp('reqManagerStaffId').setValue(records[0].raw.staffId);
                	},
                    beforequery: function (queryEvent, eOpts) {
                    }
                }
            });
            var testPlanForm = Ext.widget('form', {
                id: 'testPlanForm',
                width: screenWidth,
                height: 282,
                autoScroll:true,
                tbar: [
                      /**
                       {
                        xtype: 'button',
                        text: '保存',
                        handler: function () {
                            var form = Ext.getCmp('testPlanForm');
                            MaskLoading();
                            form.submit({
                                clientValidation: true,
                                url: "<%=request.getContextPath()%>/saveTestPlanForm.do",
                                params: {},
                                method: 'POST',
                                success: function (response, config) {
                            		MaskOver();
                                    var success = config.result.success;
                                    // 当后台数据同步成功时  
                                    if (success) {
                                        Ext.Msg.alert("提示","保存成功!");
                                    }
                                },
                                failure: function (response, config) {
                            		MaskOver();
                            		Ext.Msg.alert("提示","数据修改失败!");
                                }
                            });
                        }
                    }, {
                        xtype: 'button',
                        text: '启动',
                        handler: function () {
                            var form = Ext.getCmp("testPlanForm");
                            MaskLoading();
                            form.submit({
                                clientValidation: true,
                                url: "<%=request.getContextPath()%>/runTestPlanForm.do",
                                params: {},
                                method: 'POST',
                                success: function (response, config) {
                            MaskOver();
                                    var success = config.result.success;
                                    // 当后台数据同步成功时  
                                    if (success) {
                                        Ext.data.StoreManager.lookup("taskStore").reload({
                                            params: {
                                                planTag: planTag,
                                                planFlag: planFlag,
                                                planId: planId
                                            }
                                        });
                                    }
                                },
                                failure: function (response, config) {
                            MaskOver();
                            		Ext.Msg.alert("提示",config.result.message);
                                }
                            });
                        }
                    }
                    **/
                ],

                title: '集团联调测试需求单',
                layout: {
                    type: 'vbox'
                },
                listeners: {
                    render:function (render, eOpts) {
                    	<%if(!request.getParameter("reqId").equals("")&&!request.getParameter("reqId").equals("null")&&request.getParameter("reqId")!=null){%>
                    	MaskLoading();
                    	testPlanForm.load({
	                        params: {
	                            reqId:'<%=request.getParameter("reqId")%>'
	                        },
	                        url: '<%=request.getContextPath()%>/getJointDebugReqFormByReqId.do',
	                        method: 'POST',
	                        success: function (form, action) {
                            	MaskOver();
	                            var reasonRemarks = Ext.getCmp('testPlanForm').getForm().findField('reasonRemarks').getValue();
	                            if(reasonRemarks!=null&&reasonRemarks!=""){
	                            	Ext.getCmp('testPlanForm').doLayout();
                                	Ext.getCmp('testPlanForm').getForm().findField('reasonRemarks').setVisible(true);
	                            }
	                        },
	                        failure: function (form, action) {
                            	MaskOver();
	                            Ext.Msg.alert('提示', "失败原因是！: " + action.result.errorMessage);
	                        }
                    	});
                		<%}%>
                    }
                },
                bodyBorder: 0,
                fieldDefaults: {
                    labelAlign: 'right',
                    labelWidth: 60,
                    labelStyle: 'font-weight:bold'
                },
                defaults: {
                    margins: '5 0 0 0'
                },
                items: [
                	{//////////////////////////////////////////////第一行
                        xtype: 'fieldcontainer',
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textfield',
                        items: [
                        	{
                                width: 1000,
                                labelAlign: 'right',
                                name: 'reqName',
                                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>联调需求名称",
                                allowBlank: false
                            }, {
                                xtype: 'hidden',
                                name: 'reqId',
                                fieldLabel: '测试计划id'
                            }, {
                                xtype: 'hidden',
                                name: 'isDelete',
                                fieldLabel: '删除标示',
                                value:'0'
                            }, {
                                xtype: 'hidden',
                                name: 'creatorId',
                                fieldLabel: '创建人ID'
                            }, {
                                xtype: 'hidden',
                                name: 'createTime',
                                fieldLabel: '创建日期'
                            }, {
                                xtype: 'hidden',
                                name: 'creatorName',
                                fieldLabel: '创建人名称'
                            }
                        ]
                    },{//////////////////////////////////////////////////////第二行
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
                                labelAlign: 'right',
                                name: 'groupContactsName',
                                id: 'groupContactsName',
                                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>集团联系人",
                                allowBlank: false
                            },
                            reqMgrComboBox, {
                                xtype: 'hidden',
                                name: 'reqManagerStaffId',
                                id: 'reqManagerStaffId',
                                fieldLabel: '需求管理员ID'
                            },{
                                width: 250,
                                labelAlign: 'right',
                                name: 'reqTag',
                                id: 'reqTag',
                                fieldLabel: "需求编号",
                                <%if(request.getParameter("winFlag").equals("create")){%>
				                value:'GJDRF'+Ext.util.Format.date(new Date(),'YmdHisu'),
				                <%}%>
                                readOnly:true,
                                allowBlank: false
                            }
                            
                        ]
                    }, {////////////////////////////////////////////第三行
                        xtype: 'fieldcontainer',
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textfield',
                        items: [
                        	{
                                width: 250,
                                xtype: 'datefield',
                                labelAlign: 'right',
                                name: 'provincialReqDevEndTime',
                                format: 'Y-m-d',
	        				    allowBlank: false,
                                fieldLabel: '<font style="color: red; font-weight:bold;">*</font>省司要求开发完成日期',
                                listeners:{
                                	select:function(field,value, eOpts ){
                                		var groupReqDevEndTime=Ext.getCmp('testPlanForm').getForm().findField('groupReqDevEndTime').getValue();
                                		if(groupReqDevEndTime!=''&&groupReqDevEndTime!=null&&groupReqDevEndTime<value){
                                			reasonRemarksFlag = true;
                                			Ext.getCmp('testPlanForm').doLayout();
                                			Ext.getCmp('testPlanForm').getForm().findField('reasonRemarks').setVisible(true);
                                		}else{
                                			reasonRemarksFlag = false;
                                			Ext.getCmp('testPlanForm').doLayout();
                                			Ext.getCmp('testPlanForm').getForm().findField('reasonRemarks').setVisible(false);
                                			Ext.getCmp('testPlanForm').getForm().findField('reasonRemarks').setValue('');
                                		}
                                	}
                                }
                            },{
                                width: 250,
                                xtype: 'datefield',
                                labelAlign: 'right',
                                name: 'groupReqDevEndTime',
                                format: 'Y-m-d',
	        				    allowBlank: false,
                                fieldLabel: '<font style="color: red; font-weight:bold;">*</font>集团要求开发完成日期',
                                listeners:{
                                	select:function(field,value, eOpts ){
                                		var provincialReqDevEndTime=Ext.getCmp('testPlanForm').getForm().findField('provincialReqDevEndTime').getValue();
                                		if(provincialReqDevEndTime!=''&&provincialReqDevEndTime!=null&&provincialReqDevEndTime>value){
                                			reasonRemarksFlag = true;
                                			Ext.getCmp('testPlanForm').doLayout();
                                			Ext.getCmp('testPlanForm').getForm().findField('reasonRemarks').setVisible(true);
                                		}else{
                                			reasonRemarksFlag = false;
                                			Ext.getCmp('testPlanForm').doLayout();
                                			Ext.getCmp('testPlanForm').getForm().findField('reasonRemarks').setVisible(false);
                                			Ext.getCmp('testPlanForm').getForm().findField('reasonRemarks').setValue('');
                                		}
                                	}
                                }
                            },{
                                width: 250,
                                xtype: 'datefield',
                                labelAlign: 'right',
                                name: 'jointDebugPlanBeginTime',
                                format: 'Y-m-d',
	        				    allowBlank: false,
                                fieldLabel: '<font style="color: red; font-weight:bold;">*</font>联调计划开始日期',
                                listeners:{
                                	select:function(field,value, eOpts ){
                                		var jointDebugPlanEndTime=Ext.getCmp('testPlanForm').getForm().findField('jointDebugPlanEndTime').getValue();
                                		if(jointDebugPlanEndTime!=''&&jointDebugPlanEndTime!=null&&jointDebugPlanEndTime<value){
                                			Ext.Msg.alert("提示","联调计划开始日期必须早于联调计划结束日期");field.setValue('') ;
                                		}
                                	}
                                }
                            },{
                                width: 250,
                                xtype: 'datefield',
                                labelAlign: 'right',
                                name: 'jointDebugPlanEndTime',
                                format: 'Y-m-d',
	        				    allowBlank: false,
                                fieldLabel: '<font style="color: red; font-weight:bold;">*</font>联调计划结束日期',
                                listeners:{
                                	select:function(field,value, eOpts ){
                                		var jointDebugPlanBeginTime=Ext.getCmp('testPlanForm').getForm().findField('jointDebugPlanBeginTime').getValue();
                                		if(jointDebugPlanBeginTime!=''&&jointDebugPlanBeginTime!=null&&jointDebugPlanBeginTime>value){
                                			Ext.Msg.alert("提示","联调计划开始日期必须早于联调计划结束日期");field.setValue('') ;
                                		}
                                	}
                                }
                            }
                        ]
                	}, {////////////////////////////////////////////第四行
                        xtype: 'fieldcontainer',
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textarea',
                        fieldDefaults: {
                            labelAlign: 'right'
                        },
                        items: [
                        	{
                                width: 1000,
                                height: 80,
                                labelAlign: 'right',
                                name: 'reasonRemarks',
                                id: 'reasonRemarks',
                                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>晚于集团要求日期原因说明",
                                hidden : true
                            }
                        ]
                    }, {////////////////////////////////////////////第五行
                        xtype: 'fieldcontainer',
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textfield',
                        fieldDefaults: {
                            labelAlign: 'right',
                        	labelWidth: 120
                        },
                        items: [
                        	{
		                        xtype: "checkbox",
		                        checked:false,
		                        fieldLabel: '是否造报文',
		                        name: 'isNeedMessage',
		                        id: "isNeedMessage",
							    listeners: {
							        change: function(myField, newValue, oldValue, eOpts){
                        				if(newValue){
                        					messageRemarksFlag = true;
                                			Ext.getCmp('testPlanForm').getForm().findField('messageRemarks').setVisible(true);
                        				}else{
                        					messageRemarksFlag = false;
                                			Ext.getCmp('testPlanForm').doLayout();
                                			Ext.getCmp('testPlanForm').getForm().findField('messageRemarks').setVisible(false);
                                			Ext.getCmp('testPlanForm').getForm().findField('messageRemarks').setValue('');
                        				}
							        }
							    }
		                    }
                        ]
                    }, {//////////////////////////////////////////////////////第六行
                        xtype: 'fieldcontainer',
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textarea',
                        fieldDefaults: {
                        	labelAlign: 'right'
                        },
                        items: [
                        	{
                                width: 1000,
                                height: 80,
                                name: 'messageRemarks',
                                id: 'messageRemarks',
                                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>造报文原因说明",
                                hidden : true
                            }
                        ]
                    }, {//////////////////////////////////////////////////////第七行
                        xtype: 'fieldcontainer',
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textarea',
                        fieldDefaults: {
                            labelAlign: 'right'
                        },
                        items: [{
                                width: 1000,
                                height: 80,
                                labelAlign: 'right',
                                name: 'remarks',
                                fieldLabel: "备注说明",
                                allowBlank: true
                            }
                        ]
                    }
                ]

            });
            var taskStore = Ext.create('Ext.data.Store', {
                storeId: 'taskStore',
                fields: [{
                        name: 'taskId',
                        type: 'string'
                    }, {
                        name: 'reqId',
                        type: 'string'
                    }, {
                        name: 'currentStatus',
                        type: 'string'
                    }, {
                        name: 'priority',
                        type: 'string'
                    }, {
                        name: 'createTime',
                        type: 'string'
                    }, {
                        name: 'taskTag',
                        type: 'string'
                    }, {
                        name: 'devTag',
                        type: 'string'
                    }, {
                        name: 'reqTag',
                        type: 'string'
                    }, {
                        name: 'plCompleteTime',
                        type: 'string'
                    }, {
                        name: 'factCompleteTime',
                        type: 'string'
                    }, {
                        name: 'devWorkDay',
                        type: 'string'
                    }, {
                        name: 'testWorkDay',
                        type: 'string'
                    }, {
                        name: 'createTime',
                        type: 'string'
                    }, {
                        name: 'taskName',
                        type: 'string'
                    }, {
                        name: 'distributePersion',
                        type: 'string'
                    }, {
                        name: 'distributeTime',
                        type: 'string'
                    }, {
                        name: 'bigType',
                        type: 'string'
                    }, {
                        name: 'subType',
                        type: 'string'
                    }, {
                        name: 'taskHour',
                        type: 'string'
                    }, {
                        name: 'performanceTest',
                        type: 'string'
                    }, {
                        name: 'crossCycle',
                        type: 'string'
                    }, {
                        name: 'devFirm',
                        type: 'string'
                    }, {
                        name: 'testFirm',
                        type: 'string'
                    }, {
                        name: 'testType',
                        type: 'string'
                    }, {
                        name: 'testPersion',
                        type: 'string'
                    }, {
                        name: 'runPersion',
                        type: 'string'
                    }, {
                        name: 'reqPersion',
                        type: 'string'
                    }, {
                        name: 'isImportanceReq',
                        type: 'string'
                    }, {
                        name: 'point2pointTest',
                        type: 'string'
                    }, {
                        name: 'testPersionOpinion',
                        type: 'string'
                    }, {
                        name: 'jointTest',
                        type: 'string'
                    }, {
                        name: 'distributeStaffid',
                        type: 'string'
                    }, {
                        name: 'distributeStaffname',
                        type: 'string'
                    }, {
                        name: 'initialSituation',
                        type: 'string'
                    }, {
                        name: 'taskPhase',
                        type: 'string'
                    }, {
                        name: 'planTag',
                        type: 'string'
                    }
                ],
                proxy: {
                    type: 'ajax',
                    url: '<%=request.getContextPath()%>/getTestTaskList.do',
                    reader: {
                        root: "data",
                        type: "json"
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
                    url: '<%=request.getContextPath()%>/getComBoxMap.do',
                    reader: {
                        type: 'json',
                        root: 'data'
                    }
                },
                listeners: {
                    load: function () {
                        taskWorkflowParamStore.load({params:{query:30000}});
                    }
                }
            });
            mapStore.load();
            var bigTypeStore = new Ext.data.Store({
                autoLoad: true,
                id: 'bigTypeStore',
                fields: ['value', 'show'],
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
            
            
            var taskWorkflowParamStore = new Ext.data.Store({
                id: 'taskWorkflowParamStore',
                fields: ['linkId', 'phaseId', 'phaseName', 'vmTaskName'],
                proxy: {
                    type: 'ajax',
                    url: '<%=request.getContextPath()%>/getWorkflowParam.do',
                    reader: {
                        type: 'json',
                        root: 'data'
                    }
                },
              listeners: {
                    load: function () {
                        taskStore.load({
                            params: {
                        	/*
                                planId: planId,
                                planFlag: planFlag
                                */
                            }
                        });
                    }
                }
            });
            var taskGrid = Ext.create('Ext.grid.Panel', {
                id: 'taskGrid',
                cls: 'ui-formPanel',
                title: '集团联调任务单列表',
                margins: '0 0 0 0',
                height: 180,
                width: screenWidth,/*
                tbar: [ {
                            xtype: 'button',
                            text: '关联集团联调任务单',
                            handler: function () {
                				/ *
                                var taskGridWin = new top.Ext.window.Window({
                                    id: 'taskGridWinCreate',
                                    title: '新建任务单',
                                    width: screenWidth,
                                    height: 180,
                                    modal: true,
                                    autoScroll: true,
                                    listeners: {
                                        destroy: function (window, eOpts) {
                                            taskStore.reload({
                                                params: {
                                                    planTag: planTag,
                                                    planFlag: planFlag,
                                                    planId: planId
                                                }
                                            });
                                        }
                                    },
                                    closeAction: 'destroy',
                                    html: '<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/workflow/testPlan/TaskList.jsp?planFlag='+planFlag+'&flag=0&planTag=' + planTag + '&planId=' + planId + '" width="1100" height="480"/>'
                                }).show();
                                * /
                            }
                        },
                        {
                            xtype: 'button',
                            text: '删除集团联调任务单',
                            handler: function () {
                                / *
                        		var taskGridWin = new top.Ext.window.Window({
                                    id: 'taskGridWinCreate',
                                    title: '新建任务单',
                                    width: 1100,
                                    height: 520,
                                    modal: true,
                                    autoScroll: true,
                                    listeners: {
                                        destroy: function (window, eOpts) {
                                            taskStore.reload({
                                                params: {
                                                    planTag: planTag,
                                                    planFlag: planFlag,
                                                    planId: planId
                                                }
                                            });
                                        }
                                    },
                                    closeAction: 'destroy',
                                    html: '<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/workflow/testPlan/P2PTaskForm.jsp?planFlag='+planFlag+'&flag=0&planTag=' + planTag + '&planId=' + planId + '" width="1100" height="480"/>'
                                }).show();
                                * /
                            }
                        }
                ],*/
                forctFit: true,
                stripeRows: true,
                loadMask: true,
                store: taskStore,
                selType: 'rowmodel',
                listeners: {
            		/*
                    itemdblclick: function (eventObject, htmlElement, eOpts) {
                        var models = Ext.getCmp('taskGrid').getSelectionModel().getSelection();
                        if (models.length != 1) {
                            Ext.Msg.alert("提示","选择错误!");
                        }
                        var url='<%=request.getContextPath()%>/aiga/workflow/testPlan/TaskList.jsp';
                        if(models[0].data.testType==5){
                        	url='<%=request.getContextPath()%>/aiga/workflow/testPlan/P2PTaskForm.jsp';
                        }else{
                        	url='<%=request.getContextPath()%>/aiga/workflow/testPlan/TaskList.jsp';
                        }
                        
                       url+='?flag=1&taskId=' + models[0].data.taskId ;
                        
                        var taskFormWin = new top.Ext.window.Window({
                            id: 'taskFormWinLookOver',
                            title: '查看任务单',
                            width: screenWidth*0.9,
                            height: screenHeight*0.9,
                            modal: true,
                            listeners: {
                                destroy: function (window, eOpts) {
                                    var taskStore = Ext.data.StoreManager.lookup("taskStore");
                                    taskStore.reload({
                                        params: {
                                            planTag: planTag,
                                            planFlag: planFlag,
                                            planId: planId
                                        }
                                    });
                                }
                            },
                            closeAction: 'destroy',
                            html: '<iframe id="frame" name="frame" src="'+url+'" width="100%" height="100%" scrolling="yes"/>'
                        }).show();
                    }
            		*/
                },
                columns: [new Ext.grid.RowNumberer(), {
                        header: "测试任务名称",
                        width: 100,
                        sortable: true,
                        dataIndex: 'taskName'
                    }, {
                        header: "计划id",
                        width: 100,
                        sortable: true,
                        dataIndex: 'planId',
                        hidden: true
                    }, {
                        header: "测试任务id",
                        width: 100,
                        sortable: true,
                        dataIndex: 'taskId',
                        hidden: true
                    }, {
                        header: "测试任务编号",
                        width: 100,
                        sortable: true,
                        dataIndex: 'taskTag',
                        hidden: true
                    }, {
                        header: "计划编号",
                        width: 100,
                        sortable: true,
                        dataIndex: 'planTag'
                    }, {
                        header: "需求编号",
                        width: 100,
                        sortable: true,
                        dataIndex: 'reqTag'
                    }, {
                        header: "开发任务编号",
                        width: 100,
                        sortable: true,
                        dataIndex: 'devTag'
                    }, {
                        header: "需求管理员",
                        width: 100,
                        sortable: true,
                        dataIndex: 'reqPersion'
                    }, {
                        header: "测试管理员Id",
                        width: 100,
                        sortable: true,
                        dataIndex: 'distributeStaffid',
                        hidden: true
                    }, {
                        header: "测试组长",
                        width: 100,
                        sortable: true,
                        dataIndex: 'distributeStaffname'
                    },

                    {
                        header: '系统大类',
                        dataIndex: 'bigType',
                        width: 60,
                        align: 'center',
                        renderer: function (value, cellmeta, record) {


                            try {
                                var store = Ext.data.StoreManager.lookup("mapStore");
                                store.clearFilter(true);

                                store.filter("categoryName", "bigTypeStore");
                                return store.findRecord("value", value).getData().show + "";
                            } catch (e) {
                                return "未指定"
                            };
                        }
                    }, {
                        header: '系统子类',
                        dataIndex: 'subType',
                        width: 60,
                        align: 'center',
                        renderer: function (value, cellmeta, record) {

                            try {
                                var store = Ext.data.StoreManager.lookup("mapStore");
                                store.clearFilter(true);
                                store.filter("categoryName", "subTypeStore");
                                return store.findRecord("value", value).getData().show + "";
                            } catch (e) {
                                return "未指定"
                            };
                        },
                        hidden: true
                    }, {
                        header: '测试类型',
                        dataIndex: 'testType',
                        width: 100,
                        align: 'center',
                        renderer: function (value, cellmeta, record) {
                            try {
                                var store = Ext.data.StoreManager.lookup("mapStore");
                                store.clearFilter(true);
                                store.filter("categoryName", "testTypeStore");
                                return store.findRecord("value", value).getData().show + "";
                            } catch (e) {
                                return "未指定"
                            };
                        },
                        hidden: true
                    }, {
                        header: '测试厂商',
                        dataIndex: 'testFirm',
                        width: 60,
                        align: 'center',
                        renderer: function (value, cellmeta, record) {

                            try {
                                var store = Ext.data.StoreManager.lookup("mapStore");
                                store.clearFilter(true);
                                store.filter("categoryName", "testFirmStore");

                                return store.findRecord("value", value).getData().show + "";
                            } catch (e) {
                                return "未指定"
                            };
                        }
                    }, {
                        header: '开发厂商',
                        dataIndex: 'devFirm',
                        width: 60,
                        align: 'center',
                        renderer: function (value, cellmeta, record) {

                            try {


                                var store = Ext.data.StoreManager.lookup("mapStore");
                                store.clearFilter(true);
                                store.filter("categoryName", "devFirmStore");
                                return store.findRecord("value", value).getData().show + "";
                            } catch (e) {
                                return "未指定"
                            };
                        }
                    }, {
                        header: '任务状态',
                        dataIndex: 'currentStatus',
                        width: 60,
                        align: 'center',
                        renderer: function (value, cellmeta, record) {
                            try {
                                var store = Ext.data.StoreManager.lookup("taskWorkflowParamStore");
                                return store.findRecord("linkId", value).getData().vmTaskName + "";

                            } catch (e) {
                                return "未指定{"+value+"}";
                            };

                        }
                    }, {
                        header: '任务所处阶段',
                        dataIndex: 'taskPhase',
                        width: 60,
                        align: 'center',
                        renderer: function (value, cellmeta, record) {
                            try {
                                var store = Ext.data.StoreManager.lookup("taskWorkflowParamStore");
                                return store.findRecord("phaseId", value).getData().phaseName + "";

                            } catch (e) {
                                return "未指定{"+value+"}";
                            };

                        }
                    }, {
                        header: "测试任务派发人",
                        width: 100,
                        sortable: true,
                        dataIndex: 'distributePersion',
                        hidden: true
                    }, {
                        header: "测试任务执行人",
                        width: 100,
                        sortable: true,
                        dataIndex: 'runPersion',
                        hidden: true
                    }, {
                        header: "任务优先级",
                        width: 100,
                        sortable: true,
                        dataIndex: 'priority',
                        renderer: function (value, cellmeta, record) {


                            try {
                                var store = Ext.data.StoreManager.lookup("mapStore");
                                store.clearFilter(true);

                                store.filter("categoryName", "priorityStore");
                                return store.findRecord("value", value).getData().show + "";
                            } catch (e) {
                                return "未指定"
                            };
                        }
                    }
                ]
            });
            var taskGrid1 = Ext.create('Ext.grid.Panel', {
                id: 'taskGrid1',
                cls: 'ui-formPanel',
                title: '集团联调子任务单列表',
                margins: '0 0 0 0',
                height: 180,
                width: screenWidth,
                forctFit: true,
                stripeRows: true,
                loadMask: true,
                store: taskStore,
                selType: 'rowmodel',
                listeners: {
                },
                columns: [
	                new Ext.grid.RowNumberer(), 
	                {
                        header: "需求编号",
                        width: 100,
                        sortable: true,
                        dataIndex: 'reqTag'
                    }, {
                        header: "开发任务编号",
                        width: 100,
                        sortable: true,
                        dataIndex: 'devTag'
                    }
                ]
            });
            var taskGrid2 = Ext.create('Ext.grid.Panel', {
                id: 'taskGrid2',
                cls: 'ui-formPanel',
                title: '变更单',
                margins: '0 0 0 0',
                height: 180,
                width: screenWidth,
                forctFit: true,
                stripeRows: true,
                loadMask: true,
                store: taskStore,
                selType: 'rowmodel',
                listeners: {
                },
                columns: [
	                new Ext.grid.RowNumberer(), 
	                {
                        header: "需求编号",
                        width: 100,
                        sortable: true,
                        dataIndex: 'reqTag'
                    }, {
                        header: "开发任务编号",
                        width: 100,
                        sortable: true,
                        dataIndex: 'devTag'
                    }
                ]
            });
            var taskGrid3 = Ext.create('Ext.grid.Panel', {
                id: 'taskGrid3',
                cls: 'ui-formPanel',
                title: '历史轨迹',
                margins: '0 0 0 0',
                height: 180,
                width: screenWidth,
                forctFit: true,
                stripeRows: true,
                loadMask: true,
                store: taskStore,
                selType: 'rowmodel',
                listeners: {
                },
                columns: [
	                new Ext.grid.RowNumberer(), 
	                {
                        header: "需求编号",
                        width: 100,
                        sortable: true,
                        dataIndex: 'reqTag'
                    }, {
                        header: "开发任务编号",
                        width: 100,
                        sortable: true,
                        dataIndex: 'devTag'
                    }
                ]
            });
            var tabPanel = Ext.create("Ext.tab.Panel", {
                frame: true,
           		border: 0,
                width: screenWidth,
                height:205,
                id: 'tabPanel',
                activeTab: 0, // 默认激活第1个tab页
                renderTo: Ext.getBody(),
                items: [
                	{
                            title: "附件列表",
                            contentEl:'fileTrans',
                            listeners:{
                            	beforeshow:function(tab,eOpts){
                            		$('#fileTrans').show();
                            		//initPackList(planTag, '1', current_linkNo,'0','0',false);
                            	}
                            }
                        },
                	taskGrid,
                	taskGrid1,
                	taskGrid2,
                	taskGrid3
                ]
            });
            Ext.create('Ext.Panel', {
            	id:'testPlanPanel',
                renderTo: Ext.get('planPanel'),
                cls: 'ui-formPanel',
                width: screenWidth,
                height: screenHeight-16,
                layout: {
                    type: 'hbox',
                    align: 'stretch',
                    padding: 0
                },
                defaults: {
                    split: true,
                    collapsible: false,
                    bodyStyle: 'padding:0 0 20 0'
                },
                items: [{
                        region: 'center',
                        items: [testPlanForm, tabPanel]
                    }
                ]
            });
        });
    </script>
</html>