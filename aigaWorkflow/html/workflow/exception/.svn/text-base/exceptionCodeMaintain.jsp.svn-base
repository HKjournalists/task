<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/webframe/common/commonhead.jsp"%>
<html>
  <head>
  <title>Comframe异常原因维护</title>
  <script  defer src="exceptionCodeMaintain.js"></script>
    <style type="text/css">
    ul{
     margin-right:20px;
	 margin-left:20px;
    }
    </style>

  </head>
  
  <body>
  <fieldset>
	  <legend>查询条件</legend>
<label>异常原因编码</label><input type=text id="code" size=15>
<label>工作流处理对象类型</label><input type=text id="WFobject" size=15>
<ai:button text="查询" id="query"  enable="true" onclick="do_query()"/>

</fieldset>
<fieldset>
	  <legend>查询结果</legend>
	  	<ul >
				
				<ai:table setname="com.ai.comframe.exception.db.ExceptionCode" 
				tableid="exceptionCode"
				editable="false" 
				multiselect="true"
				tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
				implservice_name="com.ai.comframe.exception.service.IExceptionMaintain"
				implservice_querymethod="queryExceptionCode(String workFlowType,String ExCode,int $STARTROWINDEX, int $ENDROWINDEX)"
				implservice_countmethod="queryExceptionCodeCount(String workFlowType,String ExCode)"	
		        needrefresh="true"
		        rowsequence="true"
		        height="200" width="850"
		        initial="false"
		        footdisplay="block"
		        rowheight="-1"
                pagesize="20"
		        >
		
		<ai:col fieldname="EXCEPTION_CODE"  visible="true" width="100"/>
		<ai:col fieldname="EXCEPTION_NAME"   visible="true" width="200"/>
		<ai:col fieldname="WORKFLOW_OBJECT_TYPE_ID"   visible="true" width="200"/>
		<ai:col fieldname="STATE"   visible="true" width="250"/>
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
