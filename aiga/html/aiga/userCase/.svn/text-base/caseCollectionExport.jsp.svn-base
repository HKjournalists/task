<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%AigaUser user=( AigaUser)request.getSession().getAttribute( "aigaUser");%>
<html>

<head>
    <title>测试子任务查询</title>
    <%@ include file="/aiga/common/include.jsp" %>
</head>
<body style="padding: 0px;">
<form style="display:none;" id="exportForm" action="<%=request.getContextPath()%>/downloadCase.do"
			enctype="multipart/form-data" method="post" target="temp">
			<input type="hidden" name="method" value="export" />
			<input type="submit" id="download" class="tmpBtn" value="下载" />
		</form>
</body>
<script type="text/javascript">
	Ext.onReady(function(){
		loadMask = new Ext.LoadMask(top.window.document.body, {
			msg : '数据处理中!',
			disabled : false
		});
	});
	
	function MaskLoading(){
		loadMask.show();
	}
	function MaskOver(){
		loadMask.hide();
	}
</script>
<script type="text/javascript">
    var screenWidth = document.documentElement.clientWidth;
    var screenHeight = document.documentElement.clientHeight*0.98;
    Ext.onReady(function() {
        Ext.QuickTips.init();
        Ext.tip.QuickTipManager.init();
        var btn = new Ext.Button({
            text: '查询',
            width: 60,
            margin: '0 0 0 50px',
            handler: function() {
                var funPointFolder = Ext.getCmp('qryForm').getForm().findField('funPointFolder').getValue();
                var systemFolder = Ext.getCmp('qryForm').getForm().findField('systemFolder').getValue();
                var funPointImportant = Ext.getCmp('qryForm').getForm().findField('funPointImportant').getValue();
                var baseFunLabel = Ext.getCmp('qryForm').getForm().findField('baseFunLabel').getValue();
                var busiLabel = Ext.getCmp('qryForm').getForm().findField('busiLabel').getValue();
                
                var testType = Ext.getCmp('qryForm').getForm().findField('testType').getValue();
                var caseImportant = Ext.getCmp('qryForm').getForm().findField('caseImportant').getValue();
                var maintenanceFac = Ext.getCmp('qryForm').getForm().findField('maintenanceFac').getValue();
                var isRegressionTest = Ext.getCmp('qryForm').getForm().findField('isRegressionTest').getValue();
                Ext.StoreMgr.get('caseCollectionStore').reload({
                    params: {
                    	funPointFolder: encodeURI(encodeURI(funPointFolder)),
                    	systemFolder:systemFolder,
						funPointImportant:funPointImportant,
						baseFunLabel:baseFunLabel+"",
						busiLabel:busiLabel+"",
						testType: testType+"",
						caseImportant:caseImportant,
						maintenanceFac:maintenanceFac,
						isRegressionTest:isRegressionTest
                    }
                });
            }
        });
     	var sysContentModel= Ext.define('sysContentModel', {
    	    extend: 'Ext.data.Model',
    	    fields: [
    	        {name: 'constantId',  type: 'string'},
    	        {name: 'categoryName', type: 'string'},
    	        {name: 'category', type: 'string'},
    	        {name: 'show', type: 'string'},
    	        {name: 'value', type: 'string'},
    	        {name: 'other1', type: 'string'},
    	        {name: 'other2', type: 'string'},
    	        {name: 'memo', type: 'string'}
    	    ]
    	});
        var qryForm = new Ext.form.FormPanel({
            id: 'qryForm',
            title: '查询区域',
            cls: 'ui-formPanel',
            defaults: {
                margins: '5 0 5 0',
            },
            renderTo: Ext.getBody(),
            width: screenWidth * 0.98,
            height: screenHeight * 0.3 * 0.99,
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
                        {name: 'funPointFolder',fieldLabel: '功能名称'},
                        {xtype: 'combo',name: 'systemFolder', fieldLabel: '归属系统',displayField: 'sysName',valueField: 'sysId', 
							store: Ext.create('Ext.data.Store', {
								fields:[{name:'sysName'},{name:'sysId'}],
								proxy: {type: 'ajax',url: '<%=request.getContextPath()%>/getSysFolder.do',reader: {type: 'json',root: 'data'}}
							,listeners:{load:function(store,records){var blankRecord={sysName:'--请选择--'};store.insert(0,blankRecord)}}
							})
							},
                		{xtype: 'combo',name: 'funPointImportant', fieldLabel: '测试类型',displayField: 'show',valueField: 'value', 
							store: Ext.create('Ext.data.Store', {model: 'sysContentModel',
								proxy: {type: 'ajax',url: '<%=request.getContextPath()%>/getSysConstantStore.do?category=test_type',reader: {type: 'json',root: 'data'}}
							,listeners:{load:function(store,records){var blankRecord={show:'--请选择--'};store.insert(0,blankRecord)}}
							})
							},
						{xtype: 'combo',name: 'baseFunLabel', fieldLabel: '涉及的基础功能',displayField: 'busiName',valueField: 'busiId', multiSelect : true,
								listConfig:{
						              itemTpl : Ext.create('Ext.XTemplate', '<input type=checkbox>{busiName}</input>'), 
						              listeners:{
								        	itemclick:function(view, record, item, index, e, eOpts ){  
								        		 var isSelected = view.isSelected(item);  
								                 var checkboxs = item.getElementsByTagName('input');  
								                  if(checkboxs!=null)  { 
								                	  var checkbox = checkboxs[0];  
								                      if(!isSelected)checkbox.checked = true;
								                      else checkbox.checked = false;  
								                      }  
								                  }
										},
						              onItemSelect: function(record) {      
						                  var node = this.getNode(record);
						                  if (node) {  
						                     Ext.fly(node).addCls(this.selectedItemCls);  
						                     var checkboxs = node.getElementsByTagName('input');  
						                     if(checkboxs!=null){var checkbox = checkboxs[0]; checkbox.checked = true;}  
						                  }  
						              }
								}, 
								store: Ext.create('Ext.data.Store', {
									fields:[{name:'busiName'},{name:'busiId'}],
									proxy: {type: 'ajax',url: '<%=request.getContextPath()%>/getBaseBusiLabel.do',reader: {type: 'json',root: 'data'}}
							})
							},
						{xtype: 'combo',name: 'busiLabel', fieldLabel: '涉及的业务',displayField: 'busiName',valueField: 'busiId',multiSelect : true,
								listConfig:{  
					              itemTpl : Ext.create('Ext.XTemplate', '<input type=checkbox>{busiName}</input>'),  
					              listeners:{
							        	itemclick:function(view, record, item, index, e, eOpts ){  
							        		 var isSelected = view.isSelected(item);  
							                 var checkboxs = item.getElementsByTagName('input');  
							                  if(checkboxs!=null)  { 
							                	  var checkbox = checkboxs[0];  
							                      if(!isSelected)checkbox.checked = true;
							                      else checkbox.checked = false;  
							                      }  
							                  }
									},
					              onItemSelect: function(record) {      
					                  var node = this.getNode(record);  
					                  if (node) {  
					                     Ext.fly(node).addCls(this.selectedItemCls);  
					                     var checkboxs = node.getElementsByTagName('input');  
					                     if(checkboxs!=null){var checkbox = checkboxs[0]; checkbox.checked = true;}  
					                  }  
					              }
							}, 
							store: Ext.create('Ext.data.Store', {
								fields:[{name:'busiName'},{name:'busiId'}],
								proxy: {type: 'ajax',url: '<%=request.getContextPath()%>/getBusiLabel.do?category=test_type',reader: {type: 'json',root: 'data'}}
							})
							}
                		]
            }, {
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
						{xtype: 'combo',name: 'caseImportant', fieldLabel: '用例重要级别', displayField: 'show',valueField: 'value',
							store: Ext.create('Ext.data.Store', {model: 'sysContentModel',
								proxy: {type: 'ajax',url: '<%=request.getContextPath()%>/getSysConstantStore.do?category=case_important',reader: {type: 'json',root: 'data'}}
							,listeners:{load:function(store,records){var blankRecord={show:'--请选择--'};store.insert(0,blankRecord)}}
							})
						},
						{xtype: 'combo',name: 'maintenanceFac', fieldLabel: '维护厂商',displayField: 'show',valueField: 'value', 
							store: Ext.create('Ext.data.Store', {model: 'sysContentModel',
								proxy: {type: 'ajax',url: '<%=request.getContextPath()%>/getSysConstantStore.do?category=case_fac',reader: {type: 'json',root: 'data'}}
							,listeners:{load:function(store,records){var blankRecord={show:'--请选择--'};store.insert(0,blankRecord)}}
							})
							},
						{xtype: 'combo',name: 'testType', fieldLabel: '回归测试类型',displayField: 'show',valueField: 'value', //multiSelect : true,
							store: Ext.create('Ext.data.Store', {model: 'sysContentModel',
								proxy: {type: 'ajax',url: '<%=request.getContextPath()%>/getSysConstantStore.do?category=test_type',reader: {type: 'json',root: 'data'}}
							,listeners:{load:function(store,records){var blankRecord={show:'--请选择--'};store.insert(0,blankRecord)}}
							})
							},
						{name: 'isRegressionTest',fieldLabel: '是否为回归测试',xtype: 'checkbox'},
							btn
                ]
            }]
        });
        var caseCollectionModel = Ext.regModel('caseCollectionModel', {
            fields: [
                     {name: 'sequence',type: 'string'/** 序号 **/},
                     {name: 'systemFolder',type: 'string'/**归属系统 **/},
                     {name: 'funPointFolder',type: 'string'/**功能点 **/},
                     {name: 'funPointType',type: 'string'/**功能点类型 **/},
                     {name: 'funPointDesc',type: 'string'/**功能点说明 **/},
                     {name: 'menuPath',type: 'string'/**菜单路径 **/},
                     {name: 'funPointImportant',type: 'string'/**功能点重要级别 **/},
                     {name: 'caseImportant',type: 'string'/**用例重要级别 **/},
                     {name: 'caseName',type: 'string'/**用例名称 **/},
                     {name: 'caseDesc',type: 'string'/**用例描述 **/},
                     {name: 'isHasTest',type: 'string'/**是否实现自动化 **/},
                     {name: 'maintenanceFac',type: 'string'/**维护厂商 **/},
                     {name: 'caseId',type: 'string'/**功能点Id **/}
                     ]
        });

        var caseCollectionStore = Ext.create('Ext.data.Store', {
            storeId: 'caseCollectionStore',
            model: caseCollectionModel,
            proxy: {
                url: '<%=request.getContextPath()%>/getUsecaseCollection.do',
                type: 'ajax',
                reader: {
                    type: 'json',
                    root: 'data'
                }
            }
        });
        caseCollectionStore.load();
        var caseCollectionGrid = new Ext.grid.Panel({
            id: 'caseCollectionGrid',
            cls: 'ui-formPanel',
            width: screenWidth * 0.98,
            height: screenHeight * 0.8 * 0.9,
            renderTo: Ext.getBody(),
            title: '用例列表',
            store: caseCollectionStore,
            listeners: {
                itemdblclick: function(grid, record, item, index, e, eOpts) {
                	getUsecaseCollection.getSelectionModel().getSelection();
                }
            },
            selModel: Ext.create("Ext.selection.CheckboxModel",{id : 'checkBoxForChoiceCount',mode:"SIMPLE"}),
            tbar:[
				{xtype: 'button',text: '导出选中条目',handler: function () {
					var exportItems = Ext.getCmp("caseCollectionGrid").getSelectionModel().getSelection();
					if(exportItems.length == 0){
						Ext.Msg.alert("操作提示","请选择需要导出的用例");
						return;
					}
					Ext.MessageBox.confirm('操作提示','确定需要导出选中的用例?',function(optional){
						if(optional=='yes'){
							var Ids = []; //要删除的id
		                    Ext.each(exportItems, function (item) {
		                        Ids.push(item.data.caseId);
		                    })
							var url = "<%=request.getContextPath()%>/downloadCase.do?caseIds="+Ids;
							$("#exportForm")[0].action=url;
							$("#exportForm")[0].submit();
							
						}
					});
				}}
            ],
            columns: [
                    {xtype: 'rownumberer'}, 
	            	{header: "归属系统",width: 60,sortable: true,dataIndex: 'systemFolder'}, 
	            	{header: "功能点",width: 60,sortable: true,dataIndex: 'funPointFolder'}, 
	            	{header: "功能点类型",width: 60,sortable: true,dataIndex: 'funPointType'}, 
	            	{header: "功能点说明",width: 60,sortable: true,dataIndex: 'funPointDesc'}, 
	            	{header: "菜单路径",width: 100,sortable: true,dataIndex: 'menuPath'}, 
	            	{header: "功能点重要级别",width: 100,sortable: true,dataIndex: 'funPointImportant'}, 
	            	{header: "用例重要级别",width: 100,sortable: true,dataIndex: 'caseImportant'}, 
	    			{header: "用例名称",width: 100,sortable: true,dataIndex: 'caseName'}, 
	    			{header: "用例描述",width: 100,sortable: true,dataIndex: 'caseDesc'}, 
	    			{header: "是否实现自动化",width: 100,sortable: true,dataIndex: 'isHasTest'}, 
	    			{header: "维护厂商",width: 100,sortable: true,dataIndex: 'maintenanceFac'}, 
	    			{header: "用例ID",width: 100,sortable: true,dataIndex: 'caseId',hidden: true}
            	]
        });
    });
</script>
</html>
