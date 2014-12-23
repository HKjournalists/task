<!--
/**
 * 选择扩展BO话框.
 * @param 包括:
          oldStaffArray-员工过滤数组.在该数组中的BONAME不显示在选择列表中.
          isSingleSel-是否单选标志,1表示每次只能选择一个,2表示可以选择多个
          winObj-window对象

 * @return 通过window.returnVal返回每个选定BO的name,如果选择多个BO则多个名值对以","分隔.
           若选择"取消",返回"undefined";
 * @author: HuangCheng
*/
-->

<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/secframe/common/common.jsp"%>

<html>
	<head>
	</head>
	<SCRIPT LANGUAGE="JavaScript" for="window" even="onload">

</SCRIPT>
	<script language="javascript">

//查询出所有的BO对象
function getAllBoNames()
{
   var url = "<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.PrivilegeAction?action=queryExtendBo";
   var retVal = PostInfotoServer(url,"");
   var newBoArray = retVal.split(",");
   for(var i=0;i<newBoArray.length;i++)
   {
       if( !isOldBo( newBoArray[i] ) && newBoArray[i] != "" )
         srcList[srcList.length] = new Option( newBoArray[i],newBoArray[i],false,false);
   }
}

//判断BO是否已经存在于老的BO数组中
function isOldBo( boName )
{
  for( var i=0;i<oldArray.length;i++)
  {
    if( oldArray[i] == boName )
       return true;
  }
  return false;
}

function confirmFunc()
{
    var result = "";
    for (var i=0;i<srcList.length;i++)
    {
      if( srcList[i].selected )
        result += srcList[i].text+",";
    }
    if (result.charAt(result.length-1) == ',')
	result = result.substr(0,result.length-1);
    window.returnValue = result;
    window.close();
}

function cancel()
{
    window.returnValue = "undefined";
    window.close();
}

</script>

	<body onload="getAllBoNames()">
		<span class=modeMenuName style="width:120;left:30;z-index:10;">BO对象选择</span>
		<div align="center">
			<table border="0" cellspacing="0" cellpadding="0"
				class="modeContArea" width="410" align="center">
				<tr>
					<td class="FormTD" align="center">
						<br>
						<select id="src_list" class="combo-hilite"
							style="width: 380; height: 330" size="10" name="src_list"
							multiple>
						</select>
					</td>
				</tr>
				<tr>
					<td align="center" height="50" valign="middle">
						<ai:button style="cursor:hand;" text=" 确定 " onclick="confirmFunc()" />
						&nbsp;&nbsp;
						<ai:button style="cursor:hand;" text=" 取消 " onclick="cancel()" />
					</td>
				</tr>
				<tr style="height:10px">
					<td>
					</td>
				</tr>
			</table>
		</div>
	</body>
	<SCRIPT LANGUAGE="JavaScript" for="window" even="onload">
    var gParamObject = dialogArguments;
    /********************参数列表*******************/
    var oldArray = null;
    //单选和多选标志
    var isSingleSel = 1;
    var winObj = null;
    window.returnValue = "undefined";
    var srcList = document.all.item("src_list").options;
    if(gParamObject)
    {
	   //获取参数
        oldArray = gParamObject.oldArray;
        isSingleSel =  gParamObject.isSingleSel;
        winObj = gParamObject.winObj;
       //设置单选或者多选
	if(isSingleSel==1)
	    document.all.item("src_list").multiple = false;
        else
	    document.all.item("src_list").multiple = true;
    }
</script>
</html>
