<!--
/************************************************

  Created Date:
  Project Name:
  Module Name:        添加MO 操作
  Author:             邢献杰
  Version:            1.1
  begin Version Date: 2007-07
  Last Version Date:  2007-07

************************************************/
-->
<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai"%>
<%@include file="/secframe/common/common.jsp"%>

<script language="JavaScript"
	src="<%=request.getContextPath()%>/jsv2/CommUtil.js"></script>
<script language="JavaScript"
	src='<%=request.getContextPath()%>/secframe/common/common.js'>
</script>
<html>

	<head>
		<title>新增MO操作</title>
		<SCRIPT LANGUAGE="JavaScript" for="window" even="onload">
          var gParamArray = dialogArguments;

function MoOp(func_id,name, is_query, title ,func_name)
{
    
    this.func_id = func_id;
    this.name = name;
    this.is_query = is_query;   
    this.title = title;  
    this.func_name=func_name;
}

   function insertFunc()
   {
   	
   	
    var dbformMoOp = g_FormRowSetManager.get("dbformMoOp");
    


   	if( dbformMoOp.getValue("NAME") == null ||
        dbformMoOp.getValue("NAME") == ""){
   			alert("必须输入操作名称");
   			return;
   		}
    var objRelat=new MoOp(dbformMoOp.getValue("FUNC_ID"),dbformMoOp.getValue("NAME"),dbformMoOp.getValue("IS_QUERY"),dbformMoOp.getValue("TITLE"),dbformMoOp.getValue("EXT1"));
    
    window.returnValue = objRelat;
	window.close();    
   }

   function closeWindowFunc()
   {
    top.close();
   }

   function bodyLoad()
   {

   }
</script>
	</head>

	<body onLoad="bodyLoad()" class=modeBody>
		<div id="MyFormArea">
							<fieldset id="content" style="text-align:left;font-size:12"
						align="left">
						<LEGEND class=FormZName>
							MO操作详细信息
						</LEGEND>
			<table border=0 cellpadding=0 cellspacing=0 id=AutoNumber2
				class=modeContArea>

				<ai:dbform formid="dbformMoOp"
					setname="com.ai.secframe.bo.sysmgr.SysMoOp"
					datamodel="com.ai.appframe2.web.datamodel.QueryModelForService"
					implservice_name="com.ai.secframe.service.sysmgr.SysMoOp"
					implservice_querymethod="getBeans" initial="false"
					editable="true">
					<ai:dbformfield formid="dbformMoOp" fieldname="FUNC_ID"
									width="170" height="20" editable="true" visible="false" />
					<table border=0 cellspacing=0 width="350" cellpadding=0
						class="FormTD" align="center">
						<tr>
							<td colspan=4 align="center" height="10"></td>
						</tr>

							
							<tr>
							<td width="100" class="FormTDName">
								名称:
							</td>
							<td width="215" class="FormTD" colspan=3>
								<ai:dbformfield formid="dbformMoOp" fieldname="NAME"
									width="200" height="20" editable="true" visible="true" />
								<span class="pr9">*</span>
							</td>
						</tr>
						<tr>

							<td width="100" class="FormTDName">
								是否查询:
							</td>
							<td height=20 colspan=3 class="FormTD" width="215">
								<ai:dbformfield formid="dbformMoOp" fieldname="IS_QUERY"
									width="200" height="20" editable="true" visible="true" />
								<span class="pr9">*</span>
							</td>
							
						</tr>
						<tr>
							<td width="100" class="FormTDName">
								标题:
							</td>
							<td height=20 colspan=3 class="FormTD" width="215">
								<ai:dbformfield formid="dbformMoOp" fieldname="TITLE"
									width="200" height="20" editable="true" visible="true" />
								
							</td>
							
						</tr>						
						<tr>
							<td width="100" class="FormTDName">
								菜单名称:
							</td>
							<td height=20 colspan=3 class="FormTD" width="215">								
								<ai:dbformfield formid="dbformMoOp" fieldname="EXT1"
									width="165" height="20" editable="false" visible="true" />
									<input type="button" value="..." onclick="sel_func()">
								
							</td>
							</tr>						
						<tr></tr><tr></tr>
						<tr>
							<td height=30 colspan='4' align="center">
														<ai:button text="确    定" id="okBtn"
															onclick="insertFunc()" style="cursor:hand"></ai:button>
														<ai:button text="取    消" id="cancelBtn"
															onclick="closeWindowFunc()" style="cursor:hand"></ai:button>

							</td>
						</tr>
					</table>
				</ai:dbform>
			</table>
			</fieldset>
		</div>
	</body>
	<script language="javascript">
	var dbformMoOp=g_FormRowSetManager.get("dbformMoOp");
	dbformMoOp.setValue("IS_QUERY","N");
	dbformMoOp.setValue("FUNC_ID","0");
	dbformMoOp.setValue("EXT1","无");
	
	function sel_func()
	{
	 
	 var ret = funcSelectDialog(-1);
     if(ret!=null){
     dbformMoOp.setValue("FUNC_ID",ret[0].funcId);
     dbformMoOp.setValue("EXT1",ret[0].funcName);
     
     //document.all("ORG_NAME").value=ret[0].orgName;
     //alert(ret[0].orgId+""+ret[0].orgName)
     }
	}
</script>

</html>
