<!DOCTYPE html>
<%@page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai" %>
<html>
	<head>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" /> 
	<title>测试管理平台后台系统</title>
	<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/webframe/shdesktopui/theme/default/styles/login.css" />
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
		  var acc = document.getElementById("UserAccount").value;
	      var psw = document.getElementById("UserPwd").value;
	      if(acc==null||acc==""){
	      	alert("请输入工号");
	      	document.getElementById("UserAccount").focus();
	      	return false;
	      }
	       if(psw==null||psw==""){
	      	alert("请输入密码");
	      	document.getElementById("UserPwd").focus();
	      	return false;
	      }
	     // var vertifycode = "";
	     //if(isVertifyCode){
	     //  vertifycode = new String(document.getElementById("UserVertifyCode").value);
	     //}    
	     //var blank = "   " ;
	     //if(isVertifyCode && blank.indexOf(vertifycode)!=-1){
	     //  alert("用户校验码不能为空");
	     //  document.getElementById("UserVertifyCode").focus();
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
	    var acc = new String(document.getElementById("UserAccount").value);
	    var psw = new String(document.getElementById("UserPwd").value);
	    var vertifycode = "";
	    if(isVertifyCode){
	      vertifycode = new String(document.getElementById("UserVertifyCode").value)
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
		  document.getElementById("UserVertifyCode").value="";
		  document.all.item("vertifyCodeImg").src="<%=request.getContextPath()%>/vertifycodeservlet";
	      }
	      var xStr = ud.getValueByName("MESSAGE");
		  //alert(xStr);
		  if(xStr=="密码不正确!")
		  {
		     document.getElementById("UserPwd").value="";
			 document.getElementById("UserPwd").focus();
		 	 document.getElementById("UserPwd").focus();
		  }
		  else
		  {
		 	 document.getElementById("UserAccount").value="";
			 document.getElementById("UserPwd").value="";
		     document.getElementById("UserAccount").focus();
		 	 document.getElementById("UserAccount").focus();
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
	    + document.getElementById("UserAccount").value,
	    '',"scroll:no;resizable:no;status:no;dialogHeight:310px;dialogWidth:380px");
	
	 }
	    /**
	    * 输入重置
	    * @return
	    */
	   function Reset()
	   {
	      document.getElementById("UserAccount").value="";
	      document.getElementById("UserPwd").value="";
	      document.getElementById("UserAccount").focus();
	
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
	 <script src="<%=request.getContextPath()%>/jsv2/FormRowSet.js"></script>
	 <style type="text/css">
		.contentArea {
			padding-top: 30px;
			width: 600px;
			height: 300px;
			background: rgb(230,230,230);
			position: fixed;
			left: 380px;
			top: 120px;
			z-index: 2;
			display: none;
		}
		
		.contentTable {
			line-height: 50px;
			height: 150px;
			font-size: 14px;
		}
		
		.filterDiv {
			position: fixed;
			width: 100%;
			height: 100%;
			left: 0px;
			top: 0px;
			filter: Alpha(opacity=60);
			background: rgb(0,0,0);
			z-index: 1;
			display: none;
		}
		
		.sendBtn {
			height: 30px;
			text-align: center;
			vertical-align: middle;
		}
		
		.closeArea {
			width: 20px;
			height: 20px;
			position: relative;
			left: 260px;
			bottom: 10px;
			cursor: pointer;
		}
		
		</style>
	</head>

	<body>
		<div class="loginArea">
			<div>
				<form name="form1" method="post" action="">
					<span class="login_txt">用户名：</span>
					<span class="login_ipt">
							<input type="text" id="UserAccount" onkeypress="JumpByEnter(UserPwd)" name="text" value="" />
					</span>
					<span class="login_txt">密码：</span>
					<span class="login_ipt">
							<input type="password" id="UserPwd" onkeypress="IsEnterKeyPress()" name="Input" value="" />
					</span>
					<span class="login_btn">
						<input id="loginIMG" name="" type="button" value="登录系统" onmouseover="this.className='loginBtnHover'" onmouseout="this.className=''" onclick="Login()" />
						<input id="passwordIMG" name="" type="button" value="密码管理" onmouseover="this.className='loginBtnHover'" onmouseout="this.className=''" onclick="pwdManage()" style="margin-left: 6px;display: none;" />
					</span>
				</form>
			</div>
		</div>
		
		<div id="filterDiv" class="filterDiv"></div>
		<div id="contentArea" class="contentArea">
		<img class="closeArea" src="<%=request.getContextPath()%>/images/del2.png" onclick="closePwd()" title="关闭" />
		<ai:dbform formid="dbformStaff" setname="com.ai.secframe.bo.orgmodel.SysStaff"
	    	initial="false" editable="false">
	     	<ai:dbformfield formid="dbformStaff" fieldname="CODE"  visible="false" />
	     	<ai:dbformfield formid="dbformStaff" fieldname="PASSWORD"  visible="false" />
	     	<ai:dbformfield formid="dbformStaff" fieldname="STAFF_ID"  visible="false" />
	     	<ai:dbformfield formid="dbformStaff" fieldname="EMPLOYEE_ID"  visible="false" />
		</ai:dbform>
		<ai:dbform formid="dbformEmployee" setname="com.ai.secframe.bo.orgmodel.SysEmployee"
			initial="false" editable="false">
			<ai:dbformfield formid="dbformEmployee" fieldname="EMPLOYEE_NAME"  visible="false" />
			<ai:dbformfield formid="dbformEmployee" fieldname="BILL_ID"  visible="false" />
			<ai:dbformfield formid="dbformEmployee" fieldname="CARD_TYPE_ID"  visible="false" />
			<ai:dbformfield formid="dbformEmployee" fieldname="CARD_NO"  visible="false" />
			<ai:dbformfield formid="dbformEmployee" fieldname="EMAIL"  visible="false" />
		</ai:dbform>
		<table class="contentTable">
			<tr>
				<td class="title_e">手机号：</td>
				<td><input type="text" id="emailText" class="dbform_disable_style" disabled="disabled" style="width: 200px;" /></td>
			</tr>
			<tr>
				<td class="title_e">处理方式：</td>
				<td>
					<select id="dealWay" onchange="changeDealWay()" style="width: 200px;">
						<option value="">--请选择--</option>
						<option value="find" selected="selected">密码找回</option>
						<option value="reset">密码修改</option>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="button" class="sendBtn" id="sendMsgBtn" value="发送到邮箱" onclick="sendMail()" style="display:none;" />
					<input type="button" class="sendBtn" id="sendBtn" value="发送到手机" onclick="sendMsg()" />
				</td>
			</tr>
		</table>
		<table id="modifyTbl" style="display: none;">
			<tr>
				<td class="title_e">验证码：</td>
				<td><input type="text" id="verifyCode" class="dbform_inputfield_style" style="width: 200px;" /></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><ai:button text="修改密码" onclick="changePwd()" /></td>
			</tr>
		</table>
		<div id="explainDiv" style="display: none;">短信已发送，请提取密码并关闭此对话框
		</div>
		</div>
	</body>
	<script type="text/javascript">
	  	var dbformStaff = g_FormRowSetManager.get("dbformStaff");
	  	var dbformEmployee = g_FormRowSetManager.get("dbformEmployee");
		var contentArea = document.getElementById("contentArea");
		var filterDiv = document.getElementById("filterDiv");
	  	var dealWay = document.getElementById("dealWay");
	  	var modifyTbl = document.getElementById("modifyTbl");
	  	var explainDiv = document.getElementById("explainDiv");
	  	
	  	document.getElementById("UserAccount").focus();
	  	
		function pwdManage() {
			//var url = "<%=request.getContextPath()%>/secframe/orgmodel/staff/IdentifyCode.jsp";
			var acc = document.getElementById("UserAccount").value;
			if(acc == "") {
				alert("请填写用户账号信息");
				return;
			}
			//url += "?code="+acc+"&random="+Math.random();
			//window.open(url,"","");
			pwdManageNext();
		}
	  	
	  	function pwdManageNext() {
	  		var condition = "code='"+document.getElementById("UserAccount").value.toUpperCase()+"'";
	  		dbformStaff.refresh(condition);
	  		var staffId = dbformStaff.getValue("STAFF_ID");
	  		if(staffId == "" || staffId == "0") {
	  			alert("您输入的工号有误，请重新输入！");
	  			return;
	  		}
	  		var employeeId = dbformStaff.getValue("EMPLOYEE_ID");
	  		dbformEmployee.refresh("employee_id="+employeeId);
	  		var phone = dbformEmployee.getValue("BILL_ID");
	  		if(phone == "") {
	  			alert("您的账号信息中没有手机信息，请联系相关人员添加！");
	  			document.getElementById("sendBtn").disabled = true;
	  			return;
	  		}
	  		emailText.value= phone;
	  		document.getElementById("filterDiv").style.display = "block";
	  		filterDiv.style.display = "block";
	  		contentArea.style.display = "block";
	  		document.getElementById("UserAccount").blur();
	  	}
	  	
	  	function sendMail() {
	  		var index = dealWay.selectedIndex;
	  		var selVal = dealWay.options[index].value;
	  		if(selVal == "") {
	  			alert("请选择处理方式");
	  			return;
	  		}
	  		var url = "<%=request.getContextPath()%>/business/com.ai.secframe.web.PwdManageAction?action=sendMailAction&type="+selVal;
	  		var list = new Array();
	  		list.push(dbformStaff);
	  		list.push(dbformEmployee);
	  		var result = saveRowSet(url,list,true,false);
	  		var retVal = result.getValueByName("retVal");
	  		if(retVal == "Y") {
	  			alert("邮件发送成功！");
	  			if(selVal == "find") {
	  				document.getElementById("sendBtn").disabled = true;
	  				explainDiv.style.display = "block";
	  			}
	  		} else if(retVal == "O") {
	  			alert("您在一分钟内刚刚发送了邮件，请查收，如需重发请稍等");
	  		} else {
	  			alert("邮件发送失败");
	  			return;
	  		}
	  	}
	  	
	  	function sendMsg() {
	  		var index = dealWay.selectedIndex;
	  		var selVal = dealWay.options[index].value;
	  		if(selVal == "") {
	  			alert("请选择处理方式");
	  			return;
	  		}
	  		var url = "<%=request.getContextPath()%>/business/com.ai.secframe.web.PwdManageAction?action=sendMsgAction&type="+selVal;
	  		var list = new Array();
	  		list.push(dbformStaff);
	  		list.push(dbformEmployee);
	  		var result = saveRowSet(url,list,true,false);
	  		var retVal = result.getValueByName("retVal");
	  		if(retVal == "Y") {
	  			alert("短信发送成功！");
	  			if(selVal == "find") {
	  				document.getElementById("sendBtn").disabled = true;
	  				explainDiv.style.display = "block";
	  			}
	  		} else if(retVal == "O") {
	  			alert("您在五分钟内刚刚发送了短信，请查收，如需重发请稍等");
	  		} else {
	  			alert("短信发送失败");
	  			return;
	  		}
	  	}
	  	
	  	function changeDealWay() {
	  		var index = dealWay.selectedIndex;
	  		var selVal = dealWay.options[index].value;
	  		explainDiv.style.display = "none";
	  		if(selVal == "") {
	  			modifyTbl.style.display = "none";
	  		} else if(selVal == "find") {
	  			modifyTbl.style.display = "none";
	  		} else {
	  			modifyTbl.style.display = "block";
	  		}
	  	}
	  	
	  	function changePwd() {
	  		var inputVerifyCode = document.getElementById("verifyCode").value;
	  		if(inputVerifyCode == "") {
	  			alert("请查收短信获取验证码并输入");
	  			return;
	  		}
	  		var staffId = dbformStaff.getValue("STAFF_ID");
	  		if(inputVerifyCode == frmVerifyCode) {
	  			window.showModalDialog("secframe/orgmodel/staff/ChPassword.jsp?staff_id="+staffId,"scroll:no;resizable:no;status:no;dialogHeight:230px;dialogWidth:380px");
	  		} else {
	  			alert("您输入的验证码不正确，请输入最新获取的验证码！");
	  		}
	  	}
	  	
	  	function closePwd() {
	  		contentArea.style.display = "none";
	  		filterDiv.style.display = "none";
	  		document.getElementById("UserPwd").focus();
	  	}
  	
  </script>
</html>
