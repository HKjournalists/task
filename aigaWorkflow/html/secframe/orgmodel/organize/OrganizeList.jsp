<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai"%>
<%@include file="/secframe/common/common.jsp"%>
<%@ page import="com.ai.appframe2.web.HttpUtil" %>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/PopMenu_v2.js"></script>
<%	
	String isMgrStation=HttpUtil.getParameter(request, "isMgrStation");	
    if(isMgrStation==null||isMgrStation.equals("")) {
     	isMgrStation="N";
     }
     String isDistrict=HttpUtil.getParameter(request, "isDistrict");	
    if(isDistrict==null||isDistrict.equals("")) {
     	isDistrict="N";
     }
%>
<HTML>
<head>
<title>��֯����</title>
<script>
			var organizeId =""; //��ǰ�ڵ����֯ID
			var organizeName = "";	 //��ǰ��֯������
			var is_mgrStation='<%= isMgrStation%>';					
			function refreshItemPara(item_id){
		    if(organizeId==-1) return "";    
				if(item_id =="tab_orginfo" ){
					return "isMgrStation="+is_mgrStation+"&org_id=" + organizeId;
				}else if(item_id =="tab_station"){
		        	return "org_name=" + encodeURI(encodeURI(organizeName)) + "&org_id=" + organizeId;
				}else if(item_id =="tab_orgdistrict"){
				return "org_id=" + organizeId;
				}
			}
		</script>
</head>
<body onLoad="doResize()" onResize="doResize()">
<table width="98%" border='0' align="center" valign="top"
			cellpadding="0" cellspacing="0">
  <tr>
    <td colspan=4 height=5></td>
  </tr>
  <tr>
    <td valign="top" width="" align="center">
	<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px">��֯ѡ��</td>
                <td align="right" style="height: 20px"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="left" style="padding-left:5px;" height="250" valign="top">
            <div id="byorg">
              <ai:dbtree_new id="orgTree"
							datamodel="com.ai.secframe.web.orgmodel.SysOrgCodeTreeModel"
							multiselect="false" height="525" width="100%" ishaveline="true"
							onselect="treeNodeClick"/>
            </div></td>
        </tr>


      </table>
</td>
    <td width=4>&nbsp;</td>
    <td valign="top" width=750 align="center"><ai:tab width="740" height="534" id="tab1"
						getParameter="refreshItemPara">
        <%if (isMgrStation.equals("N")&&isDistrict.equals("N")){ %>
        <ai:tabitem title="��֯��Ϣ" id="tab_orginfo" src="OrgDetail.jsp"
							initial="true" />
        <%}else if(isDistrict.equals("N")){ %>
        <ai:tabitem title="������λ" id="tab_station" initial="true"  src='<%=request.getContextPath() + "/secframe/sysmgr/station/StationList.jsp"%>' />
        <% } else {%>
         <ai:tabitem title="������չ��Ϣ" id="tab_orgdistrict" src="OrgDistrict.jsp"
							initial="true" />
        <% } %>
      </ai:tab>
    </td>
  </tr>
</table>
</body>
</html><script>

	
	var dbTree = g_DBTreeNewManager.get("orgTree");
	
	//����partyRoleIdɾ����֯
	function delOrgByRoleId(roleId){		
		if(dbTree.hasChildNode(roleId)){
			alert('�Բ��𣬸���֯����������֯������ɾ��!');
			return;
		}		
		var org_name = dbTree.getNodeInfo(roleId).text;		
		if(!confirm("ȷʵҪɾ�� '"+ org_name + "' ��"))return;
		var msg = PostInfo("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysOrganizeAction?"+
			"action=deleteOrganize&org_id="+roleId);
      
    	var result = msg.getValueByName('MESSAGE');
		if(result=='1'){
  			alert('ɾ���ɹ���');
			var parent_value = dbTree.getParentNodeInfo(roleId).value;
			dbTree.refresh(parent_value ,1);
			dbTree.setNodeSelect(parent_value);
		}else if(result=='-1'){
			alert('ɾ��ʧ��!');
		}else {
     		alert(result);
    	}
	}

	//�Ҽ��˵�ˢ��
	function refreshOrg(){
		dbTree.refresh(organizeId ,1);
	}

	//ˢ������ĳ���ڵ�
	function refreshTreeNode(organizeId){
		dbTree.refresh(organizeId ,1);
	}
    //ˢ�µ�ǰ���ڵ�
    function refreshCurNode()
    {
     dbTree.refresh(organizeId ,1);
    }

	//ˢ������ĳ���ڵ�ĸ��ڵ�
	function refreshParentTreeNode(org_id,org_name){
	    
	    var objCurParNode=dbTree.getParentNodeInfo(org_id);
	    //alert(org_id);
	    if(objCurParNode!=null&&objCurParNode.value>0)
	    {
		 var parent_value = objCurParNode.value;		 
		 dbTree.refresh(parent_value ,1);
		}
		if(objCurParNode.value==-1)
		  dbTree.setCurNodeInfo(org_id,org_name,org_id);
	}


	//�����������ʾ�ò����������Ĳ���Ա
	function treeNodeClick(treeVal,treeText,treeUserObj,treeNodeType){
		//if(treeVal==-1) return;

		organizeId = treeVal;
		organizeName = treeText;

		setTabItemByItemIdx("tab1",getCurrentTabFocusItem("tab1"));
	}

    //�����ؼ���С����Ӧ����
	function doResize(){
		var width = document.body.offsetWidth;
		var height = document.body.offsetHeight;

	}

</script>
