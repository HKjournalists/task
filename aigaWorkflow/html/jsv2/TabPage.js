/**
* AiTabPageǰ̨ģ��
* ���ܣ�ʵ��TAB����ʾ������ɾ��ˢ�µȷ�����
* ���ߣ������� ���ż��Źɷ����޹�˾ �Ͼ��з�����J2EE Platform��
* ʱ�䣺2006.2.14
* �����ṩ�ĺ�����
* 1.	getCurrentTabFocusItem(aTabId) 			ȡ��ǰ�۽���TABItem��������,û�о۽�����-1
* 2.	getTabItemIdxsByTabItemId(aTabId,aItemId)	����aItemId��ø�aItemId��Ӧ��TAB index������
* 3.	setTabItem(aTabId,aItemId)			����TAB��ź�TABITEM�������Tab��ǰҳ
* 4.	setTabItemByItemIdx(aTabId,aIdx)		����TAB��ź�TABITEM��������Tab��ǰҳ
* 5.	refreshTabItem(aTabId,aTabItemId,aTitle,aUrl)	����TabItem������ˢ��
* 6.	refreshTabItemByIdx(aTabId,aIdx,aTitle,aUrl)	����TabItem��������ˢ��
* 7.	openNewTabItem(aTabId,aTabItemId,aTitle,aUrl,aIsDeletable,aIdx)	����Tabҳ
* 8.	closeTabItem(aTabId,aTabItemId)			����ItemId���ɾ��TABҳ
* 9.	closeTabItemByIdx(aTabId,aIdx)			����Item������ɾ��TABҳ
* 10.	setTabItemDeletable(aTabId,aItemId,aEditable)	����Item�������ö�ӦItem���Ƿ��ɾ������
* 11.	setTabItemDeletableByIdx(aTabId,aIdx,aEditable)	����Item�������ö�ӦItem���Ƿ��ɾ������
* 12.	getTabItemDeletable(aTabId,aItemId)		����Item����ȡ��ӦItem���Ƿ��ɾ������
* 13.	getTabItemDeletableByIdx(aTabId,aIdx)		����Item������ȡ��ӦItem���Ƿ��ɾ������
* 14.	getTabType(aTabId)				����TAB���ȡTA����
* 15.	setTabItemLen(aTabId,aTabItemId,aTabItemLen)	����TabItem�Ŀ��
*
*		================add by hexg 2006-6-28
* 16.	setTabItemTitle(aTabId,aItemId,title)	����TAB��ź�TABITEM�������Tabҳ��title
* 17.	getTabItemTitle(aTabId,aItemId)	����TAB��ź�TABITEM��Ż�ȡTabҳ��title
* 18.   tabResizeTo(aTabId,width,height);
* 19.   setTabHeadScrollChangeValue(aTabId ,scrollChangeValue)
* */

var TAB_TYPE_H="H";
var TAB_TYPE_V="V";
var TAB_TYPE_B="B";
//ȡ��ǰ�۽���TABItem
//û�о۽�����-1
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
* ����aItemId��ø�aItemId��Ӧ��TAB index������
* aTabId TAB���
* aItemId TABITEM���
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
  ����TAB��ź�TABITEM�������Tab��ǰҳ
  aTabId��TAB���
  aItemId:TABITEM���
*/
function setTabItem(aTabId,aItemId){
  var aItemTitleObj=document.getElementById(aTabId +"_Title_"+ aItemId);
  var aItemBodyObj=document.getElementById(aTabId +"_TableBody_"+ aItemId);
  var aFrameObj=document.getElementById(aTabId + "_" + aItemId);
  var aItemFocusObj = document.getElementById(aTabId + "_Focus_" + aItemId);

  if(aItemBodyObj==null){
  	alert('�Բ����Ҳ�����Ӧ�� tabItem,�޷�������о۽�������');
  	return false;
  }

  var ret=setTabItem_common(aTabId,aItemTitleObj,aItemBodyObj,aFrameObj,aItemFocusObj);
  if (ret==false){
    return;
  }
  //����aItemId��ø�aItemId��Ӧ��TAB index������
  //��¼��ǰ����TAB��index
  var aAry=getTabItemIdxsByTabItemId(aTabId,aItemId);
  if (aAry.length>=0){
    setCurrentTabFocusItem(aTabId,aAry[0]);
  }
}


/**
*  ���TABItemʱ������TAB��ź͵�ǰ����Ķ�������Tab��ǰҳ
*  �ڲ��������������ṩ��
*  aTabId��TAB���
*  aClickedTdObj:��ǰ����Ķ���
*  ��tab_h.vm��tab_v.vm�к�����Tabʱ�����˸÷��������Tabҳʱ����
*/
function setClickedTabItem(aTabId,aClickedTdObj){
  var aTagType=getTabType(aTabId);
 //��ѯ�ö����index
  var aIdx;
  var aTitleTable=document.getElementById(aTabId+"_secTable");
  //����TAB�����ݵ�ǰѡ�е�TD��ȡ��TD����������еĵ�INDEX
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
*  ����TAB��ź�TABITEM��������Tab��ǰҳ
*  tabId��
*  aIdx:
*/
function setTabItemByItemIdx(aTabId,aIdx){
  if (aIdx==null||aIdx=="undefined"||aIdx<0){
    alert("�봫��Ϸ���TabItem�����ţ�");
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
  		alert('�Բ���ָ����Idx����tabҳ�ķ�Χ,�޷�������о۽�������');
	  	return false;
	 }
    aItemTitleObj=aTitleTable.rows[0].cells[aIdx];
    aItemFocusObj = aTitleTable.rows[0].cells[aIdx].firstChild;
    aItemFocusObj = aTitleTable.rows[0].cells[aIdx].firstChild.rows[0].cells[0].firstChild;

  }else if(aTagType.toUpperCase()==TAB_TYPE_B){
  	if(aTitleTable.rows[0].cells.length-1<aIdx){
  		alert('�Բ���ָ����Idx����tabҳ�ķ�Χ,�޷�������о۽�������');
	  	return false;
	 }
    aItemTitleObj=aTitleTable.rows[0].cells[aIdx];
    aItemFocusObj = aTitleTable.rows[0].cells[aIdx].firstChild;
    aItemFocusObj = aTitleTable.rows[0].cells[aIdx].firstChild.rows[0].cells[0].firstChild;
  }else{
  	if(aTitleTable.rows.length-1<aIdx){
  		alert('�Բ���ָ����Idx����tabҳ�ķ�Χ,�޷�������о۽�������');
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
  //��¼��ǰ����TAB��index
  setCurrentTabFocusItem(aTabId,aIdx);
}

/**
* �ڲ�������ǰ��������Tab�۽�����ʹ�ã��������ṩ��
*  ����Tab��ǰҳ
*  tabId��TAB���
*  aItemTitleObj: �������ڵ�td����
*  aItemBodyObj:  ���Ķ���
*  aFrameObj��    iframe����
*/
function setTabItem_common(tabId,aItemTitleObj,aItemBodyObj,aFrameObj,aItemFocusObj){
  var tmpFocusIdx = getCurrentTabFocusItem(tabId);
  var headTable = document.getElementById(tabId + "_secTable");
  //beforeSetTab
  //SetTabItem֮ǰ�Ļص����� dd
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
      alert("ִ��beforeSetTab����"+ex.message+"������ִ��SetTabItem֮��");
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
    //ȡ��itemId
    var itemId=aItemTitleObj.id.split("_Title_")[1];
     var p = "";
     try{
       eval("p=" + getparameterfunction +"('" + itemId + "');");
     }catch(ex){
       alert("ȡ������������ʧ�ܣ����麯��"+getparameterfunction+"�Ƿ���ڡ�");
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
  //���url��ͬ��ˢ�¡��������������ͬ����ˢ�¡�
  if(aFrameObj.src != src ){
      aFrameObj.src = src;
  }
  //SetTabItem֮��Ļص�����
  if (afterSetTab&&afterSetTab!=""){
    try{
     eval(afterSetTab+"('"+aOldItemTitle+"','"+aNewItemTitle+"')");
    }catch(ex){
      alert("ִ��afterSetTab����"+ex.message+"������ִ��SetTabItem֮��");
      return;
    }
  }
}

/**
* ����TabItem������ˢ��
* aTabId Tab����
* aTabItemId   TabItem������
* aTitle ���⣬����Ҫ�ı����ʱ����null
* aUrl   Url������Ҫ�ı�Urlʱ����null
* */
function refreshTabItem(aTabId,aTabItemId,aTitle,aUrl){
  var aAry=getTabItemIdxsByTabItemId(aTabId,aTabItemId);
  for (var i=0;i<aAry.length;i++){
    refreshTabItemByIdx(aTabId,aAry[i],aTitle,aUrl);
  }
}

/**
* ����TabItem��������ˢ��
* aTabId Tab����
* aIdx   TabItem��������
* aTitle ���⣬����Ҫ�ı����ʱ����null
* aUrl   Url������Ҫ�ı�Urlʱ����null
* */
function refreshTabItemByIdx(aTabId,aIdx,aTitle,aUrl){
  if (aIdx==null||aIdx=="undefined"||aIdx==undefined||aIdx<0){
    alert("�봫��Ϸ���TabItem�����ţ�");
    return;
  }
  //�������͵�ǰ���ⲻͬ����ˢ�±���
  //ȡ�������ͱ���
  var aTagType=getTabType(aTabId);
  if (aTitle){
    var aHeadTable=document.getElementById(aTabId+"_secTable");
    var aHeadTdObj;
    if (aTagType.toUpperCase()==TAB_TYPE_H){
      if (aHeadTable.rows[0].cells[aIdx]){
        aHeadTdObj=aHeadTable.rows[0].cells[aIdx];
        //20060807
		//���ñ���
		if(aTitle!=null){
			//str = "<div id='item_title' nowrap align=center class='tab_title_style'><font size=1>&nbsp;</font>"+aTitle+"</div>";
			aHeadTdObj.firstChild.rows[0].cells[0].firstChild.firstChild.firstChild.rows[0].cells[0].innerHTML = aTitle;
		}
      }else{
        alert("aHeadTdObj���󲻴���,�����������Ƿ����!");
        return;
      }
    }else if(aTagType.toUpperCase()==TAB_TYPE_B){
    	if (aHeadTable.rows[0].cells[aIdx]){
        aHeadTdObj=aHeadTable.rows[0].cells[aIdx];
        //20060807
		//���ñ���
		if(aTitle!=null){
			str = "<div id='item_title' nowrap align=center class='tab_title_style'><font size=1>&nbsp;</font>"+aTitle+"</div>";
			aHeadTdObj.firstChild.rows[0].cells[0].firstChild.firstChild.firstChild.rows[0].cells[0].innerHTML = aTitle;
		}
      }else{
        alert("aHeadTdObj���󲻴���,�����������Ƿ����!");
        return;
      }
    }else{
      if (aHeadTable.rows[aIdx]){
        aHeadTdObj=aHeadTable.rows[aIdx].cells[0];
         //20060807
		//���ñ���
		if(aTitle!=null){
			str = "<div id='item_title' nowrap align=center class='tab_title_style'><font size=1>&nbsp;</font>"+aTitle+"</div>";
			aHeadTdObj.firstChild.rows[0].cells[1].innerHTML = str;
		}
      }else{
        alert("aHeadTdObj���󲻴���,�����������Ƿ����!");
        return;
      }
    }
   
  }
  //���url��ͬ����ˢ��url
  //ȡ���Ķ����url
  if (aUrl){
    var aMainObjId=aTabId+"_mainTable";
    var aMainObj=document.getElementById(aMainObjId);
    aItemBodyObj=aMainObj.tBodies[aIdx];
    if (!aItemBodyObj){
      alert("���Ķ���aMainObj.tBodies������,�����������Ƿ����");
      return;
    }
    aFrameObj=aItemBodyObj.rows[0].cells[0].firstChild;
    aFrameObj.destsrc=aUrl;
    aFrameObj.src = aUrl;
  }

  updateScrollBarStatus(aTabId)
}

/**
* ����Tabҳ
* aTabId TAB���
* aTabItemId TabItem���
* aTitle ����
* aUrl   URL
* aIsDeletable �Ƿ�ɱ�ɾ��
* aIdx    �����ڸ������ŵ�TABҳ֮ǰ��
* */
function openNewTabItem(aTabId,aTabItemId,aTitle,aUrl,aIsDeletable,aIdx){
  //���ӱ���͹ر�ͼƬ��ť����Ӧ�Ĺر��¼�
  //�����ļ�������Ǻ������AddTabHeader_H.vm�ж�ȡ
  //��ѯҪ�����Ŀ�����
  var aNewItemHeadObj;
  var aItemHeadTargetObj=null;
  //ȡaTabType
  var aTagType=getTabType(aTabId);
  var aNewIdx=0;
  var aTotalNo=0;
  var aHeadTable=document.getElementById(aTabId+"_secTable");
  if (aTagType.toUpperCase()==TAB_TYPE_H){
    aNewItemHeadObj=getNewHItemHead(aTabId,aTabItemId,aTitle,aIsDeletable,'h');
    //����Ǻ���ģ�����Ҫ����id="${tag.getId()}_secTable"��TABLE�ĵ�һ��TR���ڸ�TR������һ��TD
    aTabHeadTargetObj=aHeadTable.rows[0];
    aTotalNo=aHeadTable.rows[0].cells.length;
    //�����Ϊ���һ������ֱ��׷�������һ������֮��
    if (aIdx==null||aIdx=="undefined"||aIdx>=aTotalNo){
      aNewIdx=aTotalNo;
      aTabHeadTargetObj.appendChild(aNewItemHeadObj);
    }else{
      //�������Ŀ�����֮ǰ��
      var aAfterObj=aHeadTable.rows[0].cells[aIdx];
      aTabHeadTargetObj.insertBefore(aNewItemHeadObj,aAfterObj);
      aNewIdx=aIdx;
    }
  }else if(aTagType.toUpperCase()==TAB_TYPE_B){
  	aNewItemHeadObj=getNewHItemHead(aTabId,aTabItemId,aTitle,aIsDeletable,'b');
    //����Ǻ���ģ�����Ҫ����id="${tag.getId()}_secTable"��TABLE�ĵ�һ��TR���ڸ�TR������һ��TD
    aTabHeadTargetObj=aHeadTable.rows[0];
    aTotalNo=aHeadTable.rows[0].cells.length;
    //�����Ϊ���һ������ֱ��׷�������һ������֮��
    if (aIdx==null||aIdx=="undefined"||aIdx>=aTotalNo){
      aNewIdx=aTotalNo;
      aTabHeadTargetObj.appendChild(aNewItemHeadObj);
    }else{
      //�������Ŀ�����֮ǰ��
      var aAfterObj=aHeadTable.rows[0].cells[aIdx];
      aTabHeadTargetObj.insertBefore(aNewItemHeadObj,aAfterObj);
      aNewIdx=aIdx;
    }
  }else{
    aNewItemHeadObj=getNewVItemHead(aTabId,aTabItemId,aTitle,aIsDeletable);
    //���������ģ������id="${tag.getId()}_secTable"��TABLE�����TABLE������һ��
    aTabHeadTargetObj=aHeadTable.tBodies[0];
    aTotalNo=aHeadTable.rows.length;
    //�����Ϊ���һ������ֱ��׷�������һ������֮��
    if (aIdx==null||aIdx=="undefined"||aIdx>=aTotalNo){
      aNewIdx=aTotalNo;
      aTabHeadTargetObj.appendChild(aNewItemHeadObj);
    }else{
      //�������Ŀ�����֮ǰ��
      var aAfterObj=aHeadTable.rows[aIdx];
      aTabHeadTargetObj.insertBefore(aNewItemHeadObj,aAfterObj);
      aNewIdx=aIdx;
    }
  }

  //����TAB��������
  var aMainObjId=aTabId+"_mainTable";
  var aMainObj=document.getElementById(aMainObjId);
  //����aTabIdȡ�������ݵĸ߶ȣ�
  var aHeight=aMainObj.tBodies[0].rows[0].height;
  var aNewMainObj=getNewItemMain(aTabId,aTabItemId,aUrl,aHeight);
  //�����Ϊ���һ������ֱ��׷�������һ������֮��
  if (aIdx==null||aIdx=="undefined"||aIdx>=aTotalNo){
    aNewIdx=aTotalNo;
    aMainObj.appendChild(aNewMainObj);
  }else{
    //�������Ŀ�����֮ǰ��
    var aAfterObj=aMainObj.tBodies[aIdx];
    aMainObj.insertBefore(aNewMainObj,aAfterObj);
    aNewIdx=aIdx;
  }
  //����setTabItem������������TABҳ��Ϊ��ǰҳ
  setTabItemByItemIdx(aTabId,aNewIdx);
  updateScrollBarStatus(aTabId);
  
}

//ȡ����������TabItem������
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

//ȡ����������TabItem������
function getNewVItemHead(aTabId,aTabItemId,aTitle,aIsDeletable){
  var aTrStr="<tr align=right></tr>";
  var aTr=document.createElement(aTrStr);
  var aTd=getCommonItemHead(aTabId,aTabItemId,aTitle,aIsDeletable,"tab_v_not_focus");
  aTr.appendChild(aTd);
  return aTr;
}

/**��������TabItem������TabItem�Ĺ�ͬ���ݣ����Ը��ã������޸�
* ע�⣺�޸�vmģ���ļ�ʱ������Ҫ�޸Ĵ˷�����
* �ڲ��������������ṩ��
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

/*��������TabItem������TabItem����������
* �ڲ��������������ṩ��
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

/**����ItemId���ɾ��TABҳ
* aTabId TAB���
* aTabItemId ItemId���
* */
function closeTabItem(aTabId,aTabItemId){
  //����aTabItemIdȡ������
  var aAry=getTabItemIdxsByTabItemId(aTabId,aTabItemId);
  if (aAry!=null&&aAry.length>0){
    for (var i=0;i<aAry.length;i++){
      //����Item������ɾ��
      closeTabItemByIdx(aTabId,aAry[i])
    }
  }else{
    alert("�����Tabҳ"+aTabId+"_"+aTabItemId+"�Ƿ���ڣ�");
    return "false";
  }
}

/**����Item������ɾ��
* aTabId TAB���
* aIdx Item������
* */
function closeTabItemByIdx(aTabId,aIdx){
  if (aIdx==null||aIdx=="undefined"||aIdx<0){
    alert("�봫��Ϸ���TabItem�����ţ�");
    return;
  }

  //ȡ��ǰ״̬���ж��Ƿ��ɾ��
  var aCurState=getTabItemDeletableByIdx(aTabId,aIdx);

  if (aCurState==false || aCurState=="false"){
    return false;
  }

  //����Item������ȡ��aCloseSpanObj����
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

/**����رհ�ťʱɾ��һ��TABҳ
* �ڲ��������������ṩ��
* ��tab_h.vm��tab_v.vm�к�����Tabʱ�����˸÷���������رհ�ťʱ����
* aTabId TAB���
* aCloseSpanObj �رհ�ť����
* */
function closeClickedTabItem(aTabId,aCloseSpanObj){
  if (!aTabId){
    alert("δ�ҵ�Tab��ʶ��");
    return;
  }
  //��������
  //���ֻ�����һ��������ɾ����
  var aMainObjId=aTabId+"_mainTable";
  var aMainObj=document.getElementById(aMainObjId);
  if (aMainObj.tBodies.length==1){
    alert("���һ��TABҳ������ɾ����");
    return;
  }
  var aTagObj=document.getElementById(aTabId);
  var aTagType=getTabType(aTabId);
  var aItemHeadObj;
  var aIdx=-1;
  //��ѯ�ö����index
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
    //����TAB��Ҫɾ��td��tr
    aItemHeadObj=aCloseSpanObj.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;
    for (var i=0;i<aTitleTable.rows.length;i++){
      if (aTitleTable.rows[i].uniqueID==aItemHeadObj.uniqueID){
        aIdx=i;
        break;
      }
    }

  }
  //ɾ������͹ر�ͼƬ��ť����
 //aItemHeadObj.removeNode(true);
  aItemHeadObj.parentNode.removeChild(aItemHeadObj);
  aItemHeadObj.innerHTML="";
  aItemHeadObj =null;

  //ɾ��TAB��������
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

  //���ɾ����TABҳ�ǵ�ǰ����TABҳ����
  //����ɾ��TABҳ��ǰһ��TABҳΪ��ǰ����TABҳ
  //���ɾ����TABҳ�ڵ�ǰ����TABҳ�����棬��ǰ��ǰ����TABҳcurrentTabFocusIdx��Ҫ��1
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

/**����Item�������ö�ӦItem���Ƿ��ɾ������
* aTabId TAB���
* aItemId TabItem���
* aEditable �Ƿ��ɾ��
* */
function setTabItemDeletable(aTabId,aItemId,aEditable){
  if (aEditable!="true"&&aEditable!="false"){
    alert("aEditable�������󣬱���Ϊ��true/false");
    return "false";
  }
  if((aTabId==null||aTabId==undefined||aTabId=="undefined")
  ||(aItemId==null||aItemId==undefined||aItemId=="undefined")){
    alert("������Tab��ź�TabItem��ţ�");
    return "false";
  }
  if (aTabId==null||aTabId==undefined||aTabId=="undefined"){
    alert("�봫��Ϸ���TAB��ţ�");
    return "false";
  }
  if (aItemId==null||aItemId==undefined||aItemId=="undefined"){
    alert("�봫��Ϸ���TabItem��ţ�");
    return "false";
  }
  var aAry=getTabItemIdxsByTabItemId(aTabId,aItemId);
  if (aAry!=null&&aAry.length>0){
    for (var i=0;i<aAry.length;i++){
      setTabItemDeletableByIdx(aTabId,aAry[i],aEditable);
    }
  }else{
    alert("�����Tabҳ"+aTabId+"_"+aItemId+"�Ƿ���ڣ�");
    return "false";
  }

}

/**����Item�������ö�ӦItem���Ƿ��ɾ������
* aTabId TAB���
* aIdx TabItem��������
* aEditable �Ƿ��ɾ��
* */
function setTabItemDeletableByIdx(aTabId,aIdx,aEditable){
  if (aEditable!="true"&&aEditable!="false"){
    alert("aEditable�������󣬱���Ϊ��true/false");
    return "false";
  }
  if((aTabId==null||aTabId==undefined||aTabId=="undefined")
  ||(aIdx==null||aIdx==undefined||aIdx=="undefined")){
    alert("������Tab��ź�������,���߼���Tabҳ�Ƿ���ڣ�");
    return "false";
  }

  if (aTabId==null||aTabId==undefined||aTabId=="undefined"){
    alert("�봫��Ϸ���TAB��ţ�");
    return "false";
  }
  if (aIdx==null||aIdx==undefined||aIdx=="undefined"||aIdx<0){
    alert("�봫��Ϸ���TabItem�����ţ�");
    return "false";
  }
  //�ж϶����״̬�Ƿ��Ѿ���Ҫ���õ�״̬,���߷���false
  var aCurState=getTabItemDeletableByIdx(aTabId,aIdx);
  if (aEditable==aCurState||aCurState==false){
    return "false";
  }

  var aTagType=getTabType(aTabId);
  var aTitleTable=document.getElementById(aTabId+"_secTable");
  //���ӻ�ɾ��ͼƬ��ť,�����ö����ֵ
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

/**����Item����ȡ��ӦItem���Ƿ��ɾ������
* aTabId TAB���
* aItemId TabItem���
* */
function getTabItemDeletable(aTabId,aItemId){
  if((aTabId==null||aTabId==undefined||aTabId=="undefined")
  ||(aItemId==null||aItemId==undefined||aItemId=="undefined")){
    alert("������Tab��ź�TabItem��ţ�");
    return "false";
  }
  if (aTabId==null||aTabId==undefined||aTabId=="undefined"){
    alert("�봫��Ϸ���TAB��ţ�");
    return "false";
  }
  if (aItemId==null||aItemId==undefined||aItemId=="undefined"){
    alert("�봫��Ϸ���TabItem��ţ�");
    return "false";
  }
  var aAry=getTabItemIdxsByTabItemId(aTabId,aItemId);
  //ֻȡ��һ�����������
  if (aAry.length>=0){
    return getTabItemDeletableByIdx(aTabId,aAry[0]);
  }else{
    alert("δ�ҵ�aItemId��");
    return "false";
  }
}

/**����Item������ȡ��ӦItem���Ƿ��ɾ������
* aTabId TAB���
* aIdx TabItem������
* */
function getTabItemDeletableByIdx(aTabId,aIdx){
  if((aTabId==null||aTabId==undefined||aTabId=="undefined")
  ||(aIdx==null||aIdx==undefined||aIdx=="undefined")){
    alert("������Tab��ź�������,���߼���Tabҳ�Ƿ���ڣ�");
    return false;
  }

  if (aTabId==null||aTabId==undefined||aTabId=="undefined"){
    alert("�봫��Ϸ���TAB��ţ�");
    return false;
  }
  if (aIdx==null||aIdx==undefined||aIdx=="undefined"||aIdx<0){
    alert("�봫��Ϸ���TabItem�����ţ�");
    return false;
  }

  var aTagType=getTabType(aTabId);
  var aItemEditable;
  var aTitleTable=document.getElementById(aTabId+"_secTable");
  if (aTagType.toUpperCase()==TAB_TYPE_H){
    if (!aTitleTable.rows[0].cells[aIdx]){
        alert("���󲻴���,�����������Ƿ����!");
        return  false;
    }
    aItemEditable=aTitleTable.rows[0].cells[aIdx].isDeletable;
  }else if (aTagType.toUpperCase()==TAB_TYPE_B){
    if (!aTitleTable.rows[0].cells[aIdx]){
        alert("���󲻴���,�����������Ƿ����!");
        return  false;
    }
    aItemEditable=aTitleTable.rows[0].cells[aIdx].isDeletable;
  }else{
    if (!aTitleTable.rows[aIdx]){
        alert("���󲻴���,�����������Ƿ����!");
        return  false;
    }
    aItemEditable=aTitleTable.rows[aIdx].cells[0].isDeletable;
  }
  if (aItemEditable==""){
    aItemEditable="false";
  }
  return aItemEditable;
}

/**����TAB���ȡTA����
* aTabId TAB���
* ���أ�H or V
* */
function getTabType(aTabId){
  var aTagObj=document.getElementById(aTabId);
  return aTagObj.tagType;
}
/**����TabItem�Ŀ��
*	aTabId	TAB���
*	aTabItemId  TabItem���
**/
function setTabItemLen(aTabId,aTabItemId,aTabItemLen){
	
	var td_obj = document.getElementById(aTabId+"_Title_"+aTabItemId);
	if(td_obj==null||td_obj==undefined){
		alert("�Բ����Ҳ�����Ӧ�� tabItem,�޷�����������ó��Ȳ�����");
		return false;
	}	
	td_obj.firstChild.rows[0].cells[0].style.width = aTabItemLen;
	td_obj.firstChild.rows[0].cells[0].firstChild.style.width = aTabItemLen;
	td_obj.firstChild.rows[0].cells[0].firstChild.firstChild.style.width = aTabItemLen;
}

//����TAB��ź�TABITEM�������Tabҳ��title
function setTabItemTitle(aTabId,aItemId,aTitle){
	var aTitleObj=document.getElementById(aTabId +"_Title_"+ aItemId);

	if(aTitleObj==null){
		alert('�Բ����Ҳ�����Ӧ�� tabItem,�޷�������о۽�������');
		return false;
	}
	str = "<div id='item_title' nowrap align=center class='tab_title_style'><font size=1>&nbsp;</font>"+aTitle+"</div>";
	aTitleObj.firstChild.rows[0].cells[1].innerHTML = str;
}
//	����TAB��ź�TABITEM��Ż�ȡTabҳ��title
function getTabItemTitle(aTabId,aItemId){
	var aTitleObj=document.getElementById(aTabId +"_Title_"+ aItemId);

	if(aTitleObj==null){
		alert('�Բ����Ҳ�����Ӧ�� tabItem,�޷�������о۽�������');
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

//TAB̧ͷ�������
function scrollDivLeft(aTabId,toEnd){
	if (aTabId==null||aTabId==undefined||aTabId=="undefined"){
		alert("�봫��Ϸ���TAB��ţ�");
		return false;
	}

	var scrollDiv=document.getElementById(aTabId +"_scrollDiv");
	if(scrollDiv==null){
		alert('�Բ����Ҳ�����Ӧ�� TAB,�޷�������й���������');
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

//TAB̧ͷ���ҹ���
function scrollDivRight(aTabId,toEnd){
	if (aTabId==null||aTabId==undefined||aTabId=="undefined"){
		alert("�봫��Ϸ���TAB��ţ�");
		return false;
	}

	var scrollDiv=document.getElementById(aTabId +"_scrollDiv");
	if(scrollDiv==null){
		alert('�Բ����Ҳ�����Ӧ�� TAB,�޷�������й���������');
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

//���ù�����ÿ���޸ĵ���
function setTabHeadScrollChangeValue(aTabId ,scrollChangeValue){
	if (aTabId==null||aTabId==undefined||aTabId=="undefined"){
		alert("�봫��Ϸ���TAB��ţ�");
		return false;
	}

	var scrollDiv=document.getElementById(aTabId +"_scrollDiv");
	if(scrollDiv==null){
		alert('�Բ����Ҳ�����Ӧ�� TAB,�޷����������ֵ��');
		return false;
	}
	if(typeof(scrollChangeValue)!='number'){
		alert('�Բ�����ΪscrollChangeValue���úϷ�����ֵ��');
		return false;
	}
	if(scrollChangeValue<=0){
		alert('�Բ���scrollChangeValue��ֵ�������0��');
		return false;
	}
	scrollDiv.srcollChangeValue = scrollChangeValue;
}

//���ò�������������ʽ,�ڲ�����
function updateScrollBarStatus (aTabId,aTabWidth,aTabHeight){
  if(aTabId==null||aTabId==undefined||aTabId=="undefined"){
		alert("�봫��Ϸ���TAB��ţ�");
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

	//����߶�
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
//������������ǩ�ϵı仯
function setMouseOverTabItem(aTabId,aOverTdObj){
  var aTagType=getTabType(aTabId);
  //��ѯ�ö����index
  var aIdx;
  var aTitleTable=document.getElementById(aTabId+"_secTable");
  //����TAB�����ݵ�ǰѡ�е�TD��ȡ��TD����������еĵ�INDEX
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
* ����TAB��ź�TABITEM�����������������ϵ���ʽ
* aTabId
* aIdx
*/
function setOverTabItemByItemIdx(aTabId,aIdx){
  if (aIdx==null||aIdx=="undefined"||aIdx<0){
    alert("�봫��Ϸ���TabItem�����ţ�");
    return;
  }
  
  var aTitleTable=document.getElementById(aTabId+"_secTable");
  var aTagType=getTabType(aTabId);
  var tmpFocusIdx = getCurrentTabFocusItem(aTabId);

  if (aTagType.toUpperCase()==TAB_TYPE_H){
  	if(aTitleTable.rows[0].cells.length-1<aIdx){
  		alert('�Բ���ָ����Idx����tabҳ�ķ�Χ,�޷�������в�����');
	  	return false;
	 }
	if (tmpFocusIdx != aIdx) {
	
		aTitleTable.rows[0].cells[aIdx].firstChild.rows[0].cells[0].firstChild.className ="tab_h_title_style_hover";
	}
  }else if(aTagType.toUpperCase()==TAB_TYPE_B){
  	if(aTitleTable.rows[0].cells.length-1<aIdx){
  		alert('�Բ���ָ����Idx����tabҳ�ķ�Χ,�޷�������в�����');
	  	return false;
	 }
	if (tmpFocusIdx != aIdx) {
		aTitleTable.rows[0].cells[aIdx].firstChild.rows[0].cells[0].firstChild.className ="tab_b_title_style_hover";
	}
  }else{
  	if(aTitleTable.rows.length-1<aIdx){
  		alert('�Բ���ָ����Idx����tabҳ�ķ�Χ,�޷�������в�����');
	  	return false;
	 }
	if (tmpFocusIdx != aIdx) {
		aTitleTable.rows[aIdx].cells[0].firstChild.className ="tab_v_title_style_hover";
  	}
  }
}


//��������Ƴ���ǩ�ϵı仯
function setMouseOutTabItem(aTabId,aOutTdObj){
  var aTagType=getTabType(aTabId);
  //��ѯ�ö����index
  var aIdx;
  var aTitleTable=document.getElementById(aTabId+"_secTable");
  //����TAB�����ݵ�ǰѡ�е�TD��ȡ��TD����������еĵ�INDEX
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
* ����TAB��ź�TABITEM�����������������ϵ���ʽ
* aTabId
* aIdx
*/
function setOutTabItemByItemIdx(aTabId,aIdx){
  if (aIdx==null||aIdx=="undefined"||aIdx<0){
    alert("�봫��Ϸ���TabItem�����ţ�");
    return;
  }
  
  var aTitleTable=document.getElementById(aTabId+"_secTable");
  var aTagType=getTabType(aTabId);
  var tmpFocusIdx = getCurrentTabFocusItem(aTabId);

  if (aTagType.toUpperCase()==TAB_TYPE_H){
  	if(aTitleTable.rows[0].cells.length-1<aIdx){
  		alert('�Բ���ָ����Idx����tabҳ�ķ�Χ,�޷�������в�����');
	  	return false;
	 }
	if (tmpFocusIdx != aIdx) {
	
		aTitleTable.rows[0].cells[aIdx].firstChild.rows[0].cells[0].firstChild.className ="tab_h_title_style";
	}
  }else if(aTagType.toUpperCase()==TAB_TYPE_B){
  	if(aTitleTable.rows[0].cells.length-1<aIdx){
  		alert('�Բ���ָ����Idx����tabҳ�ķ�Χ,�޷�������в�����');
	  	return false;
	 }
	if (tmpFocusIdx != aIdx) {
		aTitleTable.rows[0].cells[aIdx].firstChild.rows[0].cells[0].firstChild.className ="tab_b_title_style";
	}
  }else{
  	if(aTitleTable.rows.length-1<aIdx){
  		alert('�Բ���ָ����Idx����tabҳ�ķ�Χ,�޷�������в�����');
	  	return false;
	 }
	if (tmpFocusIdx != aIdx) {
		aTitleTable.rows[aIdx].cells[0].firstChild.className ="tab_v_title_style";
  	}
  }
}

/**
* �������TAB�Ĺر�ͼ���ϵ���ʽ�仯
*/
function setMouseOverCloseTabItem(aTabId,aCloseSpanObj,aOverTdId) {

  var aTagType=getTabType(aTabId);
  //��ѯ�ö����index
  var aIndx;
  
  var aTitleTable=document.getElementById(aTabId+"_secTable");
  var aOverTdObj=document.getElementById(aTabId+aOverTdId);
  
  //����TAB�����ݵ�ǰѡ�е�TD��ȡ��TD����������еĵ�INDEX
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
* ����Ƴ�TAB�Ĺر�ͼ���ϵ���ʽ�仯
*/
function setMouseOutCloseTabItem(aTabId,aCloseSpanObj,aOutTdId) {
  var aTagType=getTabType(aTabId);
  //��ѯ�ö����index
  var aIndx;
  
  var aTitleTable=document.getElementById(aTabId+"_secTable");
  var aOutTdObj=document.getElementById(aTabId+aOutTdId);
  
  //����TAB�����ݵ�ǰѡ�е�TD��ȡ��TD����������еĵ�INDEX
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
