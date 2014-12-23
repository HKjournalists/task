<%@ page language="java"
	import="java.util.*,java.util.Date,java.text.SimpleDateFormat,com.zhuozhengsoft.pageoffice.*,java.sql.*,java.io.*"
	pageEncoding="utf-8"%>
<%@page import="com.asiainfo.aiga.search.dao.BaseDAO"%>
<%@page import="com.asiainfo.lucene.LuceneEntities.properties.LuceneCommon;"%>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po"%>
<%
	String sID = request.getParameter("id");
	String subTaskId = request.getParameter("subTaskId");
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
		poCtrl.setSaveFilePage("savefile.jsp?id=" + sID);
		
		//添加自定义菜单栏
		poCtrl.setCustomMenuCaption("自定义菜单");
		poCtrl.addCustomMenuItem("显示标题","CustomMenuItem1_Click()",true);
		poCtrl.addCustomMenuItem("领导圈阅","CustomMenuItem2_Click()",true);
		
		//添加自定义工具栏
		poCtrl.addCustomToolButton("保存","CustomToolBar_Save()",1);
		poCtrl.addCustomToolButton("另存为","CustomToolBar_SaveAs()",1);
		poCtrl.addCustomToolButton("插入印章","CustomToolBar_InsertSeal()",2);
		poCtrl.addCustomToolButton("领导圈阅","CustomToolBar_HandDraw()",3);
		poCtrl.addCustomToolButton("全屏/还原","CustomToolBar_FullScreen()",4);
		
		poCtrl.webOpen(filePath, OpenModeType.xlsNormalEdit,"somebody");
		poCtrl.setTagId("PageOfficeCtrl1");
	//************************PageOffice组件的使用*****************************
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>在线编辑文件</title>
		<link rel="stylesheet" href="css/style.css" type="text/css"></link>
	</head>
	<body>
		<!--a title-->
		<div class=" topTitle">
			<ul>
		    	<li class="pd-left"><a href="index.jsp?subTaskId=<%=subTaskId%>" style="color:White;"><font >返回文件列表</font></a></li>
		        <li><font>当前模式：</font>在线编辑</li>
		        <li><font>当前系统日期：</font><%=new SimpleDateFormat("yyyy/MM/dd/EEEE").format(new Date()) %></li>
		    </ul>
		</div>
		<!--content-->
		<div class="zz-content mc clearfix pd-28">
			<form id="form1">
				<div style="height: 700px;">
					<!-- *************************PageOffice组件的使用************************************ -->
					<po:PageOfficeCtrl id="PageOfficeCtrl1"></po:PageOfficeCtrl>
					<script type="text/javascript">

					    function CustomMenuItem1_Click() {
					        alert("该菜单的标题是：" + document.getElementById("PageOfficeCtrl1").Caption);
					    };
					    
					    function CustomMenuItem2_Click() {
					        document.getElementById("PageOfficeCtrl1").HandDraw.Start();
					    };
					
					    function CustomToolBar_Save() {
					        document.getElementById("PageOfficeCtrl1").WebSave();
					        alert("保存成功！\n这里可以显示开发人员自定义的保存成功信息。");
					    }
					    
					    function CustomToolBar_SaveAs() {
					        document.getElementById("PageOfficeCtrl1").ShowDialog(2);
					    }
						
						function CustomToolBar_InsertSeal() {
							alert("请使用此用户的印章测试\r\n用户名：李志 \r\n初始密码：111111");
        					var zoomseal = document.getElementById("PageOfficeCtrl1").ZoomSeal;
	    					if (zoomseal != null)
	        					zoomseal.AddSeal();
						}
						
						function CustomToolBar_HandDraw() {
							document.getElementById("PageOfficeCtrl1").HandDraw.Start();
						}
						
						function CustomToolBar_FullScreen() {
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
