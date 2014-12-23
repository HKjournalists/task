<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai"%>
<%@ include file="/webframe/common/commonhead.jsp"%>
<%@ include file="/webframe/jspcommon/includedhead.jsp" %>
<html>
<head>
<title>JS规则配置页面</title>
</head>
<body>
<table id="quertTable" align="center">
	<tr>
		<td>
			<ai:dbform formid="queryForm" setname="com.ai.comframe.autoform.web.SETObjectJsRule" editable="true" initial="false">
				<table width="100%">
					<tr>
					<td>规则ID:</td>
		            <td>
		                <ai:dbformfield fieldname="RULE_ID" formid="queryForm" visible="true" width="120"></ai:dbformfield>
		            </td>
		            <td>规则名称：</td>
		            <td>
		                <ai:dbformfield fieldname="RULE_NAME" formid="queryForm" visible="true" width="120"></ai:dbformfield>
		            </td>
		            <td>函数名称：</td>
		            <td>
		                <ai:dbformfield fieldname="FUNC_NAME" formid="queryForm" visible="true" width="120"></ai:dbformfield>
		            </td>
		            <td>
		            	<input type="button" value="查询" class="B" onclick="query();"> 
		            </td>
					</tr>
		  		</table>
	  		</ai:dbform>
		</td>
	</tr>
</table>
<table id="resultTable" align="center">
  <tr>
    <td>
      <!--SET参数详细信息-->
      <ai:table setname="com.ai.comframe.autoform.web.SETObjectJsRule" tableid="TblJs" 
         implservice_name="com.ai.comframe.autoform.service.AutoFormSV"
         implservice_querymethod="getObjectJsRule(String ruleID,String funName,String ruleName,int $STARTROWINDEX,int $ENDROWINDEX)"
         implservice_countmethod="getObjectJsRuleCount(String ruleID,String funName,String ruleName)"
         tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
         pagesize="20" editable="true" footdisplay="none" height="200" width="700"
          initial="false" multiselect="true" needrefresh="true"  >
          <ai:col fieldname="FILE_NAME" editable="true"  visible="true" width="180"/>
          <ai:col fieldname="RULE_NAME" editable="true"  visible="true" width="180"/>
          <ai:col fieldname="FUNC_NAME" editable="true"  visible="true" width="180"/>
          
          <ai:col fieldname="PARAM_LIST" editable="true"  visible="true" width="180"/>
          <ai:col fieldname="REMARKS" editable="true"  visible="true" width="180"/>
          <ai:col fieldname="RULE_ID" editable="false"  visible="false" width="180"/>
      </ai:table>
    </td>
  </tr>
  <tr>
  	<td align="center">
        <input type="button" value="新增" class="B" onclick="addNewRule();">
        <input type="button" value="删除"  class="B" onclick="deleteRule();">
        <input type="button" value="保存"  class="B" onclick="saveRule();">
        <input type="button" value="关闭" class="B" onclick="window.close();"> 
    </td>
  </tr>
</table>
</body>
<script>
function getQueryRorm(){
	  return g_FormRowSetManager.get("queryForm");
}

function getResultTable(){
	  return g_TableRowSetManager.get("TblJs");
}
function query(){
	var jsruleid = getQueryRorm().getValue("RULE_ID");
	var ruleName = getQueryRorm().getValue("RULE_NAME");
	var funcName = getQueryRorm().getValue("FUNC_NAME");
	
	var param = "ruleID="+jsruleid+"&funName="+funcName+"&ruleName="+ruleName;

	getResultTable().refresh(param);
}

function addNewRule(){
  	 getResultTable().newRow();
  	 
}
function deleteRule(){
	var selArray=getResultTable().getSelectedRows();
    if(selArray.length>0){
        if(window.confirm("是否确定要删除选定的JS规则？")){
            for(var i=selArray.length-1;i>=0;i--){
              getResultTable().deleteRow(selArray[i]);
            }
            return true;
        }
    }else{
        alert("请选择要删除的JS规则！");
     }
}
function saveRule(){
	var list = new Array();
	list.push(getResultTable());
	var msg = saveRowSet("<%=request.getContextPath()%>/business/com.ai.comframe.autoform.web.AutoFormAction?action=saveJsRuleConfig",list,false,true);
  var ret = msg.getValueByName("retVal");
  alert(ret);
  window.dialogArguments.refreshObjectItem();
}
</script>
</html>