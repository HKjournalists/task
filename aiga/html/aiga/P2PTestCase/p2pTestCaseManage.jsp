<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp"%>
<html>
<head>
<title>端到端用例管理</title>
</head>
<body>
</body>
<style>
</style>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
var leftWidth = 1200 - 260;
if(leftWidth  < screenWidth * 0.8)
	leftWidth = screenWidth * 0.8;
var copyCaseId = '',clickFlag='';
var caseField='';
var lastInputValue='';
var subTaskTag = '${param.subTaskTag}';
var normalMac = '${param.normalMac}';
var TemporaryTag = '${param.TemporaryTag}';
Ext.regModel('extCommboModel', {
    fields: [
        {type: 'string', name: 'value'},
        {type: 'string', name: 'text'}
    ]
});
var P2pBusiOneLevelIds=new Array();
var P2pBusiTwoLevelIds=new Array();
var types=new Array();
var ids=new Array();
function query(){
	clickFlag='query';
	P2pBusiTwoLevelIds=new Array();
	P2pBusiOneLevelIds=new Array();
	types=new Array();
	ids=new Array();
	var tp = Ext.getCmp('caseTree');  
	var root = tp.getStore().getProxy();  
		root.extraParams.clickFlag = 'query';
	var searchComBox=Ext.getCmp('searchComBox');
	var caseTreeStore= Ext.data.StoreManager.lookup('caseTreeStore');
	//监听事件
	var searchStore= Ext.data.StoreManager.lookup('searchStore');
	ids=searchComBox.getValue();
	var storeMap=searchStore.data.map;
	for(var index in  ids){
		try{
			var id=ids[index];
			if(storeMap[id]!='undefined'){
				P2pBusiTwoLevelIds.push(storeMap[id].raw.AigaP2pBusiTwoLevelId);
				P2pBusiOneLevelIds.push(storeMap[id].raw.AigaP2pBusiOneLevelId);
				types.push(storeMap[id].raw.type);
			}
		}catch(e){
		}
	}
	if(ids==null||ids.length==0){
		clickFlag='click';
		caseTreeStore.load({params:{flag:'AigaP2pBusiOneLevel',clickFlag:clickFlag,caseField: caseField,P2pBusiTwoLevelIds:P2pBusiTwoLevelIds,P2pBusiOneLevelIds:P2pBusiOneLevelIds,types:types}});
	}else{
		caseTreeStore.load({params:{flag:'AigaP2pBusiOneLevel',clickFlag:clickFlag,caseField: caseField,P2pBusiTwoLevelIds:P2pBusiTwoLevelIds,P2pBusiOneLevelIds:P2pBusiOneLevelIds,types:types}});
		
	}
}
Ext.onReady(function() {
	Ext.QuickTips.init();
	Ext.tip.QuickTipManager.init();
	
	var searchField = Ext.create('Ext.data.Store', {
	    fields: ['abbr', 'name'],
	    data : [
	        {'abbr':'AigaP2pBusiTwoLevel', 'name':'二级业务'}
	       ,{'abbr':'AigaP2pBusiOneLevel', 'name':'一级业务'}
	    ]
	});
	Ext.regModel('searchModel', {
	    fields: [
	        {type: 'string',name:'name'},
	        {type: 'string',name:'id'},
	        {type: 'string',name:'type'},
	        {type: 'string',name:'AigaP2pBusiTwoLevelId'},
	        {type: 'string',name:'AigaP2pBusiOneLevelId'},
	        {type: 'string',name:'remark'}
	    ]
	});
    var searchStore = Ext.create('Ext.data.Store', {
		storeId:'searchStore',
		model:'searchModel',
	    proxy: {
	        type: 'ajax',
        	url : '<%=request.getContextPath()%>/searchCaseAndFolder.do',
	        reader: {
				type:'json',
				root:'data'
	        }
	    }
	});
	var caseFieldCombox = new Ext.form.ComboBox({
		width: 80,
	  	store: searchField,
    	queryMode: 'local',
    	id:'caseFieldCombox',
    	displayField: 'name',
    	valueField: 'abbr',
    	value:'AigaP2pBusiTwoLevel',
		 listeners:{
			 select:function( combo, records, eOpts ){
				 var combox=Ext.getCmp('searchComBox');
				 //combox.displayField='funFolderName';
			 }
         }
		});
	var searchComBoxMain=new Ext.form.ComboBox({
       xtype: 'combo',
       id:'searchComBox',
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
       		if(newValue==null||newValue=='null'){
       			_this.collapse();
       		}
       		
	},
	focus:function( _this, The, eOpts ){
			_this.focus(true);try{
				if(_this.getValue()!=null&&_this.getValue!='null'&&_this.getValue().length!=0)_this.expand();
			}catch(e){}
	},
      	specialkey:function( _this, e, eOpts ){
      		 if (e.getKey() == e.ENTER) {
      			 var queryData={caseField:'',caseValue:''};
      			 caseField=caseFieldCombox.getValue();
      			 var searchComBox=Ext.getCmp('searchComBox');
			if(searchComBox.getValue() instanceof Array){
				searchComBox.expand();
				}else{
					_this.collapse();
					if(caseField!=''&&searchComBox.getValue()!=null&&searchComBox.getValue()!='null'&&searchComBox.getValue()!=''){
						queryData.caseField=caseField;
						queryData.caseValue=searchComBox.getValue();
						var query='{'+caseField+':\''+encodeURI(encodeURI(searchComBox.getValue()))+'\'}';
						searchComBox.doQuery(query, true ); 
	               	}else {
	               		window.query();
	               		return;
	               		}
					}
			}
      	},
       	beforequery: function( queryEvent,  eOpts ){return;},
       	beforeselect:function( combo, record,index, eOpts ){}
       	},
       listConfig: {
           loadingText: 'Searching...',
           emptyText: '没有搜索到结果',
           itemTpl : Ext.create('Ext.XTemplate','<input type=checkbox>{[values.name]}</input>'),  
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
	    });
	var searchForm = Ext.widget({
	    xtype: 'form',
	    layout: 'column',
	    collapsible: false,
	    id: 'searchForm',
	    title: '搜索',
	    cls: 'ui-formPanel',
	    bodyPadding: '5 5 0',
	    minWidth: 260,
	    minHeight: 100,
	   	width: screenWidth*0.2,   
		height: screenHeight*0.2, 
		layout: 'hbox', 
	    fieldDefaults: {msgTarget: 'side',labelWidth: 50},
	    items: [caseFieldCombox,searchComBoxMain,{xtype:'button',text: '',tooltip:'生成结果树',id:'searchBtn',iconCls: 'search-button',handler: function() {query();}}
	    ]
	    });
	var caseTreeStore = Ext.create('Ext.data.TreeStore', {
		id:'caseTreeStore',
		listeners:{
			load:function(){
			}	
		},
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getP2PCaseTreeSyn.do',
			extraParams:{  
				flag:'AigaP2pBusiOneLevel' 
			}
		},
		root: {
			id:'-1',
			text: '业务',
			expanded: true
		},
		reader: { 
			type: 'json', 
			root: 'children' 
		} 
    });
	var caseTree = null;
	caseTree = Ext.create('Ext.tree.Panel', { 
		id :'caseTree',
		minWidth: 260,
		minHeigth: 300,
	    width: screenWidth*0.2,
	    height: screenHeight*0.79 - 10,
        cls: 'ui-formPanel',
	    title : '用户体验测试用例库',   
	    rootVisible : false,
	    useArrows: true,
	    autoScroll:true,
        frame: false,
        flex: 3,
        store: caseTreeStore,
	    viewConfig : {  
	   
	        loadingText : '加载数据...' 
	    },
	  
		listeners : {
			iconclschange:function( Panel , newCls , oldCls ,  eOpts ){
			},
			itemclick : function(thisView, record, htmlElementItem, indexNo){
				var leaf=record.raw.leaf;
				if(leaf){
					if(record.raw.type=='AigaP2pBusiTwoLevel'){
						var busiOneLevelId = record.raw.parentId;
						var id = record.raw.id;
						//var subNode = caseTreeStore.getNodeById(subSysId);
						$('#contentFrame').attr('src','p2pTestCaseMain.jsp?busiTwoLevelId='+id+'&busiOneLevelId='+busiOneLevelId+'&p2pSubTaskTag='+subTaskTag+'&p2pNormalMac='+encodeURI(encodeURI(normalMac))+'&p2pTemporaryTag='+TemporaryTag);
					}
				}else{
					//clickFlag='click';
				}
		},
		beforeitemexpand :function(record,eOpts){  
			if(!record.raw.expanded){
				//手动张开的
				clickFlag='click';
			}else{
				clickFlag='query';
			}
			var tp = Ext.getCmp('caseTree');  
			var root = tp.getStore().getProxy();  
			root.extraParams.P2pBusiOneLevelIds = P2pBusiOneLevelIds;
			root.extraParams.P2pBusiTwoLevelIds = P2pBusiTwoLevelIds;
			root.extraParams.types = types;
			root.extraParams.clickFlag = clickFlag;
			if(record.raw.type=='AigaP2pBusiOneLevel'){
				root.extraParams.flag = 'AigaP2pBusiTwoLevel';
			}
			if(record.raw.type=='AigaP2pBusiTwoLevel'){
			}
		} 
	}
	}); 
	Ext.create('Ext.panel.Panel', {
		renderTo : Ext.getBody(),
		minWidth: 1200,
		minHeight: 500,
		width : screenWidth*0.98,
		hieght : screenHeight*0.96,
		border:0,
		listeners:{
			render:function(render,eOpts){
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
							        fieldLabel: '修改类型',
							        allowBlank: false,
							        forceSelection: true,
							        emptyText:'请选择修改类型',
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
							        		}
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
						        fieldLabel: '测试子任务名称',
						        xtype: 'combo', 
						        forceSelection: true,
						        emptyText:'请选择子任务名称',
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
						text:'关闭',
						handler:function(){
							window.parent.closeTab();
						}
					},{
					  	xtype: 'button',
						text: '确定',
						handler:function(){
							subTaskTag = '';
							normalMac = '';
							TemporaryTag = '';
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
					id:'caseEditReasonWin',
					title:'用例修改',
				    width : 400,
				    height : 350,
				    modal : true,
				    closable:false,
				    resizable:false,
				    closeAction : 'destroy',
				    items:[caseEditForm]
				});
				if(subTaskTag ==''&&normalMac == ''&&TemporaryTag == '')
				caseEditReasonWin.show();
				
			}
		},
		layout : {
			type : 'hbox',
			align : 'stretch',
			padding : 0
		},
		defaults : {
			split : true,
			collapsible : false,
			bodyStyle : 'padding:0px'
		},
		items : [ {
			region : 'west',
			items : [ searchForm, caseTree ]
		}, {
			region : 'center',
			border:0,
			items : [ {html:'<iframe id="contentFrame" frameBorder="0" scrolling="no" width="'+leftWidth+'" height="'+(screenHeight - 10)+'"></iframe>'} ]
		} ]
	});
});
</script>
</html>