/**
	文件名称：CommonUtil.js
	作者	: zhongrui
	编制时间: 2005-03-24
	文件内容：一些常用的js公用类。工具类
	包括方法：
	g_FormFieldIsNull	 判断DBForm的指定字段是否为空
	g_GetObjXY 		 获取页面中某个元素的绝对座标
	g_IsDigit    		 校验是否全由数字组成
	g_IsFloat(s,pDecimal) 校验是否是合法的小数
	g_IsEmail 		 判断合法的email地址
	g_IsTeleNumber		 校验普通电话、传真号码：可以“+”开头，除数字外，可含有“-”
	g_IsPostalCode 		校验邮政编码 6位数字
	g_IsMobileNumber 	校验手机号码：必须以数字开头，除数字外，可含有“-”
	g_IsDate		判断日期格式是否合法，符合yyyy-mm-dd
	g_IsDateTime		校验日期时间是否合法yyyy-mm-dd H24:MI:SS这种格式的日期+时间
	g_getStrLen 		获取字符串的长度，如果字符串中包括中文等双字节代码，则其长度算为2。
	g_getSubStrInByte			获取子字符串，参数长度为字节长度。
	g_StringTrim		字符串trim方法，取消到前后的空格
	g_GetSysDateTime	请求数据库获取数据库的日期和时间
	g_GetSysDate		请求数据库获取数据库日期
	g_GetSysTime		请求数据库获取数据库时间
  g_CheckInputNum         控制只能输入数字
  g_IDCardNumber      判断是否是身份证号码
  g_FormatDate(aDate,format) 格式化日期时间方法PARAMETER: aDate:js中的aDate对象,format-格式字符串.如:yyyy-MM-dd hh:mm:ss
  
  g_BeforePasteNum()  粘贴时控制只能贴入数字和回车 需要绑定onbeforePaste事件
  g_BeforePasteEnglish() 粘贴时控制只能贴入数字和字母，需要绑定onbeforePaste事件
  
  g_CompareDate       判断日期大小
  g_MonthsBetween	  计算月份差(忽略天，先将时间trunc到月，然后做比较)
**/


/**
 判断DBForm的指定字段是否为空，如果为空返回true，并alert警告。否则返回false
 pFormRowSet -- DBFormRowSet对象
 pFieldNames -- 校验的字段名称串，每个字符以"," 分割
*/

function g_FormFieldIsNull(pFormRowSet,pFieldNames)
{
	var flag = false;
	if(pFormRowSet == null || pFieldNames==null || pFieldNames=="")
	{
		alert("参数为空，检查");
		return flag;
	}
    var fieldArray = pFieldNames.split(",");
	if(fieldArray!=null && fieldArray.length>0){
	  for (var i=0;i<fieldArray.length ;i++ )
	  {
	var fieldValue = pFormRowSet.getValue(fieldArray[i]);
	if(fieldValue!=null && g_StringTrim(fieldValue)==""){

		  var fieldText = pFormRowSet.getTitle(fieldArray[i]);
		  alert(fieldText+"不可为空，请检查");
		  flag = true;
		  break;
		}
	  }

	}
    return flag;

}



 /*********************************************************************************
* FUNCTION: g_GetObjXY 获取页面中某个元素的绝对座标
* PARAMETER: obj,dhtml 对象
* RETURNS: array，array['x']=xpos,array['y']=ypos
*********************************************************************************/
function g_GetObjXY(Obj)
 {
	 for(var sumTop=0,sumLeft=0;Obj!=document.body;sumTop+=Obj.offsetTop,sumLeft+=Obj.offsetLeft,Obj=Obj.offsetParent);
	return {left:sumLeft,top:sumTop};

 }



 /*********************************************************************************
* FUNCTION: g_IsEmail 判断合法的email地址
* PARAMETER: String (Email Address)
* RETURNS: TRUE if the String is a valid Email address
* FALSE if the passed string is not a valid Email Address
* EMAIL FORMAT: AnyName@EmailServer e.g; webmaster@hotmail.com
* @ sign can appear only once in the email address.
*********************************************************************************/
function g_IsEmail (theStr) {
if(theStr==null || theStr=='')return true;
var atIndex = theStr.indexOf('@');
var dotIndex = theStr.indexOf('.', atIndex);
var flag = true;
theSub = theStr.substring(0, dotIndex+1)

if ((atIndex < 1)||(atIndex != theStr.lastIndexOf('@'))||(dotIndex < atIndex + 2)||(theStr.length <= theSub.length))
{ return(false); }
else { return(true); }
}



/*********************************************************************************
* FUNCTION: g_IsDigit 校验是否全由数字组成
* PARAMETER: 字符串s
* RETURNS: true/false
*********************************************************************************/

function g_IsDigit(s)
{
 if(s==null) return false;
 if(s=='')return true;
 s=''+s;
 if(s.substring(0,1)=='-' && s.length>1)s=s.substring(1,s.length);

var patrn=/^[0-9]*$/;
if (!patrn.exec(s)) return false;
return true
}

/*********************************************************************************
* FUNCTION: g_IsFloat 校验是否是小数
* PARAMETER: 字符串s.pDecimal精度（保留多少位小数 值为0或者－1时不限制精度）
* RETURNS: true/false
*********************************************************************************/
function g_IsFloat(s,pDecimal)
{
 if(s==null) return false;
 s=''+s;
 if(s=='')return true;
 
 if(s.substring(0,1)=='-' && s.length>1)s=s.substring(1,s.length);

 var dec = -1;
 if(parseInt(pDecimal)!=NaN)
   dec = pDecimal;
 var reg = "^[0-9]+(\\.[0-9]{1,"+dec+"})?$";
 if(dec==0 || dec==-1)
 {
   reg = "^[0-9]+(\\.[0-9]{1,10000})?$";
 }
 var re = new RegExp(reg,"g");
 if(!s.match(re)) return false;
 else return true;

}


/*********************************************************************************
* FUNCTION: g_IsTeleNumber 校验普通电话、传真号码：可以“+”开头，除数字外，可含有“-”
* PARAMETER: 字符串s
* RETURNS: true/false
*********************************************************************************/

function g_IsTeleNumber_bak(s)
{
if(s==null || s=='')return true;
if(s.length>20)return false;
var patrn=/^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/;
if (!patrn.exec(s)) return false
return true
}
function g_IsTeleNumber(s)
{
if(s==null || s=='')return true;
if(s.length>20 || s.length<4)return false;

var re = new RegExp(/^[\d'('')'' '\*\-]*$/);

if(re.exec(s))return true;
else return false;
}
/*********************************************************************************
* FUNCTION: g_IsMobileNumber 校验手机号码：必须以数字开头，除数字外，可含有“-”
* PARAMETER: 字符串s
* RETURNS: true/false
*********************************************************************************/

function g_IsMobileNumber_bak(s)
{
var patrn=/^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/;
if (!patrn.exec(s)) return false
return true
}

//新的手机号码验证，以1打头，11位数字
function g_IsMobileNumber(s)
{
if(s==null || s=='')return true;
if( s.length!=11 || ( s.substring(0,2)!='13' && s.substring(0,2)!='15'))return false;
if(!g_IsDigit(s))return false;
return true
}
/*********************************************************************************
* FUNCTION: g_IsPostalCode 校验邮政编码 6位数字
* PARAMETER: 字符串s
* RETURNS: true/false
*********************************************************************************/

//
function g_IsPostalCode(s)
{
if(s==null || s=='')return true;
var patrn=/^[0-9]{6}$/;
if (!patrn.exec(s)) return false
return true
}





/*********************************************************************************
* FUNCTION: g_IsDate 校验日期是否合法yyyy-mm-dd这种格式的日期
* PARAMETER: 字符串s
* RETURNS: true/false
*********************************************************************************/

function g_IsDate(str)
{
	if(str=='')return true;
   if(DATE_SEPARATOR==null) DATE_SEPARATOR ="-";
   var regExpStr = "^\\d{4}" + DATE_SEPARATOR + "\\d{1,2}" + DATE_SEPARATOR + "\\d{1,2}$";
   var patrn = new RegExp(regExpStr);

   if(!patrn.exec(str)) return false;
   var dateArray  = str.split(DATE_SEPARATOR);
   var d= new Date(dateArray[0],dateArray[1]-1,dateArray[2]);
   var issame =(d && (d.getFullYear()==dateArray[0])&& (d.getMonth()+1==dateArray[1]) &&(d.getDate()==dateArray[2]));
   if (!issame)
       {
	 return false;
       }
   return true;
}

/*********************************************************************************
* FUNCTION: g_IsDateTime 校验日期是否合法yyyy-mm-dd H24:MI:SS这种格式的日期+时间
* PARAMETER: 字符串s
* RETURNS: true/false
*********************************************************************************/
function g_IsDateTime(str)
{
	if(str=='')return true;
   if(DATE_SEPARATOR==null) DATE_SEPARATOR ="-";
   var regExpStr = "^\\d{4}" + DATE_SEPARATOR + "\\d{1,2}" + DATE_SEPARATOR + "\\d{1,2}\\s\\d{2}:\\d{1,2}:\\d{1,2}$";
   var patrn = new RegExp(regExpStr);

   if(!patrn.exec(str)) return false;
   var dateTimeArray = str.split(" ");
   if(dateTimeArray==null || dateTimeArray.length!=2) return false;
   var dateArray  = dateTimeArray[0].split(DATE_SEPARATOR);
   var timeArray = dateTimeArray[1].split(":");
   var d= new Date(dateArray[0],dateArray[1]-1,dateArray[2],timeArray[0],timeArray[1],timeArray[2]);
   var issame =(d && (d.getFullYear()==dateArray[0])&& (d.getMonth()+1==dateArray[1]) &&(d.getDate()==dateArray[2]) && (d.getHours() == timeArray[0]) && (d.getMinutes()== timeArray[1]) && (d.getSeconds()== timeArray[2])  );
   if (!issame)
       {
	 return false;
       }
   return true;
}

/*********************************************************************************
* FUNCTION: 获取字符串的长度，如果字符串中包括中文等双字节代码，则其长度算为2。
* PARAMETER: 字符串s
* RETURNS: int
*********************************************************************************/
function g_GetStrLen(str){
  str = str.toString(10);
  return str.replace(/[^\x00-\xff]/g,"aa").length;
}

/*********************************************************************************
* FUNCTION: 获取子字符串，参数长度为字节长度
* PARAMETER: str字符串，length获取长度，已字节为单位，如双字节，按照2处理，子串取ground
* RETURNS: int
*********************************************************************************/
function g_getSubStrInByte(str,lenth){
  str = str.toString(10);
  var tmpstr= str.replace(/[^\x00-\xff]/g,"\x0b\x0c");

	tmpstr =tmpstr.substring(0,lenth);
	tmpstr = tmpstr.replace(/\x0b/g,'');
	return str.substring(0,tmpstr.length);
}

/*********************************************************************************
* FUNCTION: 字符串trim方法，取消到前后的空格
* PARAMETER: 字符串s
* RETURNS: string字符串
*********************************************************************************/
function g_StringTrim(str){
  str = str.toString(10);
  return str.replace(/(^\s*)|(\s*$)/g, "");
}



/*********************************************************************************
* FUNCTION: 请求数据库获取数据库的日期和时间
* PARAMETER: null
* RETURNS: string字符串
*********************************************************************************/
function g_GetSysDateTime()
{
     var _gNode = null;
     var xml= new ActiveXObject("Msxml.DOMDocument");
     xml.async = false;
     var url=  _gModuleName+ "/business/com.ai.appframe2.web.DefaultAction?action=getSysDateTime";
     var b = xml.load(url);
     if(!b){
	    alert("无法获取时间信息,请检查:\n当前用户是否已经失效.\n网络连接是否正常.\n数据库运行是否正常");
		return null;
	  }

      var xmlNode = xml.documentElement;
      var ud = createUserDataClass(xmlNode,true);
      return ud.getValueByName("DateTime");
}



/*********************************************************************************
* FUNCTION: 请求数据库获取数据库日期
* PARAMETER: null
* RETURNS: string字符串
*********************************************************************************/

function g_GetSysDate()
{
   var dateTime = g_GetSysDateTime();
   var date = null;
   if(dateTime!=null && dateTime.indexOf(' ')!=null)
	{
	   date = dateTime.substring(0,dateTime.indexOf(' '));
	}
  return date;
}

/*********************************************************************************
* FUNCTION: 请求数据库获取数据库的时间
* PARAMETER: null
* RETURNS: string字符串
*********************************************************************************/
function g_GetSysTime()
{
   var dateTime = g_GetSysDateTime();
   var time = null;
   if(dateTime!=null && dateTime.indexOf(' ')!=null)
	{
	   time = dateTime.substring(dateTime.indexOf(' ')+1,dateTime.length);
	}
  return time;
}


/*********************************************************************************
* FUNCTION: 控制只能输入数字和回车
* PARAMETER: null
* RETURNS: null
*********************************************************************************/
function g_CheckInputNum(obj){
  var keyCode = event.keyCode;

  if(keyCode==8)return;
  if(keyCode==46)return;
  if(keyCode==35)return;
  if(keyCode==36)return;
  if(keyCode==37)return;
  if(keyCode==39)return;
  if(event.keyCode==13)return;

  //支持ctrl + a、v、x、c
  if(event.ctrlKey && (keyCode==65 || keyCode==67
    ||keyCode==86 || keyCode==88)){
    if(keyCode==86){
      var str = window.clipboardData.getData('text');
      if(str!=null){
        str = str.replace(/[^\d\n]/g,'');
        str = str.replace(/[\n]+/g,'\n');
        window.clipboardData.setData('Text',str);
      }
    }
    return;
  }

  if(48>event.keyCode || (event.keyCode > 57 && event.keyCode < 96)
     || event.keyCode >105 ){
    event.returnValue=false;
  }
  //对微软输入法的特殊限制
  if(keyCode ==229 && obj !=null){
    obj.disabled = true;
    obj.disabled = false;
    obj.focus();
    obj.value = obj.value.replace(/[^\d]/g,'');
  }
}

/*********************************************************************************
* FUNCTION: 控制只能输入数字或字母等
* 允许的字母如下："0123456789-_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "
* PARAMETER: null
* RETURNS: null
*********************************************************************************/

function g_CheckInputEnglish(obj){
  var keyCode = event.keyCode;

  if(keyCode==8)return;
  if(keyCode==46)return;
  if(keyCode==35)return;
  if(keyCode==36)return;
  if(keyCode==37)return;
  if(keyCode==39)return;
  if(event.keyCode==13)return;

  //支持ctrl + a、v、x、c
  if(event.ctrlKey && (keyCode==65 || keyCode==67
    ||keyCode==86 || keyCode==88)){
    //
    if(keyCode==86){
      var str = window.clipboardData.getData('text');
      if(str!=null){
        str = str.replace(/[\W]/g,'');
        window.clipboardData.setData('Text',str);
      }
    }
    return;
  }

  var checkOK = "0123456789-_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";

  var str = String.fromCharCode(keyCode);

  if(checkOK.indexOf(str)<0 ){
    event.returnValue=false;
  }
  //对微软输入法的特殊限制
  if(keyCode ==229 && obj !=null){
    obj.disabled = true;
    obj.disabled = false;
    obj.focus();
    obj.value = obj.value.replace(/[\W]/g,'')
  }
}


//判断是否是身份证号码
function g_IDCardNumber(value){
  if(value=='' || value==null)return true;
  var length = value.length;

  if(length ==15){
    if(!g_IsDigit(value) || value.substring(0,1)=='-'){
      return false;
    }
    return true;
  }else if(length ==18){
    //前17位必须是数字
    for (i= 0; i < 17;  i++){
      code = value.charCodeAt(i);
      if(code<48 || code>57)return false;
    }
    //18位身份证号码的最后一位可以是数字或英文字母
    code = value.charCodeAt(17);
    if(code>=48 && code<=57 || code>=65 && code<=90 || code>=97 && code<=122){
      return true;
    }
  }
  //位数不为15或者18则返回
  return false;
}

//判断日期大小,输入两个日期字符串，返回两个日期的大小
// 0一样大 ，1 第一日期大 ，-1 第二个日期大,-2错误
function g_CompareDate(date_str1 ,date_str2){
  if(date_str1 ==null)date_str1='';
  if(date_str2==null ) date_str2='';

  if(date_str1 ==date_str2)return 0;

  if( !g_IsDateTime(date_str1) && !g_IsDate(date_str1)
      || !g_IsDateTime(date_str2) && !g_IsDate(date_str2) ){
    alert('无法比较日期值，请确认比较的两个值都为合法的时间类型！');
    return -2;
  }

  if(date_str1 =='' && date_str2 !='') return -1;
  if(date_str2 =='' && date_str1 !='')return 1;

  var hour =0;
  var min =0;
  var sec =0;

  var dateTimeArray = date_str1.split(" ");
  var dateArray  = dateTimeArray[0].split(DATE_SEPARATOR);
  if(dateTimeArray.length>1){
    var timeArray = dateTimeArray[1].split(":");
    hour = timeArray[0];
    min = timeArray[1]
    sec = timeArray[2]
  }
  var d1= new Date(dateArray[0],dateArray[1]-1,dateArray[2],hour ,min ,sec);

  hour =0;
  min =0;
  sec =0;

  dateTimeArray = date_str2.split(" ");
  dateArray  = dateTimeArray[0].split(DATE_SEPARATOR);
  if(dateTimeArray.length>1){
    var timeArray = dateTimeArray[1].split(":");
    hour = timeArray[0];
    min = timeArray[1]
    sec = timeArray[2]
  }
  var d2= new Date(dateArray[0],dateArray[1]-1,dateArray[2],hour ,min ,sec);

  if (d1.getTime()==d2.getTime()) return 0;
  if(d1.getTime()>d2.getTime())return 1;
  else return -1;
}
/**
判断月份差,输入两个日期字符串，返回两个月份差
如果输入的是非法值，抛出异常
(year1-year2)*12+(month1-month2)
add by yangbb
*/
function g_MonthsBetween(date_str1 ,date_str2){
	if(date_str1 ==null){
		date_str1='';
	}	
    if(date_str2==null ){
    	date_str2='';
    }	

    if(date_str1 ==date_str2){
    	return 0;
	}
	
    if( !g_IsDateTime(date_str1) && !g_IsDate(date_str1)|| !g_IsDateTime(date_str2) && !g_IsDate(date_str2) ){
    	alert('无法比较日期值，请确认比较的两个值都为合法的时间类型！');
    	//抛出异常
    	throw new Error("输入的参数不是合法的时间类型");
  	}

	//解析时间字符串
	var year1 =0;
    var month1 =0;
    var day1 =0;
	var dateTimeArray = date_str1.split(" ");
  	var dateArray  = dateTimeArray[0].split(DATE_SEPARATOR);
  	year1=dateArray[0];
  	month1=dateArray[1];
  	day1=dateArray[2];
  	
  	var year2 =0;
    var month2 =0;
    var day2 =0;
  	dateTimeArray = date_str2.split(" ");
  	dateArray  = dateTimeArray[0].split(DATE_SEPARATOR);
  	year2=dateArray[0];
  	month2=dateArray[1];
  	day2=dateArray[2];
  	
	return (year1-year2)*12+(month1-month2);
}

//校验密码是否合法 ,8位非空字母 ，包含数字和字母
function checkPSWFormatValid(psw){
  if(psw==null || psw.length<8){
    alert('对不起，密码长度不能少于8位!');
    return false;
  }
  if(psw.indexOf(' ')>-1 || psw.indexOf('&')>-1){
    alert("对不起，密码中不能包含空格或者'&'符号!");
    return false;
  }

  var bNumber = false;//判断密码是否含有数字
  var bAlphe = false; //判断是否含有英文字母

  for (i = 0;  i < psw.length;  i++){
      //如果含有英文字母和数字，则返回true
      if(bNumber && bAlphe ){
        return true;
      }
      code = psw.charCodeAt(i);
      //判断是否包含数字
      if(!bNumber){
        if(code>=48 && code<=57){
           bNumber = true;
           continue;
        }
      }
      //判断是否包含英文字母
      if(!bAlphe){
        if(code>=65 && code<=90 || code>=97 && code<=122){
           bAlphe = true;
        }
      }
   }
   if(bNumber && bAlphe ){
        return true;
   }
   alert('对不起，密码必须同时包含数字和英文字母!');
   return false;
}


/*********************************************************************************
* FUNCTION: 格式化日期时间方法
* PARAMETER: aDate:js中的aDate对象,format-格式字符串.如:yyyy-MM-dd hh:mm:ss
* RETURNS: 格式后的日期时间字符串
* AUTHOR:ZLH
*********************************************************************************/
function g_FormatDate(aDate,format)
  {
    var o = {
    "M+" : aDate.getMonth()+1, //month
    "d+" : aDate.getDate(),    //day
    "h+" : aDate.getHours(),   //hour
    "m+" : aDate.getMinutes(), //minute
    "s+" : aDate.getSeconds(), //second
    "q+" : Math.floor((aDate.getMonth()+3)/3),  //quarter
    "S" : aDate.getMilliseconds() //millisecond
    }
    if(/(y+)/.test(format)) format=format.replace(RegExp.$1,
    (aDate.getFullYear()+"").substr(4 - RegExp.$1.length));
    for(var k in o)if(new RegExp("("+ k +")").test(format))
    format = format.replace(RegExp.$1,
    RegExp.$1.length==1 ? o[k] :
    ("00"+ o[k]).substr((""+ o[k]).length));
    return format;
  }

/*********************************************************************************
* FUNCTION: 粘贴时控制只能贴入数字和回车
* PARAMETER: null
* RETURNS: null
*********************************************************************************/
function g_BeforePasteNum(){
  var str = window.clipboardData.getData('text');
  if(str!=null){
    str = str.replace(/[^\d\n]/g,'');
    str = str.replace(/[\n]+/g,'\n');
    str = str.replace(/(^\s*)|(\s*$)/g, "");
    window.clipboardData.setData('Text',str);
  }
}

/*********************************************************************************
* FUNCTION: 粘贴时控制只能贴入数字和字母
* PARAMETER: null
* RETURNS: null
*********************************************************************************/
function g_BeforePasteEnglish(){
  var str = window.clipboardData.getData('text');
  if(str!=null){
    str = str.replace(/[\W]/g,'');
    window.clipboardData.setData('Text',str);
  }
}
