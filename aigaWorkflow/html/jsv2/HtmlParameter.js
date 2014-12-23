function HtmlParameter(){
    this.List = new Array();  
    this.getParameter = function(name){
        return this.List[name];
    }
    this.setParameter = function(name,value){
        this.List[name] = value;
    }
}

function parseHtmlParameter(location){
   var docLoc=document.location.toString();
   var t1="";
   var result = new HtmlParameter();
   var pos = docLoc.indexOf("?");
   if( pos != -1){
      var paramString=docLoc.substr(pos + 1,docLoc.length);
      var params = paramString.split("&")
      for(var i=0;i<params.length;i++){
      	 var tmpArray = params[i].split("=");
      	 if (tmpArray.length == 2){
            var name  = tmpArray[0];
            var value = tmpArray[1];
            result.setParameter(name,value);
            //alert(name + ":" + value);
      	 }else
      	   alert("分解参数错误 ：" + paramString);
      }
    }
    return result;
}

var gHtmlParameter = parseHtmlParameter(document.location.toString());

