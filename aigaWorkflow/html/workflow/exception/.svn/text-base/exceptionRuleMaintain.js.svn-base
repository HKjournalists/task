var _desc="";


window.onload= function(){

	var docLoc=parseHtmlParameter(document.location.toString());
	 _desc=docLoc.getParameter("desc");
	if (_desc=="noValue"){
		alert("请先选择异常情形");
		parent.switchTab1();
	}
	else 
	do_query(_desc);
}


	

function getExcepRuleGird(){
	return g_TableRowSetManager.get("exceptionRule");
}

function do_add(){
	var ExGird=getExcepRuleGird();
	ExGird.newRow();
	ExGird.setValue(ExGird.getRow(),"EXCEPTION_DESC_CODE",_desc);
	do_edit();
}

function do_query(DescCode){
	getExcepRuleGird().refresh("&Desc="+DescCode);
	
}
function do_edit(){
	getExcepRuleGird().setEditSts(true);
}
function do_delete(){
	if(!confirm("确认删除?")){
		return;
		}
	var ExGird=getExcepRuleGird();
	var selectedRows=ExGird.getSelectedRows();
	for (var i=selectedRows.length-1;i>=0;i--){
	ExGird.deleteRow(selectedRows[i]);
	}
	do_save();
}


function do_save(){
	var grid=getExcepRuleGird();
if (grid.getTotalRowCount()>0){
		for (var i=0;i<grid.getTotalRowCount();i++)
		{
			if((grid.getValue(i,"EXCEPTION_RULE_REMARKS")=="")&&(grid.getValue(i,"EXCEPTION_DESC_CODE")=="")&&(grid.getValue(i,"CURRENT_WORK_FLOW_CODE")=="")&&(grid.getValue(i,"NEXT_WORK_FLOW_CODE")==""))
			{
				alert("请不要保存空行");
				return;
			}
		}
	}
	var list = new Array(); 
	list.push(g_TableRowSetManager.get("exceptionRule"));
	var url = _gModuleName+"/business/com.ai.comframe.web.exception.ExceptionAction?action=SaveExRule";

	var rtn=saveRowSet(url,list,false,false);

	getExcepRuleGird().setEditSts(false);
}