<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="java.util.HashMap" %>
<%@include file="/secframe/common/common.jsp"%>
<html>
<head>
<title>功能模块管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body onLoad="closeTree()">
<table width="100%" bgcolor="#FFFFFF" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="250"><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px">菜单域</td>
                <td align="right" style="height: 20px"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="left" style="padding-left:10px;"><ai:dbtree_new id="sysfunction_tree" height="515" width="100%" 
			   datamodel="com.ai.secframe.web.sysmgr.SysFunctionDataModel" 
			   initial="true" ishaveline="true"
			   onselect="SysfuncInfoLoad" />
          </td>
        </tr>
      </table></td>
    <td valign="top" width="80%"  style="padding-left:10px"><table border=0 cellspacing=0 cellpadding=0 id="mainTable">
        <tr>
          <td valign="top"  bgcolor="#FFFFFF"><ai:dbform formid="sysfuncform" 
			datamodel="com.ai.appframe2.web.datamodel.QueryModelForService"
			setname="com.ai.secframe.bo.sysmgr.SysFunction" 
			implservice_name="com.ai.secframe.service.sysmgr.SysFunction"
			implservice_querymethod="querySysFunction"
			initial="false">
              <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
                <tr>
                  <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
                      <tr>
                        <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                        <td style="height: 20px"> 菜单信息</td>
                        <td align="right" style="height: 20px"></td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td bgcolor="#FFFFFF" align="left" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" height="200">
                      <tr>
                        <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">功能编码</td>
                        <td width="1"></td>
                        <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="FUNC_CODE" formid="sysfuncform" width="200" />
                          <span class="pr9">*</span>
                          <ai:dbformfield fieldname="PARENT_ID" formid="sysfuncform"  visible="false"  width="200" />
                          <ai:dbformfield fieldname="FUNC_ID" formid="sysfuncform"  visible="false"  width="200" /></td>
                        <td width="1"></td>
                        <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">功能名称</td>
                        <td width="1"></td>
                        <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="NAME" formid="sysfuncform" width="200" />
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
                        <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">图标路径</td>
                        <td width="1"></td>
                        <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="FUNC_IMG" formid="sysfuncform" width="200" /></td>
                        <td width="1"></td>
                        <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">模块类型</td>
                        <td width="1"></td>
                        <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="FUNC_TYPE" formid="sysfuncform" width="200" />
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
                        <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">模块参数</td>
                        <td width="1"></td>
                        <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="FUNC_ARG" formid="sysfuncform" width="200" /></td>
                        <td width="1"></td>
                        <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">dll文件名</td>
                        <td width="1"></td>
                        <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="DLL_PATH" formid="sysfuncform" width="200" /></td>
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
                        <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">链接地址</td>
                        <td width="1"></td>
                        <td bgcolor="#F1F3FB" class="font13pxboldblack" colspan="5"><ai:dbformfield fieldname="VIEWNAME" formid="sysfuncform" width="533" />
                          </td>
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
                        <td bgcolor="#F1F3FB" class="font13pxboldblack" colspan="5"><ai:dbformfield fieldname="NOTES" formid="sysfuncform" width="533" /></td>
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
                    </table></td>
                </tr>
              </table>
            </ai:dbform>
            <br>
            <div id="buttonDiv" align="center">
              <input name="" type="button" class="btn-2word" value="新增" id="updateStation" onclick="newMenuItemAction()"/>
              &nbsp;
              <input name="" type="button" class="btn-2word" value="保存" id="save" onclick="updateAction()"/>
              &nbsp;
              <input name="" type="button" class="btn-2word" value="删除" id="delSysFunc" onclick="delMenuItemAction()"/>
            </div></td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html><script language="javascript">

var sysFuncRowSet = g_FormRowSetManager.get("sysfuncform");
var dbtree = g_DBTreeNewManager.get("sysfunction_tree");



//-- flag 1 = add,2 = update ,3 =init
function setBtnDisabled(flag){
if(flag==3){	
  document.getElementById("updateStation").disabled  = true;
  document.getElementById("save").disabled = true;
  document.getElementById("delSysFunc").disabled = true;
  } else if(flag == 1){
    document.getElementById("updateStation").disabled  = true;
  	document.getElementById("save").disabled = false;
  	document.getElementById("delSysFunc").disabled = true;
  } else if(flag == 2) {
   document.getElementById("updateStation").disabled  = false;
  	document.getElementById("save").disabled = false;
  	document.getElementById("delSysFunc").disabled = false;
  }
}

function refreshTree(){
   var dbtree = g_DBTreeNewManager.get("sysfunction_tree");
   var ud = dbtree.refresh(null,1);
}

function SysfuncInfoLoad(){
	var conStr = "";
	setBtnDisabled(2);
	var dbtree = g_DBTreeNewManager.get("sysfunction_tree");
	var curNode = dbtree.getCurNodeInfo();
	var curSysfuncId = curNode.value;
	if(curNode== null || curSysfuncId ==""){
	  setBtnDisabled(3);
	  return;
	}
	if(curSysfuncId==1){
		document.all.item("save").disabled = true;
		document.all.item("delSysFunc").disabled = true;
	}
	conStr ="STATE=1 and FUNC_ID="+curSysfuncId ;
	sysFuncRowSet.refresh(conStr);
	sysFuncRowSet = g_FormRowSetManager.get("sysfuncform");
}

function updateAction(){
	if(sysFuncRowSet.toXmlString(true)==""){
		return;
	}
  if(sysFuncRowSet.validate("FUNC_CODE",true,true) == false) {
  	sysFuncRowSet.setFocus("FUNC_CODE");
  	return;
  }
  if(sysFuncRowSet.validate("NAME",true,true) == false) {
  	sysFuncRowSet.setFocus("NAME");
  	return;
  }
  
  if(sysFuncRowSet.validate("FUNC_TYPE",true,true) == false) {
  	sysFuncRowSet.setValue("FUNC_TYPE","");
  	sysFuncRowSet.setFocus("FUNC_TYPE");
  	return;
  }
  
  if(sysFuncRowSet.validate("VIEWNAME",false,true) == false) {
  	sysFuncRowSet.setFocus("VIEWNAME");
  	return;
  }
  if(sysFuncRowSet.validate("FUNC_IMG",false,true) == false) {
  	sysFuncRowSet.setFocus("FUNC_IMG");
  	return;
  }
  if(sysFuncRowSet.validate("FUNC_ARG",false,true) == false) {
  	sysFuncRowSet.setFocus("FUNC_ARG");
  	return;
  }
  if(sysFuncRowSet.validate("DLL_PATH",false,true) == false) {
  	sysFuncRowSet.setFocus("DLL_PATH");
  	return;
  }
  if( sysFuncRowSet.toXmlString()=="" ) {
  	alert("未做任何修改!");
  	return ;
  }
  var dbtree = g_DBTreeNewManager.get("sysfunction_tree");
  var curNode = dbtree.getCurNodeInfo();
  var param="&curid="+curNode.value;
  var list = new Array();
  list.push(sysFuncRowSet);
  //alert(sysFuncRowSet.toXmlString());
  var msg = saveRowSet('<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysFunctionDataModel?action=saveSysFunction'+param,list);
  var rtnval=msg.getValueByName("reVal");
  if(rtnval!="OK"){
    alert(rtnval);
  }else{
    alert("保存成功");
    if(curNode.value == 1){
    	dbtree.refresh(curNode.value,1);
    } else {
    	var parentNode = dbtree.getParentNodeInfo(curNode.value);
    	
		dbtree.refresh(parentNode.value,1);
		dbtree.expandNodeByValue(curNode.value,true);
		dbtree.expandNodeByValue(parentNode.value,true);
		}
		
  }
  setBtnDisabled(2);
}

function delMenuItemAction(){
  var dbtree = g_DBTreeNewManager.get("sysfunction_tree");
  var curNode = dbtree.getCurNodeInfo();
  if(curNode==null){
    alert("请选择菜单中的某一功能！");
    return;
  }
  
  if(curNode.value == "1"){
    alert("不可删除根节点");
    return;
  }

  if(!window.confirm("是否确定要删除该功能模块?"))return;
  
  var param ="&curid="+curNode.value;
  var rtnval = PostInfotoServer('<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysFunctionDataModel?action=deleteSysFunction'+param,'');
    	
  if(rtnval!="OK"){
    alert(rtnval);
  }else{
    alert("删除成功.");
    var parentNode = dbtree.getParentNodeInfo(curNode.value);
    dbtree.refresh(parentNode.value,1);
    sysFuncRowSet.newRow();
  }
}

function newMenuItemAction(){

	var curNode = dbtree.getCurNodeInfo();
	sysFuncRowSet.refresh("FUNC_ID=-1");
	sysFuncRowSet.setValue("PARENT_ID",curNode.value);
	setBtnDisabled(1);
}

//合并节点
function closeTree(){
  
  var arr = dbtree.getChildrenNodesInfo(1);
  if(arr==null){
    return;
  }
  
  for(i=0;i<arr.length;i++){
    dbtree.expandNodeByValue(arr[i].value,false);
  }
  
  dbtree.setNodeSelect(1);
}

setBtnDisabled(3);
</script>
