<!DOCTYPE HTML>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");%>
<%@ include file="/aiga/common/common.jsp" %>
<%
request.getSession().setAttribute("subTaskTag", request.getParameter("subTaskTag"));
request.getSession().setAttribute("normalMac", request.getParameter("normalMac"));
request.getSession().setAttribute("TemporaryTag", request.getParameter("TemporaryTag"));
	String flag = request.getParameter("flag");//判断是添加还是修改 create alter query
	if(flag == null){
		flag = "";
	}
%>
 
<html>
<head>
	<title>测试要素管理</title> 
</head>
  
<body>
	<div id="testElemPanel"></div>
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
var parentIds=new Array();
var funIds=new Array();
var subSysIds=new Array();
var sysIds=new Array();
var types=new Array();
var ids=new Array();
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
var funPointIdParam = "";
var afterSelect = function (funPointId,funPointName,sysId,sysName) {
	Ext.getCmp("funName").setValue(funPointName);
	Ext.getCmp("funId").setValue(funPointId);
	Ext.getCmp("sysName").setValue(sysName);
	Ext.getCmp("sysId").setValue(sysId);
	funPointIdParam = funPointId;
}
var masker = function(msg){
	var mask = new Ext.LoadMask(top.window.document.body, {
		msg : msg,
		disabled : false
	});
	return mask;
};
var maskerWithHtmlEl = function(htmlEl,msg){
	var mask = new Ext.LoadMask(htmlEl, {
		msg : msg,
		disabled : false
	});
	return mask;
};
Ext.regModel('extCommboModel', {
    fields: [
        {type: 'int', name: 'value'},
        {type: 'string', name: 'text'}
    ]
});
Ext.regModel('addReasonCommboModel', {
    fields: [
        {type: 'int', name: 'value'},
        {type: 'string', name: 'text'}
    ]
});
Ext.onReady(function(){
	Ext.QuickTips.init();
    Ext.tip.QuickTipManager.init();
   	var testElemForm = Ext.widget('form', {
   		<%if(flag!=null&&(flag.equals("create")||flag.equals("alter"))){%>
   		tbar:Ext.create('Ext.Toolbar',{
			items:[{
				text:'保存并关联',
				handler:function(){
					var valueForm = testElemForm.getForm();
					var funNameParam = valueForm.findField('funName').getValue();
					//alert(funNameParam);
					funPointIdParam = valueForm.findField('funId').getValue()+"";
					if(valueForm.findField('isGlobalElem').getValue()+''=='0'){
						if(funNameParam==""){
							Ext.Msg.alert("提示","私有要素请选择所属功能点");
							return false;
						}
					}
					var sysIdParam = valueForm.findField('sysId').getValue();
					var isOfMultiSys = false;//是否多系统共有
					var elemNameParam = valueForm.findField('elemName').getValue();
					/*
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
					*/
					testElemForm.submit({
						clientValidation: true,
			  			url:"<%=request.getContextPath()%>/saveTestElemAndRela.do?funId="+funPointIdParam,
			  			method:'POST',  
	                   	success:function(response,config){
	                   		var json = Ext.JSON.decode(config.response.responseText);
	                   		Ext.Msg.alert("操作","保存并关联成功");
	                   		testElemForm.load({
	                   			url:'<%=request.getContextPath()%>/getTestElemForm.do?elemId='+json.elemId,
	                   			success:function(response,config){
	                   			},
	                   			failure:function(response,config){
			                   		Ext.Msg.alert("操作","获取要素信息失败");
			                   	}
	                   		});
	                   	},
	                   	failure:function(response,config){
	                   		Ext.Msg.alert("操作","保存并关联要素失败");
	                   	}
					});
				}	
			}]
		}),
   		<%}%>
        id: 'testElemForm',
        cls: 'ui-formPanel',
        width: 1050,
        height:100,
        border:0,
	    title: '测试要素',
        layout:{ 
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
		items: [{
        	xtype: 'fieldcontainer', 
            labelStyle: 'font-weight:bold;padding:0', 
            layout: 'hbox', 
            defaultType: 'textfield', 
			fieldDefaults: { 
            	labelAlign: 'right' 
            }, 
            items: [{
	        		name: 'elemId',
	        		id: 'elemId',
	                xtype: 'hidden'
            	},{
	                xtype: 'textfield',
	                name: 'elemTag',
	                fieldLabel: '要素编号',
	                width:250,
	                readOnly:true
	                <%if(flag!=null&&flag.equals("create")){%>
	                ,
	                value:'TESTELEM'+Ext.util.Format.date(new Date(),'YmdHisu')
	                <%}%>
            	},{
	                xtype: 'textfield',
	                name: 'elemName',
	                id: 'elemName',
	                width:250,
	                fieldLabel: '要素名称'
            	},{
			    	name: 'elemSysAchieveType', 
			        fieldLabel: '要素类型',
			        xtype: 'combo', 
	                width:200,
			        allowBlank: false,
			        forceSelection: true,
			        emptyText:'请选择要素类型',
			        store:Ext.create('Ext.data.Store', {
			        	autoLoad:true,
						model:"extCommboModel",
						proxy:Ext.create('Ext.data.proxy.Ajax',{
							type:"ajax",
							model:"extCommboModel",
							url:'<%=request.getContextPath()%>/getCaseParam.do?type=elem_type',
							reader:{
								root:"data",
								type:"json"
							}
						})
					}),
		            displayField:'text',
		            valueField:'value',
		            mode:'remote'
            	},{
				    xtype: "textfield",
				    name: "isDelete",
				    id: "isDelete",
				    value:'0',
       				hidden :true
				},{
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
				    xtype: "textfield",
				    name: "funName",
				    id: "funName",
				    fieldLabel: "所属功能点",
	                width:250,
				    emptyText: '选择所属功能点',
				    enableKeyEvents:true,
				    listeners:{
						keyup:function( text,e,eOpts ){
							Ext.getCmp("funName").setValue("");
							Ext.getCmp("funId").setValue("");
							Ext.getCmp("sysName").setValue("");
							Ext.getCmp("sysId").setValue("");
							funPointIdParam = "";
						}
				    }
				}
				<%if(!(flag!=null&&flag.equals("query"))){%>
				,{
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
						       	width: screenWidth*0.5,   
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
								width:screenWidth*0.5,
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
												var sysId = record.parentNode.raw.parentId;
												var sysName = record.parentNode.parentNode.raw.text;
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
						    	width: screenWidth*0.5,
						   		height: screenHeight,
								modal : true,
								closeAction : 'destroy',
								resizable:false,
								items:[searchForm,funPointTree]
							});
							selectFunPointWin.show();
				    }
				}
				<%}%>
            ]
		},{
        	xtype: 'fieldcontainer', 
            labelStyle: 'font-weight:bold;padding:0', 
            layout: 'hbox', 
            defaultType: 'textfield', 
			fieldDefaults: { 
            	labelAlign: 'right' 
            }, 
            items: [{
	        	xtype: 'hidden',
	            name: 'applicateSys',
	            fieldLabel: '适用系统'
            },{
	            xtype: 'hidden',
	            name: 'isGlobalElem',
	            fieldLabel: '是否全局要素'
	            <%if(flag!=null&&flag.equals("create")){%>
                ,
                value:'0'
                <%}%>
            }]
		}]
	});

   	<%if(flag!=null&&(flag.equals("query")||flag.equals("alter"))){%>
	Ext.getCmp("testElemForm").load({
		url:'<%=request.getContextPath()%>/getTestElemForm.do?elemId=<%=request.getParameter("elemId")%>',
		success:function(response,config){
		},
		failure:function(response,config){
	   	}
 	});
	<%if(flag!=null&&flag.equals("query")){%>
	var fieldAry = Ext.getCmp('testElemForm').getForm().getFields();
	for(var i = 0; i < fieldAry.length; i++) {
		fieldAry.get(i).setReadOnly(true);
	}
	<%}%>
   	<%}%>
	
	var subElemModel = Ext.regModel("subElemModel",{
		fields:[
			{name:'subElemId',type:'string'},
			{name:'elemId',type:'string'},
			{name:'elemValue',type:'string'},
			{name:'elemTestLogic',type:'string'},
			{name:'takeValueMethod',type:'string'},
			{name:'valueRemark',type:'string'}
		]
	});
	
	var subElemProxy = new Ext.data.proxy.Ajax({
		type:"ajax",
		model:subElemModel,
		url:'<%=request.getContextPath()%>/getSubElem.do',
		reader:{
			root:"data",
			type:"json"
		}
	});
	
	var subElemStore = Ext.create('Ext.data.Store',{
		model:subElemModel,
		proxy:subElemProxy
	});
	subElemStore.load({
		params:{elemId:<%=request.getParameter("elemId")%>}
	});
	
	var subElemGrid = Ext.create('Ext.grid.Panel',{
		<%if(!(flag!=null&&flag.equals("query"))){%>
		tbar: Ext.create('Ext.Toolbar',{
			items:[{
				text:'新增',
				handler:function(){
					var elemId = testElemForm.getForm().findField('elemId').getValue();
					if(elemId==""){
						Ext.Msg.alert("提示","请先保存要素");
						return;
					}
					var subElemForm = Ext.create('Ext.form.Panel',{
						tbar: Ext.create('Ext.Toolbar',{
							items:[{
								text:'保存',
								handler:function(){
									var subElemFormMasker = new maskerWithHtmlEl(addSubElemWindow,'正在保存要素值信息，请稍后');
									subElemFormMasker.show();
									var valueForm = subElemForm.getForm();
									
									valueForm.findField('elemId').setValue(elemId);
									subElemForm.submit({
										clientValidation: true,
							  			url:"<%=request.getContextPath()%>/saveSubElem.do",
							  			method:'POST',  
					                   	success:function(response,config){
					                   		subElemStore.reload({params:{elemId:elemId}});
					                   		subElemFormMasker.hide();
					                   		addSubElemWindow.close();
					                   	},
					                   	failure:function(response,config){
					                   		subElemFormMasker.hide();
					                   		var errorType = config.failureType;
											if(errorType=="client"){
												Ext.Msg.alert("提示","请处理带有红色下划线的字段的错误");
											}else if(config.failureType =="connect"){
												Ext.Msg.alert("提示","当前网络不畅，请稍后再试");
											}else
												Ext.Msg.alert("提示","<font color='red'>保存失败</font>,在保存时后台出现异常");
					                   	}
									});
								}
							}]
						}),
						id:'subElemForm',
						width:486,
						height:266,
				        cls: 'ui-formPanel',
						layout: { 
							type: 'vbox'
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
						    fieldDefaults: {
						    	labelAlign: 'right'
						    },
						    items: [{
						    	xtype:'hidden',
						    	name: 'subElemId'
						    },{
				                name: 'isDelete',
				                xtype: 'hidden'
			            	},{
						    	xtype:'hidden',
						    	name: 'elemId'
						    },{
						    	xtype:'hidden',
						    	name: 'elemTestLogic'
						    },{ 
						    	width: 486, 
						    	height:70,
						    	name: 'elemValue', 
						    	xtype:'textareafield',
						        fieldLabel: '<font color="red">要素值</font>', 
						        allowBlank: false,
						        emptyText:'请填写要素值',
						        maxLength : 4000,
						        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
						    }] 
						 },{
							xtype: 'fieldcontainer', 
						    labelStyle: 'font-weight:bold;padding:0',
						    layout: 'hbox',
						    defaultType: 'textfield',
						    fieldDefaults: {
						    	labelAlign: 'right'
						    },
						    items: [{
						    	width: 486, 
						    	height:70,
						    	name: 'takeValueMethod', 
						    	xtype:'textareafield',
						        fieldLabel: '<font color="red">取数方法</font>', 
						        allowBlank: false,
						        emptyText:'请填写取数方法',
						        maxLength : 4000,
						        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
						    }]
						 },{
							xtype: 'fieldcontainer', 
						    labelStyle: 'font-weight:bold;padding:0',
						    layout: 'hbox',
						    defaultType: 'textfield',
						    fieldDefaults: {
						    	labelAlign: 'right'
						    },
						    items: [{
						    	width: 486, 
						    	height:60,
						    	name: 'valueRemark', 
						    	xtype:'textareafield',
						        fieldLabel: '备注', 
						        emptyText:'请填写备注',
						        maxLength : 4000,
						        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
						    }]
						 }]
					});
					
					var addSubElemWindow = new Ext.window.Window({
						id:'addSubElemWindow',
					    width : 500,
					    height : 300,
					    title:'新增要素值',
					    modal : true,
					    resizable:false,
					    closeAction : 'destroy',
					    items:[subElemForm]
					});
					addSubElemWindow.show();
				}
			},{
				text:'删除',
				handler:function(){
					var elemId = testElemForm.getForm().findField('elemId').getValue();
					if(elemId==''){
						Ext.Msg.alert("提示","未能获取到要素信息");
						return;
					}
					var selections = subElemGrid.getSelectionModel().getSelection();
					if(selections==null||selections.length==0){
						Ext.Msg.alert("提示","请选择一条测试要素值进行删除");
						return;
					}
					var deleteSubElemMasker = new maskerWithHtmlEl(Ext.getCmp('testElemPanel'),'正在删除要素值信息，请稍后');
					deleteSubElemMasker.show();
					var subElemId = new Array();
					for(var i=0,n=selections.length;i<n;i++){
						subElemId.push(selections[i].raw.subElemId);
					}
					Ext.Ajax.request({
						url:'<%=request.getContextPath()%>/deleteSubElem.do?subElemIds='+subElemId.join(","),
						success:function(response,config){
							var json = Ext.JSON.decode(response.responseText);
							if(json.success==true){
								subElemStore.reload({params:{elemId:elemId}});
								deleteSubElemMasker.hide();
								Ext.Msg.alert("提示","删除成功");
							}else{
								deleteSubElemMasker.hide();
								Ext.Msg.alert("错误","<font color='red'>删除失败</font>,删除要素值时后台出现错误");
							}
						},
						failure:function(response,config){
							deleteSubElemMasker.hide();
							Ext.Msg.alert("提示","数据请求失败");
						}
					});
				}
			}]
		}),
		<%}%>
		id:'subElemGrid',
	    cls: 'ui-formPanel',
		title:'测试要素值',
		border:0,
        width: 1050,
        height:290,
		viewConfig:{
			forctFit:true,
			stripeRows:true
		},
		store:subElemStore,
		<%if(!(flag!=null&&flag.equals("query"))){%>
		listeners:{
			itemdblclick:function(grid, record, item, index, e, eOpts ){
				var subElemId = record.raw.subElemId;
				var elemId = testElemForm.getForm().findField('elemId').getValue();
				if(elemId==""){
					Ext.Msg.alert("提示","请先保存要素");
					return;
				}
				var subElemForm = Ext.create('Ext.form.Panel',{
					tbar:Ext.create('Ext.Toolbar',{
						items:[{
							text:'保存',
							handler:function(){
								var subElemFormMasker = new maskerWithHtmlEl(editSubElemWindow,'正在保存要素值信息，请稍后');
								subElemFormMasker.show();
								var valueForm = subElemForm.getForm();
								
								valueForm.findField('elemId').setValue(elemId);
								subElemForm.submit({
									clientValidation: true,
						  			url:"<%=request.getContextPath()%>/saveSubElem.do",
						  			method:'POST',  
				                   	success:function(response,config){
				                   		subElemStore.reload({params:{elemId:elemId}});
				                   		subElemFormMasker.hide();
				                   		editSubElemWindow.close();
				                   	},
				                   	failure:function(response,config){
				                   		subElemFormMasker.hide();
				                   		var errorType = config.failureType;
										if(errorType=="client"){
											Ext.Msg.alert("提示","请处理带有红色下划线的字段的错误");
										}else if(config.failureType =="connect"){
											Ext.Msg.alert("提示","当前网络不畅，请稍后再试");
										}else
											Ext.Msg.alert("提示","<font color='red'>保存失败</font>,在保存时后台出现异常");
				                   	}
								});
							}
						}]
					}),
					id:'subElemForm',
					width:486,
					height:266,
			        cls: 'ui-formPanel',
					layout: { 
						type: 'vbox'
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
					listeners:{
			        	render:function(form,eOpts){
			        		var loadTestSubElemMasker = new maskerWithHtmlEl(editSubElemWindow,'正在加载测试要素值信息，请稍后');
			        		loadTestSubElemMasker.show();
			        		form.load({
			        			url:'<%=request.getContextPath()%>/getTestSubElemForm.do?subElemId='+subElemId,
			             		success:function(response,config){
			             			loadTestSubElemMasker.hide();
			             		},
			             		failure:function(response,config){
			             			loadTestSubElemMasker.hide();
			                  		Ext.Msg.alert("操作","获取要素值信息失败");
			                  	}
			        		});
			        	}
			        },
					items: [{
						xtype: 'fieldcontainer', 
					    labelStyle: 'font-weight:bold;padding:0',
					    layout: 'hbox',
					    defaultType: 'textfield',
					    fieldDefaults: {
					    	labelAlign: 'right'
					    },
					    items: [{
					    	xtype:'hidden',
					    	name: 'subElemId'
					    },{
			                name: 'isDelete',
			                xtype: 'hidden'
		            	},{
					    	xtype:'hidden',
					    	name: 'elemId'
					    },{
					    	xtype:'hidden',
					    	name: 'elemTestLogic'
					    },{ 
					    	width: 486, 
					    	height:70,
					    	name: 'elemValue', 
					    	xtype:'textareafield',
					        fieldLabel: '<font color="red">要素值</font>', 
					        allowBlank: false,
					        emptyText:'请填写要素值',
					        maxLength : 4000,
					        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
					    }] 
					 },{
						xtype: 'fieldcontainer', 
					    labelStyle: 'font-weight:bold;padding:0',
					    layout: 'hbox',
					    defaultType: 'textfield',
					    fieldDefaults: {
					    	labelAlign: 'right'
					    },
					    items: [{
					    	width: 486, 
					    	height:70,
					    	name: 'takeValueMethod', 
					    	xtype:'textareafield',
					        fieldLabel: '<font color="red">取数方法</font>', 
					        allowBlank: false,
					        emptyText:'请填写取数方法',
					        maxLength : 4000,
					        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
					    }]
					 },{
						xtype: 'fieldcontainer', 
					    labelStyle: 'font-weight:bold;padding:0',
					    layout: 'hbox',
					    defaultType: 'textfield',
					    fieldDefaults: {
					    	labelAlign: 'right'
					    },
					    items: [{
					    	width: 486, 
					    	height:60,
					    	name: 'valueRemark', 
					    	xtype:'textareafield',
					        fieldLabel: '备注', 
					        emptyText:'请填写备注',
					        maxLength : 4000,
					        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
					    }]
					 }]
				});
				
				var editSubElemWindow = new Ext.window.Window({
					id:'editSubElemWindow',
				    width : 500,
				    height : 300,
				    title:'编辑要素值',
				    modal : true,
				    resizable:false,
				    closeAction : 'destroy',
				    items:[subElemForm]
				});
				editSubElemWindow.show();
			}
		},
		selModel:Ext.create("Ext.selection.CheckboxModel",{checkOnly : true,ignoreRightMouseSelection : true}),
		<%}%>
		columns:[
			new Ext.grid.RowNumberer(),
			{header:"主键",width:100,dataIndex:"subElemId",sortable:true,hidden:true},
			{header:"外键",width:100,dataIndex:"elemId",sortable:true,hidden:true},
			{header:"要素值",width:200,dataIndex:"elemValue",sortable:true},
			{header:"要素测试逻辑",width:100,dataIndex:"elemTestLogic",sortable:true,hidden:true},
			{header:"取数方法",width:200,dataIndex:"takeValueMethod",sortable:true},
			{header:"备注",width:200,dataIndex:"valueRemark",sortable:true}
			<%if(!(flag!=null&&flag.equals("query"))){%>
			,{header:'操作', width:50,menuDisabled: true,xtype:'actioncolumn',sortable:false,items: [{
	      			icon:"<%=request.getContextPath()%>/css/images/copy-font.gif",
	   				id: 'copySecR',  
					tooltip: '复制要素值',  
					handler: function(grid, rowIndex, colIndex) {
	      				var record = grid.getStore().getAt(rowIndex);
						var subElemId = record.raw.subElemId;
						var elemId = testElemForm.getForm().findField('elemId').getValue();
						if(elemId==""){
							Ext.Msg.alert("提示","请先保存要素");
							return;
						}
						var subElemForm = Ext.create('Ext.form.Panel',{
							tbar:Ext.create('Ext.Toolbar',{
								items:[{
									text:'保存',
									handler:function(){
										var subElemFormMasker = new maskerWithHtmlEl(editSubElemWindow,'正在保存要素值信息，请稍后');
										subElemFormMasker.show();
										var valueForm = subElemForm.getForm();
										var elemId = testElemForm.getForm().findField('elemId').getValue();
										valueForm.findField('elemId').setValue(elemId);
										valueForm.findField('subElemId').setValue('');
										subElemForm.submit({
											clientValidation: true,
								  			url:"<%=request.getContextPath()%>/saveSubElem.do",
								  			method:'POST',  
						                   	success:function(response,config){
						                   		subElemStore.reload({params:{elemId:elemId}});
						                   		subElemFormMasker.hide();
						                   		editSubElemWindow.close();
						                   	},
						                   	failure:function(response,config){
						                   		subElemFormMasker.hide();
						                   		var errorType = config.failureType;
												if(errorType=="client"){
													Ext.Msg.alert("提示","请处理带有红色下划线的字段的错误");
												}else if(config.failureType =="connect"){
													Ext.Msg.alert("提示","当前网络不畅，请稍后再试");
												}else
													Ext.Msg.alert("提示","<font color='red'>保存失败</font>,在保存时后台出现异常");
						                   	}
										});
									}
								}]
							}),
							id:'subElemForm',
							width:486,
							height:266,
					        cls: 'ui-formPanel',
							layout: { 
								type: 'vbox'
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
							listeners:{
					        	render:function(form,eOpts){
					        		var loadTestSubElemMasker = new maskerWithHtmlEl(editSubElemWindow,'正在加载测试要素值信息，请稍后');
					        		loadTestSubElemMasker.show();
					        		form.load({
					        			url:'<%=request.getContextPath()%>/getTestSubElemForm.do?subElemId='+subElemId,
					             		success:function(response,config){
					             			loadTestSubElemMasker.hide();
					             		},
					             		failure:function(response,config){
					             			loadTestSubElemMasker.hide();
					                  		Ext.Msg.alert("操作","获取要素值信息失败");
					                  	}
					        		});
					        	}
					        },
							items: [{
								xtype: 'fieldcontainer', 
							    labelStyle: 'font-weight:bold;padding:0',
							    layout: 'hbox',
							    defaultType: 'textfield',
							    fieldDefaults: {
							    	labelAlign: 'right'
							    },
							    items: [{
							    	xtype:'hidden',
							    	name: 'subElemId'
							    },{
					                name: 'isDelete',
					                xtype: 'hidden'
				            	},{
							    	xtype:'hidden',
							    	name: 'elemId'
							    },{
							    	xtype:'hidden',
							    	name: 'elemTestLogic'
							    },{ 
							    	width: 486, 
							    	height:70,
							    	name: 'elemValue', 
							    	xtype:'textareafield',
							        fieldLabel: '<font color="red">要素值</font>', 
							        allowBlank: false,
							        emptyText:'请填写要素值',
							        maxLength : 4000,
							        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
							    }] 
							 },{
								xtype: 'fieldcontainer', 
							    labelStyle: 'font-weight:bold;padding:0',
							    layout: 'hbox',
							    defaultType: 'textfield',
							    fieldDefaults: {
							    	labelAlign: 'right'
							    },
							    items: [{
							    	width: 486, 
							    	height:70,
							    	name: 'takeValueMethod', 
							    	xtype:'textareafield',
							        fieldLabel: '<font color="red">取数方法</font>', 
							        allowBlank: false,
							        emptyText:'请填写取数方法',
							        maxLength : 4000,
							        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
							    }]
							 },{
								xtype: 'fieldcontainer', 
							    labelStyle: 'font-weight:bold;padding:0',
							    layout: 'hbox',
							    defaultType: 'textfield',
							    fieldDefaults: {
							    	labelAlign: 'right'
							    },
							    items: [{
							    	width: 486, 
							    	height:60,
							    	name: 'valueRemark', 
							    	xtype:'textareafield',
							        fieldLabel: '备注', 
							        emptyText:'请填写备注',
							        maxLength : 4000,
							        maxLengthText:'该字段最大长度为：{0},您的文本长度已经超出该限制'
							    }]
							 }]
						});
						
						var editSubElemWindow = new Ext.window.Window({
							id:'editSubElemWindow',
						    width : 500,
						    height : 300,
						    title:'复制要素值',
						    modal : true,
						    resizable:false,
						    closeAction : 'destroy',
						    items:[subElemForm]
						});
						editSubElemWindow.show();
					}
				}]
			}
			<%}%>
		]
	});
   	
   	Ext.create('Ext.Panel', {
    	id:'testElemPanel',
        renderTo: Ext.get('testElemPanel'),
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
            items: [testElemForm,subElemGrid]
        }]
    });
});
</script>
</html>