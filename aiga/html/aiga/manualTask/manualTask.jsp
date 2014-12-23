<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser"); %>
<html>
<head>
	<title>编写手工用例</title>
	<style type="text/css">
	.x-grid-cell-inner{
	    width:100%;
	    height:60px;
	    background-position:2px 2px;
	    background-repeat:no-repeat;
	    background-color:transparent;
	    white-space: pre-wrap;
	}
	</style>
</head>
<body>
	<jsp:include page="/aiga/workflow/common/SelectStaff.jsp"></jsp:include>
</body>
<script type="text/javascript">
var caseId = '${param.caseId}';
var parentId = '${param.parentId}';
if(caseId=='')
	caseId='0';
if(parentId=='')
	parentId='0';
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
Ext.onReady(function() {
	Ext.QuickTips.init();
	Ext.tip.QuickTipManager.init();
	var caseForm = Ext.widget('form', {
		tbar:Ext.create('Ext.Toolbar',{
			items:[{
				text:'保存',
				handler:function(){
				  		/**提交*/
				  		var submitForm = caseForm.getForm();
				  		submitForm.findField('status').setValue('1');
				  		submitForm.findField('isLeaf').setValue('Y');
				  		if(caseId=='0'){
				  			submitForm.findField('caseId').setValue('');
				  			if(parentId=='0'){
				  				Ext.Msg.alert('提示',"未找到关联用例父节点信息");
				  				return;
				  			}
				  			submitForm.findField('parentId').setValue(parentId);
				  			submitForm.findField('caseType').setValue("2");
				  		}else{
				  			var currentStaff = '<%=user.getUserName()%>';
				  			submitForm.getForm().findField('updateTime').setValue(Ext.util.Format.date(new Date(),'Y-m-d H:i:s'));
				  			submitForm.getForm().findField('latestOperator').setValue(currentStaff);
				  		}
				    	submitForm.findField('sysLabel').setValue(getAllSysLabel());
					  	submitForm.findField('ownLabel').setValue(getAllOwnLabel());
					  	MaskLoading();
				  		submitForm.submit({
				  			clientValidation: true,
				  			url:"<%=request.getContextPath()%>/saveManualCase.do",
				  			method:'POST',  
	                    	success:function(response,config){
				  	MaskOver();
	                        	Ext.Msg.alert('提示','保存成功');
	                        	caseId = config.result.caseId;
	                        	caseForm.load({
									params:{caseId:caseId},  
									url:'<%=request.getContextPath()%>/getCaseForm.do',
									method:'POST',  
									success:function(form,action){
										caseId = submitForm.findField('caseId').getValue();
										var sysLabelData = action.result.data.sysLabel;
										var ownLabelData = action.result.data.ownLabel;
										loadAutoLabel(sysLabelData,ownLabelData);
										if(typeof window.parent.refreshTree == 'function'){
                                			window.parent.refreshTree();
                                		}
									},  
									failure:function(form,action){  
										Ext.Msg.alert('提示',"用例表单加载失败");  
									}
								});
	                    },
						failure:function(response,config){
				  	MaskOver();
							Ext.Msg.alert("提示","数据修改失败!");
						}
				  	});
				}
			},{
				text:'重置',
				handler:function(){
					caseForm.getForm().reset();
				}
			}]
		}),
		id:'caseForm',
		width:screenWidth,
		height:'screenHeight*0.4',
		title:'用例', 
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
		items: [{
			xtype: 'fieldcontainer', 
		    labelStyle: 'font-weight:bold;padding:0',
		    layout: 'hbox',
		    defaultType: 'textfield',
		    fieldDefaults: {
		    	labelAlign: 'right'
		    },
		    items: [{ 
		    	width: 250, 
		    	name: 'caseName', 
		        fieldLabel: '用例名称', 
		        allowBlank: false,
		        emptyText:'请填写用例名称'
		    }, { 
		    	width: 250, 
		        xtype: 'datefield', 
		        name: 'createTime', 
		        fieldLabel: '创建时间',
		        allowBlank: false,
		        readOnly:true
		    }, { 
		    	width: 250, 
		        xtype: 'datefield', 
		        name: 'updateTime',
		        fieldLabel: '更新时间', 
		        readOnly:true
		    },{
		    	xtype: "hidden",
		    	name:"isLeaf"
		    },{
		    	xtype: "hidden",
		    	name:"sysLabel"
		    },{
		    	xtype: "hidden",
		    	name:"ownLabel"
		    },{
		    	xtype: "hidden",
		    	name:"caseType"
		    },{
		    	xtype: "hidden",
		    	name:"caseId"
		    },{
		    	xtype: "hidden",
		    	name:"parentId"
		    },{
		    	xtype: "hidden",
		    	name:"elemId"
		    },{
		    	xtype: "hidden",
		    	name:"authorNo"
		    },{
		    	xtype: "hidden",
		    	name:"approvalPsn"
		    },{
		    	xtype: "hidden",
		    	name:"status"
		    }] 
		 }, { 
				xtype: 'fieldcontainer', 
			    labelStyle: 'font-weight:bold;padding:0', 
			    layout: 'hbox', 
			    defaultType: 'textfield', 
			    fieldDefaults: { 
			    	labelAlign: 'right' 
			    }, 
				items:[{
			    	width: 250, 
			        xtype: 'textfield', 
			        name: 'author',
			        fieldLabel: '创建人', 
			        allowBlank: false,
			        readOnly:true
			    }, { 
			        width: 250, 
			        xtype: 'textfield', 
			        name:'latestOperator',
			        fieldLabel: '最后操作人',
			        readOnly:true
			    },
			    { 
			        width: 250, 
			        xtype: 'textfield', 
			        name:'url',
			        fieldLabel: 'URL', 
			        allowBlank: false,
			        emptyText:'请填写测试界面地址'
			    }]
		},{ 
				xtype: 'fieldcontainer', 
			    labelStyle: 'font-weight:bold;padding:0', 
			    layout: 'hbox', 
			    defaultType: 'textfield', 
			    fieldDefaults: { 
			    	labelAlign: 'right' 
			    },
			    items:[{ 
			        width: 250, 
			        xtype: 'textfield', 
			        hidden:true,
			        name:'approvalName',
			        fieldLabel: '用例审批人', 
			        readOnly:true,
			        emptyText:'请选择审批人'
			    },{
				xtype:'button',
				hidden:true,
				text:'选择',
				handler:function(){
					SelectStaff.showWin('WF_LINKROLE1',3,-1,3,2,false);
				}
			}]
		},{
			html:'<div id="autoLabel" style="border: none"></div>',border:false
		},{ 
			xtype: 'fieldcontainer', 
			labelStyle: 'font-weight:bold;padding:0', 
			layout: 'hbox', 
			defaultType: 'textfield', 
			fieldDefaults: { 
				labelAlign: 'right' 
			}, 
			items:[{
				width: 750, 
			    xtype: 'textareafield', 
			    name:'caseDesc',
			    fieldLabel: '用例描述', 
			    allowBlank: false,
			    emptyText:'请填写用例描述'
			}]
		}]
	});
	
	var manualTaskModel = Ext.regModel("manualTaskModel",{
		fields:[
			{name:'taskId',type:'string'},
			{name:'taskName',type:'string'},
			{name:'taskDesc',type:'string'},
			{name:'createTime',type:'string'},
			{name:'updateTime',type:'string'},
			{name:'preResult',type:'string'},
			{name:'preTestData',type:'string'},
			{name:'caseId',type:'string'},
			{name:'describe',type:'string'},
			{name:'actualResult',type:'string'},
			{name:'taskOrder',type:'string'}]
	});
	var manualTaskStore = Ext.create('Ext.data.Store', {
	  	model: manualTaskModel,
	});
	var manualTaskGrid = Ext.create('Ext.grid.Panel',{
		tbar:Ext.create("Ext.Toolbar",{
			items:[{
				text:'保存',
				handler:function(){
					var submitForm = caseForm.getForm();
				  	if(caseId=='0'){
				  		Ext.Msg.alert("提示","请先保存用例信息");
				  		return;
				  	}
					var submitDatas = new Array();
					var datas = manualTaskGrid.getStore().data.items;
					for(var i=0;i<datas.length;){
						var data = datas[i].data;
						if(data.taskName==''&&data.taskDesc==''&&data.preResult==''&&data.preTestData==''&&data.describe=='')
			    			manualTaskGrid.getStore().removeAt(i);
			    		else{
			    			datas[i].set('taskOrder',i);
			    			datas[i].set('caseId',caseId);
			    			submitDatas.push(data);
			    			datas[i].commit();
			    			i++;
			    		}
			    	}
					MaskLoading();
			    	Ext.Ajax.request({   
						url:'<%=request.getContextPath()%>/saveManualTask.do?',  
						params:{table :Ext.encode(submitDatas)},
						success:function(response,config){
							MaskOver();
							MaskLoading();
							Ext.Ajax.request({   
								url:'<%=request.getContextPath()%>/getManualTask.do?',  
								params:{caseId:caseId},
								success:function(response,config){
									MaskOver();
									var json=Ext.JSON.decode(response.responseText);
									manualTaskStore.removeAll();
									var data = json.data;
									for( var i=0,n=data.length;i<n;i++){
										manualTaskStore.add(data[i]);
									}
									if(data.length==0)
										manualTaskStore.add({taskId:null,taskName:'',taskDesc:'',createTime:'',updateTime:'',preResult:'',preTestData:'',describe:'',actualResult:''});
								}, 
						        failure:function(){ 
									MaskOver(); 
						        	Ext.Msg.alert('提示','数据加载出错');
						        }   
						    });
						}, 
				        failure:function(){ 
							MaskOver();
				        	Ext.Msg.alert('提示','保存数据出错');
				        }   
			    	});  
				}
			}]
		}),
		id:'manualTaskGrid',
        cls: 'ui-formPanel',
		title:'用例步骤',
        height:screenHeight*0.51,
        width:screenWidth*0.986,
		forctFit:true,
        stripeRows:true,
        loadMask:true, 
		viewConfig:{
	        forctFit:true,
			stripeRows:true
		},
		listeners:{
			itemclick:function(grid,record,item,index,e,eOpts){
				var cell = grid.getSelectionModel().getCurrentPosition();
				if(cell==null||typeof cell=='undefined'||cell.columnHeader.dataIndex==null)return;
				var dataLength = grid.getStore().data.items.length;
				if(dataLength==1)
					grid.getStore().add({taskId:null,taskName:'',taskDesc:'',createTime:'',updateTime:'',preResult:'',preTestData:'',describe:'',actualResult:''});
				else{
					if(dataLength-1==index)
						grid.getStore().add({taskId:null,taskName:'',taskDesc:'',createTime:'',updateTime:'',preResult:'',preTestData:'',describe:'',actualResult:''});
				}
			}
		},
		/**
		**编辑插件
		**/
		plugins:[
			Ext.create('Ext.grid.plugin.CellEditing', {
            clicksToEdit: 1
        })],
		store:manualTaskStore,
		selType:'cellmodel',
		columns:[new Ext.grid.RowNumberer(),
				{header: "步骤ID", width:100, sortable: true, dataIndex: 'taskId',hidden:true},
				{header: "步骤名称", width:100, sortable: true, dataIndex: 'taskName',field: {xtype: 'textareafield',allowBlank: false,height:60}},
        		{header: "测试操作步骤", width:200,sortable: true, dataIndex: 'taskDesc',field: {xtype: 'textareafield',allowBlank: false,height:60}},
        		{header: "预期", width:100, sortable: true, dataIndex: 'preResult', field: {xtype: 'textareafield',allowBlank: false,height:60}},
        		{header: "测试数据准备", width:100, sortable: true, dataIndex: 'preTestData', field: {xtype: 'textareafield',allowBlank: false,height:60}},
        		{header: "步骤描述", width:200, sortable: true, dataIndex: 'describe', field: {xtype: 'textareafield',allowBlank: false,height:60}},
        		{header: "实际结果", width:100, sortable: true, dataIndex: 'actualResult',hidden:true},
        		{header: "操作", width:50,xtype:'actioncolumn',sortable:false,items: [{
        			icon:"<%=request.getContextPath()%>/aiga/label/image/del.gif",
        			id: 'delComp',  
					tooltip: '删除步骤',  
					handler: function(grid, rowIndex, colIndex) { 
						var taskId = grid.getStore().getAt(rowIndex).data.taskId;
						if(taskId==null){
					        manualTaskGrid.getStore().removeAt(rowIndex);
					        var dataLength = grid.getStore().data.items.length;
					        if(dataLength==rowIndex)
					        	manualTaskStore.add({taskId:null,taskName:'',taskDesc:'',createTime:'',updateTime:'',preResult:'',preTestData:'',describe:'',actualResult:''});
					        manualTaskGrid.getView().refresh();
					        var selection = manualTaskGrid.getSelectionModel();
					        if(selection!=null)
					        	selection.select(0);
				        }else{
				        	MaskLoading();
						        Ext.Ajax.request({   
								url:'<%=request.getContextPath()%>/deleteManualTask.do?',  
								params:{taskId:taskId},
								success:function(response,config){ 
									MaskOver();
									MaskLoading();
									Ext.Ajax.request({   
										url:'<%=request.getContextPath()%>/getManualTask.do?',  
										params:{caseId:caseId},
										success:function(response,config){
											MaskOver();
											var json=Ext.JSON.decode(response.responseText);
											manualTaskStore.removeAll();
											var data = json.data;
											for( var i=0,n=data.length;i<n;i++){
												manualTaskStore.add(data[i]);
											}
											if(data.length==0)
												manualTaskStore.add({taskId:null,taskName:'',taskDesc:'',createTime:'',updateTime:'',preResult:'',preTestData:'',describe:'',actualResult:'',caseId:caseId});
										}, 
								        failure:function(){
											MaskOver();
								        	Ext.Msg.alert('提示','数据加载出错');
								        }   
								    });
								}, 
						        failure:function(){  
									MaskOver();
						        	Ext.Msg.alert('提示','保存数据出错');
						        }   
					    	});  
				    	}
					}  
        		}]}
        	]
	});
	
	Ext.create('Ext.form.Panel', {
		renderTo:  Ext.getBody(),
		width: screenWidth,
		height: screenHeight,
        cls: 'ui-formPanel',
		layout: 'border',
		layout: {
			type: 'hbox',      
			align: 'stretch', 
			padding: 0
		},
		listeners:{
			render:function(render,eOpts){
				MaskLoading();
				caseForm.load({
					params:{caseId:caseId},  
					url:'<%=request.getContextPath()%>/getCaseForm.do',
					method:'POST',  
					success:function(form,action){
						MaskOver();
						caseId = caseForm.getForm().findField("caseId").getValue();
						if(caseId=='0'||caseId==''){
							var currentStaff = '<%=user.getUserName()%>';
							var currentStaffNo = '<%=user.getUserAccount()%>';
							Ext.getCmp('caseForm').getForm().findField('author').setValue(currentStaff);
							Ext.getCmp('caseForm').getForm().findField('authorNo').setValue(currentStaffNo);
							Ext.getCmp('caseForm').getForm().findField('createTime').setValue(Ext.util.Format.date(new Date(),'Y-m-d H:i:s'));
							Ext.getCmp('caseForm').getForm().findField('updateTime').setValue(Ext.util.Format.date(new Date(),'Y-m-d H:i:s'));
							Ext.getCmp('caseForm').getForm().findField('latestOperator').setValue(currentStaff);
						}
						var sysLabelData = action.result.data.sysLabel;
						var ownLabelData = action.result.data.ownLabel;
						loadAutoLabel(sysLabelData,ownLabelData);
						if(caseId=='')
							caseId = '0';
						MaskLoading();
						Ext.Ajax.request({   
							url:'<%=request.getContextPath()%>/getManualTask.do?',  
							params:{caseId:caseId},
							success:function(response,config){
								MaskOver();
								var json=Ext.JSON.decode(response.responseText);
								var data = json.data;
								for( var i=0,n=data.length;i<n;i++){
									manualTaskStore.add(data[i]);
								}
								if(data.length==0)
									manualTaskStore.add({taskId:null,taskName:'数据准备',taskDesc:'',createTime:'',updateTime:'',preResult:'',preTestData:'',describe:'',actualResult:'',caseId:caseId});
							}, 
					        failure:function(){ 
								MaskOver();
					        	Ext.Msg.alert('提示','数据加载出错');
					        }   
					    });    	
					},  
					failure:function(form,action){
						MaskOver();
						Ext.Msg.alert('提示',"用例表单加载失败");  
					}
				});
			}
		},
		defaults: {
			split: true,           
			collapsible: false,           
			bodyStyle: 'padding:0px'
		},
		items: [{
			region: 'center',
			items:[caseForm,manualTaskGrid]
		}]
	});
	addLabel('autoLabel');
	Ext.getCmp('caseForm').doLayout();
});


		function addLabel(divId) {
			Ext.QuickTips.init();
			var sysLabel = new Ext.data.Store({
				autoLoad: true,
				id: 'sysLabel',
				fields: ['value','show'],
				proxy: {
					type: 'ajax',
					url: '<%=request.getContextPath()%>/getSysLabel.do',
					reader: {
						type: 'json',
						root: 'data'
					}
				}
			});
			
			var sysAddBtn = new Ext.Button({
				id: 'sysAddBtn',
				text: '添加',
				margin: '0 0 0 20',
				listeners:{
					click: {
						fn:function(){
							addSysLabel();
						}
				}}
			});
			var ownAddBtn = new Ext.Button({
				text: '添加',
				margin: '0 0 0 20',
				id:'ownAddBtn',
				listeners:{
					click: {
						fn:function(){
							addOwnLabel();
						}
				}}
			});
			var sysLabel = new Ext.form.Panel({
				id: 'sysLabel',
				renderTo: Ext.get(divId),
				width: 900,
				height: 30,
				border: false,
				layout:'hbox',
				items:[
					{xtype:'label',text:'公有标签:',margin:'2 5 2 20',width: 80,style:'text-align:right;line-height: 18px;'},
					sysAddBtn
				]
			});
			var ownLabel = new Ext.form.Panel({
				id: 'ownLabel',
				renderTo: Ext.get(divId),
				width: 900,
				height: 28,
				border: false,
				layout:'hbox',
				items:[
					{xtype:'label',text:'自定义标签:',margin:'2 5 2 20',width: 80,style:'text-align:right;line-height: 18px;'},
					ownAddBtn
				]
			});
			
			var testBtn = new Ext.Button({
				//renderTo: Ext.get(divId),
				text:'测试',
				listeners: {
					click: function(){alert(getAllSysLabel());getAllOwnLabel();}
				}
			});
			
		}
		
		function addSysLabel(value) {
			var length = (Ext.getCmp('sysLabel').items.length - 2)/2;
			if(length == 5) {
				return;
			}
			Ext.getCmp('sysLabel').remove(Ext.getCmp('sysAddBtn'));
			var sysAddBtn = new Ext.Button({
				text: '添加',
				id:'sysAddBtn',
				listeners:{
					click: {
						fn:function(){
							addSysLabel();
						}
				}}
			});
			var delImg = new Ext.Img({
				src:'<%=request.getContextPath()%>/images/del.gif',
				width: 16,
				height: 16,
				margin:'2 10 2 0',
				listeners: {
					el:{
						click:function() {
							removeCurLabel('sysLabel');
						}
					}
				}
			});
			Ext.getCmp('sysLabel').doLayout();
			Ext.getCmp('sysLabel').add(new Ext.form.ComboBox({width: 110,store: Ext.StoreManager.get('sysLabel'),valueField: 'value',displayField: 'show',name:'sysLabelAuto',value:value}));
			Ext.getCmp('sysLabel').add(delImg);
			Ext.getCmp('sysLabel').add(sysAddBtn);
		}
		
		function addOwnLabel(value) {
			var length = (Ext.getCmp('ownLabel').items.length - 2)/2;
			if(length == 5) {
				return;
			}
			Ext.getCmp('ownLabel').remove(Ext.getCmp('ownAddBtn'));
			var ownAddBtn = new Ext.Button({
				text: '添加',
				id:'ownAddBtn',
				listeners:{
					click: {
						fn:function(){
							addOwnLabel();
						}
				}}
			});
			var delImg = new Ext.Img({
				src:'<%=request.getContextPath()%>/images/del.gif',
				width: 16,
				height: 16,
				margin:'2 10 2 0',
				listeners: {
					el:{
						click:function() {
							removeCurLabel('ownLabel');
						}
					}
				}
			});
			Ext.getCmp('ownLabel').add(new Ext.form.TextField({width:110,value:value,name:'ownLabelAuto'}));
			Ext.getCmp('ownLabel').add(delImg);
			Ext.getCmp('ownLabel').add(ownAddBtn);
		}
		
		function removeCurLabel(labelId) {
			Ext.getCmp(labelId).remove(Ext.getCmp($(event.target).prev().attr('id')));
			Ext.getCmp(labelId).remove(Ext.getCmp($(event.target).attr('id')));
			Ext.getCmp(labelId).doLayout();
		}
		
		function getAllSysLabel() {
			var ay = new Array();
			$('input[name=sysLabelAuto]').each(function(){
				ay.push($(this).val());
			});
			return ay+"";
		}
		
		function getAllOwnLabel() {
			var ay = new Array();
			$('input[name=ownLabelAuto]').each(function(){
				ay.push($(this).val());
			});
			return ay+"";
		}
		
		function loadAutoLabel(sysLabelData,ownLabelData) {
			$("#autoLabel").html("");
			addLabel('autoLabel');
			var baseForm = Ext.getCmp('caseForm').getForm();
			if(sysLabelData != null && sysLabelData != "") {
				var sysAry = sysLabelData.split(",");
				for(var i = 0; i <　sysAry.length; i++) {
					addSysLabel(sysAry[i]);
				}
			}
			if(ownLabelData != null && ownLabelData != "") {
				var sysAry = ownLabelData.split(",");
				for(var i = 0; i <　sysAry.length; i++) {
					addOwnLabel(sysAry[i]);
				}
			}
		}

var afterSelect = function(staffs,option){
	var staffCode = staffs.staffCode;
	var staffName = staffs.employeeName;
	
	Ext.getCmp('caseForm').getForm().findField('approvalName').setValue(staffName);
	Ext.getCmp('caseForm').getForm().findField('approvalPsn').setValue(staffCode);
};
</script>
</html>