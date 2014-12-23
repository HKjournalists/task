<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/aiga/common/common.jsp" %>
<%
    String flagRight = request.getParameter("flag");//是否可以审批的权限标识
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
	boolean isFlag = true;
	String flag = "1";
%>
<html>
    
<head>
	<title>测试要素查询查询</title>
	<style type="text/css">
		#uploadForm-body table {
		    float: left;
		}
		#uploadForm-body div {
		    float: left;
		}
		.red {
		    color:red;
		}
	</style>
</head>

<body>
	<script type="text/javascript" src="<%=request.getContextPath()%>/aiga/workflow/testTask/ajaxFileUpload/ajaxfileupload.js"></script>
	<img id="loading" src="<%=request.getContextPath()%>/aiga/workflow/testTask/ajaxFileUpload/loading.gif" style="display:none;">
	<form name="form" action="" method="POST" enctype="multipart/form-data">
	<div id='uploadTestTaskDiv'></div>
	</form>
	<form style="display:none;" id="exportForm" action="<%=request.getContextPath()%>/downloadTemplateExcel.do?templateFileName=testElemTemplate.xls"
		enctype="multipart/form-data" method="post" target="temp">
		<input type="hidden" name="method" value="export" />
		<input type="submit" id="download" class="tmpBtn" value="下载" />
	</form>
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
function ajaxFileUpload(){
	MaskLoading();
	url='<%=request.getContextPath()%>/uploadTestElemExcel.do';
	$.ajaxFileUpload(
			{
				url:url,
				secureuri:false,
				fileElementId:'fileToUpload',
				dataType: 'json',
			success: function (data, status)
			{
					MaskOver();
					var testElemStore=Ext.data.StoreManager.lookup('testElemStore');
					testElemStore.add(data.data);
					if(typeof(data.msg)=="undefined"){
						Ext.Msg.alert("提示","导入成功！");
					}else{
						Ext.Msg.alert("错误提示",data.msg);
					}
			},
			error: function (data, status, e)
			{	
				MaskOver();
			    Ext.Msg.alert("错误提示",data.msg);
			}
		}
	)
	
	return false;

}
var parentIds=new Array();
var funIds=new Array();
var subSysIds=new Array();
var sysIds=new Array();
var types=new Array();
var ids=new Array();
var afterSelect = function (funPointId,funPointName,sysId,sysName) {
	Ext.getCmp("funName").setValue(funPointName);
	Ext.getCmp("funId").setValue(funPointId);
	Ext.getCmp("sysName").setValue(sysName);
	Ext.getCmp("sysId").setValue(sysId);
}
Ext.regModel('extCommboModel', {
    fields: [
        {type: 'string', name: 'value'},
        {type: 'string', name: 'text'}
    ]
});
function delElem(rowIndex) {   //rowIndex，colIndex均从0开始  
	var grid=Ext.getCmp('testElemGrid');
    var elemId = grid.getStore().getAt(rowIndex).data.elemId;
    var funId = grid.getStore().getAt(rowIndex).data.funId;
    Ext.Msg.confirm('提示','是否删除要素？',function(optional){
		if(optional=='yes'){
			MaskLoading();
		    Ext.Ajax.request({   
				url:"<%=request.getContextPath()%>/deleteTestElemRela.do?funId="+funId+"&elemIds="+elemId,  
				params:{elemId:elemId},
				success:function(response,config){ 
					MaskOver();
					monthDelSlaStore = Ext.data.StoreManager.lookup("testElemStore");
					monthDelSlaStore.reload();
				}, 
		        failure:function(){  
					MaskOver();
		        	Ext.Msg.alert('提示','删除数据出错');
		        }   
			});
		}else return;
	});
}
function query(){
	clickFlag='query';
	parentIds=new Array();
	funIds=new Array();
	subSysIds=new Array();
	sysIds=new Array();
	types=new Array();
	ids=new Array();
	var tp = Ext.getCmp('funPointTree');  
	var root = tp.getStore().getProxy();  
		root.extraParams.clickFlag = 'query';
	var searchComBox=Ext.getCmp("searchComBox");
	var caseTreeStore= Ext.data.StoreManager.lookup('funPointTreeStore');
	//监听事件
	var searchStore= Ext.data.StoreManager.lookup('searchStore');
	ids=searchComBox.getValue();
	var storeMap=searchStore.data.map;
	for(var index in  ids){
		try{
			var id=ids[index];
			if(storeMap[id]!='undefined'){
				console.log(storeMap[id]);
				parentIds.push(storeMap[id].raw.parentId);
				funIds.push(storeMap[id].raw.funId);
				subSysIds.push(storeMap[id].raw.subSysId);
				sysIds.push(storeMap[id].raw.sysId);
				types.push(storeMap[id].raw.type);
			}
		}catch(e){console.log(e);}
	}
	if(ids==null||ids.length==0){
		clickFlag='click';
		caseTreeStore.load({params:{flag:'sysFolder',clickFlag:clickFlag,caseField: caseField,ids:ids,parentIds:parentIds,funIds:funIds,subSysIds:subSysIds,sysIds:sysIds,types:types}});
	}else{
		caseTreeStore.load({params:{flag:'sysFolder',clickFlag:clickFlag,caseField: caseField,ids:ids,parentIds:parentIds,funIds:funIds,subSysIds:subSysIds,sysIds:sysIds,types:types}});
		
	}
}
Ext.onReady(function () {
	Ext.QuickTips.init();
    Ext.tip.QuickTipManager.init();
    elemReason('create');
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
        	async:false,
            type: 'ajax',
            url: '<%=request.getContextPath()%>/getMultipleSysConstant.do?categorys=ADD_REASON_TYPE,ELEM_TYPE,IS_GLOBAL,ANALYSIS_METHOD',
            reader: {
                type: 'json',
                root: 'data'
            }
        },
        listeners:{
            load:function(store,records){
            	var blankRecord={show:'--请选择--'};
            	store.insert(0,blankRecord);
            }
        }
    });
    mapStore.load();
     
    var elemTypeCombox = new Ext.form.ComboBox({
    	id:'elemTypeCombox',
        width: 190,
        store: mapStore,
        labelAlign: 'right',
        name: "elemType",
        fieldLabel: "要素类型",
        valueField: 'value',
        displayField: 'show',
        listeners: {
            beforequery: function (queryEvent, eOpts) {
    			var store = Ext.data.StoreManager.lookup("mapStore");
                store.clearFilter(true);
                store.filter("categoryName", "elemType");
                queryEvent.query = "mapStore";
            }
        }
    });
    
    var btn = new Ext.Button({
	    text: '查询',
	    width: 60,
	    margin: '0 0 0 50px',
	    handler: function() {
			Ext.StoreMgr.get('testElemStore').loadPage(1);
		}
	});
    var qryForm = new Ext.form.FormPanel({
        id: 'qryForm',
        title: '查询区域',
        cls: 'ui-formPanel',
        defaults: {
            margins: '5 0 5 0',
        },
        renderTo: Ext.getBody(),
        width: screenWidth * 0.98,
        height: screenHeight * 0.15 * 0.99,
        layout: 'vbox',
        bodyBorder: 0,
        items: [{
            xtype: 'fieldcontainer',
            labelStyle: 'font-weight:bold;padding:0',
            fieldDefaults: {
                labelAlign: 'right',
                labelWidth: 80,
                width: 200
            },
            layout: 'hbox',
            defaultType: 'textfield',
            items: [
                    {name: 'elemTag',fieldLabel: '要素编号'},
                    {name: 'elemName',fieldLabel: '要素名称'},
                    elemTypeCombox,{
					    xtype: "textfield",
					    name: "funId",
					    id: "funId",
        				hidden :true
					},{
					    xtype: "textfield",
					    name: "sysId",
					    id: "sysId",
        				hidden :true
					},{
					    xtype: "textfield",
					    name: "sysName",
					    id: "sysName",
        				hidden :true
					},{
					    width: 200,
					    labelWidth: 70,
					    xtype: "textfield",
					    name: "funName",
					    id: "funName",
					    fieldLabel: "所属功能点",
					    emptyText: '选择所属功能点',
					    enableKeyEvents:true,
					    listeners:{
							keyup:function( text,e,eOpts ){
								Ext.getCmp("funName").setValue("");
								Ext.getCmp("funId").setValue("");
								Ext.getCmp("sysName").setValue("");
								Ext.getCmp("sysId").setValue("");
							}
					    }
					},{
					    xtype: 'button',
					    text: '选择',
					    handler: function () {
							/*******搜索框*****/
							var searchField = Ext.create('Ext.data.Store', {
							    fields: ['abbr', 'name'],
							    data : [
							        {"abbr":"funFolderName", "name":"功能点名"}
							        ,{"abbr":"subSysFolderName", "name":"子系统名"}
									,{"abbr":"systemFolderName", "name":"系统名"}
							    ]
							});
							var caseFieldCombox = new Ext.form.ComboBox({
								width: 80,
							  	store: searchField,
						    	queryMode: 'local',
						    	id:'caseFieldCombox',
						    	displayField: 'name',
						    	valueField: 'abbr',
						    	value:"funFolderName",
								listeners:{
									select:function( combo, records, eOpts ){
										 var combox=Ext.getCmp("searchComBox");
										 combox.displayField="funFolderName";
									 }
						        }
							});
							Ext.regModel('searchModel', {
							    fields: [
							        {type: 'string',name:'name'},
							        {type: 'string',name:'id'},
							        {type: 'string',name:'type'},
							        {type: 'string',name:'parentId'},
							        {type: 'string',name:'funId'},
							        {type: 'string',name:'subSysId'},
							        {type: 'string',name:'sysId'},
							        {type: 'string',name:'remark'}
							    ]
							});
						    searchStore = Ext.create('Ext.data.Store', {
								storeId:'searchStore',
								model:"searchModel",
							    proxy: {
							        type: 'ajax',
						        	url : '<%=request.getContextPath()%>/searchCaseAndFolder.do',
							        reader: {
										type:"json",
										root:"data"
							        }
							    }
							});
							var searchForm = Ext.widget({
						        xtype: 'form',
						        layout: 'column',
						        // frame: true,
						        collapsible: false,
						        id: 'searchForm',
						        title: '搜索',
						        cls: 'ui-formPanel',
						        bodyPadding: '5 5 0',
						        minWidth: 260,
						        minHeight: 100,
						       	width: screenWidth*0.3,   
								height: screenHeight*0.1, 
								layout: "hbox", 
						        fieldDefaults: {
						            msgTarget: 'side',
						            labelWidth: 50
						        },
						        items: [caseFieldCombox,{
						        	/**输入comBox配置*****/
						            xtype: 'combo',
						            id:"searchComBox",
						            minChars:10,
						            store: searchStore,
						            queryCaching :true,
						            queryParam : 'kw',
						            displayField: 'name',
						            valueField:'id',
						            typeAhead: true,
						            typeAheadDelay : 90800,
						            hideLabel: true,
						            multiSelect : true,
						            hideTrigger:true,
						            anchor: '100%',
						            listeners:{
						            	change:function( _this, newValue, oldValue, eOpts ){
						            		if(newValue instanceof Array){
						                		var searchBtn=Ext.getCmp('searchBtn');
						                		//searchBtn.setVisible(newValue.length>0);
						            		}
										},
										focus:function( _this, The, eOpts ){
											_this.focus(true);
										},
							           	specialkey:function( _this, e, eOpts ){
							           		var searchComBox=Ext.getCmp("searchComBox");
							           		 if (e.getKey() == e.ENTER) {
							                    	var queryData={caseField:"",caseValue:""};
							                   	caseField=caseFieldCombox.getValue();
							                   	var searchComBox=Ext.getCmp("searchComBox");
							                   	if(caseField!=""&&searchComBox.getValue()!=null&&searchComBox.getValue()!="null"&&searchComBox.getValue()!=""){
							                   	queryData.caseField=caseField;
							                   	queryData.caseValue=searchComBox.getValue();
							                   	var query="{"+caseField+":\""+encodeURI(encodeURI(searchComBox.getValue()))+"\"}";
							           			 searchComBox.doQuery(query, true ); 
							                   	//searchStore.load({params:{kw:query}});
							                   	}else {
							                   		window.query();
							                   		return;
							                   	}
							                    }
							           	},
						            	beforequery: function( queryEvent,  eOpts ){
						            		//console.log(queryEvent);
						            		return;
						                	var queryData={caseField:"",caseValue:""};
						                	var caseField=caseFieldCombox.getValue();
						                	var searchComBox=Ext.getCmp("searchComBox");
						                	if(caseField!=""&&searchComBox.getValue()!=null&&searchComBox.getValue()!="null"){
							                	queryData.caseField=caseField;
							                	queryData.caseValue=searchComBox.getValue();
							                	queryEvent.query="{"+caseField+":\""+encodeURI(encodeURI(searchComBox.getValue()))+"\"}";
						                	}else return;
					                	},
						            	beforeselect:function( combo, record,index, eOpts ){
						            	}
							        },
						            listConfig: {
						                loadingText: 'Searching...',
						                emptyText: '没有搜索到结果',
						                itemTpl : Ext.create('Ext.XTemplate','<input type=checkbox>{[values.name]}</input>'),  
						                // Custom rendering template for each item
						                getInnerTpl: function() {
						                    return '{[values.name]}';
						                },
						           	   listeners:{
								        	itemclick:function(view, record, item, index, e, eOpts ){
								        		 var isSelected = view.isSelected(item);  
								                 var checkboxs = item.getElementsByTagName('input');  
								                  if(checkboxs!=null)  { 
								                	  var checkbox = checkboxs[0];  
								                      if(!isSelected)checkbox.checked = true;
								                      else checkbox.checked = false;  
								                      }  
								                  }
										},
						              onItemSelect: function(record) {      
						                  var node = this.getNode(record);  
						                  if (node) {  
						                     Ext.fly(node).addCls(this.selectedItemCls);  
						                     var checkboxs = node.getElementsByTagName('input');  
						                     if(checkboxs!=null){var checkbox = checkboxs[0]; checkbox.checked = true;}  
						                  }  
						              }
						           }
						            //pageSize: 10
						        },{xtype:'button',text: '',tooltip:'生成结果树',id:'searchBtn',iconCls: 'search-button',handler: function() {query();}}
						        ]
						    });
							/*****search end *******/
							var funPointTreeStore = Ext.create('Ext.data.TreeStore', {  
								id:'funPointTreeStore',
								proxy: {
									type: "ajax",
									url: "<%=request.getContextPath()%>/getCaseTreeSyn.do",
									extraParams:{  
										flag:'sysFolder' 
									}
								},
								root: {
									id:'-1',
									text: '功能点',
									expanded: true
								},
								reader: { 
									type: 'json', 
									root: 'children' 
								} 
							});
							var funPointEnter = function(funPointId,funPointName,sysId,sysName){
								 if(afterSelect!=null&&typeof afterSelect=='function'){
									afterSelect(funPointId,funPointName,sysId,sysName);
								 }
								 Ext.getCmp('selectFunPointWin').close();
							};
							var funPointTree = Ext.create("Ext.tree.Panel", {  
								id :'funPointTree',
							    width: screenWidth*0.3,
							    height: screenHeight*0.6,
							    cls: 'ui-formPanel',
							    title : "功能点选择",   
							    rootVisible : true,
							    useArrows: true,
							    autoScroll:true,
							    frame: false,
							    flex: 3,
							    store: funPointTreeStore,
							    viewConfig : {  
							        loadingText : "加载数据..." 
							    },
								listeners : {
									itemdblclick : function(thisView, record, htmlElementItem, indexNo){
										if(record.raw.leaf){
											if(record.raw.type=='funFolder'){
												var funPointId = record.raw.id;
												var funPointName = record.raw.text;
												var sysId = record.raw.parentId;
												var sysName = record.parentNode.raw.text;
												funPointEnter(funPointId,funPointName,sysId,sysName);
											}
										}
									},
									beforeitemexpand:function(record,eOpts){  
										/*
										var tp = Ext.getCmp('funPointTree');  
										var root = tp.getStore().getProxy();  
										if(record.raw.type=='sysFolder'){
											root.extraParams.flag = 'funFolder';
											root.extraParams.isLeaf = 'yes';
										}
										*/
										if(!record.raw.expanded){
											//手动张开的
											clickFlag='click';
										}else{
											clickFlag='query';
										}
										var tp = Ext.getCmp('funPointTree');  
										var root = tp.getStore().getProxy();  
										//root.extraParams.parentIds = parentIds;
										root.extraParams.funIds = funIds;
										root.extraParams.subSysIds = subSysIds;
										root.extraParams.sysIds = sysIds;
										root.extraParams.types = types;
										root.extraParams.clickFlag = clickFlag;
										console.log(subSysIds);
										if(record.raw.type=='sysFolder'){
											root.extraParams.flag = 'subSysFolder';
											/**if(caseField=='funFolderName'&&clickFlag=='query'){
											root.extraParams.funIds = parentIds;
											}**/
										}
										if(record.raw.type=='subSysFolder'){
											root.extraParams.flag = 'funFolder';  
											
											//root.extraParams.clickFlag = clickFlag;
											
											/**if(caseField=='funFolderName'&&clickFlag=='query'){
												//console.log(ids);
												root.extraParams.funIds = ids;
											}else if(clickFlag=='query'){
												root.extraParams.funIds = "";
											}	
											**/
										}
									} 
								}
							});
					       var selectFunPointWin = Ext.create('Ext.window.Window',{
								id:'selectFunPointWin',
								title : '选择功能点',
						    	width: screenWidth*0.3+10,
						   		height: screenHeight*0.6+10,
								modal : true,
								closeAction : 'destroy',
								resizable:false,
								items:[searchForm,funPointTree]
							});
							selectFunPointWin.show();
					    }
					},{
                        xtype: "checkbox",
                        width:80,
                        checked:true,
                        boxLabel: '查私有要素',
                        name: 'tbarIsPrivate',
                        inputValue: '1',
                        id: "tbarIsPrivate"
                    },{
                        xtype: "checkbox",
                        width:80,
                        checked:true,
                        boxLabel: '查公共要素',
                        name: 'tbarIsCommon',
                        inputValue: '2',
                        id: "tbarIsCommon"
                    },{
			            xtype: 'fieldcontainer',
			            labelStyle: 'font-weight:bold;padding:0',
			            fieldDefaults: {
			                labelAlign: 'right',
			                labelWidth: 90,
			                width: 200
			            },
			            layout: 'hbox',
			            defaultType: 'textfield',
			            items: [
							btn
			            ]
        			}
                ]
            }
        ]
	});
    
	var testElemStore = Ext.create('Ext.data.Store', {
		storeId:'testElemStore',
		pageSize: 20,//每页显示条数
		fields:[
	        {name: 'elemId',type: 'string'},//ID 
			{name: 'elemTag',type: 'string'}, //编号
			{name: 'elemName',type: 'string'},//名称
			{name: 'elemSysAchieveType',type: 'string'},//类型
			{name: 'applicateSys',type: 'string'},//(已废弃字段)
			{name: 'isGlobalElem',type: 'string'},//公共测试要素
			{name: 'sysId',type:'string'},//所属系统
			{name: 'funId',type: 'string'},//功能点ID
			{name: 'staffId',type: 'string'},//评审人ID
			{name: 'staffName',type: 'string'},//评审人名字
			{name: 'isDelete',type:'string'},//是否已在公共测试要素中删除
			{name: 'addReasonType',type: 'string'},//新增原因类型
			{name: 'addReason',type:'string'},//新增原因
			{name: 'funName',type: 'string'},//所属功能点名称
			{name: 'sysName',type:'string'},//所属系统名称
			{name: 'operatorName',type:'string'},//最后操作人
			{name: 'operateTime',type:'string'},//最后操作时间
			{name: 'creatorName',type:'string'},//创建人
			{name: 'creatorTime',type:'string'}//创建时间
 		],
	    proxy: {
	        type: 'ajax',
        	url : '<%=request.getContextPath()%>/getTestElemList.do',
	        reader: {
	            root:"data",
				type:"json",
            	totalProperty:'total'
	        }
	    }
	});
	testElemStore.on('beforeload',function(){        // =======翻页时 查询条件     
		Ext.apply(       
			testElemStore.proxy.extraParams, {
					elemTag: encodeURI(encodeURI(Ext.getCmp('qryForm').getForm().findField('elemTag').getValue())),
					elemName: encodeURI(encodeURI(Ext.getCmp('qryForm').getForm().findField('elemName').getValue())),
					funId: Ext.getCmp('qryForm').getForm().findField('funId').getValue(),
					sysId: Ext.getCmp('qryForm').getForm().findField('sysId').getValue(),
					elemSysAchieveType: Ext.getCmp('elemTypeCombox').getValue(),
					tbarIsPrivate:Ext.getCmp('tbarIsPrivate').rawValue,
					tbarIsCommon:Ext.getCmp('tbarIsCommon').rawValue
					
				}      
			);      
	});
	testElemStore.loadPage(1);
	
	var testElemGrid = new Ext.grid.Panel({
        id: 'testElemGrid',
        cls: 'ui-formPanel',
        width: screenWidth * 0.98,
        height: screenHeight * 0.85,
        renderTo: Ext.getBody(),
        title: '测试要素信息列表',
        store: testElemStore,
        bbar: Ext.create('Ext.PagingToolbar', { 
			store: testElemStore, 
			displayInfo: true, 
			displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
			emptyMsg: "没有数据"
		})
		<%if(!(flagRight!=null&&flagRight.equals("true"))){%>//没有评审权限的时候显示出来
		,tbar:[
        	{xtype: 'button',text: '新增',handler: function () {
				elemReason('create');
        	}},{
                xtype: 'fileuploadfield',
                id:'fileToUpload',
                fieldLabel: '批量导入公共要素',
                buttonText: '选择公共要素文件',
                listeners:{
                    	change:function(comp,str,eOpts){
                    		if(str.endWith('xls')||str.endWith('xlsx')){
                    			Ext.getCmp("upload").setHandler(function(){ajaxFileUpload();});
                    		}else{
                    			Ext.MessageBox.alert('提示','['+str+']文件不是合法的Excel文件');
                    			Ext.getCmp("upload").setHandler(function () {
                                	Ext.MessageBox.alert('提示','未选择上传文件文件');
                                	});
                    		}
                    	}
                    }
                }, {
                    width: 50,
                    xtype: 'button',
                    text: '导入',
                    id:'upload',
                    handler: function () {
                    	Ext.MessageBox.alert('提示','未选择上传文件文件');
                    },
                    listeners:{
                    	afterrender:function( Component, eOpts ){
                    	}
                    }
                },
                {
                    width: 100,
                    xtype: 'button',
                    text: '下载模版',
                    handler: function () {
                    	$("#exportForm")[0].submit();
                    },
                    listeners:{
                    }
                }
        ]
        <%}%>
        ,listeners: {
            itemdblclick: function(grid, record, item, index, e, eOpts) {
            	testElemQueryWin = new top.Ext.window.Window({
			 		id:'testElemQueryWin',
				    title : '查看测试要素详细信息',
				    width : 1050,
				    height : 408,
				    modal : true,
				    autoScroll:true,
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/userCase/testElemManage.jsp?flag=query&elemId='+record.raw.elemId+'" width="1050" height="400"/>'
            	}).show();
            },
        	itemcontextmenu: rightClickTargetFn
        },
        columns: [
            {xtype: 'rownumberer'}, 
         	{header: "测试要素ID",width: 100,sortable: true,dataIndex: 'elemId',hidden: true}, 
         	{header: "要素编号",width: 180,sortable: true,dataIndex: 'elemTag'}, 
         	{header: "要素名称 ",width: 150,sortable: true,dataIndex: 'elemName'}, 
         	{header: "要素类型",width: 100,sortable: true,dataIndex: 'elemSysAchieveType',renderer: function (value, cellmeta, record) {
                try {
                    var store = Ext.data.StoreManager.lookup("mapStore");
                    store.clearFilter(true);
                    store.filter("categoryName", "elemType");
                    return store.findRecord("value", value).getData().show + "";
                } catch (e) {
                    return "数据错误";
                };
            }}, 
 			{header: "所属系统(已废弃字段)",sortable: false,dataIndex: 'applicateSys',hidden: true}, 
 			{header: "公共要素",width: 60,align:'center',sortable: true,dataIndex: 'isGlobalElem',renderer: function(value, cellmeta, record) {if(value==1||value=='on')return "是";else return "否"; }}, 
 			{header: "所属系统",width: 200,sortable: true,dataIndex: 'sysName'}, 
 			{header: "所属功能点",width: 200,sortable: true,dataIndex: 'funName'}, 
 			{header: "评审人ID",sortable: true,dataIndex: 'staffId',hidden: true}, 
 			{header: "评审人",width: 100,sortable: false,dataIndex: 'staffName'}, 
 			{header: "是否已在公共测试要素中删除",hidden: true,sortable: true,dataIndex: 'isDelete',renderer: function(value, cellmeta, record) {if(value==1||value=='on')return "是";else return "否"; }}, 
 			{header: "新增原因类型",width: 80,sortable: true,dataIndex: 'addReasonType',renderer: function (value, cellmeta, record) {
                try {
                    var store = Ext.data.StoreManager.lookup("mapStore");
                    store.clearFilter(true);
                    store.filter("categoryName", "addReasonType");
                    return store.findRecord("value", value).getData().show + "";
                } catch (e) {
                    return "数据错误";
                };
            },hidden: true},
            {header: "最后操作人",width: 100,sortable: false,dataIndex: 'operatorName'},
            {header: "最后操作日期",width: 100,sortable: false,dataIndex: 'operateTime',renderer: function (value, cellmeta, record) {
                return value.substring(0,10);
                }},
            {header: "创建人",width: 100,sortable: false,dataIndex: 'creatorName'},
            {header: "创建日期",width: 100,sortable: false,dataIndex: 'creatorTime',renderer: function (value, cellmeta, record) {
                return value.substring(0,10);
                }},
 			{header: "新增原因",width: 420,sortable: false,dataIndex: 'addReason',hidden: true}
            <%if(!(flagRight!=null&&flagRight.equals("true"))){%>//没有评审权限的时候显示出来
            ,{header: "操作", width:33,menuDisabled: true,align:'center',sortable:false, dataIndex: 'isGlobalElem',renderer: function (value, cellmeta, record) {
                try {
                	//if(value==1||value=='on')return "是";else return "否"; 
                	if(!(value==1||value=='on')){
                    	return  "<img height='13px' src='<%=request.getContextPath()%>/aiga/label/image/del.gif' onclick='delElem("+record.index+")'/>";
                	}else return '';
                } catch (e) {
                    return ""
                };
            }}
            <%}%>
      	]
    });
});
function rightClickTargetFn(view, record, item, index, e, eOpts) {
    e.preventDefault();
    rightTargetReportMenu.showAt(e.getXY());
}
var rightTargetReportMenu = new Ext.menu.Menu({
	items: [
		<%if(!(flagRight!=null&&flagRight.equals("true"))){%>//没有评审权限的时候显示出来
		{
	        id: 'editTask',
	        text: '编辑测试要素信息',
	        handler: function () {
				elemReason('alter');
	        }
    	}
		<%}else{%>//有修改权限显示的菜单
		{
	        id: 'approvalTestElem',
	        text: '成为公共要素',
	        handler: function () {
	            var models = Ext.getCmp('testElemGrid').getSelectionModel().getSelection();
	            if (models.length != 1) {
	            	Ext.Msg.alert("提示","选择错误!");
	            }
	            Ext.Ajax.request({
					url:"<%=request.getContextPath()%>/approvalTestElem.do?deleteFlag=0&elemId="+models[0].data.elemId+"&staffId=<%=user.getUserId()%>&staffName="+encodeURI(encodeURI('<%=user.getUserName()%>')),
					success:function(response,config){
						testElemStore = Ext.data.StoreManager.lookup("testElemStore");
						testElemStore.reload();
						Ext.Msg.alert("提示","审批成功");
					},
					failure:function(response,config){
						Ext.Msg.alert("提示","审批失败");
					}
				});
	        }
    	},{
	        id: 'unapprovalTestElem',
	        text: '去除公共要素',
	        handler: function () {
	            var models = Ext.getCmp('testElemGrid').getSelectionModel().getSelection();
	            if (models.length != 1) {
	            	Ext.Msg.alert("提示","选择错误!");
	            }
	            Ext.Ajax.request({
					url:"<%=request.getContextPath()%>/approvalTestElem.do?deleteFlag=1&elemId="+models[0].data.elemId+"&staffId=<%=user.getUserId()%>&staffName="+encodeURI(encodeURI('<%=user.getUserName()%>')),
					success:function(response,config){
						testElemStore = Ext.data.StoreManager.lookup("testElemStore");
						testElemStore.reload();
						Ext.Msg.alert("提示","审批成功");
					},
					failure:function(response,config){
						Ext.Msg.alert("提示","审批失败");
					}
				});
	        }
    	}
    	<%}%>
	]
});
function elemReason(flag){
	var subTaskTag = '';
	var normalMac = '';
	var TemporaryTag = '';
     		var caseEditForm = Ext.create('Ext.form.Panel',{
        id: 'caseEditForm',
        cls: 'ui-formPanel',
        width: 400,
        height:350,
        border:0,
        listeners:{
        	render:function(panel,eOpts){
        		caseEditForm.getForm().findField('TemporaryTag').disable(true);
        		caseEditForm.getForm().findField('normalMac').disable(true);
        		caseEditForm.getForm().findField('subTaskTag').enable(true);
        	}
        },
        layout: { 
               type: 'vbox'
           }, 
           fieldDefaults: { 
               labelAlign: 'right', 
               labelWidth: 100, 
               labelStyle: 'font-weight:bold' 
           },
        	defaults: { 
               margins: '15 0 0 0' 
           }, 
			items: [
			{
	        	xtype: 'fieldcontainer', 
                labelStyle: 'font-weight:bold;padding:0', 
                layout: 'hbox', 
                defaultType: 'textfield', 

                fieldDefaults: { 
                    labelAlign: 'right' 
                }, 
	            items: [{
				    	name: 'caseEditType', 
				        xtype: 'combo', 
				        fieldLabel: '原因类型',
				        allowBlank: false,
				        forceSelection: true,
				        emptyText:'请选择原因类型',
				        value : 'subTask',
				        listeners:{
				        	change:function(combo, newValue, oldValue, eOpts ){
				        		if(newValue=='subTask'){
				        			caseEditForm.getForm().findField('TemporaryTag').setValue('');
				        			caseEditForm.getForm().findField('TemporaryTag').disable(true);
				        			caseEditForm.getForm().findField('normalMac').setValue('');
					        		caseEditForm.getForm().findField('normalMac').disable(true);
					        		caseEditForm.getForm().findField('subTaskTag').enable(true);
				        		}
				        		else if(newValue=='temporary'){
				        			caseEditForm.getForm().findField('TemporaryTag').enable(true);
				        			caseEditForm.getForm().findField('normalMac').setValue('');
					        		caseEditForm.getForm().findField('normalMac').disable(true);
					        		caseEditForm.getForm().findField('subTaskTag').setValue('');
					        		caseEditForm.getForm().findField('subTaskTag').disable(true);
				        		}
				        		else if(newValue=='normal'){
				        			caseEditForm.getForm().findField('TemporaryTag').setValue('');
				        			caseEditForm.getForm().findField('TemporaryTag').disable(true);
					        		caseEditForm.getForm().findField('normalMac').enable(true);
					        		caseEditForm.getForm().findField('subTaskTag').setValue('');
					        		caseEditForm.getForm().findField('subTaskTag').disable(true);
				        		}/////////wenghy
				        	}
				        },
				        store:Ext.create('Ext.data.Store', {
							fields : ['text','value'],
							data:[{text:'关联子任务',value:'subTask'},{text:'临时任务',value:'temporary'},{text:'常态维护',value:'normal'}]
						}),
			           displayField:'text',
			           valueField:'value',
			           mode:'local'
            		}
	            ]
			},
			{
	        	xtype: 'fieldcontainer', 
                labelStyle: 'font-weight:bold;padding:0', 
                layout: 'hbox', 
                defaultType: 'textfield', 

                fieldDefaults: { 
                    labelAlign: 'right' 
                }, 
	            items: [{
			    	name: 'subTaskTag', 
			        fieldLabel: '测试子任务编号',
			        xtype: 'combo', 
			        forceSelection: true,
			        emptyText:'请选择子任务编号',
			        store:Ext.create('Ext.data.Store', {
			        	autoLoad:true,
						model:"extCommboModel",
						proxy:Ext.create('Ext.data.proxy.Ajax',{
							type:"ajax",
							model:"extCommboModel",
							url:'<%=request.getContextPath()%>/getTestSubTaskParamsForCaseLib.do',
							reader:{
								root:"data",
								type:"json"
							}
						})
					}),
		           displayField:'text',
		           valueField:'value',
		           mode:'remote'
	            }]
	        },
	        {
	        	xtype: 'fieldcontainer', 
                labelStyle: 'font-weight:bold;padding:0', 
                layout: 'hbox', 
                defaultType: 'textfield', 

                fieldDefaults: { 
                    labelAlign: 'right' 
                }, 
	            items: [{
	            	xtype:'textfield',
	            	vtype: 'alphanum',
	                name: 'TemporaryTag', 
			        fieldLabel: '临时编号'
	            }]
	        },
	        {
	        	xtype: 'fieldcontainer', 
                labelStyle: 'font-weight:bold;padding:0', 
                layout: 'hbox', 
                defaultType: 'textfield', 

                fieldDefaults: { 
                    labelAlign: 'right' 
                }, 
	            items: [{
           			xtype:'textareafield',
	                name: 'normalMac', 
			        fieldLabel: '常态维护',
			        width:333,
 							height:100
	            }]
	        }
		]
	});
    var closeFlag = 0;//取消的标志(关闭页面)
    
	var caseEditReasonWin = new Ext.window.Window({
		tbar:[{
			xtype:'button',
			text:'常态维护',
			handler:function(){
				subTaskTag = '';
				normalMac = '无';
				TemporaryTag = '';
				caseEditReasonWin.close();
			}
		},'->',{
			xtype:'button',
			text:'取消',
			handler:function(){
				closeFlag = 1;
				caseEditReasonWin.close();
			}
		},{
		  	xtype: 'button',
			text: '确定',
			handler:function(){
				var caseEditType = caseEditForm.getForm().findField('caseEditType').getValue();
				if(caseEditType=='subTask'){
					subTaskTag = caseEditForm.getForm().findField('subTaskTag').getValue();
					if(subTaskTag==null||subTaskTag==''||subTaskTag.length==0){
						Ext.Msg.alert("提示","请选择测试子任务编号");
						return;
					}
				}else if(caseEditType=='temporary'){
					var temporaryTagField = caseEditForm.getForm().findField('TemporaryTag');
					if(!temporaryTagField.isValid()){
						Ext.Msg.alert("提示","临时测试子任务编号只可以<font color=\"red\">包括数字及字母</font>，请正确填写临时测试子任务编号");
						return;
					}
					TemporaryTag = temporaryTagField.getValue();
					if(TemporaryTag==null||TemporaryTag==''||TemporaryTag.length==0){
						Ext.Msg.alert("提示","请填写临时测试子任务编号");
						return;
					}
				}else if(caseEditType=='normal'){
					normalMac = caseEditForm.getForm().findField('normalMac').getValue();
					if(normalMac==null||normalMac==''||normalMac.length==0){
						Ext.Msg.alert("提示","请填写常态维护原因");
						return;
					}
				}
				caseEditReasonWin.close();
			}
		}],
		renderTo:Ext.get('winPanel'),
		id:'caseEditReasonWin',
		title:'原因信息',
	    width : 400,
	    height : 350,
	    modal : true,
	    closable:false,
	    resizable:false,
	    closeAction : 'destroy',
	    listeners: {
	        destroy:function( component,eOpts ){
				if(closeFlag==0){
					if(flag=='create'){
						testElemCreateWin = new top.Ext.window.Window({
					 		id:'testElemCreateWin',
						    title : '测试要素信息',
						    width : 1050,
						    height : 408,
						    modal : true,
						    autoScroll:true,
						    listeners:{
								destroy:function(window,eOpts){
									testElemStore = Ext.data.StoreManager.lookup("testElemStore");
									testElemStore.reload();
								}
						    },
						    closeAction : 'destroy',
						    html:"<iframe style='overflow:hidden;' id='frame' name='frame' src='<%=request.getContextPath()%>/aiga/userCase/testElemManage.jsp?flag=create&subTaskTag="+subTaskTag+"&normalMac="+normalMac+"&TemporaryTag="+TemporaryTag+"' width='1050' height='400'/>"
		            	}).show();
					}else{
						var models = Ext.getCmp('testElemGrid').getSelectionModel().getSelection();
			            if (models.length != 1) {
			            	Ext.Msg.alert("提示","一次只能修改一个测试要素!");
			            }
			            var testElemAlterWin = new top.Ext.window.Window({
			                id: 'testElemAlterWin',
			                title: '编辑测试要素信息',
			                width: 1050,
						    height : 408,
			                modal: true,
			                listeners: {
			                    destroy: function (window, eOpts) {
									testElemStore = Ext.data.StoreManager.lookup("testElemStore");
									testElemStore.reload();
			                    }
			                },
			                closeAction: 'destroy',
						    html:"<iframe style='overflow:hidden;' id='frame' name='frame' src='<%=request.getContextPath()%>/aiga/userCase/testElemManage.jsp?flag=alter&elemId="+models[0].data.elemId+"&subTaskTag="+subTaskTag+"&normalMac="+normalMac+"&TemporaryTag="+TemporaryTag+"' width='1050' height='400'/>"
			            }).show();
					}
				}
	        }
	    },
	    items:[caseEditForm]
	}).show();
}
</script>
</html>