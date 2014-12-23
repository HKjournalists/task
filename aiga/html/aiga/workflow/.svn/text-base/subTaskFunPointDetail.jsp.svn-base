<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.asiainfo.aiga.requisition.bo.AigaTestSubTask"%>
<%@page import="com.asiainfo.aiga.funPoint.bo.AigaFunPoint"%>
<%@page import="com.asiainfo.aiga.userCase.bo.AigaSecene" %>
<%@page import="com.asiainfo.aiga.userCase.bo.extend.AigaInstCase" %>
<%
	AigaTestSubTask aigaTestSubTask = (AigaTestSubTask)request.getAttribute("aigaTestSubTask");
%>
<!DOCTYPE>
<html>
  <head>
    <title>子任务包含功能点详细信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
  </head>
  
  <body style="border:none">
  	<div>
  		<span><%=aigaTestSubTask.getSubTaskName().replaceAll("<","&lt;").replaceAll(">","&gt;") %>:包含功能点详细信息列表</span>
  	</div>
    <div>
      <%
      	List<AigaFunPoint> aigaFunPointsList = new LinkedList<AigaFunPoint>();
      	aigaFunPointsList  = (List<AigaFunPoint>)request.getAttribute("aigaFunPointsList");
      	int funOrder = 1;
      	try{
      		if(!aigaFunPointsList.isEmpty()){//功能点不为空的时候执行
          		Iterator funIterator = aigaFunPointsList.iterator();
          		while(funIterator.hasNext()){
          			AigaFunPoint aigaFunPoint = (AigaFunPoint)funIterator.next();
    	  %>
          <p><font size="5"><%=funOrder %> 功能点:<%=aigaFunPoint.getSysName().replaceAll("<","&lt;").replaceAll(">","&gt;")%></font></p>
          <%		
    				Map<String,List<AigaInstCase>> casesMaps = new HashMap<String,List<AigaInstCase>>();
          			casesMaps = (Map<String,List<AigaInstCase>>)request.getAttribute("casesMaps");
          			if(!casesMaps.isEmpty()){//有功能点关联用例的时候执行
          				List<AigaInstCase> instCaseList = (List<AigaInstCase>)casesMaps.get(aigaFunPoint.getFunId().toString());
          				if(instCaseList!=null&&!instCaseList.isEmpty()){//当前功能点关联用例的时候执行
          					Iterator instCaseIterator = instCaseList.iterator();
          					int caseOrder = 1;
          					while(instCaseIterator.hasNext()){
          						AigaInstCase aigaInstCase = (AigaInstCase)instCaseIterator.next();
          						%>
          <p><font size="4"><%=funOrder %>.<%=caseOrder++ %> 用例名称:<%=aigaInstCase.getCaseName().replaceAll("<","&lt;").replaceAll(">","&gt;") %></font></p>
          <p><font size="3">场景名称:<%
          try{
        	  Map<String,String> secenesMaps = new HashMap<String,String>();
        	  String senceneName = "";
        	  secenesMaps = (Map<String,String>)request.getAttribute("secenesMaps");
        	  if(secenesMaps!=null){
        	  	  senceneName =  secenesMaps.get(aigaInstCase.getSecId().toString());
        	  	  request.setAttribute("senceneName",senceneName);
        	  }else{
        	  	  request.setAttribute("senceneName","暂未关联场景");
        	  }
          }catch(Exception e){
        	  request.setAttribute("senceneName","暂未关联场景");
          } %><%=request.getAttribute("senceneName") %></font><br></p>
          <table width="834" border="1" table-layout="fixed">
    		<tr>
   			  <td width="278" align="center" style="background-color: rgb(0, 128, 255);"><strong>&nbsp;<font color="#ff0000">前置条件</font><br></strong></td>
   			  <td width="278" align="center" style="background-color: rgb(0, 128, 255);"><strong><font color="#ff0000">操作说明 </font><br></strong></td>
   			  <td width="278" align="center" style="background-color: rgb(0, 128, 255);"><strong>&nbsp;<font color="#ff0000">预期结果</font><br></strong></td>
    		</tr>
    		<tr>
    		  <%try{%>
    			<td width="278"><%=aigaInstCase.getCasePreCond().replaceAll("<","&lt;").replaceAll(">","&gt;") %></td>		
    			<%}catch(Exception e){%>
    			</td>
    			<%}try{%>
    			<td width="278"><%=aigaInstCase.getCaseOperateInst().replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("&lt;br/&gt;","<br/>") %></td>		
    			<%}catch(Exception e){%>
    			</td>
    			<%}try{%>
    			<td width="278"><%=aigaInstCase.getPreResult().replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("&lt;br/&gt;","<br/>")  %></td>		
    			<%}catch(Exception e){%>
    			</td>
    			<%}%>
    		  </tr>
    	  </table>					
          				   <%}
          				}else{%>
          <p>暂未关联用例!</p>					
          			  <%}
          			}else{%>
     	  <p>暂未关联用例!</p>		
     	  		  <%}
          			funOrder++;
          		}
          	}else{%>
     	  <p>暂未关联功能点!</p>		
     	  <%}
      	}catch(Exception e){%>
       	  <p>暂未关联功能点!</p>		
      <%}%>
    </div>
  </body>
</html>
