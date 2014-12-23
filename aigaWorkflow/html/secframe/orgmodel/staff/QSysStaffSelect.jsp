<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai"%>
<%@include file="/secframe/common/common.jsp"%>
<%@ page import="com.ai.appframe2.service.ServiceFactory"%>
<%@ page  import="com.ai.secframe.common.Constants"%>
<%@ page 
	import="com.ai.secframe.service.orgmodel.interfaces.ISysOrganize"%>
<%@ page
	import="com.ai.secframe.ivalues.orgmodel.ISysOrganizeValue"%>
<%@ page
	import="com.ai.secframe.common.Constants"%>
<%
		      ISysOrganize service = (ISysOrganize) ServiceFactory.getService( Constants.SERVICE_SYS_ORGANIZE );
		      ISysOrganizeValue vals = service.getSysOrganizeById( SessionManager.getUser().getOrgId() );
		      String orgCode = vals.getCode();
	%>
<ai:scriptinclude src="/jsv2/json.js"/>
<html>
<head>
<title>选择号码</title>
</head>
<body>
<table width="100%" border=0 cellpadding=0 cellspacing=0 id="mainTable">
  <tr>
    <td valign="top"  bgcolor="#FFFFFF"><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px">员工查询</td>
                <td align="right" style="height: 20px"><div id="buttonDiv" style="display:block"></div></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="left" valign="top"><ai:dbform formid="qSysStaff"
				setname="com.ai.secframe.bo.orgmodel.QSysStaff"
				datamodel="com.ai.appframe2.web.datamodel.QueryModelForService"
				implservice_name="com.ai.secframe.service.orgmodel.SysStaff"
				initial="false"
				editable="true">
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
                <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">工号</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="qSysStaff"
							fieldname="CODE" width="150"
							editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">员工名称</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="qSysStaff"
							fieldname="NAME" width="150"
							editable="true" visible="true" /></td>
              </tr>
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
                <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">组织CODE</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="qSysStaff"
							fieldname="ORGANIZE_CODE" width="150"
							editable="false" visible="true" /></td>
                <td width="1"></td>
                <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">组织名称</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="qSysStaff"
							fieldname="ORGANIZE_NAME" width="150"
							editable="true" visible="true" /></td>
              </tr>
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
                <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">组织ID</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="qSysStaff" fieldname="ORGANIZE_ID" width="100" editable="false" visible="true" />
                  <input value="..." id="selectBtn"
						onclick="org_sel()" type="button" class="btn-1word" /></td>
                <td width="1"></td>
                <td colspan="3" bgcolor="#F1F3FB" class="font13pxboldblack" style="padding-left:15px;"><input name="Input" type="button" class="btn-2word" value="查询" id="queryBtn" onClick="searchStaff()"/>
                </td>
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
            </table></ai:dbform></td>
        </tr>
      </table>
      <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px"> 员工列表</td>
                <td align="right" style="height: 20px"><input name="Input" type="button" class="btn-2word" value="确定" id="OKBtn" onClick="OK()"/>
                  <input name="Input" type="button" class="btn-2word" value="取消" id="CancelBtn" onClick="CANCEL()"/>
                </td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="center" valign="top"><table border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td align=center height="100" valign="top"><ai:table tableid="qSysStaffResultTable"
						setname="com.ai.secframe.bo.orgmodel.QSysStaff"
						initial="false" multiselect="true" editable="false"
						tablemodel="com.ai.appframe2.web.datamodel.QueryModelForService"
						implservice_name="com.ai.secframe.service.orgmodel.SysStaff"
						implservice_querymethod="queryQSysStaff"
						implservice_countmethod="queryQSysStaffCount"
						width="380" height="530" needrefresh="true" footdisplay="none">
                    <ai:col fieldname="CODE" width="80" editable="true"
							visible="true" />
                    <ai:col fieldname="NAME" width="90" editable="true"
							visible="true" />
                    <ai:col fieldname="STAFF_ID" width="260" editable="true"
							visible="false" />
                    <ai:col fieldname="ORGANIZE_CODE" width="80" editable="true"
							visible="true" />
                    <ai:col fieldname="ORGANIZE_NAME" width="140" editable="true"
							visible="true" />
                    <ai:col fieldname="STATE" width="80" editable="true"
							visible="true" />
                  </ai:table>
                </td>
                <td align=center width="30" height="100"><input name="Input" type="button" class="btn-2word" value="<<--" id="add1" onClick="add()"/>
                  <br>
                  <br>
                  <input name="Input" type="button" class="btn-2word" value="-->>" id="remove1" onClick="remove()"/>
                </td>
                <td align=center height="100" valign="top"><ai:table tableid="qSysStaffTable"
						setname="com.ai.secframe.bo.orgmodel.QSysStaff"
						initial="false" multiselect="true" editable="false"
						tablemodel="com.ai.appframe2.web.datamodel.QueryModelForService"
						implservice_name="com.ai.secframe.service.orgmodel.SysStaff"
						implservice_querymethod="queryQSysStaff"
						implservice_countmethod="queryQSysStaffCount"
						width="380" height="520" needrefresh="true"   pagesize="100">
                    <ai:col fieldname="CODE" width="80" editable="true"
							visible="true" />
                    <ai:col fieldname="NAME" width="90" editable="true"
							visible="true" />
                    <ai:col fieldname="STAFF_ID" width="260" editable="true"
							visible="false" />
                    <ai:col fieldname="ORGANIZE_CODE" width="80" editable="true"
							visible="true" />
                    <ai:col fieldname="ORGANIZE_NAME" width="140" editable="true"
							visible="true" />
                    <ai:col fieldname="STATE" width="80" editable="true"
							visible="true" />
                  </ai:table>
                </td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
<script type="text/javascript">	
	var qSysStaff = g_FormRowSetManager.get("qSysStaff");	
	var qSysStaffTable = g_TableRowSetManager.get("qSysStaffTable");	
	var qSysStaffResultTable = g_TableRowSetManager.get("qSysStaffResultTable");
	
	function add(){
	
	if( qSysStaffTable.getSelectedRows()!=null&&qSysStaffTable.getSelectedRows().length>0){
	 		var selRows = qSysStaffTable.getSelectedRows();
	  		for(var i=0;i<selRows.length;i++)
	  		{
		  		qSysStaffResultTable.newRow();
				qSysStaffResultTable.setValue(qSysStaffResultTable.getRow(),"CODE",qSysStaffTable.getValue(selRows[i],"CODE"),qSysStaffTable.getValue(selRows[i],"CODE"));
				qSysStaffResultTable.setValue(qSysStaffResultTable.getRow(),"NAME",qSysStaffTable.getValue(selRows[i],"NAME"),qSysStaffTable.getValue(selRows[i],"NAME"));
				qSysStaffResultTable.setValue(qSysStaffResultTable.getRow(),"STAFF_ID",qSysStaffTable.getValue(selRows[i],"STAFF_ID"),qSysStaffTable.getValue(selRows[i],"STAFF_ID"));
				qSysStaffResultTable.setValue(qSysStaffResultTable.getRow(),"ORGANIZE_CODE",qSysStaffTable.getValue(selRows[i],"ORGANIZE_CODE"),qSysStaffTable.getValue(selRows[i],"ORGANIZE_CODE"));
			  	qSysStaffResultTable.setValue(qSysStaffResultTable.getRow(),"ORGANIZE_NAME",qSysStaffTable.getValue(selRows[i],"ORGANIZE_NAME"),qSysStaffTable.getValue(selRows[i],"ORGANIZE_NAME"));
			  	qSysStaffResultTable.setValue(qSysStaffResultTable.getRow(),"STATE",qSysStaffTable.getValue(selRows[i],"STATE"),qSysStaffTable.getValue(selRows[i],"STATE"));	
	  			
	  		}
	  		
	 }else
	 {
	  alert("请选择记录！");
	 }
		
	}
	function Staff(staffId,staffName,orgId,orgName,staffCode){
		this.staffId = staffId;
		this.staffName = staffName;
		this.orgId = orgId;
		this.orgName = orgName;
		this.staffCode = staffCode;
	}
	function remove(){
	if( qSysStaffResultTable.getSelectedRows()!=null&&qSysStaffResultTable.getSelectedRows().length>0){
	 		
	  		for(var i=0;i < qSysStaffResultTable.count();i++){
			if(qSysStaffResultTable.isSelected(i)){
				qSysStaffResultTable.deleteRow(i);
					i--;
				}
         	}
	  		
	 }else
	 {
	  alert("请选择记录！");
	 }
	}
	
	
	function OK(){	
	
		if(qSysStaffResultTable.getTotalRowCount()==0){
			alert("没有选择的记录")
			return;
		}
		var ids="";
		var names = "";
		for( var j =0 ;j< qSysStaffResultTable.getTotalRowCount() ; j++){

	   		 ids= qSysStaffResultTable.getValue(j,"STAFF_ID") + "," + ids;
	   		 names= qSysStaffResultTable.getValue(j,"NAME") + "," + names;

	   	}
		
		if('staffprivilege'=='<%=request.getParameter("staffprivilege")%>'){
			
			var list = new Array();
			list[0] = ids;
			list[1] = names;
															
		window.returnValue = list;
		window.self.close();
														

		} else {
		
	   	ids = ids.substr(0,ids.length-1);
			var msg = PostInfo("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysUserGroupAction?"+
				"action=addUserGroupRelate&staff_ids="+ids+"&group_id=<%=request.getParameter("group_id")%>");
			alert(msg.getValueByName("MESSAGE"));	
			CANCEL();
			
		}
	
	}	
	
	function CANCEL(){
		window.close();
	}
	
	function searchStaff(){
		var name = qSysStaff.getValue("NAME");
		var code = qSysStaff.getValue("CODE");
		var orgName = qSysStaff.getValue("ORGANIZE_NAME");
		var orgCode = qSysStaff.getValue("ORGANIZE_CODE");
		var orgId = qSysStaff.getValue("ORGANIZE_ID");
		
		
		var nameCond = "";
		var codeCond = "";
		var orgNameCond="";
		var orgCodeCond="";
		var orgIdCond="";
		
		var flag = false;
		
		if(name!=null&&name!=""){
			nameCond = "NAME LIKE '"+name+"%' ";
		}
		
		if(code!=null&&code!=""){
			codeCond = "CODE LIKE '"+code+"%' ";
		}
		
		if(orgName!=null&&orgName!=""){
			orgNameCond = "ORGANIZE_NAME LIKE '"+orgName+"%' ";
		}
		
		if(orgCode!=null&&orgCode!=""&&orgCode!="Y"){
			orgCodeCond = "ORGANIZE_CODE LIKE '"+orgCode+"%' ";
		}
		
		if(orgId!=null&&orgId!=""){
			orgIdCond = "ORGANIZE_ID = "+orgId+" ";
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
		if(orgNameCond!=""){
			if(flag){
				cond = cond +" AND "+ orgNameCond;
			}else {
				cond = cond +  orgNameCond;
				flag = true;
			}
		}
		if(orgCodeCond!=""){
			if(flag){
				cond = cond +" AND "+ orgCodeCond;
			}else {
				cond = cond +  orgCodeCond;
				flag = true;
			}
		}
		if(orgIdCond!=""){
			if(flag){
				cond = cond +" AND "+ orgIdCond;
			}else {
				cond = cond +  orgIdCond;
				flag = true;
			}
		}
		
		
		if(cond==""){
			alert("请输入条件");
			return ;
		}
		
		   cond = encodeURI(cond); 
			cond = encodeURI(cond);
		
		qSysStaffTable.refresh(cond);
	}
	function org_sel(){
	 	var result = orgSelectDialog(<%=SessionManager.getUser().getOrgId()%>);
		//重新装载岗位
		if(result!=null ){
            org_id = result[0].orgId;
			qSysStaff.setValue("ORGANIZE_ID",org_id);
		}
	
	
		if(result!=null){
		}
		
	}
	//qSysStaff.setValue("ORGANIZE_CODE",'<%=orgCode%>');
</script>
</html>