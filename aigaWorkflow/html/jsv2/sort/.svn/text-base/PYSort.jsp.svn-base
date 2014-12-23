<%@ page contentType="text/html; charset=GBK"%>
//该文件提供拼音排序法


//根据GB2312汉字拼音排序，优点：不依赖于JAVA后台，速度快
//缺点：不能对不在GB2312中的汉字进行排序
function sortByGB2312(a, b){
    for ( var i = 0; i < a.length; i++ ){
      var codeA = private_getGB2312AscCode(a.charAt(i))
      var codeB = private_getGB2312AscCode(b.charAt(i))

      if(codeA > codeB) return 1;
      else if(codeA < codeB) return -1;
    }
    return 0
}

//根据GBK全字符集进行排序，优点：能对所有的汉按拼音进行排序
//缺点：对不在GB2312 范围内的汉字需要调用JAVA后台，速度稍微慢点
function sortByGBK(a,b){
      for (var i=0; i < a.length; i++){
      var codeA = private_getAllHzAscCode(a.charAt(i))
      var codeB = private_getAllHzAscCode(b.charAt(i))
      
      if(codeA > codeB) return 1;
      else if(codeA < codeB) return -1;
    }
    return 0
}

//获取所有汉字的拼音在GB2312 中的位置
function private_getAllHzAscCode(char){
   if (char.charCodeAt(0) == null || char=='') return ""
    var code = char.charCodeAt(0);
    if(code < 1328 ) return code;
    
    try{
	    //调用vbscript获取ascii码
	    var ascCode = vbasc(char)
	    ascCode = eval("0x"+ascCode)
	  }catch(e){
	  	return char;
	  }
    
    try{
	    if(ascCode <55292){
	    	return ascCode;
	    } else {
	    	ascCode = private_getGBKCode(char);
	    }
	  }catch(e){
	  	return ascCode;
	  }
    
    return ascCode;
}

//获取一个汉字的编码，如果该汉字在GB2312范围内，则直接返回该编码，
//如果该汉字不在GB2312范围内，则先获取该汉字的拼音，然后根据拼音
//获取该拼音在GB2312 编码中的位置
var GBKArray = new Array();
function private_getGBKCode(char){
	//从缓存数组中寻找
    var tmp = GBKArray[char];
    if(tmp != null ) return tmp;
    //调用后台获取该汉字的编码
    var path = "<%=request.getContextPath()%>";
    path = path + "/business/com.ai.appframe2.util.GetGBKCodeAction?action=getGBKCodeInGB2312&url_source=XMLHTTP&hz=" + char;
    
    var XMLSender=null;
		if (typeof ActiveXObject != "undefined"){   
			XMLSender=new ActiveXObject("Microsoft.XMLHTTP");   
		}
		else if (window.XMLHttpRequest) {                        
			XMLSender=new XMLHttpRequest();
		} 
    XMLSender.Open("POST",path,false);

    XMLSender.setRequestHeader("Content-Type","multipart/form-data");

    XMLSender.send('');
    var result =  XMLSender.responseText;

    
    //如果没有查到数据则用它自身的ascii code 代替
    if(result ==''){
      result = ascCode;
    }
    //将后台查询结果放到JS缓存
    GBKArray[char] = result;
    return result;  
}

//获取一个汉字的纯ASC码
function private_getGB2312AscCode(char){
    if (char.charCodeAt(0) == null || char=='') return ""
    var code = char.charCodeAt(0);
    if(code < 1328 ) return code;
    
    //调用vbscript获取ascii码
    try{
    	var ascCode = vbasc(char)
    	ascCode = eval("0x"+ascCode)
    	return ascCode;
    }catch(e){
    	return char;
    }
  }
  
  

//调整lv和nv 的位置，不过个人感觉意义不大，所以就不做调整了
function private_adjustCode(code){
	if(code == null || code =="") return code;
	
	if(code==50606) code=50613;
	else if(code>=50607 && code<50610) code = code -1;
	else if(code>=49855 && code<49869 )code = 49896 -(49869-code);
	else if(code>=49869 && code<49896)code = code -(49869-49855);
	
	return code;
}
  