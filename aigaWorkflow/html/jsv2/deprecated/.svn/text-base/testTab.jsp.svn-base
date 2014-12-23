<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/webframe/jspcommon/includedhead.jsp"%>

<HTML>
<HEAD>
<TITLE>
 TAB测试
</TITLE>
</HEAD>
<BODY>
<table border="0" width="100%" align="center">
<tr >
<td>
<ai:tab id="main_tab" height="510" width="700" getParameter="" type="V" vmFile="">
<ai:tabitem id="item_1" src="/webframe/image/main/chpassword.gif" title="修改密码1" isDeletable="true"></ai:tabitem>
<ai:tabitem id="item_2" src="/webframe/image/main/logo1.swf" title="Flash2" isDeletable="false"></ai:tabitem>
<ai:tabitem id="item_3" src="/webframe/image/main/chpassword.gif" title="修改密码3" isDeletable="true"></ai:tabitem>
<ai:tabitem id="item_4" src="/webframe/image/main/logo1.swf" title="Flash4" isDeletable="true"></ai:tabitem>
</ai:tab>
</td>
</tr>
<tr>
  <td>
    <input type="button" class="B" value="getTabItemDeletableByIdx" onclick="getItemDeletable(0);">
    <input type="button" class="B" value="setTabItemDeletableByIdxTrue" onclick="setItemDeletable('true');">
    <input type="button" class="B" value="setTabItemDeletableByIdxfalse" onclick="setItemDeletable('false');">
    <input type="button" class="B" value="getTabItemDeletableByName" onclick="getItemDeletableByName('item_1');">
    <input type="button" class="B" value="setTabItemDeletableByNameTrue" onclick="setItemDeletableByName('true');">
    <input type="button" class="B" value="setTabItemDeletableByNamefalse" onclick="setItemDeletableByName('false');">
    <input type="button" class="B" value="newTabItem" onclick="newTabItem();">
    <input type="button" class="B" value="根据索引号刷新" onclick="refreshmain_tab('Idx');">
    <input type="button" class="B" value="根据TabItemId刷新" onclick="refreshmain_tab('ItemId');">
    <input type="button" class="B" value="根据索引号删除" onclick="deletemain_tab('Idx');">
      <input type="button" class="B" value="根据TabItemId删除" onclick="deletemain_tab('ItemId');">
  </td>
</tr>
</table>
</BODY>
</HTML>
<script>
function getItemDeletable(aIdx){
  if (aIdx==null||aIdx=="undefined"){
    aIdx=getCurrentTabFocusItem();
  }
  var aa=getTabItemDeletableByIdx("main_tab",aIdx);
  alert(aa);
}
function setItemDeletable(aValue){
  var aa=setTabItemDeletableByIdx("main_tab",0,aValue);
}

function getItemDeletableByName(aItemName){
  var aa=getTabItemDeletable("main_tab",aItemName);
  alert(aa);
}
function setItemDeletableByName(aValue){
  var aa=setTabItemDeletable("main_tab",'item_1',aValue);
}

function newTabItem(){
  openNewTabItem("main_tab","buzhidao","测试","/webframe/image/main/zjcd.gif","true");
}

function refreshmain_tab(aType){
  if (aType=="Idx"){
    refreshTabItemByIdx("main_tab",5,null,"/webframe/image/main/chpassword.gif");
  }else{
    refreshTabItem("main_tab","buzhidao","ttt4",null);
  }
}

function deletemain_tab(aType){
  if (aType=="Idx"){
    closeTabItemByIdx("main_tab",5);
  }else{
    closeTabItem("main_tab","buzhidao");
  }
}
</script>
