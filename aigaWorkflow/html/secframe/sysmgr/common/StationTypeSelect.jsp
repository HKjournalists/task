<!--
/**
 * 岗位类型选择对话框.
 * @param 包括:
          oldStaffArray-岗位类型过滤数组.在该数组中的不显示在选择列表中.
          isSingleSel-是否单选标志,1表示每次只能选择一个,2表示可以选择多个
          winObj-window对象

 * @return 通过window.returnVal返回每个选定的n岗位类型的名称及ID,如果选择多个则多个名值对以","分隔.
           若选择"取消",返回"undefined";
 * @author: HuangCheng
*/
-->

<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<ai:scriptinclude src="/secframe/common/common.js" />
<ai:scriptinclude src="/jsv2/json.js" />
<html>
	<head>
		<title>选择岗位</title>
	</head>

	<body>
		<center>
			<span class=modeMenuName style="width:120;left:30;z-index:10;">岗位类型选择</span>
			<div align="center">
				<table border="0" cellspacing="0" cellpadding="0"
					class="modeContArea" width="410" align="center">
					<tr>
						<td class="FormTD" align="center">
							<br>
							<select id="src_list" class="combo-hilite"
								style="width: 380; height: 330" size="10" name="src_list"
								multiple="true">
							</select>
							
						</td>
					</tr>
					<tr>
						<td align="center" height="50" valign="middle">
							<ai:button text=" 确定 " style="cursor:hand;"
								onclick="confirmFunc()" />
							&nbsp;&nbsp;
							<ai:button text=" 取消 " style="cursor:hand;" onclick="cancel()" />
						</td>
					</tr>
				</table>
			</div>
		</center>
	</body>
</html>
<script language="javascript">
var paraObj = window.dialogArguments;
var singleFlag = paraObj.singleFlag;
var oldArray = paraObj.arrStatType;
var srcList = document.getElementById("src_list");
//查询出所有的岗位类型
function inital(){

  if(singleFlag)
  	srcList.multiple = true;
  else 
  	srcList.multiple = false; 
  var ret = PostInfotoServer("<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.PrivilegeAction?action=qrySysStationType","");
  if(ret!=null&&ret!="NO"){
  	var statTpye = ret.parseJSON();
  	for(var i=0;i<statTpye.StationType.length;i++){
  		if(!isOldStationType(statTpye.StationType[i].statTypeId))
  			srcList[srcList.length] = new Option(statTpye.StationType[i].statTypeName,statTpye.StationType[i].statTypeId,false,false);
  	}
  } 	
}
inital();
//
function isOldStationType( stationTypeId )
{
	if(oldArray==null)
		return false;
  for( var i=0;i<oldArray.length;i++)
  {
    if( oldArray[i] == stationTypeId )
       return true;
  }
  return false;
}

function confirmFunc()
{
    var result = new Array();
    for (var i=0;i<srcList.length;i++)
    {
      if( srcList[i].selected )
        result.push(new StationType(srcList[i].value,srcList[i].text));
    }
    window.returnValue = result;
    window.close();
}
function StationType(statTypeId,statTypeName){
	this.statTypeId = statTypeId;
	this.statTypeName = statTypeName;
}
function cancel()
{
    window.close();
}

</script>
