/**
         g_getContentFrame(id)：获取ContentFrame对象
	　   getTitle()：获取标题文本
	     setTitle(pTitle):设置ContentFrame的标题文本
*/
function g_getContentFrame(id){
	var UIObject = document.all("AIContentFrame_"+id);
	if(UIObject == null){
	    alert("未能找到ContentFrame对象, 对象Id:" + id);
	    return;
	}
    if(UIObject.getTitle == null){
	       UIObject.getTitle = AIContentFrame_getTitle;
	       UIObject.setTitle = AIContentFrame_setTitle;
	     
    }
	return UIObject;
}

function AIContentFrame_getTitle()
{
   var titleObj = document.all(this.id+"_Title");
   if(titleObj)
	   return titleObj.innerText;
}

function AIContentFrame_setTitle(pTitle)
{
 var titleObj = document.all(this.id+"_Title");
   if(titleObj)
		titleObj.innerText = pTitle;
}

