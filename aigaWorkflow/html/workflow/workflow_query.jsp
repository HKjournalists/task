<%@page contentType="text/html; charset=gb2312"%>
<%@include file="/secframe/common/common.jsp"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>�칫��Ʒ����ϵͳ</title>
  </head>
  <body>
    <br/>
    <table border="1" align="center" width="90%" height="30" style="BORDER-RIGHT: 1px solid; BORDER-TOP: 0px solid; BORDER-LEFT: 1px solid;BORDER-BOTTOM: 0px solid; TABLE-LAYOUT: fixed;BORDER-COLLAPSE: collapse">
     <tr >
     <th width="20%"><a href="javaScript:show(1);">����״̬</a></th>
     <th width="20%"><a href="javaScript:show(2);">����״̬</a></th>
     <th width="20%"><a href="javaScript:show(3);">����״̬</a></th>
     <th width="20%"><a href="javaScript:show(4);">����״̬</a></th>
     <th width="20%"><a href="javaScript:show(5);">ȷ��״̬</a></th>
     </tr>
     </table>
    <table align="center" width="90%">
    <tr align="center">
    <td width="100%">
       <ai:contentframe id="" title="��ʷ�켣��Ϣ��ʾ" contenttype="" width="100%">
	   <ai:stable tableid="workflowTable" setname="com.asiainfo.alm.web.common.SETWorkflowQuery"
			invoke_type="service" initial="false" 
            invoke_name="com.asiainfo.alm.service.common.WorkflowService" 
            invoke_querymethod="queryWorkflow(String reqId,String phaseId,int $STARTROWINDEX,int $ENDROWINDEX)"
            invoke_countmethod="getWorkflowCount(String reqId,String phaseId)"
            editable="false" needrefresh="true" multiselect="false"
            width="100%" height="200" rowheight="-1" pagesize="7" rowsequence="true"
            ondbclick="" oncontextmenu="">
            <ai:col fieldname="ORDER_ID"  width="150"  visible="true" />
            <ai:col fieldname="TASK_ID"  width="150"  visible="true" />
            <ai:col fieldname="VM_TASK_NAME"  width="150"  visible="true" />
            <ai:col fieldname="PHASE_NAME"  width="150"  visible="true"/>
            <ai:col fieldname="LINK_NO"  width="150"  visible="true" />
            <ai:col fieldname="CREATE_TIME"  width="150"  visible="true" />
            <ai:col fieldname="RECV_TIME"  width="150"  visible="true" />
            <ai:col fieldname="EXEC_TIME"  width="150"  visible="true" />
            <ai:col fieldname="EXEC_STAFF_ID"  width="150"  visible="true" />
            <ai:col fieldname="FINISH_TIME"  width="150"  visible="true" />
		</ai:stable>
	</ai:contentframe>
    </td>
  </tr>
 </table> 
 
  <script type="text/javascript">
      //��Ҫ��������id
	  var reqId = '1000';
	  
	  //ˢ���б�
	  var workflowTable=g_TableRowSetManager.get("workflowTable");
	  workflowTable.refresh(null,"phaseId="+'1');
	  
	  function show(value){
	   workflowTable.refresh(null,"phaseId="+value);
	  }
  </script>
  </body>
</html>
