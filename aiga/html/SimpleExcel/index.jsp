<!DOCTYPE html>
<%@ page language="java"
	import="java.util.*,java.io.*,java.sql.*,java.net.*,java.text.SimpleDateFormat,java.util.Date"
	pageEncoding="UTF-8"%>
<%@page import="com.asiainfo.aiga.search.dao.BaseDAO"%>
<%@page import="com.asiainfo.lucene.LuceneEntities.properties.LuceneCommon;"%>
<%@ include file="/aiga/common/include.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	String subTaskId = request.getParameter("subTaskId");
	if(request.getParameter("action") != null && "copy".equalsIgnoreCase(request.getParameter("action"))) {
		Class.forName(BaseDAO.DRIVER);//载入驱动程序类别
		Connection conn = DriverManager.getConnection(BaseDAO.URL, BaseDAO.USERNAME, BaseDAO.PASSWORD);
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("select aiga_excel$seq.nextval from dual");
		int newID = 1;
		if (rs.next()) {
			String id = rs.getString(1);
			if (id != null && id.length() > 0) {
				newID = Integer.parseInt(id) + 1;
			}
		}
		rs.close();
	
		String fileName = "AnalysisObj" + newID + ".xlsx";
		String FileSubject = "请输入文档主题";
		String getFile = (String) request.getParameter("FileSubject");
		if (getFile != null && getFile.length() > 0)
			FileSubject = getFile;
		System.out.println(FileSubject);
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");//设置日期格式
		// new Date()为获取当前系统时间
		String strsql = "Insert into aiga_excel(ID,FileName,Subject,SubmitTime,SubTaskId) values("
				+ newID + ",'" + fileName + "','" + FileSubject + "',to_date('" + df.format(new Date()) + "','yyyy-MM-dd hh24:mi:ss')," + subTaskId + ")";
		stmt.executeUpdate(strsql);
		stmt.close();
		conn.close();
	
		//拷贝文件
		String templateName = request.getParameter("TemplateName");
		InputStream input = getServletConfig().getServletContext().getResourceAsStream("/SimpleExcel/doc/"+ templateName);
		String newPath = "";
		boolean isWeblogic = true;
		if(isWeblogic) {
			newPath = LuceneCommon.getProertiesValue("excel.exportPath","excel.properties")+"/" + fileName;
		} else {
			newPath = "E:\\temp\\" + fileName;
		}
		try {
			int bytesum = 0;
			int byteread = 0;
			//File oldfile = new File(oldPath);
			if(input != null) { //文件存在时 
				//InputStream inStream = new FileInputStream(oldPath); //读入原文件
				InputStream inStream = input;
				File outFile = new File(newPath);
				FileOutputStream fs = new FileOutputStream(outFile);
				byte[] buffer = new byte[1024];
				int length;
				while((byteread = inStream.read(buffer)) != -1) {
					bytesum += byteread; //字节数 文件大小 
					fs.write(buffer, 0, byteread);
				}
				inStream.close();
			}
		} catch (Exception e) {
			System.out.println("复制单个文件操作出错");
			e.printStackTrace();
		}
		//out.println("<script type='text/javascript'>topOpen('excel.jsp?id="+newID+")</script>");
		response.sendRedirect("excel.jsp?id=" + newID + "&subTaskId=" + subTaskId);
	} else if(request.getParameter("action") != null && "delete".equalsIgnoreCase(request.getParameter("action"))) {
		String id = request.getParameter("id");
		Class.forName(BaseDAO.DRIVER);//载入驱动程序类别
		Connection conn = DriverManager.getConnection(BaseDAO.URL, BaseDAO.USERNAME, BaseDAO.PASSWORD);
		Statement stmt = conn.createStatement();
		stmt.executeUpdate("delete from aiga_excel where id=" + id);
		stmt.close();
		conn.close();
	}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" href="css/style.css" type="text/css"></link>
		<!--[if lte IE 6]>
<script type="text/javascript" src="js/belatedPNG.js"></script>
<script type="text/javascript">
  DD_belatedPNG.fix('.png_bg,.png_bg a:hover,img,li');
</script>
<![endif]-->
		<title>在线演示示例</title>
	</head>
	<body>
		<script type="text/javascript">
			function onColor(td) {
				td.style.backgroundColor = '#D7FFEE';
			}
			function offColor(td) {
				td.style.backgroundColor = '';
			}
			function openHtml(filename) {
				window.open("doc/" + filename);
			}
			function topOpen(url) {
				url += "&subTaskId=<%=subTaskId%>";
				window.open(url);
			}
			function deleteFile(url) {
				top.Ext.MessageBox.confirm('提示','确定要删除吗?',function(optional){
					if(optional == "yes") {
						location.href = url;
					}
				});
			}
		</script>
		<!--content-->
		<div class="zz-content mc clearfix">
			<div class="demo mc" style="border-bottom: none;">
				<form name="form1" id="form1" action="index.jsp?action=copy&subTaskId=<%=subTaskId%>" method="post">
					<table class="text" cellSpacing="0" cellPadding="0" border="0">
						<tr>
							<td style="font-size: 9pt" align="left">
								<select name="TemplateName">
									<option value='redhead00.xls'>
										------不使用模板------
									</option>
									<option value='用户体验测试分析模板.xlsx' selected>
										用户体验测试分析模板
									</option>
								</select>
							</td>
							<td align="center">
								<input name="FileSubject" type="text" class="boder"
									style="width: 180px;" value="请输入文档主题" />
							</td>
							<td width="221">
								&nbsp;
								<input type="image" name="ImageButton1" id="ImageButton1"
									src="images/newword.gif" alt="" border="0" />
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="zz-talbeBox mc">
				<table class="zz-talbe">
					<thead>
						<tr>
							<th width="7%">
								类型
							</th>
							<th width="32%">
								文档名称
							</th>
							<th width="19%">
								创建日期
							</th>
							<th width="25%">
								操作模式
							</th>
							<th width="13%">
								文件读写
							</th>
						</tr>
					</thead>
					<tbody>
						<%
							Class.forName(BaseDAO.DRIVER);//载入驱动程序类别
							Connection conn = DriverManager.getConnection(BaseDAO.URL, BaseDAO.USERNAME, BaseDAO.PASSWORD);
							Statement stmt = conn.createStatement();
							ResultSet rs = stmt.executeQuery("select * from  aiga_excel where SubTaskId='" + subTaskId + "' order by ID DESC ");

							while (rs.next()) {
								String str0 = rs.getString(1);
								if (str0 != null && str0.length() > 0) {
						%>
						<tr onmouseover='onColor(this);' onmouseout='offColor(this);'>
							<td>
								<img src='images/office-2.jpg' />
							</td>
							<td><%=rs.getString(3)%></td>
							<%
								//显示时间
										String str4 = rs.getString(4);
										if (str4 != null && str4.length() > 0) {
							%>
							<td><%=new SimpleDateFormat("yyyy/MM/dd")
								.format(new SimpleDateFormat("yyyy-MM-dd")
										.parse(str4))%></td>
							<%
								} else {
							%>
							<td>
								&nbsp;
							</td>
							<%
								}		
							%>
							<td>
								<a href='javascript:void(0)' onclick='topOpen("excel.jsp?id=<%=str0 %>")'>在线编辑</a> <a href='javascript:void(0)' onclick='topOpen("excel2.jsp?id=<%=str0 %>")'>只读打开</a>
							</td>
							<%
								}
							%>
							<td>
								<a href='javascript:void(0)' onclick='deleteFile("<%=request.getContextPath()%>/SimpleExcel/index.jsp?action=delete&id=<%=str0 %>")'>删除</a>
							</td>
						</tr>
						<%
							}
							rs.close();
							stmt.close();
							conn.close();
						%>
					</tbody>
				</table>
			</div>
		</div>
		<!--content end-->
	</body>
</html>
