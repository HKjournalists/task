<!DOCTYPE HTML>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String valJson = request.getParameter("valJson");
	if(valJson != null) {
		//valJson = new String(valJson.getBytes("ISO-8859-1"),"UTF-8");
	}
	//System.out.println(valJson);
%>

<html>
	<head>
		<title>性能测试单</title>
		<script type="text/javascript" src="../../jquery/base/jquery-1.6.1.js"></script>
		<style type="text/css">
			.base-input {
				width: 100px;
				border-style: none;
			}
			.left-tbl {
				float: left;
				border-right: none;
			}
			.right-tbl {
				float: left;
			}
			table tr td {
				height: 30px;
			}
			.two-row {
				height: 62px;
			}
			.three-row {
				height: 98px;
			}
			.four-row {
				height: 120px;
			}
			.five-row {
				height: 162px;
			}
			table {
				background: #d3e1f1;
				border: 1px solid #99bce8;
			}
			table tr td  {
				border: 1px solid white;
				font-size: 14px;
				font-weight: 60;
				background: #d3e1f1;
			}
			table tr td label {
				display: inline-block;
				width: 80px;
			}
			table tr {
				border-style: none;
			}
			.border-td {
				border: 1px solid #d3e1f1;
				font-size: 14px;
				font-weight: 60;
			}
			.no-bottom-border {
				border-bottom: none;
				width: 100px;
			}
			.label-div {
				display: inline-block;
				width: 100px;
				position: absolute;
				z-index: 99;
				top: 23px;
			}
			.no-top-border {
				border-top: none;
			}
			textarea,dis_channel {
				width: 99%;
				height: 100%;
				display: inline-block;
				resize: none;
				padding-right: 1px;
				border-style: none;
				overflow: auto;
				outline: none;
			}
			input[type=text] {
				height: 98%;
				padding: 1px 2px 1px 1px;
				border-style: none;
				outline: none;
			}
		</style>
	</head>
	<body>
		<div style="display: inline-block;">
			<form id="perSubTaskForm">
			<input type="hidden" name="perId" />
			<input type="hidden" name="acceptChannel" />
			<table class="left-tbl" cellspacing="0" cellpadding="0">
				<tr>
					<td>系统名称</td>
					<td class="border-td"><input type="text" class="base-input" name="sysName" /></td>
					<td class="border-td no-bottom-border" rowspan="2">
						<div class="label-div">
							<label><input type="radio" name="busiType" disabled>现有业务</label><br>
							<label><input type="radio" name="busiType" disabled checked="checked">新业务</label>
						</div>
					</td>
					</tr>
				<tr>
					<td>业务/功能名称</td>
					<td class="border-td" colspan="2"><input type="text" class="base-input" name="busiName" /></td>
				</tr>
				<tr class="two-row">
					<td>简要说明</td>
					<td colspan="2" class="two-row border-td"><textarea name="simpleDesc"></textarea></td>
				</tr>
				<tr class="three-row">
					<td>受理渠道</td>
					<td colspan="2" class="three-row border-td" id="acceptChannel">
						<span>
							<label><input type="checkbox" name="channelCheck" text="CRM" />CRM</label>
							<label><input type="checkbox" name="channelCheck" text="社会渠道" />社会渠道</label><br>
							<label><input type="checkbox" name="channelCheck" text="接口" />接口</label>
							<label><input type="checkbox" name="channelCheck" text="客服" />客服</label><br>
							<label><input type="checkbox" name="channelCheck" text="其它" />其它</label><br>
							<label style="width: 150px;padding-left: 5px;">请说明<input id="channelText" name="channelText" style="border-style:none;border-bottom: 1px solid;width: 100px;background:#d3e1f1;outline:none;margin-left: 5px;" /></label>
						</span>
					</td>
				</tr>
				<tr>
					<td>渠道业务量比例</td>
					<td colspan="2" class="border-td"><textarea name="proportion"></textarea></td>
				</tr>
				<tr class="two-row">
					<td>测试建议</td>
					<td colspan="2" class="two-row border-td"><textarea name="testOpinion"></textarea></td>
				</tr>
			</table>
			<table class="right-tbl" cellspacing="0" cellpadding="0">
				<tr>
					<td>平均响应时间要求</td>
					<td colspan="2" class="border-td"><textarea name="averageTimeRequire"></textarea></td>
				</tr>
				<tr>
					<td rowspan="4" class="four-row">交易处理能力</td>
					<td>每秒交易数TPS</td>
					<td class="border-td"><input type="text" class="base-input" name="tps" /></td>
				</tr>
				<tr>
					<td>高峰一小时交易量</td>
					<td class="border-td"><input type="text" class="base-input" name="peakBusi" /></td>
				</tr>
				<tr>
					<td>业务量最大地市</td>
					<td class="border-td"><input type="text" class="base-input" name="busiCity" /></td>
				</tr>
				<tr>
					<td>高峰日或高峰小时说明</td>
					<td class="border-td"><input type="text" class="base-input" name="peakDesc" /></td>
				</tr>
				<tr>
					<td rowspan="5" class="five-row">资源占用要求</td>
					<td>Web服务器</td>
					<td class="border-td"><input type="text" class="base-input" name="webServer" /></td>
				</tr>
				<tr>
					<td>接口服务器</td>
					<td class="border-td"><input type="text" class="base-input" name="interServer" /></td>
				</tr>
				<tr>
					<td>APP服务器</td>
					<td class="border-td"><input type="text" class="base-input" name="appServer" /></td>
				</tr>
				<tr>
					<td>数据库服务器</td>
					<td class="border-td"><input type="text" class="base-input" name="dbServer" /></td>
				</tr>
				<tr>
					<td>其它服务器</td>
					<td class="border-td"><input type="text" class="base-input" name="otherServer" /></td>
				</tr>
			</table>
			</form>
		</div>
		<div style="text-align: center;margin-top: 2px;">
			<input type="button" value="提交保存" onclick="refreshParent()" />
			<input type="button" value="取消" onclick="window.parent.closePerFrame()" />
		</div>
	</body>
	<script type="text/javascript">
		$(function(){
			var valJson = "<%=valJson%>";
			refreshPerSubTaskForm(valJson);
		});
		
		function getValJson() {
			var json = "{";
			$("#perSubTaskForm").find(":input[name!=channelCheck]").each(function(){
				var name = $(this).attr("name");
				var curVal = $(this).val()
				json += "'"+name+"':'"+ curVal + "',";
			});
			var channelCheckVal = "'";
			$("#perSubTaskForm").find("input[name=channelCheck]").each(function(){
				if($(this).attr("checked")) {
					channelCheckVal += $(this).attr("text") + ","
				}
			});
			channelCheckVal += "'";
			channelCheckVal = channelCheckVal.replace(",'","'");
			json += "'channelCheck':"+channelCheckVal;
			json += "}";
			json = json.replace(",}","}");
			return json;
		}
		
		function refreshPerSubTaskForm(valJson) {
			var json = eval("("+valJson+")");
			$("#perSubTaskForm").find(":input[name!=channelCheck]").each(function(){
				var name = $(this).attr("name");
				$(this).val(json[name]);
				if(name == "acceptChannel" && json[name] != "") {
					$("#acceptChannel").html(json[name]);
				}
			});
			var chanStr = json.channelCheck;
			if(!chanStr) {
				return;
			}
			var checkValAry = chanStr.split(",");
			for(var i = 0; i < checkValAry.length; i++) {
				$("input[name=channelCheck][text="+checkValAry[i]+"]").attr("checked",true);
			}
		}
		
		function refreshParent() {
			var valJson = getValJson();
			window.parent.closePerFrame(valJson);
		}
		
	</script>
</html>
