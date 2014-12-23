/**

  文件名称：publicHiddenFrame.js

  作者：关昆

  编制时间：2002-10-14

  文件内容：提供将变量写入公共的隐藏帧，并从其中读取变量的方法。

  方法：

        publicFrame_putGlobal:设置变量

        参数：

          aPageName:页面名称

          aGlobalName:全局变量名称

          aGlobalValue:全局变量值

       publicFrame_getGlobal:读取变量

       publicFrame_getSysFunPara:读取系统参数ID（在配置功能模块时指定）

       参数:

          aPageName:页面名称

          aGlobalName:全局变量名称

       publicFrame_clearGlobal:清除变量

  if (publicFrame_isDebugger)  showMessage("publicFrame.js","Start");


**/

var publicFrame_PUBLICFRAME = top.FrameHidden;

var publicFrame_isDebugger = false;

function publicFrame_getSysFunPara(aParaName)

{

   var _gMENUPARA = "menuMain.jsp";

   var re = publicFrame_getGlobal(_gMENUPARA,aParaName);

   return re;

}

function publicFrame_getCurrentMenuID(){

   var _gMENUPARA = "menuMain.jsp";

   var _gMENU_ID = "MENU_ID";

   var re = publicFrame_getGlobal(_gMENUPARA,_gMENU_ID);

   return re;

}

function publicFrame_putGlobal(aPageName,aGlobalName,aGlobalValue)

{

  if (!aPageName)

  {

    if (publicFrame_isDebugger)  showMessage("publicFrame_putGlobal()执行失败，原因","参数aPageName为空");

      return false;

  }

  if (!aGlobalName)

  {

    if (publicFrame_isDebugger)  showMessage("publicFrame_putGlobal()执行失败，原因","参数aGlobalName为空");

      return false;

  }

  var obj = publicFrame_PUBLICFRAME;

  if (!obj)

  {

    if (publicFrame_isDebugger)  showMessage("publicFrame_putGlobal()执行失败","没有找到公共的隐藏帧--top.FrameHidden--");

      return false;

  }

  if (publicFrame_isDebugger)  showMessage("publicFrame_putGlobal()","找到公共的隐藏帧--top.FrameHidden--");

  /**

   **obj.GlobalArray:数组,Array[i]表示PageName，Array[i].VALUE是一个tmpGValueArray对象

     tmpGValueArray:数组，Array[i]表示GlobalName(全局变量的名称),Array[i].VALUE是GlobalValue(全局变量的值)

   **/

  if (!obj.GlobalArray) //如果GlobalArray不存在，则创建

  {

    if (publicFrame_isDebugger)  showMessage("publicFrame_putGlobal()->obj.GlobalArray","obj.GlobalArray为空");

    obj.GlobalArray = new Array();

    var tmpGValueArray = new Array();

    var tmpObj = new Object();

    tmpObj.NAME = aGlobalName;

    tmpObj.VALUE = aGlobalValue;

    tmpGValueArray.push(tmpObj);

    var tmpObj = new Object();

    tmpObj.NAME = aPageName;

    tmpObj.VALUE = tmpGValueArray;

    obj.GlobalArray.push(tmpObj);

    if (publicFrame_isDebugger)  showMessage("publicFrame_setGlobal->obj.GlobalArray[obj.GlobalArray.length - 1].VALUE[obj.GlobalArray[obj.GlobalArray.length - 1].VALUE.length - 1].VALUE",obj.GlobalArray[obj.GlobalArray.length - 1].VALUE[obj.GlobalArray[obj.GlobalArray.length - 1].VALUE.length - 1].VALUE);

  }

  else

  {

    var tmpPage = null;

    for (var i=0;i<obj.GlobalArray.length;i++)

    {

      if (obj.GlobalArray[i]!=null&&obj.GlobalArray[i].NAME != null && obj.GlobalArray[i].NAME.toUpperCase() == aPageName.toUpperCase())
      {

        tmpPage = obj.GlobalArray[i];

        break;

      }

    } //end for

    if (tmpPage == null)

    {

      if (publicFrame_isDebugger)  showMessage("publicFrame_putGlobal()->obj.GlobalArray","obj.GlobalArray不为空但没有PageName="+aPageName+"对应的元素");

      var tmpGValueArray = new Array();

      var tmpObj = new Object();

      tmpObj.NAME = aGlobalName;

      tmpObj.VALUE = aGlobalValue;

      tmpGValueArray.push(tmpObj);



      var tmpObj = new Object();

      tmpObj.NAME = aPageName;

      tmpObj.VALUE = tmpGValueArray;

      obj.GlobalArray.push(tmpObj);

      if (publicFrame_isDebugger)  showMessage("obj.GlobalArray[obj.GlobalArray.length - 1].VALUE[obj.GlobalArray[obj.GlobalArray.length - 1].VALUE.length - 1].VALUE",obj.GlobalArray[obj.GlobalArray.length - 1].VALUE[obj.GlobalArray[obj.GlobalArray.length - 1].VALUE.length - 1].VALUE);

     }

     else

     {



       var tmpGValue = tmpPage.VALUE;

       if (tmpGValue == null)

       {

       	 if (publicFrame_isDebugger)  showMessage("publicFrame_putGlobal()->obj.GlobalArray","obj.GlobalArray不为空且有PageName="+aPageName+"对应的元素，但该元素VALUE属性为空");

         tmpGValue = new Array();

         var tmpObj = new Object();

         tmpObj.NAME = aGlobalName;

         tmpObj.VALUE = aGlobalValue;

         tmpGValue.push(tmpObj);

         if (publicFrame_isDebugger)  showMessage("obj.GlobalArray[obj.GlobalArray.length - 1].VALUE[obj.GlobalArray[obj.GlobalArray.length - 1].VALUE.length - 1].VALUE",obj.GlobalArray[obj.GlobalArray.length - 1].VALUE[obj.GlobalArray[obj.GlobalArray.length - 1].VALUE.length - 1].VALUE);

       }

       else

       {

         var bflag = false;

       	 for (var i=0;i<tmpGValue.length;i++)

       	   if (tmpGValue[i].NAME !=null && tmpGValue[i].NAME.toUpperCase() == aGlobalName.toUpperCase())

       	   {

       	     if (publicFrame_isDebugger)  showMessage("publicFrame_putGlobal()->obj.GlobalArray","obj.GlobalArray不为空且有"+aPageName+"对应的元素，而且该元素中有名称"+aGlobalName+"为的变量");

       	     tmpGValue[i].VALUE  = aGlobalValue;

       	     bflag = true;

       	     if (publicFrame_isDebugger)  showMessage("obj.GlobalArray[obj.GlobalArray.length - 1].VALUE[obj.GlobalArray[obj.GlobalArray.length - 1].VALUE.length - 1].VALUE",obj.GlobalArray[obj.GlobalArray.length - 1].VALUE[obj.GlobalArray[obj.GlobalArray.length - 1].VALUE.length - 1].VALUE);

       	     break;

       	   }

         if (!bflag)

         {

           if (publicFrame_isDebugger)  showMessage("publicFrame_putGlobal()->obj.GlobalArray","obj.GlobalArray不为空且有"+aPageName+"对应的元素，但是该元素中没有名称"+aGlobalName+"为的变量");

           var tmpObj = new Object();

       	   tmpObj.NAME = aGlobalName;

       	   tmpObj.VALUE = aGlobalValue;

       	   tmpGValue.push(tmpObj);

       	   if (publicFrame_isDebugger)  showMessage("obj.GlobalArray[obj.GlobalArray.length - 1].VALUE[obj.GlobalArray[obj.GlobalArray.length - 1].VALUE.length - 1].VALUE",obj.GlobalArray[obj.GlobalArray.length - 1].VALUE[obj.GlobalArray[obj.GlobalArray.length - 1].VALUE.length - 1].VALUE);

         }

       } //end if..else tmpGValue

     } //end if..esle tmpPage

  } // end if..else obj.GlobalArray

}

function publicFrame_getGlobal(aPageName,aGlobalName)

{

  if (!aPageName)

  {

    if (publicFrame_isDebugger)  showMessage("publicFrame_getGlobal()返回空值，原因","参数aPageName为空");

      return null;

  }

  if (!aGlobalName)

  {

    if (publicFrame_isDebugger)  showMessage("publicFrame_getGlobal()返回空值，原因","参数aGlobalName为空");

      return null;

  }

  var obj = publicFrame_PUBLICFRAME;

  if (!obj)

  {

    if (publicFrame_isDebugger)  showMessage("publicFrame_getGlobal()返回空值，原因","没有找到公共的隐藏帧--top.FrameHidden--");

      return null;

  }

  if (!obj.GlobalArray)

  {

    if (publicFrame_isDebugger)  showMessage("publicFrame_getGlobal()返回空值，原因","找到公共的隐藏帧--top.FrameHidden--,但GlobalArray属性为空");

      return null;

  }

  //if (publicFrame_isDebugger)  showMessage("publicFrame_getGlobal()->obj.GlobalArray",obj.GlobalArray);

  for(var i=0;i<obj.GlobalArray.length;i++)

  {

    if (obj.GlobalArray[i]!=null&&obj.GlobalArray[i].NAME != null && obj.GlobalArray[i].NAME.toUpperCase() == aPageName.toUpperCase())

    {

      if (obj.GlobalArray[i].VALUE && obj.GlobalArray[i].VALUE != null)

      {

      	for (var j=0;j<obj.GlobalArray[i].VALUE.length;j++)

      	{

      	  if (obj.GlobalArray[i].VALUE[j].NAME != null && obj.GlobalArray[i].VALUE[j].NAME.toUpperCase() == aGlobalName.toUpperCase())

      	  {

      	    if (publicFrame_isDebugger)  showMessage("publicFrame_getGlobal()返回值不为空->","-)");

      	    return obj.GlobalArray[i].VALUE[j].VALUE;

      	  }

      	}

      	if (publicFrame_isDebugger)  showMessage("publicFrame_getGlobal()->返回空值，原因","obj.GlobalArray中存在PageName="+aPageName+"的元素，但该元素中没有名为"+aGlobalName+"的变量");

      	return null;

      }

      else

      {

      	if (publicFrame_isDebugger)  showMessage("publicFrame_getGlobal()->返回空值，原因","obj.GlobalArray中存在PageName="+aPageName+"的元素，但该元素中.VALUE属性为空(变量数组为空)!!");

      	return null;

      }

    } //end if obj.GlobalArray[i].toUpperCase() == aPageName.toUpperCase()

  }

  if (publicFrame_isDebugger)  showMessage("publicFrame_getGlobal()->返回空值，原因","obj.GlobalArray中不存在PageName="+aPageName+"的元素");

  return null;

}

function publicFrame_clearGlobal()

{

  var obj = publicFrame_PUBLICFRAME;

  if (!obj) return;

  obj.GlobalArray = null;

}

function publicFrame_clearPageGlobal(aPageName)

{

  var obj = publicFrame_PUBLICFRAME;

  if (!obj) return;
  if(! obj.GlobalArray) return;
  for(var i=0;i<obj.GlobalArray.length;i++)

  {
    if (obj.GlobalArray[i]!=null&&obj.GlobalArray[i].NAME != null && obj.GlobalArray[i].NAME.toUpperCase() == aPageName.toUpperCase())

    {
	obj.GlobalArray[i] = null;
    }
  }

}
