<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai" %>
<%@ include file="/workflow/workflow_css.jsp"%>
<%@ include file="/webframe/common/commonhead.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/jsv2/AppFrameCss.jsp" type="text/css">

<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/TableRowSet.js"></script>

<html>
<head>
  <title>节假日维护</title>
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
			    <ai:col fieldname="HOLIDAY" width="200" title="节假日" visible="true"/>
				</ai:table>
		  </td></tr>
		  <tr><td align="center">
		  <ai:button id="btnAdd" text="查  询" onclick="qryHoliday()"/>
		  <ai:button id="btnAdd" text="新  增" onclick="add()"/>
		  <ai:button id="btnEdit" text="删  除" onclick="dele()"/>
		  <ai:button id="btnSave" text="保  存" onclick="save()"/>
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
	    	alert("未查到数据!");
	 	 }
 	 
 	 
}
function save(){
  if(!confirm("确认保存?")){
	  return;
	}
	var grid=getHolidayTable();
	if (grid.getTotalRowCount()>0){
		for (var i=0;i<grid.getTotalRowCount();i++)
		{
			if(grid.getValue(i,"HOLIDAY")==""){
				alert("日期不能为空");
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
	alert("请注意清理各服务器缓存数据!");
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
    alert("请选择要删除的记录");
    return;
  }
	if(!confirm("确认删除?")){
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