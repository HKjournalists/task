<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<html>
    
    <head>
        <title>测试计划</title>
    </head>
    <body>
       <jsp:include page="/aiga/workflow/common/SelectStaff.jsp"></jsp:include>
      <div id="fileTrans"><jsp:include page="/aiga/attach/fileTrans.jsp"></jsp:include></div>
      <div id="solidDiv" style="height:0px;width:0px;"><jsp:include page="/aiga/workflow/testPlan/TestSolidTaskList.jsp">
      	<jsp:param value="${param.objId}" name="planId"/>
      </jsp:include></div>
        <div id="planPanel"></div>
        <% 
        String planId=request.getParameter( "objId"); 
        AigaUser user=( AigaUser)request.getSession().getAttribute( "aigaUser"); 
        //0 创建 1查看 2编辑 
        String planFlag=request.getParameter( "planFlag"); 
        boolean isHasPlanId=(planId!=null&&!planId.equals( ""));
        %>
    </body>
    <script type="text/javascript">
    $(function(){
    	$('#fileTrans').hide();
    });
        var extjsFolderPath = '<%=request.getContextPath()%>/extJs';
        var screenWidth = document.documentElement.clientWidth;
        var screenHeight = document.documentElement.clientHeight;
        var planId = "${param.objId}";
        var planFlag = "${param.planFlag}";
        var planTag = "";
        /*****右击*******/
        function rightClickTargetFn(view, record, item, index, e, eOpts) {
            e.preventDefault();
            rightTargetReportMenu.showAt(e.getXY());
        }

        function closeWindow(windowId) {
            var _taskWin = Ext.getCmp(windowId);
            _taskWin.close();
        }
        var rightTargetReportMenu = new Ext.menu.Menu({
            items: [{
                    id: 'editTask',
                    text: '编辑任务单',
                    handler: function () {
                        var models = Ext.getCmp('taskGrid').getSelectionModel().getSelection();
                        if (models.length != 1) {
                            Ext.Msg.alert("提示","选择错误!");
                        }
                        var taskFormWin = new top.Ext.window.Window({
                            id: 'taskFormWin',
                            title: '编辑任务单',
                            width: 1100,
                            height: 400,
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
                            html: '<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/workflow/testPlan/TaskList.jsp?flag=2&taskId=' + models[0].data.taskId + '" width="1100" height="400"/>'
                        }).show();
                    }
                }, {
                    id: 'delRel',
                    text: '删除关联',
                    handler: function () {
                        var models = Ext.getCmp('taskGrid').getSelectionModel().getSelection();
                        if (models.length != 1) {
                            Ext.Msg.alert("提示","选择错误!");
                        }
                        $.getJSON("<%=request.getContextPath()%>/delRelTaskList.do", {
                            planId: planId,
                            taskId: models[0].data.taskId
                        }, function (data) {
                            if (data.success != true) {
                                Ext.Msg.alert("提示","请求失败!");
                                Ext.data.StoreManager.lookup('taskStore').reload({
                                    params: {
                                        planTag: planTag,
                                        planFlag: planFlag,
                                        planId: planId
                                    }
                                });
                            }
                        });
                    }
                }
            ]
        });
        Ext.onReady(function () {
            Ext.QuickTips.init();
            Ext.tip.QuickTipManager.init();
          	Ext.get("solidDiv").hide();
            var dateFormat = Ext.Date.format(new Date, 'YmdHisu');
            planTag = 'TP' + dateFormat;
            var planTagTitle = "参数有误";
            if ('<%=planFlag%>' == 0 && '<%=isHasPlanId%>' == 'false') {
                planTagTitle = '测试计划创建&nbsp;&nbsp;(' + planTag + ')';
            }
            if ('<%=isHasPlanId%>' == 'true' && '<%=planFlag%>' == 2) {
                planTagTitle = "创建计划编辑";
            }
            if ('<%=isHasPlanId%>' == 'true' && '<%=planFlag%>' == 1) {
                planTagTitle = "创建计划查看";
            }
            var bigTypeStore = new Ext.data.Store({
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
            var bigTypeCombox = new Ext.form.ComboBox({
                width: 250,
                store: bigTypeStore,
                labelAlign: 'right',
                name: "bigType",
                fieldLabel: "系统大类",
                valueField: 'value',
                displayField: 'show',
                listeners: {
                    beforequery: function (queryEvent, eOpts) {
                        //console.log(queryEvent);
                        queryEvent.query = "bigTypeStore";
                    }
                }
            });
            var onLineTypeStore = new Ext.data.Store({
                id: 'planTypeStore',
                fields: ['value', 'show'],
                proxy: {
                    type: 'ajax',
                    url: '<%=request.getContextPath()%>/getComBox.do?query=onLineTypeStore',
                    reader: {
                        type: 'json',
                        root: 'data'
                    }
                }
            });
            onLineTypeStore.load();
            var onLineTypeCombox = new Ext.form.ComboBox({
                width: 250,
                labelAlign: 'right',
                store: onLineTypeStore,
                name: 'onLineType',
                fieldLabel: '上线类型',
                valueField: 'value',
                displayField: 'show',
                listeners: {
                    beforequery: function (queryEvent, eOpts) {
                        queryEvent.query = 'onLineTypeStore';
                    }
                }
            });
            var workflowParamStore = new Ext.data.Store({
                id: 'workflowParamStore',
                fields: ['linkId', 'phaseId', 'phaseName', 'vmTaskName'],
                proxy: {
                    type: 'ajax',
                    url: '<%=request.getContextPath()%>/getWorkflowParam.do?query=10000',
                    reader: {
                        type: 'json',
                        root: 'data'
                    }
                }
            });
            workflowParamStore.load();
            var planStatusCombox = new Ext.form.ComboBox({
                width: 250,
                labelAlign: 'right',
                store: workflowParamStore,
                name: 'planStatus',
                fieldLabel: '计划单状态',
                valueField: 'linkId',
                displayField: 'vmTaskName',
                listeners: {}
 			<%if(planFlag!=null&&planFlag.equals("0")){%>,value:1,readOnly:true<%}%>
            });

            var planPhaseCombox = new Ext.form.ComboBox({
                width: 250,
                store: workflowParamStore,
                name: 'planPhase',
                labelAlign: 'right',
                fieldLabel: '计划所处阶段',
                valueField: 'phaseId',
                displayField: 'phaseName',
                listeners: {}
            <%if(planFlag!=null&&planFlag.equals("0")){%>,value:1,readOnly:true<%}%>
            });
            var testPlanForm = Ext.widget('form', {
                id: 'testPlanForm',
                width: screenWidth * 0.98,
                height: 340,
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

                title: '' + planTagTitle,
                layout: {
                    type: 'vbox'
                },
                listeners: {
                    render: function (render, eOpts) { <%
                        if (isHasPlanId) { %>
                                testPlanForm.load({
                                params: {
                                    planId: planId
                                },
                                url: '<%=request.getContextPath()%>/getTestPlanForm.do',
                                method: 'POST',
                                success: function (form, action) {
                                    //获取form 设置title
                                    planTag = action.result.data.planTag;
                                    testPlanForm.setTitle("测试计划查看&nbsp;&nbsp;(" + planTag + ")");
                                    Ext.data.StoreManager.lookup("taskStore").load({
                                        params: {
                                            planId: planId,
                                            planTag: planTag,
                                            planFlag: planFlag
                                        }
                                    }); <%
                                    if (planFlag != null && !planFlag.equals("2")) { %>
                                        var fields = testPlanForm.getForm().getFields().items;
                                        for (var i = 0, n = fields.length; i < n; i++) {
                                            fields[i].setReadOnly(true);
                                        } <%
                                    } %>
                                },
                                failure: function (form, action) {
                                    Ext.Msg.alert('提示', "失败原因是: " + action.result.errorMessage);
                                }
                            }); <%
                        } %>
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


                items: [{
                        xtype: 'fieldcontainer',
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textfield',
                        items: [{
                                width: 1000,
                                labelAlign: 'right',
                                name: 'planName',
                                fieldLabel: '测试计划名称',
                                allowBlank: false
                            }, {
                                xtype: 'hidden',
                                name: 'planId',
                                fieldLabel: '测试计划id'
                            }
                        ]
                    }, {
                        xtype: 'fieldcontainer',
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textfield',
                        items: [
                                planStatusCombox,
                                planPhaseCombox, {
                                width: 250,
                                labelAlign: 'right',
                                name: 'submitStaffName',
                                value: '<%=user.getUserName()%>',
                                fieldLabel: '计划提交人'

                            }, {
                                xtype: 'hidden',
                                labelAlign: 'right',
                                name: 'submitStaffId',
                                value: '<%=user.getUserId()%>'
                            } <%
                            if (isHasPlanId && !planFlag.equals("0")) { %> , {
                                    width: 250,
                                    xtype: 'datefield',
                                    name: 'createTime',
                                    format: 'Y-m-d',
                                    fieldLabel: '创建时间',
                                    readOnly: true
                                } <%
                            } %>
                        ]
                    }, {
                        xtype: 'fieldcontainer',
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textfield',
                        items: [

                            {
                                xtype: "hidden",
                                labelAlign: 'right',
                                name: 'planTag',
                                id: "planTag",
                                fieldLabel: '测试计划编号',
                                <%
                                if (!isHasPlanId && planFlag != null && planFlag.equals("0")) { %>
                                        value: planTag,
                                    <%
                                } %> renderer: function (value, cellmeta, record) {}
                            }, {
                                width: 250,
                                xtype: 'datefield',
                                name: 'plCompleteTime',
                                format: 'Y-m-d',
                                fieldLabel: '计划期望上线时间'
                            }, {
                                width: 250,
                                xtype: 'datefield',
                                name: 'beginTime',
                                format: 'Y-m-d',
                                fieldLabel: "测试计划开始时间"
                            }, {
                                width: 250,
                                xtype: 'datefield',
                                name: 'codeCommitDate',
                                labelAlign: 'right',
                                format: 'Y-m-d',
                                fieldLabel: "代码截止提交日"
                            }, {
                                width: 250,
                                xtype: 'datefield',
                                name: 'factCompleteTime',
                                format: 'Y-m-d',
                                fieldLabel: '计划实际上线时间'
                            }
                        ]
                    }, {
                        xtype: 'fieldcontainer',
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textfield',
                        fieldDefaults: {
                            labelAlign: 'right'
                        },
                        items: [{
                                width: 250,
                                xtype: 'datefield',
                                name: 'reqTime',
                                format: 'Y-m-d',
                                fieldLabel: '需求定稿时间'
                            },
                            bigTypeCombox,
                                onLineTypeCombox, {
                                width: 250,
                                labelAlign: 'right',
                                name: 'versionContent',
                                fieldLabel: '版本容量'

                            }
                        ]
                    }, {
                        xtype: 'fieldcontainer',
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textfield',
                        fieldDefaults: {
                        	labelAlign: 'right'
                        },
                        items: [{
                                xtype: 'checkbox',
                                width: 250,
                                name: 'isSecurityTest',
                                fieldLabel: '是否安全测试'
                            }, {
                                xtype: 'checkbox',
                                width: 250,
                                name: 'isCodeScan',
                                fieldLabel: '是否代码扫描'
                            }, {
                                xtype: 'checkbox',
                                width: 250,
                                name: 'isRegressionTest',
                                fieldLabel: '是否性能测试'
                            }, {
                                xtype: 'checkbox',
                                id: "isPerformanceTest",
                                width: 250,
                                name: 'isPerformanceTest',
                                fieldLabel: '是否回归扫描'
                            }
                        ]
                    }, {
                        xtype: 'fieldcontainer',
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textarea',
                        fieldDefaults: {
                            labelAlign: 'right'
                        },
                        items: [{
                                width: 1000,
                                height: 50,
                                labelAlign: 'right',
                                name: 'planDscr',
                                fieldLabel: '计划描述',
                                allowBlank: false
                            }
                        ]
                    }, {
                        xtype: 'fieldcontainer',
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textarea',
                        fieldDefaults: {
                            labelAlign: 'right'
                        },
                        items: [{
                                width: 1000,
                                height: 50,
                                labelAlign: 'right',
                                name: 'changeReason',
                                fieldLabel: '变更原因',
                                allowBlank: false
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
                autoLoad: true,
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
                                planId: planId,
                                planFlag: planFlag
                            }
                        });
                    }
                }
            });
            var taskGrid = Ext.create('Ext.grid.Panel', {
                id: 'taskGrid',
                cls: 'ui-formPanel',
                title: '任务列表',
                margins: '0 0 0 3',
                height: 180,
                width: screenWidth * 0.98,
                tbar: [ <%
                    if (planFlag != null && planFlag.equals("0")) { %> {
                            xtype: 'button',
                            text: '关联任务单',
                            handler: function () {
                                var taskGridWin = new top.Ext.window.Window({
                                    id: 'taskGridWin',
                                    title: '任务单',
                                    width: 980,
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
                                    html: '<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/workflow/testPlan/TaskList.jsp?flag=3&planTag=' + planTag + '&planId=' + planId + '" width="950" height="480"/>'
                                }).show();
                            }
                        }, {
                            xtype: 'button',
                            text: '新建任务单',
                            handler: function () {
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
                                    html: '<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/workflow/testPlan/TaskList.jsp?planFlag='+planFlag+'&flag=0&planTag=' + planTag + '&planId=' + planId + '" width="1100" height="480"/>'
                                }).show();
                            }
                        }, {
                            xtype: 'button',
                            text: '导入Excel',
                            handler: function () {
                                var taskGridWin = new top.Ext.window.Window({
                                    id: 'taskGridWinExcel',
                                    title: '导入任务单Excel',
                                    width: 500,
                                    height: 200,
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
                                    html: '<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/workflow/testPlan/TaskList.jsp?flag=4&planTag=' + planTag + '&planId=' + planId + '" width="480" height="160"/>'
                                }).show();
                            }
                        } <%
                    } %>
                ],
                forctFit: true,
                stripeRows: true,
                loadMask: true,
                store: taskStore,
                selType: 'rowmodel',
                listeners: {
                    itemdblclick: function (eventObject, htmlElement, eOpts) {
                        var models = Ext.getCmp('taskGrid').getSelectionModel().getSelection();
                        if (models.length != 1) {
                        	Ext.Msg.alert("提示","选择错误!");
                        }
                        var taskFormWin = new top.Ext.window.Window({
                            id: 'taskFormWinLookOver',
                            title: '查看任务单',
                            width: 1100,
                            height: 400,
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
                            html: '<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/workflow/testPlan/TaskList.jsp?flag=1&taskId=' + models[0].data.taskId + '" width="1100" height="400"/>'
                        }).show();
                    }
            <%if(planFlag!=null&&!planFlag.equals("1")){%>
            	, itemcontextmenu: rightClickTargetFn
            	<%}%>
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
                        header: "测试管理员",
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
                        }
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
                        }
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
                    },
                    //，是否需求端到端测试，是否为重点需求、是否为跨周期需求、测试管理员意见；
                    {
                        header: "测试任务派发时间",
                        width: 100,
                        sortable: true,
                        dataIndex: 'distributeTime',
                        hidden: true
                    }, {
                        header: "测试任务计划完成时间",
                        width: 100,
                        sortable: true,
                        dataIndex: 'plCompleteTime',
                        hidden: true
                    }, {
                        header: "测试任务实际完成时间",
                        width: 100,
                        sortable: true,
                        dataIndex: 'factCompleteTime',
                        hidden: true
                    }, {
                        header: "是否重点需求",
                        width: 100,
                        sortable: true,
                        dataIndex: 'isImportanceReq',
                        renderer: function (value, cellmeta, record) {
                            if (value == 'on') return "是";
                            else return "否";
                        }
                    }, {
                        header: '是否联调',
                        dataIndex: 'isJointTest',
                        width: 60,
                        align: 'center',
                        renderer: function (value, cellmeta, record) {
                            if (value == 0) return "是";
                            else return "否";
                        }
                    }, {
                        header: '是否性能测试',
                        dataIndex: 'isPerformanceTest',
                        width: 60,
                        align: 'center',
                        renderer: function (value, cellmeta, record) {
                            if (value == 0) return "是";
                            else return "否";
                        }
                    }, {
                        header: '是否跨周期需求',
                        dataIndex: 'isCrossCycle',
                        width: 60,
                        align: 'center',
                        renderer: function (value, cellmeta, record) {
                            if (value == 0) return "是";
                            else return "否";
                        }
                    }, {
                        header: '是否端对端测试',
                        dataIndex: 'isPoint2pointTest',
                        width: 60,
                        align: 'center',
                        renderer: function (value, cellmeta, record) {
                            if (value == 0) return "是";
                            else return "否";
                        }
                    }, {
                        header: "开发任务工时",
                        width: 100,
                        sortable: true,
                        dataIndex: 'devWorkDay'
                    }, {
                        header: "测试任务工时",
                        width: 100,
                        sortable: true,
                        dataIndex: 'testWorkDay'
                    }, {
                        header: "初步情况分析",
                        width: 100,
                        sortable: true,
                        dataIndex: 'initialSituation'
                    }
                ]
            });
            var tabPanel = Ext.create("Ext.tab.Panel", {
                frame: true,
                width: screenWidth,
                layout:'fit',
                id: 'tabPanel',
                activeTab: 0, // 默认激活第1个tab页
                renderTo: Ext.getBody(),
                items: [ <%
                    if (planFlag != null && planFlag.equals("0")) { %>
                            taskGrid, {
                            title: "附件列表",
                            contentEl:'fileTrans',
                            listeners:{
                            	beforeshow:function(tab,eOpts){
                            		$('#fileTrans').show();
                            		initPackList(planTag, '1', '${param.linkNo}','0','0',false);
                            	}
                            }
                        } <%
                    } else { %>
                        //非创建状态
                        {
                            title: "历史轨迹",
                            html: '<iframe id="f_1" scrolling="auto" frameborder="0" width="100%" height="100%" src="<%=request.getContextPath()%>/aiga/workflow/common/HistoryTrack.jsp?objId=${param.objId}&objType=${param.objType}"></iframe>'
                        }, {
                            title: "版本测试任务列表",
                            contentEl:'solidDiv',
                            listeners:{
                            	beforeshow:function(tab,eOpts){
                            		Ext.get("solidDiv").show();
                            		$("#solidDiv").show();
                            	}
                            }
                        }, {
                            title: "附件列表",
                            contentEl:'fileTrans',
                            listeners:{
                            	beforeshow:function(tab,eOpts){
                            		$('#fileTrans').show();
                            		initPackList(planTag, '1', '${param.linkNo}','0','0',false);
                            	}
                            }
                        },
                        taskGrid <%
                    } %>
                ]
            });
            Ext.create('Ext.Panel', {
                renderTo: Ext.get('planPanel'),
                cls: 'ui-formPanel',
                width: screenWidth * 0.98,
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
                        items: [testPlanForm, tabPanel]
                    }
                ]
            });
        });
    </script>

</html>