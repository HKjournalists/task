<!DOCTYPE HTML>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");%>
<%@ include file="/aiga/common/common.jsp" %>
<%
	String flag = request.getParameter("flag");//判断是添加还是修改 create alter
	if(flag == null){
		flag = "";
	}
	String isViewer = request.getParameter("isViewer");//判断是否只读 yes
	if(isViewer == null){
		isViewer = "";
	}
%>
 
<html>
<head>
	<title>创建子系统</title>
</head>
  
<body>
	<div id="funPountPanel"></div>
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
Ext.onReady(function(){
	Ext.QuickTips.init();
    Ext.tip.QuickTipManager.init();
    /**
     * 所属系统
     */
    var sysIdStore = new Ext.data.Store({
        id: 'sysIdStore',
        fields: ['value', 'show'],
        proxy: {
            type: 'ajax',
            url: '<%=request.getContextPath()%>/getComBoxForSystemFolder.do',
            reader: {
            	type: 'json',
           		root: 'data'
           	}
        }
    });
    sysIdStore.load();
    var sysIdCombox = Ext.create('Ext.form.field.ComboBox',{
    	id:'sysIdCombox',
        store: sysIdStore,
        labelAlign: 'right',
        id: "sysId",
        name: "sysId",
        width: 250,
        forceSelection:true,
        typeAhead:true,
        minChars:1,
		allowBlank: false,
        selectOnFocus: true,
        triggerAction: 'all',
        queryMode: 'local',
        fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>归属系统",
        valueField: 'value',
        displayField: 'show'
    });
	var funFolderForm = Ext.widget('form', {
        id: 'funFolderForm',
        width: screenWidth,
        border:0,
		<%if((!flag.equals("")&&flag.equals("create"))||(!flag.equals("")&&flag.equals("alter"))){%>
        tbar: [{
        	xtype: 'button',
            text: '保存',
            handler: function () {
            	var form = Ext.getCmp('funFolderForm');
                MaskLoading();
                form.submit({
                	clientValidation: true,
                    url: "<%=request.getContextPath()%>/saveSubSysFolderForm.do",
                    params: {},
                    method: 'POST',
                    success: function (response, config) {
                    	MaskOver();
                        var success = config.result.success;
						if (success) {
                        	Ext.MessageBox.show({        
                        		title: '提示',        
                        		msg: '保存成功!',
        						buttons: Ext.MessageBox.OKCANCEL,        
        						fn: function(btn){           
                        			if(btn=='ok'){
									    <%if(!flag.equals("")&&flag.equals("create")){%>
                        				top.Ext.getCmp("funFolderCreateWin").close(); 
									    <%}if(!flag.equals("")&&flag.equals("alter")){%>
                        				top.Ext.getCmp("funFolderAlterWin").close(); 
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
                    	}else{
                        	Ext.Msg.alert("提示",config.result.message);
                    	}
                    }
                });
			}
        }],
		<%}%>
		<%if(!flag.equals("")&&flag.equals("create")){%>
		title: '新增子系统信息',
	    <%}if(!flag.equals("")&&flag.equals("alter")){%>
		title: '修改子系统信息',
	    <%}%> 
        layout: {
        	type: 'vbox'
        },
        listeners: {
			render: function (render, eOpts) {
    			<%if(!flag.equals("")&&flag.equals("alter")){%>
                MaskLoading();
                funFolderForm.load({
                    params: {
                        subsysId: <%=request.getParameter("subsysId")%>
                    },
                    url: '<%=request.getContextPath()%>/getSubSysFolderBySubSysId.do',
                    method: 'POST',
                    success: function (form, action) {
                    	var sysId = action.result.data.sysId;
                    	if(sysId==0){
                    		Ext.getCmp('funFolderForm').getForm().findField('sysId').setValue("");
                    	}
                    	MaskOver();
                    },
                    failure: function (form, action) {
                    	MaskOver();
                        Ext.Msg.alert('提示', "失败原因是: " + action.result.errorMessage);
                    }
                });
                <%}%>
			}	
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
		            	width: 500,
		                labelAlign: 'right',
		                id:'sysName',
		                name: 'sysName',
		                fieldLabel: "<font style='color: red; font-weight:bold;'>*</font>子系统名称",
		                allowBlank: false
	            	},{
		                xtype: 'hidden',
		                id:'subsysId',
		                name: 'subsysId',
		                fieldLabel: '子系统id'
	            	},{
		                xtype: 'hidden',
		                id:'createTime',
		                name: 'createTime',
		                fieldLabel: '子系统创建时间'
	            	}
	            ]
			},{
	        	xtype: 'fieldcontainer',
	            labelStyle: 'font-weight:bold;padding:0',
	            layout: 'hbox',
	            items: [
	            	sysIdCombox
	            ]
			}
		]
	});
	Ext.create('Ext.Panel', {
    	id:'funPointPanel',
        renderTo: Ext.get('funPountPanel'),
        cls: 'ui-formPanel',
        width: screenWidth*0.99,
        height: screenHeight*0.99,
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
            items: [funFolderForm]
        }]
    });
	Ext.getCmp('funFolderForm').doLayout();
});
</script>
</html>