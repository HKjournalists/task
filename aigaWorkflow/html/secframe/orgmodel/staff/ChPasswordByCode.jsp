<%@ include file="/webframe/common/commonhead.jsp"%>
<%@ page contentType="text/html; charset=GBK" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��������</title>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/UserData_v2.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/Globe_v2.jsp"></script>
</head>
<script language="JavaScript">
   /**
   * ��������
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
    	alert("��½������Ϊ��");
    	document.all.item("UserCode").focus();
    	return;
    }
    if(old==""){
    	alert("�����벻��Ϊ��");
    	document.all.item("OldPass").focus();
    	return;
    }
    if(old==psw){
        alert("�����������벻����ͬ");
    	document.all.item("OldPass").focus();
    	return;
    }
	if(psw.length<=0|| pswConfirm.length<=0)
	{
      //top.returnValue = false;
      alert("����,����ȷ�ϲ���Ϊ��");
      return;
    }
	if(psw.length>12)
	{
	  alert("���볤�Ȳ��ܳ���12λ");
	  return;
	}
	if(psw.indexOf(" ")>=0 || psw.indexOf("&")>=0 || psw.indexOf("^")>=0)
	{
	  alert("�����м䲻�����п��ַ����ߡ�&��,��^���ַ�����");
	  return;
	}
	//wugj modify  �����������ĸ���������
	
	if(psw.length<6)
	{
	  alert("���볤�ȱ�������λ����");
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
	  alert("��������Ǵ�Сд��ĸ�����ֵ����");
	  document.all.item("UserPwd").focus();
	  return;
	}

    //alert("psw="+psw+" cpsw="+pswConfirm+"}");
	if(psw!=pswConfirm)
    {
      alert("�����������벻ͬ");
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
      alert("��������ɹ�,�����������½��");
      window.returnValue = "1";
      window.close();
    }
   }

   /**
    * ȡ����¼
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
	  <td class="FormTDName" width="120">��½����</td>
     <td><input type="text" id="UserCode" value="" onKeyPress="JumpByEnter(OldPass)" ></td>
  </tr>
<tr>
	  <td class="FormTDName" width="120">�����룺</td>
     <td><input type="password" id="OldPass" onKeyPress="JumpByEnter(UserPwd)" ></td>
  </tr>
  <tr>
	  <td class="FormTDName" width="120">�������룺</td>
     <td><input type="password" id="UserPwd" onKeyPress="JumpByEnter(UserPwdConfirm)" ></td>
  </tr>
  <tr>
      <td class="FormTDName" width="120">����ȷ�ϣ�</td>
     <td><input type="password" id="UserPwdConfirm" onKeyPress="IsEnterKeyPress()" ><td>
  </tr>
  <tr>
      <td class="FormTDName" width="120">�������</td>
     <td valign="bottom">������6-10λ֮�䣬������д��ĸ��Сд��ĸ�����֡�<td>
  </tr>
  <tr>
      <td class="FormTDName" width="120">��ϵ�ˣ�</td>
     <td valign="bottom">��������wangrp3@asiainfo.com<td>
  </tr>
  <tr>
      <td colspan=2 height="30"></td>
   </tr>
  <tr><td colspan=2>
	  <p align="center">
	  	
		  <input type="button" value="ȷ ��" onclick="chPassFunc()" name="OK" class="btn-2word">&nbsp;<input type="button" value="�� ��" name="RESET" onclick="resetFunc()" class="btn-2word">&nbsp;<input type="button" value="ȡ ��" name="CLOSE" onClick="cancelFunc()" class="btn-2word">

	  </p>
      </td>
   </tr>
</table>
 </form>
<p>
</p> </body>
</html>
