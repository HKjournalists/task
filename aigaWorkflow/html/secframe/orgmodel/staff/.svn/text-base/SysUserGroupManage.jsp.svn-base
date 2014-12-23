<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<%@ page import="com.ai.appframe2.web.HttpUtil" %>
<html>
<head>
<title>分组管理</title>
</head>
<body>
<table width="100%" bgcolor="#FFFFFF" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="250" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"><table width="380" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px">分组信息</td>
                <td align="right" style="height: 20px"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="left"><ai:dbform formid="sysUserGroup"
					setname="com.ai.secframe.bo.orgmodel.SysUserGroup"
					datamodel="com.ai.appframe2.web.datamodel.QueryModelForService"
					implservice_name="com.ai.secframe.service.orgmodel.interfaces.SysUserGroup"
					implservice_querymethod="querySysUserGroup" 
					initial="false" editable="true">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" height="">
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td width="100" class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">用户组名称</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack" colspan="5"><ai:dbformfield formid="sysUserGroup" fieldname="GROUP_NAME"
								width="150" height="20" editable="true" visible="true" />
                  <span class="pr9">*</span>
                  <input name="" type="button" class="btn-2word" value="查询" id="serBtn" onClick="search()"/></td>
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
                <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">分类</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack" colspan="5"><ai:dbformfield formid="sysUserGroup" fieldname="GROUP_KIND"
								width="150" height="20" editable="true" visible="true" /></td>
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
                <td bgcolor="#F1F3FB" class="font13pxboldblack" colspan="5"><ai:dbformfield formid="sysUserGroup" fieldname="REMARK"
								width="150" height="20" editable="true" visible="true" /></td>
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
            </ai:dbform><div id="buttonDiv"  align="center" style="height:30px; padding-top:4px;">
              <input name="" type="button" class="btn-2word" value="新增" id="addBtn" onClick="add()"/>
              &nbsp;
              <input name="" type="button" class="btn-2word" value="编辑" id="editBtn" onClick="update()"/>
              &nbsp;
              <input name="" type="button" class="btn-2word" value="保存" id="saveBtn" onClick="save()"/>
              &nbsp;
              <input name="" type="button" class="btn-2word" value="删除" id="delBtn" onClick="del()"/>
            </div></td>
        </tr>
      </table>
      <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"><table width="380" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px">分组列表</td>
                <td align="right" style="height: 20px"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="left"><ai:table tableid="sysUserGroupTable"
							setname="com.ai.secframe.bo.orgmodel.SysUserGroup"
							initial="false" multiselect="true" editable="false"
							tablemodel="com.ai.appframe2.web.datamodel.QueryModelForService"
							implservice_name="com.ai.secframe.service.orgmodel.interfaces.SysUserGroup"
							implservice_querymethod="querySysUserGroup"  pagesize="100"
							implservice_countmethod="querySysUserGroupCount" width="350" ondbclick="selectStaffByGroup"
							height="380" needrefresh="true">
              <ai:col fieldname="GROUP_ID" width="60" editable="false"
								visible="true" />
              <ai:col fieldname="GROUP_NAME" width="150" editable="false"
								visible="true"/>
              <ai:col fieldname="GROUP_KIND" width="150" editable="false"
								visible="true"/>
              <ai:col fieldname="REMARK" width="150" editable="false"
								visible="true" />
            </ai:table></td>
        </tr>
      </table></td>
    <td valign="top" width="80%"  style="padding-left:10px"><table width="100%" border=0 cellpadding=0 cellspacing=0 id="mainTable">
        <tr>
          <td valign="top"  bgcolor="#FFFFFF"><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
              <tr>
                <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
                    <tr>
                      <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                      <td style="height: 20px">分组关联员工查询</td>
                      <td align="right" style="height: 20px"><div id="buttonDiv" style="display:block"></div></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td bgcolor="#FFFFFF" align="left" valign="top"><ai:dbform formid="sysUserGroupRelate"
					setname="com.ai.secframe.bo.orgmodel.QSysUserGroupRelate"
					datamodel="com.ai.appframe2.web.datamodel.QueryModelForService"
					implservice_name="com.ai.secframe.service.orgmodel.interfaces.SysUserGroupRelate"
					implservice_querymethod="querySysUserGroupRelate" 
					initial="false" editable="true">
                  <table width="100%" border="0" cellpadding="0" cellspacing="0" height="">
                    <tr>
                      <td height="1" class="font13pxboldblue1"></td>
                      <td width="1"></td>
                      <td class="font13pxboldblack"></td>
                      <td width="1"></td>
                      <td width="100" class="font13pxboldblack"></td>
                      <td width="1"></td>
                      <td class="font13pxboldblack"></td>
                    </tr>
                    <tr>
                      <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">员工名称</td>
                      <td width="1"></td>
                      <td bgcolor="#F1F3FB" class="font13pxboldblack" colspan="5"><ai:dbformfield formid="sysUserGroupRelate" fieldname="NAME"
								width="150" height="20" editable="true" visible="true" />
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
                      <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">员工工号</td>
                      <td width="1"></td>
                      <td bgcolor="#F1F3FB" class="font13pxboldblack" colspan="5"><ai:dbformfield formid="sysUserGroupRelate" fieldname="CODE"
								width="150" height="20" editable="true" visible="true" />
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
                      <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">分组名称</td>
                      <td width="1"></td>
                      <td bgcolor="#F1F3FB" class="font13pxboldblack" colspan="5"><ai:dbformfield formid="sysUserGroupRelate" fieldname="GROUP_NAME"
								width="150" height="20" editable="true" visible="true" />
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
                      <td height="1" class="font13pxboldblue1"></td>
                      <td width="1"></td>
                      <td class="font13pxboldblack"></td>
                      <td width="1"></td>
                      <td class="font13pxboldblack"></td>
                      <td width="1"></td>
                      <td class="font13pxboldblack"></td>
                    </tr>
                  </table>
                  </ai:dbform><div id="div1" align="center" style="height:30px; padding-top:4px;">
                    <input name="Input" type="button" class="btn-2word" value="查询" id="search" onClick="searchStaff()"/>
                  </div></td>
              </tr>
            </table>
            <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
              <tr>
                <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
                    <tr>
                      <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                      <td style="height: 20px"> 分组关联员工列表</td>
                      <td align="right" style="height: 20px"><input name="" type="button" class="btn-6word" value="添加员工关联" id="addRelate" onClick="addRelate()"/>
                        <input name="" type="button" class="btn-6word" value="删除员工关联" id="delRelate" onClick="delRelate()"/>
                      </td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td bgcolor="#FFFFFF" align="left" valign="top"><ai:table tableid="sysUserGroupRelateTable"
							setname="com.ai.secframe.bo.orgmodel.QSysUserGroupRelate"
							initial="false" multiselect="true" editable="false"
							tablemodel="com.ai.appframe2.web.datamodel.QueryModelForService"
							implservice_name="com.ai.secframe.service.orgmodel.interfaces.SysUserGroupRelate"
							implservice_querymethod="querySysUserGroupRelate"
							implservice_countmethod="querySysUserGroupRelateCount" width="520"    pagesize="100"
							height="380" needrefresh="true">
                    <ai:col fieldname="RELATE_ID" width="80" editable="false"
								visible="false" />
                    <ai:col fieldname="GROUP_ID" width="80" editable="false"
								visible="false" />
                    <ai:col fieldname="STAFF_ID" width="100" editable="false"
								visible="false"/>
                    <ai:col fieldname="NAME" width="140" editable="false"
								visible="true"/>
                    <ai:col fieldname="CODE" width="100" editable="false"
								visible="true"/>
                    <ai:col fieldname="GROUP_NAME" width="140" editable="false"
								visible="true"/>
                    <ai:col fieldname="STATE" width="150" editable="false"
								visible="true" />
                  </ai:table></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
</table>
<script type="text/javascript">
	var sysUserGroup = g_FormRowSetManager.get("sysUserGroup");
	var sysUserGroupTable = g_TableRowSetManager.get("sysUserGroupTable");	
	var sysUserGroupRelate = g_FormRowSetManager.get("sysUserGroupRelate");
	var sysUserGroupRelateTable = g_TableRowSetManager.get("sysUserGroupRelateTable");	
	var c ="";
	var cur_group_id=0;
	var r ="";

	function save(){
	
	
		if(sysUserGroup.getValue("GROUP_NAME")==''){
			alert("分组名称不能为空");
			sysUserGroup.setFocus("GROUP_NAME");
		} 
		
		if(sysUserGroup.getValue("GROUP_KIND")==''){
			alert("请选择分类");
			sysUserGroup.setFocus("GROUP_KIND");
		} 
		
		if(sysUserGroup.getValue("REMARK")==''){
			alert("分组备注不能为空");
			sysUserGroup.setFocus("REMARK");
		} 
		
	    if(sysUserGroup.toXmlString(true)==""){
				alert('当前的数据尚未被修改，不需要保存！');
				return;
		}
				
	    var list = new Array();
	    list.push(sysUserGroup);   
	    var msg = saveRowSet("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysUserGroupAction?action=saveUserGroup"
	    ,list,false ,false);
	    
		sysUserGroupTable.refresh("");	
		r = "";
		//sysUserGroup.setEditSts(false);	
		
	}	
	
	function add(){
		//sysUserGroup.setEditSts(true);
		sysUserGroup.refresh("group_id=-2");

	}
	
	function search(){
		sysUserGroupTable.refresh("GROUP_NAME LIKE '%"+sysUserGroup.getValue("GROUP_NAME")+"%'");
		r = "GROUP_NAME LIKE '%"+sysUserGroup.getValue("GROUP_NAME")+"%'";
	}
	function update(){
		if( sysUserGroupTable.getSelectedRows()!=null&&sysUserGroupTable.getSelectedRows().length>0){			
			sysUserGroup.refresh("GROUP_ID="+sysUserGroupTable.getValue(sysUserGroupTable.getSelectedRows()[0],"GROUP_ID"));
			//sysUserGroup.setEditSts(true);
		 }
		 else
		 {
		  alert("请选择！");
		 }
	}
	function del(){	
	 if( sysUserGroupTable.getSelectedRows()!=null&&sysUserGroupTable.getSelectedRows().length>0){
	 		
	  		for(var i=0;i < sysUserGroupTable.count();i++){
			if(sysUserGroupTable.isSelected(i)){
				sysUserGroupTable.deleteRow(i);
					i--;
				}
         	}
	  	var list = new Array();
	    list.push(sysUserGroupTable);   
	    var msg = saveRowSet("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysUserGroupAction?action=saveUserGroup"
	    ,list,false ,false);
	    
		sysUserGroupTable.refresh(r);	  
	 }
	 else
	 {
	  alert("请选择！");
	 }
	}
	function init()
	{  	
			//sysUserGroup.setEditSts(false);				
	  		sysUserGroupTable.refresh(""); 			
	} 
	init();
	
	function selectStaffByGroup(){	
		var groupId = sysUserGroupTable.getValue(sysUserGroupTable.getRow(),"GROUP_ID");
		sysUserGroupRelateTable.refresh("GROUP_ID="+groupId);	
		c = "GROUP_ID="+groupId;
		cur_group_id = groupId;
	}
	function searchStaff(){
		var name = sysUserGroupRelate.getValue("NAME");
		var code = sysUserGroupRelate.getValue("CODE");
		var groupName = sysUserGroupRelate.getValue("GROUP_NAME");
		
		var nameCond = "";
		var codeCond = "";
		var groupNameCond="";
		
		var flag = false;
		
		if(name!=null&&name!=""){
			nameCond = " NAME LIKE '"+name+"%' ";
		}
		
		if(code!=null&&code!=""){
			codeCond = " CODE LIKE '"+code+"%' ";
		}
		
		if(groupName!=null&&groupName!=""){
			groupNameCond = " GROUP_NAME LIKE '"+groupName+"%' ";
		}
		
		var cond = "";
		if(nameCond!=""){
			cond = cond + nameCond;
			flag=true;
		}
		
		if(codeCond!=""){
			if(flag){
				cond = cond +" AND "+ codeCond;
			}else {
				cond = cond +  codeCond;
				flag = true;
			}
		}
		if(groupNameCond!=""){
			if(flag){
				cond = cond +" AND "+ groupNameCond;
			}else {
				cond = cond +  groupNameCond;
			}
		}
		
		if(cond==""){
			alert("请输入条件");
			return ;
		}
		sysUserGroupRelateTable.refresh(cond);
		cur_group_id = 0;
	}
	
	function addRelate(){	
		if(cur_group_id==0){
			alert("请在左边用户分组双击选择用户分组后再添加用户关系");
			return;
			}
		var result = window.showModalDialog("QSysStaffSelect.jsp?group_id="+cur_group_id,"org","scroll:no;resizable:no;status:no;dialogHeight:700px;dialogWidth:900px");
		sysUserGroupRelateTable.refresh(c);
	}
	
	function delRelate(){
	if( sysUserGroupRelateTable.getSelectedRows()!=null&&sysUserGroupRelateTable.getSelectedRows().length>0){
	 		
	  		for(var i=0;i < sysUserGroupRelateTable.count();i++){
			if(sysUserGroupRelateTable.isSelected(i)){
				sysUserGroupRelateTable.deleteRow(i);
					i--;
				}
         	}
	  	var list = new Array();
	    list.push(sysUserGroupRelateTable);   
	    var msg = saveRowSet("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysUserGroupAction?action=deleteUserGroupRelate"
	    ,list,false ,false);
	    
		sysUserGroupRelateTable.refresh(c);	  
	 }
	 else
	 {
	  alert("请选择！");
	 }
	}


</script>
</body>
</html>