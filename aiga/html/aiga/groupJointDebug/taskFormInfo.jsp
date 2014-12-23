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
      	<div id="planPanel"></div>
    </body>
    <script type="text/javascript">
        var extjsFolderPath = '<%=request.getContextPath()%>/extJs';
        var screenWidth = document.documentElement.clientWidth*0.999;
        var screenHeight = document.documentElement.clientHeight*0.92;
        
        Ext.onReady(function () {
            Ext.QuickTips.init();
            Ext.tip.QuickTipManager.init();
            var dateFormat = Ext.Date.format(new Date, 'YmdHisu');
            /**
		     * 系统大类
		     */
		    var bigTypeStore = new Ext.data.Store({
		        id: 'bigTypeStore',
		        fields: ['value', 'show'],
		        proxy: {
		            type: 'ajax',
		            url: '<%=request.getContextPath()%>/getComBoxForJointDebugTaskForm.do?query=bigType',
		            reader: {
		            	type: 'json',
		           		root: 'data'
		           	}
		        }
		    });
		    bigTypeStore.load();
		    
		    /**
		     * 系统子类
		     */
		    var subTypeStore = new Ext.data.Store({
		        id: 'subTypeStore',
		        fields: ['value', 'show'],
		        proxy: {
		            type: 'ajax',
		            url: '<%=request.getContextPath()%>/getComBoxForJointDebugTaskForm.do?query=subType',
		            reader: {
		                type: 'json',
		                root: 'data'
		            }
		        }
		    });
		    subTypeStore.load();
		    
		    /**
		     * 系统大类
		     */
		    var taskTypeStore = new Ext.data.Store({
		        id: 'taskTypeStore',
		        fields: ['value', 'show'],
		        proxy: {
		            type: 'ajax',
		            url: '<%=request.getContextPath()%>/getComBoxForJointDebugTaskForm.do?query=taskType',
		            reader: {
		            	type: 'json',
		           		root: 'data'
		           	}
		        }
		    });
		    taskTypeStore.load();
		    
            //选择联调管理员
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
            //联调管理员
            var jointDebugManagerStore = new Ext.data.Store({
                id: 'jointDebugManagerStore',
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
            			jointDebugManagerStore.each(function(record){
            				record.set('displayName',record.get('staffCode')+':'+record.get('staffName'));
            			});
                	}
                	
                }
            });
            jointDebugManagerStore.load({params:{staffId:'<%=user.getUserId()%>',roleCode:'WF_TEST_DMD'}});
            var jointDebugManagerComboBox = new Ext.form.ComboBox({
                width: 250,
                mode:'remote',
                store: jointDebugManagerStore,
                name: "jointDebugManagerName",
                id: "jointDebugManagerName",
                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>联调管理员",
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
                		Ext.getCmp('jointDebugManagerId').setValue(records[0].raw.staffId);
                	},
                    beforequery: function (queryEvent, eOpts) {
                    }
                }
            });
            //开发负责人
            var devManagerStore = new Ext.data.Store({
                id: 'devManagerStore',
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
            			devManagerStore.each(function(record){
            				record.set('displayName',record.get('staffCode')+':'+record.get('staffName'));
            			});
                	}
                	
                }
            });
            devManagerStore.load({params:{staffId:'<%=user.getUserId()%>',roleCode:'WF_TEST_DMD'}});
            var devManagerComboBox = new Ext.form.ComboBox({
                width: 250,
                mode:'remote',
                store: devManagerStore,
                name: "devManagerName",
                id: "devManagerName",
                fieldLabel: "开发负责人",
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
                		Ext.getCmp('devManagerId').setValue(records[0].raw.staffId);
                	},
                    beforequery: function (queryEvent, eOpts) {
                    }
                }
            });
            var testPlanForm = Ext.widget('form', {
                id: 'testPlanForm',
                width: screenWidth,
                height: screenHeight*0.9,
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
                    	<%if(!request.getParameter("taskId").equals("")&&!request.getParameter("taskId").equals("null")&&request.getParameter("taskId")!=null){%>
                    	MaskLoading();
                    	testPlanForm.load({
	                        params: {
	                            reqId:'<%=request.getParameter("taskId")%>'
	                        },
	                        url: '<%=request.getContextPath()%>/getJointDebugTaskFormByReqId.do',
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
                                name: 'taskName',
                                id:'taskName',
                                fieldLabel: "联调任务名称",
                                allowBlank: false
                            }, {
                                xtype: 'hidden',
                                name: 'taskId',
                                fieldLabel: '任务id'
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
                        items: [{
	                        xtype: "combo",
	                        id: "bigTypeCombox",
					        width: 250,
							forceSelection:true,
					       	typeAhead:true,
	                        store: bigTypeStore,
	                        name: "bigType",
	                        fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>系统大类",
	        				allowBlank: false,
	                        valueField: 'value',
	        				labelAlign: 'right',
	                        displayField: 'show',
			                triggerAction: 'all',
			                queryMode: 'local',
			                minChars:1,
			                selectOnFocus: true,
				           	mode:'local',
				           	value:'',
						    listeners:{
						    	change: function(combo, newValue, oldValue, eOpts) {
		            				//1.get subSys combox value
		            				var subType = Ext.getCmp('subTypeCombox').getValue();
		            				var storeClone = Ext.clone(Ext.StoreMgr.get('subTypeStore'));//克隆一个原有的Store
		            				storeClone.setProxy(
						    		{
						    			type: 'ajax',
								        url: '<%=request.getContextPath()%>/getComBoxForJointDebugTaskForm.do?query=subType&other2='+newValue,
								        reader: {
								        	type: 'json',
								        	root: 'data'
								    	}
								    });
		            				storeClone.reload();//加载一次最新的Store
		            				//console.log(storeClone.findRecord("value",subSysId));
		            				if(storeClone.findRecord("value",subType)==null){
		            					Ext.getCmp('subTypeCombox').clearValue();
							    		Ext.StoreMgr.get('subTypeStore').setProxy(
							    		{
							    			type: 'ajax',
									        url: '<%=request.getContextPath()%>/getComBoxForJointDebugTaskForm.do?query=subType&other2='+newValue,
									        reader: {
									        	type: 'json',
									        	root: 'data'
									    	}
									    });
							    		Ext.StoreMgr.get('subTypeStore').reload();
		            				}
						    		//2.through store , if the new store's values have the old value
						    		//3.if there is, selected; if not , null.
						    	}
						    }
	                       }, {
	                           xtype: "combo",
						       width: 250,
							   forceSelection:true,
						       typeAhead:true,
	        				   labelAlign: 'right',
	                           id: "subTypeCombox",
	                           store: subTypeStore,
	                           name: "subType",
	                           fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>系统子类",
	        				   allowBlank: false,
	                           valueField: 'value',
	                           displayField: 'show',
				               triggerAction: 'all',
				               queryMode: 'local',
				               minChars:1,
				               selectOnFocus: true,
					           mode:'local',
					           value:''
	                       }, {
	                           xtype: "combo",
						       width: 250,
							   forceSelection:true,
						       typeAhead:true,
	        				   labelAlign: 'right',
	                           id: "taskTypeCombox",
	                           store: taskTypeStore,
	                           name: "taskType",
	                           fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>任务类型",
	        				   allowBlank: false,
	                           valueField: 'value',
	                           displayField: 'show',
				               triggerAction: 'all',
				               queryMode: 'local',
				               minChars:1,
				               selectOnFocus: true,
					           mode:'local',
					           value:'',
							   listeners:{
							       change: function(combo, newValue, oldValue, eOpts) {
			            		       if(newValue==1001){//开发类
			            		           Ext.getCmp('taskName').setFieldLabel("<font style='color: red; font-weight:bold;'>*</font>联调任务名称");
			            		           Ext.getCmp('taskTag').setFieldLabel("<font style='color: red; font-weight:bold;'>*</font>任务编号");
			            		           Ext.getCmp('taskPlanBeginCommitTime').setFieldLabel("<font style='color: red; font-weight:bold;'>*</font>开发任务计划开始提交日期");
			            		           Ext.getCmp('taskPlanEndCommitTime').setFieldLabel("<font style='color: red; font-weight:bold;'>*</font>开发任务计划完成提交日期");
			            		           Ext.getCmp('devManagerName').setFieldLabel("<font style='color: red; font-weight:bold;'>*</font>开发负责人");
			            		       }else if(newValue==1002){//非开发类
			            		           Ext.getCmp('taskName').setFieldLabel("联调任务名称");
			            		           Ext.getCmp('taskTag').setFieldLabel("任务编号");
			            		           Ext.getCmp('taskPlanBeginCommitTime').setFieldLabel("开发任务计划开始提交日期");
			            		           Ext.getCmp('taskPlanEndCommitTime').setFieldLabel("开发任务计划完成提交日期");
			            		           Ext.getCmp('devManagerName').setFieldLabel("开发负责人");
			            		       }	
							       }
							   }
	                       },
	                       /*
	                       reqMgrComboBox, {
	                            xtype: 'hidden',
                                name: 'reqManagerStaffId',
                                id: 'reqManagerStaffId',
                                fieldLabel: '需求管理员ID'
                            },
                            */{
                                width: 250,
                                labelAlign: 'right',
                                name: 'taskTag',
                                id: 'taskTag',
                                fieldLabel: "任务编号",
                                <%if(request.getParameter("winFlag").equals("create")){%>
				                value:'GJDTF'+Ext.util.Format.date(new Date(),'YmdHisu'),
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
                                //readOnly:true,
	        				    allowBlank: false,
                                fieldLabel: '省司要求开发完成日期'
                            },{
                                width: 250,
                                xtype: 'datefield',
                                labelAlign: 'right',
                                name: 'reqPlanAccomplishTime',
                                format: 'Y-m-d',
	        				    allowBlank: false,
                                fieldLabel: '<font style="color: red; font-weight:bold;">*</font>需求计划完成日期',
                                listeners:{
                                	select:function(field,value, eOpts ){
                                		var provincialReqDevEndTime=Ext.getCmp('testPlanForm').getForm().findField('provincialReqDevEndTime').getValue();
                                		console.log(provincialReqDevEndTime);
                                		if(provincialReqDevEndTime!=''&&provincialReqDevEndTime!=null&&provincialReqDevEndTime<value){
                                			Ext.getCmp('testPlanForm').doLayout();
                                			Ext.getCmp('testPlanForm').getForm().findField('reasonRemarks').setVisible(true);
                                		}else{
                                			Ext.getCmp('testPlanForm').doLayout();
                                			Ext.getCmp('testPlanForm').getForm().findField('reasonRemarks').setVisible(false);
                                			Ext.getCmp('testPlanForm').getForm().findField('reasonRemarks').setValue('');
                                		}
                                		var taskPlanEndCommitTime=Ext.getCmp('testPlanForm').getForm().findField('taskPlanEndCommitTime').getValue();
                                		if(taskPlanEndCommitTime!=''&&taskPlanEndCommitTime!=null&&taskPlanEndCommitTime<value){
                                			Ext.Msg.alert("提示","需求计划完成日期必须早于开发任务计划完成提交日期");field.setValue('') ;
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
                                name: 'taskPlanBeginCommitTime',
                                id: 'taskPlanBeginCommitTime',
                                format: 'Y-m-d',
                                fieldLabel: '开发任务计划开始提交日期',
                                listeners:{
                                	select:function(field,value, eOpts ){
                                		var taskPlanEndCommitTime=Ext.getCmp('testPlanForm').getForm().findField('taskPlanEndCommitTime').getValue();
                                		if(taskPlanEndCommitTime!=''&&taskPlanEndCommitTime!=null&&taskPlanEndCommitTime<value){
                                			Ext.Msg.alert("提示","开发任务计划开始提交日期必须早于开发任务计划完成提交日期");field.setValue('') ;
                                		}
                                	}
                                }
                            },{
                                width: 250,
                                xtype: 'datefield',
                                labelAlign: 'right',
                                name: 'taskPlanEndCommitTime',
                                id: 'taskPlanEndCommitTime',
                                format: 'Y-m-d',
                                fieldLabel: '开发任务计划完成提交日期',
                                listeners:{
                                	select:function(field,value, eOpts ){
                                		var taskPlanBeginCommitTime=Ext.getCmp('testPlanForm').getForm().findField('taskPlanBeginCommitTime').getValue();
                                		if(taskPlanBeginCommitTime!=''&&taskPlanBeginCommitTime!=null&&taskPlanBeginCommitTime>value){
                                			Ext.Msg.alert("提示","开发任务计划开始提交日期必须早于开发任务计划完成提交日期");field.setValue('') ;
                                		}
                                		var reqPlanAccomplishTime=Ext.getCmp('testPlanForm').getForm().findField('reqPlanAccomplishTime').getValue();
                                		if(reqPlanAccomplishTime!=''&&reqPlanAccomplishTime!=null&&reqPlanAccomplishTime<value){
                                			Ext.Msg.alert("提示","需求计划完成日期必须早于开发任务计划完成提交日期");field.setValue('') ;
                                		}
                                	}
                                }
                            },
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
                                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>晚于省司要求日期原因说明",
                                hidden : true
                            }
                        ]
                    }, {////////////////////////////////////////////第五行
                        xtype: 'fieldcontainer',
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textarea',
                        fieldDefaults: {
                            labelAlign: 'right'
                        },
                        items: [
                        	jointDebugManagerComboBox, 
                        	{
	                            xtype: 'hidden',
                                name: 'jointDebugManagerId',
                                id: 'jointDebugManagerId',
                                fieldLabel: '联调管理员ID'
                            },
                            devManagerComboBox, 
                        	{
	                            xtype: 'hidden',
                                name: 'devManagerId',
                                id: 'devManagerId',
                                fieldLabel: '开发负责人ID'
                            },{
                                width: 250,
                                xtype: 'datefield',
                                labelAlign: 'right',
                                name: 'jointDebugBeginTime',
                                format: 'Y-m-d',
                                readOnly:true,
                                fieldLabel: '<font style="color: red; font-weight:bold;">*</font>联调开始日期'
                            },{
                                width: 250,
                                xtype: 'datefield',
                                labelAlign: 'right',
                                name: 'jointDebugEndTime',
                                format: 'Y-m-d',
                                readOnly:true,
                                fieldLabel: '<font style="color: red; font-weight:bold;">*</font>联调结束日期'
                            }
                        ]
                    },{////////////////////////////////////////////第六行
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
                                			Ext.getCmp('testPlanForm').getForm().findField('messageRemarks').setVisible(true);
                        				}else{
                                			Ext.getCmp('testPlanForm').doLayout();
                                			Ext.getCmp('testPlanForm').getForm().findField('messageRemarks').setVisible(false);
                                			Ext.getCmp('testPlanForm').getForm().findField('messageRemarks').setValue('');
                        				}
							        }
							    }
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
                    }, {//////////////////////////////////////////////////////第八行
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
                                name: 'remarks',
                                fieldLabel: "备注说明",
                                allowBlank: true
                            }
                        ]
                    }
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
                        items: [testPlanForm]
                    }
                ]
            });
        });
    </script>
</html>