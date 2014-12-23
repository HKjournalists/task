/**
	文件名称：UIRelation.js
	作者	: 墙 辉
	编制时间: 2002-09-25
	文件内容：处理界面对象之间的关系
	包括对象：

**/

/******************************************************************************
 *
 *  界面元素关系管理对象,在对象内部管理一个域对象数组。
 *
******************************************************************************/
function UIRelationFactory(parent,xmlNode)
{
  this.List = new Array();
  this.Parent = null;
  if (parent ) this.Parent = parent;
  if (xmlNode)
  {
    for(var i=0;i < xmlNode.childNodes.length;i++)
       this.List[this.List.length] = (new UIRelation(this,xmlNode.childNodes(i)));
  }
  this.setParent = function(parent) { this.Parent = parent;}
  this.getParent = function() { return this.Parent;}

          /*
          * 根据事件源名称和事件名称查找界面关系数组
          */
  this.findUIRelation = function(sourceName,eventName)
          {
            var result = new Array();
            for(var i=0;i<this.List.length;i++)
            {// alert(this.List[i].getSource()  +'----' + sourceName + '--' +this.List[i].getSourceEventName() +'---' + eventName);
             if (compareObjectName(this.List[i].getSource(),sourceName) && (this.List[i].getSourceEventName() == eventName))
                 result[result.length] = (this.List[i]);
            }
            return result;
          }
          /*
          * 触发事件
          */
  this.triggerEvent = function(event)
          { //alert(event.getSource().getName() +'---'+ event.getName());
            var sourceName;
            if (event.getSource().getHtmlObjectName) sourceName = event.getSource().getHtmlObjectName();
            else sourceName = event.getSource().getName();
            var relationList = this.findUIRelation(sourceName,event.getName());
            for(var i =0;i<relationList.length;i++)
              relationList[i].sendEventToTarget(event);


          }
}

/******************************************************************************
 *
 *  界面元素关系对象,在对象内部管理一个域对象数组。
 *
******************************************************************************/
function UIRelation(parent,xmlNode)
{
  this.Source = null; //事件源
  this.SourceEventName = null;
  this.Target = null; //触发的目标对象
  this.TargetEventName = null;
  this.Condition = null ;//触发条件
  this.Parent = null;
  if (parent ) this.Parent = parent;

  if(xmlNode)
  {  var tmpNode ;
     for(var i=0;i < xmlNode.childNodes.length;i++)
     { tmpNode = xmlNode.childNodes(i);
       if (tmpNode.nodeName == "Source")
         this.Source = tmpNode.text;
       else if (tmpNode.nodeName == "SourceEvent")
         this.SourceEventName = tmpNode.text;
       else if (tmpNode.nodeName == "Target")
         this.Target = tmpNode.text;
       else if (tmpNode.nodeName == "TargetEvent")
         this.TargetEventName = tmpNode.text;
       else if (tmpNode.nodeName == "Condition")
         this.Condition = tmpNode.text;
     }
  }
  this.setParent = function(parent) { this.Parent = parent;}
  this.getParent = function() { return this.Parent;}
  this.getSource = function() { return this.Source; }
  this.setSource = function(source) { this.Source = source; }
  this.getSourceEventName = function() { return this.SourceEventName; }
  this.setSourceEventName = function(sourceEventName) { this.SourceEventName = sourceEventName; }
  this.getTarget = function() { return this.Target; }
  this.setTarget = function(target) { this.Target = target; }
  this.getTargetEventName = function() { return this.TargetEventName; }
  this.setTargetEventName = function(targetEventName) { this.TargetEventName = targetEventName; }
  this.getCondition = function() { return this.Condition; }
  this.setCondition = function(Condition) { this.Condition = Condition; }
  this.sendEventToTarget = function(sourceEvent)
              {
                var sourceName = sourceEvent.getSource().getHtmlObjectName();
                var targetName = match(sourceName,this.getTarget());
                var SourceObj = sourceEvent.getSource();
                var TargetObj = getDataSet(this).findDataObj(targetName);
                //alert(targetName);
                if(this.getCondition())
                {  //alert(this.getCondition());
                   var b = eval(this.getCondition());
                   //alert(this.getCondition() +'---'+ b);
                   if (b==false)
                      return;
                }
                //将事件名称，源对象，参数列表作为参数调用目标对象receiveEvent方法
                //alert(TargetObj.getHtmlObjectName());
                if (TargetObj)
                {  //alert(TargetObj.getHtmlObjectName());
                   var event = new UIEvent(this.getTargetEventName(),sourceEvent.getSource(),sourceEvent.getWindowEvent());
                   TargetObj.triggerEvent(event );
                }
              }
}

/******************************************************************************
 *
 *  界面元素事件对象,在对象内部管理一个域对象数组。
 *
******************************************************************************/
function UIEvent(name,source,windowEvent)
{
   this.Name = null;    //事件名称
   this.Source = null;  //发起事件的对象
   this.WindowEvent = null; //事件参数数组
   if(name)
      this.Name = name;
   if(source)
      this.Source = source;
   if(windowEvent)
      this.WindowEvent = windowEvent;

   this.getName = function() { return this.Name;}
   this.setName = function(name) { this.Name = name;}
   this.getSource = function() { return this.Source;}
   this.setSource = function(source) {  this.Source = source;}
   this.getWindowEvent = function() { return this.WindowEvent;}
   this.setWindowEvent = function(windowEvent) {  this.WindowEvent = windowEvent;}
}
