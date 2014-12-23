
/**在页面上可自由拖动的图标对象
* 创建参数说明：
* iconSrc图标URL
* btmText图标下方显示的文字含义
* gotoUrl点击图标下方显示的文字或者双击图标后的URL去向
* posX图标创建的横坐标
* posY图标创建的纵坐标
* divObj图标创建的DIV环境
* 张联华
 * 2004.10.26
*  于杭州办事处
 */
var g_MovePictManager=new MovePictManager();

function MovePictManager(){
 this.MovePictList = new Array();
 this.MaxId = 0;
 this.n=0;
 this.getNewPK = function(){
      this.MaxId = this.MaxId + 1;
//      alert("MovePictId" + this.MaxId);
      return this.MaxId;
 }
 this.push = function(movepict){
      this.MovePictList[movepict.PK] = movepict;
 }
 this.get = function(movePictPK){
      return this.MovePictList[movePictPK];
 }
}

function MovePict(iconSrc,btmText,gotoUrl,posX,posY,divObj,menuid){
  var tmpObj = new MovePictClass(iconSrc,btmText,gotoUrl,posX,posY,divObj,menuid);
  return tmpObj;
}

function MovePictClass(iconSrc,btmText,gotoUrl,posX,posY,divObj,menuid){
    this.PK = g_MovePictManager.getNewPK();
    g_MovePictManager.push(this);
    this.ICON_SRC=iconSrc;
    this.BTM_TEXT=btmText;
    this.GOTO_URL=gotoUrl;
    this.MENU_ID=menuid;
    this.x=posX;
    this.y=posY;
    this.z=null;
    this.w=null;

    this.UIObject = null;
    if (divObj)
      this.UIObject = divObj;
    else
      this.UIObject = document.createElement("div");

    var tmpid = "Move_pict_IDTmp";
    if (divObj)
      tmpid = divObj.id;
    this.id = tmpid;
    this.buildNode = buildPictFunc
    this.UIObject.onmousedown=MovePictClass_down;
    this.UIObject.onmouseup=MovePictClass_up;
    this.UIObject.onmousemove=MovePictClass_move;
    this.getX=function(){return this.PosX};
    this.getY=function(){return this.PosY};
    this.getPK=function(){return this.PK};
}

function buildPictFunc(){
  var htmStrArray = new Array();
  var aPK=this.PK;
  //在MovePict.js中生成DIV对象时设置oncontextmenu='checkOpType(AIPic??)设置
  //checkOpType在调用右键菜单的页面中声明使用。
  this.ICON_SRC=this.ICON_SRC.replace("//","/");
  htmStrArray[htmStrArray.length] = ("<DIV id=AIPic"+aPK+" style='LEFT: "+this.x+"; WIDTH: 63px; POSITION: absolute; TOP:"+this.y+"; HEIGHT: 82px' oncontextmenu='checkOpType(AIPic"+aPK+");'>");
  htmStrArray[htmStrArray.length] = ("<IMG style='CURSOR: hand' align=center hspace=5 src="+this.ICON_SRC+" name=0 ondblclick='window.location=\""+this.GOTO_URL+"\"'>");
  htmStrArray[htmStrArray.length] = ("<BR>");
  htmStrArray[htmStrArray.length] = ("<SPAN >");
  htmStrArray[htmStrArray.length] = ("<TABLE BORDER=0 cellSpacing=0 cellPadding=0 >");
  htmStrArray[htmStrArray.length] = ("<TBODY>");
  htmStrArray[htmStrArray.length] = ("<TR>");
  var open_func_name="javascript:openUrl('"+this.MENU_ID+"','"+(this.GOTO_URL)+"','"+this.BTM_TEXT+"')";
  htmStrArray[htmStrArray.length] = ("<TD width=50 align=center id=AILinkName"+aPK+"><A class=b1 href=\""+open_func_name+"\">"+this.BTM_TEXT+"</A>");
  htmStrArray[htmStrArray.length] = ("</TD>");
  htmStrArray[htmStrArray.length] = ("</TR>");
  htmStrArray[htmStrArray.length] = ("</TBODY>");
  htmStrArray[htmStrArray.length] = ("</TABLE>");
  htmStrArray[htmStrArray.length] = ("</SPAN>");
  htmStrArray[htmStrArray.length] = ("</DIV>");
  this.UIObject.innerHTML+=htmStrArray.join("");
}

function openUrl(aMenuId,aUrl,aText){
  //在桌面打开url
  parent.openUrl(aUrl,aText);
  //记录点击菜单的信息
  parent.logUserMenuClick(aMenuId,aText,aUrl);
}

function MovePictClass_down(){
  if (document.all && window.event.srcElement.parentElement){
    if  (window.event.srcElement.parentElement.id.indexOf("AIPic") != -1){
 	this.z=window.event.srcElement.parentElement;
        this.y=window.event.offsetY;
 	this.x=window.event.offsetX;
 	this.w=window.event.srcElement.parentElement.id.charAt(window.event.srcElement.parentElement.id.length-1);
	window.event.srcElement.parentElement.style.zIndex=g_MovePictManager.n++;
    }
  }
  return false;
}

function MovePictClass_move(){
  if (document.all && this.z){
    this.z.style.posLeft=window.event.clientX-this.x;
    this.z.style.posTop=window.event.clientY-this.y;
    var divName=this.z.id;
    var aID=divName.substring(5,divName.length);
    //更新对象的坐标
    for (var i=0;i<aryMovePict.length;i++){
      if (aID==i+1){
          aMovePictInst=aryMovePict[i];
          aMovePictInst[3]=this.z.style.posLeft;//x坐标
          aMovePictInst[4]=this.z.style.posTop;//y坐标
          aMovePictInst[8]="ISMOVE";
          aryMovePict[i]=aMovePictInst;
          break;
      }
    }
  }
  return false;
}

function MovePictClass_up(){
    document.onmousemove=null;
    this.z=null;
}

//重新排列桌面图标
function ReArrangePict(pAryMovePict){
	var n=pAryMovePict.length;
//	var pics = new Array(n);
//	for (var i=0;i<n;i++){
//            pics[i]=new picArray("AIPic"+eval(i+1),"icon"+i,"300","300");
//	}
	var winW //window Width
	winW=document.body.clientWidth
	var winH //window Height
	winH=document.body.clientHeight //window Height
	var minWinW=800
	var minWinH=410
	var iconW=100 //Icon Width
	var iconH=100 //Icon Height
	var topM=95 //Top Margin
	var rightM=70 //Right Margin
	var rows
	var cols
	var row
	var col

        rows=parseInt((winH-topM)/iconW)
        cols=parseInt(n/rows)+1
        row=0
        col=0
        for(i=0; i < n; i++)
        {
            obj=eval("AIPic"+eval(i+1));
            obj.style.posTop=topM+row*iconH;
            obj.style.posLeft=winW-rightM-col*iconW;
            aMovePictInst=pAryMovePict[i];
            aMovePictInst[4]=topM+row*iconH;//y坐标
            aMovePictInst[3]=winW-rightM-col*iconW;//x坐标
            aMovePictInst[8]="ISMOVE";
            aryMovePict[i]=aMovePictInst;
            if(row<rows-1){
              row=row+1
            }else{
              row=0;
              col=col+1
            }
            if(row>2){
              row=0;
              col=col+1
            }
        }

	if(rows<4){
            row=0
            col=0
            for(i=0; i < n; i++)
            {
                obj=eval("AIPic"+eval(i+1));
                obj.style.posTop=topM+row*iconH;
                obj.style.posLeft=winW-rightM-col*iconW;
            	aMovePictInst=pAryMovePict[i];
           	 aMovePictInst[4]=topM+row*iconH;//y坐标
            	aMovePictInst[3]=winW-rightM-col*iconW;//x坐标
                aMovePictInst[8]="ISMOVE";
            	aryMovePict[i]=aMovePictInst;
                if(row<rows-1){
                  row=row+1
                }else{
                  row=0;
                  col=col+1
                }if(row>2){
                  row=0;
                  col=col+1;
                 }
            }
	}else{
            row=3
            col=0
            j=0
            for(i=6; i < n; i++)
            {
                obj=eval("AIPic"+eval(i+1));
                obj.style.posTop=topM+row*iconH;
                obj.style.posLeft=winW-rightM-col*iconW;
                aMovePictInst=pAryMovePict[i];
            	aMovePictInst[4]=topM+row*iconH;//y坐标
            	aMovePictInst[3]=winW-rightM-col*iconW;//x坐标
                aMovePictInst[8]="ISMOVE";
            	aryMovePict[i]=aMovePictInst;
                if(row<rows-1){
                  row=row+1;
                }else{
                    if (j<1){
                      row=3;
                      col=col+1;
                      j++;
                    }else {
                      row=0;
                      col=col+1;
                    }
                }
            }
	}
}

