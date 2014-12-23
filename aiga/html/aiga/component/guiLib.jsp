<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");%>
<html>
<head>
	<title>组件库</title>
</head>
<body>
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;

function rightClickTree(view,record,item,index,e,eOpts){
	 e.preventDefault();
	 var treeNode=Ext.getCmp('guiTree').getSelectionModel().getSelection();
     if(treeNode.length==0){
       	Ext.Msg.alert('提示','请选择控件');
       	return;
     }
     if(treeNode[0].raw.leaf==false){
     	Ext.getCmp('addGui').setVisible(true);
		Ext.getCmp('addFolder').setVisible(true);
		Ext.getCmp('delFolder').setVisible(true);
		Ext.getCmp('editFolder').setVisible(true);
	 }else if(treeNode[0].raw.leaf==true){
		return;
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
   			var treeNode=Ext.getCmp('guiTree').getSelectionModel().getSelection();
         	if(treeNode.length==0){
         		Ext.Msg.alert('提示','请选择控件树节点');
         		return;
         	}
         	if(treeNode[0].raw.leaf==true){
         		Ext.Msg.alert('提示','请选择控件树非叶子节点');
         		return;
         	}
         	Ext.Msg.prompt('新增目录', '目录名称', function(btn, text){
			    if (btn == 'ok'){
			    	var treeNode=Ext.getCmp('guiTree').getSelectionModel().getSelection();
					var folderName = text;
					if(folderName==null||folderName=='')
						return;
					MaskLoading();
					Ext.Ajax.request({
						url:'<%=request.getContextPath()%>/saveGuiFolder.do',
						params:{folderName:folderName,guiId:treeNode[0].raw.id},
						success:function(response,config){
								MaskOver();
							Ext.Msg.alert("提示","保存成功");
							var parentId = treeNode[0].raw.id; 
			                var node =Ext.data.StoreManager.lookup('guiTreeStore').getNodeById(parentId);   
	   						Ext.data.StoreManager.lookup('guiTreeStore').load({node:node});
						},
						failure:function(response,config){
								MaskOver();
							Ext.Msg.alert("提示","请求数据失败");
						}
					});
			    }
			});
   		}
   	},{
   		id:'delFolder',
   		text:'删除目录',
   		handler:function(){
   			var treeNode=Ext.getCmp('guiTree').getSelectionModel().getSelection();
   			if(treeNode[0].hasChildNodes()==true){
   				Ext.Msg.alert('提示','该目录并不为空，不可删除');
				return;
   			}
			if(treeNode.length==0){
				Ext.Msg.alert('提示','请选择控件树节点');
				return;
			}
			if(treeNode[0].raw.leaf==true){
				Ext.Msg.alert('提示','请选择控件树非叶子节点');
				return;
			}
			var folderName = treeNode[0].raw.text;
					MaskLoading();
			Ext.Ajax.request({
				url:'<%=request.getContextPath()%>/deleteGuiFolder.do',
				params:{folderName:folderName,guiId:treeNode[0].raw.id},
				success:function(response,config){
								MaskOver();
					Ext.Msg.alert("提示","删除成功");
					var parentId = treeNode[0].raw.parentId; 
			        var node =Ext.data.StoreManager.lookup('guiTreeStore').getNodeById(parentId);   
	   				Ext.data.StoreManager.lookup('guiTreeStore').load({node:node});
				},
				failure:function(response,config){
								MaskOver();
					Ext.Msg.alert("提示","请求数据失败");
				}
			});
   		}
   	},{
   		id:'editFolder',
   		text:'编辑目录',
   		handler:function(){
   			var treeNode=Ext.getCmp('guiTree').getSelectionModel().getSelection();
		 	if(treeNode.length==0){
				Ext.Msg.alert('提示','请选择控件树节点');
			    return;
			}
			if(treeNode[0].raw.leaf==true){
				Ext.Msg.alert('提示','请选择控件树非叶子节点');
				return;
			}
   			Ext.Msg.prompt('编辑目录', '目录名称', function(btn, text){
   				if (btn == 'ok'){
					var folderName = text;
					if(folderName==null||folderName=='')
						return;
					MaskLoading();
					Ext.Ajax.request({
						url:'<%=request.getContextPath()%>/editGuiFolder.do',
						params:{folderName:folderName,guiId:treeNode[0].raw.id},
						success:function(response,config){
								MaskOver();
							Ext.Msg.alert("提示","编辑成功");
							var parentId = treeNode[0].raw.parentId;
			                var node =Ext.data.StoreManager.lookup('guiTreeStore').getNodeById(parentId);   
	   						Ext.data.StoreManager.lookup('guiTreeStore').load({node:node});
						},
						failure:function(response,config){
								MaskOver();
							Ext.Msg.alert("提示","请求数据失败");
						}
					});
			    }
			},undefined,undefined,treeNode[0].raw.text);
   		}
   	},{
       	id:'addGui',
       	icon:'<%=request.getContextPath()%>/aiga/userCase/image/add.gif',
       	text:'新增控件',
       	handler:function(){
       		var treeNode=Ext.getCmp('guiTree').getSelectionModel().getSelection();
         	if(treeNode.length==0){
         		Ext.Msg.alert('提示','请选择控件树节点');
         		return;
         	}
         	if(treeNode[0].raw.leaf==true){
         		Ext.Msg.alert('提示','请选择控件树非叶子节点');
         		return;
         	}
         	Ext.getCmp('guiForm').getForm().reset();
         	Ext.getCmp('guiForm').getForm().findField('guiLatestOperator').setValue('<%=user.getUserName()%>');
        	Ext.getCmp('guiForm').getForm().findField('guiUpdateTime').setValue(Ext.util.Format.date(new Date(),'Y-m-d H:i:s'));
         	Ext.getCmp('guiForm').getForm().findField('guiAuthor').setValue('<%=user.getUserName()%>');
         	Ext.getCmp('guiForm').getForm().findField('guiCreateTime').setValue(Ext.util.Format.date(new Date(),'Y-m-d H:i:s'));
         	Ext.getCmp('guiForm').getForm().findField('parentId').setValue(treeNode[0].raw.id);
       	}
	}]
});
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.tip.QuickTipManager.init();
	
	var guiForm = Ext.widget('form', {
		tbar:Ext.create('Ext.Toolbar',{
			items:[{
				text:'保存',
				handler:function(){
					var selectNodes = Ext.getCmp('guiTree').getSelectionModel().getSelection();
					if(selectNodes.length==0){
						Ext.Msg.alert('提示','请选择控件');
						return;
					}
					guiForm.getForm().findField('isLeaf').setValue('Y');
					guiForm.getForm().findField('guiUpdateTime').setValue(Ext.util.Format.date(new Date(),'Y-m-d H:i:s'));
					guiForm.getForm().findField('guiLatestOperator').setValue('<%=user.getUserName()%>');
					MaskLoading();
					guiForm.submit({
						url:'<%=request.getContextPath()%>/saveGuiForm.do',
						method:'POST',  
						success:function(form,action){
							MaskOver();
							Ext.Msg.alert('提示','保存成功');
							if(selectNodes[0].raw.leaf==false){
								var parentId = selectNodes[0].raw.id;
				                var node =Ext.data.StoreManager.lookup('guiTreeStore').getNodeById(parentId);   
		   						Ext.data.StoreManager.lookup('guiTreeStore').load({node:node});
							}else{
								var parentId = selectNodes[0].raw.parentId;
				                var node =Ext.data.StoreManager.lookup('guiTreeStore').getNodeById(parentId);   
		   						Ext.data.StoreManager.lookup('guiTreeStore').load({node:node});
							}
						},
						failure:function(form,action){
							MaskOver();
							Ext.Msg.alert('提示','保存失败');
						}
					});
				}
			}]
		}),
		id:'guiForm',
		width:screenWidth*0.8*0.998,
		height:screenHeight*0.99,
		title:'控件', 
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
			margins: '10 0 10 0' 
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
		    	xtype: "hidden",
		    	name:"isLeaf",
		    	fieldLabel : "是否为叶子节点"
		    },{
		    	xtype: "hidden",
		    	name:"guiId",
		    	fieldLabel : "控件名ID"
		    },{
		    	xtype: "hidden",
		    	name:"parentId",
		    	fieldLabel : "父组件ID"
		    },{ 
		    	width: 250, 
		    	name: 'guiName', 
		        fieldLabel: '控件名称', 
		        allowBlank: false
		    }, { 
		    	xtype:'combo',
		    	width: 250, 
		        name: 'guiPermission',
		        fieldLabel: '控件审批',
		        allowBlank: false,
		        store:Ext.create('Ext.data.Store', {
					fields:['value','text'],
			        data:[
			            	{'value':0,'text':'通过'},
			            	{'value':1,'text':'不通过'}
			            ]
					}),
		           displayField:'text',
		           valueField:'value',
		           mode:'local',
		           emptyText:'请选择'
		    }, { 
		    	width: 250, 
		        name: 'guiSelector', 
		        fieldLabel: '控件Selector',
		        allowBlank: false 
		    }] 
		 }, { 
				xtype: 'fieldcontainer', 
			    labelStyle: 'font-weight:bold;padding:0', 
			    layout: 'hbox', 
			    defaultType: 'textfield', 
			    fieldDefaults: { 
			    	labelAlign: 'right' 
			    }, 
				items:[
				    {
					    	width: 250, 
					        name: 'guiUrl',
					        fieldLabel: '控件gui'
					},
				{ 
			        width: 250, 
			        name:'guiTag',
			        fieldLabel: '控件Tag',
			        allowBlank: false 
			    }, { 
			        width: 250, 
			        name:'guiPath',
			        fieldLabel: '控件path'
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
				{
			    	width: 250, 
			        name: 'guiExtra',
			        fieldLabel: '控件extra'
			    }, { 
			        width: 250, 
			        name:'guiCreateTime',
			        xtype:'datefield',
			        fieldLabel: '创建时间',
			        readOnly:true
			    },
				{ 
			        width: 250, 
			        xtype:'datefield',
			        name:'guiUpdateTime',
			        fieldLabel: '更新时间',
			        readOnly:true
			    }
			    ]
		},{ 
				xtype: 'fieldcontainer', 
			    labelStyle: 'font-weight:bold;padding:0', 
			    layout: 'hbox', 
			    defaultType: 'textfield', 
			    fieldDefaults: { 
			    	labelAlign: 'right' 
			    }, 
				items:[
				{
			    	width: 250, 
			        name: 'guiAuthor',
			        fieldLabel: '控件作者'
			    },
			    {
			    	width: 250, 
			        name: 'guiBounds',
			        fieldLabel: '控件Bounds'
			    },
			    {
			    	width: 250, 
			        name: 'guiHashcode',
			        fieldLabel: '控件hashCode'
			    }]
		},
		{ 
				xtype: 'fieldcontainer', 
			    labelStyle: 'font-weight:bold;padding:0', 
			    layout: 'hbox', 
			    defaultType: 'textfield', 
			    fieldDefaults: { 
			    	labelAlign: 'right' 
			    }, 
				items:[
				{ 
			        width: 250, 
			        name:'guiLatestOperator',
			        fieldLabel: '最后操作人'
			    }]
		},
		{ 
				xtype: 'fieldcontainer', 
			    labelStyle: 'font-weight:bold;padding:0', 
			    layout: 'hbox', 
			    defaultType: 'textfield', 
			    fieldDefaults: { 
			    	labelAlign: 'right' 
			    }, 
				items:[{
					xtype:'textareafield',
			    	width: 750, 
			    	height:50,
			        name: 'guiHtml',
			        fieldLabel: '控件Html', 
			        allowBlank: false 
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
				width: 750, 
				height:50,
			    xtype: 'textareafield', 
			    name:'guiDesc',
			    fieldLabel: '控件描述', 
			    allowBlank: false 
			}]
		}]
	});
	
	var guiTreeStore = Ext.create('Ext.data.TreeStore', { 
		id:'guiTreeStore', 
		proxy: {
			type: "ajax",
			url: "<%=request.getContextPath()%>/getAllGuiTreeSyn.do"
		},
		root: {
			id:'1',
			text: '控件',
			expanded: true,
			leaf:false
		},
		reader: { 
			type: 'json', 
			root: 'children' 
		} 
    });
	var guiTree = Ext.create('Ext.tree.Panel',{
		id:'guiTree',
        cls: 'ui-formPanel',
		title: '控件树',
		width: screenWidth*0.2*0.99,
		rootVisible: true,
		height: screenHeight*0.99,
		store: guiTreeStore,
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
        	itemclick : function(thisView, record, htmlElementItem, indexNo){
        		if(record.raw.leaf==true){
        			var guiId = record.raw.id;
        			if(guiId==null||guiId.length==0){
        				Ext.Msg.alert("提示","请选择控件");
        			}
        			guiForm.load({
        				url:'<%=request.getContextPath()%>/getGuiFormById.do',
        				params:{guiId:guiId},
        				method:'POST',
        				success:function(form,action){
        					
        				},
        				failure:function(form,action){
        					Ext.Msg.alert('提示',"失败原因是: "+action.result.errorMessage);
        				}
        			});
        		}else
        			Ext.getCmp('guiForm').getForm().reset();
        	},
        	itemcontextmenu : rightClickTree
        }
	});
	
	Ext.create('Ext.Panel', {
		renderTo: Ext.getBody(),
        cls: 'ui-formPanel',
		width: screenWidth*0.998,
		height: screenHeight*0.99,
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
			region: 'west',
			items:[guiTree]
		}, {
			region: 'center',
			items:[guiForm]
		}]
    });
});
</script>
</html>