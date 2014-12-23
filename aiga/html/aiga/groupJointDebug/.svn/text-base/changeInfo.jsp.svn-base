<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");%>
<html>
    
    <head>
        <title>集团联调变更</title>
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
      	<div id="fileTrans" style="display:none;"><jsp:include page="/aiga/attach/fileTrans.jsp"></jsp:include></div>
        <div id="planPanel"></div>
    </body>
    <script type="text/javascript">
        var extjsFolderPath = '<%=request.getContextPath()%>/extJs';
        var screenWidth = document.documentElement.clientWidth*0.999;
        var screenHeight = document.documentElement.clientHeight*0.92;
        var changeTaskTagFlag = false;//校验编号是否存在标识.
        var taskPlanBeginCommitTimeValueTemp = "";//暂时缓存子任务的任务计划开始提交日期的数值
        var taskPlanEndCommitTimeValueTemp = "";//暂时缓存子任务的任务计划结束提交日期的数值
        var taskTypeFlag = "";//变更单任务类型标识(1:需求,2:任务,3:子任务)
        var subTaskIdValueTemp = "";//如果子任务类型则把子任务ID暂时缓存,用于内容类型的变更显示关联的子任务
        var subTaskTagValueTemp = "";//如果子任务类型则把子任务编号暂时缓存,用于内容类型的变更显示关联的子任务
        Ext.onReady(function () {
            Ext.QuickTips.init();
            Ext.tip.QuickTipManager.init();
            var dateFormat = Ext.Date.format(new Date, 'YmdHisu');
            /**
		     * 集团联调变更任务类型(1:需求,2:任务,3:子任务)
		     */
		    var changeTaskTypeStore = new Ext.data.Store({
		        id: 'changeTaskTypeStore',
		        fields: ['value', 'show'],
		        proxy: {
		            type: 'ajax',
		            url: '<%=request.getContextPath()%>/getComBoxForJointDebugChange.do?query=changeTaskType',
		            reader: {
		            	type: 'json',
		           		root: 'data'
		           	}
		        }
		    });
		    changeTaskTypeStore.load();
		    
		    /**
		     * 集团联调变更类型(1:时间,2:内容)
		     */
		    var changeTypeStore = new Ext.data.Store({
		        id: 'changeTypeStore',
		        fields: ['value', 'show'],
		        proxy: {
		            type: 'ajax',
		            url: '<%=request.getContextPath()%>/getComBoxForJointDebugChange.do?query=changeType',
		            reader: {
		            	type: 'json',
		           		root: 'data'
		           	}
		        }
		    });
		    changeTypeStore.load();
		    
		    /**
		     * 集团联调变更子任务变更内容类型(1:内容,2:报文,3:状态)
		     */
		    var contentsTypeStore = new Ext.data.Store({
		        id: 'contentsTypeStore',
		        fields: ['value', 'show'],
		        proxy: {
		            type: 'ajax',
		            url: '<%=request.getContextPath()%>/getComBoxForJointDebugChange.do?query=contentsType',
		            reader: {
		            	type: 'json',
		           		root: 'data'
		           	}
		        }
		    });
		    contentsTypeStore.load();
		    
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
		    
            var testPlanForm = Ext.widget('form', {
                id: 'testPlanForm',
                width: screenWidth,
                //height: 297,
                height: 400,
                autoScroll:true,
                tbar: [],
                title: '集团联调变更',
                layout: {
                    type: 'vbox'
                },
                listeners: {
                	
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
                                name: 'changeName',
                                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>集团联调变更名称",
                                allowBlank: false
                            }, {
                                xtype: 'hidden',
                                name: 'changeId',
                                id: 'changeId',
                                fieldLabel: '集团联调变更ID'
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
                            }, {
                                xtype: 'hidden',
                                name: 'auditingId',
                                fieldLabel: '审批人ID'
                            }, {
                                xtype: 'hidden',
                                name: 'auditingTime',
                                fieldLabel: '审批日期'
                            }, {
                                xtype: 'hidden',
                                name: 'auditingName',
                                fieldLabel: '审批人名称'
                            }, {
                                xtype: 'hidden',
                                name: 'auditingName',
                                fieldLabel: '审批人名称'
                            }, {
                                xtype: 'hidden',
                                name: 'isPass',
                                fieldLabel: '是否通过',
                                <%if(request.getParameter("winFlag").equals("create")){%>
				                value:'0'
				                <%}%>
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
                        items: [
                        	{
	                           xtype: "combo",
						       width: 250,
							   forceSelection:true,
						       typeAhead:true,
	        				   labelAlign: 'right',
	                           id: "changeTaskTypeCombox",
	                           store: changeTaskTypeStore,
	                           name: "changeTaskType",
	                           fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>集团联调变更任务类型",
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
							    	   if(newValue!=oldValue){//改变值,以前的校验通过标识直接置为失效
							    		   changeTaskTagFlag = false;
							    		   Ext.getCmp('changeTaskTag').setValue('');
							    		   allSetValueToEmpty();
							    	   }
			            		       if(newValue==1){//需求单
			            		    	   Ext.getCmp('changeTypeCombox').hide();//变更类型(子任务)
			            		    	   Ext.getCmp('reqPlanAccomplishTime').hide();//任务字段
				                           Ext.getCmp('changeTaskTag').setFieldLabel("<font style='color: red; font-weight:bold;'>*</font>集团联调需求编号");
				                           showReqForm();//需求字段
			            		       }else if(newValue==2){//任务单
			            		    	   Ext.getCmp('reqPlanAccomplishTime').show();//任务字段
			            		    	   Ext.getCmp('changeTypeCombox').hide();//变更类型(子任务)
										   Ext.getCmp('changeTaskTag').setFieldLabel("<font style='color: red; font-weight:bold;'>*</font>集团联调任务编号");
										   hideReqForm();//需求字段
			            		       }else if(newValue==3){//子任务单
			            		    	   Ext.getCmp('changeTypeCombox').show();//变更类型(子任务)
			            		    	   Ext.getCmp('reqPlanAccomplishTime').hide();//任务字段
										   Ext.getCmp('changeTaskTag').setFieldLabel("<font style='color: red; font-weight:bold;'>*</font>集团联调子任务编号");
										   hideReqForm();//需求字段
				                       }
		            		    	   taskTypeFlag = newValue;
			                           Ext.getCmp('changeTaskTag').show();
			                           Ext.getCmp('changeTaskTag').focus();
							       }
							   }
	                       },{
                               width: 250,
                               labelAlign: 'right',
                               name: 'changeTaskTag',
                               id: 'changeTaskTag',
                               fieldLabel: '',
                               hidden:true,
                               blankText : '失去焦点自动校验编号是否存在',
                               allowBlank: false,
                               listeners:{
							       change: function(combo, newValue, oldValue, eOpts) {
							    	   var changeTaskType = Ext.getCmp('changeTaskTypeCombox').getValue();
							    	   if(changeTaskType==null||changeTaskType==""){
							    		   Ext.getCmp('changeTaskTypeCombox').focus();
							    	   }
							       },
	                       		   blur:function(component, eventObject, eOpts){
	                       			   var value = component.getValue();
	                       			   var changeTaskType = Ext.getCmp('changeTaskTypeCombox').getValue();
	                       			   if(value!=null&&value!=""){
	                       				    MaskLoading();
		                       				Ext.Ajax.request({
			                					async:false,
			                					url:'<%=request.getContextPath()%>/checkJointDebugChangeTaskTag.do?changeTaskType='+changeTaskType+'&tag='+value,
			                					success:function(response,config){
			                						var json=Ext.JSON.decode(response.responseText);
			                						if(json.success==true){//访问成功
			                							MaskOver();
			                							flag=json.msg;
			                							if(flag=='yes'){
			                								Ext.Msg.alert("提示","编号校验通过");
			                								changeTaskTagFlag = true;
			                								if(changeTaskType==1){//联调需求
				                								Ext.getCmp('groupReqDevEndTime').setValue(json.groupReqDevEndTime);
				                								Ext.getCmp('provincialReqDevEndTime').setValue(json.provincialReqDevEndTime);
				                								Ext.getCmp('jointDebugPlanBeginTime').setValue(json.jointDebugPlanBeginTime);
				                								Ext.getCmp('jointDebugPlanEndTime').setValue(json.jointDebugPlanEndTime);
			                								}else if(changeTaskType==2){
				                								Ext.getCmp('reqPlanAccomplishTime').setValue(json.reqPlanAccomplishTime);
			                								}else if(changeTaskType==3){
			                									taskPlanBeginCommitTimeValueTemp = json.taskPlanBeginCommitTime;
			                									taskPlanEndCommitTimeValueTemp = json.taskPlanEndCommitTime;
			                									subTaskIdValueTemp = json.subTaskId;
			                									subTaskTagValueTemp = value;
			                								}else{
				                								changeTaskTagFlag = false;
				                								allSetValueToEmpty();
				                								Ext.Msg.alert("提示","常量表数据出错(changeTaskType)");
			                								}
			                							}
			                						}else if(json.success==false){
			                							MaskOver();
			                							flag=json.msg;
			                							if(flag=='error'){
			                								Ext.Msg.alert("提示","数据错误或服务器出现异常");
			                								changeTaskTagFlag = false;
			                							}
			                							if(flag=='no'){
			                								Ext.Msg.alert("提示","该编号不存在");
			                								changeTaskTagFlag = false;
			                							}
			                							allSetValueToEmpty();
			                							hideSubTaskForm();
		                								component.setValue('');
		                								component.focus();
			                						}
			                					}
			                			   });
	                       			   }
	                       		   }
							   }
                           },{
                                width: 250,
                                labelAlign: 'right',
                                name: 'changeTag',
                                id: 'changeTag',
                                fieldLabel: "集团联调变更编号",
                                <%if(request.getParameter("winFlag").equals("create")){%>
				                value:'GJDC'+Ext.util.Format.date(new Date(),'YmdHisu'),
				                <%}%>
                                readOnly:true,
                                allowBlank: false
                            },{
	                           xtype: "combo",
						       width: 250,
							   forceSelection:true,
						       typeAhead:true,
	        				   labelAlign: 'right',
	                           id: "changeTypeCombox",
	                           store: changeTypeStore,
	                           name: "changeType",
	                           fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>集团联调变更类型",
	                           hidden:true,
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
							    	   if(!changeTaskTagFlag&&newValue!=null){//首先必须校验通过子任务编号
											Ext.Msg.alert("提示","请先填写集团联调子任务编号,并通过校验才可以选择变更类型");
											Ext.getCmp('changeTaskTag').setValue('');
											Ext.getCmp('changeTaskTag').focus();
											combo.setValue('');
											return;
							    	   }else if(newValue==1){//时间类型
							    		   Ext.getCmp('tabPanel').hide();
							    		   Ext.getCmp('testPlanForm').setHeight(400);
							    		   Ext.getCmp('taskPlanBeginCommitTime').show();
							    		   Ext.getCmp('taskPlanBeginCommitTime').setValue(taskPlanBeginCommitTimeValueTemp);
							    		   Ext.getCmp('taskPlanEndCommitTime').show();
							    		   Ext.getCmp('taskPlanEndCommitTime').setValue(taskPlanEndCommitTimeValueTemp);
							    		   Ext.getCmp('contentsTypeCombox').setValue('');
							    		   Ext.getCmp('contentsTypeCombox').hide();
							    	   }else if(newValue==2){//内容类型
							    		   Ext.getCmp('testPlanForm').setHeight(297);
							    		   Ext.getCmp('tabPanel').show();
							    		   Ext.getCmp('contentsTypeCombox').show();
							    		   Ext.getCmp('contentsTypeCombox').setValue('');
							    		   Ext.getCmp('taskPlanBeginCommitTime').setValue('');
							    		   Ext.getCmp('taskPlanEndCommitTime').setValue('');
							    		   Ext.getCmp('taskPlanBeginCommitTime').hide();
							    		   Ext.getCmp('taskPlanEndCommitTime').hide();
							    	   }
							       },
							       hide:function( component, eOpts ){
							    	   hideSubTaskForm();
						    		   Ext.getCmp('tabPanel').hide();
						    		   Ext.getCmp('testPlanForm').setHeight(400);
							       }
	                           
							   }
	                       }
                        ]
                    }, {////////////////////////////////////////////第三行(需求必填字段)
                        xtype: 'fieldcontainer',
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textfield',
                        items: [
                        	{
                                width: 250,
                                xtype: 'datefield',
                                labelAlign: 'right',
                                hidden:true,
                                name: 'provincialReqDevEndTime',
                                id: 'provincialReqDevEndTime',
                                format: 'Y-m-d',
                                fieldLabel: '<font style="color: red; font-weight:bold;">*</font>省公司要求开发完成日期',
                                listeners:{
                                	select:function(field,value, eOpts ){
                                		if(!changeTaskTagFlag){
                                			Ext.Msg.alert("提示","必须填写集团联调需求单编号,并校验通过!");field.setValue('') ;
                                		}
                                	}
                                }
                            },{
                                width: 250,
                                xtype: 'datefield',
                                labelAlign: 'right',
                                name: 'groupReqDevEndTime',
                                id: 'groupReqDevEndTime',
                                format: 'Y-m-d',
                                hidden:true,
                                fieldLabel: '<font style="color: red; font-weight:bold;">*</font>集团要求开发完成日期',
                                listeners:{
                                	select:function(field,value, eOpts ){
                                		if(!changeTaskTagFlag){
                                			Ext.Msg.alert("提示","必须填写集团联调需求单编号,并校验通过!");field.setValue('') ;
                                		}
                                	}
                                }
                            },{
                                width: 250,
                                xtype: 'datefield',
                                labelAlign: 'right',
                                name: 'jointDebugPlanBeginTime',
                                id: 'jointDebugPlanBeginTime',
                                format: 'Y-m-d',
                                hidden:true,
                                fieldLabel: '<font style="color: red; font-weight:bold;">*</font>联调计划开始日期',
                                listeners:{
                                	select:function(field,value, eOpts ){
                                		var jointDebugPlanEndTime=Ext.getCmp('testPlanForm').getForm().findField('jointDebugPlanEndTime').getValue();
                                		if(jointDebugPlanEndTime!=''&&jointDebugPlanEndTime!=null&&jointDebugPlanEndTime<value){
                                			Ext.Msg.alert("提示","联调计划开始日期必须早于联调计划结束日期");field.setValue('') ;
                                		}
                                		if(!changeTaskTagFlag){
                                			Ext.Msg.alert("提示","必须填写集团联调需求单编号,并校验通过!");field.setValue('') ;
                                		}
                                	}
                                }
                            },{
                                width: 250,
                                xtype: 'datefield',
                                labelAlign: 'right',
                                name: 'jointDebugPlanEndTime',
                                format: 'Y-m-d',
                                id: 'jointDebugPlanEndTime',
                                hidden:true,
                                fieldLabel: '<font style="color: red; font-weight:bold;">*</font>联调计划结束日期',
                                listeners:{
                                	select:function(field,value, eOpts ){
                                		var jointDebugPlanBeginTime=Ext.getCmp('testPlanForm').getForm().findField('jointDebugPlanBeginTime').getValue();
                                		if(jointDebugPlanBeginTime!=''&&jointDebugPlanBeginTime!=null&&jointDebugPlanBeginTime>value){
                                			Ext.Msg.alert("提示","联调计划开始日期必须早于联调计划结束日期");field.setValue('') ;
                                		}
                                		if(!changeTaskTagFlag){
                                			Ext.Msg.alert("提示","必须填写集团联调需求单编号,并校验通过!");field.setValue('') ;
                                		}
                                	}
                                }
                            }
                        ]
                	}, {////////////////////////////////////////////第四行(任务必填字段)
                        xtype: 'fieldcontainer',
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textarea',
                        fieldDefaults: {
                            labelAlign: 'right'
                        },
                        items: [
                        	{
                                width: 250,
                                xtype: 'datefield',
                                labelAlign: 'right',
                                hidden:true,
                                name: 'reqPlanAccomplishTime',
                                id: 'reqPlanAccomplishTime',
                                format: 'Y-m-d',
                                fieldLabel: '<font style="color: red; font-weight:bold;">*</font>需求计划完成日期',
                                listeners:{
                                	select:function(field,value, eOpts ){
                                		if(!changeTaskTagFlag){
                                			Ext.Msg.alert("提示","必须填写集团联调任务单编号,并校验通过!");field.setValue('') ;
                                		}
                                	}
                                }
                            }
                        ]
                    }, {////////////////////////////////////////////第五行(子任务时间类型必填字段)
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
                                width: 250,
                                xtype: 'datefield',
                                labelAlign: 'right',
                                name: 'taskPlanBeginCommitTime',
                                id: 'taskPlanBeginCommitTime',
                                format: 'Y-m-d',
                                hidden:true,
                                fieldLabel: '<font style="color: red; font-weight:bold;">*</font>任务计划开始提交日期',
                                listeners:{
                                	select:function(field,value, eOpts ){
                                		var taskPlanEndCommitTime=Ext.getCmp('testPlanForm').getForm().findField('taskPlanEndCommitTime').getValue();
                                		if(taskPlanEndCommitTime!=''&&taskPlanEndCommitTime!=null&&taskPlanEndCommitTime<value){
                                			Ext.Msg.alert("提示","任务计划开始提交日期必须早于任务计划结束提交日期");field.setValue('') ;
                                		}
                                		if(!changeTaskTagFlag){
                                			Ext.Msg.alert("提示","必须填写集团联调子任务单编号,并校验通过!");field.setValue('') ;
                                		}
                                	}
                                }
                            },{
                                width: 250,
                                xtype: 'datefield',
                                labelAlign: 'right',
                                name: 'taskPlanEndCommitTime',
                                format: 'Y-m-d',
                                id: 'taskPlanEndCommitTime',
                                hidden:true,
                                fieldLabel: '<font style="color: red; font-weight:bold;">*</font>任务计划结束提交日期',
                                listeners:{
                                	select:function(field,value, eOpts ){
                                		var taskPlanBeginCommitTime=Ext.getCmp('testPlanForm').getForm().findField('taskPlanBeginCommitTime').getValue();
                                		if(taskPlanBeginCommitTime!=''&&taskPlanBeginCommitTime!=null&&taskPlanBeginCommitTime>value){
                                			Ext.Msg.alert("提示","任务计划开始提交日期必须早于任务计划结束提交日期");field.setValue('') ;
                                		}
                                		if(!changeTaskTagFlag){
                                			Ext.Msg.alert("提示","必须填写集团联调子任务单编号,并校验通过!");field.setValue('') ;
                                		}
                                	}
                                }
                            }
                        ]
                    }, {//////////////////////////////////////////////////////第六行(子任务内容类型必填字段)
                        xtype: 'fieldcontainer',
                        labelStyle: 'font-weight:bold;padding:0',
                        layout: 'hbox',
                        defaultType: 'textarea',
                        fieldDefaults: {
                        	labelAlign: 'right'
                        },
                        items: [
                        	{
	                           xtype: "combo",
						       width: 250,
							   forceSelection:true,
						       typeAhead:true,
	        				   labelAlign: 'right',
	                           id: "contentsTypeCombox",
	                           store: contentsTypeStore,
	                           name: "contentsType",
	                           fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>集团联调变更内容类型",
	                           hidden:true,
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
							    	   if(!changeTaskTagFlag&&newValue!=null){//首先必须校验通过子任务编号
											Ext.Msg.alert("提示","请先填写集团联调子任务编号,并通过校验才可以选择变更类型");
											Ext.getCmp('changeTaskTag').setValue('');
											Ext.getCmp('changeTaskTag').focus();
											combo.setValue('');
											return;
							    	   }else if(newValue==1){//内容类型
							    		   
							    	   }else if(newValue==2){//报文类型
							    		   
							    	   }else if(newValue==3){//状态类型
							    		   
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
                                height: 180,
                                labelAlign: 'right',
                                name: 'remarks',
                                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>备注说明",
                                allowBlank: false
                            }
                        ]
                    }
                ]

            });
            
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
                    url: "<%=request.getContextPath()%>/getGroupCaseListByChangeId.do",
                    reader: {
                        root: "data",
                        type: "json"
                    }
                }
            });
            var taskGrid = Ext.create('Ext.grid.Panel', {
                id: 'taskGrid',
                cls: 'ui-formPanel',
                title: '已经变更的用例列表',
                margins: '0 0 0 0',
                height: 180,
                width: screenWidth,
                tbar: [ 
               		{
                        xtype: 'button',
                        text: '添加变更的用例',
                        handler: function () {
                        	var changeId = Ext.getCmp("changeId").getValue();
                        	if(changeId==""||changeId==null){
                    			Ext.Msg.alert("提示","请先保存变更单,再选择集团用例.");
                    			return;
                        	}
                        	choiceGroupCaseWin = new top.Ext.window.Window({
            			 		id:'choiceGroupCaseWin',
            				    title: '集团用例列表',
            	                width: 1050,
            				    height : 408,
            	                modal: true,
            	                listeners: {
            	                    destroy: function (window, eOpts) {
            	                    	groupCaseStore = Ext.data.StoreManager.lookup("groupCaseStore");
            	                    	console.log(Ext.getCmp("changeId").getValue());
            	                    	groupCaseStore.on('beforeload',function(){
            	                    		Ext.apply(       
            	                    				groupCaseStore.proxy.extraParams, {
            	                    					changeId: Ext.getCmp("changeId").getValue()  
            	                    				}      
            	                    			);      
            	                    	});
            	                    	groupCaseStore.load();
            	                    }
            	                },
            	                closeAction: 'destroy',
            	                html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/groupJointDebug/changeCaseR.jsp?subTaskTag='+Ext.getCmp("changeTaskTag").getValue()+'&changeId='+Ext.getCmp("changeId").getValue()+'" width="1050" height="406"/>'
            	            }).show();
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
            
            var tabPanel = Ext.create("Ext.tab.Panel", {
                frame: true,
                hidden:true,
           		border: 0,
                width: screenWidth,
                height:205,
                id: 'tabPanel',
                activeTab: 0, // 默认激活第1个tab页
                renderTo: Ext.getBody(),
                items: [
                	taskGrid
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
                        items: [testPlanForm,tabPanel]
                    }
                ]
            });
        });
        //显示需求字段
		var showReqForm =  function(){
			changeTaskTagFlag = false;
    	   	Ext.getCmp('groupReqDevEndTime').show();
		   	Ext.getCmp('provincialReqDevEndTime').show();
		   	Ext.getCmp('jointDebugPlanBeginTime').show();
		   	Ext.getCmp('jointDebugPlanEndTime').show();
       	} 
        //隐藏需求字段
       	var hideReqForm =  function(){
			changeTaskTagFlag = false;
       		Ext.getCmp('groupReqDevEndTime').hide();
       		Ext.getCmp('groupReqDevEndTime').setValue('');
			Ext.getCmp('provincialReqDevEndTime').hide();
			Ext.getCmp('provincialReqDevEndTime').setValue('');
			Ext.getCmp('jointDebugPlanBeginTime').hide();
			Ext.getCmp('jointDebugPlanBeginTime').setValue('');
			Ext.getCmp('jointDebugPlanEndTime').hide();
			Ext.getCmp('jointDebugPlanEndTime').setValue('');
       	}
        //所有字段置空
        var allSetValueToEmpty = function(){
 		   Ext.getCmp('taskPlanBeginCommitTime').setValue('');
 		   Ext.getCmp('taskPlanEndCommitTime').setValue('');
		   Ext.getCmp('changeTypeCombox').setValue('');
 		   Ext.getCmp('groupReqDevEndTime').setValue('');
 		   Ext.getCmp('provincialReqDevEndTime').setValue('');
 		   Ext.getCmp('jointDebugPlanBeginTime').setValue('');
 		   Ext.getCmp('jointDebugPlanEndTime').setValue('');
 		   Ext.getCmp('reqPlanAccomplishTime').setValue('');
        }
        //隐藏所有的子任务的字段
        var hideSubTaskForm = function(){
 		   Ext.getCmp('taskPlanBeginCommitTime').hide();
 		   Ext.getCmp('taskPlanEndCommitTime').hide();
 		   Ext.getCmp('contentsTypeCombox').hide();
        }
    </script>
</html>