<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai"%>
<%@ include file="/webframe/common/commonhead.jsp"%>
<%@include file="/secframe/common/common.jsp"%>
<HTML>
<head>
<title>批量添加员工</title>
</head>
   <body>
<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
     <tr>
    <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
        <tr>
          <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
          <td style="height: 20px">员工批量管理</td>
          <td align="right" style="height: 20px"></td>
        </tr>
      </table></td>
  </tr>
     <tr>
    <td bgcolor="#FFFFFF" align="left" height="100" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" height="100">
        <tr>
          <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">导入文件</td>
          <td width="1"></td>
          <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:fileupload name="frmPhoneUpload"  fileSavePath="" formXmlParamName="" showProcessBar="true"
	                      			submitFuncName="doUpload"  savePathStyle="H" onFinishFuncName="doOnFinish" >
              <input id="importFile" style="width:300" name="importFile" type="file">
            </ai:fileupload></td>
        </tr>
        <tr>
          <td height="1" class="font13pxboldblue1"></td>
          <td width="1"></td>
          <td class="font13pxboldblack"></td>
        </tr>
        <tr>
          <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">文件格式</td>
          <td width="1"></td>
          <td bgcolor="#F1F3FB" class="font13pxboldblack"> 如:【号码】 注意:<font color="#FC2418">保留第一行为标题</font>,文件单列,格式(.xls),具体请<a href="addstaff.xls"><font color="#FC2418"><U>下载模版</U></font></a></td>
        </tr>
        <tr>
          <td height="1" class="font13pxboldblue1"></td>
          <td width="1"></td>
          <td class="font13pxboldblack"></td>
        </tr>
        <tr bgcolor="#E1EDFA">
          <td height="1" class="font13pxboldblue1"></td>
          <td width="1"></td>
          <td class="font13pxboldblack"></td>
        </tr>
        <tr bgcolor="#FFFFFF" height="30">
          <td height="30"  colspan="3"  align="center"><input name="Input" type="button" class="btn-4word" value="文件导入" id="saveBtn" onClick="doSubmitWait()"/>
          </td>
        </tr>
      </table></td>
  </tr>
     <tr>
    <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
        <tr>
          <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
          <td style="height: 20px">绑定列表</td>
          <td align="right" style="height: 20px"></td>
        </tr>
      </table></td>
  </tr>
     <tr>
    <td bgcolor="#FFFFFF" align="center"><ai:table tableid="staff"
					conditionname="initInLoad" 
						setname="com.ai.secframe.bo.orgmodel.AddStaff"
						initial="false" multiselect="true" editable="true"
						tablemodel="com.ai.appframe2.web.tag.ActionDataModel"		
						parametersname="com.ai.secframe.web.orgmodel.SysStaffAction"				
						width="850" height="330" needrefresh="true" footdisplay="none">
        <ai:col fieldname="EMPLOYEE_NAME" width="60" editable="true"
							visible="true" />
        <ai:col fieldname="CODE" width="60" editable="true"
							visible="true" />
        <ai:col fieldname="PASSWORD" width="60" editable="true"
							visible="true" />
        <ai:col fieldname="JOB_POSITION" width="90" editable="true"
							visible="true" />
        <ai:col fieldname="BILL_ID" width="70" editable="true"
							visible="true" />
        <ai:col fieldname="OP_LVL" width="100" editable="true"
							visible="true" />
        <ai:col fieldname="ORGANIZE_ID" width="80" editable="true"
							visible="true" />
        <ai:col fieldname="ORGANIZE_NAME" width="200" editable="true"
							visible="true" />
        <ai:col fieldname="OPCODE" width="60" editable="true"
							visible="true" />			
		<ai:col fieldname="OP_TYPE" width="60" editable="true"
							visible="true" />
		<ai:col fieldname="EXT1" width="60" editable="true"
							visible="true" />
		<ai:col fieldname="EXT2" width="60" editable="true"
							visible="true" />
		<ai:col fieldname="EXT3" width="60" editable="true"
							visible="true" />				
      </ai:table>
         <div id="foot" style="height:35px; padding-top:5px;">
        <input name="Input" type="button" class="btn-2word" value="检验" onClick="checks()"/>
        &nbsp;
        <input name="Input" type="button" class="btn-2word" value="保存"  onClick="saveStaff()"/>
        &nbsp;
        <input name="Input" type="button" class="btn-2word" value="撤销"  onClick="cancel1()"/>
      </div></td>
  </tr>
   </table>
</body>
   </html><script language="javascript">
function get_TableRowSet() {
    return g_TableRowSetManager.get("staff");
}
var flag = false; //验证是否成功验证过
function checks(){
	var tableSet = get_TableRowSet();
	 var staff_name;
   var code;
   var organzie_id;
   var bill_id;
   var op_code;
   var optrlvl;
   var password;	
   var result = "";
   var all = tableSet.getTotalRowCount();
   if(all==0)
   	return ;
 	for( var i = 0 ;i < all ; i++){
		staff_name = tableSet.getValue(i,"EMPLOYEE_NAME");
		code = tableSet.getValue(i,"CODE");   
		organzie_id = tableSet.getValue(i,"ORGANIZE_ID"); 
		bill_id =  tableSet.getValue(i,"BILL_ID"); 
		op_code =  tableSet.getValue(i,"OPCODE"); 
		optrlvl =  tableSet.getValue(i,"OP_LVL"); 
	    var parm = "staff_name="+staff_name+"&code="+code+"&organzie_id="+organzie_id+"&bill_id="+bill_id+"&op_code="+op_code;	    
	    parm = parm + "&optrlvl="+optrlvl+"&password="+password;    
	    var aActionUrl="<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysStaffAction?action=check&"+parm;	    
	    var msg = PostInfo(aActionUrl);
		var r = msg.getValueByName("IsOk");
		var org_name =  msg.getValueByName("ORGNAME");
		tableSet.setValue(i,"ORGANIZE_NAME",org_name);
			if(r=="TRUE"){
				var rmsg = msg.getValueByName("MESSAGE");
				if(rmsg!=""&&rmsg!=null){
					tableSet.setRowBgColor(i,"#FFFF97");
					result = result + rmsg + "\n";
				} else {
					tableSet.setRowBgColor(i,"#FFFFFF");
				}
			}else{
				var rmsg = msg.getValueByName("MESSAGE");
				result = result + rmsg + "\n";
				tableSet.setRowBgColor(i,"#FFFF97");
			}
			    
	 }	 
	 if(result!=""){
	 	alert(result);
	 } else {
	 	flag = true;
	 	alert("验证通过");
	 }
}

function cancel(){

var aActionUrl="<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysStaffAction?action=cancel";	    
var msg = PostInfo(aActionUrl);
flag = false; 
onRefresh();
}

function saveStaff(){
	if(!flag){
		alert("请验证导入数据的正确性，只有在全部验证成功后才能保存");
		return;
	}
	var tableSet = get_TableRowSet();
	var list = new Array();
	list.push(tableSet);
	var msg = saveRowSet("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysStaffAction?action=save",list,false);
	//var r = msg.getValueByName("IsOk");
}


function doSubmitWait(){
    if(!validateImport()){//验证文件格式是否是.xls
            document.getElementById("btnConfirm").disabled = "";
            //document.getElementById("btnClose").disabled = "";
            return;
    }
   //document.FileForm.action = "<%=request.getContextPath()%>/business/com.asiainfo.boss.res.phone.web.ImportPhoneAction?action=doImportChannelSchemeInfo&schemeId="+schemeId+"&region_code="+regionCode+"&county_code="+countyCode+"&returnMethod=" + returnMethod;
     document.all("frmPhoneUpload").submit();
     flag = false;
  }
  function doUpload(){
  	 var aFileUploadFormObj=frmPhoneUpload;
     var aXmlAry=null;
     var aFormXmlParamName=null;
     var aIsXmlForceFlag=null;
     relValueSucc = "";
     retValueLost = "";

     var aActionUrl="<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysStaffAction?action=doImportStaffForExcel";
     PostUploadInfo(aFileUploadFormObj,aActionUrl,aXmlAry,aFormXmlParamName,aIsXmlForceFlag);
    
  }
  
  function doOnFinish(aUserDataXml){ 
  onRefresh();
    var aFlag = getReturnValueByName(aUserDataXml,"IsOk");
    var aMsg = getReturnValueByName(aUserDataXml,"MESSAGE");
    if(aFlag=="TRUE"){
    	onRefresh();
    }else{
    	alert(aMsg);
    } 
    // window.close();
  }
  
  function validateImport(){
        var filePath = document.getElementById("importFile").value;
        if (filePath=="") {
            alert("请选择需要导入的文件！");
            return false;
        }
        if (filePath.substring(filePath.lastIndexOf(".") + 1, filePath.length).toUpperCase() != "XLS") {
            alert("导入的文件必须为.xls，请确认！");
            return false;
        }
        return true;
   }
   
   //表格 BusinessFeeConfigBean_Table刷新函数
function onRefresh() {
    var tableSet = get_TableRowSet();
    tableSet.refresh("refreshBandStaff", "");
}





   </script>
   