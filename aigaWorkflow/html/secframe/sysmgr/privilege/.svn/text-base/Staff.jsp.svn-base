<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<ai:scriptinclude src="/secframe/common/common.js" />
<script language="JavaScript"
	src="<%=request.getContextPath()%>/jsv2/HtmlParameter.js"></script>
<HTML>
<head>
<title>被管对象下的员工</title>
</head>
<ai:loginuser />
<body onLoad="init()" style="width:100%;height:100%;overflow:auto">
<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
  <tr>
    <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
        <tr>
          <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
          <td style="height: 20px">员工选择</td>
          <td align="right" style="height: 20px"></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"  align="center" height="160" style="padding-left:5px;" valign="top"><ai:table setname="com.ai.secframe.bo.sysmgr.QrySysPermission"
						tableid="tblStaff" needrefresh="true" initial="false"
						multiselect="false" editable="false" pagesize="50" width="330"
						height="140" onrowchange="qryPer"
						tablemodel="com.ai.appframe2.web.datamodel.QueryModelForService"
						implservice_name="com.ai.secframe.service.sysmgr.Privilege"
						implservice_querymethod="qryStaffByMoId"
						implservice_countmethod="qrySysPermissionCount">
        <ai:col fieldname="PERMISSION_ID" visible="false" />
        <ai:col fieldname="STAFF_ID" visible="false" />
        <ai:col fieldname="STAFF_CODE" />
        <ai:col fieldname="STAFF_NAME" />
        <ai:col fieldname="ORG_NAME" />
      </ai:table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" align="center" height="35" valign="middle"><input name="Input" type="button" class="btn-2word" value="增加" id="newBtn" onClick="addStaff()"/>
      &nbsp;
      <input name="Input" type="button" class="btn-2word" value="删除" id="delBtn" onClick="delStaff()"/>
    </td>
  </tr>
</table>
</body>
</html><script type="text/javascript">
<!--
var flag = 1;
var tabStaff = g_TableRowSetManager.get("tblStaff");
function qryPer(){	

	var permId = tabStaff.getValue(tabStaff.getRow(),"PERMISSION_ID");
	//alert(permId);
	//alert(tabStaff.getValue(tabStaff.getRow(),"STAFF_ID"));
	window.parent.permId = permId;
	window.parent.parent.qryPerm(permId);
}
function init(){
	var moId = window.parent.moId;
	var operName = window.parent.operName;
	if(moId==null){
		return false;
	}else{
    	var cond = "mo_id='"+moId+"' and operator_name='"+operName+"' and STAFF_ID is not null";
		tabStaff.refresh(cond);
		if(tabStaff.count()>0){
			//tabStaff.setRow(0);
		}
	}
	//qryPer();
}
function delStaff(){
	if(window.confirm("你确定要删除所属员工"+tabStaff.getValue(tabStaff.getRow(),"STAFF_NAME")+"吗?")){
 		//alert(tabStaff.getValue(tabStaff.getRow(),"STAFF_ID")+":"+tabStaff.getValue(tabStaff.getRow(),"PERMISSION_ID"));
 		//return;
 		window.parent.parent.delPerm(tabStaff.getValue(tabStaff.getRow(),"PERMISSION_ID"));
 		init();
 	}
}
function addStaff(){
	//alert(window.parent.moId);
	if( window.parent.moId == null ) return ;
  	var oldStaffArray = new Array();
  	for( var i=0;i<tabStaff.count();i++ )
    	oldStaffArray[i] = tabStaff.getValue(i,"STAFF_ID");
  	

	var ret = window.showModalDialog("../../orgmodel/staff/QSysStaffSelect.jsp?staffprivilege=staffprivilege","org","scroll:no;resizable:no;status:no;dialogHeight:700px;dialogWidth:900px");
  	if(ret!=null){
  		ret[0] = ret[0].substr(0,ret[0].length-1);
  		window.parent.parent.save(ret[0]);
  		init();
  	}
}
function initPermId(){
	if(tabStaff.getRow()<=-1){
		window.parent.permId = null;
	}else{
		window.parent.permId = tabStaff.getValue(tabStaff.getRow(),"PERMISSION_ID");
	}
}
//-->
</script>
