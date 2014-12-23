<%@page contentType="text/html; charset=GBK"%>
<%@include file="/csc/common/taglib.jsp"%>

<%		
		//type就是roleCode
		String roleCode = request.getParameter("type");
		String cur_userId = request.getParameter("cur_userId");
		String projectCode = request.getParameter("projectCode");
		String parentOrgId = request.getParameter("parentOrgId");
		String districtId = request.getParameter("districtId");
		String chooseType = request.getParameter("chooseType");
		
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
			
		request.setAttribute("districtId",districtId);
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
			<tr><td width="45%">
					<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
				         <tr>
				             <td bgcolor="#FFFFFF" align="left" style="padding: 5px 0px 0px 10px;">
					             <ai:dbtree_new id="treeStaffOrg" datamodel="com.asiainfo.csc.common.web.TreeStaffSelect" 
					            	multiselect="false" height="240" width="100%" ishaveline="true"
					                onselect="displayStaffs"  ondblclick="displayStaffs" />
				             </td>
				         </tr>
	      			 </table>
				</td>
							
				<td width="55%" align="center" style="padding:5px 0px 0px 0px;">
					<ai:stable tableid="tblSelectStaff" setname="com.asiainfo.csc.common.web.SETStaffTable"
						 invoke_type="service" initial="false" footdisplay="none"
                         invoke_name="com.asiainfo.csc.common.service.StaffTableSV" 
                         invoke_querymethod="queryStaffsByIds(String staffIds ,String roleCode)"
                         editable="false" needrefresh="true" multiselect="true"
                         width="100%" height="230" rowheight="-1" pagesize="100" rowsequence="true"
                         ondbclick="" oncontextmenu="" onrowselected="selectThisRow">
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
	  <table style="margin-top: 3px;">
			<tr>
				<td align="right" valign="top" class="title_e" style="line-height:20px;width:70px;">意见/备注：</td>
				<td>
					<textarea id="resTextarea" class="dbform_textarea_style" style="width: 450px; height: 50px; display: inline; overflow-x: auto; overflow-y: auto;"></textarea>
				</td>
			</tr>
		</table>
		<ai:stable tableid="tblGetStaff" setname="com.asiainfo.csc.common.web.SETStaffTable"
			 invoke_type="service" initial="false" footdisplay="none" 
	         invoke_name="com.asiainfo.csc.common.service.StaffTableSV" 
	         invoke_querymethod="queryStaffsByIdAndRole(String staffIds ,String roleCode)"
	         editable="false" needrefresh="true" multiselect="false"
	         width="1" height="1" rowheight="-1" pagesize="100" rowsequence="false"
	         ondbclick="" oncontextmenu="">
	       	<ai:col fieldname="STAFF_ID"  editable="false" width="200" visible="false"/>
			<ai:col fieldname="PARENT_ORGANIZE_ID" editable="false" width="200" visible="false" />
			<ai:col fieldname="ORGANIZE_ID" 	editable="false" width="200" visible="false" />
			<ai:col fieldname="STAFF_CODE" 		editable="false" width="80" visible="false" />
			<ai:col fieldname="EMPLOYEE_NAME"  	editable="false" width="80" visible="false"/>
			<ai:col fieldname="ORGANIZE_NAME"  	editable="false" width="120" visible="false"/>
			<ai:col fieldname="BILL_ID" 		editable="false" width="120" visible="false" />
       </ai:stable>
       <table width="100%" align="center">
			<tr>
				<td align="center">
		    		<input name="" type="button" class="bigBtn" value="确定" id="confirm"  onclick="confirmData()"/>
		    		<input name="" type="button" class="bigBtn" value="清空" id="clear"  onclick="clearData()"/>
				</td>
			</tr>
		</table>
  </body>
  
  <script language="JavaScript" src="/jsv2/DBTree_new.js"></script>
  <script>
  var unfoldCount = 0;
  function getTblStaff(){
	return g_TableRowSetManager.get("tblGetStaff");
  }
  
  function selectTblStaff(){
	return g_TableRowSetManager.get("tblSelectStaff");
  }
  
  function getTreeStaffOrg() {
		return g_DBTreeNewManager.get("treeStaffOrg");
  }
  
  var selectStaffIds = new Array();
  initStaff();
  
/* 
function selectThisRow(RowIndex,isSelected){
	//alert(RowIndex+"---"+isSelected);
	var staffId = selectTblStaff().getValue(RowIndex,"STAFF_ID");
	
	if(isSelected){
		selectStaffIds.push(staffId);
	}else{
		var arrayIndex ;
		for(var j=0;j<selectStaffIds.length;j++){
			if(selectStaffIds[j]==staffId){
				arrayIndex=j;
			}
		}
		selectStaffIds.splice(arrayIndex,1);
	}
}
*/
function selectThisRow(RowIndex,isSelected){
	if(RowIndex==-100&&isSelected==true)
	{
		var count = selectTblStaff().count();
		for(var i = 0;i<count;i++)
		{
			selectThisRow(i,true);
		}
	}
	else if(RowIndex==-100&&isSelected==false)
	{
		var count = selectTblStaff().count();
		for(var i = 0;i<count;i++)
		{
			selectThisRow(i,false);
		}
	}
	else
	{
		var staffId = selectTblStaff().getValue(RowIndex,"STAFF_ID");
	
		if(isSelected){
		    var b = true;
			for(var x =0;x<selectStaffIds.length;x++)
			{
				if(selectStaffIds[x]==staffId)
				{
				   b = false;
                   break;
                }
			}
			if(b)
				selectStaffIds.push(staffId);
		}else{
			var arrayIndex ;
			for(var j=0;j<selectStaffIds.length;j++){
				if(selectStaffIds[j]==staffId){
					arrayIndex=j;
				}
			}
			selectStaffIds.splice(arrayIndex,1);
		}
	}
}  
function confirmData(){
	//不选人 ，直接 点击确定
	if(selectStaffIds.length==0){
		$.messager.alert('操作提示',"请先选择下一环节处理人",'error');
		return;
	}
	var resTextarea = document.getElementById("resTextarea").value;
	if(resTextarea == "") {
		$.messager.alert('操作提示',"请填写意见/备注",'error');
		return;
	}
	
	selectTblStaff().refresh(null,"staffIds="+selectStaffIds);
	var totalGet = selectTblStaff().getTotalRowCount();
	var condition1="";
	var condition2="";
	var condition3="";
	var condition4="";

	for(var i=0;i<totalGet;i++){
		condition1+=selectTblStaff().getValue(i,"STAFF_ID")+";";
		condition2+=selectTblStaff().getValue(i,"EMPLOYEE_NAME")+";";
		condition3+=selectTblStaff().getValue(i,"STAFF_CODE")+";";
		condition4+=selectTblStaff().getValue(i,"ORGANIZE_ID")+";";
	}
	
	if(confirm("你确定选这些人吗："+condition2)){
		var returnData=new Array();
	 	returnData[0]=condition1;
		returnData[1]=condition2;
		returnData[2]=condition3;
		returnData[3]=condition4;
		returnData[4]=resTextarea;
		window.returnValue = returnData;
		window.close();
	}
}


function initStaff(){
	selectStaffIds = new Array();
	getTreeStaffOrg().refresh(null,-1);
	document.getElementById("resTextarea").focus();
	$('#resTextarea').val('同意');
}

function expandNode(parentVal){
	unfoldCount = unfoldCount + 1;
	//展开 层级 自定义！
	if("<%=deepCnt%>"!=null && "<%=deepCnt%>"!=""){
		if(unfoldCount >= "<%=deepCnt%>"){
			return;
		}
	}
	
	var allNodes = getTreeStaffOrg().getChildrenNodesInfo(parentVal);
	for(var k=0; k<allNodes.length; k++){
		if(allNodes[k].userobj=='-1'){
			getTreeStaffOrg().expandNodeByValue(allNodes[k].value,true);
			expandNode(allNodes[k].value);
		}
	}
}

function displayStaffs(nodeVal,nodeText,nodeUserObj,nodeType) {
	if(nodeUserObj==null ||nodeUserObj==""){
		return;
	}
	
	if(nodeUserObj=="-1"){
		return;
	}
	var chooseType='<%=chooseType%>';
	if(chooseType=='user'){
		selectTblStaff().refresh(null,"staffIds="+nodeUserObj+"&roleCode=<%=roleCode%>");
	}else{
		selectTblStaff().refresh(null,"staffIds="+nodeUserObj);
	}
	//alert("nodeVal--"+nodeVal+"--nodeText--"+nodeText+"--nodeUserObj--"+nodeUserObj);
	
	//得到全部数据 ，选中 已选数据
	var totalCount = selectTblStaff().getTotalRowCount();
	
	for(var i=0;i<totalCount;i++){
		var rowId = selectTblStaff().getValue(i,"STAFF_ID");
		if(isSelect(rowId)){
			selectTblStaff().rowSelected(i,true,false);
		}
	}
}

function isSelect(rowId){
	for(var j=0;j<selectStaffIds.length;j++){
		if(selectStaffIds[j]==rowId){
			return true;
		}
	}
	return false;
}

function clearData(){
    var returnData=new   Array(); 
   	returnData[0]="";
	returnData[1]="";
	returnData[2]="";
	returnData[3]="";
	returnData[4]="";
	window.returnValue = returnData;
	window.close();
}
</script>
</html>

