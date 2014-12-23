<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@include file="/aiga/common/common.jsp"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");%>
<html>
	<head>
		<title>测试日报统计查询</title>
		
	</head>
	<body style="padding: 0px;">
		<form style="display:none;" id="exportDailyStatisticsForm" action="<%=request.getContextPath()%>/downloadDailyStatistics.do"
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
		            }, {
		                name: 'displayName',
		                type: 'Srting'
		            }
		        ]
		    });
			var testorStoreForDaily = Ext.create('Ext.data.Store', {
			    id: 'testorStoreForDaily',
				model:StaffRoleViewModel,
				proxy:Ext.create('Ext.data.proxy.Ajax',{
					type:"ajax",
					url:'<%=request.getContextPath()%>/getStaffRoleViews.do?roleCode=WF_TEST_PFR',
					reader:{
						root:"data",
						type:"json"
					}
				}),
		       listeners:{
		           load : function(store, records, options ){
		               store.each(function(record){
		   		           record.set('displayName',record.get('staffCode')+':'+record.get('staffName'));
		   		   	   });
		               var rs = Ext.create("EmptyStaff");
		               store.insert(0,rs);  
		               return true;
		           }
		        }
			});
			testorStoreForDaily.load();
            
			var testOrderlistStatusModel= Ext.define('mapModel', {
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
			var testOrderlistStatusStore=new  Ext.data.Store({
				autoLoad: true,
				id: 'testOrderlistStatusStore',
				model:testOrderlistStatusModel,
				groupField: 'categoryName',
				proxy: {
					type: 'ajax',
					url: '<%=request.getContextPath()%>/getMultipleSysConstant.do?categorys=AIGA_TEST_DAILY',
					reader: {
						type: 'json',
						root: 'data'
					}
				}
			});
			testOrderlistStatusStore.load();
			var mainProcessIsPassModel= Ext.define('mapModel', {
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
			var mainProcessIsPassStore=new  Ext.data.Store({
				autoLoad: true,
				id: 'mainProcessIsPassStore',
				model:mainProcessIsPassModel,
				groupField: 'categoryName',
				proxy: {
					type: 'ajax',
					url: '<%=request.getContextPath()%>/getMultipleSysConstant.do?categorys=MAIN_PROCESS_IS_PASS',
					reader: {
						type: 'json',
						root: 'data'
					}
				}
			});
			mainProcessIsPassStore.load();
			var testOrderlistStatusCombox = new Ext.form.ComboBox({
		    	id:'testOrderlistStatusCombox',
		        width: 220,
		        store: testOrderlistStatusStore,
		        labelAlign: 'right',
				forceSelection: true,
				mode: 'local',//申明本属性即可实现过滤  
		        name: "testOrderlistStatus",
		        fieldLabel: "测试工单状态",
		        labelWidth: 100,
		        valueField: 'value',
		        displayField: 'show',
		        listeners: {
		            beforequery: function (queryEvent, eOpts) {
		                queryEvent.query = "testOrderlistStatus";
		            }
		        }
		    });
			var mainProcessIsPassCombox = new Ext.form.ComboBox({
		    	id:'mainProcessIsPassCombox',
		        width: 260,
		        store: mainProcessIsPassStore,
		        labelAlign: 'right',   
				forceSelection: true,
				mode: 'local',//申明本属性即可实现过滤  
		        name: "mainProcessIsPass",
		        fieldLabel: "测试主流程是否通过",
		        labelWidth: 140,
		        valueField: 'value',
		        displayField: 'show',
		        listeners: {
		            beforequery: function (queryEvent, eOpts) {
		                queryEvent.query = "mainProcessIsPass";
		            }
		        }
		    });
			
			var bigTypeStore = new Ext.data.Store({
            	autoLoad:true,
                id: 'bigTypeStore',
                fields: ['value', 'show'],
                proxy: {
                    type: 'ajax',
                    url: '<%=request.getContextPath()%>/getComBox.do?query=bigTypeStore',
                    reader: {
                        type: 'json',
                        root: 'data'
                    }
                },
                listeners:{
			    	load : function(store, records, options ){
		            	var rs = Ext.create("EmptyVal");
		                store.insert(0,rs);  
		            }
                }
            });
            bigTypeStore.load();
            var bigTypeCombox = new Ext.form.ComboBox({
                width: 200,
                store: bigTypeStore,
                name: "bigType",
                id: "bigType",
                fieldLabel: "系统大类",
                forceSelection:true,
	            typeAhead:true,
	            minChars:1,
	            selectOnFocus: true,
	            triggerAction: 'all',
	            queryMode: 'local',
                valueField: 'value',
                displayField: 'show'
            });
			
    		var btn = new Ext.Button({
    			id: 'qryBtn',
    			text: '查询',
    			width: 60,
    			margin: '0 0 0 80px',
    			handler: function(){
    				queryDailyReport();
    			}
    		});
    		Ext.regModel('extCommboModel', {
			    fields: [
			        {type: 'string', name: 'value'},
			        {type: 'string', name: 'text'}
			    ]
			});
			var testorStore = Ext.create('Ext.data.Store', {
				model:"extCommboModel",
				proxy:Ext.create('Ext.data.proxy.Ajax',{
					type:"ajax",
					model:"extCommboModel",
					url:'<%=request.getContextPath()%>/getSubTaskTestorForSearch.do',
					reader:{
						root:"data",
						type:"json"
					}
				})
			});
			testorStore.load();
			   var departStore = Ext.create('Ext.data.Store', {
			   		autoLoad: true,
			        storeId:'departStore',
			        fields:[
			                {name:'organizeId',type:'string'}, 
			        		{name:'organizeName',type:'string'}
			        	   ],
			        proxy: {
			        	    type: 'ajax',
			               	url : '<%=request.getContextPath()%>/getAllStaffOrg.do',
			                reader: {
			        	        root:"data",
			        			type:"json"
			        	     }
			        	   },
			        	   listeners:{
			        	    	load:function(store,records,successful, eOpts ){
			        		       var blankRecord={
					    				organizeName:'--请选择--'
			            		    }
			        	    		store.insert(0,blankRecord);
			        	    	}
			        	    }
			      });
				  
			      var departComboBox = new Ext.form.ComboBox({
			           width: 200,
			           store: departStore,
			           name:'organizeId',
			           fieldLabel: "组织部门",
			           valueField: 'organizeId',
			           displayField: 'organizeName',
			           editable:true,
			           forceSelection:true,
			            typeAhead:true,
			            minChars:1,
			            selectOnFocus: true,
			            triggerAction: 'all',
			            queryMode: 'local'
			            });
    		var qryForm = new Ext.form.FormPanel({
    			id:'qryForm',
    			title:'查询区域',
    			cls:'ui-formPanel',
    			defaults: { 
					margins: '5 0 5 0'
				},
    			renderTo: Ext.getBody(),
    			width: screenWidth - 2,
    			height: screenHeight*0.17*0.99,
    			minWidth: 1200,
    			minHeight: 50,
    			layout: 'vbox',
    			bodyBorder: 0, 
    			items: [
					{
	    				xtype: 'fieldcontainer',
					    layout: 'vbox',
					    items: [{
		    				xtype: 'fieldcontainer',
						    labelStyle: 'font-weight:bold;padding:0',
			    			fieldDefaults: {
								labelAlign: 'right',
								labelWidth: 80,
								width: 200
							},
						    layout: 'hbox',
					    	defaultType: 'textfield',
					    	items:[
								bigTypeCombox,
								departComboBox,
								{
								    name: "searchStaffForDaily",
								    id: "searchStaffForDaily",
						    		fieldLabel:'测试人员',
						    		xtype:'combo',
									width: 200,
						    		forceSelection:true,
					                typeAhead:true,
					                minChars:1,
					                selectOnFocus: true,
					                triggerAction: 'all',
					                queryMode: 'local',
						    		store:testorStoreForDaily,
						           	displayField:'displayName',
						           	valueField:'staffId',
						           	mode:'local'
						    	},
				                testOrderlistStatusCombox,
				                mainProcessIsPassCombox,
					    		
					    		]
					    },{
		    				xtype: 'fieldcontainer',
						    labelStyle: 'font-weight:bold;padding:0',
			    			fieldDefaults: {
								labelAlign: 'right',
								labelWidth: 80,
								width: 200
							},
						    layout: 'hbox',
					    	defaultType: 'textfield',
					    	items:[
					    		{xtype:'datefield',name:'beginDate',format:'Y-m-d',fieldLabel:'填写时间从',width: 200},
						    	{xtype:'datefield',name:'endDate',format:'Y-m-d',fieldLabel:'至',width: 200},
	                            {
	                                xtype: 'checkbox',
	                                width: 200,
	                                checked:true,
	                                name: 'isRecentQuery',
	                                fieldLabel: '是否查询最新记录',	
	                                labelWidth: 180
	                            }, 
						    	{
	                            	xtype:'datefield',
	                            	name:'factCompleteTime',
	                            	format:'Y-m-d',
	                            	fieldLabel:'<font style="color: red; font-weight:bold;">*</font>上线时间',
	                            	width: 220,
	                            	labelWidth: 100
	                            },
						    	btn,
						    	{
	                            	xtype: 'button',
	                            	text: '数据导出',
	                            	width: 60,
	                            	margin: '0 0 0 60px',
	                            	handler: function () {
					    						Ext.MessageBox.confirm('操作提示','确定导出日报数据?',function(optional){
					    						if(optional=='yes'){
					    							var url = "<%=request.getContextPath()%>/downloadDailyStatistics.do";
					    							$("#exportDailyStatisticsForm")[0].action=url;
					    							$("#exportDailyStatisticsForm")[0].submit();
					    							
					    						}
					    					});
					    		}}
					            
					    		]
					    }
					    ]
					}
    			]
    		});
    		var dailyReportStore = Ext.create('Ext.data.Store', {
    			autoLoad: false,
				storeId:'dailyReportStore',
				pageSize:20, //每页显示条数
				fields:[
			        {name:'subTaskId',type:'string'}, 
			 		{name:'subTaskTag',type:'string'},  
			 		{name:'devTag',type:'string'}, 
			 		{name:'subTaskName',type:'string'}, 
			 		{name:'testorName',type:'string'},
			        {name:'factCompleteTime',type:'string'}, 
			 		{name:'passCaseNumber',type:'string'},
			 		{name:'sumCaseNumber',type:'string'},
			 		{name:'passPercent',type:'string'},
			 		{name:'editStaffName',type:'string'},
			 		{name:'deffectSumNumber',type:'string'},
			 		{name:'deffectUnfinishendNumber',type:'string'},
			 		{name:'testOrderlistStatus',type:'string'},
			 		{name:'mainProcessIsPass',type:'string'},
			 		{name:'reviewResult',type:'string'},
			 		{name:'commitTime',type:'string'},
			 		{name:'isRecentQuery',type:'string'}
			 		
			 	],
			    proxy: {
			        type: 'ajax',
		        	url : '<%=request.getContextPath()%>/getTestDailyReportList.do',
			        reader: {
			            root:"data",
						type:"json",
            			totalProperty:'total'
			        }
			    }
			});
    		var dailyReportGrid = new Ext.grid.Panel({
    			id: 'dailyReportGrid',
		        cls: 'ui-formPanel',
		        minWidth: 1200,
		        minHeight: 300,
		        width: screenWidth - 2,
		        height: screenHeight*0.83*0.99,
		        bbar: Ext.create('Ext.PagingToolbar', { 
					store: dailyReportStore, 
					displayInfo: true, 
					displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
					emptyMsg: "没有数据"
				}),
		       renderTo: Ext.getBody(),
				title:'日报信息列表',
    			store: dailyReportStore,
                selModel: Ext.create("Ext.selection.CheckboxModel",{id : 'checkBoxForChoiceCount',mode:"SIMPLE"}),
                
    			columns: [
    				{xtype:'rownumberer'},
    				{header: "子任务id", width:100,align:'center', sortable: true, dataIndex: 'subTaskId',hidden:true},
    				{header: "开发子任务编号", width:100,align:'center', sortable: true, dataIndex: 'devTag'},
					{header: "测试子任务编号", width:100,align:'center',  sortable: true, dataIndex: 'subTaskTag'},
					{header: "子任务名称", width:100,align:'center',  sortable: true, dataIndex: 'subTaskName'},
					{header: "测试人员", width:100,align:'center',  sortable: true, dataIndex: 'testorName'},
					{header: "上线时间", width:100,align:'center',  sortable: true, dataIndex: 'factCompleteTime'},
					{header: "用例通过数", width:100,align:'center',  sortable: true, dataIndex: 'passCaseNumber'},
					{header: "用例总数",width: 100,align:'center', sortable: true,dataIndex: 'sumCaseNumber'},
	         		{header: "测试通过率", width:100,align:'center',  sortable: true, dataIndex: 'passPercent'},
	         		{header: "缺陷未解决数", width:100,align:'center', sortable: true, dataIndex: 'deffectUnfinishendNumber'},
	            	{header: "缺陷总数", width:100,align:'center', sortable: true, dataIndex: 'deffectSumNumber'},
	            	{header: "测试工单状态", width:100,align:'center', sortable: true, dataIndex: 'testOrderlistStatus',renderer: function (value, cellmeta, record) {
		                try {
		                    var store = Ext.data.StoreManager.lookup("testOrderlistStatusStore");
		                    store.clearFilter(true);
		                    store.filter("categoryName", "testOrderlistStatus");
		                    return store.findRecord("value", value).getData().show + "";
		                } catch (e) {
		                    return "";
		                };
		            }},
	            	{header: "主流程是否通过", width:100,align:'center', sortable: true, dataIndex: 'mainProcessIsPass',renderer: function (value, cellmeta, record) {
		                try {
		                    var store = Ext.data.StoreManager.lookup("mainProcessIsPassStore");
		                    store.clearFilter(true);
		                    store.filter("categoryName", "mainProcessIsPass");
		                    return store.findRecord("value", value).getData().show + "";
		                } catch (e) {
		                    return "";
		                };
		            }},
		            {header: "审核状态", width:100,align:'center', sortable: true, dataIndex: 'reviewResult'},
	            	{header: "填写人", width:100,align:'center', sortable: true, dataIndex: 'editStaffName'},
	            	{header: "提交日期", width:100,align:'center', sortable: true, dataIndex: 'commitTime'}
    			]
    		});
    	});
    	
    	function queryDailyReport() {
			var factCompleteTime = Ext.getCmp('qryForm').getForm().findField('factCompleteTime').getValue();//上线时间开始
			if(factCompleteTime=='' || factCompleteTime==null){
				Ext.Msg.alert("提示","请选择上线时间") ;
				return;
			}
			var isRecentQuery = Ext.getCmp('qryForm').getForm().findField('isRecentQuery').getValue();//是否查询最新记录
			var beginDate = Ext.getCmp('qryForm').getForm().findField('beginDate').getValue();//开始时间
			var endDate = Ext.getCmp('qryForm').getForm().findField('endDate').getValue();//结束时间
			var testorId = Ext.getCmp('qryForm').getForm().findField('searchStaffForDaily').getValue();//测试人员
			var testOrderlistStatusCombox = Ext.getCmp('qryForm').getForm().findField('testOrderlistStatusCombox').getValue();//工单状态
			var mainProcessIsPass = Ext.getCmp('qryForm').getForm().findField('mainProcessIsPassCombox').getValue();//主流程是否通过
			var bigType = Ext.getCmp('qryForm').getForm().findField('bigType').getValue();//系统大类
			var store = Ext.data.StoreManager.lookup("StaffRoleViewStore");
			var organizeId = Ext.getCmp('qryForm').getForm().findField('organizeId').getValue();
			Ext.StoreMgr.get('dailyReportStore').on('beforeload',function(){        // =======翻页时 查询条件     
				Ext.apply(       
					Ext.StoreMgr.get('dailyReportStore').proxy.extraParams, {
						beginDate:beginDate,endDate:endDate,searchStaffId:testorId,organizeId:organizeId,
						testOrderlistStatus:testOrderlistStatusCombox,mainProcessIsPass:mainProcessIsPass,
						factCompleteTime:factCompleteTime,bigType:bigType,isRecentQuery:isRecentQuery
					}      
				);      
			});
			Ext.StoreMgr.get('dailyReportStore').loadPage(1);
    	}
    </script>
</html>