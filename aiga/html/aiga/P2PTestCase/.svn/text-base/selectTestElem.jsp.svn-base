<!DOCTYPE HTML>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");%>
<%@ include file="/aiga/common/common.jsp" %>
<html>
<head>
	<title></title>
</head>
  
<body>
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth - 20;
var screenHeight = document.documentElement.clientHeight - 10;
var busiOneLevelId = ${param.busiOneLevelId};
var busiTwoLevelId = ${param.busiTwoLevelId};
/**
 * 载入表单
 */
function loadForm(){
	 MaskLoading();
	 Ext.getCmp('AigaP2pTestElemForm').getForm().load({
           params: {
           	busiTwoLevelId: busiTwoLevelId
           },
           url: '<%=request.getContextPath()%>/getAigaP2pTestElem.do',
           method: 'POST',
           success: function (form, action) {
        	   MaskOver();
           	var _baseFunctionIds=new Array();
           	var _channelIds=new Array();
       		var strBaseFunctionIds=action.result.data.baseFunctionIds;
       		var strChannelIds=action.result.data.channelIds;
       		if(strBaseFunctionIds!=''){
       			var baseFunctionIds=strBaseFunctionIds.split(',');
           		for(var i=0,n=baseFunctionIds.length;i<n;i++)_baseFunctionIds.push(parseInt(baseFunctionIds[i]));
           		Ext.getCmp('_baseFunctionIds').setValue(_baseFunctionIds);
       		}
       		if(strChannelIds!=''){
       			var channelIds=strChannelIds.split(',');
       			for(var i=0,n=channelIds.length;i<n;i++)_channelIds.push(parseInt(channelIds[i]));
               	Ext.getCmp('_channelIds').setValue(_channelIds);
       		}
           },
           failure: function (form, action) {
               Ext.Msg.alert('提示', '失败 ');
        	   MaskOver();
           }
           });
}
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.tip.QuickTipManager.init();
	var AigaP2pTestElemForm=new Ext.form.Panel({
    	xtype:'form',
    	title:'选择测试要素',
    	id:'AigaP2pTestElemForm',
	    margins : '10 0 0 3',
		height: screenHeight*0.13,
	    width: screenWidth,
    	bodyBorder: '10 0 0 3',
    	listeners:{
    	    render: function (render, eOpts) {
    	    	loadForm();
            }
    	},
    	 items: [{
                xtype: 'fieldcontainer',
                labelStyle: 'font-weight:bold',
                layout: 'hbox',
                padding:'10 0 0 0',
                defaultType: 'textfield',
                items: [
						{xtype:'hidden',name:'elemId'},
                        {xtype: 'combo',width: 450,labelWidth: 60,id: '_baseFunctionIds', fieldLabel: '基础功能',displayField: 'funName',valueField: 'funId', multiSelect : true,
                        	listConfig:{
                        		itemTpl : Ext.create('Ext.XTemplate', '<input type=checkbox>{funName}</input>'), 
					            listeners:{itemclick:function(view, record, item, index, e, eOpts ){var isSelected = view.isSelected(item); var checkboxs = item.getElementsByTagName('input'); if(checkboxs!=null)  {var checkbox = checkboxs[0];if(!isSelected)checkbox.checked = true;else checkbox.checked = false; }}},
					            onItemSelect: function(record) { var node = this.getNode(record);if (node) {Ext.fly(node).addCls(this.selectedItemCls);var checkboxs = node.getElementsByTagName('input');  if(checkboxs!=null){var checkbox = checkboxs[0]; checkbox.checked = true;}  } }
					            }, 
					store: Ext.create('Ext.data.Store', {
						autoLoad :true,
						fields:[{name:'funName'},{name:'funId'}],
						proxy: {type: 'ajax',url: '<%=request.getContextPath()%>/getBaseFunctionCombox.do',reader: {type: 'json',root: 'data'}}
				})
				}
				,{xtype: 'combo',id: '_channelIds',width: 450,labelWidth: 40, fieldLabel: '渠道',displayField: 'channelName',valueField: 'channelId', multiSelect : true,
					listConfig:{
                		itemTpl : Ext.create('Ext.XTemplate', '<input type=checkbox>{channelName}</input>'), 
			            listeners:{itemclick:function(view, record, item, index, e, eOpts ){var isSelected = view.isSelected(item); var checkboxs = item.getElementsByTagName('input'); if(checkboxs!=null)  {var checkbox = checkboxs[0];if(!isSelected)checkbox.checked = true;else checkbox.checked = false; }}},
			            onItemSelect: function(record) { var node = this.getNode(record);if (node) {Ext.fly(node).addCls(this.selectedItemCls);var checkboxs = node.getElementsByTagName('input');  if(checkboxs!=null){var checkbox = checkboxs[0]; checkbox.checked = true;}  } }
			            }, 
					store: Ext.create('Ext.data.Store', {
						autoLoad :true,
						fields:[{name:'channelName'},{name:'channelId'}],
						proxy: {type: 'ajax',url: '<%=request.getContextPath()%>/getChannelCombox.do',reader: {type: 'json',root: 'data'}},
						listeners:{
							load:function(){
							}
						}
				})
				},
				{
                	   xtype:'button',
                	   text:'提交选择',
                	   handler:function(){
                		   
                		   var channelIds= Ext.getCmp('_channelIds').getValue();
                		   var basFunctionIds= Ext.getCmp('_baseFunctionIds').getValue();
                		   if(channelIds==null ||channelIds.length==0){
                			   alert('渠道不能为空!');return ;
                		   }
                		   if(basFunctionIds==null||basFunctionIds.length==0){
                			   alert('基础功能不能为空!');return;
                		   }
                		   MaskLoading();
                		    var form = Ext.getCmp('AigaP2pTestElemForm').getForm();
                            form.submit({
                                url: '<%=request.getContextPath()%>/saveAigaP2pTestElem.do',
                                params:{busiTwoLevelId:'${param.busiTwoLevelId}',channelIds: channelIds.join(','),baseFunctionIds: basFunctionIds.join(',')},
                                success: function (fp, action) {
                                	MaskOver();
                                	loadForm();
                                },
                                failure: function (form, action) {
                                    Ext.Msg.alert('提示', '失败 ');
                                    MaskOver();
                                    loadForm();
                                }
                            });
                	   }
                   }
				]
            }
            ]
    });
	Ext.create('Ext.panel.Panel',{
		minWidth: 1200-260,
		minHeight: 350,
		width: screenWidth,
	    height: screenHeight + 5,
	    renderTo: Ext.getBody(),
	    cls: 'ui-formPanel',
		bodyBorder:0,
		listeners:{
		},
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
			items:[AigaP2pTestElemForm]
		}]
	});
});

</script>
</html>