<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai"%>
<%@ include file="/webframe/common/commonhead.jsp"%>
<%@ include file="/webframe/jspcommon/includedhead.jsp"%>
<HTML>
	<HEAD>
		<TITLE>元件信息</TITLE>
	</HEAD>
	<BODY onload="refreshObjectItem();">
		<%
			String ObjectItemId = HttpUtil.getParameter(request, "OBJECT_ITEM_ID");
			if (ObjectItemId == null) {
				ObjectItemId = "-1";
			}
			String ObjectItemType = HttpUtil.getParameter(request, "OBJECT_ITEM_TYPE");
			String ObjectItemKindId = HttpUtil.getParameter(request, "OBJECT_ITEM_KIND_ID");
			//pageContext.getRequest().setAttribute("OBJECT_ITEM_ID",ObjectItemId);
		%>
		<div style="width:100%;height:100%;overflow:auto" align="center">
			<table width="98%" border="0" cellspacing="0" cellpadding="0">
				<tr class="alt_row">
					<td class="section_content">
						<!--内容写在下面：有几个模块就用几个table；table的宽度不可超过900，如果DBGrid超过900，则在'div'中加入'style="width:900;overflow:auto"';高度不要定义-->
						<!--功能内容开始-->
						<table align="center">
							<tr>
								<td>
									<ai:dbform formid="objectItemForm"
										setname="com.ai.comframe.autoform.web.SETObjectItem"
										implservice_name="com.ai.comframe.autoform.service.AutoFormSV"
										implservice_querymethod="getObjectItemDetail(long aObjectItemId)"
										initial="false"
										datamodel="com.ai.appframe2.web.datamodel.MethodModelForService">
										<table border="0" cellspacing="0" cellpadding="0"
											align="center">
											<tr>
												<td width="100" class="FormTDName">
													元件单元编号：
												</td>
												<td width="240" class="FormTD">
													<ai:dbformfield fieldname="OBJECT_ITEM_ID"
														formid="objectItemForm" editable="false" width="240"></ai:dbformfield>
												</td>
												<td width="100" class="FormTDName">
													编码：
												</td>
												<td width="240" class="FormTD">
													<ai:dbformfield fieldname="CODE" formid="objectItemForm"
														width="240"></ai:dbformfield>
												</td>
											</tr>
											<tr>
												<td width="100" class="FormTDName">
													名称：
												</td>
												<td width="240" class="FormTD">
													<ai:dbformfield fieldname="NAME" formid="objectItemForm"
														width="240"></ai:dbformfield>
												</td>
												<td width="100" class="FormTDName">
													描述：
												</td>
												<td width="240" class="FormTD">
													<ai:dbformfield fieldname="DESCRIPTION"
														formid="objectItemForm" width="240"></ai:dbformfield>
												</td>
											</tr>
											<tr>
												<td width="100" class="FormTDName">
													单元类型：
												</td>
												<td width="240" class="FormTD">
													<ai:dbformfield fieldname="ITEM_TYPE"
														formid="objectItemForm" width="240"></ai:dbformfield>
												</td>
												<td width="100" class="FormTDName">
													排序方式：
												</td>
												<td width="240" class="FormTD">
													<ai:dbformfield fieldname="SORT_BY" formid="objectItemForm"
														width="240"></ai:dbformfield>
												</td>
											</tr>
											<tr>
												<td width="100" class="FormTDName">
													状态：
												</td>
												<td width="240" class="FormTD">
													<ai:dbformfield fieldname="STATE" formid="objectItemForm"
														width="240"></ai:dbformfield>
												</td>
												<td width="100" class="FormTDName">
													备注：
												</td>
												<td width="240" class="FormTD">
													<ai:dbformfield fieldname="REMARKS" formid="objectItemForm"
														width="240"></ai:dbformfield>
												</td>
											</tr>
										</table>
										<div id="AttrExtDiv" style="display:none">
											<table border="0" cellspacing="0" cellpadding="0"
												align="center">
												<tr>
													<td width="100" class="FormTDName">
														回单服务：
													</td>
													<td width="240" class="FormTD">
														<ai:dbformfield fieldname="DATA_COMMIT_SV"
															formid="objectItemForm" width="240"></ai:dbformfield>
													</td>
													<td width="100" class="FormTDName">
														回单服务方法：
													</td>
													<td width="240" class="FormTD">
														<ai:dbformfield fieldname="DATA_COMMIT_SV_FUNCTION"
															formid="objectItemForm" width="240"></ai:dbformfield>
													</td>
												</tr>
												<tr>
													<td width="100" class="FormTDName">
														回单结果DS：
													</td>
													<td width="240" class="FormTD">
														<ai:dbformfield fieldname="FINISHCODE_DS"
															formid="objectItemForm" width="240"></ai:dbformfield>
													</td>
													<td width="100" class="FormTDName">
														回单结果DS参数：
													</td>
													<td width="240" class="FormTD">
														<ai:dbformfield fieldname="FINISHCODE_DS_PARAM"
															formid="objectItemForm" width="240"></ai:dbformfield>
													</td>
												</tr>
											</table>
										</div>
									</ai:dbform>
								</td>
							</tr>
							<tr>
								<td>
									<!--URL配置SET-->
									<div id="URLDiv" style="display:none" align="center">
										<fieldset style="width:100%;text-align:center;font-size:12">
											<legend>
												URL配置
											</legend>
											<table>
												<tr>
													<td>
														<!--SET参数详细信息-->
														<ai:table
															setname="com.ai.comframe.autoform.web.SETObjectItemUrl"
															tableid="TblUrl"
															implservice_name="com.ai.comframe.autoform.service.AutoFormSV"
															implservice_querymethod="getObjectItemUrl(String aObjectItemId,int $STARTROWINDEX,int $ENDROWINDEX)"
															implservice_countmethod=""
															tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
															pagesize="20" editable="true" footdisplay="none"
															height="80" width="630" initial="false"
															multiselect="true" needrefresh="true">

															<ai:col fieldname="URL_BUSI_TYPE" editable="true"
																visible="true" width="110" />
															<ai:col fieldname="URL" editable="true" visible="true"
																width="490" />
															<ai:col fieldname="OBJECT_ITEM_ID" editable="true"
																visible="false" width="0" />
														</ai:table>
													</td>
												</tr>
												<tr>
													<td align="center">
														<input type="button" value="新增" class="B"
															onclick="addUrl();">
														<input type="button" value="删除" class="B"
															onclick="deleteTable('TblUrl');">
													</td>
												</tr>
											</table>
										</fieldset>
									</div>
								</td>
							</tr>



							<tr>
								<td>
									<div id="AttrBlockDiv" style="display:none">
										<!--属性详细信息-->
										<ai:dbform formid="objectItemAttributeForm"
											setname="com.ai.comframe.autoform.web.SETObjectItemAttribute"
											implservice_name="com.ai.comframe.autoform.service.AutoFormSV"
											implservice_querymethod="getObjectItemAttributeDetail(long aObjectItemId)"
											initial="false"
											datamodel="com.ai.appframe2.web.datamodel.MethodModelForService">
											<table border="0" cellspacing="0" cellpadding="0"
												align="center">
												<tr>
													<td width="100" class="FormTDName">
														是否可编辑：
													</td>
													<td width="240" class="FormTD">
														<ai:dbformfield fieldname="IS_EDIT"
															formid="objectItemAttributeForm" width="240"></ai:dbformfield>
													</td>
													<td width="100" class="FormTDName">
														是否可视：
													</td>
													<td width="240" class="FormTD">
														<ai:dbformfield fieldname="IS_VISIBLE"
															formid="objectItemAttributeForm" width="240"></ai:dbformfield>
													</td>
												</tr>
												<tr>
													<td width="100" class="FormTDName">
														缺省值：
													</td>
													<td width="240" class="FormTD">
														<ai:dbformfield fieldname="DEFAULT_VALUE"
															formid="objectItemAttributeForm" width="240"></ai:dbformfield>
													</td>
													<td width="100" class="FormTDName">
														跨列个数：
													</td>
													<td width="240" class="FormTD">
														<ai:dbformfield fieldname="COL_SPAN"
															formid="objectItemAttributeForm" width="240"></ai:dbformfield>
													</td>
												</tr>
												<tr>
													<td width="100" class="FormTDName">
														宽度：
													</td>
													<td width="240" class="FormTD">
														<ai:dbformfield fieldname="WIDTH"
															formid="objectItemAttributeForm" width="240"></ai:dbformfield>
													</td>
													<td width="100" class="FormTDName">
														备注：
													</td>
													<td width="240" class="FormTD">
														<ai:dbformfield fieldname="REMARKS"
															formid="objectItemAttributeForm" width="240"></ai:dbformfield>
													</td>
												</tr>
												<tr>
													<td width="100" class="FormTDName">
														状态：
													</td>
													<td width="240" class="FormTD">
														<ai:dbformfield fieldname="STATE"
															formid="objectItemAttributeForm" width="240"></ai:dbformfield>
													</td>
												</tr>
											</table>
										</ai:dbform>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<!--SET详细信息-->
									<div id="SetBlockDiv" style="display:none">
										<!--属性详细信息-->
										<ai:dbform formid="objectItemSetForm"
											setname="com.ai.comframe.autoform.web.SETObjectItemSet"
											implservice_name="com.ai.comframe.autoform.service.AutoFormSV"
											implservice_querymethod="getObjectItemSetDetail(long aObjectItemId)"
											initial="false"
											datamodel="com.ai.appframe2.web.datamodel.MethodModelForService">
											<table border="0" cellspacing="0" cellpadding="0"
												align="center">
												<tr>
													<td width="100" class="FormTDName">
														SET名称：
													</td>
													<td width="240" class="FormTD">
														<ai:dbformfield fieldname="SET_NAME"
															formid="objectItemSetForm" width="240"></ai:dbformfield>
													</td>
													<td width="100" class="FormTDName">
														ROWSET对象名称：
													</td>
													<td width="240" class="FormTD">
														<ai:dbformfield fieldname="ROWSET_NAME"
															formid="objectItemSetForm" width="240"></ai:dbformfield>
													</td>
												</tr>
												<tr>
													<td width="100" class="FormTDName">
														每行列数：
													</td>
													<td width="240" class="FormTD">
														<ai:dbformfield fieldname="LINE_COL_NUM"
															formid="objectItemSetForm" width="240"></ai:dbformfield>
													</td>
													<td width="100" class="FormTDName">
														表现形式：
													</td>
													<td width="240" class="FormTD">
														<ai:dbformfield fieldname="UI_TAG_TYPE"
															formid="objectItemSetForm" width="240"></ai:dbformfield>
													</td>
												</tr>
												<tr>
													<td width="100" class="FormTDName">
														宽度：
													</td>
													<td width="240" class="FormTD">
														<ai:dbformfield fieldname="WIDTH"
															formid="objectItemSetForm" width="240"></ai:dbformfield>
													</td>
													<td width="100" class="FormTDName">
														高度：
													</td>
													<td width="240" class="FormTD">
														<ai:dbformfield fieldname="HEIGHT"
															formid="objectItemSetForm" width="240"></ai:dbformfield>
													</td>
												</tr>
												<tr>
													<td width="100" class="FormTDName">
														查询服务：
													</td>
													<td colspan="3" class="FormTD">
														<ai:dbformfield fieldname="QUERY_DATA_SV"
															formid="objectItemSetForm" width="580"></ai:dbformfield>
													</td>
												</tr>
												<tr>
													<td width="100" class="FormTDName">
														查询方法：
													</td>
													<td width="240" class="FormTD">
														<ai:dbformfield fieldname="QUERY_DATA_SV_FUNCTION"
															formid="objectItemSetForm" width="240"></ai:dbformfield>
													</td>
													<td width="100" class="FormTDName">
														分页方法：
													</td>
													<td width="240" class="FormTD">
														<ai:dbformfield fieldname="COUNT_DATA_SV_FUNCTION"
															formid="objectItemSetForm" width="240"></ai:dbformfield>
													</td>
												</tr>
											</table>
										</ai:dbform>
									</div>
								</td>
							</tr>
							<tr align="center">
								<td align="center">
									<%
										request.setAttribute("conditionname", "OBJECT_ITEM_ID = :ObjectItemId");
										java.util.HashMap paraMap = new java.util.HashMap();
										paraMap.put("ObjectItemId", new Long(ObjectItemId));
										request.setAttribute("parameter", paraMap);
									%>
									<!--SET参数表格详细信息-->
									<div id="ParamBlockDiv" style="display:none" align="center">
									<fieldset style="width:100%;text-align:center;font-size:12">
											<legend>
												JS配置
											</legend>
										<table>
											<tr>
												<td>													
													<ai:table
														setname="com.ai.comframe.autoform.web.SETJsRuleSet"
														tableid="TblEvent"
														implservice_name="com.ai.comframe.autoform.service.AutoFormSV"
														implservice_querymethod="getObjectJsRuleSetValues(String objectItemId,int $STARTROWINDEX,int $ENDROWINDEX)"
														implservice_countmethod=""
														tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
														pagesize="20" editable="true" footdisplay="none"
														height="120" width="630" initial="false"
														multiselect="true" needrefresh="true">
														<ai:col fieldname="RULE_TYPE" editable="true"
															visible="true" width="180" />
														<ai:col fieldname="EVENT_OBJ_TYPE" editable="true"
															visible="true" width="180" />
														<ai:col fieldname="RULE_ID" editable="true" visible="true"
															width="180" />

														<ai:col fieldname="OBJ_NAME" editable="true"
															visible="true" width="180" />
														<ai:col fieldname="EVENT_NAME" editable="true"
															visible="true" width="180" />
														<ai:col fieldname="PARAM_LIST" editable="true"
															visible="true" width="180" />

														<ai:col fieldname="OBJECT_ITEM_ID" editable="false"
															visible="false" />
														<ai:col fieldname="JS_RULE_SET_ID" editable="false"
															visible="false" />
													</ai:table>
												</td>
											</tr>
											<tr>
												<td align="center">
													<input type="button" value="新增" class="B"
														onclick="addNewEvent();">
													<input type="button" value="删除" class="B"
														onclick="deleteTable('TblEvent');">
													<input type="button" value="规则配置" class="B"
														onclick="addRuleConfig();">
												</td>
											</tr>
										</table>
										</fieldset>
									</div>
								</td>
							</tr>
							<tr align="right">
								<td colspan="4">
									<input type="button" class="B" value="保存"
										onclick="saveObjectItem()">
								</td>
							</tr>
						</table>

						<!--功能内容结束-->
					</td>
				</tr>
			</table>
		</div>

		<script language="javascript">
function gObjectItemRowSet(){
  return g_FormRowSetManager.get("objectItemForm");
}
function gObjectItemAttributeRowSet(){
  return g_FormRowSetManager.get("objectItemAttributeForm");
}
function gObjectItemSetRowSet(){
  return g_FormRowSetManager.get("objectItemSetForm");

}
function gObjectItemSetEventRowSet(){
  return g_TableRowSetManager.get("TblEvent");
}
function gObjectItemUrlSetRowSet(){
  return g_TableRowSetManager.get("TblUrl");
}


function addUrl(){
	var OBJECT_ITEM_ID = gObjectItemRowSet().getValue("OBJECT_ITEM_ID");
	gObjectItemUrlSetRowSet().newRow();
	gObjectItemUrlSetRowSet().setValue(gObjectItemUrlSetRowSet().getRow(),"OBJECT_ITEM_ID",OBJECT_ITEM_ID);
}

function addNewEvent(){
  var OBJECT_ITEM_ID = gObjectItemRowSet().getValue("OBJECT_ITEM_ID");
  gObjectItemSetEventRowSet().newRow();
  gObjectItemSetEventRowSet().setValue(gObjectItemSetEventRowSet().getRow(),"OBJECT_ITEM_ID",OBJECT_ITEM_ID);
}

function deleteTable(object){
	var selArray=g_TableRowSetManager.get(object).getSelectedRows();
    if(selArray.length>0){
        if(window.confirm("是否确定要删除选定的数据？")){
            for(var i=selArray.length-1;i>=0;i--){
              g_TableRowSetManager.get(object).deleteRow(selArray[i]);
            }
            return true;
        }
    }else{
    	var aRowNo=g_TableRowSetManager.get(object).getRow();
        if (aRowNo>=0){
          if(window.confirm("是否确定要删除当前行的事件？")){
            g_TableRowSetManager.get(object).deleteRow(aRowNo);
          }else{
            return;
          }
        }else{
          alert("请选择要删除的事件。");
        }
     }
}

function refreshObjectItem(){
  if ("<%=ObjectItemId%>"=="-1"){
    gObjectItemRowSet().newRow();
    gObjectItemRowSet().setValue("ITEM_TYPE","<%=ObjectItemType%>");
    if("<%=ObjectItemType%>"=="WORKFLOW" || "<%=ObjectItemType%>"=="WORKFLOW_NODE"){
    	document.all.item("AttrExtDiv").style.display="block";
    	document.all.item("URLDiv").style.display="block";
    }
    if ("<%=ObjectItemType%>"=="ATTRIBUTE"){
      gObjectItemAttributeRowSet().newRow();
      document.all.item("AttrBlockDiv").style.display="block";
    }
    if ("<%=ObjectItemType%>"=="SET"){
      gObjectItemSetRowSet().newRow();
      document.all.item("SetBlockDiv").style.display="block";
      document.all.item("ParamBlockDiv").style.display="block";
    }
    if("<%=ObjectItemType%>"=="WORKFLOW_NODE"){
    	document.all.item("ParamBlockDiv").style.display="block";
    }
  }else{
    var param="aObjectItemId=<%=ObjectItemId%>";
    gObjectItemRowSet().refresh(param);
    if("<%=ObjectItemType%>"=="WORKFLOW" || "<%=ObjectItemType%>"=="WORKFLOW_NODE"){
    	document.all.item("AttrExtDiv").style.display="block";
    	document.all.item("URLDiv").style.display="block";
    	gObjectItemUrlSetRowSet().refresh(param);
    }
    if ("<%=ObjectItemType%>"=="ATTRIBUTE"){
      gObjectItemAttributeRowSet().refresh(param);
      document.all.item("AttrBlockDiv").style.display="block";
    }
    if ("<%=ObjectItemType%>"=="SET"){
      gObjectItemSetRowSet().refresh(param);
      document.all.item("SetBlockDiv").style.display="block";
      document.all.item("ParamBlockDiv").style.display="block";
      var cond = "objectItemId=<%=ObjectItemId%>";
	  gObjectItemSetEventRowSet().refresh(cond);
    }
    if("<%=ObjectItemType%>"=="WORKFLOW_NODE"){
    	document.all.item("ParamBlockDiv").style.display="block";
    	var cond = "objectItemId=<%=ObjectItemId%>";
	  	gObjectItemSetEventRowSet().refresh(cond);
    }
  }
}
function saveObjectItem(){
  var DC_LIST="";
  var list = new Array();
  if (gObjectItemRowSet().toXmlString()!=""){
      DC_LIST="ObjectItemDc";
      //test verify方法
      var r=gObjectItemRowSet().validate("REMARKS",true,false);
      if (r==false){
        alert("请输入备注！");
        return;
      }
      list.push(gObjectItemRowSet());
  }
  if (gObjectItemAttributeRowSet().toXmlString()!=""){
      if (DC_LIST!=""){
        DC_LIST+=",";
      }
      DC_LIST+="ObjectItemAttributeDc";
      list.push(gObjectItemAttributeRowSet());
  }
  if (gObjectItemSetRowSet().toXmlString()!=""){
      if (DC_LIST!=""){
        DC_LIST+=",";
      }
      DC_LIST+="ObjectItemSetDc";
      list.push(gObjectItemSetRowSet());
  }
  if (gObjectItemUrlSetRowSet().toXmlString()!=""){
      if (DC_LIST!=""){
        DC_LIST+=",";
      }
      DC_LIST+="ObjectItemUrlSetDc";
      list.push(gObjectItemUrlSetRowSet());
  }
  
  if (gObjectItemSetEventRowSet().toXmlString()!=""){
      if (DC_LIST!=""){
        DC_LIST+=",";
      }
      DC_LIST+="ObjectItemSetEventDc";
      var TblEventRowset = g_TableRowSetManager.get("TblEvent");
      list.push(TblEventRowset);
  }
  if (list.length==0){
    alert("您没有修改任何数据！");
    return;
  }
  var param="&DC_LIST="+DC_LIST+"&OBJECT_ITEM_KIND_ID=<%=ObjectItemKindId%>";
  var msg = saveRowSet("<%=request.getContextPath()%>/business/com.ai.comframe.autoform.web.AutoFormAction?action=saveObjectItem"+param,list,false,true);
  var ret = msg.getValueByName("retVal");
  alert(ret.substring(1,ret.length));
  if (ret.substring(0,1)=="Y"){
    location.reload();
    //刷新树节点。
    var aTree=window.parent.parent.refreshNode();
  }
}

function addRuleConfig(){
	var ret = window.showModalDialog("addJsRuleConfig.jsp",window,
	   "scroll:no;resizable:no;status:no;dialogHeight:350px;dialogWidth:800px");
}
</script>
	</BODY>
</HTML>
