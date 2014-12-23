<%@ page contentType="text/html; charset=GBK" %>

<%
/**
  作者 ： 墙辉   2004/05/13
splitString(str,separator):  根据分割字符将字符串分割为数组
	参数说明：
	　　　　　　str: 原始字符串
	　　　　　　separator　：分隔符　　　　
	返回值说明：分割后的字符串数组

saveRowSet(aUrl,aRowSets,isSetStsToOld,isOnlySendModifyData,colnames,isIncludeDisplayAttr,isOnlySelectData):保存RowSet数组
	参数说明：
　　　　　　　　　　aUrl: URL地址
		   aRowSets:　RowSet数组
		   isSetStsToOld:是否在保存操作后将rowset得状态置为old 。 true/false
		   isOnlySendModifyData:是否只提交修改过的数据,缺省是true(只提交修改过的数据行)
		   colnames:需要提交数据集的列名,是一个数组,与aRowSets对应,每个数组元素是用","分隔的列明字符串
		   isIncludeDisplayAttr:是否提交显示属性,缺省是true(提交显示属性)
		   isOnlySelectData:是否只提交选中的数据，缺省是false
	返回值说明：UserDataClass 对象

copyRowSet(source,sourceRowIndex,dest,destRowIndex):拷贝数据集的一行数据
		　 source: 源数据集
		   sourceRowIndex:　源行号
		   dest:　目标数据集
		   destRowIndex: 目的行号

g_GetUserInfo（）：在js脚本中获取当前登陆用户信息的方法v

g_ShowDefineQryDlg(pFuncCode,pStaffId  )   弹出对话框，显示自定义查询的设置对话框
	    pFuncCode 功能模块编码
	   pStaffId 员工的staffid值，如果为空显示当前登陆员工的staffid
	  return true/false 表示数据是否更新过。


*/
%>
//日期分割符
var DATE_SEPARATOR = "-";

var _gModuleName = "<%=request.getContextPath()%>";
var _WBS_LOGINOUT_FLAG ="<LOGIN_OUT>LOGINOUT</LOGIN_OUT>";//登出标志
var _LOGIN_OUT_PAGE = _gModuleName+"<%=com.ai.appframe2.common.SessionManager.getLoginOutWebPageUrl()%>";
var _isClearCacheObj = "<%=com.ai.appframe2.common.AIConfigManager.getConfigItem("IS_CLEAR_PAGE_CACHE")%>";


function gCheckLogOut(pXml){

 if(pXml == _WBS_LOGINOUT_FLAG){
    window.location = _LOGIN_OUT_PAGE;
 }
 else if(pXml.indexOf(_WBS_LOGINOUT_FLAG)>0)
	window.location = _LOGIN_OUT_PAGE;
 else
	 return pXml;
}

function splitString(str,separator)
{
   if (!(str)) return new Array(0);
   if (!(separator)) return new Array(str);
   var List = new Array(0);
   var tmpStr = "";
   var index = 0;
   while (str)
   {  index = str.indexOf(separator);
      if (index < 0)    //没有找到
      { List[List.length] = (str);
	str = null;
	break;
      }
      else if (index ==0)  // 分隔符号前面没有其它字符
	 str = str.substr(index + separator.length);
      else
      {    tmpStr = str.substring(0,index);
	   List[List.length]=(tmpStr);
		 str = str.substr(index + separator.length);
      }
   }
   return List;
}



/**
  modify by qianghui 2004/09/03 add parameter isOnlySendModifyData
  modify by qianghui 20050704 add parameter colnames(保存指定的列到后台，列名称数组)
 */
function saveRowSet(aUrl,aRowSets,isSetStsToOld,isOnlySendModifyData,colnames,isIncludeDisplayAttr,isOnlySelectData){
   var beforeSaveRowSetFunc = null;
   try
   {
      eval("beforeSaveRowSetFunc=g_AIBeforeSaveRowSetFunc");
   }
   catch(e)
   {
      beforeSaveRowSetFunc =null;
   }
   if(beforeSaveRowSetFunc!=null)
   {
     beforeSaveRowSetFunc(aRowSets);
   }
   if(isSetStsToOld==null)
     isSetStsToOld = true;
   
   //默认将不提交显示属性
   if(isIncludeDisplayAttr==null){
    isIncludeDisplayAttr = false;
   }
   if(isOnlySelectData == null){
     isOnlySelectData = false;
   }
    
   if (aRowSets == null || aRowSets.length == 0){
      alert("没有设置需要保存的数据集！");
      return ;
   }

   var tmpstr  = "<RootInfo>"
   for(var i =0 ; i < aRowSets.length;i ++){
     if(colnames != null && colnames[i]!=null){
       if(isOnlySelectData == false){
	       tmpstr = tmpstr + aRowSets[i].toXmlString(isOnlySendModifyData,colnames[i],isIncludeDisplayAttr);
	     }
	     else{
	       tmpstr = tmpstr + aRowSets[i].toXmlStringOfSelects(isOnlySendModifyData,colnames[i],isIncludeDisplayAttr);
	     }
	   }
     else{
       if(isOnlySelectData == false){
	       tmpstr = tmpstr + aRowSets[i].toXmlString(isOnlySendModifyData,null,isIncludeDisplayAttr);
	     }
	     else{
	       tmpstr = tmpstr + aRowSets[i].toXmlStringOfSelects(isOnlySendModifyData,null,isIncludeDisplayAttr);
	     }
	   }
   }
   tmpstr = tmpstr   + "</RootInfo>";
   var sRe=PostInfotoServer(aUrl,tmpstr);
   var xml = g_GetXMLDocument();
   xml.loadXML(sRe);
   var xmlNode = xml.documentElement;
   var ud = createUserDataClass(xmlNode,true);

   var flag =ud.getValueByName("FLAG");
   var message =ud.getValueByName("MESSAGE");
   if((flag != "ERROR") && (isSetStsToOld == true)){
     for(var i =0 ; i < aRowSets.length;i ++)
	 aRowSets[i].setStsToOld();
   }
   if(message){
       var infoDiv = document.all("ErrorOrInfo");
       if (infoDiv)
	  infoDiv.innerText = message;
       else
	  alert(message);
   }
   return ud;
}
/**
 * 拷贝数据集的一行数据
　* source: 源数据集
  * sourceRowIndex:　源行号
  * dest:　目标数据集
  * destRowIndex: 目的行号
 */
function copyRowSet(source,sourceRowIndex,dest,destRowIndex){
  var cols = source.getColNames();
  var sourceClassName = source.getClassName();
  var destClassName = dest.getClassName();
  if((sourceClassName == "FormRowSet") && (destClassName == "FormRowSet")){
    for(var i=0;i < cols.length; i++)
      dest.setValue(cols[i],source.getValue(cols[i]),source.getDisplayText(cols[i]) );
  }else if(sourceClassName == "FormRowSet"){
     for(var i=0;i < cols.length;i++)
       dest.setValue(destRowIndex,cols[i],
	    source.getValue(cols[i]),
	    source.getDisplayText(cols[i]) );
  }else if(destClassName == "FormRowSet"){
    for(var i=0;i < cols.length;i++)
       dest.setValue(cols[i],
	    source.getValue(sourceRowIndex,cols[i]),
	    source.getDisplayText(sourceRowIndex,cols[i]) );
  }else{
    for(var i=0;i < cols.length;i++)
      dest.setValue(destRowIndex,cols[i],
	    source.getValue(sourceRowIndex,cols[i]),
	    source.getDisplayText(sourceRowIndex,cols[i]) );
  }
}






function getXmlNodeFromStr(str)
{
  var xml= g_GetXMLDocument();
  xml.async = false;
  xml.loadXML(str);
  return xml.documentElement;
}


function callXMLHTTP(url,xml){
    if(typeof(monitor_flag)=='undefined'){
      monitor_flag = false;
    }
    if (url.indexOf("?") >=0)
      url = url +"&url_source=XMLHTTP";
    else
      url = url +"?url_source=XMLHTTP";
      
    if(monitor_flag ==true){
       url = url + getLogString();
       recordExecStartTime();
    }

    var XMLSender = g_GetXMLHTTPRequest();
    XMLSender.Open("POST",url,false);
    XMLSender.setRequestHeader("Content-Type","multipart/form-data");
    XMLSender.send(xml);
   
   
    if(monitor_flag ==true){
      recordExecEndTime();
    }
    return XMLSender.responseText;
}

function PostInfotoServer(url,xml){
    if(xml ==null)
      return;

    return gCheckLogOut(callXMLHTTP(url,xml));

}

function PostInfo(url,xml){

   var sRe = gCheckLogOut(callXMLHTTP(url,xml));

   var xml = g_GetXMLDocument();
   xml.loadXML(sRe);
   var xmlNode = xml.documentElement;
   var ud = createUserDataClass(xmlNode,true);
   return ud;
}

function sendToServer(url,xml){
   if(xml==null) xml="";
   var sRe = PostInfotoServer(url,xml);
   var xml = g_GetXMLDocument();
   xml.loadXML(sRe);
   var xmlNode = xml.documentElement;

   var ud = createUserDataClass(xmlNode,true);
   var message =ud.getValueByName("MESSAGE");
   if(message){
       var infoDiv = document.all("ErrorOrInfo");
       if (infoDiv)
	  infoDiv.innerText = message;
       else
	  alert(message);
   }
   return ud;
}

/**
add by zr 20060420增加
可将param通过post方法传递到action中，而不是放在url后面传递
pUrl---页面链接
pParam---参数对，如aa=123&bb=456
该方法传递参数中若有中文，后台获取时应使用UTF8进行转码。
HttpUtil.getParameter(req,"参数名称",HttpUtil.CHARSET_UTF8);
*/
function postParamToServer(pUrl,pParam)
{
   if(typeof(monitor_flag)=='undefined'){
      monitor_flag = false;
    }
    if(monitor_flag ==true){
       pUrl = pUrl + getLogString();
       recordExecStartTime();
    }
  var XMLSender = g_GetXMLHTTPRequest();
  XMLSender.Open("POST",pUrl,false);
  XMLSender.setRequestHeader("CONTENT-TYPE","application/x-www-form-urlencoded");
  //XMLSender.setRequestHeader("CONTENT-TYPE","application/x-www-form-urlencoded");
  XMLSender.setrequestheader("CONTENT-LENGTH",pParam.length);
  XMLSender.send(pParam);
  if(monitor_flag ==true){
      recordExecEndTime();
    }
  return XMLSender.responseText;
}
/**
  返回值为UserData对象
*/
function postParam(pUrl,pParam)
{
   var sRe = postParamToServer(pUrl,pParam);
   var xml = g_GetXMLDocument();
   xml.loadXML(sRe);
   var xmlNode = xml.documentElement;
   var ud = createUserDataClass(xmlNode,true);
   return ud;
}





/**
add by zr 判断是否当前用户已经被注销。若被注销就跳转到登录界面
用于createRowSetFactory
 */

function userValidCheckByNode(pXmlNode)
{
	if(pXmlNode!=null && pXmlNode.baseName=="LOGIN_OUT")
	{
	 var strURL= _gModuleName + "/index.jsp";
	 alert("当前用户已超时或者被管理员注销，请重新登录!");
	  var winObj = getTopWin();
	 if(winObj!=null)
	      winObj.location = strURL;
	  else
	      top.location = strURL;
	  return false;
	}
	return true;
}



/**
对条件字符串中的特殊字符进行编码
 */
function g_ConditonStrEncode(pStr)
{
   if(pStr==null || pStr=="") return pStr;

   var reStr = pStr;
   //对"%"进行转化
   reStr = reStr.replace(/%/g,'%25');
   //对"="进行转化
   reStr = reStr.replace(/=/g,'%3D');
   //对"+"进行转化
   reStr = reStr.replace(/[+]/g,'%2B');
   //对'&'进行转换
   reStr = reStr.replace(/&/g,'%26');

   //对'#'进行转换
   reStr = reStr.replace(/#/g,'%23');

   return reStr;
}

function g_ConditonStrDecode(pStr)
{
   if(pStr==null || pStr=="") return pStr;

   var reStr = pStr;
   //对"%"进行转化
   reStr = reStr.replace('%25','%');
   //对"="进行转化
   reStr = reStr.replace('%3D','=');
   //对"+"进行转化
   reStr = reStr.replace('%2B','+');
   //对&进行转化
   reStr = reStr.replace('%26','&');

   //对#进行转化
   reStr = reStr.replace('%23','#');

   return reStr;
}

/**
进行特殊字符替换,add by zhuwg
 */
function g_CheckAndTransStr(str)
  {
    str = str.toString();
    if(str=="") return str;
    strArray=str.split("&");
    tmpStr=strArray[0];
    if(strArray.length>1)
	for(i=1;i<strArray.length;i++)
    {
      tmpStr+="&amp;";
      tmpStr+=strArray[i];
    }
    str=tmpStr;
    while(str.indexOf(">")>=0)
    {
      index=str.indexOf(">");
      str=str.substring(0,index)+"&gt;"+str.substring(index+1,str.length);
    }
    while(str.indexOf("<")>=0)
    {
      index=str.indexOf("<");
      str=str.substring(0,index)+"&lt;"+str.substring(index+1,str.length);
    }
    while(str.indexOf("'")>=0)
    {
      index=str.indexOf("'");
      str=str.substring(0,index)+"&apos;"+str.substring(index+1,str.length);
    }
    while(str.indexOf('"')>=0)
    {
      index=str.indexOf('"');
      str=str.substring(0,index)+"&quot;"+str.substring(index+1,str.length);
    }
    return str;
  }




/**
 * 在js脚本中获取当前登陆用户信息的方法
 */
function g_GetUserInfo()
{
  var obj = document.all("AIFRAME2_LOGIN_USER");
  if(obj)
  {
    if(obj.length && obj.length>1)
	  {
		alert("每一个页面中只能加入唯一的一个<AI:LOGINUSER/>标签");
	return;
	  }
	return obj;
  }
  else
  {
    alert("获取当前登陆用户信息出错，请确认您是否在页面中加入<AI:LOGINUSER/>标签");
    return null;
  }
}

/**
 * 用于查询时打开日期控件，选择日期，并将日期填入对应的控件中。
 */
function getNewDate(obj){
  var dlgLeft = event.screenX;
  var dlgTop = event.screenY;
  var oldDate = null;
  if(!!obj.value)
    oldDate =obj.value;
   var showType = "date";
  var paramObj = {showtype:showType,definedate:oldDate};
  var newDate = window.showModalDialog( _gModuleName+ "/jsv2/DBCalendarDlg.htm",paramObj,"scroll:no;resizable:no;status:no;dialogLeft:"+dlgLeft+";dialogTop:"+dlgTop+";dialogHeight:280px;dialogWidth:230px");
  if (newDate!="none"){
     obj.value = newDate;
  }
}
/**用于查询时打开日期时间控件，选择日期时间，并将日期时间填入对应的控件中。*/
function getNewDateTime(obj){
  var dlgLeft = event.screenX;
  var dlgTop = event.screenY;
  var oldDateTime = null;
  if(!!obj.value)
    oldDateTime =obj.value;
   var showType = "datetime";
  var paramObj = {showtype:showType,definedate:oldDateTime};
  var newDateTime = window.showModalDialog( _gModuleName+ "/jsv2/DBCalendarDlg.htm",paramObj,"scroll:no;resizable:no;status:no;dialogLeft:"+dlgLeft+";dialogTop:"+dlgTop+";dialogHeight:320px;dialogWidth:240px");
  if (newDateTime!="none"){
     obj.value = newDateTime;
  }
}

/**
 * 获取最高级的window对象
 */
function getTopWin()
{
  if (window.name == "WebFrameSet")
  {
    return window;
  }
  
  var w = window;
  if (window == window.parent)
  {
  	
    if (window.opener)
    {
	w = window.opener;
	try{
		while ( w.opener!=null && (w != w.opener))
		{
		  if (w.name == "WebFrameSet")
		   {
		     return w;
		   }
		  w = w.opener;
		}
	}catch(e){
		return window;
	}
	
    }
    else
    {
       return window;
    }
  }
  else
  {
     w = window.parent;
     while (w.parent && (w != w.parent))
	{
	  if (w.name == "WebFrameSet")
	   {
	     return w;
	   }
	  w = w.parent;
	}
  }

  return w;
}



function arrayRemove(a,index)
{
    for(var i=index;i < a.length -1;i++)
      a[i] = a[i +1];
    a.length = a.length - 1;
    return a;
}
function arrayShift(inArray){
  var result = new Array();
  for(var i=0;i < inArray.length - 1;i++){
     result[i] = inArray[i + 1];
  }
  return result;
}
function arrayRemoveNoSort(a,index)
{
    a[index] = a[a.length - 1];
    result = a[a.length - 1];
    a.length = a.length - 1;
    return result;
}

function indexOfArray(arr,data)
{ var result = -1;
  if(arr)
   for(var i=0;i < arr.length;i++)
   { //alert(i+ '---' + data +'---' + arr.toString());
     if (arr[i] == data)
     {
       result =  i;
       break;
     }
   }
  //alert( result + '---' + arr.toString() + '---' + data );
  return result;
}

function g_TransCharge(pFloatCharge){
    var dw2 = new Array("","万","亿");//大单位
	var dw1 = new Array("拾","佰","千");//小单位
	var dw = new Array("零","壹","贰","叁","肆","伍","陆","柒","捌","玖");//整数部分用
	var dws = new Array("零","壹","贰","叁","肆","伍","陆","柒","捌","玖");//小数部分用
	var ifnegative = 0;
	if(pFloatCharge < 0)
		ifnegative = 1;
	var whole = new String(Math.abs(pFloatCharge));
	//分离整数与小数
	var num;
	var dig;
	if(whole.indexOf(".") == -1)
	{
		num = whole;
		dig = "";
	}
	else
	{
		num = whole.substring(0,whole.indexOf("."));
		dig = whole.substring( whole.indexOf(".")+1, whole.length);
	}
	//转换整数部分
	var i=1;
	var len = num.length;


	var k1=0;//计小单位
	var k2=0;//计大单位
	var str="";

	for(i=1;i<=len;i++)
	{
		var n = num.charAt(len-i);
		str = dw[Number(n)].concat(str);//加数字

		if(len-i-1>=0)//在数字范围内
		{
			if(k1!=3)//加小单位
			{
				str = dw1[k1].concat(str);
				k1++;
			}
			else//不加小单位，加大单位
			{
				k1=0;
				var temp = str.charAt(0);
				if(temp=="万" || temp=="亿")//若大单位前没有数字则舍去大单位
					str = str.substr( 1, str.length-1);
				str = dw2[k2].concat(str);
			}
		}

		if(k1==3)//小单位到千则大单位进一
		{
			k2++;
		}
	}
	str+="元";
	//转换小数部分

	for(i=0;i<2;i++){
		var n = dig.charAt(i);
		if (i==0)
		{
			str = str+dws[Number(n)]+"角";
		}
		else if(i==1)
		{
			str = str+dws[Number(n)]+"分";
		}
	}
   if(ifnegative ==1)
		str = "负" + str;
	return str;

}

//设置按钮状态
function AIButtonSetDisabled(flag){
   //如果设置成可编辑状态，则要判断权限
  if(flag==false){
    if(this.OperatorAuthor !=null && 
        (this.OperatorAuthor==false || this.OperatorAuthor=='false')){
      return;
    }
  }
  
  this.disabled = flag;
}

//获取httpRequest对象的标准方法
function g_GetXMLHTTPRequest() {
  var xRequest=null;
  if (typeof ActiveXObject != "undefined"){
    //Internet Explorer     
    xRequest=new ActiveXObject
     ("Microsoft.XMLHTTP");   
  }
  else if (window.XMLHttpRequest) {                        
//Mozilla/Safari
    xRequest=new XMLHttpRequest();   
}
  return xRequest;
}
//获取xmlDom的标准方法
function g_GetXMLDocument(){
  var xDoc=null;
  if (typeof(ActiveXObject)!= "undefined"){
    var msXmlAx=null;
    //Newer Internet Explorer
    try{
      msXmlAx=new ActiveXObject("Msxml2.DOMDocument");   
    }catch (e){
      //Older Internet Explorer
      msXmlAx=new ActiveXObject("Msxml.DOMDocument");   
    }
    xDoc=msXmlAx;
  }
  else if (document.implementation && document.implementation.createDocument){ 
    //Mozilla/Safari
    xDoc=document.implementation.createDocument("","",null);   
  }
  if (xDoc==null || typeof xDoc.load=="undefined"){
    xDoc=null;
  }
  return xDoc;
}
