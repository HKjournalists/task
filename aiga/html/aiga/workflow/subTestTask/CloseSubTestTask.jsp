<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");%>
<html>
	<head>
		<title>测试子任务关闭</title>
	</head>
	<body style="padding: 0px;">
	 <jsp:include page="/aiga/common/common.jsp"></jsp:include>
	<form style="display:none;" id="exportForm" action="<%=request.getContextPath()%>/downloadTestReport.do"
			enctype="multipart/form-data" method="post" target="temp">
			<input type="hidden" name="method" value="export" />
			<input type="submit" id="download" class="tmpBtn" value="下载" />
		</form>
    </body>
    <script type="text/javascript">
    	var screenWidth = document.documentElement.clientWidth;
		var screenHeight = document.documentElement.clientHeight;
    	Ext.onReady(function(){
            Ext.QuickTips.init();
            Ext.tip.QuickTipManager.init();
            Ext.regModel('extCommboModel', {
			    fields: [
			        {type: 'string', name: 'value'},
			        {type: 'string', name: 'text'}
			    ]
			});
			var possible = new Ext.data.Store({
				autoLoad: true,
				id: 'possible',
				fields: ['value','show'],
				proxy: {
			    	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=possible'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			   }
			});
			possible.load();
			var isPerformanceStore = new Ext.data.Store({
			 	autoLoad: true,
			 	id: 'isPerformanceStore',
			    fields: ['value','show'],
			    proxy: {
			    	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=req_performance'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			    }
			});
			var priority = new Ext.data.Store({
			 	autoLoad: true,
			 	id: 'priority',
			    fields: ['value','show'],
			    proxy: {
			    	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=req_priority'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			    }
			});
			 var StaffRoleViewModel = Ext.define('StaffRoleViewModel', {
	                extend: 'Ext.data.Model',
	                fields: [{
	                        name: 'staffId',
	                        type: 'string'
	                    },{
	                        name: 'staffCode',
	                        type: 'string'
	                    }, {
	                        name: 'staffName',
	                        type: 'string'
	                    }, {
	                        name: 'roleCode',
	                        type: 'string'
	                    }, {
	                        name: 'organizeId',
	                        type: 'string'
	                    }, {
	                        name: 'organizeName',
	                        type: 'string'
	                    }, {
	                        name: 'parentOrganizeId',
	                        type: 'string'
	                    }, {
	                        name: 'staffWorkdayCoefficient',
	                        type: 'int'
	                    }
	                ]
	            });
			  var StaffRoleViewStore = new Ext.data.Store({
	                id: 'StaffRoleViewStore',
	                model: StaffRoleViewModel,
	                proxy: {
	                    type: 'ajax',
	                    url: '<%=request.getContextPath()%>/getStaffGiveViews.do?roleCode=WF_TEST_CHD',
	                    reader: {
	                        type: 'json',
	                        root: 'data'
	                    }
	                },
	                listeners: {
	                	load:function(store,records,successful,eOpts){
	                		  StaffRoleViewStore.each(function(record){
					              record.set('displayName',record.get('staffCode')+':'+record.get('staffName'));
				                 });
	                		  var rs = Ext.create("EmptyStaff");
	                            store.insert(0,rs); 
	                	}
	                	
	                }
	            });
	            StaffRoleViewStore.load({params:{roleCode:'WF_TEST_CHD'}});
	            
	            
	            
	            
	            
	            
	            
	            
	        	var testorStore = Ext.create('Ext.data.Store', {
				    id: 'testorStore',
					model:StaffRoleViewModel,
					proxy:Ext.create('Ext.data.proxy.Ajax',{
						type:"ajax",
						model:"extCommboModel",
						url:'<%=request.getContextPath()%>/getStaffRoleViews.do?roleCode=WF_TEST_PFR',
						reader:{
							root:"data",
							type:"json"
						}
					}),
			       listeners:{
	                      load : function(store, records, options ){
	        	               testorStore.each(function(record){
					           record.set('displayName',record.get('staffCode')+':'+record.get('staffName'));
				            });
	            	      var rs = Ext.create("EmptyStaff");
	                      store.insert(0,rs);  
	                      return true;
	                     }
			        }
				});
				testorStore.load();
	            var StaffRoleViewComboBox = new Ext.form.ComboBox({
	                width: 220,
	                store: StaffRoleViewStore,
	                name: "creator",
	                fieldLabel: '子任务派发人',
	                forceSelection:true,
		            typeAhead:true,
		            minChars:1,
		            selectOnFocus: true,
		            triggerAction: 'all',
		            queryMode: 'local',
	                valueField: 'staffId',
	                displayField: 'displayName',
	                editable:true,
	                	listConfig: {
	                }
	            });
			 var workflowParamStore = new Ext.data.Store({
	                id: 'workflowParamStore',
	                fields: ['linkId', 'phaseId', 'phaseName', 'vmTaskName'],
	                proxy: {
	                    type: 'ajax',
	                    url: '<%=request.getContextPath()%>/getWorkflowParam.do',
	                    reader: {
	                        type: 'json',
	                        root: 'data'
	                    }
	                },
	                listeners:{
	                	load:function(store,records,successful,eOpts){
	                		var blankRecord={
	                				phaseName:'--请选择--',
	                				vmTaskName:'--请选择--'
	                		}
	                		store.insert(0,blankRecord);
	                		for(var i=0,n=records.length;i<n;i++){
	                			if((records[i].data.linkId==699)||(records[i].data.linkId=='699')||(records[i].data.linkId==799)||(records[i].data.linkId=='799')||(records[i].data.linkId==899)||(records[i].data.linkId=='899')){
		                		    store.removeAt(i+1);	
		                		}
	                	  }
	                		
	                	}
	                }
	            });
			
	       var subTaskStatusStore = new Ext.data.Store({
               id: 'subTaskStatusStore',
               fields: ['linkId', 'phaseId', 'phaseName', 'vmTaskName'],
               proxy: {
                   type: 'ajax',
                   url: '<%=request.getContextPath()%>/getWorkflowParam.do?query=40000,50000,60000',
                   reader: {
                       type: 'json',
                       root: 'data'
                   }
               },
               listeners:{
               	load:function(store,records,successful,eOpts){
               		var blankRecord={
               				phaseName:'--请选择--',
               				vmTaskName:'--请选择--'
               		}
               		store.insert(0,blankRecord);
               		for(var i=0,n=records.length;i<n;i++){
               			if((records[i].data.linkId==699)||(records[i].data.linkId=='699')||(records[i].data.linkId==799)||(records[i].data.linkId=='799')||(records[i].data.linkId==899)||(records[i].data.linkId=='899')){
	                		    store.removeAt(i+1);	
	                		}
               	  }
               		
               	}
               }
           });
	       subTaskStatusStore.load();
	       var testTaskStatusCombox = new Ext.form.ComboBox({
               width: 220,
               labelAlign: 'right',
               id:'subTaskStatus',
               store: workflowParamStore,
               name: 'subTaskStatus',
               fieldLabel: '子任务状态',
               valueField: 'linkId',
               displayField: 'vmTaskName',
               listeners: {}
           });
			var subTaskTypeStore = new Ext.data.Store({
			 	id: 'subTaskTypeStore',
			    fields: ['value','show','other2'],
			    proxy: {
			    	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=SUB_TASK_TYPE'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			    },
			    listeners:{
			    	load:function(store,records){
			    		var blankRecord={
			    				show:'--请选择--',
			    				value:''
	            		}
	            		store.insert(0,blankRecord);
			    	}
			    
			    }
			});
			subTaskTypeStore.load();
    		var btn = new Ext.Button({
    			id: 'qryBtn',
    			text: '查询',
    			width: 60,
    			margin: '0 0 0 50px',
    			handler: function(){
    				querySubTask();
    			}
    		});
    		var btn1 = new Ext.Button({
    			id: 'closeBtn',
    			text: "<div data-qtip='选择子任务后可关闭选中的子任务'>关闭子任务</div>",
    			width: 80,
    			margin: '0 0 0 50px',
    			handler: function(){
    				closeSubTask();
    			}
    		});
    		var qryForm = new Ext.form.FormPanel({
    			id:'qryForm',
    			title:'查询区域',
    			cls:'ui-formPanel',
    			defaults: { 
					margins: '5 0 5 0',
				},
    			renderTo: Ext.getBody(),
    			width: screenWidth*0.98,
    			height: screenHeight*0.2*0.99,
    			layout: 'vbox',
    			bodyBorder: 0, 
    			items: [
    				{
	    				xtype: 'fieldcontainer', 
					    labelStyle: 'font-weight:bold;padding:0', 
		    			fieldDefaults: { 
							labelAlign: 'right', 
							labelWidth: 80,
							width: 220
						},
					    layout: 'hbox', 
					    defaultType: 'textfield',
					    items: [
					    	{name:'subTaskTag',fieldLabel:'子任务编号'},
					    	{name:'subTaskName',fieldLabel:'子任务名称'},
					    	StaffRoleViewComboBox,
					    	{xtype:'combo',name:'subTaskType',fieldLabel:'子任务类型',store:'subTaskTypeStore',displayField:'show',valueField:'value',listeners:{
						    	change: function(combo, newValue, oldValue, eOpts) {
					    		Ext.getCmp('subTaskStatus').clearValue();
					    		var other2 = "";
					    		for(var s = 0; s < Ext.StoreMgr.get('subTaskTypeStore').getCount(); s++) {
					    			var tempVal = Ext.StoreMgr.get('subTaskTypeStore').getAt(s).get('value');
					    			if(tempVal == newValue) {
					    				other2 = Ext.StoreMgr.get('subTaskTypeStore').getAt(s).get("other2");
						    			break;
					    			}
						    	}
					    	    Ext.StoreMgr.get('workflowParamStore').setProxy(
					    		       {
					    			      type: 'ajax',
							              url: '<%=request.getContextPath()%>/getWorkflowParam.do?query='+other2,
							              reader: {
							        	  type: 'json',
							        	  root: 'data'
							    	   }
							        });
					    		     Ext.StoreMgr.get('workflowParamStore').load();
					    	}
					    }},
					    	testTaskStatusCombox
					    ]
					},
					{
	    				xtype: 'fieldcontainer',
					    labelStyle: 'font-weight:bold;padding:0',
		    			fieldDefaults: {
							labelAlign: 'right',
							labelWidth: 80,
							width: 220
						},
					    layout: 'hbox',
					    defaultType: 'textfield',
					    items: [
					    	{xtype:'datefield',name:'beginDate',format:'Y-m-d',fieldLabel:'上线时间从',
					    		listeners:{
									select: function() {
										var start = Ext.getCmp('qryForm').getForm().findField('beginDate').getValue();
							            Ext.getCmp('qryForm').getForm().findField('endDate').setMinValue(start);   
										var endDate = Ext.getCmp('qryForm').getForm().findField('endDate').getValue();
							            if(start > endDate&&endDate!=null){   
							                Ext.getCmp('qryForm').getForm().findField('endDate').setValue(start);
							            }   
									}
								}
					    	},
					    	{xtype:'datefield',name:'endDate',format:'Y-m-d',fieldLabel:'到'},
					    	{
					    		name:'testorName',
					    		fieldLabel:'测试人员',
					    		xtype:'combo',
					    		id:'testor',
					    		forceSelection:true,
				                typeAhead:true,
				                minChars:1,
				                hidden:true,
				                selectOnFocus: true,
				                triggerAction: 'all',
				                queryMode: 'local',
					    		store:testorStore,
					           	displayField:'displayName',
					           	valueField:'staffId',
					           	mode:'local',
					           	value:''
					    	},
					    	btn,
					    	btn1
					    ]
					}
    			]
    		});
    		var subTaskStore = Ext.create('Ext.data.Store', {
				storeId:'subTaskStore',
				pageSize:20, //每页显示条数
				fields:[
			        {name:'subTaskId',type:'int',convert: null}, 
			 		{name:'subTaskTag',type:'string'},
			 		{name:'subTaskName',type:'string'}, 
			 		{name:'taskTag',type:'string'}, 
			 		{name:'subTaskType',type:'int'}, 
			 		{name:'reqId',type:'int', convert: null},
			 		{name:'creator',type:'string'},
			 		{name:'subTaskStatus',type:'int'},
			 		{name:'createTime',type:'string'},
			 		{name:'testorName',type:'string'},
			 		{name:'plCompleteTime',type:'string'},
			 		{name:'factCompleteTime',type:'string'},
			 		{name:'subTaskPriority',type:'string'},
			 		{name:'devWorkDay',type:'string'},
			 		{name:'testWorkDay',type:'string'},
			 		{name:'possibleProduct',type:'string'},
			 		{name:'possibleBack',type:'string'},
			 		{name:'possibleTest',type:'string'},
			 		{name:'isPerformance',type:'int'}
			 	],
			    proxy: {
			        type: 'ajax',
		        	url : '<%=request.getContextPath()%>/getTestSubTaskByCon.do?flag=4',
			        reader: {
			            root:"data",
						type:"json",
            			totalProperty:'total'
			        }
			    }
			});
    		subTaskStore.load();
    		var subTaskGrid = new Ext.grid.Panel({
    			id: 'subTaskGrid',
		        cls: 'ui-formPanel',
		        width: screenWidth*0.98,
		        height: screenHeight*0.8*0.98,
		        bbar: Ext.create('Ext.PagingToolbar', { 
					store: subTaskStore, 
					displayInfo: true, 
					displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
					emptyMsg: "没有数据"
				}),
		        renderTo: Ext.getBody(),
				title:'测试子任务列表',
    			store: subTaskStore,
    			listeners: {
    				itemdblclick: function(grid,record,item,index,e,eOpts){
			        	planGrid.getSelectionModel().getSelection();
					}
    			},
    			selModel:top.Ext.create('Ext.selection.CheckboxModel',{mode:"SIMPLE"}),
    			columns: [
    				{xtype:'rownumberer'},
    				{header: "子任务id", width:100, sortable: true, dataIndex: 'subTaskId',hidden:true},
					{header: "子任务编号", width:100, sortable: true, dataIndex: 'subTaskTag'},
					{header: "子任务名称", width:100, sortable: true, dataIndex: 'subTaskName'},
					{header: "任务编号", width:80, sortable: true, dataIndex: 'taskTag',hidden:true},
					{header: "需求ID", width:100, sortable: true, dataIndex: 'reqId',hidden:true},
					{header: "派发人", width:100, sortable: true, dataIndex: 'creator',hidden:true},
					{header: "子任务类型", width:80,sortable: true, dataIndex: 'subTaskType',
	            		editor:{xtype:'combo',displayField:'show', valueField:'value', store:'subTaskTypeStore'},
			    		renderer:function(value){
			    			var rec = Ext.StoreMgr.get('subTaskTypeStore').find('value',value);
			    			if(rec == -1) {
			    				return '';
			    			}
			    			return Ext.StoreMgr.get('subTaskTypeStore').getAt(rec).raw.show;
			    		}
	                },
					{header: "子任务状态",width: 100,sortable: true,dataIndex: 'subTaskStatus',renderer: function(value, cellmeta, record) {
			 	        try
			   	          {
				        		var store=Ext.data.StoreManager.lookup("subTaskStatusStore");
			        		   store.clearFilter(true);
			        		   return store.findRecord("linkId", value).getData().vmTaskName + "";
			   	         } catch(e){return "未指定"};
				     }},
	         		{header: "创建时间", width:150, sortable: true, dataIndex: 'createTime'},
	         		{header: "测试人员", width:100,sortable: true, dataIndex: 'testorName'},
	            	{header: "计划完成时间", width:100,sortable: true, dataIndex: 'plCompleteTime',hidden:true},
	            	{header: "开发工时", width:100,sortable: true, dataIndex: 'devWorkDay'},
	            	{header: "测试工时", width:100,sortable: true, dataIndex: 'testWorkDay',hidden:true},
	            	{header: "生产环境可测性", width:100,sortable: true, dataIndex: 'possibleProduct',
	            		editor:{xtype:'combo',displayField:'show', valueField:'value', store:'possible'},
			    		renderer:function(value){
			    			var rec = Ext.StoreMgr.get('possible').find('value',value);
			    			if(rec == -1) {
			    				return '';
			    			}
			    			return Ext.StoreMgr.get('possible').getAt(rec).raw.show;
			    		}
	            	},
	            	{header: "准发布可测性", width:100,sortable: true, dataIndex: 'possibleBack',
	            		editor:{xtype:'combo',displayField:'show', valueField:'value', store:'possible'},
			    		renderer:function(value){
			    			var rec = Ext.StoreMgr.get('possible').find('value',value);
			    			if(rec == -1) {
			    				return '';
			    			}
			    			return Ext.StoreMgr.get('possible').getAt(rec).raw.show;
			    		}
	            	},
	            	{header: "测试环境可测性", width:100,sortable: true, dataIndex: 'possibleTest',
	            		editor:{xtype:'combo',displayField:'show', valueField:'value', store:'possible'},
			    		renderer:function(value){
			    			var rec = Ext.StoreMgr.get('possible').find('value',value);
			    			if(rec == -1) {
			    				return '';
			    			}
			    			return Ext.StoreMgr.get('possible').getAt(rec).raw.show;
			    		}
	            	},
	        		{ header: '上线时间',dataIndex: 'factCompleteTime', width: 100,
	        			renderer : function(value) {
	         				if(value.length>0){
		         				return value.substring(0,10);
	         				}
				       }
				    },
	        		{ header: '子任务优先级',dataIndex: 'subTaskPriority', width: 100,
	        			editor:{xtype:'combo',displayField:'show', valueField:'value', store:'priority'},hidden:true,
			    		renderer:function(value){
			    			var rec = Ext.StoreMgr.get('priority').find('value',value);
			    			if(rec == -1) {
			    				return '';
			    			}
			    			return Ext.StoreMgr.get('priority').getAt(rec).raw.show;
			    		}
	        		},
	        		{ header: '是否性能测试',dataIndex: 'isPerformance',sortable: true, width: 100,
	        			editor:{xtype:'combo',displayField:'show', valueField:'value', store:'isPerformanceStore'},hidden:true,
			    		renderer:function(value){
			    			var rec = Ext.StoreMgr.get('isPerformanceStore').find('value',value);
			    			if(rec == -1) {
			    				return '';
			    			}
			    			return Ext.StoreMgr.get('isPerformanceStore').getAt(rec).raw.show;
			    		}
	        		},
	        		{header: "操作", width:50,menuDisabled: true,xtype:'actioncolumn',sortable:false,items: [{
            				icon:"<%=request.getContextPath()%>/aiga/images/save.png",
            				id:'downloadTestReport',
            				tooltip:'下载测试报告',
            				handler:function(grid, rowIndex, colIndex){
            					var data=grid.getStore().getAt(rowIndex).getData();
            					var subTaskId = data.subTaskId;
            					var url = "<%=request.getContextPath()%>/downloadTestReport.do?subTaskId="+subTaskId;
								$("#exportForm")[0].action=url;
								$("#exportForm")[0].submit();
    		        		}
    		        	}],hidden:true
    		        }
    			],
    			listeners:{
    				/*dblclick: {
	  					element: 'body',
	  					fn: function() {
	  						var sel = subTaskGrid.getSelectionModel().getSelection();
	  						if(sel.length == 0) {
	  							return;
	  						}
	  						var subTaskId = sel[0].get('subTaskId');
	  						var subTaskType = sel[0].get('subTaskType');
	  						var win = new top.Ext.window.Window({
								title: '子任务管理',
								layout: 'fit',
								width: screenWidth*0.95,
								height: 650,
								modal: true,
								constrain:true,
								resizable:false,
								id: 'modelWin',
								listeners: {
									'beforeClose': function(){querySubTask();}
								},
								html: "<iframe src='<%=request.getContextPath()%>/aiga/workflow/subTestTask/subTestTaskManage.jsp?subTaskType="+subTaskType+"&objId="+subTaskId+"' frameborder=0 style='width:1300px;height: 600px;overflow: auto;'></iframe>"
							});
							win.show();
	  					}
	  				}*/
    			}
    		});
    		
    		
    	});
    	
    	function querySubTask() {
    		var subTaskTag = Ext.getCmp('qryForm').getForm().findField('subTaskTag').getValue();
    		var subTaskName = Ext.getCmp('qryForm').getForm().findField('subTaskName').getValue();
			var subTaskStatus = Ext.getCmp('qryForm').getForm().findField('subTaskStatus').getValue();
			var subTaskType = Ext.getCmp('qryForm').getForm().findField('subTaskType').getValue();
			var creator = Ext.getCmp('qryForm').getForm().findField('creator').getValue();
			var beginDate = Ext.getCmp('qryForm').getForm().findField('beginDate').getValue();
			var endDate = Ext.getCmp('qryForm').getForm().findField('endDate').getValue();
			var testorId = Ext.getCmp('qryForm').getForm().findField('testor').getValue();
			Ext.StoreMgr.get('subTaskStore').on('beforeload',function(){        // =======翻页时 查询条件     
				Ext.apply(       
					Ext.StoreMgr.get('subTaskStore').proxy.extraParams, {
						subTaskTag:encodeURI(subTaskTag),subTaskName:encodeURI(subTaskName),subTaskStatus:encodeURI(subTaskStatus),
						subTaskType:subTaskType,testorId: testorId,creator:encodeURI(creator),
						beginDate:beginDate,endDate:endDate
					}      
				);      
			});
			Ext.StoreMgr.get('subTaskStore').load();
    	}
    	
    	function closeSubTask(){
    		var subTaskGrid=Ext.getCmp('subTaskGrid');
    		var closeStore=subTaskGrid.getSelectionModel().getSelection();
    		if(closeStore.length==0){
    			Ext.Msg.alert("提示","未选择任何子任务");
    		}else{
			    MaskLoading();
			    var data = new Array(); 
			    Ext.Array.each(closeStore, function(record) {  
			    	data.push(record.data);  
			    });
		    	Ext.Ajax.request({ 
					async:false,
					method:'POST',
					url:"<%=request.getContextPath()%>/closeSubTestTask.do",
					params : {table :Ext.encode(data)},
					success:function(response,config){
						MaskOver();
						top.Ext.Msg.alert('提示',"子任务关闭成功");
						subTaskGrid.getStore().load();
					},
					failure:function(response,config){
						MaskOver();
						top.Ext.Msg.alert('提示','子任务关闭失败');
					}
				});
    		}
    	}
    	
    </script>
</html>