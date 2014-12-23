<%@page contentType="text/html; charset=GBK"%>
<%@include file="/csc/common/taglib.jsp"%>
<html>
  <head>
  	<title>批量导入</title>
  	<style type="text/css">
  		p {
  			font-size: 14px;
  			line-height: 15px;
  			font-family: "Tahoma", "黑体", "Helvetica", "sans-serif";
  			color: #5371ba;
  			font-weight: 500;
  		}
  	</style>
  </head>
  <body style="padding: 0px 6px 0px 6px;text-align: center;">
	<div id="proviceAppraiseDiv" class="div_title"  style="width: 960px;">
		<table class="content_title" border="0">
			<tr class="content_title_text"> 
				<td>模板说明</td>
		    	<td align="right">
		    		<!-- 
		    		<input type="button" class="btn-4word" value="下载模板" id="clear"  onclick="downStaffExcel()"/>
		    		 -->
		    	</td>
			</tr>
		</table>
		<table width="100%" cellpadding="0" cellspacing="0">
			<thead>
				<tr class="GH-TR">
					<th class="GH-TD">用户名</th>
					<th class="GH-TD">工号</th>
					<th class="GH-TD">角色</th>
					<th class="GH-TD">组织名称</th>
				</tr>
			</thead>
			<tbody style="height: 100px; width: 100%;padding-top: 20px;padding-bottom: 50px;background: rgb(227,234,242);">
				<tr><td colspan="8">
					<p>
						1、请在界面上先配置组织再导入数据，excel中的组织名称要正确
					</p>
					<p>
						2、有一个员工在多个组织下的情况，请在excel中最多配置一条数据，导入后在页面继续添加，本模板只导入直属组织
					</p>
					<p>
						3、请不要修改模板
					</p>
					<p>
						4、角色名称要与数据库对应，以“,”分割
					</p>
					<p>
						5、excel中第一行为标题行，数据从第二行开始
					</p>
				</td></tr>
			</tbody>
		</table>
		<table class="content_title" border="0">
			<tr class="content_title_text"> 
				<td>数据导入</td>
		    	<td>
		    		<form id="fileForm" enctype="multipart/form-data" method="post" target="hiddenFrame" >
		    			<input id="uploadFile" type="file" name="uploadFile" />
		    			<input type="button" class="btn-2word" id="subBtn" value="提交" onclick="dealStaffExcel()" />
		    		</form>
		    		<iframe name="hiddenFrame" style="display:none;"></iframe>
		    	</td>
			</tr>
		</table>
		
	</div>	
  </body>
  <script>
  	function downStaffExcel() {
  		var url = "<%=request.getContextPath()%>/importStaffServlet?method=getExcelDemo&random="+Math.random();
  		window.location.href = url;
  	}
  	
  	function dealStaffExcel() {
  		var val = $("#uploadFile").val();
  		if(val == null || val == "") {
  			alert("请先选择文件再上传");
  			return;
  		}
  		$("#subBtn").attr("disabled",true);
  		$("#fileForm").attr("action","<%=request.getContextPath()%>/importStaffServlet?method=dealStaffExcel&random="+Math.random());
  		$("#fileForm").submit();
  	}
  	
  	function dealCallback(callBackMsg) {
  		alert(callBackMsg);
  		if(callBackMsg == "导入成功") {
  			$("#subBtn").attr("disabled",true);
  		} else {
  			$("#subBtn").attr("disabled",false);
  		}
  	}
  	
  </script>
</html>

