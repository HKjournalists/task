/**
功能：显示进度条,当运行的函数结束后自动关闭进度条.
调用方式：
	beginAIWaitBanner(funcObj,msg);
参数说明: 
	funcObj:一个function对象或者string字符串;
	msg:在进度条上显示的文字描述;
进度条风格:
	在jsv2/AppFrameCss.jsp中定义,名称为: AIAPPFRAME_WAIT_MAIN_CSS;

调用示例:
	1、传递string字符串,要求运行的函数不带参数，或者参数为常量或者全局变量：
		beginAIWaitBanner("run_process()","请等待....");  
		beginAIWaitBanner("run_process('常量1','常量2')" , "请等待....");
		beginAIWaitBanner("run_process(para1,para2)" , "请等待....");//要求para1和para2必须为全局变量
	
	2、运行的函数带参数，并且参数为局部变量，此时必须临时定义一个function，然后将这个
	临时function传递给进度条：
		
		加进度条前：function save(){
					var arr = new Array(); //局部变量,将做参数
					arr[0]='1';
					arr[1]='2';
					//.... 
					
					run_process(arr);	//准备加进度条的函数，带局部变量为参数。
					
					//下面这行代码将不会正常运行
					//beginAIWaitBanner("run_process(arr)","请等待....");  
				 }
				 
		加进度条后：function save(){
					 var arr = new Array(); //局部变量,将做参数
					 arr[0]='1';
					 arr[1]='2';
					 //....
					
					 //将准备加进度条的函数用一个function包装，然后传递给进度条
					 var f_fun = function(){	
					 	 run_process(arr);	
					 }
					
					 //下面代码能正常运行
					 beginAIWaitBanner("f_run","请等待...."); 
				  }
*/

var global_tmp_funtion =null;

function beginAIWaitBanner(funcObj,msg){
	//如果funObj为function对象,则直接赋值
	if(typeof(funcObj)=='function'){
		global_tmp_funtion = funcObj;
	}
	//如果funcObj为string对象,则构建一个function对象
	else if(typeof(funcObj)=='string'){
		global_tmp_funtion = function(){
			eval(funcObj);
		}
	}
	else{
		alert('参数错误！请传递一个Function对象或者一个字符串');
		return;
	}
	
	if(document.all.item("AIAPPFRAME_WAIT_DIV")==null){
		var divObj = document.createElement("div");
		document.body.appendChild(divObj);
		divObj.style.visibility = "visible";
		
		divObj.id = "AIAPPFRAME_WAIT_DIV";
		divObj.className = "AIAPPFRAME_WAIT_MAIN_CSS";
		divObj.innerHTML="<table width=\"100%\" height=\"100%\" border=0><tr><td align=\"center\" valign=\"middle\"><TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 class=\"AIAPPFRAME_WAIT_DIV_CSS\"><TR><td width=20></td><td width=60 height=80 align=center><span  class=\"AIAPPFRAME_WAIT_LOAD_CSS\"></span></td><td id=\"AIAPPFRAME_WAIT_DIV_CONTENT\">正在加载中,请稍后...</td></tr></table></td></tr></table>";
	}
	else{
		document.all.item("AIAPPFRAME_WAIT_DIV").style.visibility = "visible";
	}
	
	if(msg!=null && msg!=""){
		document.all.item("AIAPPFRAME_WAIT_DIV_CONTENT").innerText = msg;
	}
	
	window.setTimeout("global_tmp_funtion();endAIWaitBanner();",10);
}

function endAIWaitBanner(){
	if(document.all.item("AIAPPFRAME_WAIT_DIV")!=null){
		document.all.item("AIAPPFRAME_WAIT_DIV").style.visibility  = "hidden";
	}
}
