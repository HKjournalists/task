<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<%@ page import="com.ai.appframe2.web.HttpUtil" %>
<ai:scriptinclude src="/secframe/common/common.js" />
<html>
<head>
<title>授权copy</title>
</head>
<%	
	String cond = " STATE = 1 " ;
	request.setAttribute("condition" ,cond);
%>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top"><table width="100%" height="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px">员工选择</td>
                <td align="right" style="height: 20px"><input name="button" type="button" class="btn-3word"  onClick="selectType(1)" value="按组织"/>
                  <input name="button2" type="button" class="btn-3word"  onClick="selectType(2)" value="按分组"/></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="left" style="padding-left:5px;" height="250" valign="top"><div id="group" style="display: none;">
               <ai:dbform formid="sysUserGroup"
					setname="com.ai.secframe.bo.orgmodel.SysUserGroup"
					datamodel="com.ai.appframe2.web.datamodel.QueryModelForService"
					implservice_name="com.ai.secframe.service.orgmodel.interfaces.SysUserGroup"
					implservice_querymethod="querySysUserGroup" 
					initial="false" editable="true">
              <table width="200" border='0' align="center" valign="top"
				cellpadding="0" cellspacing="0">
               
                <tr>
                  <td colspan="4" align="center" height="10"></td>
                </tr>
                <tr>
                  <td width="100"> 用户组名称</td>
                  <td colspan="3"><ai:dbformfield formid="sysUserGroup" fieldname="GROUP_NAME"
								width="100" height="20" editable="true" visible="true" />
                    <input name="Input2" type="button" class="btn-2word" value="查询"  onClick="search()"/>
                  </td>
                </tr>
                <tr>
                  <td colspan="4" align="center" height="20"></td>
                </tr>
                <tr>
                  <td align="center" colspan="4" height="40"><ai:table tableid="sysUserGroupTable"
							setname="com.ai.secframe.bo.orgmodel.SysUserGroup"
							initial="false" multiselect="true" editable="false"
							tablemodel="com.ai.appframe2.web.datamodel.QueryModelForService"
							implservice_name="com.ai.secframe.service.orgmodel.interfaces.SysUserGroup"
							implservice_querymethod="querySysUserGroup"  pagesize="100"
							implservice_countmethod="querySysUserGroupCount" width="200" ondbclick="selectStaffByGroup"
							height="120" needrefresh="true">
                      <ai:col fieldname="GROUP_ID" width="60" editable="false"
								visible="true" />
                      <ai:col fieldname="GROUP_NAME" width="120" editable="false"
								visible="true"/>
                      <ai:col fieldname="REMARK" width="150" editable="false"
								visible="true" />
                    </ai:table>
                  </td>
                </tr>
                <tr>
                  <td align="center" colspan="4" height="40"><br>
                    <ai:table tableid="sysUserGroupRelateTable"
							setname="com.ai.secframe.bo.orgmodel.QSysUserGroupRelate"
							initial="false" multiselect="true" editable="false"
							tablemodel="com.ai.appframe2.web.datamodel.QueryModelForService"
							implservice_name="com.ai.secframe.service.orgmodel.interfaces.SysUserGroupRelate"
							implservice_querymethod="querySysUserGroupRelate"
							implservice_countmethod="querySysUserGroupRelateCount" width="200"    pagesize="100"
							height="220" needrefresh="true">
                      <ai:col fieldname="RELATE_ID" width="80" editable="false"
								visible="false" />
                      <ai:col fieldname="GROUP_ID" width="80" editable="false"
								visible="false" />
                      <ai:col fieldname="STAFF_ID" width="100" editable="false"
								visible="false"/>
                      <ai:col fieldname="CODE" width="70" editable="false"
								visible="true"/>
                      <ai:col fieldname="NAME" width="140" editable="false"
								visible="true"/>
                      <ai:col fieldname="GROUP_NAME" width="140" editable="false"
								visible="true"/>
                      <ai:col fieldname="STATE" width="150" editable="false"
								visible="true" />
                    </ai:table>
                  </td>
                </tr>
              </table>
            </ai:dbform></div>
            <div id="org">
              <ai:dbtree_new
			id="partytree"
			datamodel="com.ai.secframe.web.sysmgr.OrgStaffTreeModel"
			multiselect="true" height="550" width="100%" ishaveline="true"
			onselect="treeNodeClick" oncheckboxclick="chkSelected" />
            </div></td>
        </tr>
      </table></td>
    <td valign="top" style="padding-left:10px;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
              <tr>
                <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
                    <tr>
                      <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                      <td style="height: 20px">授权岗位列表</td>
                      <td align="right" style="height: 20px"><input name="Input2" type="button" class="btn-2word" value="删除"  onClick="delete_Station()"/>
                        &nbsp;</td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td bgcolor="#FFFFFF" align="left" height="200" valign="top"><ai:table setname="com.ai.secframe.bo.sysmgr.SysAuthor" 
          tableid="station_autor_table"
 tablemodel = "com.ai.appframe2.web.datamodel.QueryModelForService"
 initial = "false" multiselect = "true" needrefresh="true"
 editable = "false" width="700" height="200" implservice_name="com.ai.secframe.service.sysmgr.SysAuthor"
 implservice_querymethod="querySysAuthor" implservice_countmethod="">
                    <ai:col fieldname="STATION_ID"  width="180"  editable = "false"  visible="true"/>
                    <ai:col fieldname="IS_AUTHOR"  width="100"  editable = "true"  visible="true"/>
                    <ai:col fieldname="IS_REAL_OPERATION"  width="100"  editable = "true"  visible="false"/>
                    <ai:col fieldname="AUTHOR_VALID_DATE"  width="150"  editable = "true"  visible="true"/>
                    <ai:col fieldname="AUTHOR_EXPIRE_DATE"  width="150"  editable = "true"  visible="true"/>
                    <ai:col fieldname="NOTES"  width="100"  editable = "true"  visible="true"/>
                  </ai:table>
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
                      <td style="height: 20px">授权角色列表</td>
                      <td align="right" style="height: 20px"><input name="Input2" type="button" class="btn-2word" value="删除"  onClick="delete_Role()"/>
                        &nbsp;</td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td bgcolor="#FFFFFF" align="left" height="200" valign="top"><ai:table setname="com.ai.secframe.bo.sysmgr.SysStaffRoleAuthor"
				 tableid="tblRole" tablemodel = "com.ai.appframe2.web.datamodel.QueryModelForService" 
				 initial = "false" multiselect = "true" needrefresh="true"
				 editable = "false" width="700" height="200" implservice_name="com.ai.secframe.service.sysmgr.SysStaffRoleAuthor"
				 implservice_querymethod="querySysStaffRoleAuthor" implservice_countmethod="">
                    <ai:col fieldname="ROLE_AUTHOR_ID"  width="100"  editable = "false"  visible="false"/>
                    <ai:col fieldname="ROLE_ID"  width="100"  editable = "false"  visible="true"/>
                    <ai:col fieldname="AUTHOR_VALID_DATE"  width="150"  editable = "true"  visible="true"/>
                    <ai:col fieldname="AUTHOR_EXPIRE_DATE"  width="150"  editable = "true"  visible="true"/>
                    <ai:col fieldname="NOTES"  width="100"  editable = "true"  visible="true"/>
                    <ai:col fieldname="ORGANIZE_ID"  width="100"  editable = "true"  visible="true"/>
                  </ai:table>
                </td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td><div align="center" style="height:35px; padding-top:6px;">
              <input name="Input2" type="button" class="btn-4word" value="选择员工"  onClick="selectStaff()"/>
              &nbsp;
              <input name="Input2" type="button" class="btn-2word" value="确认"  onClick="authorise()"/>
              &nbsp; </div></td>
        </tr>
      </table></td>
  </tr>
</table>
<script type="text/javascript">
	var tree_value	=	null;		//当前节点的值
	var tree_text 	= 	null;		//当前节点的文本
	var tree_userObj= 	null;		//当前节点的用户值
	var result		=	new Object();
	var dbtree = g_DBTreeNewManager.get("partytree");
	var roles = g_TableRowSetManager.get("tblRole");
	var stations = g_TableRowSetManager.get("station_autor_table");
	var sysUserGroup = g_FormRowSetManager.get("sysUserGroup");
	var sysUserGroupTable = g_TableRowSetManager.get("sysUserGroupTable");	
	var sysUserGroupRelateTable = g_TableRowSetManager.get("sysUserGroupRelateTable");	
	var group_id=0;
	var isGroup = false;
	
	var selAuthorId = "";
	
	//删除授权与他的岗位类型集
	function delete_Role(){
	   var selCount = roles.getSelectedRows();
	   var len = selCount.length;
	   if( len <= 0 )
	   {
	     alert("请在先选择要删除的岗位角色！");
	     return;
	   }
	   if (confirm("您确认删除选定的岗位角色吗？")){
		   for( var i=len-1;i>=0;i-- ){
		       roles.deleteRow(selCount[i]);
		   }
	   }else{
	   		return;
	   }
	}
	//删除授权与他的功能点
	function delete_Station(){
	   var selCount = stations.getSelectedRows();
	   var len = selCount.length;
	   if( len <= 0 )
	   {
	     alert("请在先选择要删除的权限点！");
	     return;
	   }
	   if(confirm("是否确定要删除该权限点授权?")){
	   	for( var i=len-1;i>=0;i-- ){
	       stations.deleteRow(selCount[i]);
	   	}
	   	
	   }else{
	   		return;
	   }
	   }
	
	//点击参与人显示该参与所包含的操作员
	function treeNodeClick(treeVal,treeText,treeUserObj,treeNodeType){
		if(treeVal==-1) return;
		tree_value = treeVal;
		tree_text = treeText;
		tree_userObj = treeUserObj;
		result.partyroleid	 = tree_value;
		result.partyrolename = tree_text;
		//result.partyid		 = party_id;
	}
	
	function chkSelected(value,text,userobj,isChecked,nType) {
		
		var childrenNodes = dbtree.getChildrenNodesInfo(value);
		if(isChecked){
			for(var i=0;i<childrenNodes.length;i++){
				var objstr = childrenNodes[i].userobj;
				var objarray = objstr.split('|');
				if(objarray[1]=='STAFF'){
					dbtree.setNodeChecked(childrenNodes[i].value,true);
				}
				
			}
		}else{
			
			for(var i=0;i<childrenNodes.length;i++){
			var objstr = childrenNodes[i].userobj;
				var objarray = objstr.split('|');
				if(objarray[1]=='STAFF'){
					dbtree.setNodeChecked(childrenNodes[i].value,false);
				}
			}
		}
	}
	
	
		function authoriseByGroup(){
		
		if(!isGroup){
			alert("请切换到分组授权");
			return;
		}
		if(group_id==0){
			alert("请先双击选择一个分组");
			return;
		}
		
		selAuthorId = "";
		
		
		//if(authorpartyid==-1){
		//	alert('请选定权限来源!');
		//	return;
		//}
		
		//var authorValidDate = formRowSet.getValue("AUTHOR_VALID_DATE");
		
		//if(authorValidDate==null||authorValidDate==''){
		//	alert('请选定生效日期!');
		//	return;
		//}
		//var authorExpireDate = formRowSet.getValue("AUTHOR_EXPIRE_DATE");
		//if(authorExpireDate==null||authorExpireDate==''){
		//	alert('请选定失效日期!');
		//	return;
		//}
		//if(authorExpireDate<=authorValidDate){
		//	alert('失效日期必须大于生效日期!');
		//	return;
		//}
		
		
		list = new Array();
		
		
		var selRows = gAuthor.getSelectedRows();
		if(selRows.length<1){
			alert('请选定授权角色');
			return;
		}
		for(var n=0;n<selRows.length;n++){
			gAuthorAdd.newRow();
			gAuthorAdd.setValue(gAuthorAdd.getRow(),"ROLE_ID",gAuthor.getValue(selRows[n],"ROLE_ID"));
		}
		var submitURL = "<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysAuthoriseAction?action=saveBatchAuthorRoleByGroup";
		submitURL = submitURL+"&authorValidDate="+authorValidDate;
		submitURL = submitURL+"&authorExpireDate="+authorExpireDate;
		submitURL = submitURL+"&authorpartyid="+authorpartyid;
		submitURL = submitURL+"&group_id="+group_id;
		list.push(gAuthorAdd);
		var retMsg = saveRowSet(submitURL,list);
		var msg = retMsg.getValueByName("retVal");
		errorMsg = retMsg.getValueByName("msg");
	  	if( msg=="0" ){
		    alert("保存成功");
		}else if(msg=="-1"){
	  		alert(errorMsg);
	  	}else if(msg=="-2"){
	  		alert(errorMsg);
	  	}else if(msg=="-3"){
	  		alert(errorMsg);
	  	}else if(msg=="-4"){
	  		alert(errorMsg);
	  	}else{
	  		alert("保存失败");
	  	}
	  	window.location.href='BatchRoleAuthorise.jsp';
	}
	
	
	function authorise(){
		//cleargrid();
		selAuthorId = "";
		var nodeArray = dbtree.getCheckedNodesInfo();
		if(isGroup ){
		if( sysUserGroupRelateTable.getSelectedRows()!=null&&sysUserGroupRelateTable.getSelectedRows().length>0){
			var selRows = sysUserGroupRelateTable.getSelectedRows();
			for(var i=0;i<selRows.length;i++){
						if( selAuthorId != ""){
							selAuthorId  += "@";	
						}			
			selAuthorId +=  sysUserGroupRelateTable.getValue(selRows[i],"STAFF_ID");	
		}
		
			}else {
				alert("请在分组中选择授权员工");
				return;
			}
			
		} else {
		if(nodeArray.length<1){
			alert('请选定授权员工!');
			return;
		}
			if(nodeArray.length>50){
				alert('选定授权员工请不要超过50名!');
				return;
			}
		}
		
		for(var n=0;n<nodeArray.length;n++){
			var objstr = nodeArray[n].userobj;
				var objarray = objstr.split('|');
				if(objarray[1]=='STAFF'){
					//alert(nodeArray[n].text);
					if( selAuthorId != ""){
						selAuthorId  += "@";	
					}		
					selAuthorId +=  objarray[0];		
					alert(selAuthorId);					
				}
		}
		var list = new Array();
		
		
		//var selRows = gAuthor.getSelectedRows();
		//if(selRows.length<1){
		//	alert('请选定授权角色');
		//	return;
		//}
		//for(var n=0;n<selRows.length;n++){
		//	gAuthorAdd.newRow();
		//	gAuthorAdd.setValue(gAuthorAdd.getRow(),"ROLE_ID",gAuthor.getValue(selRows[n],"ROLE_ID"));
		//}
		var submitURL = "<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysAuthoriseAction?action=saveBatchAuthorCopy";
		
		submitURL = submitURL+"&selAuthorId="+selAuthorId;
		
		for( var i =0 ;i< roles.getTotalRowCount() ; i++){	   		   
	   		  roles.setValue(i,"NOTES",roles.getValue(i,"NOTES"))
	   	}
		for( var i =0 ;i< stations.getTotalRowCount() ; i++){	   		   
	   		  stations.setValue(i,"NOTES",stations.getValue(i,"NOTES"))
	   	}
		
		list.push(roles);
		list.push(stations);	
		
		var retMsg = saveRowSet(submitURL,list);
		var msg = retMsg.getValueByName("retVal");
		errorMsg = retMsg.getValueByName("msg");
	  	if( msg=="0" ){
		    alert("保存成功");
		}else if(msg=="-1"){
	  		alert(errorMsg);
	  	}else if(msg=="-2"){
	  		alert(errorMsg);
	  	}else if(msg=="-3"){
	  		alert(errorMsg);
	  	}else if(msg=="-4"){
	  		alert(errorMsg);
	  	}else{
	  		alert("保存失败");
	  	}
	  	//window.location.href='BatchRoleAuthorise.jsp';
	}
	
	function selectStaff(){
		var result = window.showModalDialog("../../orgmodel/staff/EmployeeList.jsp?type=selectStaff","org","scroll:no;resizable:no;status:no;dialogHeight:590px;dialogWidth:400px");
		if(result=='undefined'||result==null){
			result="";
		} else {
			var cond = " state=1 and AUTHOR_TYPE in ('A','C') and STAFF_ID = "+result ;
			stations.refresh(cond);
			roles.refresh(" state=1 and STAFF_ID = "+result );
			
		}
	}

	function selectType(v){
		if(v==1){
			document.getElementById("org").style.display="block";
			document.getElementById("group").style.display="none";
			isGroup = false;
		} else {
			document.getElementById("org").style.display="none";
			document.getElementById("group").style.display="block";
			isGroup = true;
		}
	}
	
	



	function search(){
		sysUserGroupTable.refresh("GROUP_NAME LIKE '%"+sysUserGroup.getValue("GROUP_NAME")+"%'");
	}
	
	
	function init()
	{ 	
						
	  		sysUserGroupTable.refresh(""); 			
	} 
	init();
	
	function selectStaffByGroup(){	
		var groupId = sysUserGroupTable.getValue(sysUserGroupTable.getRow(),"GROUP_ID");
		sysUserGroupRelateTable.refresh("GROUP_ID="+groupId);	
		group_id = groupId;
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
	}
	
	
	
	
</script>
</body>
</html>