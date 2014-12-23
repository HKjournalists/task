function STableRowSet_refresh(tUrl,tmpstr){
	tUrl = tUrl + "&localcache=stable";
	
	tmpstr = document.all('TableTagInfo_'+this.DBGridPK).value + tmpstr;
    
	var sRe=PostInfotoServer(tUrl,tmpstr);
	var xml = new ActiveXObject("Msxml.DOMDocument");
	xml.async = false;
	xml.loadXML(sRe);
	return xml.documentElement;
}

function STableRowSet_turnPage(aGridPK ,pageIndex){
	
	var tUrl = _gModuleName + "/gridturnpage?localcache=stable&action=turnpage&newpage=" + pageIndex;
    
    var tmpStr = document.all('TableTagInfo_'+aGridPK).value;
    tmpStr = tmpStr + document.all('TableTagCondition_'+aGridPK).value;
    var sRe=PostInfotoServer(tUrl,tmpStr);
	var xml = new ActiveXObject("Msxml.DOMDocument");
	xml.async = false;
	xml.loadXML(sRe);
	
	return xml.documentElement;
}

if(typeof(TableRowSet)!='undefined'){
	TableRowSet.prototype.s_refresh = STableRowSet_refresh;
	TableRowSet.prototype.s_turnPage = STableRowSet_turnPage;
}

if(typeof(TableRowSetSimple)!='undefined'){
	TableRowSetSimple.prototype.s_refresh = STableRowSet_refresh;
	TableRowSetSimple.prototype.s_turnPage = STableRowSet_turnPage;
}