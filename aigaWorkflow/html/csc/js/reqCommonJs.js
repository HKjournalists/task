String.prototype.isBlank = function(){
	return (typeof this=='undefined'||this==null||this ==""||this.length==0);
}

var reqCommonMethod = function(currentLinkNo,stakeholderFormId,stakeholderTableId,orderFormId,reqFormId){
	if(currentLinkNo.isBlank()){
		alert('请初始化当前环节编号(currentLinkNo)');
		return;
	}
	if(orderFormId.isBlank()){
		alert('请初始化当前工单AI:DBFORM的ID(orderFormId)');
		return;
	}
	if(reqFormId.isBlank()){
		alert('请初始化当前需求AI:DBFORM的ID(reqFormId)');
		return;
	}
	if(currentLinkNo.isBlank()&&stakeholderTableId.isBlank()){
		alert('请初始化下一环节处理人AI:DBFORM的ID(stakeholderFormId)或AI:TABLE的ID(stakeholderTableId)');
		return;
	}
	reqCommonMethod.currentLinkNo = currentLinkNo;
	reqCommonMethod.stakeholderFormId = stakeholderFormId;
	reqCommonMethod.stakeholderTableId = stakeholderTableId;
	reqCommonMethod.orderFormId = orderFormId;
	reqCommonMethod.reqFormId = reqFormId;
}

reqCommonMethod.formList = new Array();
reqCommonMethod.url = '';
reqCommonMethod.contextPath = '';
reqCommonMethod.componentUrl = '';
reqCommonMethod.currentLinkNo = '';
reqCommonMethod.selectBranchSet = '';
reqCommonMethod.componentJsonUrl = '';
reqCommonMethod.stakeholderFormId = '';
reqCommonMethod.stakeholderTableId = '';
reqCommonMethod.reqFormId = '';
reqCommonMethod.stakeholderType = '';
reqCommonMethod.orderFormId = '';
reqCommonMethod.userId = '';
reqCommonMethod.afterSubmitOrder = null;
reqCommonMethod.beforeSubmitOrder = null;
reqCommonMethod.beforeUpdateStakeholder = null;
reqCommonMethod.afterUpdateStakeholder = null;
reqCommonMethod.componentJsonObject;

reqCommonMethod.stakeholderParam = {
	roleCode : -1,
	staffId : -1,
	projectCode : -1,
	parentOrgId : -1
};

reqCommonMethod.initStakeholderComponent = function(divId){
	if(this.componentUrl=='')
		return;
	var rtn = PostInfo(this.componentUrl+'&currentLinkNo='+this.currentLinkNo,null);
	var str = rtn.getValueByName('html');
	$('#'+divId).html(str);
	
	var jsonRtn = PostInfo(this.componentJsonUrl+'&currentLinkNo='+this.currentLinkNo,null);
	var jsonString = jsonRtn.getValueByName('json');
	this.componentJsonObject = eval('(' + jsonString + ')');
}

reqCommonMethod.initReqForm = function(reqId){
	var reqForm = g_FormRowSetManager.get(this.reqFormId);
	reqForm.refresh("REQ_ID="+reqId);
}

reqCommonMethod.initOrderForm = function(orderId){
	var orderForm = g_FormRowSetManager.get(this.orderFormId);
	orderForm.refresh("ORDER_ID="+orderId);
}

reqCommonMethod.setWOResult = function(nextLinkNo){
	var approvalForm = g_FormRowSetManager.get(this.stakeholderFormId);
	var orderForm = g_FormRowSetManager.get(this.orderFormId);
	var cond = this.componentJsonObject[nextLinkNo].cond;
	if(cond == null)
		cond = '';
	approvalForm.refresh("OBJ_ID=0");
	if(this.componentJsonObject[nextLinkNo].needRefreshStakeholder == 1){
		var objId = orderForm.getValue('OBJ_ID');
		var objType = orderForm.getValue('OBJ_TYPE');
		if(objId.isBlank()||objType.isBlank()){
			alert('错误:未初始化工单');
			return;
		}
		var linkNo = '';
		var approvalFormTemp = g_FormRowSetManager.get('approvalFormTemp');
		if(this.componentJsonObject[nextLinkNo].refreshStakeholderLinkNo != null){
			linkNo = this.componentJsonObject[nextLinkNo].refreshStakeholderLinkNo;
			approvalFormTemp.refresh("OBJ_ID="+objId+" and OBJ_TYPE="+objType+" and LINK_NO='"+linkNo+"' and STDHOLDE_TYPE=2");
			if(approvalFormTemp.getValue("STDHOLDER_STAFF_NAME").isBlank()){
				alert('错误:指定环节的处理人未在alm_stakeholder表中查询到');
				return;
			}
			approvalForm.refresh("OBJ_ID="+objId+" and OBJ_TYPE="+objType+" and LINK_NO='"+nextLinkNo+"' and STDHOLDE_TYPE=2");
			approvalForm.setValue("LINK_ID",this.componentJsonObject[nextLinkNo].nextLinkId);
  			approvalForm.setValue("LINK_NO",nextLinkNo);
  			approvalForm.setValue("TEMPLATE_ID",this.componentJsonObject[nextLinkNo].templateId);
  			approvalForm.setValue("STDHOLDER_STAFF_ID",approvalFormTemp.getValue("STDHOLDER_STAFF_ID"));
 			approvalForm.setValue("STDHOLDER_STAFF_NAME",approvalFormTemp.getValue("STDHOLDER_STAFF_NAME"));
 			approvalForm.setValue("STDHOLDER_STAFF_NO",approvalFormTemp.getValue("STDHOLDER_STAFF_NO"));
 			approvalForm.setValue("STDHOLDE_TYPE",this.stakeholderType);
		}else{
			linkNo = nextLinkNo;
			approvalForm.refresh("OBJ_ID="+objId+" and OBJ_TYPE="+objType+" and LINK_NO='"+linkNo+"' and STDHOLDE_TYPE=2");
		}
	}
	if(this.updateStakeholder(nextLinkNo,approvalForm.getValue("STDHOLDER_STAFF_NAME"))){
		cond += '<cond name="staffId" value="'+approvalForm.getValue("STDHOLDER_STAFF_ID")+'"></cond>';
		orderForm.setValue("RESULT",this.componentJsonObject[nextLinkNo].result);
		orderForm.setValue("COND",'<conds>'+cond+'</conds>');
		this.reqWarp(nextLinkNo);
	}
}

reqCommonMethod.setSignWOResult = function(nextLinkNo){
	var signTable = g_TableRowSetManager.get(this.stakeholderTableId);
	var orderForm = g_FormRowSetManager.get(this.orderFormId);
	var cond = this.componentJsonObject[nextLinkNo].cond;
	var selectStaffNames = '';
	if(cond == null)
		cond = '';
	signTable.refresh(null,"objId=0&objType=0");
	if(this.componentJsonObject[nextLinkNo].needRefreshStakeholder == 1){
		var objId = orderForm.getValue('OBJ_ID');
		var objType = orderForm.getValue('OBJ_TYPE');
		var condition="objId="+objId+"&objType="+objType+"&linkNo="+nextLinkNo;
		signTable.refresh(null,condition);
		for(var i=0;i<signTable.getTotalRowCount();i++){
	  		selectStaffNames += signTable.getValue(i,'STDHOLDER_STAFF_NAME')+";";
		}
	}
	if(this.updateSignStakeholder(nextLinkNo,selectStaffNames)){
		conds = cond += '<cond name="staffId" value="'+this.condStaffIdSign+'"></cond>';
		orderForm.setValue("RESULT",this.componentJsonObject[nextLinkNo].result);
		orderForm.setValue("COND",'<conds>'+cond+'</conds>');
		this.reqSignWarp(nextLinkNo);
	}
}

reqCommonMethod.updateStakeholder = function(nextLinkNo,selectStaffName){
	var isChoiceStakeholder = this.componentJsonObject[nextLinkNo].isChoiceStakeholder;
	var needOption = this.componentJsonObject[nextLinkNo].needOption;
	if(isChoiceStakeholder==0&&needOption==0&&selectStaffName!=''){
		return true;
	}else{
		if(this.componentJsonObject[nextLinkNo].linkNoType == 'user'){
			reqCommonMethod.stakeholderParam.roleCode = this.componentJsonObject[nextLinkNo].nextRoleCode;
			reqCommonMethod.stakeholderParam.staffId = this.userId;
			reqCommonMethod.stakeholderParam.parentOrgId = -1;
			reqCommonMethod.stakeholderParam.projectCode = -1;
		}
		var approvalForm = g_FormRowSetManager.get(this.stakeholderFormId);
		var orderForm = g_FormRowSetManager.get(this.orderFormId);
		var returnData =new Array();
		if(typeof this.beforeUpdateStakeholder === 'function')
			if(this.beforeUpdateStakeholder(nextLinkNo)==false)
				return false;
	  	returnData = this.selectStaffByProject(this.stakeholderParam.roleCode,this.stakeholderParam.staffId,this.stakeholderParam.projectCode,this.stakeholderParam.parentOrgId,undefined,this.componentJsonObject[nextLinkNo].isChoiceStakeholder,selectStaffName,this.componentJsonObject[nextLinkNo].needOption,this.componentJsonObject[nextLinkNo].optionDefaultValue);
		if(returnData!=null&&typeof returnData != 'undefined'&&returnData[5]=='enter'){
			if(!returnData[1].isBlank()){
				approvalForm.setValue("LINK_ID",this.componentJsonObject[nextLinkNo].nextLinkId);
				approvalForm.setValue("LINK_NO",nextLinkNo);
				approvalForm.setValue("TEMPLATE_ID",this.componentJsonObject[nextLinkNo].templateId);
				approvalForm.setValue("STDHOLDER_STAFF_ID",returnData[0]);
				approvalForm.setValue("STDHOLDER_STAFF_NAME",returnData[1]);
				approvalForm.setValue("STDHOLDER_STAFF_NO",returnData[2]);
				approvalForm.setValue("STDHOLDE_TYPE",this.stakeholderType);
			}else{
				if(selectStaffName.isBlank()){
					return false;
				}
			}
			var remarkInfo = returnData[4].replace(/(^\s*)|(\s*$)/g, "");
			orderForm.setValue("OPINION",remarkInfo);
			if(typeof this.afterUpdateStakeholder === 'function')
				if(this.afterUpdateStakeholder(nextLinkNo)==false)
					return false;
			return true;
		}else{
			return false;
		}
	}
}

reqCommonMethod.updateSignStakeholder = function(nextLinkNo,selectStaffNames){
	var isChoiceStakeholder = this.componentJsonObject[nextLinkNo].isChoiceStakeholder;
	var needOption = this.componentJsonObject[nextLinkNo].needOption;
	if(isChoiceStakeholder==0&&needOption==0&&selectStaffNames!=''){
		return true;
	}else{
		if(this.componentJsonObject[nextLinkNo].linkNoType == 'sign'){
			reqCommonMethod.stakeholderParam.roleCode = -1;
			reqCommonMethod.stakeholderParam.staffId = -1;
			reqCommonMethod.stakeholderParam.parentOrgId = -1;
			reqCommonMethod.stakeholderParam.projectCode = -1;
		}
		var returnData=new Array();
		var signTable = g_TableRowSetManager.get(this.stakeholderTableId);
		var orderForm = g_FormRowSetManager.get(this.orderFormId);
		this.condStaffIdSign = '';
		if(typeof this.beforeUpdateStakeholder === 'function')
			if(this.beforeUpdateStakeholder(nextLinkNo)==false)
				return false;
	  	returnData = this.selectStaffsByProject(this.stakeholderParam.roleCode,this.stakeholderParam.staffId,this.stakeholderParam.projectCode,this.stakeholderParam.parentOrgId,"sign",selectStaffNames,this.componentJsonObject[nextLinkNo].needOption,this.componentJsonObject[nextLinkNo].optionDefaultValue,this.componentJsonObject[nextLinkNo].isChoiceStakeholder);
	    if(returnData!=null&&typeof returnData != 'undefined'&&returnData[5]=='enter'){
	    	var arr = returnData[0].split(";");
		    var signNames = returnData[1].split(";");
		    var signNo = returnData[2].split(";");
			this.condStaffIdSign = returnData[0];
		 	if(!returnData[1].isBlank()){
		 		signTable.refresh(null,"objId=0&objType=0");
		 		for(var i =0;i<arr.length-1;i++)
				{
					signTable.newRow(false);
					signTable.setValue(i,"LINK_ID",this.componentJsonObject[nextLinkNo].nextLinkId);
					signTable.setValue(i,"LINK_NO",nextLinkNo);
					signTable.setValue(i,"TEMPLATE_ID",this.componentJsonObject[nextLinkNo].templateId);
					signTable.setValue(i,"STDHOLDER_STAFF_ID",arr[i]);
					signTable.setValue(i,"STDHOLDER_STAFF_NAME",signNames[i]);
					signTable.setValue(i,"STDHOLDER_STAFF_NO",signNo[i]);
					signTable.setValue(i,"STDHOLDE_TYPE",this.stakeholderType);
				}
		 	}else{
		 		if(selectStaffNames.isBlank()){
					return false;
				}else{
					var length = signTable.getTotalRowCount();
					for(var i=0;i<length;i++){
		  				this.condStaffIdSign += signTable.getValue(i,'STDHOLDER_STAFF_ID')+";";
					}		
				}
		 	}
			
			var remarkInfo = returnData[4].replace(/(^\s*)|(\s*$)/g, "");
			orderForm.setValue("OPINION",remarkInfo);
			if(typeof this.afterUpdateStakeholder === 'function')
				if(this.afterUpdateStakeholder(nextLinkNo)==false)
					return false;
			return true
	    }else{
			return false;
		}
    }
}

reqCommonMethod.reqWarp = function(nextLinkNo){
	var reqForm = g_FormRowSetManager.get(this.reqFormId);
	var orderForm = g_FormRowSetManager.get(this.orderFormId);
	var approvalForm = g_FormRowSetManager.get(this.stakeholderFormId);
	
	this.formList = new Array();
	this.formList.push(reqForm);
	this.formList.push(orderForm);
	this.formList.push(approvalForm);
	
	this.url = '';
	this.url = this.contextPath+this.componentJsonObject[nextLinkNo].submitUrl;
	if(typeof this.beforeSubmitOrder === 'function')
	    this.beforeSubmitOrder(nextLinkNo);
	var rtn = saveRowSet(this.url,this.formList,true,false);
	if(rtn.getValueByName(this.componentJsonObject[nextLinkNo].submitResultVar)=="Y")
	{
		$.messager.alert('操作提示',this.componentJsonObject[nextLinkNo].submitSuccessMsg,'info',function(){
			if(typeof this.afterSubmitOrder === 'function')
	    		this.afterSubmitOrder(rtn,nextLinkNo);
	    	var orderId = orderForm.getValue('ORDER_ID');
	    	if(orderId==null||orderId==""||orderId=="null")
	    	{
	    		skipToIndexForDesktop();
	    	}
	    	else
	    	{
	    		skipToIndex();
	    	}
		});
	}else{
		$.messager.alert('操作提示',this.componentJsonObject[nextLinkNo].submitFailMsg,'error');
	}
}

reqCommonMethod.reqSignWarp = function(nextLinkNo){
	var reqForm = g_FormRowSetManager.get(this.reqFormId);
	var orderForm = g_FormRowSetManager.get(this.orderFormId);
	var signTable = g_TableRowSetManager.get(this.stakeholderTableId); 
	if(orderForm.getValue("OPINION").isBlank()){
		return;
    }
    this.formList = new Array();
  	this.formList.push(orderForm);
  	this.formList.push(reqForm);
  	this.formList.push(signTable);
  	
  	this.url = '';
  	this.url = this.contextPath+this.componentJsonObject[nextLinkNo].submitUrl;
  	if(typeof this.beforeSubmitOrder === 'function')
	    this.beforeSubmitOrder(nextLinkNo);
  	var rtn = saveRowSet(this.url,this.formList,true,false);
	if(rtn.getValueByName(this.componentJsonObject[nextLinkNo].submitResultVar)=="Y")
	{
		$.messager.alert('操作提示',this.componentJsonObject[nextLinkNo].submitSuccessMsg,'info',function(){
			if(typeof this.afterSubmitOrder === 'function')
	    		this.afterSubmitOrder(rtn,nextLinkNo);
	    	var orderId = orderForm.getValue('ORDER_ID');
	    	if(orderId==null||orderId==""||orderId=="null")
	    	{
	    		skipToIndexForDesktop();
	    	}
	    	else
	    	{
	    		skipToIndex();
	    	}
		});
	}else{
		$.messager.alert('操作提示',this.componentJsonObject[nextLinkNo].submitFailMsg,'error');
	}
}

reqCommonMethod.selectStaffByProject = function(){
	var roleCode = arguments[0];
	var staffId =  arguments[1];
	var projectCode =  arguments[2];
	var parentOrgId =  arguments[3];
	var chooseType=arguments[4];
	var isChoiceStakeholder = arguments[5];
	var selectStaffName = arguments[6];
	var needOption = arguments[7];
	var optionDefaultValue = arguments[8];
	var dialogHeigh = '345px';
	if(isChoiceStakeholder==0&&selectStaffName!='')
		dialogHeigh = '125px';
	if(needOption==0)
		dialogHeigh = '280px';
	url=this.contextPath+"/csc/common/SelectStaff_NEW.jsp?type="+roleCode+"&cur_userId="+staffId+"&projectCode="+projectCode+"&parentOrgId="+parentOrgId+"&chooseType="+chooseType+"&isChoiceStakeholder="+isChoiceStakeholder+"&selectStaffName="+selectStaffName+"&needOption="+needOption+"&optionDefaultValue="+optionDefaultValue;
	var returnData = window.showModalDialog(url,"org","scroll:no;resizable:no;status:no;dialogHeight:"+dialogHeigh+";dialogWidth:560px");
	return returnData;
}
	
reqCommonMethod.selectStaffsByProject = function(){
	var roleCode = arguments[0];
	var staffId =  arguments[1];
	var projectCode =  arguments[2];
	var parentOrgId =  arguments[3];
	var chooseType=arguments[4];
	var selectStaffNames = arguments[5];
	var needOption = arguments[6];
	var optionDefaultValue = arguments[7];
	var isChoiceStakeholder = arguments[8];
	var dialogHeigh = '390px';
	if(isChoiceStakeholder==0&&selectStaffNames!='')
		dialogHeigh = '130px';
	if(needOption==0)
		dialogHeigh = '340px';
	url=this.contextPath+"/csc/common/SelectMultiPsn_NEW.jsp?type="+roleCode+"&cur_userId="+staffId+"&projectCode="+projectCode+"&parentOrgId="+parentOrgId+"&chooseType="+chooseType+"&selectStaffNames="+selectStaffNames+"&needOption="+needOption+"&optionDefaultValue="+optionDefaultValue+"&isChoiceStakeholder="+isChoiceStakeholder;
	var returnData = window.showModalDialog(url,"org","scroll:no;resizable:no;status:no;dialogHeight:"+dialogHeigh+";dialogWidth:560px");
	return returnData;
}

reqCommonMethod.addComponent = function(addLinkNo){
	if(this.addComponentUrl=='')
		return;
	var rtn = PostInfo(this.addComponentUrl+'&linkNo='+addLinkNo,null);
	var str = rtn.getValueByName('html');
	$('#workflowComponent').prepend(str);
	
	var jsonRtn = PostInfo(this.componentJsonUrl+'&currentLinkNo='+addLinkNo,null);
	var jsonString = jsonRtn.getValueByName('json');
	var addJson = eval('(' + jsonString + ')');
	
	for(var item in addJson){
		this.componentJsonObject[item] = addJson[item];
	}
}
