<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=GBK"%>
<HTML>
<TITLE>河南移动需求管理平台</TITLE>
<link href="logincss.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/UserData_v2.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/Globe_v2.jsp"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/CommUtil.js"></script>

<script language="JavaScript" type="text/JavaScript">	
  var isVertifyCode = false;//界面是否有验证码校验输入框;
  var channel_id = "1";  
  function UserVerify(account,psw,vertifycode){
    var xml = null;
    var XMLSender = new ActiveXObject("Microsoft.XMLHTTP");
    var url = "<%=request.getContextPath()%>/baseserver?CHANNEL_ID=" + channel_id + "&EventID=1&LOGIN_USRNAME="+account+"&LOGIN_PSWD="+psw+"&LOGIN_VERFYCODE="+vertifycode
    XMLSender.Open("POST",url,false);
    XMLSender.setRequestHeader("Content-Type","text/xml; charset=UTF-8");
    XMLSender.send(xml);
    return XMLSender.responseText;
  }
   function selectSystem(){	  
	  var acc = document.all.item("UserAccount").value;
      var psw = document.all.item("UserPwd").value;
      if(acc==null||acc==""){
      	alert("请输入工号");
      	document.all.item("UserAccount").focus();
      	return false;
      }
       if(psw==null||psw==""){
      	alert("请输入密码");
      	document.all.item("UserPwd").focus();
      	return false;
      }
     // var vertifycode = "";
     //if(isVertifyCode){
     //  vertifycode = new String(document.all.item("UserVertifyCode").value);
     //}    
     //var blank = "   " ;
     //if(isVertifyCode && blank.indexOf(vertifycode)!=-1){
     //  alert("用户校验码不能为空");
     //  document.all.item("UserVertifyCode").focus();
     //  return false;
     //}
	 
	  return true;
  }


  /**
   * 用户登录
   * @return
   */
  function Login(){
  	if(selectSystem())//跳到别的系统
  	{
  	var blank = "                                      ";
    var acc = new String(document.all.item("UserAccount").value);
    var psw = new String(document.all.item("UserPwd").value);
    var vertifycode = "";
    if(isVertifyCode){
      vertifycode = new String(document.all.item("UserVertifyCode").value)
    }	
    var loginRe = UserVerify(acc,psw,vertifycode);
    
    //alert("loginRe="+loginRe);
    var xml= new ActiveXObject("Msxml.DOMDocument");
    xml.async = false;
    var bload = xml.loadXML(loginRe);
    //alert(bload);
    var xmlNode = xml.documentElement;
    var ud = createUserDataClass(xmlNode);    
    if(ud==null){
      alert('登陆失败！');
      return;
    }
    //alert(ud.getValueByName("LOGIN_FLAG"));
    if (ud.getValueByName("LOGIN_FLAG") == "Y"){ //登录成功
       var SUCCESS_MESSAGE = ud.getValueByName("SUCCESS_MESSAGE");
       if(SUCCESS_MESSAGE!=null && SUCCESS_MESSAGE!=''){
          alert(SUCCESS_MESSAGE);
       }
	     var mySrc = ud.getValueByName("MESSAGE");
	     //openWin(mySrc);
	    // alert(screen.width+" "+screen.height);
       	window.open (ud.getValueByName("MESSAGE"),"","menubar=no,status=no,resizable=no,scrollbars=no,toolbar=no,top=0,left=0,width="+ (screen.Width-8)+ ",height=" +(screen.Height-60));
	     window.opener = null;
	     window.close();
    }
    else
    {//登录失败
      alert(ud.getValueByName("MESSAGE"));
      if(isVertifyCode && document.all.item("vertifyCodeImg")!=null){
	  document.all.item("UserVertifyCode").value="";
	  document.all.item("vertifyCodeImg").src="<%=request.getContextPath()%>/vertifycodeservlet";
      }
      var xStr = ud.getValueByName("MESSAGE");
	  //alert(xStr);
	  if(xStr=="密码不正确!")
	  {
	     document.all.item("UserPwd").value="";
		 document.all.item("UserPwd").focus();
	 	 document.all.item("UserPwd").focus();
	  }
	  else
	  {
	 	 document.all.item("UserAccount").value="";
		 document.all.item("UserPwd").value="";
	     document.all.item("UserAccount").focus();
	 	 document.all.item("UserAccount").focus();
      }
    }
  	}
    
   }

   /**
    * 取消登录
    * @return
    */
   function CancleLogin()
   {
     top.close();
   }
   
    function changePassword(){
    var flag = window.showModalDialog("<%=request.getContextPath()%>/secframe/orgmodel/staff/ChPasswordByCode.jsp?code=" 
    + document.all.item("UserAccount").value,
    '',"scroll:no;resizable:no;status:no;dialogHeight:310px;dialogWidth:380px");

 }
    /**
    * 输入重置
    * @return
    */
   function Reset()
   {
      document.all.item("UserAccount").value="";
      document.all.item("UserPwd").value="";
      document.all.item("UserAccount").focus();

   }

   function JumpByEnter(NextElement){
     var lKeyCode = (navigator.appname=="Netscape")?event.which:window.event.keyCode;
     if ( lKeyCode == 13 ){

	   NextElement.focus();
     }
   }

   function IsEnterKeyPress(){
     var lKeyCode = (navigator.appname=="Netscape")?event.which:event.keyCode;
     if ( lKeyCode == 13 ){
       Login();
     }
     else
       return false;
   }
   
   //变更登录按钮的图片
   function loginIMG_over(){
   	document.getElementById("loginIMG").src="images/1007.gif";
   }
   
   function loginIMG_out(){
   	document.getElementById("loginIMG").src="images/1006.gif";
   }	
 </script>  
   
   

<BODY>
<TABLE width="100%" height="100%" border=0 cellPadding=0 cellSpacing=0>
  <TBODY>
  <TR>
    <TD background="images/1001.gif" height=123>&nbsp;</TD>
  </TR>
  <TR>
    <TD height=475 align=center vAlign=middle background="images/1002.gif">
    <table width="712" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="712" height="475" valign="top" background="images/login.png">
        <table width="712" height="252" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="110" height="169">&nbsp;</td>
            <td width="271">&nbsp;</td>
            <td width="331">&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
											<td valign="top">
												<form name="form1" method="post" action="">
													<table width="271" border="0" cellpadding="0"
														cellspacing="0">
														<tr>
															<td width="53" height="21">
																用户名
															</td>
															<td width="145" height="25">
																<label>
																	<input type="text" id="UserAccount"
																		onKeyPress="JumpByEnter(UserPwd)" class="username"
																		name="text" value="administrator" style="width: 130" />

																</label>
															</td>
															<td width="85" rowspan="3" align="center" valign="middle">
																<img src="images/1006.gif" width="61" height="64"
																	ID="loginIMG" onMouseOver="loginIMG_over()"
																	onMouseOut="loginIMG_out()" onClick="Login()">
															</td>
														</tr>
														<tr>
															<td height="25">
																<blockquote>
																	<p>
																		密&nbsp;&nbsp;&nbsp;&nbsp;码
																	</p>
																</blockquote>
															</td>
															<td height="25">
																<label>
																	<input type="password" id="UserPwd"
																		onKeyPress="IsEnterKeyPress()" class="password"
																		name="Input" value="1" style="width: 130" value="" />
																</label>
															</td>
														</tr>
														<tr>
<!-- 
															<td height="25">
																验证码
															</td>
															<td height="25" valign="top">
																<table width="127" height="30" border="0"
																	cellpadding="0" cellspacing="0">
																	<tr>
																		<td width="75">
																			<label>
																				<input type="text" id="UserVertifyCode"
																					onKeyPress="IsEnterKeyPress()" class="code"
																					name="Input" style="width: 80" value="">
																			</label>
																		</td>
																		<td width="75">
																			&nbsp;
																		</td>
																		<td width="52">
																			<image id="vertifyCodeImg" src="" width="50"
																				height="20" align="absmiddle">
																		</td>

																	</tr>

																</table>
																<label></label>
															</td>
 -->
														</tr>
													</table>
												</form>
											</td>
											<td>
												&nbsp;
											</td>
										</tr>
        </table></td>
      </tr>
    </table></TD>
  </TR>
  <TR>
<TD background="images/1003.gif"  height="40%">&nbsp;</TD>
</TR></TBODY></TABLE>
</BODY>
<script>
//document.all.item("vertifyCodeImg").src="<%=request.getContextPath()%>/vertifycodeservlet";
//Login();
</script>

</HTML>
