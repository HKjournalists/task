/**
 * 祁麟
 * 界面事件定义
 */
S_OnClick = "OnClick";

S_OnGridRowFocusChange = "GridRowFocusChange"; //参数说明：OldRowIndex,NewRowIndex
S_OnGridCellFocusChange = "GridCellFocusChange"; //参数说明：OldRowIndex,OldColIndex,NewRowIndex,NewColIndex
S_OnGridRowSelected = "GridRowSelected"; //参数说明：RowIndex，SelectedSts = true(选中),false(取消选中)
S_OnGridDbClick = "OnGridDbClick"; //参数说明：RowIndex,ColIndex
S_OnContextMenu = "OnContextMenu";//参数说明：RowIndex,ColIndex

S_OnRowFocusChange ="RowFocusChange";
S_OnRowSelected ="RowSelected";
S_OnUnRowSelected ="UnRowSelected";
S_OnCellValueChange = "CellValueChange";
S_OnChange ="OnChange";
S_OnDbClick ="OnDbClick";
S_OnEnter = "OnEnter";
S_OnKeyDown = "OnKeyDown";
S_OnKeyUp = "OnKeyUp";
S_OnKeyPress = "OnKeyPress";
S_OnMouseDown = "OnMouseDown";
S_OnMouseUp = "OnMouseUp";
S_OnFocus = "OnFocus";
S_OnBlur = "OnBlur";
S_OnMouseMove = "OnMouseMove";
S_OnMouseOut = "OnMouseOut"
S_Enable ="Enable";
S_Disable ="Disable";

function Object_fireListenerByEvent(eventName,event)
{
  var b = false;
  eval("b = !!(this." + eventName + ")");
  if (b==false) return;
  var obj = null;
  eval("obj = this." +eventName);
  if (obj)
    for(var i=0;i<obj.length;i++)
      obj[i].execute(event);
}

function Object_fireListener(eventName,eventSource,windowEvent)
{

  var b = false;
  eval("b = !!(this." + eventName + ")");
  if (b==false) return;
  var obj = null;
  eval("obj = this." +eventName);
  if (obj)
  { var event = new UIEvent(eventName,eventSource,windowEvent);
    for(var i=0;i<obj.length;i++)
      obj[i].execute(event);
  }
}

function Object_removeListener(eventName,listener)
{
   var obj = null
   eval("obj = this." + eventName );
   if(!obj) return ;
   for(var i=0;i<obj.length;i++)
   {
     if (obj[i] == listener)
     {
       arrayRemove(obj,i);
       return;
     }
   }
}
function Object_addListener(eventName,listener)
{
   var b = false;
   eval("b = !!(this." + eventName + ")");
   if (b==false)
      eval("this." + eventName +" = new Array()");
   var obj = null;
   eval("obj = this." + eventName );
   for(var i =0;i<obj.length;i++)
     if(obj[i] == listener)
        return ;
   obj[obj.length] = (listener);
}
