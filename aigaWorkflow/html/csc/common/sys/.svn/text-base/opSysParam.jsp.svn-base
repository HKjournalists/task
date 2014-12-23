<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ include file="/csc/common/taglib.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>系统参数表</title>
  </head>
  
  <body>
  <div class="div_title">
    	<table class="content_title" border="0">
			<tr>
				<td class="content_title_text">参数表</td>
			</tr>
		</table>
    	<ai:stable tableid="tblSysParam" setname="com.asiainfo.csc.common.web.SETSysParam"
			height="200" width="100%" footdisplay="true" needrefresh="true" initial="false"
			invoke_type="service" invoke_name="com.asiainfo.csc.common.service.SysParamSV"
			invoke_querymethod="getAllSysParam()"
			editable="false" multiselect="false" rowheight="-1" pagesize="" rowsequence="true"
			oncontextmenu="" ondbclick="refreshSysParamFrm" >
			<ai:col fieldname="PARAM_ID" width="100" visible="false" />
			<ai:col fieldname="PARAM_TYPE"  width="200"  visible="true" />
			<ai:col fieldname="PARAM_NO"  width="200"  visible="true" />
			<ai:col fieldname="PARAM_NAME"  width="200"  visible="true" />
			<ai:col fieldname="PARAM_DISC"  width="100"  visible="true" />
			<ai:col fieldname="PARAM_RELA_ID"  width="100"  visible="true" />
			<ai:col fieldname="PARAM_VALUE"  width="100"  visible="true" />
			<ai:col fieldname="SORT_ID"  width="100"  visible="true" />
		</ai:stable>
		</div>
		<div class="div_title">
		<table class="content_title" border="0">
			<tr>
				<td class="content_title_text">操作区域</td>
				<td align="right">
					<ai:button text="新增" onclick="newSysParam()" />
					<ai:button text="保存" onclick="saveSysParam()" />
					<ai:button text="删除" onclick="delSysParam()" />
				</td>
			</tr>
		</table>
		<ai:dbform setname="com.asiainfo.csc.common.web.SETSysParam" formid="sysParamFrm" initial="false" editable="true">
    	<ai:dbformfield fieldname="PARAM_ID" formid="sysParamFrm" visible="false"/>
			<table width="100%" align="center" class="table_context">
				<tr>
					<td class="title_e">PARAM_NAME：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="PARAM_NAME" formid="sysParamFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">PARAM_NO：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="PARAM_NO" formid="sysParamFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">PARAM_TYPE：</td>	
					<td class="aiEdit_3col"><ai:dbformfield fieldname="PARAM_TYPE" formid="sysParamFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
				</tr>
				<tr>
					<td class="title_e">PARAM_RELA_ID：</td>	
					<td class="aiEdit_3col"><ai:dbformfield fieldname="PARAM_RELA_ID" formid="sysParamFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">PARAM_VALUE：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="PARAM_VALUE" formid="sysParamFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
					<td class="title_e">PARAM_DISC：</td>
					<td class="aiEdit_3col"><ai:dbformfield fieldname="PARAM_DISC" formid="sysParamFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
				</tr>
				<tr>
					<td class="title_e">SORT_ID：</td>
					<td class="aiEdit_3col" colspan="5"><ai:dbformfield fieldname="SORT_ID" formid="sysParamFrm" visible="true" width="<%=aiEdit_3cw%>"/></td>
				</tr>
			</table>
    	</ai:dbform>
	</div>
  </body>
  <script type="text/javascript">
  	var tblSysParam = g_TableRowSetManager.get("tblSysParam");
  	var sysParamFrm = g_FormRowSetManager.get("sysParamFrm");
  	
  	initOpSysParam();
  	
  	function initOpSysParam() {
  		tblSysParam.refresh(null,null);
  	}
  	
  	function refreshSysParamFrm() {
  		var curRow = tblSysParam.getRow();
  		sysParamFrm.refresh("param_id="+tblSysParam.getValue(curRow,"PARAM_ID"));
  	}
  	
  	function newSysParam() {
  		sysParamFrm.newRow();
  	}
  	
  	function saveSysParam() {
  		var list = new Array();
  		list.push(sysParamFrm);
  		var url = "<%=request.getContextPath()%>/business/com.asiainfo.csc.common.web.OpTableAction?action=saveSysParam";
  		var result = saveRowSet(url,list,true,false);
  		var retVal = result.getValueByName("retVal");
  		alert(retVal);
  		if(retVal == "Y") {
  			tblSysParam.refresh(null,null);
  			if(sysParamFrm.getValue("PARAM_ID") == "") {
	  			newSysParam();
  			}
  		}
  	}
  	
  	function delSysParam() {
  		if(!confirm("确定删除该条数据吗？")) {
  			return;
  		}
  		var list = new Array();
  		list.push(sysParamFrm);
  		var url = "<%=request.getContextPath()%>/business/com.asiainfo.csc.common.web.OpTableAction?action=delSysParam";
  		var result = saveRowSet(url,list,true,false);
  		var retVal = result.getValueByName("retVal");
  		alert(retVal);
  		if(retVal == "Y") {
  			tblSysParam.refresh(null,null);
  			newSysParam();
  		}
  	}
  	
  </script>
</html>
