<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");%>
<html>
<head>
<title>已办工单查询</title>
</head>
<body>
	<div id="queryworkorder_div" class="div_title" style="width:100%;height:20%">
		<table class="content_title" border="0">
			<tr>
				<td class="content_title_text">工单查询区</td>
			</tr>
	    </table>
	    <table align="center" width="100%">
			<tr>
				<td class="title_e">名称：</td>
				<td align="left"><input class="x-form-field x-form-text" id="name" type="text" style="width:200px;editable:true"></td>
			    <td class="title_e">类型：</td>
			    <td align="left" id="objType"></td>
			    <td class="title_e">起始创建时间：</td>
				<td align="left" id="createTime"></td>
				<td align="right"><input type="button" onclick="queryWorkorder()" value="查询" class="btn-2word"/></td>
			</tr>
		</table>
	</div>
	<div id="queryworkorder_list_div" class="div_title" style="width:100%;height:80%">
		<table class="content_title" border="0">
        	<tr>
	    		<td class="content_title_text">工单显示区</td>
			</tr>
		</table>
		<table width="100%" align="center" class="table_context">
			<tr>
				<td width="100%" id="workorderTable"></td>
			</tr>
		</table>
	</div>
</body>
<script type="text/javascript">
Ext.onReady(function(){

Ext.QuickTips.init();
Ext.regModel('extCommboModel', {
    fields: [
        {type: 'string', name: 'value'},
        {type: 'string', name: 'show'}
    ]
});

var condProxy = new Ext.data.proxy.Ajax({
	type:"ajax",
	model:"extCommboModel",
	url:'<%=request.getContextPath()%>/getSysParam.do?category=OBJ_TYPE',
	reader:{
		root:"data",
		type:"json"
	}
});
var condStore = Ext.create('Ext.data.JsonStore',{
	model:"extCommboModel",
	proxy:condProxy,
	listeners:{
		load:function(store,records){
			var blankRecord={value:'',show:'--请选择--'};
			store.insert(0,blankRecord);
		}
	}
});

condStore.load();
Ext.create('Ext.form.field.ComboBox', {
	id:'objType',
	renderTo:'objType',
    multiSelect: false,
    displayField: 'show',
    valueField:'value',
    width: 200,
    store: condStore,
    queryMode: 'local'
});

Ext.create('widget.datefield',{
	format: 'Y-m-d',
	id:'createTime',
	width:200,
	renderTo:'createTime'
});
var workorderModel = Ext.regModel("workorderModel",{
	fields:[
		{name:'orderId',type:'string'},
		{name:'objId',type:'string'},
		{name:'execStaffId',type:'string'},
		{name:'linkNo',type:'string'},
		{name:'objTag',type:'string'},
		{name:'objName',type:'string'},
		{name:'orderType',type:'int'},
		{name:'vmTaskName',type:'string'},
		{name:'objType',type:'int'},
		{name:'createTime',type:'string'},
		{name:'status',type:'int'},
		{name:'submitStaffName',type:'string'},
		{name:'templateId',type:'string'}]
	});
	
	var gridProxy = new Ext.data.proxy.Ajax({
		type:"ajax",
		model:workorderModel,
		url:'<%=request.getContextPath()%>/getDomainJsonDataForQuery.do?urlJava=/business/com.asiainfo.csc.common.web.WorkorderListAction&action=getWorkorderDoneList',
		reader:{
			root:"data",
			type:"json"
		}
	});
	var gridStore = Ext.create('Ext.data.Store',{
		id:'workorderStore',
		pageSize:20,
		model:workorderModel,
		proxy:gridProxy,
		remoteSort: true
	});
	
	gridStore.on('beforeload', function(store, options) {
		var name = encodeURI(encodeURI($('#name').val()));
		var objType = encodeURI(encodeURI(Ext.getCmp('objType').getValue()==undefined?'':Ext.getCmp('objType').getValue()));
		var createTime = encodeURI(encodeURI(Ext.util.Format.date(Ext.getCmp('createTime').getValue(),'Y-m-d')));
		Ext.apply(gridStore.proxy.extraParams,{staffId:'<%=user.getUserId()%>',name:name,objType:objType,createTime:createTime});
	});
	
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
            url: '<%=request.getContextPath()%>/getMultipleSysConstant.do?categorys=OBJ_TYPE,ORDER_STATUS,ORDER_TYPE',
            reader: {
                type: 'json',
                root: 'data'
            }
        },
        listeners:{
			load:function(){
				gridStore.load({params:{staffId:'<%=user.getUserId()%>',name:'',orderType:'',createTime:''}});
			}
		}
    });
    mapStore.load();
	var workorderGrid = Ext.create('Ext.grid.Panel',{
		id:'workorderGrid',
		renderTo:'workorderTable',
		height:document.documentElement.clientHeight*0.840,
		viewConfig:{
			forctFit:true,
			stripeRows:true
		},
		store:gridStore,
		selType:'rowmodel',
		bbar: Ext.create('Ext.PagingToolbar', { 
			store: gridStore, 
			displayInfo: true, 
			displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
			emptyMsg: "没有数据"
		}),
		listeners:{
			itemdblclick:function(grid,record,item,index,e,eOpts){
				var url = '';
				if(record.raw.objType=='1'){
					url = '<%=request.getContextPath()%>/aiga/workflow/search/TestPlanForm.jsp?objId='+record.raw.objId+'&planFlag=1&objType='+record.raw.objType+'&linkNo='+record.raw.linkNo;
				}else if(record.raw.objType=='3'){
					url = '<%=request.getContextPath()%>/aiga/workflow/search/TestTaskForm.jsp?taskId='+record.raw.objId+'&flag=1&objType='+record.raw.objType+'&objId='+record.raw.objId;
				}else if(record.raw.objType=='4'){
					url = '<%=request.getContextPath()%>/aiga/workflow/subTaskAnalysis.jsp?objId='+record.raw.objId;
				}else if(record.raw.objType=='5'){
					url = '<%=request.getContextPath()%>/aiga/workflow/P2PSubTaskAnalysis.jsp?objId='+record.raw.objId;
				}else if(record.raw.objType=='6'){
					url = '<%=request.getContextPath()%>/aiga/workflow/perfSubTest/PerfSubTaskForm.jsp?objId='+record.raw.objId;
				}else if(record.raw.objType=='21'){
					url = '<%=request.getContextPath()%>/aiga/workflow/search/TestSolidTaskForm.jsp?taskId='+record.raw.objId+'&taskTypeName='+encodeURI(encodeURI("安全测试"))+'&templateId=21000'+'&linkNo='+record.raw.linkNo+'&objId='+record.raw.objId+'&objType='+record.raw.objType;
				}else if(record.raw.objType=='22'){
					url = '<%=request.getContextPath()%>/aiga/workflow/search/TestSolidTaskForm.jsp?taskId='+record.raw.objId+'&taskTypeName='+encodeURI(encodeURI("性能测试"))+'&templateId=22000'+'&linkNo='+record.raw.linkNo+'&objId='+record.raw.objId+'&objType='+record.raw.objType;
				}else if(record.raw.objType=='23'){
					url = '<%=request.getContextPath()%>/aiga/workflow/search/TestSolidTaskForm.jsp?taskId='+record.raw.objId+'&taskTypeName='+encodeURI(encodeURI("代码扫描"))+'&templateId=23000'+'&linkNo='+record.raw.linkNo+'&objId='+record.raw.objId+'&objType='+record.raw.objType;
				}else if(record.raw.objType=='24'){
					url = '<%=request.getContextPath()%>/aiga/workflow/search/TestSolidTaskForm.jsp?taskId='+record.raw.objId+'&taskTypeName='+encodeURI(encodeURI("自动回归测试"))+'&templateId=24000'+'&linkNo='+record.raw.linkNo+'&objId='+record.raw.objId+'&objType='+record.raw.objType;
				}else if(record.raw.objType=='25'){
					url = '<%=request.getContextPath()%>/aiga/workflow/search/TestSolidTaskForm.jsp?taskId='+record.raw.objId+'&taskTypeName='+encodeURI(encodeURI("手动回归测试"))+'&templateId=25000'+'&linkNo='+record.raw.linkNo+'&objId='+record.raw.objId+'&objType='+record.raw.objType;
				}else if(record.raw.objType=='7'){
					url = '<%=request.getContextPath()%>/aiga/workflow/search/TestTaskForm.jsp?taskId='+record.raw.objId+'&flag=1&objType='+record.raw.objType+'&objId='+record.raw.objId;
				}else if(record.raw.objType=='8'){
					url = '<%=request.getContextPath()%>/aiga/workflow/subTaskProblem/SubTaskProblem.jsp?objId='+record.raw.objId+'&flag=1';
				}else if(record.raw.objType=='9'){
					url = '<%=request.getContextPath()%>/aiga/workflow/perfTestTask/PerfTaskForm.jsp?hide=true&taskId='+record.raw.objId+'&flag=1&objType='+record.raw.objType+'&objId='+record.raw.objId;
				}
				Ext.create(top.Ext.window.Window,{
				    title : '详细信息',
				    modal : true,
				    resizable:false,
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="'+url+'" style="width:1100px;height:510px;"/>'
			   }).show();
			}
		},
		columns:[
			{xtype: 'rownumberer',width:30},
			{header: "工单ID", width:100, sortable: true, dataIndex: 'orderId',hidden:true},
			{header: "业务ID", width:100, sortable: true, dataIndex: 'objId',hidden:true},
       		{header: "工单处理人", width:100,sortable: true, dataIndex: 'execStaffId',hidden:true},
       		{header: "环节编号", width:100, sortable: true, dataIndex: 'linkNo',hidden:true},
       		{header: "编号", width:150, sortable: true, dataIndex: 'objTag'},
       		{header: "名称", width:250, sortable: true, dataIndex: 'objName'},
       		{header: "工单类型", width:100, sortable: true, dataIndex: 'orderType', renderer: function (value, cellmeta, record) {
                   try {
                       var store = Ext.data.StoreManager.lookup("mapStore");
                       store.clearFilter(true);
                       store.filter("categoryName", "工单类型");
                       return store.findRecord("value", value).getData().show + "";
                   } catch (e) {
                       return "未指定"+value;
                   };
               }},
       		{header: "环节名称", width:100, sortable: true, dataIndex: 'vmTaskName'},
       		{header: "对象类型", width:100, sortable: true, dataIndex: 'objType',renderer: function (value, cellmeta, record) {
                   try {
                       var store = Ext.data.StoreManager.lookup("mapStore");
                       store.clearFilter(true);
                       store.filter("categoryName", "对象类型");
                       return store.findRecord("value", value).getData().show + "";
                   } catch (e) {
                       return "未指定"+value;
                   };
               }},
       		{header: "创建时间", width:140, sortable: true, dataIndex: 'createTime'},
       		{header: "工单状态", width:100, sortable: true, dataIndex: 'status',renderer: function (value, cellmeta, record) {
                   try {
                       var store = Ext.data.StoreManager.lookup("mapStore");
                       store.clearFilter(true);
                       store.filter("categoryName", "工单状态");
                       if(value==-1){
                       	return "已关闭";
                       }else{
                       	return store.findRecord("value", value).getData().show + "";
                       }
                       
                   } catch (e) {
                       return "未指定"+value;
                   };
               }},
       		{header: "创建人", width:100, sortable: true, dataIndex: 'submitStaffName'},
       		{header: "模板ID", width:100, sortable: true, dataIndex: 'templateId',hidden:true}
       	]
	});
});

function queryWorkorder(){
	var name = encodeURI(encodeURI($('#name').val()));
	var objType = encodeURI(encodeURI(Ext.getCmp('objType').getValue()==undefined?'':Ext.getCmp('objType').getValue()));
	var createTime = encodeURI(encodeURI(Ext.util.Format.date(Ext.getCmp('createTime').getValue(),'Y-m-d')));
	Ext.getCmp('workorderGrid').getStore().reload({params:{staffId:'<%=user.getUserId()%>',name:name,objType:objType,createTime:createTime}});
	Ext.getCmp('workorderGrid').getStore().loadPage(1);
}
</script>
</html>