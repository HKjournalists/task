<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<%@ page import="com.ai.appframe2.web.HttpUtil" %>
<ai:scriptinclude src="/secframe/common/common.js" />
<html>
<head>
<title></title>
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
                <td style="height: 20px">Ա��ѡ��</td>
                <td align="right" style="height: 20px"><input name="button" type="button" class="btn-3word"  onClick="selectType(1)" value="����֯"/>
                  <input name="button2" type="button" class="btn-3word"  onClick="selectType(2)" value="������"/></td>
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
                  <td width="100"> �û�������</td>
                  <td colspan="3"><ai:dbformfield formid="sysUserGroup" fieldname="GROUP_NAME"
								width="100" height="20" editable="true" visible="true" />
                    <input name="Input2" type="button" class="btn-2word" value="��ѯ"  onClick="search()"/>
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
                <td style="height: 20px">��Ȩ��ɫ�б�</td>
                <td align="right" style="height: 20px">&nbsp;</td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="left" height="250" valign="top"><ai:dbform
					setname="com.ai.secframe.bo.sysmgr.SysStaffRoleAuthor"
					formid="searchform" initial="false" >
              <table border="0"  height="35" align="center" cellpadding="0" cellspacing="0">
                <tr>
                  <td> Ȩ����Դ
                    <ai:dbformfield formid="searchform" fieldname="ORGANIZE_ID" width="150"
						height="20" editable="false" visible="true" />
                    <input type="button" value='...' id="searchrole" class="btn-1word" onClick="org_sel()" />
                    ��Чʱ��
                    <ai:dbformfield formid="searchform" fieldname="AUTHOR_VALID_DATE" width="150"
						height="20" editable="true" visible="true" />
                    ʧЧʱ��
                    <ai:dbformfield formid="searchform" fieldname="AUTHOR_EXPIRE_DATE"
						width="150" height="20" editable="true" visible="true" />
                  </td>
                </tr>
              </table>
            </ai:dbform>
            <ai:table
			tableid="tblRole" setname="com.ai.secframe.bo.sysmgr.SysRole"
			tablemodel="com.ai.appframe2.web.datamodel.QueryModelForService"
			implservice_name="com.ai.secframe.service.sysmgr.SysRole"
			implservice_querymethod="querySysRole"
			implservice_countmethod="querySysRoleCount" initial="true"
			pagesize="30" multiselect="true" editable="true" width="750"
			height="430" needrefresh="true"
			conditionname="condition">
              <ai:col fieldname="ROLE_ID" editable="false" visible="false" />
              <ai:col fieldname="NAME" width="380" editable="false" visible="true" />
              <ai:col fieldname="NOTES" width="375" editable="false" visible="true" />
            </ai:table>
            <div style="display:none">
              <ai:table setname="com.ai.secframe.bo.sysmgr.SysStaffRoleAuthor"
	tableid="role_autor_table" tablemodel = "com.ai.appframe2.web.datamodel.MethodModelForService" 
 	initial = "false" >
                <ai:col fieldname="ROLE_AUTHOR_ID"  width="100"  editable = "false"  visible="false"/>
                <ai:col fieldname="ROLE_ID"  width="100"  editable = "false"  visible="true"/>
                <ai:col fieldname="ORGANIZE_ID"  width="100"  editable = "false"  visible="true"/>
                <ai:col fieldname="AUTHOR_VALID_DATE"  width="150"  editable = "true"  visible="true"/>
                <ai:col fieldname="AUTHOR_EXPIRE_DATE"  width="150"  editable = "true"  visible="true"/>
                <ai:col fieldname="NOTES"  width="100"  editable = "true"  visible="true"/>
                <ai:col fieldname="STAFF_ID"  width="100"  editable = "false"  visible="false"/>
              </ai:table>
            </div>
            <div align="center" style="height:35px; padding-top:6px;">
              <input name="Input2" type="button" class="btn-2word" value="ȷ��"  onClick="authorise()"/>
              &nbsp;
              <input name="Input2" type="button" class="btn-4word" value="������Ȩ"  onClick="authoriseByGroup()"/>
              &nbsp; </div></td>
        </tr>
      </table></td>
  </tr>
</table>
<script type="text/javascript">
	var tree_value	=	null;		//��ǰ�ڵ��ֵ
	var tree_text 	= 	null;		//��ǰ�ڵ���ı�
	var tree_userObj= 	null;		//��ǰ�ڵ���û�ֵ
	var party_id	=	null;
	var result		=	new Object();
	var dbtree = g_DBTreeNewManager.get("partytree");
	var gAuthor = g_TableRowSetManager.get("tblRole");
	var formRowSet = g_FormRowSetManager.get("searchform");
	var gAuthorAdd = g_TableRowSetManager.get("role_autor_table");
	var authorpartyid =-1;
	
	var sysUserGroup = g_FormRowSetManager.get("sysUserGroup");
	var sysUserGroupTable = g_TableRowSetManager.get("sysUserGroupTable");	
	var sysUserGroupRelateTable = g_TableRowSetManager.get("sysUserGroupRelateTable");	
	var group_id=0;
	var isGroup = false;
	
	var selAuthorId = "";
	
	function selectAll(){
		gAuthor.selectAll(true);
	}
	
	
	//�����������ʾ�ò����������Ĳ���Ա
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
			alert("���л���������Ȩ");
			return;
		}
		if(group_id==0){
			alert("����˫��ѡ��һ������");
			return;
		}
		
		cleargrid();
		selAuthorId = "";
		
		
		if(authorpartyid==-1){
			alert('��ѡ��Ȩ����Դ!');
			return;
		}
		
		var authorValidDate = formRowSet.getValue("AUTHOR_VALID_DATE");
		
		if(authorValidDate==null||authorValidDate==''){
			alert('��ѡ����Ч����!');
			return;
		}
		var authorExpireDate = formRowSet.getValue("AUTHOR_EXPIRE_DATE");
		if(authorExpireDate==null||authorExpireDate==''){
			alert('��ѡ��ʧЧ����!');
			return;
		}
		if(authorExpireDate<=authorValidDate){
			alert('ʧЧ���ڱ��������Ч����!');
			return;
		}
		
		
		list = new Array();
		
		
		var selRows = gAuthor.getSelectedRows();
		if(selRows.length<1){
			alert('��ѡ����Ȩ��ɫ');
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
		    alert("����ɹ�");
		}else if(msg=="-1"){
	  		alert(errorMsg);
	  	}else if(msg=="-2"){
	  		alert(errorMsg);
	  	}else if(msg=="-3"){
	  		alert(errorMsg);
	  	}else if(msg=="-4"){
	  		alert(errorMsg);
	  	}else{
	  		alert("����ʧ��");
	  	}
	  	window.location.href='BatchRoleAuthorise.jsp';
	}
	
	
	function authorise(){
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
				alert("���ڷ�����ѡ����ȨԱ��");
				return;
			}
			
			} else {
			if(nodeArray.length<1){
				alert('��ѡ����ȨԱ��!');
				return;
			}
			//if(nodeArray.length>50){
			//	alert('ѡ����ȨԱ���벻Ҫ����50��!');
			//	return;
			//}
		}
		if(authorpartyid==-1){
			alert('��ѡ��Ȩ����Դ!');
			return;
		}
		
		var authorValidDate = formRowSet.getValue("AUTHOR_VALID_DATE");
		
		if(authorValidDate==null||authorValidDate==''){
			alert('��ѡ����Ч����!');
			return;
		}
		var authorExpireDate = formRowSet.getValue("AUTHOR_EXPIRE_DATE");
		if(authorExpireDate==null||authorExpireDate==''){
			alert('��ѡ��ʧЧ����!');
			return;
		}
		if(authorExpireDate<=authorValidDate){
			alert('ʧЧ���ڱ��������Ч����!');
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
					alert(selAuthorId);					
				}
		}
		list = new Array();
		
		
		var selRows = gAuthor.getSelectedRows();
		if(selRows.length<1){
			alert('��ѡ����Ȩ��ɫ');
			return;
		}
		for(var n=0;n<selRows.length;n++){
			gAuthorAdd.newRow();
			gAuthorAdd.setValue(gAuthorAdd.getRow(),"ROLE_ID",gAuthor.getValue(selRows[n],"ROLE_ID"));
		}
		var submitURL = "<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysAuthoriseAction?action=saveBatchAuthorRole";
		submitURL = submitURL+"&authorValidDate="+authorValidDate;
		submitURL = submitURL+"&authorExpireDate="+authorExpireDate;
		submitURL = submitURL+"&authorpartyid="+authorpartyid;
		submitURL = submitURL+"&selAuthorId="+selAuthorId;
		//alert(submitURL);
		list.push(gAuthorAdd);
		var retMsg = saveRowSet(submitURL,list);
		var msg = retMsg.getValueByName("retVal");
		errorMsg = retMsg.getValueByName("msg");
	  	if( msg=="0" ){
		    alert("����ɹ�");
		}else if(msg=="-1"){
	  		alert(errorMsg);
	  	}else if(msg=="-2"){
	  		alert(errorMsg);
	  	}else if(msg=="-3"){
	  		alert(errorMsg);
	  	}else if(msg=="-4"){
	  		alert(errorMsg);
	  	}else{
	  		alert("����ʧ��");
	  	}
	  	window.location.href='BatchRoleAuthorise.jsp';
	}
	
	function cancel(){
		//dbtree.clearSelection();
		gAuthor.selectAll(false);
	}
	
	
	function cleargrid(){
	  
	   
	   var selauthorCount = gAuthorAdd.count();
	   for( var i=selauthorCount-1;i>=0;i-- ){
	       gAuthorAdd.deleteRow(i);
	   }
	}
	
	function selectAction(RowIndex,isSelected){

	}
	function onload(){
		
	}
	function org_sel(){
	 var result = orgSelectDialog(<%=com.ai.appframe2.common.SessionManager.getUser().getOrgId()%>);
		if(result!=null){
			formRowSet.setValue('ORGANIZE_ID',result[0].orgName,result[0].orgName);
			authorpartyid = result[0].orgId;
		}
		
	}
	onload();
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
			alert("����������");
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
	  alert("��ѡ��");
	 }
	}
</script>
</body>
</html>