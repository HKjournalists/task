window.onload= function(){
	
}

function queryDescCode(){

		var selectedrows=getExcepDescGird().getSelectedRows();
		if (selectedrows[0]==null)
		return "noValue";
		else
	return	getExcepDescGird().getValue(selectedrows[0],"EXCEPTION_DESC_CODE");
		
}
function queryDescName(){

		var selectedrows=getExcepDescGird().getSelectedRows();
		if (selectedrows[0]==null)
		return "noValue";
		else
	return	getExcepDescGird().getValue(selectedrows[0],"EXCEPTION_DESC_NAME");
		
}



function getExcepDescGird(){
	return g_TableRowSetManager.get("exceptionDesc");
}

function do_add(){
	var ExGird=getExcepDescGird();
	ExGird.newRow();

	do_edit();
}

function do_query(){
	var descType=document.getElementById("Desc");
	getExcepDescGird().refresh("&description="+descType.value);
	
}
function do_edit(){
	getExcepDescGird().setEditSts(true);
}
function do_delete(){
if(!confirm("确认删除?")){
	return;
	}
	var ExGird=getExcepDescGird();
	var selectedRows=ExGird.getSelectedRows();
	for (var i=selectedRows.length-1;i>=0;i--){
		ExGird.deleteRow(selectedRows[i]);
	}
	do_save();
}


function do_save(){
var grid=getExcepDescGird();
if (grid.getTotalRowCount()>0){
		for (var i=0;i<grid.getTotalRowCount();i++)
		{
			if(grid.getValue(i,"EXCEPTION_DESC_CODE")==""){
				alert("异常情形编码不能为空");
				return;
			}
			if((grid.getValue(i,"EXCEPTION_DESC_CODE")=="")&&(grid.getValue(i,"EXCEPTION_DESC_NAME")==""))
			{
				alert("请不要保存空行");
				return;
			}
		}
	}
	var list = new Array(); 
	list.push(g_TableRowSetManager.get("exceptionDesc"));
	var url = _gModuleName+"/business/com.ai.comframe.web.exception.ExceptionAction?action=SaveExDesc";

	var rtn=saveRowSet(url,list,false,false);
	
	getExcepDescGird().setEditSts(false);

}