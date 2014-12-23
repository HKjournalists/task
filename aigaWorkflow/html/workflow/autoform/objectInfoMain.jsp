<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/webframe/common/commonhead.jsp"%>
<HTML>
<HEAD>
<link rel="stylesheet" href="<%=request.getContextPath()%>/webframe/css/WebStyle.jsp" type="text/css">
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/Globe_v2.jsp"></script>
</HEAD>
<BODY>
	<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr >
			<td>
		      <ai:tab id="object_tab" height="580" width="100%" getParameter="getParam" type="H">
			 	 <ai:tabitem id="object_detail_info" src="objectItemDetail.jsp" title="元件详细信息"></ai:tabitem>
		         <ai:tabitem id="object_user_info" src="objectItemRelate.jsp" title="使用了下列元件"></ai:tabitem>
		         <ai:tabitem id="object_user_relat" src="objectItemRelated.jsp" title="父亲元件"></ai:tabitem>
		      </ai:tab>
		    </td>
	    </tr>
       </table>
</BODY>
</HTML>
<script language="javascript">
var CURRENT_TAB_NAME = "object_detail_info";
var objectItemId = "";
var objectItemName = "";
var objectItemType = "";
function getCurrentTabName(){
  return CURRENT_TAB_NAME;
}
function getParam(aTabName){
  CURRENT_TAB_NAME=aTabName;
  return "OBJECT_ITEM_ID="+objectItemId+"&OBJECT_ITEM_TYPE="+objectItemType
  +"&OBJECT_ITEM_NAME="+objectItemName+"&OBJECT_ITEM_KIND_ID="+objectItemKindId;
}

function refreshTab(pObjectItemId,pObjectItemType,pObjectItemName,pObjectItemKindId)
{
  objectItemId = pObjectItemId;
  objectItemName = pObjectItemName;
  objectItemType = pObjectItemType;
  objectItemKindId=pObjectItemKindId;
  if (!CURRENT_TAB_NAME)
    {
	    CURRENT_TAB_NAME="";
    }
    if (CURRENT_TAB_NAME!="")
    {
	    setTabItem("object_tab",CURRENT_TAB_NAME);
    }
    else
    {
	    setTabItem("object_tab","object_detail_info");
    }
}

</script>

