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
	<title>衡量交付SLA管理</title>
</head>
  
<body>
	<div id="monthDelSlaPanel"></div>
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
Ext.onReady(function(){
	Ext.QuickTips.init();
    Ext.tip.QuickTipManager.init();
    
	var monthDelSlaForm = Ext.widget('form', {
        id: 'monthDelSlaForm',
        width: screenWidth,
        border:0,
        tbar: [
        	<%if(flag!=null&&!flag.equals("query")){%>
        	{
	        	xtype: 'button',
	            text: '保存',
	            handler: function () {
	            	var form = Ext.getCmp('monthDelSlaForm');
	            	var formData = form.getValues();
	                MaskLoading();
	                form.submit({
	                	clientValidation: true,
	                    url: "<%=request.getContextPath()%>/saveMonthDelSla.do",
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
	                        					top.Ext.getCmp("monthDelSlaAlterWin").close();
	                        				<%}else if(flag.equals("create")){%>
	                        					top.Ext.getCmp("monthDelSlaCreateWin").close();
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
	            	top.Ext.getCmp("monthDelSlaQueryWin").close();
				}
        	}
        	<%}%>
        	
        ],
		title: '衡量交付SLA详细信息',
        layout: {
        	type: 'vbox'
        },
        listeners: {
		    <%if(!flag.equals("")&&(flag.equals("alter")||flag.equals("query"))){%>
			render: function (render, eOpts) {
                Ext.getCmp('monthDelSlaForm').load({
                    params: {
                        slaId: <%=request.getParameter("slaId")%>
                    },
                    url: '<%=request.getContextPath()%>/getMonthDelSlaBySlaId.do',
                    method: 'POST',
                    success: function (form, action) {
                    	<%if(flag.equals("query")){%>
                    	var fieldAry = Ext.getCmp('monthDelSlaForm').getForm().getFields();
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
		                id:'slaName',
		                name: 'slaName',
		                fieldLabel: 'SLA名称'
	            	},{
		            	width: 250,
		                labelAlign: 'right',
		                id:'targetAttention',
		                name: 'targetAttention',
		                fieldLabel: '指标关注'
	            	},{
		            	width: 250,
		                labelAlign: 'right',
		                id:'scopeOfApplication',
		                name: 'scopeOfApplication',
		                fieldLabel: '适用范围'
	            	},{
		            	width: 250,
		                labelAlign: 'right',
		                id:'responsiblePerson',
		                name: 'responsiblePerson',
		                fieldLabel: '指标负责人'
	            	},{
		                xtype: 'hidden',
		                id:'slaId',
		                name: 'slaId',
		                fieldLabel: 'SLA_ID'
	            	},{
		                xtype: 'hidden',
		                id:'slaStatus',
		                name: 'slaStatus',
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
		                id:'slaDefine',
		                name: 'slaDefine',
		                fieldLabel: 'SLA定义'
	            	},{
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
		                id:'targetReachSituation',
		                name: 'targetReachSituation',
		                fieldLabel: '指标达成情况(请写出公式和值)'
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
    	id:'monthDelSlaPanel',
        renderTo: Ext.get('monthDelSlaPanel'),
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
            items: [monthDelSlaForm]
        }]
    });
});
</script>
</html>