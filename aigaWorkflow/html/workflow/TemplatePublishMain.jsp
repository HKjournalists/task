<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/webframe/common/commonhead.jsp"%>
<script src="<%=request.getContextPath()%>/jsv2/TabPage.js"></script>
<script src="<%=request.getContextPath()%>/jsv2/HtmlParameter.js"></script>
<script type="text/javascript">
function getParameter(itemId){
	var s=Math.random()*10000;
	
	if (itemId==1){
	//alert(self.location.toString());
		var aUrl="rand="+s;
		return aUrl;
	}
	if (itemId==2){
		var aUrl="rand="+s;
		return aUrl;
		}
	}
</script>
<html>
	<head>
		<style type="text/css">
		</style>
	</head>

	<body >
	<div class="frame-title"><span>流程发布</span></div>
	<div class="frame-strip">
	<ai:pagearea id="页面主体区域" >
	    <ai:tab id="main_tab" height="550" width="99%"  type="h" getParameter="getParameter">
		    <ai:tabitem id="1" src="TemplateQuery.jsp" title="模板查询" width ="25" initial="true" ></ai:tabitem>
		    <ai:tabitem id="2" src="TemplatePublish.jsp" title="模板发布" width ="25"></ai:tabitem>	  		
	   </ai:tab>
	</ai:pagearea>

	</div>
	</body>
	
</html>
