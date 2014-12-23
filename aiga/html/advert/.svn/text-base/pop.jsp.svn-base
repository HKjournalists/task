<!DOCTYPE HTML>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<html>
	<head>
		<title>测试管理平台</title>
				<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/base/jquery-1.8.0.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/base/yanue.pop.js" ></script>
				<script type="text/javascript" src="<%=request.getContextPath()%>/aiga/common/commonUtil.js" ></script>
		<style type="text/css">
			*{margin:0;padding:0;}
			#pop{background:#fff;width:260px;border:1px solid #e0e0e0;font-size:12px;position: fixed;right:10px;bottom:10px;}
			#popHead{line-height:32px;background:#249edc;border-bottom:1px solid #e0e0e0;position:relative;font-size:12px;padding:0 0 0 10px;}
			#popHead h2{font-size:14px;color:#F5EDED;line-height:32px;height:32px;}
			#popHead #popClose{position:absolute;right:10px;top:1px;}
			#popHead a#popClose:hover{color:#f00;cursor:pointer;}
			#popContent{padding:5px 10px;background:#d5e2f2;}
			#popTitle a{line-height:24px;font-size:14px;font-family:'微软雅黑';color:#333;font-weight:bold;text-decoration:none;}
			#popTitle a:hover{color:#f60;}
			#popIntro{text-indent:24px;line-height:160%;margin:5px 0;color:#666;}
			#popMore{text-align:right;border-top:1px dotted #ccc;line-height:24px;margin:8px 0 0 0;}
			#popMore a{color:#f60;}
			#popMore a:hover{color:#f00;}
		</style>
	</head>
	<body>
		<div id="pop" style="display:none;">
			<div id="popHead">
				<a id="popClose" title="关闭">关闭</a>
				<h2>温馨提示</h2>
			</div>
		<div id="popContent">
				<dl>
					<dt id="popTitle"><a href="http://127.0.0.1/" target="_blank">这里是参数</a></dt>
					<dd id="popIntro">这里是内容简介</dd>
				</dl>
			<p id="popMore"><a href="http://127.0.0.1/" target="_blank">查看 »</a></p>
		</div>
	</div>
	</body>
	<script LANGUAGE="JavaScript">
		function stop(timeout){
			 clearInterval(timeout);
			}
		
		  function showResultText(btn, text){
		        Ext.example.msg('Button Click', 'You clicked the {0} button and entered the text "{1}".', btn, text);
		    };
		$(document).ready(function(){
			var _YMD="";
			var _mStart=06;
			var _mEnd=06;
			var _sStart=00;
			var _sEnd=00;
			var _ss=00;
			var timeStart;
			var timeEnd;
			var timeStart,timeEnd;
			var messageFormat="";
			var timeout=null;
			timer = function(){
				var now=new Date();
				_YMD = now.getFullYear()+"-"+(now.getMonth() + 1)+"-"+now.getDate();
				var m=now.getMinutes();
				var s=now.getSeconds();
				timeStart=_YMD+" "+timeStart;
				timeEnd=_YMD+" "+timeEnd;
				var oDateStart = new Date(timeStart.replace(/-/g,"/"));
				var oDateEnd = new Date(timeEnd.replace(/-/g,"/"));
				
				if(oDateStart<now&&oDateEnd>now){
					stop(timeout);
					var params= ["<%=((AigaUser)request.getSession().getAttribute("aigaUser")).getUserName()%>","北京时间",now.Format('yyyy-MM-dd hh:mm:ss')]; 
					var pop=new Pop("日报填写提醒","daily/testDailyMain.jsp",formatParams(messageFormat,params));
					}
			  }
			$.getJSON("<%=request.getContextPath()%>/getTimer.do",{},function(data){
				timeStart=data.timer[0];
				timeEnd=data.timer[1];
				messageFormat=data.message;
				 timeout=setInterval("timer()",1000);
				 });
			
		});
	</script>
</html>