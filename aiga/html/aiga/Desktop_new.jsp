<!DOCTYPE HTML>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="com.asiainfo.aiga.common.security.user.Menu"%>
<%@page import="com.asiainfo.aiga.common.security.user.Util"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@page import="com.asiainfo.aiga.common.security.user.URLConnectUtil"%>
<%@include file="/aiga/common/common.jsp"%>
<%@page import="java.util.List"%>
<%
	String cxt = request.getContextPath();
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
	String workflowUrl = request.getSession().getAttribute("workflowUrl").toString();
	String menuStr = URLConnectUtil.getMenuXml(user.getUserAccount(), workflowUrl+"/business/com.ai.filter.AigaLoginMenu?action=getMenu");
%>
<html>
	<head>
		<title>测试管理平台</title>
		<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/style/main.css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/scrollWord.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/base/yanue.pop.js" ></script>
		<style type="text/css">
		.current em{color:#00f !important;}
		.current a{color:#00f !important;}
		</style>
	</head>
	<body style="overflow: hidden;">
		<!-- 应用结构框架 -->
		
		<%
			long domain_id = 1;
			String menuXml = "";
			//String menuXml = com.ai.appframe2.privilege.UserManagerFactory.getUserManager().getUserMenuXml(global_UserInfo.getCode(),"H",domain_id);
			menuXml = menuStr.replaceAll("&","&amp;");
			//System.out.println(menuXml);
			Menu menu = Util.ri(menuXml);
			List<Menu> levelOne = menu.getChildren();
		%>
		<form id="logoutForm" action="<%=request.getContextPath()%>/logout.do">
		</form>
		<div id="frameBodyDiv" class="wrapper" style="overflow:hidden">
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
						<p><%=user.getUserName() %></p>
						<span title="退出系统" onclick="Logout()" class="span2"></span>
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
									img="/css/images/ic01.gif";
								}
						%>
						<%if(i==0&&j==0) {%>
								<li class="current"><a href="javascript:void(0)" onclick="javascript:opUrl('<%=cxt+url%>','<%=menu2.getCaption()%>','<%=menu2.getId() %>');return false;" onfocus="this.blur()"><em><img src="<%=cxt+img%>" /></em><%=menu2.getCaption()%></a>
								<%}else{ %>
								<li><a href="javascript:void(0)" onclick="javascript:opUrl('<%=cxt+url%>','<%=menu2.getCaption()%>','<%=menu2.getId() %>');return false;" onfocus="this.blur()"><em><img src="<%=cxt+img%>" /></em><%=menu2.getCaption()%></a>
								<%} %>
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
								
									<li><a href="javascript:void(0)" onclick="javascript:opUrl('<%=cxt+url3%>','<%=menu3.getCaption()%>','<%=menu3.getId() %>');return false;" onfocus="this.blur()"><%=menu3.getCaption()%></a>
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
										<li><a href="javascript:void(0)" onclick="javascript:opUrl('<%=cxt+url4%>','<%=menu4.getCaption()%>','<%=menu4.getId() %>');return false;" onfocus="this.blur()"><%=menu4.getCaption()%></a></li>
										
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
		
			<div id="mainContent" class="mainContent"><!-- frame start -->
				<!-- 
				<iframe id="mainFrame" src="<%=request.getContextPath()%>/aiga/workflow/common/WorkorderList.jsp" width="100%" frameborder="0" scrolling='yes'></iframe>
				 -->
			</div>
		
		</div>
	</body>
	<script LANGUAGE="JavaScript">
		var theWidth = 0;
		var newHeight = 0;
		var waitOrderId = "70";
		
		onresize();
		
		$(window).resize(function(){onresize();});
		document.body.onresize=function(){onresize();};
		function Logout(){
		   $("#logoutForm").submit();
		}
		function onresize() {
			//$("#mainFrame").css("height","100%");
			newHeight = document.documentElement.clientHeight-80;
			$("#mainContent").css("height",newHeight + "px");
			/*
			var width = $(".meun_btm").css("width").replace("px","");
			*/
			theWidth = document.documentElement.clientWidth-10;
			
			$("#mainContent").css("width",theWidth+"px");
		}
		//绑订主iframe的onactive事件,执行受理框架的清除SoSessionData动作
		
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
		
		function setTab(name,cursel,n){
			for(i=1;i<=n;i++){
			var menu=document.getElementById(name+i);
			var con=document.getElementById("con_"+name+"_"+i);
			menu.className=i==cursel?"current":"";
			con.style.display=i==cursel?"block":"none";
			}
		}
		
		function opUrl(url, text, id){
			if(!("<%=cxt%>javascript:void(0)"==url || "<%=cxt%>null" == url )){
				var indexSt = url.indexOf("http://");
				if(indexSt > -1) {
					url = url.substring(indexSt);
				}
				addNewTab(url, text, id);
			    //reHeightMainIframe();
			};
		}
		Ext.require([
		             'Ext.grid.*',
		             'Ext.toolbar.Paging',
		             'Ext.util.*',
		             'Ext.data.*',
		             'Ext.ux.TabCloseMenu',
		             'Ext.ux.TabScrollerMenu',
		             'Ext.ux.TabReorderer',
		             'Ext.ux.GroupTabPanel'
		         ]);
		Ext.onReady(function(){
			var mainTab = new Ext.tab.Panel({
				id: 'mainTab',
				width: theWidth,
				height: newHeight,
				plugins: Ext.create('Ext.ux.TabReorderer'),
				renderTo: Ext.get('mainContent'),
				plugins: [
				          Ext.create('Ext.ux.TabCloseMenu',{
				        	  	closeTabText: '关闭当前',
								closeOthersTabsText: '关闭其他',
						        closeAllTabsText: '关闭所有',
						        extraItemsTail: [
						                    '-',
						                    {
						                        text: '可关闭',
						                        checked: true,
						                        hideOnClick: true,
						                        handler: function (item) {
						                            currentItem.tab.setClosable(item.checked);
						                        }
						                    }
						                ],
						        listeners: {
						            aftermenu: function () {
						                currentItem = null;
						            },
						            beforemenu: function (menu, item) {
						                var menuitem = menu.child('*[text="可关闭"]');
						                currentItem = item;
						                menuitem.setChecked(item.closable);
						            }
						        }
				    }),
				    Ext.create('Ext.ux.TabReorderer')
				    ],
				items:[
				]
			});
			opUrl('<%=request.getContextPath()%>/aiga/workflow/common/WorkorderList.jsp','待处理工单',waitOrderId);
		});
		
		function addNewTab(url, text, id) {
			id = "MENU" + id;
			var tab = Ext.getCmp("mainTab");
			if(Ext.getCmp(id)) {
				tab.remove(id, true);
			}
			if(tab.el.dom.childNodes[1].childElementCount>=7){
				Ext.Msg.alert('提示','您打开的tab页过多，请关闭无用页后，重新打开！');
				return;
			}
			var panel = Ext.create('Ext.form.Panel',{
				id: id,
				title: text,
				reorderable: false,
				listeners:{
					beforeshow: function(curTab, eOpts) {
						if(id == ("MENU"+waitOrderId)) {
							if(document.getElementById("iframe"+id).contentWindow.Ext) {
								document.getElementById("iframe"+id).contentWindow.Ext.StoreMgr.get('gridStore').load();
							}
							//$("#iframe"+id).attr("src","<%=request.getContextPath()%>/aiga/workflow/common/WorkorderList.jsp");
						}
					}
				},
				width: theWidth,
				height: newHeight,
				closable: true,
				html: '<iframe id="iframe'+id+'" width="'+(theWidth)+'" height="'+(newHeight-23)+'" frameborder="0" scrolling="yes" src="'+url+'"></iframe>'
			});
			tab.add(panel);
			tab.setActiveTab(panel);
		}
		
		function addOrderPanel(panel){
			var tab = Ext.getCmp("mainTab");
			tab.add(panel);
			tab.setActiveTab(panel);
		}
		
		function closeTab(){
			var tab = Ext.getCmp("mainTab");
			tab.getActiveTab().close();
		}
		/**
		*author:wenghy
		*通过匹配文本关闭tab标签
		*2014/10/24
		**/
		function closeTabByText(text){
			var tabMainPanel = Ext.getCmp('mainTab');
			try{
				var childTab=tabMainPanel.child().items.items;
				for(var i=0,n=childTab.length;i<n;i++)if(childTab[i].text==text)childTab[i].destroy();
			}catch(e){
			}
			
			
			
		}
		function clickMenu(oneLevelMenuName,secondLevelMenuName){
			$("a:contains('"+secondLevelMenuName+"')")[0].click();
			$("li").has("em:contains("+oneLevelMenuName+")")[0].click();
		}
	</script>
	<jsp:include page="/advert/pop.jsp"></jsp:include>
</html>