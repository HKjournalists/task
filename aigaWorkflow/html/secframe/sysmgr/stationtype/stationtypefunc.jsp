<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="java.util.HashMap" %>
<%@include file="/secframe/common/common.jsp"%>
<HTML>
<HEAD>
<TITLE>岗位类型功能关系</TITLE>
<script language="JavaScript">
var selStationTypeId = null;
var funcids = "::";

function reloadStationType()
{
  var dbtree = g_DBTreeNewManager.get("stationtype_tree");
  var ud = dbtree.refresh(null,-1);
  dbtree.setCheckBoxSts(1,false);
}
function getFuncId(v){
		var msg = PostInfo("<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysStationTypeModel?"+
				"action=getFuncIds&stationTypeId="+v);
		funcids = msg.getValueByName("retVal"); 
		if(funcids=="-1"){
			alert("获取菜单IDS出错");
		}
}

//根据岗位类型查询该岗位类型的所拥有功能
function reloadStationTypeFunc()
{
	var stationtypeTree = g_DBTreeNewManager.get("stationtype_tree");
	var sysfunctionTree = g_DBTreeNewManager.get("sysfunction_tree");
	sysfunctionTree.setCheckBoxSts(1, false);
	var curNode = stationtypeTree.getCurNodeInfo();
	if(curNode.userobj=="STATION_TYPE"){
	//alert(curNode.value);
  	selStationTypeId=curNode.value;
  	getFuncId(selStationTypeId);
  	sysfunctionTree.setQueryCondtion("stationTypeId="+curNode.value);
  	var ud = sysfunctionTree.refresh(null,-1,"stationTypeId="+curNode.value);
    closeTree();
  	saveBtn.style.display="block";
	}else{
		var ud = sysfunctionTree.refresh(null,-1);
		var childNodes = sysfunctionTree.getChildrenNodesInfo(1);
		for(var i=0;i<childNodes.length;i++){
			sysfunctionTree.setCheckBoxSts(childNodes[i].value, false);
		}
		saveBtn.style.display="none";
	}
  
}

//保存用户所做的修改
function saveStationTypeFunc(){
	 var stationtypeTree = g_DBTreeNewManager.get("stationtype_tree");
	 
	 var curNode = stationtypeTree.getCurNodeInfo();
	 var stationTypeId = curNode.value;
   //将用户选择的funcId转化为数组
   //var dbtree = g_DBTreeNewManager.get("sysfunction_tree");
   //var objFirstNodes=dbtree.getChildrenNodesInfo(dbtree.getRootNodeInfo().value);
   //for(i=0;i<objFirstNodes.length;i++)
    //{
    // var objFirstNode=dbtree.getNodeInfo(objFirstNodes[i].value);
     
     //alert(objFirstNode); 
   // }
   //alert(objFirstNodes.length);
   //var selNodes = dbtree.getCheckedNodesInfo();
   //if (!selNodes && selNodes.length < 1) {
   //		return;
   //}
   //var funcIdStr = "::";
   /*
   for (var i = 0; i < selNodes.length; i++) {
    for(i=0;i<objFirstNodes.length;i++)
     {
      var objFirstNode=dbtree.getNodeInfo(objFirstNodes[i].value);
      if(selNodes[i].value==objFirstNode.value)
       setAllSubNodeSts(dbtree ,selNodes[i].value ,false);
     }
   }
   */
   //selNodes = dbtree.getCheckedNodesInfo();
   
   
   /*
   for (var i = 0; i < selNodes.length; i++) {
   		funcIdStr = funcIdStr + selNodes[i].value + ":";
   }

   for(i=0;i<objFirstNodes.length;i++)
     {
      if(funcIdStr.indexOf(":"+objFirstNodes[i].value+":")>0)
      {
        setAllSubNode(dbtree ,objFirstNodes[i].value);
      }
     }   
     selNodes = dbtree.getCheckedNodesInfo();
     
 
     for (var i = 0; i < selNodes.length; i++) {
   		funcIdStr = funcIdStr + selNodes[i].value + ":";
     }
     */
     //alert(funcids);
     //return;
	 var flag = PostInfotoServer( "<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysStationTypeModel?action=saveStationTypeFunc&stationTypeId="+stationTypeId,funcids);
	 if(flag=="OK"){
	 		alert("保存数据成功!");
			selFuncArray=null;
	 } else {
			alert(flag);
	 }
}

function printCurNodeInfo() {
	var dbtree = g_DBTreeNewManager.get("sysfunction_tree");
	var obj = dbtree.getCurNodeInfo();
}
function selectFunc()
{
	var dbtree = g_DBTreeNewManager.get("sysfunction_tree");
	var node=dbtree.getCurNodeInfo();
	if(node==null) return ;
	var value=node.value;
	var stationTypeId=-1;
	if(selStationTypeId!=null) stationTypeId=selStationTypeId;
	//alert('aa'+stationTypeId);
	dbtree.setQueryCondtion("stationTypeId="+stationTypeId);
}
function chkSelected(value,text,userobj,isChecked,nType) {
	var dbtree = g_DBTreeNewManager.get("sysfunction_tree");
	
	//var childs=dbtree.getChildrenNodesInfo(1);
	//alert(value);
	//if(dbtree.getChildrenNodesInfo(1)[0]!=null)
	//alert(value);
	if(isChecked){
		funcids = funcids.replace(":"+value+":",":");
		funcids = funcids + value +":";
	} else {
		funcids = funcids.replace(":"+value+":",":");
	}
	//alert(funcids);
	if(value!=1)
	{
	if(isChecked){
		setAllSubNodeSts(dbtree ,value ,true);
	}else if(!isChecked ){
		setAllSubNodeSts(dbtree ,value ,false);
	}
	setAllParNodeSts(dbtree,value);
	}
}
//递归设置下属所有节点状态
function setAllSubNode(dbtree ,parentValue ){
  //alert('uuu');
  var childrenNodes = dbtree.getChildrenNodesInfo(parentValue);
  //递归
  while(childrenNodes.length >0){
    var value = childrenNodes.pop().value;
    //dbtree.setNodeChecked(value,isChecked);

    //获取该节点的下属节点，放入数组
    var tmp = dbtree.getChildrenNodesInfo(value);
    if(tmp != null && tmp.length>0){
      childrenNodes = childrenNodes.concat(tmp);
    }
  }
}
//递归设置下属所有节点的选中或不选中的状态
function setAllSubNodeSts(dbtree ,parentValue , isChecked){
  var childrenNodes = dbtree.getChildrenNodesInfo(parentValue);

  while(childrenNodes.length >0){
		    var value = childrenNodes.pop().value;
		    
		    if(isChecked){
		    		funcids = funcids.replace(":"+value+":",":");
					funcids = funcids + value +":";
				} else {
					funcids = funcids.replace(":"+value+":",":");
				}
		    dbtree.setNodeChecked(value,isChecked);		
		    //获取该节点的下属节点，放入数组
		    var tmp = dbtree.getChildrenNodesInfo(value);
		    if(tmp != null && tmp.length>0){
		      childrenNodes = childrenNodes.concat(tmp);
		      
		    }			   
		  }
}
//递归设置上级所有节点的选中的状态
function setAllParNodeSts(dbtree ,curValue){
  var parentNode = dbtree.getParentNodeInfo(curValue);
  //alert(parentNode);
  //递归
  while(parentNode!=null){
    dbtree.setNodeChecked(parentNode.value,true);
    funcids = funcids.replace(":"+parentNode.value+":",":");
    funcids = funcids + parentNode.value +":";
    parentNode = dbtree.getParentNodeInfo(parentNode.value);
  }
}
</script>
</HEAD>
<body class="bodyTabPage" onLoad="closeTree();sysfunction_tree.setNodeSelect(1);">
<table width="100%" bgcolor="#FFFFFF" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="250" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"><table width="250" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px">岗位类型</td>
                <td align="right" style="height: 20px"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="left" style="padding-left:10px;"><ai:dbtree_new id="stationtype_tree" height="490" width="100%" datamodel="com.ai.secframe.web.sysmgr.SysStationTypeModel" initial="true" ishaveline="true" onselect="reloadStationTypeFunc" onwillexpand=""/>
          </td>
        </tr>
      </table></td>
    <td valign="top" width="80%"  style="padding-left:10px"><table width="100%" border=0 cellpadding=0 cellspacing=0 id="mainTable">
        <tr>
          <td valign="top"  bgcolor="#FFFFFF"><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
              <tr>
                <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
                    <tr>
                      <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                      <td style="height: 20px"> 关联权限</td>
                      <td align="right" style="height: 20px"><input name="" type="button" class="btn-2word" value="保存" id="saveBtn" onClick="saveStationTypeFunc()"/>
                      </td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td bgcolor="#FFFFFF" align="left" valign="top"><ai:dbtree_new id="sysfunction_tree" height="490" width="100%" datamodel="com.ai.secframe.web.sysmgr.SysStationTypeFunctionClModel" initial="false" ishaveline="true" multiselect="true" onwillexpand="selectFunc" oncheckboxclick="chkSelected" /></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</HTML><script type="text/javascript">
var sysfunction_tree = g_DBTreeNewManager.get("sysfunction_tree");
sysfunction_tree.setCheckBoxSts(1, false);
saveBtn.style.display="none";

function closeStationTypeTree()
{ 
  var dbtree = g_DBTreeNewManager.get("stationtype_tree");
  dbtree.refresh(null,-1);
  /*
  var arr = dbtree.getChildrenNodesInfo(1);
  if(arr==null){
    return;
  }
  
  for(i=0;i<arr.length;i++){
    dbtree.expandNodeByValue(arr[i].value,false);
  }
  */
}

//合并节点
function closeTree(){
  var arr = sysfunction_tree.getChildrenNodesInfo(1);
  
  if(arr==null){
    return;
  }
  
  for(i=0;i<arr.length;i++){
    sysfunction_tree.expandNodeByValue(arr[i].value,false);
  }
}
//closeStationTypeTree();
</script>
