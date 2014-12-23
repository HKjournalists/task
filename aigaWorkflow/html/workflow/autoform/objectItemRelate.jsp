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
 Ԫ�������б�
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

//��ϵ�Ĺ�ϵ���ܹ������¼���ϵ���繤�����Ļ��ڵ������������ܹ������¼���ϵ�������ԣ�
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

//˫����ʾ�ڵ���ϸ��Ϣ
function showDetailInfo(){
	  var aNodeObj=objectItemTree.getCurNodeInfo();
	  if (aNodeObj==null){
	    alert("ȡ�ڵ����");
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
  //�Ƿ�ɱ༭
  var achkIsVisible=document.all.item("chkIsVisible").checked;
  if (achkIsVisible==true){
    PARAM+="&IS_VISIBLE=1";
  }else{
    PARAM+="&IS_VISIBLE=0";
  }
  //�Ƿ����
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


/**����Ϊ�Ҽ��˵�*/
var ItemRelatTreeModel = new AIPopMenuModel();
var ItemRelatTreeMenu;

/**�Ҽ��˵���ع���*/

/**
* ����Ԫ��֮��Ĺ�ϵOBJECT_ITEM_RELAT��
* ������
* 1��aParentItemId�ϼ�Ԫ�����
* 2��aParentItemType�ϼ�Ԫ������
* 3��aChildItemId�¼�Ԫ�����
* 4��aChildItemType�¼�Ԫ������
* �������¼�Ԫ��������ɹ�ϵ���ͣ��磺WORKFLOW_NODE,WORKFLOW_SET��
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
* ɾ��Ԫ��֮��Ĺ�ϵ
* ������
* 1��aItemRelatId��ϵ���
* */
function delObjectItemRelat(){
  var aNodeObj=objectItemTree.getCurNodeInfo();
  var aNodeText=aNodeObj.text;
  var aNodeValue=aNodeObj.value;
  if (confirm("ɾ����ϵ��һ��ɾ���ù�ϵ���ӹ�ϵ�� ��ȷ��ɾ��Ԫ��֮��Ĺ�ϵ��"+aNodeText+" ��")==false){
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
* ����Ԫ��֮��Ĺ�ϵ�Ĺ�ϵOBJECT_ITEM_RELAT_RELAT��
* ������
* 1��aRelatId��ϵ���
* 2��aChildItemId�¼�Ԫ�����
* 3��aChildItemType�¼�Ԫ������
* 4���ϼ���ϵ���
* 5��
* �������¼�Ԫ��������ɹ�ϵ���ͣ��磺WORKFLOW.WORKDLOW_NODE.SET��
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
* ɾ��Ԫ��֮��Ĺ�ϵ
* ������
* 1��aRelatRelatId��ϵ�Ĺ�ϵ���
* */
function delObjectItemRelatRelat(){
  var aNodeObj=objectItemTree.getCurNodeInfo();
  var aNodeText=aNodeObj.text;
  var aNodeValue=aNodeObj.value;
  if (confirm("ɾ����ϵ��һ��ɾ���ù�ϵ���ӹ�ϵ�� ��ȷ��ɾ��Ԫ��֮��Ĺ�ϵ��"+aNodeText+" ��")==false){
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
* ����Ԫ�����͵�����Ԫ����������ѡ��
* aObjectItemType Ҫ���ӵ�Ԫ������
* aAddType        ���ӵ���Ԫ��֮��Ĺ�ϵ���ǹ�ϵ�Ĺ�ϵ
* aRelatTypeCode  Ԫ����ϵ���߹�ϵ�Ĺ�ϵ֮��Ĺ�ϵ����
* aRelatId
* aTargetItemId   Ŀ��Ԫ�����ϵ���
* aMainObjectItemId ��Object_item_relat�е���������ϵ����Ҫ�������ݣ�
* ��ӹ������Ļ��ڣ��价�ڱ����ǹ������Ļ��ڣ����set�����ԣ������Ա�����set������
* */
function selectObjectItemsByType(aObjectItemType,aAddType,aRelatTypeCode,aTargetItemId,aRelatId,aMainObjectItemId){
  var param="?OBJECT_ITEM_TYPE="+aObjectItemType+"&ADD_TYPE="+aAddType+"&RELAT_TYPE_CODE="+aRelatTypeCode+"&TARGET_ITEM_ID="
       +aTargetItemId+"&RELAT_ID="+aRelatId+"&MAIN_OBJECT_ITEM_ID="+aMainObjectItemId;
  var r=window.showModalDialog("AddObjectItemRelatTree.jsp"+param,window,"scroll:no;resizable:no;status:no;dialogHeight:580px;dialogWidth:450px");
  if (r&&r=="true"){
    //ˢ����
    var aNodeObj=objectItemTree.getCurNodeInfo();
    var aNodeValue=aNodeObj.value;
    return true;
  }
}

function createMenu(){
        /** ����һ���˵���
         ����: pItemId���˵����Ψһ��ʾ
         pItemName���˵�������
         pParentItemId �� �˵������ڵ��ϼ��˵�������main���˵�����ֵΪnull
         pFuncName - ����˵���Ҫ������js�����ĺ�������.
         **/
         <%
           IAutoFormSV autoform = (IAutoFormSV)ServiceFactory.getService(IAutoFormSV.class);
           IObjectItemType[] ObjectItemChildTypes=autoform.getObjectItemChildTypes();
           for (int i=0;i<ObjectItemChildTypes.length;i++){
        %>
              ItemRelatTreeModel.addPopMenuItem("addIc<%=ObjectItemChildTypes[i].getObjectItemTypeCode()%>","����<%=ObjectItemChildTypes[i].getObjectItemTypeName()%>",null,"addObjectItemRelat('<%=ObjectItemChildTypes[i].getObjectItemTypeCode()%>')");
              ItemRelatTreeModel.addPopMenuItem("delIc<%=ObjectItemChildTypes[i].getObjectItemTypeCode()%>","ɾ��<%=ObjectItemChildTypes[i].getObjectItemTypeName()%>",null,"delObjectItemRelat()");
        <%
           }
           IObjectItemType[] ObjectItemRelatChildTypes=autoform.getObjectItemRelatChildTypes();
           for (int i=0;i<ObjectItemRelatChildTypes.length;i++){
        %>
              ItemRelatTreeModel.addPopMenuItem("addRc<%=ObjectItemRelatChildTypes[i].getObjectItemTypeCode()%>","����<%=ObjectItemRelatChildTypes[i].getObjectItemTypeName()%>",null,"addObjectItemRelatRelat('<%=ObjectItemRelatChildTypes[i].getObjectItemTypeCode()%>')");
              ItemRelatTreeModel.addPopMenuItem("delRc<%=ObjectItemRelatChildTypes[i].getObjectItemTypeCode()%>","ɾ��<%=ObjectItemRelatChildTypes[i].getObjectItemTypeName()%>",null,"delObjectItemRelatRelat()");
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
    alert("����ѡ��ĳһ���ڵ㣡");
    return;
  }
  var aNodeText=aNodeObj.text;
  var aNodeValue=aNodeObj.value;
  var aUserObj=getNodeUserObject(aNodeObj);
  //�Ƚ������еĲ˵�
  //�������в˵����Ƶ��б�
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
   //���ò˵�
  ItemRelatTreeMenu.setItemEnabledById("<%=disabledMenuList%>",false);
/**
* ���ݽڵ����ڵ�λ�ü����ʣ�ȷ����ǰ�ڵ��Ƿ��ִ��
* ������ʾ�˵��Ľڵ������У�
* 1����ǰԪ�����Թ�����Ԫ�����ͽڵ㣬OBJECT_NODE_TYPE=OBJECT_ITEM_TYPE����ִ�����Ӳ���
* 2����ϵ�ڵ㡣OBJECT_NODE_TYPE=OBJECT_ITEM_RELAT����ִ��ɾ������
* 3����ϵ���Թ�����Ԫ�����ͽڵ㣬OBJECT_NODE_TYPE=RELAT_OBJECT_ITEM_TYPE����ִ�����Ӳ���
* 4����ϵ�ڵ�Ĺ�ϵ��OBJECT_NODE_TYPE=OBJECT_ITEM_RELAT_RELAT����ִ��ɾ������������������ϵ����
* 5����ϵ�ڵ�Ĺ�ϵ������Ԫ����OBJECT_NODE_TYPE=OBJECT_ITEM_RELAT_RELAT_CHILD����ִ��ɾ������
*
**/
  if (aUserObj.OBJECT_NODE_TYPE=="OBJECT_ITEM_TYPE"){
  <%
     for (int i=0;i<ObjectItemChildTypes.length;i++){
       //�磺����ǻ������ͣ���ֻ�����ӻ���
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
           
       //�磺����ǻ������ͣ���ֻ�����ӻ���
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
       //�磺����ǻ������ͣ���ֻ�����ӻ���
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
       //�磺����ǻ������ͣ���ֻ�����ӻ���
  %>
       if ("<%=ObjectItemRelatChildTypes[i].getObjectItemTypeCode()%>"==aUserObj.OBJECT_ITEM_TYPE_CODE){
           ItemRelatTreeMenu.setItemEnabledById("delRc<%=ObjectItemRelatChildTypes[i].getObjectItemTypeCode()%>",true);
       }
       //�������ӹ������磺WORKFLOW.WORKFLOW_NODE.SET_CHILD
       if (aUserObj.OBJECT_NODE_RELAT_CODE.split(".").length==3){
 	  //ȡ�ù�����ϵ��������������
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
       //�磺����ǻ������ͣ���ֻ�����ӻ���
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
//�����˵�
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
  <!--��չ����-->

    <div id="div_extra" style="display:none">
    <table>
      <tr>
        <td class="FormTD">
          <input type="checkbox" id="chkIsVisible"   title="�Ƿ����"  />�Ƿ����
        <br></td>
      </tr>
      <tr>
        <td class="FormTD">
          <input type="checkbox" id="chkIsEditable"   title="�Ƿ�ɱ༭"/>�Ƿ�ɱ༭
        <br></td>
      </tr>
      <tr>
        <td>
          <input type="text" id="sortNo" size="2"/>��������
        <br></td>
      </tr>
      <tr>
        <td class="FormTD">
          <input type="button" class="B" value="����" onclick="saveExtraInfo();"/>
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
