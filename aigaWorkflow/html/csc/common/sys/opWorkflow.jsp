<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ include file="/csc/common/taglib.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>系统参数表</title>
  </head>
  
  <body>
  <div class="div_title">
    	<table class="content_title" border="0">
			<tr>
				<td class="content_title_text">参数表</td>
			</tr>
		</table>
    	<ai:stable tableid="tblWorkflow" setname="com.asiainfo.csc.common.web.SETAlmWorkflow"
			height="200" width="100%" footdisplay="true" needrefresh="true" initial="false"
			invoke_type="service" invoke_name="com.asiainfo.csc.common.service.WorkflowService"
			invoke_querymethod="getAllWorkflow()"
			editable="false" multiselect="false" rowheight="-1" pagesize="" rowsequence="true"
			oncontextmenu="" ondbclick="refreshWorkflowFrm" >
			<ai:col fieldname="WF_ITEM_ID" width="100" visible="false" />
			<ai:col fieldname="TEMPLATE_ID"  width="200"  visible="true" />
			<ai:col fieldname="TEMPLATE_NAME"  width="200"  visible="true" />
			<ai:col fieldname="TEMPLATE_TYPE"  width="200"  visible="true" />
			<ai:col fieldname="VERSION"  width="100"  visible="true" />
			<ai:col fieldname="PHASE_ID"  width="100"  visible="true" />
			<ai:col fieldname="PHASE_NAME"  width="100"  visible="true" />
			<ai:col fieldname="VM_TASK_NAME"  width="100"  visible="true" />
			<ai:col fieldname="VM_LINK_ID" width="100" editable="true" />
			<ai:col fieldname="VM_TASK_NO"  width="200"  visible="true" />
			<ai:col fieldname="LINK_ID"  width="200"  visible="true" />
			<ai:col fieldname="LINK_NO"  width="200"  visible="true" />
			<ai:col fieldname="LINK_NO_TYPE"  width="100"  visible="true" />
			<ai:col fieldname="ROLE_CODE"  width="100"  visible="true" />
			<ai:col fieldname="LINK_URL"  width="100"  visible="true" />
			<ai:col fieldname="NEXT_LINK_COND_TREE"  width="100"  visible="true" />
			<ai:col fieldname="IS_DISPLAY" width="100" editable="true" />
			<ai:col fieldname="IS_ROLE"  width="200"  visible="true" />
			<ai:col fieldname="IS_PRINT"  width="200"  visible="true" />
			<ai:col fieldname="IS_REAUTHORIZE"  width="200"  visible="true" />
			<ai:col fieldname="IS_TERMINATE"  width="100"  visible="true" />
			<ai:col fieldname="IS_BACK"  width="100"  visible="true" />
			<ai:col fieldname="IS_NOTICE"  width="100"  visible="true" />
			<ai:col fieldname="IS_DISCUSS"  width="100"  visible="true" />
			<ai:col fieldname="BACK_COND"  width="200"  visible="true" />
			<ai:col fieldname="BACK_LINK_NO"  width="100"  visible="true" />
			<ai:col fieldname="HTML_TAG_NAME"  width="100"  visible="true" />
			<ai:col fieldname="HTML_TAG_DESC"  width="100"  visible="true" />
			<ai:col fieldname="INIT_LINK_NO"  width="100"  visible="true" />
			<ai:col fieldname="INIT_LINK_ID"  width="200"  visible="true" />
			<ai:col fieldname="NEED_INIT_STAFF"  width="100"  visible="true" />
			<ai:col fieldname="CREATE_STAFF_ID"  width="100"  visible="true" />
			<ai:col fieldname="CREATE_TIME"  width="100"  visible="true" />
			<ai:col fieldname="START_TIME"  width="100"  visible="true" />
			<ai:col fieldname="END_TIME"  width="200"  visible="true" />
			<ai:col fieldname="VALID_TAG"  width="100"  visible="true" />
			<ai:col fieldname="IS_COMPANY"  width="100"  visible="true" />
			<ai:col fieldname="IS_DEPART"  width="100"  visible="true" />
			<ai:col fieldname="IS_GROUP"  width="100"  visible="true" />
			<ai:col fieldname="CONNECT_POINT"  width="100"  visible="true" />
		</ai:stable>
		</div>
		<div class="div_title">
		<table class="content_title" border="0">
			<tr>
				<td class="content_title_text">操作区域</td>
				<td align="right">
					<ai:button text="新增" onclick="newWorkflow()" />
					<ai:button text="保存" onclick="saveWorkflow()" />
					<ai:button text="删除" onclick="delWorkflow()" />
				</td>
			</tr>
		</table>
		<ai:dbform setname="com.asiainfo.csc.common.web.SETAlmWorkflow" formid="workflowFrm" initial="false" editable="true">
    	<ai:dbformfield fieldname="WF_ITEM_ID" formid="workflowFrm" visible="false"/>
			<table width="100%" align="center" class="table_context">
				<tr>
					<td class="title_e">TEMPLATE_ID：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="TEMPLATE_ID" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">TEMPLATE_NAME：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="TEMPLATE_NAME" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">TEMPLATE_TYPE：</td>	
					<td class="aiEdit_3col"><ai:dbformfield fieldname="TEMPLATE_TYPE" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
				</tr>
				<tr>
					<td class="title_e">VERSION：</td>	
					<td class="aiEdit_3col"><ai:dbformfield fieldname="VERSION" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">PHASE_ID：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="PHASE_ID" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">PHASE_NAME：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="PHASE_NAME" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
				</tr>
				<tr>
					<td class="title_e">VM_TASK_NAME：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="VM_TASK_NAME" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">VM_LINK_ID：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="VM_LINK_ID" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">VM_TASK_NO：</td>	
					<td class="aiEdit_3col"><ai:dbformfield fieldname="VM_TASK_NO" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
				</tr>
				<tr>
					<td class="title_e">LINK_ID：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="LINK_ID" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">LINK_NO：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="LINK_NO" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">LINK_NO_TYPE：</td>	
					<td class="aiEdit_3col"><ai:dbformfield fieldname="LINK_NO_TYPE" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
				</tr>
				<tr>
					<td class="title_e">ROLE_CODE：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="ROLE_CODE" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">LINK_URL：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="LINK_URL" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">NEXT_LINK_COND_TREE：</td>	
					<td class="aiEdit_3col"><ai:dbformfield fieldname="NEXT_LINK_COND_TREE" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
				</tr>
				<tr>
					<td class="title_e">IS_DISPLAY：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="IS_DISPLAY" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">IS_ROLE：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="IS_ROLE" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">IS_PRINT：</td>	
					<td class="aiEdit_3col"><ai:dbformfield fieldname="IS_PRINT" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
				</tr>
				<tr>
					<td class="title_e">IS_REAUTHORIZE：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="IS_REAUTHORIZE" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">IS_TERMINATE：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="IS_TERMINATE" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">IS_BACK：</td>	
					<td class="aiEdit_3col"><ai:dbformfield fieldname="IS_BACK" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
				</tr>
				<tr>
					<td class="title_e">IS_NOTICE：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="IS_NOTICE" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">IS_DISCUSS：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="IS_DISCUSS" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">BACK_COND：</td>	
					<td class="aiEdit_3col"><ai:dbformfield fieldname="BACK_COND" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
				</tr>
				<tr>
					<td class="title_e">BACK_LINK_NO：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="BACK_LINK_NO" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">HTML_TAG_NAME：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="HTML_TAG_NAME" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">HTML_TAG_DESC：</td>	
					<td class="aiEdit_3col"><ai:dbformfield fieldname="HTML_TAG_DESC" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
				</tr>
				<tr>
					<td class="title_e">INIT_LINK_NO：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="INIT_LINK_NO" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">INIT_LINK_ID：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="INIT_LINK_ID" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">NEED_INIT_STAFF：</td>	
					<td class="aiEdit_3col"><ai:dbformfield fieldname="NEED_INIT_STAFF" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
				</tr>
				<tr>
					<td class="title_e">CREATE_STAFF_ID：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="CREATE_STAFF_ID" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">CREATE_TIME：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="CREATE_TIME" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">START_TIME：</td>	
					<td class="aiEdit_3col"><ai:dbformfield fieldname="START_TIME" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
				</tr>
				<tr>
					<td class="title_e">END_TIME：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="END_TIME" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">VALID_TAG：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="VALID_TAG" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">IS_COMPANY：</td>	
					<td class="aiEdit_3col"><ai:dbformfield fieldname="IS_COMPANY" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
				</tr>
				<tr>
					<td class="title_e">IS_DEPART：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="IS_DEPART" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">IS_GROUP：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="IS_GROUP" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">CONNECT_POINT：</td>	
					<td class="aiEdit_3col"><ai:dbformfield fieldname="CONNECT_POINT" formid="workflowFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
				</tr>
			</table>
    	</ai:dbform>
	</div>
  </body>
  <script type="text/javascript">
  	var tblWorkflow = g_TableRowSetManager.get("tblWorkflow");
  	var workflowFrm = g_FormRowSetManager.get("workflowFrm");
  	
  	initOpWorkflow();
  	
  	function initOpWorkflow() {
  		tblWorkflow.refresh(null,null);
  	}
  	
  	function refreshWorkflowFrm() {
  		var curRow = tblWorkflow.getRow();
  		workflowFrm.refresh("wf_item_id="+tblWorkflow.getValue(curRow,"WF_ITEM_ID"));
  	}
  	
  	function newWorkflow() {
  		workflowFrm.newRow();
  	}
  	
  	function saveWorkflow() {
  		if(!checkNeed()) {
  			return;
  		}
  		var list = new Array();
  		list.push(workflowFrm);
  		var url = "<%=request.getContextPath()%>/business/com.asiainfo.csc.common.web.OpTableAction?action=saveWorkflow";
  		var result = saveRowSet(url,list,true,false);
  		var retVal = result.getValueByName("retVal");
  		alert(retVal);
  		if(retVal == "Y") {
  			tblWorkflow.refresh(null,null);
  			if(workflowFrm.getValue("WF_ITEM_ID") == "") {
	  			newWorkflow();
  			}
  		}
  	}
  	
  	function delWorkflow() {
  		if(!confirm("确定删除该条数据吗？")) {
  			return;
  		}
  		var list = new Array();
  		list.push(workflowFrm);
  		var url = "<%=request.getContextPath()%>/business/com.asiainfo.csc.common.web.OpTableAction?action=delWorkflow";
  		var result = saveRowSet(url,list,true,false);
  		var retVal = result.getValueByName("retVal");
  		alert(retVal);
  		if(retVal == "Y") {
  			tblWorkflow.refresh(null,null);
  			newWorkflow();
  		}
  	}
  	
  	function checkNeed() {
  		if(workflowFrm.getValue("VM_TASK_NAME") == "") {
  			alert("请输入VM_TASK_NAME");
  			return false;
  		}
  		if(workflowFrm.getValue("LINK_ID") == "") {
  			alert("请输入LINK_ID");
  			return false;
  		}
  		return true;
  	}
  	
  </script>
</html>
