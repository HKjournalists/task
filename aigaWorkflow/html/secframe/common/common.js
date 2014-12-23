
function orgSelectDialog(orgId){
	var url = _gModuleName+"/secframe/sysmgr/common/OrgSelectDialog.jsp?sequence="+(new Date()).valueOf();
	
	if(orgId!=null&&orgId!="")
		url += "&org_id="+orgId;
	var ret = window.showModalDialog(url,null,"scroll:no;resizable:no;help:no;status:no;dialogHeight:450px;dialogWidth:300px");
	if(ret!=null){
		return ret;
	}else{
		return null;
	}
}
/**
 *Ա��ѡ��Ի���
 *staffSelectDialog(arrStaff,singleFlag)
 *arrStaffΪ�Ѿ�ѡ���Ա��(staffId����),��Ա��ѡ����潫����ʾ��ֻ��ʾ������Ҳ��ڸ÷�Χ�ڵ�Ա��;
 *singleFlagΪ�Ƿ���Զ�ѡԱ���ı�־��true/false����
 *����ֵΪArray
 *var ret = staffSelectDialog(null,true);
 *if(ret !=null){
 *  for(var i=0;i<ret.length;i++){
 *	  alert(ret[0].orgId+"___"+ret[0].orgName+"___"+ret[0].staffId+"____"+ret[0].staffName);
 *  }
 *}
**/
function staffSelectDialog(arrStaff,singleFlag){
	var url = _gModuleName+"/secframe/sysmgr/common/StaffSelectDialog.jsp?sequence="+(new Date()).valueOf();
	
	if(arrStaff == null)
		arrStaff = new Array();
	var paraObj = new Object();
	paraObj.arrStaff = arrStaff;
	paraObj.singleFlag = singleFlag;
	paraObj.winObj = window;
	var ret = window.showModalDialog(url,paraObj,"scroll:no;resizable:no;help:no;status:no;dialogHeight:460px;dialogWidth:530px");
	if(ret!=null){
		return ret;
	}else{
		return null;
	}
}

/**
 *����ѡ��
 *funcSelectDialog
 *
 *����ֵΪFunc����
 *�õ�����ֵ�Ĺ�����ƺ͹��ܱ�����£�
 *var ret = funcSelectDialog();
 *if(ret!=null){
 *	alert(ret.funcId+"___"+ret.funcName)
 *}
**/
function funcSelectDialog(){
	var url = _gModuleName+"/secframe/sysmgr/common/FuncSelectDialog.jsp?sequence="+(new Date()).valueOf();
	
	var ret = window.showModalDialog(url,null,"scroll:no;resizable:no;help:no;status:no;dialogHeight:450px;dialogWidth:300px");
	if(ret!=null){
		return ret;
	}else{
		return null;
	}
}

/**
 *��λ�Ի���ѡ��
 *stationSelectDialog(arrStation,singleFlag)��
 *arrStation�Ѿ�ѡ��ĸ�λ��Ϊ���顣singleFlag�Ƿ�ѡ��־��
 *singleFlagΪ�Ƿ���Զ�ѡԱ���ı�־��true/false����
 *var ret = stationSelectDialog(null,true);
 *if(ret!=null)
 *  for(var i=0;i<ret.length;i++){
 *		alert(ret[i].stationId+"_"ret[i].stationName);
 *  }
**/

function stationSelectDialog(arrStation,singleFlag){
	var url = _gModuleName+"/secframe/sysmgr/common/StationSelectDialog.jsp?sequence="+(new Date()).valueOf();
	if(arrStation==null){
		arrStation = new Array();
	}
	var paraObj = new Object();
	paraObj.arrStation = arrStation;
	paraObj.singleFlag = singleFlag;
	paraObj.winObj = window;	
	var ret = window.showModalDialog(url,paraObj,"scroll:no;resizable:no;status:no;dialogHeight:460px;dialogWidth:530px;help:no");
	if(ret!=null){
		return ret;
	}else{
		return null;
	}
}
/**
 *��λ���ͶԻ���ѡ��
 *stationTypeSelectDialog(arrStationType,singleFlag)��
 *arrStationType�Ѿ�ѡ��ĸ�λ��Ϊ���顣singleFlag�Ƿ�ѡ��־��
 *singleFlagΪ�Ƿ���Զ�ѡԱ���ı�־��true/false����
 *var ret = stationTypeSelectDialog(null,true);
 *if(ret!=null)
 *  for(var i=0;i<ret.length;i++){
 *		alert(ret[i].stationId+"_"ret[i].stationName);
 *  }
**/
function stationTypeSelectDialog(arrStationType,singleFlag){
	var url = _gModuleName+"/secframe/sysmgr/common/StationTypeSelect.jsp?sequence="+(new Date()).valueOf();
	if(arrStationType==null){
		arrStationType = new Array();
	}
	var paraObj = new Object();
	paraObj.arrStatType = arrStationType;
	paraObj.singleFlag = singleFlag;
	paraObj.winObj = window;
	var ret = window.showModalDialog(url,paraObj,"scroll:no;resizable:no;status:no;dialogHeight:480px;dialogWidth:460px;help:no");
	if(ret!=null){
		return ret;
	}else{
		return null;
	}
}
function getTblAttPack(){
	return g_TableRowSetManager.get("tblAttPack");
}



