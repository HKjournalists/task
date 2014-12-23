/**
* AiTabPage前台模块
* 功能：实现TAB的显示、增、删、刷新等方法。
* 作者：张联华 亚信集团股份有限公司 南京研发中心J2EE Platform部
* 时间：2006.2.14
* 对外提供的函数：
* 1.	getCurrentTabFocusItem(aTabId) 			取当前聚焦的TABItem的索引号,没有聚焦返回-1
* 2.	getTabItemIdxsByTabItemId(aTabId,aItemId)	根据aItemId获得该aItemId对应的TAB index的数组
* 3.	setTabItem(aTabId,aItemId)			根据TAB编号和TABITEM编号设置Tab当前页
* 4.	setTabItemByItemIdx(aTabId,aIdx)		根据TAB编号和TABITEM索引设置Tab当前页
* 5.	refreshTabItem(aTabId,aTabItemId,aTitle,aUrl)	根据TabItem的名称刷新
* 6.	refreshTabItemByIdx(aTabId,aIdx,aTitle,aUrl)	根据TabItem的索引号刷新
* 7.	openNewTabItem(aTabId,aTabItemId,aTitle,aUrl,aIsDeletable,aIdx)	新增Tab页
* 8.	closeTabItem(aTabId,aTabItemId)			根据ItemId编号删除TAB页
* 9.	closeTabItemByIdx(aTabId,aIdx)			根据Item索引号删除TAB页
* 10.	setTabItemDeletable(aTabId,aItemId,aEditable)	根据Item名称设置对应Item的是否可删除属性
* 11.	setTabItemDeletableByIdx(aTabId,aIdx,aEditable)	根据Item索引设置对应Item的是否可删除属性
* 12.	getTabItemDeletable(aTabId,aItemId)		根据Item名称取对应Item的是否可删除属性
* 13.	getTabItemDeletableByIdx(aTabId,aIdx)		根据Item索引号取对应Item的是否可删除属性
* 14.	getTabType(aTabId)				根据TAB编号取TA类型
* 15.	setTabItemLen(aTabId,aTabItemId,aTabItemLen)	设置TabItem的宽度
*
*		================add by hexg 2006-6-28
* 16.	setTabItemTitle(aTabId,aItemId,title)	根据TAB编号和TABITEM编号设置Tab页的title
* 17.	getTabItemTitle(aTabId,aItemId)	根据TAB编号和TABITEM编号获取Tab页的title
* 18.   tabResizeTo(aTabId,width,height);
* 19.   setTabHeadScrollChangeValue(aTabId ,scrollChangeValue)
* */

var TAB_TYPE_H="H";
var TAB_TYPE_V="V";
var TAB_TYPE_B="B";
//取当前聚焦的TABItem
//没有聚焦返回-1
function getCurrentTabFocusItem(aTabId){
  if(! document.getElementById(aTabId))
    return -1;
  var tmpFocusIdx = document.getElementById(aTabId).currentTabFocusIdx;
  if(tmpFocusIdx == null)
  {
	tmpFocusIdx = -1;
	document.getElementById(aTabId).currentTabFocusIdx = tmpFocusIdx;
  }

  tmpFocusIdx = parseInt(tmpFocusIdx);
  return tmpFocusIdx;
}

function setCurrentTabFocusItem(aTabId,aFocusIdx){
    document.getElementById(aTabId).currentTabFocusIdx = aFocusIdx;
}

/**
* 根据aItemId获得该aItemId对应的TAB index的数组
* aTabId TAB编号
* aItemId TABITEM编号
* */
function getTabItemIdxsByTabItemId(aTabId,aItemId){
  var aIdxAry=new Array();
  var aMainObjId=aTabId+"_mainTable";
  var aMainObj=document.getElementById(aMainObjId);

  if(aMainObj!=null){
	  for (var i=0;i<aMainObj.tBodies.length;i++){
	    if (aMainObj.tBodies[i].id==aTabId+"_TableBody_"+aItemId){
	      aIdxAry[aIdxAry.length]=i;
	    }
	  }
  }
  return aIdxAry;
}

/**
  根据TAB编号和TABITEM编号设置Tab当前页
  aTabId：TAB编号
  aItemId:TABITEM编号
*/
function setTabItem(aTabId,aItemId){
  var aItemTitleObj=document.getElementById(aTabId +"_Title_"+ aItemId);
  var aItemBodyObj=document.getElementById(aTabId +"_TableBody_"+ aItemId);
  var aFrameObj=document.getElementById(aTabId + "_" + aItemId);
  var aItemFocusObj = document.getElementById(aTabId + "_Focus_" + aItemId);

  if(aItemBodyObj==null){
  	alert('对不起，找不到对应的 tabItem,无法对其进行聚焦操作。');
  	return false;
  }

  var ret=setTabItem_common(aTabId,aItemTitleObj,aItemBodyObj,aFrameObj,aItemFocusObj);
  if (ret==false){
    return;
  }
  //根据aItemId获得该aItemId对应的TAB index的数组
  //记录当前焦点TAB的index
  var aAry=getTabItemIdxsByTabItemId(aTabId,aItemId);
  if (aAry.length>=0){
    setCurrentTabFocusItem(aTabId,aAry[0]);
  }
}


/**
*  点击TABItem时，根据TAB编号和当前点击的对象设置Tab当前页
*  内部方法，不对外提供！
*  aTabId：TAB编号
*  aClickedTdObj:当前点击的对象
*  在tab_h.vm和tab_v.vm中和新增Tab时引用了该方法，点击Tab页时调用
*/
function setClickedTabItem(aTabId,aClickedTdObj){
  var aTagType=getTabType(aTabId);
 //查询该对象的index
  var aIdx;
  var aTitleTable=document.getElementById(aTabId+"_secTable");
  //横向TAB，根据当前选中的TD获取该TD在所处表格中的的INDEX
  if (aTagType.toUpperCase()==TAB_TYPE_H){
    var aTitleTr=aTitleTable.rows[0];
    for (var i=0;i<aTitleTr.cells.length;i++){
      if (aTitleTr.cells[i].uniqueID==aClickedTdObj.uniqueID){
        aIdx=i;
        break;
      }
    }
  }else if(aTagType.toUpperCase()==TAB_TYPE_B){
  	var aTitleTr=aTitleTable.rows[0];
    for (var i=0;i<aTitleTr.cells.length;i++){
      if (aTitleTr.cells[i].uniqueID==aClickedTdObj.uniqueID){
        aIdx=i;
        break;
      }
    }
  }else{
    for (var i=0;i<aTitleTable.rows.length;i++){
      if (aTitleTable.rows[i].cells[0].uniqueID==aClickedTdObj.uniqueID){
        aIdx=i;
        break;
      }
    }
  }
  var ret=setTabItemByItemIdx(aTabId,aIdx);
  if (ret==false){
    return;
  }
}

/**
*  根据TAB编号和TABITEM索引设置Tab当前页
*  tabId：
*  aIdx:
*/
function setTabItemByItemIdx(aTabId,aIdx){
  if (aIdx==null||aIdx=="undefined"||aIdx<0){
    alert("请传入合法的TabItem索引号！");
    return;
  }
  var aItemTitleObj;
  var aItemBodyObj;
  var aFrameObj;
  var aItemFocusObj;
  var aTitleTable=document.getElementById(aTabId+"_secTable");
  var aTagType=getTabType(aTabId);

  if (aTagType.toUpperCase()==TAB_TYPE_H){
  	if(aTitleTable.rows[0].cells.length-1<aIdx){
  		alert('对不起，指定的Idx超过tab页的范围,无法对其进行聚焦操作。');
	  	return false;
	 }
    aItemTitleObj=aTitleTable.rows[0].cells[aIdx];
    aItemFocusObj = aTitleTable.rows[0].cells[aIdx].firstChild;
    aItemFocusObj = aTitleTable.rows[0].cells[aIdx].firstChild.rows[0].cells[0].firstChild;

  }else if(aTagType.toUpperCase()==TAB_TYPE_B){
  	if(aTitleTable.rows[0].cells.length-1<aIdx){
  		alert('对不起，指定的Idx超过tab页的范围,无法对其进行聚焦操作。');
	  	return false;
	 }
    aItemTitleObj=aTitleTable.rows[0].cells[aIdx];
    aItemFocusObj = aTitleTable.rows[0].cells[aIdx].firstChild;
    aItemFocusObj = aTitleTable.rows[0].cells[aIdx].firstChild.rows[0].cells[0].firstChild;
  }else{
  	if(aTitleTable.rows.length-1<aIdx){
  		alert('对不起，指定的Idx超过tab页的范围,无法对其进行聚焦操作。');
	  	return false;
	 }
    aItemTitleObj=aTitleTable.rows[aIdx].cells[0];

    aItemFocusObj = aTitleTable.rows[aIdx].cells[0].firstChild.rows[0].cells[0].firstChild;
  }

  var aMainObjId=aTabId+"_mainTable";
  var aMainObj=document.getElementById(aMainObjId);
  aItemBodyObj=aMainObj.tBodies[aIdx];

  aFrameObj=aItemBodyObj.rows[0].cells[0].firstChild;

  var ret=setTabItem_common(aTabId,aItemTitleObj,aItemBodyObj,aFrameObj,aItemFocusObj);

  if (ret==false){
    return;
  }
  //记录当前焦点TAB的index
  setCurrentTabFocusItem(aTabId,aIdx);
}

/**
* 内部方法，前两个设置Tab聚焦方法使用，不对外提供。
*  设置Tab当前页
*  tabId：TAB编号
*  aItemTitleObj: 标题所在的td对象
*  aItemBodyObj:  正文对象
*  aFrameObj：    iframe对象
*/
function setTabItem_common(tabId,aItemTitleObj,aItemBodyObj,aFrameObj,aItemFocusObj){
  var tmpFocusIdx = getCurrentTabFocusItem(tabId);
  var headTable = document.getElementById(tabId + "_secTable");
  //beforeSetTab
  //SetTabItem之前的回调函数 dd
  var beforeSetTab= headTable.beforeSetTab;
  
  var afterSetTab= headTable.afterSetTab;
  var aOldItemTitle=null;
  var aOldItemTitleObjId=null;
  var aTitleTable=document.getElementById(tabId+"_secTable");
  if (tmpFocusIdx !=null &&tmpFocusIdx>=0){
    var aTagType=getTabType(tabId);

    if (aTagType.toUpperCase()==TAB_TYPE_H){
      if (tmpFocusIdx>=aTitleTable.rows[0].cells.length){
        tmpFocusIdx=aTitleTable.rows[0].cells.length-1;
      }
      aOldItemTitleObjId=aTitleTable.rows[0].cells[tmpFocusIdx].id;
    }else if(aTagType.toUpperCase()==TAB_TYPE_B){
    	if (tmpFocusIdx>=aTitleTable.rows[0].cells.length){
        tmpFocusIdx=aTitleTable.rows[0].cells.length-1;
      }
      aOldItemTitleObjId=aTitleTable.rows[0].cells[tmpFocusIdx].id;
    }else{
      if (tmpFocusIdx>=aTitleTable.rows.length){
        tmpFocusIdx=aTitleTable.rows.length-1;
      }
      aOldItemTitleObjId=aTitleTable.rows[tmpFocusIdx].cells[0].id;
    }
    aOldItemTitle=aOldItemTitleObjId.split("_Title_")[1];
  }

  var aNewItemTitleObjId=aItemTitleObj.id;
  var aNewItemTitle=aNewItemTitleObjId.split("_Title_")[1];
  if (beforeSetTab&&beforeSetTab!=""){
    try{
      var ret=eval(beforeSetTab+"('"+aOldItemTitle+"','"+aNewItemTitle+"')");
      if (ret==false){
        return false;
      }
    }catch(ex){
      alert("执行beforeSetTab出错："+ex.message+"或定义在执行SetTabItem之后！");
      return false;
    }
  }
  var mainTable = document.getElementById(tabId + "_mainTable");
  var aTagObj=document.getElementById(tabId);
  var aTagType=getTabType(tabId);
  var aFocusClass;
  var aNotFocusClass;
  if (aTagType.toUpperCase()==TAB_TYPE_H){
    aFocusClass="tab_h_focus";
    aNotFocusClass="tab_h_not_focus";
  	/*for(i=0;i<headTable.cells.length;i++){
      //headTable.cells[i].firstChild.style.display="none";
      //headTable.cells[i].firstChild.rows[0].cells[0].style.display="none";
    }*/

	
	
     for(i=0;i<headTable.cells.length;i++){
     	//headTable.cells[i].firstChild.className=aNotFocusClass;
     	if(headTable.cells[i].firstChild.firstChild.firstChild.firstChild.firstChild.className != "tab_h_title_style")
     	  headTable.cells[i].firstChild.firstChild.firstChild.firstChild.firstChild.className ="tab_h_title_style";
		/****/
     	if (headTable.rows[0].cells[i].firstChild.rows[0].cells[0].firstChild.firstChild.firstChild.rows[0].cells[1].firstChild != null)
     	{
     		//alert(i + "start");
     		headTable.rows[0].cells[i].firstChild.rows[0].cells[0].firstChild.firstChild.firstChild.rows[0].cells[1].firstChild.className="tab_item_close_button";
     		//alert(i + "end");
     	}
     	/****/
	  }
	  for(i=0;i<mainTable.tBodies.length;i++)
	      mainTable.tBodies[i].style.display="none";

	  //aItemTitleObj.firstChild.className=aFocusClass;
	  aItemTitleObj.firstChild.firstChild.firstChild.firstChild.firstChild.className = "tab_h_title_style_current";
	  
	  /****/
	  //add close_button style	  
	  var temp=aItemTitleObj.firstChild.rows[0].cells[0].firstChild.firstChild.firstChild.rows[0].cells[1].firstChild;
	  if (temp != null)
	  {
	  	temp.className="tab_item_close_button_current";
	  }
	  /****/
	  aItemBodyObj.style.display="block";
  }else if(aTagType.toUpperCase()==TAB_TYPE_B){
     for(i=0;i<headTable.cells.length;i++){
       if(headTable.cells[i].firstChild.firstChild.firstChild.firstChild.firstChild.className != "tab_b_title_style")
     	   headTable.cells[i].firstChild.firstChild.firstChild.firstChild.firstChild.className ="tab_b_title_style";
     	/****/
     	if (headTable.rows[0].cells[i].firstChild.rows[0].cells[0].firstChild.firstChild.firstChild.rows[0].cells[1].firstChild != null)
     	{
     		headTable.rows[0].cells[i].firstChild.rows[0].cells[0].firstChild.firstChild.firstChild.rows[0].cells[1].firstChild.className="tab_item_close_button";
     	}
     	/****/
	}
	  for(i=0;i<mainTable.tBodies.length;i++)
	      mainTable.tBodies[i].style.display="none";

	  //aItemTitleObj.firstChild.className=aFocusClass;
	  aItemTitleObj.firstChild.firstChild.firstChild.firstChild.firstChild.className = "tab_b_title_style_current";
	  
	  /****/
	  //add close_button style
	  var temp=aItemTitleObj.firstChild.rows[0].cells[0].firstChild.firstChild.firstChild.rows[0].cells[1].firstChild;
	  if (temp != null)
	  {
	  	temp.className="tab_item_close_button_current";
	  }
	  /****/
	  
	  aItemBodyObj.style.display="block";
  }else{

    aFocusClass="tab_v_title_style_current";
    aNotFocusClass="TAB_V_TITLE_STYLE";

  	for(i=0;i<headTable.rows.length;i++)
  	{
      headTable.rows[i].cells[0].firstChild.rows[0].cells[0].style.display="none";
      /****/
      var temp=headTable.rows[i].cells[0].firstChild.rows[0].cells[2];
      if (temp.firstChild != null)
      {
        temp.firstChild.className="tab_item_close_button";
      }
      /****/
    }

      for(i=0;i<headTable.cells.length;i++)
      {
        if(headTable.cells[i].firstChild.className != aNotFocusClass)
           headTable.cells[i].firstChild.className=aNotFocusClass;
      }

	  for(i=0;i<mainTable.tBodies.length;i++)
	      mainTable.tBodies[i].style.display="none";

	  aItemTitleObj.firstChild.className=aFocusClass;
	  /****/
	  var temp=aItemTitleObj.firstChild.rows[0].cells[2];
	  if (temp.firstChild != null)
	  {
	  	temp.firstChild.className="tab_item_close_button_current";
	  }
	  /****/
	  aItemBodyObj.style.display="block";
  }
  //aItemFocusObj.style.display="inline";
 // aItemFocusObj.style.display="block";
  //aItemFocusObj.parentNode.style.display="block";
  var src = aFrameObj.destsrc;

  var divobj = document.getElementById(tabId);
  var getparameterfunction = divobj.getparameterfunction;
  if(getparameterfunction&&(getparameterfunction!="")){
    //取得itemId
    var itemId=aItemTitleObj.id.split("_Title_")[1];
     var p = "";
     try{
       eval("p=" + getparameterfunction +"('" + itemId + "');");
     }catch(ex){
       alert("取参数函数调用失败！请检查函数"+getparameterfunction+"是否存在。");
       return;
     }
     if(p){
	     if(src.indexOf("?") > 0 ){
		src = src + "&" + p;
	     }else{
                src = src + "?" + p;
	     }
     }

  }
  //如果url不同就刷新。包括传入参数不同，才刷新。
  if(aFrameObj.src != src ){
      aFrameObj.src = src;
  }
  //SetTabItem之后的回调函数
  if (afterSetTab&&afterSetTab!=""){
    try{
     eval(afterSetTab+"('"+aOldItemTitle+"','"+aNewItemTitle+"')");
    }catch(ex){
      alert("执行afterSetTab出错："+ex.message+"或定义在执行SetTabItem之后！");
      return;
    }
  }
}

/**
* 根据TabItem的名称刷新
* aTabId Tab名称
* aTabItemId   TabItem的名称
* aTitle 标题，不需要改变标题时传入null
* aUrl   Url，不需要改变Url时传入null
* */
function refreshTabItem(aTabId,aTabItemId,aTitle,aUrl){
  var aAry=getTabItemIdxsByTabItemId(aTabId,aTabItemId);
  for (var i=0;i<aAry.length;i++){
    refreshTabItemByIdx(aTabId,aAry[i],aTitle,aUrl);
  }
}

/**
* 根据TabItem的索引号刷新
* aTabId Tab名称
* aIdx   TabItem的索引号
* aTitle 标题，不需要改变标题时传入null
* aUrl   Url，不需要改变Url时传入null
* */
function refreshTabItemByIdx(aTabId,aIdx,aTitle,aUrl){
  if (aIdx==null||aIdx=="undefined"||aIdx==undefined||aIdx<0){
    alert("请传入合法的TabItem索引号！");
    return;
  }
  //如果标题和当前标题不同，则刷新标题
  //取标题对象和标题
  var aTagType=getTabType(aTabId);
  if (aTitle){
    var aHeadTable=document.getElementById(aTabId+"_secTable");
    var aHeadTdObj;
    if (aTagType.toUpperCase()==TAB_TYPE_H){
      if (aHeadTable.rows[0].cells[aIdx]){
        aHeadTdObj=aHeadTable.rows[0].cells[aIdx];
        //20060807
		//设置标题
		if(aTitle!=null){
			//str = "<div id='item_title' nowrap align=center class='tab_title_style'><font size=1>&nbsp;</font>"+aTitle+"</div>";
			aHeadTdObj.firstChild.rows[0].cells[0].firstChild.firstChild.firstChild.rows[0].cells[0].innerHTML = aTitle;
		}
      }else{
        alert("aHeadTdObj对象不存在,请检查索引号是否过大!");
        return;
      }
    }else if(aTagType.toUpperCase()==TAB_TYPE_B){
    	if (aHeadTable.rows[0].cells[aIdx]){
        aHeadTdObj=aHeadTable.rows[0].cells[aIdx];
        //20060807
		//设置标题
		if(aTitle!=null){
			str = "<div id='item_title' nowrap align=center class='tab_title_style'><font size=1>&nbsp;</font>"+aTitle+"</div>";
			aHeadTdObj.firstChild.rows[0].cells[0].firstChild.firstChild.firstChild.rows[0].cells[0].innerHTML = aTitle;
		}
      }else{
        alert("aHeadTdObj对象不存在,请检查索引号是否过大!");
        return;
      }
    }else{
      if (aHeadTable.rows[aIdx]){
        aHeadTdObj=aHeadTable.rows[aIdx].cells[0];
         //20060807
		//设置标题
		if(aTitle!=null){
			str = "<div id='item_title' nowrap align=center class='tab_title_style'><font size=1>&nbsp;</font>"+aTitle+"</div>";
			aHeadTdObj.firstChild.rows[0].cells[1].innerHTML = str;
		}
      }else{
        alert("aHeadTdObj对象不存在,请检查索引号是否过大!");
        return;
      }
    }
   
  }
  //如果url不同，则刷新url
  //取正文对象和url
  if (aUrl){
    var aMainObjId=aTabId+"_mainTable";
    var aMainObj=document.getElementById(aMainObjId);
    aItemBodyObj=aMainObj.tBodies[aIdx];
    if (!aItemBodyObj){
      alert("正文对象aMainObj.tBodies不存在,请检查索引号是否过大！");
      return;
    }
    aFrameObj=aItemBodyObj.rows[0].cells[0].firstChild;
    aFrameObj.destsrc=aUrl;
    aFrameObj.src = aUrl;
  }

  updateScrollBarStatus(aTabId)
}

/**
* 新增Tab页
* aTabId TAB编号
* aTabItemId TabItem编号
* aTitle 标题
* aUrl   URL
* aIsDeletable 是否可被删除
* aIdx    插入在该索引号的TAB页之前。
* */
function openNewTabItem(aTabId,aTabItemId,aTitle,aUrl,aIsDeletable,aIdx){
  //增加标题和关闭图片按钮及对应的关闭事件
  //读入文件，如果是横向，则从AddTabHeader_H.vm中读取
  //查询要插入的目标对象
  var aNewItemHeadObj;
  var aItemHeadTargetObj=null;
  //取aTabType
  var aTagType=getTabType(aTabId);
  var aNewIdx=0;
  var aTotalNo=0;
  var aHeadTable=document.getElementById(aTabId+"_secTable");
  if (aTagType.toUpperCase()==TAB_TYPE_H){
    aNewItemHeadObj=getNewHItemHead(aTabId,aTabItemId,aTitle,aIsDeletable,'h');
    //如果是横向的，则需要查找id="${tag.getId()}_secTable"的TABLE的第一行TR，在该TR中增加一个TD
    aTabHeadTargetObj=aHeadTable.rows[0];
    aTotalNo=aHeadTable.rows[0].cells.length;
    //如果作为最后一个，则直接追加在最后一个对象之后。
    if (aIdx==null||aIdx=="undefined"||aIdx>=aTotalNo){
      aNewIdx=aTotalNo;
      aTabHeadTargetObj.appendChild(aNewItemHeadObj);
    }else{
      //否则插在目标对象之前。
      var aAfterObj=aHeadTable.rows[0].cells[aIdx];
      aTabHeadTargetObj.insertBefore(aNewItemHeadObj,aAfterObj);
      aNewIdx=aIdx;
    }
  }else if(aTagType.toUpperCase()==TAB_TYPE_B){
  	aNewItemHeadObj=getNewHItemHead(aTabId,aTabItemId,aTitle,aIsDeletable,'b');
    //如果是横向的，则需要查找id="${tag.getId()}_secTable"的TABLE的第一行TR，在该TR中增加一个TD
    aTabHeadTargetObj=aHeadTable.rows[0];
    aTotalNo=aHeadTable.rows[0].cells.length;
    //如果作为最后一个，则直接追加在最后一个对象之后。
    if (aIdx==null||aIdx=="undefined"||aIdx>=aTotalNo){
      aNewIdx=aTotalNo;
      aTabHeadTargetObj.appendChild(aNewItemHeadObj);
    }else{
      //否则插在目标对象之前。
      var aAfterObj=aHeadTable.rows[0].cells[aIdx];
      aTabHeadTargetObj.insertBefore(aNewItemHeadObj,aAfterObj);
      aNewIdx=aIdx;
    }
  }else{
    aNewItemHeadObj=getNewVItemHead(aTabId,aTabItemId,aTitle,aIsDeletable);
    //如果是纵向的，则查找id="${tag.getId()}_secTable"的TABLE，向该TABLE中增加一行
    aTabHeadTargetObj=aHeadTable.tBodies[0];
    aTotalNo=aHeadTable.rows.length;
    //如果作为最后一个，则直接追加在最后一个对象之后。
    if (aIdx==null||aIdx=="undefined"||aIdx>=aTotalNo){
      aNewIdx=aTotalNo;
      aTabHeadTargetObj.appendChild(aNewItemHeadObj);
    }else{
      //否则插在目标对象之前。
      var aAfterObj=aHeadTable.rows[aIdx];
      aTabHeadTargetObj.insertBefore(aNewItemHeadObj,aAfterObj);
      aNewIdx=aIdx;
    }
  }

  //增加TAB正文内容
  var aMainObjId=aTabId+"_mainTable";
  var aMainObj=document.getElementById(aMainObjId);
  //根据aTabId取正文内容的高度！
  var aHeight=aMainObj.tBodies[0].rows[0].height;
  var aNewMainObj=getNewItemMain(aTabId,aTabItemId,aUrl,aHeight);
  //如果作为最后一个，则直接追加在最后一个对象之后。
  if (aIdx==null||aIdx=="undefined"||aIdx>=aTotalNo){
    aNewIdx=aTotalNo;
    aMainObj.appendChild(aNewMainObj);
  }else{
    //否则插在目标对象之前。
    var aAfterObj=aMainObj.tBodies[aIdx];
    aMainObj.insertBefore(aNewMainObj,aAfterObj);
    aNewIdx=aIdx;
  }
  //调用setTabItem方法将新增的TAB页设为当前页
  setTabItemByItemIdx(aTabId,aNewIdx);
  updateScrollBarStatus(aTabId);
  
}

//取得新增横向TabItem的内容
function getNewHItemHead(aTabId,aTabItemId,aTitle,aIsDeletable,type){
  //getCommonItemHead(aTabId,aTabItemId,aTitle,aIsDeletable,"tab_h_not_focus");
  var aTdStr="<td class=tab_"+type+"_not_focus onclick=\"setClickedTabItem('"+aTabId+"',this)\" ";
  /****/
  aTdStr+="onmouseover=\"setMouseOverTabItem('"+aTabId+"',this)\" ";
  aTdStr+="onmouseout=\"setMouseOutTabItem('"+aTabId+"',this)\" ";
  /****/
  aTdStr+="id =\""+aTabId+"_Title_"+aTabItemId+"\" style=\"white-space: nowrap; word-break: keep-all;\" isDeletable=\""+aIsDeletable+"\"  nowrap> ";
  aTdStr+="</td>";
  var aTd=document.createElement(aTdStr);
  var aSpanStr="<table =0 cellspacing=0 cellpadding=0 class=tab_"+type+"_not_focus width='100%'>";
	aSpanStr+="<tr><td nowrap align=center>";
	aSpanStr+="<div id='item_title' nowrap align=center class='tab_"+type+"_title_style'><a href=\"###\"><table border=\"0\" cellspacing=0 cellpadding=0><tr><td width=\"98%\" class=\"tab_"+type+"_title_font_style\">"+aTitle+"</td>";
	aSpanStr+="<td>";
	if (aIsDeletable=="true"){
	    aSpanStr+="<span id=\"tab_item_close_button\" class=\"tab_item_close_button\" onclick=\"closeClickedTabItem('"+aTabId+"',this);\" "
	   	 		/****/
	    		+"onmouseover=\"setMouseOverCloseTabItem('"+aTabId+"',this,'_Title_"+aTabItemId+"')\" "
	    		+"onmouseout=\"setMouseOutCloseTabItem('"+aTabId+"',this,'_Title_"+aTabItemId+"')\" "
	    		/****/
	    		+">&nbsp</span> ";
	}
  	aSpanStr+="</td></tr></table></a></div></td></tr></table>";
  aTd.innerHTML=aSpanStr;
  return aTd;
  return;
}

//取得新增纵向TabItem的内容
function getNewVItemHead(aTabId,aTabItemId,aTitle,aIsDeletable){
  var aTrStr="<tr align=right></tr>";
  var aTr=document.createElement(aTrStr);
  var aTd=getCommonItemHead(aTabId,aTabItemId,aTitle,aIsDeletable,"tab_v_not_focus");
  aTr.appendChild(aTd);
  return aTr;
}

/**新增横向TabItem、纵向TabItem的共同内容，用以复用，便于修改
* 注意：修改vm模板文件时可能需要修改此方法！
* 内部方法，不对外提供！
* */
function getCommonItemHead(aTabId,aTabItemId,aTitle,aIsDeletable,aTabClass){
  var aTdStr="<td class="+aTabClass+" onclick=\"setClickedTabItem('"+aTabId+"',this)\" ";
  /****/
  aTdStr+="onmouseover=\"setMouseOverTabItem('"+aTabId+"',this)\" ";
  aTdStr+="onmouseout=\"setMouseOutTabItem('"+aTabId+"',this)\" ";
  /****/
  aTdStr+="id =\""+aTabId+"_Title_"+aTabItemId+"\"  isDeletable=\""+aIsDeletable+"\"  nowrap> ";
  aTdStr+="</td>";
  var aTd=document.createElement(aTdStr);

  var aSpanStr="<table =0 cellspacing=0 cellpadding=0 class='tab_h_not_focus' width='100%'>";
	aSpanStr+="<tr><td width='1%' nowrap>";
	aSpanStr+="<div id="+aTabId+"_Focus_"+aTabItemId+" class='tab_item_focus_star'>&nbsp</div>";
	aSpanStr+="</td><td nowrap align=center>";
	aSpanStr+="<div id='item_title' nowrap align=center class='tab_title_style'><font size=1>&nbsp;</font>"+aTitle+"</div></td>";
	aSpanStr+="<td width='1%' nowrap>";
	if (aIsDeletable=="true"){
	    aSpanStr+="<span id=\"tab_item_close_button\" class=\"tab_item_close_button\" onclick=\"closeClickedTabItem('"+aTabId+"',this);\" "
	    		/****/
	    		+"onmouseover=\"setMouseOverCloseTabItem('"+aTabId+"',this,'_Title_"+aTabItemId+"')\" "
	    		+"onmouseout=\"setMouseOutCloseTabItem('"+aTabId+"',this,'_Title_"+aTabItemId+"')\" "
	    		/****/
	    		+">&nbsp</span> ";
	}
  	aSpanStr+="</td>";
	aSpanStr+="</tr></table>";

  aTd.innerHTML=aSpanStr;
  return aTd;
}

/*新增横向TabItem、纵向TabItem的正文内容
* 内部方法，不对外提供！
* */
function getNewItemMain(aTabId,aTabItemId,aUrl,aHeight){
  var aNewMainCont="<tbody style=\"display:none;\" id=\""+aTabId+"_TableBody_"+aTabItemId+"\"></tbody>";
  var aNewMainObj=document.createElement(aNewMainCont);
  var aTrCont="<tr height=\""+aHeight+"\"></tr>";
  var aNewRow=document.createElement(aTrCont);
  var aTdCont="<td align=center valign=top ></td>";
  var aNewCell=document.createElement(aTdCont);
  aNewCell.innerHTML="<iframe id=\""+aTabId+"_"+aTabItemId+"\" destsrc=\""+aUrl+"\" width=\"100%\" height=\"100%\" frameborder=0> </iframe>";
  aNewRow.appendChild(aNewCell);
  aNewMainObj.appendChild(aNewRow);
  return aNewMainObj;
}

/**根据ItemId编号删除TAB页
* aTabId TAB编号
* aTabItemId ItemId编号
* */
function closeTabItem(aTabId,aTabItemId){
  //根据aTabItemId取得索引
  var aAry=getTabItemIdxsByTabItemId(aTabId,aTabItemId);
  if (aAry!=null&&aAry.length>0){
    for (var i=0;i<aAry.length;i++){
      //根据Item索引号删除
      closeTabItemByIdx(aTabId,aAry[i])
    }
  }else{
    alert("请检查该Tab页"+aTabId+"_"+aTabItemId+"是否存在！");
    return "false";
  }
}

/**根据Item索引号删除
* aTabId TAB编号
* aIdx Item索引号
* */
function closeTabItemByIdx(aTabId,aIdx){
  if (aIdx==null||aIdx=="undefined"||aIdx<0){
    alert("请传入合法的TabItem索引号！");
    return;
  }

  //取当前状态，判断是否可删除
  var aCurState=getTabItemDeletableByIdx(aTabId,aIdx);

  if (aCurState==false || aCurState=="false"){
    return false;
  }

  //根据Item索引号取得aCloseSpanObj对象
  var aTagObj=document.getElementById(aTabId);
  var aTagType=getTabType(aTabId);
  var aTitleTable=document.getElementById(aTabId+"_secTable");
  var aCloseSpanObj;


  if (aTagType.toUpperCase()==TAB_TYPE_H){
    aCloseSpanObj = aTitleTable.rows[0].cells[aIdx].firstChild.rows[0].cells[0].firstChild.firstChild.firstChild.rows[0].cells[1].firstChild;
  }else if(aTagType.toUpperCase()==TAB_TYPE_B){
  	aCloseSpanObj = aTitleTable.rows[0].cells[aIdx].firstChild.rows[0].cells[0].firstChild.firstChild.firstChild.rows[0].cells[1].firstChild;
  }else{
    aCloseSpanObj = aTitleTable.rows[aIdx].cells[0].firstChild.rows[0].cells[2].firstChild;
  }
  closeClickedTabItem(aTabId,aCloseSpanObj);
}

/**点击关闭按钮时删除一个TAB页
* 内部方法，不对外提供！
* 在tab_h.vm和tab_v.vm中和新增Tab时引用了该方法，点击关闭按钮时调用
* aTabId TAB编号
* aCloseSpanObj 关闭按钮对象
* */
function closeClickedTabItem(aTabId,aCloseSpanObj){
  if (!aTabId){
    alert("未找到Tab标识！");
    return;
  }
  //正文内容
  //如果只有最后一个，则不能删除！
  var aMainObjId=aTabId+"_mainTable";
  var aMainObj=document.getElementById(aMainObjId);
  if (aMainObj.tBodies.length==1){
    alert("最后一个TAB页不允许删除！");
    return;
  }
  var aTagObj=document.getElementById(aTabId);
  var aTagType=getTabType(aTabId);
  var aItemHeadObj;
  var aIdx=-1;
  //查询该对象的index
  var aTitleTable=document.getElementById(aTabId+"_secTable");
  if (aTagType.toUpperCase()==TAB_TYPE_H){
    sub_table_td=aCloseSpanObj.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;
   
    aItemHeadObj = sub_table_td.parentNode.parentNode.parentNode.parentNode;
	
    var aTitleTr=aTitleTable.rows[0];
    for (var i=0;i<aTitleTr.cells.length;i++){
      if (aTitleTr.cells[i].uniqueID==aItemHeadObj.uniqueID){
        aIdx=i;
        break;
      }
    }
  }else if(aTagType.toUpperCase()==TAB_TYPE_B){
  	 sub_table_td=aCloseSpanObj.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;
   
    aItemHeadObj = sub_table_td.parentNode.parentNode.parentNode.parentNode;

    var aTitleTr=aTitleTable.rows[0];
    for (var i=0;i<aTitleTr.cells.length;i++){
      if (aTitleTr.cells[i].uniqueID==aItemHeadObj.uniqueID){
        aIdx=i;
        break;
      }
    }
  }else{
    //纵向TAB需要删除td的tr
    aItemHeadObj=aCloseSpanObj.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;
    for (var i=0;i<aTitleTable.rows.length;i++){
      if (aTitleTable.rows[i].uniqueID==aItemHeadObj.uniqueID){
        aIdx=i;
        break;
      }
    }

  }
  //删除标题和关闭图片按钮栏。
 //aItemHeadObj.removeNode(true);
  aItemHeadObj.parentNode.removeChild(aItemHeadObj);
  aItemHeadObj.innerHTML="";
  aItemHeadObj =null;

  //删除TAB正文内容
  aItemBodyObj=aMainObj.tBodies[aIdx];
  if (aItemBodyObj){
	var iframeObj = aItemBodyObj.firstChild.firstChild.firstChild;
	if(iframeObj.tagName == 'IFRAME'){ 
		var doc = iframeObj.contentDocument;
		if (doc == undefined || doc == null){
		   doc = iframeObj.contentWindow.document;
		}	
		iframeObj.contentWindow.location.replace("about:blank");
		doc.write('');        
		doc.clear(); 
	}
	
    aItemBodyObj.removeNode(true);
  }

  //如果删除的TAB页是当前焦点TAB页，则
  //设置删除TAB页的前一个TAB页为当前焦点TAB页
  //如果删除的TAB页在当前焦点TAB页的上面，则当前当前焦点TAB页currentTabFocusIdx需要减1
  var tmpFocusIdx = getCurrentTabFocusItem(aTabId);
  if (aIdx<tmpFocusIdx){
    tmpFocusIdx = tmpFocusIdx -1;
    setCurrentTabFocusItem(aTabId,tmpFocusIdx);
  }
  var aFocusIdx;
  if (aIdx==tmpFocusIdx){
    aFocusIdx=aIdx-1;
    if (aFocusIdx<=0){
      aFocusIdx=0;
    }
    setTabItemByItemIdx(aTabId,aFocusIdx);
  }
  else{
    if (aIdx==0){
      aFocusIdx=0;
      setTabItemByItemIdx(aTabId,aFocusIdx);
    }
  }
updateScrollBarStatus(aTabId)
}

/**根据Item名称设置对应Item的是否可删除属性
* aTabId TAB编号
* aItemId TabItem编号
* aEditable 是否可删除
* */
function setTabItemDeletable(aTabId,aItemId,aEditable){
  if (aEditable!="true"&&aEditable!="false"){
    alert("aEditable参数错误，必须为：true/false");
    return "false";
  }
  if((aTabId==null||aTabId==undefined||aTabId=="undefined")
  ||(aItemId==null||aItemId==undefined||aItemId=="undefined")){
    alert("请输入Tab编号和TabItem编号！");
    return "false";
  }
  if (aTabId==null||aTabId==undefined||aTabId=="undefined"){
    alert("请传入合法的TAB编号！");
    return "false";
  }
  if (aItemId==null||aItemId==undefined||aItemId=="undefined"){
    alert("请传入合法的TabItem编号！");
    return "false";
  }
  var aAry=getTabItemIdxsByTabItemId(aTabId,aItemId);
  if (aAry!=null&&aAry.length>0){
    for (var i=0;i<aAry.length;i++){
      setTabItemDeletableByIdx(aTabId,aAry[i],aEditable);
    }
  }else{
    alert("请检查该Tab页"+aTabId+"_"+aItemId+"是否存在！");
    return "false";
  }

}

/**根据Item索引设置对应Item的是否可删除属性
* aTabId TAB编号
* aIdx TabItem的索引号
* aEditable 是否可删除
* */
function setTabItemDeletableByIdx(aTabId,aIdx,aEditable){
  if (aEditable!="true"&&aEditable!="false"){
    alert("aEditable参数错误，必须为：true/false");
    return "false";
  }
  if((aTabId==null||aTabId==undefined||aTabId=="undefined")
  ||(aIdx==null||aIdx==undefined||aIdx=="undefined")){
    alert("请输入Tab编号和索引号,或者检查该Tab页是否存在！");
    return "false";
  }

  if (aTabId==null||aTabId==undefined||aTabId=="undefined"){
    alert("请传入合法的TAB编号！");
    return "false";
  }
  if (aIdx==null||aIdx==undefined||aIdx=="undefined"||aIdx<0){
    alert("请传入合法的TabItem索引号！");
    return "false";
  }
  //判断对象的状态是否已经是要设置的状态,或者返回false
  var aCurState=getTabItemDeletableByIdx(aTabId,aIdx);
  if (aEditable==aCurState||aCurState==false){
    return "false";
  }

  var aTagType=getTabType(aTabId);
  var aTitleTable=document.getElementById(aTabId+"_secTable");
  //增加或删除图片按钮,并设置对象的值
  var aSpanObjHtml="<span id=\"tab_item_close_button\" class=\"tab_item_close_button\" onclick=\"closeClickedTabItem('"+aTabId+"',this);\">&nbsp</span>";
  if (aTagType.toUpperCase()==TAB_TYPE_H){

    aTitleTable.rows[0].cells[aIdx].isDeletable=aEditable;
    if (aEditable=="true"){
		//aTitleTable.rows[0].cells[aIdx].innerHTML+=aSpanObjHtml;
		//aTitleTable.rows[0].cells[aIdx].firstChild.rows[0].cells[2].innerHTML=aSpanObjHtml;
		 aTitleTable.rows[0].cells[aIdx].firstChild.rows[0].cells[0].firstChild.firstChild.firstChild.rows[0].cells[1].innerHTML=aSpanObjHtml;
    }else{
      //aTitleTable.rows[0].cells[aIdx].firstChild.rows[0].cells[2].innerText="";
      //alert(aTitleTable.rows[0].cells[aIdx].firstChild.rows[0].cells[0].firstChild.firstChild.firstChild.rows[0].cells[1].innerHTML)
      aTitleTable.rows[0].cells[aIdx].firstChild.rows[0].cells[0].firstChild.firstChild.firstChild.rows[0].cells[1].innerText="";
      /* var aChildObjAry=aTitleTable.rows[0].cells[aIdx].childNodes;
       for (var i=0;i<aChildObjAry.length;i++){
         if (aChildObjAry[i].id=="tab_item_close_button"){
           aChildObjAry[i].removeNode(true);
         }
       }*/
    }
  }else if (aTagType.toUpperCase()==TAB_TYPE_B){

    aTitleTable.rows[0].cells[aIdx].isDeletable=aEditable;
    if (aEditable=="true"){
		//aTitleTable.rows[0].cells[aIdx].innerHTML+=aSpanObjHtml;
		 aTitleTable.rows[0].cells[aIdx].firstChild.rows[0].cells[0].firstChild.firstChild.firstChild.rows[0].cells[1].innerHTML=aSpanObjHtml;
    }else{
      aTitleTable.rows[0].cells[aIdx].firstChild.rows[0].cells[0].firstChild.firstChild.firstChild.rows[0].cells[1].innerText="";
      /* var aChildObjAry=aTitleTable.rows[0].cells[aIdx].childNodes;
       for (var i=0;i<aChildObjAry.length;i++){
         if (aChildObjAry[i].id=="tab_item_close_button"){
           aChildObjAry[i].removeNode(true);
         }
       }*/
    }
  }else{
    aTitleTable.rows[aIdx].cells[0].isDeletable=aEditable;
    if (aEditable=="true"){
	    aTitleTable.rows[aIdx].cells[0].firstChild.rows[0].cells[2].innerHTML=aSpanObjHtml;
    }else{
    	aTitleTable.rows[aIdx].cells[0].firstChild.rows[0].cells[2].innerText="";
       /*var aChildObjAry=aTitleTable.rows[aIdx].cells[0].childNodes;
       for (var i=0;i<aChildObjAry.length;i++){
         if (aChildObjAry[i].id=="tab_item_close_button"){
           aChildObjAry[i].removeNode(true);
         }
       }*/
    }
  }

}

/**根据Item名称取对应Item的是否可删除属性
* aTabId TAB编号
* aItemId TabItem编号
* */
function getTabItemDeletable(aTabId,aItemId){
  if((aTabId==null||aTabId==undefined||aTabId=="undefined")
  ||(aItemId==null||aItemId==undefined||aItemId=="undefined")){
    alert("请输入Tab编号和TabItem编号！");
    return "false";
  }
  if (aTabId==null||aTabId==undefined||aTabId=="undefined"){
    alert("请传入合法的TAB编号！");
    return "false";
  }
  if (aItemId==null||aItemId==undefined||aItemId=="undefined"){
    alert("请传入合法的TabItem编号！");
    return "false";
  }
  var aAry=getTabItemIdxsByTabItemId(aTabId,aItemId);
  //只取第一个对象的属性
  if (aAry.length>=0){
    return getTabItemDeletableByIdx(aTabId,aAry[0]);
  }else{
    alert("未找到aItemId！");
    return "false";
  }
}

/**根据Item索引号取对应Item的是否可删除属性
* aTabId TAB编号
* aIdx TabItem索引号
* */
function getTabItemDeletableByIdx(aTabId,aIdx){
  if((aTabId==null||aTabId==undefined||aTabId=="undefined")
  ||(aIdx==null||aIdx==undefined||aIdx=="undefined")){
    alert("请输入Tab编号和索引号,或者检查该Tab页是否存在！");
    return false;
  }

  if (aTabId==null||aTabId==undefined||aTabId=="undefined"){
    alert("请传入合法的TAB编号！");
    return false;
  }
  if (aIdx==null||aIdx==undefined||aIdx=="undefined"||aIdx<0){
    alert("请传入合法的TabItem索引号！");
    return false;
  }

  var aTagType=getTabType(aTabId);
  var aItemEditable;
  var aTitleTable=document.getElementById(aTabId+"_secTable");
  if (aTagType.toUpperCase()==TAB_TYPE_H){
    if (!aTitleTable.rows[0].cells[aIdx]){
        alert("对象不存在,请检查索引号是否过大!");
        return  false;
    }
    aItemEditable=aTitleTable.rows[0].cells[aIdx].isDeletable;
  }else if (aTagType.toUpperCase()==TAB_TYPE_B){
    if (!aTitleTable.rows[0].cells[aIdx]){
        alert("对象不存在,请检查索引号是否过大!");
        return  false;
    }
    aItemEditable=aTitleTable.rows[0].cells[aIdx].isDeletable;
  }else{
    if (!aTitleTable.rows[aIdx]){
        alert("对象不存在,请检查索引号是否过大!");
        return  false;
    }
    aItemEditable=aTitleTable.rows[aIdx].cells[0].isDeletable;
  }
  if (aItemEditable==""){
    aItemEditable="false";
  }
  return aItemEditable;
}

/**根据TAB编号取TA类型
* aTabId TAB编号
* 返回：H or V
* */
function getTabType(aTabId){
  var aTagObj=document.getElementById(aTabId);
  return aTagObj.tagType;
}
/**设置TabItem的宽度
*	aTabId	TAB编号
*	aTabItemId  TabItem编号
**/
function setTabItemLen(aTabId,aTabItemId,aTabItemLen){
	
	var td_obj = document.getElementById(aTabId+"_Title_"+aTabItemId);
	if(td_obj==null||td_obj==undefined){
		alert("对不起，找不到对应的 tabItem,无法对其进行设置长度操作！");
		return false;
	}	
	td_obj.firstChild.rows[0].cells[0].style.width = aTabItemLen;
	td_obj.firstChild.rows[0].cells[0].firstChild.style.width = aTabItemLen;
	td_obj.firstChild.rows[0].cells[0].firstChild.firstChild.style.width = aTabItemLen;
}

//根据TAB编号和TABITEM编号设置Tab页的title
function setTabItemTitle(aTabId,aItemId,aTitle){
	var aTitleObj=document.getElementById(aTabId +"_Title_"+ aItemId);

	if(aTitleObj==null){
		alert('对不起，找不到对应的 tabItem,无法对其进行聚焦操作。');
		return false;
	}
	str = "<div id='item_title' nowrap align=center class='tab_title_style'><font size=1>&nbsp;</font>"+aTitle+"</div>";
	aTitleObj.firstChild.rows[0].cells[1].innerHTML = str;
}
//	根据TAB编号和TABITEM编号获取Tab页的title
function getTabItemTitle(aTabId,aItemId){
	var aTitleObj=document.getElementById(aTabId +"_Title_"+ aItemId);

	if(aTitleObj==null){
		alert('对不起，找不到对应的 tabItem,无法对其进行聚焦操作。');
		return false;
	}
	return aTitleObj.firstChild.rows[0].cells[0].innerText
}

function tabResizeTo(aTabId,width,height){
	var aMainObjId=aTabId+"_mainTable";
  	var aMainObj=document.getElementById(aMainObjId);
    
    var secTableID= aTabId+"_scrollDiv";
    var secTableObj=document.getElementById(secTableID);
  	if(width){
  		aMainObj.style.width = width;
        secTableObj.style.width = width;
    }
  	if(height){
  		for(i=0;i<aMainObj.rows.length;i++)
  		  aMainObj.rows[i].style.height = height;
  	}
  	updateScrollBarStatus(aTabId)
}

//TAB抬头向左滚动
function scrollDivLeft(aTabId,toEnd){
	if (aTabId==null||aTabId==undefined||aTabId=="undefined"){
		alert("请传入合法的TAB编号！");
		return false;
	}

	var scrollDiv=document.getElementById(aTabId +"_scrollDiv");
	if(scrollDiv==null){
		alert('对不起，找不到对应的 TAB,无法对其进行滚动操作。');
		return false;
	}

  if(toEnd != null && toEnd == true){
    scrollDiv.scrollLeft = 0;
  }
  else{
	  scrollDiv.scrollLeft = scrollDiv.scrollLeft - scrollDiv.srcollChangeValue;
	}

	controlBarTable=document.getElementById(aTabId +"_controlBarTable");
	controlBarTable.style.left = scrollDiv.scrollLeft+scrollDiv.clientWidth-45;
}

//TAB抬头向右滚动
function scrollDivRight(aTabId,toEnd){
	if (aTabId==null||aTabId==undefined||aTabId=="undefined"){
		alert("请传入合法的TAB编号！");
		return false;
	}

	var scrollDiv=document.getElementById(aTabId +"_scrollDiv");
	if(scrollDiv==null){
		alert('对不起，找不到对应的 TAB,无法对其进行滚动操作。');
		return false;
	}

  if(toEnd != null && toEnd == true){
   scrollDiv.scrollLeft = scrollDiv.scrollWidth - scrollDiv.clientWidth ;
  }
  else{
	  scrollDiv.scrollLeft = scrollDiv.srcollChangeValue -0+ scrollDiv.scrollLeft ;
	}

	controlBarTable=document.getElementById(aTabId +"_controlBarTable");
	controlBarTable.style.left = scrollDiv.scrollLeft+scrollDiv.clientWidth-45;
}

//设置滚动条每次修改的量
function setTabHeadScrollChangeValue(aTabId ,scrollChangeValue){
	if (aTabId==null||aTabId==undefined||aTabId=="undefined"){
		alert("请传入合法的TAB编号！");
		return false;
	}

	var scrollDiv=document.getElementById(aTabId +"_scrollDiv");
	if(scrollDiv==null){
		alert('对不起，找不到对应的 TAB,无法设置其滚动值。');
		return false;
	}
	if(typeof(scrollChangeValue)!='number'){
		alert('对不起，请为scrollChangeValue设置合法的数值。');
		return false;
	}
	if(scrollChangeValue<=0){
		alert('对不起，scrollChangeValue的值必须大于0。');
		return false;
	}
	scrollDiv.srcollChangeValue = scrollChangeValue;
}

//设置操作滚动条的样式,内部方法
function updateScrollBarStatus (aTabId,aTabWidth,aTabHeight){
  if(aTabId==null||aTabId==undefined||aTabId=="undefined"){
		alert("请传入合法的TAB编号！");
		return false;
	}
	var aTagType=getTabType(aTabId); 
	 
	if(aTagType=="v"||aTagType=="V") return;
	
  var outerDiv = document.all(aTabId);
  
  var parentClientWidth = getParentWidth(outerDiv);
  
  var scrollDiv=document.getElementById(aTabId +"_scrollDiv");
  var scrollDivWidth = scrollDiv.clientWidth;
  if(aTabWidth != null && aTabWidth.indexOf("%") > -1 ){
	    var percent = aTabWidth.replace("%","");
	    scrollDivWidth = parentClientWidth * parseInt(percent)/100 - 10;
	}else if(aTabWidth != null && aTabWidth != "") {
	   aTabWidth = aTabWidth.replace("px","");
	   scrollDivWidth = aTabWidth;
	}	

	if((scrollDivWidth+"").indexOf("px") > -1){
   	scrollDivWidth = parseInt(scrollDivWidth.replace("px",""));
	}
  
 	var secTableWidth = document.all(aTabId + "_secTable").scrollWidth;

	var controlBarTable= document.getElementById(aTabId +"_controlBarTable");
  
	if(secTableWidth > scrollDivWidth) {
	  controlBarTable.style.display = 'block';
	}else{
	  controlBarTable.style.display = 'none';
	}
	scrollDiv.style.width = scrollDivWidth;
  controlBarTable.style.left = scrollDiv.scrollLeft+scrollDiv.clientWidth-45;
  var frametab = document.getElementById(aTabId+"_mainTable");
	frametab.style.width=scrollDiv.offsetWidth;	

	//处理高度
	var parentClientHeight = getParentHeight(outerDiv);
  var realHeight  = frametab.style.height;
   if(aTabHeight != null && aTabHeight.indexOf("%") > -1 ){
	    var percent = aTabHeight.replace("%","");
	    realHeight = parentClientHeight * parseInt(percent)/100 - scrollDiv.scrollHeight - 10;
	}else if(aTabHeight != null && aTabHeight != "") {
	   aTabHeight = aTabHeight.replace("px","");
	   realHeight = aTabHeight - scrollDiv.scrollHeight - 10;
	}	
  
	if((realHeight+"").indexOf("px") > -1){
   	realHeight = parseInt(realHeight.replace("px",""));
	}
  frametab.style.height = realHeight;	
}

function getParentWidth(tmpObject){
  var tmpParentNode = tmpObject.parentNode;
  var parentClientWidth = tmpParentNode.width;
  while(tmpParentNode!=null && (parentClientWidth == null || parentClientWidth =="")){
     tmpParentNode = tmpParentNode.parentNode;
     if(tmpParentNode != null){ 
        parentClientWidth = tmpParentNode.width;
     }
  }
  if(parentClientWidth == null|| parentClientWidth =="" || parentClientWidth =="100%"){
    parentClientWidth  = document.body.clientWidth ;
  }
  if( (parentClientWidth + "").indexOf("%") >=0){
     var percent = parentClientWidth.replace("%","");
     var tmpWidth = getParentWidth(tmpParentNode);
     parentClientWidth = tmpWidth *  parseInt(percent)/100 ;
  }
  return parentClientWidth;
}

function getParentHeight(tmpObject){
  var tmpParentNode = tmpObject.parentNode;
  var parentClientHeight = tmpParentNode.height;
  while(tmpParentNode!=null && (parentClientHeight == null || parentClientHeight =="")){
     tmpParentNode = tmpParentNode.parentNode;
     if(tmpParentNode != null){ 
        parentClientHeight = tmpParentNode.height;
     }
  }
  if(parentClientHeight == null|| parentClientHeight =="" || parentClientHeight =="100%"){
    parentClientHeight  = document.body.clientHeight ;
  }
  if( (parentClientHeight + "").indexOf("%") >=0){
     var percent = parentClientHeight.replace("%","");
     var tmpHeight = getParentHeight(tmpParentNode);
     parentClientHeight = tmpHeight *  parseInt(percent)/100 ;
  }

  return parentClientHeight;
}

/****/
/* ls_demon
*/
//设置鼠标移入标签上的变化
function setMouseOverTabItem(aTabId,aOverTdObj){
  var aTagType=getTabType(aTabId);
  //查询该对象的index
  var aIdx;
  var aTitleTable=document.getElementById(aTabId+"_secTable");
  //横向TAB，根据当前选中的TD获取该TD在所处表格中的的INDEX
  if (aTagType.toUpperCase()==TAB_TYPE_H){
    var aTitleTr=aTitleTable.rows[0];
    for (var i=0;i<aTitleTr.cells.length;i++){
      if (aTitleTr.cells[i].uniqueID==aOverTdObj.uniqueID){
        aIdx=i;
        break;
      }
    }
  }else if(aTagType.toUpperCase()==TAB_TYPE_B){
  	var aTitleTr=aTitleTable.rows[0];
    for (var i=0;i<aTitleTr.cells.length;i++){
      if (aTitleTr.cells[i].uniqueID==aOverTdObj.uniqueID){
        aIdx=i;
        break;
      }
    }
  }else{
    for (var i=0;i<aTitleTable.rows.length;i++){
      if (aTitleTable.rows[i].cells[0].uniqueID==aOverTdObj.uniqueID){
        aIdx=i;
        break;
      }
    }
  }
  var ret=setOverTabItemByItemIdx(aTabId,aIdx);
  if (ret==false){
    return;
  }
}

/**
* 根据TAB编号和TABITEM索引设置鼠标在组件上的样式
* aTabId
* aIdx
*/
function setOverTabItemByItemIdx(aTabId,aIdx){
  if (aIdx==null||aIdx=="undefined"||aIdx<0){
    alert("请传入合法的TabItem索引号！");
    return;
  }
  
  var aTitleTable=document.getElementById(aTabId+"_secTable");
  var aTagType=getTabType(aTabId);
  var tmpFocusIdx = getCurrentTabFocusItem(aTabId);

  if (aTagType.toUpperCase()==TAB_TYPE_H){
  	if(aTitleTable.rows[0].cells.length-1<aIdx){
  		alert('对不起，指定的Idx超过tab页的范围,无法对其进行操作。');
	  	return false;
	 }
	if (tmpFocusIdx != aIdx) {
	
		aTitleTable.rows[0].cells[aIdx].firstChild.rows[0].cells[0].firstChild.className ="tab_h_title_style_hover";
	}
  }else if(aTagType.toUpperCase()==TAB_TYPE_B){
  	if(aTitleTable.rows[0].cells.length-1<aIdx){
  		alert('对不起，指定的Idx超过tab页的范围,无法对其进行操作。');
	  	return false;
	 }
	if (tmpFocusIdx != aIdx) {
		aTitleTable.rows[0].cells[aIdx].firstChild.rows[0].cells[0].firstChild.className ="tab_b_title_style_hover";
	}
  }else{
  	if(aTitleTable.rows.length-1<aIdx){
  		alert('对不起，指定的Idx超过tab页的范围,无法对其进行操作。');
	  	return false;
	 }
	if (tmpFocusIdx != aIdx) {
		aTitleTable.rows[aIdx].cells[0].firstChild.className ="tab_v_title_style_hover";
  	}
  }
}


//设置鼠标移出标签上的变化
function setMouseOutTabItem(aTabId,aOutTdObj){
  var aTagType=getTabType(aTabId);
  //查询该对象的index
  var aIdx;
  var aTitleTable=document.getElementById(aTabId+"_secTable");
  //横向TAB，根据当前选中的TD获取该TD在所处表格中的的INDEX
  if (aTagType.toUpperCase()==TAB_TYPE_H){
    var aTitleTr=aTitleTable.rows[0];
    for (var i=0;i<aTitleTr.cells.length;i++){
      if (aTitleTr.cells[i].uniqueID==aOutTdObj.uniqueID){
        aIdx=i;
        break;
      }
    }
  }else if(aTagType.toUpperCase()==TAB_TYPE_B){
  	var aTitleTr=aTitleTable.rows[0];
    for (var i=0;i<aTitleTr.cells.length;i++){
      if (aTitleTr.cells[i].uniqueID==aOutTdObj.uniqueID){
        aIdx=i;
        break;
      }
    }
  }else{
    for (var i=0;i<aTitleTable.rows.length;i++){
      if (aTitleTable.rows[i].cells[0].uniqueID==aOutTdObj.uniqueID){
        aIdx=i;
        break;
      }
    }
  }
  var ret=setOutTabItemByItemIdx(aTabId,aIdx);
  if (ret==false){
    return;
  }
}

/**
* 根据TAB编号和TABITEM索引设置鼠标在组件上的样式
* aTabId
* aIdx
*/
function setOutTabItemByItemIdx(aTabId,aIdx){
  if (aIdx==null||aIdx=="undefined"||aIdx<0){
    alert("请传入合法的TabItem索引号！");
    return;
  }
  
  var aTitleTable=document.getElementById(aTabId+"_secTable");
  var aTagType=getTabType(aTabId);
  var tmpFocusIdx = getCurrentTabFocusItem(aTabId);

  if (aTagType.toUpperCase()==TAB_TYPE_H){
  	if(aTitleTable.rows[0].cells.length-1<aIdx){
  		alert('对不起，指定的Idx超过tab页的范围,无法对其进行操作。');
	  	return false;
	 }
	if (tmpFocusIdx != aIdx) {
	
		aTitleTable.rows[0].cells[aIdx].firstChild.rows[0].cells[0].firstChild.className ="tab_h_title_style";
	}
  }else if(aTagType.toUpperCase()==TAB_TYPE_B){
  	if(aTitleTable.rows[0].cells.length-1<aIdx){
  		alert('对不起，指定的Idx超过tab页的范围,无法对其进行操作。');
	  	return false;
	 }
	if (tmpFocusIdx != aIdx) {
		aTitleTable.rows[0].cells[aIdx].firstChild.rows[0].cells[0].firstChild.className ="tab_b_title_style";
	}
  }else{
  	if(aTitleTable.rows.length-1<aIdx){
  		alert('对不起，指定的Idx超过tab页的范围,无法对其进行操作。');
	  	return false;
	 }
	if (tmpFocusIdx != aIdx) {
		aTitleTable.rows[aIdx].cells[0].firstChild.className ="tab_v_title_style";
  	}
  }
}

/**
* 鼠标移入TAB的关闭图标上的样式变化
*/
function setMouseOverCloseTabItem(aTabId,aCloseSpanObj,aOverTdId) {

  var aTagType=getTabType(aTabId);
  //查询该对象的index
  var aIndx;
  
  var aTitleTable=document.getElementById(aTabId+"_secTable");
  var aOverTdObj=document.getElementById(aTabId+aOverTdId);
  
  //横向TAB，根据当前选中的TD获取该TD在所处表格中的的INDEX
  if (aTagType.toUpperCase()==TAB_TYPE_H){
    var aTitleTr=aTitleTable.rows[0];
    for (var i=0;i<aTitleTr.cells.length;i++){
      if (aTitleTr.cells[i].uniqueID==aOverTdObj.uniqueID){
        aIndx=i;
        break;
      }
    }
  }else if(aTagType.toUpperCase()==TAB_TYPE_B){
  	var aTitleTr=aTitleTable.rows[0];
    for (var i=0;i<aTitleTr.cells.length;i++){
      if (aTitleTr.cells[i].uniqueID==aOverTdObj.uniqueID){
        aIndx=i;
        break;
      }
    }
  }else{
    for (var i=0;i<aTitleTable.rows.length;i++){
      if (aTitleTable.rows[i].cells[0].uniqueID==aOverTdObj.uniqueID){
        aIndx=i;
        break;
      }
    }
  }
  
  var tmpFocusIdx = getCurrentTabFocusItem(aTabId);

  if (tmpFocusIdx == aIndx) {
  	aCloseSpanObj.className="tab_item_close_button_hover";
  }
}

/**
* 鼠标移出TAB的关闭图标上的样式变化
*/
function setMouseOutCloseTabItem(aTabId,aCloseSpanObj,aOutTdId) {
  var aTagType=getTabType(aTabId);
  //查询该对象的index
  var aIndx;
  
  var aTitleTable=document.getElementById(aTabId+"_secTable");
  var aOutTdObj=document.getElementById(aTabId+aOutTdId);
  
  //横向TAB，根据当前选中的TD获取该TD在所处表格中的的INDEX
  if (aTagType.toUpperCase()==TAB_TYPE_H){
    var aTitleTr=aTitleTable.rows[0];
    for (var i=0;i<aTitleTr.cells.length;i++){
      if (aTitleTr.cells[i].uniqueID==aOutTdObj.uniqueID){
        aIndx=i;
        break;
      }
    }
  }else if(aTagType.toUpperCase()==TAB_TYPE_B){
  	var aTitleTr=aTitleTable.rows[0];
    for (var i=0;i<aTitleTr.cells.length;i++){
      if (aTitleTr.cells[i].uniqueID==aOutTdObj.uniqueID){
        aIndx=i;
        break;
      }
    }
  }else{
    for (var i=0;i<aTitleTable.rows.length;i++){
      if (aTitleTable.rows[i].cells[0].uniqueID==aOutTdObj.uniqueID){
        aIndx=i;
        break;
      }
    }
  }
  
  var tmpFocusIdx = getCurrentTabFocusItem(aTabId);

  if (tmpFocusIdx == aIndx) {
  	aCloseSpanObj.className="tab_item_close_button_current";
  }
}
/****/
//--------------add---------------
function tab_h_button_mouseoverl(toEnd)
{
 var obj = window.event.srcElement;
 if(obj.tagName!="DIV")return;
 else{
  if(toEnd != null && toEnd == true)
    obj.className="tab_h_scrollLeftEndButton_hover";
  else
    obj.className="tab_h_scrollLeftButton_hover";
 }
}
function tab_h_button_mouseoutl(toEnd)
{
 var obj = window.event.srcElement;
 if(obj.tagName!="DIV")return;
 else{
  if(toEnd != null && toEnd == true)
    obj.className="tab_h_scrollLeftEndButton";
  else 
    obj.className="tab_h_scrollLeftButton";
 }
}
function tab_h_button_mouseoverr(toEnd)
{
 var obj = window.event.srcElement;
 if(obj.tagName!="DIV")return;
 else{
  if(toEnd != null && toEnd == true)
    obj.className="tab_h_scrollRightEndButton_hover";
  else
    obj.className="tab_h_scrollRightButton_hover";
 }
}
function tab_h_button_mouseoutr(toEnd)
{
 var obj = window.event.srcElement;
 if(obj.tagName!="DIV")return;
 else{
   if(toEnd != null && toEnd == true)
     obj.className="tab_h_scrollRightEndButton";
   else 
     obj.className="tab_h_scrollRightButton";
 }
}

function tab_b_button_mouseoverl(toEnd)
{
 var obj = window.event.srcElement;
 if(obj.tagName!="DIV")return;
 else{
  if(toEnd != null && toEnd == true)
    obj.className="tab_b_scrollLeftEndButton_hover";
  else
    obj.className="tab_b_scrollLeftButton_hover";
 }
}
function tab_b_button_mouseoutl(toEnd)
{
 var obj = window.event.srcElement;
 if(obj.tagName!="DIV")return;
 else{
  if(toEnd != null && toEnd == true)
    obj.className="tab_b_scrollLeftEndButton";
  else
    obj.className="tab_b_scrollLeftButton";
 }
}
function tab_b_button_mouseoverr(toEnd)
{
 var obj = window.event.srcElement;
 if(obj.tagName!="DIV")return;
 else{
  if(toEnd != null && toEnd == true)
    obj.className="tab_b_scrollRightEndButton_hover";
  else
    obj.className="tab_b_scrollRightButton_hover";
 }
}
function tab_b_button_mouseoutr(toEnd)
{
 var obj = window.event.srcElement;
 if(obj.tagName=="DIV"){
	if(toEnd != null && toEnd == true)
    obj.className="tab_b_scrollRightEndButton";
  else
    obj.className="tab_b_scrollRightButton";
 }
}

function removeChild(parentNode){

  for(var m=0;m<parentNode.childNodes.length;m++){
	  if(parentNode.childNodes[m].childNodes.length>0){
		  removeChild(parentNode.childNodes[m]);
	  }
	  else{
		  if(parentNode.childNodes[m].innerHTML){
		       //alert(parentNode.childNodes[m].innerHTML);
			   //parentNode.childNodes[m].innerHTML="";
		  }
		  parentNode.removeChild(parentNode.childNodes[m]);
		  
	  }
  }
}
