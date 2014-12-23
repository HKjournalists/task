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
	<title>业务标签管理</title>
</head>
  
<body>
	<div id="aigaBusiPanel"></div>
</body>
<script type="text/javascript">
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
                type: 'int'
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
    var mapStore = new Ext.data.Store({
        id: 'mapStore',
        model: mapModel,
        groupField: 'categoryName',
        proxy: {
            type: 'ajax',
            url: '<%=request.getContextPath()%>/getSysConstantStore.do?category=AigaBusi',
            reader: {
                type: 'json',
                root: 'data'
            }
        },
        listeners: {
        }
    });
    mapStore.load();
    var busiTypeCombox = new Ext.form.ComboBox({
        width: 380,
        store: mapStore,
        labelAlign: 'right',
        name: "busiType",
        fieldLabel: "业务分类",
        valueField: 'value',
        displayField: 'show',
        listeners: {
            beforequery: function (queryEvent, eOpts) {
                queryEvent.query = "busiType";
            }
        }
    });
    var importantClassCombox = new Ext.form.ComboBox({
        width: 370,
        store: mapStore,
        labelAlign: 'right',
        name: "importantClass",
        fieldLabel: "重要等级",
        valueField: 'value',
        displayField: 'show',
        listeners: {
            beforequery: function (queryEvent, eOpts) {
                queryEvent.query = "importantClass";
            }
        }
    });
	var aigaBusiForm = Ext.widget('form', {
        id: 'aigaBusiForm',
        width: screenWidth,
        border:0,
        tbar: [
        	<%if(flag!=null&&!flag.equals("query")){%>
        	{
	        	xtype: 'button',
	            text: '保存',
	            handler: function () {
	            	var form = Ext.getCmp('aigaBusiForm');
	            	var formData = form.getValues();
	                MaskLoading();
	                form.submit({
	                	clientValidation: true,
	                    url: "<%=request.getContextPath()%>/saveAigaBusi.do",
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
	                        					top.Ext.getCmp("aigaBusiAlterWin").close();
	                        				<%}else if(flag.equals("create")){%>
	                        					top.Ext.getCmp("aigaBusiCreateWin").close();
	                        				<%}%>
	                        			} 
	                        		},  
	                        		icon: Ext.MessageBox.QUESTION    
	                        	});
							}
						},
	                    failure: function (response, config) {
	                    	MaskOver();
	                        Ext.Msg.alert("提示","保存失败!");
	                    }
	                });
				}
        	}
        	<%}else{%>
        	{
	        	xtype: 'button',
	            text: '关闭',
	            handler: function () {
	            	top.Ext.getCmp("aigaBusiQueryWin").close();
				}
        	}
        	<%}%>
        	
        ],
		title: '业务详细信息',
        layout: {
        	type: 'vbox'
        },
        listeners: {
		    <%if(!flag.equals("")&&(flag.equals("alter")||flag.equals("query"))){%>
			render: function (render, eOpts) {
                Ext.getCmp('aigaBusiForm').load({
                    params: {
                        busiId: <%=request.getParameter("busiId")%>
                    },
                    url: '<%=request.getContextPath()%>/getAigaBusiByBusiId.do',
                    method: 'POST',
                    success: function (form, action) {
                    	<%if(flag.equals("query")){%>
                    	var fieldAry = Ext.getCmp('aigaBusiForm').getForm().getFields();
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
		            	width: 250,
		                labelAlign: 'right',
		                id:'busiName',
		                name: 'busiName',
		                fieldLabel: '业务名称'
	            	},busiTypeCombox,
	            	importantClassCombox,
	            	{
		                xtype: 'hidden',
		                id:'busiId',
		                name: 'busiId',
		                fieldLabel: '业务ID'
	            	},{
		                xtype: 'hidden',
		                id:'isInvalid',
		                name: 'isInvalid',
		                fieldLabel: '是否已被禁用(1:已被禁用,0:未被禁用)',
		                value:'0'
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
		                id:'busiDesc',
		                name: 'busiDesc',
		                fieldLabel: '业务说明'
	            	},
	            	{
		            	width: 500,
		                labelAlign: 'right',
		                id:'remarks',
		                name: 'remarks',
		                fieldLabel: '备注'
	            	}
	            ]
			}
		]
	});
	Ext.create('Ext.Panel', {
    	id:'aigaBusiPanel',
        renderTo: Ext.get('aigaBusiPanel'),
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
            items: [aigaBusiForm]
        }]
    });
});
</script>
</html>