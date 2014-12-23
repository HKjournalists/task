<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<%@ page import="com.ai.appframe2.web.HttpUtil" %>
<html>
<head>
<title>
</title>
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
  <tr>
    <td class="tdhead"><table width="250" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
        <tr>
          <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
          <td style="height: 20px">岗位授权</td>
          <td align="right" style="height: 20px"></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" align="left"><ai:table setname="com.ai.secframe.bo.sysmgr.SysAuthor" tableid="station_autor_table"
 tablemodel = "com.ai.appframe2.web.datamodel.QueryModelForService"
 initial = "false" multiselect = "true" needrefresh="true"
 editable = "true" width="680" height="360" implservice_name="com.ai.secframe.service.sysmgr.SysAuthor"
 implservice_querymethod="querySysAuthor" implservice_countmethod="">
 		<ai:col fieldname="STATION_ID"  width="180"  editable = "false"  visible="true"/>
		<ai:col fieldname="IS_AUTHOR"  width="100"  editable = "true"  visible="true"/>
		<ai:col fieldname="AUTHOR_TYPE"  width="100"  editable = "true"  visible="true"/>
		<ai:col fieldname="IS_REAL_OPERATION"  width="100"  editable = "true"  visible="false"/>
		<ai:col fieldname="AUTHOR_VALID_DATE"  width="150"  editable = "true"  visible="true"/>
		<ai:col fieldname="AUTHOR_EXPIRE_DATE"  width="150"  editable = "true"  visible="true"/>
		<ai:col fieldname="NOTES"  width="100"  editable = "true"  visible="true"/>
		
		
</ai:table>
      <div align="center" style="height:30px; padding-top:6px;">
        <input name="button"  type="button" id="addBtn" class="btn-2word" onClick="addStation()" value="新增"/>
        &nbsp;
        <input name="button"  type="button" id="saveBtn" class="btn-2word" onClick="save()" value="保存"/>
        &nbsp;
        <input name="button" id="delBtn"  type="button" class="btn-2word" onClick="delete_Station();" value="删除"/>
      </div></td>
  </tr>
</table>
<script>
	var org_id = null;
	var staff_id = null;
        var cur_orginize_party_role_id =-1;
        var cur_orginize_party_id =-1;
	var gRowSet = g_TableRowSetManager.get("station_autor_table");
	
	function init(staffId,orgId){
		org_id = orgId;
		staff_id = staffId;
		var cond = " state=1 and AUTHOR_TYPE in ('A','B','C') and STAFF_ID = "+staff_id ; //这里不显示角色过来的
		gRowSet.refresh(cond);
	}
	
	if(org_id==null||staff_id==''){

		alert('请选择组织和员工!');
	}else{
		addBtn.setDisabled(false);
  		saveBtn.setDisabled(false);
  		delBtn.setDisabled(false);
	}
	//删除授权与他的功能点
	function delete_Station(){
	   var selCount = gRowSet.getSelectedRows();
	   var len = selCount.length;
	   if( len <= 0 )
	   {
	     alert("请在先选择要删除的权限点！");
	     return;
	   }
	   var roleT = ""; //角色授权的不能删除
	   if(confirm("是否确定要删除该权限点授权?")){
	   	for( var i=len-1;i>=0;i-- ){
	       
	   	   if(gRowSet.getValue(selCount[i],"AUTHOR_TYPE")!='B')
	       	gRowSet.deleteRow(selCount[i]);
	       else
	        roleT = gRowSet.getDisplayText(selCount[i],"STATION_ID") +","+ roleT ;
	   	}
	   	if(roleT!=""){
	   		alert("以下岗位\""+roleT+"\"是通过角色授权过来，请通过角色授权删除");
	   	}
	   }else{
	   		return;
	   }
	   list = new Array();
		list.push(gRowSet);
		if(gRowSet.toXmlString(true)==""){
			return;
		}
		var retMsg = saveRowSet("<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysAuthoriseAction?action=saveAuthorStation&staff_id="+staff_id,list);
		var msg = retMsg.getValueByName("retVal");
		errorMsg = retMsg.getValueByName("msg");
	  	if( msg=="0" ){
		    alert("保存成功");
		    gRowSet.refresh("state=1 and AUTHOR_TYPE in ('A','B','C') and staff_id=" + staff_id);
			
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
		for(var i=0;i<gRowSet.count();i++)
		{
		 var svdate=gRowSet.getValue(i,"AUTHOR_VALID_DATE");
		 var sedate=gRowSet.getValue(i,"AUTHOR_EXPIRE_DATE");
		 var re = /-/g; 
		 var newvdate=svdate.replace(re,"/");
		 var newedate=sedate.replace(re,"/");

		 
		 if(Date.parse(newvdate) > Date.parse(newedate) )
		 {
		  alert("权限生效时间必须大于失效时间！");
		  gRowSet.setFocusByName(i,"AUTHOR_VALID_DATE");
		  return ;
		 }
		}
		list = new Array();
		list.push(gRowSet);
		var retMsg = saveRowSet("<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysAuthoriseAction?action=saveAuthorStation&staff_id="+staff_id,list);
		var msg = retMsg.getValueByName("retVal");
		errorMsg = retMsg.getValueByName("msg");
	  	if( msg=="0" ){
		    alert("保存成功");
		    gRowSet.refresh("state=1 and AUTHOR_TYPE in ('A','B','C') and STAFF_ID = "+staff_id );
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


	//添加功能点
	function addStation(){
		var paraArray = new Array();
	  	for(var i=0;i<gRowSet.count();i++){
	  		paraArray[i] = gRowSet.getValue(i,"STATION_ID");
	  	}
	  	if(org_id==null){
	  		alert('请选定组织和员工!');
	  		return;
	  	}
		var d = new Date();
		var flag = window.showModalDialog("StationSelect.jsp?org_id=" + org_id + "&staff_id="+staff_id
			+ "&d="+d.getTime(),paraArray,"scroll:no;resizable:no;status:no;dialogHeight:450px;dialogWidth:300px;help:no");

		if(flag!=null){
			var addArray = flag;
				for(var i=0;i<addArray.length;i++){
		                gRowSet.newRow();
		                gRowSet.setValue(gRowSet.getRow(),"STATION_ID",addArray[i].id,addArray[i].value);
		                gRowSet.setValue(gRowSet.getRow(),"IS_AUTHOR","N","否");
		                gRowSet.setValue(gRowSet.getRow(),"IS_REAL_OPERATION","Y","是");
		                gRowSet.setValue(gRowSet.getRow(),"AUTHOR_EXPIRE_DATE",'2014-01-01 00:00:00');
		                gRowSet.setValue(gRowSet.getRow(),"AUTHOR_VALID_DATE",g_GetSysDateTime());
		                gRowSet.setValue(gRowSet.getRow(),"REMARKS","");
		        }
				//save();
				alert('请点保存按钮后新增的岗位授权数据生效！');
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
