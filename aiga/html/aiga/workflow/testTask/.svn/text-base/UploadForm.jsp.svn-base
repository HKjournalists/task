<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/aiga/common/common.jsp" %>
    <% 
        AigaUser user=( AigaUser)request.getSession().getAttribute( "aigaUser"); 
        %>
<html>
    
    <head>
        <title>任务单</title>
        <link href="<%=request.getContextPath()%>/aiga/workflow/testTask/ajaxFileUpload/ajaxfileupload.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=request.getContextPath()%>/aiga/workflow/testTask/ajaxFileUpload/jquery.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/aiga/workflow/testTask/ajaxFileUpload/ajaxfileupload.js"></script>
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
            .x-grid-cell-inner{
			    width:100%;
			    height:30px;
			    background-position:2px 2px;
			    background-repeat:no-repeat;
			    background-color:transparent;
			    white-space: nowrap;
			}
        </style>
    </head>
    
    <body>
    
   	<img id="loading" src="<%=request.getContextPath()%>/aiga/workflow/testTask/ajaxFileUpload/loading.gif" style="display:none;">
		<form name="form" action="" method="POST" enctype="multipart/form-data">
		<div id='uploadTestTaskDiv'></div>
		</form>
		<form style="display:none;" id="exportForm" action="<%=request.getContextPath()%>/downloadTemplateExcel.do?templateFileName=testTaskTemplate.xls&fileName=test_Task_Template.xls"
			enctype="multipart/form-data" method="post" target="temp">
			<input type="hidden" name="method" value="export" />
			<input type="submit" id="download" class="tmpBtn" value="下载" />
		</form>
    </body>
<script type="text/javascript">
var extjsFolderPath = '<%=request.getContextPath()%>/extJs';
var screenWidth = document.documentElement.clientWidth*0.98;
var screenHeight = document.documentElement.clientHeight*0.89;
var planId="",planTag="",factCompleteTime="";bigType="";
function ajaxFileUpload(){
	url="<%=request.getContextPath()%>/uploadTeskTaskExcel.do";
	url+="?planId="+planId+"&planTag="+planTag+"&factCompleteTime="+factCompleteTime;
	if(planTag==null||planTag==''){
		Ext.Msg.confirm('提示','排期计划未选择，是否导入任务列表？',function(optional){
			if(optional=='yes'){
				uploadSubmit();
			}	
		});
	}else{
		uploadSubmit();
	}
}
function uploadSubmit(){
	MaskLoading();
	$.ajaxFileUpload(
			{
				url:url,
				secureuri:false,
				fileElementId:'fileToUpload',
				dataType: 'json',
				success: function (data, status)
			{
					MaskOver();
					Ext.getCmp('itemsPanel').hide();
					var taskStore=Ext.data.StoreManager.lookup('taskStore');
					if(data.checkMsg!=null&&data.checkMsg.trim()!=""){
						alert(data.checkMsg);
						return;
					}
					if(data.data.length==0){
						alert("没有导入任何任务，未启动！");
						return;
					}
					taskStore.add(data.data);
					batchStartUpTestTaskWF();
					Ext.getCmp('planComboBox').setReadOnly(true);
			},
			error: function (data, status, e)
			{
				MaskOver();
				alert(data.msg);
				var responseData=Ext.decode(data.responseText);
				//console.log(data);
			}
		}
	)
}
Ext.onReady(function () {
    Ext.QuickTips.init();
    Ext.tip.QuickTipManager.init();
    
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
        	url : '<%=request.getContextPath()%>/getTestPlanList.do?taskFlag=7',
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
        id:'planComboBox',
        name: "planTag",
        valueField: 'planName',
        displayField: 'planName',
        fieldLabel: '选择排期计划',
        editable:true,
        	listConfig: {
            getInnerTpl: function() {
            	return '<div data-qtip="计划编号:{planTag}</br>上线时间:{(factCompleteTime)}">{planName}</div>';
            }
        },
        listeners: {
        	select :function(combo,records, eOpts ){
        		planTag=records[0].data.planTag;
        		planId=records[0].data.planId;
        		factCompleteTime=records[0].data.factCompleteTime;
        		bigType=records[0].data.bigType;
        		var planCompleteTimeField=Ext.getCmp('planCompleteTime');
        		planCompleteTimeField.setValue(factCompleteTime);
        		},
            beforequery: function (queryEvent, eOpts) {
            }
        }
    });
    var taskStore = Ext.create('Ext.data.Store', {
        storeId: 'taskStore',
        fields: [
                 {
                name: 'planName',
                type: 'string'
            },
            {
                name: 'factCompleteTime',
                type: 'string'
            },{
                name: 'taskId',
                type: 'string'
            }, 
            {
                name: 'staffIds',
                type: 'string'
            },
            {
                name: 'staffsName',
                type: 'string'
            },
            {
                name: 'staffNames',
                type: 'string'
            },{
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
    var uploadForm = Ext.create('Ext.panel.Panel', {
        id: 'uploadForm',
        width: screenWidth,
	    height: screenHeight*0.5,
        cls: 'ui-formPanel',
        bodyBorder: 0,
        baseCls: '#FFFFF',
        buttonAlign: 'right',
        cls: 'ui-formPanel',
        frame: true, //要设为true 
        height: 50,
        minHeight: 50,
        minWidth: 1000,
        items: [{
                width: 350,
                labelWidth: 80,
                xtype: 'fileuploadfield',
                name: 'taskList',
                id:'fileToUpload',
                fieldLabel: '导入任务单',
                buttonText: '选择文件',
                listeners:{
                	change:function(comp,str,eOpts){
                		if(str.endWith('xls')){
                			Ext.getCmp("upload").setHandler(function(){ajaxFileUpload();});
                		}else{
                			Ext.MessageBox.alert('提示','['+str+']文件不是合法的Excel文件,请用扩展名为xls的文件导入，可以下载模版');
                			Ext.getCmp("upload").setHandler(function () {
                            	Ext.MessageBox.alert('提示','未选择上传文件文件');
                            	});
                		}
                	}
                }
            }, {
                width: 50,
                xtype: 'button',
                text: '导入',
                id:'upload',
                handler: function () {
                	Ext.MessageBox.alert('提示','未选择上传文件文件');
                },
                listeners:{
                	afterrender:function( Component, eOpts ){
                	}
                }
            },
            planComboBox,
            {
                width: 180,
                labelWidth:80,
                id:'planCompleteTime',
                readOnly:true,
                xtype: 'textfield',
                fieldLabel: '排期时间'
            },
            {
                width: 100,
                xtype: 'button',
                text: '下载模版',
                handler: function () {
                	$("#exportForm")[0].submit();
                },
                listeners:{
                }
            }
        ]
    });
    var itemsPanel = new Ext.panel.Panel({
        id: 'itemsPanel',
        title: '导入测试任务列表',
        cls: 'ui-formPanel',
        defaults: {
            margins: '5 0 5 0',
        },
        renderTo: Ext.get('uploadTestTaskDiv'),
        width: screenWidth,
        height: screenHeight* 0.15,
        minHeight: 70,
        layout: 'hbox',
        bodyBorder: 0,
        items: [{
            xtype: 'fieldcontainer',
            labelStyle: 'font-weight:bold;padding:0',
            fieldDefaults: {
                labelAlign: 'right',
                labelWidth: 90,
                width: 200
            },
            layout: 'vbox',
            defaultType: 'textfield',
            items: [uploadForm]
        }]
    });
        var taskGrid = Ext.create('Ext.grid.Panel', {
        id: 'taskGrid',
        cls: 'ui-formPanel',
        title: '任务列表',
        margins: '0 0 0 3',
        height: screenHeight*0.85,
        width: screenWidth,
        renderTo: Ext.getBody(),
        /**
		**编辑插件
		**/
		plugins:[
			Ext.create('Ext.grid.plugin.CellEditing', {
            triggerEvent:'cellclick'
        })],
        forctFit: true,
        stripeRows: true,
        loadMask: true,
        store: taskStore,
        selType: 'rowmodel',
        listeners:{
        	cellclick:function(Table, HTMLElement, cellIndex,record,  tr,  rowIndex, EventObject,eOpts){
        	}
        },
        columns: [
                new Ext.grid.RowNumberer({header:"序号",width:30 }), 
                {
                    header: "测试任务编号",
                    width: 150,
                    sortable: true,
                    dataIndex: 'taskTag'
                },
                {
                    header: "测试任务名称",
                    width: 200,
                    sortable: true,
                    dataIndex: 'taskName'
                }, 
                {
                    header: "测试人员名称",
                    hidden:true,
                    dataIndex: 'staffsId'
                },
                {
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
                header: "测试组长Id",
                width: 100,
                sortable: true,
                dataIndex: 'distributeStaffid',
                hidden: true
            }, {
                header: "测试组长",
                width: 100,
                sortable: true,
                dataIndex: 'distributeStaffname'
            }, /**{
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
                width: 60,
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
            }, **/{
                header: "任务单说明",
                width: 100,
                sortable: true,
                dataIndex: 'initialSituation'
            }
        ]
    });
});
</script>
</html>