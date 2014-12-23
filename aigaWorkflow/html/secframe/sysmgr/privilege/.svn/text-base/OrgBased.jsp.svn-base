<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<ai:scriptinclude src="/jsv2/json.js" />
<html>
<head>
<title>根据组织授权</title>
</head>
<body onLoad="init()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td bgcolor="#FFFFFF"  align="center" height="130" style="padding-left:5px;" valign="top"><ai:tab id="tabPrivilegeObj" getParameter="getParameter"  width="380"
										height="130"  type="H">
              <ai:tabitem id="staff" src="OrgTree.jsp" title="员工" />
              <ai:tabitem id="station" src="OrgTree.jsp" title="岗位" />
              <ai:tabitem id="stationType" src="StationTypeQuery.jsp"
											title="岗位类型" />
            </ai:tab>
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
                <td style="height: 20px">搜索结果列表</td>
                <td align="right" style="height: 20px"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF"  align="left" height="60" style="padding-left:5px;" valign="top"><select id="searchList" style="width:320px"
										size="7" onChange="qryMoList();">
            </select>
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
                <td style="height: 20px">MO列表</td>
                <td align="right" style="height: 20px"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF"  align="left" height="100" style="padding-left:5px;" valign="top"><ai:table setname="com.ai.secframe.bo.sysmgr.QrySysPermission"
									tableid="tblPermission" needrefresh="true" initial="false"
									multiselect="false" editable="false" pagesize="50"
									onrowchange="getMoInfo" width="320" height="100"
									tablemodel="com.ai.appframe2.web.datamodel.QueryModelForService"
									implservice_name="com.ai.secframe.service.sysmgr.Privilege"
									implservice_querymethod="qrySysPermission"
									implservice_countmethod="qrySysPermissionCount">
              <ai:col fieldname="PERMISSION_ID" visible="false" />
              <ai:col fieldname="MO_ID" visible="false"/>
              <ai:col fieldname="MO_NAME" />
              <ai:col fieldname="OPERATOR_NAME" />
            </ai:table>          </td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="center" height="30" valign="middle"><input name="Input4" type="button" class="btn-2word" value="增加" id="Input3" onClick="addMo()"/>
            &nbsp;
            <input name="Input4" type="button" class="btn-2word" value="删除" id="Input4" onClick="delMo()"/>
          </td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html><script language="javascript">
var searchListSel = document.all.item("searchList").options;
var tblPermission = g_TableRowSetManager.get("tblPermission");
var curTab = null;
var moId = null;
var permId = null;
var operName = null;
var flag = 1;
function getMoId(){
	return moId;
}
function getOperName(){
	return operName;
}
function getPermId(){
	return permId;
}
function init(){
	window.parent.curTab = "orgbased";
	if(curTab==null){
		setTabItem("tabPrivilegeObj","staff");
		window.parent.curChildTab = "staff";
		curTab = "staff";
	}
}
function getParameter(itemId){
	clearSearchList();
	window.parent.clearAll();
	window.parent.curChildTab = itemId;
	curTab = itemId;
	var tab = eval("tabPrivilegeObj_"+itemId);
	window.parent.globalVar(itemId.toUpperCase());
	tblPermission.refresh("staff_id=-1");
	if(tab.flag!=undefined){
		tab.init();
	}
}
function qryObj(codeValue){
	var url = "";
	var type = (curTab).toLowerCase();
	clearSearchList();
	if(type=="staff"){
		url = _gModuleName + "/business/com.ai.secframe.web.sysmgr.PrivilegeAction?action=qrySysStaff&orgId="+codeValue;
		var ret = PostInfotoServer(url,"");
		if(ret!="NO"){
			var objJSON = ret.parseJSON();
			for(var i=0;i<objJSON.Staff.length;i++){
				searchList[i] = new Option(objJSON.Staff[i].staffName,objJSON.Staff[i].staffId,false,false);
			}
		}
	}else if(type=="station"){
		url = _gModuleName + "/business/com.ai.secframe.web.sysmgr.PrivilegeAction?action=qrySysStation&orgId="+codeValue;
		var ret = PostInfotoServer(url,"");
		if(ret!=""&&ret!="NO"){
	 		var objJSON = ret.parseJSON();
			for(var i=0;i<objJSON.Station.length;i++){
				searchList[i] = new Option(objJSON.Station[i].stationName,objJSON.Station[i].stationId,false,false);
			}
		}
	}else if(type=="stationtype"){
		url = _gModuleName+ "/business/com.ai.secframe.web.sysmgr.PrivilegeAction?action=qrySysStationType&typeName="+codeValue.split("$")[1]+"&typeId="+codeValue.split("$")[0];
		var ret = PostInfotoServer(url,"");
		if(ret!=null&&ret!="NO"){
  			var statTpye = ret.parseJSON();
  			for(var i=0;i<statTpye.StationType.length;i++){
  				searchList[i] = new Option(statTpye.StationType[i].statTypeName,statTpye.StationType[i].statTypeId,false,false);
  			}
  		}
  	} 	
}
function clearSearchList(){
	searchListSel.length = 0;
}
function qryMoList(){
	window.parent.clearMOPre();
	window.parent.allPrs.length = 0;
	if(searchListSel.length<=0)
		return false;
	var cond = "";
	if(curTab == "staff")
		cond = "staff_id="; 
	else if(curTab == "station")
		cond = "station_id="; 
	else if( curTab == "stationType" )
		cond = "station_type_id=";
	else if(curTab == "orgQuery"){
		curTab = tabPrivilegeObj_orgQuery.getCurTab();
		if(curTab == "staff")
			cond = "staff_id="; 
		else if(curTab == "station")
			cond = "station_id="; 		
	}
	cond += searchList.value;
	tblPermission.refresh(cond);
	if(tblPermission.count()>0)
		tblPermission.setRow(0);
}
function delMo(){
	if(tblPermission.getRow()>=0){
		var permId = tblPermission.getValue(tblPermission.getRow(),"PERMISSION_ID");
		window.parent.delPerm(permId);
		qryMoList();
		window.parent.clearAll();
		getParameter(curTab)
	}
}
function addMo(){
	if(searchList.length < 1) return;
	var arrMo = new Array();
	for(var i=0;i<tblPermission.count();i++){
		arrMo[i] = tblPermission.getValue(tblPermission.getRow(),"MO_ID")+","+tblPermission.getValue(tblPermission.getRow(),"OPERATOR_NAME");
	}
	var ret = window.showModalDialog("MoSelect.jsp",arrMo,"scroll:no;help:no;resizable:no;status:no;dialogHeight:450px;dialogWidth:300px");
	if(ret !=null){	
		window.moId = ret.moId;
		window.operName = ret.operName;
		window.parent.save(searchList.value);
    	qryMoList();
    }
}
function getMoInfo(){
	permId = tblPermission.getValue(tblPermission.getRow(),"PERMISSION_ID");
	operName = tblPermission.getValue(tblPermission.getRow(),"OPERATOR_NAME");
	moId = tblPermission.getValue(tblPermission.getRow(),"MO_ID");
	window.parent.qryPerm(permId);
	window.parent.qryMoInfo(moId);
}
function getCurTab(){
	return curTab;
}
</script>
