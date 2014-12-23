<%@ page language="java"
	import="java.util.*,com.zhuozhengsoft.pageoffice.*"
	pageEncoding="UTF-8"%>
<%@page import="com.asiainfo.lucene.LuceneEntities.properties.LuceneCommon;"%>

<%
	//****************************PageOffice组件的使用***************************************
	FileSaver fs = new FileSaver(request, response);
	//fs.saveToFile("E:\\temp\\"+fs.getFileName());
	
	fs.saveToFile(LuceneCommon.getProertiesValue("excel.exportPath","excel.properties")+"/"+fs.getFileName());		
	fs.close();//关闭FileServer对象
	//****************************PageOffice组件的使用***************************************
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
	</head>
	<body>
		<form id="form1">
			<div>

			</div>
		</form>
	</body>
</html>
