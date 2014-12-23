<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<%
	String subTaskId = "";
	try{
		subTaskId = request.getParameter("subTaskId");
	}catch(Exception e){
		
	}
	String contentsType="";
	try{
		contentsType = request.getParameter("contentsType");
	}catch(Exception e){
		
	}
%>
<html>
<head>
	<title>集团用例</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/aiga/workflow/testTask/ajaxFileUpload/ajaxfileupload.js"></script>
</head>
<body id="CaseBody">
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;

Ext.onReady(function(){
	
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
	
	var groupCaseTreeStore = Ext.create('Ext.data.TreeStore', { 
		id:'groupCaseTreeStore',
		autoLoad:false,
		proxy: {
			type: "ajax",
		    <%if(subTaskId!=null&&!subTaskId.equals("")){%>
		    url: "<%=request.getContextPath()%>/getGroupCaseTree.do?subTaskId=<%=subTaskId%>"
		    <%}else{%>
			url: "<%=request.getContextPath()%>/getGroupCaseTree.do"
		    <%}%>
		},
		root: {
			id:'-1',
			text: '集团用例',
			expanded: true
		},
		reader: { 
			type: 'json', 
			root: 'children' 
		} 
    });
	var groupCaseTree = Ext.create('Ext.tree.Panel',{
		id:'groupCaseTree',
        cls: 'ui-formPanel',
		width: screenWidth*0.2,
		rootVisible: true,
		height: screenHeight*0.99,
		store: groupCaseTreeStore,
		useArrows: true,
		viewConfig : {  
			loadingText : "加载数据..."
		},
		animate:true,
        autoScroll:true,
        containerScroll:true,
        frame:false,
        listeners:{
        	itemdblclick : function(thisView,record,htmlElementItem,indexNo){
				if(record.raw.leaf==true){
		   			var caseId = record.raw.id;
		   			if(caseId==null||caseId.length==0){
		   				Ext.Msg.alert("提示","请选择用例");
		   			}
		   			caseForm.load({
		   				url:'<%=request.getContextPath()%>/getGroupCase.do',
		   				params:{caseId:caseId},
		   				method:'POST',
		   				success:function(form,action){
		   					if(action.result.data.isNeedMessage==1){
		   						Ext.getCmp('isNeedMessage').setValue(1);
		   					}else{
		   						Ext.getCmp('isNeedMessage').setValue(0);
		   					}
			                <%if(request.getParameter("contentsType")!=null&&!request.getParameter("contentsType").equals("")){%>
			                var contentsType = <%=request.getParameter("contentsType")%>;
			                var fieldAry = Ext.getCmp('caseForm').getForm().getFields();
							for(var i = 0; i < fieldAry.length; i++) {
								if(contentsType==1){//内容
									if(fieldAry.get(i).getName()=="isDelete"||fieldAry.get(i).getName()=="isNeedMessage")
										fieldAry.get(i).setReadOnly(true);
								}else if(contentsType==2){//报文
									if(fieldAry.get(i).getName()=="isNeedMessage")
										continue;
									fieldAry.get(i).setReadOnly(true);
								}else if(contentsType==3){//状态
									if(fieldAry.get(i).getName()=="isDelete")
										continue;
									fieldAry.get(i).setReadOnly(true);
								}else{
						  			fieldAry.get(i).setReadOnly(true);
								}
					  		}
			                <%}%>
		   				},
		   				failure:function(form,action){
		   					MaskOver();
		   					Ext.Msg.alert('提示',"失败原因是: "+action.result.errorMessage);
		   				}
		   			});
		   		}else
		   			Ext.getCmp('caseForm').getForm().reset();
			}
        }
	});
	var caseForm = Ext.create('Ext.form.Panel', {
		tbar:Ext.create('Ext.Toolbar',{
			items:[{
				text:'保存',
				handler:function(){
					var selectNodes = Ext.getCmp('groupCaseTree').getSelectionModel().getSelection();
					if(selectNodes.length==0){
						Ext.Msg.alert('提示','请选择用例');
						return;
					}
					var leaf =[];
	                Ext.each(selectNodes, function (item) {
	                    leaf.push(item.data.leaf);
	                })
					if(!leaf[0]){
						Ext.Msg.alert('提示','请选择需要修改的用例,不要点选非叶子结点(非用例)!');
						return;
					}
					caseForm.getForm().findField('isLeaf').setValue('Y');
	                MaskLoading();
	                caseForm.submit({
	                	clientValidation: true,
						params:{contentsType:'<%=request.getParameter("contentsType")%>',subTaskTag:'<%=request.getParameter("subTaskTag")%>'}, 
	                    url: "<%=request.getContextPath()%>/saveGroupCase.do",
	                    method: 'POST',
	                	success:function(response,config){ 
	                    	MaskOver();//把这外面的“数据处理中”关闭
			  				Ext.Msg.alert('提示','保存成功');
	                    	caseForm.load({
								params:{caseId:selectNodes[0].raw.id},  
								url:'<%=request.getContextPath()%>/getGroupCase.do',
								method:'POST',  
								success:function(form,action){
									MaskOver();
									if(selectNodes[0].data.leaf){//是叶子结点则获取其父级结点Id
										var subTypeNodeId = selectNodes[0].data.parentId;
										var tempStore = Ext.data.StoreManager.lookup('groupCaseTreeStore');
									    var subTypeNode =tempStore.getNodeById(subTypeNodeId);//获取父级结点(系统子类ID)
									    var reqTypeNodeId = subTypeNode.data.parentId;//获取父级结点的Id(集团联调需求单编号ID)
									    var reqTagNode =tempStore.getNodeById(reqTypeNodeId);//获取父级结点(集团联调需求单ID)
									    var yearMonthNodeId = reqTagNode.data.parentId;//获取父级结点的Id(年月)
							   			tempStore.load({params:{subTypeNodeId:subTypeNodeId,reqTypeNodeId:reqTypeNodeId,yearMonthNodeId:yearMonthNodeId}});
									}else{//不是叶子结点则获取当前结点的Id
										//parentId = selectNodes[0].raw.id;
										Ext.Msg.alert('提示','数据存在错误,请手动刷新页面!');
									}
								},  
								failure:function(form,action){
									MaskOver();  
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
		width:screenWidth*0.8,
		height:screenHeight*0.99,
		title:'集团联调用例',
        cls: 'ui-formPanel',
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
			    fieldDefaults: {
			    	labelAlign: 'right',
                    labelWidth: 120
			    },
			    items: [{
				    	xtype: "combo",
				        width: 450,
                        labelWidth:200,
					    forceSelection:true,
				        typeAhead:true,
	      				labelAlign: 'right',
	                    id: "isDeleteCombox",
	                    store: isDeleteStore,
	                    name: "isDelete",
	                    fieldLabel: "用例状态",
	      				allowBlank: false,
	                    valueField: 'value',
	                    displayField: 'show',
		                triggerAction: 'all',
		                queryMode: 'local',
		                minChars:1,
		                selectOnFocus: true,
			            mode:'local',
			            value:''
                    },{ 
						xtype: "checkbox",
                        width:450,
			    		labelAlign : 'right',
                        checked:false,
                        boxLabelAlign:'before',
                        boxLabel: '是否需要造报文:',
                        name: 'isNeedMessage',
                        id: "isNeedMessage"
			    }] 
			},{
				xtype: 'fieldcontainer', 
			    labelStyle: 'font-weight:bold;padding:0',
			    layout: 'hbox',
			    defaultType: 'textfield',
			    fieldDefaults: {
			    	labelAlign: 'right'
			    },
			    items: [
			    	{ 
						width: 450,
						height:100, 
					    xtype: 'textareafield', 
				    	name: 'caseName', 
				        fieldLabel: '用例名称', 
				        allowBlank: false,
				        emptyText:'请填写用例名称'
				    },{
						width: 450,
						height:100, 
					    xtype: 'textareafield', 
					    name:'preResult',
					    fieldLabel: '预期结果', 
					    allowBlank: false,
					    emptyText:'请填写预期结果'
					},{
				    	xtype: "hidden",
				    	name:"caseId"
				    },{
				    	xtype: "hidden",
				    	name:"createTime"
				    },{
				    	xtype: "hidden",
				    	name:"creatorId"
				    },{
				    	xtype: "hidden",
				    	name:"creatorName"
				    },{
				    	xtype: "hidden",
				    	name:"parentId"
				    },{
				    	xtype: "hidden",
				    	name:"isLeaf",
				    	fieldLabel : "是否为叶子节点"
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
						width: 450,
						height:100, 
					    xtype: 'textareafield', 
					    name:'caseDesc',
					    fieldLabel: '用例描述', 
					    allowBlank: false,
					    emptyText:'请填写用例描述'
					},{
						width: 450,
						height:100, 
					    xtype: 'textareafield', 
					    name:'testPurpose',
					    fieldLabel: '测试目的', 
					    allowBlank: false,
					    emptyText:'请填写测试目的'
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
						width: 450,
						height:100, 
					    xtype: 'textareafield', 
					    name:'preCondition',
					    fieldLabel: '预置条件', 
					    allowBlank: false,
					    emptyText:'请填写预置条件'
					},{
						width: 450,
						height:100, 
					    xtype: 'textareafield', 
					    name:'testDataDesc',
					    fieldLabel: '测试数据描述', 
					    allowBlank: false,
					    emptyText:'请填写测试数据描述'
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
					width: 900,
					height:100, 
				    xtype: 'textareafield', 
				    name:'remark',
				    fieldLabel: '备注', 
				    emptyText:'请填写备注'
			}]
		}]
	});
	Ext.create('Ext.panel.Panel', {
		renderTo:  Ext.get('CaseBody'),
		width: screenWidth*0.99,
		height: screenHeight,
		bodyBorder:0,
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
		items: [
			{
				region: 'west',
				items:[groupCaseTree]
			},{
				region: 'center',
				items:[caseForm]
		}]
	});
});
</script>

</html>