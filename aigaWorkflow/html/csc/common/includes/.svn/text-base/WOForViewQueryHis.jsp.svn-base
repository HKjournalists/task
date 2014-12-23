<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/csc/common/taglib.jsp"%>
<%
	String WOOrderid = request.getParameter("WOOrderid");
	String showType = request.getParameter("showType");
%>

<html>
  <body>
		<table align="center" width="100%">
			<ai:dbform formid="frmOrder" setname="com.asiainfo.csc.common.web.SETWorkorderList"
				implservice_name="com.asiainfo.csc.common.service.WorkorderSV"
				implservice_querymethod="getWorkOrderListByOrderId(Long orderId)" 
				datamodel="com.ai.appframe2.web.datamodel.MethodModelForService"
				initial="false" editable="false" >
				<ai:dbformfield fieldname="ORDER_ID" formid="frmOrder" visible="false"/>
					  <tr>
						<td class="title_e">工单对象</td>
						<td class="aiEdit_4col"><ai:dbformfield fieldname="ORDER_TYPE" formid="frmOrder" editable="false" width="150" /></td>
						<td class="title_e">处理结果</td>
						<td class="aiEdit_4col"><ai:dbformfield fieldname="RESULT" formid="frmOrder" editable="false" width="150" /></td>
					</tr>
					<tr>
						<td class="title_e">状态</td>
						<td class="aiEdit_4col"><ai:dbformfield fieldname="STATUS" formid="frmOrder" 	editable="false" 	width="150" /></td>
						<td class="title_e">创建时间</td>
						<td class="aiEdit_4col"><ai:dbformfield fieldname="CREATE_TIME" formid="frmOrder" editable="false" width="150" /></td>
					</tr>
					<tr>
				    	<td class="title_e">完成时间</td>
						<td class="aiEdit_4col"><ai:dbformfield fieldname="FINISH_TIME" formid="frmOrder" editable="false" 	width="150" /></td>
						<td class="title_e">所属环节</td>
						<td class="aiEdit_4col"><ai:dbformfield fieldname="VM_TASK_NAME" formid="frmOrder" editable="false" width="150" /></td>
					</tr>
					<tr>
				    	<td class="title_e">执行人姓名</td>
						<td class="aiEdit_4col"><ai:dbformfield fieldname="EMPLOYEE_NAME" formid="frmOrder" editable="false" 	width="150" /></td>
					</tr>
					<tr>
						<td class="title_e" align="center">处理意见</td>
						<td class="aiEdit_4col" colspan="3"><ai:dbformfield fieldname="OPINION" formid="frmOrder" editable="false" width="350" height="100" /></td>
					</tr>
			</ai:dbform>
		</table>
  </body>
  <script type="text/javascript">
  	var showType = "<%=showType%>";
  	var WOOrderid = "<%=WOOrderid%>";
  	initWOView();
  	function getFrmWorkOrder(){
		return g_FormRowSetManager.get("frmOrder");
	}
  	
  	function initWOView(){
  		if(showType=="orderHis"){
  			initWOinfo();
  		}
  		filterWorkorderResult();
  	}
  	function initWOinfo(){
  		getFrmWorkOrder().refresh("orderId="+WOOrderid);
  	}
  	
  	function filterWorkorderResult(){
		var result = getFrmWorkOrder().getValue("RESULT");
        var newResult = '';
        var finishtime=getFrmWorkOrder().getValue("FINISH_TIME");
        var newFinishtime='';
        if(result.length>0){newResult='完成';}
	    else if(result==''){newResult='待定';}
        else{newResult='';}
		if(newResult!=''){
        	getFrmWorkOrder().setValue('RESULT',newResult);
		}
		if(finishtime==''){newFinishtime='未完成';}
		else{newFinishtime='';}
		if(newFinishtime!=''){
			getFrmWorkOrder().setValue('FINISH_TIME',newFinishtime);
		}
    }
  </script>
</html>





