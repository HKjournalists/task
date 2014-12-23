

window.onload= function(){

	var docLoc=parseHtmlParameter(document.location.toString());
	 var _desc2=docLoc.getParameter("desc2");

	if (_desc2=="noValue"){
		alert("请先选择异常情形");
		parent.switchTab1();
	}
	else 
		queryByDescCode(_desc2);
		
}

function openHidden(){
var rtn=new Array();
rtn=window.showModalDialog("queryExcepCode.jsp",null,'status:no;dialogWidth:500px;dialogHeight:400px');
//document.getElementById("tempgrid").style.display="";
 var UnionGrid=getExcepRelationUnionGird();
	for (var i=0;i<rtn.length;i++){
		UnionGrid.newRow();
	 	UnionGrid.setValue(UnionGrid.getRow(),"EXCEPTION_CODE",rtn[i]);
		UnionGrid.setValue(UnionGrid.getRow(),"EXCEPTION_DESC_CODE",parseHtmlParameter(document.location.toString()).getParameter("desc2"));
		UnionGrid.setValue(UnionGrid.getRow(),"EXCEPTION_DESC_NAME",parseHtmlParameter(document.location.toString()).getParameter("descname"));
	}

}





function getExcepRelationUnionGird(){
	return g_TableRowSetManager.get("exceptionRelationUnion");
}

function getExcepRelGird(){
	return g_TableRowSetManager.get("exceptionRelation");
}










function rel(){
	var gridCode=getExcepRelationUnionGird();
	var selectedRows=gridCode.getSelectedRows();
	
	if (selectedRows.length<1) 
	{
		alert("请选中需要关联的行");
		return;
	}
	
	var desc=gridCode.getValue(selectedRows[0],"EXCEPTION_DESC_CODE");
	if (desc=="noValue"){
	alert("请在异常情形表中选择一个异常情形");
	top.switchTab1();
	return;
	}
	var url = _gModuleName+"/business/com.ai.comframe.web.exception.ExceptionAction?action=SaveExUnion";
	url+="&length="+selectedRows.length;
	url+="&desc="+desc;
	for (var i=0;i<selectedRows.length;i++){
	url+="&para"+i+"="+gridCode.getValue(selectedRows[i],"EXCEPTION_CODE");
	}
	//alert(url);
	var rt=PostInfo(url);
	alert(rt.getValueByName("MESSAGE"));
	
	if (rt.getValueByName("MESSAGE")=="SUCCESS"){
	queryByDescCode(desc);
	}
	else
	getExcepRelationUnionGird().refresh("&DescCode=");
	

}


function queryByDescCode(DescCode){
	getExcepRelationUnionGird().refresh("&DescCode="+DescCode);

}


function delete1(){
	var grid=getExcepRelationUnionGird();
	var selectedRows=grid.getSelectedRows();
	
	for (var i=selectedRows.length-1;i>=0;i--){
		grid.deleteRow(selectedRows[i]);
	}
}



/*
function saveRel(){
	var grid=getExcepRelGird();
	var list = new Array(); 
	list.push(grid);
	var url = _gModuleName+"/business/com.ai.comframe.web.exception.ExceptionAction?action=SaveRel";
	var rtn=saveRowSet(url,list,false,false);
	
}
*/

