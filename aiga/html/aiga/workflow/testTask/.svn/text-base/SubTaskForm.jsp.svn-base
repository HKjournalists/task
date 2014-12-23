<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ include file="/aiga/common/common.jsp" %>
<%
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String taskId = request.getParameter("taskId");
	String subTaskId = request.getParameter("subTaskId");
	if(taskId == null || "".equals(taskId)) {
		taskId = "0";
	}
	if(subTaskId == null || "".equals(subTaskId)) {
		subTaskId = "0";
	}
	String flag=request.getParameter("flag");
%>

<html>
  <head>
    <title>测试任务分解</title>
  </head>
  <body>
  	<jsp:include page="/aiga/workflow/common/SelectStaff.jsp"></jsp:include>
  </body>
  <script type="text/javascript">
  //选人窗口回调函数
  var selectFlag="";
  var afterSelect = function (staffs, option) {
	  var id,name;
	  if(selectFlag=='creator'){
		  id='creator';
		  name='creatorStaff';
	  }else if(selectFlag=='testor'){
		  id='testorId';
		  name='testorName';
	  }
      var distributeStaffid = Ext.getCmp(id);
      distributeStaffid.setValue(staffs.staffId);
      var distributeStaffname = Ext.getCmp(name);
      distributeStaffname.setValue(staffs.employeeName);
  }
  var dateFormat = Ext.Date.format(new Date, 'YmdHisu');
  var subTaskTag = 'ST' + dateFormat;
  	Ext.onReady(function(){
        Ext.QuickTips.init();
        Ext.tip.QuickTipManager.init();
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
            name: 'subTaskPriority',
            fieldLabel: '子任务优先级',
            valueField: 'value',
            displayField: 'show'
        });
        var workflowParamStore = new Ext.data.Store({
            id: 'workflowParamStore',
            fields: ['phaseId', 'phaseName', 'linkId', 'vmTaskName'],
            proxy: {
                type: 'ajax',
                url: '<%=request.getContextPath()%>/getWorkflowParam.do',
                reader: {
                    type: 'json',
                    root: 'data'
                }
            },
            listeners:{
            	load:function( store, records, successful, eOpts ){
            		try{
            		
            			var data=store.getAt(0).data;
            			var subTaskStatusCombox=Ext.getCmp("subTaskStatusCombox");
                		var curPhaseCombox=Ext.getCmp("curPhaseCombox");
                		subTaskStatusCombox.setValue(data.linkId);
                		<%if(flag!=null&&flag.equals("0")){%>
                		curPhaseCombox.setValue(data.phaseId);
                		<%}%>
                		curPhaseCombox.setReadOnly(true);
                		subTaskStatusCombox.setReadOnly(true);
            		}catch(e){
            			Ext.Msg.alert("错误信息",e.message);
            		}
            		
            	}
            }
        });
        var subTaskStatusCombox = new Ext.form.ComboBox({
            width: 250,
            id:'subTaskStatusCombox',
            store: workflowParamStore,
            name: 'subTaskStatus',
            fieldLabel: '任务状态',
            valueField: 'linkId',
            displayField: 'vmTaskName',
            listeners: {change:function(Field, newValue, oldValue, eOpts){
            }}
        });

        var curPhaseCombox = new Ext.form.ComboBox({
            width: 250,
            id:'curPhaseCombox',
            store: workflowParamStore,
            name: 'curPhase',
            fieldLabel: '任务所处阶段',
            valueField: 'phaseId',
            displayField: 'phaseName',
            listeners: {}
        });
        var booleanStore= new Ext.create('Ext.data.Store',{
        	fields:['value','text'],
	        data:[
	            	{'value':0,'text':'是'},
	            	{'value':1,'text':'否'}
	            ]
			});
    	var sysContentModel= Ext.define('sysContentModel', {
    	    extend: 'Ext.data.Model',
    	    fields: [
    	        {name: 'constantId',  type: 'string'},
    	        {name: 'categoryName', type: 'string'},
    	        {name: 'category', type: 'string'},
    	        {name: 'show', type: 'string'},
    	        {name: 'value', type: 'string'},
    	        {name: 'other1', type: 'string'},
    	        {name: 'other2', type: 'string'},
    	        {name: 'memo', type: 'string'}
    	    ]
    	});
    	var sysContentStore=new  Ext.data.Store({
    		id: 'sysContentStore',
    		model: sysContentModel,
    		proxy: {
    			type: 'ajax',
    			url: '<%=request.getContextPath()%>/getSysConstantStore.do',
    			reader: {
    				type: 'json',
    				root: 'data'
    			}
    		},
    		listeners:{
    			beforeload:function( store, operation,  eOpts ){
    			},
    			load:function( store, records, successful, eOpts ){
    					//在新建子任务时候自动过滤  "性能测试子任务"
    				<%if(flag!=null && flag.equals("0")){%>
    				if(successful==true){
    					store.filter("memo", "0");
    				}
    				<%}%>
    			}
    		}
    	});
    	sysContentStore.load({params:{category:'SUB_TASK_TYPE'}});
        var subTaskTypeCombox = new Ext.form.ComboBox({
            width: 250,
            store: sysContentStore,
            name: 'subTaskType',
            fieldLabel: '子任务类型',
            valueField: 'value',
            displayField: 'show',
            listeners:{
            	  beforequery: function (queryEvent, eOpts) {
            		 queryEvent.combo.getStore().proxy.url+='?category=SUB_TASK_TYPE';
                  },
                  select:function( combo,records,eOpts ){
                	  workflowParamStore.proxy.url='<%=request.getContextPath()%>/getWorkflowParam.do?query='+records[0].data.other2;
                	  workflowParamStore.load();
                  }
            }
        });
		var subTaskForm = new Ext.form.Panel({
  			id: 'subTaskForm',
  			title: '子任务信息&nbsp;&nbsp;('+subTaskTag+')',
  			renderTo: Ext.getBody(),
  			cls: 'ui-formPanel',
  			bodyBorder: 0,
  			defaults: {margins: '5 0 0 0'},
  			layout: 'vbox',
  			tbar: [
	<%if(flag==null||!flag.equals("1")){%>
  				{
	  				id:'addSubmit',
	  				text:'提交保存',
	  				handler:function() {
  						MaskLoading();
	  					subTaskForm.submit({
                            clientValidation: true,
                            url: '<%=request.getContextPath()%>/saveSubTaskInfo.do',
                            params: {},
                            method: 'POST',
                            success: function (response, config) {
	  					MaskOver();
                                var success = config.result.success;
                                if (success) {
                                	Ext.Msg.alert("提示",'保存成功!');
									setTimeout("window.parent.Ext.getCmp('subTaskWin').close();",500);
                                }
                            },
                            failure: function (response, config) {
	  					MaskOver();
								Ext.Msg.alert("提示",'数据修改失败!');
								setTimeout("window.parent.Ext.getCmp('subTaskWin').close();",500);
                            }
                        });
	  				}
  				}
  				<%}%>
  			],
  			items:[
					{
					    xtype: 'fieldcontainer',
							layout: 'hbox',
							fieldDefaults: { 
					        labelAlign: 'right',
					        labelWidth: 100,
					        width: 1000
					    },
							items:[
								{xtype:'textfield',fieldLabel:'子任务名称',name:'subTaskName'},
								   //隐藏
								{xtype:'hidden',fieldLabel:'',name:'subTaskId'},
								{xtype:'hidden',fieldLabel:'',name:'subTaskTag',value: subTaskTag},
								{xtype:'hidden',fieldLabel:'',name:'taskId',value:'<%=taskId%>'},
								{xtype:'hidden',fieldLabel:'',name:'reqId'},
		  						{xtype:'hidden',fieldLabel:'实际完成时间',name:'factCompleteTime'},
		  						{xtype:'hidden',fieldLabel:'子任务提交人ID',name:'submitStaffId',value:'<%=user.getUserId()%>'},
		  						{xtype:'hidden',fieldLabel:'子任务提交人',name:'submitStaffName',value:'<%=user.getUserName()%>'}
							]
						},
		  				{
			                xtype: 'fieldcontainer',
		  					layout: 'hbox',
		  					fieldDefaults: { 
			                    labelAlign: 'right',
			                    labelWidth: 100,
			                    width: 250
			                },
		  					items:[
		  					 	subTaskTypeCombox,
		  						{xtype:'textfield',fieldLabel:'需求编号',name:'reqTag'},
		  						curPhaseCombox,
		  						subTaskStatusCombox
		  					]
		  				},
		  				{
			                xtype: 'fieldcontainer',
		  					layout: 'hbox',
		  					fieldDefaults: { 
			                    labelAlign: 'right',
			                    labelWidth: 100,
			                    width: 250
			                },
		  					items:[
								priorityCombox,
		  						{xtype:'datefield',fieldLabel:'创建时间',name:'createTime'},
								{width: 212,xtype:'textfield',fieldLabel:'子任务派发人',name:'creatorStaff',id:'creatorStaff'},
								{width: 0,xtype:'hidden',fieldLabel:'子任务派发人Id',name:'creator',id:'creator'},
								{xtype: 'button',text: '选择',handler: function () {selectFlag='creator';SelectStaff.showWin('WF_TEST_CHD', '<%=user.getUserId()%>', -1, -1, 2, false,2,0);}},
								{width: 0,xtype:'hidden',fieldLabel:'测试人员Id',name:'testorId',id:'testorId'},
								{width: 212,xtype:'textfield',fieldLabel:'测试人员',name:'testorName',id:'testorName'},
								{xtype: 'button',text: '选择',handler: function () {selectFlag='testor';SelectStaff.showWin('WF_TEST_PFR', '<%=user.getUserId()%>', -1, -1, 2, false,2,0);}}
		  					]
		  				},
		  				{
			                xtype: 'fieldcontainer',
		  					layout: 'hbox',
		  					fieldDefaults: { 
			                    labelAlign: 'right',
			                    labelWidth: 100,
			                    width: 250
			                },
		  					items:[
								{xtype:'combo',name: 'isPerformance',fieldLabel: '是否性能测试',store:booleanStore,displayField:'text',valueField:'value'},
								{xtype:'combo',name: 'possibleProduct',fieldLabel: '生产环境可测性',store:booleanStore,displayField:'text',valueField:'value'},
								{xtype:'combo',name: 'possibleBack',   fieldLabel: '准发布可测性',store:booleanStore,displayField:'text',valueField:'value'},
								{xtype:'combo',name: 'possibleTest',   fieldLabel: '测试环境可测性',store:booleanStore,displayField:'text',valueField:'value'}
		  					]
		  				},
		  				{
			                xtype: 'fieldcontainer',
		  					layout: 'hbox',
		  					fieldDefaults: { 
			                    labelAlign: 'right',
			                    labelWidth: 100,
			                    width: 250
			                },
		  					items:[
		  					 	{xtype:'textfield',fieldLabel:'开发任务工时',name:'devWorkDay'},
		  						{xtype:'textfield',fieldLabel:'测试任务工时',name:'testWorkDay',
		  					 		listeners: {
                                    focus: function (comp, The, eOpts) {
                                        var devWorkDay = Ext.getCmp('subTaskForm').getForm().findField('devWorkDay');
                                        if (devWorkDay.value != undefined && (comp.value == undefined) || comp.value == '')
                                            comp.setValue(devWorkDay.value / 2);
                                    }
                                }},
		  						{xtype:'datefield',fieldLabel:'计划完成时间',name:'plCompleteTime'}
		  						]
		  				},
		  				{
			                xtype: 'fieldcontainer',
		  					layout: 'hbox',
		  					fieldDefaults: { 
			                    labelAlign: 'right',
			                    labelWidth: 100,
			                    width: 1000,
			                    height:50
			                },
		  					items:[
		  						{xtype:'textarea',fieldLabel:'生产不可测原因',name:'possibleProductReason'}
		  					]
		  				},
		  				{
			                xtype: 'fieldcontainer',
		  					layout: 'hbox',
		  					fieldDefaults: { 
			                    labelAlign: 'right',
			                    labelWidth: 100,
			                    width: 1000,
			                    height:50
			                },
		  					items:[
		  						{xtype:'textarea',fieldLabel:'准发布不可测原因',name:'possibleBackReason'}
		  					]
		  				},
		  				{
			                xtype: 'fieldcontainer',
		  					layout: 'hbox',
		  					fieldDefaults: { 
			                    labelAlign: 'right',
			                    labelWidth: 100,
			                    width: 1000,
			                    height:50
			                },
		  					items:[
		  						{xtype:'textarea',fieldLabel:'测试不可测原因',name:'possibleTestReason'}
		  					]
		  				}
  			]
  		});
		<%if(flag!=null&&flag.equals("1")){%>
        var tabPanel = Ext.create("Ext.tab.Panel", {
            title: "Ext.tab.Panel示例",
            frame: true,
            width: screenWidth * 0.98,
            height: screenHeight * 0.4,
            id: 'tabPanel',
        	cls: 'ui-formPanel',
            activeTab: 0, // 默认激活第1个tab页
           	renderTo: Ext.getBody(),
            items: [
                    {
                        title: "历史轨迹",
                        html: '<iframe id="f_1" scrolling="auto" frameborder="0" width="100%" height="100%" src="<%=request.getContextPath()%>/aiga/workflow/common/HistoryTrack.jsp?objId=${param.objId}&objType=${param.objType}"></iframe>'
                    },
                    {
                        title: "附件列表",
                        html: "tab标签页3内容"
                    }
            ]
        });
		var fieldAry = subTaskForm.getForm().getFields();
		for(var i = 0; i < fieldAry.length; i++) {
  			fieldAry.get(i).setReadOnly(true);
  		}
        <%}%>
  	<%if(!subTaskId.equals("0")) {%>
  		Ext.getCmp('subTaskForm').getForm().load({
  			url:'<%=request.getContextPath()%>/getTestSubTaskById.do',
  			params:{subTaskId:'<%=subTaskId%>'},
  			success: function(form, action) {
  				//console.log(action.result.data.subTaskTag);
  				Ext.getCmp('subTaskForm').setTitle("子任务信息 &nbsp;&nbsp;("+action.result.data.subTaskTag+")");
  				workflowParamStore.proxy.url='<%=request.getContextPath()%>/getWorkflowParam.do?query='+action.result.templateId;
  				workflowParamStore.load();
			}
  		});
  	<%}%>
  	});
  </script>

</html>
