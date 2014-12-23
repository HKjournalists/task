<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<%@ page import="com.ai.appframe2.web.HttpUtil" %>
<html>
<head>
<title></title>
</head>
<%
			String party_role_id=String.valueOf(SessionManager.getUser().getOrgId());
			request.setAttribute("org_id",party_role_id);

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
                <td align="right" style="height: 20px"><input type="button" class="btn-3word" value="按组织"  onClick="selectType(1)"/>
                  <input type="button" class="btn-3word" value="按分组"  onClick="selectType(2)"/></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="left" height="250" valign="top"><div id="group" style="display: none;">
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
                  <td colspan="3" nowrap="nowrap"><ai:dbformfield formid="sysUserGroup" fieldname="GROUP_NAME"	width="100" height="20" editable="true" visible="true" /><input name="Input2" type="button" class="btn-2word" value="查询"  onClick="search()"/>
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
    <td valign="top" style="padding-left:10px;"><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px">授权权限点</td>
                <td align="right" style="height: 20px">&nbsp;</td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="left" height="250" valign="top"><ai:table
			setname="com.ai.secframe.bo.sysmgr.QSysAuthorInfo"
			tableid="author"
			tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
			implservice_name="com.ai.secframe.service.sysmgr.SysAuthor"
			implservice_querymethod="getSysAuthorInfo(long orgId,long orgRoleTypeId,long staffId)"
			footdisplay="none" editable="true" rowsequence="true" onrowselected="selectAction"
			height="480" width="700" multiselect="true" needrefresh="true"
			initial="false">
              <ai:col fieldname="STATION_NAME" edittype="DBTree" width="200"
				editable="false" />
              <ai:col fieldname="STATION_ID" visible="false" />
              <ai:col fieldname="STATION_CODE" editable="false" width="130" />
              <ai:col fieldname="AUTHOR_ID" width="80" visible="false" />
              <ai:col fieldname="IS_AUTHOR" width="80" />
              <ai:col fieldname="IS_REAL_OPERATION" width="80" />
              <ai:col fieldname="AUTHOR_VALID_DATE" width="130" />
              <ai:col fieldname="AUTHOR_EXPIRE_DATE" width="130" />
              <ai:col fieldname="NOTES" editable="true" width="120" />
              <ai:col fieldname="FL" editable="true" width="120" visible="false" />
            </ai:table>
            <div style="display:none">
              <ai:table
			setname="com.ai.secframe.bo.sysmgr.QSysAuthorInfo"
			tableid="author_add"
			tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
			implservice_name="com.ai.secframe.service.sysmgr.SysAuthor"
			implservice_querymethod="getSysAuthorInfo(long orgId,long orgRoleTypeId,long staffId)"
			footdisplay="none" editable="true" rowsequence="true"
			conditionname="condition" height="450" width="700" multiselect="true"
			needrefresh="true"
			initial="false">
                <ai:col fieldname="STATION_NAME" edittype="DBTree" width="200"
				editable="false" />
                <ai:col fieldname="STATION_ID" visible="false" />
                <ai:col fieldname="STATION_CODE" editable="false" width="50" />
                <ai:col fieldname="AUTHOR_ID" width="50" visible="false" />
                <ai:col fieldname="IS_AUTHOR" width="50" />
                <ai:col fieldname="IS_REAL_OPERATION" width="50" />
                <ai:col fieldname="AUTHOR_VALID_DATE" width="130" />
                <ai:col fieldname="AUTHOR_EXPIRE_DATE" width="130" />
                <ai:col fieldname="NOTES" editable="true" width="120" />
                <ai:col fieldname="FL" editable="true" width="120" visible="false" />
              </ai:table>
            </div>
            <div align="center" style="height:35px; padding-top:6px;">
              <input name="Input2" type="button" class="btn-2word" value="组织"  onClick="org_sel()"/>
              &nbsp;
              <input name="Input2" type="button" class="btn-2word" value="确认"  onClick="authorise()"/>
              &nbsp;
              <input name="Input2" type="button" class="btn-4word" value="全组授权"  onClick="saveByGroup()"/>
              &nbsp;
              <input name="Input2" type="button" class="btn-2word" value="全选"   onClick="selectAll()"/>
              &nbsp;
              <input name="Input2" type="button" class="btn-4word" value="取消全选"  onClick="cancel()"/>
            </div></td>
        </tr>
      </table></td>
  </tr>
</table>
<script type="text/javascript">
	var tree_value	=	null;		//当前节点的值
	var tree_text 	= 	null;		//当前节点的文本
	var tree_userObj= 	null;		//当前节点的用户值
	var party_id	=	null;
	var result		=	new Object();
	var sysUserGroup = g_FormRowSetManager.get("sysUserGroup");
	var sysUserGroupTable = g_TableRowSetManager.get("sysUserGroupTable");	
	var sysUserGroupRelateTable = g_TableRowSetManager.get("sysUserGroupRelateTable");	
	var group_id=0;
	var isGroup = false;
	
	var dbtree = g_DBTreeNewManager.get("partytree");
	

	
	var gAuthor = g_TableRowSetManager.get("author");
	
	var gAuthorAdd = g_TableRowSetManager.get("author_add");
	
	var selAuthorId = "";
	
	
	//点击参与人显示该参与所包含的操作员
	function treeNodeClick(treeVal,treeText,treeUserObj,treeNodeType){
		if(treeVal==-1) return;
		tree_value = treeVal;
		tree_text = treeText;
		tree_userObj = treeUserObj;
		result.partyroleid	 = tree_value;
		result.partyrolename = tree_text;
		result.partyid		 = party_id;
	}
	
	function chkSelected(value,text,userobj,isChecked,nType) {
		
		var childrenNodes = dbtree.getChildrenNodesInfo(value);
		//alert(childrenNodes.length);
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
	
	function saveByGroup(){
	if(!isGroup){
	alert("请切换到分组授权");
	return;
	}
	if(group_id==0){
	alert("请先双击选择一个分组");
	return;
	}
	
	list = new Array();
		
		var selRows = gAuthor.getSelectedRows();
		if(selRows.length<1){
			alert('请选定授权权限点');
			return;
		}
		
		for(var n=0;n<selRows.length;n++){
			gAuthorAdd.newRow();
			gAuthorAdd.setValue(gAuthorAdd.getRow(),"STATION_NAME",gAuthor.getValue(selRows[n],"STATION_NAME"));
			gAuthorAdd.setValue(gAuthorAdd.getRow(),"STATION_ID",gAuthor.getValue(selRows[n],"STATION_ID"));
			gAuthorAdd.setValue(gAuthorAdd.getRow(),"STATION_CODE",gAuthor.getValue(selRows[n],"STATION_CODE"));
			gAuthorAdd.setValue(gAuthorAdd.getRow(),"AUTHOR_ID",gAuthor.getValue(selRows[n],"AUTHOR_ID"));
			gAuthorAdd.setValue(gAuthorAdd.getRow(),"IS_AUTHOR",gAuthor.getValue(selRows[n],"IS_AUTHOR"));
			gAuthorAdd.setValue(gAuthorAdd.getRow(),"IS_REAL_OPERATION",gAuthor.getValue(selRows[n],"IS_REAL_OPERATION"));
			gAuthorAdd.setValue(gAuthorAdd.getRow(),"AUTHOR_VALID_DATE",gAuthor.getValue(selRows[n],"AUTHOR_VALID_DATE"));
			gAuthorAdd.setValue(gAuthorAdd.getRow(),"AUTHOR_EXPIRE_DATE",gAuthor.getValue(selRows[n],"AUTHOR_EXPIRE_DATE"));
			gAuthorAdd.setValue(gAuthorAdd.getRow(),"NOTES",gAuthor.getValue(selRows[n],"NOTES"));
			gAuthorAdd.setValue(gAuthorAdd.getRow(),"FL",gAuthor.getValue(selRows[n],"FL"));
		}
		list.push(gAuthorAdd);
		
		
		  
		var retMsg = saveRowSet("<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysAuthoriseAction?action=saveBatchAuthorStationByGroup&group_id="+group_id,list);
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
	
	
	
	}
	function authorise(){
	 
		//先清空数据
		cleargrid();
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
			alert('请选定授权员工');
			return;
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
	 
					}
			}
		}
		
		list = new Array();
		
		var selRows = gAuthor.getSelectedRows();
		if(selRows.length<1){
			alert('请选定授权权限点');
			return;
		}
		
		for(var n=0;n<selRows.length;n++){
			gAuthorAdd.newRow();
			gAuthorAdd.setValue(gAuthorAdd.getRow(),"STATION_NAME",gAuthor.getValue(selRows[n],"STATION_NAME"));
			gAuthorAdd.setValue(gAuthorAdd.getRow(),"STATION_ID",gAuthor.getValue(selRows[n],"STATION_ID"));
			gAuthorAdd.setValue(gAuthorAdd.getRow(),"STATION_CODE",gAuthor.getValue(selRows[n],"STATION_CODE"));
			gAuthorAdd.setValue(gAuthorAdd.getRow(),"AUTHOR_ID",gAuthor.getValue(selRows[n],"AUTHOR_ID"));
			gAuthorAdd.setValue(gAuthorAdd.getRow(),"IS_AUTHOR",gAuthor.getValue(selRows[n],"IS_AUTHOR"));
			gAuthorAdd.setValue(gAuthorAdd.getRow(),"IS_REAL_OPERATION",gAuthor.getValue(selRows[n],"IS_REAL_OPERATION"));
			gAuthorAdd.setValue(gAuthorAdd.getRow(),"AUTHOR_VALID_DATE",gAuthor.getValue(selRows[n],"AUTHOR_VALID_DATE"));
			gAuthorAdd.setValue(gAuthorAdd.getRow(),"AUTHOR_EXPIRE_DATE",gAuthor.getValue(selRows[n],"AUTHOR_EXPIRE_DATE"));
			gAuthorAdd.setValue(gAuthorAdd.getRow(),"NOTES",gAuthor.getValue(selRows[n],"NOTES"));
			gAuthorAdd.setValue(gAuthorAdd.getRow(),"FL",gAuthor.getValue(selRows[n],"FL"));
		}
		list.push(gAuthorAdd);
		
		
		  
		var retMsg = saveRowSet("<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysAuthoriseAction?action=saveBatchAuthorStation&selAuthorId="+selAuthorId,list);
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
	  	
	}
	function cancel(){
		//dbtree.clearSelection();
		gAuthor.selectAll(false);
		for(var i=0;i<gAuthor.count();i++){
			if(gAuthor.getValue(i,"FL")=="STATION"){
				selectAction(i,false);
			}
		}
	}
	
	function selectAll(){
		gAuthor.selectAll(true);
		var selNodes = gAuthor.getSelectedRows();
		for(var i=0;i<selNodes.length;i++){
			selectAction(selNodes[i],true);
		}
	}
	
	function cleargrid(){
	
	
	gAuthorAdd.refresh("STATION_ID=-1");
	/**
	   var selCount = gRowSet.count();
	   for( var i=selCount-1;i>=0;i-- ){
	       gRowSet.deleteRow(i);
	   }
	   
	   var selauthorCount = gAuthorAdd.count();
	   for( var i=selauthorCount-1;i>=0;i-- ){
	       gAuthorAdd.deleteRow(i);
	   }
	   */
	}
	
	function selectAction(RowIndex,isSelected){
		if(isSelected==true ){
			gAuthor.setValue(RowIndex,"IS_AUTHOR","N","否");
			gAuthor.setValue(RowIndex,"IS_REAL_OPERATION","Y","是");
			gAuthor.setValue(RowIndex,"AUTHOR_VALID_DATE","2000-01-01 00:00:00");
			gAuthor.setValue(RowIndex,"AUTHOR_EXPIRE_DATE","2050-01-01 00:00:00");
			gAuthor.setValue(RowIndex,"NOTES","");
		}
		if(isSelected==false){
			gAuthor.setValue(RowIndex,"IS_AUTHOR","");
			gAuthor.setValue(RowIndex,"IS_REAL_OPERATION","");
			gAuthor.setValue(RowIndex,"AUTHOR_VALID_DATE","");
			gAuthor.setValue(RowIndex,"AUTHOR_EXPIRE_DATE","");
			gAuthor.setValue(RowIndex,"NOTES","");
		}
	}
	function onload(){
		gAuthor.visibleSelect(-100,false);
		var tblCount = gAuthor.count();
		for(i=0;i<tblCount;i++){
			var fl = gAuthor.getValue(i,"FL");
			if(fl!="STATION"){
				gAuthor.setRowEditSts(i,false);
				gAuthor.visibleSelect(i,false);
			}
		}
	}
	function org_sel(){
	 var result = orgSelectDialog(<%=party_role_id%>);

		//重新装载岗位
		if(result!=null ){
                       org_id = result[0].orgId;
			cond = "orgId="+org_id+"&orgRoleTypeId=1&staffId=-1";
			//alert(cond);
			gAuthor.refresh(cond);
			onload();
		}
	
	
		if(result!=null){
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
	//onload();
</script>
</body>
</html>