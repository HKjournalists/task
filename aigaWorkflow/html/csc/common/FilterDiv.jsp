<!-- 透明滤镜开始 -->
<div id="loading" style="position:absolute; top:0; left:0; height:100%; width:100%; background:#ffffff; filter:alpha(opacity=0);"></div>
<!-- 透明滤镜结束 -->
		
<script type="text/javascript">
//判断页面是否加载完毕，如果加载完毕，就删除加载信息的DIV
function document.onreadystatechange(){
	try{
		if (document.readyState == "complete") {
	     	delNode("loading");
	    }
    }catch(e){
    	alert("页面加载失败");
    }
}

//删除指定的DIV
function  delNode(nodeId){   
  	try{   
	  	var div =document.getElementById(nodeId);  
	  	if(div !==null){
		  	div.parentNode.removeChild(div);   
		  	div=null;    
		  	CollectGarbage(); 
	  	}  
  	}catch(e){   
  	   alert("删除ID为"+nodeId+"的节点出现异常");
  	}   
}
</script>