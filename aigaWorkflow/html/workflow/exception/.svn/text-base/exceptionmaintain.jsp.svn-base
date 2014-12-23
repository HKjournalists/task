<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/webframe/common/commonhead.jsp"%>
<script src="<%=request.getContextPath()%>/jsv2/TabPage.js"></script>
<script src="<%=request.getContextPath()%>/jsv2/HtmlParameter.js"></script>
	<script type="text/javascript">
	var _descCodeToRule="";
	var _descCodeToRel="";
	var _descNameToRel="";
	function getParameter(itemId){
	var s=Math.random()*10000;
	//var a=document.all("main_tab");
	//var b=document.getElementById("main_tab").height;
	if (itemId==2){
	//alert(self.location.toString());
	
		_descCodeToRel=self.main_tab_1.queryDescCode();
		_descNameToRel=self.main_tab_1.queryDescName();
		var aUrl="desc2="+_descCodeToRel+"&descname="+_descNameToRel+"&rand="+s;
		return aUrl;
	}
	
	if (itemId==3){
		_descCodeToRule=self.main_tab_1.queryDescCode();
		
		var aUrl="desc="+_descCodeToRule+"&rand="+s;
		return aUrl;
		//    refreshTabItem("main_tab",itemId,null,aUrl);
		}
	}
	function switchTab1(){
		setTabItem("main_tab","1");
	}
	
	/* 也可以用window onload事件绑定事件监听函数
	function a(){
		var tem=document.getElementById("main_tab_Title_1");
		tem.onclick=function(){
		alert("a");
		}
	}
	*/
	</script>
<html>
	<head>
		<style type="text/css">
		</style>
	</head>

	<body >
	<div class="frame-title"><span>异常信息维护</span></div>
	<div class="frame-strip">
	<ai:pagearea id="页面主体区域">
	    <ai:tab id="main_tab" height="550" width="99%"  type="h" getParameter="getParameter">
		    <ai:tabitem id="1" src="exceptionDescMaintain.jsp" title="异常情形维护" width ="25" initial="true" ></ai:tabitem>
		    <ai:tabitem id="2" src="exceptionCodeDescRelation.jsp" title="异常原因与情形关系维护" width ="25"></ai:tabitem>
	  		<ai:tabitem id="3" src="exceptionRuleMaintain.jsp" title="异常处理规则维护"  width ="25"></ai:tabitem>
	  		
	   </ai:tab>
	</ai:pagearea>

	</div>
	</body>
	
</html>
