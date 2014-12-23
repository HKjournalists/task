<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp"%>
<%
	String taskId = request.getParameter("taskId");
	String flag = "5";
	boolean isShowTask = (taskId != null && !taskId.equals(""));
	boolean isFlag = (flag != null && !flag.equals(""));
	AigaUser user = (AigaUser) request.getSession().getAttribute(
			"aigaUser");
%>
<html>

	<head>
		<title>任务单查询</title>
		<style type="text/css">
#uploadForm-body table {
	float: left;
}

#uploadForm-body div {
	float: left;
}

.red {
	color: red;
}
</style>
	</head>

	<body>
		<jsp:include page="/aiga/workflow/common/SelectStaff.jsp"></jsp:include>
	</body>
	<script type="text/javascript">
    var staffSelect="";
    var optionHtml="<option value=''></option>";
        var taskId = "${param.taskId}";
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
           
            Ext.require([
    		             'Ext.grid.*',
    		             'Ext.toolbar.Paging',
    		             'Ext.util.*',
    		             'Ext.data.*',
    		             'Ext.ux.*'
    		         ]);
        Ext.onReady(function () {
            Ext.QuickTips.init();
            Ext.tip.QuickTipManager.init();
            var dateFormat = Ext.Date.format(new Date, 'YmdHisu');
            taskTag = "TT" + dateFormat;
            /////map 
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
                        taskWorkflowParamStore.load({params:{query:"30000,90000,70000"}});
                    }
                }
            });
            mapStore.load();
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
			      taskStore.load({
			                params: {
			                    taskFlag: "5"
			                }
			            });
			            
			            
                    }
                }
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
                },
                listeners:{
        	    	load:function(store,records,successful, eOpts ){
        	    		store.insert(0,{value:'',show:'--全部--'});
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
                    url: '<%=request.getContextPath()%>/getQryAndOther2.do?query=subTypeStore',
                    reader: {
                        type: 'json',
                        root: 'data'
                    }
                },
                listeners:{
    	    	load:function(store,records,successful, eOpts ){
    	    		store.insert(0,{value:'',show:'--全部--'});
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
	            
	           var priorityStore = new Ext.data.Store({
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
            
            var taskPhaseCombox = new Ext.form.ComboBox({
                width: 250,
                store: workflowParamStore,
                name: 'taskPhase',
                fieldLabel: "任务所处阶段",
                valueField: 'phaseId',
                displayField: 'phaseName',
                listeners: {},value:1,readOnly:true
            });
            var taskStatusCombox = new Ext.form.ComboBox({
            	width: 170,
			    labelWidth: 60,
                store: workflowParamStore,
                id:"tbarTaskStatus",
                name: 'currentStatus',
                fieldLabel: "任务状态",
                valueField: 'linkId',
                displayField: 'vmTaskName',
                hidden:true,
                listeners: {
                }
            ,value:101,readOnly:true
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
             //////////////////////////////////////////////////////////////////////////
            
            
            
            
            
           
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
                	load : function(store, records, options ){
                    	var rs = {
                    			phaseName:'--请选择---',	
                    			vmTaskName:'--请选择---',
                    			linkId:'',
                    			phaseId:''
                    	}
                        store.insert(0,rs);  
						var rec = store.find('linkId',199);
		                if(rec!=-1){
		               		store.removeAt(rec);
		                }
                        return true;
                    }
                }
            });
            workflowParamStore.load();
            
            var taskStore = Ext.create('Ext.data.Store', {
                storeId: 'taskStore',
				pageSize:20, //每页显示条数
                fields: [
                         {
                        name: 'planName',
                        type: 'string'
                    },{
                        name: 'taskId',
                        type: 'string'
                    }, {
                        name: 'staffsId',
                        type: 'string'
                    },{
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
                    },
                    {
                        name: 'isJointTest',
                        type: 'string'
                    },
                    {
                        name: 'planName',
                        type: 'string'
                    },
                    { name: 'uetTaskId',
                    	type: 'string'
	                },
	                {
	                    name: 'perfTaskId',
	                    type: 'string'
	                },
                
                    {
                        name: 'planId',
                        type: 'string'
                    }
                ],
                proxy: {
                    type: 'ajax',
                    url: '<%=request.getContextPath()%>/getTestTaskListForClose.do',
                    reader: {
                        root: "data",
                        type: "json",
            			totalProperty:'total'
                    }
                }
            });
            
           var btn = new Ext.Button({
    			id: 'qryBtn',
    			text: '查询',
    			width: 60,
    			margin: '0 0 0 50px',
    			handler: function(){
    				queryTask();
    			}
    		});
    		var btn1 = new Ext.Button({
    			id: 'closeBtn',
    			text: "<div data-qtip='选择任务后可关闭选中的任务'>关闭任务</div>",
    			width: 80,
    			margin: '0 0 0 50px',
    			handler: function(){
    				closeSubTask();
    			}
    		});
            
            var qryForm = new Ext.form.FormPanel({
    			id:'qryForm',
    			title:'查询区域',
    			cls:'ui-formPanel',
    			defaults: { 
					margins: '5 0 5 0',
				},
    			renderTo: Ext.getBody(),
    			width: screenWidth*0.98,
    			height: screenHeight*0.2*0.99,
    			layout: 'vbox',
    			bodyBorder: 0, 
    			items: [
    				{
	    				xtype: 'fieldcontainer', 
					    labelStyle: 'font-weight:bold;padding:0', 
		    			fieldDefaults: { 
							labelAlign: 'right', 
							labelWidth: 80,
							width: 220
						},
					    layout: 'hbox', 
					    defaultType: 'textfield',
					    items: [
					    	{name:'taskTag',fieldLabel:'测试任务编号'},
					    	{name:'taskName',fieldLabel:'测试任务名称'},
					    	{xtype:'combo',name:'testType',fieldLabel:'测试任务类型',store:'testTypeStore',displayField:'show',valueField:'value'},
							{xtype:'datefield',name:'beginDate',format:'Y-m-d',fieldLabel:'上线时间从',
								listeners:{
									select: function() {
										var start = Ext.getCmp('qryForm').getForm().findField('beginDate').getValue();
							            Ext.getCmp('qryForm').getForm().findField('endDate').setMinValue(start);   
										var endDate = Ext.getCmp('qryForm').getForm().findField('endDate').getValue();
							            if(start > endDate&&endDate!=null){   
							                Ext.getCmp('qryForm').getForm().findField('endDate').setValue(start);
							            }   
									}
								}
							},
							{xtype:'datefield',name:'endDate',format:'Y-m-d',fieldLabel:'到'}
					    ]
					},{
						xtype: 'fieldcontainer', 
					    labelStyle: 'font-weight:bold;padding:0', 
		    			fieldDefaults: { 
							labelAlign: 'right', 
							labelWidth: 80,
							width: 220
						},
					    layout: 'hbox', 
					    defaultType: 'textfield',
					 	items: [
					 		{xtype:'combo',name:'bigType',fieldLabel:'系统大类',store:'bigTypeStore',displayField:'show',valueField:'value',
						 		listeners:{
							    	change: function(combo, newValue, oldValue, eOpts) {
							    		Ext.getCmp('qryForm').getForm().findField('subType').setValue("");
							    		Ext.StoreMgr.get('subTypeStore').setProxy({type: 'ajax',
									        url: '<%=request.getContextPath()%>/getQryAndOther2.do?query=subTypeStore&other2='+newValue,
									        reader: {
									        	type: 'json',
									        	root: 'data'
									    }});
							    		Ext.StoreMgr.get('subTypeStore').load();
							    	}
							    }
				    		},
                        	{xtype:'combo',name:'subType',fieldLabel:'系统子类',store:'subTypeStore',displayField:'show',valueField:'value'},
							btn,btn1
					 	]
					}
    			]
    		});
            var taskGrid = Ext.create('Ext.grid.Panel', {
                id: 'taskGrid',
                cls: 'ui-formPanel',
                title: '任务单列表',
               // margins: '0 0 0 3',
		        bbar: Ext.create('Ext.PagingToolbar', { 
					store: taskStore, 
					displayInfo: true, 
					displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
					emptyMsg: "没有数据"
				}),
				
                height: screenHeight*0.8*0.98,
                width: screenWidth*0.98,
                /**
        		**编辑插件
        		**/
        		plugins:[
        			Ext.create('Ext.grid.plugin.CellEditing', {
                    triggerEvent:'cellclick'
                })],
                //forctFit: true,
                //stripeRows: true,
               // loadMask: true,
                store: taskStore,
                selType: 'rowmodel',
                selModel:top.Ext.create('Ext.selection.CheckboxModel',{mode:"SIMPLE"}),
                columns: [
                         new Ext.grid.RowNumberer({  header　:　"序号",  width　:　30}),
                        {
                            header: "测试任务编号",
                            width: 150,
                            sortable: true,
                            dataIndex: 'taskTag'
                        },
                        {
                            header: "测试任务名称",
                            width: 300,
                            sortable: true,
                            dataIndex: 'taskName'
                        }, {
	                        header: '测试任务类型',
	                        dataIndex: 'testType',
	                        width: 80,
	                        align: 'center',
	                        renderer: function (value, cellmeta, record) {
	                            try {
	                                var store = Ext.data.StoreManager.lookup("mapStore");
	                                store.clearFilter(true);
	                                store.filter("categoryName", "testTypeStore");
	                                return store.findRecord("value", value).getData().show + "";
	                            } catch (e) {
	                                return "";
	                            };
	                        }
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
                        header: "测试任务id",
                        width: 100,
                        sortable: true,
                        dataIndex: 'taskId',
                        hidden: true
                    }, {
                        header: "需求编号",
                        width: 100,
                        sortable: true,
                        dataIndex: 'reqTag'
                    }, {
                        header: "需求管理员",
                        width: 100,
                        sortable: true,
                        dataIndex: 'reqPersion'
                    }, {
                        header: "开发任务编号",
                        width: 100,
                        sortable: true,
                        dataIndex: 'devTag'
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
                                if(value==-1){
                                	return "已关闭";
                                }else{
	                                return store.findRecord("linkId", value).getData().vmTaskName + "";
								}
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
                        header: "任务创建时间",
                        width: 100,
                        sortable: true,
                        dataIndex: 'createTime',
                        hidden: true
                    },
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
                            if (value == 'on'||value==1) return "是";
                            else return "否";
                        }
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
                    },{
                        header: '是否需要联调',
                        dataIndex: 'jointTest',
                        width: 60,
                        align: 'center',
                        renderer: function (value, cellmeta, record) {
                            if (value == 'on'||value==1) return "是";
                            else return "否";
                        },
                        hidden: true
                    }, {
                        header: '是否性能测试',
                        dataIndex: 'isPerformanceTest',
                        width: 60,
                        align: 'center',
                        renderer: function (value, cellmeta, record) {
                            if (value == 'on'||value==1) return "是";
                            else return "否";
                        },
                        hidden: true
                    }, {
                        header: '是否跨周期需求',
                        dataIndex: 'isCrossCycle',
                        width: 60,
                        align: 'center',
                        renderer: function (value, cellmeta, record) {
                            if (value == 'on'||value==1) return "是";
                            else return "否";
                        },
                        hidden: true
                    }, {
                        header: '是否端对端测试',
                        dataIndex: 'isPoint2pointTest',
                        width: 60,
                        align: 'center',
                        renderer: function (value, cellmeta, record) {
                            if (value == 'on'||value==1) return "是";
                            else return "否";
                        },
                        hidden: true
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
                        header: "任务单说明",
                        width: 100,
                        sortable: true,
                        dataIndex: 'initialSituation'
                    }
                ]
            });
            Ext.create('Ext.Panel', {
                renderTo: Ext.getBody(),
                cls: 'ui-formPanel',
                width: screenWidth * 0.99,
                height: screenHeight * 0.99,
                minWidth: 1300,
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
                        items:
                        //关联
                        [taskGrid]
                        //编辑页面
                    }
                ]
            })
            });
            
            function queryTask() {
	    		var taskTag = Ext.getCmp('qryForm').getForm().findField('taskTag').getValue();
	    		var taskName = Ext.getCmp('qryForm').getForm().findField('taskName').getValue();
				var testType = Ext.getCmp('qryForm').getForm().findField('testType').getValue();
				var beginDate = Ext.getCmp('qryForm').getForm().findField('beginDate').getValue();
				var endDate = Ext.getCmp('qryForm').getForm().findField('endDate').getValue();
				var bigType = Ext.getCmp('qryForm').getForm().findField('bigType').getValue();
				var subType = Ext.getCmp('qryForm').getForm().findField('subType').getValue();
				Ext.StoreMgr.get('taskStore').on('beforeload',function(){        // =======翻页时 查询条件     
					Ext.apply(       
						Ext.StoreMgr.get('taskStore').proxy.extraParams, {
							taskTag : encodeURI(taskTag),
							taskName : encodeURI(taskName),
							testType : encodeURI(testType),
							beginDate : beginDate,
							endDate : endDate,
							bigType : bigType,
							subType : subType
						}      
					);      
				});
			Ext.StoreMgr.get('taskStore').load();
    	}
    	
    	
    	function closeSubTask(){
    		var taskGrid=Ext.getCmp('taskGrid');
    		var closeStore=taskGrid.getSelectionModel().getSelection();
    		if(closeStore.length==0){
    			Ext.Msg.alert("提示","未选择任何任务");
    		}else{
			    MaskLoading();
			    var data = new Array(); 
			    Ext.Array.each(closeStore, function(record) {  
			    	data.push(record.data);  
			    });
		    	Ext.Ajax.request({ 
					async:false,
					method:'POST',
					url:"<%=request.getContextPath()%>/closeTestTask.do",
					params : {table :Ext.encode(data)},
					success:function(response,config){
						MaskOver();
						if(Ext.decode(response.responseText).success){
							top.Ext.Msg.alert('提示',"任务关闭成功");
							taskGrid.getStore().load();
						
						}else{
							top.Ext.Msg.alert("错误提示",Ext.decode(response.responseText).msg);
						}
					},
					failure:function(response,config){
						MaskOver();
						top.Ext.Msg.alert('提示','任务关闭失败');
					}
				});
    		}
    	}
    </script>
	<script type="text/javascript">

</script>
</html>