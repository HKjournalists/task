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
  var staff_id="<%=request.getParameter("staff_id")%>";
   
  if(gParam)
  {
     opId=gParam;
  }
  function chPassFunc()
  {
    
    var psw = document.all.item("UserPwd").value;
    var pswConfirm = document.all.item("UserPwdConfirm").value;

	if(psw.length<=0|| pswConfirm.length<=0)
	{
      top.returnValue = false;
      alert("密码,密码确认不能为空");
      return;
    }
	if(psw.length>10)
	{
	  alert("密码长度不能超过十位");
	  return;
	}
	if(psw.length<6)
	{
	  alert("密码长度不能小于六位");
	  return;
	}
	if(psw.indexOf(" ")>=0 || psw.indexOf("&")>=0 || psw.indexOf("^")>=0)
	{
	  alert("密码中间不允许有空字符或者‘&’,‘^’字符存在");
	  return;
	}
	//wugj modify  密码必须是字母和数字组合
	
	
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
    
    var msg = PostInfo("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysStaffAction?action=setSysStaffPassword&staff_id="+staff_id+"&password="+psw);
    
    var ret = msg.getValueByName("retVal");
    if(ret=="-1"){
	 alert(msg.getValueByName("msg"));
	 document.all.item("UserPwd").value="";
	 document.all.item("UserPwdConfirm").value="";
	 document.all.item("UserPwd").focus();

    }
    else
    {
      alert("重置密码成功！");
      cancelFunc();
    }
   }


   /**
    * 取消登录
    * @return
    */
   function cancelFunc(){
     top.returnValue=false;
     top.close();
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
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="8"></td>
  </tr>
</table>

<ai:contentframe id="" title="重置密码" contenttype="" width="98%" >	
<form name="LoginForm">
<table>
  <tr>
     <td>密码规则：长度在6-10位之间，包含大写字母、小写字母及数字。</td>
  </tr>
</table>
<table width="98%" border=0 align="center" cellpadding="1" cellspacing="1">
  <tr>
	 <td class="td_font">新设密码：</td>
     <td><input type="password" id="UserPwd" onKeyPress="JumpByEnter(UserPwdConfirm)"></td>
  </tr>
  <tr>
      <td class="td_font">密码确认：</td>
     <td><input type="password" id="UserPwdConfirm" onKeyPress="IsEnterKeyPress()"><td>
  </tr>
  <tr><td colspan=2 align="center" height="50">
	  <input type="button" value="确定" onClick="chPassFunc()" class="btn-2word">&nbsp;
	  <input type="button" value="重置" onClick="resetFunc()" class="btn-2word">&nbsp;
	  <input type="button" value="取消" onClick="cancelFunc()" class="btn-2word">
      </td>
   </tr>
</table>
 </form>
 </ai:contentframe>
</body>
</html>
