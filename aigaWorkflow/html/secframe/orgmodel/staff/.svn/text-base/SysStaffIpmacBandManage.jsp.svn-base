<%@ page contentType="text/html; charset=gb2312"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai"%>
<%@include file="/secframe/common/common.jsp"%>
<%
	String staff_id = request.getParameter("staff_id");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>员工IP绑定关系</title>
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
  <tr>
    <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
        <tr>
          <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
          <td style="height: 20px">操作部分</td>
          <td align="right" style="height: 20px"></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" align="left" height="150" valign="top"><ai:dbform formid="sysBand" onvalchange="onvaluechange"
					setname="com.ai.secframe.bo.orgmodel.SysStaffIpmacBand"
					datamodel="com.ai.appframe2.web.datamodel.QueryModelForService"
					implservice_name="com.ai.secframe.service.orgmodel.interfaces.SysStaffIpmacBand"
					implservice_querymethod="querySysStaffIpmacBand" 
					initial="false" editable="false">
      <ai:dbformfield formid="sysBand" fieldname="STAFF_ID"
								width="150" height="20" editable="true" visible="false" />
      <ai:dbformfield formid="sysBand" fieldname="SYS_STAFF_IPMAC_BAND_ID"
								width="150" height="20" editable="true" visible="false" />
      <table width="100%"  height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr heigth=30>
          <td><table width="100%" border="0" height="120"  cellpadding="0" cellspacing="0">
              <tr>
                <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1" id="ipbegintd">IP地址</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack" colspan="5"><ai:dbformfield formid="sysBand" fieldname="IP"
								width="200" height="20" editable="true" visible="true" />
                <span class="pr9">*</span> </td>
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
                <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1" id="ipendtd">MAC地址</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack" colspan="5"><ai:dbformfield formid="sysBand" fieldname="MAC"
								width="200" height="20" editable="true" visible="true" />
                <span class="pr9">*</span> </td>
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
                <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">绑定类型</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack" colspan="5"><ai:dbformfield formid="sysBand" fieldname="BAND_TYPE"
								width="200" height="20" editable="true" visible="true" />
                <span class="pr9">*</span> </td>
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
			    <tr bgcolor="#E1EDFA">
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
          <td align="center" valign="middle" height="35"><input name="" type="button" class="btn-2word" value="添加" id="addBtn" onClick="add()"/>
            &nbsp;
            <input name="" type="button" class="btn-2word" value="编辑" id="editBtn" onClick="update()"/>
            &nbsp;
            <input name="" type="button" class="btn-2word" value="保存" id="saveBtn" onClick="save()"/>
            &nbsp;
            <input name="" type="button" class="btn-2word" value="删除" id="delBtn" onClick="del()"/>
          </td>
        <tr>
      </table></ai:dbform></td>
  </tr>
  <tr>
    <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
        <tr>
          <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
          <td style="height: 20px">绑定列表</td>
          <td align="right" style="height: 20px"></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" align="center"><ai:table tableid="sysBandTable"
							setname="com.ai.secframe.bo.orgmodel.SysStaffIpmacBand"
							initial="false" multiselect="true" editable="false"
							tablemodel="com.ai.appframe2.web.datamodel.QueryModelForService"
							implservice_name="com.ai.secframe.service.orgmodel.interfaces.SysStaffIpmacBand"
							implservice_querymethod="querySysStaffIpmacBand"
							implservice_countmethod="querySysStaffIpmacBandCount" width="620"
							height="150" needrefresh="true">
        <ai:col fieldname="SYS_STAFF_IPMAC_BAND_ID" width="150" editable="false"
								visible="false" />
        <ai:col fieldname="STAFF_ID" width="150" editable="false"
								visible="true" />
        <ai:col fieldname="IP" width="150" editable="false"
								visible="true"/>
        <ai:col fieldname="MAC" width="150" editable="false"
								visible="true" />
        <ai:col fieldname="BAND_TYPE" width="150" editable="false"
								visible="true"/>
      </ai:table>
    </td>
  </tr>
</table>
</body>
<script type="text/javascript">
	var staff_id = "<%=staff_id%>";		
	var sysForm = g_FormRowSetManager.get("sysBand");
	var sysTable = g_TableRowSetManager.get("sysBandTable");	
	function init(staffId,orgId){
		staff_id = staffId;
		initLoad();
	}
	function isIP(strIP){
		var re=/^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$/;
		if(re.test(strIP))
		{
			return true;
		}
		return false;
	}
	function save(){
		sysForm.setValue("STAFF_ID",staff_id);
		
		if(sysForm.getValue("BAND_TYPE")=='1'||sysForm.getValue("BAND_TYPE")=='3'){
		
			if(sysForm.getValue("IP")==null||sysForm.getValue("IP")==""){
				alert('请输入IP!');
				sysForm.setFocus("IP");
				return;
			}
		}
		if(isIP(sysForm.getValue("IP"))!=''||isIP(sysForm.getValue("IP"))==null){
			if(!isIP(sysForm.getValue("IP"))){
				alert('IP格式不正确!');
				sysForm.setFocus("IP");
				return;
			}
		}
		if(sysForm.getValue("BAND_TYPE")=='2'||sysForm.getValue("BAND_TYPE")=='3'){
			if(sysForm.getValue("MAC")==null||sysForm.getValue("MAC")==""){
				alert('请输入MAC!');
				sysForm.setFocus("MAC");
				return;
			}
		}
		
		if(sysForm.getValue("BAND_TYPE")!='4' && sysForm.getValue("BAND_TYPE")!='5'){
		var reg=/^[A-Fa-f0-9]{2}(-[A-Fa-f0-9]{2}){5}$/; 
		
		if(!reg.test(sysForm.getValue("MAC"))){
					alert('MAC格式不对!');
					sysForm.setFocus("MAC");
					return;
		}
		}
		else{
		if(!isIP(sysForm.getValue("IP"))){
				alert('IP格式不正确!');
				sysForm.setFocus("IP");
				return;
			}
		if(!isIP(sysForm.getValue("MAC"))){
				alert('IP格式不正确!');
				sysForm.setFocus("MAC");
				return;
			}
		}
	
		if(sysForm.getValue("BAND_TYPE")=="")
		{
			alert("请选择绑定类型!");
			sysForm.setFocus("BAND_TYPE");
			return;
		}
		
	
	    if(sysForm.toXmlString(true)==""){
				alert('当前的数据尚未被修改，不需要保存！');
				return;
		}    
		
		if(sysForm.getValue("IP")!=null||sysForm.getValue("IP")!=""){
			for(var i=0;i<sysTable.count();i++){
		  		if(sysForm.getValue("IP") == sysTable.getValue(i,"IP")){
		  			if(sysForm.getValue("MAC")==sysTable.getValue(i,"MAC")){
		  				alert("绑定信息重复");
		  				return;
		  			}
		  		}	  		
		  	}	
		}
		
	    var list = new Array();
	    list.push(sysForm);   
	    var msg = 
	    saveRowSet("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysStaffIpmacBandAction?action=saveSysStaffIpmacBand"
	    ,list,false ,false);
	    var ret = msg.getValueByName("retVal");
	    if(ret=="-1")
		{
			alert("操作失败");
		}else{
			alert("操作成功");
			sysTable.refresh("state=1 and staff_id="+staff_id);	  
			sysForm.setEditSts(false);	
			sysForm.refresh("staff_id=-2");
		}
			
	}
	
	function onvaluechange(pFieldName,pOldVal,pNewVal,DBFormPK){
		if(pFieldName=='BAND_TYPE'){
			if(pNewVal=='4' || pNewVal=='5'){//网段
				document.getElementById("ipbegintd").innerText="开始IP";
				document.getElementById("ipendtd").innerText="结束IP";
			} else {
				document.getElementById("ipbegintd").innerText="IP地址";
				document.getElementById("ipendtd").innerText="MAC地址";
			}
		}
		
	}
	function add(){
		if(staff_id=='null'){
			alert("请先选择员工");
			return;
		}
		sysForm.setEditSts(true);
		sysForm.refresh("staff_id=-2");
	}
	function update(){
		if( sysTable.getSelectedRows()!=null&&sysTable.getSelectedRows().length>0){	
			sysForm.setEditSts(true);
			sysForm.refresh("SYS_STAFF_IPMAC_BAND_ID="+sysTable.getValue(sysTable.getSelectedRows()[0],"SYS_STAFF_IPMAC_BAND_ID"));
		 }
		 else
		 {
		  alert("请选择！");
		 }
	}
	function addBatchBand(){
	
 		var result = window.showModalDialog("AddIPband.jsp","org","scroll:no;resizable:no;status:no;dialogHeight:900px;dialogWidth:750px");
 	
 	}
	function del(){	
	 if( sysTable.getSelectedRows()!=null&&sysTable.getSelectedRows().length>0){
	 		
	  		var selRows = sysTable.getSelectedRows();
	  		var ids="";
	  		for(var i=0;i<selRows.length;i++)
	  		{
	  			ids= sysTable.getValue(selRows[i],"SYS_STAFF_IPMAC_BAND_ID") + "," + ids;
	  		}
	  		if(!confirm("确实要删除"+ selRows.length + "条吗？"))return;
	  		ids = ids.substr(0,ids.length-1);
			var msg = PostInfo("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysStaffIpmacBandAction?"+
				"action=deleteSysStaffIpmacBand&ids="+ids);
			var result = msg.getValueByName("retVal"); 
			if(result=="1"){
				 alert("删除成功！");
				 initLoad();
			}else{
				alert("删除失败！");
			}	
	 }
	 else
	 {
	  alert("请选择！");
	 }
	}
	function initLoad()
	{  	
			sysForm.setEditSts(false);
			sysForm.refresh("staff_id=-2");
			if(staff_id!=null&&staff_id!=""){			
	  			sysTable.refresh("state=1 and staff_id="+staff_id);	  			
			} 
	} 
	initLoad();
</script>
</html>