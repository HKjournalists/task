<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>

<html>
  <head>
	<title>自动化测试任务</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ie-tab.css"> 
	<body id="caseBody">
	</body>
	<script type="text/javascript">
	var screenWidth = document.documentElement.clientWidth - 20;
	var screenHeight = document.documentElement.clientHeight - 10;
	Ext.onReady(function(){
		var testCaseModel = Ext.regModel("testCaseModel",{
			fields:[
				{name:'caseId',type:'string'},
				{name:'caseName',type:'string'},
				{name:'secId',type:'string'},
				{name:'casePreCond',type:'string'},
				{name:'caseOperateInst',type:'string'},
				{name:'preResult',type:'string'},
				{name:'hasTest',type:'string'}
			]
		});
		var testCaseProxy = new Ext.data.proxy.Ajax({
			type:"ajax",
			model : testCaseModel,
			url:'<%=request.getContextPath()%>/getCaseTableForSeceneRela.do',
			reader:{
				root:"data",
				type:"json"
			}
		});
		var caseLoadMasker = new masker('正在加载用例信息，请稍后');
		var testCaseStore = Ext.create('Ext.data.Store',{
			model : testCaseModel,
			proxy : testCaseProxy,
			listeners:{
				beforeload:function(){
					caseLoadMasker.show();
				},
				load:function(){
					caseLoadMasker.hide();
				}
			}
		});
	
	
	});
	var autoTestCaseGrid = Ext.create('Ext.grid.Panel',{
		id:'autoTestCase',
        cls: 'ui-formPanel',
        renderTo: Ext.get("caseBody"),
        margins : '0 0 0 3',
		height: screenHeight*0.78*0.99,
		width: screenWidth*0.98,
        title: '手工用例单',
        bbar: Ext.create('Ext.PagingToolbar', { 
			//store: solidTaskStore, 
			displayInfo: true, 
			displayMsg: '显示 {0} - {1} 条，共计 {2} 条', 
			emptyMsg: "没有数据"
		}),
		forctFit:true,
        stripeRows:true,
		store: testCaseStore,
		selType:'rowmodel'
		
		
		
		
	});
	
	</script>
</html>
