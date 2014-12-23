<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.ai.appframe2.web.HttpUtil"%>
<%@ include file="/webframe/common/commonhead.jsp"%>

<HTML>
<HEAD>
<link rel="stylesheet" href="<%=request.getContextPath()%>/webframe/css/WebStyle.jsp" type="text/css">
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/Globe_v2.jsp"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/DBTree_new.js"></script>
<TITLE>
 产品单元类型列表
</TITLE>
</HEAD>
<BODY bgcolor="#ffffff" >
<%
 String aObjectItemType=HttpUtil.getParameter(request,"OBJECT_ITEM_TYPE");
 String aAddType=HttpUtil.getParameter(request,"ADD_TYPE");
 String aRelatTypeCode=HttpUtil.getParameter(request,"RELAT_TYPE_CODE");
 String aTargetItemId=HttpUtil.getParameter(request,"TARGET_ITEM_ID");
 String aRelatId=HttpUtil.getParameter(request,"RELAT_ID");
 String aMainObjectItemId=HttpUtil.getParameter(request,"MAIN_OBJECT_ITEM_ID");


 pageContext.getRequest().setAttribute("OBJECT_ITEM_TYPE",aObjectItemType);
 pageContext.getRequest().setAttribute("OBJECT_ITEM_ID",aTargetItemId);
 pageContext.getRequest().setAttribute("RELAT_ID",aRelatId);
 pageContext.getRequest().setAttribute("MAIN_OBJECT_ITEM_ID",aMainObjectItemId);
 pageContext.getRequest().setAttribute("ADD_TYPE",aAddType);
%>
<div class="width:100%;height:100%;overflow:auto">
<ai:dbtree_new id="objectItemTree" datamodel="com.ai.comframe.autoform.web.ObjectItemTree"
  multiselect="true" height="500" width="440" ishaveline="true" />
</div>
<div>
  <input type="checkbox" id="chkIsVisible"   title="是否可视" checked />是否可视
  <input type="checkbox" id="chkIsEditable"   title="是否可编辑" checked/>是否可编辑
</div>
 <div align="center"> <input type="button"  value="确定" class="B" onclick="ok()"></div>
</BODY>
</HTML>
<script language="JavaScript">
var objectItemTree = g_DBTreeNewManager.get("objectItemTree");
var OBJECT_ITEM_TYPE="<%=aObjectItemType%>";
var OBJECT_ITEM_ID="<%=aTargetItemId%>";

function ok(){
  var NodeObjs=objectItemTree.getCheckedNodesInfo();
  var aSelectNodeStr="";
  for (var j=0;j<NodeObjs.length;j++){
    	var aNodeObj=NodeObjs[j];
  	var aNodeText=aNodeObj.text;
  	var aNodeValue=aNodeObj.value;
  	var aNodeUserObjStr=aNodeObj.userobj;
    if (aNodeUserObjStr!=null&&aNodeUserObjStr!=""){
  	  var aUserObj=new Object();
          var aListAry=aNodeUserObjStr.split(",");
          if (aListAry!=null&&aListAry.length>0){
              for (var i=0;i<aListAry.length;i++){
                var aNameValue=aListAry[i];
                if (aNameValue!=null&&aNameValue!=""){
                  var aNameValueAry=aNameValue.split("=");
                  if (aNameValueAry!=null&&aNameValueAry.length>0){
                    var aName=aNameValueAry[0];
                    var aValue=aNameValueAry[1];
                    if (aName=="OBJECT_ITEM_TYPE_CODE"){
                      aUserObj.OBJECT_ITEM_TYPE_CODE=aValue;
                    }else if (aName=="OBJECT_ITEM_KIND_ID"){
                      aUserObj.OBJECT_ITEM_KIND_ID=aValue;
                    }else if (aName=="OBJECT_ITEM_ID"){
                      aUserObj.OBJECT_ITEM_ID=aValue;
                    }else if (aName=="OBJECT_NODE_TYPE"){
                      aUserObj.OBJECT_NODE_TYPE=aValue;
                    }
                  }
                }
              }
          }
          if (aUserObj.OBJECT_ITEM_TYPE_CODE!=null&&aUserObj.OBJECT_ITEM_TYPE_CODE==OBJECT_ITEM_TYPE&&aUserObj.OBJECT_NODE_TYPE=="OBJECT_ITEM"){
            aSelectNodeStr+=aUserObj.OBJECT_ITEM_ID+",";
          }
  	}
  }
  if (aSelectNodeStr==""){
    alert("您没有选择下属对象或选择的对象类型不是"+OBJECT_ITEM_TYPE+"!");
    return;
  }else{
    //保存
    aSelectNodeStr=aSelectNodeStr.substr(0,aSelectNodeStr.length-1);

    var param="&OBJECT_ITEM_ID="+OBJECT_ITEM_ID+"&RELAT_OBJECT_ITEM_ID_LIST="+aSelectNodeStr
    +"&RELAT_TYPE=<%=aRelatTypeCode%>"+"."+OBJECT_ITEM_TYPE+"+&RELAT_ID=<%=aRelatId%>+&ADD_TYPE=<%=aAddType%>";
    //是否可编辑
    var achkIsVisible=document.all.item("chkIsVisible").checked;
    if (achkIsVisible==true){
      param+="&IS_VISIBLE=Y";
    }else{
      param+="&IS_VISIBLE=N";
    }
    //是否可视
    var achkIsEditable=document.all.item("chkIsEditable").checked;
    if (achkIsEditable==true){
      param+="&IS_EDITABLE=Y";
    }else{
      param+="&IS_EDITABLE=N";
    }
    var resu=PostInfo('<%=request.getContextPath()%>/business/com.ai.comframe.autoform.web.AutoFormAction?action=addObjectItemRelat'+param,"").getValueByName("retValue");
    var aResu=resu.substr(0,1);
    var aMsg=resu.substr(1,resu.length);
      alert(aMsg);
      top.returnValue="true";
      top.close();
  }
}
</script>
