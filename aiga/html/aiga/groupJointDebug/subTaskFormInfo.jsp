<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");%>
<html>
    <head>
        <title>联调测试子任务</title>
    </head>
    <body>
       	<img id="loading" src="<%=request.getContextPath()%>/aiga/workflow/testTask/ajaxFileUpload/loading.gif" style="display:none;">
		<form name="form" action="" method="POST" enctype="multipart/form-data">
			<div id='uploadTestTaskDiv'></div>
		</form>
		<form style="display:none;" id="exportForm" action="<%=request.getContextPath()%>/downloadTemplateExcel.do?templateFileName=testPlanTemplate.xls&fileName=test_Plan_Template.xls" enctype="multipart/form-data" method="post" target="temp">
			<input type="hidden" name="method" value="export" />
			<input type="submit" id="download" class="tmpBtn" value="下载" />
		</form>
      	<div id="fileTrans"  style="display:none;"><jsp:include page="/aiga/attach/fileTrans.jsp"></jsp:include></div>
      	<div id="planPanel"></div>
    </body>
	<script type="text/javascript" src="<%=request.getContextPath()%>/aiga/workflow/testTask/ajaxFileUpload/ajaxfileupload.js"></script>
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
		     * 任务类型
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
		    
		    /**
		     * 开发进度
		     */
		    var devProgressStore = new Ext.data.Store({
		        id: 'devProgressStore',
		        fields: ['value', 'show'],
		        proxy: {
		            type: 'ajax',
		            url: '<%=request.getContextPath()%>/getComBoxForJointDebugTaskForm.do?query=devProgress',
		            reader: {
		            	type: 'json',
		           		root: 'data'
		           	}
		        }
		    });
		    devProgressStore.load();
		    
		    /**
		     * 联调用例状态
		     */
		    var isDeleteStore = new Ext.data.Store({
		        id: 'isDeleteStore',
		        fields: ['value', 'show'],
		        proxy: {
		            type: 'ajax',
		            url: '<%=request.getContextPath()%>/getComBoxForGroupCase.do?query=isDelete',
		            reader: {
		            	type: 'json',
		           		root: 'data'
		           	}
		        }
		    });
		    isDeleteStore.load();
		    
            //各种角色MODEL
            var StaffRoleViewModel = Ext.define('StaffRoleViewModel', {
                extend: 'Ext.data.Model',
                fields: [
                	{
                        name: 'staffId',
                        type: 'string'
                    }, {
                        name: 'staffCode',
                        type: 'string'
                    }, {
                        name: 'staffName',
                        type: 'string'
                    }, {
                        name: 'displayName',
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
            //开发负责人下拉列表框
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
	            readOnly:true,
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
            //集团联调子任务表单
            var subTaskForm = Ext.widget('form', {
                id: 'subTaskForm',
                width: screenWidth,
                <%if(request.getParameter("winFlag").equals("create")){%>
                height: 500,
                <%}else{%>
                height: 299,
                <%}%>
                autoScroll:true,
                //tbar: [],
                title: '集团联调测试子任务单',
                layout: {
                    type: 'vbox'
                },
                listeners: {
                    render:function (render, eOpts) {
                    	<%if(!request.getParameter("subTaskId").equals("")&&!request.getParameter("subTaskId").equals("null")&&request.getParameter("subTaskId")!=null){%>
                    	//开发人员填写子任务信息的时候会执行该部分.(查询出子任务的信息直接修改)
                    	MaskLoading();
                    	subTaskForm.load({
	                        params: {
	                            subTaskId:'<%=request.getParameter("subTaskId")%>'
	                        },
	                        url: '<%=request.getContextPath()%>/getJointDebugSubTaskFormBySubTaskId.do',
	                        method: 'POST',
	                        success: function (form, action) {
					            //加载已经关联的用例
					            Ext.data.StoreManager.lookup('groupCaseStore').load({params: {subTaskId: action.result.data.subTaskId}});
                            	MaskOver();
	                        },
	                        failure: function (form, action) {
                            	MaskOver();
	                            Ext.Msg.alert('提示', "失败原因是:" + action.result.errorMessage);
	                        }
                    	});
                		<%}else if(!request.getParameter("taskId").equals("")&&!request.getParameter("taskId").equals("null")&&request.getParameter("taskId")!=null){%>
                		//分配子任务的时候会执行该部分.(查询出子任务在任务中继承的那些信息)
                		MaskLoading();
                    	subTaskForm.load({
	                        params: {
	                            taskId:'<%=request.getParameter("taskId")%>'
	                        },
	                        url: '<%=request.getContextPath()%>/getJointDebugTaskFormByTaskId.do',
	                        method: 'POST',
	                        success: function (form, action) {
                            	MaskOver();
	                        },
	                        failure: function (form, action) {
                            	MaskOver();
	                            Ext.Msg.alert('提示', "失败原因是:" + action.result.errorMessage);
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
                                name: 'subTaskName',
                                id:'subTaskName',
                                fieldLabel: "联调子任务名称",
                                allowBlank: false
                            }, {
                                xtype: 'hidden',
                                name: 'subTaskId',
                                fieldLabel: '子任务id'
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
                    },{//////////////////////////////////////////////第二行
                        xtype: 'fieldcontainer',
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textfield',
                        items: [
                        	{
                                width: 750,
                                labelAlign: 'right',
                                name: 'taskName',
                                id:'taskName',
                                readOnly : true,
                                fieldLabel: "联调任务名称",
                                allowBlank: false
                            }, {
                                width: 250,
                                labelAlign: 'right',
                                name: 'subTaskTag',
                                id: 'subTaskTag',
                                fieldLabel: "子任务编号",
                                <%if(request.getParameter("winFlag").equals("create")){%>
				                value:'GJDSTF'+Ext.util.Format.date(new Date(),'YmdHisu'),
				                <%}%>
                                readOnly:true,
                                allowBlank: false
                            }
                        ]
                    },{//////////////////////////////////////////////////////第三行
                        xtype: 'fieldcontainer',
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textfield',
                        fieldDefaults: {
                            labelAlign: 'right'
                        },
                        items: [
                        	{
		                        xtype: "combo",
		                        id: "bigTypeCombox",
						        width: 250,
								forceSelection:true,
						       	typeAhead:true,
		                        store: bigTypeStore,
		                        name: "bigType",
		                        fieldLabel: "系统大类",
		        				allowBlank: false,
		                        valueField: 'value',
		        				labelAlign: 'right',
		                        displayField: 'show',
				                triggerAction: 'all',
				                queryMode: 'local',
				                minChars:1,
	                            readOnly : true,
				                selectOnFocus: true,
					           	mode:'local',
					           	value:'',
							    listeners:{
							        change: function(combo, newValue, oldValue, eOpts) {
			            			    //1.get subType combox value
			            				var subType = Ext.getCmp('subTypeCombox').getValue();
			            				var storeClone = Ext.clone(Ext.StoreMgr.get('subTypeStore'));//克隆一个原有的Store
			            				storeClone.setProxy({
							    			type: 'ajax',
									        url: '<%=request.getContextPath()%>/getComBoxForJointDebugTaskForm.do?query=subType&other2='+newValue,
									        reader: {
									        	type: 'json',
									        	root: 'data'
									    	}
									    });
			            				storeClone.reload();//加载一次最新的Store
			            				if(storeClone.findRecord("value",subType)==null){
			            					Ext.getCmp('subTypeCombox').clearValue();
								    		Ext.StoreMgr.get('subTypeStore').setProxy({
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
	                            fieldLabel: "系统子类",
	        				    allowBlank: false,
	                            valueField: 'value',
                                readOnly : true,
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
	                            fieldLabel: "任务类型",
	        				    allowBlank: false,
	                            valueField: 'value',
                                readOnly : true,
	                            displayField: 'show',
				                triggerAction: 'all',
				                queryMode: 'local',
				                minChars:1,
				                selectOnFocus: true,
					            mode:'local',
					            value:''
	                       }, {
                                width: 250,
                                labelAlign: 'right',
                                name: 'taskTag',
                                id: 'taskTag',
                                fieldLabel: "任务编号",
                                readOnly:true,
                                allowBlank: false
                            }
                            
                    	]
                    },{////////////////////////////////////////////第四行
                        xtype: 'fieldcontainer',
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textfield',
                        fieldDefaults: {
                            labelAlign: 'right'
                        },
                        items: [
                        	{
                                width: 250,
                                xtype: 'datefield',
                                labelAlign: 'right',
                                name: 'taskPlanBeginCommitTime',
                                id: 'taskPlanBeginCommitTime',
                                format: 'Y-m-d',
                                readOnly:true,
                                fieldLabel: '开发任务计划开始提交日期'
                            }, {
                                width: 250,
                                xtype: 'datefield',
                                labelAlign: 'right',
                                name: 'taskPlanEndCommitTime',
                                id: 'taskPlanEndCommitTime',
                                format: 'Y-m-d',
                                readOnly:true,
                                fieldLabel: '开发任务计划完成提交日期'
                            }, {
                                width: 250,
                                xtype: 'datefield',
                                labelAlign: 'right',
                                name: 'taskFactBeginCommitTime',
                                id: 'taskFactBeginCommitTime',
                                format: 'Y-m-d',
                                allowBlank: false,
                                fieldLabel: '<font style="color: red; font-weight:bold;">*</font>开发任务实际开始提交日期',
                                listeners:{
                                	select:function(field,value, eOpts ){
                                		var taskFactEndCommitTime=Ext.getCmp('subTaskForm').getForm().findField('taskFactEndCommitTime').getValue();
                                		if(taskFactEndCommitTime!=''&&taskFactEndCommitTime!=null&&taskFactEndCommitTime<value){
                                			Ext.Msg.alert("提示","开发任务实际开始提交日期必须早于开发任务实际完成提交日期");field.setValue('') ;
                                		}
                                	}
                                }
                            }, {
                                width: 250,
                                xtype: 'datefield',
                                labelAlign: 'right',
                                name: 'taskFactEndCommitTime',
                                id: 'taskFactEndCommitTime',
                                format: 'Y-m-d',
                                allowBlank: false,
                                fieldLabel: '<font style="color: red; font-weight:bold;">*</font>开发任务实际完成提交日期',
                                listeners:{
                                	select:function(field,value, eOpts ){
                                		var taskFactBeginCommitTime=Ext.getCmp('subTaskForm').getForm().findField('taskFactBeginCommitTime').getValue();
                                		if(taskFactBeginCommitTime!=''&&taskFactBeginCommitTime!=null&&taskFactBeginCommitTime>value){
                                			Ext.Msg.alert("提示","开发任务实际开始提交日期必须早于开发任务实际完成提交日期");field.setValue('') ;
                                		}
                                	}
                                }
                            }
                        ]
                    }, {////////////////////////////////////////////第五行
                        xtype: 'fieldcontainer',
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textfield',
                        fieldDefaults: {
                            labelAlign: 'right'
                        },
                        items: [
                        	{
                                width: 250,
                                xtype: 'datefield',
                                labelAlign: 'right',
                                name: 'jointDebugFactBeginTime',
                                format: 'Y-m-d',
	        				    allowBlank: false,
                                fieldLabel: '<font style="color: red; font-weight:bold;">*</font>联调实际开始日期',
                                listeners:{
                                	select:function(field,value, eOpts ){
                                		var jointDebugFactEndTime=Ext.getCmp('subTaskForm').getForm().findField('jointDebugFactEndTime').getValue();
                                		if(jointDebugFactEndTime!=''&&jointDebugFactEndTime!=null&&jointDebugFactEndTime<value){
                                			Ext.Msg.alert("提示","联调实际开始日期必须早于联调实际结束日期");field.setValue('') ;
                                		}
                                	}
                                }
                            }, {
                                width: 250,
                                xtype: 'datefield',
                                labelAlign: 'right',
                                name: 'jointDebugFactEndTime',
                                format: 'Y-m-d',
	        				    allowBlank: false,
                                fieldLabel: '<font style="color: red; font-weight:bold;">*</font>联调实际结束日期',
                                listeners:{
                                	select:function(field,value, eOpts ){
                                		var jointDebugFactBeginTime=Ext.getCmp('subTaskForm').getForm().findField('jointDebugFactBeginTime').getValue();
                                		if(jointDebugFactBeginTime!=''&&jointDebugFactBeginTime!=null&&jointDebugFactBeginTime>value){
                                			Ext.Msg.alert("提示","联调实际开始日期必须早于联调实际结束日期");field.setValue('') ;
                                		}
                                	}
                                }
                            }, {
	                            xtype: "combo",
						        width: 250,
							    forceSelection:true,
						        typeAhead:true,
	        				    labelAlign: 'right',
	                            id: "devProgressCombox",
	                            store: devProgressStore,
	                            name: "devProgress",
	                            fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>开发进度",
	        				    allowBlank: false,
	                            valueField: 'value',
	                            displayField: 'show',
				                triggerAction: 'all',
				                queryMode: 'local',
				                minChars:1,
				                selectOnFocus: true,
					            mode:'local',
					            value:''
                            },
                            devManagerComboBox, 
                        	{
	                            xtype: 'hidden',
                                name: 'devManagerId',
                                id: 'devManagerId',
                                fieldLabel: '开发负责人ID'
                            }
                        ]
                	}, {////////////////////////////////////////////第七行
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
                                readOnly : true,
		                        name: 'isNeedMessage',
		                        id: "isNeedMessage",
							    listeners: {
							        change: function(myField, newValue, oldValue, eOpts){
                        				if(newValue){
                                			Ext.getCmp('subTaskForm').getForm().findField('messageRemarks').setVisible(true);
                        				}else{
                                			Ext.getCmp('subTaskForm').doLayout();
                                			Ext.getCmp('subTaskForm').getForm().findField('messageRemarks').setVisible(false);
                                			Ext.getCmp('subTaskForm').getForm().findField('messageRemarks').setValue('');
                        				}
							        }
							    }
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
                        items: [
                        	{
                                width: 1000,
                                height: 80,
                                readOnly : true,
                                name: 'messageRemarks',
                                id: 'messageRemarks',
                                fieldLabel: "造报文原因说明",
                                hidden : true
                            }
                        ]
                    }
                ]

            });
            <%if(request.getParameter("winFlag").equals("alter")){%>
            //集团用例Store
            var groupCaseStore = Ext.create('Ext.data.Store', {
                storeId: 'groupCaseStore',
                fields: [
                	{
                        name: 'caseId',
                        type: 'string'
                    }, {
                        name: 'caseName',
                        type: 'string'
                    }, {
                        name: 'caseDesc',
                        type: 'string'
                    }, {
                        name: 'testPurpose',
                        type: 'string'
                    }, {
                        name: 'preCondition',
                        type: 'string'
                    }, {
                        name: 'testDataDesc',
                        type: 'string'
                    }, {
                        name: 'testStep',
                        type: 'string'
                    }, {
                        name: 'remark',
                        type: 'string'
                    }, {
                        name: 'preResult',
                        type: 'string'
                    }, {
                        name: 'isDelete',
                        type: 'string'
                    }, {
                        name: 'createTime',
                        type: 'string'
                    }, {
                        name: 'creatorId',
                        type: 'string'
                    }, {
                        name: 'creatorName',
                        type: 'string'
                    },{
                        name: 'isNeedMessage',
                        type: 'string'
                    }
                ],
                proxy: {
                    type: 'ajax',
                    url: '<%=request.getContextPath()%>/getGroupCaseListBySubTaskId.do',
                    reader: {
                        root: "data",
                        type: "json"
                    }
                }
            });
            var taskGrid = Ext.create('Ext.grid.Panel', {
                id: 'taskGrid',
                cls: 'ui-formPanel',
                title: '关联用例',
                margins: '0 0 0 0',
                height: 180,
                width: screenWidth,
                tbar: [ 
               		{
                        xtype: 'button',
                        text: '维护关联用例',
                        handler: function () {
               				var subTaskId = Ext.getCmp('subTaskForm').getForm().findField('subTaskId').getValue();
               				var subTaskName = Ext.getCmp('subTaskForm').getForm().findField('subTaskName').getValue()+"";
               				if(subTaskName.length>10){
								subTaskName = subTaskName.substring(0,10)+"...";
							}
               				console.log(window.parent);
                            window.parent.addNewTab("<%=request.getContextPath()%>/aiga/groupCase/groupCase.jsp?subTaskId="+subTaskId,subTaskName+"用例管理","");
                        }
                    },{
		                xtype: 'fileuploadfield',
		                id:'fileToUpload',
		                fieldLabel: '批量导入测试用例',
		                buttonText: '选择功能文件',
		                listeners:{
		                    	change:function(comp,str,eOpts){
		                    		if(str.endWith('xls')||str.endWith('xlsx')){
		                    			var fieldAry = Ext.getCmp('subTaskForm').getForm().getFields();
		                    			var subTaskId = "";
		                    			var subType = "";
										for(var i = 0; i < fieldAry.length; i++) {
											if(fieldAry.get(i).getName()=="subTaskId"){
												subTaskId = fieldAry.get(i).getValue();
											}
											else if(fieldAry.get(i).getName()=="subType"){
												subType = fieldAry.get(i).getValue();
											}else{
												continue;
											}
								  		}
										if(subTaskId==""||subTaskId==null){
		                    				Ext.MessageBox.alert('提示','请先保存子任务再管理用例subTaskId='+subTaskId+'subType'+subType);
		                    				return;
										}
		                    			Ext.getCmp("upload").setHandler(function(){ajaxFileUpload(subTaskId,subType);});
		                    		}else{
		                    			Ext.MessageBox.alert('提示','['+str+']文件不是合法的Excel文件');
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
                ],
                forctFit: true,
                stripeRows: true,
                loadMask: true,
                store: groupCaseStore,
                selType: 'rowmodel',
                listeners: {},
                columns: [
                	new Ext.grid.RowNumberer(),
                	{header: "用例Id",width: 100,sortable: false,dataIndex: 'caseId',hidden: true},
                	{header: "用例名称",width: 100,sortable: false,dataIndex: 'caseName'},
                	{header: "用例描述",width: 100,sortable: false,dataIndex: 'caseDesc'},
                	{header: "测试目的",width: 100,sortable: false,dataIndex: 'testPurpose'},
                	{header: "前置条件",width: 100,sortable: false,dataIndex: 'preCondition'},
                	{header: "测试数据描述",width: 100,sortable: false,dataIndex: 'testDataDesc'},
                	{header: "测试步骤",width: 100,sortable: false,dataIndex: 'testStep'},
                	{header: "预测结果",width: 100,sortable: false,dataIndex: 'preResult'},
                	{header: "是否需要造报文",width: 100,sortable: false,dataIndex: 'isNeedMessage',
	                    renderer: function (value, cellmeta, record) {
	                        if (value == 'on'||value==1) return "是";
	                        else return "否";
                    }},
                	{header: "描述",width: 100,sortable: false,dataIndex: 'remark'},
                	{header: "用例状态",width: 100,sortable: false,dataIndex: 'isDelete',renderer: function(value, cellmeta, record) {
		  	        	try{
		  	        		var store=Ext.data.StoreManager.lookup("isDeleteStore");
		 	        		store.clearFilter(true);
		 	        		return store.findRecord("value",value).getData().show+"";
		  	        	}catch(e){return "未指定"};
		  	        }},
                	{header: "创建日期",width: 100,sortable: false,dataIndex: 'createTime',renderer: function(value, cellmeta, record) {
		  	        	return value.substring(0,10)+"";
		  	        }},
                	{header: "创建人",width: 100,sortable: false,dataIndex: 'creatorName'},
                	{header: "测试人ID",width: 100,sortable: false,dataIndex: 'creatorId',hidden: true}
                ]
            });
            var taskGrid1 = Ext.create('Ext.grid.Panel', {
                id: 'taskGrid1',
                cls: 'ui-formPanel',
                title: '集团联调子任务单列表',
                margins: '0 0 0 0',
                height: 180,
                width: screenWidth,
                forctFit: true,
                stripeRows: true,
                loadMask: true,
                store: groupCaseStore,
                selType: 'rowmodel',
                listeners: {
                },
                columns: [
	                new Ext.grid.RowNumberer(), 
	                {
                        header: "需求编号",
                        width: 100,
                        sortable: true,
                        dataIndex: 'reqTag'
                    }, {
                        header: "开发任务编号",
                        width: 100,
                        sortable: true,
                        dataIndex: 'devTag'
                    }
                ]
            });
            var taskGrid2 = Ext.create('Ext.grid.Panel', {
                id: 'taskGrid2',
                cls: 'ui-formPanel',
                title: '变更单',
                margins: '0 0 0 0',
                height: 180,
                width: screenWidth,
                forctFit: true,
                stripeRows: true,
                loadMask: true,
                store: groupCaseStore,
                selType: 'rowmodel',
                listeners: {
                },
                columns: [
	                new Ext.grid.RowNumberer(), 
	                {
                        header: "需求编号",
                        width: 100,
                        sortable: true,
                        dataIndex: 'reqTag'
                    }, {
                        header: "开发任务编号",
                        width: 100,
                        sortable: true,
                        dataIndex: 'devTag'
                    }
                ]
            });
            var taskGrid3 = Ext.create('Ext.grid.Panel', {
                id: 'taskGrid3',
                cls: 'ui-formPanel',
                title: '历史轨迹',
                margins: '0 0 0 0',
                height: 180,
                width: screenWidth,
                forctFit: true,
                stripeRows: true,
                loadMask: true,
                store: groupCaseStore,
                selType: 'rowmodel',
                listeners: {
                },
                columns: [
	                new Ext.grid.RowNumberer(), 
	                {
                        header: "需求编号",
                        width: 100,
                        sortable: true,
                        dataIndex: 'reqTag'
                    }, {
                        header: "开发任务编号",
                        width: 100,
                        sortable: true,
                        dataIndex: 'devTag'
                    }
                ]
            });
            var tabPanel = Ext.create("Ext.tab.Panel", {
                frame: true,
           		border: 0,
                width: screenWidth,
                height:205,
                id: 'tabPanel',
                activeTab: 0, // 默认激活第1个tab页
                renderTo: Ext.getBody(),
                items: [
                	
                	taskGrid,
                	taskGrid1,
                	taskGrid2,
                	taskGrid3,
                	{
                        title: "附件列表",
                        contentEl:'fileTrans',
                        listeners:{
                        	beforeshow:function(tab,eOpts){
                        		$('#fileTrans').show();
                        		//initPackList(planTag, '1', current_linkNo,'0','0',false);
                        	}
                        }
                    }
                ]
            });
            <%}%>	
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
                        items: [subTaskForm
                            <%if(request.getParameter("winFlag").equals("alter")){%>	
                        	, tabPanel
                        	<%}%>
                        ]
                    }
                ]
            });
        });
        function ajaxFileUpload(subTaskId,subType){
			MaskLoading();
			url="<%=request.getContextPath()%>/uploadGroupCaseExcel.do?subTaskId="+subTaskId+"&subType="+subType;
			$.ajaxFileUpload(
					{
						url:url,
						secureuri:false,
						fileElementId:'fileToUpload',
						dataType: 'json',
					success: function (data, status)
					{
							MaskOver();
							var funFolderStore=Ext.data.StoreManager.lookup('funFolderStore');
							funFolderStore.add(data.data);
							if(typeof(data.msg)=="undefined"){
								var subTaskId = Ext.getCmp('subTaskForm').getForm().findField('subTaskId').getValue();
					            //加载已经关联的用例
					            Ext.data.StoreManager.lookup('groupCaseStore').reload({params: {subTaskId: subTaskId}});
								Ext.Msg.alert("提示","导入成功！");
							}else{
								if(data.success){
									var subTaskId = Ext.getCmp('subTaskForm').getForm().findField('subTaskId').getValue();
						            //加载已经关联的用例
						            Ext.data.StoreManager.lookup('groupCaseStore').reload({params: {subTaskId: subTaskId}});
									Ext.Msg.alert("提示",data.msg);
								}else{
									Ext.Msg.alert("错误提示",data.msg);
								}
							}
					},
					error: function (data, status, e)
					{	
						MaskOver();
					    if(data.success){
							Ext.Msg.alert("提示",data.msg);
							var subTaskId = Ext.getCmp('subTaskForm').getForm().findField('subTaskId').getValue();
				            //加载已经关联的用例
				            Ext.data.StoreManager.lookup('groupCaseStore').reload({params: {subTaskId: subTaskId}});
						}else{
							Ext.Msg.alert("错误提示",data.msg);
						}
					}
				}
			)
			return false;
		}
    </script>
</html>