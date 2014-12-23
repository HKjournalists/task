<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai"%>
<%@ include file="/webframe/common/commonhead.jsp"%>
<%@ include file="/secframe/common/common.jsp"%>
<HTML>
<head>
<title>批量添加员工绑定信息</title>
</head>
   <body>
<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
     <tr>
    <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
        <tr>
          <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
          <td style="height: 20px">批量绑定管理</td>
          <td align="right" style="height: 20px"><input name="" type="button" class="btn-4word" value="查询视图"  onClick="selectType(1)"/>
            <input name="" type="button" class="btn-4word" value="导入视图"  onClick="selectType(2)"/></td>
        </tr>
      </table></td>
  </tr>
     <tr>
    <td bgcolor="#FFFFFF" align="left" height="100" valign="top"><div id="uploadView" style="display: none;">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" height="100">
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
            <td bgcolor="#F1F3FB" class="font13pxboldblack"> 如:【号码】 注意:<font color="#FC2418">保留第一行为标题</font>,文件单列,格式(.xls),具体请<a href="ipband.xls"><font color="#FC2418"><U>下载模版</U></font></a></td>
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
        </table>
      </div>
         <div id="searchView">
        <ai:dbform formid="sysBand"
					setname="com.ai.secframe.bo.orgmodel.AddIpBand"
					datamodel="com.ai.appframe2.web.datamodel.QueryModelForService"
					initial="false" editable="true">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" height="100">
             <tr>
            <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">IP地址</td>
            <td width="1"></td>
            <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="sysBand" fieldname="IP"
								width="150" height="20" editable="true" visible="true" /></td>
            <td width="1"></td>
            <td bgcolor="#F1F3FB" class="font13pxboldblue1">MAC地址</td>
            <td width="1"></td>
            <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="sysBand" fieldname="MAC"
								width="150" height="20" editable="true" visible="true" /></td>
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
            <td width="100" bgcolor="#E5EFF5" class="font13pxboldblue1">工号</td>
            <td width="1"></td>
            <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="sysBand" fieldname="CODE"
								width="150" height="20" editable="true" visible="true" /></td>
            <td width="1"></td>
            <td bgcolor="#F1F3FB" class="font13pxboldblue1">绑定类型</td>
            <td width="1"></td>
            <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="sysBand" fieldname="BAND_TYPE"
								width="150" height="20" editable="true" visible="true" /></td>
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
             <tr bgcolor="#E1EDFA">
            <td height="1" class="font13pxboldblue1"></td>
            <td width="1"></td>
            <td class="font13pxboldblack"></td>
            <td width="1"></td>
            <td class="font13pxboldblack"></td>
            <td width="1"></td>
            <td class="font13pxboldblack"></td>
          </tr>
             <tr bgcolor="#FFFFFF" height="30">
            <td height="30"  colspan="7"  align="center"><input name="Input" type="button" class="btn-2word" value="查询" id="saveBtn" onClick="query()"/>
               </td>
          </tr>
           </table>
     </ai:dbform> </div></td>
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
    <td bgcolor="#FFFFFF" align="center"><ai:table tableid="band"
					conditionname="initInLoad" 
						setname="com.ai.secframe.bo.orgmodel.AddIpBand"
						initial="false" multiselect="true" editable="true"
						tablemodel="com.ai.appframe2.web.tag.ActionDataModel"		
						parametersname="com.ai.secframe.web.orgmodel.SysStaffAction"				
						width="700" height="300" needrefresh="true" footdisplay="none">
		<ai:col fieldname="EMPLOYEE_NAME" width="60" editable="true"
							visible="true" />				
        <ai:col fieldname="STAFF_ID" width="60" editable="true"
							visible="true" />
        <ai:col fieldname="CODE" width="60" editable="true"
							visible="true" />
        <ai:col fieldname="IP" width="120" editable="true"
							visible="true" />
        <ai:col fieldname="MAC" width="120" editable="true"
							visible="true" />
        <ai:col fieldname="BAND_TYPE" width="80" editable="true"
							visible="true" />
      </ai:table>
         <div id="foot" style="display:none; height:35px; padding-top:5px;">
        <input name="Input" type="button" class="btn-2word" value="检验" onClick="checks()"/>
        &nbsp;
        <input name="Input" type="button" class="btn-2word" value="保存"  onClick="save()"/>
        &nbsp;
        <input name="Input" type="button" class="btn-2word" value="撤销"  onClick="cancel1()"/>
      </div></td>
  	</tr>
   </table>
</body>
   </html><script language="javascript">
function get_TableRowSet() {
    return g_TableRowSetManager.get("band");
}
var sysForm = g_FormRowSetManager.get("sysBand");
var isSearchView = true;
var flag = false; //验证是否成功验证过
function checks(){
	var tableSet = get_TableRowSet();	 
   var code;   
   var result = "";
   var all = tableSet.getTotalRowCount();
   if(all==0)
   	return ;
 	for( var i = 0 ;i < all ; i++){
		code = tableSet.getValue(i,"CODE");
	    var parm = "code="+code;    
	    var aActionUrl="<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysStaffAction?action=checkBand&"+parm;	    
	    var msg = PostInfo(aActionUrl);
		var r = msg.getValueByName("IsOk");
		var staff_id =  msg.getValueByName("STAFF_ID");
		var employee_name =  msg.getValueByName("EMPLOYEE_NAME");
		tableSet.setValue(i,"STAFF_ID",staff_id);
		tableSet.setValue(i,"EMPLOYEE_NAME",employee_name);
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

function save(){
	if(!flag){
		alert("请验证导入数据的正确性，只有在全部验证成功后才能保存");
		return;
	}
	var tableSet = get_TableRowSet();
	var list = new Array();
	list.push(tableSet);
	var msg = saveRowSet("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysStaffAction?action=saveBand",list,false);
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

     var aActionUrl="<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysStaffAction?action=doImportStaffBandForExcel";
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
    tableSet.refresh("refreshBand", "");
}
function cancel1(){
var aActionUrl="<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysStaffAction?action=cancelBand";	    
var msg = PostInfo(aActionUrl);
flag = false; 
onRefresh();
}

	function query(){
		var ip = sysForm.getValue("IP");
		var code = sysForm.getValue("CODE");
		var mac = sysForm.getValue("MAC");
		var bandType = sysForm.getValue("BAND_TYPE");
		
		var ipCond = "";
		var codeCond = "";
		var macCond="";
		var bandTypeCond="";
		var flag = false;
		
		if(ip!=null&&ip!=""){
			ipCond = " IP LIKE '"+ip+"%' ";
		}
		
		if(code!=null&&code!=""){
			codeCond = " CODE LIKE '"+code+"%' ";
		}
		
		if(mac!=null&&mac!=""){
			macCond = " MAC LIKE '"+mac+"%' ";
		}
		
		if(bandType!=null&&bandType!=""){
			bandTypeCond = " BAND_TYPE = '"+bandType+"' ";
		}
		
		var cond = "";
		if(ipCond!=""){
			cond = cond + ipCond;
			flag=true;
		}
		
		if(codeCond!=""){
			if(flag){
				cond = cond +" AND "+ codeCond;
			}else {
				cond = cond +  codeCond;
				flag = true;
			}
		}
		
		if(macCond!=""){
			if(flag){
				cond = cond +" AND "+ macCond;
			}else {
				cond = cond +  macCond;
				flag = true;
			}
		}
		
		if(bandTypeCond!=""){
			if(flag){
				cond = cond +" AND "+ bandTypeCond;
			}else {
				cond = cond +  bandTypeCond;
				flag = true;
			}
		}
		if(cond==""){
			alert("请输入条件");
			return ;
		}
		var tableSet = get_TableRowSet();
		tableSet.refresh("refreshBands", "ip="+ip+"&mac="+mac+"&code="+code+"&type="+bandType);
		tableSet.setEditSts(false);
	}
	
	function selectType(v){
		if(v==1){
			document.getElementById("searchView").style.display="block";
			document.getElementById("uploadView").style.display="none";
			document.getElementById("foot").style.display="none";
			isSearchView = true;
			var tableSet = get_TableRowSet();
			tableSet.refresh("refreshBands","ip=-1");
		} else {
			document.getElementById("searchView").style.display="none";
			document.getElementById("uploadView").style.display="block";
			document.getElementById("foot").style.display="block";
			isSearchView = false;
			onRefresh();
		}
	}



   </script>
   