<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<%@ page import="com.ai.appframe2.web.HttpUtil"%>
<html>
<head>
<title>组织基本信息</title>
</head>
<body>
<%
	String org_id = HttpUtil.getParameter(request, "org_id");
%>

<ai:table tableid="relateTable"
						setname="com.ai.secframe.bo.orgmodel.QSysOrgDistrictRelate"
						initial="false" multiselect="true" editable="false"
						tablemodel="com.ai.appframe2.web.datamodel.QueryModelForService"
						implservice_name="com.ai.secframe.service.orgmodel.SysOrganize"
						implservice_querymethod="queryQSysOrgDistrictRelate"						
						width="680" height="400" needrefresh="true" footdisplay="none">
                    <ai:col fieldname="DISTRICT_ID" width="80" editable="true"
							visible="true" />
                    <ai:col fieldname="DISTRICT_NAME" width="120" editable="true"
							visible="true" />
                    <ai:col fieldname="REGION_ID" width="100" editable="true"
							visible="false" />
                    <ai:col fieldname="DISTRICT_TYPE_ID" width="180" editable="true"
							visible="true" />
                    <ai:col fieldname="PARENT_DISTRICT_ID" width="140" editable="true"
							visible="true" />
                    
                  </ai:table>
                  <div align="center">
                  <input name="Input" type="button" class="btn-2word" value="添加" id="selectDis" onClick="selectDis()"/>
                  <input name="" type="button" class="btn-2word" value="删除" id="delBtn" onClick="del()"/>
                  <div>
</body>
</html><script>
  	var org_id = "<%=org_id%>";
  	var relateTable = g_TableRowSetManager.get("relateTable");	
  
	function refresh_Org_Form(org_id)
	{
     	if(org_id!=""){
     		relateTable.refresh(org_id);
     	}
	}
	refresh_Org_Form(org_id);
	

	
	function selectDis(){
		var result = window.showModalDialog("<%=request.getContextPath()%>/secframe/sysmgr/common/DistrictSelectDialog.jsp","org","scroll:no;resizable:no;status:no;dialogHeight:460px;dialogWidth:300px");
		if(result=='undefined'||result==null){
			result="";
		}else {
			result = result.split('&');
			//partyRoleOrg_formRowSet.setValue("DISTRICT_ID",result[0]);	 
			
			//alert(result[1].split('|')[0]);
			//partyRoleOrg_formRowSet.setValue("COUNTY_ID",result[1]);	
			//TODO 保存到数据库 
			var msg = PostInfo("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysOrganizeAction?"+
					"action=saveOrgDistrict&dis_ids="+result[1].split('|')[0]+"&flag=A&org_id="+org_id);
			var result = msg.getValueByName("retVal"); 
			if(result!='0'){
				alert(result);
			}
			refresh_Org_Form(org_id);
		}
	}
	
	function del(){	
	 if( relateTable.getSelectedRows()!=null&&relateTable.getSelectedRows().length>0){
	 		
	  		var selRows = relateTable.getSelectedRows();
	  		var ids="";
	  		for(var i=0;i<selRows.length;i++)
	  		{
	  			ids= relateTable.getValue(selRows[i],"DISTRICT_ID") + "," + ids;
	  		}
	  		if(!confirm("确实要删除"+ selRows.length + "条吗？"))return;
	  		ids = ids.substr(0,ids.length-1);
			var msg = PostInfo("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysOrganizeAction?"+
					"action=saveOrgDistrict&dis_ids="+ids+"&flag=D&org_id="+org_id);
			var result = msg.getValueByName("retVal"); 

			if(result!='0'){
				alert(result);
			}
			refresh_Org_Form(org_id);
	 }
	 else
	 {
	  alert("请选择！");
	 }
	}
</script>
