<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/csc/common/taglib.jsp"%>
<%
   String funPointId = request.getParameter("funPointId");
   String objType = request.getParameter("objType");
%>
<html>
  <head>
    <title></title>
  </head>
  <body>
<div id="reqTrack_pucker"> <!--  class="popdownMain1"  -->
	<div id="reqTrack"    ><!-- class="popdownTitle"  onclick="document.all.childreqTrack.style.display=(document.all.childreqTrack.style.display =='block')?'none':'block';init_workflow_query_block()" -->
		<table	border="0" width="100%" height="10" style="padding: 0 0 0 0;margin: 0 0 0 0 ;">
			<tr onclick="onReqTrack_HideShow()"  style="cursor:hand;" >
			<td style="width:120;font-family:Arial, 黑体 10pt; padding: 0 5px 0 0;" align="right">
				<img src="<%=request.getContextPath()%>/csc/images/div/his.gif">&nbsp;历史轨迹
			</td>
			<td align="center" width="20" >
				<a style="align: center;" href="###"> <img id="show_hide_ico_track" src="<%=request.getContextPath()%>/csc/images/pucker/show.png" name="show_hide_ico" border="0" alt="提示：展开/隐藏"></a>
			</td>
			<td align="right" id="" class="EXT_line_bottom">&nbsp;</td>
			</tr>
		</table>
	</div> 
	<div id="childreqTrack" style="display:none"> 
    	<table  align="center" width="100%" height="30" style="BORDER-RIGHT: 1px solid; BORDER-TOP: 0px solid; BORDER-LEFT: 1px solid;BORDER-BOTTOM: 0px solid; TABLE-LAYOUT: fixed;BORDER-COLLAPSE: collapse">
  	<!--<tr >
      			<td width="120">&nbsp;
      			<td id="phase1" align="center" >
     				<img src="<%=request.getContextPath()%>/csc/images/reqtrack/reqtrack-1-1.gif" id="track1" border="0" onclick="show(1)">
     			</td> 
     			<td id="td_arrow1"><img src="<%=request.getContextPath()%>/csc/images/reqtrack/arrow.gif" id="arrow1" border="0"></td>
     			<td id="phase2" align="center" >
     				<img src="<%=request.getContextPath()%>/csc/images/reqtrack/reqtrack-2-1.gif" id="track2" border="0" onclick="show(2)">
     			</td> 
     			<td  id="td_arrow2"><img src="<%=request.getContextPath()%>/csc/images/reqtrack/arrow.gif" id="arrow1" border="0"></td>
     			<td id="phase3" align="center" >
     				<img src="<%=request.getContextPath()%>/csc/images/reqtrack/reqtrack-3-2.gif" id="track3" border="0" onclick="show(3)">
     			</td>
     			<td id="td_arrow3"><img src="<%=request.getContextPath()%>/csc/images/reqtrack/arrow.gif" id="arrow1" border="0"></td> 
     			<td id="phase4" align="center" >
     				<img src="<%=request.getContextPath()%>/csc/images/reqtrack/reqtrack-4-3.gif"  id="track4" border="0" onclick="show(4)">
     			</td>
     			<td  id="td_arrow4"><img src="<%=request.getContextPath()%>/csc/images/reqtrack/arrow.gif" id="arrow1" border="0"></td>
     			<td id="phase5" align="center" >
     				<img src="<%=request.getContextPath()%>/csc/images/reqtrack/reqtrack-5-3.gif"  id="track5" border="0" onclick="show(5)">
     			</td>
     			<td  id="td_arrow5"><img src="<%=request.getContextPath()%>/csc/images/reqtrack/arrow.gif" id="arrow1" border="0"></td>
     			<td id="phase6" align="center" >
     				<img src="<%=request.getContextPath()%>/csc/images/reqtrack/reqtrack-6-3.gif"  id="track6" border="0" onclick="show(6)">
     			</td>
     	</tr>-->
     	<tr>
   		<td width="120">&nbsp;</td>
   		<td colspan="11" id="workflowTd">
			<ai:stable tableid="workflowTable" setname="com.asiainfo.csc.common.web.SETWorkorderList"
					invoke_type="service" initial="false" footdisplay="none"
		            invoke_name="com.asiainfo.csc.common.service.WorkorderSV" 
		            invoke_querymethod="queryHisWorkorderList(String objId,String objType,int $STARTROWINDEX,int $ENDROWINDEX)"
		            invoke_countmethod="countHisWorkorderList(String objId,String objType)"
		            editable="false" needrefresh="true" multiselect="false"
		            width="100%" height="100" rowheight="-1" rowsequence="true"
		            ondbclick="toViewWorkOrder" oncontextmenu="">
	            <ai:col fieldname="OBJ_ID"  	width="80"  visible="false" 	/>
	            <ai:col fieldname="ORDER_ID"  	width="80"  visible="false" 	/>
	            
	            <ai:col fieldname="OBJ_NAME"  	width="80"  visible="true" 	/>
	            <ai:col fieldname="OBJ_TYPE"  	width="150"  visible="false" 	/>
				<ai:col fieldname="VM_TASK_NAME"  	width="200"  visible="true" 	/>
	            <ai:col fieldname="EMPLOYEE_NAME"  	width="100"  visible="true" 	/>         
	            <ai:col fieldname="CREATE_BEGIN_TIME"  		width="150"  visible="true" 	/>
	            <ai:col fieldname="ORDER_TYPE"  		width="80"  visible="false" 	/>
	            <ai:col fieldname="RESULT"  	width="150"  visible="true" 	/>
	            <ai:col fieldname="STATUS"  	width="150"  visible="true" 	/>
	            <ai:col fieldname="OPINION"  		width="300"  visible="true" 	/>
			</ai:stable>
		</td></tr>
		</table>
 	</div>
</div>
</body>
  <script type="text/javascript">
	var reqId = "";
    var cur_phase = "";
	var WOOrderid = "";
    initWorkflowQuery1(<%=funPointId%>,<%=objType %>);  
    
	//function workflow_initid(setId) {  reqId = setId;  initWorkflowQuery();}
	
	//预留函数,查询所有的数据
	function show(value){
	 	if(reqId==null||reqId==""){ return; }
	 	
	 	//var show_qry = "reqId="+reqId+"&phaseId="+cur_phase; 去除阶段过滤；
	 	var show_qry = "reqId="+reqId+'&phaseId='+"";
	 	
	 	// if(cur_phase==6){  alert('需求已完成'); 	}
	 	g_TableRowSetManager.get("workflowTable").refresh(null,show_qry);
	 	filterWorkorderResult();
	}
	function initWorkflowQuery1(objId,objType){
		var init_qry="objId="+objId+"&objType="+objType;
		g_TableRowSetManager.get("workflowTable").refresh(null,init_qry);
		filterWorkorderResult();
	}
	  //初始化函数
	function initWorkflowQuery(){
	  	if(reqId==null||reqId==""){	cscPrompt("ERROR：初始化workflow Track 错误，需求ID为：" + cur_phase,"error");return;	}
	    g_FormRowSetManager.get("reqFormWorkflowQuery").refresh("REQ_ID="+reqId);
	    cur_phase = g_FormRowSetManager.get("reqFormWorkflowQuery").getValue('CUR_PHASE');
	    
	    //var init_qry = "reqId="+reqId+"&phaseId="+cur_phase; 去除阶段过滤；
	    
	    var init_qry = "reqId="+reqId+"&phaseId="+"";
		if( cur_phase==null||cur_phase=="")	{cscPrompt("ERROR：当前阶段为NULL，程序错误" + cur_phase,"error");}
		if( init_qry==null||init_qry=="")	{cscPrompt("ERROR：查询条件为NULL，程序错误" + init_qry,"error");}
	 	var finalSize = 6;
	 	
	 	g_TableRowSetManager.get("workflowTable").refresh(null,init_qry);
		filterWorkorderResult();
	 /*	for(var i=1;i<finalSize;i++){
	    	if(i<cur_phase){
	    		document.getElementById('track'+i).src ="<%=request.getContextPath()%>/csc/images/reqtrack/reqtrack-"+i+"-1.gif";}
	     	if(i>cur_phase){ 
	     		document.getElementById('track'+i).src ="<%=request.getContextPath()%>/csc/images/reqtrack/reqtrack-"+i+"-3.gif";
	      	}
	     	if(i==cur_phase){
	     		document.getElementById('track'+i).src ="<%=request.getContextPath()%>/csc/images/reqtrack/reqtrack-"+i+"-2.gif";
	      	}
	 	}
	 	
	 	if((cur_phase==6)&&(cur_phase==finalSize)){
	 		document.getElementById('track'+6).src ="<%=request.getContextPath()%>/csc/images/reqtrack/reqtrack-"+6+"-1.gif"
	 	}*/
	 }
	  //单击为显示的情况下初始化
	function init_workflow_query_block(){
	   if('block'==$('#reqTrack').css('display')){workflow_initid('${param.reqId}');}
	}
	
	function show_workflow_history(boo){
	   if(boo){ $('#reqTrack_pucker').show(); }else{  $('#reqTrack_pucker').hide();}
	}
    
    function filterWorkorderResult(){
      var workflowTable = g_TableRowSetManager.get("workflowTable");
         var length = workflowTable.getTotalRowCount();
         var result = '';
         var newResult = '';
         for(var i=0;i<length;i++){
           result = workflowTable.getValue(i,'RESULT');
           if(result.length>0){newResult='完成';}
	       else if(result==''){newResult='待定';}
           else{
            newResult = '';
           }
           if(newResult!=''){
             workflowTable.setValue(i,'RESULT',newResult);
           }
         }
    }
    
   function onReqTrack_HideShow(){
		if(document.getElementById('childreqTrack').style.display=='none'){
			document.getElementById('childreqTrack').style.display = 'block';
			document.getElementById('show_hide_ico_track').src="<%=request.getContextPath()%>/csc/images/pucker/hide.png";
		}else {
			document.getElementById('childreqTrack').style.display='none';
			document.getElementById('show_hide_ico_track').src="<%=request.getContextPath()%>/csc/images/pucker/show.png";
		}
	} 
	
	function toViewWorkOrder(){
	   	var dealingTable = g_TableRowSetManager.get("workflowTable");
	 	var rowIndex = dealingTable.getRow();
	 	var ordertype = dealingTable.getValue(rowIndex,"ORDER_TYPE");
	 	var orderId = dealingTable.getValue(rowIndex,"ORDER_ID");
	 	var objId = dealingTable.getValue(rowIndex,"OBJ_ID");
	 	var objTag = dealingTable.getValue(rowIndex,"OBJ_NAME");
	 	var vmTaskNAME = dealingTable.getValue(rowIndex,"VM_TASK_NAME");
 		showWODetial(orderId);
 
 	}
 
	function showWODetial( WOOrderid ){

		var url = "<%=request.getContextPath()%>/csc/common/includes/WOForViewQueryHis.jsp?WOOrderid="+WOOrderid+"&showType=orderHis";

		window.showModalDialog(url,"org","scroll:no;resizable:no;status:no;dialogHeight:300px;dialogWidth:730px");

	}
  </script>
</html>