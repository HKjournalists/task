<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser"); %>
<html>
	<head>
		<title>用例集</title>
	</head>
	<body>
	</body>
	<style>
	 .highlight{color:red;}
	 </style>
	<script type="text/javascript">
var extjsFolderPath='<%=request.getContextPath()%>/extJs';
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
var caseIds = new Array();
caseIds.push(0);
//add by yinsx
var taskStatus="0";
// RADIO 点击事件
var radios = new Array();
radios.push(/^\d{3}$/); //匹配所有
radios.push(/^1\d{1}\d{1}$/); //匹配测试环境
radios.push(/^\d{1}1\d{1}$/); //匹配准发布环境
radios.push(/^\d{1}\d{1}1$/); //匹配生产环境
function checkboxClick(indexX,indexY,t,e){
	var store = Ext.getCmp('caseGrid').getStore();
	var getRowModel = store.getAt(indexX);
	var val=changeIndexValue(getRowModel.get("refValue"),indexY);
	
	getRowModel.set('refValue', val);
	getRowModel.commit();
}

function checkall(e){
	var type=e.id;
	var store = Ext.getCmp('caseGrid').getStore();
	var flag=e.checked;
	for(i=0;i<store.getCount();i++){
		var getRowModel = store.getAt(i);
		document.getElementById(type+"_"+i).checked=flag;
		var val=changeIndexValue(getRowModel.get("refValue"),(type=='test')?0:(type=='prepare')?1:2,(flag)?"1":"0");
		getRowModel.set('refValue', val);
		getRowModel.commit();
	}
}
function changeIndexValue(string,index,value){
	var sub="";
	sub=string.substring(0,index);
	if(value!=null&&value.length>0){
		sub+=value;
	}else{
		if(string.substring(index,index+1)=="1"){
			sub+="0";
		}else{
			sub+="1";
		}
	}
	sub+=string.substring(index+1);
	return sub.toString();
}
/*function changeIndexValues(string,index){
	var sub="";
	sub=string.substring(0,index);
	if(string.substring(index,index+1)=="1"){
		sub+="0";
	}else{
		sub+="1";
	}
	sub+=string.substring(index+1);
	return sub.toString();
}*/
//将字符串转换为数组
String.prototype.toCharArray=function(){
 var c = new Array();
 for(var i=0;i<this.length;i++){
  c[i] = this.substr(i,1);
 } 
 return c;
}
function removeHTMLTag(str) {
    str = str.replace(/<\/?[^>]*>/g,''); //去除HTML tag
    str = str.replace(/[ | ]*\n/g,'\n'); //去除行尾空白
    //str = str.replace(/\n[\s| | ]*\r/g,'\n'); //去除多余空行
    str=str.replace(/&nbsp;/ig,'');//去掉&nbsp;
    return str;
}
Ext.MessageBox.buttonText = {
		yes:'是',
		ok:'好的',
		no:'否',
		cancle:'取消'
};
top.Ext.MessageBox.buttonText = {
		yes:'是',
		ok:'好的',
		no:'否',
		cancle:'取消'
};
Ext.onReady(function() {
top.Ext.QuickTips.init();
//tooltip初始化
top.Ext.tip.QuickTipManager.init();
Ext.QuickTips.init();
Ext.tip.QuickTipManager.init();
	var caseModel = Ext.regModel("caseModel",{
	fields:[
		{name:'caseId',type:'string'},
		{name:'funId',type:'string'},
		{name:'caseName',type:'string'},
		{name:'parentId',type:'string'},
		{name:'caseDesc',type:'string'},
		{name:'hasTest',type:'string'},
		{name:'createTime',type:'string'},
		{name:'updateTime',type:'string'},
		{name:'author',type:'string'},
		{name:'latestOperator',type:'string'},
		{name:'refValue',type:'string'},
		{name:'relaId',type:'string'}
		]
	});
	gridStore = Ext.create('Ext.data.Store', {
		storeId:'caseStore',
	  	model: caseModel,
	    proxy: {
	    	url : '<%=request.getContextPath()%>/getCaseExtTableBySubTaskId.do',
	        type: 'ajax',
	        reader: {
	            type: 'json',
	            root: 'data'
	        }
	    }
	});
	 var workflowParamStore = new Ext.data.Store({
         id: 'workflowParamStore',
         fields: ['phaseId', 'linkId', 'phaseName','vmTaskName'],
		 listeners:{
			 load:function(store,records,successful,eOpts){
	   	     		store.add({linkId:'1',phaseId:'1',phaseName:'加载全部子任务',vmTaskName:'加载全部子任务'});
	   	     		store.add({linkId:'0',phaseId:'0',phaseName:'加载未结束子任务',vmTaskName:'加载未结束子任务'});
			 }
	     }
     });
	 workflowParamStore.load();
	//add by yinsx 添加子任务状态查询条件
	 var testTaskStatusCombox = new Ext.form.ComboBox({
		   width:200,
	       labelWidth: 70,
           labelAlign: 'right',
           id:'subTaskStatus',
           store: workflowParamStore,
           name: 'subTaskStatus',
           fieldLabel: '子任务状态',
           forceSelection:true,
           typeAhead:true,
           minChars:1,
           selectOnFocus: true,
           triggerAction: 'all',
           queryMode: 'local',
           valueField: 'linkId',
           displayField: 'vmTaskName',
           listeners: {
        	   change: function(combo, newValue, oldValue, eOpts) {
   			   taskStatus=Ext.getCmp('subTaskStatus').getValue();
   			   Ext.StoreMgr.get('subTaskTreeStore').setProxy({
	    		    	type: "ajax",
	    	   			url: "<%=request.getContextPath()%>/getsubTaskTreeSyn.do?staffId=<%=user.getUserId()%>&subTaskStatus="+taskStatus
			    	}),
	    	   Ext.StoreMgr.get('subTaskTreeStore').load();
	   		
       		}
        }
   });
	gridStore.load({params:{subTaskId:"0"}});
	var caseGrid = Ext.create('Ext.grid.Panel',{
		id:'caseGrid',
        cls: 'ui-formPanel',
		title:'选择用例',
        margins : '0 0 0 3',
        height:screenHeight*0.48,
       //tbar:tbar,
        width:screenWidth*0.8,
		forctFit:true,
        stripeRows:true,//斑马线效果   
        loadMask:true,
		listeners:{
			itemdblclick:function(grid,record,item,index,e,eOpts){
	        	var editWin = new top.Ext.window.Window({
				    id:'editWin',
				    title : '编辑用例',
				    width : 1000,
				    height : 550,
				    modal : true,
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="<%=request.getContextPath()%>/aiga/userCase/comp.jsp?caseId='+record.raw.caseId+'&parentId=" width=1000 height=650/>'
			   });
			   editWin.show();
			}
		},
		store:Ext.data.StoreManager.lookup('caseStore'),
		selType:'rowmodel',
		columnLines: true, 
		columns:[new Ext.grid.RowNumberer(),
				{header: "用例ID", width:100, sortable: true, dataIndex: 'caseId',hidden:true},
				{header: "用例名称", width:300, sortable: true, dataIndex: 'caseName'},
				{header: "父ID", width:100, sortable: true, dataIndex: 'parentId',hidden:true},
				{header: "用例描述", width:100, sortable: true, dataIndex: 'caseDesc',hidden:true},
				{header: "是否实现自动化", width:100, sortable: true, dataIndex: 'hasTest',renderer :function(v){if(v=='1')return '是';else return '否';}},
        		{header: "创建时间", width:100,sortable: true, dataIndex: 'createTime',hidden:true},
        		{header: "修改时间", width:100, sortable: true, dataIndex: 'updateTime',hidden:true},
        		{header: "作者", width:100, sortable: true, dataIndex: 'author',hidden:true},
        		{header: "最后修改人", width:100, sortable: true, dataIndex: 'latestOperator',hidden:true},
        		{header: "<input id='test' type='checkbox' onclick=checkall(this)>测试环境</input>", width:80, sortable: true, dataIndex: 'refValue',sortable:false,renderer :function(v){
        		if(v.toCharArray()[0]==1){
        		return '<input type="checkbox" id="test_'+arguments[3]+'" checked="true" onclick="checkboxClick('+arguments[3]+',0,event,this)" />';
        		}else{
        		return '<input type="checkbox" id="test_'+arguments[3]+'" onclick="checkboxClick('+arguments[3]+',0,event,this)" />';
        		}
        		}},
        		{header: "<input id='prepare' type='checkbox' onclick=checkall(this)>准发布环境</input>", width:90, sortable: true, dataIndex: 'refValue',sortable:false,renderer :function(v){
        		if(v.toCharArray()[1]==1){
        		return '<input type="checkbox" id="prepare_'+arguments[3]+'" checked="true" onclick="checkboxClick('+arguments[3]+',1,event,this)"/>';
        		}else{
        		return '<input type="checkbox" id="prepare_'+arguments[3]+'" onclick="checkboxClick('+arguments[3]+',1,event,this)" />';
        		}
        		}},
        		{header: "<input id='prod' type='checkbox' onclick=checkall(this)>生产环境</input>", width:80, sortable: true, dataIndex: 'refValue',sortable:false,renderer :function(v){
        		if(v.toCharArray()[2]==1){
        		return '<input type="checkbox" id="prod_'+arguments[3]+'" onclick="checkboxClick('+arguments[3]+',2,event,this)"  checked="true"/>';
        		}else{
        		return '<input type="checkbox" id="prod_'+arguments[3]+'" onclick="checkboxClick('+arguments[3]+',2,event,this)"/>';
        		}
        		}},
        		{header: "要素ID", width:100, sortable: true, dataIndex: 'elemId',hidden:true}
        ],
        tbar: [{xtype : "tbfill"},{
         xtype: 'button',
         text : '保存并创建任务',
         style: {
            marginRight: '10px'
        },
        handler:function(){
        	var grid=Ext.getCmp("caseGrid");
        	var store=grid.getStore();
        	var array=store.collect('refValue',true,true);
        	var records = store.getRange();// 获取修改的行的数据，无法获取幻影数据  
     		var phantoms=store.getNewRecords() ;//获得幻影行  
      		records=records.concat(phantoms);//将幻影数据与真实数据合并
        	var isNull=(array.toString().indexOf("1")==-1)?true:false;
        	if(isNull){
        		Ext.Msg.alert('提示','没有选择任何用例！');
        	}else{
        		//console.log(store.data);
        		var data = new Array(); 
			    Ext.Array.each(store.data.items, function(record) {  
                	data.push(record.data);  
                });
			    var form=Ext.getCmp("collectForm");
                MaskLoading();
                form.submit({
		  			clientValidation: true,
		  			url:"<%=request.getContextPath()%>/saveCollection.do",
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
				var treeNode=Ext.getCmp('subTaskTree').getSelectionModel().getSelection();
       			if(treeNode.length==0){
       				Ext.Msg.alert('提示','请选择组件树节点');
         		return;
	         	}
	         	if(treeNode[0].raw.leaf==false){
	         		Ext.Msg.alert('提示','请选择组件树叶子节点');
	         		return;
	         	}
	         	MaskLoading();
                form.submit({
			  		clientValidation: true,
			  		url:"<%=request.getContextPath()%>/saveRunTask.do",
			  		params : {  
                    	table :Ext.encode(data),
                        subTaskId:treeNode[0].raw.id,
                        taskName:treeNode[0].raw.text
                    },
					method:'POST',  
		            success:function(response,config){ 
		                MaskOver();
		                runTaskStore.reload({params:{subTaskId:treeNode[0].raw.id}});
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
        		 /*Ext.Msg.prompt('创建任务', '任务名称', function(btn, text){
				    if (btn == 'ok'){
				    	var grid=Ext.getCmp("caseGrid");
         		 		var radios=Ext.getCmp("environment");
	                    var store=grid.getStore();
						var records = store.getUpdatedRecords();// 获取修改的行的数据，无法获取幻影数据  
		       			var phantoms=store.getNewRecords() ;//获得幻影行  
		        		records=records.concat(phantoms);//将幻影数据与真实数据合并
						var data = new Array(); 
						var taskName = text;
						if(taskName==null||taskName==''){
							Ext.Msg.alert('提示','请填写任务名称');
							return;
						}
		                Ext.Array.each(store.data.items, function(record) {  
		                	data.push(record.data);  
		                });
		                var form=Ext.getCmp("collectForm");
		                MaskLoading();
		                form.submit({
				  			clientValidation: true,
				  			url:"<%=request.getContextPath()%>/saveCollection.do",
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
				  		var treeNode=Ext.getCmp('subTaskTree').getSelectionModel().getSelection();
	         			if(treeNode.length==0){
	         				Ext.Msg.alert('提示','请选择组件树节点');
			         		return;
			         	}
			         	if(treeNode[0].raw.leaf==false){
			         		Ext.Msg.alert('提示','请选择组件树叶子节点');
			         		return;
			         	}
			         	MaskLoading();
		                form.submit({
					  		clientValidation: true,
					  		url:"<%=request.getContextPath()%>/saveRunTask.do",
					  		params : {  
		                    	table :Ext.encode(data),
		                        subTaskId:treeNode[0].raw.id,
		                        taskName:taskName,
		                        environment :radios.getValue().environment
		                    },
					  		method:'POST',  
		                    success:function(response,config){ 
		                MaskOver();
		                    	runTaskStore.reload({params:{subTaskId:treeNode[0].raw.id}});
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
				 });*/
				 
				 
			}
        }] 
		 
	}); 
	
	var runTaskModel = Ext.regModel("runTaskModel",{
		fields:[
			{name:'taskId',type:'string'},
			{name:'taskStatus',type:'string'},
			{name:'subTaskId',type:'string'},
			{name:'taskFlag',type:'string'},
			{name:'taskResult',type:'string'},
			{name:'taskTag',type:'string'},
			{name:'taskName',type:'string'},
			{name:'collectType',type:'string'}]
	});
	
	var runTaskProxy = new Ext.data.proxy.Ajax({
			type:"ajax",
			model:caseModel,
			url:'<%=request.getContextPath()%>/getRunTask.do',
			reader:{
				root:"data",
				type:"json"
			}
		});
	var runTaskStore = Ext.create('Ext.data.Store',{
		model:runTaskModel,
		proxy:runTaskProxy
	});
	runTaskStore.load({params:{subTaskId:"0"}});
	var runTaskGrid = Ext.create('Ext.grid.Panel',{
		id:'runTaskGrid',
        cls: 'ui-formPanel',
		title:'执行任务',
		height: screenHeight*0.48,
	    width: screenWidth*0.8,
		viewConfig:{
			forctFit:true,
			stripeRows:true
		},
		store:runTaskStore,
		listeners:{
			itemdblclick:function(grid,record,item,index,e,eOpts){
				var cell = grid.getSelectionModel().getCurrentPosition();
				var rowIndex = cell.row;
				var colIndex = cell.column;
				showDetail(grid, rowIndex, colIndex);
			}
		},
		columns:[
			new Ext.grid.RowNumberer(),
			{header:"主键",width:100,dataIndex:"taskId",sortable:true,hidden:true},
			{header:"任务编号",width:100,dataIndex:"taskTag",sortable:true},
			{header:"任务名称",width:300,dataIndex:"taskName",sortable:true},
			{header:"任务状态",width:100,dataIndex:"taskStatus",sortable:true,renderer:function(value){if(value=='1')return '任务创建';else if(value=='2')return '执行未完成';else if(value=='3')return '执行完成';else '未知状态';}},
			{header:"子任务",width:100,dataIndex:"subTaskId",sortable:true,hidden:true},
			{header:"任务标示",width:100,dataIndex:"taskFlag",sortable:true,hidden:true},
			{header:"执行结果",width:100,dataIndex:"taskResult",sortable:true,hidden:true},
			{header:"测试环境",width:100,dataIndex:"collectType",sortable:true,renderer:function(value){if(value=='1')return '测试环境'; else if(value=='2')return '准发布环境';else if(value=='3')return '生产环境';else '未知环境';}},
			{header: "操作", width:50,menuDisabled: true,xtype:'actioncolumn',sortable:false,items: [{
				icon:"<%=request.getContextPath()%>/css/images/delete.png",
        			id: 'deleteTask',  
					tooltip: '删除',
					handler:function(grid, rowIndex, colIndex){
						var taskId = grid.getStore().data.items[rowIndex].raw.taskId;
						var status = grid.getStore().data.items[rowIndex].raw.taskStatus;
						/*if(status!='1'){
							Ext.Msg.alert('提示','该执行任务已经执行，不可删除');
							return;
						}*/
						var treeNode=Ext.getCmp('subTaskTree').getSelectionModel().getSelection();
	         			if(treeNode.length==0){
	         				Ext.Msg.alert('提示','请选择组件树节点');
			         		return;
			         	}
			         	if(treeNode[0].raw.leaf==false){
			         		Ext.Msg.alert('提示','请选择组件树叶子节点');
			         		return;
			         	}
			         	MaskLoading();
						Ext.Ajax.request({
							url:'<%=request.getContextPath()%>/deleteTask.do?taskId='+taskId,
							success:function(response,config){
								MaskOver();
								runTaskStore.load({params:{subTaskId:treeNode[0].raw.id}});
							},
							failure:function(response,config){
								MaskOver();
								Ext.Msg.alert('提示','删除失败');
								return;
							}
						});
					}
			},{
        			icon:"<%=request.getContextPath()%>/css/images/add.png",
        			id: 'runTask',  
					tooltip: '运行',  
					handler: function(grid, rowIndex, colIndex) {
						Ext.MessageBox.confirm('提示','确定要运行吗?',function(optional){
							if(optional=='yes'){
								var subTaskId = grid.getStore().data.items[rowIndex].raw.subTaskId;
								var taskId = grid.getStore().data.items[rowIndex].raw.taskId;
								if(taskId==null||taskId==''){
									Ext.Msg.alert('提示','缺失taskId');
									return;
								}
								MaskLoading();
								/*Ext.Ajax.request({   
									url:'<%=request.getContextPath()%>/startTask.do?taskId='+taskId,  
									success:function(response,config){
										MaskOver();
									},
									failure:function(response,config){
										MaskOver();
										Ext.Msg.alert("提示","数据请求失败");
										return;
									}
								});*/
								showDetail(grid, rowIndex, colIndex);
								MaskOver();
							}
						});
					}  
        	}]}]
	});
	
	var subTaskTreeStore = Ext.create('Ext.data.TreeStore', { 
		id:'subTaskTreeStore', 
		proxy: {
			type: "ajax",
			url: "<%=request.getContextPath()%>/getsubTaskTreeSyn.do?staffId=<%=user.getUserId()%>&subTaskStatus="+taskStatus
		},
		root: {
			id:'0',
			text: '测试子任务',
			expanded: true
		},
		reader: { 
			type: 'json', 
			root: 'children' 
		} 
    });
	var subTaskTree = Ext.create('Ext.tree.Panel',{
		id:'subTaskTree',
		title: '测试任务',
        cls: 'ui-formPanel',
		width: screenWidth*0.2,
		rootVisible: true,
		height: screenHeight*0.96,
		store: subTaskTreeStore,
		useArrows: true,
		autoScroll:true,
		viewConfig : {  
			loadingText : "加载数据..."
		},
		animate:true,
        autoScroll:true,
        containerScroll:true,
        frame:false,
        listeners:{
        	itemclick : function(thisView, record, htmlElementItem, indexNo){
        		var leaf = record.raw.leaf;
        		if(leaf==true){
        			var subTaskId = record.raw.id;
        			gridStore.load({params:{subTaskId:subTaskId}});
        			runTaskStore.load({params:{subTaskId:subTaskId}});
        		}
        	}
        },
        tbar: [
               {xtype : "tbfill"},
               testTaskStatusCombox] 
	});

	Ext.create('Ext.form.Panel', {
			id:"collectForm",
        	cls: 'ui-formPanel',
			renderTo : Ext.getBody(),
			width : screenWidth*0.99,
			height : screenHeight*0.96,
			layout : 'border',
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

			items : [{
				region : 'west',
				items : [subTaskTree]
			},{
				region : 'center',
				items : [caseGrid,runTaskGrid]
			}]
		});
	});
	
	function showDetail(grid, rowIndex, colIndex){
		var subTaskId = grid.getStore().data.items[rowIndex].raw.subTaskId;
		var taskId = grid.getStore().data.items[rowIndex].raw.taskId;
		if(taskId==null||taskId==''){
			Ext.Msg.alert('提示','缺失taskId');
			return;
		}
		
		var runResult = new Ext.data.Store({
			 	autoLoad: true,
			 	id: 'runResult',
			    fields: ['other1','show'],
			    proxy: {
			    	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=runResult'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			    }
			});
		runResult.load();
		var runModel = Ext.regModel("runModel",{
			fields:[
				{name:'runId',type:'string'},
				{name:'taskId',type:'string'},
				{name:'caseId',type:'string'},
				{name:'runResult',type:'string'},
				{name:'runTime',type:'string'},
				{name:'caseName',type:'string'},
				{name:'hasTest',type:'string'},
				{name:'casePreCond',type:'string'},
				{name:'caseOperateInst',type:'string'},
				{name:'preResult',type:'string'},
				{name:'relaResult',type:'string'},
				{name:'caseOrder',type:'int'},
				{name:'status',type:'string'},
				{name:'runInfo',type:'string'},
				{name:'runName',type:'string'}
				]
			});
			var	runStore = Ext.create('Ext.data.Store', {
				storeId:'runStore',
			  	model: runModel,
			    proxy: {
			    	url : '<%=request.getContextPath()%>/getRunResult.do',
			        type: 'ajax',
			        reader: {
			            type: 'json'
			        }
			    }
			});
			runStore.load({params:{subTaskId:subTaskId,taskId:taskId}});
			var runInfoModel= Ext.regModel("runInfoModel",{
			fields:[
				{name:'result',type:'string'},
				{name:'stepName',type:'string'},
				{name:'runInfo',type:'string'},
				{name:'runObj',type:'object'},
				{name:'runTime',type:'dateTime'},
				{name:'actualValue',type:'string'},
				{name:'expectValue',type:'string'}
				]
			});
			var runInfoStore= Ext.create('Ext.data.Store', {
				storeId:'runInfoStore',
				model: runInfoModel
			});
			 
			var runGrid = top.Ext.create('Ext.grid.Panel',{
				tbar:top.Ext.create('Ext.Toolbar',{
					items:[{
						text:'刷新',
						handler:function(){
							runStore.reload({params:{subTaskId:subTaskId,taskId:taskId}});
							top.Ext.getCmp("addValue").disable();
						}
					},{
						xtype: "combo",
					    id: "addValue",
					    width: 200,
					    labelWidth: 120,
					    store: runResult,
					    name: "addResultValue",
					    fieldLabel: "批量设置执行结果",
					    valueField: 'other1',
					    displayField: 'show',
					    disabled:true,
					    listeners:{
						    change:function(e,newValue,oldValue,opts){
								var grid=top.Ext.getCmp('runGrid');
								var rs=grid.getSelectionModel().getSelection();
								if(rs.length>0){
									Ext.each(rs,function(item,index,arrs){
										item.set("runResult",newValue);
									});
								}
								top.Ext.getCmp("addValue").disable();
								grid.getSelectionModel().deselectAll(true);
								
							}
					    }
					},{text:'保存',
						handler:function(){
							var runStore=Ext.data.StoreManager.lookup('runStore');
							var updateStore=runStore.getUpdatedRecords();
							var data = new Array(); 
						    Ext.Array.each(updateStore, function(record) {
						    	data.push(record.data);  
						  	});
						  	MaskLoading();
						  	Ext.Ajax.request({ 
								async:false,
								method:'POST',
								url:"<%=request.getContextPath()%>/saveRunResult.do",
								params : {table :Ext.encode(data)},
								success:function(response,config){
									MaskOver();
									var returnData=Ext.decode(response.responseText,true);
									if(returnData.success){
										top.Ext.Msg.confirm('提示',returnData.message,function(optional){
											if(optional=='yes')	window.location.reload();
										});
									}
									top.Ext.Msg.alert('提示','保存成功');
									top.Ext.getCmp("addValue").disable();
									runStore.reload({params:{subTaskId:subTaskId,taskId:taskId}});
									return;
								},
								failure:function(response,config){
									MaskOver();
									top.Ext.Msg.alert('提示','保存失败');
								}
							});
						}
					}]
				}),
				id:'runGrid',
  				cls: 'ui-formPanel',
				title:'用例执行',
		        margins : '0 0 0 3',
		        width:screenWidth*0.98,
		        height:screenHeight*0.7,
		        autoScroll: true,
				forctFit:true,
		        stripeRows:true,//斑马线效果   
		        loadMask:true,
		        selModel:top.Ext.create('Ext.selection.CheckboxModel',{mode:"SIMPLE"}),//CheckboxModel RowModel
		        plugins:[
					top.Ext.create('Ext.grid.plugin.CellEditing', {clicksToEdit: 1})
					],
				listeners:{
					itemclick:function(grid,record,item,index,e,eOpts){
						var cell = grid.getSelectionModel().getCurrentPosition();
						var rs=grid.getSelectionModel().getSelection();
						var combox = top.Ext.getCmp("addValue");
						if(rs.length>0){
							combox.enable();
						}else{
							combox.disable();
						}
					},
					beforeedit : function(editor, e) {
				        if(e.field== "runResult"||e.field=="relaResult"){
				            return true;
				        }else{
				            return false;
				        }
				    },
				    beforedeselect : function (rowModel,record,index,eOpts){
				    	
				    },
				    beforeselect : function (rowModel,record,index,eOpts){
				    	//console.log(index);
				    	top.Ext.getCmp("addValue").enable();
				    }
				},
				selType:'rowmodel',
				store:Ext.data.StoreManager.lookup('runStore'),
				columnLines: true, 
				columns:[new top.Ext.grid.RowNumberer(),
						{header: "执行ID", width:100, sortable: true, dataIndex: 'runId',hidden:true},
						{header: "任务ID", width:100, sortable: true, dataIndex: 'taskId',hidden:true},
						{header: "用例名称", width:200, sortable: true, dataIndex: 'caseName'},
						{header: '执行结果',width: 100,dataIndex: 'runResult',sortable: true,
						
		        			editor: new top.Ext.form.ComboBox({
		        				displayField:'show', 
		        				valueField:'other1',
		        				store: runResult,
		        				listeners:{
			        				blur:function(e,obj,opts){
			        					var grid = top.Ext.getCmp('runGrid');
										var rs=grid.getSelectionModel().getSelection();
										if(rs.length>0){
											top.Ext.getCmp("addValue").disable();
											grid.getSelectionModel().deselectAll(true);
										}
			        				},focus:function(e,obj,opts){
										top.Ext.getCmp("addValue").disable();
			        				}
			        				
		        				}
		        			}),
				    		renderer:function(value){
				    			var rec = Ext.StoreMgr.get('runResult').find('other1',value);
				    			if(rec == -1) {
				    				return "<font color=orange>未执行</font>";
				    			}
				    			if(value=="1"){
				    				return "<font style='color:green'>"+Ext.StoreMgr.get('runResult').getAt(rec).raw.show+"</font>";
				    			}else if(value=="2"){
				    				return "<font style='color:red'>"+Ext.StoreMgr.get('runResult').getAt(rec).raw.show+"</font>";
				    			}else{
				    				return "<font style='color:orange'>"+Ext.StoreMgr.get('runResult').getAt(rec).raw.show+"</font>";
				    			}
				    		}
		        		},
		        		{header: "实际结果", width:200,sortable: true, dataIndex: 'relaResult',
		        			editor:{xtype:'textfield',
		        				listeners:{
			        				blur:function(e,obj,opts){
											top.Ext.getCmp("addValue").disable();
			        				},focus:function(e,obj,opts){
										top.Ext.getCmp("addValue").disable();
			        				}
		        				}
		        			}
		        		},
		        		{header: "执行信息", width:100,sortable: true, dataIndex: 'runInfo',hidden:true},
		        		{header: "用例前置条件", width:200,sortable: true, dataIndex: 'casePreCond'},
		        		{header: "用例操作说明", width:200,sortable: true, dataIndex: 'caseOperateInst',
		        			renderer:function(value,data,record,colIndex,store,view){
		        				return "<div data-qtip='"+value+"'>"+value+"</div>";
		        			}
		        		},
		        		{header: "预期结果", width:200,sortable: true, dataIndex: 'preResult'
		        			,renderer:function(value,data,record,colIndex,store,view){
		        				//tipValue=value.replace("<","&lt;").replace(">","&gt;");
		        				//var tipValue=value;
		        				//console.log(value);
		        				//value2 = Ext.util.Format.htmlDecode(value);
		        				return "<div data-qtip='"+  Ext.String.htmlEncode(Ext.util.Format.htmlEncode(value)) +"'>"+ Ext.util.Format.htmlEncode(value)+"</div>";
		        			}
		        		},
		        		{header: "执行时间", width:200,sortable: true, dataIndex: 'runTime',hidden:true}
		        ]
			});
			
	        var taskWin = new top.Ext.window.Window({
				id:'taskWin',
				title : '任务运行',
				width : 1000,
				height : screenHeight*0.8,
				autoScroll: true,
				resizable:false,
				modal : true,
				constrain : true,
				closeAction : 'destroy',
				items:[runGrid]
			}).show();
			taskWin.on("close",function(panel,opts){
				var subTaskId=Ext.getCmp('runTaskGrid').getStore().data.get(0).get("subTaskId");
				Ext.getCmp('runTaskGrid').getStore().reload({params:{subTaskId:subTaskId}});
		    });
			
	}

	</script>
</html>