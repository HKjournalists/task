String.prototype.startWith=function(str){     
  var reg=new RegExp("^"+str);     
  return reg.test(this);        
}  
String.prototype.trim=function(){
    return this.replace(/(^\s*)|(\s*$)/g, "");
 }
 String.prototype.ltrim=function(){
    return this.replace(/(^\s*)/g,"");
 }
 String.prototype.rtrim=function(){
    return this.replace(/(\s*$)/g,"");
 }
String.prototype.endWith=function(str){     
  var reg=new RegExp(str+"$");     
  return reg.test(this);        
}
function formatParams(source,params){  
	    $.each(params, function(i, n) {  
	        source = source.replace(new RegExp("\\{" + i + "\\}", "g"), n);  
	    });  
	    return source;  
	}
	// 瀵笵ate鐨勬墿灞曪紝灏�Date 杞寲涓烘寚瀹氭牸寮忕殑String 
	// 鏈�M)銆佹棩(d)銆佸皬鏃�h)銆佸垎(m)銆佺(s)銆佸搴�q) 鍙互鐢�1-2 涓崰浣嶇锛�
	// 骞�y)鍙互鐢�1-4 涓崰浣嶇锛屾绉�S)鍙兘鐢�1 涓崰浣嶇(鏄�1-3 浣嶇殑鏁板瓧) 
	// 渚嬪瓙锛�
	// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
	// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
	Date.prototype.Format = function(fmt) 
	{ //author: meizz 
	  var o = { 
	    "M+" : this.getMonth()+1,                 //鏈堜唤 
	    "d+" : this.getDate(),                    //鏃�
	    "h+" : this.getHours(),                   //灏忔椂 
	    "m+" : this.getMinutes(),                 //鍒�
	    "s+" : this.getSeconds(),                 //绉�
	    "q+" : Math.floor((this.getMonth()+3)/3), //瀛ｅ害 
	    "S"  : this.getMilliseconds()             //姣 
	  }; 
	  if(/(y+)/.test(fmt)) 
	    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
	  for(var k in o) 
	    if(new RegExp("("+ k +")").test(fmt)) 
	  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length))); 
	  return fmt; 
	}
/* 
*  方法:Array.remove(dx) 通过遍历,重构数组 
*  功能:删除数组元素. 
*  参数:dx删除元素的下标. 
*/ 
Array.prototype.remove=function(dx) 
{
    if(isNaN(dx)||dx>this.length){return false;} 
    for(var i=0,n=0;i<this.length;i++) 
    { 
        if(this[i]!=this[dx]) 
        { 
            this[n++]=this[i] 
        } 
    } 
    this.length-=1 
} 