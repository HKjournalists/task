<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="java.util.HashMap" %>
<%@include file="/secframe/common/common.jsp"%>
<html>
<head>
<script language=javascript>
var curRoleId = -1;
var curRoleName = "";
//查询某角色下所有的岗位类型数据
function roleStationTypeReload(){
	if(curRoleId==null){
		curRoleId = -1;
	  curRoleName = "";
  }
	if(curRoleId==-1){
		//设置岗位类型的操作按钮为不可视
    setBtnVisible(false);
	}else{
		setBtnVisible(true);
	}
	var stationTypeRowSet = g_TableRowSetManager.get("tblStationType");
  var cond = "orgRoleTypeId="+curRoleId;
  //alert(cond);
  stationTypeRowSet.refresh(cond);
  var tblCount = stationTypeRowSet.count();
  stationTypeRowSet.visibleSelect(-100,false);
  for(i=0;i<tblCount;i++){
		var fl = stationTypeRowSet.getValue(i,"FL");
		if(fl=="STATION_TYPE_KIND"){
			stationTypeRowSet.visibleSelect(i,false);
		}
		flag = fl.split(":");
		if(flag.length==2 && flag[1]=="SELECT"){
			stationTypeRowSet.rowSelected(i,true,true);
		}
	}
}

//保存对岗位类型所做的修改
function updateStationTypeAction(){
	var stationType = g_TableRowSetManager.get("tblStationType");
	if( stationType.toXmlString(true) == "" ){
		return;
	}
	var list = new Array();
	list.push(stationType);
	var url = "<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysStationTypeModel?action=saveStationTypeRoleTypeRelate&partyRoleTypeId="+curRoleId;
	var retMsg = saveRowSet(url,list,false);
	var retVal = retMsg.getValueByName("retVal");
	if(retVal=="OK"){
		alert("保存数据成功");
	}else {
		alert(retVal);
	}
	roleStationTypeReload();
}

function setBtnVisible(flag){
	if(flag)
		document.all.item("buttonDiv").style.display = "block";
	else
	  document.all.item("buttonDiv").style.display = "none";
}

//行改变
function rowChange(oldRow,newRow){
  var roleRowSet = g_TableRowSetManager.get("tblRoleTypeInfo");
  curRoleId = roleRowSet.getValue(newRow,"ORG_ROLE_TYPE_ID");
  curRoleName = roleRowSet.getValue(newRow,"ORG_ROLE_TYPE_NAME");
  roleStationTypeReload();
}

function select(){	
	var dbtree = g_DBTreeNewManager.get("tree");
	var curNode = dbtree.getCurNodeInfo();
	if(curNode== null)
		return;
	
  curRoleId = curNode.value;
  curRoleName = curNode.text;
  //alert(curRoleId);
  roleStationTypeReload();
}

function selectAction(RowIndex,isSelected){
	var gRowSet = g_TableRowSetManager.get("tblStationType");
	if(isSelected==true){
		gRowSet.setValue(RowIndex,"FL","STATION_TYPE:SELECT");
	}else{
		gRowSet.setValue(RowIndex,"FL","STATION_TYPE");
	}
}
</script>
<title>岗位类型管理和组织类型关系</title>
</head>
<body>
<table width="100%" bgcolor="#FFFFFF" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="250" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"><table width="250" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px">组织类型</td>
                <td align="right" style="height: 20px"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="left" style="padding-left:10px;"><ai:dbtree_new
					id="tree" height="450" width="250"
					datamodel="com.ai.secframe.web.orgmodel.OrgTypeTreeModel"
					initial="true" ishaveline="true" multiselect="false"
					onselect="select" />
          </td>
        </tr>
      </table></td>
    <td valign="top" width="80%"  style="padding-left:10px"><table width="100%" border=0 cellpadding=0 cellspacing=0 id="mainTable">
        <tr>
          <td valign="top"  bgcolor="#FFFFFF"><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
              <tr>
                <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
                    <tr>
                      <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                      <td style="height: 20px"> 关联岗位类型</td>
                      <td align="right" style="height: 20px"><div id="buttonDiv" style="display:block">
                          <input name="" type="button" class="btn-2word" value="保存" id="updateStationTypeBtn" onClick="updateStationTypeAction()"/>
                        </div></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td bgcolor="#FFFFFF" align="left" valign="top"><ai:table setname="com.ai.secframe.bo.sysmgr.QSysStationKindAndTypeInfo" 
                                      tableid="tblStationType" 
                                      tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService" 
                                      implservice_name="com.ai.secframe.service.sysmgr.SysStationType"
                                      implservice_querymethod="getSysStationKindAndTypeInfo(long orgRoleTypeId)" 
                                      footdisplay="none" editable="false" rowsequence="true" pagesize="50" 
                                      height="430" width="600" multiselect="true" initial="false"
                                      onrowselected="selectAction" needrefresh="true">
                    <ai:col fieldname="STATIONTYPE_NAME" edittype="DBTree" width="200" />
                    <ai:col fieldname="STATIONTYPE_CODE" width="180" />
                    <ai:col fieldname="NOTES" width="180" />
                    <ai:col fieldname="STATION_TYPE_ID" visible="false" />
                    <ai:col fieldname="FL" visible="false" width="200"/>
                  </ai:table></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html>