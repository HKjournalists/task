<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/csc/common/taglib.jsp"%>
<%
	String type = request.getParameter("type");
	String objNo = request.getParameter("objNo");
	//request.setAttribute("userInfo", g_GetUserInfo());
%>
<html>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/csc/common/css/aialm_style_css.jsp" type="text/css">
	<head>
	<title>附件选择</title>
	</head>

	<body>
	
		<div id="attach_select" class="div_title" >
			<table class="content_title" border="0">
				<tr>
		        	<td align="center" width="20"><img src="<%=request.getContextPath()%>/csc/images/div/select.gif"></td> 
					<td class="content_title_text">任务查询区</td>
					<td align="right"><ai:button id="qryBtn" text="查询" onclick="qryAttach()"/></td>
				</tr>
		    </table>
			<ai:dbform formid="queryForm" setname="com.asiainfo.csc.attach.web.SETQueryAtt" datamodel="com.ai.appframe2.web.tag.ActionDataModel" editable="true" initial="false">
				<table align="center" width="100%">
					<tr align="right">
						<td class="title_e">附件名称</td>
						<td class="aiEdit_3col" align="left"><ai:dbformfield fieldname="ATT_NAME" formid="queryForm" editable="true" width="<%=aiEdit_4cw%>"/></td>
					
						<td class="title_e">提交人</td>
						<td class="aiEdit_3col" align="left"><ai:dbformfield fieldname="SUBMITTER_TAG" formid="queryForm" editable="false" width="<%=aiEdit_btn_4cw%>"/><input id="staffBtn" class="staffbtn" type="button" onclick="onSelectStaff()"/></td>
					</tr>
					<tr align="right">	
						<td class="title_e">提交时间</td>
						<td class="aiEdit_3col" colspan="3">
							<ai:dbformfield fieldname="SUBMIT_TIME" formid="queryForm" visible="true" width="150" editable=""></ai:dbformfield>-
						  	<ai:dbformfield fieldname="SUBMIT_END_TIME"   formid="queryForm" visible="true" width="150" editable=""></ai:dbformfield> 
						</td>
					</tr>
				</table>
			</ai:dbform>
		</div>
	
		<div class="div_title">
		 				
			<table class="content_title" width="100%" border="0">
				<tr>
					<td class="content_title_text">附件信息</td>
					<td  align="right">
						<ai:button text="添加附件" name="ftpAttach" id="addAttach" enable="false" onclick="addAttach()"/>
	           		</td>
				</tr>
			</table>
		 				
			<table align="center" width="100%">
				<tr><td width="100%" align="center">
					<ai:stable tableid="tblAttach" setname="com.asiainfo.csc.attach.web.SETQueryAtt"
	                	invoke_type="service" initial="false" footdisplay="true"
	                    invoke_name="com.asiainfo.csc.attach.service.AttachService" 
	                    invoke_querymethod="queryAttach(String attName, String submitter_tag, String startdate, String enddate, int $STARTROWINDEX, int $ENDROWINDEX)"
	                    invoke_countmethod="queryAttachCount(String attName, String submitter_tag, String startdate, String enddate)"
	                    editable="false" needrefresh="true" multiselect="true"
	                    width="100%" height="100" rowheight="-1" pagesize="10" rowsequence="true"
	                    ondbclick="" oncontextmenu="">					
						<ai:col fieldname="ATT_ID" visible="false"></ai:col>
						<ai:col fieldname="ATT_NAME" visible="true" width="100"></ai:col>
						<ai:col fieldname="ATT_PATH" visible="true" width="100"></ai:col>
						<ai:col fieldname="ATT_TYPE" visible="true" width="100"></ai:col>
						<ai:col fieldname="ATT_DESC" visible="true" width="100"></ai:col>
						<ai:col fieldname="SUBMITTER_TAG" visible="true" width="100"></ai:col>
						<ai:col fieldname="SUBMIT_LINK" visible="true" width="100"></ai:col>
						<ai:col fieldname="SUBMIT_TIME" visible="true" width="100"></ai:col>
						<ai:col fieldname="STATUS" visible="false"></ai:col>
					</ai:stable>
				</td></tr>
			</table>
		</div>
	</body>

<script language="JavaScript">

init();

function init(){
	/*
	getTblAttach().refresh(null,"");
	var count = getTblAttach().getTotalRowCount();
	
	if(count > 0){
		g_AIButtonManager.get("addAttach").setDisabled(false);
		
		for(var i = 0; i < count; i++){
			getTblAttach().setValue(i, "STATUS", 0);
		}
	}else{
		g_AIButtonManager.get("addAttach").setDisabled(true);
	}
	*/
}

function getTblAttach(){
  	return g_TableRowSetManager.get("tblAttach");
}

function getQueryForm(){
	return g_FormRowSetManager.get("queryForm");
}
  
function addAttach(){
	var rows = getTblAttach().getSelectedRows();

	if(rows.length == 0){
		aialmPrompt("请选择一个文件");
		return;
	}
	
	for(var i = 0; i < rows.length; i++){
		getTblAttach().setValue(rows[i], "STATUS", 1);
	}
	
	var list = new Array();
	list.push(getTblAttach());
	
	var url = "<%=request.getContextPath()%>/business/com.asiainfo.csc.attach.web.AttachAction?action=newPackage&objNo=<%=objNo%>&type=" + <%=type%>;
	
	saveRowSet(url,list,true,false);
	
	window.dialogArguments.refreshPackList();
    window.close();
}

function onSelectStaff(){
	//returnData=window.showModalDialog("request.getContextPath()/aialm/common/SelectStaff.jsp?type=GS","org","scroll:no;resizable:no;status:no;dialogHeight:330px;dialogWidth:500px");
	
	//if(returnData == null){
   	//	return;
   	//}
   	
   	returnData = selectStaffByProject("APIC",-1);
   	if(returnData == null){
   		return;
   	}
   	var name = returnData[1];
   	var no = returnData[2];
   	
   	getQueryForm().setValue("SUBMITTER_TAG",no,name);
}

function qryAttach(){
	var attName = getQueryForm().getValue("ATT_NAME");
	var submitter_tag = getQueryForm().getValue("SUBMITTER_TAG");
	var startdate = getQueryForm().getValue("SUBMIT_TIME");
	var enddate = getQueryForm().getValue("SUBMIT_END_TIME");
	
	getTblAttach().refresh(null, "attName=" + attName + "&submitter_tag=" + submitter_tag + "&startdate=" + startdate + "&enddate=" + enddate);
	
	var count = getTblAttach().getTotalRowCount();
	
	if(count > 0){
		g_AIButtonManager.get("addAttach").setDisabled(false);
		
		for(var i = 0; i < count; i++){
			getTblAttach().setValue(i, "STATUS", 0);
		}
	}else{
		g_AIButtonManager.get("addAttach").setDisabled(true);
	}
}
</script>

</html>