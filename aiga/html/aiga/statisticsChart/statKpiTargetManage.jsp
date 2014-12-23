<!DOCTYPE HTML>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");%>
<%@ include file="/aiga/common/common.jsp" %>
<%
	String flag = request.getParameter("flag");//判断是添加还是修改 create alter query
	if(flag == null){
		flag = "";
	}
%>
 
<html>
<head>
	<title>KPI管理</title>
</head>
  
<body>
	<div id="statKpiTargetPanel"></div>
</body>
<script type="text/javascript">
var dateFormat = Ext.Date.format(new Date, 'YmdHisu');//随机生成数
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
Ext.onReady(function(){
	Ext.QuickTips.init();
    Ext.tip.QuickTipManager.init();
    var mapModel = Ext.define('mapModel', {
        extend: 'Ext.data.Model',
        fields: [{
                name: 'constantId',
                type: 'string'
            }, {
                name: 'categoryName',
                type: 'string'
            }, {
                name: 'category',
                type: 'string'
            }, {
                name: 'show',
                type: 'string'
            }, {
                name: 'value',
                type: 'string'
            }, {
                name: 'other1',
                type: 'string'
            }, {
                name: 'other2',
                type: 'string'
            }, {
                name: 'memo',
                type: 'string'
            }
        ]
    });
    var myDate=new Date();//获取时间
    var month=myDate.getMonth()+1;
    if(month<10){month="0"+month;}
    var changeDate=myDate.getFullYear()+"-"+month+"-"+myDate.getDate();
    var mapStore = new Ext.data.Store({
        id: 'mapStore',
        model: mapModel,
        groupField: 'categoryName',
        proxy: {
            type: 'ajax',
            url: '<%=request.getContextPath()%>/getSysConstantStore.do?category=STATISTICS',
            reader: {
                type: 'json',
                root: 'data'
            }
        },
        listeners: {
        }
    });
    mapStore.load();
    var kpiTypeCombox = new Ext.form.ComboBox({
        width: 200,
        name:'kpiType',
       store: mapStore,
       labelAlign: 'right',
       fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>KPI类型",
       valueField: 'value',
       displayField: 'show',
       allowBlank: false,
        listeners: {
            beforequery: function (queryEvent, eOpts) {
                queryEvent.query = "kpiTypeStore";
            }
        }
    });
     var targetStore = new Ext.data.Store({
			id: 'targetStore',
			model: mapModel,
			proxy: {
			    type: 'ajax',
			    url: '<%=request.getContextPath()%>/getSysConstantStore.do?category=TARGET_TYPE'+'&_='+(new Date()).getTime(),
			    reader: {
			        type: 'json',
			        root: 'data'
			    }
		 }
  });
    targetStore.load();
    var targetTypeCombox = new Ext.form.ComboBox({
        width: 200,
        store: targetStore,
        labelAlign: 'right',
        name: "targetType",
        fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>指标类型",
        valueField: 'value',
        displayField: 'show',
        allowBlank: false,
        listeners: {
        }
    });
	var statKpiTargetForm = Ext.widget('form', {
        id: 'statKpiTargetForm',
        width: screenWidth,
        border:0,
        tbar: [
        	<%if(flag.equals("create")||flag.equals("")){%>
        	{
	        	xtype: 'button',
	            text: '保存',
	            handler: function () {
	            	var form = Ext.getCmp('statKpiTargetForm');
	            	var formData = form.getValues();
	                MaskLoading();
	                form.submit({
	                	clientValidation: true,
	                    url: "<%=request.getContextPath()%>/saveStatKpiTarget.do",
	                    method: 'POST',
	                    success: function (response, config) {
	                    	MaskOver();
	                        var success = config.result.success;
	                        // 当后台数据同步成功时  
							    if (success) {
						  Ext.MessageBox.show({        
	                        		title: '提示',        
	                        		msg: '保存成功!',
	        						buttons: Ext.MessageBox.OKCANCEL,       
	        						fn: function(btn){           
	                        			if(btn=='ok'){
	                        				<%if(flag.equals("alter")){%>
	                        					top.Ext.getCmp("statKpiTargetAlterWin").close();
	                        				<%}else if(flag.equals("create")){%>
	                        					top.Ext.getCmp("statKpiTargetCreateWin").close();
	                        				<%}%>
	                        			} 
	                        		},  
	                        		icon: Ext.MessageBox.QUESTION    
	                        	});
							}
						},
	                    failure: function (response, config) {
	                    	MaskOver();
	                        if(config.failureType=="client"){
                    		   Ext.Msg.alert("提示","<font style='color: red; font-weight:bold;'>*</font>为必填项!");
                    		   return;
                    	    }
                        	Ext.Msg.alert("提示","保存失败");
	                    }
	                });
				}
        	}
        	<%}else if(flag.equals("alter")){%>
        	{
	        	xtype: 'button',
	            text: '修改',
	            handler: function () {
	            	statKpiTargetForm.form.setValues({changeTime:changeDate});
	            	var form = Ext.getCmp('statKpiTargetForm');
	            	var formData = form.getValues();
	                MaskLoading();
	                form.submit({
	                	clientValidation: true,
	                	params: {
	                        kpiId: <%=request.getParameter("kpiId")%>
	                    },
	                    url: "<%=request.getContextPath()%>/deleteStatKpiTargetByKpiId.do",
	                    method: 'POST',
	                    success: function (response, config) {
	                    	MaskOver();
	                        var success = config.result.success;
	                        // 当后台数据同步成功时  
							    if (success) {
							    	 form.submit({
						                	clientValidation: true,
						                    url: "<%=request.getContextPath()%>/saveStatKpiTarget.do",
						                    method: 'POST',
						                    success: function (response, config) {
						                    	MaskOver();
						                        var success = config.result.success;
						                        // 当后台数据同步成功时  
												    if (success) {
											  Ext.MessageBox.show({        
						                        		title: '提示',        
						                        		msg: '修改成功!',
						        						buttons: Ext.MessageBox.OKCANCEL,       
						        						fn: function(btn){           
						                        			if(btn=='ok'){
						                        				<%if(flag.equals("alter")){%>
						                        					top.Ext.getCmp("statKpiTargetAlterWin").close();
						                        				<%}else if(flag.equals("create")){%>
						                        					top.Ext.getCmp("statKpiTargetCreateWin").close();
						                        				<%}%>
						                        			} 
						                        		},  
						                        		icon: Ext.MessageBox.QUESTION    
						                        	});
												}
											},
						                    failure: function (response, config) {
						                    	MaskOver();
                                               	Ext.Msg.alert("提示","保存失败");
                                               	return;
						                    }
						                });
							}
						},
	                    failure: function (response, config) {
	                    	MaskOver();
	                    	Ext.Msg.alert("提示","修改失败");
	                    }
	                });
				}
        	}
        	<%}else{%>
        	{
	        	xtype: 'button',
	            text: '关闭',
	            handler: function () {
	            	top.Ext.getCmp("statKpiTargetQueryWin").close();
				}
        	}
        	<%}%>
        	
        ],
		title: 'KPI详细信息',
        layout: {
        	type: 'vbox'
        },
        listeners: {
		    <%if(flag.equals("query")||flag.equals("alter")){%>
			render: function (render, eOpts) {
                Ext.getCmp('statKpiTargetForm').load({
                    params: {
                        kpiId: <%=request.getParameter("kpiId")%>
                    },
                    url: '<%=request.getContextPath()%>/getStatKpiTargetByKpiId.do',
                    method: 'POST',
                    success: function (form, action) {
                    	<%if(flag.equals("query")){%>
                    	var fieldAry = Ext.getCmp('statKpiTargetForm').getForm().getFields();
						for(var i = 0; i < fieldAry.length; i++) {
							fieldAry.get(i).setReadOnly(true);
				  		}
                    	<%}%>
                    	
                    },
                    failure: function (form, action) {
                        Ext.Msg.alert('提示', "失败原因是: " + action.result.errorMessage);
                    }
                });
			}
		    <%}%>
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
	            defaultType: 'textfield',
	            items: [{
		            	width: 200,
		                labelAlign: 'right',
		                id:'kpiName',
		                name: 'kpiName',
		                allowBlank: false,
		                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>KPI名称"
	            	},{
		            	width: 200,
		                labelAlign: 'right',
		                id:'targetAttention',
		                allowBlank: false,
		                name: 'targetAttention',
		                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>指标关注"
	            	},{
		            	width: 200,
		                labelAlign: 'right',
		                id:'kpiDefine',
		                allowBlank: false,
		                name: 'kpiDefine',
		                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>KPI定义"
	            	},{
		            	width: 200,
		                labelAlign: 'right',
		                allowBlank: false,
		                id:'targetUnit',
		                name: 'targetUnit',
		                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>指标单位"
	            	}
	            ]
			},{
	        	xtype: 'fieldcontainer',
	            labelStyle: 'font-weight:bold;padding:0',
	            layout: 'hbox',
	            defaultType: 'textfield',
	            items: [{
	                xtype: 'hidden',
	                id:'kpiId',
	                name: 'kpiId',
	                fieldLabel: 'KPI_ID'
            	},{
            		readOnly:true,
                    width: 200,
                    xtype: 'datefield',
                    id:'changeTime',
                    name: 'changeTime',
                    labelAlign: 'right',
                    allowBlank: false,
                    format: 'Y-m-d',
                    fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>修改时间"
                    },
            	 {
	            	width: 200,
	                labelAlign: 'right',
	                id:'changeStaffName',
	                name: 'changeStaffName',
	                allowBlank: false,
	                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>修改人姓名"
            	},{
	            	xtype: 'hidden',
	                labelAlign: 'right',
	                id:'changeStaffId',
	                name: 'changeStaffId',
	                allowBlank: false,
	                fieldLabel: '修改人Id'
            	},kpiTypeCombox,targetTypeCombox,
            	{
	            	xtype:'hidden',
	                labelAlign: 'right',
	                id:'kpiUuid',
	                name: 'kpiUuid',
	                <%if(flag!=null&&flag.equals("create")){%>
	                    value:dateFormat
	                <%}%>
            	}
	            ]
			},{
	        	xtype: 'fieldcontainer',
	            labelStyle: 'font-weight:bold;padding:0',
	            layout: 'hbox',
	            defaultType: 'textfield',
	            items: [
                      {
                        width: 200,
                        id:'targetProvideTime',
                        name: 'targetProvideTime',
                        labelAlign: 'right',
                        allowBlank: false,
                        fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>指标提供时间"
                      }, {
                        xtype: 'hidden',
                        id:'kpiStatus',
                        name: 'kpiStatus',
                        fieldLabel: '是否可用标识(1:可用,0:禁用)',
                        value:'1'
                      },{
                          xtype: 'hidden',
                          id:'kpiHisStatus',
                          name: 'kpiHisStatus',
                          fieldLabel: '是否可用标识(1:无,0:有)',
                          value:'1'
                        },{
	            	        width: 200,
	                        labelAlign: 'right',
	                        id:'targetDepartment',
	                        name: 'targetDepartment',
	                        fieldLabel: '提供部门'
            	          }
	            ]
			},{
	        	xtype: 'fieldcontainer',
	            labelStyle: 'font-weight:bold;padding:0',
	            layout: 'hbox',
	            defaultType: 'textarea',
	            items: [
                     {
	                  width: 500,
                      labelAlign: 'right',
                      id:'standardValue',
                      name: 'standardValue',
                      allowBlank: false,
                      fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>达标值"
                    },
	            	{
		            	width: 500,
		                labelAlign: 'right',
		                id:'computationalFormula',
		                name: 'computationalFormula',
		                allowBlank: false,
		                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>计算公式"
	            	}
	            ]
			},{
	        	xtype: 'fieldcontainer',
	            labelStyle: 'font-weight:bold;padding:0',
	            layout: 'hbox',
	            defaultType: 'textarea',
	            items: [
	            	{
		            	width: 500,
		                labelAlign: 'right',
		                id:'changeReason',
		                name: 'changeReason',
		                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>修改原因"
	            	},{
		            	width: 500,
		                labelAlign: 'right',
		                id:'remark',
		                name: 'remark',
		                fieldLabel: '备注'
	            	}
	            ]
			}
		]
	});
	Ext.create('Ext.Panel', {
    	id:'statKpiTargetPanel',
        renderTo: Ext.get('statKpiTargetPanel'),
        cls: 'ui-formPanel',
        width: screenWidth,
        height: screenHeight,
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
            items: [statKpiTargetForm]
        }]
    });
});
</script>
</html>