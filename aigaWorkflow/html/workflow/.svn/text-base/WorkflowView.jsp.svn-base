<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai" %>
<%@ page import="com.ai.appframe2.web.datamodel.CommonTreeModel"%>

<link rel="stylesheet" href="<%=request.getContextPath()%>/jsv2/AppFrameCss.jsp" type="text/css">
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/PopMenu_v2.js"></script>
<%@ include file="/workflow/workflow_css.jsp"%>

<html>
<head>
  <title>流程监控</title>
</head>
<%
String rootUrl = "";
request.setAttribute(CommonTreeModel.ROOT_ID,"0");
request.setAttribute(CommonTreeModel.ROOT_NAME,"流程监控");
request.setAttribute(CommonTreeModel.ROOT_URL,rootUrl);
request.setAttribute(CommonTreeModel.TREE_TYPE_ID,"50");
%>
<body>
  <table align="center" width="100%">
    <tr><td id="treeTD" width="23%" height="100%" valign="top">
      <fieldset style="width:98%;text-align:left;font-size:12">
        <legend class="FormZName">信息导航</legend>
        <ai:dbtree_new id="custTree" datamodel="com.ai.appframe2.web.datamodel.CommonTreeModel" ishaveline="true"
          multiselect="false" onrightclick="showPopMenu" onselect="selectNode" width="100%" height="540"/>
      </fieldset>
    </td>
    <td width="77%" height="100%" valign="top">
      <iframe id="subPage" align="left" width="100%" height="560" src="" frameborder="0" scrolling="auto" onactivate="subPageActivate()"></iframe>
    </td></tr>
  </table>
</body>
</html>

<script language="javascript">
var dbTree = g_DBTreeNewManager.get("custTree");
var popMenu = null;
document.onclick = hidePopMenu;
document.all.treeTD.oncontextmenu = treeRefresh;

function selectNode(newVal,newText,newUserObj,newNodeType){
  var curNodeInfo = dbTree.getCurNodeInfo();
  if(curNodeInfo ==null){
    alert("请选中节点！");
    return;
  }
  else{
    var url=curNodeInfo.userobj;
    if(url==null || url=="null" || url==""){
      return;
    }
    //userobj中存放的是nodeType$param#webUrl
    var start  = url.indexOf("<%=CommonTreeModel.URL_SPLIT%>")+1;
    var end = url.length;
    url = url.substring(start,end);
    if(url.indexOf("null")>=0){
      return;
    }
    if(url.indexOf("http")==0){
      document.all.subPage.src = url;
    }
    else{
      document.all.subPage.src = "<%=request.getContextPath()%>"+url;
    }
  }
}

function showPopMenu(treeVal,treeText,treeUserObj,treeNodeType){
    hidePopMenu();
    treeRefresh();
}

function hidePopMenu(){
  if(popMenu){
    popMenu.hidePopMenu();
  }
}

//刷新树
function  treeRefresh(){
  hidePopMenu();
  var tmpGroupModel = new AIPopMenuModel();
  tmpGroupModel.addPopMenuItem("1","刷新导航树",null,"rootRefresh");
  popMenu = new AIPopMenu(tmpGroupModel);
  popMenu.showPopMenu();
  return false;
}
function rootRefresh(){
  dbTree.refresh();
}

//刷新节点
function nodeRefresh(){
  var curNodeInfo = dbTree.getCurNodeInfo();
  if(curNodeInfo ==null){
    return;
  }
  var nodes = curNodeInfo.value.split("_");
  if(nodes.length==1){   //根节点
    dbTree.refresh();
  }
  else if(nodes.length==2){  //第一级节点
    dbTree.refresh(curNodeInfo.value);
  }
  else if(nodes.length>2){   //刷新父节点
    var start = 0;
    var end = curNodeInfo.value.lastIndexOf("_");
    dbTree.refresh(curNodeInfo.value.substr(start,end));
  }
}

//点击右边页面时取消导航树上的右键浮动菜单
function subPageActivate(){
    hidePopMenu();
    window.event.returnValue = false;
    window.event.cancelBubble = true;
}
</script>
