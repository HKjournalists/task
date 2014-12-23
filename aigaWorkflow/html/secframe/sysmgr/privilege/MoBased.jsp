<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<!--
页面名称：mobased
页面功能：按照MO为导向，对员工，岗位和岗位类型进行授权
作者：马进
创建日期：2006-3-2
-->
<html>
	<head>
		<title>权限管理页面</title>
	</head>
	<body onLoad="init()" style="width:100%;height:100%;overflow:auto">
	
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
                    <tr>
                      <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
                          <tr>
                            <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                            <td style="height: 20px">被管对象选择</td>
                            <td align="right" style="height: 20px"></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr>
                      <td bgcolor="#FFFFFF" align="left" style="padding-left:5px;" height="160" valign="top">
					  <ai:dbtree_new id="sysdirtree"
										datamodel="com.ai.secframe.web.sysmgr.DBTreeModelSysMo"
										width="350" height="180" multiselect="false" ishaveline="true" onselect="refdata"/>
                      </td>
                    </tr>
                  </table></td>
      </tr>
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
                    <tr>
                      <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
                          <tr>
                            <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                            <td style="height: 20px">对象的所有属性</td>
                            <td align="right" style="height: 20px"></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr>
                      <td bgcolor="#FFFFFF" align="left" height="160" valign="top">
					  <ai:tab id="tab" getParameter="getParameter" width="380"
										height="250">
										<ai:tabitem id="staff" width="60" src="Staff.jsp" title="员工" />
										<ai:tabitem id="station" width="60" src="Station.jsp" title="岗位" />
										<ai:tabitem id="stationtype" width="120" src="StationType.jsp"
											title="岗位类型" />
									</ai:tab>
					
					</td>
                    </tr>
                  </table></td>
      </tr>
    </table>
	
	
	
	
	
	
	
	
	
	
	
	
	
	</body>
<script language="javascript">
var dbtree= g_DBTreeNewManager.get("sysdirtree");
var curTab = null;
var moId = null;
var operName = null;
var permId = null;
var flag = 1;
function getPermId(){
	return permId;
}
function getOperName(){
	return operName;
}
function getMoId(){
	return moId;
}
function init(){
	window.parent.curTab = "mobased";
}
function refdata(){
	var curNode = dbtree.getCurNodeInfo();
	var parentNode = dbtree.getParentNodeInfo(curNode.value);
	//alert(curNode.value);
	
	if(curNode.userobj=="O"){
		moId = parentNode.value;
		
		operName = curNode.text;
		//alert(moId+"|"+operName);
		permId = null;
		if(curTab == null){
			curTab = "staff";
			setTabItem("tab","staff");
		}else{
			var tab = eval("tab_"+curTab);
			if(tab.flag==undefined)
				return;
			else
				tab.init();
		}
		window.parent.refrRight(moId);
	}
}
function getParameter(itemId){
	curTab = itemId;
	window.parent.clearMOPre();
	window.parent.globalVar(itemId.toUpperCase());
	var tab = eval("tab_"+itemId);
	if(tab.flag!=null){
		tab.initPermId();
		window.parent.qryPerm(permId);
	}
}
function getCurTab(){
	return curTab;
}
</script>
</html>
