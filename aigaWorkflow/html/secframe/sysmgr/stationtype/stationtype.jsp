<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="java.util.HashMap" %>
<%@include file="/secframe/common/common.jsp"%>
<html>
<head>
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
<title>岗位类型页面</title>
</head>
<SCRIPT LANGUAGE="JavaScript">
var tempKindId=0;
var stationType = false;
function reloadForm(){
	 var conStr = "";
   setBtnDisabled(false);
   var stationTypeRowSet = g_FormRowSetManager.get("stationtypeform");
   var stationTypeKindRowSet = g_FormRowSetManager.get("stationtypekindform");
   var dbtree = g_DBTreeNewManager.get("stationtype_tree");
   var curNode = dbtree.getCurNodeInfo();
   var fl = curNode.userobj;
   if(curNode.value==-1)
   return ;
   var vv = dbtree.getParentNodeInfo(curNode.value).text;
   if(curNode==null){
	   setBtnDisabled(true);
	   return;
	 }
	 if(stationType==true){
	 	fl="STATION_TYPE";
	 	
	 }
	 if(fl=="STATION_TYPE"){
	 	document.all.item("station_type").style.display = "block";
	 	document.all.item("station_type_kind").style.display = "none";
   		var curStationTypeId = curNode.value;
	 	conStr ="STATE=1 and STATION_TYPE_ID="+curStationTypeId ;
   		stationTypeRowSet.refresh(conStr);
	 }else{
	 	document.all.item("station_type").style.display = "none";
	 	document.all.item("station_type_kind").style.display = "block";
   		var curKindId = curNode.value;
	   	if(curKindId==-1){
	   		document.getElementById("saveKind").disabled =  true;
			document.getElementById("delKind").disabled =  true;
			document.getElementById("addType").disabled =  true;
	   	}else{
			document.getElementById("saveKind").disabled =  false;
			document.getElementById("delKind").disabled =  false;
			document.getElementById("addType").disabled =  false;
	   	}
	 	conStr ="STATE=1 and KIND_ID="+curKindId ;
   		stationTypeKindRowSet.refresh(conStr);
	 }
	 if(stationType == true){
	 	tempKindId = curNode.value;
	 	stationTypeRowSet.setValue("KIND_ID",curNode.text,curNode.text);
	 	stationType=false;
	 } else {
	 	 tempKindId = dbtree.getParentNodeInfo(curNode.value).value;
		 stationTypeRowSet.setValue("KIND_ID",vv,vv);
	 }
	 
}

function newStationTypeAction(){
 
 stationType = true;
 reloadForm();
 
 
}

function newStationTypeKindAction(){
	var dbtree = g_DBTreeNewManager.get("stationtype_tree");
	var stationTypeKindRowSet = g_FormRowSetManager.get("stationtypekindform");
	var curNode = dbtree.getCurNodeInfo();
	if(curNode==null){
	  alert("请选择菜单中的某一功能！");
	  return;
	}
	stationTypeKindRowSet.refresh("KIND_ID=-1");
	stationTypeKindRowSet.setValue("PARENT_KIND_ID",curNode.value); 
}

function updateStationTypeAction(){
	var dbtree = g_DBTreeNewManager.get("stationtype_tree");
  var curNode = dbtree.getCurNodeInfo();
  var stationTypeRowSet = g_FormRowSetManager.get("stationtypeform");

  if( stationTypeRowSet.toXmlString()=="" ) {
  	alert("未做任何修改!");
  	return ;
  }
  //alert(tempKindId);
  stationTypeRowSet.setValue("KIND_ID",tempKindId,tempKindId);
  var code = stationTypeRowSet.getValue("CODE");
  if( code == null || code == "" ){
  	alert("岗位类型编码不能为空，请填写岗位类型编码");
    return;
  }
  var name = stationTypeRowSet.getValue("NAME")
  if( name == null || name == "" ){
  	alert("岗位类型名称不能为空，请填写岗位类型名称");
    return;
  }
  var sortId = stationTypeRowSet.getValue("SORT_ID");
  if(g_IsDigit(sortId)==false){
  	alert("序号只能为数字！");
  	stationTypeRowSet.setValue("SORT_ID","");
  	stationTypeRowSet.setFocus("SORT_ID");
  	return;
  }
  if(g_GetStrLen(sortId)>3){
  	alert("序号的长度必须小于等于3位");
  	stationTypeRowSet.setValue("SORT_ID","");
  	stationTypeRowSet.setFocus("SORT_ID");
  	return;
  }
  var list = new Array();
  list.push(stationTypeRowSet);
  var retMsg = saveRowSet("<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysStationTypeModel?action=saveStationType",list);
  var retVal = retMsg.getValueByName("retVal");

  if(retVal=="OK"){
  	alert("岗位类型数据保存成功");
    reloadForm();    
    var node = dbtree.getCurNodeInfo();
    dbtree.setCurNodeInfo(node.value,name,node.userobj);
    var curParNode = dbtree.getParentNodeInfo(node.value);
    dbtree.refresh(curParNode.value);
   	dbtree.expandNodeByValue(node.value,true);
	dbtree.expandNodeByValue(curParNode.value,true);
  }
  else{
    alert(retVal);
  }
}

function updateStationTypeKindAction(){
	var dbtree = g_DBTreeNewManager.get("stationtype_tree");
  var curNode = dbtree.getCurNodeInfo();
  var stationTypeKindRowSet = g_FormRowSetManager.get("stationtypekindform");
  if( stationTypeKindRowSet.toXmlString()=="" ) {
  	alert("未做任何修改!");
  	return ;
  }
  var name = stationTypeKindRowSet.getValue("KIND_NAME")
  if( name == null || name == "" ){
  	alert("分类名称不能为空，请填写分类名称!");
    return;
  }
  var sortId = stationTypeKindRowSet.getValue("SORT_ID");
  if(g_IsDigit(sortId)==false){
  	alert("序号只能为数字！");
  	stationTypeKindRowSet.setValue("SORT_ID","");
  	stationTypeKindRowSet.setFocus("SORT_ID");
  	return;
  }
  if(g_GetStrLen(sortId)>3){
  	alert("序号的长度必须小于等于3位");
  	stationTypeKindRowSet.setValue("SORT_ID","");
  	stationTypeKindRowSet.setFocus("SORT_ID");
  	return;
  }
  var list = new Array();
  list.push(stationTypeKindRowSet);
  var retMsg = saveRowSet("<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysStationTypeModel?action=saveStationTypeKind",list);
  var retVal = retMsg.getValueByName("retVal");

  if(retVal=="OK"){
  	alert("岗位类型分类数据保存成功");
    reloadForm();
    var dbtree = g_DBTreeNewManager.get("stationtype_tree");
    
    var node = dbtree.getCurNodeInfo();
    dbtree.setCurNodeInfo(node.value,name,node.userobj);
    var curParNode = dbtree.getParentNodeInfo(node.value);
    dbtree.refresh(curParNode.value);
    dbtree.expandNodeByValue(node.value,true);
	dbtree.expandNodeByValue(curParNode.value,true);
  }
  else{
    alert(retVal);
  }
}

function delStationTypeAction()
{
	var dbtree = g_DBTreeNewManager.get("stationtype_tree");
  var curNode = dbtree.getCurNodeInfo();
  if(curNode==null){
    alert("请选择菜单中的某一功能！");
    return;
  }
  
  if(!window.confirm("是否确定要删除该岗位类型?"))return;
    
  var parent_value = dbtree.getParentNodeInfo(curNode.value).value;
  var stationTypeRowSet = g_FormRowSetManager.get("stationtypeform");
  stationTypeRowSet.setValue("KIND_ID",'0','0');
  stationTypeRowSet.setValue("NOTES",stationTypeRowSet.getValue("NOTES")+' ',stationTypeRowSet.getValue("NOTES")+' ');
  //stationTypeRowSet.setStsToDel();
  var list = new Array();
  list.push(stationTypeRowSet);

  var retMsg = saveRowSet("<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysStationTypeModel?action=saveStationType&del=Y",list);
  var retVal = retMsg.getValueByName("retVal");

  if(retVal=="OK"){
    alert("岗位类型删除成功!");
    reloadForm();
    dbtree.refresh(parent_value);
    dbtree.setNodeSelect(parent_value);
  }else{
    alert(retVal);
  }
  	
  
}

function delStationTypeKindAction()
{
	var dbtree = g_DBTreeNewManager.get("stationtype_tree");
  var curNode = dbtree.getCurNodeInfo();
  if(curNode!=null){
  	if(window.confirm("是否确定要删除该岗位类型分类?")){
  		var parent_value = dbtree.getParentNodeInfo(curNode.value).value;
  		var stationTypeKindRowSet = g_FormRowSetManager.get("stationtypekindform");
  		stationTypeKindRowSet.setStsToDel();
 			var list = new Array();
  		list.push(stationTypeKindRowSet);
  		var retMsg = saveRowSet("<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysStationTypeModel?action=saveStationTypeKind",list);
  		var retVal = retMsg.getValueByName("retVal");

  		if(retVal=="OK"){
 				alert("岗位类型分类数据删除成功！");
    		reloadForm();
				dbtree.refresh(parent_value);
				dbtree.setNodeSelect(parent_value);
  		}else {
    		alert(retVal);
    	}
  	}
  }else{
  	alert("请选择菜单中的某一功能！");
  }
}

function refreshTree(){
   var dbtree = g_DBTreeNewManager.get("stationtype_tree");
   var ud = dbtree.refresh(null,-1);
}

function setBtnDisabled(flag){

	if(document.all.item("station_type").style.display == "block"){
	
			document.getElementById("saveStationType").disabled = flag;
			document.getElementById("delStationType").disabled = flag;

	}
  if(document.all.item("station_type_kind").style.display == "block"){
			document.getElementById("saveKind").disabled = flag;
			document.getElementById("delKind").disabled = flag;
			document.getElementById("addType").disabled = flag;
			document.getElementById("addKind").disabled = flag;
 	
	}

}

</SCRIPT>
<body>
<table width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top"><table width="250" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px">岗位类型树</td>
                <td align="right" style="height: 20px"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="left" style="padding-left:10px;"><ai:dbtree_new id="stationtype_tree" height="440" width="200" datamodel="com.ai.secframe.web.sysmgr.SysStationTypeModel" initial="true" ishaveline="true" onselect="reloadForm" onrightclick="" />
          </td>
        </tr>
      </table></td>
    <td valign="top" style="padding-left:5px;"><table width="100%" border="0"  id="station_type" style="display:none" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px"> 岗位类型信息</td>
                <td align="right" style="height: 20px"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="left" valign="top">
          <ai:dbform formid="stationtypeform" setname="com.ai.secframe.bo.sysmgr.SysStationType" initial="false" 
																													                              datamodel="com.ai.secframe.web.sysmgr.SysMgrQueryModelForService"
																																												implservice_name="com.ai.secframe.service.sysmgr.SysStationType" implservice_querymethod="queryStationType">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" height="150">
              <tr>
                <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">岗位类型代码</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="CODE" formid="stationtypeform" width="200" />
                  <span class="pr9">*</span></td>
                <td width="1"></td>
                <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">岗位类型名称</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="NAME" formid="stationtypeform" width="200" />
                  <span class="pr9">*</span></td>
              </tr>
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">岗位类型分类</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="KIND_ID" formid="stationtypeform" width="200" /></td>
                <td width="1"></td>
                <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">岗位类型序号</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="SORT_ID" formid="stationtypeform" width="200" /></td>
              </tr>
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">备注</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack" colspan="5"><ai:dbformfield fieldname="STATION_TYPE_ID" formid="stationtypeform" visible="false" />
                  <ai:dbformfield fieldname="NOTES" formid="stationtypeform" editable="true" width="540" /></td>
              </tr>
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
            </table></ai:dbform></td>
        </tr>
        <tr>
          <td align="center" valign="middle" height="35" bgcolor="#FFFFFF">
              <input name="" type="button" class="btn-2word" value="保存" id="saveStationType" onClick="updateStationTypeAction()"/>
              &nbsp;
              <input name="" type="button" class="btn-2word" value="删除" id="delStationType" onClick="delStationTypeAction()"/>
            </td>
        </tr>
      </table>
      <table id="station_type_kind" style="display:block" width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px"> 分类信息</td>
                <td align="right" style="height: 20px"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="left" valign="top"><ai:dbform formid="stationtypekindform" setname="com.ai.secframe.bo.sysmgr.SysStationTypeKind" initial="false" datamodel="com.ai.appframe2.web.datamodel.QueryModelForService"
																													implservice_name="com.ai.secframe.service.sysmgr.SysStationType" implservice_querymethod="querySysStationTypeKind">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" height="150">
              <tr>
                <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">分类编号</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="KIND_ID" formid="stationtypekindform" width="200" /></td>
                <td width="1"></td>
                <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">分类名称</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="KIND_NAME" formid="stationtypekindform" width="200" />
                  <span class="pr9">*</span></td>
              </tr>
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">上级分类编号</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="PARENT_KIND_ID" formid="stationtypekindform" width="200" /></td>
                <td width="1"></td>
                <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">同级排序编号</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="SORT_ID" formid="stationtypekindform" width="200" /></td>
              </tr>
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
			  <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td align="center" colspan="7"><input name="" type="button" class="btn-4word" value="新增分类" id="addKind" onClick="newStationTypeKindAction()"/>
                  &nbsp;
                  <input name="" type="button" class="btn-5word" value="新增岗位类型" id="addType" onClick="newStationTypeAction()"/>
                  &nbsp;
                  <input name="" type="button" class="btn-4word" value="保存分类" id="saveKind" onClick="updateStationTypeKindAction()"/>
                  &nbsp;
                  <input name="Input" type="button" class="btn-4word" value="删除" id="delKind" onClick="delStationTypeKindAction()"/></td>
              </tr>
            </table></ai:dbform></td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html><script type="text/javascript">
//设置按钮状态
setBtnDisabled(true);
//右击菜单
//treeMenuBuild();
</script>
