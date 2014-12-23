<%@page contentType="text/html; charset=GBK"%>
<%@include file="/csc/common/taglib.jsp"%>

<%
		//type就是roleCode
		String roleCode = request.getParameter("type");
		String cur_userId = request.getParameter("cur_userId");
		String projectCode = request.getParameter("projectCode");
		String parentOrgId = request.getParameter("parentOrgId");
		String msg = request.getParameter("chooseType");
		if(msg != null) {
			msg = new String(msg.getBytes("ISO-8859-1"),"GBK");
		}
		//控制 初始化 展开层级！
		String deepCnt = request.getParameter("deepCnt");
		
		request.setAttribute("roleCode",roleCode);
		request.setAttribute("cur_userId",cur_userId);
		if("undefined".equals(projectCode))
			request.setAttribute("projectCode","");
		else
			request.setAttribute("projectCode",projectCode);
		if("undefined".equals(parentOrgId))
			request.setAttribute("parentOrgId","0");
		else
			request.setAttribute("parentOrgId",parentOrgId);	
		
		request.setAttribute("roleOrgId",2);
%>

<html>
  <head>
  	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/easyui/themes/icon.css">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/jquery.easyui.min.js"></script>
  	<title>选择人员</title>
  </head>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/csc/common/css/aialm_style_css.jsp" type="text/css">
  
  <body>
	<div id="proviceAppraiseDiv" class="div_title">
		<table align="center" width="100%">
			<tr>
				<td width="45%">
					<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
				         <tr>
				             <td bgcolor="#FFFFFF" align="left" style="padding-left:10px;">
					            <ai:dbtree_new id="staffTree" datamodel="com.asiainfo.csc.common.web.TreeStaffSelect" 
					            	multiselect="false" height="200" width="100%" ishaveline="true"
					                onselect="displayStaffs"  ondblclick="displayStaffs" />
				             </td>
				         </tr>
	      			 </table>
      			 </td>
      			 <td style="padding-top: 6px;">
					<ai:stable tableid="staffTable" setname="com.asiainfo.csc.common.web.SETStaffTable"
						 invoke_type="service" initial="false" footdisplay="none"
                         invoke_name="com.asiainfo.csc.common.service.StaffTableSV" 
                         invoke_querymethod="queryStaffsByName(String staffIds,String roleCode,String name)"
                         editable="false" needrefresh="true" multiselect="false"
                         width="100%" height="185" rowheight="-1" pagesize="100" rowsequence="true"
                         ondbclick="" oncontextmenu="">
                       	<ai:col fieldname="STAFF_ID"  editable="false" width="200" visible="false"/>
						<ai:col fieldname="PARENT_ORGANIZE_ID" editable="false" width="200" visible="false" />
						<ai:col fieldname="ORGANIZE_ID" 	editable="false" width="200" visible="false" />
						<ai:col fieldname="STAFF_CODE" 		editable="false" width="80" visible="true" />
						<ai:col fieldname="EMPLOYEE_NAME"  	editable="false" width="80" visible="true"/>
						<ai:col fieldname="ORGANIZE_NAME"  	editable="false" width="120" visible="true"/>
						<ai:col fieldname="BILL_ID" 		editable="false" width="120" visible="false" />
	               </ai:stable>
				</td>
			</tr>
		</table>
	</div>
	<table style="margin-top: 3px;" id="resTable">
		<tr>
			<td align="right" valign="top" class="title_e" style="line-height:20px;width:70px;">意见/备注：</td>
			<td>
				<textarea id="resTextarea" class="dbform_textarea_style" style="width: 450px; height: 50px; display: inline; overflow-x: auto; overflow-y: auto;"></textarea>
			</td>
		</tr>
	</table>
	<div id="tip" style="position:absolute;display:none;border:1px;border-style:solid;width: 100px;height: 10px">
			<table id="tipTable"  bgcolor="#ffffee" width="100%" height="100%" style="font-weight: normal;">
				<tr><td align="left"><font style="color: red">处理人搜索框<br/></font></td>
				</tr>
			</table>
		</div>
		<table width="100%" align="center">
			<tr>
				<td align="center">
		    		<input name="" type="button"  class="bigBtn" value="确认" id="clear"  onclick="selectStaff()"/>
					<input name="" type="button"  class="bigBtn" value="取消" id="cancel" onClick="clearData()"/>
				</td>
			</tr>
		</table>
  </body>
  
  <script language="JavaScript" src="/jsv2/DBTree_new.js"></script>
  <script>
  var unfoldCount = 0;
  var staffTable = g_TableRowSetManager.get("staffTable");
  var staffTree = g_DBTreeNewManager.get("staffTree");
  
  initStaff();
  
  function selectStaff()
  {
	  var staffId = 0;
	  var curRow = staffTable.getRow();
	  staffId = staffTable.getValue(staffTable.getRow(),"STAFF_ID");
	  var emp_name = staffTable.getValue(staffTable.getRow(),"EMPLOYEE_NAME");
	  var staff_code = staffTable.getValue(staffTable.getRow(),"STAFF_CODE");
	  var organize_id = staffTable.getValue(staffTable.getRow(),"ORGANIZE_ID");
	  var resTextarea = document.getElementById("resTextarea").value;
	  if(emp_name.length==0){
	  	$.messager.alert('操作提示',"请先选择下一环节处理人",'error');
	  	return;
	  }else {
	  	  if(resTextarea.length == 0 && "<%=msg%>" != "") {
	  	  	$.messager.alert('操作提示',"请填写意见/备注",'error');
	  	  	return;
	  	  }
		  var returnData=new Array();     
	      returnData[0]=staffId;
	      returnData[1]=emp_name;
	      returnData[2]=staff_code;
	      returnData[3]=organize_id;
	      returnData[4]=resTextarea;
		  window.returnValue = returnData;
		  window.close();
	  }
  }


  function initStaff()
  {
	  staffTree.refresh(null,-1);
	  //expandNode("-1");
	  if("" == "<%=msg%>") {
	  	$('#resTable').hide();
	  }
	  $('#resTextarea').val('<%=msg%>');
  }

  function expandNode(parentVal)
  {
  	  unfoldCount = unfoldCount + 1;
	  //展开 层级 自定义！
	  if("<%=deepCnt%>"!=null && "<%=deepCnt%>"!="")
	  {
	  	  if(unfoldCount >= "<%=deepCnt%>")
		   	  return;
	  }
	
	  var allNodes = staffTree.getChildrenNodesInfo(parentVal);
	  for(var k=0; k<allNodes.length; k++)
	  {	
		  if(allNodes[k].userobj=='-1')
		  {
			  staffTree.expandNodeByValue(allNodes[k].value,true);
			  expandNode(allNodes[k].value);
		  }
	  }
  }


  function displayStaffs(nodeVal,nodeText,nodeUserObj,nodeType) 
  {
	  if(nodeUserObj==null ||nodeUserObj=="")
	  	  return;
	
	  if(nodeUserObj=="-1")
		  return;
		  
	  //alert("nodeVal--"+nodeVal+"nodeText--"+nodeText+"nodeUserObj--"+nodeUserObj)
	  staffTable.refresh(null,"staffIds="+nodeUserObj+"&roleCode=<%=roleCode%>");
  }

  function clearData()
  {
      var returnData=new   Array(); 
   	  returnData[0]="";
	  returnData[1]="";
	  returnData[2]="";
	  returnData[3]="";
	  returnData[4]="";
	  window.returnValue = returnData;
	  window.close();
  }
  
var x,y;
function over(index){
	x = event.clientX;
	y = event.clientY;
	document.all.tip.style.display = "block";
	document.all.tip.style.top = y;
	document.all.tip.style.left = x;
}
function out(){
	document.all.tip.style.display = "none";
}

function searchPerson(){
	var searchPsn = $('#searchPsn').val();
	staffTable.refresh(null,"name="+searchPsn+"&roleCode=<%=roleCode%>");
}
  </script>
</html>

