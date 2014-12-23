<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser"); %>
<html>
	<head>
		<title>选择人员</title>
		<!--[if IE 8]>
		<style type="text/css">
		#staffWin{
		z-index:2147483647;
		}
		</style>
		<![endif]-->
	</head>
	<body>
	</body>
<script type="text/javascript">
/**
 * 界面样式 winType  1:选人写意见, 2:只选人, 3:只写意见
 * 选人模式 choiceCount  1:多人模式, 0:单人模式
 * SelectStaff.showWin(roleCode,cur_userId,projectCode,parentOrgId,roleOrgId,needOption,winType,choiceCount)
 * 
 * 在引用页添加以下变量, 示例代码如下:
 * 
 * //窗口显示类型 (1:选人加写意见, 2:只选人, 3:只写意见)
 * var winType = '';
 * //选人模式(0:单人, 1:多人)
 * var choiceCount = '';
 * 
 * 详见aiga/workflow/CreateTestPlan.jsp
 */

var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
var afterSelect = null;
var beforeSelect = null;
var SelectStaff = function(){};
SelectStaff.staffJson = null;
SelectStaff.getStaff = function(){
	return this.staffJson;
};

var checkBoxForChoiceCount =  Ext.create("Ext.selection.CheckboxModel",{
	id : 'checkBoxForChoiceCount',
	mode:"SIMPLE",
	listeners:{
		deselect: function(model,record,index) {//取消选中时产生的事件
			staffStoreTemp.remove(record);
		},
		select: function(model,record,index) {//record被选中时产生的事件
			staffStoreTemp.add(record);
		}
	}
});

var staffEnter = function(grid,choiceCount,winType,needOption){
	if(choiceCount=='0'){
		var selectStaff = grid.getSelectionModel().getSelection();
		if(beforeSelect!=null&&typeof beforeSelect=='function'){
		 	beforeSelect();
		 }
		 var data = null;
		 if(selectStaff.length==1){
		 	data = selectStaff[0].data;
		 }
		 SelectStaff.staffJson=data;
		 if(afterSelect!=null&&typeof afterSelect=='function'){
			 if(winType == 1){//需要填写意见时进行校验
				var option = Ext.getCmp('remarkForm').getForm().findField('remark').getValue();
			 	if((winType == '1' || needOption==true)&&option==''){//当需要填写意见或者选人加写意见时触发
			 		Ext.Msg.alert('提示','请填写意见/备注');
			 		return;
			 	}
			 	afterSelect(SelectStaff.staffJson,option,winType);
			 }else{
		 	 	afterSelect(SelectStaff.staffJson,null,winType);
			 }
		 }
	}else if(choiceCount=='1'){
		var returnData = new Array();
		Ext.Array.each(staffStoreTemp.data.items, function(record) {  
        	returnData.push(record.data);  
        });
		SelectStaff.staffJson = returnData;
		var option = null;
		if(winType != 2){
			option = Ext.getCmp('remarkForm').getForm().findField('remark').getValue();
			if((winType == '1' || needOption==true)&&option==''){//当需要填写意见或者选人加写意见时触发
				Ext.Msg.alert('提示','请填写意见/备注');
			 	return;
			}
		}
		afterSelect(SelectStaff.staffJson,option,winType);
	}
	Ext.getCmp('staffWin').close();
};
/**
 * 弹窗函数
 * @param {Object} roleCode
 * @param {Object} cur_userId
 * @param {Object} projectCode
 * @param {Object} parentOrgId
 * @param {Object} roleOrgId
 * @param {Object} needOption
 * @param {Object} winType  (必选参数)界面样式(1:选人加添意见, 2:只选人, 3:只写意见)
 * @param {Object} choiceCount (必选参数)选人模式(0:单人, 1:多人)
 * @memberOf {TypeName} 
 * @return {TypeName} 
 */
SelectStaff.showWin = function(roleCode,cur_userId,projectCode,parentOrgId,roleOrgId,needOption,winType,choiceCount){
	/*
	if(winType!='2'){
	//意见模板combo start
		autoOpinionStore=new Ext.data.Store({
			autoLoad: true,
			id: 'autoOpinionStore',
			fields: ['value','show'],
			proxy: {
				async:false,
				type: 'ajax',
				url: '<%=request.getContextPath()%>/getAutoOpinion.do',
				reader: {
					type: 'json',
					root: 'data'
				}
			}
		});
		autoOpinionStore.load();
		autoOpinionCombox = new Ext.form.ComboBox({
			width: 250,
			store: autoOpinionStore ,
			name:"autoOpinionCombox",
			fieldLabel : "意见模板",
			valueField: 'value',
			displayField: 'show',
			listeners:{
	            select: {
	                scope: this,
	                fn: function(combo, value, option) {
	                    var selectValue = value[value.length - 1].data.show;
	                    Ext.getCmp('comBoxForAutoOpinion').setValue(selectValue); 
	                }
	            }
			}
		});
		
		//remarkForm start
		remarkForm = Ext.create('Ext.form.Panel', {
			id : 'remarkForm',
			width : 586,
			height : 110,
			layout : {
				type : 'vbox'
			},
			bodyBorder : 0,
			fieldDefaults : {
				labelAlign : 'right',
				labelWidth : 60,
				labelStyle : 'font-weight:bold'
			},
			defaults : {
				margins : '0 0 0 0'
			},
			items : [ {
				xtype : 'fieldcontainer',
				labelStyle : 'font-weight:bold;padding:0',
				layout : 'vbox',
				defaultType : 'textfield',
				fieldDefaults : {
					labelAlign : 'right'
				},
				items : [ autoOpinionCombox,{
					id:'comBoxForAutoOpinion',
					width:483,
					height:78,
					xtype : "textareafield",
					name : "remark",
					fieldLabel:'备注/意见'
				} ]
			} ]
		});
		//remarkForm end
	}
	//意见模板combo end
	
	if(winType!=3){
		//staffTree start
		MaskLoading();
		Ext.Ajax.request({   
			async:false,
			url:'<%=request.getContextPath()%>/getTreeStaffSelectForExt.do?roleCode='+roleCode+'&cur_userId='+cur_userId+'&projectCode='+projectCode+'&parentOrgId='+parentOrgId+'&roleOrgId='+roleOrgId+'&uid=<%=user.getUserAccount()%>',  
			success:function(response,config){ 
				MaskOver();
			json=Ext.JSON.decode(response.responseText);
				staffTree = Ext.create('Ext.tree.Panel',{
					id:'staffTree',
					width: 220,
					height: 215,
					rootVisible: true,
					useArrows: true,
					autoScroll:true,
					viewConfig : {  
						loadingText : "加载数据..."
					},
					listeners:{
						itemclick:function(tree,record,item,index,e,eOpts ){
							staffStore.reload({params:{staffIds:record.raw.type,roleCode:roleCode}});
						}
					},
					animate:true,
				    autoScroll:true,
				    containerScroll:true,
				    frame:false,
				    root:json.data.root
				});
			},
		    failure:function(){ 
				MaskOver();
		        Ext.Msg.alert('提示','数据加载出错');
			}
		});
		//staffTree end
		
		//staffStore start
		staffModel = Ext.regModel("staffModel",{
			fields:[
				{name:'staffId',type:'string'},
				{name:'parentOrganizeId',type:'string'},
				{name:'organizeId',type:'string'},
				{name:'staffCode',type:'string'},
				{name:'employeeName',type:'string'},
				{name:'organizeName',type:'string'},
				{name:'billId',type:'string'}]
		});
		
		staffProxy = new Ext.data.proxy.Ajax({
			type:"ajax",
			model:staffModel,
			url:'<%=request.getContextPath()%>/queryStaffsByName.do',
			reader:{
				root:"data",
				type:"json"
			}
		});
		staffStore = Ext.create('Ext.data.Store',{
			model:staffModel,
			proxy:staffProxy
		});
		staffStore.load({params:{staffIds:'0',roleCode:'0'}});
		//staffStore end
		
		//staffGrid start
		
		gridconfig = {
			id:'staffGrid',
			height: 215,
		    width: 366,
				viewConfig:{
				forctFit:true,
				stripeRows:true
			},
			store:staffStore,
			columns:[
				new Ext.grid.RowNumberer(),
				{header:"员工ID",width:100,dataIndex:"staffId",sortable:true,hidden:true},
				{header:"父组织ID",width:100,dataIndex:"parentOrganizeId",sortable:true,hidden:true},
				{header:"组织ID",width:100,dataIndex:"organizeId",sortable:true,hidden:true},
				{header:"员工编码",width:100,dataIndex:"staffCode",sortable:true},
				{header:"员工",width:100,dataIndex:"employeeName",sortable:true},
				{header:"组织",width:100,dataIndex:"organizeName",sortable:true},
				{header:"手机号",width:100,dataIndex:"billId",sortable:true,hidden:true}]
		};
		if(choiceCount=='0')gridconfig.selType = 'rowmodel';
		else if(choiceCount=='1'){
			gridconfig.selModel = checkBoxForChoiceCount;//用于人, 需要多选模式 
			staffStoreTemp =  Ext.create('Ext.data.Store',{
				model:staffModel,
				proxy:staffProxy
			});
		}
		staffGrid = Ext.create('Ext.grid.Panel',gridconfig);
		//staffGrid end
		if(choiceCount=='0'){
			staffGrid.addListener('itemdblclick', function(grid,record,item,index,e,eOpts){staffEnter(staffGrid,choiceCount,winType,needOption);},this);
		}else if(choiceCount=='1'){
			staffGrid.addDocked([{
			    xtype: 'toolbar',
			    dock: 'bottom',
			    ui: 'footer',
			    items: [{
		            text: '确定',
		            handler: function() {
		                staffEnter(staffGrid,choiceCount,winType,needOption);
		            }
		        },{
		            text: '取消',
		            handler: function() {
		                staffWin.close();
		            }
		        }]
			}]);
		}
	}
	
	var title = '';
	if(winType=='3'){
		title = '填写意见';
	}else{
		title = '选择人员';
	}
	
	staffWin = Ext.create('Ext.window.Window',{
		id:'staffWin',
		title : title,
		width : 600,
		height : 361,
		modal : true,
		closeAction : 'destroy',
		resizable:false,
		items:[]
	});
	if(winType == '1'){ //选人加写意见界面
		staffWin.setSize(600,361);
		staffWin.add([{
			layout : {
				type : 'hbox',
				align : 'stretch',
				padding : 0
			},
			region : 'center',
			items : [Ext.getCmp('staffTree'),staffGrid]
		},{
			region : 'south',
			items : [remarkForm]
		}]);
	}else if(winType == '2'){//只选人界面
		staffWin.setSize(600,251);
		staffWin.add([{
			layout : {
				type : 'hbox',
				align : 'stretch',
				padding : 0
			},
			region : 'center',
			items : [Ext.getCmp('staffTree'),staffGrid]
		}]);
	}else if(winType == '3'){
		staffWin.setSize(500,145);
		remarkForm.addDocked([{
		    xtype: 'toolbar',
		    dock: 'bottom',
		    ui: 'footer',
		    items: [{
	            text: '确定',
	            handler: function() {
	                var option = remarkForm.getForm().findField('remark').getValue();
				 	if(option==''){
				 		Ext.Msg.alert('提示','请填写意见/备注');
				 		return;
				 	}
				 	afterSelect(SelectStaff.staffJson,option);
	                staffWin.close();
	            }
	        },{
	            text: '取消',
	            handler: function() {
	                staffWin.close();
	            }
	        }]
		}]);
		staffWin.add([{
			region : 'south',
			items : [remarkForm]
		}]);
	}
	*/
	

	var StaffRoleViewModel = Ext.define('StaffRoleViewModel', {
	    extend: 'Ext.data.Model',
	    fields: [{
	            name: 'staffId',
	            type: 'string'
	        },{
	            name: 'staffCode',
	            type: 'string'
	        }, {
	            name: 'staffName',
	            type: 'string'
	        },  {
	            name: 'displayName',
	            type: 'string'
	        },{
	            name: 'roleCode',
	            type: 'string'
	        }, {
	            name: 'organizeId',
	            type: 'string'
	        }, {
	            name: 'organizeName',
	            type: 'string'
	        }, {
	            name: 'parentOrganizeId',
	            type: 'string'
	        }, {
	            name: 'staffWorkdayCoefficient',
	            type: 'int'
	        }
	    ]
	});
    Ext.define('subTaskStaffsModel', {
        extend: 'Ext.data.Model',
        fields: ['taskId', 'staffNames','staffIds']
    });
    var subTaskStaffsStore= new Ext.data.Store({
        id: 'subTaskStaffsStore',
        model:subTaskStaffsModel
        
    });
    //选择测试人员store
    var StaffRoleViewStore = new Ext.data.Store({
        id: 'StaffRoleViewStore',
        model: StaffRoleViewModel,
        proxy: {
            type: 'ajax',
            url: '<%=request.getContextPath()%>/getStaffRoleViews.do?staffId=<%=user.getUserId()%>&roleCode=AAA',
            reader: {
                type: 'json',
                root: 'data'
            }
        },
        listeners: {
        	load:function(){
    			StaffRoleViewStore.each(function(record){
    				record.set('displayName',record.get('staffCode')+':'+record.get('staffName'));
    			});
        	}
        	
        }
    });
    StaffRoleViewStore.proxy.url="<%=request.getContextPath()%>/getStaffRoleViews.do?staffId=<%=user.getUserId()%>&roleCode="+roleCode;
    StaffRoleViewStore.load();
    
    var SingleStaffRoleViewComboBox = new Ext.form.ComboBox({
        width: 250,
        store: StaffRoleViewStore,
        name: "distributeStaffname",
        fieldLabel: "选择人员",
        labelWidth :80,
        forceSelection:true,
	    typeAhead:true,
	    minChars:1,
	    selectOnFocus: true,
	    triggerAction: 'all',
	    queryMode: 'local',
        valueField: 'staffName',
        displayField: 'displayName',
        editable:true,
        	listConfig: {
        },
        listeners: {
        	select :function(combo,records, eOpts ){
        		SelectStaff.staffJson = records[0].raw;
        		//Ext.getCmp('taskForm').getForm().findField("distributeStaffid").setValue(records[0].raw.staffId);
        	},
            beforequery: function (queryEvent, eOpts) {
            }
        }
    });
    
    var data = new Array();
    
    var MutiStaffRoleViewComboBox = new Ext.form.ComboBox({
        width: 250,
        multiSelect: true,
        store: StaffRoleViewStore,
        name: "mutidistributeStaffname",
        fieldLabel: "选择多人",
        labelWidth :80,
        forceSelection:true,
	    typeAhead:true,
	    minChars:1,
	    selectOnFocus: true,
	    triggerAction: 'all',
	    queryMode: 'local',
        valueField: 'staffName',
        displayField: 'displayName',
        editable:true,
        	listConfig: {
        },
        listeners: {
        	select :function(combo,records, eOpts ){
        		//SelectStaff.staffJson = records[0].raw;
        		//Ext.getCmp('taskForm').getForm().findField("distributeStaffid").setValue(records[0].raw.staffId);
        	},
            beforequery: function (queryEvent, eOpts) {
            }
        },
        
        listConfig:{  
	        itemTpl : Ext.create('Ext.XTemplate', '<input type=checkbox>{displayName}</input>'),  
	        listeners:{
		    	itemclick:function(view, record, item, index, e, eOpts ){  
		    		 var isSelected = view.isSelected(item);  
		             var checkboxs = item.getElementsByTagName('input');  
		              if(checkboxs!=null)  { 
		            	  var checkbox = checkboxs[0];  
		                  if(!isSelected){
		                  	  checkbox.checked = true;
		                  	  addSelectData(record);
		                  }else {
		                      checkbox.checked = false; 
		                      deleteSelectStaff(record)
		                  }
		                  SelectStaff.staffJson = data;
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
		}
        
    });
    
    function addSelectData(selectStaff){
    	data.push(selectStaff);
    }
    
    function deleteSelectStaff(selectStaff){
    	for(var i = 0;i<data.length;i++){
    		if(selectStaff.staffId == data[i].staffId){
    			data.splice(i,1); 
    			break;
    		}
    	}
    }

	autoOpinionStore=new Ext.data.Store({
		autoLoad: true,
		id: 'autoOpinionStore',
		fields: ['value','show'],
		proxy: {
			async:false,
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getAutoOpinion.do',
			reader: {
				type: 'json',
				root: 'data'
			}
		}
	});
	autoOpinionStore.load();
	
	autoOpinionCombox = new Ext.form.ComboBox({
		width: 250,
		store: autoOpinionStore ,
		name:"autoOpinionCombox",
		fieldLabel : "意见模板",
		labelWidth :80,
		valueField: 'value',
		displayField: 'show',
		listeners:{
            select: {
                scope: this,
                fn: function(combo, value, option) {
                    var selectValue = value[value.length - 1].data.show;
                    Ext.getCmp('comBoxForAutoOpinion').setValue(selectValue); 
                }
            }
		}
	});

		
	//remarkForm start
	var remarkForm = null;
	
	if(choiceCount == '0'){
		remarkForm = Ext.create('Ext.form.Panel', {
			id : 'remarkForm',
			width : 586,
			height : 135,
			layout : {
				type : 'vbox'
			},
			bodyBorder : 0,
			fieldDefaults : {
				labelAlign : 'right',
				labelWidth : 60,
				labelStyle : 'font-weight:bold'
			},
			defaults : {
				margins : '0 0 0 0'
			},
			items : [ {
				xtype : 'fieldcontainer',
				labelStyle : 'font-weight:bold;padding:0',
				layout : 'vbox',
				defaultType : 'textfield',
				fieldDefaults : {
					labelAlign : 'right'
				},
				items : [ 
						SingleStaffRoleViewComboBox,
						autoOpinionCombox,{
						id:'comBoxForAutoOpinion',
						width:483,
						height:50,
						labelWidth :80,
						xtype : "textareafield",
						name : "remark",
						fieldLabel:'备注/意见'
					}
					]
			} ]
		});
	}else if(choiceCount == '1'){
		remarkForm = Ext.create('Ext.form.Panel', {
			id : 'remarkForm',
			width : 586,
			height : 135,
			layout : {
				type : 'vbox'
			},
			bodyBorder : 0,
			fieldDefaults : {
				labelAlign : 'right',
				labelWidth : 60,
				labelStyle : 'font-weight:bold'
			},
			defaults : {
				margins : '0 0 0 0'
			},
			items : [ {
				xtype : 'fieldcontainer',
				labelStyle : 'font-weight:bold;padding:0',
				layout : 'vbox',
				defaultType : 'textfield',
				fieldDefaults : {
					labelAlign : 'right'
				},
				items : [ 
						MutiStaffRoleViewComboBox,
						autoOpinionCombox,{
						id:'comBoxForAutoOpinion',
						width:483,
						height:50,
						labelWidth :80,
						xtype : "textareafield",
						name : "remark",
						fieldLabel:'备注/意见'
					}
				]
			}]
		});
	}
		
	var title = '';
	if(winType=='3'){
		title = '填写意见';
	}else{
		title = '选择人员';
	}

	staffWin = Ext.create('Ext.window.Window',{
		id:'staffWin',
		title : title,
		width : 500,
		height : 220,
		modal : true,
		closeAction : 'destroy',
		resizable:false,
		items:[]
	});
	
	staffWin.setSize(500,180);
	remarkForm.addDocked([{
	    xtype: 'toolbar',
	    dock: 'bottom',
	    ui: 'footer',
	    items: [{
            text: '确定',
            handler: function() {
                var option = remarkForm.getForm().findField('remark').getValue();
			 	/*if(option==''){
			 		Ext.Msg.alert('提示','请填写意见/备注');
			 		return;
			 	}*/
			 	afterSelect(SelectStaff.staffJson,option);
                staffWin.close();
            }
        },{
            text: '取消',
            handler: function() {
                staffWin.close();
            }
        }]
	}]);
	staffWin.add([{
		region : 'south',
		items : [remarkForm]
	}]);
	
	staffWin.show();		
};
</script>
</html>
	