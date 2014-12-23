<%@ page import ="com.ai.appframe2.common.*"%>
<%@ page import ="com.ai.appframe2.vm.*"%>
<%@ page import ="com.ai.appframe2.vm.workflow.*"%>
<%@ page import ="com.ai.appframe2.vm.common.*"%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/webframe/common/commonhead.jsp"%>
<html>
  <head>
  <title>Comframe异常情形维护</title>
  <script  defer src="exceptionDescMaintain.js"></script>
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
<label>异常情形编码</label><input type=text  id="Desc"  size=30>
<ai:button text="查询" id="query"  enable="true" onclick="do_query()"/>

</fieldset>
<fieldset>
	  <legend>查询结果</legend>
	  	<ul>
				
				<ai:table setname="com.ai.comframe.exception.db.ExceptionDesc" 
				tableid="exceptionDesc"
				editable="false" 
				multiselect="false"
				tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
				implservice_name="com.ai.comframe.exception.service.IExceptionMaintain"
				implservice_querymethod="queryExceptionDesc(String description,int $STARTROWINDEX, int $ENDROWINDEX))"
				implservice_countmethod="queryExceptionDescCount(String description)"		
		        needrefresh="true"
		        rowsequence="true"
		        height="200" width="400"
		        initial="false"
		        footdisplay="true"
		        rowheight="-1"
		        pagesize="20"
            
		        >
		
		<ai:col fieldname="EXCEPTION_DESC_CODE"  visible="true" width="150"/>
		<ai:col fieldname="EXCEPTION_DESC_NAME"   visible="true" width="200"/>
		
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
