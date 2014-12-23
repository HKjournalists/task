<%@ page contentType="text/html; charset=GBK" %>
<%@page import="com.ai.webframe.Menu"%>
<%@page import="com.ai.webframe.Util"%>
<%@ include file="/webframe/jspcommon/includedhead.jsp"%>
<%@ page import="com.ai.secframe.common.Constants"%>
<%@ page import="com.asiainfo.csc.common.define.WorkFlowParam"%>
<ai:scriptinclude src="/jQuery/jquery-1[1].3.2.js"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<%
	String cxt = request.getContextPath();
	request.setAttribute("cxt",cxt);
    String 	curStaffName= g_GetUserInfo().getName();
    long 	curStaffId 	= g_GetUserInfo().getID();
    String 	curStaffCode= g_GetUserInfo().getCode();
    String 	userIp 		= g_GetUserInfo().getIP();
    String 	orgName 	= g_GetUserInfo().getOrgName();
    long 	orgId 		= g_GetUserInfo().getOrgId();	

    request.getSession().getServletContext().setAttribute("WORKFLOWPARAM",WorkFlowParam.getInstance());
	request.setCharacterEncoding("gbk"); 
	

	//再接收数据就可以正常输出了 
 	request.setAttribute("curStaffCode",curStaffCode);
 	
 	request.setAttribute("orgNameStr", orgName);
%>

<html>
	<head>
		<title>测试管理平台后台系统</title>
		<link type="text/css" rel="stylesheet" href="theme/default/styles/main.css" />
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
		<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="js/setState.js"></script>
		<script type="text/javascript" src="js/scrollWord.js"></script>
		
		<script language="JavaScript">
			//var TREE_CURNODE_CHILD_NO=null;
			var TREE_CURNODE_IMG_STR=null;
			var TREE_CURNODE_TEXT=null;
			var TREE_CURNODE_URL_STR=null;
			var TREE_CURNODE_VALUE=null;
			
			function MM_findObj(n, d) { //v4.01
			  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
			    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
			  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
			  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
			  if(!x && d.getElementById) x=d.getElementById(n); return x;
			}
			function Logout(){
			   //清除sosessiondata
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
			     if (ud.getValueByName("LOGIN_FLAG") == "Y"){ //注销成功
				top.location = ud.getValueByName("MESSAGE");
			      }
			     else{//注销失败
				alert(ud.getValueByName("MESSAGE"));
			      }
			    }
			}
			//修改密码
			function chpassword(){
			    var isAllowPassword ="Y";
			    var staffCode = "<%=curStaffCode%>";
			    if (isAllowPassword == "Y"){
			      var flag = window.showModalDialog("<%=request.getContextPath()%>/secframe/orgmodel/staff/ChPasswordByCode.jsp?staff_id=<%=curStaffId%>&code=${curStaffCode}",'',"scroll:no;resizable:no;status:no;dialogHeight:235px;dialogWidth:280px");
			    }else{alert("当前员工无修改自身密码的权限");}
			}
			
			function openDesk(){
			  mainFrame.openUrl("Desktop.jsp","桌面");
			}
			function closeWindow(){
			  PostInfo("<%=request.getContextPath()%>/business/com.ai.secframe.web.SecFrameAction?action=loginOut");
			}
			//绑订主iframe的onactive事件,执行受理框架的清除SoSessionData动作
			//var staticSrc = "";
			function clearSoSessionData(){
			  closeWindow();
			  return;
			  //删除受理的session数据,释放对受理集团的锁定.
			   var reVal = PostInfo(_gModuleName+"/business/com.asiainfo.boss.so.web.SoFrameAction?action=clearSoSessionData","");
			   if(reVal.getValueByName("FLAG")=="ERROR"){
			     alert("删除受理缓冲数据出现错误.错误原因:"+reVal.getValueByName("MESSAGE"));
			   }
			}
			
			/* 隐藏/显示左边窗口 by hequ */
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
			
			function setTab(name,cursel,n){
				for(i=1;i<=n;i++){
				var menu=document.getElementById(name+i);
				var con=document.getElementById("con_"+name+"_"+i);
				menu.className=i==cursel?"current":"";
				con.style.display=i==cursel?"block":"none";
				}
			}
		
		</script>
	
	</head>
	<body style=" margin:0;overflow: hidden;" onLoad="'images/Logout_hover.gif'" onUnload="closeWindow()" >
		<!-- 应用结构框架 -->
		
		<%
			long domain_id = 1;
			String menuXml = com.ai.appframe2.privilege.UserManagerFactory.getUserManager().getUserMenuXml(global_UserInfo.getCode(),"H",domain_id);
			menuXml = menuXml.replaceAll("&","&amp;");
			//System.out.println(menuXml);
			Menu menu = Util.ri(menuXml);
			List<Menu> levelOne = menu.getChildren();
			
			
		%>
		<div id="frameBodyDiv" class="wrapper" style="">
			<div class="menu" style="overflow-x: hidden;"><!-- menu -->
			
				<div class="menu_top">
					<div class="menu_info">
						<span class="corner_left">&nbsp;</span>
						<ul><!-- 当前：current -->
							<%
								for(int i=0,length=levelOne.size();i<length;i++){
							%>
								
								<li <%if(i==0){%>class="current"<%}%> id="one<%=i+1%>" onclick="setTab('one',<%=i+1%>,<%=length%>);location.href='javascript:void(0)'"><em><%=levelOne.get(i).getCaption()%></em></li>
								
							<%
								}
							%>
						</ul>
						<span class="corner_right">&nbsp;</span>
					</div>
					
					<div class="user_info">
						<p><%=curStaffName%>(${orgNameStr})</p>
						<span title="版本信息" onclick="showVer()" class="span1"></span>
						<span title="退出系统" onclick="Logout();" class="span2"></span>
					</div>
					
				</div>
					
				<%
					for(int i=0,length=levelOne.size();i<length;i++){
				%>
				<div class="meun_btm" id="con_one_<%=i+1%>"  <%if(i==0){%>style="display:block;"<%}else{ %>style="display:none;"<%} %>>
					<span class="menu_btm_left">&nbsp;</span>
					<ul><!-- 当前:current -->
						<%
						List<Menu> secondList = levelOne.get(i).getChildren();
						if(secondList!=null&&secondList.size()>0){
							for(int j=0,secLength=secondList.size();j<secLength;j++){
								Menu menu2 = secondList.get(j);
								String url = menu2.getUrl();
								if(url==null||"".equals(url.trim())||"null".equals(url.trim().toLowerCase())){
									url="javascript:void(0)";
								}else{
									url = url.trim().replaceAll("&amp;","&");
								}
								String img = menu2.getImg();
								//System.out.println(img);
								if(img==null||"".equals(img.trim())||"null".equals(img.trim().toLowerCase())){
									img="/webframe/shdesktopui/theme/default/images/ic01.gif";
								}
						%>
								<li><a href="javascript:void(0)" onclick="javascript:opUrl('<%=cxt+url%>');return false;" onfocus="this.blur()"><em><img src="<%=cxt+img%>" /></em><%=menu2.getCaption()%></a>
								<%
									List<Menu> thirdList = menu2.getChildren();
									if(thirdList!=null&&thirdList.size()>0){
										int thirdLength = thirdList.size();
										int height = 6 + 24 * thirdLength;
								%>
								<!--
								<iframe style="height:150px;" frameborder="0"></iframe>
								 需要赋值该iframe高度: 126px = 6px + 24px * 5（三级栏目个数） -->
								<ul class="third_menu">
								<% 
										for(int k=0;k<thirdLength;k++){
											Menu menu3 = thirdList.get(k);
											String url3 = menu3.getUrl();
											url = url.replaceAll("&amp;","&");
											List<Menu> fourthList = menu3.getChildren();
								%>
								
									<li><a href="javascript:void(0)" onclick="javascript:opUrl('<%=cxt+url3%>');return false;" onfocus="this.blur()"><%=menu3.getCaption()%></a>
									<%
										if(fourthList != null && fourthList.size() > 0) {
									%>
										<!-- 抄袭上面的iframe 
										<iframe style="height:150px;" frameborder="0"></iframe>
										-->
										<ul class="fourth_menu">
									<%
											for(int l = 0; l < fourthList.size(); l++) {
												Menu menu4 = fourthList.get(l);
												String url4 = menu4.getUrl();
												url = url.replaceAll("&amp;","&");
									%>
										<li><a href="javascript:void(0)" onclick="javascript:opUrl('<%=cxt+url4%>');return false;" onfocus="this.blur()"><%=menu4.getCaption()%></a></li>
										
									<%
											}
									%>
										</ul>
									<%
										}
									%>
									</li>
								
								<%
										}
								%>
								</ul>
								<%
									}
								%>
								</li>
					<%		
							}%>
							<%
						}
					%>
						
					</ul>
					<div class="arrow"><!-- 右侧箭头 -->
						<span class="al" title="" onclick=""></span>
						<span class="ar" title="" onclick=""></span>
					</div>
					<span class="menu_btm_right">&nbsp;</span>
					<div class="leftMask">&nbsp;<!--  --></div>
				</div>
				
				<%
					}
				%>		
				
						
			</div>
			
			<span class="maskL">&nbsp;</span>
			<span class="maskR">&nbsp;</span>
		
			<div class="mainContent"><!-- frame start -->
					<iframe id="mainFrame" src="Menu.jsp" height="100%" width="100%" frameborder="0" scrolling='yes'></iframe>
			</div><!-- frame stop -->
		
		</div>
	</body>
	<script LANGUAGE="JavaScript">	
		var url_position_page="Desktop.jsp";
		var url_position = document.all("url_position");
		
		function opUrl(url){
			if(!("<%=cxt%>javascript:void(0)"==url || "<%=cxt%>null" == url )){
				var indexSt = url.indexOf("http://");
				if(indexSt > -1) {
					url = url.substring(indexSt);
				}
				document.getElementById('mainFrame').setAttribute("src",url)
			    document.getElementById('mainFrame').contentWindow.location=document.getElementById('mainFrame').src;
			    //reHeightMainIframe();
			}
		}
		
		
		
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
		
		function showVer() {
			window.showModalDialog("help.jsp?random="+Math.random(),"","dialogWidth=400px;dialogHeight=300px;status=no;");
		}
		
		function timer(){
		 setInterval("timerValue()",30*1000);
		} 
		
		
		function clearCurrent(){
			var new_menu=$(".menu");
			//alert(new_menu.children(".meun_btm").children("ul").children("li").html());
			new_menu.children(".meun_btm").children("ul").children("li").removeClass("current");
		}
	</script>
</html>