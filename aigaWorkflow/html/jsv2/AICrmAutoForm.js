
function AICrmAutoFormDbLink(pDBFormPk,pFieldName,val,text,para)
{
    //查询是否有取参数的函数
    //如果有的话，则取出参数
    var param="";
    try{
      eval("param = getOpenWinFieldParam_" + pFieldName +"('"+pFieldName+"');");
    }catch(e){
      param="";
    }
   if(para!=null && !g_StringTrim(para)==""){
      var paraArray = para.split("|||");
      if(paraArray!=null && paraArray.length>=2)
      {
//	alert(paraArray[0]);
//	alert(paraArray[1]);
//	alert(_gModuleName);

	//否则直接调用
	var url = _gModuleName + paraArray[0];
	if (param!=null&&param!=""&&param!="undefined"){
	  url+=param;
	}
	return window.showModalDialog(url,window,paraArray[1]);
      }
      else
      {
	alert("[AICrmAutoFormDbLink]方法执行时参格式不正确.para="+para);
	return null;
      }
   }
}
