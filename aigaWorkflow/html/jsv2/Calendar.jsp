<%@ page contentType="text/html; charset=GBK" %>

/**
 * 用于查询时打开日期控件，选择日期，并将日期填入对应的控件中。
 */
function calendar(obj, isDisplayTime) {
	var dlgLeft = event.screenX;
	var dlgTop = event.screenY;
    var url="<%=request.getContextPath()%>/jsv2/Calendar.htm";
    var character = "dialogWidth:394px;dialogHeight:280px;dialogLeft:"+dlgLeft+";dialogTop:"+dlgTop+";center:yes;help:no;resizable:no;status:no;scroll:no";
    var paramObj = new Array();
    paramObj[0] = obj;
    if (isDisplayTime == false) {
    	paramObj[1] = false;
    } else {
    	paramObj[1] = true;
    }
    window.showModalDialog(url,paramObj,character);
}
