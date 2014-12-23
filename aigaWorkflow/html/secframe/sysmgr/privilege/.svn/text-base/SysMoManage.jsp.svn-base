<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<ai:scriptinclude src="/jsv2/PopMenu_v2.js"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>MO维护界面</title>
</head>
<body>

  <table border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td width="30%" valign="top"  style="padding-right:8px;">
	  
	  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"><table width="250" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px">MO目录结构</td>
                <td align="right" style="height: 20px"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="left" style="padding-left:10px;"><ai:dbtree_new id="sysdirtree" 
								datamodel="com.ai.secframe.web.sysmgr.DBTreeModelSysDir" multiselect="false"
								onrightclick="rightMenu"  height="490" width="260" onselect="refRight" ishaveline="true"/>
          </td>
        </tr>
      </table>
</td>
      <td width="70%" valign="top"><table width="100%" cellpadding="0" cellspacing="0">
          <tr>
            <td height="70" colspan="2" valign="top">
			
			<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
              <tr>
                <td class="tdhead"><table width="250" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
                    <tr>
                      <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                      <td style="height: 20px">被管理对象</td>
                      <td align="right" style="height: 20px"></td>
                    </tr>
                </table></td>
              </tr>
              <tr>
                <td bgcolor="#FFFFFF" align="left"><ai:dbform formid="frmsysmo"
										setname="com.ai.secframe.bo.sysmgr.SysMo" editable="true"
										datamodel="com.ai.appframe2.web.datamodel.QueryModelForService"
										implservice_name="com.ai.secframe.service.sysmgr.SysMo"
										implservice_querymethod="querySysMo"											
											initial="false">
											<table width="100%" border="0" cellpadding="0" cellspacing="0" height="60">
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td width="100" class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">名称</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="MO_ID" formid="frmsysmo"
															visible="false" />
                      <ai:dbformfield fieldname="NAME" formid="frmsysmo"
															editable="false"/></td>
                <td width="1"></td>
                <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">类型</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="MO_TYPE" formid="frmsysmo"
															editable="true" /></td>
              </tr>
             
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td width="100" class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">备注</td>
                <td width="1"></td>
                <td colspan="5" bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield fieldname="REMARKS" formid="frmsysmo"
															editable="true" width="300" /></td>
              </tr>
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
            </table>
				</ai:dbform>							
                </td>
              </tr>
            </table>
			
			
			</td>
          </tr>
          <tr>
            <td width="50%" align="center">
			<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
              <tr>
                <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
                    <tr>
                      <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                      <td style="height: 20px">MO属性设置</td>
                      <td align="right" style="height: 20px">
					  <input  type="button" class="btn-2word" value="新增" onClick="return grdMrg('grdMoAttr','0');"/>
					   &nbsp;<input  type="button" class="btn-2word" value="删除"  onClick="return grdMrg('grdMoAttr','1');"/>

					  </td>
                    </tr>
                </table></td>
              </tr>
              <tr>
                <td bgcolor="#FFFFFF" align="left">
						
				<ai:table tableid="grdMoAttr" oncontextmenu=""
											footdisplay="none"
											tablemodel="com.ai.appframe2.web.datamodel.QueryModelForService"
										implservice_name="com.ai.secframe.service.sysmgr.SysMoAttr"
										implservice_querymethod="queryMoAttr"
										implservice_countmethod="getBeansCount"
											setname="com.ai.secframe.bo.sysmgr.SysMoAttr" height="380"
											multiselect="false" oncellchange="" editable="true"
											needrefresh="true" width="286" initial="false">
                <ai:col fieldname="TITLE" />
                <ai:col fieldname="ATTR_TYPE" />
                <ai:col fieldname="REMARKS" />
              </ai:table>
                </td>
              </tr>
            </table>			
			</td>
            <td width="50%" valign="top" align="center"  style="padding-left:8px;">
			
			<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
              <tr>
                <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
                    <tr>
                      <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                      <td style="height: 20px">MO操作设置</td>
                      <td align="right" style="height: 20px">	  
					  <input  type="button" class="btn-2word" value="新增" onClick="newMoOp();"/>
					   &nbsp;<input  type="button" class="btn-2word" value="删除"  onClick="return grdMrg('grdMoOp','1');"/>
</td>
                    </tr>
                </table></td>
              </tr>
              <tr>
                <td bgcolor="#FFFFFF" align="left">
              <ai:table tableid="grdMoOp" oncontextmenu=""
											setname="com.ai.secframe.bo.sysmgr.SysMoOp" height="380"
											tablemodel="com.ai.appframe2.web.datamodel.QueryModelForService"
										implservice_name="com.ai.secframe.service.sysmgr.SysMoOp"
										implservice_querymethod="getBeans"
										implservice_countmethod="getBeansCount"
											multiselect="false" oncellchange="" footdisplay="none"
											editable="true" needrefresh="true" width="286"
											initial="false">
                <ai:col fieldname="NAME"/>
                <ai:col fieldname="IS_QUERY"/>
                <ai:col fieldname="TITLE"/>
                <ai:col fieldname="FUNC_ID" editable="false" />
              </ai:table>
                </td>
              </tr>
            </table>
	</td>
          </tr>
        </table></td>
    </tr>
  </table>
<center>
<input  type="button" class="btn-2word" value="保存" onClick="return save();"/>
<center>
</body>
</html><script type="text/javascript">
<!--
//初始化页面控件
var grdMoAttr = g_TableRowSetManager.get("grdMoAttr");
var grdMoOp = g_TableRowSetManager.get("grdMoOp");
var frmsysmo = g_FormRowSetManager.get("frmsysmo");
var dbTree = g_DBTreeNewManager.get("sysdirtree");
var model = new AIPopMenuModel();
//初始化右击菜单
model.addPopMenuItem(1,"新建资源包",null,"newDir");//构造
model.addPopMenuItem(2,"新件MO文件",null,"newMo");
model.addSeparator(null);//分隔线
model.addPopMenuItem(3,"删除",null,"delOper");

var popMenu = new AIPopMenu(model);


//MO OP新增
function newMoOp()
{
		if(isNull()==false){
			return false;
		}
	    var paramObj = new Object();
        var dbtblMoOp = eval("grdMoOp");
		var dbformMoOp = window.showModalDialog("MoOpAdd.jsp?sequence="+(new Date().getMilliseconds()),"",
			"scroll:yes;resizable:no;status:no;help:no;dialogHeight:610px;dialogWidth:740px");
		if(dbformMoOp != null){		
		
		dbtblMoOp.newRow();
		dbtblMoOp.setValue(dbtblMoOp.getRow(),"NAME",dbformMoOp.name,dbformMoOp.name);
		dbtblMoOp.setValue(dbtblMoOp.getRow(),"IS_QUERY",dbformMoOp.is_query,dbformMoOp.is_query);
		dbtblMoOp.setValue(dbtblMoOp.getRow(),"TITLE",dbformMoOp.title,dbformMoOp.title);
		dbtblMoOp.setValue(dbtblMoOp.getRow(),"FUNC_ID",dbformMoOp.func_id,dbformMoOp.func_name);
	 }

}



//Grid表格的增加、删除函数
function grdMrg(grdId,type){
	var grdObj = eval(grdId);
	if(type==0){
		if(isNull()==false){
			return false;
		}
		grdObj.newRow();
	}else if(type==1){
		if(grdObj.getCurRowIndex()<0){
			alert("请选择需要删除的行！");
		}else{
			grdObj.deleteRow(grdObj.getCurRowIndex());
		}
	}
}
function save(){
	if(isNull()==false){
		return false;
	}
	if(frmsysmo.getValue("MO_TYPE").length<=0){
		alert("请选择类型！");
		frmsysmo.setFocus("MO_TYPE");
		return false;
	}
	if(attrIsNull()!=0){
		alert("请填写完整属性信息！");
		var arr = attrIsNull().split(",");
		grdMoAttr.setFocusByName(arr[0],arr[1]);
		return false;
	}
	if(opIsNull()!=0){
		alert("请填写完整操作属性信息！");
		var arr = opIsNull().split(",");
		grdMoOp.setFocusByName(arr[0],arr[1]);
		return false;
	}
	var list = new Array();
	list[0] = frmsysmo;
	list[1] = grdMoAttr;
	list[2] = grdMoOp;
	saveRowSet(_gModuleName+"/business/com.ai.secframe.web.sysmgr.SysMoMamageAction?action=save&MO_ID="+frmsysmo.getValue("MO_ID")+"",list);
	refdata(frmsysmo.getValue("MO_ID"));
}
function rightMenu(){
	var node = dbTree.getCurNodeInfo();
	if(node.value==0){
		popMenu.setItemEnabledById("3",false);
	}else{
		popMenu.setItemEnabledById("3",true);
	}
	popMenu.showPopMenu();
	
}
function hide(){
	popMenu.hidePopMenu();
}
document.onclick=hide;
function newDir(){
	var node = dbTree.getCurNodeInfo();
	if(node.userobj!='E'){
		alert("父结点非目录结构！");
		return false;
	}
	//window.open("SysDirectory.jsp");
	showModalDialog('SysDirectory.jsp',node,'dialogWidth:400px;dialogHeight:180px;center:yes;scroll:no;resizable:no;help:no;status:no;');
	dbTree.refresh(node.value,1);
}
function newMo(){
	var allnode = dbTree.getSelectionPathInfo();
	var dirFullName = "";
	var arrNode = new Array();
	var node = dbTree.getCurNodeInfo();
	if(node.userobj!='E'){
		alert("父结点非目录结构！");
		return false;
	}
	if(node.value!=0){
		for(var i=1;i<allnode.length;i++){
			dirFullName += "."+allnode[i].text;
		}
	}
	arrNode[0] = node.value;
	arrNode[1] = dirFullName.substr(1);
	//window.open("SysMo.jsp");
	window.showModalDialog("SysMo.jsp",arrNode,"dialogWidth:400px;dialogHeight:180px;center:yes;scroll:no;resizable:no;help:no;status:no;");
	dbTree.refresh(node.value,1);
}
function refRight(){
	var node = dbTree.getCurNodeInfo();
	if(node.userobj=='E'){
		return false;
	}
	refdata(node.value);
}
function delOper(){
	var node = dbTree.getCurNodeInfo();
	var obj = dbTree.getChildrenNodesInfo(node.value);
	var dirValue = "";
	var moId = "";
	if(node.userobj!="E"&&obj.length>0){
		alert("请先删除当前结点下数据！");
		dbTree.refresh(node.value,1);
		return false;
	}
	if(node.userobj=="E")
		dirValue = node.value;
	else
		moId = node.value;
	if(window.confirm("确认删除？")==true){
		PostInfotoServer(_gModuleName+"/business/com.ai.secframe.web.sysmgr.SysMoMamageAction?action=delMoAndDir&dirValue="+dirValue+"&moId="+moId,'');
		alert("删除成功！");
		dbTree.refresh(dbTree.getParentNodeInfo(node.value).value);
		refdata(node.value);
	}
}
function refdata(moId){
	frmsysmo.refresh("MO_ID='"+moId+"'");
	grdMoAttr.refresh("MO_ID='"+moId+"'");
	grdMoOp.refresh("MO_ID='"+moId+"'");	
}
function isNull(){
	if(frmsysmo.getValue("NAME")==""||frmsysmo.getValue("NAME").length<=0){
		alert("请选择MO信息！");
		return false;
	}
	return true;
}
function attrIsNull(){
	var atrCount = grdMoAttr.getTotalRowCount();
	for(var i=0;i<atrCount;i++){
		if(grdMoAttr.getValue(i,"TITLE")==""){
			return i+",TITLE";
		}
		if(grdMoAttr.getValue(i,"ATTR_TYPE")==""){
			return i+",ATTR_TYPE";
		}
	}
	return 0;
}
function opIsNull(){
	var opCount = grdMoOp.getTotalRowCount();
	for(var i=0;i<opCount;i++){
		if(grdMoOp.getValue(i,"NAME")==""){
			return i+",NAME";
		}
		if(grdMoOp.getValue(i,"IS_QUERY")==""){
			return i+",IS_QUERY";
		}
	}
	return 0;
}
//-->
</script>
