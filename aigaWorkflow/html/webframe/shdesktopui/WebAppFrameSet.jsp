<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/webframe/jspcommon/includedhead.jsp"%>
<%@ page import="com.ai.secframe.common.Constants"%>
<%@ page import="com.ai.appframe2.privilege.UserInfoInterface"%>
<%@ page import="com.asiainfo.csc.common.define.WorkFlowParam"%>

<ai:scriptinclude src="/jQuery/jquery-1[1].3.2.js"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<%
	String cxt = request.getContextPath();
	request.setAttribute("cxt",cxt);
%>
<%
    String 	curStaffName= g_GetUserInfo().getName();
    long 	curStaffId 	= g_GetUserInfo().getID();
    String 	curStaffCode= g_GetUserInfo().getCode();
    String 	userIp 		= g_GetUserInfo().getIP();
    String 	orgName 	= g_GetUserInfo().getOrgName();
    long 	orgId 		= g_GetUserInfo().getOrgId();	

    request.getSession().getServletContext().setAttribute("WORKFLOWPARAM",WorkFlowParam.getInstance());
	request.setCharacterEncoding("gbk"); 
	

	//�ٽ������ݾͿ������������ 
 	request.setAttribute("curStaffCode",curStaffCode);
 	request.setAttribute("orgNameStr", request.getSession().getAttribute("orgNameStr"));
%>

<html>
<head>
<title>�����������󿪷�����ƽ̨</title>
<meta content="text/html;charset=GBK" http-equiv="Content-Type">
<style>
td { font-size: 12px; color: #000000}
a {  font-family: Arial, "����"; font-size: 12px; color: #000000; text-decoration: none}
a:active {  font-family: "Arial,����"; font-size: 12px; color: #000000; text-decoration: none}
a:link {  font-family: "Arial,����"; font-size: 12px; color: #000000; text-decoration: none}
a:visited {  font-family: Arial, "����"; font-size: 12px; color: #000000; text-decoration: none}
a:hover {  font-family: "Arial,����"; font-size: 12px; color: #336699; text-decoration: none}
.hm {  font-family: Arial, "����"; font-size: 12px; color: #FFFFFF; text-decoration: none}
.hm:active {  font-family: "Arial,����"; font-size: 12px; color: #FFFFFF; text-decoration: none}
.hm:link {  font-family: "Arial,����"; font-size: 12px; color: #FFFFFF; text-decoration: none}
.hm:visited {  font-family: Arial, "����"; font-size: 12px; color: #FFFFFF; text-decoration: none}
.hm:hover {  font-family: "Arial,����"; font-size: 12px; color: #FF7800; text-decoration: none}
.td_font1 { width:54px; text-align :right; color:#FFFFFF; }
.font_white { color: #FFFFFF}
.font_note {color:#FF7800;font-weight: bold;}
.td_org { color:#FF8A00; } 
.title2 {color:#000000;filter:DropShadow(Color=#ffffff, OffX=1, OffY=1, Positive=2);font-size: 12px;text-decoration: none;}
.input_blue{font-size:12px;color:#000000; background-color: #D4E1F2; border-width:1px; border-style:solid; border-color:#749CB7;padding-top: 2px;padding-left: 3px;height: 20px;}
#frame_top{width: 100%;background-image: url(<%=request.getContextPath()%>/webframe/shdesktopui/images/top_bg.gif);border-width: 0px;border-style: dashed;border-color: #000000;height: 48px;}
#frame_top_logo{float: left;width: 233px;height: 48px;border-width: 0px;border-style: dashed;border-color: #000000;}
#frame_top_info{float: left;width: 50%;padding-top: 10px;border-width: 0px;border-style: dashed;border-color: #000000;}
#frame_top_welcome{float: left;width: 200px;padding-top: 32px;border-width: 0px;border-style: dashed;border-color: #000000;}
#frame_top_button{float: right;border-width: 0px;border-style: dashed;border-color: #000000;}
#frame_middle{width: 100%;margin: 0px;border-width: 0px;border-style: dashed;border-color: #000000;}
#frame_left{float: left;width: 200px;background-image: url(<%=request.getContextPath()%>/webframe/shdesktopui/images/left_bg.gif);background-position: bottom; background-repeat: repeat-x; display: block}
#menuTreeDiv{padding-left: 8px; padding-top: 8px;width: 200;height: expression(screen.height-283);overflow: auto;vertical-align: top;}
#frame_right{float: left;margin: 0 0 0 0;height: expression(screen.height-152);background-color: #FFFFFF;border-width: 0px;border-style: dashed;border-color: #000000;}
#frame_separator{float: left;width: 7px;height: expression(screen.height-152);background-image: url(<%=request.getContextPath()%>/webframe/shdesktopui/images/yuxin.gif);background-repeat: repeat-y; border-width: 0px;border-style: dashed;border-color: #000000;}
#frame_foot{height: 19px;align: center;text-align: center;background-image: url(<%=request.getContextPath()%>/webframe/shdesktopui/images/bottom_bg.gif);}
</style>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsv2/Globe_v2.jsp"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/floatbutton_v2.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/NormalRowSet.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/DBTree_v2.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/UIRelation_v2.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/Object_v2.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/PopMenu_v2.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/UserData_v2.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/DBTreeXmlModel.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/FieldType_v2.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/DataType_v2.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/CommUtil.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/DataSource_v2.js" type="text/javascript"></script>
<script language="JavaScript" src="js/MovePict.js"></script>
<script language="JavaScript">
//var TREE_CURNODE_CHILD_NO=null;
var TREE_CURNODE_IMG_STR=null;
var TREE_CURNODE_TEXT=null;
var TREE_CURNODE_URL_STR=null;
var TREE_CURNODE_VALUE=null;
function startdragFunc(){
  if (menuTree.getPathFromRoot()==null){return;}     
  TREE_CURNODE_VALUE=menuTree.getCurNodeValue();
  TREE_CURNODE_TEXT=menuTree.getCurNodeText();
  TREE_CURNODE_IMG_STR=getImgStr(TREE_CURNODE_VALUE);
  TREE_CURNODE_URL_STR=getUrlStr(TREE_CURNODE_VALUE);
}
function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}
/**
 * ע����ǰ�û�
 */
function Logout(){
   //���sosessiondata
   clearSoSessionData();
   var xml = null;
   var XMLSender = new ActiveXObject("Microsoft.XMLHTTP");
   var url = "<%=request.getContextPath()%>/baseserver?EventID=2";
   XMLSender.Open("POST",url,false);
   XMLSender.setrequestheader("content-type","application/x-www-form-urlencoded");
   XMLSender.send(xml);
   var reInfo = XMLSender.responseText;
   var xml= new ActiveXObject("Msxml.DOMDocument");
   xml.async = false;
   var bload = xml.loadXML(reInfo);
   var xmlNode = xml.documentElement;
   if(xmlNode.baseName=="LOGIN_OUT"){
       top.location="<%=request.getContextPath()%>/index.jsp";
   }else{
     var ud = createUserDataClass(xmlNode);
     if(ud==null)
		top.location="<%=request.getContextPath()%>/index.jsp";
     if (ud.getValueByName("LOGIN_FLAG") == "Y"){ //ע���ɹ�
	top.location = ud.getValueByName("MESSAGE");
      }
     else{//ע��ʧ��
	alert(ud.getValueByName("MESSAGE"));
      }
    }
}
//�޸�����
function chpassword(){
    var isAllowPassword ="Y";
    var staffCode = "<%=curStaffCode%>";
    if (isAllowPassword == "Y"){
      var flag = window.showModalDialog("<%=request.getContextPath()%>/secframe/orgmodel/staff/ChPasswordByCode.jsp?staff_id=<%=curStaffId%>&code=${curStaffCode}",'',"scroll:no;resizable:no;status:no;dialogHeight:235px;dialogWidth:280px");
    }else{alert("��ǰԱ�����޸����������Ȩ��");}
}

function openDesk(){
  mainFrame.openUrl("Desktop.jsp","����");
}
function closeWindow(){
  PostInfo("<%=request.getContextPath()%>/business/com.ai.secframe.web.SecFrameAction?action=loginOut");
}
//����iframe��onactive�¼�,ִ�������ܵ����SoSessionData����
//var staticSrc = "";
function clearSoSessionData(){
  closeWindow();
  return;
  //ɾ�������session����,�ͷŶ������ŵ�����.
   var reVal = PostInfo(_gModuleName+"/business/com.asiainfo.boss.so.web.SoFrameAction?action=clearSoSessionData","");
   if(reVal.getValueByName("FLAG")=="ERROR"){
     alert("ɾ�����������ݳ��ִ���.����ԭ��:"+reVal.getValueByName("MESSAGE"));
   }
}

/* ����/��ʾ��ߴ��� by hequ */
function changLeftBar(){
  if (document.all.leftFrame.style.display=='block'){
    document.all.leftFrame.style.display='none';
    document.all.imgLeft.src="images/toright.gif";
    //mainFrame.contentFrame.location = url_position_page;
  }else
     if(document.all.leftFrame.style.display=='none')   
  {document.all.leftFrame.style.display='block';
  document.all.imgLeft.src="images/toleft.gif";
  //mainFrame.contentFrame.location = url_position_page;
  }   
 }
function openUrl(url,name){
  //publicFrame_clearGlobal();
  top.url_position.innerText = name;
  mainFrame.contentFrame.location = url;
  top.url_position_page = url;
}
//-->
</script>
</head>
<body style="overflow:none; margin:0" onLoad="timer();'images/clientview_hover.gif','images/check_hover.gif','images/chpassword_hover.gif','images/openDesk_hover.gif','images/releaseNotify_hover.gif','images/Logout_hover.gif'" onUnload="closeWindow()" >
<!-- Ӧ�ýṹ��� -->
<div style="width:100%; overflow:auto; margin:0 border-width: 0px;">
	<!--top ��ʼ -->
	<div id="frame_top">
		<div id="frame_top_logo">
			<img src="images/logo.jpg">
		</div>
		<div id="frame_top_info">
			<ul>
				<li><span class="font_note">
					<script language="javascript">
		    			var time=new Date();
		    			month=time.getMonth()+1;
					    day=time.getDate();
					    year=time.getYear();
					    var date=time.getDay();
					    document.write(year+"��");
					    document.write(month+"��"+day+"��");
						var week=new Array(6);
		  				week[0] ="������";
					    week[1] ="����һ";
		 				week[2] ="���ڶ�";
		  				week[3] ="������";
		  				week[4] ="������";
		  				week[5] ="������";
		  				week[6] ="������";
		  				document.write(week[date]);
					</script>
					</span>
				</li>
				<li><span class="font_note">
					${orgNameStr}��<%=curStaffName%>
					<script language="JavaScript">
		  				var mess1="";
		    			day=new Date( );
		    			hr=day.getHours( );
		    			if ((hr>=0)&&(hr<4))mess1="�賿��";
		    			if ((hr>=4)&&(hr<7))mess1="�峿��";
		    			if ((hr>=7)&&(hr<12))mess1="���Ϻ�";
		    			if ((hr>=12)&&(hr<14))mess1="�����";
		    			if ((hr>=14)&&(hr<19))mess1="�����";
		    			if ((hr>=19)&&(hr<23))mess1="���Ϻ�";
		    			if ((hr>=23)&&(hr<24))mess1="��ҹ��";
		   				document.write(mess1)
			 		</script>
				</li>
				<li><span class="font_note">��ӭ����¼�����������󿪷�����ƽ̨</span></li>
			</ul>
		</div>
		<div id="frame_top_button" style="margin: 20px 10px 0 5px; align: right; valign:middle" >
		<!-- �ճ�ͼ�� -->
			<a style="align: right; valign:middle"  href="###" onClick="openDesk1()" ><img src="<%=request.getContextPath()%>/webframe/shdesktopui/images/BOSS.png" name="boss" border="0" alt="��ʾ��Ϣ��BOSS"></a>&nbsp;&nbsp;
			<a style="align: right; valign:middle"  href="###" onClick="openDesk2()" ><img src="<%=request.getContextPath()%>/webframe/shdesktopui/images/QC.png" name="qc" border="0" alt="��ʾ��Ϣ��QC"></a>&nbsp;&nbsp;
			<a style="align: right; valign:middle"  href="###" onClick="openDesk3()" ><img src="<%=request.getContextPath()%>/webframe/shdesktopui/images/test.png" name="test" border="0" alt="��ʾ��Ϣ������ϵͳ"></a>&nbsp;&nbsp;
		<!-- // -->
			<a style="align: right; valign:middle"  href="###" onClick="openDesk()" ><img src="<%=request.getContextPath()%>/webframe/shdesktopui/images/desk.gif" name="Image1" border="0" alt="��ʾ��Ϣ������ҳ��"></a>&nbsp;&nbsp;
		<!--<a style="align: right; valign:middle"  href="###" onClick="openCount()"><img src="<%=request.getContextPath()%>/webframe/shdesktopui/images/count.gif" name="Image2" border="0" alt="��ʾ��Ϣ������ͳ��"></a>&nbsp;&nbsp;  -->
			<a style="align: right; valign:middle"  href="###" onClick="openHelp()" ><img src="<%=request.getContextPath()%>/webframe/shdesktopui/images/help.gif" name="Image3" border="0" alt="��ʾ��Ϣ��������Ϣ"></a>&nbsp;&nbsp;
			<a style="align: right; valign:middle"  href="###" onClick="chpassword()" ><img src="<%=request.getContextPath()%>/webframe/shdesktopui/images/chpass.gif" name="Image5" border="0" alt="��ʾ��Ϣ���޸�����"></a>&nbsp;&nbsp;
			<a style="align: right; valign:middle" href="###" onClick="Logout()" ><img src="<%=request.getContextPath()%>/webframe/shdesktopui/images/exit.gif" name="Image4" border="0" alt="��ʾ��Ϣ���˳�ϵͳ"></a>&nbsp;&nbsp;
		</div>
	</div>
	<!--top ���� -->
	<div id="frame_middle">
		<div id="frame_left">
			<table width="200" border="0" cellspacing="0" cellpadding="0">
       			<tr>
       				<td valign="top">
  						<table width="200" border="0" cellpadding="0" cellspacing="0" background="images/left_menu_bg01.gif">
           					<tr>
              					<td width="56" height="24" align="right"><img src="images/icon_login.gif"></td>
              					<td valign="middle" class="title2" >�� Ϣ �� ʾ </td>
           					</tr>
        				</table>
       				</td>
       			</tr>
        		<tr>
        			<td align="center" valign="top" id="tlb" style="display:block" bgcolor="#FFFFFF">
  						<table width="160" border="0" cellspacing="0" cellpadding="0">
					        <tr><td valign="middle" style="line-height:80px"  onclick="myWorkOrderDisplay()" > ���У�<span class="font_note" id="sysWorkOrderCount" ></span> ��������Ϣ</td></tr>
				          <!--  <tr><td valign="middle" style="line-height:20px"  onclick="myAlarmDisplay()"     > ���У�<span class="font_note" id="sysAlarmCount"></span> ���澯��Ϣ</td></tr>
				            <tr><td valign="middle" style="line-height:20px"  onclick="myPalarmDisplay()"    > ���У�<span class="font_note" id="sysPalarmCount"	></span> ��Ԥ����Ϣ</td></tr>
				            <tr><td valign="middle" style="line-height:20px"  onclick="myNaticeDisplay()"    > ���У�<span class="font_note" id="sysNaticeCount" 	></span> ��֪ͨ��Ϣ</td></tr> -->
        				</table>
  					</td>
        		</tr>
   			</table>
			<table width="200" border="0" cellspacing="0" cellpadding="0">
         		<tr>
         			<td valign="top">
         				<table width="200" border="0" cellpadding="0" cellspacing="0" background="images/left_menu_bg01.gif">
            				<tr height="24" >
				                <td width="56" height="24" align="right"><img src="images/icon_tree.gif"></td>
				                <td valign="middle" class="title2">�� �� �� ��</td>
            				</tr>
         				</table>
	  				</td>
         		</tr>
    	  		<tr>
    	  			<td align="left" valign="top">
			  		    <%
						   long domain_id = 1;
						   String xml = com.ai.appframe2.privilege.UserManagerFactory.getUserManager().getUserMenuXml(global_UserInfo.getCode(),"H",domain_id);
						   out.print("<div style=\"display:none\" id=\"FUNC_INFO\">");
						   out.print(xml);
						   out.print("</div>");
					    %>
	    				<div id="menuTreeDiv"></div>
	    				<div id="slidemenubar2"></div>
	    				<script language="JavaScript" src="js/floatmenu.js"></script>
    	  			</td>
    	  		</tr>
    		</table>
		</div>
		<div id="frame_separator">
		</div>
		<div id="frame_right">
			<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF" >
			 
			 <!--�ұ��� headline ��ʼ -->
			 	<tr><td valign="top" height="24">
       				<table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0" background="images/title_bg.gif">
						<tr>
							<td width="10"><img src="images/title_left.gif"></td>
							<td valign="middle" align="left"><a href="###" onClick="openUrlposition()"><label id="url_position" >����</label></a></td>
							<td align="right" width="40"><img src="images/title_right.gif"></td>
						</tr>
	   				</table>
	   			</td></tr>
		  <!--�ұ��� headline ���� -->
		  <!--�ұ��� ���� ��ʼ -->
     			<tr>
     				<td valign="top" >
     		 			<iframe id="mainFrame" src="Menu.jsp" height="100%" width="100%" frameborder="0" scrolling='NO'> </iframe>
    				</td>
     			</tr>
     		</table>
		</div> 
		<div id="frame_foot" class="font_white">
			
		</div>
	</div>
</div>
</body>
<script LANGUAGE="JavaScript">	
var url_position_page="Desktop.jsp";
var url_position = document.all("url_position");
menuTree.addListener(S_OnChange,new Tree_DbClickListener(""));
function setUrl_position(url,name){
  url_position.innerText =  name ;
  url_position_page=url;
  mainFrame.contentFrame.location = url_position_page;
}
function openUrlposition(){
  mainFrame.contentFrame.location = url_position_page;
}
function createRowSetFactoryInHidden(aUrl,aWindow){
   	alert("aUrl="+aUrl);
   	var tmpG = createRowSetFactory(aUrl,aWindow);
   	return tmpG;
}
function createRowSetFactoryInHiddenByView(aViewName,aEventID,aPara){
  	var tmpG = createRowSetFactoryByView(aViewName,aEventID,aPara)
  	return tmpG;
}
function createNewRowSetFactory(){
  var tmpG = new RowSetFactoryClass();
  return tmpG;
}
function Tree_DbClickListener(name){  
  this.Name = name;
  this.execute = function(event){	
  var urlStr = getUrlStr(menuTree.getCurNodeValue());
  var index = urlStr.toLowerCase().indexOf("http://");
  if(index>=0){
    urlStr = urlStr.substring(index);
  }
  var imgStr = getImgStr(menuTree.getCurNodeValue());
  var aMenuId=menuTree.getCurNodeValue();
  var aMenuName=menuTree.getCurNodeText();
  if(urlStr==""){
	 alert("����[ " + aMenuName +" ]���ڽ����� ......");
	 return;
  }
   openUrl(urlStr,aMenuName);
   //��¼�û����ʹ�õĲ˵� �����Ҫ�����ù��ܣ�����������ע�ʹ�
   //logUserMenuClick(aMenuId,aMenuName,urlStr);
   //openCloseMenu();
   }
}
 //  pull();
//��Ϣ��ʾ����������ֺ���
timerValue(); 
//-------------------function ��ʼ  
function   timerValue()   
{   
    var url = "<%=request.getContextPath()%>/business/com.asiainfo.csc.common.web.NoticeAction?action=queryNotice&staffId=<%=curStaffId%>&staffCode=${curStaffCode}";
    var result = PostInfo(url,null);
    var  sysWorkOrderCount=result.getValueByName("sysWorkOrderCount");
    //var  sysNaticeCount=result.getValueByName("sysNaticeCount");
    //var  sysPalarmCount=result.getValueByName("sysPalarmCount");
    //var  sysAlarmCount=result.getValueByName("sysAlarmCount");
    document.getElementById('sysWorkOrderCount').innerText = sysWorkOrderCount;  
    //document.getElementById('sysNaticeCount').innerText  = 	sysNaticeCount;  
    //document.getElementById('sysPalarmCount').innerText = 	sysPalarmCount;  
    //document.getElementById('sysAlarmCount').innerText= 		sysAlarmCount;  
}  
function timer(){
 setInterval("timerValue()",30*1000);
} 
 //-----------------���������Ϣ����Ӧ����Ӧ��ѯҳ��ĺ�����δ���
function myWorkOrderDisplay(){
 	//mainFrame.openUrl("${cxt}/aialm/query/aialm_notice_query.jsp?type=1&readstatus=1","");	
}
function myAlarmDisplay(){
	mainFrame.openUrl("${cxt}/aialm/query/aialm_notice_query.jsp?type=3&readstatus=1","");	
} 
function myPalarmDisplay(){
	mainFrame.openUrl("${cxt}/aialm/query/aialm_notice_query.jsp?type=2&readstatus=1","");	
}
function myNaticeDisplay(){	
 	mainFrame.openUrl("${cxt}/aialm/query/aialm_notice_query.jsp?type=1&readstatus=1","");
 }
function openCount(){
	var url = '<%=request.getContextPath()%>/aialm/common/workOrderCount.jsp?showBigOrSmall=big';
	mainFrame.openUrl(url,"ͳ��")
}
function openHelp(){
	var url = '<%=request.getContextPath()%>/csc/common/aialmHelp.jsp';
	mainFrame.openUrl(url,"����")
}
function openDesk1(){
	window.open('http://172.31.81.123/boss','','height=500,width=611,scrollbars=yes,status =yes');
}
function openDesk2(){
	window.open('http://172.20.252.103:8080/qcbin/','','height=500,width=611,scrollbars=yes,status =yes');
}
function openDesk3(){
	window.open('http://172.20.252.101:81/examv6/index.htm','','height=500,width=611,scrollbars=yes,status =yes');
}
</script>
</html>