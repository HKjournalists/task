<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<%@ page import="com.ai.appframe2.web.HttpUtil" %>
<html>
<head>
<title>角色授权</title>
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
  <tr>
    <td class="tdhead"><table width="250" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
        <tr>
          <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
          <td style="height: 20px">岗位角色授权</td>
          <td align="right" style="height: 20px"></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" align="left"><ai:table setname="com.ai.secframe.bo.sysmgr.SysStaffRoleAuthor"
 tableid="role_autor_table" tablemodel = "com.ai.appframe2.web.datamodel.QueryModelForService" 
 initial = "false" multiselect = "true" needrefresh="true"
 editable = "true" width="700" height="350" implservice_name="com.ai.secframe.service.sysmgr.SysStaffRoleAuthor"
 implservice_querymethod="querySysStaffRoleAuthor" implservice_countmethod="">
        <ai:col fieldname="ROLE_AUTHOR_ID"  width="100"  editable = "false"  visible="false"/>
        <ai:col fieldname="ROLE_ID"  width="100"  editable = "false"  visible="true"/>
        <ai:col fieldname="AUTHOR_VALID_DATE"  width="150"  editable = "true"  visible="true"/>
        <ai:col fieldname="AUTHOR_EXPIRE_DATE"  width="150"  editable = "true"  visible="true"/>
        <ai:col fieldname="NOTES"  width="100"  editable = "true"  visible="true"/>
        <ai:col fieldname="ORGANIZE_ID"  width="100"  editable = "true"  visible="true"/>
      </ai:table>
      <div align="center" style="height:30px; padding-top:6px;">
      <input id ="org" value = "" type="text" width="40px"/>
      <input value="组织来源" id="selectBtn" onclick="org_sel()" type="button" class="btn-4word" />&nbsp;      
        <input name="button"  type="button" id="addBtn" class="btn-2word" onClick="addStation()" value="新增"/>
        &nbsp;
        <input name="button"  type="button" id="saveBtn" class="btn-2word" onClick="save()" value="保存"/>
        &nbsp;
        <input name="button" id="delBtn"  type="button" class="btn-2word" onClick="delete_Station();" value="删除"/>
      </div></td>
  </tr>
</table>
<script>
	var person_party_id = "-1";
	var org_id = null;
	var staff_id = null;
	var gRowSet = g_TableRowSetManager.get("role_autor_table");
	
	function org_sel(){
	 	var result = orgSelectDialog(<%=SessionManager.getUser().getOrgId()%>);
		//重新装载岗位
		if(result!=null ){
			document.getElementById("org").value= result[0].orgName;
			org_id = result[0].orgId;
		}	
	
		if(result!=null){
		}
		
	}
	
	function init(staffId,orgId){
		org_id = orgId;
		staff_id = staffId;
		gRowSet.refresh(" state=1 and STAFF_ID = "+staff_id );
	}
	if(person_party_id==null||person_party_id==''){
		addBtn.disabled=true;
  	    saveBtn.disabled=true;
  	    delBtn.disabled=true;
		alert('请选择组织和员工!');
	}else{
		addBtn.disabled=false;
  		saveBtn.disabled=false;
  		delBtn.disabled=false;
	}
	//删除授权与他的岗位类型集
	function delete_Station(){
	   var selCount = gRowSet.getSelectedRows();
	   var len = selCount.length;
	   if( len <= 0 )
	   {
	     alert("请在先选择要删除的岗位角色！");
	     return;
	   }
	   if (confirm("您确认删除选定的岗位角色吗？")){
		   for( var i=len-1;i>=0;i-- ){
		       gRowSet.deleteRow(selCount[i]);
		   }
	   }else{
	   		return;
	   }
	   list = new Array();
		list.push(gRowSet);
		var retMsg = saveRowSet("<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.AuthoriseAction?action=saveAuthorRole&staff_id="+staff_id+"&org_id="+org_id,list);
		var msg = retMsg.getValueByName("retVal");
		errorMsg = retMsg.getValueByName("msg");
	  	if( msg=="0" ){
		    alert("保存成功");
		    //gRowSet.refresh();
		    gRowSet.refresh(" state=1 and STAFF_ID = " + staff_id);
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
	
	
	//保存
	function save(){
		if(gRowSet.toXmlString(true)==""){
			alert('当前的数据尚未被修改，不需要保存！');
			return;
		}
		list = new Array();
		list.push(gRowSet);
		if(gRowSet.toXmlString(true)==""){
			return;
		}
		var retMsg = saveRowSet("<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.AuthoriseAction?action=saveAuthorRole&staff_id="+staff_id+"&org_id="+org_id,list);
		var msg = retMsg.getValueByName("retVal");
		errorMsg = retMsg.getValueByName("msg");
	  	if( msg=="0" ){
		    alert("保存成功");
		    //gRowSet.refresh();
		    gRowSet.refresh(" state=1 and STAFF_ID = " + staff_id);
		}else if(msg=="-1"){
	  		alert(errorMsg);
	  		gRowSet.refresh(" state=1 and STAFF_ID = " + staff_id);
	  	}else if(msg=="-2"){
	  		alert(errorMsg);
	  		gRowSet.refresh(" state=1 and STAFF_ID = " + staff_id);
	  	}else if(msg=="-3"){
	  		alert(errorMsg);
	  		gRowSet.refresh(" state=1 and STAFF_ID = " + staff_id);
	  	}else if(msg=="-4"){
	  		alert(errorMsg);
	  		gRowSet.refresh(" state=1 and STAFF_ID = " + staff_id);
	  	}else{
	  		alert("保存失败");
	  		gRowSet.refresh(" state=1 and STAFF_ID = " + staff_id);
	  	}
		
	}
	
	
	//添加岗位
	function addStation(){
		if(staff_id==null){
			alert("请先选择员工");
			return;
			}
	
		var paraArray = new Array();
	  	for(var i=0;i<gRowSet.count();i++){
	  		var rowObject = new Object();
	  		rowObject.roleid =  gRowSet.getValue(i,"ROLE_ID");
	  		rowObject.authororgid =  gRowSet.getValue(i,"ORGANIZE_ID");
	  		paraArray[i] = rowObject;
	  	}
		var d = new Date();
		var flag = window.showModalDialog("RoleSelect.jsp?org_id=" + org_id +
			"&d="+d.getTime(),paraArray,"scroll:no;resizable:no;status:no;dialogHeight:460px;dialogWidth:530px;help:no");
		
		if(flag!=null){
			var addArray = flag;
			//首先取得组织编号
			var org = addArray[addArray.length-1];
			//alert(org.id);
				//alert(org.id +"---"+org.value);
				for(var i=0;i<addArray.length-1;i++){
		                gRowSet.newRow();
		                gRowSet.setValue(gRowSet.getRow(),"ROLE_ID",addArray[i].id,addArray[i].value);
		                gRowSet.setValue(gRowSet.getRow(),"ORGANIZE_ID",org.id,org.value);
		                //gRowSet.setValue(gRowSet.getRow(),"IS_AUTHOR","N","否");
		                //gRowSet.setValue(gRowSet.getRow(),"IS_REAL_OPERATION","Y","是");
		                gRowSet.setValue(gRowSet.getRow(),"AUTHOR_EXPIRE_DATE",'2050-01-01 00:00:00');
		                gRowSet.setValue(gRowSet.getRow(),"AUTHOR_VALID_DATE",'2000-01-01 00:00:00');
		                gRowSet.setValue(gRowSet.getRow(),"NOTES","");
		        }
		}
	}
	
	//调整控件大小以适应窗口
	function doResize(){
		var width = document.body.offsetWidth;
		var height = document.body.offsetHeight;
		//gRowSet.resize(width-4,height-193);
	}
	
</script>
</BODY>
</HTML>