<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<%@ page import="com.ai.appframe2.web.HttpUtil" %>
<%@ page import="com.ai.secframe.service.orgmodel.interfaces.ISysOrganize" %>
<%@ page import="com.ai.secframe.common.Constants" %>
<%@ page import="com.ai.appframe2.service.ServiceFactory" %>
<%
 String org_id=HttpUtil.getParameter(request,"org_id");
 if(org_id==null||org_id.equals(""))
 {
  org_id=String.valueOf(SessionManager.getUser().getOrgId());
 }
 String org_name = ((ISysOrganize) ServiceFactory.getService( Constants.SERVICE_SYS_ORGANIZE )).getSysOrganizeById( Long.parseLong( org_id ) ).getOrganizeName();
%>
<html>
<head>
<title>添加岗位角色页面</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312"></head>

<body>
<table width="100%" border=0 cellpadding=0 cellspacing=0 id="mainTable">
  <tr>
    <td valign="top"  bgcolor="#FFFFFF"><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
          <tr>
            <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
                <tr>
                  <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                  <td style="height: 20px">添加岗位角色</td>
                  <td align="right" style="height: 20px"><input name="Input" type="button" class="btn-2word" value="确定" id="OKBtn" onClick="ok()"/>
                      <input name="Input" type="button" class="btn-2word" value="取消" id="CancelBtn" onClick="cancel()"/>
                  </td>
                </tr>
            </table></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" align="center" valign="top"><table border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td align=center height="100" valign="top"><ai:listbox width="200" id="src_list"
						ds="com.ai.secframe.bo.sysmgr.QStationRoleList"
						initial="false" listsize="26" showtype="list"
						onchange="" />
                  </td>
                  <td align=center width="30" height="100"><input name="Input" type="button" class="btn-2word" value="<<--" id="add1" onClick="delItem()"/>
                      <br>
                      <br>
                      <input name="Input" type="button" class="btn-2word" value="-->>" id="remove1" onClick="addItem()"/>
                  </td>
                  <td align=center height="100" valign="top"><ai:listbox width="200" id="dst_list"
						ds="com.ai.secframe.bo.sysmgr.QStationRoleList"
						initial="false" listsize="26" showtype="list"
						onchange="" />
                  </td>
                </tr>
            </table></td>
          </tr>
      </table></td>
  </tr>
</table>
</body>
</html>
<SCRIPT LANGUAGE="JavaScript" for="window" even="onload">
	var person_party_id = "-1";
	var org_id = <%=org_id %>;
	var org_name = '<%=org_name%>';
	var party_role_id = "-1";
	//当前操作员所在的参与人的权限列表
	var dst_list = g_getListBox("dst_list");
	var src_list = g_getListBox("src_list");
	
    function initData(){

		
		src_list.refresh("condition= state=1");
		var gParam = dialogArguments;
		   	
		   	for(var i=0;i<gParam.length;i++){
		   	    //alert(gParam[i].authororgid);
		   		if(gParam[i].authororgid==org_id){
		   			src_list.delItem(gParam[i].roleid);
		   		}
		  	}
		  	
	}



  	initData();
  	
	var gParam = dialogArguments;

   	//将已经有的岗位去掉
   	for(var i=0;i<gParam.length;i++){
   		src_list.delItem(gParam[i]);
  	}
</script>
<script>




	//保存旧的权限
	var oldAuthorArry = new Array();



	//删除
	function delItem(){
		if(dst_list.getID()==null || dst_list.getID() ==''){
			alert('请先选择一个要删除的岗位角色!');
			return;
		}
		src_list.addItem(dst_list.getID(),dst_list.getValue());
		dst_list.delItem(dst_list.getID());
	}
	//增加
	function addItem(){
		if(src_list.getID()==null || src_list.getID() ==''){
			alert('请先选择要增加的一个岗位角色!');
			return;
		}
		dst_list.addItem(src_list.getID(),src_list.getValue());
		src_list.delItem(src_list.getID());
	}

	//确定
	function ok(){
		
		if(org_id==null || org_id ==''){
			alert("请选择一个组织作为权限来源");
			return false;
		}
		
		if (dst_list.getAllItem().length < 1)
	    {
	      alert("请选择一个岗位角色!");
	      return false;
	    }
	    var result;
	    var org;
		
		dst_list.addItem(org_id,org_name);
		//result[result.length].id = org_id;
		//result[result.length].value = org_name.value;
		result = dst_list.getAllItem();
		
	    window.returnValue = result;
	    window.close();
	}
	//取消
	function cancel()
	{
	    window.returnValue = null;
	    window.close();
	}


	
</script>
