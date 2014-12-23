<%@page contentType="text/html; charset=GBK"%>
<%@include file="/csc/common/taglib.jsp"%>
<%
	//String  staffName = g_GetUserInfo().getName();
	String  staffCode = g_GetUserInfo().getCode();
	java.sql.Timestamp  currentTime =  com.ai.appframe2.common.ServiceManager.getOpDateTime();
	String curTime = currentTime.toLocaleString();
%>

<html>
  <head>
    <title>demo页面——floatdiv&tree</title>
  </head>
  <body>
  	<!-- 最外层要有一个div，其子div中的float属性才有用 -->
  	<div>
	  	<div id="protExceptionTreeDiv" class="div_title1" style="float:left;width:30%;height:100%;">
	     	<table class="content_title" border="0">
				<tr>
					<td align="center" width="20">
						<img src="<%=request.getContextPath()%>/csc/images/div/select.gif">
					</td>
					<td class="content_title_text">协议结构</td>
					<td align="right">
						<form><input type="text" id="qryText" /></form>
					</td>	
					<td align="right">
						<ai:button id="queryBtn" text="查询" onclick="addException()"/>
					</td>
				</tr>
			</table>
			<fieldset style="width: 100%;; font-size: 12; padding: 5px 5px 0 5px; border-color: #E5EFF5; border-style: solid;">
				<ai:dbtree_new id="protExceptionTree"
					datamodel="com.asiainfo.csc.reqTree.web.ReqTree"
					multiselect="false" height="530" width="100%" ishaveline="true"
					ondblclick="showProtExceptionTbl" onselect="showProtExceptionTbl"
					onrightclick=""/>
			</fieldset>
	    </div>
	    <div id="protExceptionDiv" style="float: left;width: 70%;height: 100%;">
	    	<table class="content_title" style="display:block;width:100%;">
	    		<tr>
	    			<td align="center" width="20"><img src="<%=request.getContextPath()%>/csc/images/div/opera.gif"></td> 
					<td class="content_title_text" align="left">列表显示区</td>
					<td align="right" >
						<ai:button id="editBtn" text="数据配置" onclick="editData()"/>
						<ai:button id="delBtn" text="删除数据" onclick="delData()"/>
					</td>
	    		</tr>
	    	</table>
	    </div>
  	</div>
  </body>
  <script type="text/javascript">
  	var protExceptionTree = g_DBTreeNewManager.get("protExceptionTree");
  	
  	initProtException();
  	
  	function initProtException() {
  		
  	}
  	
	function getProtExceptionTree() {
		return g_DBTreeNewManager.get("protExceptionTree");
	}
  	
  	function displayProtException() {
  		protExceptionFrm.refresh("exceptionId="+tblProtException.getValue(tblProtException.getRow(),"EXCEPTION_ID"));
  		saveProtExceptionBtn.setDisabled(false);
  	}
  	
  	function queryBtn() {	 
		var value="";
		value=document.getElementById("qryText").value;
		getProtExceptionTree().refresh(null,10,"value="+value);
		expandAll();
	}
	
  	function expandAll() {
		var RootNode = getProtExceptionTree().getRootNodeInfo();
		expandNodes(RootNode);
	}
	
	function expandNodes(node) {
		getProtExceptionTree().expandNodeByValue(node.value,true); 
		var nodes = getProtExceptionTree().getChildrenNodesInfo(node.value);
		for(var i=0;i<nodes.length;i++) {
			expandNodes(nodes[i]);
		}
	}
  	
  	function showProtExceptionTbl() {
  		
  	}
  	
  </script>
</html>
