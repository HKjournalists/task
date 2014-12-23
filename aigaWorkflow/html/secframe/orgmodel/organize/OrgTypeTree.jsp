<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/secframe/common/common.jsp"%>
<html>
<head>
<title>组织类型树</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px">组织类型选择</td>
                <td align="right" style="height: 20px"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="left" style="padding-left:5px;" height="250" valign="top">
            <div id="byorg">
              <ai:dbtree_new 
 id="tree" height="380"  
 datamodel="com.ai.secframe.web.orgmodel.OrgTypeTreeModel" 
 initial="true" ishaveline="true" width="280"  multiselect="false" 
 onselect="select" onwillexpand="onwillexpand" ondblclick="oncommit" />
            </div></td>
        </tr>
      </table>	
		<table border=0 width=100% align="center">
			<tr>
				<td align="center">
				<input name="Input" type="button" class="btn-2word" value="确定" id="affirm" onClick="oncommit()"/>
				&nbsp;
				<input name="Input" type="button" class="btn-2word" value="取消" id="cancel" onClick="onclose()"/>
				</td>
			</tr>
		</table>
</body>

<script language="javascript">

function select(){
	return;
	
	var conStr = "";
	
	var dbtree = g_DBTreeNewManager.get("tree");
	var curNode = dbtree.getCurNodeInfo();
	if(curNode== null)
		return;
	
	conStr ="STATE=1 and FUNC_ID="+curValue ;
}

function oncommit(){    
    var dbtree = g_DBTreeNewManager.get("tree");
	var curNode = dbtree.getCurNodeInfo();
	if(curNode== null)
		return;
		
    window.returnValue = curNode.value+"|"+curNode.text;
    top.close();
} 

//不选,返回""  只为弹出框使用
function onnoselect(){
	window.returnValue = "clear";
	top.close();
}

//关闭窗口 只为弹出框使用
function onclose(){
	//window.returnValue = "";
	top.close();
}

//节点展开事件
function onwillexpand(){
}

//合并节点
function closeTree(){
  var dbtree = g_DBTreeNewManager.get("tree");
  var arr = dbtree.getChildrenNodesInfo(1);
  if(arr==null){
    return;
  }
  
  for(i=0;i<arr.length;i++){
    dbtree.expandNodeByValue(arr[i].value,false);
  }
  
  dbtree.setNodeSelect(1);
}

function refreshTree(){
   var dbtree = g_DBTreeNewManager.get("tree");
   var ud = dbtree.refresh(null,-1);
}
</script>
</html>
