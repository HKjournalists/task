<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>计划创建</title>
</head>
<body>
</body>
<script type="text/javascript">
var extjsFolderPath='<%=request.getContextPath()%>/extJs';
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;

Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.tip.QuickTipManager.init();
	var bigTypeCombox = new Ext.form.ComboBox({
		width: 250,
		store:  Ext.data.Store({
			autoLoad: true,
			id: 'bigTypeStore',
			fields: ['value','show'],
			proxy: {
				type: 'ajax',
				url: '<%=request.getContextPath()%>/getComBox.do',
				reader: {
					type: 'json',
					root: 'data'
				}
			}
		}),
		name:"bigType",
		fieldLabel : "系统大类",
		valueField: 'value',
		displayField: 'show',
		 listeners:{
			 beforequery:function( queryEvent,eOpts ){
				queryEvent.query="bigTypeStore";
			 }
         }
		});
	
	var planTypeCombox = new Ext.form.ComboBox({
		width: 250,
		store:  Ext.data.Store({
			autoLoad: true,
			id: 'planTypeStore',
			fields: ['value','show'],
			proxy: {
				type: 'ajax',
				url: '<%=request.getContextPath()%>/getComBox.do',
				reader: {
					type: 'json',
					root: 'data'
				}
			}
		}),
		name:'planType',
		fieldLabel : "上线类型",
		valueField: 'value',
		displayField: 'show',
		 listeners:{
			 beforequery:function( queryEvent,eOpts ){
					queryEvent.query="planTypeStore";
				 }
         }
		});
	var planStatusCombox = new Ext.form.ComboBox({
		width: 250,
		store:  Ext.data.Store({
			autoLoad: true,
			id: 'planStatusStore',
			fields: ['value','show'],
			proxy: {
				type: 'ajax',
				url: '<%=request.getContextPath()%>/getComBox.do',
				reader: {
					type: 'json',
					root: 'data'
				}
			}
		}),
		name:'planStatus',
		fieldLabel : "计划单状态",
		valueField: 'value',
		displayField: 'show',
		 listeners:{
			 beforequery:function( queryEvent,eOpts ){
					queryEvent.query="planStatusStore";
				 }
         }
		});
	var testPlanForm = Ext.widget('form', {
		id:'testPlanForm',
		width:screenWidth,
		height:screenHeight*0.5,
		tbar:[
		{
		 xtype: 'button',
		  text: '保存',
		    handler:function(){
                       var form=Ext.getCmp("testPlanForm");
                       MaskLoading();
	                        form.submit({
				  			clientValidation: true,
				  			url:"<%=request.getContextPath()%>/saveTestPlanForm.do",
				  			method:'POST',  
	                    	success:function(response,config){ 
	                  MaskOver();
	                        },
	                        failure:function(response,config){
	                  MaskOver();
	                  			Ext.Msg.alert("提示","数据修改失败!");
							}
				  		});
                }
		  }],
			
		title:'测试计划创建', 
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
		    items: [
		   	{
				width:250,
				labelAlign: 'right',
				name: 'planTag',
				fieldLabel: '测试计划编号', 
				allowBlank: false 
			},{		
					width:250,
			        xtype: 'datefield', 
			        name: 'createTime',
				fieldLabel: '测试计划创建时间' 
				
			},{
					width:250,
			        xtype: 'datefield', 
			        name: 'beginTime',
				fieldLabel: '测试计划开始时间' 
			},{
				width:250,
		        xtype: 'datefield', 
		        name: 'plCompleteTime',
			fieldLabel: '测试计划提交时间' 
		},{
		  		xtype:'hidden', 
				name: 'planId',
				fieldLabel: '测试计划id'
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
				width:250,
		        xtype: 'datefield', 
		        name: 'codeCommitDate',
	    		fieldLabel : "代码截止提交日"
	    	},
			bigTypeCombox,
			planStatusCombox,
			planTypeCombox]
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
	    	xtype:'combo',
	    	width: 250, 
	        name: 'isSecurityTest', 
	        fieldLabel: '是否安全测试',
	        allowBlank: false,
	        store:Ext.create('Ext.data.Store', {
				fields:['value','text'],
		        data:[
		            	{'value':0,'text':'是'},
		            	{'value':1,'text':'否'}
		            ]
				}),
	           displayField:'text',
	           valueField:'value',
	           mode:'local',
	           emptyText:'请选择'
	    },{ 
	xtype:'combo',
	width: 250, 
    name: 'isCodeScan', 
    fieldLabel: '是否代码扫描',
    allowBlank: false,
    store:Ext.create('Ext.data.Store', {
		fields:['value','text'],
        data:[
            	{'value':0,'text':'是'},
            	{'value':1,'text':'否'}
            ]
		}),
       displayField:'text',
       valueField:'value',
       mode:'local',
       emptyText:'请选择'
},
        { 
	xtype:'combo',
	width: 250, 
    name: 'isRegressionTest', 
    fieldLabel: '是否回归测试',
    allowBlank: false,
    store:Ext.create('Ext.data.Store', {
		fields:['value','text'],
        data:[
            	{'value':0,'text':'是'},
            	{'value':1,'text':'否'}
            ]
		}),
       displayField:'text',
       valueField:'value',
       mode:'local',
       emptyText:'请选择'
},{ 
	xtype:'combo',
	width: 250, 
    name: 'isPerformanceTest', 
    fieldLabel: '是否性能测试',
    allowBlank: false,
    store:Ext.create('Ext.data.Store', {
		fields:['value','text'],
        data:[
            	{'value':0,'text':'是'},
            	{'value':1,'text':'否'}
            ]
		}),
       displayField:'text',
       valueField:'value',
       mode:'local',
       emptyText:'请选择'
}]
},{ 
			xtype: 'fieldcontainer', 
		    labelStyle: 'font-weight:bold;padding:0', 
		    layout: 'hbox', 
		    defaultType: 'textfield', 
		    fieldDefaults: {
            labelAlign: 'right'
        },
		    items: [{
		    	xtype:"hidden",
				name: 'versionId',
				fieldLabel: '版本id'
			}, { 
			width:250,
				name:'versionTag',
				fieldLabel: '版本编号', 
				allowBlank: false 
			},,{
			  		width:250,
			        xtype: 'datefield', 
			        name: 'versionCreateTime',
				fieldLabel: '版本创建时间'
			},{
			  		width:250,
			        xtype: 'datefield', 
			        name: 'plOnlineTime',
				fieldLabel: '版本计划上线时间' 
				
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
		    items: [{
		      		width:250,
			        xtype: 'datefield', 
			        name: 'factOnlineTime',
				fieldLabel: '版本计划实际时间'
			},{
			  	width:250,
				name: 'plWorkDay',
				fieldLabel: '版本计划容量'
			},
			{
		  		width:250,
				name: 'factWorkDay',
				fieldLabel: '版本实际容量'
			}] 
		 }]
	});
	
	

	Ext.create('Ext.Panel', {
		renderTo: Ext.getBody(),
		width: screenWidth*0.99,
		height: screenHeight*0.99,
        cls: 'ui-formPanel',
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
		items: [ {
			region: 'center',
			items:[testPlanForm]
		}]
    });
});
</script>
</html>