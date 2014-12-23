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
                <td style="height: 20px">地区选择</td>
                <td align="right" style="height: 20px"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="left" style="padding-left:5px;" height="250" valign="top">
            <div id="byorg">
              <ai:dbtree_new id="disTree"
						datamodel="com.ai.secframe.web.orgmodel.SysDistrictTreeModel"
						multiselect="false" height="380" width="280" ishaveline="true" ondblclick="chkCur"/>
            </div></td>
        </tr>
      </table>	
		<table border=0 width=100% align="center">
			<tr>
				<td align="center">
				<input name="Input" type="button" class="btn-2word" value="确定" id="affirm" onClick="affirm()"/>
				&nbsp;
				<input name="Input" type="button" class="btn-2word" value="取消" id="cancel" onClick="cancel()"/>
				</td>
			</tr>
		</table>
	</body>
</html>
<script type="text/javascript">
<!--
var curNode = null;
var disTree = g_DBTreeNewManager.get("disTree");
function affirm(){
	curNode = disTree.getCurNodeInfo();
	if(curNode == null){
		alert("请选择区域！");
		return false;
	}
	var parentNode = disTree.getParentNodeInfo(curNode.value);
	if(parentNode.value=="-1"){
		window.returnValue = curNode.value+"|"+curNode.text+"&"+curNode.value+"|"+curNode.text;
	} else {
		window.returnValue = parentNode.value+"|"+parentNode.text+"&"+curNode.value+"|"+curNode.text;
	}
	
	window.self.close();
}
function cancel(){	
	window.self.close();
}
function chkCur(){
	affirm();
}
//-->
</script>
