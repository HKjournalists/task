function init(frameId,dH,ishow){
  var open = 0;
  
	if(dH==null||dH==""){
	  var dH = (document.documentElement.clientHeight>0)?document.documentElement.clientHeight:document.body.clientHeight;
	}
	var Ds = getChildrenByTag(frameId,"ul");
	var Ts = getChildrenByTag(frameId,"div");
	if(Ds.length != Ts.length){
	 alert(frameId+"±Í«©”–ŒÛ");
	 return;
	}
	dH -= Ts.length * Ts[0].clientHeight;
	for(var i = 0 ; i < Ds.length ; i++){
	  if(ishow == false){
	    Ds[i].style.height = "0px";
	  }
	  else{
		  if(i==open){
		    Ds[i].style.height = dH+"px";
		    Ds[i].style.display = "block";
		  }
		  else{
		    Ds[i].style.height = "0px";
		  }
	  }
	  Ts[i].value = i;
	  Ts[i].onclick = function(){
	    if(open == this.value && ishow != false){
	      return false;
	    }
	    closeMe(frameId,dH,Ds[open],Ds[this.value]);
	    open = this.value;
	  }
	}
}

function getOutLookDiv(id){
  if(document.getElementById(id)){
    return document.getElementById(id);
  }
 }
 
function getChildrenByTag(id,tagName){
  return getOutLookDiv(id).getElementsByTagName(tagName);
}
 
function closeMe(frameId,dH,curDiv,newDiv){
  var h = parseInt(curDiv.style.height);

  if(h > 0){    
    curDiv.style.height = 0+"px";
    curDiv.style.display="none";
  }
  openMe(frameId,dH,newDiv);
}
 
function openMe(frameId,dH,newDiv){
  var h = parseInt(newDiv.style.height);  
  if(h < dH){       
    newDiv.style.height = dH+"px";
    newDiv.style.display="";
  }
}