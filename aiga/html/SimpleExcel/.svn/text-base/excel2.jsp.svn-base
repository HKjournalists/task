<%@ page language="java"
	import="java.util.*,java.util.Date,java.text.SimpleDateFormat,com.zhuozhengsoft.pageoffice.*,java.sql.*,java.io.*,
	com.zhuozhengsoft.pageoffice.excelwriter.*"
	pageEncoding="UTF-8"%>
<%@page import="com.asiainfo.aiga.search.dao.BaseDAO"%>
<%@page import="com.asiainfo.lucene.LuceneEntities.properties.LuceneCommon;"%>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po"%>
<%
	String subTaskId = request.getParameter("subTaskId");
	String sID = request.getParameter("id");
	String fileName = "";
	if (sID == null || sID == "") {
		out.println("<script>alert('为获得文件ID号！');location.href='index.jsp?subTaskId="+subTaskId+"'</script>");
	}

	Class.forName(BaseDAO.DRIVER);//载入驱动程序类别
	Connection conn = DriverManager.getConnection(BaseDAO.URL, BaseDAO.USERNAME, BaseDAO.PASSWORD);
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery("select * from aiga_excel where id = " + sID);
	if (rs.next()) {
		fileName = rs.getString("FileName");
	}
	rs.close();
	boolean isWeblogic = true;
	String filePath = "";
	if(isWeblogic) {
		filePath = LuceneCommon.getProertiesValue("excel.exportPath","excel.properties")+"/" + fileName;
	} else {
		filePath = "E:\\temp\\" + fileName;
	}
	File file = new File(filePath);
	if (!file.exists()) {
		out.println("<script>alert('该文件不存在！');location.href='index.jsp?subTaskId="+subTaskId+"'</script>");
	}
	if(isWeblogic) {
		filePath = "file://" + filePath;
	}
	//************************PageOffice组件的使用*****************************
		PageOfficeCtrl poCtrl = new PageOfficeCtrl(request);
		poCtrl.setServerPage("../poserver.zz");
		poCtrl.setSaveFilePage("savafile.jsp?id=" + sID);
		
		//添加自定义工具栏
		poCtrl.addCustomToolButton("另存为","saveAs()",1);
		poCtrl.addCustomToolButton("打印设置","setPrint()",6);
		poCtrl.addCustomToolButton("全屏/还原","setFullScreen()",4);
		
		poCtrl.setMenubar(false);//隐藏自定义菜单栏
		poCtrl.setOfficeToolbars(false);//隐藏Office工具栏
		
		Workbook wb = new Workbook();//创建工作薄对象
		wb.setDisableSheetDoubleClick(true);//禁止双击单元格
		wb.setDisableSheetRightClick(true);//禁止右击单元格
		poCtrl.setWriter(wb);
		
		poCtrl.webOpen(filePath, OpenModeType.xlsReadOnly,"somebody");
		poCtrl.setTagId("PageOfficeCtrl1");
	//************************PageOffice组件的使用*****************************
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<!--[if lte IE 6]>
<script type="text/javascript" src="js/belatedPNG.js"></script>
<script type="text/javascript">
  DD_belatedPNG.fix('.png_bg,.png_bg a:hover,img,li');
</script>
<![endif]-->
		<title>只读打开文件</title>
		<link rel="stylesheet" href="css/style.css" type="text/css"></link>
	</head>
	<body>
		<!--a title-->
		<div class=" topTitle">
			<ul>
				<li class="pd-left">
					<a href="index.jsp?subTaskId=<%=subTaskId%>" style="color: White;"><font>返回文件列表</font>
					</a>
				</li>
				<li>
					<font>当前模式：</font>在线编辑
				</li>
				<li>
					<font>当前系统日期：</font><%=new SimpleDateFormat("yyyy/MM/dd wwww")
					.format(new Date())%>
				</li>
			</ul>
		</div>
		<!--content-->
		<div class="zz-content mc clearfix pd-28">
			<form id="form1">
				<div style="height: 700px;">
					<!-- *************************PageOffice组件的使用************************************ -->
					<po:PageOfficeCtrl id="PageOfficeCtrl1"></po:PageOfficeCtrl>
					<script type="text/javascript">
					
					    function saveAs() {
				            document.getElementById("PageOfficeCtrl1").ShowDialog(2);
				        }
				        function setPrint() {
				            document.getElementById("PageOfficeCtrl1").ShowDialog(5);
				        }
				        function setFullScreen() {
				            document.getElementById("PageOfficeCtrl1").FullScreen = !document.getElementById("PageOfficeCtrl1").FullScreen;
				        }
			
			    	</script>
			    <!-- *************************PageOffice组件的使用************************************ -->
				</div>
			</form>
		</div>
		<!--content end-->
		<!--footer-->
		<div class="login-footer clearfix">
			Copyright copy 2013 北京卓正志远软件有限公司
		</div>
		<!--footer end-->
	</body>
</html>
