<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ include file="/csc/common/taglib.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>查看工单信息</title>
  </head>
  
  <body>
  <div id="allocationReqDeal_div" class="div_title">
  		<table class="content_title" border="0">
			<tr>
				<td class="content_title_text">工单信息</td>
			</tr>
		</table>
   		<ai:dbform setname="com.asiainfo.csc.common.web.SETWorkorderList" formid="viewWOForm" initial="false" editable="true">
    	<ai:dbformfield fieldname="ORDER_ID" formid="viewWOForm" visible="false"/>
    	<ai:dbformfield fieldname="OBJ_ID" formid="viewWOForm" visible="false"/>
    	<ai:dbformfield fieldname="EXEC_STAFF_ID" formid="viewWOForm" visible="false"/>
    	
			<table width="100%" align="center" class="table_context">
			<tr>
				<td class="title_e">执行结果：</td>
				<td class="aiEdit_3col"><ai:dbformfield fieldname="COND" formid="viewWOForm" visible="true" width="<%=aiEdit_3cw%>"/></td>
				<td class="title_e">工单执行人：</td>
				<td class="aiEdit_3col"><ai:dbformfield fieldname="EMPLOYEE_NAME" formid="viewWOForm" visible="true" width="<%=aiEdit_3cw%>"/></td>
			</tr>
			<tr>
				<td class="title_e">承载对象类型：</td>	
				<td class="aiEdit_3col"><ai:dbformfield fieldname="OBJ_TYPE" formid="viewWOForm" visible="true" width="<%=aiEdit_3cw%>"/></td>
				<td class="title_e">工单类型：</td>	
				<td class="aiEdit_3col"><ai:dbformfield fieldname="ORDER_TYPE" formid="viewWOForm" visible="true" width="<%=aiEdit_3cw%>"/></td>
				<td class="title_e">所处环节：</td>
				<td class="aiEdit_3col"><ai:dbformfield fieldname="LINK_ID" formid="viewWOForm" visible="true" width="<%=aiEdit_3cw%>"/></td>
			</tr>
			<tr>
				<td class="title_e">创建时间：</td>
				<td class="aiEdit_3col"><ai:dbformfield fieldname="CREATE_BEGIN_TIME" formid="viewWOForm" visible="true" width="<%=aiEdit_3cw%>"/></td>
				<td class="title_e">完成时间：</td>
				<td class="aiEdit_3col"><ai:dbformfield fieldname="FINISH_TIME" formid="viewWOForm" visible="true" width="<%=aiEdit_3cw%>"/></td>
				<td class="title_e">状态：</td>
				<td class="aiEdit_3col"><ai:dbformfield fieldname="STATUS" formid="viewWOForm" visible="true" width="<%=aiEdit_3cw%>"/></td>
			</tr>
			<tr>
				<td class="title_e" valign="top" style="line-height:28px;">执行人留言：</td>
				<td class="aiEdit_3col" colspan="5"><ai:dbformfield fieldname="OPINION" formid="viewWOForm" visible="true" width="<%=aiEditArea_4cw%>" height="<%=aiEditArea_high_min%>"/></td>
			</tr>
			</table>
    	</ai:dbform>
	</div>
  </body>
</html>
