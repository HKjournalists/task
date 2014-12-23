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
	<title>集团联调需求单列表</title>
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
                    {name: 'reqName',fieldLabel: '需求单名称'},
                    {name: 'reqTag',fieldLabel: '需求单编号'},
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
	        {name:'reqId',type:'string'},//需求单ID
	 		{name:'reqTag',type:'string'},//需求单编号
	 		{name:'reqName',type:'string'},//需求单名称
	 		{name:'createTime',type:'string'},//需求单创建时间
	 		{name:'creatorId',type:'string'},//需求单创建人ID
	 		{name:'creatorName',type:'string'},//需求单创建人名字
	 		{name:'jointDebugPlanBeginTime',type:'string'},//集团联调计划开始日期
	 		{name:'jointDebugPlanEndTime',type:'string'},//集团联调计划结束日期
	 		{name:'reqManagerStaffId',type:'string'},//需求管理员ID
	 		{name:'reqManagerStaffName',type:'string'},//需求需求管理员名字
	 		{name:'groupContactsName',type:'string'},//集团联系人
	 		{name:'groupReqDevEndTime',type:'string'},//集团要求开发完成日期
	 		{name:'provincialReqDevEndTime',type:'string'},//省公司要求开发完成日期
	 		{name:'isNeedMessage',type:'string'},//是否需要造报文
	 		{name:'messageRemarks',type:'string'},//报文原因说明
	 		{name:'reasonRemarks',type:'string'},//省公司要求时间晚于集团要求时间原因说明
	 		{name:'isJoingDebugCompleted',type:'string'},//是否联调完成
	 		{name:'isDelete',type:'string'},//删除标示
	 		{name:'groupContactsPhone',type:'string'},//集团联系人电话
	 		{name:'groupContactsEmail',type:'string'},//集团联系人邮箱
	 		{name:'groupContactsRemarks',type:'string'},//集团联系人备注信息
     		{name:'remarks',type:'string'}//需求单备注说明
 		],
	    proxy: {
	        type: 'ajax',
        	url : '<%=request.getContextPath()%>/getJointDebugReqFormList.do',
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
					reqName: encodeURI(encodeURI(Ext.getCmp('qryForm').getForm().findField('reqName').getValue())),
		           	reqTag:Ext.getCmp('qryForm').getForm().findField('reqTag').getValue()  
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
        title: '集团联调需求单列表',
        store: funFolderStore,
        bbar: Ext.create('Ext.PagingToolbar', { 
			store: funFolderStore, 
			displayInfo: true, 
			displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
			emptyMsg: "没有数据"
		}),
        tbar:[
        	{xtype: 'button',text: '新增集团联调需求单',handler: function () {
        		var createReqFormWin = new top.Ext.window.Window({
				 		id:'createReqFormWin',
					    title : '新增联调需求单',
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
					    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/groupJointDebug/createReqForm.jsp?winFlag=create" scrolling="yes"   width="100%" height="100%"/>'
					}).show();
        	}},{xtype: 'button',text: '删除选中条目',handler: function () {
					
        			var deleteItems = Ext.getCmp("caseCollectionGrid").getSelectionModel().getSelection();
					if(deleteItems.length == 0){
						Ext.Msg.alert("操作提示","请选择需要删除的集团联调需求单");
						return;
					}
					Ext.MessageBox.confirm('操作提示','确定删除选中的集团联调需求单?',function(optional){
						if(optional=='yes'){
							var Ids = []; //要删除的id
		                    Ext.each(deleteItems, function (item) {
		                        Ids.push(item.data.reqId);
		                    })
		                    MaskLoading();
							Ext.Ajax.request({
								async:false,
								url:"<%=request.getContextPath()%>/deleteJointDebugReqForms.do?reqIds="+Ids,
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
	            var alterReqFormWin = new top.Ext.window.Window({
			 		id:'alterReqFormWin',
				    title : '修改集团联调需求单',
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
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/groupJointDebug/createReqForm.jsp?winFlag=alter&reqId='+record.raw.reqId+'" scrolling="yes"   width="100%" height="100%"/>'
				}).show();
            }
        },
        selModel: Ext.create("Ext.selection.CheckboxModel",{id : 'checkBoxForChoiceCount',mode:"SIMPLE"}),
        columns: [
            {xtype: 'rownumberer'},
            {header: "需求单ID",width: 100,sortable: true,dataIndex: 'reqId',hidden:true},
            {header: "编号",width: 100,sortable: true,dataIndex: 'reqTag'},
            {header: "名称",width: 100,sortable: true,dataIndex: 'reqName'},
            {header: "计划开始日期",width: 100,sortable: true,dataIndex: 'jointDebugPlanBeginTime',renderer: function(value, cellmeta, record) {
  	        	return value.substring(0,10)+"";
  	        }},
            {header: "计划结束日期",width: 100,sortable: true,dataIndex: 'jointDebugPlanEndTime',renderer: function(value, cellmeta, record) {
  	        	return value.substring(0,10)+"";
  	        }},
            {header: "集团联系人",width: 100,sortable: true,dataIndex: 'groupContactsName'},
            {header: "需求管理员ID",width: 100,sortable: true,dataIndex: 'reqManagerStaffId',hidden:true},
            {header: "需求管理员",width: 100,sortable: true,dataIndex: 'reqManagerStaffName'},
            {header: "集团要求日期",width: 100,sortable: true,dataIndex: 'groupReqDevEndTime',renderer: function(value, cellmeta, record) {
  	        	return value.substring(0,10)+"";
  	        }},
            {header: "省司要求日期",width: 100,sortable: true,dataIndex: 'provincialReqDevEndTime',renderer: function(value, cellmeta, record) {
  	        	return value.substring(0,10)+"";
  	        }},
            {header: "晚于要求日期原因说明",width: 200,sortable: true,dataIndex: 'reasonRemarks'},
            {header: "是否造报文",width: 100,sortable: true,dataIndex: 'isNeedMessage',renderer: function(value, cellmeta, record) {if(value==1||value=='on')return "是";else return "否"; }},
            {header: "报文原因说明",width: 100,sortable: true,dataIndex: 'messageRemarks'},
            {header: "是否联调完成",width: 100,sortable: true,dataIndex: 'isJoingDebugCompleted',renderer: function(value, cellmeta, record) {if(value==1||value=='on')return "是";else return "否"; }},
            {header: "集团联系人电话",width: 100,sortable: true,dataIndex: 'groupContactsPhone',hidden:true},
            {header: "集团联系人邮箱",width: 100,sortable: true,dataIndex: 'groupContactsEmail',hidden:true},
            {header: "集团联系人备注信息",width: 100,sortable: true,dataIndex: 'groupContactsRemarks',hidden:true},
            {header: "创建日期",width: 100,sortable: true,dataIndex: 'createTime',renderer: function(value, cellmeta, record) {
  	        	return value.substring(0,10)+"";
  	        }},
            {header: "创建人ID",width: 100,sortable: true,dataIndex: 'creatorId',hidden:true},
            {header: "创建人",width: 100,sortable: true,dataIndex: 'creatorName'},
            {header: "备注说明",width: 100,sortable: true,dataIndex: 'remarks'}
      	]
    });
});
</script>
</html>