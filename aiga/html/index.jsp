<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<%@ page import="java.util.*"  contentType="text/html; charset=UTF-8"%>
<%@page import="com.asiainfo.aiga.common.LoginFilter" %>
<%
	String path = request.getContextPath();
	Object msg = request.getSession().getAttribute("error");
	if(msg == null) {
		msg = "请输入用户名和密码";
	}
	String workflowUrl = LoginFilter.getWorkflowUrl();
	request.getSession().removeAttribute("error");
%>

<HTML xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>自动化测试管理平台</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript" src="<%=path%>/jquery/base/jquery-1.7.2.js"></script>
		<!--
		<link rel="stylesheet" type="text/css" href="styles.css">
		-->
		<style type="text/css">
			body {
				margin: 0 auto;
				overflow:hidden;
				background: rgb(2, 96, 156);
			}
			
			.btn-txt {
				font-size: 12px;
				color: rgb(220, 220, 220);
				text-align: center;
				
			}
			
			.pw-class {
				width: 58px;
				height: 35px;
				line-height: 35px;
				background-image: url('images/login_base.gif');
				cursor: pointer;
			}
			
			.lg-class {
				width: 38px;
				height: 35px;
				line-height: 35px;
				background-image: url('images/login_base.gif');
				cursor: pointer;
			}
			
			.pw-class:hover,.lg-class:hover {
				background-image: url('images/login_base_1.gif');
			}
			
		</style>
	</head>
	<body onLoad="MM_preloadImages('images/login_09_1.gif','images/login_10_1.gif')">
		<form id="loginForm" action="<%=path%>/login.do" method="post">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td bgcolor="#02395f">&nbsp;</td>
				</tr>
				<tr>
					<td height="607" align="center" background="images/login_02.gif">
						<table width="974" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="281" background="images/login_01.jpg">&nbsp;</td>
							</tr>
							<tr>
								<td height="116">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="393" height="116" background="images/login_05.gif">&nbsp;</td>
											<td width="174">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td height="81" background="images/login_06.gif">
															<table width="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="22%">
																		&nbsp;
																	</td>
																	<td width="78%" height="25">
																		<span style="color: orange;font-size: 12px;"><%=msg %></span>
																	</td>
																</tr>
																<tr>
																	<td width="24%">
																		<div align="center"> <font style="height:1;font-size:9pt; color:#bfdbeb;filter:glow(color=#1070a3,strength=1)">用户</font>
																		</div>
																	</td>
																	<td width="76%" height="25">
																		<input type="text" id="userAcc" name="userAcc" onkeyup="ucKeyUp()" style="width:125px; height:20px; background:#32a2e3; font-size:12px; border:solid 1px #0468a7; color:#14649f;"></td>
																</tr>
																<tr>
																	<td>
																		<div align="center"> <font style="height:1;font-size:9pt; color:#bfdbeb;filter:glow(color=#1070a3,strength=1)">密码</font>
																		</div>
																	</td>
																	<td height="25">
																		<input type="password" id="pwd" name="pwd" onkeyup="pwdKeyUp()" style="width:125px; height:20px; background:#32a2e3; font-size:12px; border:solid 1px #0468a7; color:#14649f;"></td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td height="35">
															<table width="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="50" height="35">
																		<img src="images/login_08.gif" width="50" height="35"></td>
																	<td width="46">
																		<!-- 
																		<a href="javascript:void(0)">
																			<img src="images/login_09.gif" id="Image1" width="42" height="35" border="0" id="Image1" onMouseOver="MM_swapImage('Image1','','images/login_09_1.gif',1)" onMouseOut="MM_swapImgRestore()" onclick="login()">
																		</a>
																		 -->
																		 <div id="Image1"  class="lg-class btn-txt" onclick="login()">登录</div>
																	</td>
																	<td width="80">
																			<div id="Image2" class="pw-class btn-txt" onclick="resetForm()">密码修改</div>
																		<!-- 
																		<a href="javascript:void(0)">
																			<img src="images/login_10.gif" id="Image2" width="45" height="35" border="0" id="Image2" onMouseOver="MM_swapImage('Image2','','images/login_10_1.gif',1)" onMouseOut="MM_swapImgRestore()" onclick="resetForm()">
																			</a>
																		 -->
																	</td>
																	<td width="0">
																		<img src="images/login_11.gif" width="29" height="35"></td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
											<td width="407" background="images/login_07.gif">&nbsp;</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="160" background="images/login_12.gif">&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td bgcolor="#02609c">&nbsp;</td>
				</tr>
			</table>
		</form>
	</body>
	<script type="text/javascript">
	
		$(function(){$("#userAcc").focus();});
		
		function ucKeyUp(e) {
			if($("#userAcc").val() == "") {
				return;
			}
			var currKey=0,e=e||event;
	　　      　   currKey=e.keyCode||e.which||e.charCode;
	　　      　　	//var keyName = String.fromCharCode(currKey);
			if(currKey == 13) {
				$("#pwd").focus();
			}
		}
		
		function pwdKeyUp() {
			if($("#pwd").val() == "") {
				return;
			}
			var currKey=0,e=e||event;
	　　      　   currKey=e.keyCode||e.which||e.charCode;
	　　      　　	//var keyName = String.fromCharCode(currKey);
			if(currKey == 13) {
				login();
			}
		}
		
		function login() {
			$("#loginForm").submit();
		}
		
		function resetForm() {
			//$("#loginForm :input").val("");
			var result = window.showModalDialog("<%=workflowUrl%>/secframe/orgmodel/staff/ChPasswordByCode.jsp",null,"dialogWidth:600px;dialogHeight=400px;");
			$.ajax({
				url: '<%=request.getContextPath()%>/refreshUserInfo.do',
				type: 'post',
				success: function() {
				},
				failture: function() {
					alert("刷新员工信息失败");
				}
			});
		}
		  	
	  	function MM_preloadImages() { //v3.0
		  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
		    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
		    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
		}
		
		function MM_swapImgRestore() { //v3.0
		  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
		}
		
		function MM_findObj(n, d) { //v4.01
		  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
		    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
		  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
		  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
		  if(!x && d.getElementById) x=d.getElementById(n); return x;
		}
		
		function MM_swapImage() { //v3.0
		  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
		   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
		}
	</script>
</html>