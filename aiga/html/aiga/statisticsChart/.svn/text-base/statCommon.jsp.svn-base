<!DOCTYPE html>
<%@page import="nl.justobjects.pushlet.util.Sys"%>
<%@page import="com.asiainfo.aiga.common.helper.CommonHelper"%>
<%@page import="com.asiainfo.aiga.statistics.bo.StatGrid"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<%@page import="com.asiainfo.aiga.statistics.bo.StatGridColumns"%>
<%@page import="java.util.List"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");%>
<%
StatGrid statGrid=(StatGrid)request.getAttribute("statGrid");
String  initCondition=(String)request.getAttribute("initCondition");
Map<String,String> initValueMap=(Map<String,String>)request.getAttribute("initValueMap");
List<StatGridColumns> statGridObjList=(List<StatGridColumns>)request.getAttribute("statGridObjList");
Map<String,String> map=(Map<String,String>)request.getAttribute("statGridFieldMap");
if(statGrid.getGridProxyUrl()==null || statGrid.getGridProxyUrl().equals(""))statGrid.setGridProxyUrl("getstatisticsoBjectList.do");
StringBuffer htmlBuffer=new StringBuffer();
StringBuffer tabrHtmlBuffer=new StringBuffer();
for(StatGridColumns column:statGridObjList){
	htmlBuffer.append(column);
	htmlBuffer.append(",");
	tabrHtmlBuffer.append(column.getTbarHtmlString());
	
}
StringBuffer gridProperties=new StringBuffer();
String strEditPlugins="";
gridProperties.append(",width:"+statGrid.getWidth());
gridProperties.append(",height:"+statGrid.getHeight());
gridProperties.append(",title:'"+(statGrid.getTitle()==null?"":statGrid.getTitle())+"'");
gridProperties.append(",forctFit:"+statGrid.getForctFit());
gridProperties.append(",stripeRows:"+statGrid.getStripeRows());
gridProperties.append(",loadMask:"+statGrid.getLoadMask());
if(statGrid.getEditPlugins()!=null&&statGrid.getEditPlugins().equals("true"))gridProperties.append(",plugins: [cellEditing]");
%>


<html>
<head>
	<%@ include file="/aiga/common/include.jsp" %>
	<script type="text/javascript" src="<%=request.getContextPath()%>/chart/FusionCharts.js"></script>
	<title><%=statGrid.getTitle() %></title>
</head>
<body>
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
var cellEditing = Ext.create('Ext.grid.plugin.CellEditing', {
    clicksToEdit: 1
});
var pageToolBar=Ext.create('Ext.PagingToolbar', {
	store: Ext.StoreMgr.get('gridStore'), 
	displayInfo: true, 
	displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
	emptyMsg: "没有数据"
	});
function query() {
	var gridTbar=Ext.getCmp('gridTbar');
	var queryData={objName:'<%=statGrid.getClassPath()%>'};
	//length -1 是为了去除最后一个按钮不被遍历
	var i=0;
	<%if(statGrid.getEditPlugins()!=null&&statGrid.getEditPlugins().equals("true")){%>i=2;<%}%>
	for(;i<gridTbar.items.keys.length-1;i++){ 
		var tbarField=Ext.getCmp(gridTbar.items.keys[i]);
		try{
			queryData[tbarField.getName()]=encodeURI(encodeURI(tbarField.getValue()+""));
		}catch(e){
			continue;
			alert(e.message);
		}
		}
	Ext.StoreMgr.get('gridStore').on('beforeload',function(){
		Ext.apply(       
			Ext.StoreMgr.get('gridStore').proxy.extraParams,queryData  
		);      
	});
	Ext.StoreMgr.get('gridStore').loadPage(1);
	try{
		window.parent.loadFusion(queryData);
	}catch(e){
	}
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
	Ext.Ajax.request({
		url:'<%=request.getContextPath()%>/submitStatisticsGridStore.do',
		params:{
			table:Ext.encode(data),
			stroeName:'<%=statGrid.getClassPath()%>'
			},
		success:function(response,config){
			//Ext.Msg.alert('提示','保存成功！',function(){
				store.loadPage(1);
    		//});
		},
		failure:function(response,config){
			Ext.Msg.alert('提示','请求数据失败');
		}
	});
}
function setSubColumnsEditor(column,status){
	try{
		var columns=column.items.items;
		console.log(columns);
		for(var i=0,n=columns.length;i<n;i++){
			var _column=columns[i];
			if(_column.headerCounter>0){
				setSubColumnsEditor(_column,status);
			}
			columns[i].setEditor(status);
		}
	}catch(e){console.log(e);}
}
function setGridAllColumnsEditor(Grid,status){
	try{
		var columns=Grid.columns;
		for(var i=0,n=columns.length;i<n;i++){
			var column=columns[i];
			if(column.headerCounter>0){
				setSubColumnsEditor(column,status);
			}
			try{
				column.setEditor(status);
			}catch(e1){
				
			}
			
		}
	}catch(e){console.log(e);}
}
function addGridStore(){
	var record = Ext.create('storeModel');
	for(var field in record.data){
		//初始化方法做判断
			<%
			Iterator<Map.Entry<String, String>> initIt = initValueMap.entrySet().iterator();
		while (initIt.hasNext()) {
	  		 Map.Entry<String, String> entry = initIt.next();
	  		 entry.getKey();
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
					stroeName:'<%=statGrid.getClassPath()%>'
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
Ext.require([
             'Ext.grid.*',
             'Ext.toolbar.Paging',
             'Ext.util.*',
             'Ext.data.*',
             'Ext.selection.CellModel',
             'Ext.state.*',
             'Ext.form.*',
             'Ext.ux.CheckColumn'
         ]);
Ext.onReady(function(){
	var storeModel = Ext.regModel("storeModel",{
		fields:[
		        <%
                StringBuffer strFields=new StringBuffer();
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
	var gridProxy = new Ext.data.proxy.Ajax({
		type:"ajax",
		model: storeModel,
		url:'<%=request.getContextPath()+"/"+statGrid.getGridProxyUrl()+"?objName="+statGrid.getClassPath()+"&"+initCondition%>',
		reader:{
			 root:"data",
			 type:"json",
			 totalProperty:'total'
		}
	});
	var gridStore = Ext.create('Ext.data.Store',{
		model: storeModel,
		id:'gridStore',
		pageSize:20,
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
		selType:'rowmodel'
		<%System.out.println(gridProperties);%>
		<%=gridProperties.toString()%>
		,dockedItems: [{
		    xtype: 'toolbar',
		    dock: 'top',
		    id:'gridTbar',
		    items: [
					<%if(statGrid.getEditPlugins()!=null&&statGrid.getEditPlugins().equals("true")){%> 
					{xtype:'button',text: '',iconCls: 'save-button',handler: function() {submitGridStore();}},
					{xtype:'button',text: '',iconCls: 'add-button',handler: function() {addGridStore();}},
					{xtype:'button',text: '',iconCls: 'del-button',handler: function() {delGridStore();}},
					<%}%>
					<%if(tabrHtmlBuffer!=null&&tabrHtmlBuffer.toString().length()!=0){%>
		        	<%System.out.println("----"+tabrHtmlBuffer.toString().substring(0,tabrHtmlBuffer.toString().length()-1));%>
					<%=tabrHtmlBuffer.toString().substring(0,tabrHtmlBuffer.toString().length()-1)%>
    	      		,{xtype:'button',text: '',iconCls: 'search-button',handler: function() {query();}}
    	      		<%}%>
		    ]
		}]
		
		<%System.out.println(statGrid.getBbar());
		if(statGrid.getBbar()!=null&&statGrid.getBbar().length()!=0){%>
		,bbar:pageToolBar
		<%}%>
		,listeners:{
			afterrender:function(  _this, eOpts ){
				try{
					//setGridAllColumnsEditor(Ext.getCmp('Grid'),false);
					//window.parent.ifrmLoaded();
			}catch(e){}
			}
		},
		columns:[
				new Ext.grid.RowNumberer({header:"序号",width:30}),
				<%System.out.println(htmlBuffer);%>
				<%if(htmlBuffer!=null&&htmlBuffer.toString().length()!=0){%>
				<%=htmlBuffer.toString().substring(0,htmlBuffer.length()-1)%>
				<%}%>
	    	]
		});
	var mainPanel = Ext.create('Ext.panel.Panel', {
		width: screenWidth*.99,
	    height: screenHeight*.96,
	    renderTo: Ext.getBody(),
	    layout: {
	        type: 'vbox',      
	        align: 'stretch', 
	        padding: 0
	    },
	    items:[Grid]
	});
	});
	
</script>
</html>