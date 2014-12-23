<!DOCTYPE html>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/aiga/common/common.jsp"%>
<%
	String subTaskId = request.getParameter("subTaskId");
%>
<html>
	<head>
		<title>需求分析</title>
		<style type="text/css">
			
			#qryFunDiv {
				display: inline-block;
				padding-top: 10px;
			}
			
			input[type=button] {
				width: 60px;
				height: 20px;
				line-height: 20px;
			}
			
			span,label {
				/*
				*/
				text-overflow: ellipsis;
				white-space: nowrap;
				overflow: hidden;
			}
			
			.sel-label {
				display: inline-block;
				border: 1px solid rgb(240, 240, 240);
				cursor: pointer;
				height: 20px;
				line-height: 20px;
				margin-right: 20px;
			}
			
			.sel-label span {
				display: inline-block;
				height: 20px;
				line-height: 20px;
			}
			
			.sel-label img {
				width: 12px;
				height: 12px;
				border-style: none;
				vertical-align: top;
				position: relative;
				top: 3px;
			}
			
			.left-area {
				display: inline-block;
				width: 120px;
				height: 100%;
				vertical-align: middle;
				float: left;
			}
			
			.right-area {
				display: inline-block;
				width: 620px;
				float: left;
				max-height: 70px;
				overflow: auto;
				margin-right: 20px;
			}
			
			.select-label {
				display: inline-block;
				width: 850px;
				border: 1px dashed rgb(200, 200, 200);
				padding: 10px;
			}
			
			.sel-div {
				margin-bottom: 10px;
			}
			
			.sel-span {
				display: inline-block;
				width: 90px;
				height: 20px;
				line-height: 20px;
				margin-left: 12px;
			}
			
			.select-label span {
				display: inline-block;
				width: 120px;
				height: 20px;
				line-height: 20px;
			}
			
			.select-label label:hover {
				color: rgb(200, 50, 50);
				cursor: pointer;
			}
			
			.operate-div {
				display: inline-block;
				width: 800px;
				height: 30px;
				line-height: 30px;
				text-align: center;
			}
		</style>
	</head>
	<body>
		<div id="qryFunDiv">
			<div class="sel-div">
				<span class="sel-span">已选标签 -></span>
				<label class="sel-label"><span id="busiSelLabel"></span><img src="<%=request.getContextPath()%>/css/images/del.gif" onclick="delBusiLabel()"/></label>
				<label class="sel-label"><span id="baseSelLabel"></span><img src="<%=request.getContextPath()%>/css/images/del.gif" onclick="delBaseLabel()" /></label>
				<input type="button" value="查询" style="position: relative;left: 100px;" onclick="getFunFoldersByLabel()" />
			</div>
			<div id="singleBase" class="select-label">
				<div class="left-area">
					基础业务标签：
				</div>
				<div class="right-area">
				</div>
				<input type="button" value="多选" onclick="multiplyBaseLabel()" />
			</div>
			<div id="multiplyBase" class="select-label">
				<div class="left-area">
					基础业务标签：
				</div>
				<div class="right-area">
				</div>
				<div class="operate-div">
					<input type="button" value="确定" onclick="multiplyBaseSelLabel()" />
					<input type="button" value="取消" onclick="cancelMultiplyBase()" />
				</div>
			</div>
			<div id="singleBusi" class="select-label">
				<div class="left-area">
					业务标签：
				</div>
				<div class="right-area">
				</div>
				<input type="button" value="多选" onclick="multiplyBusiLabel()" />
			</div>
			<div id="multiplyBusi" class="select-label">
				<div class="left-area">
					业务标签：
				</div>
				<div class="right-area">
				</div>
				<div class="operate-div">
					<input type="button" value="确定" onclick="multiplyBusiSelLabel()" />
					<input type="button" value="取消" onclick="cancelMultiplyBusi()" />
				</div>
			</div>
		</div>
		<div id="qryFunGrid"></div>
	</body>
	<script type="text/javascript">
		
		Ext.onReady(function(){
			Ext.tip.QuickTipManager.init();
			relaFunFolder();
			$("#multiplyBusi").hide();
			$("#multiplyBase").hide();
			$("#busiSelLabel").parent().hide();
			$("#baseSelLabel").parent().hide();
			
			Ext.create('Ext.grid.Panel', {
				title: '查询结果',
				selModel: Ext.create('Ext.selection.CheckboxModel',{mode:"SIMPLE"}),
				id: 'qryFunGrid',
				renderTo: Ext.getBody(),
				width: '100%',
				height: 240,
				store: Ext.create('Ext.data.Store', {
					autoLoad: false,
					method: 'post',
					layout: 'vbox',
			        model: parent.FuncPoint,
			        proxy: {
			        	async:false,
			            type: 'ajax',
			            url: '<%=request.getContextPath()%>/getFunFoldersByLabel.do?subTaskId=<%=subTaskId%>',
			            reader: {
			                type: 'json',
			                root: 'data'
			            }
			        }
				}),
				columns: [
					{xtype: 'rownumberer'},
					{header:'功能点名称', dataIndex:'sysName', width: 200},
					{header:'菜单路径', dataIndex:'menuPath', width: 300},
					{header:'基础业务标签', dataIndex:'baseFunLabel', width: 200},
					{header:'业务标签', dataIndex:'busiLabel', width: 200}
				],
				buttons: [
					{text:'添加选中功能点', handler:function(){addSelFunFolder()}}
				]
			})
		});
		
		function relaFunFolder() {
			$.ajax({
				url: '<%=request.getContextPath()%>/getComBoxForBusi.do',
				type: 'post',
				dataType: 'json',
				async: false,
				data: '',
				success: function(json) {
					var busiLabels = json.data;
					var singleArea = "";
					var multiplyBusi = "";
					for(var i = 0; i < busiLabels.length; i++) {
						singleArea += "<span><label onclick='singleBusiLabel()' labelVal='"+busiLabels[i].value+"' title='"+busiLabels[i].show+"'>"+busiLabels[i].show+"</label></span>";
						multiplyBusi += "<span><label title='"+busiLabels[i].show+"'><input type='checkbox' value='"+busiLabels[i].value+"' />"+busiLabels[i].show+"</label></span>";;
					}
					$(singleArea).appendTo($("#singleBusi>.right-area"));
					$(multiplyBusi).appendTo($("#multiplyBusi>.right-area"));
				}
			});
			
			$.ajax({
				url: '<%=request.getContextPath()%>/getComBoxForBaseBusi.do',
				type: 'post',
				dataType: 'json',
				async: false,
				data: '',
				success: function(json) {
					var baseLabels = json.data;
					var singleArea = "";
					var multiplyBase = "";
					for(var i = 0; i < baseLabels.length; i++) {
						singleArea += "<span><label onclick='singleBaseLabel()' labelVal='"+baseLabels[i].value+"' title='"+baseLabels[i].show+"'>"+baseLabels[i].show+"</label></span>";
						multiplyBase += "<span><label title='"+baseLabels[i].show+"'><input type='checkbox' value='"+baseLabels[i].value+"'/>"+baseLabels[i].show+"</label></span>";;
					}
					$(singleArea).appendTo($("#singleBase>.right-area"));
					$(multiplyBase).appendTo($("#multiplyBase>.right-area"));
				}
			});
		}
		
		function multiplyBusiLabel() {
			$("#singleBusi").hide();
			$("#multiplyBusi").show();
		}
		
		function multiplyBaseLabel() {
			$("#singleBase").hide();
			$("#multiplyBase").show();
		}
		
		function multiplyBaseSelLabel() {
			var val = new Array();
			var dis = new Array();
			$("#multiplyBase input[type=checkbox]:checked").each(function(){
				val.push($(this).val());
				dis.push($(this).parent().attr("title"));
			});
			val += "";
			dis += "";
			if(val != "") {
				setBaseLabel(val, dis);
			}
			$("#multiplyBase").hide();
			$("#singleBase").hide();
		}
		
		function multiplyBusiSelLabel() {
			var val = new Array();
			var dis = new Array();
			$("#multiplyBusi input[type=checkbox]:checked").each(function(){
				val.push($(this).val());
				dis.push($(this).parent().attr("title"));
			});
			val += "";
			dis += "";
			if(val != "") {
				setBusiLabel(val, dis);
			}
			$("#multiplyBusi").hide();
			$("#singleBusi").hide();
		}
		
		function cancelMultiplyBusi() {
			$("#multiplyBusi").hide();
			$("#singleBusi").show();
		}
		
		function cancelMultiplyBase() {
			$("#multiplyBase").hide();
			$("#singleBase").show();
		}
		
		function singleBusiLabel() {
			var val = $(event.srcElement).attr("labelVal");
			var dis =  $(event.srcElement).html();
			setBusiLabel(val, dis);
			$("#singleBusi").hide();
			$("#multiplyBusi").hide();
		}
		
		function singleBaseLabel() {
			var val = $(event.srcElement).attr("labelVal");
			var dis =  $(event.srcElement).html();
			setBaseLabel(val, dis);
			$("#singleBase").hide();
		}
		
		function setBusiLabel(val, dis) {
			$("#busiSelLabel").attr("labelVal",val);
			$("#busiSelLabel").html(dis);
			$("#busiSelLabel").parent().show();
			hideXMask();
		}
		
		function setBaseLabel(val, dis) {
			$("#baseSelLabel").attr("labelVal",val);
			$("#baseSelLabel").html(dis);
			$("#baseSelLabel").parent().show();
			hideXMask();
		}
		
		function delBusiLabel() {
			$("#busiSelLabel").attr("labelVal","");
			$("#busiSelLabel").html("");
			$("#busiSelLabel").parent().hide();
			$("#singleBusi").show();
		}
		
		function delBaseLabel() {
			$("#baseSelLabel").attr("labelVal","");
			$("#baseSelLabel").html("");
			$("#baseSelLabel").parent().hide();
			$("#singleBase").show();
		}
		
		function hideXMask() {
			$(".x-mask").each(function(){
				if($(this).css("visibility") == "hidden") {
					$(this).addClass("not-dis");
				}
			});
		}
		
		function getFunFoldersByLabel() {
			var busiLabels = $("#busiSelLabel").html();
			var baseLabels = $("#baseSelLabel").html();
			Ext.getCmp('qryFunGrid').getStore().load({params:{busiLabel:busiLabels, baseFunLabel:baseLabels}});
		}
		
		function addSelFunFolder() {
			var records = Ext.getCmp('qryFunGrid').getSelectionModel().getSelection();
			if(records.length == 0) {
				Ext.Msg.alert("提示","请选择数据");
				return;
			}
			parent.addLabelFuns(records);
			parent.Ext.getCmp('relaFunWin').close();
		}
		
	</script>
</html>