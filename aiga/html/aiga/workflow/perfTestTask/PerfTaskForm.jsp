<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.BaseAction"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.asiainfo.aiga.common.WorkflowParam"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ include file="/aiga/common/common.jsp" %>
<% 
    String planId=request.getParameter( "planId");
   	String taskId=request.getParameter( "taskId"); 
   	String planTag=request.getParameter( "planTag"); 
    //0 创建(附件列表)   1查看一(历史轨迹  附件) 2 编辑(所有) 3 查看二(所有)
    String flag=request.getParameter( "flag"); 
    boolean isShowTask=(taskId!=null&& !taskId.equals("")); 
    boolean isFlag=(flag!=null&& !flag.equals( "")); 
    boolean isShowPlan=(planId!=null&& !planId.equals( ""));
    AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
    Enumeration pNames = request.getParameterNames();
    Map<String,String> requstMap=new HashMap<String,String> ();
   	while(pNames.hasMoreElements()) {
		String name = (String)pNames.nextElement();
		String val = request.getParameter(name);
		if(val != null) {
			val = BaseAction.decodeCN(val).replace("\n", " ");
			val = BaseAction.decodeCN(val).replace("\r", "");
		}
		requstMap.put(name, val);
		System.out.println("name="+name+"-----"+requstMap.get(name));
	}
   	String key="";
%>
<html>
    
    <head>
        <script type="text/javascript" src="<%=request.getContextPath()%>/extJs/ext.bug.fix.js"></script>
        <title>任务单</title>
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
       <div id="fileTrans" style="display:none;"><jsp:include page="/aiga/attach/fileTrans.jsp"></jsp:include></div>
        <jsp:include page="/aiga/workflow/common/SelectStaff.jsp"></jsp:include>
    </body>
    <script type="text/javascript">
    var staffSelect="";
        var planId = "${param.planId}";
        var taskId = "${param.taskId}";
        var planTag = "${param.planTag}";
        var extjsFolderPath = '<%=request.getContextPath()%>/extJs';
        var screenWidth = document.documentElement.clientWidth;
        var screenHeight = document.documentElement.clientHeight;

            function removeHTMLTag(str) {
                str = str.replace(/<\/?[^>]*>/g, ''); //去除HTML tag
                str = str.replace(/[ | ]*\n/g, '\n'); //去除行尾空白
                str = str.replace(/&nbsp;/ig, ''); //去掉&nbsp;
                return str;
            }

            function getArrayBycategoryName(categoryName) {
                var records = new Array();
                $.getJSON("<%=request.getContextPath()%>/getComBoxMap.do", {}, function (data) {
                    records = data.data;
                    var bigArray = new Array();
                    for (var i = 0, n = records.length; i < n; i++) {
                        if (records[i].categoryName == categoryName) {
                            var subArray = new Array();
                            subArray.push(records[i].value);
                            subArray.push(records[i].show);
                            bigArray.push(subArray);
                        }
                    }
                    return bigArray;
                });

            }
        Ext.onReady(function () {
            Ext.QuickTips.init();
            Ext.tip.QuickTipManager.init();
            var dateFormat = Ext.Date.format(new Date, 'YmdHisu');
            taskTag = "TT" + dateFormat;
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
            
            
            
            //Daniel's Store start
            var blankRecord = {
				planId: '',
				planTag: '',
				planName: '------请选择------',
				planStatus: '',
				planPhase: '',
				submitStaffName: '',
				submitStaffId: '',
				createTime: '',
				plCompleteTime: '',
				beginTime: '',
				codeCommitDate: '',
				factCompleteTime: '',
				reqTime: '',
				bigType: '',
				onLineType: '',
				versionContent: '',
				isSecurityTest: '',
				isCodeScan: '',
				isPerformanceTest: '',
				isRegressionTest: '',
				planDscr: '',
				changeReason: ''
			};

            var planStore = Ext.create('Ext.data.Store', {
        		storeId:'planStore',
        		fields:[
        		        {name:'planId',type:'string'}, 
        		 		{name:'planTag',type:'string'}, 
        		 		{name:'planName',type:'string'},
        		 		{name:'planStatus',type:'string'},
        		 		{name:'planPhase',type:'string'},
        		 		{name:'submitStaffName',type:'string'}, 
        		 		{name:'submitStaffId',type:'string'}, 
        		 		{name:'createTime',type:'string'},
        		 		{name:'plCompleteTime',type:'string'}, 
        		 		{name:'beginTime',type:'string'},
        		 		{name:'codeCommitDate',type:'string'},
        		 		{name:'factCompleteTime',type:'string'},
        		 		{name:'reqTime',type:'string'},
        		 		{name:'bigType',type:'string'},
        		 		{name:'onLineType',type:'string'},
        		 		{name:'versionContent',type:'string'},
        		 		{name:'isSecurityTest',type:'string'},
        		 		{name:'isCodeScan',type:'string'},
        		 		{name:'isPerformanceTest',type:'string'},
        		 		{name:'isRegressionTest',type:'string'},
        		 		{name:'planDscr',type:'string'},
        		 		{name:'changeReason',type:'string'}
        		 		],
        	    proxy: {
        	        type: 'ajax',
                	url : '<%=request.getContextPath()%>/getTestPlanList.do?taskFlag=<%=flag%>',
        	        reader: {
        	            root:"data",
        				type:"json"
        	        }
        	    },
        	    listeners:{
        	    	load:function(store,records,successful, eOpts ){
        	    		store.insert(0,blankRecord);
        	    	}
        	    }
        	});
        	
        	planStore.load();

            var planComboBox = new Ext.form.ComboBox({
                width: 250,
                store: planStore,
                name: "planTag",
                fieldLabel: "测试计划名称",
                valueField: 'planTag',
                displayField: 'planName',
                forceSelection:true,
	            typeAhead:true,
	            minChars:1,
	            selectOnFocus: true,
	            triggerAction: 'all',
	            queryMode: 'local',
                editable:true,
                listeners: {
                	select :function(combo,records, eOpts ){
                	 	Ext.getCmp("taskForm").getForm().findField('planId').setValue(records[0].raw.planId);
                	 	//Ext.getCmp("taskForm").getForm().findField('planTag').setValue(records[0].raw.planTag);
                	 	Ext.getCmp("taskForm").getForm().findField('factCompleteTime').setValue(records[0].raw.factCompleteTime);
                	 	Ext.getCmp("taskForm").getForm().findField('bigType').setValue(records[0].raw.bigType);
                	},
                    beforequery: function (queryEvent, eOpts) {
                    }
                }
                <%key="planTag";if(requstMap.get(key)!=null&&!requstMap.get(key).equals("")){%>,value:'<%=requstMap.get(key)%>'<%}%>
            });
            
            
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
            Ext.define('subTaskStaffsModel', {
                extend: 'Ext.data.Model',
                fields: ['taskId', 'staffNames','staffIds']
            });
            var subTaskStaffsStore= new Ext.data.Store({
                id: 'subTaskStaffsStore',
                model:subTaskStaffsModel
                
            });
            
            //选择需求管理员
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
                name: "reqPersion",
                fieldLabel: "需求管理员",
                forceSelection:true,
	            typeAhead:true,
	            minChars:1,
	            selectOnFocus: true,
	            triggerAction: 'all',
	            queryMode: 'local',
                valueField: 'staffName',
                displayField: 'displayName',
                editable:true,
                	listConfig: {
                },
                listeners: {
                	select :function(combo,records, eOpts ){
                		//taskForm.findField("reqPersion").setValue(records[0].raw.staffName);
                	},
                    beforequery: function (queryEvent, eOpts) {
                    }
                }
                <%key="reqPersion";if(requstMap.get(key)!=null&&!requstMap.get(key).equals("")){%>,value:'<%=requstMap.get(key)%>'<%}%>
            });

            /********staffStore end********/

            //Daniel's Store end

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
                        taskWorkflowParamStore.load({params:{query:90000}});
                    }
                }
            });
            mapStore.load();


            var priorityStore = new Ext.data.Store({
                autoLoad: true,
                id: 'priorityStore',
                fields: ['value', 'show'],
                proxy: {
                    type: 'ajax',
                    url: '<%=request.getContextPath()%>/getComBox.do?query=priorityStore',
                    reader: {
                        type: 'json',
                        root: 'data'
                    }
                }
            });
            priorityStore.load();
            var priorityCombox = new Ext.form.ComboBox({
                width: 250,
                store: priorityStore,
                name: 'priority',
                fieldLabel: "任务优先级",
                forceSelection:true,
	            typeAhead:true,
	            selectOnFocus: true,
                valueField: 'value',
                displayField: 'show'
              	<%key="priority";if(requstMap.get(key)!=null&&!requstMap.get(key).equals("")){%>,value:<%=requstMap.get(key)%><%}%>

            });
            var workflowParamStore = new Ext.data.Store({
                id: 'workflowParamStore',
                fields: ['phaseId', 'phaseName', 'linkId', 'vmTaskName'],
                proxy: {
                    type: 'ajax',
                    url: '<%=request.getContextPath()%>/getWorkflowParam.do?query=90000',
                    reader: {
                        type: 'json',
                        root: 'data'
                    }
                },
                listeners:{
                	load:function(store,records,successful,opts){
                		store.add({phaseId:'',phaseName:'',linkId:-1,vmTaskName:'已关闭'});
                	}
                }
            });
            workflowParamStore.load();
         

            var taskPhaseCombox = new Ext.form.ComboBox({
                width: 250,
                store: workflowParamStore,
                name: 'taskPhase',
                fieldLabel: "任务所处阶段",
                valueField: 'phaseId',
                displayField: 'phaseName',
                listeners: {}
            <%if(flag!=null &&flag.equals("0")){%>,value:1,readOnly:true<%}%>
            });
            var taskStatusCombox = new Ext.form.ComboBox({
                width: 250,
                store: workflowParamStore,
                name: 'currentStatus',
                fieldLabel: "任务状态",
                valueField: 'linkId',
                displayField: 'vmTaskName',
                listeners: {}
            <%if(flag!=null &&flag.equals("0")){%>,value:1201,readOnly:true<%}%>
            });
            var bigTypeStore = new Ext.data.Store({
            	autoLoad:true,
                id: 'bigTypeStore',
                fields: ['value', 'show'],
                proxy: {
                    type: 'ajax',
                    url: '<%=request.getContextPath()%>/getComBox.do?query=bigTypeStore',
                    reader: {
                        type: 'json',
                        root: 'data'
                    }
                },
                listeners:{
                	load:function( store,records, successful,eOpts ){
                	}
                }
            });
            bigTypeStore.load();
            var bigTypeCheckGroup = new Ext.form.CheckboxGroup({
                width: 1000,
                fieldLabel: "系统大类",
                labelAlign: 'right',
                width:1000,
                id:'bigTypeCheckGroup'
            });
            var subTypeStore = new Ext.data.Store({
                id: 'subTypeStore',
                fields: ['value', 'show'],
                proxy: {
                    type: 'ajax',
                    url: '<%=request.getContextPath()%>/getComBox.do?query=subTypeStore',
                    reader: {
                        type: 'json',
                        root: 'data'
                    }
                },
                listeners:{
                	load:function( store,records, successful,eOpts ){
                	}
                }
            });
            subTypeStore.load();
            var subTypeCheckGroup = new Ext.form.CheckboxGroup({
                width: 1000,
                fieldLabel: "系统子类",
                labelAlign: 'right',
                width:1000,
                id:'subTypeCheckGroup'
            });
            var bigTypeCombox = new Ext.form.ComboBox({
                width: 250,
                store: bigTypeStore,
                name: "bigType",
                fieldLabel: "系统大类",
                forceSelection:true,
	            typeAhead:true,
	            minChars:1,
	            selectOnFocus: true,
	            triggerAction: 'all',
	            queryMode: 'local',
                valueField: 'value',
                displayField: 'show'
                <%key="bigType";if(requstMap.get(key)!=null&&!requstMap.get(key).equals("")){%>,value:<%=requstMap.get(key)%><%}%>
            });
            var subTypeCombox = new Ext.form.ComboBox({
                width: 250,
                store: subTypeStore,
                name: "subType",
                fieldLabel: "系统子类",
                valueField: 'value',
                displayField: 'show',
                listeners: {
                    beforequery: function (queryEvent, eOpts) {
                        queryEvent.query = "subTypeStore";
                    }
                }
            	<%key="subType";if(requstMap.get(key)!=null&&!requstMap.get(key).equals("")){%>,value:<%="'"+requstMap.get(key)+"'"%><%}%>

            });
            var testTypeStore = new Ext.data.Store({
                id: 'testTypeStore',
                fields: ['value', 'show'],
                proxy: {
                    type: 'ajax',
                    url: '<%=request.getContextPath()%>/getComBox.do?query=testTypeStore',
                    reader: {
                        type: 'json',
                        root: 'data'
                    }
                }
            });
            testTypeStore.load();
            var testTypeCombox = new Ext.form.ComboBox({
            	width:250,
                store: testTypeStore,
                name: "testType",
                fieldLabel: "测试类型",
                valueField: 'value',
                displayField: 'show',
                value:5,
                listeners: {
                    beforequery: function (queryEvent, eOpts) {
                        queryEvent.query = "testTypeStore";
                    }
                }
            });
            var devFirmStore = new Ext.data.Store({
                id: 'devFirmStore',
                fields: ['value', 'show'],
                proxy: {
                    type: 'ajax',
                    url: '<%=request.getContextPath()%>/getComBox.do?query=devFirmStore',
                    reader: {
                        type: 'json',
                        root: 'data'
                    }
                }
            });
            devFirmStore.load();
            var devFirmCombox = new Ext.form.ComboBox({
                width: 250,
                store: devFirmStore,
                name: "devFirm",
                fieldLabel: "开发厂商",
                forceSelection:true,
	            typeAhead:true,
	            minChars:1,
	            selectOnFocus: true,
	            triggerAction: 'all',
	            queryMode: 'local',
                valueField: 'value',
                displayField: 'show'
            	<%key="devFirm";if(requstMap.get(key)!=null&&!requstMap.get(key).equals("")){%>,value:<%=requstMap.get(key)%><%}%>

            });
            var testFirmStore = new Ext.data.Store({
                autoLoad: true,
                id: 'testFirmStore',
                fields: ['value', 'show'],
                proxy: {
                    type: 'ajax',
                    url: '<%=request.getContextPath()%>/getComBox.do?query=testFirmStore',
                    reader: {
                        type: 'json',
                        root: 'data'
                    }
                }
            });
            testFirmStore.load();
            var testFirmCombox = new Ext.form.ComboBox({
                width: 250,
                store: testFirmStore,
                name: "testFirm",
                fieldLabel: "测试厂商",
                forceSelection:true,
	            typeAhead:true,
	            minChars:1,
	            selectOnFocus: true,
	            triggerAction: 'all',
	            queryMode: 'local',
                valueField: 'value',
                displayField: 'show'
            	<%key="testFirm";if(requstMap.get(key)!=null&&!requstMap.get(key).equals("")){%>,value:<%=requstMap.get(key)%><%}%>

            });
  
            var taskForm = Ext.widget('form', {
                id: 'taskForm',
                layout: 'vbox',
                title: '<%if(isShowTask&&isFlag&&(flag.equals("2"))){%>编辑性能体验测试任务<%}else if(isShowTask&&isFlag&&(flag.equals("1")||flag.equals("3"))){%>查看性能测试<%}else{%>创建性能测试任务单&nbsp;&nbsp(' + taskTag + ')<%}%>',

                tbar: [ <%
                    if (isFlag && (false)) { %> {
                            xtype: 'button',
                            text: '保存',

                            handler: function () {
                                var form = Ext.getCmp("taskForm");
                                MaskLoading();
                                form.submit({
                                    clientValidation: true,
                                    url: "<%=request.getContextPath()%>/saveTestTaskForm.do",
                                    params: {
                                        planId: planId,
                                        planTag: planTag
                                    },
                                    method: 'POST',
                                    success: function (response, config) {
                                	MaskOver();
                                        var success = config.result.success;
                                        // 当后台数据同步成功时  
                                        if (success) {
                                        	var _taskWin = null;
                                        	<%if(flag.equals("0")){%>
                                            	_taskWin = top.Ext.getCmp("taskGridWinCreate");
                                            <%}else {
                                            	%>
                                            	_taskWin = top.Ext.getCmp("taskFormWin");
                                            	<%
                                            }%>
                                            //_taskWin.close();
                                            Ext.Msg.alert("提示","任务保存成功!");
                                        }
                                    },
                                    failure: function (response, config) {
                                	MaskOver();
                                		Ext.Msg.alert("提示","数据修改失败!");
                                    }
                                });

                            }
                        } <%
                    } %>
                ],

                width: screenWidth,
                minWidth: 1000,
                bodyBorder: 0,
                fieldDefaults: {
                    labelAlign: 'right',
                    labelWidth: 60
                },
                defaults: {
                    margins: '5 0 0 0'
                },
                listeners: {
                    render: function (render, eOpts) { <%
                        if (isShowTask) { %>
                                taskForm.load({
                                params: {
                                    taskId: taskId
                                },
                                url: '<%=request.getContextPath()%>/getTaskForm.do',
                                method: 'POST',
                                success: function (form, action) {
                                    <%if(flag.equals("1")||flag.equals("3")){%>
                                    var fields = taskForm.getForm().getFields().items;
                                    for (var i = 0, n = fields.length; i < n; i++) {
                                        fields[i].setReadOnly(true);
                                    }
                                    <%}%>
                                    <%if(flag.equals("1")||flag.equals("2")||flag.equals("3")){%>
                                    perfStore.proxy.url="<%=request.getContextPath()%>/getPerfTestTask.do?taskTag="+Ext.getCmp('taskForm').getForm().findField('taskTag').getValue();
            						perfStore.load();
                                    <%}%>
                                    
                                },
                                failure: function (form, action) {
                                    Ext.Msg.alert('提示', "失败原因是: " + action.result.errorMessage);
                                }
                            }); <%
                        } %>
                    }
                },
                items: [{
                        xtype: 'fieldcontainer',
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textfield',
                        items: [{
                                width: 1000,
                                labelAlign: 'right',
                                name: 'taskName',
                                fieldLabel: '测试任务名称',
                                allowBlank: false
                                <%key="taskName";if(requstMap.get(key)!=null&&!requstMap.get(key).equals("")){%>,value:<%="'"+requstMap.get(key)+"'"%><%}%>

                            }, {
                                xtype: "hidden",
                                name: "planId",
                                value: planId,
                                fieldLabel: "计划Id"
                                <%key="planId";if(requstMap.get(key)!=null&&!requstMap.get(key).equals("")){%>,value:<%="'"+requstMap.get(key)+"'"%><%}%>
                            }, {
                                xtype: "hidden",
                                name: 'taskId',
                                fieldLabel: '测试任务id'
                            }, {
                                xtype: "hidden",
                                name: 'factCompleteTime',
                                fieldLabel: '计划上线时间'
                                <%key="factCompleteTime";if(requstMap.get(key)!=null&&!requstMap.get(key).equals("")){%>,value:<%="'"+requstMap.get(key)+"'"%><%}%>
                            },{
                                xtype: "hidden",
                                name: 'taskTag',
                                fieldLabel: '测试任务编号' <%
                                if (isFlag && flag.equals("0")) { %> , value: taskTag <%
                                } %>
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
                        items: [planComboBox,
                            taskPhaseCombox,
                            taskStatusCombox,
                            priorityCombox
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
                                name: "reqTag",
                                fieldLabel: "需求编号",
                                allowBlank:false
                                <%key="reqTag";if(requstMap.get(key)!=null&&!requstMap.get(key).equals("")){%>,value:<%="'"+requstMap.get(key)+"'"%><%}%>

                            }, {
                            	xtype:'hidden',
                            	name: "testType",
                                fieldLabel: "测试类型",
                                value:9
                            },
                            reqMgrComboBox, 
                            {
                                xtype: 'hidden',
                                name: 'distributeStaffid',
                                fieldLabel: '测试人员Id'
                                //allowBlank: false,
                            }, {
                                xtype: 'hidden',
                                name: 'distributeStaffname',
                                fieldLabel: '测试人员名称'
                                //allowBlank: false,
                            },
                            devFirmCombox,
                            {
	                            name: 'isImportanceReq',
	                            xtype: 'checkbox',
	                            width: 250,
	                            fieldLabel: '是否重点需求'
	                           <%key="isImportanceReq";if(requstMap.get(key)!=null&&(requstMap.get(key).equals("on")||requstMap.get(key).equals("true"))){%>,checked:<%="'"+true+"'"%><%}%>
                       			}
                        ]
                    },
                    {
                        xtype: "fieldcontainer",
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textfield',
                        fieldDefaults: {
                            labelAlign: 'right'
                        },
                        items: [bigTypeCombox,
                       			{
                                    width: 250,
                                    xtype:'numberfield',
                                    name: 'testWorkDay',
                                    fieldLabel: '测试任务工时',
                                    selectOnFocus: true,
                                    allowBlank: false
                                },
                        		testFirmCombox
                        ]
                    }
                   , {
                        xtype: "fieldcontainer",
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textfield',
                        fieldDefaults: {
                            labelAlign: 'right'
                        },

                        items: [
                        	{
                                xtype: 'hidden',
                                name: 'submitStaffId',
                                fieldLabel: '提交人员Id',
                                value:'<%=user.getUserId()%>'
                                //allowBlank: false,
                                
                            }, {
                                xtype: 'hidden',
                                name: 'submitStaffName',
                                fieldLabel: '提交人员名称',
                                value:'<%=user.getUserName()%>'
                                //allowBlank: false,
                            }, 
                        ]
                    }, 
                    {
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
                                name: 'initialSituation',
                                fieldLabel: '任务单说明',
                                allowBlank: false
                                <%key="initialSituation";if(requstMap.get(key)!=null&&!requstMap.get(key).equals("")){%>,value:<%="'"+requstMap.get(key)+"'"%><%}%>
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
                        name: 'importanceReq',
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
                            //0 代表未关联的所有任务
            <%
            if (isShowPlan && isFlag && flag.equals("6")) { %>
                    taskStore.load({
                    params: {
                        taskFlag: "6",
                        planId: planId
                    }
                }); <%
            } else { %>
                    taskStore.load({
                    params: {
                        taskFlag: "0",
                        planTag: planTag
                    }
                }); <%
            } %>
                    }
                }
            });
      		Ext.define('SubTask',{
    		    extend: 'Ext.data.Model',
    		    fields: [
    		        {name: 'subTaskId',type: 'int',convert: null},
    		        {name: 'subTaskTag',type: 'string'},
    		        {name: 'taskTag',type: 'string'},
    		        {name: 'subTaskName',type: 'string'},
    		        {name: 'reqId',type: 'int',convert: null},
    		        {name: 'creator', type: 'string'},
    		        {name: 'subTaskStatus', type: 'string'},
    		        {name: 'createTime',type: 'string'},
    		        {name: 'plCompleteTime',type: 'string'},
    		        {name: 'factCompleteTime',type: 'string'},
    		        {name: 'subTaskPriority',type: 'string'},
    		        {name: 'devWorkDay',type: 'string'},
    		        {name: 'testWorkDay',type: 'string'},
    		        {name: 'possibleProduct',type: 'string'},
    		        {name: 'possibleBack',type: 'string'},
    		        {name: 'possibleTest',type: 'string'},
    		        {name: 'possibleProductReason',type: 'string'},
    		        {name: 'possibleBackReason',type: 'string'},
    		        {name: 'possibleTestReason',type: 'string'},
    		        {name: 'taskId',type: 'int',convert: null,defaultValue:'<%=taskId%>'},
    		        {name: 'subTaskType',type: 'int',convert: null},
    		        {name: 'creatorStaff',type: 'string'},
    		        {name: 'curPhase',type: 'int',convert: null},
    		        {name: 'testorId',type: 'int',convert: null},
    		        {name: 'testorName',type: 'string'}
    		    ]
    		});
      		
      		var subTaskStore = new Ext.data.Store({
      			model: 'SubTask',
      			id: 'subTaskStore',
      			proxy: {
    			type: 'ajax',
    			url: '<%=request.getContextPath()%>/getSubTaskListByTaskId.do',
    			    reader: {
    			        type: 'json',
    			        root: 'data'
    			    }
    			}
      		});
      		subTaskStore.load({params:{taskId: '<%=taskId%>'}});
      		var subTaskGrid = new Ext.grid.Panel({
      			id: 'subTaskGrid',
      			title: '子任务列表',
      			cls: 'ui-formPanel',
      			layout: 'fit',
      			height:200,
      			<%if(flag==null||false){%>
      			tbar:[
      				{
      					text: '新增',
      					height: 20,
    			    	width: 40,
    			    	handler: function() {
    			    		addSubTaskWin();
    			    	}
      				},
      				{
      					text: '删除',
      					height: 20,
    			    	width: 40,
    			    	handler: function() {
    			    		delSubTaskConfirm();
    			    	}
      				}
      			],
      			<%}%>
      			listeners: {
      				dblclick: {
      					element: 'body',
      					fn: function() {
      						//modifySubTask();
      					}
      				}
      			},
      			store: subTaskStore,
      			columns:[
      				{xtype:'rownumberer'},
      				{header:'子任务编号',dataIndex:'subTaskTag',field:'textfield'},
      				{header:'子任务名称',dataIndex:'subTaskName',field:'textfield'},
      				{header:'创建时间',dataIndex:'createTime',field:'textfield'},
      				{header:'计划完成时间',dataIndex:'plCompleteTime',field:'textfield'},
      				{header:'开发任务工时',dataIndex:'devWorkDay',field:'textfield'},
      				{header:'测试任务工时',dataIndex:'testWorkDay',field:'textfield'},
      				{header:'子任务优先级',dataIndex:'subTaskPriority',field:'textfield'},
      				{header:'子任务类型',dataIndex:'subTaskType',field:'textfield'},
      				{header:'测试人员',dataIndex:'testorName',field:'textfield'}
      			]
      		});
      		
      		Ext.define('perfModel', {
				extend: 'Ext.data.Model',
				fields: [
					{name: 'pftId', type: 'string', convert: null},
					{name: 'taskTag', type: 'string', defaultValue:Ext.getCmp('taskForm').getForm().findField('taskTag').getValue()},
			        {name: 'testObjType', type: 'string', convert: null},
			        {name: 'testObjDscr', type: 'string'},
			        {name: 'perfDemand', type: 'string'}
				]
			});
			
			var testObjType = new Ext.data.Store({
			 	autoLoad: true,
			 	id: 'testObjType',
			    fields: ['value','show'],
			    proxy: {
			    	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=testObj_Type'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			    }
			});
      		var perfStore = Ext.create('Ext.data.Store', {
			     autoLoad: true,
			     model: "perfModel",
			     proxy: {
			         type: 'ajax',
			         url: '<%=request.getContextPath()%>/getPerfTestTask.do?taskTag='+taskTag+'&_='+(new Date()).getTime(),
			         reader: {
			             type: 'json',
			             root: 'data'
			         }
			     }
			});
      		
      		perfPanelEdit = Ext.create('Ext.grid.plugin.CellEditing', {
						            clicksToEdit: 1
						        })
            var tabPanel = Ext.create("Ext.tab.Panel", {
                frame: true,
                width: screenWidth * 0.98,
                height: screenHeight * 0.4,
                id: 'tabPanel',
                activeTab: 0, // 默认激活第1个tab页
                renderTo: Ext.getBody(),
                items: [
	                	Ext.create('Ext.grid.Panel', {
							title: '性能指标',
							id: 'perfPanel',
							store: perfStore,
							width:screenWidth*0.85,
						    columns: [
						    	{xtype:'rownumberer'},
						    	{dataIndex: 'pftId', hidden: true},
						    	{dataIndex: 'taskId', hidden: true},
						    	{header: '测试对象类型', dataIndex:'testObjType', editor:{xtype:'combo',displayField:'show', valueField:'value', store:'testObjType',allowBlank:false},
						    		renderer:function(value){
						    			var rec = Ext.StoreMgr.get('testObjType').find('value',value);
						    			if(rec == -1) {
						    				return '';
						    			}
						    			return Ext.StoreMgr.get('testObjType').getAt(rec).raw.show;
						    		}
						    	},
						        {header: '对象描述', dataIndex: 'testObjDscr', field: 'textarea' ,height: 20,flex: 1,allowBlank:false},
						        {header: '性能描述', dataIndex: 'perfDemand', field: 'textarea' ,height: 20,flex: 1,allowBlank:false}
						    ],
						    <%if(flag==null||!flag.equals("1")){%>
						    selType: 'cellmodel',
						    plugins: [
						        perfPanelEdit
						    ],
						    <%}%>
						    height: 200,
						    width: screenWidth*0.85,
						    <%if(flag==null||!flag.equals("1")){%>
						    tbar: [
							    {
							    	text: '新增',
							    	height: 20,
							    	width: 40,
							    	handler: function() {
							    		var r = Ext.create('perfModel');
							    		r.set('taskTag',Ext.getCmp('taskForm').getForm().findField('taskTag').getValue());
							    		var index = perfStore.data.length;
								    	perfStore.insert(index,r);
								    	Ext.getCmp('perfPanel').getView().refresh();
							    	}
							    },
							    {
							    	text: '删除',
							    	height: 20,
							    	width: 40,
							    	handler: function() {
							    		confirmDelPerf();
							    	}
							    },
							     {
							    	text: '保存',
							    	height: 20,
							    	width: 40,
							    	handler: function() {
							    		savePerfTask();
							    	}
							    }
						    ]
						    <%}%>
						}),
                        <%if(flag!=null && (flag.equals("2")||flag.equals("3")||flag.equals("1"))){%>
                        {
                            title: "历史轨迹",
                            html: '<iframe id="f_1" scrolling="auto" frameborder="0" width="100%" height="100%" src="<%=request.getContextPath()%>/aiga/workflow/common/HistoryTrack.jsp?objId=${param.objId}&objType=${param.objType}"></iframe>'
                        }, 
                        <%}%>
                        <%if(flag!=null && (flag.equals("2")||flag.equals("3"))){%>
                        subTaskGrid,
                        <%}%>
                        {
                            title: "附件列表",
                            contentEl:'fileTrans',
                            listeners:{
                            	beforeshow:function( Component, eOpts ){
                            		$('#fileTrans').show();
                            		var taskTag = Ext.getCmp('taskForm').getForm().findField('taskTag').getValue();
                            		initPackList(taskTag, '1', 'factoryMgrRece','0','0',false);
                            	}
                            }
                        }
                ]
            });
            
            function confirmDelPerf() {
				var curSel = Ext.getCmp('perfPanel').getSelectionModel().getSelection();
				if(curSel.length == 0) {
					return;
				}
				Ext.MessageBox.confirm('提示','确定要删除该条性能指标吗？',function(btn){
					if(btn == 'yes') {
						delPerfTest();
					} else {
						return;
					}
				});
			}
			
			
			
			function delPerfTest() {
				var curSel = Ext.getCmp('perfPanel').getSelectionModel().getSelection();
				var pftId = curSel[0].get('pftId');
				if(!pftId) {
					Ext.getCmp('perfPanel').getStore().remove(curSel);
	    			Ext.getCmp('perfPanel').getView().refresh();
	    			return;
				}
		  		MaskLoading();
				$.ajax({
		    		async: false,
	    			type: 'POST',
	    			url: '<%=request.getContextPath()%>/deleteAigaPerftestTask.do',
	    			data: 'pftId='+pftId+'&_='+(new Date()).getTime(),
	    			success: function(data) {
	    				Ext.getCmp('perfPanel').getStore().remove(curSel);
	    				Ext.getCmp('perfPanel').getView().refresh();
	    			}
	    		});
		    	MaskOver();
			}
		
            Ext.create('Ext.Panel', {
                renderTo: Ext.getBody(),
                cls: 'ui-formPanel',
                width: screenWidth - 10,
                height: screenHeight * 0.99,
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
                        items:[taskForm,tabPanel]
                    }
                ]
            })
            });
            
     		function savePerfTask() {
     			var vRecords = Ext.getCmp('perfPanel').getStore().data.items; // 获取需要校验的数据数据   
                for(var row = 0;row<vRecords.length;row++){
                    var record = vRecords[row].data;
                    var testObjType = record["testObjType"];
                    var testObjDscr = record["testObjDscr"];
                    var perfDemand = record["perfDemand"];
                    if(testObjType==null||testObjType==""){
                      	alert('测试对象类型');return false;
                    }
                    if(testObjDscr==null||testObjDscr==""){
                      	alert('对象描述');return false;
                    }
                    if(perfDemand==null||perfDemand==""){
                      	alert('性能描述');return false;
                    }
                }
				
				perfPanelEdit.completeEdit();
				
				var resStore = Ext.getCmp('perfPanel').getStore();
				var resources = new Array();
				resStore.each(function(rec){
					resources.push(Ext.encode(rec.data));
				});
				resources = "[" + resources + "]";
				$.ajax({
		    		async: false,
					type: 'POST',
					dataType: "json",
					url: '<%=request.getContextPath()%>/saveAigaPerftestTask.do',
					data: 'table='+resources+"&_=" + (new Date()).getTime(),
					success: function(data) {
						resStore.reload();
					}
				});
				return true;
			}
	
    </script>

</html>