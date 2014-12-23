<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>

<%@ include file="/aiga/common/include.jsp" %>

<html>
  <head>
    <title>测试任务创建</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ie-tab.css">
  </head>
  <body>
  </body>
  <script type="text/javascript">
	Ext.onReady(function(){
		var screenWidth=document.documentElement.clientWidth;
		var screenHeight=document.documentElement.clientHeight-5;
  		var tabs = new Ext.TabPanel({
			id: 'tabs',
			renderTo: Ext.getBody(),
			width: screenWidth - 8,
			height: screenHeight,
			cls:"ui-tab-bar",
			bodyCls:"ui-tab-body",
			layout:'fit',
			activeTab: 0,
			bodyBorder: 0,
			items: [
                    {
                        title: "新建测试任务",
                        html: '<iframe id="f_1" scrolling="yes" frameborder="0" width="' + (screenWidth - 10) + '" height="'+(screenHeight - 35)+'" src="<%=request.getContextPath()%>/aiga/workflow/testTask/TestTaskStartUp.jsp"></iframe>'
                    }, 
                    {
                        title: "批量导入测试任务",
                        html: '<iframe id="f_2" scrolling="yes" frameborder="0" width="' + (screenWidth - 10) + '" height="'+(screenHeight - 35)+'" src="<%=request.getContextPath()%>/aiga/workflow/testTask/TesttaskBatchImport.jsp"></iframe>'
                    }
			]
		});
	});
  </script>
</html>
