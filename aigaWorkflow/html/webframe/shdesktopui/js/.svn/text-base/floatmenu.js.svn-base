//window.onload=regenerate2

if (document.all){

	themenu=document.all.slidemenubar2.style;
	
	rightboundary=document.body.clientHeight-500;//top
	leftboundary=document.body.clientHeight;//bottom
}

function pull(){
	if (window.drawit)
	    clearInterval(drawit);
	pullit=setInterval("pullengine()",30);

}

function draw(){
	clearInterval(pullit);
	drawit=setInterval("drawengine()",30);

}
//function refresh_menuMask(menuObjStyle)
//{
//  var maskObj = document.all.item("menu_mask");
  //alert("h="+maskObj+",pixelleft="+maskObj.style.pixelLeft);

//  if(maskObj)
//  {
    //alert("width="+maskObj.style.pixelLeft);
//    maskObj.style.pixelTop = menuObjStyle.pixelTop;
//  }

//}
function pullengine(){

	if (document.all&&themenu.pixelTop>rightboundary)
	    themenu.pixelTop-=60;
	else if(document.layers&&themenu.top>rightboundary)
	    themenu.top-=60;
	else if (window.pullit){
	    clearInterval(pullit);
	    
	}
        refresh_menuMask(themenu);

}

function drawengine(){
    
	if (document.all&&themenu.pixelTop<leftboundary)
	   {
	    themenu.pixelTop+=60;
	    refresh_menuMask(themenu);
	    }
	else if(document.layers&&themenu.top<leftboundary){
	    themenu.top+=60;
	    refresh_menuMask(themenu);
	    }
	else if (window.drawit){
	    clearInterval(drawit);
	   
	   
	    document.all.slidemenubar2.style.height = "0";
	    //document.all.menu_mask.style.height="0";
	   //document.all.slidemenubar2.style.display="none";
	    //document.all.menu_mask.style.display="none";
	    
	}
        
}

function openMenu()
{
  if(document.all.slidemenubar2.openState==null || document.all.slidemenubar2.openState=="0")
  {
    
     pull();
     document.all.slidemenubar2.openState="1";
  }
}

function closeMenu()
{
  if(document.all.slidemenubar2.openState=="1")
  {
     draw();
     document.all.slidemenubar2.openState="0";
  }
}

function openCloseMenu(){
   
	if(document.all.slidemenubar2.openState==null || document.all.slidemenubar2.openState=="0"){
		if(document.all.slidemenubar2.style.display=="none"){
		   document.all.slidemenubar2.style.height = "450px";
	       //document.all.menu_mask.style.height="450px";
           //document.all.slidemenubar2.style.display="block";
           //document.all.menu_mask.style.display="block";
        }
		pull();
		document.all.slidemenubar2.openState="1";
	}
	else{
	    draw();
		document.all.slidemenubar2.openState="0";
	}
}
var menuTree = null;
var model = null;
function getUrlStr(id){
   return _gModuleName+model.getUserObject(id,"url");
}
function getImgStr(id){
   return _gModuleName+model.getUserObject(id,"img");
}
function DBTreeLoad(xmlStr)
  {
	model = createDBTreeXmlModel(xmlStr,"id1","caption","url,img");
	menuTree = new DBTree(model);
	//menuTree.addListener(S_OnChange,new TreeListener(""));
	menuTree.setSameNodeEvent(true);
	menuTree.setFolderEvent(false);
       menuTree.setRootEvent(false);
	menuTree.setAllowDragDrop(true);
    menuTree.displayTree();
  }
//function TreeListener(name)
// {  this.Name = name;
//    this.execute = function(event)
//    {
//       var urlStr = getUrlStr(menuTree.getCurNodeValue());
//	   var imgStr = getImgStr(menuTree.getCurNodeValue());
//	   alert("urlStr="+urlStr+",\nimg="+imgStr);
//    }
// }
DBTreeLoad(document.all.item("FUNC_INFO").innerHTML);
document.all.item("menuTreeDiv").appendChild(menuTree.getUIObject());

