<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser"); %>
<html>
	<head>
		<title>组件</title>
	</head>
	<body>
		<jsp:include page="/aiga/workflow/common/SelectStaff.jsp"></jsp:include>
	</body>
	<script type="text/javascript">
var extjsFolderPath='<%=request.getContextPath()%>/extJs';
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
var compId = '${param.compId}';
var parentId = '${param.parentId}';
if(compId=='')
	compId='0';
if(parentId=='')
	parentId='0';
/******刷新序号******/
function refreshNum(){
guiGrid.getView().refresh();
}
	var guiModel = Ext.regModel("guiModel",{
		fields:[{name:'guiId',type:'string'}, 
		 		{name:'guiSelector',type:'string'}, 
		 		{name:'guiUrl',type:'string'}, 
		 		{name:'guiThumbUrl',type:'string'},
		 		{name:'guiTag',type:'string'},
		 		{name:'parentId',type:'string'},
		 		{name:'guiName',type:'string'},
		 		{name:'guiPermission',type:'string'},
		 		{name:'guiPath',type:'string'},
		 		{name:'guiExtra',type:'string'},
		 		{name:'guiDesc',type:'string'},
		 		{name:'guiHtml',type:'string'},
		 		{name:'guiCreateTime',type:'string'},
		 		{name:'guiUpdateTime',type:'string'},
		 		{name:'guiAuthor',type:'string'},
		 		{name:'guiBounds',type:'string'},
		 		{name:'guiHashCode',type:'string'},
		 		{name:'guiLatestOperator',type:'string'}]
	});

Ext.onReady(function() {
Ext.QuickTips.init();
//tooltip初始化
Ext.tip.QuickTipManager.init();
	/***组件表单***/
		var compForm = Ext.create('Ext.form.Panel', {
		tbar:Ext.create('Ext.Toolbar',{
			items:[{
				text:'保存',
				handler:function(){
					var guiGrid= Ext.getCmp("guiGrid");
					var store=guiGrid.getStore();
					var records = store.getUpdatedRecords();// 获取修改的行的数据，无法获取幻影数据  
	      				var phantoms=store.getNewRecords() ;//获得幻影行  
	       			records=records.concat(phantoms);//将幻影数据与真实数据合并
					var data = new Array(); 
	                   Ext.Array.each(store.data.items, function(record) {  
	                       data.push(record.data);  
	                       });  
	                   var submitForm = compForm.getForm();
	                   submitForm.findField('permission').setValue('1');
	                   if(compId=='0'){
			  			submitForm.findField('compId').setValue('');
			  			if(parentId=='0'){
			  				Ext.Msg.alert('提示',"未找到关联用例父节点信息");
			  				return;
			  			}
			  			submitForm.findField('author').setValue('<%=user.getUserName()%>');
			  			submitForm.findField('parentId').setValue(parentId);
			  			submitForm.findField('isLeaf').setValue('Y');
			  		}else{
			  			var currentStaff = '<%=user.getUserName()%>';
			  			submitForm.findField('latestOperator').setValue(currentStaff);
			  		}
			  		/**提交*/
			  		MaskLoading();
			  		compForm.submit({
			  			clientValidation: true,
			  			url:"<%=request.getContextPath()%>/saveComp.do",
			  			params : {
	                           table :Ext.encode(data)
	                       },
			  			method:'POST',  
	                   	success:function(response,config){
			  		MaskOver();
	                       	var success = config.result.success;  
	                           // 当后台数据同步成功时  
	                           if (success) {
	                               Ext.Array.each(records, function(record) {  
	                               	record.commit();// 向store提交修改数据，页面效果
	                           	});
	                           }
	                       },
	                       failure:function(response,config){
			  		MaskOver();
							Ext.Msg.alert("提示","数据修改失败!");
						}
			  		});
				}
			}]
		}),
		id:'compForm',
		width:screenWidth*0.8*0.99,
		height:screenHeight*0.4,
		title:'组件', 
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
		    	width: 220,
		    	name: 'compName', 
		        fieldLabel: '组件名称', 
		        allowBlank: false,
		         emptyText:'请填写组件名称'
		    }, { 
			        width: 220, 
			        xtype: 'textfield', 
			        name:'approvalName',
			        fieldLabel: '组件审批人', 
			        allowBlank: false,
			        readOnly:true,
			        emptyText:'请选择审批人'
			    },{
				xtype:'button',
				text:'选择',
				handler:function(){
					SelectStaff.showWin('WF_LINKROLE1',3,-1,3,2,false,2,0);
				}
			}] 
		 }, { 
				xtype: 'fieldcontainer', 
			    labelStyle: 'font-weight:bold;padding:0', 
			    layout: 'hbox', 
			    defaultType: 'textfield', 
			    fieldDefaults: { 
			    	labelAlign: 'right' 
			    }, 
				items:[ { 
			        width: 220,
			        name:'defaultVal',
			        fieldLabel: '组件默认值', 
			        allowBlank: false,
			        emptyText:'请填写组件默认值'
			    },{ 
			    	readOnly:true,
			        width: 220,
			        name:'author',
			        fieldLabel: '组件创建人',
			        readOnly:true
			    },
			    {
			    	width: 220,
			        name: 'latestOperator',
			        fieldLabel: '最后修改人', 
			        allowBlank: false,
			        readOnly:true
			    }]
		},{ 
			xtype: 'fieldcontainer', 
			labelStyle: 'font-weight:bold;padding:0', 
			layout: 'hbox', 
			defaultType: 'textfield', 
			fieldDefaults: { 
				labelAlign: 'right' 
			}, 
			items:[{ 
				width: 660, 
				height:35,
			    xtype: 'textareafield', 
			    name:'compDesc',
			    fieldLabel: '组件描述', 
			    allowBlank: false,
			    emptyText:'请填写组件描述'
			}]
		},{ 
				xtype: 'fieldcontainer', 
			    labelStyle: 'font-weight:bold;padding:0', 
			    layout: 'hbox', 
			    defaultType: 'textfield', 
			    fieldDefaults: { 
			    	labelAlign: 'right' 
			    }, 
				items:[ { 
		    	xtype:"hidden",
		    	width: 220,
		        name: 'path', 
		        fieldLabel: '组件path', 
		        allowBlank: false
		    },{ 
			    	xtype: "hidden",
			        width: 220,
			        name:'hashcode',
			        fieldLabel: '组件hashcode', 
			        allowBlank: false 
			    },{
			    	xtype: "hidden",
			    	width: 220,
			        name: 'extra',
			        fieldLabel: '组件extra', 
			        allowBlank: false 
			    },{
					xtype: "hidden",
			    	width: 600, 
			    	height:35,
			        name: 'url',
			        fieldLabel: '组件url', 
			        allowBlank: false 
			    },{
		    	xtype: "hidden",
		    	name:"compId",
		    	fieldLabel : "组件ID"
		    },{
		    	xtype: "hidden",
		    	name:"parentId",
		    	fieldLabel : "父组件ID"
		    },
		    {
		    	xtype: "hidden",
		    	name:"isLeaf",
		    	fieldLabel : "是否为叶子"
		    },{
		    	xtype:'hidden',
		    	name: 'permission', 
		        fieldLabel: '组件审批'
		    },{
		    	xtype:'hidden',
		    	name:'authorNo'
		    },{
		    	xtype:'hidden',
		    	name:'approvalPsn'
		    }]
		}]
	});
	/***工具栏***/
	gridStore = Ext.create('Ext.data.Store', {
		storeId:'gridStore',
	  	model: guiModel,
	    proxy: {
	    	url : '<%=request.getContextPath()%>/getGuiByCompId.do',
	        type: 'ajax',
	        reader: {
	            type: 'json',
	            root: 'data'
	        }
	    }
	});

	guiGrid = Ext.create('Ext.grid.Panel',{
		id:'guiGrid',
        cls: 'ui-formPanel',
		title:'控件',
        margins : '0 0 0 3',
        width:screenWidth*0.8*0.99,
        height:screenHeight*0.59*0.99,
		forctFit:true,
        stripeRows:true,
        loadMask:true, 
		store: gridStore,
		selType:'rowmodel',
		viewConfig:{
			plugins: [{
		        ptype: 'gridviewdragdrop',
		        dragGroup: 'gridStore',
		        dropGroup: 'gridStore'
	        }],
			//拖动排序需要配置 enableDragDrop 属性 和 dropConfig属性  
	        enableDragDrop: true,  
	        dropConfig: {
	            appendOnly:true  
	        },
	        listeners:{
	        	drop:function(node,Object,overModel,dropPosition,eOpts ){
			        refreshNum();
		    	}
	        },
	        forctFit:true,
			stripeRows:true
		},
		columns:[new Ext.grid.RowNumberer(),
				{header: "控件名ID", width:100, sortable: true, dataIndex: 'guiId',hidden:true},
				{header: "父节点ID", width:100, sortable: true, dataIndex: 'parentId',hidden:true},
				{header: "控件名称", width:100, sortable: true, dataIndex: 'guiName'},
        		{header: "控件Selector", width:100,sortable: true, dataIndex: 'guiSelector',hidden:true},
        		{header: "控件gui", width:100, sortable: true, dataIndex: 'guiUrl',hidden:true},
        		{header: "控件图片", width:100, sortable: true, dataIndex: 'guiThumb',hidden:true},
        		{header: "控件类型", width:100, sortable: true, dataIndex: 'guiTag',hidden:true},
        		{header: "控件path", width:100, sortable: true, dataIndex: 'guiPath',hidden:true},
        		{header: "控件extra", width:100, sortable: true, dataIndex: 'guiExtra',hidden:true},
        		{header: "控件描述", width:100, sortable: true, dataIndex: 'guiDesc',hidden:true},
        		{header: "控件Html", width:100, sortable: true, dataIndex: 'guiHtml',hidden:true},
        		{header: "创建时间", width:100, sortable: true, dataIndex: 'guiCreateTime',hidden:true},
        		{header: "更新时间", width:100, sortable: true, dataIndex: 'guiUpdateTime'},
        		{header: "控件作者", width:100, sortable: true, dataIndex: 'guiAuthor'},
        		{header: "控件Bounds", width:100, sortable: true, dataIndex: 'guiBounds',hidden:true},
        		{header: "控件hashCode", width:100, sortable: true, dataIndex: 'guiHashCode',hidden:true},
        		{header: "最后操作人", width:100, sortable: true, dataIndex: 'guiLatestOperator'},
        		{header: "操作", width:50,menuDisabled: true,xtype:'actioncolumn',sortable:false,items: [{
        			icon:"<%=request.getContextPath()%>/aiga/label/image/del.gif",
        			id: 'delComp',  
					tooltip: '删除组件',  
					handler: function(grid, rowIndex, colIndex) {   //rowIndex，colIndex均从0开始  
				        gridStore.removeAt(rowIndex);
				        refreshNum();
					}  
        		}]}]
	});

	/*******搜索框*****/
	var searchForm=null;
		searchForm = Ext.widget({
        xtype: 'form',
        layout: 'column',
       // frame: true,
        collapsible: true,
        id: 'searchForm',
        title: '搜索',
        bodyPadding: '5 5 0',
       	width: screenWidth*0.2,   
		height: screenHeight*0.21*0.99, 
        fieldDefaults: {
            msgTarget: 'side',
            labelWidth: 50
        },
        items: [{
        	columnWidth: .66,
        	width:100,
        	xtype: 'textfield',
            fieldLabel: '关键字',
            name: 'keyword'
           // allowBlank: false,
         
        },{
        margin:'0 0 0 5',
        columnWidth: .23,
        xtype:'button',
        text: '搜索',
            handler: function() {
                this.up('form').getForm().isValid();
            }
            }
            ]
    });
	var guiTreeStore = Ext.create('Ext.data.TreeStore', {  
		id:'caseTreeStore',
		proxy: {
			type: "ajax",
			url: "<%=request.getContextPath()%>/getGuiTreeSyn.do?type=0"
		},
		root: {
			id:'-1',
			text: '控件集',
			expanded: true
		},
		reader: { 
			type: 'json', 
			root: 'children' 
		} 
    });
	var guiTree = null;
			guiTree = Ext.create("Ext.tree.Panel", {  
			
			    width: screenWidth*0.2,   
			    height: screenHeight*0.772,   
        		cls: 'ui-formPanel',
			    title : "控件树",   
			    rootVisible : true,
			    useArrows: true,
			    autoScroll:true,
		        frame: false,
		        flex: 3,
		        store: guiTreeStore,
			    viewConfig : {  
			   
			        loadingText : "加载数据..."
			    },
				listeners : {
					itemclick : function(thisView, record, htmlElementItem, indexNo){
					
					if(!record.raw.leaf)return;
					var guiId = record.raw.id;
					$.getJSON("<%=request.getContextPath()%>/getGuiById.do",{guiId: guiId}, function(data){
					for( var i=0,n=data.length;i<n;i++){
						var selector = "\""+data[i].guiSelector+"\"";
						data[i].guiSelector = selector;
  						gridStore.add(data[i]);
					}
					});
				}       
			}
		});  
     		Ext.create('Ext.form.Panel', {
			    renderTo: Ext.getBody(),
        		cls: 'ui-formPanel',
			    width: screenWidth*0.99,
			    height: screenHeight*0.99,
			    layout: 'border',
			      listeners:{
			    	render : function(render,eOpts){
				    	compForm.load({
				    		params:{compId :compId},  
							url:'<%=request.getContextPath()%>/refreshCompById.do',
							method:'POST',  
						    success:function(form,action){
						    	if(compId=='0'||compId==''){
							    	var currentStaff = '<%=user.getUserName()%>';
									var currentStaffNo = '<%=user.getUserAccount()%>';
									compForm.getForm().findField('author').setValue(currentStaff);
									compForm.getForm().findField('authorNo').setValue(currentStaffNo);
									compForm.getForm().findField('latestOperator').setValue(currentStaff);
								}else{
									$.getJSON('<%=request.getContextPath()%>/getGuiByCompId.do',{compId: compId}, function(data){
										for( var i=0,n=data.length;i<n;i++){
											var selector = "\""+data[i].guiSelector+"\"";
											data[i].guiSelector = selector;
						  					gridStore.add(data[i]);
										}
									});  
								} 	
						    },  
						    failure:function(form,action){  
						      	Ext.Msg.alert('提示',"失败原因是: "+action.result.errorMessage);  
						    }
				   		});
			    	}
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
			        region: 'west',
			        items:[searchForm,guiTree]
			    }, {
			        region: 'center',
			        items:[compForm,guiGrid]
			    }]
			}); 
});

var afterSelect = function(staffs,option){
	var staffCode = staffs.staffCode;
	var staffName = staffs.employeeName;
	
	Ext.getCmp('compForm').getForm().findField('approvalName').setValue(staffName);
	Ext.getCmp('compForm').getForm().findField('approvalPsn').setValue(staffCode);
};
</script>
</html>