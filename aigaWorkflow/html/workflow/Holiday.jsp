<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai" %>
<%@ include file="/workflow/workflow_css.jsp"%>
<%@ include file="/webframe/common/commonhead.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/jsv2/AppFrameCss.jsp" type="text/css">

<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/TableRowSet.js"></script>

<html>
<head>
  <title>�ڼ���ά��</title>
</head>


<table align="center" border="0">

<tr><td align="center" colspan="2">
    <table width="100%" align="center">

		  <tr><td align="center">
		    <ai:table  tableid="Holiday" setname="com.ai.comframe.console.BOVmHoliday"
			    tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
			    implservice_name="com.ai.comframe.console.WorkflowConsole"
			    implservice_querymethod="getHolidayValue()"
			    needrefresh="true" multiselect="true" editable="false"  
			    rowheight="-1" initial="true" width="400" height="400" footdisplay="none" rowsequence="true">
			    <ai:col fieldname="HOLIDAY" width="200" title="�ڼ���" visible="true"/>
				</ai:table>
		  </td></tr>
		  <tr><td align="center">
		  <ai:button id="btnAdd" text="��  ѯ" onclick="qryHoliday()"/>
		  <ai:button id="btnAdd" text="��  ��" onclick="add()"/>
		  <ai:button id="btnEdit" text="ɾ  ��" onclick="dele()"/>
		  <ai:button id="btnSave" text="��  ��" onclick="save()"/>
		  </td></tr>
		  
	  </table>
	  
</td></tr>
</table>

<script language="javascript">


function getHolidayTable(){
	 return g_TableRowSetManager.get("Holiday");
}


function qryHoliday(){


		getHolidayTable().refresh();
		 if(getHolidayTable().count() == 0){
	    	alert("δ�鵽����!");
	 	 }
 	 
 	 
}
function save(){
  if(!confirm("ȷ�ϱ���?")){
	  return;
	}
	var grid=getHolidayTable();
	if (grid.getTotalRowCount()>0){
		for (var i=0;i<grid.getTotalRowCount();i++)
		{
			if(grid.getValue(i,"HOLIDAY")==""){
				alert("���ڲ���Ϊ��");
				return;
			}
		}
	}
	var list = new Array(); 
	list.push(getHolidayTable());
	var url = _gModuleName+"/business/com.ai.comframe.console.action.WorkflowAction?action=saveHolidayConfig";
	var rtn=saveRowSet(url,list,false,false);
	getHolidayTable().setEditSts(false);
	qryHoliday();
	alert("��ע���������������������!");
}
function add(){
	getHolidayTable().newRow();
	edit();
}
function edit(){
	getHolidayTable().setEditSts(true);
}

function dele(){
	var HolidayGird=getHolidayTable();
  var selectedRows=HolidayGird.getSelectedRows();
	if(selectedRows.length == 0){
    alert("��ѡ��Ҫɾ���ļ�¼");
    return;
  }
	if(!confirm("ȷ��ɾ��?")){
	  return;
	}
	for (var i=selectedRows.length-1;i>=0;i--){
	  HolidayGird.deleteRow(selectedRows[i]);
	}
}
function clear(){
	var HolidayGird=getHolidayTable();
		for (var i=HolidayGird.getTotalRowCount()-1;i>=0;i--){
			HolidayGird.deleteRow(i);
		}
}
</script>