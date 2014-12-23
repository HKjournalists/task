<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@page import="com.asiainfo.aiga.common.CommonUtil"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<%
    String flag = request.getParameter("flag");//判断是添加还是修改 create alter query
    if(flag == null){
	   flag = "";
    }
%> 
<html>
<head>
	<title>月度运营KPI体系管理</title>
	<style type="text/css">
		#uploadForm-body table {
			float: left;
		}
		
		#uploadForm-body div {
			float: left;
		}
	</style>
</head>
<body>
</body>

<script type="text/javascript">
var planId="${param.planId}";
var taskId="${param.taskId}";
var extjsFolderPath='<%=request.getContextPath()%>/extJs';
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.tip.QuickTipManager.init();
        var monthRunKpiForm = Ext.widget('form',{
				id: 'monthRunKpiForm',
				layout: 'vbox',
				 tbar: [
					 <%if(flag!=null&&!flag.equals("query")){%>
			        {
		               xtype: 'button',
		               text: '保存',
			           handler:function(){
				        var form=Ext.getCmp("monthRunKpiForm");
				        			MaskLoading();
			                        form.submit({
						  			url:"<%=request.getContextPath()%>/saveMonthRunKpi.do",
						  			params : {
			                        },
						  			method:'POST',  
			                    	success:function(response,config){ 
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
	                        					top.Ext.getCmp("monthRunKpiAlterWin").close();
	                        				<%}else if(flag.equals("create")){%>
	                        					top.Ext.getCmp("monthRunKpiCreateWin").close();
	                        				<%}%>
	                        			} 
	                        		},  
	                        		icon: Ext.MessageBox.QUESTION    
	                        	});
							}
			                        },
			                        failure:function(response,config){
			                    MaskOver();  
										Ext.Msg.alert("提示","数据修改失败!");
			                        }
			    	            });
			    			}
			            }
			        	<%}else{%>
			        	{
				        	xtype: 'button',
				            text: '关闭',
				            handler: function () {
				            	top.Ext.getCmp("monthRunKpiQueryWin").close();
							}
			        	}
			        	<%}%>
	            ],
	            title: '衡量结果KPI详细信息',
	            layout: {
	            	type: 'vbox'
	            },
	            listeners: {
	    		    <%if(!flag.equals("")&&(flag.equals("alter")||flag.equals("query"))){%>
	    			render: function (render, eOpts) {
	                    Ext.getCmp('monthRunKpiForm').load({
	                        params: {
	                            kpiId: <%=request.getParameter("kpiId")%>
	                        },
	                        url: '<%=request.getContextPath()%>/getMonthRunKpiByKpiId.do',
	                        method: 'POST',
	                        success: function (form, action) {
	                        	<%if(flag.equals("query")){%>
	                        	var fieldAry = Ext.getCmp('monthRunKpiForm').getForm().getFields();
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
				items: [{
                    xtype: 'fieldcontainer',
                    labelStyle: 'font-weight:bold;padding:0',
                    layout: 'hbox',
                    defaultType: 'textfield',
                    items: [{
                            width: 1000,
                            labelAlign: 'right',
                            id:'kpiName',
                            name: 'kpiName',
                            fieldLabel: 'KPI名称',
                            allowBlank: false
                        }, {
                            xtype: 'hidden',
                            id:'kpiId',
                            name: 'kpiId',
                            fieldLabel: 'KPIid'
                        }
                    ]
                },{
                    xtype: 'fieldcontainer',
                    labelStyle: 'font-weight:bold;padding:0',
                    layout: 'hbox',
                    defaultType: 'textfield',
                    items: [
                           {
                           width: 500,
                           labelAlign: 'right',
                           id:'kpiDefine',
                           name: 'kpiDefine',
                           fieldLabel: 'KPI定义'
                         }, {
                            width: 500,
                            labelAlign: 'right',
                            id:'computationalFormula',
                            name: 'computationalFormula',
                            fieldLabel: "计算公式"
                         }
                    ]
			      },{
                    xtype: 'fieldcontainer',
                    labelStyle: 'font-weight:bold;padding:0',
                    layout: 'hbox',
                    defaultType: 'textfield',
                    items: [
                           {
                            width: 250,
                            labelAlign: 'right',
                            id:'targetAttention',
                            name: 'targetAttention',
                            fieldLabel: '指标关注'
                        },  {
                            width: 250,
                            labelAlign: 'right',
                            id:'targetUnit',
                            name: 'targetUnit',
                            fieldLabel: "指标单位"
                        },  {
                            width: 250,
                            id:'targetDepartment',
                            name: 'targetDepartment',
                            labelAlign: 'right',
                            fieldLabel: '指标负责部门'
                         },  {
                            width: 250,
                            labelAlign: 'right',
                            id:'standardValue',
                            name: 'standardValue',
                            fieldLabel: "达标值"
                        }
                    ]
			      },{
	                    xtype: 'fieldcontainer',
	                    labelStyle: 'font-weight:bold;padding:0',
	                    layout: 'hbox',
	                    defaultType: 'textfield',
	                    items: [
                               {
                              width: 250,
                              xtype: 'datefield',
                              id:'targetProvideTime',
                              name: 'targetProvideTime',
                              labelAlign: 'right',
                              format: 'Y-m-d',
                              fieldLabel: '指标提供时间'
                              }, {
                             width:250,
                             xtype: 'datefield',
                             id:'statisticsCycleTime',
                             labelAlign: 'right',
                             name: 'statisticsCycleTime',
                             format: 'Y-m-d',
                             fieldLabel: '统计周期'
                            },{
        		                xtype: 'hidden',
        		                id:'kpiStatus',
        		                name: 'kpiStatus',
        		                fieldLabel: '是否可用标识(1:可用,0:禁用)',
        		                value:'1'
        	            	}
	                    ]
				      }
    			]
      });
	Ext.create('Ext.Panel', {
		renderTo: Ext.getBody(),
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
		items: [ {
			region: 'center',
			 items:[monthRunKpiForm]
		}]
    });
});
</script>
</html>