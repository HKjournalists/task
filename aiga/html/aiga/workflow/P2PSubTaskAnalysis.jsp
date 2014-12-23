<!DOCTYPE html>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.asiainfo.aiga.common.WorkflowParam"%>
<%@include file="/aiga/common/common.jsp"%>
<%
	String subTaskId = request.getParameter("objId");
%>
<html>
	<head>
		<title>端到端子任务分析</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ie-tab.css">
		<style type="text/css">
			.float-form-left {
				float: left;
			}
			
			.float-form-left div {
				border-left: none;
			}
			
			.float-form-right {
				float: right;
			}
			
			.float-form-right div {
				border-right: none;
			}
			
			#formDiv {
				/*
				width: 100%;
				border: 1px solid #99bce8;
				*/
				display: inline-block;
				margin-bottom: 15px;
			}
			
			.fun-elem {
				position: relative;
				margin-left: 20px;
			}
			
			.none-border div {
				border-style: none;
			}
			
			.icon-ok {
				display: inline-block;
				width: 20px;
				height: 20px;
				background: url('<%=request.getContextPath()%>/css/images/yes.png')
					no-repeat;
			}
			
			.x-collapsed {
				border: none;
			}
		</style>
	</head>
	<body>
		<div id="base">
			<div id="formDiv"></div>
			<div id="fileTrans" style="display: none;"><jsp:include
					page="/aiga/attach/fileTrans.jsp"></jsp:include></div>
		</div>
	</body>
	<script type="text/javascript">
		
		var screenWidth = document.documentElement.clientWidth;
		var screenHeight = document.documentElement.clientHeight;
		
		var extIndex = 0;
		
		Ext.onReady(init);
		
		function init() {
			Ext.tip.QuickTipManager.init();
			regeditData();
			addReqForm();
			addFunpTabs();
			//refreshFuns();
			addResource();
			refreshFun();
			/*
			*/
		}
		
		function regeditData(){
			Ext.define('TestTask',{
			    extend: 'Ext.data.Model',
			    fields: [
			        {name: 'taskId',type: 'int',convert: null},
			        {name: 'reqId',type: 'int',convert: null},
			        {name: 'currentStatus',type: 'int',convert: null},
			        {name: 'priority',type: 'int',convert: null},
			        {name: 'taskTag',type: 'string'},
			        {name: 'reqTag',type: 'string'},
			        {name: 'plCompleteTime',type: 'string'},
			        {name: 'factCompleteTime',type: 'string'},
			        {name: 'createTime',type: 'string'},
			        {name: 'devWorkDay',type: 'string'},
			        {name: 'testWorkDay',type: 'string'},
			        {name: 'taskName',type: 'string'},
			        {name: 'distributeStaffId', type: 'string'},
			        {name: 'bigType', type: 'string'},
			        {name: 'isPerformanceTest',type: 'string'},
			        {name: 'isJoinTest',type: 'string'},
			        {name: 'isCrossTest',type: 'string'},
			        {name: 'isPoint2pointTest',type: 'string'},
			        {name: 'runPersion',type: 'string'},
			        {name: 'distributeTime',type: 'string'},
			        {name: 'planId',type: 'int',convert: null},
			        {name: 'subType',type: 'string'},
			        {name: 'devTag',type: 'string'},
			        {name: 'testType',type: 'string'},
			        {name: 'testFirm',type: 'string'},
			        {name: 'devFirm',type: 'string'},
			        {name: 'isImportanceReq',type: 'string'},
			        {name: 'testPersionOpinion',type: 'string'},
			        {name: 'reqPersion',type: 'string'},
			        {name: 'distributeStaffname',type: 'string'},
			        {name: 'testProgress',type: 'string'},
			        {name: 'testSituation',type: 'string'},
			        {name: 'defectNumber',type: 'string'},
			        {name: 'initialSituation',type: 'string'},
			        {name: 'testGroup',type: 'string'},
			        {name: 'devPersion',type: 'string'},
			        {name: 'devAdmin',type: 'string'},
			        {name: 'onlineTime',type: 'string'},
			        {name: 'taskPhase',type: 'string'},
			        {name: 'planTag',type: 'string'}
			    ]
			});
			Ext.define('Element', {
			    extend: 'Ext.data.Model',
			    fields: [
			        {name: 'id', type: 'int', convert: null},
			        {name: 'funTag',  type: 'string'},
			        {name: 'testelemTag',  type: 'string'},
			        {name: 'elemName',  type: 'string'},
			        {name: 'elemCondition',  type: 'string'},
			        {name: 'manuplate',  type: 'string'},
			        {name: 'result',  type: 'string'},
			        {name: 'checkDesc',  type: 'string'},
			        {name: 'size', type: 'int'}
			    ]
			});
			Ext.define('FuncPoint',{
				extend: 'Ext.data.Model',
				fields: [
					{name: 'funId', type: 'int', convert: null},
			        {name: 'funTag',  type: 'string'},
			        {name: 'funName',  type: 'string'},
			        {name: 'checkDesc',  type: 'string'},
			        {name: 'funDesc',  type: 'string'},
			        {name: 'testelemTag',  type: 'string'},
			        {name: 'funType',  type: 'int', convert: null},
			        {name: 'subTaskId',  type: 'int', convert: null},
			        {name: 'funPath',  type: 'string'},
			        {name: 'subSystem',  type: 'string'},
			        {name: 'subGroup',  type: 'string'},
			        {name: 'asiaAdmin',  type: 'string'},
			        {name: 'mobileAdmin',  type: 'string'},
			        {name: 'isAuto',  type: 'string'},
			        {name: 'isNeedAuto',  type: 'string'},
			        {name: 'autoAdmin',  type: 'string'},
			        {name: 'autoDevMonth',  type: 'string'},
			        {name: 'subFun',  type: 'string'},
			        {name: 'inter',  type: 'string'},
			        {name: 'remark',  type: 'string'},
			        {name: 'funSeq',  type: 'string'}
				]
			});
			Ext.define('Knowledge',{
	        	extend: 'Ext.data.Model',
	        	fields:[
	        		{name:'knowledgeId', type:'int', convert: null},
	        		{name:'sysName', type:'string'},
	        		{name:'subSysName', type:'string'},
	        		{name:'moduleName', type:'string'},
	        		{name:'knowledgeName', type:'string'},
	        		{name:'knowledgeType', type:'int', convert: null},
	        		{name:'knowledgeDesc', type:'string'}
	        	]
	        });
			Ext.define('Resource', {
				extend: 'Ext.data.Model',
				fields: [
					{name: 'id', type: 'int', convert: null},
			        {name: 'subTaskId',  type: 'int', defaultValue:'<%=subTaskId%>'},
			        {name: 'resourceType',  type: 'String'},
			        {name: 'resourceDesc',  type: 'string'}
				]
			});
			Ext.define('SubReason', {
				extend: 'Ext.data.Model',
				fields: [
					{name: 'reasonId', type: 'int', convert: null},
			        {name: 'subTaskId',  type: 'int', defaultValue:'<%=subTaskId%>'},
			        {name: 'reasonType',  type: 'String', convert: null},
			        {name: 'reasonEnvType',  type: 'String', convert: null},
			        {name: 'reasonDesc',  type: 'string'}
				]
			});
			var workflowParamStore = new Ext.data.Store({
				autoLoad: true,
				mode: 'remote',
	            id: 'workflowParamStore',
	            fields: ['phaseId', 'phaseName', 'linkId', 'vmTaskName'],
	            proxy: {
	                type: 'ajax',
	                url: '<%=request.getContextPath()%>/getWorkflowParam.do?query=50000',
	                reader: {
	                    type: 'json',
	                    root: 'data'
	                }
	            }
	        });
	        var knowledgeType = new Ext.data.Store({
				autoLoad: true,
				mode: 'remote',
			 	id: 'knowledgeType',
			    fields: ['value','show'],
			    proxy: {
				   	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=knowledge_type'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			   }
			});
			var priorityStore = new Ext.data.Store({
	            autoLoad: true,
				mode: 'remote',
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
			var importance = new Ext.data.Store({
				autoLoad: true,
				mode: 'remote',
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
				mode: 'remote',
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
				mode: 'remote',
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
				mode: 'remote',
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
			 	autoLoad: true,
				mode: 'remote',
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
				mode: 'remote',
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
				mode: 'remote',
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
				mode: 'remote',
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
				mode: 'remote',
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
			var funType = new Ext.data.Store({
			 	autoLoad: true,
				mode: 'remote',
			 	id: 'funType',
			    fields: ['value','show'],
			    proxy: {
			    	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=fun_type'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			    }
			});
			var resType = new Ext.data.Store({
			 	autoLoad: true,
				mode: 'remote',
			 	id: 'resType',
			    fields: ['value','show'],
			    proxy: {
			    	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=resource_type'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			    }
			});
			var reasonType = new Ext.data.Store({
			 	autoLoad: true,
				mode: 'remote',
			 	id: 'reasonType',
			    fields: ['value','show'],
			    proxy: {
			    	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=test_unable_reason'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			    }
			});
			var reasonEnvType = new Ext.data.Store({
			 	autoLoad: true,
				mode: 'remote',
			 	id: 'reasonEnvType',
			    fields: ['value','show'],
			    proxy: {
			    	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=test_unable_env'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			    }
			});
		}
		
		function hideXMask() {
			$(".x-mask").each(function(){
				if($(this).css("visibility") == "hidden") {
					$(this).addClass("not-dis");
				}
			});
		}
		
		function addReqForm() {
			var subTaskForm = new Ext.form.FormPanel({
				id: 'subTaskForm',
				renderTo: Ext.get('formDiv'),
				layout: 'vbox',
				collapsible: true,
				titleCollapse: true,
				title: '端到端子任务信息',
				cls: 'ui-formPanel',
				width: screenWidth*0.96,
				bodyBorder: 1,
				fieldDefaults: {
				    labelAlign: 'right',
				    labelWidth: 60,
				    labelStyle: 'font-weight:bold'
				},
				defaults: { 
				    margins: '5 0 0 0'
				},
				items: [
				{
					xtype: 'fieldcontainer',
	                labelStyle: 'font-weight:bold;padding:0',
	                layout: 'hbox',
	                defaultType: 'textfield',
	                fieldDefaults: {
	                    labelAlign: 'right'
	                },
	                items:[
	                	 {
		                    width: 690,
		                    name: 'subTaskName',
		                    fieldLabel: '子任务名称',
		                    allowBlank: false
		                },
		                {
		                	name:"reqTag",
		                	fieldLabel : "需求编号"
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
		                	width: 230,
		                	xtype: 'combo',
		                    valueField: 'linkId',
            				displayField: 'vmTaskName',
		                	store: 'workflowParamStore',
		                    name: 'subTaskStatus',
		                    fieldLabel: '测试子任务状态',
		                    allowBlank: false
		                }, {
			            	width: 230, 
			                name: 'creatorStaff',
			                fieldLabel: '子任务派发人', 
			                allowBlank: false 
		            	},{
		                	width: 230,
		                	name:"subTaskTag",
		                	fieldLabel : "子任务编号"
		                },
		                {
			            	width: 230,
			                name:'subTaskPriority',
			                xtype: 'combo',
			                displayField: 'show',
			                store: 'priorityStore',
			                valueField: 'value',
			                fieldLabel: '子任务优先级',
			                allowBlank: false
		            },
		            	{
		                	xtype: "hidden",
		                	name:"subTaskId",
		                	fieldLabel : "子任务ID"
		                },{
		                	xtype: "hidden",
		                	name:"taskId",
		                	fieldLabel : "taskId"
		                },{
		                	xtype: 'hidden',
		                    name: 'taskTag',
		                    fieldLabel: '任务编号',
		                    allowBlank: false
		                },{
		                	xtype: 'hidden',
		                    name: 'subTaskType',
		                    fieldLabel: '子任务类型',
		                    allowBlank: false
		                },{
		                	xtype: 'hidden',
		                    name: 'creatorStaff',
		                    allowBlank: false
		                },{
		                	xtype: 'hidden',
		                    name: 'curPhase',
		                    allowBlank: false
		                },{
		                	xtype: 'hidden',
		                    name: 'testorId',
		                    allowBlank: false
		                },{
		                	xtype: 'hidden',
		                    name: 'testorName',
		                    allowBlank: false
		                },{
		                	xtype: 'hidden',
		                    name: 'isJoinDebug',
		                    allowBlank: false
		                },{
		                	xtype: 'hidden',
		                    name: 'joinEnvironment',
		                    allowBlank: false
		                },{
		                	xtype: 'hidden',
		                    name: 'submitStaffId',
		                    allowBlank: false
		                },{
		                	xtype: 'hidden',
		                    name: 'subStaffName',
		                    allowBlank: false
		                },{
		                	xtype: 'hidden',
		                	name: 'plCompleteTime'
		                },{
		                	xtype: 'hidden',
		                	name: 'devWorkDay'
		                },{
		                	xtype: 'hidden',
		                	name: 'creator'
		                }
	                ]
	            }, {
	           		xtype: 'fieldcontainer',
	                labelStyle: 'font-weight:bold;padding:0',
	                layout: 'hbox',
	                fieldDefaults: {
	                    labelAlign: 'right'
	                },
					items:[
					{
						width: 230,
		                xtype: 'datetimefield',
		                name: 'createTime',
						readOnly: true,
		                fieldLabel: '创建时间'
					},
					{ 
	                    width: 230,
	                    xtype: 'datefield',
	                    format: 'Y-m-d',
	                    name: 'factCompleteTime',
	                    readOnly: true,
	                    fieldLabel: '计划上线时间'
	                },
		            {
		            	width: 230,
		            	xtype:'numberfield',
		                name:'testWorkDay',
		                fieldLabel: '测试任务工时',
		                readOnly: true
		            },
		            {
		            	html:'<a id="rSubCase" href="javascript:void(0)" style="margin-left: 22px;" onclick="gotoRSubCase()">关联用例数 0</a>'
		            }]
		        }]
			});
			var reqForm = new Ext.form.FormPanel({
				id: 'reqForm',
				renderTo: Ext.get('formDiv'),
				layout: 'vbox',
				collapsed: true,
				collapsible: true,
				titleCollapse: true,
				title: '关联需求信息',
				renderTo: Ext.get('formDiv'),
				cls: 'ui-formPanel not-dis',
				width: 1000,
				height: 200,
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
		                	xtype: "hidden",
		                	name:"reqId",
		                	fieldLabel : "需求ID"
		                },{
		                	width: 230,
		                	name:"reqNo",
		                	fieldLabel : "需求编号"
		                },{
		                	width: 230,
		                    name: 'reqName',
		                    fieldLabel: '需求名称',
		                    allowBlank: false
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
					items:[{
		                    width: 230,
		                    name: 'otherSystemTestNeeded',
		                    fieldLabel: '是否联调',
		                    allowBlank: false
		                },{
		            	width: 230, 
		                name: 'importance',
		                fieldLabel: '重要性', 
		                allowBlank: false 
		            }]
		        },
	            {
            		xtype: 'fieldcontainer',
	                labelStyle: 'font-weight:bold;padding:0',
	                layout: 'hbox',
	                defaultType: 'textfield',
	                fieldDefaults: {
	                    labelAlign: 'right'
	                },
					items:[ { 
	                    width: 230, 
	                    name: 'systemCategory', 
	                    fieldLabel: '系统大类',
	                    allowBlank: false 
	                },
	                {
		            	width: 230,
		                name:'systemSubCategory',
		                fieldLabel: '系统子类',
		                allowBlank: false
		            }]
		        },
		        {
            		xtype: 'fieldcontainer',
	                labelStyle: 'font-weight:bold;padding:0',
	                layout: 'hbox',
	                defaultType: 'textfield',
	                fieldDefaults: {
	                    labelAlign: 'right'
	                },
					items:[{
		            	width: 230,
		                name:'sysFunction',
		                fieldLabel: '功能模块',
		                allowBlank: false
		            },
		            {
		            	width: 230,
		                name:'testWorkDays',
		                fieldLabel: '测试任务工时',
		                allowBlank: false
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
					items:[{
		            	width: 230,
		                name:'devWorkDays',
		                fieldLabel: '开发任务工时',
		                allowBlank: false
		            },{
		            	width: 230,
		                name:'dev',
		                fieldLabel: '开发商',
		                allowBlank: false
		            }]
		        },
		        {
            		xtype: 'fieldcontainer',
	                labelStyle: 'font-weight:bold;padding:0',
	                layout: 'hbox',
	                defaultType: 'textfield',
	                fieldDefaults: {
	                    labelAlign: 'right'
	                },
					items:[
		            {
		            	width: 230,
		                name:'priority',
		                fieldLabel: '优先级',
		                allowBlank: false
		            },
		            {
		            	width: 230,
		                name:'status',
		                fieldLabel: '需求状态',
		                allowBlank: false
		            }]
		        },
		        {
            		xtype: 'fieldcontainer',
	                labelStyle: 'font-weight:bold;padding:0',
	                layout: 'hbox',
	                defaultType: 'textfield',
	                fieldDefaults: {
	                    labelAlign: 'right'
	                },
					items:[
		            {
		            	width: 230,
		                name:'isOverCircle',
		                fieldLabel: '跨周期需求',
		                allowBlank: false
		            },
		            {
		            	width: 230,
		                name:'isClientClient',
		                fieldLabel: '端到端测试',
		                allowBlank: false
		            }]
		        }]
			});
			var taskGridStore = new Ext.data.Store({
				model: 'TestTask',
				id: 'taskGridStore',
				proxy: {
					type: 'ajax',
					reader: {
				        type: 'json',
				        root: 'data'
				    }
				}
			});
			var taskGrid = new Ext.grid.Panel({
				id: 'taskGrid',
				renderTo: Ext.get('formDiv'),
				layout: 'fit',
				title: '需求任务列表',
				cls: 'ui-formPanel float-form-right',
				collapsible: true,
				collapsed: true,
				titleCollapse: true,
				store: taskGridStore,
				width: screenWidth*0.96,
				height: 250,
				bodyBorder: 0,
				columns:[
					{xtype:'rownumberer'},
	  				{header:'任务编号',dataIndex:'taskTag',field:'textfield',width:100},
	  				{header:'任务名称',dataIndex:'taskName',field:'textfield',width:100},
	  				{header:'创建时间',dataIndex:'createTime',field:'textfield',width:100},
	  				{header:'计划完成时间',dataIndex:'plCompleteTime',field:'textfield',width:100},
	  				{header:'开发任务工时',dataIndex:'devWorkDay',field:'textfield',width:100},
	  				{header:'测试任务工时',dataIndex:'testWorkDay',field:'textfield',width:100},
	  				{header:'优先级',dataIndex:'priority',field:'textfield',width:100}
				]
			});
			
			loadReq();
		}
		
		function loadReq() {
			Ext.getCmp("subTaskForm").getForm().load({url:'<%=request.getContextPath()%>/getTestSubTaskById.do',
				params:{subTaskId:'<%=subTaskId%>'},
				success: function(form, action) {
					refreshRelaCaseCount();
					var reqNo = action.result.data.reqTag;
					var taskTag = action.result.data.taskTag;
					Ext.getCmp("reqForm").getForm().load({
						url:'<%=request.getContextPath()%>/getRequisitionByNo.do',
						params:{reqNo: reqNo},
						success : function(form, action) {
							/*
							Ext.getCmp('nowTestForm').getForm().findField('testReply').setValue(action.result.data.testReply);
							Ext.getCmp('nowTestForm').getForm().findField('reqAnalysis').setValue(action.result.data.reqAnalysis);
							Ext.getCmp('nowTestForm').getForm().findField('nowTestInfo').setValue(action.result.data.nowTestInfo);
							*/
							var reqId = form.findField('reqId').getValue();
							Ext.getCmp("taskGrid").getStore().load({
								url:'<%=request.getContextPath()%>/getTestTaskByReqId.do',
								params:{reqId: reqId}
							});
							var value=Ext.getCmp('subTaskForm').getForm().findField('subTaskStatus').getValue();
							if(value==-1){
								Ext.getCmp('subTaskForm').getForm().findField('subTaskStatus').setValue("已关闭");
							}
						}
					});
				}
			});
		}
		
		function subReq() {
			MaskLoading();
			Ext.getCmp("subTaskForm").getForm().submit(
				{
					url:'<%=request.getContextPath()%>/saveSubTaskInfo.do',
					success: function(form, action) {
			MaskOver();
						loadReq();
					},
					failture: function(form, action) {
			MaskOver();
						Ext.MessageBox.alert("提示","提交数据失败");
					}
				}
			);
		}
		
		function addFunpTabs() {
			var store = Ext.create('Ext.data.Store', {
			     autoLoad: true,
				 mode: 'remote',
			     model: "Resource",
			     proxy: {
			         type: 'ajax',
			         url: '<%=request.getContextPath()%>/getResources.do?subTaskId=<%=subTaskId%>'+'&_='+(new Date()).getTime(),
			         reader: {
			             type: 'json',
			             root: 'data'
			         }
			     }
			});
			var reasonStore = Ext.create('Ext.data.Store', {
				autoLoad: true,
				mode: 'remote',
				model: 'SubReason',
				proxy: {
			        type: 'ajax',
			        url: '<%=request.getContextPath()%>/getReasons.do?subTaskId=<%=subTaskId%>'+'&_='+(new Date()).getTime(),
			        reader: {
			            type: 'json',
			            root: 'data'
			        }
			    }
			});
			var tabs = new Ext.TabPanel({
				id: 'funTab',
				width: screenWidth*0.96,
				frame: true,
				height: 420,
				deferredRender: false,
				renderTo: Ext.getBody('base'),
				activeTab: 0,
				cls:"ui-tab-bar",
				bodyCls:"ui-tab-body",
				bodyBorder: 0,
				items: [
					//{id:'tab1',title:'业务点列表',html:'',autoScroll: true},
					{title: '测试场景分析',width:'100%',height: 600,html: "<iframe width='100%' height='360' frameborder='0' src='<%=request.getContextPath()%>/aiga/P2PTestCase/p2pSceneAnalysis.jsp?subTaskId=<%=subTaskId%>' scrolling='auto'></iframe>"},
					/*
					{id:'tab2',title:'现状测试',items:[
						new Ext.form.Panel({
							//title:'现状测试',
							id:'nowTestForm',
							layout: 'vbox',
							fieldDefaults: { 
							    labelAlign: 'right', 
							    labelWidth: 120, 
							    width: 900
							},
							defaults: {
							    margins: '10 0 5 0'
							},
							items:[
								{xtype:'textareafield',fieldLabel:'【测试依据/主要需求描述】',name:'testReply'},
								{xtype:'textareafield',fieldLabel:'【需求分析】',name:'reqAnalysis'},
								{xtype:'textareafield',fieldLabel:'【现状测试】',name:'nowTestInfo'}
							]
						})
					]},
					*/
					Ext.create('Ext.grid.Panel', {
						title: '资源描述',
						id: 'resPanel',
						store: store,
						width:screenWidth*0.78,
					    columns: [
					    	{xtype:'rownumberer'},
					    	{dataIndex: 'id', hidden: true},
					    	{dataIndex: 'reqId', hidden: true},
					    	{header: '资源类型', dataIndex:'resourceType', editor:{xtype:'combo',displayField:'show', valueField:'value', store:'resType'},
					    		renderer:function(value){
					    			var rec = Ext.StoreMgr.get('resType').find('value',value);
					    			if(rec == -1) {
					    				return '';
					    			}
					    			return Ext.StoreMgr.get('resType').getAt(rec).raw.show;
					    		}
					    	},
					        {header: '资源描述', dataIndex: 'resourceDesc', field: 'textarea' ,height: 20,flex: 1}
					    ],
					    selType: 'cellmodel',
					    plugins: [
					        Ext.create('Ext.grid.plugin.CellEditing', {
					            clicksToEdit: 1
					        })
					    ],
					    height: 200,
					    width: screenWidth*0.79,
					    tbar: [
						    {
						    	text: '新增',
						    	height: 20,
						    	width: 40,
						    	handler: function() {
						    		var r = Ext.create('Resource');
						    		var index = store.data.length;
							    	store.insert(index,r);
							    	gridPanel3.getView().refresh();
						    	}
						    },
						    {
						    	text: '删除',
						    	height: 20,
						    	width: 40,
						    	handler: function() {
						    		confirmDelRes();
						    	}
						    },
						    {
						    	text: '保存',
						    	height: 20,
						    	width: 40,
						    	handler: function() {
						    		saveResources();
						    	}
						    }
					    ]
					}),
					Ext.create('Ext.grid.Panel', {
						title: '可测性分析',
						id: 'reasonPanel',
						store: reasonStore,
						width:screenWidth*0.78,
					    columns: [
					    	{xtype:'rownumberer'},
					    	{dataIndex: 'reasonId', hidden: true},
					    	{dataIndex: 'subTaskId', hidden: true},
					    	{header: '不可测环境', dataIndex:'reasonEnvType', editor:{xtype:'combo',displayField:'show', valueField:'value', store:'reasonEnvType'},
					    		renderer:function(value){
					    			var rec = Ext.StoreMgr.get('reasonEnvType').find('value',value);
					    			if(rec == -1) {
					    				return '';
					    			}
					    			return Ext.StoreMgr.get('reasonEnvType').getAt(rec).raw.show;
					    		}
					    	},
					    	{header: '不可测类型', dataIndex:'reasonType', editor:{xtype:'combo',displayField:'show', valueField:'value', store:'reasonType'},
					    		renderer:function(value){
					    			var rec = Ext.StoreMgr.get('reasonType').find('value',value);
					    			if(rec == -1) {
					    				return '';
					    			}
					    			return Ext.StoreMgr.get('reasonType').getAt(rec).raw.show;
					    		}
					    	},
					        {header: '不可测描述', dataIndex: 'reasonDesc', field: 'textarea' ,height: 20,flex: 1}
					    ],
					    selType: 'cellmodel',
					    plugins: [
					        Ext.create('Ext.grid.plugin.CellEditing', {
					            clicksToEdit: 1
					        })
					    ],
					    height: 200,
					    width: screenWidth*0.79,
					    tbar: [
						    {
						    	text: '新增',
						    	height: 20,
						    	width: 40,
						    	handler: function() {
						    		var r = Ext.create('Resource');
						    		var index = reasonStore.data.length;
							    	reasonStore.insert(index,r);
							    	Ext.getCmp('reasonPanel').getView().refresh();
						    	}
						    },
						    {
						    	text: '删除',
						    	height: 20,
						    	width: 40,
						    	handler: function() {
						    		confirmDelReason();
						    	}
						    },
						    {
						    	text: '保存',
						    	height: 20,
						    	width: 40,
						    	handler: function() {
						    		saveReasons();
						    	}
						    }
					    ]
					}),
					{title: "历史轨迹",width:screenWidth*0.78,height:350,html: '<iframe id="f_1" scrolling="auto" frameborder="0" width="100%" height="250" src="<%=request.getContextPath()%>/aiga/workflow/common/HistoryTrack.jsp?objId=${param.objId}&objType=${param.objType}"></iframe>'},
					{
						title: '附件列表',
						contentEl:'fileTrans',
	                    listeners:{
	                    	beforeshow:function(tab,eOpts){
	                    		$('#fileTrans').show();
	                    		var subTaskTag = Ext.getCmp('subTaskForm').getForm().findField('subTaskTag').getValue();
                    			initPackList(subTaskTag, '3', current_linkNo,'0','0',false);
	                    	}
	                    }
                    }
				],
				buttons:[
					//{text:'分析完毕（全部提交）',handler: funSub},
					//{text:'查看用例集',handler: function(){viewCollection();}}
				]
			});
			var zTabs = Ext.select("#funTab");
			//zTabs.insertHtml("afterBegin",'<div style="position: absolute; right: -16px; top: 5px; z-index: 2;"><a href="javascript:;" class="W_btn_c fn-mr-20" onclick="addFunArea();return false;"><span>新增业务点</span></a></div>');
			//zTabs.insertHtml("afterBegin",'<div style="position: absolute; right: 80px; top: 5px; z-index: 2;"><a href="javascript:;" class="W_btn_c fn-mr-20" onclick="addFun();return false;"><span>新增分析点</span></a></div>');
		}
		
		function addResource() {
		}
		
		function confirmRemoveFun() {
			var funId = $(event.srcElement).parents(".tab1-fun").attr("id");
			Ext.MessageBox.confirm('提示','确定要删除该业务点及相关测试要素？',function(btn){
				if(btn == 'yes') {
					removeFun(funId);
				} else {
					return;
				}
			});
		}
		
		function confirmRemoveElem() {
			var elemGridId = $(event.srcElement).parents(".x-grid").attr("id");
			Ext.MessageBox.confirm('提示','确定要删除该测试要素及相关用例关系？',function(btn){
				if(btn == 'yes') {
					removeElem(elemGridId);
				} else {
					return;
				}
			});
		}
		
		function removeElem(elemGridId) {
			var curSelect = Ext.getCmp(elemGridId).getSelectionModel().getSelection();
			if(curSelect.length == 0) {
				return;
			}
			var elemTag = curSelect[0].get("testelemTag");
	  		MaskLoading();
			$.ajax({
	    		async: false,
				url: '<%=request.getContextPath()%>/deleteTestElem.do',
				type: 'POST',
				dataType: "json",
				data: 'elemTag='+elemTag+'&_='+(new Date()).getTime(),
				success: function(json) {
					Ext.getCmp(elemGridId).getStore().remove(curSelect);
					Ext.getCmp(elemGridId).getView().refresh();
				}
			});
	    	MaskOver();
		}
		
		function removeFun(funId) {
			var funIndex = $("#tab1-body").find(".tab1-fun").length;
			if(funIndex == 1) {
				alert("无法删除最后节点");
				return;
			}
			var curIndex = funId.replace("funP","");
			var curFunTag = Ext.getCmp("funP"+curIndex).getForm().findField("funTag").getValue();
	  		MaskLoading();
			$.ajax({
	    		async: false,
				url: '<%=request.getContextPath()%>/deleteFunPoint.do',
				type: 'POST',
				dataType: "json",
				data: 'funTag='+curFunTag+'&_='+(new Date()).getTime(),
				success: function(json) {
					$("#funP"+curIndex).remove();
					//$("#elem"+curIndex).remove();
					refreshFunList();
				}
			});
	    	MaskOver();
		}
		
		function refreshFunList() {
			$("#tab1-body").find(".tab1-fun").each(function(index){
				index++;
				var id = $(this).attr("id");
				Ext.getCmp(id).setTitle("业务点"+index);
			});
			$("#tab1-body").find(".x-grid").each(function(index){
				index++;
				var id = $(this).attr("id");
				//Ext.getCmp(id).setTitle("列表要素"+index);
			});
			Ext.getCmp('funTab').doLayout();
		}
		
		function funSave() {
			subReq();
			$("#tab1-body").find(".tab1-fun").each(function(index){
				index++;
				var id = $(this).attr("id");
				var funPNo = id.replace("funP","");
				MaskLoading();
				Ext.getCmp(id).submit({
					url:'<%=request.getContextPath()%>/saveFunPoint.do',
					success: function(form, action) {
				MaskOver();
						$("#funP"+funPNo).remove();
					},
					failture: function(form, action) {
				MaskOver();
						Ext.MessageBox.alert("提示","提交数据失败");
					}
				});
			});
			$("#tab1-body").find(".x-grid").each(function(index){
				index++;
				var id = $(this).attr("id");
				var elemNo = id.replace("elem","")
				var store = Ext.getCmp(id).getStore();
				var elems = new Array();
				store.each(function(rec){
					elems.push(Ext.encode(rec.data));
				});
				elems = "[" + elems + "]";
	  		MaskLoading();
				$.ajax({
	    		async: false,
					type: 'POST',
					dataType: "json",
					url: '<%=request.getContextPath()%>/saveElements.do',
					data: 'table='+elems+"&_=" + (new Date()).getTime(),
					success: function(data) {
						$("#elem"+elemNo).remove();
					}
				});
			});
			
			saveResources();
			saveReasons();
			MaskOver();
			Ext.Msg.alert("提示","数据提交成功");
		}
		
		function funSub() {
			/*
			MaskLoading();
			Ext.getCmp('').getForm().submit({
				url: '<%=request.getContextPath()%>/saveReqNowInfo.do',
				params: {reqId:Ext.getCmp('reqForm').getForm().findField('reqId').getValue()},
				success: function(form, action) {
			MaskOver();
				},
				failtrue: function(form, action) {
			MaskOver();
				}
			});
			*/
			subReq();
			$("#tab1-body").find(".tab1-fun").each(function(index){
				index++;
				var id = $(this).attr("id");
				var funPNo = id.replace("funP","");
				MaskLoading();
				Ext.getCmp(id).submit({
					url:'<%=request.getContextPath()%>/saveFunPoint.do',
					success: function(form, action) {
				MaskOver();
						$("#funP"+funPNo).remove();
					},
					failture: function(form, action) {
						MaskOver();
						Ext.MessageBox.alert("提示","提交数据失败");
					}
				});
			});
			$("#tab1-body").find(".x-grid").each(function(index){
				index++;
				var id = $(this).attr("id");
				var elemNo = id.replace("elem","")
				var store = Ext.getCmp(id).getStore();
				var elems = new Array();
				store.each(function(rec){
					elems.push(Ext.encode(rec.data));
				});
				elems = "[" + elems + "]";
	  		MaskLoading();
				$.ajax({
	    		async: false,
					type: 'POST',
					dataType: "json",
					url: '<%=request.getContextPath()%>/saveElements.do',
					data: 'table='+elems+"&_=" + (new Date()).getTime(),
					success: function(data) {
						$("#elem"+elemNo).remove();
					}
				});
			});
			
			saveResources();
			saveReasons();
			MaskOver();
			Ext.Msg.alert("提示","数据提交成功");
			return true;
		}
		
		function saveResources() {
			var resStore = Ext.getCmp('resPanel').getStore();
			var resources = new Array();
			resStore.each(function(rec){
				resources.push(Ext.encode(rec.data));
			});
			resources = "[" + resources + "]";
	  		MaskLoading();
			$.ajax({
	    		async: false,
				type: 'POST',
				dataType: "json",
				url: '<%=request.getContextPath()%>/saveResources.do',
				data: 'table='+resources+"&_=" + (new Date()).getTime(),
				success: function(data) {
					resStore.reload();
				}
			});
	    	MaskOver();
		}
		
		function saveReasons() {
			var reasonStore = Ext.getCmp('reasonPanel').getStore();
			var reasons = new Array();
			reasonStore.each(function(rec){
				reasons.push(Ext.encode(rec.data));
			});
			reasons = "[" + reasons + "]";
	  		MaskLoading();
			$.ajax({
	    		async: false,
				type: 'POST',
				dataType: "json",
				url: '<%=request.getContextPath()%>/saveReasons.do?subTaskId=<%=subTaskId%>',
				data: 'table='+reasons+"&_=" + (new Date()).getTime(),
				success: function(data) {
					reasonStore.reload();
				}
			});
	    	MaskOver();
		}
		
		function getNewFunTag() {
			var newTag = "FUN"+(new Date()).getTime();
			return newTag;
		}
		
		function getNewElemTag() {
			var newTag = "ELEM"+(new Date()).getTime();
			return newTag;
		}
		
		function refreshFuns() {
	  		MaskLoading();
			$.ajax({
	    		async: false,
				url: '<%=request.getContextPath()%>/getFunPoints.do',
				type: 'POST',
				dataType: "json",
				data: 'subTaskId=<%=subTaskId%>'+'&_='+(new Date()).getTime(),
				success: function(json) {
					var ary = json.data;
					for(var i = 0; i < ary.length; i++) {
						addFunArea(ary[i]);
					}
					if(ary.length == 0) {
						addFunArea();
					}
					expandFirstFun();
				}
			});
	    	MaskOver();
		}
		
		function addFunArea(data) {
			collapseAllFun();
			var isCollapsed = false;
			var newTag = getNewFunTag();
			var newElemTag = getNewElemTag();
			if(data != null) {
				newTag = data.funTag;
			}
			var store = Ext.create('Ext.data.Store', {
			     autoLoad: true,
				 mode: 'remote',
			     model: "Element",
			     proxy: {
			         type: 'ajax',
			         url: '<%=request.getContextPath()%>/getElements.do?funTag='+newTag+'&_='+(new Date()).getTime(),
			         reader: {
			             type: 'json',
			             root: 'data'
			         }
			     }
			});
			var curCount = $("#tab1-body").find(".tab1-fun").length;
			var funForm = new Ext.form.FormPanel({
				title: '业务点'+(++curCount),
				id: 'funP'+(++extIndex),
				width: screenWidth*0.95,
				cls: 'ui-formPanel tab1-fun',
				margin:'5 0 5 0',
				defaults: {
				    margins: '5 0 5 0'
				},
				collapsed: isCollapsed,
				titleCollapse: true,
				collapsible: true,
				bodyBorder: 0,
				layout: 'vbox',
				listeners:{
					beforeexpand:function() {
						collapseAllFun();
					}
				},
				items: [
					{
						layout: 'hbox',
						width:screenWidth*0.75,
						border: 0,
						items: [
							{labelAlign: 'right',width:300,xtype: 'textfield',fieldLabel: '业务点名称',name: 'funName'},
							{labelAlign: 'right',width:300,xtype: 'hidden',fieldLabel: '业务点类型',store: 'funType',displayField: 'show',valueField: 'value',name: 'funType',
								listeners: {
									'select': function(combo, record, index){
										var curVal = record[0].get('value');
										//$('#funP'+extIndex).find('textarea[name=explain]').html(curVal);
									}
								}
							},
							{xtype:'hidden',fieldLabel:'业务点编号',name:'funTag'},
							{xtype:'hidden',fieldLabel:'主键',name:'funId',convert: null},
							{xtype:'hidden',fieldLabel:'关联需求ID',name:'subTaskId',value:'<%=subTaskId%>'}
						]
					},
					{
						layout: 'hbox',
						width: '100%',
						border: 0,
						items: [
							{labelAlign: 'right',width:300,xtype: 'textarea',fieldLabel: '业务点描述',name: 'funDesc'},
							{labelAlign: 'right',width:300,xtype: 'textarea',fieldLabel: '校验说明',name: 'checkDesc'}
						]
					}
				]
			});
			var gridPanel = Ext.create('Ext.grid.Panel', {
			    //title: '要素列表'+curCount,
			    title:'',
				cls: 'ui-formPanel fun-elem',
			    id: 'elem'+extIndex,
			    store: store,
				//renderTo: Ext.getCmp('tab1').body,
			    columns: [
			    	{ xtype:'rownumberer' },
			        { header: '条件',  dataIndex: 'elemCondition' ,height: 20,field:'textfield'
			        },
			        { header: '动作', dataIndex: 'manuplate',
			            field: {
			                xtype: 'textfield',
			                allowBlank: false
			            }
			        },
			        { header: '预期结果', dataIndex: 'result', field: 'textfield'},
			        { header: '校验点', dataIndex: 'checkDesc', field: 'textarea'},
			        { header: '包含用例数', dataIndex: 'size',renderer: function(value){
			        	return "<a href='javascript:void(0)' class='ui-a' onclick='manageRelaCase()'>"+value+"</a>";
			        }},
			        { header: '操作', dataIndex: 'button', renderer:showButton, width: 100},
			        { dataIndex:'id', hidden:true},
			        { dataIndex:'funTag', hidden:true},
			        { dataIndex:'testelemTag', hidden:true}
			    ],
			    selType: 'cellmodel',
			    plugins: [
			        Ext.create('Ext.grid.plugin.CellEditing', {
			            clicksToEdit: 1
			        })
			    ],
			    height: 190,
			    width: screenWidth*0.7,
			    /*
			    buttons:[
					{text:'新增业务点',handler: function(){addFunArea()}},
					{text:'删除业务点',handler: confirmRemoveFun},
					{text:'提交业务点',handler: subCurFun}
				],
				*/
			    tbar: [
				    {
				    	text: '新增',
				    	id: 'addBtnElem'+extIndex,
				    	height: 20,
				    	handler: function() {
				    		var r = Ext.create('Element');
				    		r.set('funTag',newTag);
				    		r.set('testelemTag',newElemTag);
				    		var index = store.data.length;
					    	store.insert(index,r);
					    	gridPanel.getView().refresh();
				    	}
				    },
				    {
				    	text: '删除',
				    	height: 20,
				    	handler: function() {
				    		confirmRemoveElem();
				    	}
				    }
			    ]
			});
			funForm.add(gridPanel);
			Ext.getCmp('tab1').add(funForm);
			var funFormSel = Ext.select('#funP'+extIndex);
			funFormSel.insertHtml("afterBegin",'<div style="position: absolute; right: 70px; top: 8px; z-index: 2;"><img title="删除" onclick="confirmRemoveFun()" src="<%=request.getContextPath()%>/css/images/no.png"  style="width:18px;height:18px;cursor: pointer;"/></div>');
			funFormSel.insertHtml("afterBegin",'<div style="position: absolute; right: 40px; top: 5px; z-index: 2;"><img title="提交" onclick="subCurFun('+extIndex+')" src="<%=request.getContextPath()%>/css/images/yes.png" style="width:22px;height:22px;cursor: pointer;"/></div>');
			var gridPanelSel = Ext.select('#elem'+extIndex);
			var addBtnStr = "$('#addBtnElem"+extIndex+"').click()";
			gridPanelSel.insertHtml("afterBegin",'<div style="position: absolute; left: 0px; top: -1px; *top: 1px; z-index: 2;"><a href="javascript:;" class="W_btn_c fn-mr-20" onclick="'+addBtnStr+';return false;"><span>新增要素</span></a></div>');
			if(data) {
				var thisFunp = new FuncPoint(data);
				funForm.getForm().loadRecord(thisFunp);
			} else {
				funForm.getForm().reset();
				funForm.getForm().findField("funTag").setValue(newTag);
			}
			
			Ext.getCmp('funTab').doLayout();
			setInterval("hideXMask()",1000);
		}
		
		function showButton() {
			var returnStr = "<a href='javascript:void(0)' class='ui-a' onclick='confirmRemoveElem()'>删除</a>";
			return returnStr;
		}
		
		function manageRelaCase() {
			var elemTag = $(event.srcElement).parents(".x-grid-row").children("td:last").children("div").html();
			var curGridId = $(event.srcElement).parents(".x-grid").attr("id");
			/*
			*/
			var win = new top.Ext.window.Window({
				title: '用例管理',
				layout: 'fit',
				width: screenWidth*0.9,
				height: 500,
				modal: true,
				constrain:true,
				id: 'modelWin',
				listeners: {
					'beforeClose': function(){refreshCurElem(curGridId);}
				},
				html: "<iframe src='<%=request.getContextPath()%>/aiga/userCase/manageCase.jsp?subTaskId=<%=subTaskId%>&elemTag="+elemTag+"' frameborder=0 style='width:1000px;height: 650px;overflow: auto;'></iframe>"
			});
			win.show();
		}
		
		function confirmDelRes() {
			var curSel = Ext.getCmp('resPanel').getSelectionModel().getSelection();
			if(curSel.length == 0) {
				return;
			}
			Ext.MessageBox.confirm('提示','确定要删除该资源？',function(btn){
				if(btn == 'yes') {
					delResource();
				} else {
					return;
				}
			});
		}
		
		function confirmDelReason() {
			var curSel = Ext.getCmp('reasonPanel').getSelectionModel().getSelection();
			if(curSel.length == 0) {
				return;
			}
			Ext.MessageBox.confirm('提示','确定要删除该分析？',function(btn){
				if(btn == 'yes') {
					delReason();
				} else {
					return;
				}
			});
		}
		
		function delResource() {
			var curSel = Ext.getCmp('resPanel').getSelectionModel().getSelection();
			var resId = curSel[0].get('id');
			if(!resId) {
				Ext.getCmp('resPanel').getStore().remove(curSel);
    			Ext.getCmp('resPanel').getView().refresh();
    			return;
			}
	  		MaskLoading();
			$.ajax({
	    		async: false,
    			type: 'POST',
    			url: '<%=request.getContextPath()%>/deleteResource.do',
    			data: 'resId='+resId+'&_='+(new Date()).getTime(),
    			success: function(data) {
    				Ext.getCmp('resPanel').getStore().remove(curSel);
    				Ext.getCmp('resPanel').getView().refresh();
    			}
    		});
	    	MaskOver();
		}
		
		function delReason() {
			var curSel = Ext.getCmp('reasonPanel').getSelectionModel().getSelection();
			var reasonId = curSel[0].get('reasonId');
			if(!resId) {
				Ext.getCmp('reasonPanel').getStore().remove(curSel);
    			Ext.getCmp('reasonPanel').getView().refresh();
    			return;
			}
	  		MaskLoading();
			$.ajax({
	    		async: false,
    			type: 'POST',
    			url: '<%=request.getContextPath()%>/deleteReason.do',
    			data: 'reasonId='+reasonId+'&_='+(new Date()).getTime(),
    			success: function(data) {
    				Ext.getCmp('reasonPanel').getStore().remove(curSel);
    				Ext.getCmp('reasonPanel').getView().refresh();
    			}
    		});
	    	MaskOver();
		}
		
		function refreshCurElem(curGridId) {
			var elemTag = Ext.getCmp(curGridId).getSelectionModel().getSelection()[0].get('testelemTag');
			MaskLoading();
			Ext.Ajax.request({
				url:"<%=request.getContextPath()%>/getElemCaseCount.do?elemTag="+elemTag,  
				success:function(response,config){
					MaskOver();
					var caseIdJson = Ext.JSON.decode(response.responseText);
					var size = caseIdJson.size;
					Ext.getCmp(curGridId).getSelectionModel().getSelection()[0].set('size',size);
					Ext.getCmp(curGridId).getSelectionModel().getSelection()[0].commit();
				},
				failure:function(response,config){ 
					MaskOver();
				}
			});
		}
		
		function subCurFun(curId) {
			var funTag = Ext.getCmp("funP"+curId).getForm().findField("funTag").getValue();
			MaskLoading();
			Ext.getCmp("funP"+curId).submit({
				url:'<%=request.getContextPath()%>/saveFunPoint.do',
				success: function(form, action) {
			MaskOver();
					Ext.getCmp("funP"+curId).load({
						url: '<%=request.getContextPath()%>/getFunPByTag.do?funTag='+funTag
					});
				},
				failture: function(form, action) {
			MaskOver();
					Ext.MessageBox.alert("提示","提交数据失败");
				}
			});
			var curElemId = "elem"+curId;
			var store = Ext.getCmp(curElemId).getStore();
			var elems = new Array();
			store.each(function(rec){
				elems.push(Ext.encode(rec.data));
			});
			elems = "[" + elems + "]";
	  		MaskLoading();
			$.ajax({
	    		async: false,
				type: 'POST',
				dataType: "json",
				url: '<%=request.getContextPath()%>/saveElements.do',
				data: 'table='+elems+"&_=" + (new Date()).getTime(),
				success: function(data) {
					Ext.getCmp("elem"+curId).getStore().reload();
				}
			});
	    	MaskOver();
		}
		
		function viewCollection() {
			var subTaskId = Ext.getCmp('subTaskForm').getForm().findField('subTaskId').getValue();
			var win = new top.Ext.window.Window({
				title: '用例集管理',
				layout: 'fit',
				width: screenWidth*0.8,
				height: 530,
				modal: true,
				constrain:true,
				id: 'collection',
				html: "<iframe src='<%=request.getContextPath()%>/aiga/userCase/caseCollection.jsp?subTaskId="+subTaskId+"' frameborder='0' width='930' height='530'></iframe>"
			});
			win.show();
		}
		
		function collapseAllFun() {
			$("#tab1-body").find(".tab1-fun").each(function(index){
				index++;
				var id = $(this).attr("id");
				var funPNo = id.replace("funP","");
				Ext.getCmp(id).collapse();
			});
		}
		
		function expandFirstFun() {
			$("#tab1-body").find(".tab1-fun:eq(0)").each(function(index){
				index++;
				var id = $(this).attr("id");
				Ext.getCmp(id).expand();
			});
		}
		
		function refreshFun() {
			var newUl = $("<div class='content-div'></div>");
			newUl.appendTo($("#funDiv"));
			refreshChannel(newUl);
		}
		
		function refreshChannel(parUl, data) {
			var spanStr = "<label>功能点：</label><select><option value='1'>功能点1</option></select>";
			spanStr += "<span><label>渠道：</label><select><option value='1'>渠道1</option></select>";
			spanStr += "<label>描述：</label><textarea></textarea><img src='<%=request.getContextPath()%>/images/del.gif' height='12' width='12' title='删除渠道' class='del-img' onclick='delChannel()'/></span>";
			parUl.append(spanStr);
			parUl.append("<img src='<%=request.getContextPath()%>/images/add.gif' width='20' height='20' class='add-img' title='新增渠道' onclick='addChannel()'/>");
		}
		
		function addFun() {
			var spanStr = "<div  class='content-div'>";
			spanStr += "<label>功能点：</label><select><option value='1'>功能点1</option></select>";
			spanStr += "<span><label>渠道：</label><select><option value='1'>渠道1</option></select>";
			spanStr += "<label>描述：</label><textarea></textarea><img src='<%=request.getContextPath()%>/images/del.gif' height='12' width='12' title='删除渠道' class='del-img' onclick='delChannel()'/></span><img src='<%=request.getContextPath()%>/images/add.gif' width='20' height='20' class='add-img' title='新增渠道' onclick='addChannel()'/>";
			spanStr += "</div>";
			var newUl = $(spanStr);
			newUl.appendTo($("#funDiv"));
		}
		
		function addChannel() {
			var curSpan = $(event.srcElement);
			var spanStr = "<span><label>渠道：</label><select><option value='1'>渠道1</option></select>";
			spanStr += "<label>描述：</label><textarea></textarea><img src='<%=request.getContextPath()%>/images/del.gif' height='12' width='12' title='删除渠道' class='del-img' onclick='delChannel()'/></span>";
			curSpan.before(spanStr);
		}
		
		function delChannel() {
			var curSpan = $(event.srcElement).parent();
			curSpan.remove();
		}
		
		function gotoRSubCase() {
			/*
			*/
			var win = new top.Ext.window.Window({
				title: '用例管理',
				layout: 'fit',
				width: screenWidth*0.95,
				height: 650,
				modal: true,
				constrain:true,
				resizable:false,
				id: 'modelWin',
				listeners: {
					'beforeClose': function(){refreshRelaCaseCount();}
				},
				html: "<iframe src='<%=request.getContextPath()%>/aiga/userCase/manageCase.jsp?subTaskId=<%=subTaskId%>&elemTag=SUBTASK<%=subTaskId%>' frameborder=0 style='width:100%;height: 650px;overflow: auto;'></iframe>"
			});
			win.show();
		}
		
		function refreshRelaCaseCount() {
			//rSubCase
			$.ajax({
				url: '<%=request.getContextPath()%>/getRSubCaseCount.do',
				type: 'post',
				dataType: 'json',
				data: 'elemTag=SUBTASK<%=subTaskId%>',
				success: function(data) {
					$("#rSubCase").html("关联用例数 "+data.size);
				}
			});
		}
		
	</script>
</html>