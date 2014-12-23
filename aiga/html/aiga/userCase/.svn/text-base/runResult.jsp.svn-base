<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<html>
	<head>
		<title>执行结果</title>
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
Ext.onReady(function(){
Ext.QuickTips.init();
//tooltip初始化
Ext.tip.QuickTipManager.init();
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
	runStore = Ext.create('Ext.data.Store', {
		storeId:'runStore',
	  	model: runModel,
	    proxy: {
	    	url : '<%=request.getContextPath()%>/getRunResult.do',
	        type: 'ajax',
	        reader: {
	            type: 'json',
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
	 
	runStore.load();
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
		width : 620,
		height : 350,
		autoScroll: true,
		resizable:false,
		modal : true,
		closeAction : 'hide',
		items:[runInfoGrid]
	});
	var runGrid = Ext.create('Ext.grid.Panel',{
		id:'runGrid',
        cls: 'ui-formPanel',
		title:'执行结果',
        margins : '0 0 0 3',
        width:screenWidth*0.8,
        height:screenHeight,
        autoScroll: true,
		forctFit:true,
        stripeRows:true,//斑马线效果   
        loadMask:true,
		listeners:{
			itemdblclick:function(grid,record,item,index,e,eOpts){
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
	MaskLoading();
	Ext.Ajax.request({   
		url:'<%=request.getContextPath()%>/getTaskTree.do',  
		success:function(response,config){
			MaskOver();
			var json=Ext.JSON.decode(response.responseText);
			var taskTree = Ext.create('Ext.tree.Panel',{
				id:'taskTree',
        		cls: 'ui-formPanel',
				title: '任务',
				width: screenWidth*0.2,
				rootVisible: true,
				height: screenHeight,
				useArrows: true,
				autoScroll:true,
				viewConfig : {  
					loadingText : "加载数据..."
				},
				listeners:{
					itemclick:function(tree,record,item,index,e,eOpts ){
						if(record.raw.leaf==true){
							var taskId = record.raw.value;
							var subTaskId = record.raw.type;
							runStore.reload({params:{subTaskId:subTaskId,taskId:taskId}});
						}
					}
				},
				animate:true,
		        autoScroll:true,
		        containerScroll:true,
		        frame:false,
		        root:json.data.root
			});	
			
			Ext.create('Ext.form.Panel', {
				id:"collectForm",
				renderTo : Ext.getBody(),
				width : screenWidth,
				height : screenHeight,
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
					region: 'west',
					items:[taskTree]
				},{
					region : 'center',
					items : [runGrid]
				} ]
			});	
		}, 
        failure:function(){ 
			MaskOver();
        	Ext.Msg.alert('提示','数据加载出错');
		}   
    });  
});
	</script>
</html>