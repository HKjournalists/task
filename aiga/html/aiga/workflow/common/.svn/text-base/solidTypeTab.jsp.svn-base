<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.helper.ActionHelper"%>
<%@page import="com.asiainfo.aiga.statistics.bo.StatGridColumns"%>
<%@page import="com.asiainfo.aiga.statistics.bo.StatGrid"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<%@page import="com.asiainfo.aiga.common.helper.CommonHelper"%>
<%@page import="com.asiainfo.aiga.sysConstant.bo.SysConstant"%>
<%@page import="com.asiainfo.aiga.common.BaseAction"%>
<%@page import="com.asiainfo.aiga.sysConstant.util.SysContentUtil"%>
<%@page import="com.asiainfo.aiga.common.WorkflowParam"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");%>
<%
	String objId=request.getParameter("objId");
	String objType=request.getParameter("objType");
	SysConstant sysConstant=null;
	if(objType!=null&&!objType.equals("")){
		sysConstant=SysContentUtil.getSysConstant("SOLID_TASK_TYPE", objType);
	}
	String isEditor=request.getParameter("isEditor");
	String primaryKey="";
	if(objType.equals("21"))primaryKey="seId";
	if(objType.equals("22"))primaryKey="pfId";
	if(objType.equals("23"))primaryKey="csId";
	if(objType.equals("24"))primaryKey="rtId";
	if(objType.equals("25"))primaryKey="htId";
%>
<html>
<head>
<%@ include file="/aiga/common/include.jsp" %>
	<title>固化任务类型</title>
	<style>
	.save-button{background: url(<%=request.getContextPath()%>/css/images/save.png) left top no-repeat;   }
	.add-button{background: url(<%=request.getContextPath()%>/css/images/add.png) left top no-repeat;   }
	.search-button{background: url(<%=request.getContextPath()%>/css/images/search.png) left top no-repeat;   }
	</style>
</head>
<body>
</body>
<script type="text/javascript">
var objId="${param.objId}";
var objType="${param.objType}";
var screenWidth = document.documentElement.clientWidth==0?900:document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight==0?170:document.documentElement.clientHeight;
 function ifrmLoaded() {
		//frame_1.setGridAllColumnsEditor(Grid,false);
	}
 <%if(objType!=null&&objType.equals("21")){%>
 function setSubColumnsEditor(column,status){
		try{
			var columns=column.items.items;
			//console.log(columns);
			for(var i=0,n=columns.length;i<n;i++){
				var _column=columns[i];
				if(_column.headerCounter>0){
					setSubColumnsEditor(_column,status);
				}
				columns[i].setEditor(status);
			}
		}catch(e){
			//console.log(e);
			}
	}
	function setGridAllColumnsEditor(Grid,status){
		try{
			var columns=Grid.columns;
			for(var i=0,n=columns.length;i<n;i++){
				var column=columns[i];
				if(colum.text=="系统")continue;
				if(column.headerCounter>0){
					setSubColumnsEditor(column,status);
				}
				try{
					column.setEditor(status);
				}catch(e1){
					
				}
				
			}
		}catch(e){
			//console.log(e);
			}
	}
	function addGridStore(){

		var record = Ext.create('storeModel');
		for(var field in record.data){
			//初始化方法做判断
				<%
				String initJSON="{"+primaryKey+":'',stId:'"+objId+"'}";
				Map initValueMap=ActionHelper.parseJSON2Map(initJSON);
				Iterator<Map.Entry<String, String>> initIt = initValueMap.entrySet().iterator();
			while (initIt.hasNext()) {
		  		 Map.Entry<String, String> entry = initIt.next();
		  		 %>
		  		 if(field=='<%=entry.getKey()%>')record.data[field]='<%=entry.getValue()%>';
		  		 <%
	  		 }
		%>
		}
		var Grid= Ext.getCmp('Grid');
		var store=Grid.getStore();
		var index = store.data.length;
		store.insert(0,record);
		Grid.getView().refresh();

	}
	function delGridStore(){
		var grid=Ext.getCmp('Grid');
		var store=grid.getStore();
		var selections = grid.getSelectionModel().getSelection();
		if(selections.length==0){
			Ext.Msg.alert('提示','请选择要删除的行！');
			return;
		}
		Ext.Msg.confirm('提示','是否删除该条？',function(optional){
			if(optional=='yes'){
				var data = new Array();
			    Ext.Array.each(selections, function(record) {
			        data.push(record.data);  
			        });
				Ext.Ajax.request({
					url:'<%=request.getContextPath()%>/delGridStore.do',
					params:{
						table:Ext.encode(data),
						stroeName:'<%=sysConstant.getMemo()%>'
						},
					success:function(response,config){
						
					},
					failure:function(response,config){
						Ext.Msg.alert('提示','请求数据失败');
					}
				});
				var rowIndex = store.indexOf(selections[0]);
				store.removeAt(rowIndex);
				grid.getView().refresh();
			}else return;
		});

	}
	function submitGridStore(){
		var Grid= Ext.getCmp('Grid');
		var store=Grid.getStore();
		var records = store.getUpdatedRecords();// 获取修改的行的数据，无法获取幻影数据  
				var phantoms=store.getNewRecords() ;//获得幻影行  
			records=records.concat(phantoms);//将幻影数据与真实数据合并
		var data = new Array(); 
	       Ext.Array.each(records, function(record) {  
	           data.push(record.data);  
	           });
	       //console.log(data);
		Ext.Ajax.request({
			url:'<%=request.getContextPath()%>/submitStatisticsGridStore.do',
			params:{
				table:Ext.encode(data),
				stroeName:'<%=sysConstant.getMemo()%>'
				},
			success:function(response,config){
				store.loadPage(1);
			},
			failure:function(response,config){
				Ext.Msg.alert('提示','请求数据失败');
			}
		});
	}
 <%}%>
Ext.onReady(function(){
<%if(objType!=null&&!objType.equals("21")){%>
	var AigaStGridUrl="<%=request.getContextPath()%>/"+
	"statCommon.html?className=<%=sysConstant.getMemo()%>&initCondition=stId=${param.objId}&initJSON={<%=primaryKey%>:'',stId:'${param.objId}'}&isEditor=${param.isEditor}";
	var AigaStGrid = new Ext.create('Ext.panel.Panel', {
		    title: '',
		    width: screenWidth*.98,
		    height:screenHeight,
		    html:'<iframe id="frame" name="frame_1" frameborder="no"  border=0  marginwidth=0  marginheight=0  scrolling="no" src='+AigaStGridUrl+' width="100%" height="100%"/>',
		    listeners:{
		    	afterrender:function( Component , eOpts ){
		    	}
		    }
		    
		});
<%}else{%>
var storeModel = Ext.regModel("storeModel",{
	fields:[
	        <%
	        //java 注释  反射生成Extjs Model对象
            StringBuffer strFields=new StringBuffer();
	        Map<String,String> map= CommonHelper.getFieldsClassTypeMap(new Class<?>[]{Class.forName(sysConstant.getMemo())});
       	 	Iterator<Map.Entry<String, String>> it = map.entrySet().iterator();
           	 while (it.hasNext()) {
           		 Map.Entry<String, String> entry = it.next();
           		 strFields.append("{name: '");
           		 strFields.append(entry.getKey());
           		 strFields.append("',type: '");
           		 strFields.append(entry.getValue());
           		 strFields.append("'}, ");
           		 }
           	 System.out.println(strFields.toString().substring(0, strFields.toString().length()-2));
            %>
            <%=strFields.toString().substring(0, strFields.toString().length()-2)%>
		]
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
        url: '<%=request.getContextPath()%>/getSysConstantStore.do?category=AIGA_ST_SECUTEST',
        reader: {
            type: 'json',
            root: 'data'
        }
    },
    listeners: {
    }
});
mapStore.load();
var sysComboBox = new Ext.form.ComboBox({
    width: 100,
    store: mapStore,
    name: "sysId",
    valueField: 'value',
    displayField: 'show',
    editable:true,
    	listConfig: {
    },
    listeners: {
    	select :function(combo,records, eOpts ){
    		
    	},
        beforequery: function (queryEvent, eOpts) {
        }
    }
});
var gridProxy = new Ext.data.proxy.Ajax({
	type:"ajax",
	model: storeModel,
	url:'<%=request.getContextPath()%>/getstatisticsoBjectList.do?objName=<%=sysConstant.getMemo()%>&stId=${param.objId}&isEditor=${param.isEditor}',
	reader:{
		 root:"data",
		 type:"json",
		 totalProperty:'total'
	}
});
var gridStore = Ext.create('Ext.data.Store',{
	model: storeModel,
	id:'gridStore',
	pageSize:10,
	listeners:{
	},
	proxy:gridProxy
});
gridStore.load();
var Grid = Ext.create('Ext.grid.Panel',{
	id:'Grid',
    cls: 'ui-formPanel',
    columnLines: true,
	store: gridStore,
	width:screenWidth*0.99,
	height:screenHeight*0.90,
	forctFit:true,
	stripeRows:true,
	loadMask:true,
	selType:'rowmodel'
	<%
	if(isEditor!=null&&!isEditor.equals("false")){
	%>
	,plugins: [Ext.create('Ext.grid.plugin.CellEditing', {
	    clicksToEdit: 1
	})]
	
	,dockedItems: [{
	    xtype: 'toolbar',
	    dock: 'top',
	    id:'gridTbar',
	    items: [
				{xtype:'button',text: '',iconCls: 'save-button',handler: function() {submitGridStore();}},
				{xtype:'button',text: '',iconCls: 'add-button',handler: function() {addGridStore();}},
				{xtype:'button',text: '',iconCls: 'del-button',handler: function() {delGridStore();}}
	            ]
	}]
	<%}%>
	,
	/**bbar: Ext.create('Ext.PagingToolbar', {
		store: gridStore, 
		displayInfo: true, 
		displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
		emptyMsg: "没有数据"
		}),
		**/
	listeners:{
	},
	columns:[
			new Ext.grid.RowNumberer({header:"序号",width:30}),
			{header: "seId",  width:100, hidden:true,sortable: true, dataIndex: 'seId'},
			{header: "stId",  width:100, hidden:true,sortable: true, dataIndex: 'stId'},
			{header: "系统",  width:100, sortable: true, dataIndex: 'sysId',renderer: function (value, cellmeta, record) {
                try {
                    var store = Ext.data.StoreManager.lookup("mapStore");
                    return store.findRecord("value", value).getData().show + "";
                } catch (e) {
                    return "--请选择--";
                }
            }
			<%
			if(isEditor==null||!isEditor.equals("false")){
			%>
			,editor: sysComboBox
			<%}%>
			},
			{header: "测试环境", width:100, sortable: true, dataIndex: 'testEnv'<%if(isEditor==null||!isEditor.equals("false")){%>,editor: {xtype:'textfield'}<%}%>},
			{header: "测试结果", width:100, sortable: true, dataIndex: 'testResult'<%if(isEditor==null||!isEditor.equals("false")){%>,editor: {xtype:'textfield'}<%}%>},
			{header: "紧急",
				columns:[
				         {header: "未修复", width:60, sortable: true, dataIndex: 'ungerNotRepair'<%if(isEditor==null||!isEditor.equals("false")){%>,editor: {xtype:'textfield'}<%}%>},
						 {header: "已修复", width:60, sortable: true, dataIndex: 'ungerRepaired'<%if(isEditor==null||!isEditor.equals("false")){%>,editor: {xtype:'textfield'}<%}%>}
                       	 ]
			},
			{header: "高危",
				columns:[
						{header: "未修复", width:60, sortable: true, dataIndex: 'highriskNotRepair'<%if(isEditor==null||!isEditor.equals("false")){%>,editor: {xtype:'textfield'}<%}%>},
						{header: "已修复", width:60, sortable: true, dataIndex: 'highriskRepaired'<%if(isEditor==null||!isEditor.equals("false")){%>,editor: {xtype:'textfield'}<%}%>}]
			},
			{header: "中危",
				columns:[
						{header: "未修复", width:60, sortable: true, dataIndex: 'midriskNotRepair'<%if(isEditor==null||!isEditor.equals("false")){%>,editor: {xtype:'textfield'}<%}%>},
						{header: "已修复", width:60, sortable: true, dataIndex: 'midhriskRepaired'<%if(isEditor==null||!isEditor.equals("false")){%>,editor: {xtype:'textfield'}<%}%>}]
			},
			{header: "低危",
				columns:[
						{header: "未修复", width:60, sortable: true, dataIndex: 'lowriskNotRepair'<%if(isEditor==null||!isEditor.equals("false")){%>,editor: {xtype:'textfield'}<%}%>},
						{header: "已修复", width:60, sortable: true, dataIndex: 'lowriskRepaired'<%if(isEditor==null||!isEditor.equals("false")){%>,editor: {xtype:'textfield'}<%}%>}]
			},
			{header: "备注", width:100, sortable: true, dataIndex: 'testRemark'<%if(isEditor==null||!isEditor.equals("false")){%>,editor: {xtype:'textfield'}<%}%>}
			
    	]
	});
<%}%>
		var tabs = new Ext.Panel({
			id: 'orderTab',
			width: screenWidth*.99,
			height: screenHeight*.99,
			frame: true,
			renderTo: Ext.getBody(),
			items: [<%if(objType!=null&&!objType.equals("21")){%>AigaStGrid<%}else{%>Grid<%}%>]
		});
		
	});
	
</script>
</html>