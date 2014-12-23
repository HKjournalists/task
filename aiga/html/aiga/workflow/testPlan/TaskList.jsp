<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/aiga/common/common.jsp" %>
    <% 
        String planId=request.getParameter( "planId");
    	String taskId=request.getParameter( "taskId");
    	String planTag=request.getParameter( "planTag"); 
    	String hide=request.getParameter( "hide"); 
        //0 创建 1查看 2 编辑 3关联 4导入excel 5 有工具栏的搜索 6 根据planId来搜索 
        String flag=request.getParameter( "flag"); 
        String queryFlag = request.getParameter("queryFlag");
        boolean isShowTask=(taskId!=null&& !taskId.equals( "")); 
        boolean isFlag=(flag!=null&& !flag.equals( "")); 
        boolean isShowPlan=(planId!=null&& !planId.equals( ""));
        AigaUser user=( AigaUser)request.getSession().getAttribute( "aigaUser"); 
        %>
<html>
    
    <head>
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
	var current_linkNo = '<%=WorkflowParam.getWorkflow("createTestTask").getLinkNo()%>';

    var selectFocusFlag="";
    function selectOnFocus(the,e){
    	//selectFocusFlag=true;
    }
    function selectOnBlur(the){
    	//selectFocusFlag=false;
    }
    function rightClickTargetFn(view,record,item,index,e,eOpts){   
     	e.preventDefault();   
    	rightTargetReportMenu.showAt(e.getXY());
    }
    var rightTargetReportMenu = new Ext.menu.Menu({
        items: [
        {
        	id:'editTask',
            text: '清除所选人员',
            handler: function(){
             	var currentGridRowModels=Ext.getCmp('taskGrid').getSelectionModel().getSelection();
            	if(currentGridRowModels.length!=1){
            		Ext.Msg.alert("提示","选择错误!");
            	}else{
            		currentGridRowModels[0].set('staffIds',null);
        			currentGridRowModels[0].set('staffNames',null);
        			currentGridRowModels[0].set('staffsName',null);
            	}
            	
            }
            }]
        });
    var indexArray=new Array();
    function selectOnChange(the,index){
    	var models=Ext.getCmp('taskGrid').getSelectionModel();
    	var value=$(the).val();
		var text = $(the).find("option[value='"+value+"']").html();
    	models.select(index,true);
		var model=Ext.getCmp('taskGrid').getStore().getAt(index);
		var subTaskStaffsStore=Ext.data.StoreManager.lookup('subTaskStaffsStore');
		var subTaskStaffs = {taskId:"",staffIds: "",staffNames: ""};
		subTaskStaffs.staffNames=text.split(":")[1];
		subTaskStaffs.staffIds=value;
		subTaskStaffs.taskId= model.data.taskId;
		subTaskStaffsStore.add(subTaskStaffs);
    }
    var staffSelect="";
	var optionHtml="<option value=''></option>";
        var planId = "${param.planId}";
        var taskId = "${param.taskId}";
        var planTag = "${param.planTag}";
        var extjsFolderPath = '<%=request.getContextPath()%>/extJs';
        var screenWidth = document.documentElement.clientWidth*0.99;
        var screenHeight = document.documentElement.clientHeight*0.99 - 57;
        var afterSelect = function (staffs, option) {
        	var taskForm =Ext.getCmp("taskForm").getForm();
        	if(staffSelect=="distribute"){
            	taskForm.findField("distributeStaffid").setValue(staffs.staffId);
            	taskForm.findField("distributeStaffname").setValue(staffs.employeeName);
        	}else if(staffSelect=="transfer"){
        		//转派回调函数
        		 var models = Ext.getCmp('taskGrid').getSelectionModel().getSelection();
        		var staffNames="";
        		var staffIds="";
        		for(var i in staffs ){
        			staffNames+=(i==0?"":";")+staffs[i].employeeName;
        			staffIds+=(i==0?"":";")+staffs[i].staffId;
        		}
        		models[0].set("staffsName", staffNames );
        		models[0].set("staffsId", staffIds );
        	}else{
        		taskForm.findField("reqPersion").setValue(staffs.employeeName);
        	}
        }

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
            /********staffStore start*******/
			
			Ext.define('EmptyVal', {
				extend: 'Ext.data.Model',
				fields:[
					{name:'value', type:'int', convert: null,defaultValue:''},
					{name:'show', type:'string', defaultValue: '-未选择-'}
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
            });

            //Daniel's Store end

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
            //选择测试人员store
            var StaffRoleViewStore = new Ext.data.Store({
                id: 'StaffRoleViewStore',
                model: StaffRoleViewModel,
                proxy: {
                    type: 'ajax',
                    url: '<%=request.getContextPath()%>/getStaffRoleViews.do?staffId=<%=user.getUserId()%>&roleCode=WF_TEST_PFR',
                    reader: {
                        type: 'json',
                        root: 'data'
                    }
                },
                listeners: {
                	load:function(){
            			StaffRoleViewStore.each(function(record){
            				record.set('displayName',record.get('staffCode')+':'+record.get('staffName'));
            			});
                	}
                	
                }
            });
            StaffRoleViewStore.load({params:{staffId:'<%=user.getUserId()%>',roleCode:'WF_TEST_PFR'}});
            var StaffRoleViewComboBox = new Ext.form.ComboBox({
                width: 200,
                store: StaffRoleViewStore,
                name: "StaffRoleView",
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
                	expand:function( field, eOpts ){
                		var grid=Ext.getCmp('taskGrid');
                		var model=grid.getSelectionModel().getSelection();
                		var subTaskTestorName=model[0].data.subTaskTestorName;
                		var store=field.store;
                		store.clearFilter(true);
                		store.filter([
                		              //过滤掉已经分派的
                		              {filterFn: function(item) { return subTaskTestorName.indexOf(item.data.staffName)==-1; }}
                		          ]);
                	},
                	select :function(combo,records, eOpts ){
                		var currentGridRowModels=Ext.getCmp('taskGrid').getSelectionModel().getSelection();
                		if(currentGridRowModels.length==1){
                			currentGridRowModels[0].set('staffIds',records[0].raw.staffId);
                			currentGridRowModels[0].set('staffNames',records[0].raw.staffName);
                		}
                	},
                	beforequery: function(e){ 
                		
                		var grid=Ext.getCmp('taskGrid');
                		var model=grid.getSelectionModel().getSelection();
                		var subTaskTestorName=model[0].data.subTaskTestorName;
            
                		
                        var combo = e.combo; 
                        if(!e.forceAll){ 
                            var value = e.query; 
                            combo.store.filterBy(function(record,id){ 
                            	var text = record.get(combo.displayField);
                            	var staffname = record.get(combo.valueField);
                            	if(subTaskTestorName.indexOf(staffname) != -1)
                            		return false;
                            	
                            	//first letter
                            	var py_arr = makePy(text);
                            	for(i = 0; i < py_arr.length; i++){
                            		str = py_arr[i];
                                	if (str.indexOf(value.toUpperCase())!=-1)
                                		return true;
                            	}
                            	
                            	//all pinyin
                            	var a_py = ConvertPinyin(text);
                            	if (a_py.indexOf(value.toLowerCase()) != -1)
                            		return true;
                            	
                            	//str indexof
                            	if (text.indexOf(value)!=-1) return true;
                            	return false;
                        	});  
                            combo.expand();  
                            return false; 

                    	}  
               		 }
                }
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
                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>需求管理员",
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
            });
            
            //选择测试管理员
            var testMgrStore = new Ext.data.Store({
                id: 'testMgrStore',
                model: StaffRoleViewModel,
                proxy: {
                    type: 'ajax',
                    url: '<%=request.getContextPath()%>/getStaffRoleViews.do?staffId=<%=user.getUserId()%>&roleCode=WF_TEST_CHD',
                    reader: {
                        type: 'json',
                        root: 'data'
                    }
                },
                listeners: {
                	load:function(){
            			testMgrStore.each(function(record){
            				record.set('displayName',record.get('staffCode')+':'+record.get('staffName'));
            			});
                	}
                	
                }
            });
            testMgrStore.load({params:{staffId:'<%=user.getUserId()%>',roleCode:'WF_TEST_CHD'}});
            var testMgrComboBox = new Ext.form.ComboBox({
                width: 250,
                mode:'remote',
                store: testMgrStore,
                name: "distributeStaffname",
                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>测试管理员",
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
                		Ext.getCmp('taskForm').getForm().findField("distributeStaffid").setValue(records[0].raw.staffId);
                	},
                    beforequery: function (queryEvent, eOpts) {
                    }
                }
            });
            /********staffStore end********/
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
                }); 
                <%
            }if(flag!=null && flag.equals("5")) {%>
            taskStore.load({
                params: {
                    taskFlag: "5",tbarIsBatch:"false",queryFlag: "${param.queryFlag}"
                }
            });
           <% } else { %>
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
                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>任务优先级",
                forceSelection:true,
	            typeAhead:true,
	            selectOnFocus: true,
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
                }
            });
            workflowParamStore.load();
         

            var taskPhaseCombox = new Ext.form.ComboBox({
                width: 250,
                store: workflowParamStore,
                name: 'taskPhase',
                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>任务所处阶段",
                valueField: 'phaseId',
                displayField: 'phaseName',
                listeners: {}
            <%if(flag!=null &&flag.equals("0")){%>,value:1,readOnly:true<%}%>
            });
            var taskStatusCombox = new Ext.form.ComboBox({
                width: 250,
                store: workflowParamStore,
                name: 'currentStatus',
                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>任务状态",
                valueField: 'linkId',
                displayField: 'vmTaskName',
                listeners: {}
            <%if(flag!=null &&flag.equals("0")){%>,value:101,readOnly:true<%}%>
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
			    	load : function(store, records, options ){
		            	var rs = Ext.create("EmptyVal");
		                store.insert(0,rs);  
		            }
                }
            });
            bigTypeStore.load();
            var bigTypeCombox = new Ext.form.ComboBox({
                width: 250,
                store: bigTypeStore,
                name: "bigType",
                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>系统大类",
                forceSelection:true,
	            typeAhead:true,
	            minChars:1,
	            selectOnFocus: true,
	            triggerAction: 'all',
	            queryMode: 'local',
                valueField: 'value',
                displayField: 'show',
			    listeners:{
			    	change: function(combo, newValue, oldValue, eOpts) {
			    		<%if(flag.equals("5")){
			    		%>
			    			Ext.getCmp('tbarSubType').clearValue();
			    		<%
			    		}%>
			    		Ext.StoreMgr.get('subTypeStore').setProxy(
			    		{
			    			type: 'ajax',
					        url: '<%=request.getContextPath()%>/getQryAndOther2.do?query=subTypeStore&other2='+newValue,
					        reader: {
					        	type: 'json',
					        	root: 'data'
					    	}
					    });
			    		Ext.StoreMgr.get('subTypeStore').load();
			    	}
			    }
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
                	load : function(store, records, options ){
		            	var rs = Ext.create("EmptyVal");
		                store.insert(0,rs);  
		            }
                }
            });
            subTypeStore.load();
            var subTypeCombox = new Ext.form.ComboBox({
                width: 250,
                store: subTypeStore,
                name: "subType",
                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>系统子类",
                valueField: 'value',
                displayField: 'show',
                forceSelection:true,
	            typeAhead:true,
	            minChars:1,
	            selectOnFocus: true,
	            triggerAction: 'all',
	            queryMode: 'local'
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
                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>测试类型",
                valueField: 'value',
                displayField: 'show',
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
                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>开发厂商",
                valueField: 'value',
                displayField: 'show',
                forceSelection:true,
	            typeAhead:true,
	            minChars:1,
	            selectOnFocus: true,
	            triggerAction: 'all',
	            queryMode: 'local'
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
            var testFirmCombox = new Ext.form.ComboBox({
                width: 250,
                store: testFirmStore,
                name: "testFirm",
                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>测试厂商",
                valueField: 'value',
                displayField: 'show',
                forceSelection:true,
	            typeAhead:true,
	            minChars:1,
	            selectOnFocus: true,
	            triggerAction: 'all',
	            queryMode: 'local'
            });
            var uploadForm = Ext.create('Ext.form.Panel', {
                fileUpload: true,
                frame: true,
                id: 'uploadForm',
                cls: 'ui-formPanel',
                bodyBorder: 0,
                baseCls: '#FFFFF',
                buttonAlign: 'right',
                rame: true, //要设为true 
                height: 50,
                items: [{
                        width: 350,
                        labelWidth: 80,
                        xtype: 'fileuploadfield',
                        name: 'taskList',
                        fieldLabel: '导入任务单',
                        buttonText: '选择文件'
                    }, {
                        width: 50,
                        xtype: 'button',
                        text: '导入',
                        handler: function () {
                            var form = Ext.getCmp("uploadForm").getForm();
                            form.submit({
                                url: '<%=request.getContextPath()%>/uploadTeskTaskExcel.do?planId=' + planId + '&planTag=' + planTag,
                                waitMsg: '上传中...',
                                success: function (fp, action) {
                                    Ext.Msg.alert('Success', '您的excel"' + action.result.fileName + '" 已经导入完成.', function () {
                                    	var panel=Ext.getCmp('itemsPanel');
                                    	var taskGrid=Ext.getCmp('taskGrid');
                                    	taskGrid.getStore().removeAll(true); 
                                    	taskGrid.getStore().add(action.result.data);
                                    	panel.add(taskGrid);
                                        window.parent.closeWindow("taskGridWinExcel");
                                    });
                                }
                            });
                        }
                    }
                ]
            });
            var taskForm = Ext.widget('form', {
                id: 'taskForm',
                layout: 'vbox',
                title: '<%if(isShowTask&&isFlag&&(flag.equals("2"))){%>编辑任务单<%}else if(isShowTask&&isFlag&&(flag.equals("1"))){%>查看任务单<%}else{%>创建任务单&nbsp;&nbsp(' + taskTag + ')<%}%>',
				<%if (isFlag && (flag.equals("2") || (flag.equals("0")&&(hide==null||!hide.equals("true"))))) { %>
                tbar: [
                 {
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
                                            	//_taskWin = top.Ext.getCmp("taskGridWinCreate");
                                            <%}else {
                                            	%>
                                            	//_taskWin = top.Ext.getCmp("taskFormWin");
                                            	<%
                                            }%>
                                           //_taskWin.close();
                                           Ext.Msg.alert("提示","数据保存成功!");
                                        }
                                    },
                                    failure: function (response, config) {
								MaskOver();
                                       Ext.Msg.alert("提示","数据修改失败!");
                                    }
                                });
                            }
                        } 
                    
                ], 
                <%}%>
                
                width: screenWidth * 0.99,
               	minWidth: 1200,
                bodyBorder: 0,
                fieldDefaults: {
                    labelAlign: 'right',
                    labelWidth: 60
                },
                defaults: {
                    margins: '15 0 0 0'
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
                                    	<%if(flag.equals("1")){%>
                                    var fields = taskForm.getForm().getFields().items;
                                    for (var i = 0, n = fields.length; i < n; i++) {
                                        fields[i].setReadOnly(true);
                                    }
                                    var curTag = Ext.getCmp('taskForm').getForm().findField('taskTag').getValue();
                            		initPackList(curTag, '1', current_linkNo,'0','0',false);
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
                                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>测试任务名称",
                                allowBlank: false
                            }, {
                                xtype: "hidden",
                                name: "planId",
                                value: planId,
                                fieldLabel: "计划Id"
                            }, {
                                xtype: "hidden",
                                name: 'taskId',
                                fieldLabel: '测试任务id'
                            }, {
                                xtype: "hidden",
                                name: 'taskTag',
                                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>测试任务编号" <%
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
                        items: [
                        	planComboBox,
                            taskPhaseCombox,
                            taskStatusCombox,
                            
                           	priorityCombox,{
                        		xtype:'hidden',
                        		name:'factCompleteTime'
                        	},{
                        		xtype:'hidden',
                        		name:'submitStaffName',
                        		value:'<%=user.getUserName()%>'
                        	},{
                        		xtype:'hidden',
                        		name:'submitStaffId',
                        		value:'<%=user.getUserId()%>'
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
                                name: "reqTag",
                                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>需求编号"
                            }, {
                                width: 250,
                                name: 'devTag',
                                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>开发任务编号"
                            },
                            reqMgrComboBox, 
                            {
                                xtype: 'hidden',
                                name: 'distributeStaffid',
                                fieldLabel: '测试组长Id'
                                //allowBlank: false,
                            }, 
                            testMgrComboBox
                        ]
                    }, {
                        xtype: "fieldcontainer",
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textfield',
                        fieldDefaults: {
                            labelAlign: 'right'
                        },
                        items: [
                                {
                                name: 'isImportanceReq',
                                xtype: 'checkbox',
                                width: 250,
                                fieldLabel: '是否重点需求'
                            }, 
                            bigTypeCombox,subTypeCombox,
                            ,
                            {
                                width: 250,
                                name: 'devWorkDay',
                                xtype:'numberfield',
                                minValue:0,
                                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>开发任务工时",
                                allowBlank: false,
                                listeners: {
                                	change: function (comp, newValue,oldValue, eOpts) {
                                        var devWorkDay = Ext.getCmp("taskForm").getForm().findField('testWorkDay');
                                        	devWorkDay.setValue(Math.ceil(newValue *0.6));
                                    }

                                }
                            }
                            <%if(flag!=null&&flag.equals("0")){%>
                                ,{
                        		xtype:'hidden',
                        		name: "testType",
                             	value:0
                        		}
                        		<%}%>
                        ]
                    }, {
                        xtype: "fieldcontainer",
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textfield',
                        fieldDefaults: {
                            labelAlign: 'right'
                        },

                        items: [
                            devFirmCombox,
                            testFirmCombox,
                            {
                                width: 250,
                                xtype:'numberfield',
                                name: 'testWorkDay',
                                minValue:0,
                                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>测试任务工时",
                                selectOnFocus: true,
                                validateOnChange : true,
                                listeners: {
                                    focus: function (comp, The, eOpts) {
                                        var devWorkDay = Ext.getCmp("taskForm").getForm().findField('devWorkDay');
                                        if (devWorkDay.value != undefined && (comp.value == undefined) || comp.value == "")
                                            comp.setValue(Math.ceil(devWorkDay.value *0.6));
                                    }

                                },
                                allowBlank: false
                            },
                            {
                                width: 250,
                                xtype:'combobox',
                                name: 'reqType',
                                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>需求类型",
                                selectOnFocus: true,
                            	queryMode: 'local',
                            	displayField: 'name',
                            	valueField: 'abbr',
                            	store:Ext.create('Ext.data.Store', {
                            	    fields: ['abbr', 'name'],
                            	    data:[{"abbr":"新业务需求", "name":"新业务需求"},{"abbr":"项目需求", "name":"项目需求"}
                             	]}),
                                validateOnChange : true,
                                listeners: {
                                    

                                },
                                allowBlank: false
                            }
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
                                fieldLabel: '任务单说明'
                            }
                        ]
                    }
                ]
            });
            var pageSizeNum=20;
            	if(getBrowserVersion()=="IE8.0"||getBrowserVersion()=="IE6.0"||getBrowserVersion()=="IE7.0")pageSizeNum= 25;
            	else pageSizeNum=50;
            var taskStore = Ext.create('Ext.data.Store', {
                storeId: 'taskStore',
                <%if(isFlag && flag.equals("5")){%>
                pageSize: pageSizeNum,
                <%}%>
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
                        name: 'subTaskTestorName',
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
                        type: "json",
                    	totalProperty:'total'
                    }
                }
            });
    
            
            var tabPanel = Ext.create("Ext.tab.Panel", {
                frame: true,
                width: screenWidth * 0.98,
                height: screenHeight * 0.4,
                minWidth: 1200,
                minHeight: 150,
                id: 'tabPanel',
                border: 0,
                activeTab: 0, // 默认激活第1个tab页
                items: [
                        {
                        	title: "附件列表",
                            contentEl:'fileTrans',
                            listeners:{
                            	render:function( Component, eOpts ){
                            		$('#fileTrans').show();
                            		   var curTag = Ext.getCmp('taskForm').getForm().findField('taskTag').getValue();
                            		   if(curTag!=null&&curTag!=""){
                               				initPackList(curTag, '1', current_linkNo,'0','0',false);
                            		   }
                            	}
                            }
                        }
                ]
            });
            var taskGrid = Ext.create('Ext.grid.Panel', {
                id: 'taskGrid',
                cls: 'ui-formPanel',
                <%if (isFlag && flag.equals("5")) {%>
                title: '任务分派列表',
                bbar: Ext.create('Ext.PagingToolbar', { 
					store: taskStore, 
					displayInfo: true,
					displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
					emptyMsg: "没有数据",
					listeners:{
						beforechange:function( _this, page, eOpts ){
							var store=Ext.data.StoreManager.lookup(_this.getStore().storeId);
							try{
								if(store.getUpdatedRecords().length!=0){
									Ext.Msg.confirm('提示','当前页有未分配的任务,翻页后操作会丢失,是否停留在本页面',function(optional){
										if(optional=='yes'){
											return false;
										}else{
											store.loadPage(page);
										}	
									});
								}else{
									store.loadPage(page);
								}
								return false;
								
							}catch(e){
								
							}
							
						}
					}
				}),
                <%}else{%>
                title: '可选任务单列表',
                <%}%>
                margins: '0 0 0 3',
                height: screenHeight*0.99,
                width: screenWidth*0.998,
                minWidth: 1000,
                minHeight: 300,
                tbar: [ <%
                    if (isFlag && flag.equals("3")) { %> {
                            xtype: 'button',
                            text: '选中关联',
                            handler: function () {
                                var grid = Ext.getCmp("taskGrid");
                                var records = grid.getSelectionModel().getSelection();
                                var arr = new Array();
                                for (var i = 0; i < records.length; i++) {
                                    arr[i] = records[i].data.taskId;
                                }
                                $.getJSON("<%=request.getContextPath()%>/relTaskList.do", {
                                    planId: planId,
                                    planTag: planTag,
                                    taskIdArray: arr
                                }, function (data) {
                                    if (data.success == true) {
                                    	var _taskWin = top.Ext.getCmp("taskGridWin");
            							_taskWin.close();
                                    }
                                });
                            }
                        }
                        //任务单查询
                        <%
                    } else if (isFlag && flag.equals("5")) { %> {
                            width: 170,
                            labelWidth: 70,
                            xtype: "textfield",
                            name: "taskTag",
                            id: "tbarTaskTag",
                            fieldLabel: "任务单编号"
                        },
                        {
                            width: 170,
                            labelWidth: 70,
                            xtype: "textfield",
                            name: "taskName",
                            id: "tbarTaskName",
                            fieldLabel: "任务单名称"
                        },{
                            width: 160,
                            labelWidth: 60,
                            xtype: 'datefield',
                            name: 'searchTime',
                            format: 'Y-m-d',
                            id: "tbarSearchTime",
                            fieldLabel: '上线时间'
                        }, {
                            xtype: "combo",
                            id: "tbarBigType",
                            width: 150,
                            labelWidth: 60,
                            store: bigTypeStore,
                            name: "bigType",
                            fieldLabel: "系统大类",
                            valueField: 'value',
                            displayField: 'show',
						    listeners:{
						    	change: function(combo, newValue, oldValue, eOpts) {
						    		Ext.getCmp('tbarSubType').clearValue();
						    		Ext.StoreMgr.get('subTypeStore').setProxy(
						    		{
						    			type: 'ajax',
								        url: '<%=request.getContextPath()%>/getQryAndOther2.do?query=subTypeStore&other2='+newValue,
								        reader: {
								        	type: 'json',
								        	root: 'data'
								    	}
								    });
						    		Ext.StoreMgr.get('subTypeStore').load();
						    	}
						    }
                        }, {
                            xtype: "combo",
                            width: 150,
                            labelWidth: 60,
                            id: "tbarSubType",
                            store: subTypeStore,
                            name: "subType",
                            fieldLabel: "系统子类",
                            valueField: 'value',
                            displayField: 'show'
                        }, {
                            xtype: "checkbox",
                            boxLabel: '只选已分派',
                            name: 'isBatch',
                            inputValue: '1',
                            checked: false,
                            id: "tbarIsBatch"
                        },
                        //{
                            //xtype: "checkbox",
                           // boxLabel: '已经排期',
                           // name: 'isRel',
                           // inputValue: '2',
                           // checked: true,
                           // id: "tbarIsRel"
                       // },
                        {
                            xtype: 'button',
                            text: '搜索',
                            handler: function () {
                            	taskStore.clearFilter(true);
                                taskStore.loadPage(1);

                            }
                        }  <%
                    } %>
                ],
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
                <% if (isFlag && (flag.equals("5"))) { %>,
                	itemcontextmenu: rightClickTargetFn
                	<%}%>
                },
                <%
                if (isFlag && (flag.equals("3"))) { %> selModel: Ext.create("Ext.selection.CheckboxModel",{
                	id : 'checkBoxForChoiceCount',
                	mode:"SIMPLE",
                	listeners:{
                		beforedeselect :function( RowModel,record, index, eOpts ){
                		},
                		beforeselect :function( RowModel,record, index, eOpts ){
                		}
                	}
                }),
                    <%
                } %> columns: [
                        new Ext.grid.RowNumberer({  
			                          　　header　:　"序号",  
			                          　　width　:　30
			                      　   }), 
                        {
                            header: "测试任务编号",
                            width: 150,
                            sortable: true,
                            dataIndex: 'taskTag'
                            <% if (flag==null || !flag.equals("5")) {%>
                            ,renderer: function (value, cellmeta, record) {
                                if (value != "") {
                                    cellmeta.tdAttr = "data-qtip='该任务已被计划编号为(<span class=\"red\">" + value + "</span>)的计划占用,但是<span class=\"red\">未关联</span>'";
                                    return value;
                                } else return value;
                            }
                        ,
                            hidden: true
                            <%}%>
                        },
                        {
                            header: "测试任务名称",
                            width: 200,
                            sortable: true,
                            dataIndex: 'taskName'
                        }, 
                        {
                            header: "计划编号",
                            width: 150,
                            sortable: true,
                            dataIndex: 'planTag'
                        },
                        <% if (flag!=null && flag.equals("5")) {%>
                        {
                            header: "计划名称",
                            width: 150,
                            sortable: true,
                            dataIndex: 'planName'
                        },
                        {
                            header: "计划上线时间",
                            width: 90,
                            sortable: true,
                            dataIndex: 'factCompleteTime'
                        },
                        
                        {
                            header: "测试人员名称",
                            hidden:true,
                            dataIndex: 'staffsId'
                        },
                        
                        {
                        	width:150,
                            header: "已派发人员",
                            dataIndex: 'subTaskTestorName'
                        },
                        {
                        	width:150,
                            header: "选择测试人员",
                            dataIndex: 'staffsName',
                            editor: StaffRoleViewComboBox
                        }
                       <% }%>
                       <% if (flag==null|| !flag.equals("5")) {%>
                        {
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
                    }, {
                        header: '系统大类',
                        dataIndex: 'bigType',
                        width: 60,
                        align: 'center',
                        renderer: function (value, cellmeta, record) {
                            try {
                                var store = Ext.data.StoreManager.lookup("mapStore");
                                store.clearFilter(true);
                                store.filter("categoryName", "bigTypeStore");
                                return store.findRecord("value", new RegExp("^" + value + "$")).getData().show + "";
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
                                return store.findRecord("value", new RegExp("^" + value + "$")).getData().show + "";
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
                                return store.findRecord("value", new RegExp("^" + value + "$")).getData().show + "";
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
                                return store.findRecord("value", new RegExp("^" + value + "$")).getData().show + "";
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
                                return store.findRecord("value", new RegExp("^" + value + "$")).getData().show + "";
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
                                return store.findRecord("linkId", new RegExp("^" + value + "$")).getData().vmTaskName + "";

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
                                return store.findRecord("phaseId", new RegExp("^" + value + "$")).getData().phaseName + "";

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
                                return store.findRecord("value", new RegExp("^" + value + "$")).getData().show + "";
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
                    <%}%>
                ]
            });
            <% if (flag==null|| flag.equals("5")) {%>
            Ext.StoreMgr.get('taskStore').on('beforeload',function(){
            	 var tbarIsBatch = Ext.getCmp("tbarIsBatch").rawValue;
                 var tbarSubType = Ext.getCmp("tbarSubType").getValue();
                 var tbarBigType = Ext.getCmp("tbarBigType").getValue();
                 var tbarSearchTime = Ext.getCmp("tbarSearchTime").rawValue;
                 var tbarTaskTag = Ext.getCmp("tbarTaskTag").rawValue;
                 var tbarTaskName = Ext.getCmp("tbarTaskName").rawValue;
	        	Ext.apply(       
	        			
						Ext.StoreMgr.get('taskStore').proxy.extraParams,{
							taskFlag: "${param.flag}",
							queryFlag: "${param.queryFlag}",
							tbarIsBatch: tbarIsBatch,
							tbarSubType: tbarSubType,
	                        tbarBigType: tbarBigType,
	                        tbarTaskTag: tbarTaskTag,
	                        tbarTaskName: encodeURI(encodeURI(tbarTaskName)),
	                        tbarSearchTime: tbarSearchTime
	                        
						});
            });
            <%}%>
            Ext.create('Ext.Panel', {
                renderTo: Ext.getBody(),
                cls: 'ui-formPanel',
                width: screenWidth - 5,
                height: screenHeight * 0.99,
                minWidth: 1200,
                minHeight: 500 <%if (isFlag && flag.equals("0")) {%> + 50 <%}%>,
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
                	 	id:'itemsPanel',
                        region: 'center',
                        items:
                        //关联
                        <%
                        if (isFlag && (flag.equals("3") || flag.equals("5"))) { %> [taskGrid]
                            //编辑页面
                            <%
                        } else if (isShowTask && isFlag && (flag.equals("2") || flag.equals("1"))) { %> [taskForm,tabPanel] <%
                        } else if (isFlag && flag.equals("0")) { %> [taskForm,tabPanel] <%
                        } else if (isFlag && flag.equals("4")) { %> [uploadForm] <%
                        } else if (isShowPlan && isFlag && flag.equals("6")) { %> [taskGrid] <%
                        } %>
                    }
                ]
            })
            
            });
    </script>
<script type="text/javascript">

</script>
</html>