<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<ai:scriptinclude src="/secframe/common/common.js" />
<script language="JavaScript"
			src="<%=request.getContextPath()%>/jsv2/HtmlParameter.js"></script>
<HTML>
<head>
<title>被管对象下的岗位类型</title>
</head>
<body onLoad="init()" style="width:100%;height:100%;overflow:auto">
<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
  <tr>
    <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
        <tr>
          <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
          <td style="height: 20px">岗位类型选择</td>
          <td align="right" style="height: 20px"></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"  align="center" height="160" style="padding-left:5px;" valign="top"><ai:table setname="com.ai.secframe.bo.sysmgr.QrySysPermission"
							tableid="tblStationType" needrefresh="true" initial="false"
							multiselect="false" editable="false"  pagesize="50" width="330"
						height="140"  onrowchange="qryPer"
							tablemodel="com.ai.appframe2.web.datamodel.QueryModelForService"
							implservice_name="com.ai.secframe.service.sysmgr.Privilege"
							implservice_querymethod="qrySysPermission"
							implservice_countmethod="qrySysPermissionCount">
        <ai:col fieldname="PERMISSION_ID" visible="false" />
        <ai:col fieldname="STATION_TYPE_ID" visible="false" />
        <ai:col fieldname="STATION_TYPE_CODE" width="140" />
        <ai:col fieldname="STATION_TYPE_NAME" width="165" />
      </ai:table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" align="center" height="35" valign="middle"><input name="Input" type="button" class="btn-2word" value="增加" id="newBtn" onClick="addStationType()"/>
      &nbsp;
      <input name="Input" type="button" class="btn-2word" value="删除" id="delBtn" onClick="delStationType()"/>
    </td>
  </tr>
</table>
</body>
</html><script language="javascript">
var tblStationType = g_TableRowSetManager.get("tblStationType");
var flag = 1;
function init(){
	var moId = window.parent.moId;
	var operName = window.parent.operName;
	if(moId==null){
		return false;
	}else{
    	var cond = "mo_id='"+moId+"' and operator_name='"+operName+"' and STATION_TYPE_ID is not null";
		tblStationType.refresh(cond);
		if(tblStationType.count()>0)
			tblStationType.setRow(0);
	}
}
function addStationType(){
  	var oldArray = new Array();
   	var len = tblStationType.count();
   	for( var i=0;i<len;i++)
   		oldArray.push(tblStationType.getValue(i,"STATION_TYPE_ID"));
   	
   	var ret = stationTypeSelectDialog(oldArray,true);
  	if(ret!=null){
   		var tempStr = "";
   		for(var i=0;i<ret.length;i++){
  			tempStr += ","+ret[i].statTypeId;
  		}
  		//alert(tempStr.substring(1)+"|"+tempStr);
		window.parent.parent.save(tempStr.substring(1));
		init();
  	}
}

function delStationType(){
  	if(tblStationType.getRow() != -1 &&
      	window.confirm("你确定要删除所属岗位类型"+tblStationType.getValue(tblStationType.getRow(),"STATION_TYPE_NAME")+"吗?") ){
    	window.parent.parent.delPerm(tblStationType.getValue(tblStationType.getRow(),"PERMISSION_ID"));
    	init();
	}
}
function qryPer(){
	var permId = tblStationType.getValue(tblStationType.getRow(),"PERMISSION_ID");
	window.parent.permId = permId;
	window.parent.parent.qryPerm(permId);
}
function initPermId(){
	if(tblStationType.getRow()<=-1){
		window.parent.permId = null;
	}else{
		window.parent.permId = tblStationType.getValue(tblStationType.getRow(),"PERMISSION_ID");
	}
}
</script>
