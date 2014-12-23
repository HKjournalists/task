<!DOCTYPE HTML>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/aiga/common/common.jsp"%>
<%
	String tempId = request.getParameter("tempId");
%>

<html>
  <head>
    <title></title>
	<style type="text/css">
		ul {
			list-style: none;
		}
		table td {
			padding: 5px;
			border: 1px solid;
		}
		table th {
			width: 280px;
			padding: 5px;
			border: 1px solid;
		}
	</style>
  </head>
  
  <body>
    <div id="content"></div>
  </body>
  <script type="text/javascript">
  	$(function(){
  		//MaskLoading();
  		$.ajax({
    		async: false,
  			url: '<%=request.getContextPath()%>/getRelaFunHistory.do',
  			data: 'tempId=<%=tempId%>',
  			success: function(data) {
  				$("#content").html(data);
  			}
  		});
    	//MaskOver();
  	});
  </script>
</html>
