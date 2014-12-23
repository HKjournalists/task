<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/aiga/common/common.jsp" %>
    <% 
        String planId=request.getParameter( "planId");
    	String taskId=request.getParameter( "taskId");
    	String planTag=request.getParameter( "planTag"); 
        //0 创建 1查看 2 编辑 3关联 4导入excel 5 有工具栏的搜索 6 根据planId来搜索  7 任务排期页面 8 任务变更页面  9 是否联调(根据用户来查询任务)
        String flag=request.getParameter( "flag");
        boolean isShowTask=(taskId!=null&& !taskId.equals( ""));
        boolean isFlag=(flag!=null&& !flag.equals( ""));
        boolean isShowPlan=(planId!=null&& !planId.equals( ""));
        AigaUser user=( AigaUser)request.getSession().getAttribute( "aigaUser");
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
                color:red;
            }
        </style>
    </head>
    
    <body>
        <jsp:include page="/aiga/workflow/common/SelectStaff.jsp"></jsp:include>
    </body>
    <script type="text/javascript">
    var staffSelect="";
    var tbarDistributeStaffId;
    var optionHtml="<option value=''></option>";
        var planId = "${param.planId}";
        var taskId = "${param.taskId}";
        var planTag = "${param.planTag}";
        var extjsFolderPath = '<%=request.getContextPath()%>/extJs';
        var screenWidth = document.documentElement.clientWidth;
        var screenHeight = document.documentElement.clientHeight;
        var afterSelect = function (staffs, option) {
        	Ext.getCmp("tbarDistributeStaffname").setValue(staffs.employeeName);
        }
        function createPerfTest(rowIndex){
        	var store=Ext.getCmp('taskGrid').getStore();
			var data=store.getAt(rowIndex).getData();
			MaskLoading();
			Ext.Ajax.request({
			    url: '<%=request.getContextPath()%>/checkReqHasPerfTestTask.do',
			    async:false,
			    params: {
			        reqTag:data.reqTag
			    },
			    success: function(response,config){
			    	MaskOver();
			        var text = response.responseText;;
			    	if(!Ext.decode(text).success){
			    		Ext.Msg.alert('提示',Ext.decode(text).message);
			    		return;
			    	}
			    	//var url ="<%=request.getContextPath()%>/aiga/workflow/testPlan/P2PTaskForm.jsp?flag=0";
			    	var url ="<%=request.getContextPath()%>/aiga/workflow/perfTestTask/CreatePerfTestTask.jsp?flag=0&hide=true";
					url+='&taskName='+data.taskName;
					url+='&planTag='+data.planTag;
					url+='&priority='+data.priority;
					url+='&reqTag='+data.reqTag;
					url+='&reqPersion='+data.reqPersion;
					url+='&isImportanceReq='+data.isImportanceReq;
					url+='&reqPersion='+data.reqPersion;
					url+='&bigType='+data.bigType;
					url+='&devFirm='+data.devFirm;
					url+='&testFirm='+data.testFirm;
					url+='&initialSituation='+data.initialSituation;
					url+='&startTaskId='+data.taskId;
					url+='&planId='+data.planId;
					url+='&factCompleteTime='+data.factCompleteTime;
					
					url=encodeURI(encodeURI(url));
				     var perfTaskFormWin = new top.Ext.window.Window({
					 		id:'perfTaskFormWin',
						    title : '性能测试任务单',
						    width : screenWidth * 0.98,
						    height : screenHeight * 0.98,
						    modal : true,
						    autoScroll:true,
						    listeners:{
								destroy:function(window,eOpts){
									store.loadPage(1);
								}
						    },
						    closeAction : 'destroy',
						    html:'<iframe id="frame" name="frame" src='+url+' width="100%" height="100%" scrolling="yes"/>'
						}).show();
			    	
			    },
			    failure:function(response,config){
			    	MaskOver();
			        var text = response.responseText;;
			    	if(!Ext.decode(text).success){
			    		Ext.Msg.alert('提示',Ext.decode(text).message);
			    		return;
			    	}
			    }
			});
		}
        function createP2P(rowIndex){
        	var store=Ext.getCmp('taskGrid').getStore();
			var data=store.getAt(rowIndex).getData();
			MaskLoading();
			Ext.Ajax.request({
			    url: '<%=request.getContextPath()%>/checkReqHasP2PTestTask.do',
			    async:false,
			    params: {
			        reqTag:data.reqTag
			    },
			    success: function(response,config){
			    	MaskOver();
			        var text = response.responseText;;
			    	if(!Ext.decode(text).success){
			    		Ext.Msg.alert('提示',Ext.decode(text).message);
			    		return;
			    	}
			    	//var url ="<%=request.getContextPath()%>/aiga/workflow/testPlan/P2PTaskForm.jsp?flag=0";
			    	var url ="<%=request.getContextPath()%>/aiga/workflow/testTask/UETTaskStartUp.jsp?flag=0&hide=true";
					url+='&taskName='+data.taskName;
					url+='&planTag='+data.planTag;
					url+='&priority='+data.priority;
					url+='&reqTag='+data.reqTag;
					url+='&reqPersion='+data.reqPersion;
					url+='&isImportanceReq='+data.isImportanceReq;
					url+='&reqPersion='+data.reqPersion;
					url+='&bigType='+data.bigType;
					url+='&devFirm='+data.devFirm;
					url+='&testFirm='+data.testFirm;
					url+='&initialSituation='+data.initialSituation;
					url+='&startTaskId='+data.taskId;
					url+='&planId='+data.planId;
					url+='&factCompleteTime='+data.factCompleteTime;
					
					url=encodeURI(encodeURI(url));
				    var p2pTaskFormWin = new top.Ext.window.Window({
					 		id:'p2pTaskFormWin',
						    title : '用户体验测试任务单',
						    width : 1100,
						    height : 500,
						    modal : true,
						    autoScroll:true,
						    listeners:{
								destroy:function(window,eOpts){
									store.loadPage(1);
								}
						    },
						    closeAction : 'destroy',
						    html:'<iframe id="frame" name="frame" src='+url+' width="1050" height="450"/>'
						}).show();
			    	
			    },
			    failure:function(response,config){
			    	MaskOver();
			        var text = response.responseText;;
			    	if(!Ext.decode(text).success){
			    		Ext.Msg.alert('提示',Ext.decode(text).message);
			    		return;
			    	}
			    }
			});
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
            
            function rightClickTargetFn(view,record,item,index,e,eOpts){   
             	e.preventDefault();   
            	rightTargetReportMenu.showAt(e.getXY());
            }
            var rightTargetReportMenu = new Ext.menu.Menu({
            items: [
            {
            	id:'editTask',
                text: '清除所选计划排期',
                handler: function(){
                 	var currentGridRowModels=Ext.getCmp('taskGrid').getSelectionModel().getSelection();
                	if(currentGridRowModels.length!=1){
                		Ext.Msg.alert("提示","选择错误!");
                	}else{
                		currentGridRowModels[0].set('planId',null);
            			currentGridRowModels[0].set('planTag',null);
            			currentGridRowModels[0].set('planName',null);
            			currentGridRowModels[0].set('factCompleteTime',null);
                	}
                	
                }
                }]
            });
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
	                    }
	                ]
	            });
			  var StaffRoleViewStore = new Ext.data.Store({
	                id: 'StaffRoleViewStore',
	                model: StaffRoleViewModel,
	                proxy: {
	                    type: 'ajax',
	                    url: '<%=request.getContextPath()%>/getStaffRoleViews.do?roleCode=WF_TEST_CHD',
	                    reader: {
	                        type: 'json',
	                        root: 'data'
	                    }
	                },
	                listeners:{
                          load : function(store, records, options ){
        	                  StaffRoleViewStore.each(function(record){
				              record.set('displayName',record.get('staffCode')+':'+record.get('staffName'));
			                 });
            	            var rs = Ext.create("EmptyStaff");
                            store.insert(0,rs);  
                            return true;
                         }
		            }
	            });
	            StaffRoleViewStore.load({params:{roleCode:'WF_TEST_CHD'}});
	            var StaffRoleViewComboBox = new Ext.form.ComboBox({
	                width: 200,
	                store: StaffRoleViewStore,
	                forceSelection:true,
	                typeAhead:true,
	                minChars:1,
	                selectOnFocus: true,
	                triggerAction: 'all',
	                queryMode: 'local',
	                name: "distributeStaffName",
	                id:"tbarDistributeStaffname",
	                fieldLabel: '测试组长',
	                valueField: 'staffId',
	                displayField: 'displayName',
	                editable:true,
	                	listConfig: {
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
                    			phaseName:'--请选择--',	
                    			vmTaskName:'--请选择--',
                    			linkId:'',
                    			phaseId:''
                    	}
                        store.insert(0,rs);  
                        <%if(flag!=null&&(flag.equals("7")||flag.equals("8"))){%>
							var rec = store.find('linkId',199);
			                if(rec!=-1){
			               		store.removeAt(rec);
			                }
			           <%}%>
                        return true;
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
            <%if(flag!=null &&flag.equals("0")){%>,value:101,readOnly:true<%}%>
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
            var testTypeStore = new Ext.data.Store({
                id: 'testTypeStore',
                fields: ['value', 'show','other2'],
                proxy: {
                    type: 'ajax',
                    url: '<%=request.getContextPath()%>/getComBox.do?query=testTypeStore',
                    reader: {
                        type: 'json',
                        root: 'data'
                    }
                },
                 listeners:{
			    	load:function(store,records){
			    		var blankRecord={
			    				show:'--请选择--'}
	            		store.insert(0,blankRecord);
			    	}
			    
			    }
            });
            testTypeStore.load();
             var testTypeStorex = new Ext.data.Store({
                id: 'testTypeStorex',
                fields: ['value', 'show','other2'],
                proxy: {
                    type: 'ajax',
                    url: '<%=request.getContextPath()%>/getComBoxx.do?query=testTypeStore',
                    reader: {
                        type: 'json',
                        root: 'data'
                    }
                },
                 listeners:{
			    	load:function(store,records){
			    		var blankRecord={
			    				show:'--请选择--'}
	            		store.insert(0,blankRecord);
			    	}
			    
			    }
            });
            testTypeStorex.load();
            var testTypeCombox = new Ext.form.ComboBox({
            	width:250,
                store: testTypeStore,
                name: "testType",
                id:"tbarTestType",
                fieldLabel: "测试类型",
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
        	    		store.each(function(record){
        	    		})
        	    	}
        	    }
        	});
        	planStore.load();
            var planComboBox = new Ext.form.ComboBox({
                width: 200,
                store: planStore,
                name: "planTag",
				forceSelection:true,
	            typeAhead:true,
	            minChars:1,
	            selectOnFocus: true,
	            triggerAction: 'all',
	            queryMode: 'local',
                valueField: 'planName',
                displayField: 'planName',
                editable:true,
                	listConfig: {
                    getInnerTpl: function() {
                    	return '<div data-qtip="计划编号:{planTag}</br>上线时间:{(factCompleteTime)}">{planName}</div>';
                    }
                },
                listeners: {
                	select :function(combo,records, eOpts ){
                		var currentGridRowModels=Ext.getCmp('taskGrid').getSelectionModel().getSelection();
                		if(currentGridRowModels.length==1){
                			console.log(currentGridRowModels[0]);
                			currentGridRowModels[0].set('planId',records[0].raw.planId);
                			currentGridRowModels[0].set('planTag',records[0].raw.planTag);
                			currentGridRowModels[0].set('factCompleteTime',records[0].raw.factCompleteTime);
                		}
                	},
                	beforequery: function(e){ 
                        var combo = e.combo; 
                        if(!e.forceAll){ 
                            var value = e.query; 
                            combo.store.filterBy(function(record,id){ 
                            	var text = record.get(combo.displayField);
                            	var py_arr = makePy(text);
                            	for(i = 0; i < py_arr.length; i++){
                            		str = py_arr[i];
                                	if (str.indexOf(value.toUpperCase())!=-1)
                                		return true;
                            	}
                            	
                            	if (text.indexOf(value)!=-1) return true;
                            	return false;
                           		//return (text.indexOf(value)!=-1);
                        	});  
                            combo.expand();  
                            return false; 

                    	}  
               		 }
                }
            });
            var pageSizeNum=20;
        	if(getBrowserVersion()=="IE8.0"||getBrowserVersion()=="IE6.0"||getBrowserVersion()=="IE7.0")pageSizeNum= 25;
        	else pageSizeNum=50;
            var taskStore = Ext.create('Ext.data.Store', {
                storeId: 'taskStore',
                <%if(isFlag && flag.equals("5")){%>
                pageSize:pageSizeNum,
                <%}else{%>
				pageSize:20, //每页显示条数
				<%}%>
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
                    url: '<%=request.getContextPath()%>/getTestTaskList.do',
                    reader: {
                        root: "data",
                        type: "json",
            			totalProperty:'total'
                    }
                }
            });
    
            Ext.StoreMgr.get('taskStore').on('beforeload',function(){        // =======翻页时 查询条件     
            	<%if(flag!=null&&!(flag.equals("7")||flag.equals("8")||flag.equals("9"))){
            	%>
            	var tbarIsRel = Ext.getCmp("tbarIsRel").rawValue;
               tbarDistributeStaffId = encodeURI(encodeURI(Ext.getCmp("tbarDistributeStaffname").getValue()));
            	<%
            	}%>
            	<%if(flag!=null&&flag.equals("5")&&user.isRole("WF_TEST_P2P")){%>
            		var isOperated = Ext.getCmp("isOperated").getValue();
            	<%}%>
            	<%if(flag!=null&&(flag.equals("7")||flag.equals("8"))){%>
	           		var tbarTaskStatus = Ext.getCmp("tbarTaskStatus").getValue();
            	<%}%>
            	<%if(flag!=null&&flag.equals("5")){%>
            		var beginDate = Ext.getCmp("tbarBeginDate").getValue();
					var endDate = Ext.getCmp("tbarEndDate").getValue();
					var tbarTestTypex=Ext.getCmp("tbarTestTypex").getValue();
					var tbarTestTypeStatus=Ext.getCmp("tbarTestTypeStatus").getValue();
            	<%}%>
            	<%if(!flag.equals("5")){%>/* 是否联调而定义的判断 */
            		var tbarDistributeStaffnametext = encodeURI(encodeURI(Ext.getCmp("tbarDistributeStaffname").getValue()));
					var dateTime = Ext.getCmp("searchTime1").getValue();
					var	tbarJoinTest=Ext.getCmp("tbarJoinTest").getValue();	
					var tbarnotJoinTest=Ext.getCmp("tbarnotJoinTest").getValue();
            	<%}%>
                var tbarSubType = Ext.getCmp("tbarSubType").getValue();
                var tbarBigType = Ext.getCmp("tbarBigType").getValue();
                var tbarTaskTag = Ext.getCmp("tbarTaskTag").rawValue;
                var tbarTaskName = encodeURI(encodeURI(Ext.getCmp("tbarTaskName").rawValue));
               
               	
               				Ext.apply(       
					Ext.StoreMgr.get('taskStore').proxy.extraParams, {
						taskFlag: "${param.flag}",
               <%if(flag!=null&&!(flag.equals("7")||flag.equals("8")||flag.equals("9"))){
            		%>
                        tbarIsRel: tbarIsRel,
                        //tbarSearchTime: tbarSearchTime,
                         tbarDistributeStaffId:tbarDistributeStaffId,
            		<%
            	}%>
            	<%if(flag!=null&&flag.equals("5")&&user.isRole("WF_TEST_P2P")){%>
            		isOperated:isOperated,
            		tbarDistributeStaffId:tbarDistributeStaffId,
            	<%}%>
            	<%if(flag!=null&&(flag.equals("7")||flag.equals("8"))){%>
           			tbarTaskStatus:tbarTaskStatus,
            	<%}%>
            	<%if(flag!=null&&flag.equals("5")){%>
					beginDate:beginDate,
					endDate:endDate,
					tbarTestTypex:tbarTestTypex,
					tbarTestTypeStatus:tbarTestTypeStatus,
            	<%}%>
            	<%if(!flag.equals("5")){%>/* 为了是否联调而传值 */
						dateTime: dateTime,
                       tbarDistributeStaffnametext:tbarDistributeStaffnametext,
                       tbarJoinTest:tbarJoinTest,
                       tbarnotJoinTest:tbarnotJoinTest,
            	<%}%>
                        tbarSubType: tbarSubType,
                        tbarBigType: tbarBigType,
                        tbarTaskTag: tbarTaskTag,
                        tbarTaskName:tbarTaskName
                        
					}      	
				);      
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
			      taskStore.load({
			                params: {
			                    taskFlag: "<%=flag%>"
			                }
			            });
			            
			            
                    }
                }
            });
            var operatedStore = new Ext.data.Store({
                id: 'operatedStores',
                fields: ['value', 'show'],
                proxy: {
                    type: 'ajax',
                    url: '<%=request.getContextPath()%>/getSysParam.do?category=isOperated'+'&_='+(new Date()).getTime(),
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
            operatedStore.load();
            var isOperated = new Ext.form.ComboBox({
                width: 250,
                store: operatedStore,
                name: "isOperated",
                fieldLabel: "是否已创建用户体验测试",
                valueField: 'value',
                displayField: 'show',
                listeners: {
                    beforequery: function (queryEvent, eOpts) {
                        queryEvent.query = "operatedStore";
                    }
                }
            });
            var isjointTest=new Ext.form.Checkbox({
            	boxLabel :'联调',
            	width: 70,
            	name :'joinTest',
            	id:'tbarJoinTest',
            	inputValue :1,
            	checked :false,
            	disable:true,
            });
             var isnotjointTest=new Ext.form.Checkbox({
            	boxLabel :'非联调',
            	width: 70,
            	name :'notjoinTest',
            	id:'tbarnotJoinTest',
            	inputValue :0,
            	checked :false,
            	disable:true,
            });
            var tbar1=Ext.create('Ext.panel.Panel', {
        		id:'tbar1',
    			title:'查询区域',
    			cls:'ui-formPanel',
    			defaults: { 
					margins: '5 0 5 0',
				},
    			width: screenWidth*0.98,
    			height: screenHeight*0.2*0.99,
    			minWidth: 1200,
    			minHeight: 110,
    			layout: 'vbox',
    			bodyBorder: 0, 
            		items:[	{
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
					         	
            	     		{
				    width: 140,
				    labelWidth: 70,
				    xtype: "textfield",
				    name: "taskTag",
				    id: "tbarTaskTag",
				    fieldLabel: "任务单编号"
				},
				{
				    width: 140,
				    labelWidth: 70,
				    xtype: "textfield",
				    id: "tbarTaskName",
				    fieldLabel: "任务单名称"
				},
				{
				    xtype: "combo",
				    id: "tbarBigType",
				    width: 140,
				    labelWidth: 60,
				    store: bigTypeStore,
				    name: "bigType",
				    fieldLabel: "系统大类",
				    valueField: 'value',
				    displayField: 'show',
				    listeners:{
				    	change: function(combo, newValue, oldValue, eOpts) {
				    		Ext.getCmp('tbarSubType').clearValue();
				    		Ext.StoreMgr.get('subTypeStore').setProxy({type: 'ajax',
						        url: '<%=request.getContextPath()%>/getQryAndOther2.do?query=subTypeStore&other2='+newValue,
						        reader: {
						        	type: 'json',
						        	root: 'data'
						    }});
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
				},
				
				<%if (isFlag && flag.equals("5")) { %> 
					<%if(user.isRole("WF_TEST_P2P")){ %> 
              		{
              		xtype: "combo",
				    width: 250,
				    labelWidth: 150,
				    id: "isOperated",
				    store: operatedStore,
				    name: "isOperated",
				    fieldLabel: "是否已创建用户体验测试",
				    valueField: 'value',
				    displayField: 'show'
              		},
					<%}%> 
                /*{
				    width: 160,
				    labelWidth: 60,
				    xtype: 'datefield',
				    name: 'searchTime',
				    format: 'Y-m-d',
				    id: "tbarSearchTime",
				    fieldLabel: '上线时间'
				},*/
					
				{xtype:'datefield',width: 160,labelWidth: 70,id:'tbarBeginDate',name:'beginDate',format:'Y-m-d',fieldLabel:'上线时间从',
					listeners:{
						select: function() {
				            var start = Ext.getCmp('tbarBeginDate').getValue();   
				            Ext.getCmp('tbarEndDate').setMinValue(start);   
				            var endDate = Ext.getCmp('tbarEndDate').getValue();
				            if(start > endDate){   
				                Ext.getCmp('tbarEndDate').setValue(start);   
				            }   
						}
					}
				}, 
				 {xtype:'datefield',width: 110,labelWidth: 20,id:'tbarEndDate',name:'endDate',format:'Y-m-d',fieldLabel:'到'},
				StaffRoleViewComboBox,
				/* {
                          xtype: 'button',
                          text: '搜索',
                          handler: function () {
                              taskStore.loadPage(1);

                          }
                      }   */
                      <%}else if(isFlag && (flag.equals("7")||flag.equals("8")||flag.equals("9"))) {%>
                      StaffRoleViewComboBox,
					 {
						width:160,
						labelWidth:60,
	      				/* xtype: 'monthfield',  */
	      			 	xtype: 'datefield',
	        			labelAlign: 'right',
	        			name: 'searchTime',
	        			id: 'searchTime1',
	        	/* 		format: 'Y-m', */
	        		 	format: 'Y-m-d',
						fieldLabel: '上线日期 '
					},
                      taskStatusCombox,
                      isjointTest,
                      isnotjointTest,
                      {
                          xtype: 'button',
                          text: '搜索',
                          handler: function () 
                          {
                              taskStore.loadPage(1);

                          }
                      }  
                     <% }%>
            	     	]
            		},
            			<%if (isFlag && flag.equals("5")) { %> 
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
								StaffRoleViewComboBox,
								{
									 xtype: "combo",
								     store: testTypeStorex,
								     name: "testType",
								     id:"tbarTestTypex",
								     fieldLabel: "测试类型",
								     valueField: 'value',
								     displayField: 'show',
								     listeners:{
								    	change: function(combo, newValue, oldValue, eOpts) {//如果发生变化，那么把任务状态栏清空
								    		Ext.getCmp('tbarTestTypeStatus').clearValue();
								    		var other2="";
								    		for(var s = 0; s < Ext.StoreMgr.get('testTypeStorex').getCount(); s++) {//遍历测试类型的源
									    		var tempVal = Ext.StoreMgr.get('testTypeStorex').getAt(s).get('value');//获取测试类型源中所有值
									    		if(tempVal==newValue){//当源中的值和新传来的值相同时
									    			other2=Ext.StoreMgr.get('testTypeStorex').getAt(s).get("other2");
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
											    }});
									    		Ext.StoreMgr.get('workflowParamStore').load();		
									    		
								     }
								}},     {
									 xtype: "combo",
									 labelAlign: 'right',
									 id: "tbarTestTypeStatus",
									 width: 150,
								     labelWidth: 60,
								     store: workflowParamStore,
								     name: "testTypeStatus",
								     forceSelection:true,
				          			 typeAhead:true,
				            		 minChars:1,
				            		selectOnFocus: true,
				            		triggerAction: 'all',
								     fieldLabel: "任务状态",
								     valueField: 'linkId',
				              		 displayField: 'vmTaskName',
								},  {
		                          xtype: "checkbox",
		                          boxLabel: '只查已经关联',
		                          name: 'isRel',
		                          inputValue: '2',
		                          id: "tbarIsRel",
		                          listeners:{
		                          	change:function( Field, newValue, oldValue,eOpts ){
		                          		var gridPlanTag=Ext.getCmp('gridPlanTag');
		                          		var gridPlanName=Ext.getCmp('gridPlanName');
		                          		if(newValue){
		                          			gridPlanTag.show();
		                          			gridPlanName.show();
		                          		}else{
		                          			gridPlanTag.hide();
		                          			gridPlanName.hide();
		                          		}
		                          		taskStore.loadPage(1);
		                          	}
		                          }
		                      }, 
										{
				                          xtype: 'button',
				                          text: '搜索',
				                          handler: function () {
				                          	taskStore.loadPage(1);
				                          }
				                      } 
									    ]}
									     <% }%>
									    <%--  <%if (isFlag && !flag.equals("5")) { %> 
				                     	,{
				                          xtype: 'button',
				                          text: '搜索',
				                          handler: function () {
				                          	taskStore.loadPage(1);
				                          }
				                      }  
				                       <% }%> --%>
									    ]
				            });
				            
				            var taskGrid = Ext.create('Ext.grid.Panel', {
				                id: 'taskGrid',
				                cls: 'ui-formPanel',
				                title: '任务单列表',
				                margins: '0 0 0 3',
						        bbar: Ext.create('Ext.PagingToolbar', { 
									store: taskStore, 
									displayInfo: true, 
									displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
									emptyMsg: "没有数据"
								}),
								
				                height: screenHeight*0.99 - 160 <%if(flag!=null&&flag.equals("5")){%> + 55 <%}%>,
				                width: screenWidth*0.99,
				                minWidth: 1300,
				                
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
                <%if(flag!=null&&!flag.equals("5")){%>
	                listeners:{
	                	itemcontextmenu: rightClickTargetFn
	                	<%if(flag!=null&&flag.equals("8")){%>
	                		,beforeedit : function(editor, e) {
					        if(e.field== "planName"){
					        	planStore.load();
					    	}
					        return true;
	                	}
	                	<%}%>
	                } ,
                <%}%>
                columns: [
                         new Ext.grid.RowNumberer({  header　:　"序号",  width　:　30}),
                        
                        {
                            header: "测试任务编号",
                            width: 150,
                            sortable: true,
                            dataIndex: 'taskTag'
                            <% if (isFlag&&(flag.equals("7")||flag.equals("8"))) {%>
                           // ,renderer: function (value, cellmeta, record) {
                               // if (value != "") {
                              //      cellmeta.tdAttr = "data-qtip='该任务已被计划编号为(<span class=\"red\">" + value + "</span>)的计划占用,但是<span class=\"red\">未关联</span>'";
                              //      return value;
                              //  } else return value;
                           // }
                            <%}%>
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
                                return store.findRecord("value", new RegExp("^" + value + "$")).getData().show + "";
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
                                    return store.findRecord("value", new RegExp("^" + value + "$")).getData().show + "";
                                } catch (e) {
                                    return "未指定"
                                };
                            }
                        }, {
                            header: '系统子类',
                            dataIndex: 'subType',
                            width: 80,
                            align: 'center',
                            renderer: function (value, cellmeta, record) {

                                try {
                                    var store = Ext.data.StoreManager.lookup("mapStore");
                                    store.clearFilter(true);
                                    store.filter("categoryName", "subTypeStore");
                                    return store.findRecord("value", new RegExp("^" + value + "$")).getData().show + "";
                                } catch (e) {
                                    return value;
                                };
                            }
                        },
                       
                        <% if (flag!=null&& flag.equals("9")) {%>
                         {
                            header: "测试组长",
                            width: 60,
                            sortable: true,
                            dataIndex: 'distributeStaffname'
                        },
                        {header: "计划上线时间", width:100, sortable: true, dataIndex: 'factCompleteTime'},
                        {
                            header: "是否联调测试",
                            width: 100,
                            dataIndex: 'isJointTest',
                            align:'center',
                            id:'isJointTest',
                            renderer: function (value, cellmeta, record) {
                            	return value=='true'||value=='on'?'是':'否';
                            },
                            editor:{xtype:'checkbox',
                            	listeners:{
                            		change:function( _this, newValue, oldValue, eOpts ){
                            		}
                            		
                            	}
                            	}
                        }
                        <%}%>
                        <% if (flag!=null&& (flag.equals("7")||flag.equals("8"))) {%>
                        {
                            header: "上线时间",
                            width: 100,
                            sortable: true,
                            dataIndex: 'factCompleteTime'
                        },
                        {
                            header: "测试计划排期",
                            width: 200,
                            sortable: true,
                            dataIndex: 'planName',
                            editor: planComboBox
                        }
                        
                       <% }%>
                       <% if (flag!=null&& flag.equals("5")) {%>
                        {
                            header: "<font color='red'>计划编号</font>",
                            width: 150,
                            sortable: true,
                            id:'gridPlanTag',
                            dataIndex: 'planTag',
                            hidden:true
                        },
                        {
                            header: "<font color='red'>计划名称</font>",
                            width: 150,
                            id:'gridPlanName',
                            sortable: true,
                            dataIndex: 'planName',
                            hidden:true
                        },
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
                        header: "需求管理员",
                        width: 60,
                        sortable: true,
                        dataIndex: 'reqPersion'
                    }, {
                        header: "开发任务编号",
                        width: 100,
                        sortable: true,
                        dataIndex: 'devTag'
                    },  {
                        header: "测试组长Id",
                        width: 100,
                        sortable: true,
                        dataIndex: 'distributeStaffid',
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
                                return store.findRecord("value", value ).getData().show + "";
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
                        width: 100,
                        align: 'center',
                        renderer: function (value, cellmeta, record) {
                            try {
                                var store = Ext.data.StoreManager.lookup("taskWorkflowParamStore");
                                if(value==-1){
                                	return "已关闭";
                                }else{
	                                return store.findRecord("linkId", new RegExp("^" + value + "$")).getData().vmTaskName + "";
                                }

                            } catch (e) {
                                return "未指定{"+value+"}";
                            };

                        }
                    }, {
                        hidden:true,
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
                        width: 60,
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
                        width: 80,
                        sortable: true,
                        dataIndex: 'devWorkDay'
                    }, {
                        header: "测试任务工时",
                        width: 80,
                        sortable: true,
                        dataIndex: 'testWorkDay'
                    }, {
                        header: "任务单说明",
                        width: 100,
                        sortable: true,
                        dataIndex: 'initialSituation'
                    }
                    <%}
                        if(flag.equals("5")&&user.isRole("WF_TEST_P2P")){%>
                        , 
                    	{header: "用户体验测试发起", width:110,menuDisabled: true,xtype:'actioncolumn', dataIndex: 'testType', renderer: function (value, cellmeta, record) {
                            try {
                            	if(value==0&&(record.data.uetTaskId==null||record.data.uetTaskId=="")&&record.data.currentStatus!=-1){
                                	return  "<img height='20px' src='<%=request.getContextPath()%>/aiga/images/btm_img09.gif' onclick='createP2P("+record.index+")'/>";
                            	}
                            } catch (e) {
                                return "未指定"
                            };
                        },sortable:false
    		        }
                    <%}if(flag.equals("5")&&user.isRole("WF_TEST_PTM")){%>
                        , 
                    	{header: "性能测试发起", width:100,menuDisabled: true,xtype:'actioncolumn',dataIndex: 'testType', renderer: function (value, cellmeta, record) {
                            try {
                            	if(value==0&&(record.data.perfTaskId==null||record.data.perfTaskId=="")&&record.data.currentStatus!=-1){
                                	return  "<img height='20px' src='<%=request.getContextPath()%>/aiga/images/btm_img06.gif' onclick='createPerfTest("+record.index+")'/>";
                            	}
                            } catch (e) {
                                return "未指定"
                            };
                        },sortable:false
    		        }
                    <%}%>
                ]
            });
            Ext.create('Ext.Panel', {
                renderTo: Ext.getBody(),
                cls: 'ui-formPanel',
                width: screenWidth * 0.99,
                height: screenHeight * 0.99<%if(isFlag&&(flag.equals("7")||flag.equals("8"))){%>*0.9<%}%>,
                minWidth: 1300,
                minHeight: 300,
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
                        <%
                        if (isFlag && (flag.equals("3") || flag.equals("5")||flag.equals("7")||flag.equals("8")||flag.equals("9") )) { %> 
                        [tbar1,taskGrid]
                            //编辑页面
                            <%
                        } %>
                    }
                ]
            });
            });
    </script>
<script type="text/javascript">

</script>
</html>