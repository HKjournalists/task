<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String workOrderFlag = request.getParameter("workOrderFlag");
if(workOrderFlag==null||!workOrderFlag.equals("workOrder")){
	workOrderFlag = "";
}
%>

<script type="text/javascript">


function setConds(conds,key,value)
{
	var condStr = '';
	if(conds.indexOf('<conds>')>=0&&conds.indexOf('</conds>')>=0)
	{
		var str_length = conds.length;//得到字符串的长度
		var str_conds_pos = conds.indexOf("</conds>");//
		var str_num = conds.substr(0,str_conds_pos);//截取数字
		var str_px = conds.substr(str_conds_pos,str_length-str_conds_pos);//截取px
		condStr  = condStr + str_num + '<cond name="'+key+'" value="'+value+'">' + '</cond>' + str_px;
	}
	else
	{
		condStr = condStr + '<conds>';
		condStr = condStr + '<cond name="'+key+'" value="'+value+'">' + '</cond>'
		condStr = condStr + '</conds>';
	}
	return condStr;
}

function reLoadOrderList(flag){
	<%
		if(workOrderFlag!=null&&workOrderFlag.equals("workOrder")){
			%>
	window.parent.location.href = '<%=request.getContextPath()%>/aiga/workflow/common/WorkorderList.jsp';		
			<%
		}else{
			%>
	if(flag=='startTestPlan'){
            var _taskWin = top.Ext.getCmp("taskFormWin");
            _taskWin.setTitle("测试计划执行");
            _taskWin.close();
	}else{
		window.location.href = '<%=request.getContextPath()%>/aiga/workflow/common/WorkorderList.jsp';
	}
			<%
		}
	%>
}
</script>
