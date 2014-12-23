<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.sysConstant.bo.SysConstant"%>
<%@page import="com.asiainfo.aiga.sysConstant.util.SysContentUtil"%>
<%@page import="com.asiainfo.aiga.common.WorkflowParam"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>版本测试任务表单</title>
</head>
<body>
	<div id="solidTaskPanel"></div>
	<%
	String taskId=request.getParameter("taskId");
	String taskTypeName=request.getParameter("taskTypeName");
	String templateId=request.getParameter("templateId");
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
	taskTypeName=java.net.URLDecoder.decode(java.net.URLDecoder.decode(taskTypeName, "utf-8"), "utf-8");
	SysConstant[] sysConstants=SysContentUtil.getSysContant("SOLID_TASK_TYPE");
	if(sysConstants!=null&&sysConstants.length!=0){
		for(SysConstant sys:sysConstants){
			if(sys.getOther2().equals(templateId)){
				taskTypeName=sys.getShow();
				System.out.println(taskTypeName);
			}
		}
	}
	%>
	<jsp:include page="/aiga/common/common.jsp"></jsp:include>
	<div id="fileTrans" style="display:none;"><jsp:include page="/aiga/attach/fileTrans.jsp"></jsp:include></div>
	<jsp:include page="/aiga/workflow/common/SelectStaff.jsp"></jsp:include>
	<script type="text/javascript" src="<%=request.getContextPath()%>/extJs/ext.bug.fix.js" ></script>
</body>
<script type="text/javascript">
var extjsFolderPath='<%=request.getContextPath()%>/extJs';
var screenWidth = document.documentElement.clientWidth;
var screenHeight = 350;
var taskId="${param.taskId}";
var templateId="${param.templateId}";
var taskTypeName='${param.taskTypeName}';
/*****右击*******/
function rightClickTargetFn(view,record,item,index,e,eOpts){   
	 	e.preventDefault();   
		rightTargetReportMenu.showAt(e.getXY());
	}
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.tip.QuickTipManager.init();
	var dateFormat= Ext.Date.format(new Date, 'YmdHisu');
	var taskTagTitle="版本测试任务单【<%=taskTypeName%>】";
	var bigTypeStore=new Ext.data.Store({
		id: 'bigTypeStore',
		fields: ['value','show'],
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
		store: bigTypeStore ,
		name:"bigType",
		fieldLabel : "系统大类",
		valueField: 'value',
		displayField: 'show',
		 listeners:{
			 beforequery:function( queryEvent,eOpts ){
				queryEvent.query="bigTypeStore";
			 }
         }
		});
	var onLineTypeStore=new Ext.data.Store({
		id: 'planTypeStore',
		fields: ['value','show'],
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
		store: onLineTypeStore ,
		name:'onLineType',
		fieldLabel : "上线类型",
		valueField: 'value',
		displayField: 'show',
		 listeners:{
			 beforequery:function( queryEvent,eOpts ){
					queryEvent.query="onLineTypeStore";
				 }
         }
		});
		var workflowParamStore=new  Ext.data.Store({
		id: 'workflowParamStore',
		fields: ['linkId','phaseId','phaseName','vmTaskName'],
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getWorkflowParam.do?query='+templateId,
			reader: {
				type: 'json',
				root: 'data'
			}
		},
         listeners:{
         	load:function(store,records,successful,opts){
         		store.add({phaseId:'',phaseName:'',linkId:-1,vmTaskName:'已关闭'});
         	}
         }
	});
		workflowParamStore.load();
	var taskStatusCombox = new Ext.form.ComboBox({
		width: 250,
		store: workflowParamStore,
		labelAlign: 'right', 
		name:'taskStatus',
		fieldLabel : "任务单状态",
		valueField: 'linkId',
		displayField: 'vmTaskName',
		 listeners:{
         }
		});

	var taskPhaseCombox = new Ext.form.ComboBox({
		width: 250,
		labelAlign: 'right', 
		store: workflowParamStore,
		name:'taskPhase',
		fieldLabel : "任务阶段",
		valueField: 'phaseId',
		displayField: 'phaseName',
		 listeners:{
         }
		});
	var solidTaskForm = Ext.widget('form', {
		id:'solidTaskForm',
		minWidth: 1000,
		width:screenWidth*0.98,
		height:'100%',
		title:''+taskTagTitle, 
		listeners:{
			render : function(render,eOpts){
				solidTaskForm.load({
					params:{taskId :taskId},
					url:'<%=request.getContextPath()%>/getSolidTaskForm.do',
					method:'POST',  
					success:function(form,action){
						var fields = solidTaskForm.getForm().getFields().items;
						for(var i=0,n=fields.length;i<n;i++){
							fields[i].setReadOnly(true);							
						}
					},  
					failure:function(form,action){  
						Ext.Msg.alert('提示',"失败原因是: "+action.result.errorMessage);  
					}
				});
			}
		},
		layout: {
			type: 'vbox'
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
				{ 
				xtype: 'fieldcontainer', 
			    labelStyle: 'font-weight:bold;padding:0', 
			    layout: 'hbox', 
			    defaultType: 'textfield', 
			    items: [{
					width:1000,
					labelAlign: 'right', 
					name: 'planName',
					fieldLabel: '测试计划名称'
				},{
			  		xtype:'hidden', 
					name: 'planId',
					fieldLabel: '测试计划id',
					hidden:true
				}
			     ]},
			     { 
						xtype: 'fieldcontainer', 
					    labelStyle: 'font-weight:bold;padding:0', 
					    layout: 'hbox', 
					    defaultType: 'textfield', 
					    items: [
					            /**{
							width:250,
							labelAlign: 'right', 
							name: 'planStatus',
							fieldLabel: '测试计划所处环节'
							
						},**/
						//taskPhaseCombox,
						taskStatusCombox,
						{
							width:250,
							labelAlign: 'right', 
							name: 'submitStaffName',
							fieldLabel: '计划提交人'
							
						},
						{
							xtype:'hidden',
							labelAlign: 'right', 
							name: 'submitStaffId'
						},{
				width:250,
		        xtype: 'datefield', 
		        name: 'codeCommitDate',
		        format: 'Y-m-d',
				labelAlign: 'right',
	    		fieldLabel : "代码截止提交日"
	    },{
				width:250,
		        xtype: 'datefield', 
		        name: 'factCompleteTime',
		        format: 'Y-m-d',
				labelAlign: 'right',
			fieldLabel: '计划上线时间'
			},{
							width:250,
							labelAlign: 'right', 
					        xtype: 'datefield', 
					        name: 'createTime',
						fieldLabel: '创建时间',
						hidden:true
						
						}
					     ]},
		        { 
			xtype: 'fieldcontainer', 
		    labelStyle: 'font-weight:bold;padding:0', 
		    layout: 'hbox', 
		    defaultType: 'textfield', 
		    items: [

			{
				width:250,
				labelAlign: 'right', 
				name: 'planTag',
				id:"planTag",
				fieldLabel: '测试计划编号',
				renderer:function(value, cellmeta, record){
				},
				hidden:true
			},
			/**		
			{		
					width:250,
			        xtype: 'datefield', 
			        name: 'createTime',
				fieldLabel: '测试计划创建时间'
				
			},
			**/
			
			{
					width:250,
			        xtype: 'datefield', 
			        name: 'beginTime',
				fieldLabel: "测试计划开始时间",
				hidden:true
			}] 
		 },{
     		xtype: 'fieldcontainer',
            labelStyle: 'font-weight:bold;padding:0',
            layout: 'hbox',
            defaultType: 'textfield',
            fieldDefaults: {
                labelAlign: 'right'
            },
			items:[
			bigTypeCombox,
			onLineTypeCombox,{
				width:250,
				labelAlign: 'right', 
				name: 'versionContent',
				fieldLabel: '测试可用工时'
				
			},{
				width:250,
		        xtype: 'datefield', 
		        name: 'reqTime',
		        format: 'Y-m-d',
				fieldLabel: '需求定稿时间'
			}]
		},{
				xtype: 'fieldcontainer',
		        labelStyle: 'font-weight:bold;padding:0',
		        layout: 'hbox',
		        defaultType: 'textfield',
		        fieldDefaults: {
		            labelAlign: 'left'
		        },
				items:[]
		}, { 
			xtype: 'fieldcontainer', 
		    labelStyle: 'font-weight:bold;padding:0', 
		    layout: 'hbox', 
		    defaultType: 'textarea', 
		        fieldDefaults: {
            labelAlign: 'right'
        },
		    items: [{
		    	width:1000,
		    	height:50,
				labelAlign: 'right', 
				name: 'planDscr',
				fieldLabel: '计划描述'
			}] 
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
			    	width:1000,
			    	height:50,
					labelAlign: 'right', 
					name: 'changeReason',
					fieldLabel: '变更原因',
				hidden:true
				}] 
			 }]
	});
	
		var mapModel= Ext.define('mapModel', {
	    extend: 'Ext.data.Model',
	    fields: [
	        {name: 'constantId',  type: 'string'},
	        {name: 'categoryName', type: 'string'},
	        {name: 'category', type: 'string'},
	        {name: 'show', type: 'string'},
	        {name: 'value', type: 'int'},
	        {name: 'other1', type: 'string'},
	        {name: 'other2', type: 'string'},
	        {name: 'memo', type: 'string'}
	    ]
	});
	var mapStore=new  Ext.data.Store({
		autoLoad: true,
		id: 'mapStore',
		model:mapModel,
		groupField: 'categoryName',
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getComBoxMap.do',
			reader: {
				type: 'json',
				root: 'data'
			}
		}
	});
	mapStore.load();
		var bigTypeStore=new  Ext.data.Store({
			autoLoad: true,
			id: 'bigTypeStore',
			fields: ['value','show'],
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
	
        var tabPanel = Ext.create("Ext.tab.Panel", {
            frame: true,
            cls: 'ui-formPanel',
            width: screenWidth * 0.98,
            height: screenHeight * 0.8,
            id: 'tabPanel',
            activeTab: 0, // 默认激活第1个tab页
            renderTo: Ext.getBody(),
            items: [ 
					{
					    title: "测试信息",
					    html: '<iframe id="f_0" name="f_0" scrolling="no" frameborder="0" width="100%" height="250" src="<%=request.getContextPath()%>/aiga/workflow/common/solidTypeTab.jsp?objId=${param.objId}&objType=${param.objType}&isEditor=false"></iframe>'
					},
                    {
                        title: "历史轨迹",
                        html: '<iframe id="f_1" scrolling="no" frameborder="0" width="100%" height="250" src="<%=request.getContextPath()%>/aiga/workflow/common/HistoryTrack.jsp?objId=${param.objId}&objType=${param.objType}"></iframe>'
                    }, {
                        title: "附件列表",
                        contentEl:'fileTrans',
                        listeners:{
                        	beforeshow:function(tab,eOpts){
                        		$('#fileTrans').show();
                        		var current_linkNo=taskStatusCombox.getValue( );
                        		initPackList(Ext.getCmp('solidTaskForm').getForm().findField('planTag').getValue(), '1', current_linkNo,'0','0',false);
                        	}
                        }
                    }
            ]
        });
	Ext.create('Ext.Panel', {
		renderTo: Ext.get('solidTaskPanel'),
        cls: 'ui-formPanel',
		width: screenWidth,
		height: screenHeight*0.6,
		
		minWidth: 1000,
		minHeight: 200,
		layout: {
			margin:'0 0 0 0 ',
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
			items:[solidTaskForm]
		}]
    });
});
</script>
</html>