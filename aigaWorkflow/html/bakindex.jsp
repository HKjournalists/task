<%@ page contentType="text/html; charset=gb2312"%>
<html>
<head>
<title>权限系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript"
	src="<%=request.getContextPath()%>/jsv2/UserData_v2.js"></script>
<script language="JavaScript"
	src="<%=request.getContextPath()%>/jsv2/Globe_v2.jsp"></script>
<script language="JavaScript"
	src="<%=request.getContextPath()%>/jsv2/CommUtil.js"></script>
<script language="JavaScript" type="text/JavaScript">	
  var isVertifyCode = true;//界面是否有验证码校验输入框;
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
      var vertifycode = "";
    if(isVertifyCode){
      vertifycode = new String(document.all.item("UserVertifyCode").value);
    }    
    var blank = "   " ;
    if(isVertifyCode && blank.indexOf(vertifycode)!=-1){
      alert("用户校验码不能为空");
      document.all.item("UserVertifyCode").focus();
      return false;
    }
	 
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
	     alert(screen.width+" "+screen.height);
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
</script>

</head>

<body>
<table width="180" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="10"></td>
  </tr>
  <tr>
    <td height="24">工&nbsp;&nbsp;号：
      <input type="text" id="UserAccount" onKeyPress="JumpByEnter(UserPwd)" class="username" name="text" value="administrator"  style="width: 130" value="" /></td>
  </tr>
  <tr>
    <td height="24">密&nbsp;&nbsp;码：
      <input type="password" id="UserPwd" onKeyPress="IsEnterKeyPress()" class="password" name="Input" value="password1" style="width: 130" value="" /></td>
  </tr>
  <tr>
    <td height="24">验证码：
      <input type="text" id="UserVertifyCode" onKeyPress="IsEnterKeyPress()" class="code" name="Input" style="width: 80" value="1111">
        <image id="vertifyCodeImg" src="" width="50" height="20" align="absmiddle"></td>
  </tr>
  <tr>
    <td height="45"><table width="180" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="center"><input type="button" value="登录"  onClick="Login()">
        <td align="center"><input type="button" value="重置"  onClick="Reset()" ></td>
        <td align="center"><input type="button" value="改密"  onClick="changePassword()" ></td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>
<script>
document.all.item("vertifyCodeImg").src="<%=request.getContextPath()%>/vertifycodeservlet";
//Login();
</script>