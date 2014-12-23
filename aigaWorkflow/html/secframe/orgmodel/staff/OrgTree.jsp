<!--
/************************************************

  Created Date:
  Project Name:
  Module Name:        组织树
  Author:             邢献杰
  Version:            1.1
  begin Version Date: 2007-07
  Last Version Date:  2007-07

************************************************/
-->
<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai" %>
<%@include file="/secframe/common/common.jsp"%>

<table border=0 width=250 align="center" >
<tr><td width="240">
<ai:dbtree_new id="party" datamodel="com.ai.secframe.web.orgmodel.SysOrgCodeTreeModel" 
	multiselect="false" height="250" width="250" ishaveline="true" 
	onselect="treeNodeClick"/>
</td></tr>
<tr>
<td valign=top width="240" >
<fieldset style="width:240">
<legend class="FormZName"> 搜索结果/员工列表</legend>
	<ai:listbox width="230" id="stafflistbox"
		ds="com.ai.secframe.bo.orgmodel.SysOperatorWithOrgList"
		initial="false" listsize="13" showtype="list"
		 onclick="showOperatorInfo"/>
</fieldset>
</td></tr>
</table>

<script>
    var node_org_id=-1;
	//点击参与人显示该参与所包含的操作员
	function treeNodeClick(treeVal,treeText,treeUserObj,treeNodeType){
		if(treeVal==-1) return;
		refreshStaffListBox(treeVal,treeUserObj);
		window.parent.cur_orgName=treeText;
	}	
	
	function refreshStaffListBox(org_id,treeObject){
		var stafflistbox = g_getListBox("stafflistbox");
		stafflistbox.refresh("org_id="+org_id);
		partyid		=	treeObject;
		node_org_id=org_id;
		showOperatorInfo(org_id);
	}
	function showOperatorInfo(org_id){
	//alert(org_id);
	    if(node_org_id!=-1) org_id=node_org_id;
		var currentPartyid = g_getListBox("stafflistbox").getID();
		window.parent.stafflistbox = g_getListBox("stafflistbox");
		
		window.parent.cur_staffId=currentPartyid;
		window.parent.cur_orgId=org_id;
		
		//alert(currentPartyid+'|'+org_id);
        window.parent.refreshTab(); 

	}
	
	function getPartyTreeObject(){
		var dbTree = g_DBTreeNewManager.get("party");
		return dbTree;
	}
	function refreshCurStaff()
	{
	 var stafflistbox = g_getListBox("stafflistbox");
	 stafflistbox.refresh("org_id="+node_org_id);
	 
	}
</script>
