<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//0 创建 1查看 2编辑 &&草稿
	String planFlag=request.getParameter( "planFlag"); 
%>
<html>
    
    <head>
        <title>测试计划</title>
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
       <jsp:include page="/aiga/workflow/common/SelectStaff.jsp"></jsp:include>
      <div id="fileTrans" style="display: none"><jsp:include page="/aiga/attach/fileTrans.jsp"></jsp:include></div>
      <div id="solidDiv" style="height:0px;width:0px;"><jsp:include page="/aiga/workflow/testPlan/TestSolidTaskList.jsp">
      	<jsp:param value="${param.objId}" name="planId"/>
      	<jsp:param value="TestPlanForm" name="parentForm"/>
      </jsp:include></div>
        <div id="planPanel"></div>
        <% if(planFlag != null && planFlag.equals("3")){ %>
        <!-- 操作区域浮动层 -->
		<!-- btmFixed -->
		<div class="btmFixed">
			<div class="btmFixedInner"></div>
			<div class="btmFixed_left" id="putongliucheng">
				<ul>
					<li title="" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="setWOResult('pass')">
						<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/upmng.gif" /></span>
						<p>执行</p>
					</li>
				</ul>
			</div>
			<div class="btmFixed_right">
				<div class="processRight">
					<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/btm_process.gif"/></span>
					<p>查看流程</p>
				</div>
			</div>
		</div>
		<% } %>
        <% 
    	String createTestPlanFlag = request.getParameter("createTestPlanFlag");//判断是否为创建测试计划
        String planId=request.getParameter( "objId"); 
        AigaUser user=( AigaUser)request.getSession().getAttribute( "aigaUser"); 
        String includeHead=request.getParameter("includeHead");
        boolean isHasPlanId=(planId!=null&&!planId.equals( ""));
        %>
        <%if(includeHead==null||!includeHead.equals("true")){ %>
        <!--<%}%>
           <%@ include file="/aiga/common/common.jsp" %>
           <%if(includeHead==null||!includeHead.equals("true")){ %>
         -->
          <%} %>
    </body>
    <script type="text/javascript">
    	<%
    		if(planFlag != null && planFlag.equals("3")){
    			%>
    	//创建环节信息
		var current_linkNo = '<%=WorkflowParam.getWorkflow("createTestPlan").getLinkNo()%>';
		
		var	create_linkId = '<%=WorkflowParam.getWorkflow("createTestPlan").getLinkId()%>';
		var create_linkNo = '<%=WorkflowParam.getWorkflow("createTestPlan").getLinkNo()%>';
		var	create_roleCode = '<%=WorkflowParam.getWorkflow("createTestPlan").getRoleCode()%>';
		var create_templateId = '<%=WorkflowParam.getWorkflow("createTestPlan").getTemplateId()%>';
		//下一环节link信息
		var	next_linkId ='';
		var next_linkNo = '';
		var	next_roleCode = '';
		var next_templateId = '';
		
		var orderResult = '';
		var orderCond = '';
		var resultSelect = '';
		var testTaskIds = '';
		
		
		function getTestTaskIds()
		{
			var store = Ext.getCmp('taskGrid').getStore();
		
			for (var i = 0; i < store.getCount(); i++) 
			{        
				var record = store.getAt(i);   
				testTaskIds = testTaskIds + record.get('taskId') + ',';
		    }
		}
		
		//选择对应环节编号
		function chooseLinkInfo(){
			if(orderResult == 'pass'){
				next_linkId ='<%=WorkflowParam.getWorkflow("planRunning").getLinkId()%>';
				next_linkNo = '<%=WorkflowParam.getWorkflow("planRunning").getLinkNo()%>';
				next_roleCode = '<%=WorkflowParam.getWorkflow("planRunning").getRoleCode()%>';
			}
			next_templateId = '10000';
		}
		
		
		var setWOResult = function(result){
			orderResult = result;
			chooseLinkInfo();
			if(!confirm("版本测试任务选择是否确定完成？"))
				return;
			SelectStaff.showWin(next_roleCode,'<%=user.getUserId()%>',-1,-1,2,false,3,0);
		};
		
		function initConds()
		{
			var allconds = "";
			allconds = setConds(allconds,"staffId","1");
			allconds = setConds(allconds,"orderType","1");
			allconds = setConds(allconds,"result","pass");
			return allconds;
		}
		
		var afterSelect = function(staffs,option){
			//if(staffs==null&&staffs=='')
			//	return;
			var nextStaff = {linkId:next_linkId,
							linkNo:next_linkNo,
							templateId:next_templateId,
							stdholderStaffId:'<%=user.getUserId()%>',
							stdholderStaffNo:'<%=user.getUserAccount()%>',
							stdholderStaffName:'<%=user.getUserName()%>',
							stdholdeType:<%=IStakeholderType.STDHOLDETYPE_APPROVAL%>};
			var submitStaff = {linkId:create_linkId,
							linkNo:create_linkNo,
							templateId:create_templateId,
							stdholderStaffId:'<%=user.getUserId()%>',
							stdholderStaffNo:'<%=user.getUserAccount()%>',
							stdholderStaffName:'<%=user.getUserName()%>',
							stdholdeType:<%=IStakeholderType.STDHOLDETYPE_APPROVAL%>};
							
			orderCond = initConds();
			if(orderResult=='pass')
			{
				orderCond = setConds(orderCond,"staffId",'<%=user.getUserId()%>');
				resultSelect = '<%=ConstDefine.WO_APPROVAL_RESULT_PASS%>';
			}
			orderCond = setConds(orderCond,"result",orderResult);
			if(option == null || option =="")
				return;
												
			var submitJson = {};
			submitJson.stakeholder=[nextStaff,submitStaff];
			submitJson.orderDetail={conds:orderCond,opinion:option,orderId:0,result:resultSelect};
			submitJson.testPlan={};
			
			getTestTaskIds();
			submitJson.testTaskIds= testTaskIds;
			
			var fields = Ext.getCmp('testPlanForm').getForm().getFields().items;
			for(var i=0,n=fields.length;i<n;i++){
				var field = fields[i].name;
				submitJson.testPlan[field]= Ext.getCmp('testPlanForm').getForm().findField(field).getValue();
			}
			MaskLoading();
			Ext.Ajax.request({  
				method:'POST',
				url:"<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.aiga.web.TestPlanAction&action=startTPWorkflow&jsonInfo="+Ext.encode(submitJson)+"&uid=<%=user.getUserAccount()%>",  
				success:function(response,config){
					MaskOver();
					//reLoadOrderList('startTestPlan');
					alert("启动成功");
					top.Ext.getCmp("taskFormWin").close();
				},
				failure:function(response,config){
					MaskOver();
					Ext.Msg.alert('提示','保存失败');
				}
			});
			//alert(Ext.encode(submitJson));
		};
		
		function saveTestPlan()
		{
			chooseLinkInfo();
			var submitStaff = {linkId:create_linkId,
							linkNo:create_linkNo,
							templateId:create_templateId,
							stdholderStaffId:'<%=user.getUserId()%>',
							stdholderStaffNo:'<%=user.getUserAccount()%>',
							stdholderStaffName:'<%=user.getUserName()%>',
							stdholdeType:<%=IStakeholderType.STDHOLDETYPE_APPROVAL%>};
								
			orderCond = initConds();
			if(orderResult=='pass')
			{
				orderCond = setConds(orderCond,"staffId",'<%=user.getUserId()%>');
				resultSelect = '<%=ConstDefine.WO_APPROVAL_RESULT_PASS%>';
			}
								
			var submitJson = {};
			submitJson.stakeholder=[submitStaff];
			submitJson.orderDetail={conds:orderCond,orderId:0,result:resultSelect};
			submitJson.testPlan={};
			
			getTestTaskIds();
			submitJson.testTaskIds= testTaskIds;
				
			var fields = Ext.getCmp('testPlanForm').getForm().getFields().items;
			for(var i=0,n=fields.length;i<n;i++){
				var field = fields[i].name;
				submitJson.testPlan[field]= Ext.getCmp('testPlanForm').getForm().findField(field).getValue();
			}
			MaskLoading();
			Ext.Ajax.request({  
				method:'POST',
				url:"<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.aiga.web.TestPlanAction&action=saveTestPlanFirstOrder&jsonInfo="+Ext.encode(submitJson)+"&uid=<%=user.getUserAccount()%>",  
				success:function(response,config){
					MaskOver();
					reLoadOrderList(); 
				},
				failure:function(response,config){
					MaskOver();
					Ext.Msg.alert('提示','保存失败');
				}
			});
		}
    			<%
    		}
    	%>
    	
        var extjsFolderPath = '<%=request.getContextPath()%>/extJs';
        var screenWidth = document.documentElement.clientWidth - 20;
        var screenHeight = document.documentElement.clientHeight*0.91;
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
                            if (data.success == true) {
                            	Ext.Msg.alert("提示","操作成功!");
                                Ext.data.StoreManager.lookup('taskStore').reload({
                                    params: {
                                        planTag: planTag,
                                        planFlag: planFlag,
                                        planId: planId
                                    }
                                });
                            }else{
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
            if ('<%=isHasPlanId%>' == 'true' && '<%=planFlag%>' == 3) {
                planTagTitle = "测试计划启动";
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
                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>系统大类",
                allowBlank: false,
                valueField: 'value',
                displayField: 'show',
                
                //typeAhead : true,  
                //forceSelection: true,
                //triggerAction: 'all',
                //selectOnFocus:true,
                listeners: {
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
                id:'onLineType',
                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>上线类型",
                allowBlank: false,
                valueField: 'value',
                displayField: 'show',
                listeners: {
                	change:function( _this, newValue, oldValue, eOpts ){
                		//versionContent  codeCommitDate  reqTime
            			try{
                			Ext.getCmp('versionContent').setVisible( newValue!=1 );
                			Ext.getCmp('reqTime').setVisible( newValue!=1 );
                			Ext.getCmp('codeCommitDate').setVisible( newValue!=1 );
                		}catch(e){}
                	},
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
 			<%if(planFlag!=null&&(planFlag.equals("0")||planFlag.equals("3"))){%>,value:1,readOnly:true<%}%>
            });

            var testPlanForm = Ext.widget('form', {
                id: 'testPlanForm',
                minWidth: 1024,
                
                width: screenWidth,
                height: 300,
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
                                    if ('<%=isHasPlanId%>' == 'true' && '<%=planFlag%>' == 3) {
                                        testPlanForm.setTitle("测试计划启动&nbsp;&nbsp;(" + planTag + ")");
                                        /*var fieldAry = testPlanForm.getForm().getFields();
										for(var i = 0; i < fieldAry.length; i++) {
											if(fieldAry.get(i).getName().startWith('is')||fieldAry.get(i).getName()=="reqTime"||fieldAry.get(i).getName()=="codeCommitDate"||fieldAry.get(i).getName()=="factCompleteTime"||fieldAry.get(i).getName()=="changeReason")continue;
								  			fieldAry.get(i).setReadOnly(true);
								  		}*/
								  		var fieldAry = testPlanForm.getForm().getFields();
								  		for(var i = 0; i < fieldAry.length; i++) {
											if(fieldAry.get(i).getName().startWith('is')||fieldAry.get(i).getName()=="reqTime"||fieldAry.get(i).getName()=="codeCommitDate"||fieldAry.get(i).getName()=="factCompleteTime"||fieldAry.get(i).getName()=="changeReason"||fieldAry.get(i).getName()=="planName"||fieldAry.get(i).getName()=="versionContent"||fieldAry.get(i).getName()=="planDscr"||fieldAry.get(i).getName()=="bigType"||fieldAry.get(i).getName()=="onLineType")continue;
								  			fieldAry.get(i).setReadOnly(true);
								  		}
                                    }else if ('<%=isHasPlanId%>' == 'true' && '<%=planFlag%>' == 2) {
                                        testPlanForm.setTitle("测试计划变更&nbsp;&nbsp;(" + planTag + ")");
                                        var fieldAry = testPlanForm.getForm().getFields();
										for(var i = 0; i < fieldAry.length; i++) {
											if(fieldAry.get(i).getName()=="reqTime"||fieldAry.get(i).getName()=="codeCommitDate"||fieldAry.get(i).getName()=="factCompleteTime"||fieldAry.get(i).getName()=="changeReason"||fieldAry.get(i).getName()=="versionContent")continue;
											//console.log(fieldAry.get(i).getXTypes());
								  			fieldAry.get(i).setReadOnly(true);
								  		}
                                    }else{
                                    	testPlanForm.setTitle("测试计划查看&nbsp;&nbsp;(" + planTag + ")");
                                    	var fieldAry = testPlanForm.getForm().getFields();
										for(var i = 0; i < fieldAry.length; i++) {
								  			fieldAry.get(i).setReadOnly(true);
								  		}
                                    }
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
                                            //fields[i].setReadOnly(true);
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
                                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>测试计划名称",
                                allowBlank: false
                            }, {
                                xtype: 'hidden',
                                name: 'planId',
                                fieldLabel: '测试计划id'
                            }, {
                                xtype: 'hidden',
                                name: 'planPhase',
                                fieldLabel: '测试计划阶段',
                                value:1
                            }
                        ]
                    }, {
                        xtype: 'fieldcontainer',
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textfield',
                        items: [
                                planStatusCombox,
                               {
                                width: 250,
                                labelAlign: 'right',
                                name: 'submitStaffName',
                                value: '<%=user.getUserName()%>',
                                fieldLabel: '计划提交人'
                                <%if(planFlag!=null&&(planFlag.equals("0")||planFlag.equals("3"))){%>,readOnly:true<%}%>

                            }, {
                                xtype: 'hidden',
                                labelAlign: 'right',
                                name: 'submitStaffId',
                                value: '<%=user.getUserId()%>'
                            },
                            {
                                xtype: "hidden",
                                name: 'planTag',
                                id: "planTag",
                                fieldLabel: '测试计划编号',
                                <%
                                if (!isHasPlanId && planFlag != null && planFlag.equals("0")) { %>
                                        value: planTag,
                                    <%
                                } %> renderer: function (value, cellmeta, record) {}
                            },
                            {
                                width: 250,
                                xtype: 'datefield',
                                labelAlign: 'right',
                                name: 'factCompleteTime',
                                format: 'Y-m-d',
                                fieldLabel: '<font style="color: red; font-weight:bold;">*</font>计划上线时间',
                                listeners:{
                                	select:function(field,value, eOpts ){
                                		try{
                                			if(Ext.getCmp('onLineType').getValue()==0){
	                                			Ext.getCmp('testPlanForm').getForm().findField('codeCommitDate').setValue(new Date(value-24*60*60*1000*4));
                                			}
	                                		var codeCommitDate=Ext.getCmp('testPlanForm').getForm().findField('codeCommitDate').getValue();
	                                		if(codeCommitDate!=''&&codeCommitDate!=null&&codeCommitDate>=value){
	                                			Ext.Msg.alert("提示","代码截止提交日必须早于计划上线时间");field.setValue('') ;
	                                		}
	                                		var codeCommitDate=Ext.getCmp('testPlanForm').getForm().findField('reqTime').getValue();
	                                		if(codeCommitDate!=''&&codeCommitDate!=null&&codeCommitDate>=value){
	                                			Ext.Msg.alert("提示","需求定稿时间必须早于计划上线时间");field.setValue('') ;
	                                		}
                                		}catch(e){}
                                	}
                                }
                            },
                            {
                                width: 250,
                                xtype: 'datefield',
                                name: 'codeCommitDate',
                                id:'codeCommitDate',
                                labelAlign: 'right',
                                format: 'Y-m-d',
                                fieldLabel: '<font style="color: red; font-weight:bold;">*</font>代码截止提交日',
                                listeners:{
                                	select:function(field,value, eOpts ){
                                		try{
                                			var factCompleteTime=Ext.getCmp('testPlanForm').getForm().findField('factCompleteTime').getValue();
                                    		if(factCompleteTime!=''&&factCompleteTime!=null&&factCompleteTime<=value){
                                    			Ext.Msg.alert("提示","代码截止提交日必须早于计划上线时间");field.setValue('') ;
                                    		}
                                		}catch(e){}
                                		
                                	}
                                }
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
                            	bigTypeCombox,
                                onLineTypeCombox, {
                                width: 250,
                                labelAlign: 'right',
                                name: 'versionContent',
                                id:'versionContent',
                                xtype:'numberfield',
                                minValue:0,
                                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>测试可用工时",
                                allowBlank: false

                            },{
                               width: 250,
                               xtype: 'datefield',
                               name: 'reqTime',
                               id: 'reqTime',
                               format: 'Y-m-d',
                               fieldLabel: '<font style="color: red; font-weight:bold;">*</font>需求定稿时间',
                               listeners:{
                                	select:function(field,value, eOpts ){
                                		try{
	                                		var factCompleteTime=Ext.getCmp('testPlanForm').getForm().findField('factCompleteTime').getValue();
	                                		if(factCompleteTime!=''&&factCompleteTime!=null&&factCompleteTime<=value){
	                                			Ext.Msg.alert("提示","需求定稿时间必须早于计划上线时间");field.setValue('') ;
	                                		}
                                		}catch(e){}
                                	}
                                }
                              }

                        ]
                    }, {
                        xtype: 'fieldcontainer',
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textfield',
                        fieldDefaults: {
                        	labelAlign: 'right',
                        	labelWidth: 120
                        },
                        items: [{
                                xtype: 'checkbox',
                                width: 200,
                                checked:true,
                                name: 'isSecurityTest',
                                fieldLabel: '是否安全测试'
                            }, {
                                xtype: 'checkbox',
                                width: 200,
                                checked:true,
                                name: 'isRegressionTest',
                                fieldLabel: '是否自动回归测试'
                            },
                            {
                                xtype: 'checkbox',
                                width: 200,
                                checked:true,
                                name: 'isHwergressionTest',
                                fieldLabel: '是否手工回归测试'
                            }, {
                                xtype: 'checkbox',
                                width: 200,
                                name: 'isCodeScan',
                                fieldLabel: '是否代码扫描'
                            },{
                                xtype: 'checkbox',
                                id: 'isPerformanceTest',
                                width: 200,
                                name: 'isPerformanceTest',
                                fieldLabel: '是否性能测试'
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
                                fieldLabel: "计划描述",
                                allowBlank: true
                            }
                        ]
                    }
                    <%if(planFlag!=null&&planFlag.equals("2")){%>
                    , {
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
                    <%}%>
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
                margins: '0 0 0 0',
                height: 180,
                width: screenWidth,
                <%if(!(createTestPlanFlag!=null&&createTestPlanFlag.equals("1"))){%>
                tbar: [ <%
                    if (planFlag != null && (planFlag.equals("0")||planFlag.equals("2"))) { %> {
                            xtype: 'hidden',
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
                        },
                        {
                            xtype: 'hidden',
                            text: '新建用户体验测试任务',
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
                                    html: '<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/workflow/testPlan/P2PTaskForm.jsp?planFlag='+planFlag+'&flag=0&planTag=' + planTag + '&planId=' + planId + '" width="1100" height="480"/>'
                                }).show();
                            }
                        }
                       <%
                    } %>
                ],
                <%}%>
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
                            if (value == 'on') return "是";
                            else return "否";
                        },
                        hidden: true
                    }, {
                        header: '是否性能测试',
                        dataIndex: 'isPerformanceTest',
                        width: 60,
                        align: 'center',
                        renderer: function (value, cellmeta, record) {
                            if (value == 'on') return "是";
                            else return "否";
                        },
                        hidden: true
                    }, {
                        header: '是否跨周期需求',
                        dataIndex: 'isCrossCycle',
                        width: 60,
                        align: 'center',
                        renderer: function (value, cellmeta, record) {
                            if (value == 'on') return "是";
                            else return "否";
                        },
                        hidden: true
                    }, {
                        header: '是否端对端测试',
                        dataIndex: 'isPoint2pointTest',
                        width: 60,
                        align: 'center',
                        renderer: function (value, cellmeta, record) {
                            if (value == 'on') return "是";
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
            var tabPanel = Ext.create("Ext.tab.Panel", {
                frame: true,
                minWidth: 1024,
           		border: 0,
                width: screenWidth,
                minHeight: 150,
                height:300,
                id: 'tabPanel',
                activeTab: 0, // 默认激活第1个tab页
                renderTo: Ext.getBody(),
                items: [ 
                	<%if (planFlag != null && planFlag.equals("0")) { %>
                            taskGrid, {
                            title: "附件列表",
                            contentEl:'fileTrans',
                            listeners:{
                            	beforeshow:function(tab,eOpts){
                            		$('#fileTrans').show();
                            		initPackList(planTag, '1', current_linkNo,'0','0',false);
                            	}
                            }
                        } <%
                    } else if(planFlag != null && planFlag.equals("2")){%>
                    taskGrid,
                    {
                        title: "历史轨迹",
                        height: 170,
                        width: screenWidth - 10,
                        html: '<iframe id="f_1" scrolling="auto" frameborder="0" width="100%" height="100%" src="<%=request.getContextPath()%>/aiga/workflow/common/HistoryTrack.jsp?objId=${param.objId}&objType=${param.objType}"></iframe>'
                    }, {
                        title: "版本测试任务列表",
                        height: 170,
                        width: screenWidth - 10,
                        contentEl:'solidDiv',
                        listeners:{
                        	beforeshow:function(tab,eOpts){
                        		Ext.get("solidDiv").show();
                        		$("#solidDiv").show();
                        	}
                        }
                    }, {
                        title: "附件列表",
                        height: 180,
                        width: screenWidth - 10,
                        contentEl:'fileTrans',
                        listeners:{
                        	beforeshow:function(tab,eOpts){
                        		$('#fileTrans').show();
                        		initPackList(planTag, '1', current_linkNo,'0','0',false);
                        	}
                        }
                    }
                   <% }else{ %>
                        {
                            title: "历史轨迹",
                            height: 170,
                            width: screenWidth - 10,
                            html: '<iframe id="f_1" scrolling="auto" frameborder="0" width="100%" height="100%" src="<%=request.getContextPath()%>/aiga/workflow/common/HistoryTrack.jsp?objId=${param.objId}&objType=${param.objType}"></iframe>'
                        }, {
                            title: "版本测试任务列表",
                            height: 170,
                            width: screenWidth - 10,
                            contentEl:'solidDiv',
                            listeners:{
                            	beforeshow:function(tab,eOpts){
                            		Ext.get("solidDiv").show();
                            		$("#solidDiv").show();
                            	}
                            }
                        }, 
                        taskGrid,
                        {
                            title: "附件列表",
                            height: 180,
                            width: screenWidth - 10,
                            contentEl:'fileTrans',
                            listeners:{
                            	beforeshow:function(tab,eOpts){
                            		$('#fileTrans').show();
                            		initPackList(planTag, '1', current_linkNo,'0','0',false);
                            	}
                            }
                        } <%
                    } %>
                ]
            });
            Ext.create('Ext.Panel', {
            	id:'testPlanPanel',
                renderTo: Ext.get('planPanel'),
                cls: 'ui-formPanel',
                minWidth: 1024,
                minHeight: 600,
                width: screenWidth,
                height: screenHeight*.99,
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