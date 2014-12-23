function showMessage(point,str){  alert(point + "£º" +str);}
function showDebugger(point,str){  alert(point + "£º" +str);}
function showWarnning(point,str){  alert(point + "£º" +str);}
function showError(point,str){  alert(point + "£º" +str);}

function messagebox(hintContent){
 return window.showModalDialog("messagebox.htm",hintContent,"scroll:no;resizable:no;status:no;dialogHeight:150px;dialogWidth:300px");
}




  function g_getStringLength(str){
  if(str == null)
     return 0;
  var len = 0;
  for(var i=0;i<str.length;i++)
    if(str.charCodeAt(i) > 255)
      len =len + 2;
    else
      len = len + 1;
  return len;
}