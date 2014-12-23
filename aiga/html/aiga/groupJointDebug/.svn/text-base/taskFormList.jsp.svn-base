<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/aiga/common/common.jsp" %>
<%
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
	boolean isFlag = true;
	String flag = "1";
%>
<html>
    
<head>
	<title>集团联调任务单列表</title>
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
	</style>
</head>

<body>
  	<img id="loading" src="<%=request.getContextPath()%>/aiga/workflow/testTask/ajaxFileUpload/loading.gif" style="display:none;">
		<form name="form" action="" method="POST" enctype="multipart/form-data">
		<div id='uploadTestTaskDiv'></div>
		</form>
		<form style="display:none;" id="exportForm" action="<%=request.getContextPath()%>/downloadTemplateExcel.do?templateFileName=funFolder.xls"
			enctype="multipart/form-data" method="post" target="temp">
			<input type="hidden" name="method" value="export" />
			<input type="submit" id="download" class="tmpBtn" value="下载" />
		</form>
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
function ajaxFileUpload(){
	MaskLoading();
	url="<%=request.getContextPath()%>/uploadFunFolderExcel.do";
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
						Ext.Msg.alert("提示","导入成功！");
					}else{
						Ext.Msg.alert("错误提示",data.msg);
					}
			},
			error: function (data, status, e)
			{	
				MaskOver();
			    Ext.Msg.alert("错误提示",data.msg);
			}
		}
	)
	return false;
}
Ext.onReady(function () {
	Ext.QuickTips.init();
    Ext.tip.QuickTipManager.init();
    var btn = new Ext.Button({
	    text: '查询',
	    width: 60,
	    margin: '0 0 0 50px',
	    handler: function() {
			Ext.StoreMgr.get('funFolderStore').loadPage(1);
		}
	});
    var qryForm = new Ext.form.FormPanel({
        id: 'qryForm',
        title: '查询区域',
        cls: 'ui-formPanel',
        defaults: {
            margins: '5 0 5 0',
        },
        renderTo: Ext.getBody(),
        width: screenWidth * 0.999,
        height: screenHeight * 0.15 * 0.99,
        layout: 'vbox',
        bodyBorder: 0,
        items: [{
            xtype: 'fieldcontainer',
            labelStyle: 'font-weight:bold;padding:0',
            fieldDefaults: {
                labelAlign: 'right',
                labelWidth: 90,
                width: 200
            },
            layout: 'hbox',
            defaultType: 'textfield',
            items: [
                    {name: 'taskName',fieldLabel: '任务单名称'},
                    {name: 'taskTag',fieldLabel: '任务单编号'},
					{
			            xtype: 'fieldcontainer',
			            labelStyle: 'font-weight:bold;padding:0',
			            fieldDefaults: {
			                labelAlign: 'right',
			                labelWidth: 90,
			                width: 200
			            },
			            layout: 'hbox',
			            defaultType: 'textfield',
			            items: [
							btn
			            ]
        			}
                ]
            }
        ]
	});
	var funFolderStore = Ext.create('Ext.data.Store', {
		storeId:'funFolderStore',
		pageSize: 20,//每页显示条数
		fields:[
	        {name:'taskId',type:'string'},//任务单ID
	 		{name:'taskTag',type:'string'},//任务单编号
	 		{name:'taskName',type:'string'},//任务单名称
	 		{name:'createTime',type:'string'},//任务单创建时间
	 		{name:'creatorId',type:'string'},//任务单创建人ID
	 		{name:'creatorName',type:'string'},//任务单创建人名字
	 		{name:'isDelete',type:'string'},//删除标示
	 		{name:'taskPlanBeginCommitTime',type:'string'},//任务计划提交开始日期
	 		{name:'taskPlanEndCommitTime',type:'string'},//任务计划提交结束日期
	 		{name:'devManagerId',type:'string'},//开发负责人ID
	 		{name:'devManagerName',type:'string'},//开发负责人名字
	 		{name:'bigType',type:'string'},//系统大类
	 		{name:'subType',type:'string'},//系统子类
	 		{name:'taskType',type:'string'},//任务类型
	 		{name:'isNeedMessage',type:'string'},//是否需要造报文
	 		{name:'messageRemarks',type:'string'},//报文原因说明
	 		{name:'reasonRemarks',type:'string'},//需求计划完成日期晚于本省要求完成日期原因说明
	 		{name:'jointDebugBeginTime',type:'string'},//联调开始日期
	 		{name:'jointDebugEndTime',type:'string'},//联调结束日期
	 		{name:'provincialReqDevEndTime',type:'string'},//省公司要求完成日期
	 		{name:'reqPlanAccomplishTime',type:'string'},//需求计划完成日期
	 		{name:'reqTag',type:'string'},//集团联调需求单编号
     		{name:'platformReqTag',type:'string'},//需求平台需求单编号
	 		{name:'jointDebugManagerId',type:'string'},//联调管理员ID
	 		{name:'jointDebugManagerName',type:'string'}//联调管理员名字
 		],
	    proxy: {
	        type: 'ajax',
        	url : '<%=request.getContextPath()%>/getJointDebugTaskFormList.do',
	        reader: {
	            root:"data",
				type:"json",
            	totalProperty:'total'
	        }
	    }
	});
	funFolderStore.on('beforeload',function(){        // =======翻页时 查询条件     
		Ext.apply(       
			funFolderStore.proxy.extraParams, {
					taskName: encodeURI(encodeURI(Ext.getCmp('qryForm').getForm().findField('taskName').getValue())),
		           	taskTag:Ext.getCmp('qryForm').getForm().findField('taskTag').getValue()  
				}      
			);      
	});
	funFolderStore.load();
	var caseCollectionGrid = new Ext.grid.Panel({
        id: 'caseCollectionGrid',
        cls: 'ui-formPanel',
        width: screenWidth * 0.999,
        height: screenHeight * 0.85,
        renderTo: Ext.getBody(),
        title: '集团联调任务单列表',
        store: funFolderStore,
        bbar: Ext.create('Ext.PagingToolbar', { 
			store: funFolderStore, 
			displayInfo: true, 
			displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
			emptyMsg: "没有数据"
		}),
        tbar:[
        	{xtype: 'button',text: '新增集团联调任务单',handler: function () {
        		var createTaskFormWin = new top.Ext.window.Window({
				 		id:'createReqFormWin',
					    title : '新增联调任务单',
					    width : screenWidth*0.8,
					    height : screenHeight,
					    modal : true,
					    autoScroll:false,
					    listeners:{
							destroy:function(window,eOpts){
								var planStore=Ext.data.StoreManager.lookup("funFolderStore");
								planStore.loadPage(1);
							},
							close:function(p,o){
								if(p.title=='测试计划执行'){
									
								}
							}
					    },
					    closeAction : 'destroy',
					    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/groupJointDebug/createTaskForm.jsp?winFlag=create" scrolling="yes"   width="100%" height="100%"/>'
					}).show();
        	}},
        	{xtype: 'button',text: '删除选中条目',handler: function () {
					
        			var deleteItems = Ext.getCmp("caseCollectionGrid").getSelectionModel().getSelection();
					if(deleteItems.length == 0){
						Ext.Msg.alert("操作提示","请选择需要删除的集团联调任务单");
						return;
					}
					Ext.MessageBox.confirm('操作提示','确定删除选中的集团联调任务单?',function(optional){
						if(optional=='yes'){
							var Ids = []; //要删除的id
		                    Ext.each(deleteItems, function (item) {
		                        Ids.push(item.data.taskId);
		                    })
		                    MaskLoading();
							Ext.Ajax.request({
								async:false,
								url:"<%=request.getContextPath()%>/deleteJointDebugTaskForms.do?taskIds="+Ids,
								success:function(response,config){
									MaskOver();
									Ext.Msg.alert('提示','删除成功');
									funFolderStore = Ext.data.StoreManager.lookup("funFolderStore");
									funFolderStore.loadPage(1);
								},
								failure:function(response,config){
									MaskOver();
									Ext.Msg.alert('操作','数据请求失败');
								}
							});
						}
					});
			}}/*,{
                xtype: 'fileuploadfield',
                id:'fileToUpload',
                fieldLabel: '批量导入功能点',
                buttonText: '选择功能文件',
                listeners:{
                    	change:function(comp,str,eOpts){
                    		if(str.endWith('xls')||str.endWith('xlsx')){
                    			Ext.getCmp("upload").setHandler(function(){ajaxFileUpload();});
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
                }*/
        ],
        listeners: {
            itemdblclick: function(grid, record, item, index, e, eOpts) {
	            var alterTaskFormWin = new top.Ext.window.Window({
			 		id:'alterTaskFormWin',
				    title : '修改集团联调任务单',
				    width : screenWidth*0.8,
				    height : screenHeight,
				    modal : true,
				    autoScroll:false,
				    listeners:{
						destroy:function(window,eOpts){
						var planStore=Ext.data.StoreManager.lookup("funFolderStore");
							planStore.loadPage(1);
						},
						close:function(p,o){
							if(p.title=='测试计划执行'){
								
							}
						}
				    },
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/groupJointDebug/createTaskForm.jsp?winFlag=alter&taskId='+record.raw.taskId+'" scrolling="yes"   width="100%" height="100%"/>'
				}).show();
            }
        },
        selModel: Ext.create("Ext.selection.CheckboxModel",{id : 'checkBoxForChoiceCount',mode:"SIMPLE"}),
        columns: [
            {xtype: 'rownumberer'},
            {header: "任务单ID",width: 100,sortable: true,dataIndex: 'taskId',hidden:true},
            {header: "编号",width: 100,sortable: true,dataIndex: 'taskTag'},
            {header: "名称",width: 100,sortable: true,dataIndex: 'taskName'},
            {header: "任务类型",width: 100,sortable: true,dataIndex: 'taskType'},
            {header: "集团联调需求单编号",width: 120,sortable: true,dataIndex: 'reqTag'},
            {header: "需求平台需求单编号",width: 120,sortable: true,dataIndex: 'platformReqTag'},
            {header: "任务计划开始日期",width: 120,sortable: true,dataIndex: 'taskPlanBeginCommitTime',renderer: function(value, cellmeta, record) {
  	        	return value.substring(0,10)+"";
  	        }},
            {header: "任务计划结束日期",width: 120,sortable: true,dataIndex: 'taskPlanEndCommitTime',renderer: function(value, cellmeta, record) {
  	        	return value.substring(0,10)+"";
  	        }},
            {header: "系统大类",width: 100,sortable: true,dataIndex: 'bigType'},
            {header: "系统子类",width: 100,sortable: true,dataIndex: 'subType'},
            {header: "开发负责人ID",width: 100,sortable: true,dataIndex: 'devManagerId',hidden:true},
            {header: "开发负责人",width: 100,sortable: true,dataIndex: 'devManagerName'},
            {header: "联调管理员ID",width: 100,sortable: true,dataIndex: 'jointDebugManagerId',hidden:true},
            {header: "联调管理员",width: 100,sortable: true,dataIndex: 'jointDebugManagerName'},
            {header: "联调开始日期",width: 100,sortable: true,dataIndex: 'jointDebugBeginTime',renderer: function(value, cellmeta, record) {
  	        	return value.substring(0,10)+"";
  	        }},
            {header: "联调结束日期",width: 100,sortable: true,dataIndex: 'jointDebugEndTime',renderer: function(value, cellmeta, record) {
  	        	return value.substring(0,10)+"";
  	        }},
            {header: "省公司要求完成日期",width: 120,sortable: true,dataIndex: 'provincialReqDevEndTime',renderer: function(value, cellmeta, record) {
  	        	return value.substring(0,10)+"";
  	        }},
            {header: "需求计划完成日期",width: 120,sortable: true,dataIndex: 'reqPlanAccomplishTime',renderer: function(value, cellmeta, record) {
  	        	return value.substring(0,10)+"";
  	        }},
            {header: "晚于要求日期原因说明",width: 200,sortable: true,dataIndex: 'reasonRemarks'},
            {header: "是否造报文",width: 100,sortable: true,dataIndex: 'isNeedMessage',renderer: function(value, cellmeta, record) {if(value==1||value=='on')return "是";else return "否"; }},
            {header: "报文原因说明",width: 100,sortable: true,dataIndex: 'messageRemarks'},
            {header: "创建时间",width: 100,sortable: true,dataIndex: 'createTime',renderer: function(value, cellmeta, record) {
  	        	return value.substring(0,10)+"";
  	        }},
            {header: "创建人ID",width: 100,sortable: true,dataIndex: 'creatorId',hidden:true},
            {header: "创建人",width: 100,sortable: true,dataIndex: 'creatorName'}
      	]
    });
});
</script>
</html>