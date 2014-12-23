<%@ page contentType="text/html; charset=GBK" %>
<%@ page import ="com.ai.appframe2.web.HttpUtil" %>
<%@ include file="/webframe/common/commonhead.jsp"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai"%>
<%@ page import="com.ai.comframe.autoform.service.interfaces.*" %>
<%@ page import="com.ai.appframe2.service.ServiceFactory"%>
<HTML>
<script language="JavaScript">
	
</script>
<HEAD>
<link rel="stylesheet" href="<%=request.getContextPath()%>/webframe/css/WebStyle.jsp" type="text/css">
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/Globe_v2.jsp"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/DBTree_new.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/PopMenu_v2.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/webframe/css/PopMenu_desktop.css" type="text/css">
<TITLE>
 元件类型列表
</TITLE>
</HEAD>
<%
 String aRootObjectItemId=HttpUtil.getParameter(request,"OBJECT_ITEM_ID");
 String aRootObjectItemType=HttpUtil.getParameter(request,"OBJECT_ITEM_TYPE");
 pageContext.getRequest().setAttribute("OBJECT_ITEM_ID",aRootObjectItemId);
 pageContext.getRequest().setAttribute("OBJECT_ITEM_TYPE",aRootObjectItemType);
 pageContext.getRequest().setAttribute("OBJECT_ITEM_NAME",HttpUtil.getParameter(request,"OBJECT_ITEM_NAME"));
%>
<script language="JavaScript">

//关系的关系所能关联的下级关系。如工作流的环节的数据区域所能关联的下级关系（如属性）
var aThirdRelatTypeAry=new Array();

function getNodeUserObject(aNodeObj){
  var aUserObj=new Object();
  var aNodeText=aNodeObj.text;
  var aNodeValue=aNodeObj.value;
  var aNodeUserObjStr=aNodeObj.userobj;
  if (aNodeUserObjStr!=null&&aNodeUserObjStr!=""){
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
              }else if (aName=="OBJECT_ITEM_RELAT_ID"){
                aUserObj.OBJECT_ITEM_RELAT_ID=aValue;
              }else if (aName=="OBJECT_ITEM_ID"){
                aUserObj.OBJECT_ITEM_ID=aValue;
              }else if (aName=="OBJECT_NODE_TYPE"){
                aUserObj.OBJECT_NODE_TYPE=aValue;
              }else if (aName=="OBJECT_NODE_RELAT_CODE"){
                aUserObj.OBJECT_NODE_RELAT_CODE=aValue;
              }
            }
          }
        }
    }
  }
  return aUserObj;
}

function showObjectItemInfo(){
  var aNodeObj=objectItemTree.getCurNodeInfo();
  var aNodeText=aNodeObj.text;
  var aNodeValue=aNodeObj.value;

  var aUserObj=getNodeUserObject(aNodeObj);

  if (aUserObj.OBJECT_NODE_TYPE!=null&&(aUserObj.OBJECT_NODE_TYPE=="OBJECT_ITEM_RELAT_RELAT"||
  aUserObj.OBJECT_NODE_TYPE=="OBJECT_ITEM_RELAT_RELAT_CHILD"  || aUserObj.OBJECT_NODE_TYPE=="OBJECT_ITEM_RELAT")){
    document.all.item("div_extra").style.display="block";
    var aRelatId=aUserObj.OBJECT_ITEM_RELAT_ID;
    var PARAM="&OBJECT_ITEM_RELAT_ID="+aRelatId+"&OBJECT_NODE_TYPE="+aUserObj.OBJECT_NODE_TYPE;
    var r=PostInfo('<%=request.getContextPath()%>/business/com.ai.comframe.autoform.web.AutoFormAction?action=getObjectItemRelatDetail'+PARAM,"");
    var aIsVisible=r.getValueByName("isVisible");
    var aIsEditable=r.getValueByName("isEditable");
    var aSortNo = r.getValueByName("sortNo");
    //var url = r.getValueByName("url");
    if (aIsVisible=="1"){
      document.all.item("chkIsVisible").checked=true;
    }else{
      document.all.item("chkIsVisible").checked=false;
    }
    if (aIsEditable=="1"){
      document.all.item("chkIsEditable").checked=true;
    }else{
      document.all.item("chkIsEditable").checked=false;
    }
    
    //if(aUserObj.OBJECT_ITEM_TYPE_CODE == "WORKFLOW_NODE"){
    	 //document.all.item("div_url").style.display="block";
    //}
  }else{
    document.all.item("div_extra").style.display="none";
    //document.all.item("div_url").style.display="none";
  }
  
  document.all.item("sortNo").value = aSortNo;
  //document.all.item("URL").value = url;
}

//双击显示节点详细信息
function showDetailInfo(){
	  var aNodeObj=objectItemTree.getCurNodeInfo();
	  if (aNodeObj==null){
	    alert("取节点出错！");
	    return;
	  }
	  var aUserObj=getNodeUserObject(aNodeObj);
	  var aObjectItemId=aUserObj.OBJECT_ITEM_ID;
	  var aObjectItemKindId=-1;
	  var aObjectItemNodeType=aUserObj.OBJECT_NODE_TYPE;
	  if(aObjectItemNodeType=="OBJECT_ITEM_RELAT" || aObjectItemNodeType=="OBJECT_ITEM_RELAT_RELAT"){
	  
		  var param="?OBJECT_ITEM_KIND_ID="+aObjectItemKindId+"&OBJECT_ITEM_TYPE="+aUserObj.OBJECT_ITEM_TYPE_CODE+"&OBJECT_ITEM_ID="+aObjectItemId;
		  var r=window.showModalDialog("objectItemDetail.jsp"+param,window,"scroll:no;resizable:no;status:no;dialogHeight:300px;dialogWidth:800px");
	}
}
function saveExtraInfo(){
  var aNodeObj=objectItemTree.getCurNodeInfo();
  var aNodeText=aNodeObj.text;
  var aNodeValue=aNodeObj.value;
  var aUserObj=getNodeUserObject(aNodeObj);
  var aRelatId=aUserObj.OBJECT_ITEM_RELAT_ID;
  var PARAM="&OBJECT_ITEM_RELAT_ID="+aRelatId;
  //是否可编辑
  var achkIsVisible=document.all.item("chkIsVisible").checked;
  if (achkIsVisible==true){
    PARAM+="&IS_VISIBLE=1";
  }else{
    PARAM+="&IS_VISIBLE=0";
  }
  //是否可视
  var achkIsEditable=document.all.item("chkIsEditable").checked;
  if (achkIsEditable==true){
    PARAM+="&IS_EDITABLE=1";
  }else{
    PARAM+="&IS_EDITABLE=0";
  }
  var oSortNo = document.all.item("sortNo").value;
  //var url = document.all.item("div_url").value;
  //PARAM+="&URL="+url;
  PARAM+="&SORT_NO="+oSortNo;
  PARAM+="&OBJECT_NODE_TYPE="+aUserObj.OBJECT_NODE_TYPE;
  if (aUserObj.OBJECT_NODE_TYPE==null||(aUserObj.OBJECT_NODE_TYPE!="OBJECT_ITEM_RELAT_RELAT"
  &&aUserObj.OBJECT_NODE_TYPE!="OBJECT_ITEM_RELAT_RELAT_CHILD" && aUserObj.OBJECT_NODE_TYPE!="OBJECT_ITEM_RELAT")){
    return;
  }
  var resu=PostInfo('<%=request.getContextPath()%>/business/com.ai.comframe.autoform.web.AutoFormAction?action=saveObjectItemRelat'+PARAM,"").getValueByName("retValue");
  var aResu=resu.substr(0,1);
  var aMsg=resu.substr(1,resu.length);
  alert(aMsg);

}


/**以下为右键菜单*/
var ItemRelatTreeModel = new AIPopMenuModel();
var ItemRelatTreeMenu;

/**右键菜单相关功能*/

/**
* 增加元件之间的关系OBJECT_ITEM_RELAT表
* 参数：
* 1、aParentItemId上级元件编号
* 2、aParentItemType上级元件类型
* 3、aChildItemId下级元件编号
* 4、aChildItemType下级元件类型
* 根据上下级元件类型组成关系类型，如：WORKFLOW_NODE,WORKFLOW_SET等
* */
function addObjectItemRelat(aObjectItemType){
  var aNodeObj=objectItemTree.getCurNodeInfo();
  var aNodeText=aNodeObj.text;
  var aNodeValue=aNodeObj.value;
  var aUserObj=getNodeUserObject(aNodeObj);

  var aTargetItemId=aUserObj.OBJECT_ITEM_ID;
  var aRelatTypeCode=aUserObj.OBJECT_NODE_RELAT_CODE;
  aRelatTypeCode=aRelatTypeCode.split(".")[0];
  var aAddType="OBJECT_ITEM_RELAT";
  aMainObjectItemId=aTargetItemId;
  r=selectObjectItemsByType(aObjectItemType,aAddType,aRelatTypeCode,aTargetItemId,-1,aMainObjectItemId);
  //alert(r);
  if (r==true){
    objectItemTree.refresh(aNodeValue,1);
  }
}

/**
* 删除元件之间的关系
* 参数：
* 1、aItemRelatId关系编号
* */
function delObjectItemRelat(){
  var aNodeObj=objectItemTree.getCurNodeInfo();
  var aNodeText=aNodeObj.text;
  var aNodeValue=aNodeObj.value;
  if (confirm("删除关系将一并删除该关系的子关系。 您确认删除元件之间的关系："+aNodeText+" 吗？")==false){
    return;
  }
  var aUserObj=getNodeUserObject(aNodeObj);
  var aItemRelatId=aUserObj.OBJECT_ITEM_RELAT_ID;
  var aDelType="OBJECT_ITEM_RELAT";
  var param="&RELAT_ID="+aItemRelatId+"&DELETE_TYPE="+aDelType;
  var resu=PostInfo('<%=request.getContextPath()%>/business/com.ai.comframe.autoform.web.AutoFormAction?action=deleteObjectItemRelat'+param,"").getValueByName("retValue");
  var aResu=resu.substr(0,1);
  var aMsg=resu.substr(1,resu.length);
  alert(aMsg);
  if (aResu=="Y"){
    var aParentNode=objectItemTree.getParentNodeInfo(aNodeValue);
    objectItemTree.refresh(aParentNode.value,1);
  }
}

/**
* 增加元件之间的关系的关系OBJECT_ITEM_RELAT_RELAT表
* 参数：
* 1、aRelatId关系编号
* 2、aChildItemId下级元件编号
* 3、aChildItemType下级元件类型
* 4、上级关系编号
* 5、
* 根据上下级元件类型组成关系类型，如：WORKFLOW.WORKDLOW_NODE.SET等
* */
function addObjectItemRelatRelat(aObjectItemType){
  var aNodeObj=objectItemTree.getCurNodeInfo();
  var aNodeText=aNodeObj.text;
  var aNodeValue=aNodeObj.value;
  var aUserObj=getNodeUserObject(aNodeObj);

  var aTargetItemId=aUserObj.OBJECT_ITEM_ID;
  var aRelatTypeCode=aUserObj.OBJECT_NODE_RELAT_CODE;
  var aAddType="OBJECT_ITEM_RELAT_RELAT";
  var aRelatId=aUserObj.OBJECT_ITEM_RELAT_ID;
  var aObjecttNodeType=aUserObj.OBJECT_NODE_TYPE;
  var aMainObjectItemId=-1;
  if (aObjecttNodeType=="OBJECT_ITEM_RELAT_RELAT"){
    aMainObjectItemId=aTargetItemId;
  }else{
    aMainObjectItemId="<%=aRootObjectItemId%>";
  }
  var r=selectObjectItemsByType(aObjectItemType,aAddType,aRelatTypeCode,aTargetItemId,aRelatId,aMainObjectItemId);
  if (r==true){
    objectItemTree.refresh(aNodeValue,1);
  }
}

/**
* 删除元件之间的关系
* 参数：
* 1、aRelatRelatId关系的关系编号
* */
function delObjectItemRelatRelat(){
  var aNodeObj=objectItemTree.getCurNodeInfo();
  var aNodeText=aNodeObj.text;
  var aNodeValue=aNodeObj.value;
  if (confirm("删除关系将一并删除该关系的子关系。 您确认删除元件之间的关系："+aNodeText+" 吗？")==false){
    return;
  }
  var aUserObj=getNodeUserObject(aNodeObj);
  var aItemRelatId=aUserObj.OBJECT_ITEM_RELAT_ID;
  var aDelType="OBJECT_ITEM_RELAT_RELAT";
  var param="&RELAT_ID="+aItemRelatId+"&DELETE_TYPE="+aDelType;
  var resu=PostInfo('<%=request.getContextPath()%>/business/com.ai.comframe.autoform.web.AutoFormAction?action=deleteObjectItemRelat'+param,"").getValueByName("retValue");
  var aResu=resu.substr(0,1);
  var aMsg=resu.substr(1,resu.length);
  alert(aMsg);
  if (aResu=="Y"){
    var aParentNode=objectItemTree.getParentNodeInfo(aNodeValue);
    objectItemTree.refresh(aParentNode.value,1);
  }
}

/**
* 根据元件类型弹出该元件的树，供选择
* aObjectItemType 要增加的元件类型
* aAddType        增加的是元件之间的关系还是关系的关系
* aRelatTypeCode  元件关系或者关系的关系之间的关系编码
* aRelatId
* aTargetItemId   目标元件或关系编号
* aMainObjectItemId 在Object_item_relat中的主关联关系，主要限制内容：
* 添加工作流的环节，其环节必须是工作流的环节，添加set的属性，其属性必须是set的属性
* */
function selectObjectItemsByType(aObjectItemType,aAddType,aRelatTypeCode,aTargetItemId,aRelatId,aMainObjectItemId){
  var param="?OBJECT_ITEM_TYPE="+aObjectItemType+"&ADD_TYPE="+aAddType+"&RELAT_TYPE_CODE="+aRelatTypeCode+"&TARGET_ITEM_ID="
       +aTargetItemId+"&RELAT_ID="+aRelatId+"&MAIN_OBJECT_ITEM_ID="+aMainObjectItemId;
  var r=window.showModalDialog("AddObjectItemRelatTree.jsp"+param,window,"scroll:no;resizable:no;status:no;dialogHeight:580px;dialogWidth:450px");
  if (r&&r=="true"){
    //刷新树
    var aNodeObj=objectItemTree.getCurNodeInfo();
    var aNodeValue=aNodeObj.value;
    return true;
  }
}

function createMenu(){
        /** 增加一个菜单项
         参数: pItemId－菜单项的唯一标示
         pItemName－菜单的名称
         pParentItemId － 菜单项所在的上级菜单项，如果是main主菜单，该值为null
         pFuncName - 点击菜单需要触发的js函数的函数名称.
         **/
         <%
           IAutoFormSV autoform = (IAutoFormSV)ServiceFactory.getService(IAutoFormSV.class);
           IObjectItemType[] ObjectItemChildTypes=autoform.getObjectItemChildTypes();
           for (int i=0;i<ObjectItemChildTypes.length;i++){
        %>
              ItemRelatTreeModel.addPopMenuItem("addIc<%=ObjectItemChildTypes[i].getObjectItemTypeCode()%>","增加<%=ObjectItemChildTypes[i].getObjectItemTypeName()%>",null,"addObjectItemRelat('<%=ObjectItemChildTypes[i].getObjectItemTypeCode()%>')");
              ItemRelatTreeModel.addPopMenuItem("delIc<%=ObjectItemChildTypes[i].getObjectItemTypeCode()%>","删除<%=ObjectItemChildTypes[i].getObjectItemTypeName()%>",null,"delObjectItemRelat()");
        <%
           }
           IObjectItemType[] ObjectItemRelatChildTypes=autoform.getObjectItemRelatChildTypes();
           for (int i=0;i<ObjectItemRelatChildTypes.length;i++){
        %>
              ItemRelatTreeModel.addPopMenuItem("addRc<%=ObjectItemRelatChildTypes[i].getObjectItemTypeCode()%>","增加<%=ObjectItemRelatChildTypes[i].getObjectItemTypeName()%>",null,"addObjectItemRelatRelat('<%=ObjectItemRelatChildTypes[i].getObjectItemTypeCode()%>')");
              ItemRelatTreeModel.addPopMenuItem("delRc<%=ObjectItemRelatChildTypes[i].getObjectItemTypeCode()%>","删除<%=ObjectItemRelatChildTypes[i].getObjectItemTypeName()%>",null,"delObjectItemRelatRelat()");
        <%
            }
         %>
        ItemRelatTreeMenu = new AIPopMenu(ItemRelatTreeModel);
        document.onclick=hideItemRelatTreeMenu;
}

function showPopMenu(){
        popMenu.showItemRelatTreeMenu();
}
function hideItemRelatTreeMenu(){
        if(ItemRelatTreeMenu)
                ItemRelatTreeMenu.hidePopMenu();
}

function showItemRelatTreeMenu(){
  var aNodeObj=objectItemTree.getCurNodeInfo();
  if (aNodeObj==null){
    alert("请先选择某一个节点！");
    return;
  }
  var aNodeText=aNodeObj.text;
  var aNodeValue=aNodeObj.value;
  var aUserObj=getNodeUserObject(aNodeObj);
  //先禁用所有的菜单
  //构建所有菜单名称的列表
  <%
     String disabledMenuList="";
     for (int i=0;i<ObjectItemChildTypes.length;i++){
       if (i==0){
         disabledMenuList+="addIc"+ObjectItemChildTypes[i].getObjectItemTypeCode();
       }else{
         disabledMenuList+=",addIc"+ObjectItemChildTypes[i].getObjectItemTypeCode();
       }
       disabledMenuList+=",delIc"+ObjectItemChildTypes[i].getObjectItemTypeCode();
     }
     for (int i=0;i<ObjectItemRelatChildTypes.length;i++){
       disabledMenuList+=",addRc"+ObjectItemRelatChildTypes[i].getObjectItemTypeCode();
       disabledMenuList+=",delRc"+ObjectItemRelatChildTypes[i].getObjectItemTypeCode();
     }
   %>
   //禁用菜单
  ItemRelatTreeMenu.setItemEnabledById("<%=disabledMenuList%>",false);
/**
* 根据节点所在的位置及性质，确定当前节点是否可执行
* 可以显示菜单的节点类型有：
* 1、当前元件可以关联的元件类型节点，OBJECT_NODE_TYPE=OBJECT_ITEM_TYPE，可执行增加操作
* 2、关系节点。OBJECT_NODE_TYPE=OBJECT_ITEM_RELAT，可执行删除操作
* 3、关系可以关联的元件类型节点，OBJECT_NODE_TYPE=RELAT_OBJECT_ITEM_TYPE，可执行增加操作
* 4、关系节点的关系。OBJECT_NODE_TYPE=OBJECT_ITEM_RELAT_RELAT，可执行删除操作和增加下属关系操作
* 5、关系节点的关系关联的元件，OBJECT_NODE_TYPE=OBJECT_ITEM_RELAT_RELAT_CHILD，可执行删除操作
*
**/
  if (aUserObj.OBJECT_NODE_TYPE=="OBJECT_ITEM_TYPE"){
  <%
     for (int i=0;i<ObjectItemChildTypes.length;i++){
       //如：如果是环节类型，则只能增加环节
  %>
       if ("<%=ObjectItemChildTypes[i].getObjectItemTypeCode()%>"==aUserObj.OBJECT_ITEM_TYPE_CODE){
           ItemRelatTreeMenu.setItemEnabledById("addIc<%=ObjectItemChildTypes[i].getObjectItemTypeCode()%>",true);
       }
  <%
     }
   %>
  }else if (aUserObj.OBJECT_NODE_TYPE=="OBJECT_ITEM_RELAT"){
  <%
     for (int i=0;i<ObjectItemChildTypes.length;i++){
           
       //如：如果是环节类型，则只能增加环节
  %>
       if ("<%=ObjectItemChildTypes[i].getObjectItemTypeCode()%>"==aUserObj.OBJECT_ITEM_TYPE_CODE){
           ItemRelatTreeMenu.setItemEnabledById("delIc<%=ObjectItemChildTypes[i].getObjectItemTypeCode()%>",true);
       }
  <%
     }
   %>
  }else if (aUserObj.OBJECT_NODE_TYPE=="RELAT_OBJECT_ITEM_TYPE"){
  <%
     for (int i=0;i<ObjectItemRelatChildTypes.length;i++){
       //如：如果是环节类型，则只能增加环节
  %>
       if ("<%=ObjectItemRelatChildTypes[i].getObjectItemTypeCode()%>"==aUserObj.OBJECT_ITEM_TYPE_CODE){
           ItemRelatTreeMenu.setItemEnabledById("addRc<%=ObjectItemRelatChildTypes[i].getObjectItemTypeCode()%>",true);
       }
  <%
     }
   %>
  }else if (aUserObj.OBJECT_NODE_TYPE=="OBJECT_ITEM_RELAT_RELAT"){
  <%
     for (int i=0;i<ObjectItemRelatChildTypes.length;i++){
       //如：如果是环节类型，则只能增加环节
  %>
       if ("<%=ObjectItemRelatChildTypes[i].getObjectItemTypeCode()%>"==aUserObj.OBJECT_ITEM_TYPE_CODE){
           ItemRelatTreeMenu.setItemEnabledById("delRc<%=ObjectItemRelatChildTypes[i].getObjectItemTypeCode()%>",true);
       }
       //有三级子关联，如：WORKFLOW.WORKFLOW_NODE.SET_CHILD
       if (aUserObj.OBJECT_NODE_RELAT_CODE.split(".").length==3){
 	  //取该关联关系的下属关联对象
          var atempAry=null;
          for (var kk=0;kk<aThirdRelatTypeAry.length;kk++){
            if (aThirdRelatTypeAry[kk].RELAT_TYPE_CODE==aUserObj.OBJECT_NODE_RELAT_CODE){
              atempAry=aThirdRelatTypeAry[kk].DATA_ARRAY;
              break;
            }
          }
          if (!atempAry){
            var param="&RELAT_TYPE_CODE="+aUserObj.OBJECT_NODE_RELAT_CODE+"_CHILD";
	    var aThirdRelatTypes=PostInfo('<%=request.getContextPath()%>/business/com.ai.comframe.autoform.web.AutoFormAction?action=getObjectItemRelatChildTypesByRelatCode'+param,"").getValueByName("retVal");
            atempAry=aThirdRelatTypes.split(",");
            var aObj=new Object();
            aObj.RELAT_TYPE_CODE=aUserObj.OBJECT_NODE_RELAT_CODE;
            aObj.DATA_ARRAY=atempAry;
            aThirdRelatTypeAry[aThirdRelatTypeAry.length]=aObj;
          }
          if (atempAry!=null&&atempAry.length>0){
            for (var jj=0;jj<atempAry.length;jj++){
              ItemRelatTreeMenu.setItemEnabledById("addRc"+atempAry[jj],true);
            }
          }
       }
  <%
     }
   %>
  }else{
  <%
     for (int i=0;i<ObjectItemRelatChildTypes.length;i++){
       //如：如果是环节类型，则只能增加环节
  %>
       if ("<%=ObjectItemRelatChildTypes[i].getObjectItemTypeCode()%>"==aUserObj.OBJECT_ITEM_TYPE_CODE){
           ItemRelatTreeMenu.setItemEnabledById("delRc<%=ObjectItemRelatChildTypes[i].getObjectItemTypeCode()%>",true);
       }
  <%
     }
   %>
  }

  ItemRelatTreeMenu.showPopMenu();
}
//创建菜单
createMenu();
</script>
<BODY>
<table  width="100%" align="center">
<tr>
  <td>
	<div class="width:100%;height:100%;overflow:auto">
	<ai:dbtree_new id="objectItemRelatTree" datamodel="com.ai.comframe.autoform.web.ObjectItemRelatTree" ishaveline="true"
	  multiselect="false" height="500" width="400" onselect="showObjectItemInfo"  onrightclick="showItemRelatTreeMenu"
	  ondblclick="showDetailInfo"/>
	</div>
  </td>
  <td>
  <!--扩展属性-->

    <div id="div_extra" style="display:none">
    <table>
      <tr>
        <td class="FormTD">
          <input type="checkbox" id="chkIsVisible"   title="是否可视"  />是否可视
        <br></td>
      </tr>
      <tr>
        <td class="FormTD">
          <input type="checkbox" id="chkIsEditable"   title="是否可编辑"/>是否可编辑
        <br></td>
      </tr>
      <tr>
        <td>
          <input type="text" id="sortNo" size="2"/>排序数字
        <br></td>
      </tr>
      <tr>
        <td class="FormTD">
          <input type="button" class="B" value="保存" onclick="saveExtraInfo();"/>
        <br></td>
      </tr>
    </table>
    </div>
  <br></td>
</tr>
</table>
<script>
var objectItemTree = g_DBTreeNewManager.get("objectItemRelatTree");
</script>
</BODY>

</HTML>
