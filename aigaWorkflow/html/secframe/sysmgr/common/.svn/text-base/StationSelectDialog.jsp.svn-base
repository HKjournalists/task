<!--<html>
/************************************************

  Created Date:
  Project Name:
  Module Name:        添加员工的岗位
  Author:             黄诚
  Version:            1.0
  begin Version Date: 2004-06
  Last Version Date:  2004-06

************************************************/
-->
<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<ai:scriptinclude src="/secframe/common/common.js" />
<ai:scriptinclude src="/jsv2/json.js"/>
<html>
	<head>
		<title>选择岗位</title>
	</head>
	<body class="bodyTabPage">
		<span class=modeMenuName style="width:120;left:30;z-index:10;">岗位选择</span>
		<div align="center">

			<table border="0" cellspacing="0" cellpadding="0" class=modeContArea
				width="500" align="center">
				<tr>
					<td align="center">
						<form name="dlgFrm">
							<table border="0" width="470" cellspacing="0" cellpadding="0">
								<tr>
									<td colspan=3>
										&nbsp;
									</td>
								</tr>
								<tr height="15">
									<td class="FormTD">
										选择组织:
									</td>
									<td>
									</td>
									<td class="FormTD">
									</td>
								</tr>
								<tr height="15">
									<td colspan="3">
										&nbsp;&nbsp;
										<input type="text" class="dbform_disable_style" readonly
											id="orgName"
											value="<%=SessionManager.getUser().getOrgName()%>">
										<input type="hidden" id="orgId"
											value="<%=SessionManager.getUser().getOrgId()%>">
										<input type="button" style="width:40" value="..."
											id="selOrgBtn" onclick="selOrgAction()">
									</td>
									<td class="FormTD">
									</td>
								</tr>
								<tr>
									<td colspan=3>
										&nbsp;
									</td>
								</tr>
								<tr height="15">
									<td class="FormTD">
										可选岗位：
									</td>
									<td></td>
									<td class="FormTD">
										已选岗位：
									</td>
								</tr>
								<tr>
									<td rowspan="3" align="center">
										<select id="src_list" class="combo-hilite"
											style="width: 187; height: 221" size="10" name="src_list"
											multiple>
										</select>
									</td>
									<td height="72" valign="bottom" align="center">
										<ai:button style="cursor:hand;" text=">>" onclick="addItem()" />
									</td>
									<td rowspan="3" align="center">
										<select id="dst_list" class="combo-hilite"
											style="width: 187; height: 221" size="10" name="dst_list"
											multiple>
										</select>
									</td>
								</tr>
								<tr height="39">
									<td></td>
								</tr>
								<tr height="113">
									<td valign="top" align="center">
										<ai:button style="cursor:hand;" text="<<" onclick=" delItem()"/>
									</td>
								</tr>
								<tr height="40">
									<td colspan="3" valign="bottom" align="center" height="60">
										<ai:button style="cursor:hand;" text="确定" onclick="confirm()" />
										&nbsp;&nbsp;
										<ai:button text="取消" style="cursor:hand;" onclick="cancel()" />
									</td>
								</tr>
								<tr>
									<td colspan=3>
										&nbsp;
									</td>
								</tr>
							</table>
						</form>
					</td>
				</tr>
			</table>

		</div>
	</body>
<script language="javascript">
	
	var paraObj = window.dialogArguments;
	var singleFlag = paraObj.singleFlag;
	var arrStation = paraObj.arrStation;
	var orgId = document.getElementById("orgId");
	var orgName = document.getElementById("orgName");
	var srcList = document.getElementById("src_list");
	var dstList = document.getElementById("dst_list");
function inital(){
	if(singleFlag){
		srcList.multiple = false;
		dstList.multiple = false;
	}else{
		srcList.multiple = true;
		dstList.multiple = true;
	}
	qryStation();
}
function qryStation(){
	var ret = PostInfotoServer("<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.PrivilegeAction?action=qrySysStation&orgId="+orgId.value,"");
	 if(ret!=""&&ret!="NO"){
	 	var objJSON = ret.parseJSON();
		for(var i=0;i<objJSON.Station.length;i++){
			if(!isOldStation(objJSON.Station[i].stationId)){
				srcList[srcList.length] = new Option(objJSON.Station[i].stationName,objJSON.Station[i].stationId,false,false);
			}
		}
	 }
}
inital();
//判断是否已经有该属性
function isOldStation(pValue){
	if(arrStation==null) return false;
	for(var j=0;j<arrStation.length;j++){
		if(arrStation[j]!="null" && pValue==arrStation[j])
		 	return true;
    }
    return false;
}

function addItem(){
	if(singleFlag&&srcList.value!=""){
		for( var i=dstList.length-1;i>=0;i--)        {
          srcList[srcList.length] = new Option(dstList[i].text,dstList[i].value,false,false);
          dstList[i] = null;
        }        
	}
	for (var i=srcList.length-1;i>=0;i--) {
      if (srcList[i].selected) {
        //如果已经选择某个item,就不将其加入
        for(var m=0;m<dstList.length;m++){
            if(srcList[i].value == dstList[m].value)
                return;
        }
        dstList[dstList.length] = new Option(srcList[i].text,srcList[i].value,false,false);
        srcList[i] = null;
      }
    }
}
function delItem(){
	 for (var i=dstList.length-1;i>=0;i--) {
      if (dstList[i].selected) {
        srcList[srcList.length] = new Option(dstList[i].text,dstList[i].value,false,false);
        dstList[i] = null;
      }
    }
}
function confirm()
  {
    if (dlgFrm.dst_list.length < 1)
	{
      alert("请选择一个岗位名称!");
      return false;
	}
    var result = new Array();

	for (var i=0;i<dlgFrm.dst_list.length;i++){
		 result[i] = new Station(dlgFrm.dst_list.options[i].value,dlgFrm.dst_list.options[i].text);
	}
	window.returnValue = result;
	window.close();
}
function Station(stationId,stationName){
	this.stationId = stationId;
	this.stationName = stationName
}
function cancel()
{
    window.close();
}

//选择组织
function selOrgAction()
{
     var ret = orgSelectDialog(<%=com.ai.appframe2.common.SessionManager.getUser().getOrgId()%>);
     if(ret!=null){
     	orgId.value = ret[0].orgId;
     	orgName.value = ret[0].orgName;
     }
     qryStation();
}


</SCRIPT>
</html>
