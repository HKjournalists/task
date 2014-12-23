<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.p2pTest.web.AigaP2PAction"%>
<%@page import="com.asiainfo.aiga.common.helper.CommonHelper"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp"%>
<%
AigaP2PAction.p2pSubTaskTag=request.getParameter("p2pSubTaskTag");

AigaP2PAction.p2pNormalMac=CommonHelper.decodeCN(request.getParameter("p2pNormalMac"));
AigaP2PAction.p2pTemporaryTag=request.getParameter("p2pTemporaryTag");
if(CommonHelper.NaNull(request.getParameter("busiTwoLevelId"))){
	AigaP2PAction.busiTwoLevelId=Integer.valueOf(request.getParameter("busiTwoLevelId"));
}
System.out.println("-------"+AigaP2PAction.p2pSubTaskTag);
System.out.println("-------"+AigaP2PAction.p2pNormalMac);
System.out.println("-------"+AigaP2PAction.p2pTemporaryTag);
request.getSession().setAttribute("p2pSubTaskTag", request.getParameter("subTaskTag"));
request.getSession().setAttribute("p2pNormalMac", CommonHelper.decodeCN(request.getParameter("normalMac")));
request.getSession().setAttribute("p2pTemporaryTag", request.getParameter("TemporaryTag"));
request.getSession().setAttribute("busiTwoLevelId", request.getParameter("busiTwoLevelId"));
%>
<html>
<head>
<title>端到端用例</title>
</head>
<body id="body">
</body>
<style>
</style>
<script type="text/javascript">
	var screenWidth = document.documentElement.clientWidth - 20;
	var screenHeight = document.documentElement.clientHeight - 10;
	var busiOneLevelId = ${param.busiOneLevelId};
	var busiTwoLevelId = ${param.busiTwoLevelId};
	Ext.onReady(function(){
		Ext.QuickTips.init();
		Ext.tip.QuickTipManager.init();
		var maskerWithHtmlEl = function(htmlEl,msg){
			var mask = new top.Ext.LoadMask(htmlEl, {
				msg : msg,
				minHeight: 33,
				disabled : false
			});
			return mask;
		};
		var masker = function(msg){
			return maskerWithHtmlEl(top.window.document.body, msg);
		};
		var pageLoadMask = new masker('页面加载中，请稍后');
		pageLoadMask.show();
		var Tab = new Ext.TabPanel({
			id: 'Tab',
			minWidth: 1200 - 260 - 22,
			minHeight: 120,
			width: screenWidth - 10,
		    height: screenHeight,
		    cls:"ui-tab-bar",
			bodyCls:"ui-tab-body",
		    frame:true,
			activeTab: 0,
			listeners:{
			},
			items: [
					{
						title: '测试要素',
					    listeners:{
					    	activate: function( _this, eOpts ){
								_this.update('<iframe id="f_0" name="f_0" scrolling="no" frameborder="0" width='+screenWidth+' height='+screenHeight+' src="<%=request.getContextPath()%>/aiga/P2PTestCase/selectTestElem.jsp?busiOneLevelId=${param.busiOneLevelId}&busiTwoLevelId=${param.busiTwoLevelId}"></iframe>',true);
					    	}
						}
					},
					{
						title: '用户体验测试业务用例集',
						listeners:{
							activate: function(_this,eOpts){
								_this.update('<iframe id="f_1" name="f_1" scrolling="no" frameborder="0" width='+screenWidth+' height='+screenHeight+' src="<%=request.getContextPath()%>/aiga/P2PTestCase/p2pTestCaseLib.jsp?busiOneLevelId=${param.busiOneLevelId}&busiTwoLevelId=${param.busiTwoLevelId}"></iframe>',true);
						  }
						}
					},
					{
						title: '用户体验测试业务场景',
						listeners:{
							activate: function(_this,eOpts){
								_this.update('<iframe id="f_2" name="f_2" scrolling="no" frameborder="0" width='+screenWidth+' height='+screenHeight+' src="<%=request.getContextPath()%>/aiga/P2PTestCase/p2pTestSecene.jsp?busiOneLevelId=${param.busiOneLevelId}&busiTwoLevelId=${param.busiTwoLevelId}"></iframe>',true);
							}
						}
					}
			        ]
		});
		Ext.create('Ext.panel.Panel',{
			//title:'用例库建设',
			minWidth: 1200-260,
			minHeight: 350,
			width: screenWidth,
		    height: screenHeight + 5,
		    renderTo: Ext.get('body'),
		    cls: 'ui-formPanel',
			bodyBorder:0,
			listeners:{
				render:function(panel,eOpts){
					//isAppend=true;
					pageLoadMask.hide();
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
				region: 'center',
				items:[Tab]
			}]
		});
	});
</script>
</html>