<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.WorkflowParam"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<%	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String taskId = request.getParameter("taskId");
	if(taskId == null || "".equals(taskId)) {
		taskId = "110";
	}
	String flag = request.getParameter("flag");
	String objectId = request.getParameter("objId");
	String objectType = request.getParameter("objType");
%>
<html>
  <head>
    <title>测试任务分解</title>
  </head>
  <body>
  	<jsp:include page="/aiga/workflow/common/SelectStaff.jsp"></jsp:include>
  	<div id="fileTrans" style="display:none;"><jsp:include page="/aiga/attach/fileTrans.jsp"></jsp:include></div>
  </body>
  <script type="text/javascript">
  	Ext.onReady(function(){
        Ext.QuickTips.init();
        Ext.tip.QuickTipManager.init();
 /** 		
  		var importance = new Ext.data.Store({
			autoLoad: true,
		 	id: 'importance',
		    fields: ['value','show'],
		    proxy: {
			   	type: 'ajax',
		        url: '<%=request.getContextPath()%>/getSysParam.do?category=req_importance'+'&_='+(new Date()).getTime(),
		        reader: {
		        	type: 'json',
		        	root: 'data'
		        }
		   }
		});
		var possible = new Ext.data.Store({
			autoLoad: true,
			id: 'possible',
			fields: ['value','show'],
			proxy: {
		    	type: 'ajax',
		        url: '<%=request.getContextPath()%>/getSysParam.do?category=possible'+'&_='+(new Date()).getTime(),
		        reader: {
		        	type: 'json',
		        	root: 'data'
		        }
		   }
		});
		var isUnion = new Ext.data.Store({
		 	autoLoad: true,
		 	id: 'isUnion',
		    fields: ['value','show'],
		    proxy: {
		    	type: 'ajax',
		        url: '<%=request.getContextPath()%>/getSysParam.do?category=req_union'+'&_='+(new Date()).getTime(),
		        reader: {
		        	type: 'json',
		        	root: 'data'
		        }
		    }
		});
		var isPerformance = new Ext.data.Store({
		 	autoLoad: true,
		 	id: 'isPerformance',
		    fields: ['value','show'],
		    proxy: {
		    	type: 'ajax',
		        url: '<%=request.getContextPath()%>/getSysParam.do?category=req_performance'+'&_='+(new Date()).getTime(),
		        reader: {
		        	type: 'json',
		        	root: 'data'
		        }
		    }
		});
		var priority = new Ext.data.Store({
		 	id: 'priority',
		    fields: ['value','show'],
		    proxy: {
		    	type: 'ajax',
		        url: '<%=request.getContextPath()%>/getSysParam.do?category=req_priority'+'&_='+(new Date()).getTime(),
		        reader: {
		        	type: 'json',
		        	root: 'data'
		        }
		    }
		});
		var testTaskStatus = new Ext.data.Store({
		 	autoLoad: true,
		 	id: 'testTaskStatus',
		    fields: ['value','show'],
		    proxy: {
		    	type: 'ajax',
		        url: '<%=request.getContextPath()%>/getSysParam.do?category=test_task_status'+'&_='+(new Date()).getTime(),
		        reader: {
		        	type: 'json',
		        	root: 'data'
		        }
		    }
		});
		var isOverCircle = new Ext.data.Store({
		 	autoLoad: true,
		 	id: 'isOverCircle',
		    fields: ['value','show'],
		    proxy: {
		    	type: 'ajax',
		        url: '<%=request.getContextPath()%>/getSysParam.do?category=is_over_circle'+'&_='+(new Date()).getTime(),
		        reader: {
		        	type: 'json',
		        	root: 'data'
		        }
		    }
		});
		var testImportance = new Ext.data.Store({
		 	autoLoad: true,
		 	id: 'testImportance',
		    fields: ['value','show'],
		    proxy: {
		    	type: 'ajax',
		        url: '<%=request.getContextPath()%>/getSysParam.do?category=test_importance'+'&_='+(new Date()).getTime(),
		        reader: {
		        	type: 'json',
		        	root: 'data'
		        }
		    }
		});
		var reviewStatus = new Ext.data.Store({
		 	autoLoad: true,
		 	id: 'reviewStatus',
		    fields: ['value','show'],
		    proxy: {
		    	type: 'ajax',
		        url: '<%=request.getContextPath()%>/getSysParam.do?category=req_reviewStatus'+'&_='+(new Date()).getTime(),
		        reader: {
		        	type: 'json',
		        	root: 'data'
		        }
		    }
		});
********************************************************/
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
            width: 250,
            store: testTypeStore,
            name: "testType",
            fieldLabel: "测试类型",
            valueField: 'value',
            displayField: 'show',
            listeners: {
                beforequery: function (queryEvent, eOpts) {
                    queryEvent.query = "testTypeStore";
                }
            }
        });
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
            name: "bigType",
            fieldLabel: "系统大类",
            valueField: 'value',
            displayField: 'show'
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
            }
        });
        subTypeStore.load();
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
            valueField: 'value',
            displayField: 'show',
            listeners: {
                beforequery: function (queryEvent, eOpts) {
                    queryEvent.query = "devFirmStore";
                }
            }
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
            valueField: 'value',
            displayField: 'show',
            listeners: {
                beforequery: function (queryEvent, eOpts) {
                    queryEvent.query = "testFirmStore";
                }
            }
        });
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
            valueField: 'value',
            displayField: 'show'
        });
        var workflowParamStore = new Ext.data.Store({
            id: 'workflowParamStore',
            fields: ['phaseId', 'phaseName', 'linkId', 'vmTaskName'],
            proxy: {
                type: 'ajax',
                url: '<%=request.getContextPath()%>/getWorkflowParam.do?query=30000',
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
        var taskStatusCombox = new Ext.form.ComboBox({
            width: 250,
            store: workflowParamStore,
            name: 'currentStatus',
            fieldLabel: "任务状态",
            valueField: 'linkId',
            displayField: 'vmTaskName',
            listeners: {}
        });

        var taskPhaseCombox = new Ext.form.ComboBox({
            width: 250,
            store: workflowParamStore,
            name: 'taskPhase',
            fieldLabel: "计划所处阶段",
            valueField: 'phaseId',
            displayField: 'phaseName',
            listeners: {}
        });
  		var taskForm = new Ext.form.Panel({
  			id: 'taskForm',
  			title: '任务信息',
  			renderTo: Ext.getBody(),
  			cls: 'ui-formPanel',
  			bodyBorder: 0,
  			defaults: {margins: '5 0 0 0'},
  			layout: 'vbox',
  			items:[
					{
					    xtype: 'fieldcontainer',
					    labelStyle: 'font-weight:bold;padding:0',
					    layout: 'hbox',
					    defaultType: 'textfield',
					    items: [{width: 1000,labelAlign: 'right',name: 'taskName',fieldLabel: '测试任务名称'}, 
					            {xtype: 'hidden',name: 'planId',fieldLabel:'计划Id'}, 
					        	{xtype: 'hidden',name: 'taskId',fieldLabel: '测试任务id'},
					        	{xtype: 'hidden',name: 'taskTag',fieldLabel: '测试任务编号'}
					    		]
					}, {
					    xtype: 'fieldcontainer',
					    labelStyle: 'font-weight:bold;padding:0',
					    layout: 'hbox',
					    defaultType: 'textfield',
					    fieldDefaults: {labelAlign: 'right'},
					    items: [{ width: 250,name: 'planTag', fieldLabel: '计划编号'},
					        taskPhaseCombox,
					       	taskStatusCombox,
					        priorityCombox
					    ]
					}, {
					    xtype: 'fieldcontainer',
					    labelStyle: 'font-weight:bold;padding:0',
					    layout: 'hbox',
					    defaultType: 'textfield',
					    fieldDefaults: {labelAlign: 'right'},
					
					    items: [{width: 250,name: 'reqTag',fieldLabel: '需求编号'},
					            {width: 250,name: 'devTag',fieldLabel: '开发任务编号',allowBlank: false},
					            {width: 250,name: 'reqPersion',fieldLabel: '需求管理员',allowBlank: false},
					            {xtype: 'hidden',name: 'distributeStaffid',fieldLabel: '测试管理员Id'},
					            {width: 250,xtype: 'textfield',name: 'distributeStaffname',fieldLabel: '测试管理员',emptyText: '请选择管理员' },
					            ]
					}, {
					    xtype: 'fieldcontainer',
					    labelStyle: 'font-weight:bold;padding:0',
					    layout: 'hbox',
					    defaultType: 'textfield',
					    fieldDefaults: {labelAlign: 'right'},
					    items: [testTypeCombox,
					            bigTypeCombox,
					            subTypeCombox,
					            {width: 250,name: 'isImportanceReq',xtype: 'checkbox',fieldLabel: '是否重点需求'}
					    		]
					}, {
					    xtype: 'fieldcontainer',
					    labelStyle: 'font-weight:bold;padding:0',
					    layout: 'hbox',
					    defaultType: 'textfield',
					    fieldDefaults: {labelAlign: 'right'},
					
					    items: [{width: 250,name: 'devWorkDay',fieldLabel: '开发任务工时',allowBlank: false},
					            {width: 250,name: 'testWorkDay',fieldLabel: '测试任务工时',selectOnFocus: true,
					            listeners: {
					                focus: function (comp, The, eOpts) {
					                    var devWorkDay = Ext.getCmp('taskForm').getForm().findField('devWorkDay');
					                    if (devWorkDay.value != undefined && (comp.value == undefined) || comp.value == '')
					                    	comp.setValue(devWorkDay.value / 2);
					                }
					
					            },
					            allowBlank: false
					        },
					        devFirmCombox,
					   		testFirmCombox
					    	]
					}, {
					    xtype: 'fieldcontainer',
					    labelStyle: 'font-weight:bold;padding:0',
					    layout: 'hbox',
					    defaultType: 'textfield',
					    fieldDefaults: {labelAlign: 'right'},
					    items: [{width: 250,name: 'isCrossCycle',xtype: 'checkbox',fieldLabel: '是否为跨周期需求'},
					            {width: 250,name: 'isPoint2pointTest',xtype: 'checkbox', fieldLabel: '是否端对端测试'},
					            {width: 250,name: 'isPerformanceTest',xtype: 'checkbox',fieldLabel: '是否性能测试'},
					            {width: 250,name: 'isJointTest',xtype: 'checkbox',fieldLabel: '是否联调'}
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
					    items: [{width: 1000,height: 50,labelAlign: 'right',name: 'initialSituation',fieldLabel: '初步情况分析',allowBlank: false}
					    ]
					}
  			]
  		});
  		
  		var fieldAry = taskForm.getForm().getFields();
  		for(var i = 0; i < fieldAry.length; i++) {
  			fieldAry.get(i).setReadOnly(true);
  		}
  		
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
  		
  		taskForm.getForm().load({
  			url: '<%=path%>/getTestTaskById.do',
  			params: {taskId:'<%=taskId%>'},
  			success: function(form,action) {
  			}
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
  			<%if(flag==null||!flag.equals("1")){%>
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
  						modifySubTask();
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
  		
  		var tabs = new Ext.TabPanel({
			id: 'tabs',
			width: 1000,
			frame: true,
			height: 300,
			deferredRender: false,
			renderTo: Ext.getBody(),
			activeTab: 0,
			bodyBorder: 0,
			items: [
				subTaskGrid,
				{
                    title: "附件列表",
                    contentEl:'fileTrans',
                    listeners:{
                    	beforeshow:function(tab,eOpts){
                    		$('#fileTrans').show();
                    		var taskTag = Ext.getCmp('taskForm').getForm().findField('taskTag').getValue();
                    		var current_linkNo=taskStatusCombox.getValue( );
                    		initPackList(taskTag, '1', current_linkNo,'0','0',false);
                    	}
                    }
                },
                {
                    title: "历史轨迹",
                    width: 980,
                    html: '<iframe id="f_1" scrolling="auto" frameborder="0" width="900" height="100%" src="<%=request.getContextPath()%>/aiga/workflow/common/HistoryTrack.jsp?objId=<%=objectId%>&objType=<%=objectType%>"></iframe>'
                }
			]
		});
		
  		function addSubTaskWin(){
  			var subTaskWin = new top.Ext.window.Window({
  	            id: 'subTaskWin',
  	            width: 1100,
  	            height: 450,
  	            modal: true,
  	            listeners: {
  	                destroy: function (window, eOpts) {
  	                },
  	                beforeClose: function() {
  	                	Ext.getCmp('subTaskGrid').getStore().reload();
  	                }
  	            },
  	            closeAction: 'destroy',
  	            html: '<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/workflow/search/SubTaskForm.jsp?taskId=<%=taskId%>&flag=0" width="1100" height="100%"/>'
  	        });
  	        subTaskWin.show();
  		}
        
  	function modifySubTask() {
  		var curSel = Ext.getCmp('subTaskGrid').getSelectionModel().getSelection();
  		var subTaskId = curSel[0].get("subTaskId");
  		var subTaskWin = new top.Ext.window.Window({
            id: 'subTaskWin',
            width: 1100,
            height: 450,
            modal: true,
            listeners: {
                destroy: function (window, eOpts) {
                },
                beforeClose: function() {
                	Ext.getCmp('subTaskGrid').getStore().reload();
                }
            },
            closeAction: 'destroy',
            html: '<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/workflow/search/SubTaskForm.jsp?subTaskId='+subTaskId+'&flag=<%=flag%>" width="1100" height="100%"/>'
        });
        subTaskWin.show();
  	}
  	
  	function delSubTaskConfirm() {
  		var curSel = Ext.getCmp('subTaskGrid').getSelectionModel().getSelection();
		if(curSel.length == 0) {
			return;
		}
		Ext.MessageBox.confirm('提示','确定要删除该子任务？',function(btn){
			if(btn == 'yes') {
				delSubTask();
			} else {
				return;
			}
		});
  	}
  	
  	function delSubTask() {
  		var row = Ext.getCmp('subTaskGrid').getSelectionModel().getSelection()[0];
  		var subTaskId = row.get('subTaskId');
  		MaskLoading();
  		$.ajax({
    		async: false,
  			url: '<%=request.getContextPath()%>/delSubTaskInfoById.do',
  			type: 'POST',
			dataType: "json",
  			data: 'subTaskId='+subTaskId,
  			success: function(json) {
  				Ext.MessageBox.alert('提示','删除成功');
  				Ext.getCmp('subTaskGrid').getStore().reload();
  			}
  		});
    	MaskOver();
  	}
  	
  	function addSubTaskBack() {
  		var data = Ext.getCmp('subTaskForm').getValues();
  		var r = new SubTask(data);
  		var store = Ext.getCmp('subTaskGrid').getStore();
  		var index = store.data.length;
  		store.insert(index,r);
  		Ext.getCmp('subTaskGrid').getView().refresh();
  		Ext.getCmp('subTaskWin').close();
  	}
  	
  	function modifySubTaskBack() {
  		var row = Ext.getCmp('subTaskGrid').getSelectionModel().getSelection()[0];
  		var fields = Ext.getCmp('subTaskForm').getForm().getFields();
  		for(var i = 0; i < fields.length; i++) {
  			var curVal = Ext.getCmp('subTaskForm').getForm().findField(fields.get(i).getName()).getValue();
  			row.set(fields.get(i).getName(),curVal);
  		}
  		Ext.getCmp('subTaskWin').close();
  	}
  	
  	function subTaskGrid() {
		var store = Ext.getCmp('subTaskGrid').getStore();
		var subTasks = new Array();
		store.each(function(rec){
			subTasks.push(Ext.encode(rec.data));
		});
		subTasks = "[" + subTasks + "]";
  		MaskLoading();
		$.ajax({
    		async: false,
			type: 'POST',
			dataType: "json",
			url: '<%=request.getContextPath()%>/saveSubTaskList.do',
			data: 'table='+subTasks+"&_=" + (new Date()).getTime(),
			success: function(data) {
				subTaskGrid.getStore().reload();
			}
		});
    	MaskOver();
  	}
  	
  	function getSubTaskStaff() {
  		SelectStaff.showWin('WF_TEST_PFR','<%=user.getUserId()%>',-1,-1,2,false,1,0);
  	}
  	
  	var afterSelect = function(staffs,option) {
		var staffCode = staffs.staffCode;
		var staffName = staffs.employeeName;
		
		Ext.getCmp('subTaskForm').getForm().findField('testorName').setValue(staffName);
		Ext.getCmp('subTaskForm').getForm().findField('testorName').setValue(staffCode);
	};

  	});
  </script>
</html>
