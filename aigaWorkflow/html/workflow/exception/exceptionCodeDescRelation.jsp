<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/webframe/common/commonhead.jsp"%>
<html>
  <head>
  <title>Comframe异常情形关联维护</title>
  <script  defer src="exceptionCodeDescRelation.js"></script>
  <script src="<%=request.getContextPath()%>/jsv2/TabPage.js"></script>
<script src="<%=request.getContextPath()%>/jsv2/HtmlParameter.js"></script>
  <script type="text/javascript">
  
  
  function getExcepCodeGird(){
	return g_TableRowSetManager.get("exceptionCode");
}
  function query(){
	  var Codeb=document.getElementById("Codeb").value;
	  var CodeName=document.getElementById("CodeName").value;
	  getExcepCodeGird().refresh("&Code="+Codeb+"&CodeName="+CodeName);
  
  }
  function confirm(){
	  var gridCode=getExcepCodeGird();
	  var selectedRows=gridCode.getSelectedRows();
	  var UnionGrid=getExcepRelationUnionGird();
	 for (var i=0;i<selectedRows.length;i++){
	 UnionGrid.newRow();
	 UnionGrid.setValue(UnionGrid.getRow(),"EXCEPTION_CODE",gridCode.getValue(selectedRows[i],"EXCEPTION_CODE"));
	UnionGrid.setValue(UnionGrid.getRow(),"EXCEPTION_DESC_CODE",parseHtmlParameter(document.location.toString()).getParameter("desc2"));
	 }
  }

  </script>
    <style type="text/css">
    ul{
     margin-right:20px;
	 margin-left:20px;
    }
    </style>

  </head>
  
  <body>

  <fieldset style="height:200">
	  <div id="tempgrid" style="display:none">
	  <ul>
	  			<label>异常原因编码</label><input type=text  id="Codeb"  size=10>
	  			<label>异常原因名称</label><input type=text  id="CodeName"  size=10>
	 			 <ai:button text="查询"   enable="true" onclick="query()"/>
	 			 <ai:button text="确定"   enable="true" onclick="confirm()"/>
	  </ul>

		<ul>
				<ai:table setname="com.ai.comframe.exception.db.ExceptionCode" 
				tableid="exceptionCode"
				editable="false" 
				multiselect="true"
				tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
				implservice_name="com.ai.comframe.exception.service.IExceptionMaintain"
				implservice_querymethod="queryExcepCodeAndName(String Code,String CodeName)"	
		        needrefresh="true"
		        rowsequence="true"
		        height="150" width="350"
		        initial="false"
		        footdisplay="none"
		        rowheight="-1"
            
		        >
		
		<ai:col fieldname="EXCEPTION_CODE"  visible="true" width="150"/>
		<ai:col fieldname="EXCEPTION_NAME"  visible="true" width="150"/>
		</ai:table>
		</ul>
		</div>
<fieldset style="position:relative">
	  <legend>查询结果</legend>
	  	<ul>
				
				<ai:button text="查询异常原因"  enable="true" onclick="openHidden()"/>
				<ai:button text="删除" id="delete" enable="true" onclick="delete1()"/>
				<ai:button text="保存关联关系"   enable="true" onclick="rel()"/>
				<ai:table setname="com.ai.comframe.exception.db.ExceptionRelationUnion" 
				tableid="exceptionRelationUnion"
				editable="false" 
				multiselect="true"
				tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
				implservice_name="com.ai.comframe.exception.service.IExceptionMaintain"
				implservice_querymethod="queryExceptionRelation(String DescCode)"	
		        needrefresh="true"
		        rowsequence="true"
		        height="150" width="750"
		        initial="false"
		        footdisplay="none"
		        rowheight="-1"
            
		        >
		
		<ai:col fieldname="EXCEPTION_CODE"  visible="true" width="100"/>
		<ai:col fieldname="EXCEPTION_DESC_CODE"   visible="true" width="100"/>
		<ai:col fieldname="EXCEPTION_DESC_NAME"   visible="true" width="100"/>
		</ai:table>	
		
		</ul>
		
</fieldset>
<div style="display:none">
<ai:table setname="com.ai.comframe.exception.db.ExceptionRelation" 
				tableid="exceptionRelation"
				editable="false" 
				tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
				implservice_name="com.ai.comframe.exception.service.IExceptionMaintain"
				implservice_querymethod="queryExcepRelationByDescCode(String DescCode)"	
		        needrefresh="true"
		        rowsequence="true"
		        height="150" width="750"
		        initial="false"
		        footdisplay="none"
		        rowheight="-1"
          		
		        >
		
		<ai:col fieldname="EXCEPTION_CODE"  visible="true" />
		<ai:col fieldname="EXCEPTION_DESC_CODE"   visible="true" />
		
		</ai:table>	
	</div>
  </body>
</html>
