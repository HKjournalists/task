<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<%@ page import="com.ai.appframe2.web.HttpUtil" %>
<%
	String orgIdStr = HttpUtil.getParameter(request,"org_id");
	String initial = "true";
	long orgId = -1;
	long orgRoleId = -1;
	if(orgIdStr==null || orgIdStr.equals("")){
		initial = "false";
	}else{
		orgId = Long.parseLong(HttpUtil.getParameter(request,"org_id"));		
		orgRoleId = ((com.ai.secframe.service.orgmodel.interfaces.ISysOrganize) com.ai.appframe2.service.ServiceFactory.getService( com.ai.secframe.common.Constants.SERVICE_SYS_ORGANIZE )).getSysOrganizeById(orgId).getOrgRoleTypeId();
		request.setAttribute("condition", "orgId=" + orgId);
	}
%>
<HTML>
<head>
<title>组织管理</title>
</head>
<body>
<table width="98%"  align=center cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px">岗位类型</td>
                <td align="right" style="height: 20px">&nbsp;</td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="left" height="180" valign="top">
          
<ai:table setname="com.ai.secframe.bo.sysmgr.QSysStationInfo" tableid="station_tbl"
					          tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
					          implservice_name="com.ai.secframe.service.sysmgr.SysStation"
					          implservice_querymethod="getSysStationInfo(long orgId)"
					          footdisplay="none" editable="true" rowsequence="true" conditionname="condition"
					          height="180" width="650" multiselect="true" initial="<%=initial%>"
					          onrowselected="selectAction" ondbclick="" needrefresh="true">
						<ai:col fieldname="STATIONTYPE_NAME" edittype="DBTree" width="250" editable="false" />
						<ai:col fieldname="STATIONTYPE_CODE" editable="true" width="120" visible="false"/>
						<ai:col fieldname="STATION_TYPE_ID" visible="false" />
						<ai:col fieldname="STATION_ID" visible="false" />
						<ai:col fieldname="STATION_NAME" editable="false" width="240" />
						<ai:col fieldname="STATION_CODE" editable="false" width="240" />
						<ai:col fieldname="ORGANIZE_ID" editable="false" width="180" />
						<ai:col fieldname="WORK_DESC" editable="true" width="120" />
						<ai:col fieldname="NOTES" editable="true" width="120" />
						<ai:col fieldname="FL" editable="true" width="120" visible="false" />
					</ai:table>         
</td>
        </tr>
        <tr>
          <td align="center" style="padding-top:5px; padding-bottom:5px; background-color:#FFFFFF"><input name="" type="button" class="btn-2word" value="保存" id="savebtn" onClick="updateAction()"/>
            &nbsp;
            <input name="" type="button" class="btn-2word" value="全选" id="selbtn" onClick="selectAll()"/>
            &nbsp;
            <input name="" type="button" class="btn-4word" value="取消全选" id="selbtn" onClick="notSelectAll()"/>
          </td>
        </tr>
        <tr>
          <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px">岗位列表</td>
                <td align="right" style="height: 20px"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="center" height="180">
<ai:table setname="com.ai.secframe.bo.sysmgr.QSysStationInfoExsit" 
										tableid="tblExsitStation" 
										tablemodel="com.ai.appframe2.web.datamodel.QueryModelForService" 
										implservice_name="com.ai.secframe.service.sysmgr.SysStation"
										implservice_querymethod="queryQSysStationInfoExsit" 
										implservice_countmethod="queryQSysStationInfoExsitCount" 
										footdisplay="none"
										needrefresh="true" initial="false" multiselect="true" rowsequence="true"
										editable="true" height="180" width="650" ondbclick="showStaffAction">
						<ai:col fieldname="STATION_ID" visible="false"/>
						<ai:col fieldname="STATION_NAME" width="180"/>
						<ai:col fieldname="CODE" width="180"/>
						<ai:col fieldname="STATION_TYPE_NAME" width="180"/>
						<ai:col fieldname="VALID_DATE" width="180"/>
						<ai:col fieldname="EXPIRE_DATE" width="180"/>
						<ai:col fieldname="WORK_DESC" width="180"/>
						<ai:col fieldname="NOTES" width="180"/>
						
					</ai:table>
          </td>
        </tr>
        <tr>
          <td align="center" style="padding-top:5px; padding-bottom:5px;" bgcolor="#FFFFFF"><input name="" type="button" class="btn-2word" value="删除" id="delbtn" onClick="deleteAction()"/>
            &nbsp;
            <input name="" type="button" class="btn-2word" value="保存" id="" onClick="saveStation()"/>
            &nbsp; </td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html><script type="text/javascript">
var orgId = "<%=HttpUtil.getParameter(request,"org_id")%>";
var orgRoleTypeId = "<%=orgRoleId%>";
var orgName = "<%=java.net.URLDecoder.decode(request.getParameter("org_name"),"UTF-8")%>";
function gridLoad(){
	var gRowSet = g_TableRowSetManager.get("station_tbl");
	var tblCount = gRowSet.count();
	if(orgId==""||orgId==null||orgRoleTypeId==""||orgRoleTypeId==null){
		//alert("请选择组织");
		return;
	}
	if(orgId==-1||orgRoleTypeId==-1){
		savebtn.disabled = true;
	}else{
		savebtn.disabled = false;
	}
	gRowSet.visibleSelect(-100,false);
	for(i=0;i<tblCount;i++){
		var fl = gRowSet.getValue(i,"FL");
		var stationId = gRowSet.getValue(i,"STATION_ID");
		if(fl=="STATION_TYPE_KIND"){
			gRowSet.setRowEditSts(i,false);
			//gRowSet.disabledSelect(i,true);
			gRowSet.visibleSelect(i,false);
			gRowSet.setValue(i,"ORGANIZE_ID","");
		}
		if(fl=="STATION_TYPE" && stationId!=null && stationId!=""){
			gRowSet.rowSelected(i,true,true);
		}
		if(fl=="STATION_TYPE"){
			gRowSet.setValue(i,"ORGANIZE_ID",orgId,orgName);
		}
		if(fl=="STATION_TYPE" && stationId==""){
			gRowSet.setValue(i,"DEFAULT_DISPATCH_FLAG","N","否");
		}
		if(fl=="STATION_TYPE" && gRowSet.isSelected(i)==false){
			gRowSet.setValue(i,"FL","STATION_TYPE,DELETE");
		}
	}
	//document.all.item("legend").innerText = "组织\""+orgName+"\"包含权限点";
	var gExsitRowSet = g_TableRowSetManager.get("tblExsitStation");
	gExsitRowSet.refresh("ORGANIZE_ID="+orgId);
}

function saveStation(){
var gRowSet = g_TableRowSetManager.get("tblExsitStation");
var list = new Array();
	list[0] = gRowSet;	
	  var retMsg = saveRowSet("<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysStationAction?action=save",list);
var gExsitRowSet = g_TableRowSetManager.get("tblExsitStation");
gExsitRowSet.refresh("ORGANIZE_ID="+orgId);

}

function showStaffAction(){
  var gRowSet = g_TableRowSetManager.get("tblExsitStation");
  var curIndex = gRowSet.getRow();
	if(curIndex == -1){
	  alert("请选择岗位后查询");
	  return;
	}
	var stationId = gRowSet.getValue(curIndex,"STATION_ID");
	var stationName = gRowSet.getValue(curIndex,"STATION_NAME");
	
	var paraArray = new Array();
	paraArray.push(stationId);
	paraArray.push(stationName);
	var d = new Date();
	//window.showModalDialog("partyStation.jsp?d="+d.getTime(),paraArray,"scroll:no;resizable:no;status:no;dialogHeight:450px;dialogWidth:600px;help:no");
}
function updateAction(){
  var gRowSet = g_TableRowSetManager.get("station_tbl");
  if( gRowSet.toXmlString(true)=="" ) return ;
  var selRows = gRowSet.getSelectedRows();
  for(var i=0;i<selRows.length;i++){
  	if(gRowSet.getValue(i,"FL")=="STATION_TYPE" && gRowSet.getValue(i,"STATION_ID")!=""){
  		if( gRowSet.getValue(i,"STATION_CODE") == null || gRowSet.getValue(i,"STATION_CODE") == "" ){
     		alert("第"+(i+1)+"行的权限点代码不能为空,请填写权限点代码");
     		gRowSet.setFocusByName(i,"STATION_CODE");
     		return;
  		}
  		if( gRowSet.getValue(i,"STATION_NAME") == null || gRowSet.getValue(i,"STATION_NAME") == "" ){
     		alert("第"+(i+1)+"行的权限点名称不能为空,请填写权限点名称");
     		gRowSet.setFocusByName(i,"STATION_NAME");
     		return;
  		}
  		if( gRowSet.getValue(i,"STATION_TYPE_ID") == null || gRowSet.getValue(i,"STATION_TYPE_ID") == "" ){
     		alert("第"+(i+1)+"行的岗位类型不能为空,请选择岗位类型");
     		gRowSet.setFocusByName(i,"STATION_TYPE_ID");
     		return;
  		}
  		if( gRowSet.getValue(i,"ORGANIZE_ID") == null || gRowSet.getValue(i,"ORGANIZE_ID") == "" ){
     		alert("第"+(i+1)+"行的所属组织不能为空,请选择权限点所属组织");
     		gRowSet.setFocusByName(i,"ORGANIZE_ID");
     		return;
  		}
  	}
  }
  var list = new Array();
  list.push(gRowSet);
  //alert(gRowSet.toXmlString());
  var retMsg = saveRowSet("<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysStationAction?action=saveStation",list);
  var ret = retMsg.getValueByName("retVal");
  var msg = retMsg.getValueByName("msg");
  if( ret == 0){
  	alert("权限点数据保存成功");
  }else if( ret==-1 ){
  	alert(msg);
  }else if( ret == -2 ){
    alert("权限点数据保存失败,错误信息:"+msg);
  }else
   	alert("权限点数据保存失败,未知的错误代码:"+ret);
  gRowSet.refresh("orgId="+orgId+"&orgRoleTypeId="+orgRoleTypeId);
  gridLoad();
}

function deleteAction(){
	var gRowSet = g_TableRowSetManager.get("tblExsitStation");
	var gStationRowSet = g_TableRowSetManager.get("station_tbl");
	var selCount = gRowSet.getSelectedRows();
	var len = selCount.length;
	if( len <= 0 ){
		alert("请先选择要删除的权限点！");
	  return;
	}
	if(window.confirm("是否确定要删除这些权限点?")){
		for( var i=len-1;i>=0;i-- ){
			gRowSet.deleteRow(selCount[i]);
		}
		var list = new Array();
  	list.push(gRowSet);
  	var retMsg = saveRowSet("<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysStationAction?action=deleteStation",list);
  	var ret = retMsg.getValueByName("retVal");
  	var msg = retMsg.getValueByName("msg");
  	if(ret=="0"){
  		alert("权限点删除成功！");
  	}else{
  		alert("权限点删除失败，失败原因是："+msg);
  	}
  	gStationRowSet.refresh("orgId="+orgId+"&orgRoleTypeId="+orgRoleTypeId);
  	gridLoad();
	}
}

function selectAction(RowIndex,isSelected){
	var gRowSet = g_TableRowSetManager.get("station_tbl");
	//alert(gRowSet.getValue(RowIndex,"STATION_CODE"));
	if(isSelected==true && gRowSet.getValue(RowIndex,"STATION_CODE")=="" && gRowSet.getValue(RowIndex,"STATION_NAME")==""){
		gRowSet.setValue(RowIndex,"STATION_CODE",orgId+"-"+gRowSet.getValue(RowIndex,"STATIONTYPE_CODE"));
		gRowSet.setValue(RowIndex,"STATION_NAME",orgName+"-"+gRowSet.getValue(RowIndex,"STATIONTYPE_NAME"));
	}
	if(isSelected==false){
		gRowSet.setValue(RowIndex,"FL","STATION_TYPE,DELETE");
	}
	if(isSelected==true){
		gRowSet.setValue(RowIndex,"FL","STATION_TYPE");
	}
	if(isSelected==false){
		gRowSet.setValue(RowIndex,"STATION_CODE","");
		gRowSet.setValue(RowIndex,"STATION_NAME","");
		gRowSet.setValue(RowIndex,"WORK_DESC","");
		gRowSet.setValue(RowIndex,"NOTES","");
	}
}
function selectAll(){
		var gRowSet = g_TableRowSetManager.get("station_tbl"); 
		gRowSet.selectAll(true);
		var selRows = gRowSet.getSelectedRows();
		if(selRows!=null && selRows.length>0){
			for(var i=0;i<selRows.length;i++){
				if(gRowSet.getValue(selRows[i],"STATION_CODE")=="" && gRowSet.getValue(selRows[i],"STATION_NAME")==""){
					gRowSet.setValue(selRows[i],"STATION_CODE",orgId+"-"+gRowSet.getValue(selRows[i],"STATIONTYPE_CODE"));
					gRowSet.setValue(selRows[i],"STATION_NAME",orgName+"-"+gRowSet.getValue(selRows[i],"STATIONTYPE_NAME"));
				}
				gRowSet.setValue(selRows[i],"FL","STATION_TYPE");
			}
		}
	}
function notSelectAll(){
	var gRowSet = g_TableRowSetManager.get("station_tbl"); 
	gRowSet.selectAll(false);
	for(var i=0;i<gRowSet.count();i++){
		if(gRowSet.getValue(i,"FL")!="STATION_TYPE_KIND"){
			gRowSet.setValue(i,"FL","STATION_TYPE,DELETE");
			gRowSet.setValue(i,"STATION_CODE","");
			gRowSet.setValue(i,"STATION_NAME","");
			gRowSet.setValue(i,"WORK_DESC","");
			gRowSet.setValue(i,"NOTES","");
		}
	}
}
gridLoad();
</script>
