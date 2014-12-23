<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<script language="JavaScript"
	src="<%=request.getContextPath()%>/jsv2/HtmlParameter.js"></script>
<HTML>
<head>
<title>被管对象下的岗位</title>
</head>
<body onLoad="init()" style="width:100%;height:100%;overflow:auto">
<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
  <tr>
    <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
        <tr>
          <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
          <td style="height: 20px">岗位选择</td>
          <td align="right" style="height: 20px"></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"  align="center" height="160" style="padding-left:5px;" valign="top"><ai:table setname="com.ai.secframe.bo.sysmgr.QrySysPermission"
							tableid="tblStation" needrefresh="true" initial="false"
							multiselect="false" editable="false" pagesize="50" width="330"
						height="140" onrowchange="qryPer"
							tablemodel="com.ai.appframe2.web.datamodel.QueryModelForService"
							implservice_name="com.ai.secframe.service.sysmgr.Privilege"
							implservice_querymethod="qrySysPermission"
							implservice_countmethod="qrySysPermissionCount">
        <ai:col fieldname="PERMISSION_ID" visible="false" />
        <ai:col fieldname="STATION_ID" visible="false" />
        <ai:col fieldname="STATION_CODE" width="120"/>
        <ai:col fieldname="STATION_NAME" width="200" />
      </ai:table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" align="center" height="35" valign="middle"><input name="Input" type="button" class="btn-2word" value="增加" id="newBtn" onClick="addStation()"/>
      &nbsp;
      <input name="Input" type="button" class="btn-2word" value="删除" id="delBtn" onClick="delStation()"/>
    </td>
  </tr>
</table>
</body>
</html><script language="javascript">
var tblStation = g_TableRowSetManager.get("tblStation");
var flag = 1;
function init(){
	var moId = window.parent.moId;
	var operName = window.parent.operName;
	if(moId==null){
		return false;
	}else{
    	var cond = "mo_id='"+moId+"' and operator_name='"+operName+"' and STATION_ID is not null";
		tblStation.refresh(cond);
		if(tblStation.count()>0)
			tblStation.setRow(0);
	}
}
function addStation(){
	var moId = window.parent.moId;;
  	if( moId == null ) 
  		return ;
  	var arr = new Array();
   	var len = tblStation.count();
   	for( var i=0;i<len;i++)
   		arr.push(tblStation.getValue(i,"STATION_ID"));
  	

	var ret = window.showModalDialog("../author/StationSelect.jsp?org_id=<%=SessionManager.getUser().getOrgId()%>&staff_id=0","","scroll:no;resizable:no;status:no;dialogHeight:450px;dialogWidth:300px;help:no");
	if(ret!=null){
     	var tempStr = "";
  		for(var i=0;i<ret.length;i++){
  			tempStr += ","+ret[i].id;
  		}
		window.parent.parent.save(tempStr.substring(1));
		init();
	} 
}


function delStation(){
	if( tblStation.getRow() != -1 && window.confirm("你确定要删除所属岗位"+tblStation.getValue(tblStation.getRow(),"STATION_NAME")+"吗?")){
   		window.parent.parent.delPerm(tblStation.getValue(tblStation.getRow(),"PERMISSION_ID"));
 		init();
	}
}
function qryPer(){	
	var permId = tblStation.getValue(tblStation.getRow(),"PERMISSION_ID");
	window.parent.permId = permId;
	window.parent.parent.qryPerm(permId);
}
function initPermId(){
	if(tblStation.getRow()<=-1){
		window.parent.permId = null;
	}else{
		window.parent.permId = tblStation.getValue(tblStation.getRow(),"PERMISSION_ID");
	}
}
</script>
