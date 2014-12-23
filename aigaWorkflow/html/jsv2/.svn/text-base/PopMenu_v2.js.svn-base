  /**
   　
   　作者 ： 钟锐   2004/05/18

   　
     AIPopMenu:弹出菜单控件

                  构造方法： var popMenu = new AIPopMenu(pAIPopMenuModel) 参数pAIPopMenuModel为popMenu数据Model

                  开发人员可以使用方法：

                  showPopMenu() 显示菜单

                  hidePopMenu() 隐藏菜单

                  reload(pModel) 重载菜单 pModel-菜单的数据model;

                  setItemEnabledById(pItemIdStr,flag)   设置某个菜单项是否有效,
                                                           参数;pItemIdStr 菜单项Id。如果有多个以","分隔。
                                                                    flag       布尔值，true表示设置以上的菜单项有效，false设置其无效.
          setItemEnabledByName(pName,flag) 设置某个菜单项是否有效
                                        参数;pName 菜单项。
                                                                    flag       布尔值，true表示设置以上的菜单项有效，false设置其无效.

                  setItemHideById(pItemIdStr,flag)  设置某个菜单项的是否隐藏状态为enable/disable
                                                                                   参数;pItemIdStr 菜单项Id。如果有多个以","分隔。
                                                                                   flag 为布尔值，true表示设置以上的菜单项隐藏，false设置其显示.
          setItemHideByName(pItemName,flag)  设置某个菜单项的是否隐藏状态为enable/disable
                                                                                   参数;pItemName 菜单项Id。
                                                                                   flag 为布尔值，true表示设置以上的菜单项隐藏，false设置其显示.


                  removeItemById(pItemId)  删除某个菜单项;
                  removeItemByName(pItemName)  删除某个菜单项;根据名称

     AIPopMenuModel：弹出菜单的数据model

                  addPopMenuItem(pItemId,pItemName,pParentItemId,pFuncName) 增加一个菜单项
                             参数: pItemId－菜单项的唯一标示
                                           pItemName－菜单的名称
                                                   pParentItemId － 菜单项所在的上级菜单项，如果是main主菜单，该值为null
                                                   pFuncName - 点击菜单需要触发的js函数的函数名称.

                  addPopMenuItemByRowSet(pRowSet,pIdCol,pNameCol,pParentIdCol,pFuncCol) 通过一个NormalRowSet增加菜单项
                             参数: pRowSet- NormalRowSet对象
                                           pIdCol－菜单项的唯一标示所在的列名
                                           pNameCol－菜单的名称所在的列名
                                                   pParentIdCol － 菜单项所在的上级菜单项所在的列名。
                                                   pFuncCol - 点击菜单需要触发的js函数的函数名称所在的列名


          addSeparator(pParentId) 增加一个分隔符 参数：pParentId - 菜单项所在的上级菜单项，如果是main主菜单，该值为null


  ***********/









  /**********************begin AIPopMenu.js ****************************************/

  /*************************全局函数*********************************************/
  var g_AIPopMenuManager = new AIPopMenuManager();

  function AIPopMenuManager()
   {
           this.AIPopMenuList = new Array();
           this.MaxId = 0;
           this.getNewPK = function()
                   {
                    this.MaxId = this.MaxId + 1;

                    return "AIPopMenu_" + this.MaxId;
               }
           this.push = function(pAIPopMenu)
                   {
                    this.AIPopMenuList[pAIPopMenu.PK] = pAIPopMenu;
               }
           this.get = function(pk)
                   {
                    return this.AIPopMenuList[pk];
               }
       this.getAIPopMenuList = function()
               {
                     return this.AIPopMenuList;
               }


    }


  /*************************END OF 全局函数*********************************************/




  function AIPopMenu(pAIPopMenuModel)
  {
     this.PK = g_AIPopMenuManager.getNewPK();
     g_AIPopMenuManager.push(this);

     this.model = pAIPopMenuModel;

     /*用来保存已经生成的不同级别扩展菜单的最大级别号*/
     this.maxDivLevel =-1;

     //this.AIMenuDivArray = new Array();
     //this.clearPopMenu = AIClearPopMenuFunc;
    /*PopDiv移入移出事件定义 2006-04-21 zhanglh*/
    this.onMouseEnter="";
    this.onMouseLeave="";
  }

  AIPopMenu.prototype.showPopMenu = AIPopMenu_showMenu;
  AIPopMenu.prototype.hidePopMenu = AIPopMenu_hideMenu;
  AIPopMenu.prototype.reload = AIPopMenu_reloadPopMenu;
  AIPopMenu.prototype.setItemEnabledById = AIPopMenu_setItemEnabled;
  AIPopMenu.prototype.setItemEnabledByName = AIPopMenu_setItemEnableByName;
  AIPopMenu.prototype.setItemHideById = AIPopMenu_setItemHideById;
  AIPopMenu.prototype.setItemHideByName = AIPopMenu_setItemHideByName;

  AIPopMenu.prototype.removeItemById = AIPopMenu_removeItemById;
  AIPopMenu.prototype.removeItemByName = AIPopMenu_removeItemByName;

  AIPopMenu.prototype.removeChildItem = AIRemoveChildItemFunc;

  AIPopMenu.prototype.setOnMouseEnter=AIPopMenu_setOnMouseEnter;
  AIPopMenu.prototype.setOnMouseLeave=AIPopMenu_setOnMouseLeave;

  //对所有的菜单进行隐藏。
  function AIPopMenu_hideMenu()
  {
     for(var i=0;i<=this.maxDivLevel;i++)
          {
             if(document.all.item(this.PK+"_"+i))
                     document.all.item(this.PK+"_"+i).style.visibility="hidden";
          }
  }



  //显示第一级弹出菜单
  function AIPopMenu_showMenu()
  {

    // if(this.maxDivLevel==-1)
    //   this.maxDivLevel = 0;
    if(this.maxDivLevel!=-1)
          {
            this.hidePopMenu();
          }
     var popMenuDiv = buildPopMenuDiv(this.PK+"_0",null,this,this.onMouseEnter,this.onMouseLeave);

     //显示右键主菜单
     popMenuDiv.style.posLeft=document.body.scrollLeft+window.event.clientX;
     popMenuDiv.style.posTop=document.body.scrollTop+window.event.clientY;
     //alert("x="+document.body.scrollposLeft+window.event.clientX+" y="+document.body.scrollposTop+window.event.clientY);
     if(popMenuDiv.style.posLeft+popMenuDiv.offsetWidth > document.body.scrollLeft+document.body.clientWidth)
           popMenuDiv.style.posLeft=document.body.scrollLeft+document.body.clientWidth-popMenuDiv.offsetWidth;
     if(popMenuDiv.style.posLeft < 0)
                  popMenuDiv.style.posLeft=0;
     if(popMenuDiv.style.posTop+popMenuDiv.offsetHeight > document.body.scrollTop+document.body.clientHeight)
                  popMenuDiv.style.posTop=document.body.scrollTop+document.body.clientHeight-popMenuDiv.offsetHeight;
     if(popMenuDiv.style.posTop < 0)
                  popMenuDiv.style.posTop=0;
     //alert("x="+popMenuDiv.style.posLeft+" y="+popMenuDiv.style.posTop);
     popMenuDiv.style.visibility="visible";



  }

  function buildPopMenuDiv(pDivId,pParentId,pSelPopMenuObj,pOnMouseEnter,pOnMouseLeave)
  {

          var popMenuDiv = document.all.item(pDivId);
          if(popMenuDiv)
          {
                  popMenuDiv.innerHTML="";

          }
          else
          {
         //alert("create");
             popMenuDiv = document.createElement("DIV");
             //popMenuDiv.OBJPK = pSelPopMenuObj.PK;
         popMenuDiv.id = pDivId;
         //popMenu所有创建的元素都增加isAiPopElement="true"属性，
         //以此来区分是否在同一个popMenu内移动鼠标。
         popMenuDiv.isAiPopElement="true";
         popMenuDiv.className = "aipopmenu_backdiv";
             popMenuDiv.style.width=0;
             popMenuDiv.style.height=0;
             popMenuDiv.style.position="absolute";
             popMenuDiv.style.visibility = "visible";
             popMenuDiv.oncontextmenu = function noneRightFunc(){ window.event.returnValue=false;window.event.cancelBubble=true;};
              //设置DIV的鼠标移入事件。
              //如果是本菜单和子菜单的内部之间移动，则不触发事件！
             if (pOnMouseEnter!=null&&pOnMouseEnter!="")
               popMenuDiv.onmouseenter=function doOnmousEnter(){
                var fromObj=null;
                var toObj = null;
                if(window.event){
                  toObj = window.event.toElement;
                  fromObj = window.event.fromElement;
                }
                //在popMenu内部移动或者popMenu隐藏时不触发事件
                if (toObj!=null&&fromObj!=null
                &&toObj.isAiPopElement&&fromObj.isAiPopElement
                &&toObj.isAiPopElement=="true"&&fromObj.isAiPopElement=="true"
                ||popMenuDiv.style.visibility=="hidden"){
                }else{
                  eval(pOnMouseEnter);
                }
             };
             //设置DIV的鼠标移出事件。
             if (pOnMouseLeave!=null&&pOnMouseLeave!="")
                popMenuDiv.onmouseleave=function doOnmousLeave(){
                var fromObj=null;
                var toObj = null;
                if(window.event){
                  toObj = window.event.toElement;
                  fromObj = window.event.fromElement;
                }
                //在popMenu内部移动或者popMenu隐藏时不触发事件
                if (toObj!=null&&fromObj!=null
                &&toObj.isAiPopElement&&fromObj.isAiPopElement
                &&toObj.isAiPopElement=="true"&&fromObj.isAiPopElement=="true"
                ||popMenuDiv.style.visibility=="hidden"){
                }else{
                  eval(pOnMouseLeave);
                }
             };

             pSelPopMenuObj.maxDivLevel+=1;

             document.body.appendChild(popMenuDiv);



      }
          if(pParentId==null)
             var menuItemArray = pSelPopMenuObj.model.getMainMenu();
          else
         var menuItemArray = pSelPopMenuObj.model.getSubMenu(pParentId);
          //alert("menuItemArray.length="+menuItemArray.length);
          var menuDivArray = new Array();
          menuDivArray[menuDivArray.length]=" <table isAiPopElement=\"true\" cellpadding=0 cellspacing=0 width='100%' oncontextmenu=\"window.event.cancelBubble=true;window.event.returnValue=null;\"> ";
      for(var i=0;i<menuItemArray.length;i++)
          {

             if(menuItemArray[i]==null)
                     continue;
              if(menuItemArray[i].level==-1)
                menuItemArray[i].level = pSelPopMenuObj.maxDivLevel;
             //分隔符
             if(menuItemArray[i].state=="S")
                  {
                    menuDivArray[menuDivArray.length]="<tr isAiPopElement=\"true\" style='padding-posLeft:1;height: 3;' class='aipopmenu_menu' onclick='window.event.cancelBubble=true;' onmouseup='window.event.cancelBubble=true;'><td isAiPopElement=\"true\" colspan='2'><hr isAiPopElement=\"true\" class='aipopmenu_sepa'></td></tr>";
                  }
         //菜单项已经被隐藏
             else if(menuItemArray[i].state=="H")
                  {
                    continue;
                  }
         //菜单项已经被设为Disabled
             else if(menuItemArray[i].state=="E")
                  {
                     menuDivArray[menuDivArray.length]=" <tr isAiPopElement=\"true\" PK=\""+pSelPopMenuObj.PK+"\" id=\""+menuItemArray[i].itemId+"\" level = \""+menuItemArray[i].level+"\" class='aipopmenu_menu'";
                     menuDivArray[menuDivArray.length]=" onMouseOver=\"this.className='aipopmenu_overmenu'; \"";
                     menuDivArray[menuDivArray.length]=" onMouseOut=\"this.className='aipopmenu_menu';\" ";
                     menuDivArray[menuDivArray.length]=" onmousedown=\"window.event.cancelBubble=true;window.event.returnValue=null;\"";
                     menuDivArray[menuDivArray.length]=" onmouseup=\"window.event.cancelBubble=true;window.event.returnValue=null;\"";
                     menuDivArray[menuDivArray.length]=" onclick=\"window.event.cancelBubble=true;window.event.returnValue=null;\">";
                     menuDivArray[menuDivArray.length]=" <td isAiPopElement=\"true\" nowrap class=\"aipopmenu_disablemenutext\">";
                     menuDivArray[menuDivArray.length]="&nbsp;"+menuItemArray[i].itemName+"&nbsp</td>";
                     if(menuItemArray[i].isChild)
                            menuDivArray[menuDivArray.length]="<td isAiPopElement=\"true\" class=\"aipopmenu_disablemenutext\" style='font-family: webdings; text-align: right;'>4</td>";
                     else
                            menuDivArray[menuDivArray.length]="<td isAiPopElement=\"true\"></td>";
                     menuDivArray[menuDivArray.length]="</tr>";
                  }
             else if(menuItemArray[i].state=="U")
                  {
                     menuDivArray[menuDivArray.length]=" <tr isAiPopElement=\"true\" PK=\""+pSelPopMenuObj.PK +"\" id=\""+menuItemArray[i].itemId+"\" level = \""+menuItemArray[i].level+"\" class='aipopmenu_menu'";
                     if(menuItemArray[i].isChild)
                          {
                             menuDivArray[menuDivArray.length]=" onMouseOver=\"p_AIMouseOver(this,'"+pOnMouseEnter+"','"+pOnMouseLeave+"')\"";
                             menuDivArray[menuDivArray.length]=" onMouseOut=\"p_AIMouseOut(this)\" ";
                             menuDivArray[menuDivArray.length]=" onmousedown=\"window.event.cancelBubble=true;window.event.returnValue=null;\"";
                             menuDivArray[menuDivArray.length]=" onmouseup=\"window.event.cancelBubble=true;window.event.returnValue=null;\"";
                             menuDivArray[menuDivArray.length]=" onclick=\"window.event.cancelBubble=true;\">";
                          }
                     else
                          {
                             menuDivArray[menuDivArray.length]=" onMouseOver=\"l_AIMouseOver(this);\"";
                             menuDivArray[menuDivArray.length]=" onMouseOut=\"this.className='aipopmenu_menu';\" ";
                             menuDivArray[menuDivArray.length]=" onmousedown=\"window.event.cancelBubble=true;window.event.returnValue=false;\"";
                             menuDivArray[menuDivArray.length]=" onmouseup=\"window.event.cancelBubble=true;window.event.returnValue=false;\"";
                             menuDivArray[menuDivArray.length]=" onclick=l_AIMouseClick(this)>";
                          }

                     menuDivArray[menuDivArray.length]=" <td isAiPopElement=\"true\" nowrap >";
                     menuDivArray[menuDivArray.length]="&nbsp;"+menuItemArray[i].itemName+"&nbsp;</td>";
                     if(menuItemArray[i].isChild)
                            menuDivArray[menuDivArray.length]="<td isAiPopElement=\"true\" style='font-family: webdings; text-align: right;'>4</td>";
                     else
                            menuDivArray[menuDivArray.length]="<td isAiPopElement=\"true\"></td>";
                     menuDivArray[menuDivArray.length]="</tr>";
                  }


           }//end for
     menuDivArray[menuDivArray.length]="</table>";
     popMenuDiv.innerHTML= menuDivArray.join(" ");
  //   alert(popMenuDiv.outerHTML);
     return popMenuDiv;
  }

  //独立函数，当鼠标位于有子扩展菜单的菜单项的时候，显示子扩展菜单
  function p_AIMouseOver(pTrObj,pOnMouseEnter,pOnMouseLeave)
  {
          pTrObj.className = "aipopmenu_overmenu";
          var parentId = pTrObj.id;
      var divId = pTrObj.PK+"_"+(parseInt(pTrObj.level)+1);
      var menuObj = g_AIPopMenuManager.get(pTrObj.PK);
          //alert("divId="+divId+" pId="+parentId+" pTrObj.PK"+pTrObj.PK);
      //menuObj.maxDivLevel+=1;
          var popMenuDiv = buildPopMenuDiv(divId,parentId,menuObj,pOnMouseEnter,pOnMouseLeave);
          var Parent =  document.all.item(pTrObj.PK+"_"+pTrObj.level);

          //alert(pTrObj.PK+"_"+pTrObj.level);
                  //pTrObj.parentElement.parentElement;
     //显示某个菜单项的扩展子菜单
      popMenuDiv.style.visibility="visible";
          popMenuDiv.style.posLeft=document.body.scrollLeft+Parent.offsetLeft+Parent.offsetWidth-4;
      if(popMenuDiv.style.posLeft+popMenuDiv.offsetWidth > document.body.scrollLeft+document.body.clientWidth)
          popMenuDiv.style.posLeft=popMenuDiv.style.posLeft-Parent.offsetWidth-popMenuDiv.offsetWidth+8;
      if(popMenuDiv.style.posLeft < 0)
          popMenuDiv.style.posLeft=document.body.scrollLeft+Parent.offsetLeft+Parent.offsetWidth;
      popMenuDiv.style.posTop=Parent.offsetTop+pTrObj.offsetTop;
      if(popMenuDiv.style.posTop+popMenuDiv.offsetHeight > document.body.scrollTop+document.body.clientHeight)
        popMenuDiv.style.posTop=document.body.scrollTop+document.body.clientHeight-popMenuDiv.offsetHeight;
      if(popMenuDiv.style.posTop < 0) popMenuDiv.style.posTop=0;


  }

  function p_AIMouseOut(pTrObj)
  {

          pTrObj.className = "aipopmenu_menu";
          /*var menuObj = g_AIPopMenuManager.get(pTrObj.PK);
    var curLevel = parseInt(pTrObj.level);

    for(var i=curLevel+1;i<=menuObj.maxDivLevel;i++)
          {
          var divId = pTrObj.PK+"_"+parseInt(i);
           //alert("divId="+divId);
          if(document.all.item(divId))
                  {
                    document.all.item(divId).style.visibility="hidden";
                  }
          }*/


  }

  //如果某个菜单项没有子菜单，要将它的所有子菜单隐藏掉
  function l_AIMouseOver(pTrObj)
  {
    pTrObj.className='aipopmenu_overmenu';
    var parentId = pTrObj.id;
    var menuObj = g_AIPopMenuManager.get(pTrObj.PK);
    var curLevel = parseInt(pTrObj.level);
    //alert(curLevel+","+menuObj.maxDivLevel);
    for(var i=curLevel+1;i<=menuObj.maxDivLevel;i++)
          {
          var divId = pTrObj.PK+"_"+parseInt(i);
           //alert("divId="+divId);
          if(document.all.item(divId))
                  {
                    document.all.item(divId).style.visibility="hidden";
                  }
          }





  }

  //菜单项的onclick对象
  function l_AIMouseClick(pTrObj)
  {


     var menuObj = g_AIPopMenuManager.get(pTrObj.PK);

     var selMenuItem = menuObj.model.getMenuItem(pTrObj.id);
     menuObj.hidePopMenu();
    //alert("in line15359 selMenuItem.funcName="+selMenuItem.funcName);
    if(selMenuItem && selMenuItem.funcName!=null)
     {
           if(selMenuItem.funcName.indexOf("(")>0 && selMenuItem.funcName.indexOf(")")>0)
             {
             eval(selMenuItem.funcName);
             }
       else
         {
                     eval(selMenuItem.funcName+"('"+selMenuItem.itemId+"','"+selMenuItem.itemName+"')");
             }


     }

    window.event.cancelBubble=true;
    window.event.returnValue=false;



  }

  /*
    设置某个菜单项是否有效
    参数;pItemIdStr 菜单项Id。如果有多个以","分隔。
         flag 为布尔值，true表示设置以上的菜单项有效，false设置其无效.
  */
  function AIPopMenu_setItemEnabled(pItemIdStr,flag)
  {
     if(this.model)
          {
             if(flag)
                this.model.setItemState(pItemIdStr,"U");
             else
            this.model.setItemState(pItemIdStr,"E");
          }
  }

  /*
    设置某个菜单项是否有效
    参数;pName 菜单项名称。
         flag 为布尔值，true表示设置以上的菜单项有效，false设置其无效.
  */
  function AIPopMenu_setItemEnableByName(pName,pFlag)
  {

    var selItemIdArray = this.model.getItemIdByName(pName);

    for(var i=0;i<selItemIdArray.length;i++)
          {
            //alert(selItemIdArray[i]);
            this.setItemEnabledById(selItemIdArray[i],pFlag);
          }
  }

  /*
    设置某个菜单项的是否隐藏状态为enable/disable
    参数;pItemIdStr 菜单项Id。如果有多个以","分隔。
         flag 为布尔值，true表示设置以上的菜单项隐藏，false设置其显示.
  */
  function AIPopMenu_setItemHideById(pItemIdStr,flag)
  {
      if(this.model)
          {

             if(flag)
                this.model.setItemState(pItemIdStr,"H");
             else
            this.model.setItemState(pItemIdStr,"U");
          }
  }

  function AIPopMenu_setItemHideByName(pName,pFlag)
  {
    var selItemIdArray = this.model.getItemIdByName(pName);
    for(var i=0;i<selItemIdArray.length;i++)
          {
            this.setItemHideById(selItemIdArray[i],pFlag);
          }
  }

  /*
    重新设置菜单

  */

  function AIPopMenu_reloadPopMenu(pModel)
  {
     this.model = pModel;
     for(var i=0;i<=this.maxDivLevel;i++)
          {
             if(document.all.item(this.PK+"_"+i))
                  {
                     var divObj = document.all.item(this.PK+"_"+i);
                     document.body.removeChild(divObj);
                  }
          }
     this.maxDivLevel = -1;
  }

  /*
     删除一个菜单项
  */
  function AIPopMenu_removeItemById(pItemId)
  {
    this.model.removeItemById(pItemId);
  }

  function AIPopMenu_removeItemByName(pName,pFlag)
  {
    var selItemIdArray = this.model.getItemIdByName(pName);
    for(var i=0;i<selItemIdArray.length;i++)
          {
            this.removeItemById(selItemIdArray[i]);
          }
  }







  /*
    已知父亲菜单项，删除它的孩子菜单项
  */

  function AIRemoveChildItemFunc(pParentItemId)
  {
    alert("no complete");
  }



















  /*
  本弹出菜单的接口对象
  参数：pItemId 菜单项ID
        pItemName 菜单项中文名称
            pParentItemId 菜单项父菜单的ID，如果是主菜单，父菜单项ID为null
            pFuncName 点击菜单项调用的方法。例如;"hello()";
  */
  function AIPopMenuItem(pItemId,pItemName,pParentItemId,pFuncName)
  {
    this.itemId = pItemId;
    this.itemName = pItemName;
    this.parentItemId = pParentItemId;
    this.state="U";/*'S'-表示是一个分隔符,'U'-表示当前有效,'E'-表示处于无效状态 'H'-处于隐藏状态*/
    this.funcName = pFuncName;
    this.level = -1;
    this.isChild = false;

  }



  /*
     弹出菜单的数据model
     和AIPopMenu对象的接口方法为：
     this.getMainMenu(); 弹出时的主菜单的菜单项。返回AIPopMenuItem对象数组

     this.getSubMenu(pParentItemId);//根据父级菜单，得到它的子扩展菜单的菜单项 返回AIPopMenuItem对象数组

     this.getMenuItem(pItemId); //根据菜单项Id，得到菜单项的详细信息，返回一个AIPopMenuItem对象;

     this.getItemIdByName(pName);//根据菜单中文名称，得到菜单的id值，返回一个数组

     this.setItemState(pItemIdStr,state) //设置某个或者某些菜单项的状态，多个菜单项时用“,”分隔

     this.removeItemById(pItemId) //更加ItemId删除某个菜单项



  */

  function AIPopMenuModel()
  {

          this.menuItemArray = new Array();

          this.mainMenuItemArray = new Array();

          this.allMenuItemArray = new Array();

          this.addPopMenuItem = function(pItemId,pItemName,pParentItemId,pFuncName)
                                {

                                                            var menuItem = new  AIPopMenuItem(pItemId,pItemName,pParentItemId,pFuncName);

                                                            if(pParentItemId==null || pParentItemId=="null")
                                                            {
                                                                    menuItem.level = 0;
                                                                    this.mainMenuItemArray[this.mainMenuItemArray.length]=menuItem;
                                                                    this.allMenuItemArray[pItemId] = menuItem;
                                                            }
                                                            else
                                                            {

                                                                    this.menuItemArray[this.menuItemArray.length]=menuItem;
                                    this.allMenuItemArray[pItemId] = menuItem;
                                                                    if(this.allMenuItemArray[pParentItemId])
                                                                    {
                                       this.allMenuItemArray[pParentItemId].isChild = true;


                                                                    }
                                                            }
                                } ;
      this.addPopMenuItemByRowSet = function(pRowSet,pIdCol,pNameCol,pParentIdCol,pFuncCol)
                               {
                                       var backupArray = new Array();
                                                           for(var i=0;i<pRowSet.count();i++)
                                                           {
                                  var menuItem = new  AIPopMenuItem(pRowSet.getValue(i,pIdCol),pRowSet.getValue(i,pNameCol),pRowSet.getValue(i,pParentIdCol),pRowSet.getValue(i,pFuncCol));
                                  if(menuItem.parentItemId==null || menuItem.parentItemId=="null" || menuItem.parentItemId=="")
                                                               {
                                                                      if(menuItem.itemName=="-")
                                                                           {
                                                                                  this.addSeparator(null);
                                                                           }
                                      else
                                                                           {

                                                                        this.mainMenuItemArray[this.mainMenuItemArray.length] = menuItem;
                                                                        this.allMenuItemArray[menuItem.itemId] = menuItem;
                                                                           }

                                                               }
                                                             else
                                                               {

                                                                           if(menuItem.itemName=="-")
                                                                           {
                                                                                  this.addSeparator(menuItem.parentItemId);
                                                                           }
                                      else
                                                                           {


                                                                                    this.menuItemArray[this.menuItemArray.length] =menuItem;
                                                                                    this.allMenuItemArray[menuItem.itemId] = menuItem;
                                                                                    if(this.allMenuItemArray[menuItem.parentItemId])
                                                                                    {

                                                                                           this.allMenuItemArray[menuItem.parentItemId].isChild = true;


                                                                                    }
                                                                                    else
                                                                                    {
                                                                                           backupArray[backupArray.length] = menuItem;

                                                                                    }
                                                                           }
                                                               }
                                                           }//end for
                                                           for(var j=0;j<backupArray.length;j++)
                                                           {
                                                                   var parentId = backupArray[j].parentItemId;
                                                                   var id = backupArray[j].itemId;
                                                                   if(this.allMenuItemArray[parentId])
                                                                   {
                                                                           this.allMenuItemArray[parentId].isChild = true;


                                                                   }
                                                           }
                                                           backupArray.length = 0;
                                                           backupArray = null;


                               }
      this.addSeparator = function(pParentItemId)
                               {
                                      var menuItem = new  AIPopMenuItem(null,null,pParentItemId,null);
                                                          menuItem.state="S";
                                                          if(pParentItemId==null || pParentItemId=="null")
                                                            {

                                                                    this.mainMenuItemArray[this.mainMenuItemArray.length]=menuItem;

                                                            }
                                                            else
                                                            {
                                                                    this.menuItemArray[this.menuItemArray.length]=menuItem;
                                                                    if(this.allMenuItemArray[pParentItemId])
                                                                    {
                                       this.allMenuItemArray[pParentItemId].isChild = true;

                                                                    }
                                                            }


                               }
          this.getMainMenu = function()
                                {
                                          return this.mainMenuItemArray;
                            };
      this.getSubMenu	= function(pParentItemId)
                                {
                                      var rArray = new Array();
                                                          for(var i=0;i<this.menuItemArray.length;i++)
                                                            {
                                    if(this.menuItemArray[i] && this.menuItemArray[i].parentItemId==pParentItemId)
                                                                    {
                                                                           //alert("id="+this.menuItemArray[i].itemId+" isChild="+this.menuItemArray[i].isChild);
                                                                           rArray[rArray.length] = this.menuItemArray[i];
                                                                    }
                                                            }
                              return rArray;
                             }

          this.getMenuItem = function(pItemId)
                              {
                                     //alert("pItemId="+pItemId);
                                                     if(this.allMenuItemArray[pItemId])
                                                                  return this.allMenuItemArray[pItemId];
                                                     else
                                                             return null;
                              }
          this.setItemState = function(pItemIdStr,pState)
                                {
                                      var itemArray = pItemIdStr.split(",");
                                                          if(itemArray && itemArray.length>0)
                                                            {
                                                                  for(var i=0;i<itemArray.length;i++)
                                                                    {
                                                                      if(this.allMenuItemArray[itemArray[i]])
                                                                            this.allMenuItemArray[itemArray[i]].state = pState;
                                    }
                                                            }
                                }
      this.getItemIdByName = function(pName)
                               {
                                      if(pName==null || pName=="") return;
                                                          var reVal = new Array();
                                                          for(var i=0;i<this.mainMenuItemArray.length;i++)
                                                           {
                                                                  if(this.mainMenuItemArray[i].itemName==pName)
                                                                   {
                                                                          reVal[reVal.length] = this.mainMenuItemArray[i].itemId;
                                                                   }
                                                           }
                                                          for(var i=0;i<this.menuItemArray.length;i++)
                                                           {
                                                                  if(this.menuItemArray[i].itemName==pName)
                                                                   {
                                                                          reVal[reVal.length]=this.menuItemArray[i].itemId;
                                                                   }
                                                           }
                                                           return reVal;
                               }
      this.removeItemById = function(pItemId)
          {

                  if(this.allMenuItemArray[pItemId])
                  {
             var delObj = this.allMenuItemArray[pItemId];
                     if(parseInt(delObj.level)==0 || parseInt(delObj.level)==-1)
                          {
                delPopMenuItemInArray(this.mainMenuItemArray,pItemId);

                          }
                     else
                          {
                delPopMenuItemInArray(this.menuItemArray,pItemId);

                          }
                  }
          }
  }


  function delPopMenuItemInArray(pArray,pItemId)
  {
     for(var i=0;i<pArray.length;i++)
          {
             if(pArray[i].itemId == pItemId)
                  {
                     if(i==0) pArray.shift();
                     else if(i==pArray.length-1) pArray.pop();
                     else
                          {
                             for(m=i;m<pArray.length-1;m++)
                                  {
                                     pArray[m] = pArray[m+1];
                                  }
                 pArray.pop();
                          }
                     break;
                  }
          }
  }

  /*鼠标移入整个PopMenu的事件 2006-04-21 zhanglh*/
  function AIPopMenu_setOnMouseEnter(pOnMouseEnterFuncName){
    if (pOnMouseEnterFuncName!=null&&pOnMouseEnterFuncName!=""&&pOnMouseEnterFuncName.indexOf("(")<0){
        pOnMouseEnterFuncName+="()";
    }
    this.onMouseEnter=pOnMouseEnterFuncName;
  }

  /*鼠标移出整个PopMenu的事件 2006-04-21 zhanglh*/
  function AIPopMenu_setOnMouseLeave(pOnMouseLeaveFuncName){
    if (pOnMouseLeaveFuncName!=null&&pOnMouseLeaveFuncName!=""&&pOnMouseLeaveFuncName.indexOf("(")<0){
        pOnMouseLeaveFuncName+="()";
    }
    this.onMouseLeave=pOnMouseLeaveFuncName;
  }








  /**********************end AIPopMenu.js ****************************************/
