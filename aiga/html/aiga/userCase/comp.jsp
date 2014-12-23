<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ include file="/aiga/common/common.jsp" %>
<%
	String reqId = request.getParameter("reqId");
	String elemTag = request.getParameter("elemTag");
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
%>
<html>
	<head>
		<title>用例</title>
		<style type="text/css">
			img {
				cursor: pointer;
			}
			.x-grid-cell.comp
			{
			    background-color: #9fc;
			}
			.x-grid-cell.compoff
			{
			    background-color: #ffc;
			}
		</style>
	</head>
	<body>
		<jsp:include page="/aiga/workflow/common/SelectStaff.jsp"></jsp:include>
	</body>
	<script type="text/javascript">
var extjsFolderPath='<%=request.getContextPath()%>/extJs';
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
var caseId = '${param.caseId}';
var parentId = '${param.parentId}';
if(caseId=='')
	caseId='0';
if(parentId=='')
	parentId='0';
Ext.regModel('extCommboModel', {
    fields: [
        {type: 'int', name: 'value'},
        {type: 'string', name: 'text'}
    ]
});
Ext.regModel('inputValueCommboModel', {
    fields: [
        {type: 'string', name: 'value'},
        {type: 'string', name: 'text'}
    ]
});

function rightClickTree(view,record,item,index,e,eOpts){
	 e.preventDefault();
	 var treeNode=Ext.getCmp('compTree').getSelectionModel().getSelection();
     if(treeNode.length==0){
       	Ext.Msg.alert('提示','请选择组件');
       	return;
     }
     if(treeNode[0].raw.leaf==false){
     	Ext.getCmp('addComp').setVisible(true);
		Ext.getCmp('editComp').setVisible(false);
		Ext.getCmp('addFolder').setVisible(true);
		Ext.getCmp('delFolder').setVisible(true);
		Ext.getCmp('editFolder').setVisible(true);
	 }else if(treeNode[0].raw.leaf==true){
		Ext.getCmp('addComp').setVisible(false);
		Ext.getCmp('editComp').setVisible(true);
		Ext.getCmp('addFolder').setVisible(false);
		Ext.getCmp('delFolder').setVisible(false);
		Ext.getCmp('editFolder').setVisible(false);
	 }else{
		Ext.Msg.alert('提示','未能获取点击树节点信息');
		return;
	 }
	 rightClickTreeMenu.showAt(e.getXY());
}
var rightClickTreeMenu = new Ext.menu.Menu({
    items: [{
    		id:'addFolder',
    		icon: '<%=request.getContextPath()%>/aiga/userCase/image/add.gif',
    		text:'新增目录',
    		handler:function(){
    			var treeNode=Ext.getCmp('compTree').getSelectionModel().getSelection();
	         	if(treeNode.length==0){
	         		Ext.Msg.alert('提示','请选择组件树节点');
	         		return;
	         	}
	         	if(treeNode[0].raw.leaf==true){
	         		Ext.Msg.alert('提示','请选择组件树非叶子节点');
	         		return;
	         	}
	         	Ext.Msg.prompt('新增目录', '目录名称', function(btn, text){
				    if (btn == 'ok'){
				    	var treeNode=Ext.getCmp('compTree').getSelectionModel().getSelection();
						var folderName = text;
						if(folderName==null||folderName=='')
							return;
						$.getJSON("<%=request.getContextPath()%>/saveCompFolder.do",{folderName:folderName,compId:treeNode[0].raw.id},function(data){
							var parentId = treeNode[0].raw.id; 
			                var node =Ext.data.StoreManager.lookup('compTreeStore').getNodeById(parentId);   
	   						Ext.data.StoreManager.lookup('compTreeStore').load({node:node});
						});
				    }
				});
    		}
    	},{
    		id:'delFolder',
    		text:'删除目录',
    		handler:function(){
    			var treeNode=Ext.getCmp('compTree').getSelectionModel().getSelection();
    			if(treeNode[0].hasChildNodes()==true){
    				Ext.Msg.alert('提示','该目录并不为空，不可删除');
					return;
    			}
				if(treeNode.length==0){
					Ext.Msg.alert('提示','请选择组件树节点');
					return;
				}
				if(treeNode[0].raw.leaf==true){
					Ext.Msg.alert('提示','请选择组件树非叶子节点');
					return;
				}
				var folderName = treeNode[0].raw.text;	
    			$.getJSON("<%=request.getContextPath()%>/deleteCompFolder.do",{folderName:folderName,compId:treeNode[0].raw.id},function(data){
					var parentId = treeNode[0].raw.parentId; 
			        var node =Ext.data.StoreManager.lookup('compTreeStore').getNodeById(parentId);   
	   				Ext.data.StoreManager.lookup('compTreeStore').load({node:node});
				});
    		}
    	},{
    		id:'editFolder',
    		text:'编辑目录',
    		handler:function(){
    			var treeNode=Ext.getCmp('compTree').getSelectionModel().getSelection();
			 	if(treeNode.length==0){
					Ext.Msg.alert('提示','请选择组件树节点');
				    return;
				}
				if(treeNode[0].raw.leaf==true){
					Ext.Msg.alert('提示','请选择组件树非叶子节点');
					return;
				}
    			Ext.Msg.prompt('编辑目录', '目录名称', function(btn, text){
    				if (btn == 'ok'){
						var folderName = text;
						if(folderName==null||folderName=='')
							return;
						$.getJSON("<%=request.getContextPath()%>/editCompFolder.do",{folderName:folderName,compId:treeNode[0].raw.id},function(data){
							var parentId = treeNode[0].raw.parentId;
			                var node =Ext.data.StoreManager.lookup('compTreeStore').getNodeById(parentId);   
	   						Ext.data.StoreManager.lookup('compTreeStore').load({node:node});
						});
				    }
				},undefined,undefined,treeNode[0].raw.text);
    		}
    	},{
	    	id:'editComp',
	    	icon: extjsFolderPath+'/resources/themes/images/myicons/edit-plus.gif',
	        text: '编辑组件',
	        handler: function(){
	        	var treeNode=Ext.getCmp('compTree').getSelectionModel().getSelection();
	        	var editWin = new top.Ext.window.Window({
				    id:'editWin',
				    title : '编辑组件',
				    width : 950,
				    height : 450,
				    modal : true,
				    resizable:false,
				    closeAction : 'destroy',
				    listeners:{
						destroy:function(window,eOpts){
							var parentId = treeNode[0].raw.parentId; 
		                	var node =Ext.data.StoreManager.lookup('compTreeStore').getNodeById(parentId);   
   							Ext.data.StoreManager.lookup('compTreeStore').load({node:node});
						}
				    },
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/component/gui.jsp?compId='+treeNode[0].raw.id+'&parentId=" width="950" height="423"/>'
			   });
			   editWin.show();
			   $("#editWin").css("left","70px");
        	}
        },{
        	id:'addComp',
        	icon:'<%=request.getContextPath()%>/aiga/userCase/image/add.gif',
        	text:'新增组件',
        	handler:function(){
        		var treeNode=Ext.getCmp('compTree').getSelectionModel().getSelection();
	         	if(treeNode.length==0){
	         		Ext.Msg.alert('提示','请选择组件树节点');
	         		return;
	         	}
	         	if(treeNode[0].raw.leaf==true){
	         		Ext.Msg.alert('提示','请选择组件树非叶子节点');
	         		return;
	         	}
	         	var addWin = new top.Ext.window.Window({
				    id:'addWin',
				    title : '新增组件',
				    width : 950,
				    height : 450,
				    modal : true,
				    resizable:false,
				    listeners:{
						destroy:function(window,eOpts){
							var parentId = treeNode[0].raw.id; 
		                	var node =Ext.data.StoreManager.lookup('compTreeStore').getNodeById(parentId);   
   							Ext.data.StoreManager.lookup('compTreeStore').load({node:node});
						}
				    },
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/component/gui.jsp?compId=&parentId='+treeNode[0].raw.id+'" width="950px" height="450px"/>'
		   		});
		   		addWin.show();
			   	$("#addWin").css("left","70px");
        	}
        }]
});

Ext.onReady(function() {
var testTypeArray = new Array();
Ext.Ajax.request({
	async:false,
	url:'<%=request.getContextPath()%>/getCaseParam.do?type=test_type',
	success:function(response,config){
		var json=Ext.JSON.decode(response.responseText);
		if(json!=null)
			json = json.data;
		else
			return;
		for(var i=0,n=json.length;i<n;i++){
			var item = {};
			item.boxLabel = json[i].text;
			item.inputValue = json[i].value;
			item.name = 'testType';
			testTypeArray.push(item);
		}
	},
	failure:function(response,config){
		Ext.Msg.alert('操作','数据请求失败');
	}
});
Ext.QuickTips.init();
//tooltip初始化
Ext.tip.QuickTipManager.init();
	/***用例表单***/
	var caseForm = Ext.widget('form', {
		tbar:Ext.create('Ext.Toolbar',{
			items:[{
				text:'保存',
				handler:function(){
			  		var submitForm = caseForm.getForm();
			  		submitForm.findField('status').setValue('1');
			  		if(caseId=='0'){
			  			submitForm.findField('caseId').setValue('');
			  			if(parentId=='0'){
			  				Ext.Msg.alert('提示',"未找到关联用例父节点信息");
			  				return;
			  			}
			  			submitForm.findField('funFolderId').setValue(parentId);
			  		}else{
			  			var currentStaff = '<%=user.getUserName()%>';
			  			submitForm.findField('updateTime').setValue(Ext.util.Format.date(new Date(),'Y-m-d H:i:s'));
			  			submitForm.findField('latestOperator').setValue(currentStaff);
			  		}
			  		submitForm.findField('sysLabel').setValue(getAllSysLabel());
			  		submitForm.findField('ownLabel').setValue(getAllOwnLabel());
			  		var val = [];
			        Ext.getCmp('isProgressTestCheck').items.each(function (c) {
			            if (c.getValue() == true)
			                val.push(c.inputValue);
			        });
			  		submitForm.findField('testType').setValue(val.join(','));
			  		MaskLoading();
			  		submitForm.submit({
			  			clientValidation: true,
			  			url:"<%=request.getContextPath()%>/saveManualCase.do",
			  			method:'POST',  
                    	success:function(response,config){ 
			  				Ext.Msg.alert('提示','保存成功');
                        	caseId = config.result.caseId;
                        	caseForm.load({
								params:{caseId:caseId},  
								url:'<%=request.getContextPath()%>/getCaseForm.do',
								method:'POST',  
								success:function(form,action){
									caseId = submitForm.findField('caseId').getValue();
									var val = submitForm.findField('testType').getValue();
									if (val.split) {
							            val = val.split(',');
							        }
							        Ext.getCmp('isProgressTestCheck').reset();
							        for (var i = 0; i < val.length; i++) {
							            Ext.getCmp('isProgressTestCheck').items.each(function (c) {
							                if (c.inputValue == val[i]) {
							                    c.setValue(true);
							                }
							            });
							        }
									
									var sysLabelData = action.result.data.sysLabel;
									var ownLabelData = action.result.data.ownLabel;
									loadAutoLabel(sysLabelData,ownLabelData);
									if(typeof window.parent.refreshTree == 'function'){
                               			window.parent.refreshTree();
                               		}
                               		MaskOver();
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
			}]
		}),
		id:'caseForm',
		border:0,
		collapsible:true,
		titleCollapse: true,
		width:screenWidth*0.982,
		height:screenHeight*0.4,
		title:'用例',
        cls: 'ui-formPanel',
		layout: { 
			type: 'vbox'
		},
		listeners:{
        	beforeexpand:function(p,animate,eOpts){
        		caseType.collapse();
        		caseForm.collapse();
        		autotestParamsTreeGrid.collapse();
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
		    fieldDefaults: {
		    	labelAlign: 'right'
		    },
		    items: [{ 
		    	width: 250, 
		    	name: 'caseName', 
		        fieldLabel: '用例名称', 
		        allowBlank: false,
		        emptyText:'请填写用例名称'
		    },{ 
		    	width: 250, 
		    	name: 'important', 
		        fieldLabel: '重要级别',
		        xtype: 'combo', 
		        allowBlank: false,
		        forceSelection: true,
		        emptyText:'请选择重要级别',
		        store:Ext.create('Ext.data.Store', {
		        	autoLoad:true,
					model:"extCommboModel",
					proxy:Ext.create('Ext.data.proxy.Ajax',{
						type:"ajax",
						model:"extCommboModel",
						url:'<%=request.getContextPath()%>/getCaseParam.do?type=case_important',
						reader:{
							root:"data",
							type:"json"
						}
					})
				}),
	           displayField:'text',
	           valueField:'value',
	           mode:'remote'
		    },{ 
		    	width: 250, 
		    	name: 'maintenanceFac', 
		        fieldLabel: '维护厂家',
		        xtype: 'combo', 
		        allowBlank: false,
		        forceSelection: true,
		        emptyText:'请选择维护厂家',
		        store:Ext.create('Ext.data.Store', {
		        	autoLoad:true,
					model:"extCommboModel",
					proxy:Ext.create('Ext.data.proxy.Ajax',{
						type:"ajax",
						model:"extCommboModel",
						url:'<%=request.getContextPath()%>/getCaseParam.do?type=case_fac',
						reader:{
							root:"data",
							type:"json"
						}
					})
				}),
	           displayField:'text',
	           valueField:'value',
	           mode:'remote'
		    },{ 
		        width: 250, 
		        xtype: 'textfield', 
		        name:'url',
		        fieldLabel: 'URL', 
		        allowBlank: false,
		        emptyText:'请填写测试界面地址'
		    },{ 
		        xtype: "hidden", 
		        name: 'testType', 
		    },{ 
		        xtype: "hidden", 
		        name: 'createTime', 
		    }, { 
		        xtype: "hidden", 
		        name: 'updateTime',
		    },{
		    	xtype: "hidden",
		    	name:"sysLabel"
		    },{
		    	xtype: "hidden",
		    	name:"ownLabel"
		    },{
		    	xtype: "hidden",
		    	name:"caseId"
		    },{
		    	xtype: "hidden",
		    	name:"funFolderId"
		    },{
		    	xtype: "hidden",
		    	name:"authorNo"
		    },{
		    	xtype: "hidden",
		    	name:"approvalPsn"
		    },{
		    	xtype: "hidden",
		    	name:"status"
		    },{
		    	xtype: "hidden",
		    	name:"baseCaseId"
		    },{
		        xtype: 'hidden', 
		        name: 'author',
		    }, { 
		        xtype: "hidden",
		        name:'latestOperator',
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
			    	name: 'regressionTest', 
			        fieldLabel: '是否为回归测试',
			        xtype: 'combo',
			        forceSelection: true,
			        allowBlank: false,
			        emptyText:'请选择',
			        listeners:{
			        	change:function(combo,newValue,oldValue,eOpts){
			        		if(newValue==null||newValue==0){
			        			var checks = Ext.getCmp('isProgressTestCheck').getChecked();
			        			for(var i=0,n=checks.length;i<n;i++){
			        				checks[i].setValue(false);
			        			} 
			        			Ext.getCmp('isProgressTestCheck').disable(true);
			        		}else{
			        			Ext.getCmp('isProgressTestCheck').enable(true);
			        		}
			        	}
			        },
			        store:Ext.create('Ext.data.Store', {
			        	autoLoad:true,
						model:"extCommboModel",
						proxy:Ext.create('Ext.data.proxy.Ajax',{
							type:"ajax",
							model:"extCommboModel",
							url:'<%=request.getContextPath()%>/getCaseParam.do?type=case_regress',
							reader:{
								root:"data",
								type:"json"
							}
						})
					}),
		           displayField:'text',
		           valueField:'value',
		           mode:'remote'
		    },{
		    	id:'isProgressTestCheck',
		    	width:500,
		    	xtype: 'checkboxgroup',
		        columns: 5,
		        items: testTypeArray
		    },{ 
			    	width: 250, 
			    	name: 'hasTest', 
			        fieldLabel: '是否实现自动化',
			        xtype: 'combo', 
			        forceSelection: true,
			        allowBlank: false,
			        emptyText:'请选择',
			        store:Ext.create('Ext.data.Store', {
			        	autoLoad:true,
						model:"extCommboModel",
						proxy:Ext.create('Ext.data.proxy.Ajax',{
							type:"ajax",
							model:"extCommboModel",
							url:'<%=request.getContextPath()%>/getCaseParam.do?type=has_test',
							reader:{
								root:"data",
								type:"json"
							}
						})
					}),
		           displayField:'text',
		           valueField:'value',
		           mode:'remote'
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
			    	name: 'caseType', 
			        fieldLabel: '测试类型',
			        xtype: 'combo', 
			        forceSelection: true,
			        allowBlank: false,
			        emptyText:'请选择',
			        store:Ext.create('Ext.data.Store', {
			        	autoLoad:true,
						model:"extCommboModel",
						proxy:Ext.create('Ext.data.proxy.Ajax',{
							type:"ajax",
							model:"extCommboModel",
							url:'<%=request.getContextPath()%>/getCaseParam.do?type=case_type',
							reader:{
								root:"data",
								type:"json"
							}
						})
					}),
		           displayField:'text',
		           valueField:'value',
		           mode:'remote'
		    },{ 
			    	width: 250, 
			    	name: 'efficiencyTest', 
			        fieldLabel: '是否为性能测试',
			        xtype: 'combo', 
			        forceSelection: true,
			        allowBlank: false,
			        emptyText:'请选择',
			        listeners:{
			        	change:function(combo,newValue,oldValue,eOpts){
			        		if(newValue==null||newValue==0){
			        			Ext.getCmp('efficiency').setValue(null);
			        			Ext.getCmp('efficiency').disable(true);
			        		}else{
			        			Ext.getCmp('efficiency').enable(true);
			        		}
			        	}
			        },
			        store:Ext.create('Ext.data.Store', {
			        	autoLoad:true,
						model:"extCommboModel",
						proxy:Ext.create('Ext.data.proxy.Ajax',{
							type:"ajax",
							model:"extCommboModel",
							url:'<%=request.getContextPath()%>/getCaseParam.do?type=efficiency_test',
							reader:{
								root:"data",
								type:"json"
							}
						})
					}),
		           displayField:'text',
		           valueField:'value',
		           mode:'remote'
		    },{ 
			    	width: 250, 
			    	id:'efficiency',
			    	name: 'efficiencyTestType', 
			        fieldLabel: '性能测试类型',
			        xtype: 'combo', 
			        forceSelection: true,
			        allowBlank: true,
			        emptyText:'请选择',
			        store:Ext.create('Ext.data.Store', {
			        	autoLoad:true,
						model:"extCommboModel",
						proxy:Ext.create('Ext.data.proxy.Ajax',{
							type:"ajax",
							model:"extCommboModel",
							url:'<%=request.getContextPath()%>/getCaseParam.do?type=efficiency_test_type',
							reader:{
								root:"data",
								type:"json"
							}
						})
					}),
		           displayField:'text',
		           valueField:'value',
		           mode:'remote'
		    },{ 
			    	width: 250, 
			    	name: 'teminalTest', 
			        fieldLabel: '是否端到端测试',
			        xtype: 'combo', 
			        forceSelection: true,
			        allowBlank: false,
			        emptyText:'请选择',
			        store:Ext.create('Ext.data.Store', {
			        	autoLoad:true,
						model:"extCommboModel",
						proxy:Ext.create('Ext.data.proxy.Ajax',{
							type:"ajax",
							model:"extCommboModel",
							url:'<%=request.getContextPath()%>/getCaseParam.do?type=teminal_test',
							reader:{
								root:"data",
								type:"json"
							}
						})
					}),
		           displayField:'text',
		           valueField:'value',
		           mode:'remote'
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
				width: 950,
				height:45, 
			    xtype: 'textareafield', 
			    name:'caseDesc',
			    fieldLabel: '用例描述', 
			    allowBlank: false,
			    emptyText:'请填写用例描述'
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
					SelectStaff.showWin('WF_LINKROLE1',3,-1,3,2,false,2,0);
				}
			}]
		},{
			html:'<div id="autoLabel" style="border: none;display:none"></div>',border:false
		}]
	});
	
	var compModel = Ext.regModel('compModel', { 
		fields: [ 
			{name: 'refId',type: 'string'},
			{name: 'compId',type: 'string'}, 
			{name: 'compName',type: 'string'}, 
			{name: 'inVal',type: 'string'}, 
			{name: 'expectVal',type: 'string'},
			{name: 'compDesc',type: 'string'},
			{name: 'manualTaskId',type: 'string'},
			{name: 'taskId',type: 'string'},
			{name: 'taskName',type: 'string'},
			{name: 'taskDesc',type: 'string'},
			{name: 'preResult',type: 'string'},
			{name: 'preTestData',type: 'string'},
			{name: 'caseId',type: 'string'},
			{name: 'taskOrder',type: 'string'}
		] 
	});
	
	gridStore = new Ext.data.TreeStore({ 
		model: compModel,  
		proxy: { 
			type: 'ajax',  
			url: '<%=request.getContextPath()%>/manageCaseDetail.do?caseId='+caseId
		}, 
		root: {
			id:-1,
			text: '步骤',
			expanded: true
		},
		reader: { 
			type: 'json', 
			root: 'children' 
		}
	});  
	
	var inputValueCombo = Ext.create('Ext.form.field.ComboBox', {
		id:'inputValueCombo',
     	xtype:'combo',
        emptyText:'请选择',
        displayField: 'text',
	    valueField:'value',
	    queryMode: 'local',
	    store:Ext.create('Ext.data.Store', {
	    	id:'inputValueStore',
	    	fields: ['text', 'value']
		}),
		listeners:{
			expand:function(field,eOpts){
				var autoInputValue = new Array();
				var currentnode = compGrid.getSelectionModel().getSelection();
				if(currentnode!=null&&currentnode.length==1){
					var taskId = currentnode[0].raw.manualTaskId;
					var parentnode = gridStore.getNodeById(taskId);
					var preTestData = parentnode.data.preTestData;
					var dataArray = preTestData.split(",");
					for(var i=0,n=dataArray.length;i<n;i++){
						autoInputValue.push({text:dataArray[i],value:dataArray[i]});
					}
				}
				inputValueCombo.getStore().removeAll();
				inputValueCombo.getStore().add(autoInputValue);
			}
		}
	});
	
	var manualInputCombo = Ext.create('Ext.form.field.ComboBox',{
		id:'manualInputCombo',
        emptyText:'请选择',
        multiSelect:true,
        displayField: 'text',
  		valueField:'value',
	    store:Ext.create('Ext.data.Store', {
	    	id:'inputValueSotre',
      		autoLoad:true,
			model:"inputValueCommboModel",
			proxy:Ext.create('Ext.data.proxy.Ajax',{
				type:"ajax",
				model:"inputValueCommboModel",
				url:'<%=request.getContextPath()%>/getInputValue.do?caseId='+caseId,
				reader:{
					root:"data",
					type:"json"
				}
			})
		})
	});
	
	compGrid = Ext.create('Ext.tree.Panel',{
		id:'compGrid',
		useArrows: true,
		rootVisible: false,
        height:screenHeight*0.74,
        width:screenWidth*0.777,
		forctFit:true,
        stripeRows:true,
        loadMask:true, 
		viewConfig: {
        	plugins: {
				ptype: 'treeviewdragdrop'        
			},
			listeners:{
	        	beforedrop:function(node,Object,overModel,dropPosition,eOpts){
	        		if(Object.records[0].raw.leaf==true&&overModel.raw.leaf==true)
	        			if(overModel.raw.manualTaskId==Object.records[0].raw.manualTaskId)
			        		return true;
				        else
				        	return false;
				    else
				    	return false;
		    	}
	        } 
		},
		plugins:[
			Ext.create('Ext.grid.plugin.CellEditing', {
            clicksToEdit: 2,
            listeners:{
            	beforeedit:function(e,eOpts){
            		var column = eOpts.field;
            		var data = eOpts.record.raw;
            		if(column=='taskName'){
            			if(data.leaf==false){
            				return true;
            			}else{
            				return false;
            			}
            		}else if(column=='taskDesc'){
            			if(data.leaf==false){
            				return true;
            			}else{
            				return false;
            			}
            		}else if(column=='preResult'){
            			if(data.leaf==false){
            				return true;
            			}else{
            				return false;
            			}
            		}else if(column=='preTestData'){
            			if(data.leaf==false){
            				return true;
            			}else{
            				return false;
            			}
            		}else if(column=='inVal'){
            			if(data.leaf==true){
            				return true;
            			}else{
            				return false;
            			}
            		}else if(column=='expectVal'){
            			if(data.leaf==true){
            				return true;
            			}else{
            				return false;
            			}
            		}
            		return false;
            	}
            }
        })],
		store:gridStore,
		selType:'cellmodel',
		columns:[
				{text: "主键", width:100, sortable: false, dataIndex: 'refId',hidden:true},
				{text: "顺序", width:100, sortable: false, dataIndex: 'taskOrder',hidden:true},
				{text: "组件ID", width:100, sortable: false, dataIndex: 'compId',hidden:true},
				{text: "手工步骤ID", width:100, sortable: false, dataIndex: 'taskId',hidden:true},
				{xtype: 'treecolumn',text: "步骤名称", width:100, sortable: false, dataIndex: 'taskName',field: {xtype: 'textareafield',allowBlank: false,height:60}},
        		{text: "测试操作步骤", width:200,sortable: false, dataIndex: 'taskDesc',field: {xtype: 'textareafield',allowBlank: false,height:60}},
        		{text: "预期结果", width:100, sortable: false, dataIndex: 'preResult', field: {xtype: 'textareafield',allowBlank: false,height:60}},
        		{text: "输入参数定义", width:100, sortable: false, dataIndex: 'preTestData',field:manualInputCombo},
				{text: "用例ID", width:100, sortable: false, dataIndex: 'caseId',hidden:true},
				{text: "组件名", width:100, sortable: false, dataIndex: 'compName',renderer: function (value, meta, record) {
					var author = record.raw.author;
					var tag = record.raw.tag;
					var defaultVal = record.raw.defaultVal;
					var selector = new String(record.raw.selector);
					if(selector!=null&&selector.length!=0)
						selector = selector.substr(selector.indexOf('@')+1,selector.length-selector.indexOf('@')-4);
					else
						selector = "";
					var compDesc = record.raw.compDesc;
					var tip = "组件作者:"+author+"<br>组件类型:"+tag+"<br>参考值:"+defaultVal+"<br>关键元素:"+selector.toString()+"<br>组件描述:"+compDesc+"<br>";
                    meta.tdAttr = 'data-qtip="' + tip + '"';
                    meta.tdCls = value?'comp' : 'compoff';
                    return value;
				}},
        		{text: "输入值", width:100,sortable: false, dataIndex: 'inVal',field:inputValueCombo,renderer:function(value, meta, record){
        			meta.tdCls = value?'comp' : 'compoff';
        			return value;
        		}},
        		{text: "预期值", width:100, sortable: false, dataIndex: 'expectVal', field: {xtype: 'textfield',allowBlank: false},renderer:function(value, meta, record){
        			meta.tdCls = value?'comp' : 'compoff';
        			return value;
        		}},
        		{text: "用例步骤描述", width:100, sortable: false, dataIndex: 'compDesc',renderer:function(value, meta, record){
        			meta.tdCls = value?'comp' : 'compoff';
        			return value;
        		}},
        		{text: "操作", width:50,menuDisabled: true,xtype:'actioncolumn',sortable:false,items: [{
        			icon:"<%=request.getContextPath()%>/aiga/label/image/del.gif",
        			id: 'delComp',  
					tooltip: '删除',  
					handler: function(treeGrid, rowIndex, colIndex) {
				        var currentSotre=treeGrid.getStore().getAt(rowIndex);
						if(currentSotre==null){
							Ext.Msg.alert('提示','请选择步骤节点');
							return;
						}
						if(currentSotre.raw.leaf==false){
							Ext.MessageBox.confirm('提示','确定删除该目录吗?删除该目录将会删除该目录下所有的信息',function(optional){
								if(optional=='yes'){
									Ext.Ajax.request({
										url:'<%=request.getContextPath()%>/deleteManualTask.do?taskId='+currentSotre.raw.taskId,
										success:function(response,config){
											var rootNode = gridStore.getNodeById(-1);
											gridStore.load(rootNode);
										},
										failure:function(response,config){
											Ext.Msg.alert('提示','删除失败');
										}
									});
								}
							});
						}else{
							currentSotre.remove();
						}
					}  
        		}]}
        		]
	});
	
    var compTreeStore = Ext.create('Ext.data.TreeStore', { 
		id:'compTreeStore', 
		proxy: {
			type: "ajax",
			url: "<%=request.getContextPath()%>/getTreeSyn.do?type=0"
		},
		root: {
			id:'1',
			text: '组件',
			expanded: true
		},
		reader: { 
			type: 'json', 
			root: 'children' 
		} 
    });
	var compTree = Ext.create('Ext.tree.Panel',{
		id:'compTree',
        cls: 'ui-formPanel',
		width: screenWidth*0.2,
		rootVisible: true,
		height: screenHeight*0.74,
		store: compTreeStore,
		useArrows: true,
		autoScroll:true,
		viewConfig : {  
			loadingText : "加载数据..."
		},
		animate:true,
        autoScroll:true,
        containerScroll:true,
        frame:false,
        listeners:{
        	itemclick : function(thisView,record,htmlElementItem,indexNo){
        		var submitForm = caseForm.getForm();
			  	if(caseId=='0'){
			  		Ext.Msg.alert("提示","请先保存用例信息");
			  		return;
			  	}
				if(!record.raw.leaf)return;
				var selectNode = Ext.getCmp('compGrid').getSelectionModel().getSelection();
				if(selectNode.length!=1||selectNode[0].raw.leaf==true||selectNode[0].raw.id==-1){
					Ext.Msg.alert('提示','请选择用例步骤');
					return;
				}
				var compId = record.raw.id;
				selectNode[0].expand(true,function(){
					$.getJSON("<%=request.getContextPath()%>/getCompById.do",{compId:compId}, function(data){
						var returnData = data.children[0];
						returnData.manualTaskId=selectNode[0].raw.taskId;
		  				selectNode[0].appendChild(returnData);
					});
				});
        	},
        	itemcontextmenu : rightClickTree
        }
	});
	
	var caseType = Ext.create('Ext.form.Panel', {
		tbar:Ext.create('Ext.Toolbar',{
			items:[{
				text:'保存',
				handler:function(){
					var submitForm = caseForm.getForm();
				  	if(caseId=='0'){
				  		Ext.Msg.alert("提示","请先保存用例信息");
				  		return;
				  	}
					var store=compGrid.getStore();
					var records = store.getUpdatedRecords();
					var autoSaveArray = new Array();
					var manualSaveArray = new Array();
					var i=0;
					var rootNode = gridStore.getNodeById(-1);
                    rootNode.eachChild(function(node){
                    	i++;
                    	manualSaveArray.push({taskId:node.data.taskId,taskName:node.data.taskName,taskDesc:node.data.taskDesc,preResult:node.data.preResult,preTestData:node.data.preTestData,caseId:caseId,taskOrder:i});
                    	node.eachChild(function(autoNode){
                    		autoSaveArray.push({inVal:autoNode.data.inVal,expectVal:autoNode.data.expectVal,compId:autoNode.data.compId,arguName:"",manualTaskId:node.data.taskId});
                    	});
					});
                    MaskLoading();
                    caseForm.getForm().submit({
                    	url:'<%=request.getContextPath()%>/saveCase.do',
                    	params:{table:Ext.encode(autoSaveArray)},
                    	method:'POST',
                    	success:function(response,config){
                    		var success = config.result.success;  
		                    if (success) {
		                        Ext.Array.each(records, function(record) {  
		                        	record.commit();
		                    	});
		                    	Ext.Ajax.request({
		                    		url:'<%=request.getContextPath()%>/saveManualTask.do',
		                    		params:{table:Ext.encode(manualSaveArray)},
		                    		success:function(response,config){
		                    			Ext.Msg.alert('提示','保存成功');
		                    			gridStore.load(rootNode);
		                    		},
		                    		failure:function(response,config){
		                    			MaskOver();
		                    			Ext.Msg.alert('提示','保存失败');
		                    		}
		                    	});
		                    }
		                    MaskOver();  
                    	},
                    	failure:function(response,config){
                    		MaskOver();
                    		Ext.Msg.alert('提示','保存失败');
                   		}
                   	});
				}
			},{
				text:'创建步骤',
				handler:function(){
					var submitForm = caseForm.getForm();
				  	if(caseId=='0'){
				  		Ext.Msg.alert("提示","请先保存用例信息");
				  		return;
				  	}
					Ext.Msg.prompt('添加步骤', '步骤名称', function(btn, text){
					    if (btn == 'ok'){
					    	var rootNode = gridStore.getNodeById(-1);
							var newNode = {
								parentId:-1,
								leaf:false,
								text:text,
								taskName:text,
								taskId:'',
								taskDesc:'',
								preResult:'',
								preTestData:'',
								caseId:caseId
							};
							rootNode.appendChild(newNode);
							var store=compGrid.getStore();
							var records = store.getUpdatedRecords();
							var autoSaveArray = new Array();
							var manualSaveArray = new Array();
							var i=0;
		                    rootNode.eachChild(function(node){
		                    	i++;
		                    	manualSaveArray.push({taskId:node.data.taskId,taskName:node.data.taskName,taskDesc:node.data.taskDesc,preResult:node.data.preResult,preTestData:node.data.preTestData,caseId:caseId,taskOrder:i});
		                    	node.eachChild(function(autoNode){
		                    		autoSaveArray.push({inVal:autoNode.data.inVal,expectVal:autoNode.data.expectVal,compId:autoNode.data.compId,arguName:"",manualTaskId:node.data.taskId});
		                    	});
							});
		                    MaskLoading();
		                    caseForm.getForm().submit({
		                    	url:'<%=request.getContextPath()%>/saveCase.do',
		                    	params:{table:Ext.encode(autoSaveArray)},
		                    	method:'POST',
		                    	success:function(response,config){
		                    		var success = config.result.success;  
				                    if (success) {
				                        Ext.Array.each(records, function(record) {  
				                        	record.commit();
				                    	});
				                    	Ext.Ajax.request({
				                    		url:'<%=request.getContextPath()%>/saveManualTask.do',
				                    		params:{table:Ext.encode(manualSaveArray)},
				                    		success:function(response,config){
				                    			gridStore.load(rootNode);
				                    			MaskOver();
				                    		},
				                    		failure:function(response,config){
				                    			MaskOver();
				                    			Ext.Msg.alert('提示','保存失败');
				                    		}
				                    	});
				                    }
		                    	},
		                    	failure:function(response,config){
		                    		MaskOver();
		                    		Ext.Msg.alert('提示','保存失败');
	                    		}
	                    	});
						}
					});
				}
			}]
		}),
		title:'测试步骤',
		collapsible:true,
		collapsed : true,
		titleCollapse: true,
		border:0,
        cls: 'ui-formPanel',
		width: screenWidth*0.982,
		height: screenHeight*0.85,
		listeners:{
        	beforeexpand:function(p,animate,eOpts){
        		caseType.collapse();
        		caseForm.collapse();
        		autotestParamsTreeGrid.collapse();
        	}
        },
		defaults: {
			split: true,           
			collapsible: false,           
			bodyStyle: 'padding:0px'
		},
		items: [{
			layout: {
				type: 'hbox',      
				align: 'stretch', 
				padding: 0
			},
			region: 'center',
			items:[compTree,compGrid]
		}]
	});
	
	var autotestParamsModel = Ext.regModel('autotestParamsModel', { 
		fields: [ 
			{name: 'paramId',type: 'string'}, 
			{name: 'parentId',type: 'string'}, 
			{name: 'paramName',type: 'string'},
			{name: 'paramValue',type: 'string'},
			{name: 'isleaf',type: 'string'},
			{name: 'caseId',type: 'string'},
			{name:'paramDesc',type:'string'},
			{name:'exeSql',type:'string'}
		] 
	});
	
	var autotestParamsStore = new Ext.data.TreeStore({ 
		model: autotestParamsModel,  
		proxy: { 
			type: 'ajax',  
			url: '<%=request.getContextPath()%>/getAutotestParam.do?caseId='+caseId
		}, 
		root: {
			id:1,
			text: '参数',
			expanded: true
		},
		reader: { 
			type: 'json', 
			root: 'children' 
		}
	});    
		
	var autotestParamsTreeGrid = new Ext.tree.TreePanel({ 
		tbar:Ext.create('Ext.Toolbar',{
			items:[{
				text:'添加组',
				handler:function(){
					var submitForm = caseForm.getForm();
				  	if(caseId=='0'){
				  		Ext.Msg.alert("提示","请先保存用例信息");
				  		return;
				  	}
					Ext.Msg.prompt('添加组', '组名称', function(btn, text){
					    if (btn == 'ok'){
					    	var rootNode = autotestParamsStore.getNodeById(1);
							var newNode = {
								parentId:1,
								leaf:false,
								text:text,
								paramId:'',
								paramName:text,
								paramValue:'',
								isleaf:false,
								caseId:caseId
							};
							rootNode.appendChild(newNode);
							MaskLoading();
						    var store=autotestParamsStore;
							var records = store.getUpdatedRecords();
		       				var phantoms=store.getNewRecords();
		       				var deleteRecords = store.getRemovedRecords();
		        			records=records.concat(phantoms);
							var saveOrUpdateData = new Array(); 
							var deleteData = new Array();
		                    Ext.Array.each(records, function(record) {  
		                        saveOrUpdateData.push(record.data);  
		                    });
		                     Ext.Array.each(deleteRecords, function(record) {  
		                        deleteData.push(record.data);  
		                    });
		                    Ext.Ajax.request({
		                    	url:'<%=request.getContextPath()%>/saveAutotestParam.do',
		                    	params:{savedata:Ext.encode(saveOrUpdateData),deletedata:Ext.encode(deleteData)},
		                    	success:function(response,config){
				                    Ext.Array.each(records, function(record) {  
				                        record.commit();
				                    });  
				                    var rootNode = autotestParamsStore.getNodeById(1);
				                    autotestParamsStore.load(rootNode);
				                    Ext.data.StoreManager.lookup('inputValueSotre').reload();
				                    MaskOver();
		                    	},
		                    	failure:function(response,config){
		                    		MaskOver();
		                    		Ext.Msg.alert('提示','保存失败');
		                    	}
		                    });
					    }
				    });
				}
			},{
				text:'添加参数',
				handler:function(){
					var submitForm = caseForm.getForm();
				  	if(caseId=='0'){
				  		Ext.Msg.alert("提示","请先保存用例信息");
				  		return;
				  	}
					var selections = autotestParamsTreeGrid.getSelectionModel().getSelection();
					if(selections.length!=1||selections[0].raw.leaf==true){
						Ext.Msg.alert('提示','请选择参数组节点');
						return;
					}
					Ext.Msg.prompt('添加参数', '参数名称', function(btn, text){
					    if (btn == 'ok'){
							var newNode = {
								parentId:selections[0].raw.paramId,
								leaf:true,
								text:text,
								paramId:'',
								paramName:text,
								paramValue:'',
								isleaf:false,
								caseId:caseId
							};
							selections[0].appendChild(newNode);
						}
					});
				}
			},{
				text:'保存',
				handler:function(){
					var submitForm = caseForm.getForm();
				  	if(caseId=='0'){
				  		Ext.Msg.alert("提示","请先保存用例信息");
				  		return;
				  	}
				  	MaskLoading();
				  	var store=autotestParamsTreeGrid.getStore();
					var records = store.getUpdatedRecords();
       				var phantoms=store.getNewRecords();
       				var deleteRecords = store.getRemovedRecords();
        			records=records.concat(phantoms);
					var saveOrUpdateData = new Array(); 
					var deleteData = new Array();
                    Ext.Array.each(records, function(record) {  
                        saveOrUpdateData.push(record.data);  
                    });
                     Ext.Array.each(deleteRecords, function(record) {  
                        deleteData.push(record.data);  
                    });
                    Ext.Ajax.request({
                    	url:'<%=request.getContextPath()%>/saveAutotestParam.do',
                    	params:{savedata:Ext.encode(saveOrUpdateData),deletedata:Ext.encode(deleteData)},
                    	success:function(response,config){
                    		Ext.Msg.alert('提示','保存成功');
		                    Ext.Array.each(records, function(record) {  
		                        record.commit();
		                    });  
		                    var rootNode = autotestParamsStore.getNodeById(1);
		                    autotestParamsStore.load(rootNode);
		                    Ext.data.StoreManager.lookup('inputValueSotre').reload();
		                    MaskOver();
                    	},
                    	failure:function(response,config){
                    		MaskOver();
                    		Ext.Msg.alert('提示','保存失败');
                    	}
                    });
				}
			}]
		}),
		title: '参数集合',        
		width: screenWidth*0.982, 
		height: screenHeight*0.872, 
		cls: 'ui-formPanel',
		collapsible:true,
		collapsed : true,
		useArrows: true,
		titleCollapse: true,
		rootVisible: false,
		listeners:{
        	beforeexpand:function(p,animate,eOpts){
        		caseType.collapse();
        		caseForm.collapse();
        		autotestParamsTreeGrid.collapse();
        	}
        },
		plugins:[
			Ext.create('Ext.grid.plugin.CellEditing', {
            clicksToEdit: 2,
            listeners:{
            	beforeedit:function(e,eOpts){
            		var column = eOpts.field;
            		var data = eOpts.record.raw;
            		if(column=='paramName'){
            			return true;
            		}else if(column=='paramValue'){
            			if(data.leaf==true){
            				return true;
            			}else{
            				return false;
            			}
            		}else if(column=='paramDesc'){
            			if(data.leaf==true){
            				return true;
            			}else{
            				return false;
            			}
            		}else if(column=='exeSql'){
            			if(data.leaf==true){
            				return true;
            			}else{
            				return false;
            			}
            		}
            		return false;
            	}
            }
        })],  
		store: autotestParamsStore,     
		columns:[
			{text: '主键',flex: 2,dataIndex: 'paramId',hidden:true,sortable: false},
			{text: '父ID',flex: 2,dataIndex: 'parentId',hidden:true,sortable: false},
			{xtype: 'treecolumn',text: '参数名称',flex: 2,dataIndex: 'paramName',field: {xtype: 'textfield',allowBlank: false},sortable:false},
			{text: '参数说明',flex: 2,dataIndex: 'paramDesc',field: {xtype: 'textfield',allowBlank: false},sortable:false},
			{text: '取值SQL',flex: 2,dataIndex: 'exeSql',field: {xtype: 'textfield',allowBlank: false},sortable:false},
			{text: '参数值',flex: 2,dataIndex: 'paramValue',field: {xtype: 'textfield',allowBlank: false},sortable:false},
			{text: '是否为叶子节点',flex: 2,dataIndex: 'isleaf',hidden:true,sortable: false},
			{text: '用例主键',flex: 2,dataIndex: 'caseId',hidden:true,sortable: false},
			{header: "操作", width:50,menuDisabled: true,xtype:'actioncolumn',sortable:false,items: [{
        			icon:"<%=request.getContextPath()%>/aiga/label/image/del.gif",
        			id: 'delAutetestParam',  
					tooltip: '删除',  
					handler: function(treeGrid, rowIndex, colIndex) {
						var currentSotre=treeGrid.getStore().getAt(rowIndex);
						if(currentSotre==null){
							Ext.Msg.alert('提示','请选择组件树节点');
							return;
						}
						if(currentSotre.raw.leaf==false){
							Ext.MessageBox.confirm('提示','确定删除该目录吗?删除该目录将会删除该目录下所有的参数配置',function(optional){
								if(optional=='yes'){
									currentSotre.expand(true,function(){
										currentSotre.eachChild(function(node){
											node.remove();
										});
										currentSotre.remove();
									});
								}
							});
						}else{
							currentSotre.remove();
						}
					}  
        		}]}
		] 
	}); 
	
    Ext.create('Ext.panel.Panel', {
		renderTo:  Ext.getBody(),
		width: screenWidth*0.982,
		height: screenHeight,
		bodyBorder:0,
		listeners:{
			render : function(render,eOpts){
				MaskLoading();
				caseForm.load({
					params:{caseId:caseId},  
					url:'<%=request.getContextPath()%>/getCaseForm.do',
					method:'POST',  
					success:function(form,action){
						if(caseId=='0'||caseId==''){
							var currentStaff = '<%=user.getUserName()%>';
							var currentStaffNo = '<%=user.getUserAccount()%>';
							Ext.getCmp('caseForm').getForm().findField('author').setValue(currentStaff);
							Ext.getCmp('caseForm').getForm().findField('authorNo').setValue(currentStaffNo);
							Ext.getCmp('caseForm').getForm().findField('createTime').setValue(Ext.util.Format.date(new Date(),'Y-m-d H:i:s'));
							Ext.getCmp('caseForm').getForm().findField('updateTime').setValue(Ext.util.Format.date(new Date(),'Y-m-d H:i:s'));
							Ext.getCmp('caseForm').getForm().findField('latestOperator').setValue(currentStaff);
							Ext.getCmp('isProgressTestCheck').disable(true);
							Ext.getCmp('efficiency').disable(true);
						}else{
							var regressionTest = Ext.getCmp('caseForm').getForm().findField('regressionTest').getValue();
							var efficiencyTest = Ext.getCmp('caseForm').getForm().findField('efficiencyTest').getValue();
							if(regressionTest==null||regressionTest==''||regressionTest=='0')
								Ext.getCmp('isProgressTestCheck').disable(true);
							else{
								var val = caseForm.getForm().findField('testType').getValue();
								if (val.split) {
						            val = val.split(',');
						        }
						        Ext.getCmp('isProgressTestCheck').reset();
						        for (var i = 0; i < val.length; i++) {
						            Ext.getCmp('isProgressTestCheck').items.each(function (c) {
						                if (c.inputValue == val[i]) {
						                    c.setValue(true);
						                }
						            });
						        }
				        	}
				        	if(efficiencyTest==null||efficiencyTest==''||efficiencyTest=='0'){
				        		Ext.getCmp('efficiency').disable(true);
				        		Ext.getCmp('efficiency').setValue(null);
				        	}else{
				        		Ext.getCmp('efficiency').enable(true);
				        	}
				        }
						var sysLabelData = action.result.data.sysLabel;
						var ownLabelData = action.result.data.ownLabel;
						loadAutoLabel(sysLabelData,ownLabelData);
					    MaskOver();
					},  
					failure:function(form,action){  
						MaskOver();
						Ext.Msg.alert('提示',"请求数据失败");  
					}
				});
			}
		},
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
			items:[caseForm,caseType,autotestParamsTreeGrid]
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
				for(var i = 0; i <sysAry.length; i++) {
					addSysLabel(sysAry[i]);
				}
			}
			if(ownLabelData != null && ownLabelData != "") {
				var sysAry = ownLabelData.split(",");
				for(var i = 0; i <sysAry.length; i++) {
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