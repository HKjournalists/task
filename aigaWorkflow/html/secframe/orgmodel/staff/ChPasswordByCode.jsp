<%@ include file="/webframe/common/commonhead.jsp"%>
<%@ page contentType="text/html; charset=GBK" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>重置密码</title>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/UserData_v2.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/Globe_v2.jsp"></script>
</head>
<script language="JavaScript">
   /**
   * 密码设置
   * @return
   */
  var gParam = dialogArguments;
  var opId="";
  if(gParam)
  {
     opId=gParam;
  }
  function chPassFunc()
  {
    
    var psw = document.all.item("UserPwd").value;
    var pswConfirm = document.all.item("UserPwdConfirm").value;
	var code = document.all.item("UserCode").value;
    var old = document.all.item("OldPass").value;
    if(code==""){
    	alert("登陆名不能为空");
    	document.all.item("UserCode").focus();
    	return;
    }
    if(old==""){
    	alert("旧密码不能为空");
    	document.all.item("OldPass").focus();
    	return;
    }
    if(old==psw){
        alert("新密码与密码不能相同");
    	document.all.item("OldPass").focus();
    	return;
    }
	if(psw.length<=0|| pswConfirm.length<=0)
	{
      //top.returnValue = false;
      alert("密码,密码确认不能为空");
      return;
    }
	if(psw.length>12)
	{
	  alert("密码长度不能超过12位");
	  return;
	}
	if(psw.indexOf(" ")>=0 || psw.indexOf("&")>=0 || psw.indexOf("^")>=0)
	{
	  alert("密码中间不允许有空字符或者‘&’,‘^’字符存在");
	  return;
	}
	//wugj modify  密码必须是字母和数字组合
	
	if(psw.length<6)
	{
	  alert("密码长度必须是六位以上");
	  return;
	}

	var tempStr='';
	var bNum=false;
	var bStr=false;
	var bUpperStr=false;
	for(var i=0;i<psw.length;i++){
		tempStr=psw.charAt(i);
		if(!isNaN(tempStr)){
		bNum=true;
		}
		if(/^[a-z]$/.test(tempStr)){
		bStr=true;
		}
		if(/^[A-Z]$/.test(tempStr)){
		bUpperStr=true;
		}
	}
	if(bNum!=true||bStr!=true||bUpperStr!=true){
	  alert("密码必须是大小写字母和数字的组合");
	  document.all.item("UserPwd").focus();
	  return;
	}

    //alert("psw="+psw+" cpsw="+pswConfirm+"}");
	if(psw!=pswConfirm)
    {
      alert("两次密码输入不同");
      return;
    }
    
    var msg = PostInfo("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysStaffAction?action=setSysOperatorPasswordByCode&code="+code+"&old="+old+"&password="+psw);
    
    var result = msg.getValueByName("retVal");	
    
    if(result=="-1"){
	 alert(msg.getValueByName("msg"));
	 document.all.item("UserPwd").value="";
	 document.all.item("UserPwdConfirm").value="";
	 document.all.item("UserPwd").focus();
	 return;
    }
    else
    {
      alert("重置密码成功,请用新密码登陆！");
      window.returnValue = "1";
      window.close();
    }
   }

   /**
    * 取消登录
    * @return
    */
   function cancelFunc(){
     window.returnValue=false;
     window.close();
   }
   function resetFunc(){    
	document.all.item("UserPwd").value="";
	document.all.item("UserPwdConfirm").value="";
	document.all.item("UserPwd").focus();
    
   }

   function JumpByEnter(NextElement){
     var lKeyCode = (navigator.appname=="Netscape")?event.which:event.keyCode;
     if ( lKeyCode == 13 ){
       NextElement.focus();
     }
   }

   function IsEnterKeyPress(){
     var lKeyCode = (navigator.appname=="Netscape")?event.which:event.keyCode;
     if ( lKeyCode == 13 ){
       chPassFunc();
     }
     else
       return false;
   }
</script>
<body class=modeBody>
<form name="LoginForm">
  <table align="center" width="100%" border="0" bgcolor="#D4E1F2">
    <tr><td colspan=2>&nbsp;</td>
   </tr>
   <tr>
	  <td class="FormTDName" width="120">登陆名：</td>
     <td><input type="text" id="UserCode" value="" onKeyPress="JumpByEnter(OldPass)" ></td>
  </tr>
<tr>
	  <td class="FormTDName" width="120">旧密码：</td>
     <td><input type="password" id="OldPass" onKeyPress="JumpByEnter(UserPwd)" ></td>
  </tr>
  <tr>
	  <td class="FormTDName" width="120">新设密码：</td>
     <td><input type="password" id="UserPwd" onKeyPress="JumpByEnter(UserPwdConfirm)" ></td>
  </tr>
  <tr>
      <td class="FormTDName" width="120">密码确认：</td>
     <td><input type="password" id="UserPwdConfirm" onKeyPress="IsEnterKeyPress()" ><td>
  </tr>
  <tr>
      <td class="FormTDName" width="120">密码规则：</td>
     <td valign="bottom">长度在6-10位之间，包含大写字母、小写字母及数字。<td>
  </tr>
  <tr>
      <td class="FormTDName" width="120">联系人：</td>
     <td valign="bottom">王汝鹏—wangrp3@asiainfo.com<td>
  </tr>
  <tr>
      <td colspan=2 height="30"></td>
   </tr>
  <tr><td colspan=2>
	  <p align="center">
	  	
		  <input type="button" value="确 定" onclick="chPassFunc()" name="OK" class="btn-2word">&nbsp;<input type="button" value="重 置" name="RESET" onclick="resetFunc()" class="btn-2word">&nbsp;<input type="button" value="取 消" name="CLOSE" onClick="cancelFunc()" class="btn-2word">

	  </p>
      </td>
   </tr>
</table>
 </form>
<p>
</p> </body>
</html>
