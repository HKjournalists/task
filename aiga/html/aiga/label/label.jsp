<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<html>
	<head>
		<title>标签库</title>
	</head>
	<body>
		<div id="base">
		</div>
	</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
Ext.onReady(function() {
Ext.QuickTips.init();
	var tbar = Ext.create("Ext.Toolbar", {
		items: [{ 
                text: '新增', 
                handler: function() { 
                    this.up('form').getForm().reset(); 
                } 
            }, { 
                text: '保存',
                handler: function() { 
                    if (this.up('form').getForm().isValid()) { 
					var basic = this.up('form').getForm(); 
					var selectNodes = Ext.getCmp("labelTree").getSelectionModel().getSelection();
					
					if(basic.findField('labelId').getValue()!=''){
						if(basic.findField('parentId').getValue()==''){
							basic.findField('parentId').setValue(selectNodes[0].raw.id);
						}
					}else{
						if(selectNodes.length==0){
							Ext.Msg.alert('提示',"请选择一个标签");  
							return;
						}else{
							basic.findField('parentId').setValue(selectNodes[0].raw.id);
						}
					}
					MaskLoading();
					basic.submit({  
	                    clientValidation: true,
	                    url: '<%=request.getContextPath()%>/saveLabel.do',  
	                    method:'POST',  
	                    success:function(){  
					MaskOver();
	                        Ext.Msg.alert('提示',"保存成功");
                        	Ext.getCmp('labelForm').getForm().reset();
                        	MaskLoading();
	                        Ext.Ajax.request({   
								url:"<%=request.getContextPath()%>/getLabelTree.do",  
								success:function(response,config){
									MaskOver();
									var treeJson=Ext.JSON.decode(response.responseText);
									Ext.getCmp('labelTree').setRootNode(treeJson.data.root);
								},
								failure:function(response,config){
									MaskOver();
									Ext.Msg.alert('提示',"刷新树结构失败");
								}
							});
	                    },
	                    failure:function(form,action){ 
					MaskOver();
		                	Ext.Msg.alert('提示',"保存失败,原因是: "+action.result.errorMessage);  
		                }   
	                });  
				} 
			} 
    	},
    	{
    		text: '删除',
    		handler: function() {
    			var labelId = this.up('form').getForm().findField('labelId').getValue();
    			if(labelId==null || labelId == "" || labelId == 0){
					Ext.Msg.alert('提示',"只能删除已保存的标签");  
					return;
				}
				var isLeaf = this.up('form').getForm().findField('isLeaf').getValue();
				if(isLeaf != "1") {
					Ext.Msg.alert('提示',"只能删除已叶子节点标签");  
					return;
				}
				MaskLoading();
				this.up('form').getForm().submit({  
                    clientValidation: true,
                    url: '<%=request.getContextPath()%>/deleteLabel.do',  
                    method:'POST',  
                    success:function(){  
				MaskOver();
                        Ext.Msg.alert('提示',"删除成功");
                        Ext.getCmp('labelForm').getForm().reset();
						MaskLoading();
                        Ext.Ajax.request({   
							url:"<%=request.getContextPath()%>/getLabelTree.do",  
							success:function(response,config){
									MaskOver();
								var treeJson=Ext.JSON.decode(response.responseText);
								Ext.getCmp('labelTree').setRootNode(treeJson.data.root);
							},
							failure:function(response,config){
									MaskOver();
								Ext.Msg.alert('提示',"刷新树结构失败");
							}
						});
                          
                    },
                    failure:function(form,action){
				MaskOver();
	                	Ext.Msg.alert('提示',"删除失败,原因是: "+action.result.errorMessage);  
	                }   
                });
				
    		}
    	},
    	{ 
	        text: '关联用例', 
	        handler: function() { 
	        	var selectNodes = Ext.getCmp("labelTree").getSelectionModel().getSelection();
				if(selectNodes.length==0){
					Ext.Msg.alert('提示',"请选择一个标签");  
					return;
				}
				var caseForm = Ext.widget('form', {
					tbar:Ext.create("Ext.Toolbar", {
						items: [{ 
			                text: '关联', 
			                handler: function() { 
			                    var caseNodes = Ext.getCmp("caseTree").getChecked();
			                    var labelNodes = Ext.getCmp("labelTree").getSelectionModel().getSelection();
			                    if(labelNodes.length==0){
			                    	Ext.Msg.alert('提示',"请选择要关联的标签");
			                    	return;
			                    }
			                    if(caseNodes.length==0){
				                    Ext.Msg.alert('提示',"请选择要关联的用例");
				                    return;
			                    }
			                    var labelId = labelNodes[0].raw.id;
			                    var caseIds = new Array();
			                    for(var i=0;i<caseNodes.length;i++){
			                    	if(caseNodes[i].raw.leaf==true)
			                    		caseIds.push(caseNodes[i].raw.id);
			                    }
			                    if(caseIds.length==0){
			                    	Ext.Msg.alert('提示',"请选择要关联的用例");
				                    	return;
			                    }
			                   	MaskLoading();
			                   	Ext.Ajax.request({   
								url:'<%=request.getContextPath()%>/saveCaseLabelRela.do?caseIds='+caseIds.join(',')+'&labelId='+labelId,  
								success:function(response,action){ 
									MaskOver();
				                        Ext.Msg.alert('提示',"保存成功"); 
				                        Ext.getCmp('caseWindow').hide(); 
				                        Ext.getCmp('caseWindow').close();
				                        gridStore.load({
											params: {labelId:labelId}
										});
				                    },
				                    failure:function(response,action){ 
									MaskOver();
					                	Ext.Msg.alert('提示',"保存失败,原因是: "+action.result.errorMessage);  
					                }   
				                });  
			                } 
			            }]
					}),
					id:'caseForm',
					width:'100%',
					height:'100%',
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
		                margins: '20 0 0 0' 
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
		                	name:"caseId",
		                	fieldLabel : "标签ID"
		                },{ 
		                	width: 220, 
		                    name: 'caseName', 
		                    fieldLabel: '用例名称', 
		                    allowBlank: false 
		                }, { 
		                    width: 220, 
		                    xtype: 'datefield', 
		                    name: 'createTime', 
		                    fieldLabel: '创建时间',
		                    allowBlank: false 
		                }, { 
		                	width: 220, 
		                	xtype: 'datefield', 
		                    name: 'updateTime', 
		                    fieldLabel: '更新时间', 
		                    allowBlank: false, 
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
			            	width: 220, 
			                xtype: 'textfield', 
			                name: 'author',
			                fieldLabel: '创建人', 
			                allowBlank: false 
			            }, { 
			            	width: 220, 
			                xtype: 'textfield', 
			                name:'latestOperator',
			                fieldLabel: '最后操作人', 
			                allowBlank: false 
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
			            	width: 660, 
			                xtype: 'textareafield', 
			                name:'caseDesc',
			                fieldLabel: '用例描述', 
			                allowBlank: false 
			            }]
			            }
					]
			}); 
				var caseTree = null;
				MaskLoading();
				Ext.Ajax.request({   
					url:"<%=request.getContextPath()%>/getCaseTree.do?isMutilSelect=true",  
					success:function(response,config){
						MaskOver();
						var caseTreeJson=Ext.JSON.decode(response.responseText);
						caseTree = Ext.create("Ext.tree.Panel", {   
							id:"caseTree",
        					cls: 'ui-formPanel',
						    width: 900*0.2*0.99,   
						    height: 600*0.99,   
						    title : "用例树",   
						    rootVisible : true,
						    useArrows: true,
						    autoScroll:true,
						    root: caseTreeJson.data.root,   
						    viewConfig : {   
						        loadingText : "加载数据..."  
						    },   
							listeners : {
								itemclick : function(thisView, record, htmlElementItem, indexNo){
									var caseId = record.raw.id;
									var basic = Ext.getCmp('caseForm');  
					                basic.load({
					                    params:{caseId:caseId},  
					                    url:'<%=request.getContextPath()%>/getCaseForm.do',
					                    method:'POST',  
					                    success:function(form,action){  
					                    	
					                    },  
					                    failure:function(form,action){  
					                        Ext.Msg.alert('提示',"失败原因是: "+action.result.errorMessage);  
					                    }  
					                });  
								},
								checkchange:function( node, checked, eOpts ){
									var changeTreeCheck = function(node,checked,eOpts ){
										node.set("checked",checked);
										changeChildCheck(node,checked,eOpts );
									};
									
									var changeChildCheck = function(node,checked,eOpts ){
										var childNodes = node.childNodes;
										for(var i=0;i<childNodes.length;i++){
											childNodes[i].set("checked",checked);
											changeChildCheck(childNodes[i],checked,eOpts );
										}
									};
									changeTreeCheck( node, checked, eOpts );
								}      
							}
						}); 
						var caseWindow = new Ext.window.Window({
							id:'caseWindow',
							title: '用例库',
							resizable:false,
							shadow:true,
							modal:true,
							closable:true,
						    width: 915*0.99,
						    height: 600*0.99,
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
						        items:[caseTree]
						    }, {
						        region: 'center',
						        items:[caseForm]
						    }]
						}); 
						caseWindow.show();
			        },
			        failure:function(){
			        	MaskOver();
			        	Ext.Msg.alert('提示',"加载失败"); 
			        }   
			    });
	        }
        }]
	});
	var labelForm = Ext.create('Ext.form.Panel', {
			id:'labelForm',
       		cls: 'ui-formPanel',
			tbar:tbar,
			width: 750,
			height: 280,
			title:'标签', 
            layout: { 
                type: 'vbox'
            }, 
            fieldDefaults: { 
                labelAlign: 'right', 
                labelWidth: 100, 
                labelStyle: 'font-weight:bold' 
            }, 
            defaults: { 
                margins: '20 0 10 -10' 
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
                	name:"labelId",
                	fieldLabel : "标签ID"
                },{
                	xtype: "hidden",
                	name:"isLeaf",
                	fieldLabel : "标签ID"
                },{
                	xtype: "hidden",
                	name:"parentId",
                	fieldLabel : "父标签ID"
                },{ 
                	width: 250, 
                    name: 'labelName', 
                    fieldLabel: '标签名称', 
                    allowBlank: false 
                },{
	            	width: 250, 
	                xtype: 'datefield', 
	                name: 'createTime',
	                fieldLabel: '创建时间', 
	                allowBlank: false 
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
	            	width: 750, 
	                xtype: 'textareafield', 
	                name:'labelDesc',
	                fieldLabel: '标签描述', 
	                allowBlank: false 
	            }]
	            }
			]
	}); 
	
	var caseModel = Ext.regModel("caseModel",{
		fields:[
			{name:'caseId',type:'string'},
			{name:'caseName',type:'string'},
			{name:'caseDesc',type:'string'},
			{name:'createTime',type:'string'},
			{name:'updateTime',type:'string'},
			{name:'author',type:'string'},
			{name:'latestOperator',type:'string'}]
	});
	
	var gridProxy = new Ext.data.proxy.Ajax({
			type:"ajax",
			model:caseModel,
			url:'<%=request.getContextPath()%>/getCaseTable.do',
			reader:{
				root:"data",
				type:"json"
			}
		});
	var gridStore = Ext.create('Ext.data.Store',{
		model:caseModel,
		proxy:gridProxy
	});
	
	gridStore.load({
		params: {labelId:0}
	});
	
	var caseGrid = Ext.create('Ext.grid.Panel',{
		tbar:Ext.create("Ext.Toolbar",{
			items:[{
				text:'删除关联',
				handler:function(){
					var cell = caseGrid.getSelectionModel().getSelection();
					if(cell.length==0){
						Ext.Msg.alert('提示',"请选择一条要删除的关联");
						return; 
					}
					var caseIds = new Array();
					for(var i=0;i<cell.length;i++){
						caseIds.push(cell[i].raw.caseId);
					}
					var labelNodes = Ext.getCmp("labelTree").getSelectionModel().getSelection();
					if(labelNodes.length==0){
						Ext.Msg.alert('提示',"请选择标签");
						return;
					}
					var labelId = labelNodes[0].raw.id;
					MaskLoading();
					Ext.Ajax.request({   
						url:"<%=request.getContextPath()%>/deleteCaseLabelRela.do?caseIds="+caseIds.join(',')+"&labelId="+labelId,  
						success:function(response,config){
							MaskOver();
							gridStore.load({
								params: {labelId:labelId}
							});
							Ext.Msg.alert('提示',"删除成功");
						},
						failure:function(response,config){
							MaskOver();
				        	Ext.Msg.alert('提示',"删除失败"); 
				        }
			        });
				}
			}]
		}),
		id:'caseGrid',
        cls: 'ui-formPanel',
		title:'关联用例',
		height: 230,
	    width: 750,
		viewConfig:{
			forctFit:true,
			stripeRows:true
		},
		store:gridStore,
		selModel:Ext.create("Ext.selection.CheckboxModel",{mode:"SIMPLE"}),
		columns:[
			new Ext.grid.RowNumberer(),
			{header:"主键",width:100,dataIndex:"caseId",sortable:true,hidden:true},
			{header:"用例名称",width:100,dataIndex:"caseName",sortable:true},
			{header:"用例描述",width:100,dataIndex:"caseDesc",sortable:true},
			{header:"创建时间",width:100,dataIndex:"createTime",sortable:true},
			{header:"更新时间",width:100,dataIndex:"updateTime",sortable:true},
			{header:"创建人",width:100,dataIndex:"author",sortable:true},
			{header:"最新操作人",width:100,dataIndex:"latestOperator",sortable:true}]
	});
	
	var labelTree = null;
	MaskLoading();
	Ext.Ajax.request({   
		url:"<%=request.getContextPath()%>/getLabelTree.do",  
		success:function(response,config){ 
			MaskOver();
			var treeJson=Ext.JSON.decode(response.responseText);
			labelTree = Ext.create("Ext.tree.Panel", {   
				id:"labelTree",
        		cls: 'ui-formPanel',
			    width: 200,   
			    height: 600,   
			    title : "标签树",   
			    rootVisible : true,
			    useArrows: true,
			    autoScroll:true,
			    root: treeJson.data.root,   
			    viewConfig : {   
			        loadingText : "加载数据..."  
			    },   
				listeners : {
					itemclick : function(thisView, record, htmlElementItem, indexNo){
						var labelId = record.raw.id;
						var basic = Ext.getCmp('labelForm');  
		                basic.load({
		                    params:{labelId:labelId},  
		                    url:'<%=request.getContextPath()%>/getLabel.do',  
		                    method:'POST',  
		                    success:function(form,action){  
		                    	gridStore.reload({params:{labelId:labelId}});
		                    },  
		                    failure:function(form,action){  
		                        Ext.Msg.alert('提示',"失败原因是: "+action.result.errorMessage);  
		                    }  
		                });  
					}       
				}
			});  
			
			Ext.create('Ext.Panel', {
			    renderTo: Ext.get('base'),
			    width: 960,
			    height: 510,
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
			        items:[labelTree]
			    }, {
			        region: 'center',
			        items:[labelForm,caseGrid]
			    }]
			}); 
        },
        failure:function(){
        	MaskOver();
        	Ext.Msg.alert('提示',"加载失败"); 
        }   
    });  
});
</script>
</html>