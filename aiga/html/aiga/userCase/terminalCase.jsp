<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<html>
	<head>
		<title>端到端用例集</title>
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
function changeIndexValue(string,index){

var sub="";
sub=string.substring(0,index);

if(string.substring(index,index+1)=="1"){
sub+="0";
}else{
sub+="1";
}

sub+=string.substring(index+1);

return sub.toString();
}
//将字符串转换为数组
String.prototype.toCharArray=function(){
 var c = new Array();
 for(var i=0;i<this.length;i++){
  c[i] = this.substr(i,1);
 } 
 return c;
};
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
Ext.onReady(function() {
Ext.QuickTips.init();
//tooltip初始化
Ext.tip.QuickTipManager.init();
	var caseModel = Ext.regModel("caseModel",{
	fields:[
		{name:'caseId',type:'string'},
		{name:'caseName',type:'string'},
		{name:'parentId',type:'string'},
		{name:'caseDesc',type:'string'},
		{name:'createTime',type:'string'},
		{name:'updateTime',type:'string'},
		{name:'author',type:'string'},
		{name:'latestOperator',type:'string'},
		{name:'elemId',type:'string'},
		{name:'refValue',type:'string'},
		{name:'elemTag',type:'string'},
		{name:'caseType',type:'string'},
		{name:'refId',type:'string'},
		{name:'caseOrder',type:'string'}
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
	gridStore.load({params:{subTaskId:"1"}});
	gridStore.sort('caseOrder', 'ASC');
	var caseGrid = Ext.create('Ext.grid.Panel',{
		id:'caseGrid',
        cls: 'ui-formPanel',
		title:'选择用例',
        margins : '0 0 0 3',
        height:300,
       //tbar:tbar,
        whith:screenWidth*0.98,
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
		columns:[
				{header: "用例ID", width:100, sortable: true, dataIndex: 'caseId',hidden:true},
				{header: "用例名称", width:100, sortable: true, dataIndex: 'caseName'},
				{header: "父ID", width:100, sortable: true, dataIndex: 'parentId',hidden:true},
				{header: "用例描述", width:100, sortable: true, dataIndex: 'caseDesc'},
        		{header: "创建时间", width:100,sortable: true, dataIndex: 'createTime'},
        		{header: "修改时间", width:100, sortable: true, dataIndex: 'updateTime'},
        		{header: "作者", width:100, sortable: true, dataIndex: 'author'},
        		{header: "最后修改人", width:100, sortable: true, dataIndex: 'latestOperator'},
        		{header: "用例类型", width:100, sortable: true, dataIndex: 'caseType',renderer:function(value){if(value=='1')return '自动化';else if(value=='2')return '手工';}},
        		{header: "测试环境", width:60, sortable: true, dataIndex: 'refValue',sortable:false,hidden:true,renderer :function(v){
        		if(v.toCharArray()[0]==1){
        		return '<input type="checkbox"  checked="true" onclick="checkboxClick('+arguments[3]+',0,event,this)" "/>';
        		}else{
        		return '<input type="checkbox" onclick="checkboxClick('+arguments[3]+',0,event,this)" "/>';
        		}
        		}},
        		{header: "准发布环境", width:70, sortable: true, dataIndex: 'refValue',sortable:false,renderer :function(v){
        		if(v.toCharArray()[1]==1){
        		return '<input type="checkbox"  checked="true" onclick="checkboxClick('+arguments[3]+',1,event,this)"/>';
        		}else{
        		return '<input type="checkbox" onclick="checkboxClick('+arguments[3]+',1,event,this)" />';
        		}
        		}},
        		{header: "生产环境", width:60, sortable: true, dataIndex: 'refValue',sortable:false,renderer :function(v){
        		if(v.toCharArray()[2]==1){
        		return '<input type="checkbox" onclick="checkboxClick('+arguments[3]+',2,event,this)"  checked="true"/>';
        		}else{
        		return '<input type="checkbox" onclick="checkboxClick('+arguments[3]+',2,event,this)"/>';
        		}
        		}},
        		{header: "要素ID", width:100, sortable: true, dataIndex: 'elemId',hidden:true}
        ],
        dockedItems: [{ 
            dock: 'top',
            xtype: 'toolbar',  
            items: [{
            id : "environment",
            xtype      : 'radiogroup',
            fieldLabel : '测试用例集查询',
            columns:4,
            width:500,
            listeners:{
            change:function(group, newValue, oldValue){
            if (typeof newValue.environment == 'string'){
            var grid=Ext.getCmp("caseGrid");
            grid.getStore().clearFilter(true);
            //console.log(radios[newValue.environment]);
			grid.getStore().filter("refValue",radios[newValue.environment]);
            }
			
            }
            },
            items: [{
                    boxLabel  : '所有',
                    name      : 'environment',
                    inputValue: '0',
                    id        : 'all',
                    width:50,
                    checked: true
                }, {
                    boxLabel  : '准发布环境',
                    name      : 'environment',
                    inputValue: '2',
                    width:100,
                    id        : 'release'
                }, {
                    boxLabel  : '生产环境',
                    name      : 'environment',
                    inputValue: '3',
                    width:100,
                    id        : 'production'
                }
            ]
           
        },"-",{
         xtype: 'button',
         text : '保存并创建任务',
         style: {
            marginRight: '10px'
        },
        handler:function(){
        		if(gridStore.data.items.length==0){
        			Ext.Msg.alert('提示','请在所有环境下选择该环境下的用例');
        			return;
        		}
        		if(Ext.getCmp("environment").getValue().environment==0){
        			Ext.Msg.alert('提示','不可以在所有环境下创建测试任务');
        			return;
        		}
        		
        		 Ext.Msg.prompt('创建任务', '任务名称', function(btn, text){
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
		                MaskLoading();
		                form.submit({
					  		clientValidation: true,
					  		url:"<%=request.getContextPath()%>/saveRunTask.do",
					  		params : {  
		                    	table :Ext.encode(data),
		                        subTaskId:"1",
		                        taskName:taskName,
		                        environment :radios.getValue().environment
		                    },
					  		method:'POST',  
		                    success:function(response,config){
		                MaskOver();
		                    	runTaskStore.reload({params:{subTaskId:"1"}});
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
				 });
			}
        }] 
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
	runTaskStore.load({params:{subTaskId:"1"}});
	var runTaskGrid = Ext.create('Ext.grid.Panel',{
		id:'runTaskGrid',
        cls: 'ui-formPanel',
		title:'执行任务',
		height: 260,
	    width: screenWidth,
		viewConfig:{
			forctFit:true,
			stripeRows:true
		},
		store:runTaskStore,
		columns:[
			new Ext.grid.RowNumberer(),
			{header:"主键",width:100,dataIndex:"taskId",sortable:true,hidden:true},
			{header:"任务编号",width:100,dataIndex:"taskTag",sortable:true},
			{header:"任务名称",width:100,dataIndex:"taskName",sortable:true},
			{header:"任务状态",width:100,dataIndex:"taskStatus",sortable:true,renderer:function(value){if(value=='1')return '任务创建';else if(value=='2')return '任务等待执行';else if(value=='21')return '用例发送中';else if(value=='22')return '用例发送成功';else if(value=='3')return '执行完成';else if(value=='5')return '执行失败';else '未知状态';}},
			{header:"子任务",width:100,dataIndex:"subTaskId",sortable:true,hidden:true},
			{header:"任务标示",width:100,dataIndex:"taskFlag",sortable:true,hidden:true},
			{header:"执行结果",width:100,dataIndex:"taskResult",sortable:true},
			{header:"测试环境",width:100,dataIndex:"collectType",sortable:true,renderer:function(value){if(value=='1')return '测试环境'; else if(value=='2')return '准发布环境';else if(value=='3')return '生产环境';else '未知环境';}},
			{header: "操作", width:50,menuDisabled: true,xtype:'actioncolumn',sortable:false,items: [{
				icon:"<%=request.getContextPath()%>/css/images/delete.png",
        			id: 'deleteTask',  
					tooltip: '删除',
					handler:function(grid, rowIndex, colIndex){
						var taskId = grid.getStore().data.items[rowIndex].raw.taskId;
						var status = grid.getStore().data.items[rowIndex].raw.taskStatus;
						if(status!='1'){
							Ext.Msg.alert('提示','该执行任务已经执行，不可删除');
							return;
						}
						MaskLoading();
						Ext.Ajax.request({
							url:'<%=request.getContextPath()%>/deleteTask.do?taskId='+taskId,
							success:function(response,config){
								MaskOver();
								runTaskStore.load({params:{subTaskId:"1"}});
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
								Ext.Ajax.request({   
									url:'<%=request.getContextPath()%>/startTask.do?taskId='+taskId,  
									success:function(response,config){
										MaskOver();
										var json=Ext.JSON.decode(response.responseText);
									},
									failure:function(response,config){
										MaskOver();
										Ext.Msg.alert("提示","数据请求失败");
										return;
									}
								});
								var runModel = Ext.regModel("runModel",{
									fields:[
										{name:'runId',type:'string'},
										{name:'taskId',type:'string'},
										{name:'caseId',type:'string'},
										{name:'runResult',type:'string'},
										{name:'runTime',type:'string'},
										{name:'caseName',type:'string'},
										{name:'caseType',type:'string'}
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
									 
									runStore.load({params:{subTaskId:subTaskId,taskId:taskId}});
									var runInfoGrid = Ext.create('Ext.grid.Panel', {
										store: runInfoStore,
        								cls: 'ui-formPanel',
										selModel: {
											selType: 'cellmodel'
										},
										columns: [
											{ text: "步骤",width:200, dataIndex: 'stepName'},
											{ text: "实际结果",width:100, dataIndex: 'actualValue'},
											{ text: "预期结果",width:100, dataIndex: 'expectValue'},
											{ text: "结果",width:150, dataIndex: 'result'}
										],
										columnLines: true,
										autoWidth: true,
										autoHeight: true,
										width: 600,
										height: 300,
										frame: false
									});
									var editWin = new Ext.window.Window({
										id:'editWin',
										title : '执行步骤',
										width : 600,
										height : 300,
										autoScroll: true,
										resizable:false,
										modal : true,
										closeAction : 'destroy',
										items:[runInfoGrid]
									});
									var runGrid = Ext.create('Ext.grid.Panel',{
										tbar:Ext.create('Ext.Toolbar',{
											items:[{
												text:'刷新',
												handler:function(){
													runStore.reload({params:{subTaskId:subTaskId,taskId:taskId}});
												}
											}]
										}),
										id:'runGrid',
        								cls: 'ui-formPanel',
										title:'用例执行',
								        margins : '0 0 0 3',
								        width:screenWidth*0.98,
								        height:screenHeight,
								        autoScroll: true,
										forctFit:true,
								        stripeRows:true,//斑马线效果   
								        loadMask:true,
										listeners:{
											itemdblclick:function(grid,record,item,index,e,eOpts){
												var runId = record.raw.runId;
												if(record.raw.caseType==1){
													var runObj=record.raw.runObj;
													var store=Ext.data.StoreManager.lookup("runInfoStore");
													if(runObj==null){
														Ext.Msg.alert("提示","当前用例未执行!");
														return;
													}
													store.removeAll();
													for(var i=0,n=runObj.length;i<n;i++){
														var data={stepName:"",result:"",actualValue:"",expectValue:""};
														//console.log(runObj);
														if(runObj[i].aigaLogElements.length==1){
															//console.log(runObj[i].aigaLogElements[0].actualValue);
															data.actualValue=runObj[i].aigaLogElements[0].actualValue;
															data.expectValue=runObj[i].aigaLogElements[0].expectValue;
														}
														
														data.stepName=runObj[i].stepName;
														if(runObj[i].result=='finished'){
															data.result="<font color='green'>执行完成</font>";
														}else if(runObj[i].result=='unfinish'){
															data.result="<font color='orange'>未完成<font color='green'>";
														}else if(runObj[i].result=='unRun'){
															data.result="<font color='black'>未执行</font>";
														}else if(runObj[i].result=='fail'){
															data.result="<font color='red'>失败</font>";
														}else if(runObj[i].result=='success'){
															data.result="<font color='green'>成功</font>";
														}else{
															data.result="<font color='red'>失败</font>";
														}
														//console.log(data);
														store.add(data);
													}
													editWin.show();
												}else if(record.raw.caseType==2){
													var manualTaskModel = Ext.regModel("manualTaskModel",{
														fields:[
															{name:'taskId',type:'string'},
															{name:'taskName',type:'string'},
															{name:'taskDesc',type:'string'},
															{name:'createTime',type:'string'},
															{name:'updateTime',type:'string'},
															{name:'preResult',type:'string'},
															{name:'preTestData',type:'string'},
															{name:'caseId',type:'string'},
															{name:'describe',type:'string'},
															{name:'actualResult',type:'string'},
															{name:'taskOrder',type:'string'}]
													});
													var manualTaskStore = Ext.create('Ext.data.Store', {
													  	model: manualTaskModel,
													  	proxy: {
													    	url : '<%=request.getContextPath()%>/getManualTask.do',
													        type: 'ajax',
													        reader: {
													            type: 'json',
													            root: 'data'
													        }
													    }
													});
													manualTaskStore.load({params:{caseId:record.raw.caseId}});
													var manualTaskGrid = Ext.create('Ext.grid.Panel',{
														tbar:Ext.create('Ext.Toolbar',{
															items:[{
																text:'保存',
																handler:function(){
																	var runResult = Ext.getCmp('runResult').getValue();
																	var runTime = Ext.getCmp('runTime').getValue();
																	if(runTime!=null||runTime!='')
																		runTime = Ext.util.Format.date(runTime,'Y-m-d H:m:s');
																	var actualResult = Ext.getCmp("actualResult").getForm().findField('actualResult').getValue();
																	var preResult = Ext.getCmp("preResultForm").getForm().findField('preResult').getValue();
																	var preTestData = Ext.getCmp("preTestDataForm").getForm().findField('preTestData').getValue();
																	var taskGridSelection = manualTaskGrid.getSelectionModel().getSelection();
																	if(taskGridSelection.length!=1){
																		Ext.Msg.alert('提示','请选择要执行的用例步骤');
																		return;
																	}
																	var manualtaskId = taskGridSelection[0].raw.taskId;
																	if(taskId==null||taskId==''){
																		Ext.Msg.alert('提示','缺失任务编号');
																		return;
																	}
																	if(runId==null||runId==''){
																		Ext.Msg.alert('提示','缺失运行编号');
																		return;
																	}
																	var stepName = taskGridSelection[0].raw.taskName;
																	MaskLoading();
																	Ext.Ajax.request({   
																		url:'<%=request.getContextPath()%>/saveRunManual.do?',  
																		params:{taskId:taskId,manualtaskId:manualtaskId,runId:runId,actualResult:actualResult,preResult:preResult,preTestData:preTestData,runResult:runResult,runTime:runTime,caseId:record.raw.caseId,stepName:stepName},
																		success:function(response,config){ 
																			MaskOver();
																			manualTaskStore.reload({params:{caseId:record.raw.caseId}});
																			runStore.reload({params:{subTaskId:subTaskId,taskId:taskId}});
																			Ext.getCmp("actualResult").getForm().findField('actualResult').setValue('');
																			Ext.getCmp("preResultForm").getForm().findField('preResult').setValue('');
																			Ext.getCmp("preTestDataForm").getForm().findField('preTestData').setValue('');
																		}, 
																        failure:function(){   
																        	MaskOver();
																			Ext.Msg.alert('提示','保存失败');
																        }   
																    });    	
																}
															},'-',{
																xtype:'combo',
																id:'runResult',
											                    fieldLabel: '执行结果',
											                    allowBlank: false,
											                    displayField:'text',
		           												valueField:'value',
											                    store:Ext.create('Ext.data.Store', {
																    fields:['value','text'],
														            data:[
														            	{'value':'unfinish','text':'未完成'},
														            	{'value':'fail','text':'未通过'},
														            	{'value':'success','text':'通过'}
														            ]
																})
															},{
																xtype:'datefield',
																id: 'runTime', 
											                    fieldLabel: '执行时间',
											                    allowBlank: false,
											                    value:record.raw.runTime
															}]
														}),
														id:'manualTaskGrid',
        												cls: 'ui-formPanel',
														title:'用例步骤',
												        height:150,
												        width:798,
														forctFit:true,
												        stripeRows:true,
												        loadMask:true, 
														viewConfig:{
													        forctFit:true,
															stripeRows:true
														},
														listeners:{
															itemclick:function(grid,record,item,index,e,eOpts){
																var runRecords = runGrid.getStore().data.items;
																var runRecord = null;
																for(var i=0,n=runRecords.length;i<n;i++){
																	if(runId==runRecords[i].raw.runId){
																		runRecord = runRecords[i];
																		break;
																	}
																}
																if(runRecord==null){
																	Ext.Msg.alert('提示','未找到选择运行项');
																	return;
																}
																var runObj = runRecord.raw.runObj;
																for(var i=0,n=runObj.length;i<n;i++){
																	if(runObj[i].manualTaskId==record.raw.taskId){
																		runResult = runObj[i].result;
																		break;
																	}
																}
																var preTestData = record.raw.preTestData;
																var preResult = record.raw.preResult;
																var actualResult = record.raw.actualResult;
																Ext.getCmp('runResult').setValue(runResult);
																preResultForm.getForm().findField('preResult').setValue(preResult);
																preTestDataForm.getForm().findField('preTestData').setValue(preTestData);
																Ext.getCmp('actualResult').getForm().findField('actualResult').setValue(actualResult);
															}
														},
														store:manualTaskStore,
														selType:'cellmodel',
														columns:[new Ext.grid.RowNumberer(),
																{header: "步骤ID", width:100, sortable: true, dataIndex: 'taskId',hidden:true},
																{header: "步骤名称", width:200, sortable: true, dataIndex: 'taskName'},
												        		{header: "测试操作步骤", width:300,sortable: true, dataIndex: 'taskDesc'},
												        		{header: "预期", width:300, sortable: true, dataIndex: 'preResult'},
												        		{header: "测试数据准备", width:300, sortable: true, dataIndex: 'preTestData'},
												        		{header: "实际结果", width:100, sortable: true, dataIndex: 'actualResult'},
												        		{header: "步骤描述", width:300, sortable: true, dataIndex: 'describe'}]
													});
													var actualResult = Ext.create('Ext.form.Panel',{
														id:'actualResult',
        												cls: 'ui-formPanel',
														title:'实际结果',
														width:798,
														height:150,
														layout:{ 
															type: 'vbox'
														}, 
														bodyBorder: 0, 
														fieldDefaults: { 
															labelAlign: 'right', 
															labelWidth: 60, 
															labelStyle: 'font-weight:bold' 
														}, 
														defaults: { 
															margins: '0 0 0 0' 
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
														    	width:798,
														    	height:210,
														    	xtype: "textareafield",
														    	name:"actualResult"
														    }] 
														 }]
													});
													var preResultForm = Ext.create('Ext.form.Panel',{
														id:'preResultForm',
        												cls: 'ui-formPanel',
														title:'预计结果',
														width:399,
														height:150,
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
															margins: '0 0 0 0' 
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
														    	width:399,
														    	height:210,
														    	xtype: "textareafield",
														    	name:"preResult"
														    }] 
														 }]
													});
													var preTestDataForm = Ext.create('Ext.form.Panel',{
														id:'preTestDataForm',
        												cls: 'ui-formPanel',
														title:'预备测试数据',
														width:399,
														height:150,
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
															margins: '0 0 0 0' 
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
														    	width:399,
														    	height:210,
														    	xtype: "textareafield",
														    	name:"preTestData"
														    }] 
														 }]
													});
													var manualPanel = Ext.create('Ext.panel.Panel',{
														width : 800,
														height : 500,
        												cls: 'ui-formPanel',
														layout : 'border',
														layout : {
															type : 'vbox',
															align : 'stretch',
															padding : 0
														},
														defaults : {
															split : true,
															collapsible : false,
															bodyStyle : 'padding:0px'
														},
														items : [{
															region : 'north',
															items:[manualTaskGrid,actualResult]
														},{
															region : 'center',
															layout : {
																type : 'hbox',
																align : 'stretch',
																padding : 0
															},
															items : [preResultForm,preTestDataForm]
														}]
													});
													var runManualWin = new Ext.window.Window({
														id:'runManualWin',
														title : '手工用例执行',
														width : 800,
														height : 500,
														autoScroll: true,
														resizable:false,
														modal : true,
														closeAction : 'destroy',
														items:[manualPanel]
													}).show();
												}else{
													Ext.Msg.alert('提示','未知用例类型');
													return;
												}
											}
										},
										selType:'rowmodel',
										store:Ext.data.StoreManager.lookup('runStore'),
										columnLines: true, 
										columns:[new Ext.grid.RowNumberer(),
												{header: "执行ID", width:100, sortable: true, dataIndex: 'runId'},
												{header: "任务ID", width:100, sortable: true, dataIndex: 'taskId',hidden:true},
												{header: "用例名称", width:200, sortable: true, dataIndex: 'caseName'},
												{header: "用例类型", width:100, sortable: true, dataIndex: 'caseType',renderer:function(value){if(value=='1')return '自动化';else if(value=='2')return '手工';else '未知类型';}},
												{header: "执行结果", width:100, sortable: true, dataIndex: 'runResult'},
								        		{header: "执行时间", width:200,sortable: true, dataIndex: 'runTime'},
								        		{header: "执行信息", width:100,sortable: true, dataIndex: 'runInfo',hidden:true}
								        ]
									});
							        var taskWin = new Ext.window.Window({
										id:'taskWin',
										title : '任务运行',
										width : 1000,
										height : 550,
										autoScroll: true,
										resizable:false,
										modal : true,
										closeAction : 'destroy',
										items:[runGrid]
									}).show();
							}
						});
					}  
        	}]}]
	});

	var collectForm = Ext.create('Ext.form.Panel', {
			id:"collectForm",
        	cls: 'ui-formPanel',
        	title:'端到端用例集',
			width : screenWidth*0.99,
			height : screenHeight*0.99,
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

			items : [  {
				region : 'center',
				items : [caseGrid,runTaskGrid]
			} ]
		});
		
		var terminalCaseGrid = Ext.create('Ext.grid.Panel',{
		id:'terminalCaseGrid',
        cls: 'ui-formPanel',
		title:'端到端用例',
        margins : '0 0 0 3',
        height:300,
       //tbar:tbar,
        whith:screenWidth,
		forctFit:true,
        stripeRows:true,//斑马线效果   
        loadMask:true,
		store:Ext.data.StoreManager.lookup('caseStore'),
		viewConfig:{
			plugins: [{
		        ptype: 'gridviewdragdrop',
		        dragGroup: 'caseStore',
		        dropGroup: 'caseStore'
	        }],
			//拖动排序需要配置 enableDragDrop 属性 和 dropConfig属性  
	        enableDragDrop: true,  
	        dropConfig: {
	            appendOnly:true  
	        },
	        forctFit:true,
			stripeRows:true
		},
		selType:'rowmodel',
		columnLines: true, 
		columns:[
				{header: "用例ID", width:100, sortable: true, dataIndex: 'caseId',hidden:true},
				{header: "用例名称", width:100, sortable: true, dataIndex: 'caseName'},
				{header: "父ID", width:100, sortable: true, dataIndex: 'parentId',hidden:true},
				{header: "用例描述", width:100, sortable: true, dataIndex: 'caseDesc'},
        		{header: "创建时间", width:100,sortable: true, dataIndex: 'createTime'},
        		{header: "修改时间", width:100, sortable: true, dataIndex: 'updateTime'},
        		{header: "作者", width:100, sortable: true, dataIndex: 'author'},
        		{header: "最后修改人", width:100, sortable: true, dataIndex: 'latestOperator'},
        		{header: "用例类型", width:100, sortable: true, dataIndex: 'caseType',renderer:function(value){if(value=='1')return '自动化';else if(value=='2')return '手工';}},
        		{header: "要素ID", width:100, sortable: true, dataIndex: 'elemId',hidden:true}
        ],
        dockedItems: [{ 
            dock: 'top',
            xtype: 'toolbar',  
            items: [{ 
                id: 'save',
                text:'保存',
                tooltip:'保存用例顺序',
                icon:'<%=request.getContextPath()%>/aiga/userCase/image/add.gif',
                listeners:{
                	click:function(){
	                	var list = new Array();
	                	Ext.Array.each(terminalCaseGrid.getStore().data.items,function(record){
	                		list.push(record.raw.elemTag+":"+record.raw.caseId);
	                	});
	                	MaskLoading();
	                	Ext.Ajax.request({
	                		url:'<%=request.getContextPath()%>/saveCaseOrder.do',
	                		params:{caseElemIds:list.join(",")},
	                		success:function(response,config){
	                			MaskOver();
	                			terminalCaseGrid.getStore().reload({params:{subTaskId:"1"}});
	                		},
	                		failure:function(response,config){
	                			MaskOver();
	                			Ext.Msg.alert('提示','保存失败');
	                		}
	                	});
	                }
                }
            }]
        }]
    	});
		
		var tabs = new Ext.TabPanel({
			id: 'collectTab',
			width: screenWidth,
			frame: true,
			height: screenHeight,
			renderTo: Ext.getBody(),
			activeTab: 0,
			items: [terminalCaseGrid,collectForm],
			listeners:{
				tabchange:function( tabPanel, newCard, oldCard, eOpts ){
					if(tabPanel.activeTab.id=='terminalCaseGrid')
						Ext.getCmp('all').setValue(true);
					else
						Ext.getCmp('save').fireEvent('click',null);
				}
			}
		});
	});

	</script>
</html>