
/*
	[Aiainfo] (C)2010 LiZhongDe.
	$file: reqUtils.js $
	$Date: 2010/01/30 $
*/
String.prototype.trim = function(){
    var result = this.replace(/(^\s*)|(\s*$)/g, "");
    return result;
}
/**
* add by lizhongde
*js date add toCommonCase method 
*/
Date.prototype.toCommonCase=function(){
    var xYear=this.getYear();
    var xMonth=this.getMonth()+1;
    if(xMonth<10){ xMonth="0"+xMonth;}
    var xDay=this.getDate();
    if(xDay<10){ xDay="0"+xDay;}
    var xHours=this.getHours();
    if(xHours<10){xHours="0"+xHours;}
    var xMinutes=this.getMinutes();
    if(xMinutes<10){xMinutes="0"+xMinutes;}
    var xSeconds=this.getSeconds();
    if(xSeconds<10){xSeconds="0"+xSeconds;}
    return xYear+"-"+xMonth+"-"+xDay+" "+xHours+":"+xMinutes+":"+xSeconds;
}

Date.prototype.toArray = function()   
{    
    var myDate = this;   
    var myArray = Array();   
    myArray[0] = myDate.getFullYear();   
    myArray[1] = myDate.getMonth();   
    myArray[2] = myDate.getDate();   
    myArray[3] = myDate.getHours();   
    myArray[4] = myDate.getMinutes();   
    myArray[5] = myDate.getSeconds();   
    return myArray;   
}      

function isBlank(value){return (value==undefined||value==null||value ==""||value.length==0);}
function buttonEnable(buttonId,enable){
  var button = document.getElementById(buttonId);
  if(enable){button.disabled=false;}else{button.disabled=true;} 
}
function radioEnable(radioId,enable){
  var radio = document.getElementById(radioId);
  if(enable){radio.disabled=false;}else{radio.disabled=true;} 
}
function groupRadioEnable(groupRadioName,enable){
  var arr = document.getElementsByName(groupRadioName);
  for(i=0;i<arr.length;i++){arr[i].disabled=(enable==true?false:true);}
}

/**
* dataformat:yyyy-MM-dd
* startTime="2010-01-22";
* endTime="2010-11-24";
*/
function compareToDate(startTime, endTime){
   var sTimes = startTime.split('-');
   var eTimes = endTime.split('-');
   var sDate = new Date(sTimes[0],sTimes[1]-1,sTimes[2]);
   var eDate = new Date(eTimes[0], eTimes[1]-1, eTimes[2]);
   if (sDate.getTime()==eDate.getTime()) {return 0;
   }else if(sDate.getTime()>eDate.getTime()){return 1;
   } else{ return -1;
   }
}

 function addDate(date,year,month,week,day,otherDay){
   date.setFullYear(date.getFullYear() + year);
   date.setMonth(date.getMonth() + month);
   date.setDate(date.getDate()+ week*7);
   date.setDate(date.getDate() + day);
   return date;
 }
/**
* dataformat:yyyy-MM-dd hh:mm:ss
* startTime="2010-01-22 22:20:20";
* endTime="2010-11-24 22:20:20";
* return false
*/
function compareDateTime(date1, date2){
var year1 = date1.substring(0,date1.indexOf("-"));
var year2 = date2.substring(0,date2.indexOf("-"));
var month1 = date1.substring(date1.indexOf("-")+1,date1.lastIndexOf("-"));
var month2 = date2.substring(date2.indexOf("-")+1,date2.lastIndexOf("-"));
var day1 = date1.substring(date1.lastIndexOf("-")+1,date1.indexOf(" "));
var day2 = date2.substring(date2.lastIndexOf("-")+1,date2.indexOf(" "));

if( parseInt(year1) > parseInt(year2) ){
return true;
}else if( parseInt(year1) < parseInt(year2) ){
return false;
}else if( parseInt(month1) > parseInt(month2) ){
return true;
}else if( parseInt(month1) < parseInt(month2) ){
return false;
}else if( parseInt(day1) > parseInt(day2) ){
return true;
}
return false;
}

/**
* dataformat:yyyy-MM-dd
* startTime="2010-01-22";
* endTime="2010-11-24";
* return betweenDays
*/
function getBetweenDays(startTime, endTime){
   var sDate = new Date(Date.parse(startTime.replace(/\-/g, "/")));
   var eDate = new Date(Date.parse(endTime.replace(/\-/g, "/")));
   return ((eDate-sDate)/(1000*24*3600));
}

function getBetweenDateTime(beginTime,endTime){
var beginTimes=beginTime.substring(0,10).split('-');   
var endTimes=endTime.substring(0,10).split('-');   
beginTime=beginTimes[1]+'-'+beginTimes[2]+'-'+beginTimes[0]+' '+beginTime.substring(10,19);   
endTime=endTimes[1]+'-'+endTimes[2]+'-'+endTimes[0]+' '+endTime.substring(10,19);
var a =(Date.parse(endTime)-Date.parse(beginTime))/3600/1000;
alert(a);
}

/**
* dataformat:yyyy-MM-dd
* startTime="2010-01-22";
* endTime="2010-11-24";
*/
function getDate(DateStr){
 DateStr = DateStr.substring(0,10);
 var times = DateStr.split('-');
 return new Date(times[0], times[1]-1, times[2]);
}

function stringToDate(DateStr){
   DateStr = DateStr.substring(0,10);
   var times = DateStr.split('-');
   return new Date(times[0], times[1]-1, times[2]);
}

/**
* dataformat:yyyy-MM-dd hh:mm:ss
*/
function stringToDateTime(DateStr){
   var dateTimeArray = DateStr.split(" ");
   if(dateTimeArray==null || dateTimeArray.length!=2) {
     return null;
   }
   var dateArray  = dateTimeArray[0].split("-");
   var timeArray = dateTimeArray[1].split(":");
   return new Date(dateArray[0],dateArray[1]-1,dateArray[2],timeArray[0],timeArray[1],timeArray[2]);
}

/**
* return  format : 2012-12-23
*/
function dateToString(date){
 return (date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate());
}

/*********************************************************************
                            AppFrame
*********************************************************************/

// used in valition
function showMessage(form,fieldName,message){
  if(isBlank(form.getValue(fieldName))){
     //aialmPrompt(message);
     $.messager.alert('操作提示',message,'error');
     form.setFocus(fieldName);
     return true;
  }
}

function u_validtor_message(message){
  alert(message);
}

function u_message(message){
  //aialmPrompt(message);
  alert(message);
}

// cacheItems level is two
//set cacheItems to form
function setCacheItems(fromId,sysParmId,subParamId,sysParamFieldName,subParamFileldName){
  var form = g_FormRowSetManager.get(fromId);
  var SYS_TAG = document.getElementById(sysParmId).value;
  var SUBSYS_TAG = document.getElementById(subParamId).value;
  form.setValue(sysParamFieldName,'');
  form.setValue(subParamFileldName,'');
  if(""!=SYS_TAG){
      form.setValue(sysParamFieldName,SYS_TAG);
  }
  if(""!=SUBSYS_TAG){
    form.setValue(subParamFileldName,SUBSYS_TAG);
 }
}

//set cacheItems to ai:list from form
function setCacheItemsToList(fromId,sysParmId,subParamId,sysParamFieldName,subParamFileldName,subParamFreshConName){
  var from = g_FormRowSetManager.get(fromId);
  var sysList = g_getListBox(sysParmId);
  var subList = g_getListBox(subParamId);
  sysList.setValue(from.getValue(sysParamFieldName));
  subList.refresh(subParamFreshConName+"="+from.getValue(sysParamFieldName));
  subList.setValue(from.getValue(subParamFileldName));
}
function getFinishDate(createDate,suggestAddDate){
	var finishDate;
	if(suggestAddDate=='30'){
	 finishDate = addDate(createDate,0,1,0,0,0);
	}else if(suggestAddDate=='14'){
	 finishDate = addDate(createDate,0,0,2,0,0);
	}else if(suggestAddDate=='7'){
	 finishDate = addDate(createDate,0,0,1,0,0);
	}
	return finishDate;
}
function verifyReqForm(){
  var flag = false;
  var reqForm =  g_FormRowSetManager.get('reqForm');
  //if(showMessage(reqForm,'REQ_TYPE','需求类型不能为空')){   return flag; }
  if(showMessage(reqForm,'REQ_NAME','名称不能为空')){   return flag;  }
  if(showMessage(reqForm,'APPLY_STAFF_NAME','联系人不能为空')){   return flag;  }
  if(showMessage(reqForm,'LINKMAN_PHONE','联系电话不能为空')){    return flag;  }
  if(showMessage(reqForm,'REQ_TYPE','业务类别不能为空')){ return flag;}
  //if(showMessage(reqForm,'URGENT_LEVEL','紧急程度不能为空')){ return flag;}
  if(showMessage(reqForm,'PLAN_TIME','期望完成时间不能为空')){ return flag; }
  if(showMessage(reqForm,'ACCEPT_CHANNEL','受理渠道不能为空')){ return flag;}
  //if(showMessage(reqForm,'REQ_ABSTRACT','需求背景不能为空')){  return flag;  }
  //if(showMessage(reqForm,'COMPLEX_LEVEL','难易程度不能为空')){    return flag;  }
  //if(showMessage(reqForm,'REQ_DESC','需求描述不能为空')){  return flag;  }
  //var dateResult = getBetweenDays('2010-08-26',dateToString(new Date()));
  //if(dateResult>0&&reqForm.getValue('REQ_NAME').length>128){
  //	 alert('需求描述超过1000个字符,不能保存');
  //	 return flag;
 // }
  return true;
}

function alertVerifyReqForm(){
  var flag = false;
  var reqForm =  g_FormRowSetManager.get('reqForm');
  //if(showMessage(reqForm,'REQ_TYPE','需求类型不能为空')){   return flag; }
  if(showMessage(reqForm,'REQ_NAME','名称不能为空')){   return flag;  }
  if(showMessage(reqForm,'APPLY_STAFF_NAME','联系人不能为空')){   return flag;  }
  if(showMessage(reqForm,'LINKMAN_PHONE','联系电话不能为空')){    return flag;  }
  if(showMessage(reqForm,'REQ_TYPE','业务类别不能为空')){ return flag;}
  //if(showMessage(reqForm,'URGENT_LEVEL','紧急程度不能为空')){ return flag;}
  if(showMessage(reqForm,'PLAN_TIME','期望完成时间不能为空')){ return flag; }
  //if(showMessage(reqForm,'ACCEPT_CHANNEL','受理渠道不能为空')){ return flag;}
  //if(showMessage(reqForm,'REQ_ABSTRACT','需求背景不能为空')){  return flag;  }
  //if(showMessage(reqForm,'COMPLEX_LEVEL','难易程度不能为空')){    return flag;  }
  //if(showMessage(reqForm,'REQ_DESC','需求描述不能为空')){  return flag;  }
  //var dateResult = getBetweenDays('2010-08-26',dateToString(new Date()));
  //if(dateResult>0&&reqForm.getValue('REQ_NAME').length>128){
  //	 alert('需求描述超过1000个字符,不能保存');
  //	 return flag;
 // }
  return true;
}

function setGroupTextValue(groupTextName,textValue){
  var names = document.getElementsByName(groupTextName);
  var length = names.length;
  for(var i=0; i<length; i++) {   
     names[i].value=textValue;
  }
}
/**
*js hashMap
**/
function   HashMap(){  
   this.length   =   0;  
   this.prefix   =   "hashmap_prefix_007_";  
}
/**  
 *add elemnt to hashMap 
**/  
  HashMap.prototype.put   =   function   (key,   value)  {  
          this[this.prefix   +   key]   =   value;  
          this.length   ++;  
  }  
/****
 *getValue
 **/
 HashMap.prototype.get   =   function(key) {  
     return   typeof   this[this.prefix+ key] == "undefined" ?null:this[this.prefix+key];  
  }   