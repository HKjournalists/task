<!DOCTYPE HTML>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
  <head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style type="text/css">
	.content_title_text{
		height:22px;
		color:#204D84;
		align:left;
		font-weight:bold;
		text-indent:6px;
		font-size:12px;
	}
	.content_title{
		color: #4682B4;
		margin: 0px;
		background-image: url(<%=request.getContextPath()%>/aiga/images/contractframe/contractframe_head_new.gif);
		background-repeat: repeat-x;
		height:26px;
		width:100%;
		font-weight:bold
		margin: 0 0 0 0 ;
		padding:0 0 0 0 ;
		border-bottom:1px #bdd3e6 solid;
	}
	.aiEdit_4col{
		height:30;
		border-bottom: 1;
		border-top: 0;
		border-left: 0;
		border-right: 0;
		border-color: #E5EFF5;
		border-style: solid;
		text-align:	  left;
		padding: 0 0 0 2px;
		font-size: 12px;
	}
	.div_title{
		width: 100%;
		cellpadding:0;
		cellspacing:0;
		border:1px solid #dae4ee;
		margin: 1px 0 0 0;
	}
	.table_context{
		background:  #FFFFFF;
		padding: 0 0 0 0;
	}
	.table_context > img{
		margin: 6px 0 0 0;
	}
	.title_e{
		height:25;
		font-size:12px;
		width:100px;
		border-bottom: 0;
		border-top: 0;
		border-left: 0;
		border-right: 0;
		border-color: #DEE7F0;
		border-style: solid;
		text-align:	  right;
		color:#666;
		background-color:rgba(234, 241, 247, 1);
	}
	.x-ie8 .x-tab BUTTON .x-tab-inner{
	text-overflow: clip;
	}
	
	.btn-2word {height:20px; width:80px; font-size:12px; color:#405A91; background:url(<%=request.getContextPath()%>/css/images/4wordbtn_new.gif);}
	input[type="text"][readonly="readonly"],.numberFieldGray td input,.textFieldGray td input,.textFieldGray td textarea{background:#E6E6E6; color:#0B66B0;}
	table.textFieldGray + div.x-btn{background:#E6E6E6; color:#0B66B0;}
	</style>
	<%@ include file="/aiga/common/include.jsp" %>
	<script type="text/javascript">
	/**
	*author:wenghy
	*去除多按[backspace]后退到登录页的bug
	**/
	if(document.addEventListener){  
	    document.addEventListener("keydown",maskBackspace, true);  
	}else{  
	    document.attachEvent("onkeydown",maskBackspace);  
	}  
	  
	function maskBackspace(event){  
	    var event = event || window.event; //标准化事件对象  
	    var obj = event.target || event.srcElement;  
	    var keyCode = event.keyCode ? event.keyCode : event.which ?  
	            event.which : event.charCode;  
	    if(keyCode == 8){  
	        if(obj!=null && obj.tagName!=null && (obj.tagName.toLowerCase() == "input"   
	               || obj.tagName.toLowerCase() == "textarea")){  
	            event.returnValue = true ;  
	            if(Ext.getCmp(obj.id)){  
	                if(Ext.getCmp(obj.id).readOnly) {  
	                    if(window.event)  
	                        event.returnValue = false ; //or event.keyCode=0  
	                    else  
	                        event.preventDefault();   //for ff[/b]  
	                }  
	            }  
	        }else{  
	            if(window.event)  
	                event.returnValue = false ;   // or event.keyCode=0  
	            else  
	                event.preventDefault();   
	        }  
	    }  
	}
	/**
	*author:wenghy
	*获得浏览器IE版本号
	**/
    function getBrowserVersion(){
 	    var browserVersion="";
    	try{
	    	var browser=navigator.appName ;
	 	    var b_version=navigator.appVersion;
	 	    var version=b_version.split(";");  
	 	    var trim_Version=version[1].replace(/[ ]/g,"");
	 	    if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE6.0")  {
	 			browserVersion="IE6.0";
	 	    }  
	 	    else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE7.0")  { 
	 	    	browserVersion="IE7.0";
	 	 	}  
	 	    else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE8.0")  {  
	 			browserVersion="IE8.0"; 
	 	    }  
	 	    else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE9.0")  {  
	 			browserVersion="IE8.0";
	 	    }
    	}catch(e){}
 	    return browserVersion;
    }
	    
	var loadMask;
		Ext.onReady(function(){
		    Ext.define('EmptyVal', {
				extend: 'Ext.data.Model',
				fields:[
					{name:'value', type:'int',defaultValue:''},
					{name:'show', type:'string', defaultValue: '-未选择-'}
				]
			});
			Ext.define('EmptyStaff', {
				extend: 'Ext.data.Model',
				fields:[
					{name:'staffId', type:'int', convert: null,defaultValue:null},
					{name:'staffName', type:'string', defaultValue: '-全部-'},
					{name:'displayName', type:'string', defaultValue: '-全部-'}
				]
			});
			loadMask = new Ext.LoadMask(top.window.document.body, {
				msg : '数据处理中!',
				disabled : false
			});
		});
		
		function MaskLoading(){
			loadMask.show();
		}
		function MaskOver(){
			loadMask.hide();
		}
	</script>
  </head>
  
  <body>
  </body>
</html>
