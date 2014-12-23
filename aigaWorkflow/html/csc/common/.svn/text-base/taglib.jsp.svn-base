<%@page contentType="text/html; charset=GBK" import="com.ai.appframe2.service.ServiceFactory,com.ai.secframe.common.Constants,com.ai.secframe.service.pubapi.interfaces.ISecframe,com.ai.appframe2.common.SessionManager"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/webframe/jspcommon/includedhead.jsp"%>
<%@ include file="/csc/common/css/aialm_style.jsp"%>
<%@ page import="com.asiainfo.csc.common.define.IStakeholderType"%>

<%@ page isELIgnored="false" %><!-- 这一行很关键 决定了${userInfo.ID} 语法是否可用-->
<%
	String linkNo = request.getParameter("linkNo");
	String  staffId = String.valueOf(g_GetUserInfo().getID());
	String  staffName = String.valueOf(g_GetUserInfo().getName());
	String staffNo = String.valueOf(g_GetUserInfo().getCode());
	long organizeId=g_GetUserInfo().getOrgId();
	request.setAttribute("userInfo", g_GetUserInfo());
%>
<script src="<%=request.getContextPath()%>/jsv2/Globe_v2.jsp"></script>
<script src="<%=request.getContextPath()%>/secframe/common/common.js"></script>
<script src="<%=request.getContextPath()%>/jsv2/monitor/monitor.jsp"></script>

<script src="<%=request.getContextPath()%>/jQuery/jquery-1.4.2.min.js"></script>
<!--<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/jquery.easyui.min.js"></script>-->
<script src="<%=request.getContextPath()%>/jsv2/CommUtil.js"></script>
<script src="<%=request.getContextPath()%>/csc/common/JS/ymPrompt.js"></script>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/csc/common/css/skin/qq/ymPrompt.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/csc/common/css/aialm_style_css.jsp" >
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/csc/common/css/jquery.autocomplete.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/webframe/shdesktopui/theme/default/styles/layer.css" />	
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/easyui/demo/demo.css">
<script src="<%=request.getContextPath()%>/csc/common/JS/reqUtils.js"></script>
<script src="<%=request.getContextPath()%>/csc/common/JS/jquery.autocomplete.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/webframe/shdesktopui/js/fixlayer.js"></script>

<script type="text/javascript">

function skipToIndexForDesktop()
{
	//alert(window.parent.parent.parent.mainFrame);
   window.parent.parent.parent.mainFrame.location = "<%=request.getContextPath()%>/webframe/shdesktopui/Desktop.jsp";
	window.parent.parent.parent.clearCurrent();
}


function skipToIndexForFirst()
{
   //window.parent.parent.parent.mainFrame.openUrl("<%=request.getContextPath()%>/webframe/shdesktopui/Desktop.jsp","桌面");
   	var index = window.parent.getCurrentTabFocusItem('tab1');
   	window.parent.refreshTabItem("tab1", "item1", "工单","<%=request.getContextPath()%>/csc/common/WorkorderList.jsp");
 	window.parent.closeTabItemByIdx("tab1", index);
}

// skipToIndex()
//{
 //   var index = window.parent.getCurrentTabFocusItem('tab1');
 //   window.parent.refreshTabItem("tab1", "item1", "工单","<%=request.getContextPath()%>/csc/common/WorkorderList.jsp");
 //   window.parent.closeTabItemByIdx("tab1", index);
//}
function skipToIndex()
{
   //window.parent.parent.parent.mainFrame.openUrl("<%=request.getContextPath()%>/webframe/shdesktopui/Desktop.jsp","桌面");
   var index = window.parent.getCurrentTabFocusItem('tab1');
   	window.parent.refreshTabItem("tab1", "item1", "工单","<%=request.getContextPath()%>/csc/common/WorkorderList.jsp");
 	window.parent.closeTabItemByIdx("tab1", index);
}

function skipToIndex2()
{
   //window.parent.parent.parent.mainFrame.openUrl("<%=request.getContextPath()%>/webframe/shdesktopui/Desktop.jsp","桌面");
   var index = window.parent.parent.getCurrentTabFocusItem('tab1');
   	window.parent.refreshTabItem("tab1", "item1", "工单","<%=request.getContextPath()%>/csc/common/WorkorderList.jsp");
 	window.parent.closeTabItemByIdx("tab1", index);
}


function setConds(conds,key,value)
{
	var condStr = '';
	if(conds.indexOf('<conds>')>=0&&conds.indexOf('</conds>')>=0)
	{
		var str_length = conds.length;//得到字符串的长度
		var str_conds_pos = conds.indexOf("</conds>");//
		var str_num = conds.substr(0,str_conds_pos);//截取数字
		var str_px = conds.substr(str_conds_pos,str_length-str_conds_pos);//截取px
		condStr  = condStr + str_num + '<cond name="'+key+'" value="'+value+'">' + '</cond>' + str_px;
	}
	else
	{
		condStr = condStr + '<conds>';
		condStr = condStr + '<cond name="'+key+'" value="'+value+'">' + '</cond>'
		condStr = condStr + '</conds>';
	}
	return condStr;
}


function scrollx(p) {
 var d = document, dd = d.documentElement, db = d.body, w = window, o = d.getElementById(p.id), ie6 = /msie 6/i.test(navigator.userAgent), style, timer;
 if (o) {
  cssPub = ";position:"+(p.f&&!ie6?'fixed':'absolute')+";"+(p.t!=undefined?'top:'+p.t+'px;':'bottom:0;');
  if (p.r != undefined && p.l == undefined) {
   o.style.cssText += cssPub + ('right:'+p.r+'px;');
  } else {
   o.style.cssText += cssPub + ('margin-left:'+p.l+'px;');
  }
  if(p.f&&ie6){
   cssTop = ';top:expression(documentElement.scrollTop +'+(p.t==undefined?dd.clientHeight-o.offsetHeight:p.t)+'+ "px" );';
   cssRight = ';right:expression(documentElement.scrollright + '+(p.r==undefined?dd.clientWidth-o.offsetWidth:p.r)+' + "px")';
   if (p.r != undefined && p.l == undefined) {
    o.style.cssText += cssRight + cssTop;
   } else {
    o.style.cssText += cssTop;
   }
   dd.style.cssText +=';background-image: url(about:blank);background-attachment:fixed;';
  }else{
   if(!p.f){
    w.onresize = w.onscroll = function(){
     clearInterval(timer);
     timer = setInterval(function(){
      //双选择为了修复chrome 下xhtml解析时dd.scrollTop为 0
      var st = (dd.scrollTop||db.scrollTop),c;
      c = st - o.offsetTop + (p.t!=undefined?p.t:(w.innerHeight||dd.clientHeight)-o.offsetHeight);
      if(c!=0){
       o.style.top = o.offsetTop + Math.ceil(Math.abs(c)/10)*(c<0?-1:1) + 'px';
       o.style.display = "block";
      }else{
       clearInterval(timer);
      }
     },10)
    }
   }
  }
 }
}

function test() {
	var s = g_TableRowSetManager.get("tblDiscussReqOrder").getValue(0,"OBJ_ID");
	alert(s);
}

function disable(tagId){
	var d = document.getElementById(tagId);
    for(var i=0;i<d.childNodes.length;i++){
		if(d.childNodes[i].disabled!=null){
		   d.childNodes[i].disabled = "disabled"; 
		}
	}
}
function getUserGroup(){
	var busiType = arguments[0];
	var url = "<%=request.getContextPath()%>/business/com.asiainfo.csc.req.web.reqAction?action=getUserGroupByBusiType&busiType="+busiType;
    var result = PostInfo(url,null);
    return result.getValueByName('userGroup');
}
	function to07Excel(tableId,fileName) {
		if(fileName == null || fileName == "") {
			alert("未传入参数[fileName]");
			return;
		}
		var table = g_TableRowSetManager.get(tableId);
		var viColsWidth = '';
		//获取当前表格的所有的标题
		var titles =''
		for(i=0;i<table.getVisiColCount();i++){
		    titles = titles + table.colNames[i]+"=";
		    titles = titles + table.getTitle(table.colNames[i]) + ";";
		    viColsWidth = viColsWidth + table.getColWidth(i) + ",";
		}
		if(titles==''){
		  alert('对不起,当前表格没有任何数据!');
		  return;
		}
		var list = new Array();
		list.push(table);
		titles = titles.substring(0,titles.length -1);
		viColsWidth = viColsWidth.substring(0,viColsWidth.length -1);
		var url = "<%=request.getContextPath()%>/gridturnpage1?action=toexcel&titles="+titles+"&viColsWidth="+viColsWidth+"&fileName="+fileName+"&random="+Math.random();
		var result = saveRowSet(url,list,true,false,null,true);
		if(result.getValueByName("retVal") == "Y") {
			window.location.href = "<%=request.getContextPath()%>/gridturnpage1?action=getExcel&fileName="+fileName+"&random="+Math.random();
		} else {
			alert(result.getValueByName("retVal"));
		}
	}
</script>