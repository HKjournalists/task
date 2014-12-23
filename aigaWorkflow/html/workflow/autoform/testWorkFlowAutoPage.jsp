<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/webframe/jspcommon/includedhead.jsp"%>
<%@ page import="com.ai.comframe.autoform.service.interfaces.*" %>
<%@ page import="com.ai.comframe.autoform.service.impl.*" %>
<%@ page import="java.util.*" %>
<HTML>
<HEAD>
<TITLE>
</TITLE>
  <script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/TableRowSet.js"></script>
</HEAD>
<BODY bgcolor="#ffffff" >
  <%
  /** @todo 从request取值 */
//  String aWorkFlowCode=HttpUtil.getAsString(request,"WORK_FLOW_CODE");
//  String aWorkFlowNodeCode=HttpUtil.getAsString(request,"WORK_FLOW_NODE_CODE");
//    String aBusiType=HttpUtil.getAsString(request,"BUSINESS_TYPE_CODE");
//    String aBusinessSheetId=HttpUtil.getAsString(request,"BUSINESS_SHEET_ID");
	String URL = "/workflow/autoform/WorkFlowNodeAutoPage.jsp";
       String aWorkFlowCode="test_work_flow";
       String aWorkFlowNodeCode="test_work_flow_node";
  		request.setAttribute("WORK_FLOW_CODE",aWorkFlowCode);
  		request.setAttribute("WORK_FLOW_NODE_CODE",aWorkFlowNodeCode);
  		//request.setAttribute("WORK_FLOW_ID","5001571");
  		
		request.setAttribute("order_id","test1");
	   request.setAttribute("order_id_1","test2");
	   request.setAttribute("order_id_2","test3");
	    request.setAttribute("test","测试参数传递！");
  		RequestDispatcher r = request.getRequestDispatcher(URL);
			
		r.forward(request,response);
  %>
</BODY>
</HTML>