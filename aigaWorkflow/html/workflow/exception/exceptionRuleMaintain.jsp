<%@ page import ="com.ai.appframe2.common.*"%>
<%@ page import ="com.ai.appframe2.vm.*"%>
<%@ page import ="com.ai.appframe2.vm.workflow.*"%>
<%@ page import ="com.ai.appframe2.vm.common.*"%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/webframe/common/commonhead.jsp"%>
<script src="<%=request.getContextPath()%>/jsv2/TabPage.js"></script>
<script src="<%=request.getContextPath()%>/jsv2/HtmlParameter.js"></script>
<html>
  <head>
  <title>Comframe异常规则维护</title>
  <script  defer src="exceptionRuleMaintain.js"></script>
 
    <style type="text/css">
    ul{
     margin-right:20px;
	 margin-left:20px;
    }
    </style>

  </head>
  
  <body>
  
  <fieldset>


<fieldset>
	  <legend>查询结果</legend>
	  	<ul>
				
				<ai:table setname="com.ai.comframe.exception.db.ExceptionRule" 
				tableid="exceptionRule"
				editable="false" 
				multiselect="true"
				tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
				implservice_name="com.ai.comframe.exception.service.IExceptionMaintain"
				implservice_querymethod="queryExceptionRule(String Desc)"	
		        needrefresh="true"
		        rowsequence="true"
		        height="200" width="850"
		        initial="false"
		        footdisplay="none"
		        rowheight="-1"
            
		        >
		
		<ai:col fieldname="EXCEPTION_RULE_ID"   visible="false" width="200"/>
		<ai:col fieldname="EXCEPTION_RULE_REMARKS"   visible="true" width="150"/>
		<ai:col fieldname="EXCEPTION_DESC_CODE"   editable="false" visible="true" width="150"/>
		<ai:col fieldname="CURRENT_WORK_FLOW_CODE"   visible="true" width="200"/>
		<ai:col fieldname="NEXT_WORK_FLOW_CODE"   visible="true" width="200"/>
	
		</ai:table>	
		<br>
			<ai:button text="新增" id="add"  enable="true" onclick="do_add()"/>
<ai:button text="编辑" id="edit"  enable="true" onclick="do_edit()"/>
<ai:button text="删除" id="delete"  enable="true" onclick="do_delete()"/>
<ai:button text="保存" id="save"  enable="true" onclick="do_save()"/>
		</ul>
	
</fieldset>
  </body>
</html>
