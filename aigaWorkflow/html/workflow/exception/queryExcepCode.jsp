<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/webframe/common/commonhead.jsp"%>
<script src="<%=request.getContextPath()%>/jsv2/TabPage.js"></script>
<script src="<%=request.getContextPath()%>/jsv2/HtmlParameter.js"></script>

<html>
  <head>
  <script type="text/javascript">
  var rtn= new Array();
  
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
	 for (var i=0;i<selectedRows.length;i++){
	 	rtn.push(gridCode.getValue(selectedRows[i],"EXCEPTION_CODE"));
	 }
	
  	window.returnValue=rtn;
  	
  	window.close();
  	
  }
  
  function cancel(){
  
	window.close();
}
  </script>

  </head>
  
  <body>
    <legend>查询异常原因</legend>
	
	  <div>
	  <ul>
	  			<label>异常原因编码</label><input type=text  id="Codeb"  size=10>
	  			<label>异常原因名称</label><input type=text  id="CodeName"  size=10>
	 			 <ai:button text="查询"   enable="true" onclick="query()"/>
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
		<ul>
		 <ai:button text="确定" enable="true" onclick="confirm()"/>
		 <ai:button text="取消" enable="true" onclick="cancel()"/>
		 </ul>
		</div>
		

  </body>
</html>
