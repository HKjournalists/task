window.onload= function(){
	//g_getListBox("WorkFlowTypeDs").addItem("","");
	//g_getListBox("CodeDs").addItem("","");
}

function getExcepCodeGird(){
	return g_TableRowSetManager.get("exceptionCode");
}

function do_add(){
	var ExGird=getExcepCodeGird();
	ExGird.newRow();
	do_edit();
}

function do_query(){
	var workFlowType=document.getElementById("WFobject").value;
	var ExCode=document.getElementById("code").value;
	getExcepCodeGird().refresh("&workFlowType="+workFlowType+"&ExCode="+ExCode);
}
function do_edit(){
	getExcepCodeGird().setEditSts(true);
}
function do_delete(){
	if(!confirm("确认删除?")){
	return;
	}
	var ExGird=getExcepCodeGird();
	var selectedRows=ExGird.getSelectedRows();
    
	for (var i=selectedRows.length-1;i>=0;i--){
	//alert(selectedRows[i]);
	ExGird.deleteRow(selectedRows[i]);
	}
	do_save();
}


function do_save(){
//var a=g_TableRowSetManager.get("exceptionCode").getTotalRowCount();
//var a=g_TableRowSetManager.get("exceptionCode").count();
//alert(a);
	var grid=getExcepCodeGird();
	if (grid.getTotalRowCount()>0){
		for (var i=0;i<grid.getTotalRowCount();i++)
		{
		if(grid.getValue(i,"EXCEPTION_CODE")==""){
			alert("异常编码不能为空");
			return;
		}
			if((grid.getValue(i,"EXCEPTION_CODE")=="")&&(grid.getValue(i,"EXCEPTION_NAME")=="")&&(grid.getValue(i,"WORKFLOW_OBJECT_TYPE_ID")=="")&&(grid.getValue(i,"STATE")==""))
			{
				alert("请不要保存空行");
				return;
			}
		}
	}
	var list = new Array(); 
	list.push(g_TableRowSetManager.get("exceptionCode"));
	var url = _gModuleName+"/business/com.ai.comframe.web.exception.ExceptionAction?action=SaveExCode";
	var rtn=saveRowSet(url,list,false,false);
	getExcepCodeGird().setEditSts(false);
}

