<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<html>
<head>
<title>添加权限点页面</title>
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
      <tr>
        <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
            <tr>
              <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
              <td style="height: 20px">岗位选择</td>
              <td align="right" style="height: 20px"></td>
            </tr>
        </table></td>
      </tr>
	   <tr>	  
        <td bgcolor="#FFFFFF" align="left" style="padding-left:5px;" height="30">组织选择
<input disabled="disabled" id="orgName" value="" size="14" />
&nbsp;
<input type="button" value="..." id="selOrgBtn" onClick="org_select()" class="btn-1word">
		</td>
      </tr>
      <tr>
	  
        <td bgcolor="#FFFFFF" align="left" style="padding-left:5px;" height="300" valign="top"><div id="byorg">
            <ai:dbtree_new id="stationTree"
      	datamodel="com.ai.secframe.web.sysmgr.StationTreeModel"
      	multiselect="true" height="100%" width="250" ishaveline="true"
      />
        </div></td>
      </tr>
    </table>
	<table border=0 width=100% align="center">
      <tr>
        <td align="center"><input name="Input" type="button" class="btn-2word" value="确定" id="affirm" onClick="ok()"/>
          &nbsp;
          <input name="Input2" type="button" class="btn-2word" value="取消" id="cancel" onClick="cancel()"/>
        </td>
      </tr>
    </table>
</body>
</html>
<SCRIPT LANGUAGE="JavaScript" for="window" even="onload">
      var party_id = "-1";
      var party_role_id = "-1";
      var root_organize_id ="-1";
	  var staff_id = <%=request.getParameter("staff_id")%>;
      var hasStationList = dialogArguments;
    function initData(){
            //document.all("selOrgBtn").disabled =false;
            var tree = g_DBTreeNewManager.get("stationTree");
            tree.setCheckBoxSts(-1,false);
            var root = tree.getRootNodeInfo();
            var tmpChildList = tree.getChildrenNodesInfo(root.value);
            //递归调用孩子节点
            for(var i=0;i<tmpChildList.length;i++){
              if(tmpChildList[i].userobj =='STATION'){
                for(var j=0;j<hasStationList.length;j++){
                  if(hasStationList[j] == tmpChildList[i].value){
                    tree.setNodeChecked(tmpChildList[i].value,true);
                    tree.setCheckBoxSts(tmpChildList[i].value,false);
                    break;
                  }
                }
              }else{
                 tree.setCheckBoxSts(tmpChildList[i].value,false);
              }
            }
        }


	function ok(){
           var tree = g_DBTreeNewManager.get("stationTree");
           var selectNodes = tree.getCheckedNodesInfo();
            var result = new Array();
			//alert(selectNodes.length);
            for(var i=0;i<selectNodes.length;i++)
              if(selectNodes[i].userobj =='STATION'){
                 var isInOld = false;
                    for(var j=0;j<hasStationList.length;j++){
                      if(hasStationList[j] == selectNodes[i].value){
                        isInOld = true;
                        break;
                      }
                    }
                 if(isInOld == false){
                     var tmpArray = new Object();
                     tmpArray.id = selectNodes[i].value;
                     tmpArray.value = selectNodes[i].text;
                     result[result.length] = tmpArray;
                 }
              }
			if(result.length==0){
				alert("请选择岗位");
				return;
			}
	    window.returnValue = result;
	    window.close();
	}
	//取消
	function cancel()
	{
	    window.returnValue = null;
	    window.close();
	}

	//选择组织
	function org_select(){
			 
	 var result = orgSelectDialog(<%=com.ai.appframe2.common.SessionManager.getUser().getOrgId()%>);

		//重新装载岗位
		if(result!=null ){
                       org_id = result[0].orgId;
                       document.all("orgName").value = result[0].orgName;
                       g_DBTreeNewManager.get("stationTree").refresh(null,100,"org_id=" + org_id + "&staff_id="+staff_id);
                       initData();
		}
	}

  	initData();

</script>
