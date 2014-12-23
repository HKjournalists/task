<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<html>
<head>
<title>MO选择</title>
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
        <ai:dbtree_new id="sysdirtree"
							datamodel="com.ai.secframe.web.sysmgr.DBTreeModelSysMo"
							width="300" height="350" multiselect="false" ishaveline="true"/>
      </div></td>
  </tr>
</table>
<table border=0 width=100% align="center">
  <tr>
    <td align="center"><input name="Input" type="button" class="btn-2word" value="确定" id="affirm" onClick="okFunc()"/>
      &nbsp;
      <input name="Input2" type="button" class="btn-2word" value="取消" id="cancel" onClick="cancelFunc()"/>
    </td>
  </tr>
</table>
<ai:loginuser />
</body>
</html><SCRIPT LANGUAGE="JavaScript">
var dbtree= g_DBTreeNewManager.get("sysdirtree");
var oldArr = window.dialogArguments;
var moName = null;//被管对象的全名
function okFunc()
{
	var curNode = dbtree.getCurNodeInfo();
	var parentNode = dbtree.getParentNodeInfo(curNode.value);
	if(curNode==null||curNode.userobj!="O"){
		alert("请选择一个被管对象操作属性！");
	}else{
		if(chkOld(parentNode.value+","+curNode.text)){
			alert("该MO操作属性已经存在！");
			return false;
		}
		window.returnValue = new MoObject(parentNode.value,curNode.text);
		top.close();
	}
}
function MoObject(moId,operName){
	this.moId = moId;
	this.operName = operName;
}
function chkOld(pValue){
	if(oldArr==null) return false;
	for(var i=0;i<oldArr.length;i++){
		if(oldArr[i]==pValue){
			return true;
		}
	}
	return false;
}
function cancelFunc()
{
  top.close();
}

</script>
