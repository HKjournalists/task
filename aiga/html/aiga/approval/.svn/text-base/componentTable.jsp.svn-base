<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser"); %>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/extJs/resources/css/ext-all.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/extJs/ext-all.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/base/jquery-1.8.0.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/base/json2.js"></script>
	<title>未审批组件</title>
</head>
<body>
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
Ext.onReady(function(){
	loadMask = new Ext.LoadMask(Ext.getBody(),{
		msg : '数据处理中!',
		disabled : false
	});
	var compModel = Ext.regModel("compModel",{
		fields:[
			{name:'compId',type:'string'},
			{name:'compName',type:'string'},
			{name:'permission',type:'string'},
			{name:'compDesc',type:'string'},
			{name:'author',type:'string'},
			{name:'latestOperator',type:'string'}]
	});
	
	var gridProxy = new Ext.data.proxy.Ajax({
			type:"ajax",
			model:compModel,
			url:'<%=request.getContextPath()%>/getUnApprovalComp.do',
			reader:{
				root:"data",
				type:"json"
			}
		});
	gridStore = Ext.create('Ext.data.Store',{
		model:compModel,
		proxy:gridProxy
	});
	
	gridStore.load({
		params: {currentStaff:'<%=user.getUserAccount()%>'}
	});
	
	var caseGrid = Ext.create('Ext.grid.Panel',{
		tbar:Ext.create('Ext.Toolbar',{
			items:[{
				text:'批量审批',
				handler:function(){
					var selections = caseGrid.getSelectionModel().getSelection();
					if(selections.length==0){
						Ext.Msg.alert('提示','请选择要审批的组件');
						return;
					}
					var compIds = new Array();
					for(var i=0,n=selections.length;i<n;i++){
						compIds.push(selections[i].raw.compId);
					}
					loadMask.show();
					Ext.Ajax.request({
						url:'<%=request.getContextPath()%>/batchApprovalComp.do',
						params:{
							compIds:compIds.join(",")
						},
						success:function(response,config){
							loadMask.hide();
							caseGrid.getStore().reload({params:{currentStaff:'<%=user.getUserAccount()%>'}});
							Ext.Msg.alert('提示','审批成功');
						},
						failure:function(response,config){
							loadMask.hide();
							Ext.Msg.alert('提示','审批失败');
						}
					});
				}
			}]
		}),
		id:'caseGrid',
		renderTo:Ext.getBody(),
        cls: 'ui-formPanel',
		title:'组件审批',
		height: screenHeight*0.99,
	    width: screenWidth*0.998,
		viewConfig:{
			forctFit:true,
			stripeRows:true
		},
		store:gridStore,
		selModel:Ext.create("Ext.selection.CheckboxModel",{mode:"SIMPLE"}),
		listeners:{
			itemdblclick:function(grid,record,item,index,e,eOpts){
				var compApproval = new Ext.window.Window({
				    id:'compApproval',
				    title : '组件审批',
				    width : 780,
				    height : 536,
				    modal : true,
				    resizable:false,
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/approval/componentApproval.jsp?compId='+record.raw.compId+'" width="950" height="600"/>'
		   		}).show();
			}
		},
		columns:[
				new Ext.grid.RowNumberer(),
				{header: "组件ID", width:100, sortable: true, dataIndex: 'compId',hidden:true},
				{header: "组件名", width:100, sortable: true, dataIndex: 'compName'},
				{header: "状态", width:100, sortable: true, dataIndex: 'permission',renderer: function (value, meta, record) {
					if(value=='1')
						return '不通过';
					else if(value=='0')
						return '通过';
				}},
        		{header: "组件描述", width:100,sortable: true, dataIndex: 'compDesc'},
        		{header: "组件作者", width:100, sortable: true, dataIndex: 'author'},
        		{header: "最后操作人", width:100, sortable: true, dataIndex: 'latestOperator'}
        	]
	});
});
function closeCompWin(){
	Ext.getCmp('compApproval').close();
	gridStore.reload({
		params: {currentStaff:'<%=user.getUserAccount()%>'}
	});
}
</script>
</html>