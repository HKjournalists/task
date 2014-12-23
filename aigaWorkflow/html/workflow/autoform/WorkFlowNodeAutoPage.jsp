<!--
/**************************************************************************************
 *作    者：guanxu
 *创建时间：2009-04-16
 *描    述：autoform模板页面
 *修改记录：
**************************************************************************************/
-->
<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai"%>
<%@ include file="/webframe/common/commonhead.jsp"%>
<%@ page import="com.ai.comframe.autoform.service.interfaces.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.ai.comframe.autoform.ivalues.*"%>
<%@ page import="com.ai.appframe2.web.HttpUtil"%>
<%@ page import="com.ai.appframe2.util.StringUtils"%>
<%@ page import="com.ai.appframe2.service.ServiceFactory"%>
<%@ page import="com.ai.comframe.autoform.util.*"%>
<%@ page import="com.ai.appframe2.multicenter.CenterFactory" %>
<%@ include file="/workflow/autoform/jsRuleHead.jsp"%>
<HTML>
	<HEAD>
		<TITLE></TITLE>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/webframe/css/WebStyle.jsp" type="text/css">
		
		<%
		
			
			String jsRuleObjectId = "";//js规则引擎关联对象ID
			int urlBusiType = 1;//url业务类型
			
			String aWorkFlowCode = HttpUtil.getAsString(request, "WORK_FLOW_CODE");//
			String aWorkFlowNodeCode = HttpUtil.getAsString(request, "WORK_FLOW_NODE_CODE");//
			String aOrderId = HttpUtil.getAsString(request, "ORDER_ID");//
			String aTaskId = HttpUtil.getAsString(request, "TASK_ID");
			String aWorkFlowId = HttpUtil.getAsString(request, "WORK_FLOW_ID");
			
			String aCenterType = HttpUtil.getAsString(request, "CenterType");
			String aCenterValue = HttpUtil.getAsString(request, "CenterValue");
			String queryCondition = HttpUtil.getAsString(request, "QUERY_CONDITION");//任务列表的查询条件
			urlBusiType =  HttpUtil.getAsInt(request, "urlType");
 			
			//调用服务前设置中心
			if(!StringUtils.isEmptyString(aCenterType)&&!StringUtils.isEmptyString(aCenterValue)){
				CenterFactory.pushCenterInfo(aCenterType,aCenterValue);
			}
			
			request.setAttribute("aWorkFlowCode",aWorkFlowCode);
			request.setAttribute("aWorkFlowNodeCode",aWorkFlowNodeCode);
			
			IAutoFormSV autoformSV = (IAutoFormSV)ServiceFactory.getService("com.ai.comframe.autoform.service.AutoFormSV.runTime");
			
			
			IBOObjectItemValue aWorkFlowNodeValue = autoformSV.getObjectItemInfo(aWorkFlowCode,
				aWorkFlowNodeCode);
				
			String URL = autoformSV.getObjectItemUrl(aWorkFlowCode,aWorkFlowNodeCode,urlBusiType);
				
			//回置任务参数
			if(!StringUtils.emptyString(aWorkFlowId)){
				Map vars = autoformSV.getWorkFlowVars(aWorkFlowId);
	  			if(!vars.isEmpty()){
	  				Iterator keyIterator = vars.keySet().iterator();
		    		while(keyIterator.hasNext()){
		    			String key = (String)keyIterator.next();
		    			Object value = vars.get(key);
		    			request.setAttribute(key,value);
		    		}
	  			}	
			}
				
			jsRuleObjectId = Long.toString(aWorkFlowNodeValue.getObjectItemId());
			//回单结果数据准备(DS传的参数必须和配置的参数一致)
			String aFinshCodeDS = aWorkFlowNodeValue.getFinishcodeDs();
			String aFinshCodeDSParam = aWorkFlowNodeValue.getFinishcodeDsParam();
			String listCondition = "";
			
			if(!StringUtils.isEmptyString(aFinshCodeDS) && !StringUtils.isEmptyString(aFinshCodeDSParam)){
				String[] params = aFinshCodeDSParam.split(",");
				for(int i = 0;i < params.length; i++){
					listCondition = listCondition + "&" + params[i] +"="+ HttpUtil.getAsString(request, params[i]);
				}
			}else if(StringUtils.isEmptyString(aFinshCodeDS)){
				aFinshCodeDS = "com.ai.comframe.autoform.web.DSNodeFinishCode";
				listCondition = "&aWorkFlowCode="+aWorkFlowCode+"&aWorkFlowNodeCode="+aWorkFlowNodeCode;
			}
			
		%>
	</HEAD>
	<BODY>
		<%
			//URL重定向
			if (!StringUtils.isEmptyString(URL)) {
	  			request.setAttribute("WORK_FLOW_CODE",aWorkFlowCode);
	  			request.setAttribute("WORK_FLOW_NODE_CODE",aWorkFlowNodeCode);
	  			request.setAttribute("ORDER_ID",aOrderId);
	  			request.setAttribute("TASK_ID",aTaskId);
	  			request.setAttribute("WORK_FLOW_ID",aWorkFlowId);
	  			request.setAttribute("order_state","1");                     //未竣工的订单查询
	  			
	  			RequestDispatcher r = request.getRequestDispatcher(URL);

					//response.sendRedirect(aWorkFlowNodeValue.getUrl());
				//清除中心信息
				if(!StringUtils.isEmptyString(aCenterType)&&!StringUtils.isEmptyString(aCenterValue)){
					CenterFactory.popCenterInfo();
				} 

				r.forward(request,response);

				return;
			}else if(urlBusiType>1){//URL为空，但业务操作不是默认的回单类型
				request.setAttribute("WORK_FLOW_CODE",aWorkFlowCode);
	  			request.setAttribute("WORK_FLOW_NODE_CODE",aWorkFlowNodeCode);
	  			request.setAttribute("urlType",String.valueOf(urlBusiType));
	  			RequestDispatcher r = request.getRequestDispatcher("errorInfo.jsp");
			//清除中心信息
				if(!StringUtils.isEmptyString(aCenterType)&&!StringUtils.isEmptyString(aCenterValue)){
					CenterFactory.popCenterInfo();
				} 
				r.forward(request,response);
			}
			//页面所有SET集
			List setName = new ArrayList();
			try {//------1
		%>

		<table align="center">
			<%
					List aSetList = autoformSV.getSetsByFlowNodeCode(aWorkFlowCode, aWorkFlowNodeCode);
					//String[] aRsName = new String[aSetList.size()];

					for (int i = 0; i < aSetList.size(); i++) {//------2
						IBOObjectItemSetValue aObjectItemSet = (IBOObjectItemSetValue) aSetList.get(i);
						long aSetObjectItemId = aObjectItemSet.getObjectItemId();
						jsRuleObjectId = jsRuleObjectId + "," + Long.toString(aSetObjectItemId);
						String aSetName = aObjectItemSet.getSetName();
						String aDescription = aObjectItemSet.getDescription();
						List aEventList = autoformSV.getSetEventParamObj(aSetObjectItemId);
						String aDisplayTagType = aObjectItemSet.getUiTagType();
						boolean aSetIsEditable = aObjectItemSet.getIsEditable();
						String queryDataSV = aObjectItemSet.getQueryDataSv();
						String queryDataSVFunction = aObjectItemSet.getQueryDataSvFunction();
						String countQueryDataSVFunction = aObjectItemSet.getCountDataSvFunction();
						
						//处理配置的查询方法参数
						String[] paramArray = null;
						if(!StringUtils.isEmptyString(queryDataSVFunction)){
							String param = queryDataSVFunction.substring(queryDataSVFunction.indexOf("("),queryDataSVFunction.lastIndexOf(")"));
							paramArray = param.split(",");
						}
						
					if (aDisplayTagType != null) {
						String aRowSetName = aObjectItemSet.getRowsetName();
						//aRsName[i] = aRowSetName;
						setName.add(aRowSetName);
						//表格或Form的宽度
						String aUiWidth = "" + aObjectItemSet.getWidth();
						if (aUiWidth == null) {
							aUiWidth = "";
						}
						//表格或Form的高度
						String aUiHeight = "" + aObjectItemSet.getHeight();
						if (aUiHeight == null) {
							aUiHeight = "";
						}
						
			%>
			<script language="javascript">
				//查询函数的输出
					function query_<%=aRowSetName%>(object){
		          				var strCond = "1=1";
		          				<%if(paramArray !=  null && paramArray.length > 0){
		          				   for(int ji=0;ji<paramArray.length;ji++){
		          				   		String param = paramArray[ji].split("\\s+")[1];
		          				%>
		          					strCond = strCond+"&<%=param%>=<%=HttpUtil.getAsString(request,param)%>"
		          				<%   	
		          				}      		   				
		          				%>
		          				alert(strCond);
		  						
		  						<%}else {;}%>
		  						object.refresh(strCond);
		          			}
          </script>
			
			<% 

						//事件函数输出
						if (aEventList != null && aEventList.size() > 0) {
			%>
			<script language="javascript">
			          <%
			          for (int h=0;h<aEventList.size();h++){
			            ISetObjectEventParam aSetObjectEventParam=(ISetObjectEventParam)aEventList.get(h);
			            String aEventName=aSetObjectEventParam.getEventName();
			            String aEventParamList=aSetObjectEventParam.getParamList();
			            if (aEventParamList==null||aEventParamList.trim().equals("")){
			              aEventParamList="";
			            }
			            String aParentEventFunc=aRowSetName+"_"+aSetObjectEventParam.getEventFuncName();
			            String aEventFuncName=aRowSetName+"_"+aEventName;
			          %>
			            function <%=aEventFuncName%>(<%=aEventParamList%>){
			            	if (parent.<%=aParentEventFunc%>)
			            	parent.<%=aParentEventFunc%>(<%=aEventParamList%>);
			            }
			          <%
			          }
          			%>
          			
          	</script>
			<%
					}

					//每行列数
					long aLineColNum = aObjectItemSet.getLineColNum();
					//根据Set取属性集合
					List aAttrList = autoformSV.getAttrsByFlowNodeCodeSetId(aWorkFlowCode,
						aWorkFlowNodeCode, aSetObjectItemId);
					//该set总共的属性个数
					long aAttrSize = aAttrList.size();
					if (aAttrSize > 0) {
						int aRealTotalCol = 0;
						int totalLine = 0;
						//初始化参数
						long setNo = i + 1;
					
						String aInitial = "false";
			
						if (aDisplayTagType.trim().equals("DBGRID")) {
							//构建DBGrid
							//事件函数处理
							String grid_s_ondbclick = "";
							String grid_s_onrowchange = "";
							String grid_s_oncellchange = "";
							String grid_s_onvalchange = "";
							String grid_s_oncontextmenu = "";
							String grid_s_ondblink = "";
							String grid_s_onbeforeturnpage = "";
							String grid_s_onafterturnpage = "";
							String grid_s_onrowselected = "";
							if (aEventList != null && aEventList.size() > 0) {
						for (int h = 0; h < aEventList.size(); h++) {
							ISetObjectEventParam aSetObjectEventParam = (ISetObjectEventParam) aEventList
								.get(h);
							String aEventName = aSetObjectEventParam.getEventName();
							String aEventFunc = aSetObjectEventParam.getEventFuncName();
							String aEventFuncName = aRowSetName + "_" + aEventName;
							if (aEventName.equalsIgnoreCase("ondbclick")) {
								grid_s_ondbclick = aEventFuncName;
							} else if (aEventName.equalsIgnoreCase("onrowchange")) {
								grid_s_onrowchange = aEventFuncName;
							} else if (aEventName.equalsIgnoreCase("oncellchange")) {
								grid_s_oncellchange = aEventFuncName;
							} else if (aEventName.equalsIgnoreCase("onvalchange")) {
								grid_s_onvalchange = aEventFuncName;
							} else if (aEventName.equalsIgnoreCase("oncontextmenu")) {
								grid_s_oncontextmenu = aEventFuncName;
							} else if (aEventName.equalsIgnoreCase("ondblink")) {
								grid_s_ondblink = aEventFuncName;
							} else if (aEventName.equalsIgnoreCase("onbeforeturnpage")) {
								grid_s_onbeforeturnpage = aEventFuncName;
							} else if (aEventName.equalsIgnoreCase("onafterturnpage")) {
								grid_s_onafterturnpage = aEventFuncName;
							} else if (aEventName.equalsIgnoreCase("onrowselected")) {
								grid_s_onrowselected = aEventFuncName;
							}
						}
							}
			%>
			<tr align="center">
				<td>
					<fieldset id="<%=i%>" style="width:100%;text-align:center;font-size:12">
						<legend>
							<%=aDescription%>
						</legend>
						<ai:table tableid="<%=aRowSetName%>" setname="<%=aSetName%>"
							pagesize="100" implservice_name="<%=queryDataSV%>"
							implservice_querymethod="<%=queryDataSVFunction%>"
							implservice_countmethod="<%=countQueryDataSVFunction%>"
							editable="true" footdisplay="true" needrefresh="true"
							initial="<%=aInitial%>"
							tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
							height="<%=aUiHeight%>"
							width="<%=aUiWidth%>"
							onafterturnpage="<%=grid_s_onafterturnpage%>"
							oncellchange="<%=grid_s_oncellchange%>"
							onbeforeturnpage="<%=grid_s_onbeforeturnpage%>"
							oncontextmenu="<%=grid_s_oncontextmenu%>"
							ondbclick="<%=grid_s_ondbclick%>" ondblink="<%=grid_s_ondblink%>"
							onrowchange="<%=grid_s_onrowchange%>"
							onrowselected="<%=grid_s_onrowselected%>"
							onvalchange="<%=grid_s_onvalchange%>">
							<%
											//循环所有字段
									for (int j = 0; j < aAttrSize; j++) {
										IBOObjectItemAttributeValue aObjectItemAttribute = (IBOObjectItemAttributeValue) aAttrList
											.get(j);
										String aWidth = "" + aObjectItemAttribute.getWidth();
										String aFieldName = aObjectItemAttribute.getName();
										String aEditable = aObjectItemAttribute.getIsEdit();
										if (aEditable.equals("1")) {
											aEditable = "true";
										} else {
											aEditable = "false";
										}
										String aVisible = aObjectItemAttribute.getIsVisible();
										if (aVisible.equals("1")) {
											aVisible = "true";
										} else {
											aVisible = "false";
										}
							%>
							<ai:col fieldname="<%=aFieldName%>" visible="<%=aVisible%>"
								width="<%=aWidth%>" editable="<%=aEditable%>"></ai:col>
							<%
							}
							%>
						</ai:table>
					</fieldset>
				</td>
			</tr>
			<%
			if (aSetIsEditable == true) {
			%>
			<tr align="center">
				<td>
					<input type="button" class="B" id="addnew_<%=aRowSetName%>"
						value=" 新 增 " onclick="addnew_<%=aRowSetName%>();"
						style="width:100;cursor:hand;">
					<input type="button" class="B" id="delete_<%=aRowSetName%>"
						value=" 删 除 " onclick="delete_<%=aRowSetName%>();"
						style="width:100;cursor:hand;">
				</td>
			</tr>
			<%
			}
			%>
			<script language="javascript">
                  function g<%=aRowSetName%>RowSet(){
                    return g_TableRowSetManager.get("<%=aRowSetName%>");
                  }
                  function addnew_<%=aRowSetName%>(){
                    g<%=aRowSetName%>RowSet().newRow();
                  }
                  function delete_<%=aRowSetName%>(){
                    var seleAry=g<%=aRowSetName%>RowSet().getSelectedRows();
                    if (seleAry==null||seleAry.length==0){
                      alert("请选择要删除的数据！");
                      return;
                    }
                    if (confirm("您确认删除选中的数据吗？")!=true){
                      return;
                    }
                    for (var ii=seleAry.length-1;ii>=0;ii--){
                      var aRowNo=seleAry[ii];
                      g<%=aRowSetName%>RowSet().deleteRow(aRowNo);
                    }
                  }
              
                  <%if(!StringUtils.isEmptyString(queryDataSV) && !StringUtils.isEmptyString(queryDataSVFunction)){%>
                 	query_<%=aRowSetName%>(g<%=aRowSetName%>RowSet());
                 <%}%>
                  
              </script>
			<%
							} else if (aDisplayTagType.trim().equals("DBFORM")) {
							//dbform
							String form_s_onvalchange = "";
							String form_s_ondblink = "";
							String form_s_onfocusin = "";
							String form_s_onfocusout = "";
							String form_s_onkeypress = "";
							if (aEventList != null && aEventList.size() > 0) {
							for (int h = 0; h < aEventList.size(); h++) {
								ISetObjectEventParam aSetObjectEventParam = (ISetObjectEventParam) aEventList
									.get(h);
								String aEventName = aSetObjectEventParam.getEventName();
								String aEventFunc = aSetObjectEventParam.getEventFuncName();
								String aEventFuncName = aRowSetName + "_" + aEventName;
								if (aEventName.equalsIgnoreCase("onvalchange")) {
									form_s_onvalchange = aEventFuncName;
								} else if (aEventName.equalsIgnoreCase("ondblink")) {
									form_s_ondblink = aEventFuncName;
								} else if (aEventName.equalsIgnoreCase("onfocusin")) {
									form_s_onfocusin = aEventFuncName;
								} else if (aEventName.equalsIgnoreCase("onfocusout")) {
									form_s_onfocusout = aEventFuncName;
								} else if (aEventName.equalsIgnoreCase("onkeypress")) {
									form_s_onkeypress = aEventFuncName;
								}
								}
							}
							//输出tag
			%>
			<tr align="center">
				<td>
					
						
						<fieldset id="<%=i%>" style="width:100%;text-align:center;font-size:12">
						
							<legend>
								<%=aDescription%>
							</legend>
							<div style="width:<%=(new Long(aUiWidth).longValue())%>;height:<%=new Long(aUiHeight).longValue()%>">
							<ai:dbform formid="<%=aRowSetName%>" setname="<%=aSetName%>"
								datamodel="com.ai.appframe2.web.datamodel.MethodModelForService"
								implservice_name="<%=queryDataSV%>"
								implservice_querymethod="<%=queryDataSVFunction%>"

								editable="true" initial="<%=aInitial%>"
								ondblink="<%=form_s_ondblink%>"
								onfocusin="<%=form_s_onfocusin%>"
								onfocusout="<%=form_s_onfocusout%>"
								onvalchange="<%=form_s_onvalchange%>">
								<table>

									<%
										int tempColNum = 0;
										//循环所有字段
										for (int j = 0; j < aAttrSize; j++) {
												IBOObjectItemAttributeValue aObjectItemAttribute = (IBOObjectItemAttributeValue) aAttrList
													.get(j);
												String aWidth = "" + aObjectItemAttribute.getWidth();
												String aFieldName = aObjectItemAttribute.getName();
												String aTitleName = aObjectItemAttribute.getTitleName();
												String aEditable = aObjectItemAttribute.getIsEdit();
												String aColSpan = ""
													+ aObjectItemAttribute.getColSpan();
												if (aColSpan.trim().equals("") || aColSpan == null) {
													aColSpan = "1";
												}
												if (aEditable.equals("1")) {
													aEditable = "true";
												} else {
													aEditable = "false";
												}
												String aVisible = aObjectItemAttribute.getIsVisible();
												String isVisible = "true";
												if (aVisible.equals("0")) {
													isVisible = "false";
												}
									%>
									<%
											if (tempColNum == 0) {
									%>
									<tr>
									<%}%>
										<td class="FormTDName">
											<%=aTitleName%>
										</td>

										<td colspan="<%=aColSpan%>">
											<ai:dbformfield fieldname="<%=aFieldName%>"
												formid="<%=aRowSetName%>" visible="<%=isVisible%>"
												editable="<%=aEditable%>"
												width="<%=aWidth%>" height="20" />
										</td>

										<%
											tempColNum = tempColNum
												+ Integer.valueOf(aColSpan).intValue()+1;
											if (tempColNum >= aLineColNum*2) {
												tempColNum = 0;
										%>
									</tr>
									<%
											} 
									}
									%>
								</table>
							</ai:dbform>
						</div>
						</fieldset>
						<script language="javascript">
                  			function g<%=aRowSetName%>RowSet(){
                  				
                    			return g_FormRowSetManager.get("<%=aRowSetName%>");
                 			 }
                 			 <%if(!StringUtils.isEmptyString(queryDataSV) && !StringUtils.isEmptyString(queryDataSVFunction)){%>
                 			 query_<%=aRowSetName%>(g<%=aRowSetName%>RowSet());
                 			 <%}%>
              			</script>

				</td>
			</tr>

			<%
						}
					}
				}
				}//------2
				//配置js的输出
				EventRuleProcessHelper.writerRuleToPage(pageContext,request,out, autoformSV.getObjectJsRuleSetValue(jsRuleObjectId),EventRuleProcessHelper.getMap(request));
				
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		%>
		</table>
		<div id="com.ai.workflow.cmnet.so.page.savebutton" style="display:block;" align="center">
  			请选择处理结果：
  	  		<ai:listbox id="DSNodeFinishCode" ds="<%=aFinshCodeDS%>" initial="false" parameters="" width="100" nullid="-1" nulltext="请选择"/>
  	  		<p>  
      		审批意见：
      		<textarea rows='8' cols='70' id='view'></textarea>
      
			<p>      
      		<input align="middle" type="button" value=" 保 存 " onclick="save();" class="B"  style="width:100;cursor:hand;"/>
      
      		
      		
      		<input align="right" type="button" value=" 查看流程 " onclick="viewflow();"  class="B"  style="width:100;cursor:hand;"/>
      
  		</div>
	</BODY>
	<%
	//清除中心信息
	if(!StringUtils.isEmptyString(aCenterType)&&!StringUtils.isEmptyString(aCenterValue)){
			CenterFactory.popCenterInfo();
		} 
	%>
</HTML>
<script language="javascript">

	function getFinishCode(){
		return g_getListBox("DSNodeFinishCode");
	}

	var listcondition = "<%=listCondition%>";
	getFinishCode().refresh(listcondition);

	function save(){
	 	try{
			pageValidatePlugIn();
		}catch(err){	
		}
		
		var RowSetList=new Array();
		var finshcode = g_getListBox("DSNodeFinishCode").getID();
		var param = listcondition + "&aFinishCode="+finshcode+"&aTaskId=<%=aTaskId%>"
				+"&aDataCommitSv=<%=aWorkFlowNodeValue.getDataCommitSv()%>"+"&aDataCommitSvFunction=<%=aWorkFlowNodeValue.getDataCommitSvFunction()%>"
		<%
	    for (int i=0;i<setName.size();i++){
	      String aXmlName=(String)setName.get(i);
		%>
	        RowSetList[RowSetList.length]=g<%=aXmlName%>RowSet();
		<%
	    }
		%>
	    var r=saveRowSet('<%=request.getContextPath()%>/business/com.ai.comframe.autoform.web.AutoFormTempletAction?action=saveDataAndDoTask'+param,RowSetList,false,true);
	    var msg = r.getValueByName("retValue");
	    alert(msg);
  }



if (parent.resizeHeight)
  parent.resizeHeight("autopage");
</script>
