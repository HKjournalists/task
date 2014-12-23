<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String subTaskId = request.getParameter("subTaskId");
%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=GBK" />
		<title>测试页面</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/extJs/resources/css/ext-all.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css" />
		<script type="text/javascript" src="../../extJs/ext-all.js"></script>
		<script type="text/javascript" src="../../jquery/base/jquery-1.7.2.js"></script>
		<style type="text/css">
			img {
				cursor: pointer;
			}
		</style>
	</head>
	<body>
		<div id="base">
		</div>
	</body>
	<script type="text/javascript">
		
		Ext.onReady(function(){
			Ext.onReady(function(){
				new Ext.Panel({
					renderTo: Ext.getBody(),
					title:"容器组件",
					width:500,
					height:200,
					layout:"accordion",
					layoutConfig:{
						collapseFirst:false,
						animate:true
					},
					items:[
						{title:"子元素1",html:"这是子元素1中的内容"},
						{title:"子元素2",html:"这是子元素2中的内容"},
						{title:"子元素3",html:"这是子元素3中的内容"}
					]
				});
			});
		});
		
	</script>
</html>