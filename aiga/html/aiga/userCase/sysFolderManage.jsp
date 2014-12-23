<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>

<%@ include file="/aiga/common/include.jsp" %>

<html>
  <head>
    <title>功能点所属系统管理</title>
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
			width: screenWidth - 1,
			height: screenHeight,
			cls:"ui-tab-bar",
			bodyCls:"ui-tab-body",
			layout:'fit',
			activeTab: 0,
			bodyBorder: 0,
			items: [
                    {
                        title: "系统管理",
                        html: '<iframe id="f_1" scrolling="yes" frameborder="0" width="' + (screenWidth) + '" height="'+(screenHeight - 35)+'" src="<%=request.getContextPath()%>/aiga/userCase/sysFolderQuery.jsp"></iframe>'
                    }, 
                    {
                        title: "子系统管理",
                        html: '<iframe id="f_2" scrolling="yes" frameborder="0" width="' + (screenWidth) + '" height="'+(screenHeight - 35)+'" src="<%=request.getContextPath()%>/aiga/userCase/subSysFolderQuery.jsp"></iframe>'
                    }
			]
		});
	});
  </script>
</html>
