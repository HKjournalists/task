<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="java.util.HashMap" %>
<%@include file="/secframe/common/common.jsp"%>
<html>
<head>
<%
	String cond = "STATE = 1 " ;
	request.setAttribute("condition" ,cond);
%>
<title>岗位角色管理</title>
</head>
<body>
<table width="100%" bgcolor="#FFFFFF" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="250"><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px">角色管理</td>
                <td align="right" style="height: 20px"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="left" style="padding-left:3px;"><table align="center">
              <tr>
                <td>
                  <ai:table tableid="tblRole"
					setname="com.ai.secframe.bo.sysmgr.SysRole"
					tablemodel="com.ai.secframe.web.sysmgr.SysMgrQueryModelForService"
					implservice_name="com.ai.secframe.service.sysmgr.SysRole"
					implservice_querymethod="querySysRole"
					implservice_countmethod="querySysRoleCount" initial="true" pagesize="20"
					width="330" height="350"
					onrowchange="queryStationType" needrefresh="true" conditionname="condition">
                    <ai:col fieldname="ROLE_ID" editable="false" visible="false" />
                    <ai:col fieldname="CODE" width="110"  visible="true" />
                    <ai:col fieldname="NAME" width="120"  visible="true" />
                    <ai:col fieldname="NOTES" width="120"  visible="true" />
                  </ai:table>
                </td>
              </tr>
              <tr heigth=30>
                <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">名称</td>
                      <td width="1"></td>
                      <td bgcolor="#F1F3FB" class="font13pxboldblack" colspan="5"><input id ='txtRoleId' class="dbform_disable_style"  disabled style="width:1; display:none"/>
                        <input id ='txtRoleName' class="dbform_disable_style" disabled style="width:200">
                        <span class="pr9">*</span></td>
                    </tr>
                    <tr>
                      <td height="1" class="font13pxboldblue1"></td>
                      <td width="1"></td>
                      <td class="font13pxboldblack"></td>
                      <td width="1"></td>
                      <td class="font13pxboldblack"></td>
                      <td width="1"></td>
                      <td class="font13pxboldblack"></td>
                    </tr>
                    <tr>
                      <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">编码</td>
                      <td width="1"></td>
                      <td bgcolor="#F1F3FB" class="font13pxboldblack" colspan="5"><input id ='txtRoleCode' class="dbform_disable_style" disabled style="width:200">
                        <span class="pr9">*</span></td>
                    </tr>
                    <tr>
                      <td height="1" class="font13pxboldblue1"></td>
                      <td width="1"></td>
                      <td class="font13pxboldblack"></td>
                      <td width="1"></td>
                      <td class="font13pxboldblack"></td>
                      <td width="1"></td>
                      <td class="font13pxboldblack"></td>
                    </tr>
                    <tr>
                      <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">备注</td>
                      <td width="1"></td>
                      <td bgcolor="#F1F3FB" class="font13pxboldblack" colspan="5"><input id ='txtRoleNotes' class="dbform_disable_style" disabled style="width:200"></td>
                    </tr>
                    <tr>
                      <td height="1" class="font13pxboldblue1"></td>
                      <td width="1"></td>
                      <td class="font13pxboldblack"></td>
                      <td width="1"></td>
                      <td class="font13pxboldblack"></td>
                      <td width="1"></td>
                      <td class="font13pxboldblack"></td>
                    </tr>
                    <tr>
                      <td height="1" class="font13pxboldblue1"></td>
                      <td width="1"></td>
                      <td class="font13pxboldblack"></td>
                      <td width="1"></td>
                      <td class="font13pxboldblack"></td>
                      <td width="1"></td>
                      <td class="font13pxboldblack"></td>
                    </tr>
                  </table>
              <tr >
                <td align="center" valign="middle">
                  <input name="" type="button" class="btn-2word" value="新增" id="addRoleBtn" onclick="addRoleAction()"/>
                  &nbsp;
                  <input name="" type="button" class="btn-2word" value="保存" id="saveRoleBtn" disabled onclick="saveRoleAction()"/>
                  &nbsp;
                  <input name="" type="button" class="btn-2word" value="删除" id="delRoleBtn" disabled onclick="delRoleAction()"/>
                </td>
              <tr>
            </table></td>
        </tr>
      </table></td>
    <td valign="top" width="80%"  style="padding-left:10px"><table border=0 cellspacing=0 cellpadding=0 id="mainTable">
        <tr>
          <td valign="top"  bgcolor="#FFFFFF"><ai:dbform formid="sysfuncform" 
			datamodel="com.ai.appframe2.web.datamodel.QueryModelForService"
			setname="com.ai.secframe.bo.sysmgr.SysFunction" 
			implservice_name="com.ai.secframe.service.sysmgr.SysFunction"
			implservice_querymethod="querySysFunction"
			initial="false">
              <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
                <tr>
                  <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
                      <tr>
                        <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                        <td style="height: 20px"> 关联岗位类型</td>
                        <td align="right" style="height: 20px"></td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td bgcolor="#FFFFFF" align="left" valign="top">
			<ai:table tableid="tblStationType"
                setname="com.ai.secframe.bo.sysmgr.SysRoleStationType"
                tablemodel="com.ai.secframe.web.sysmgr.SysMgrQueryModelForService"
                initial="false" multiselect="true" editable="true" height="410"
                needrefresh="true" width="600"  
                implservice_name="com.ai.secframe.service.sysmgr.SysRole"
                implservice_querymethod="querySysRoleStationType"
                implservice_countmethod="querySysRoleStationTypeCount" pagesize="18">
                      <ai:col fieldname="ROLE_STATIONTYPE_RELAT_ID" width="100" visible="false" />
                      <ai:col fieldname="ROLE_ID" width="100"  visible="false" editable="false" />
                      <ai:col fieldname="STATION_TYPE_ID" width="150"  editable="false"  visible="true" />
                      <ai:col fieldname="IS_AUTHOR" width="100" editable="true" visible="true" />
                      <ai:col fieldname="IS_REAL_OPERATION" width="100" editable="true" visible="true" />
                      <ai:col fieldname="NOTES" width="240" editable="true"  visible="true" />
                    </ai:table>
                  </td>
                </tr>
              </table>
            </ai:dbform>
			<br>
            <div id="buttonDiv" align="center">
              <div id="buttonDiv1" style="display:none">
                <input name="" type="button" class="btn-2word" value="新增" id="addStationTypeBtn" onclick="addStationTypeAction()"/>
                &nbsp;
                <input name="" type="button" class="btn-2word" value="保存" id="updateStationTypeBtn" onclick="saveStationTypeAction()"/>
                &nbsp;
                <input name="" type="button" class="btn-2word" value="删除" id="delStationTypeBtn" onclick="delStationTypeAction()"/>
              </div>
            </div>
			</td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html><script language=javascript>
  var roleRowSet = g_TableRowSetManager.get("tblRole");
  var stationTypeRowSet = g_TableRowSetManager.get("tblStationType");
  
  //点击岗位角色的行改变事件
  function queryStationType(oldRow,newRow){
    showRoleDetail();
    var roleId = roleRowSet.getValue(newRow,"ROLE_ID");    
    var cond = "ROLE_ID = "+ roleId+ " AND STATE=1 ";
    g_TableRowSetManager.get("tblStationType").refresh(cond);  
    document.getElementById("addRoleBtn").disabled=false;
  }
  
  //显示岗位角色的详细信息
  function showRoleDetail(){
    var curRow = roleRowSet.getRow();
    if(curRow<0){ 
      txtRoleId.value='';
      txtRoleName.value='';
      txtRoleCode.value='';
      txtRoleNotes.value='';      
      txtRoleName.className='dbform_disable_style';
      txtRoleCode.className='dbform_disable_style';
      txtRoleNotes.className='dbform_disable_style';
      
      txtRoleName.disabled=true;
      txtRoleCode.disabled=true;
      txtRoleNotes.disabled=true;

      document.getElementById("saveRoleBtn").disabled=true;
	  document.getElementById("delRoleBtn").disabled=true;
      buttonDiv1.style.display='none';
    }else{
      txtRoleId.value=roleRowSet.getValue(curRow,"ROLE_ID");
      txtRoleName.value=roleRowSet.getValue(curRow,"NAME");
      txtRoleCode.value=roleRowSet.getValue(curRow,"CODE");
      txtRoleNotes.value=roleRowSet.getValue(curRow,"NOTES");
	  document.getElementById("saveRoleBtn").disabled=false;
	  document.getElementById("delRoleBtn").disabled=false;
      buttonDiv1.style.display='block';      
      
      txtRoleName.className='dbform_inputfield_style';
      txtRoleCode.className='dbform_inputfield_style';
      txtRoleNotes.className='dbform_inputfield_style';
      
      txtRoleName.disabled=false;
      txtRoleCode.disabled=false;
      txtRoleNotes.disabled=false;
    }
  }
  
  //添加新的岗位角色
  function addRoleAction(){
    //roleRowSet.setRow(-1);
    //g_TableRowSetManager.get("tblRole").refresh("STATE=-1");  
	document.getElementById("saveRoleBtn").disabled=false;
	document.getElementById("delRoleBtn").disabled=true;
	document.getElementById("addRoleBtn").disabled=true;
  
    txtRoleName.className='dbform_inputfield_style';
    txtRoleCode.className='dbform_inputfield_style';
    txtRoleNotes.className='dbform_inputfield_style';
    
    txtRoleName.disabled=false;
    txtRoleCode.disabled=false;
    txtRoleNotes.disabled=false;
    
      txtRoleId.value='';
      txtRoleName.value='';
      txtRoleCode.value='';
      txtRoleNotes.value='';   
  }
  
  //保存岗位角色
  function saveRoleAction(){
    if(txtRoleName.value==''){
      alert('岗位角色名称不能为空!');
      txtRoleName.focus();
      return;
    }
    if(txtRoleName.value.length > 30){
      alert('岗位角色名称太长!');
      txtRoleName.focus();
      return;
    }
        
    if(txtRoleCode.value==''){
      alert('岗位角色代码不能为空!');
      txtRoleCode.focus();
      return;
    }
    if(txtRoleCode.value.length >20 ){
      alert('岗位角色代码太长!');
      txtRoleCode.focus();
      return;
    }    
    var str = "&id=" + txtRoleId.value +
              "&name=" + txtRoleName.value +
              "&code=" + txtRoleCode.value +
              "&notes=" + txtRoleNotes.value +
              "&oper=save";
    str = encodeURI(str);
    str = encodeURI(str);           
    var  result = PostInfotoServer( "<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysRoleAction?action=saveSysRole"+str,'');
    if(result=='OK'){
      //获取当前行索引
      var curRow = -1;
      
      //判段是否是新增
      if(txtRoleId.value==''){
        curRow = roleRowSet.count();
      }else{
        curRow = roleRowSet.getRow();
      }
      
      roleRowSet.refresh("state=1");
      if(roleRowSet.count()>0){
        roleRowSet.setRow(curRow);
      }
      showRoleDetail();
      alert('保存成功!');
    }else{
      alert(result);
    }
  }
  
  //删除岗位类型
  function delRoleAction(){
    if(txtRoleId.value==''){
      alert('请选择要删除的岗位角色!');
      return;
    }
    
    var str = "&id=" + txtRoleId.value +
              "&oper=delete";
              
    var  result = PostInfotoServer( "<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysRoleAction?action=saveSysRole"+str,'');
    if(result=='OK'){
      roleRowSet.refresh("state=1");
      if(roleRowSet.count()>0){
        roleRowSet.setRow(0);
      }
      showRoleDetail();
      alert('删除成功!');
    }else{
      alert(result);
    }
  }
  
  //新增岗位类型关系
  function addStationTypeAction(){
    var curRow = roleRowSet.getRow();
    if(curRow<0){
        alert("请选择岗位角色类型");
        return;
    }

    var paraArray = new Array();
    for(var i=0;i<stationTypeRowSet.count();i++){
      paraArray[i] = stationTypeRowSet.getValue(i,"STATION_TYPE_ID");
    }
    
    //选择岗位类型
    var returnArray = window.showModalDialog("stationtypeAdd.jsp",paraArray,"scroll:no;resizable:no;status:no;dialogHeight:430px;dialogWidth:600px");

    if(returnArray==null){
      return;
    }
    
    var roleid = roleRowSet.getValue(curRow,"ROLE_ID");
    for(var i=0;i<returnArray.length;i++){
      stationTypeRowSet.newRow();
      stationTypeRowSet.setValue(stationTypeRowSet.getRow(),"STATION_TYPE_ID",returnArray[i].id,returnArray[i].value)
      stationTypeRowSet.setValue(stationTypeRowSet.getRow(),"ROLE_ID",roleid)
      stationTypeRowSet.setValue(stationTypeRowSet.getRow(),"IS_AUTHOR","N","否");
      stationTypeRowSet.setValue(stationTypeRowSet.getRow(),"IS_REAL_OPERATION","Y","是");
      stationTypeRowSet.setValue(stationTypeRowSet.getRow(),"NOTES","");
    }
    
    alert('请点保存按钮后新增的岗位类型数据生效！');
  }
  
  
  //保存岗位角色和岗位类型之间的关系
  function saveStationTypeAction(){
    var curRow = roleRowSet.getRow();
    if(curRow<0){
        alert("请选择岗位角色类型");
        return;
    }
    
    if(stationTypeRowSet.toXmlString(true)=="") {
      alert("岗位角色对应的岗位类型未做任何修改!");
      return ;
    }
    
    var roleid = roleRowSet.getValue(curRow,"ROLE_ID");
    var msg = PostInfo("<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysRoleAction?"+
        "action=checkSysRoleIsUsed&roleid="+roleid);
    var result = msg.getValueByName('MESSAGE');
    if(result==1){
      if(confirm('警告:您修改的岗位角色已经被授权使用,修改将影响到已授权限,您确认修改吗?')==false){
        return;
      }
    }
   
    
    var list = new Array();
    list.push(stationTypeRowSet);
    
    var retMsg = saveRowSet("<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysRoleAction?action=saveSysRoleStationType",list);
    var msg = retMsg.getValueByName("retVal");

    if(msg=="OK"){
      alert("岗位类型数据保存成功");
      stationTypeRowSet.refresh(" ROLE_ID = '"+roleid+"' and state=1");
    }else{
      alert(msg);
    }
  }
  
  //删除关联的岗位类型
  function delStationTypeAction(){
    var selRows = stationTypeRowSet.getSelectedRows();
    if( selRows.length <= 0 ) {
      alert("请选择要删除的岗位类型!");
      return;
    }
    
    var curRow = roleRowSet.getRow();
    var roleid = roleRowSet.getValue(curRow,"ROLE_ID");
  
    if(!window.confirm("确定要删除选中的岗位类型吗?") )return;
    
    var msg = PostInfo("<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysRoleAction?"+"action=checkSysRoleIsUsed&roleid="+roleid);
      
    var result = msg.getValueByName('MESSAGE');
    if(result=='1'){
      if(confirm('警告:您修改的岗位角色已经被授权使用,修改将影响到已授权限,您确认修改吗?')==false) return;
    }
    
    //删除记录
    for( i=selRows.length-1;i>=0;i--){
      stationTypeRowSet.deleteRow(selRows[i]);
    }
    
    alert('请点保存按钮后删除的岗位类型数据生效！');
  }
</script>
