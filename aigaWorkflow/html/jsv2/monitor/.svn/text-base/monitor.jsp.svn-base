<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.ai.appframe2.monitor.URLFilter" %>

var ip ='<%= URLFilter.getIpAddr(request) %>'; 
//调用序列
var seq = 0;
//服务器与客户端时间偏移量
var tmcookiename = "_appmonitortimelag";
var tm;
var tmcookie = document.cookie.match(new RegExp("(^| )"+tmcookiename+"=([^;]*)(;|$)"));
if (tmcookie != null){
	tm = parseInt(tmcookie[2]);
}else{
	tm = getServerTime()-(new Date()).getTime();
	document.cookie = tmcookiename+"="+tm;
}
//表示是否监控
var monitor_flag = true; 

//保存页面执行时间的地址
var recordJSExecTimeServlet ='/WebJSServlet';

//LOG记录编号
var ai_log_pk = -1;

//一个方法中,action第几次被调用
var exec_order = 0;

//当前方法执行过程中的日志信息
var array_loginfo = new Array();

//所有日志信息
var all_logs_info = new Array();

//获取唯一LogPK
function  AI_getLogPK(){
  if(ai_log_pk ==-1){
    var current = new Date();
    ai_log_pk = ip + "_" + (current.getTime()+tm+(seq++)) ;
    array_loginfo = new Array();
    all_logs_info[all_logs_info.length] = array_loginfo;
  }
  
  AI_IncreseExecOrder();
  return ai_log_pk ;
}
//获取当前的执行顺序
function AI_getExecOrder(){
	return exec_order;
}

//将当前执行的顺序加1
function AI_IncreseExecOrder(){
	exec_order++;
}

//在调用callHttp时,同时发送当前的LOGPK 和执行顺序号到后台
function getLogString(){
  var pageURL = window.location.href;
  var index = window.location.href.indexOf(_gModuleName);
  if(index>-1){
    pageURL = window.location.href.substr(index);
  }
  
  
  var str = "&AILOGSTRING=" +  AI_getLogPK() + "@"+ AI_getExecOrder() +"@" + getUIID(pageURL);
  return str;
}

function getUIID(pageURL){
  index = pageURL.indexOf("?");
  if(index>-1){
    pageURL = pageURL.substring(0,index);
  }
  
  //获取当前事件响应的element src 
  if(event == null || event.srcElement == null){
    return pageURL + "|onload";
  }
  
  var obj = event.srcElement;
  var str = "";
  
  if(obj.id != null && obj.id !=''){
    str = "|ctrl_id=" + obj.id;
  }else if(obj.name != null && obj.name !=''){
    str = "|ctrl_name=" + obj.name;
  }else if(typeof(obj.value)!='undefined' && obj.value != null && obj.value !=''){
    tmp = "" + obj.value;
    if(tmp.length>10){
      tmp = tmp.substring(0,6) + "...";
    }
    str = "|ctrl_value=" + tmp;
  }else{
    tmp = obj.innerText;
    if(tmp.length>10){
      tmp = tmp.substring(0,6) + "...";
    }
    str = "|ctrl_text=" + tmp;
  }
  
  str = str + "|ctrl_tag=" + obj.tagName;
  str = str + "|eventType=" + event.type;
  
  return pageURL + str;
}

//方法执行的时候记录其LOGPK、顺序号、响应地址等信息
function recordExecStartTime(){
  if(AI_getExecOrder() ==1){
    array_loginfo["log_pk"] = ai_log_pk;
    array_loginfo["control_address"] = getCurrentAddress();
    array_loginfo["start_time"] = ((new Date()).getTime()+tm);
  }
}

//记录完毕的时间
function recordExecEndTime(){
  array_loginfo["end_time"] = ((new Date()).getTime()+tm);
}

//获取当前响应控件的地址
function getCurrentAddress(){
  var pageURL = window.location.href;
  var index = window.location.href.indexOf(_gModuleName);
  if(index>-1){
    pageURL = window.location.href.substr(index);
  }

  //获取当前事件响应的element src 
  if(event == null || event.srcElement == null){
    return pageURL + "|onload";
  }
  
  var obj = event.srcElement;
  var str = "";
  
  if(obj.id != null && obj.id !=''){
    str = "|ctrl_id=" + obj.id;
  }else if(obj.name != null && obj.name !=''){
    str = "|ctrl_name=" + obj.name;
  }else if(typeof(obj.value)!='undefined' && obj.value != null && obj.value !=''){
    tmp = "" + obj.value;
    if(tmp.length>10){
      tmp = tmp.substring(0,10) + "...";
    }
    str = "|ctrl_value=" + tmp;
  }else{
    tmp = obj.innerText;
    if(tmp.length>10){
      tmp = tmp.substring(0,10) + "...";
    }
    str = "|ctrl_text=" + tmp;
  }
  
  str = str + "|ctrl_tag=" + obj.tagName;
  str = str + "|eventType=" + event.type;
  
  return pageURL + str;
}

//将当前所有的日志信息转换成字符串
function translateLogToString(){
  var str = '';
  
  for(i=0; i < all_logs_info.length ; i++){
     var tmp = '';
     var arr = all_logs_info[i];
     for(prop in arr){
        tmp = tmp + "#" + prop + "=" + arr[prop];
     }
    str = str + "@@" + tmp;
  }
  
  all_logs_info.length = 0;
  return str;
}


//重置记录ID
function reset_logPK(){
  ai_log_pk = -1;
  exec_order=0;
}

//异步发送信息到后台WEB服务器
function sendWebLogInfo(){
  if(all_logs_info.length==0) return;
  
  var str = translateLogToString();
  
  var Sender = g_GetXMLHTTPRequest();
  Sender.Open("POST",_gModuleName + recordJSExecTimeServlet,true);
  Sender.send(str);
}

//将当前页面的日志信息交给父亲页面处理
function addLogInfoToParent(arr){
  if(arr==null || arr.length==0)return;
  all_logs_info = all_logs_info.concat(arr);
}

//重新设置记录监控函数，如果父页面存在监控函数，则用父页面的（定时将监控数据到父页面），否则用自己的（定时发送数据到后台）
function resetExecFunction(){
  try{
    if(window.parent !=null && window.parent.location != window.location 
       && window.parent.addLogInfoToParent !=null){
        this.addLogInfoToParent = window.parent.addLogInfoToParent;      
        window.setInterval("this.addLogInfoToParent(all_logs_info);all_logs_info.length=0",3000);
        
        this.AI_getLogPK = window.parent.AI_getLogPK;
        this.AI_getExecOrder = window.parent.AI_getExecOrder;
        this.AI_IncreseExecOrder = window.parent.AI_IncreseExecOrder;
        return;
    }
    else{
    	
    }
  }catch(e){
  }
  
  window.setInterval("sendWebLogInfo()",5000);
    
  
}

//初始化监控相关内容
function monitor_init(){
  if(window.document.body !=null){
    window.document.body.attachEvent('onmousemove', reset_logPK);
    window.document.body.attachEvent('onkeyup', reset_logPK);
  }
  
  //增强页面onunload 方法，在关闭的时候发送监控数据
  window.attachEvent('onunload', sendWebLogInfo);
  resetExecFunction();
}

window.attachEvent('onload', monitor_init);

function getServerTime(){
  var Sender = g_GetXMLHTTPRequest();
  Sender.Open("POST",_gModuleName + "/business/com.ai.appframe2.web.DefaultAction?action=getSysTimeMillis",false);
  Sender.send("");
  return Sender.responseText;
}
