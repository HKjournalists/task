<%-- 
/**
 *说明：组织选择
 *功能：组织选择	
 *@author: zhanghua2
 *DATE:2007-07-27
**/
 --%>
<%@ page contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>选择组织</title>
	</head>
	<body>
	<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
      <tr>
        <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
            <tr>
              <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
              <td style="height: 20px">组织选择</td>
              <td align="right" style="height: 20px"></td>
            </tr>
        </table></td>
      </tr>
      <tr>
        <td bgcolor="#FFFFFF" align="left" style="padding-left:5px;" height="250" valign="top"><div id="byorg">
            <ai:dbtree_new id="orgTree"
						datamodel="com.ai.secframe.web.orgmodel.SysOrgCodeTreeModel"
						multiselect="false" height="360" width="300" ishaveline="true" ondblclick="chkCur"/>
        </div></td>
      </tr>
    </table>
	<table border=0 width=100% align="center">
      <tr>
        <td align="center"><input name="Input" type="button" class="btn-2word" value="确定" id="affirm" onClick="affirm()"/>
          &nbsp;
          <input name="Input2" type="button" class="btn-2word" value="取消" id="cancel" onClick="cancel()"/>
        </td>
      </tr>
    </table>
	</body>
</html>
<script type="text/javascript">
<!--
var curNode = null;
var dbTree = g_DBTreeNewManager.get("orgTree");
function affirm(){
	curNode = dbTree.getCurNodeInfo();
	if(curNode == null){
		alert("请选择组织！");
		return false;
	}
	var v_org = new Organize(curNode.value,curNode.text);
	var list = new Array();
	list[0] = v_org
	window.returnValue = list;
	window.self.close();
}
function Organize(orgId,orgName){
	this.orgId = orgId;
	this.orgName = orgName;
}
function cancel(){	
	window.self.close();
}
function chkCur(){
	affirm();
}
//-->
</script>
