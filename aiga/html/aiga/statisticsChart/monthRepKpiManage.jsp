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
	<title>衡量通过KPI管理</title>
</head>
  
<body>
	<div id="monthRepKpiPanel"></div>
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
Ext.onReady(function(){
	Ext.QuickTips.init();
    Ext.tip.QuickTipManager.init();
    
	var monthRepKpiForm = Ext.widget('form', {
        id: 'monthRepKpiForm',
        width: screenWidth,
        border:0,
        tbar: [
        	<%if(flag!=null&&!flag.equals("query")){%>
        	{
	        	xtype: 'button',
	            text: '保存',
	            handler: function () {
	            	var form = Ext.getCmp('monthRepKpiForm');
	            	var formData = form.getValues();
	                MaskLoading();
	                form.submit({
	                	clientValidation: true,
	                    url: "<%=request.getContextPath()%>/saveMonthRepKpi.do",
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
	                        					top.Ext.getCmp("monthRepKpiAlterWin").close();
	                        				<%}else if(flag.equals("create")){%>
	                        					top.Ext.getCmp("monthRepKpiCreateWin").close();
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
	            	top.Ext.getCmp("monthRepKpiQueryWin").close();
				}
        	}
        	<%}%>
        	
        ],
		title: '衡量通过KPI详细信息',
        layout: {
        	type: 'vbox'
        },
        listeners: {
		    <%if(!flag.equals("")&&(flag.equals("alter")||flag.equals("query"))){%>
			render: function (render, eOpts) {
                Ext.getCmp('monthRepKpiForm').load({
                    params: {
                        kpiId: <%=request.getParameter("kpiId")%>
                    },
                    url: '<%=request.getContextPath()%>/getMonthRepKpiByKpiId.do',
                    method: 'POST',
                    success: function (form, action) {
                    	<%if(flag.equals("query")){%>
                    	var fieldAry = Ext.getCmp('monthRepKpiForm').getForm().getFields();
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
		                id:'kpiName',
		                name: 'kpiName',
		                fieldLabel: 'KPI名称'
	            	},{
		            	width: 250,
		                labelAlign: 'right',
		                id:'kpiMeasures',
		                name: 'kpiMeasures',
		                fieldLabel: '措施'
	            	},{
		            	width: 250,
		                labelAlign: 'right',
		                id:'kpiAssessment',
		                name: 'kpiAssessment',
		                fieldLabel: '考核'
	            	},{
		            	width: 250,
		                labelAlign: 'right',
		                id:'responsiblePerson',
		                name: 'responsiblePerson',
		                fieldLabel: '负责人'
	            	},{
		                xtype: 'hidden',
		                id:'kpiId',
		                name: 'kpiId',
		                fieldLabel: 'KPI_ID'
	            	},{
		                xtype: 'hidden',
		                id:'kpiStatus',
		                name: 'kpiStatus',
		                fieldLabel: '是否可用标识(1:可用,0:禁用)',
		                value:'1'
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
                      id:'kpiPlan',
                      name: 'kpiPlan',
                      fieldLabel: '计划'
                    },
	            	{
		            	width: 500,
		                labelAlign: 'right',
		                id:'computationalFormula',
		                name: 'computationalFormula',
		                fieldLabel: '计算公式'
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
		                id:'kpiQuestion',
		                name: 'kpiQuestion',
		                fieldLabel: '问题'
	            	},{
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
    	id:'monthRepKpiPanel',
        renderTo: Ext.get('monthRepKpiPanel'),
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
            items: [monthRepKpiForm]
        }]
    });
});
</script>
</html>