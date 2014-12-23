<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai"%>
<%@include file="/secframe/common/common.jsp"%>
<% 
	String org_id = String.valueOf(com.ai.appframe2.common.SessionManager.getUser().getOrgId());
	if(null==org_id||org_id.equals(""))
		request.setAttribute("org_id","-1");	
	else 
		request.setAttribute("org_id",org_id);	
%>
<HTML>
<head>
<title>组织管理</title>
</head>
<body>
<table width="98%" border='0' align="center" valign="top"
			cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top" width="" align="center"><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px">转出组织</td>
                <td align="right" style="height: 20px"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="left" style="padding-left:5px;" height="250" valign="top"><div id="byorg">
              <ai:dbtree_new id="partytree"
							datamodel="com.ai.secframe.web.orgmodel.SysOrgCodeTreeModel"
							multiselect="false" height="500" width="100%" ishaveline="true"
							onselect="treeNodeClick" />
            </div></td>
        </tr>
      </table></td>
    <td valign="top" width="" style="padding-left:8px;" align="center"><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px">转入组织</td>
                <td align="right" style="height: 20px"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="left" style="padding-left:5px;" height="250" valign="top"><div id="byorg">
              <ai:dbtree_new id="partytree1"
							datamodel="com.ai.secframe.web.orgmodel.SysOrgCodeTreeModel"
							multiselect="false" height="500" width="100%" ishaveline="true"
							onselect="treeNodeClick1" />
            </div></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td align="center" colspan="2" bgcolor="#FFFFFF" height="30"><input onClick="ok()" type="button" class="btn-6word" value="点击开始转移"></td>
  </tr>
</table>
</html><script>
	var cur_partyRoleId = "";//转出
	var cur_partyRoleId1 = "";//转入

	var dbTree = g_DBTreeNewManager.get("partytree");
	var dbTree1 = g_DBTreeNewManager.get("partytree1");		

	//右键菜单刷新
	function refreshOrg(){
		dbTree.refresh(cur_partyRoleId ,1);
		dbTree1.refresh(cur_partyRoleId1 ,1);
	}

	//刷新树的某个节点
	function refreshTreeNode(party_role_id){
		dbTree.refresh(party_role_id ,1);
		dbTree1.refresh(party_role_id1 ,1);
	}
    //刷新当前树节点
    function refreshCurNode()
    {
     dbTree1.refresh(cur_partyRoleId1 ,1);
    }

	//刷新树的某个节点的父节点
	function refreshParentTreeNode(org_id){	    
	    var objCurParNode=dbTree.getParentNodeInfo(org_id);
	    //alert(org_id);
	    if(objCurParNode!=null&&objCurParNode.value>0)
	    {
		 var parent_value = objCurParNode.value;		 
		 dbTree.refresh(parent_value ,1);
		}		
	}
	
	function getParentNode(org_id){
		var objCurParNode=dbTree.getParentNodeInfo(org_id);
	    //alert(org_id);
	    if(objCurParNode!=null&&objCurParNode.value>0)
	    {
		 var parent_value = objCurParNode.value;		 
			return parent_value;
		}	
	}
	

	function ok(){
		var oldParent = 0;
  		if(cur_partyRoleId!=""&&cur_partyRoleId1!=""){
  			oldParent = getParentNode(cur_partyRoleId);
			var msg = PostInfo("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysOrganizeAction?"+
				"action=moveOrg&mudi_id="+cur_partyRoleId1+"&zy_id="+cur_partyRoleId);
			var result = msg.getValueByName("retVal");			
			if(result=="-1"){
				alert("转移失败！"+msg.getValueByName("errorMsg"));
			}else{
				alert("转移成功！");
				refreshParentTreeNode(cur_partyRoleId);
				refreshCurNode();
				dbTree1.refresh(oldParent ,1);
				parent.refreshTreeNode(oldParent);
				parent.refreshTreeNode(cur_partyRoleId1);
			}	
		} else {
			alert("请选择转入转出组织");
		}
	}

	//点击参与人显示该参与所包含的操作员
	function treeNodeClick(treeVal,treeText,treeUserObj,treeNodeType){
		cur_partyRoleId = treeVal;
		cur_partyName = treeText;
		cur_partyId = treeUserObj;
		//window.frames("tab1_tab_orginfo").location="OrgDetail.jsp?org_id="+treeVal;
		//window.frames("tab1_tab_staff").location="StaffsOfOrg.jsp?org_id="+treeVal;
		
		//setTabItemByItemIdx("tab1",getCurrentTabFocusItem("tab1"));
	}
	
	//点击参与人显示该参与所包含的操作员
	function treeNodeClick1(treeVal,treeText,treeUserObj,treeNodeType){
		cur_partyRoleId1 = treeVal;
		cur_partyName1 = treeText;
		cur_partyId1 = treeUserObj;
		//window.frames("tab1_tab_orginfo").location="OrgDetail.jsp?org_id="+treeVal;
		//window.frames("tab1_tab_staff").location="StaffsOfOrg.jsp?org_id="+treeVal;
		
	}
	



</script>
