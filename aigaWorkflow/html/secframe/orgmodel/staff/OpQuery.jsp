<!--
/************************************************

  Created Date:
  Project Name:
  Module Name:        操作员查询
  Author:             邢献杰
  Version:            1.1
  begin Version Date: 2007-08
  Last Version Date:  2007-08

************************************************/
-->
<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai"%>
<%@include file="/secframe/common/common.jsp"%>

<html>
<head>								
<%
	String org_id = request.getParameter("org_id");
%>		

<% 
	String isAuthor = request.getParameter("isAuthor");
    
    if(isAuthor==null)
     isAuthor="N";

%>																						
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/CommUtil.js"></script>



</head>
<body onLoad="">
<table width="250" align="center" valign="top">
	<tr>
		<td valign="top">
			<table border=0 cellspacing=0 cellpadding=0 width="240" height="220" id=mainTable class=main_tab>
	  		<tbody  id ="tbodyStaff" style="display:block;">
	   			<tr>
	    			<td align="center" valign=top><br>
	    				<table border=0 cellspacing=0 cellpadding=0>
								<tr>
									<td class="FormTDName" width="100">姓名:</td>
									<td class="FormTD"><input type="text" id="op_name" style="width:100"></td>
			 					</tr>
								<tr>
							    <td  class="FormTDName" width="100">工号:</td>
			   					<td class="FormTD">
			   					<input type="text" id="op_code" style="width:100"></td>
			 					</tr>
			 					
			 					<%if(isAuthor.equals("Y")){ %>
			 					<TR>
			 					<td  class="FormTDName" width="100">手机号(代销商帐号):</td>
			   					<td class="FormTD">
			   					<input type="text" id="mobile" style="width:100"></td>
			 					</tr>
			 					<%} %>
							</table>
	    			</td>
	  			</tr>
	 			</tbody>		
			</table>
		</td></tr>
		<tr><td>	  
      <table border=0 align="center" cellpadding=0 cellspacing=0 id=secTable >
        <tr>
	    		<td  align="center">
	    			<ai:button text="搜  索" id="searchBtn" onclick="searchAction()" style="cursor:hand"></ai:button>
	    		</td>  		
	   		</tr>
			</table>
	</td></tr>
	<tr>
<td valign=top width="240" align="center" >
<fieldset style="width=230">
<legend class="FormZName"> 搜索结果/员工列表</legend>
	<ai:listbox width="230" id="stafflistbox"
		ds="com.ai.secframe.bo.orgmodel.SysOperatorList"
		initial="false" listsize="13" showtype="list"
		onclick="showStaffInfo"/>
</fieldset>
</td>
</tr>
</table>			
<script language="javascript">
//var organize_list = g_getListBox("organize_list");
var stafflistbox = g_getListBox("stafflistbox");
var org_id = <%=org_id%>


function showStaffInfo(person_party_id ,person_name){
		var currentPartyid = g_getListBox("stafflistbox").getID();
		window.parent.stafflistbox = g_getListBox("stafflistbox");
		//alert(currentPartyid);
		window.parent.cur_staffId=currentPartyid;
		window.parent.cur_orgId="";
		window.parent.refreshTab(); 
		
		//var cond = ' STAFF_ID = '+currentPartyid;
		//if(currentPartyid!=null&&currentPartyid!=""){
  	//		window.parent.dbformStaff.refresh(cond);
		//}
		//window.parent.setBtnDisabled(false,true,true,true);
	}
   //选择组织 
	function org_select(){
		/*
		var result = window.showModalDialog("../../sysmgr/authorization/org_select.jsp?party_role_id=" + party_role_id,
			'',"scroll:no;resizable:no;status:no;dialogHeight:450px;dialogWidth:300px");
		//重新装载岗位
		if(result!=null){
			orginize_party_role_id = result.party_role_id;
			document.all("partyRoleName").value = result.party_role_name;
		}
		*/
	}
//查询
function searchAction(){
		var op_name = document.all("op_name").value;
		var op_code =  document.all("op_code").value;
		var mobile = "";
		if("<%=isAuthor%>"=="N"){
		if(op_name.indexOf("%")>-1||op_code.indexOf("%")>-1)
			{
				alert("不允许用%号作为条件");
				return;
			}
		if((op_code==null||op_code=="")&&(op_name==null||op_name=="")){
			alert("员工名称或工号不能都为空");
			return;
		}
		} else {
			mobile = document.all("mobile").value;
		if(op_name.indexOf("%")>-1||op_code.indexOf("%")>-1||mobile.indexOf("%")>-1)
			{
				alert("不允许用%号作为条件");
				return;
			}
		if((op_code==null||op_code=="")&&(op_name==null||op_name=="")&&(mobile==null||mobile=="")){
			alert("员工名称或工号手机号不能都为空");
			return;
		}
		}
		stafflistbox.refresh("name="+op_name+"&code="+op_code+"&mobile="+mobile);
		showStaffInfo();
	}
</script>
</body>

</html>