<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser"); %>
<html>
<head>
	<title>未审批用例</title>
</head>
<body>
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
Ext.onReady(function(){
	var caseModel = Ext.regModel("caseModel",{
		fields:[
			{name:'caseId',type:'string'},
			{name:'caseName',type:'string'},
			{name:'caseDesc',type:'string'},
			{name:'createTime',type:'string'},
			{name:'updateTime',type:'string'},
			{name:'author',type:'string'},
			{name:'latestOperator',type:'string'},
			{name:'status',type:'string'}]
	});
	
	var gridProxy = new Ext.data.proxy.Ajax({
			type:"ajax",
			model:caseModel,
			url:'<%=request.getContextPath()%>/getUnApprovalCaseTable.do',
			reader:{
				root:"data",
				type:"json"
			}
		});
	var gridStore = Ext.create('Ext.data.Store',{
		model:caseModel,
		proxy:gridProxy
	});
	
	gridStore.load();
	
	var caseGrid = Ext.create('Ext.grid.Panel',{
		tbar:Ext.create("Ext.Toolbar",{
			items:[{
				text:'批量审批',
				handler:function(){
					var selections = caseGrid.getSelectionModel().getSelection();
					if(selections.length==0){
						Ext.Msg.alert('提示','请选择要审批的用例');
						return;
					}
					var caseIds = new Array();
					for(var i=0,n=selections.length;i<n;i++){
						caseIds.push(selections[i].raw.caseId);
					}
					MaskLoading();
					Ext.Ajax.request({
						url:'<%=request.getContextPath()%>/batchApprovalCase.do',
						params:{
							caseIds:caseIds.join(",")
						},
						success:function(response,config){
							MaskOver();
							caseGrid.getStore().reload();
						},
						failure:function(response,config){
							MaskOver();
							Ext.Msg.alert('提示','审批失败');
						}
					});
				}
			}]
		}),
		id:'caseGrid',
		renderTo:Ext.getBody(),
        cls: 'ui-formPanel',
		title:'用例审批',
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
				var caseApproval = new top.Ext.window.Window({
				    id:'caseApproval',
				    title : '用例审批',
				    width : 780,
				    height : 536,
				    modal : true,
				    resizable:false,
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/approval/caseApproval.jsp?caseId='+record.raw.caseId+'" width="950" height="600"/>'
		   		}).show();
			}
		},
		columns:[
			new Ext.grid.RowNumberer(),
			{header:"主键",width:100,dataIndex:"caseId",sortable:true,hidden:true},
			{header:"用例名称",width:100,dataIndex:"caseName",sortable:true},
			{header:"用例描述",width:100,dataIndex:"caseDesc",sortable:true},
			{header:"创建时间",width:100,dataIndex:"createTime",sortable:true},
			{header:"更新时间",width:100,dataIndex:"updateTime",sortable:true},
			{header:"创建人",width:100,dataIndex:"author",sortable:true},
			{header:"最新操作人",width:100,dataIndex:"latestOperator",sortable:true},
			{header:"当前状态",width:100,dataIndex:"status",sortable:true,renderer:function(value){
				if(value=='1')
					return '未审批';
				else if(value=='2')
					return '未通过';
				else if(value=='3')
					return '通过';
				else
					return '未知状态';
			}}]
	});
});
	
function closeCaseWin(){
	Ext.getCmp('caseApproval').close();
	gridStore.reload();
}
</script>
</html>