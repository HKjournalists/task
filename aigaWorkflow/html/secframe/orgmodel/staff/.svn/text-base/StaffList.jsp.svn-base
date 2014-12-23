<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai"%>
<%@include file="/secframe/common/common.jsp"%>
<html>
<head>
<title></title>
<%
	long org_id = SessionManager.getUser().getOrgId();
%>
</head>
<body>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="230"><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px">员工选择</td>
                <td align="right" style="height: 20px"><input id="byorgbtn" type="button" class="btn-3word" value="按组织"  onClick="QueryByOrg()"/>
                  <input id="bycondbtn" type="button" class="btn-3word" value="按条件"  onClick="QueryByCond()"/></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="left" style="padding-left:5px;" height="250" valign="top"><div id="bycond" style="display: none;">
              <table align="center" border="1" bordercolor="#E1EDFA" cellpadding="0" cellspacing="0">                
                <tr heigth=30>
                  <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">名称</td>
                        <td width="1"></td>
                        <td bgcolor="#F1F3FB" class="font13pxboldblack" colspan="5"><input value="" type="text" id="name"/>
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
                        <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">工号</td>
                        <td width="1"></td>
                        <td bgcolor="#F1F3FB" class="font13pxboldblack" colspan="5"><input type="text"  value="" id="code"/>
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
                        <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">手机号</td>
                        <td width="1"></td>
                        <td bgcolor="#F1F3FB" class="font13pxboldblack" colspan="5"><input type="text"  value="" id="billId"/></td>
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
                  <td align="center" valign="middle"><input name="" type="button" class="btn-2word" value="查询" id="addRoleBtn" onClick="searchStaff()"/>
                  </td>
                <tr>
              </table>
            </div>
            <div id="byorg">
              <ai:dbtree_new id="orgTree" datamodel="com.ai.secframe.web.orgmodel.SysOrgCodeTreeModel" 
					multiselect="false" height="250" width="250" ishaveline="true" 
					onselect="treeNodeClick"/>
            </div></td>
        </tr>
        <tr>
          <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px">员工列表</td>
                <td align="right" style="height: 20px"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="center"><ai:table tableid="qStaff"
        				
						setname="com.ai.secframe.bo.orgmodel.QSysStaff"
						initial="false" multiselect="true" editable="false"
						tablemodel="com.ai.appframe2.web.tag.ActionDataModel"		
						parametersname="com.ai.secframe.web.orgmodel.SysStaffAction"
						 ondbclick="selectStaff"
						width="250" height="250" needrefresh="true" footdisplay="none">
              <ai:col fieldname="CODE" width="80" editable="true"
							visible="true" />
              <ai:col fieldname="NAME" width="80" editable="true"
							visible="true" />
              <ai:col fieldname="STATE" width="80" editable="true"
							visible="true" />
              <ai:col fieldname="STAFF_ID" width="260" editable="true"
							visible="false" />
              <ai:col fieldname="ORGANIZE_CODE" width="80" editable="true"
							visible="true" />
              <ai:col fieldname="ORGANIZE_NAME" width="140" editable="true"
							visible="true" />
              <ai:col fieldname="ORGANIZE_ID" width="80" editable="true"
							visible="true" />
            </ai:table>
          </td>
        </tr>
      </table></td>
    <td valign="top" style="padding-left:5px;" height="100%"><table  height="100%" width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"  valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px">管理界面</td>
                <td align="right" style="height: 20px"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF"  height="100%" align="left" valign="top"><iframe id="ifr"        
        <%
        
        
        String ipBand = request.getParameter("ipBand");
        if(ipBand==null)
        	ipBand = "";
        String isAuthor = request.getParameter("isAuthor");
        if(isAuthor==null)
        	isAuthor = "";
        
        if(isAuthor.equals("N")){
         %>        
         src="StaffManager.jsp"         
         <%
         } else if(isAuthor.equals("Y")){
          %>
          src="../../sysmgr/author/StationAuthorise.jsp"
          <% } else if(ipBand.equals("Y")) { %>
         src="SysStaffIpmacBandManage.jsp" 
         <%} else { %>  
         src="../../sysmgr/author/RoleAuthorise.jsp"
         <%} %>                
          width="100%" height="100%">
            </iframe>
          </td>
        </tr>
      </table></td>
  </tr>
</table>
<script type="text/javascript">
	var organizeId=-1;
	var cur_orgId = -1;
	var cur_orgName = "";
	//点击参与人显示该参与所包含的操作员
	var qSysStaff = g_TableRowSetManager.get("qStaff");	
	function treeNodeClick(organizeId,organizeName,treeUserObj,treeNodeType){
		if(organizeId==-1) return;
		cur_orgId = organizeId;
		cur_orgName = organizeName;
		qSysStaff.refresh("refresh","organizeId="+organizeId);
	}
	function	refreshStaff(){	
		qSysStaff.refresh("refresh","organizeId="+cur_orgId);
	}
	function selectStaff(){
		var staffId = qSysStaff.getValue(qSysStaff.getRow(),"STAFF_ID");
		cur_orgId = qSysStaff.getValue(qSysStaff.getRow(),"ORGANIZE_ID");
		cur_orgName = qSysStaff.getValue(qSysStaff.getRow(),"ORGANIZE_NAME");
		document.frames[0].init(staffId,cur_orgId);
	}
	function getOrgTree(){
		var dbTree = g_DBTreeNewManager.get("orgTree");
		return dbTree;
	}
	
	function searchStaff(){
	
		var name = document.getElementById("name").value;
		var code = document.getElementById("code").value;
		var bill = document.getElementById("billId").value;
		
		
		var nameCond = "";
		var codeCond = "";
		var billCond="";

		
		var flag = false;
		
		if(name!=null&&name!=""){
			name = encodeURI(name); 
			name = encodeURI(name);
			nameCond = "name="+name;
		}
		
		if(code!=null&&code!=""){
			codeCond = "code="+code;
		}
		
		if(bill!=null&&bill!=""){
			billCond = "billId="+orgName;
		}
		
		
		
		var cond = "";
		if(nameCond!=""){
			cond = cond + nameCond;
			flag=true;
		}
		
		if(codeCond!=""){
			if(flag){
				cond = cond +"&"+ codeCond;
			}else {
				cond = cond +  codeCond;
				flag = true;
			}
		}
		if(billCond!=""){
			if(flag){
				cond = cond +"&"+ billCond;
			}else {
				cond = cond +  billCond;
				flag = true;
			}
		}
		
		
		if(cond==""){
			alert("请输入条件");
			return ;
		}
		qSysStaff.refresh("refresh",cond);
	}
	
	function QueryByOrg(){
		
		document.getElementById("byorg").style.display="block";
		document.getElementById("bycond").style.display="none";
		document.getElementById("byorgbtn").disabled=true;
		document.getElementById("bycondbtn").disabled=false;
	
	}
	function QueryByCond(){
		document.getElementById("byorg").style.display="none";
		document.getElementById("bycond").style.display="block";
		document.getElementById("byorgbtn").disabled=false;
		document.getElementById("bycondbtn").disabled=true;
	}
	document.getElementById("byorgbtn").disabled=true;
	</script>
</body>
</html>