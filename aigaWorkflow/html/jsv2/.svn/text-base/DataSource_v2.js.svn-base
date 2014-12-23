 /**
	文件名称：DataSource.js
	作者	: 墙 辉
	编制时间: 2002-09-10
	文件内容：所有关于WEB页面数据处理对象定义
	包括对象：
		ListDataSourceFactory：	下拉列表数据源管理器
		ListDataSource：	下拉列表数据源
		ListDataSourceDynamic  动态下拉列表数据源
		ListDataSourceStatic  静态下拉列表数据源
                ListDataSourceRowSet  静态下拉列表数据源
		SourceParameterParameter  数据源参数对象
       refreshListBox(aListBoxId,aDsId,aCondition,aValue):刷新下拉列表框数据
       　　　　aListBox：下来数据源标识
       　　　　aDsId：DS名称
              aCondition：查询条件
              aValue：缺省值
              hasNull:是否有空值
              nullId:空值ID
              nullText:空值描述
**/
var gListSrcQueryURL = _gModuleName + "/listdatasourcequery";

function refreshListBox(aListBoxId,aCondition,aValue,hasNull,nullId,nullText){
  var listbox = document.all(aListBoxId);
  var source = createStaticListDataSource(listbox.ds,aCondition,hasNull,nullId,nullText);
  source.fillListBox(null,0,listbox,"",aValue);
}
function createStaticListDataSource(aDsId,aCondition,hasNull,nullId,nullText){
    var tUrl = gListSrcQueryURL + "?eventid=static&dsid=" + aDsId;
    if (aCondition)
      tUrl = tUrl + "&" + aCondition;
    if(hasNull){
      tUrl = tUrl + "&hasNull=true";
    }
    if(nullId){
      tUrl = tUrl + "&nullId=" + nullId;
    }
    if(nullText){
      tUrl = tUrl + "&nullText=" + nullText;
    }
    var xml= new ActiveXObject("Msxml.DOMDocument");
    xml.async = false;
    var b = xml.load(tUrl);
    var xmlNode = xml.documentElement;
    return new ListDataSourceStatic(null,xmlNode);
}
/**
  下拉列表数据源管理器
**/

function ListDataSourceFactory(XmlNode)
{
  this.List = new Array();
  this.RowSet = null;
  if(XmlNode)
  {// alert('ListDataSourceFactory');
     this.List = new Array(XmlNode.childNodes.length);
     for (var i=0 ;i< XmlNode.childNodes.length ;i++)
       	this.List[i] = new ListDataSource(this,XmlNode.childNodes(i));
  }
  this.getRowSet = function() { return this.RowSet;}
  this.setRowSet = function(rowSet) { this.RowSet = rowSet;}
  this.active = function()
  {
     for(var i =0;i< this.List.length;i++)
         this.List[i].active();
  }
  this.count = function()
  {  if(this.List)
  	return this.List.length;
     else
        return 0;
  }
  this.get = function(i)
  { if((this.List)&&(i>=0)&&(i <this.List.length))
       return this.List[i];
    else
       return null;
  }
  this.find = function(name)
  {
     for(var i =0;i< this.List.length;i++)
     { if (this.List[i].getName() == name)
         return this.List[i];
     }
     return null;
  }
  this.replace = function(aListDataSource){
     if (aListDataSource == null) return;
     var name = aListDataSource.getName();
     for(var i =0;i< this.List.length;i++)
     { if (this.List[i].getName() == name)
         this.List[i] = aListDataSource;
     }
  }
}

/**
  下拉列表数据源
**/
function ListDataSource(factory,xmlNode)
{
  var S_TYPE_STATIC = "Static"; //数据在xml中提供
  var S_TYPE_DYNAMIC = "Dynamic"; //数据需要根据动态条件从服务器中取得。
  var type =S_TYPE_STATIC;
  var obj = null;

  if (xmlNode)
  { if((xmlNode.attributes.getNamedItem("Type")) &&(xmlNode.attributes.getNamedItem("Type").nodeValue
            == S_TYPE_DYNAMIC))
  	type = S_TYPE_DYNAMIC ;
     if (type == S_TYPE_STATIC)
       obj = new ListDataSourceStatic(factory,xmlNode);
     else
       obj = new ListDataSourceDynamic(factory,xmlNode);
  }
  return obj;
}
/**
  数据源参数对象
**/
function SourceParameter(factory,xmlNode)
{
   this.Name = null;      //参数传递给服务器时使用的名称
   this.FetchCode = null; //该参数从那一个数据域中获取
   this.Value = null; //参数值 可能直接在XML中传入了缺省的值
   this.TYPE_FIELD ="Field";
   this.TYPE_CONST ="Const";
   this.Type = this.TYPE_FIELD;
   this.Factory = factory;
   if(xmlNode)
   {
     this.Name =xmlNode.attributes.getNamedItem("Name").nodeValue;
     if (xmlNode.attributes.getNamedItem("Type"))
        this.Type =xmlNode.attributes.getNamedItem("Type").nodeValue;

     if (xmlNode.attributes.getNamedItem("Value"))
     {
       if(this.Type == this.TYPE_CONST)
          this.Value = xmlNode.attributes.getNamedItem("Value").nodeValue;
       else
         this.FetchCode = xmlNode.attributes.getNamedItem("Value").nodeValue;
     }
   }
   this.getValue = function() { return this.Value ;}
   this.getName = function() { return this.Name; }
   
   this.getNewValue =function(aRowSet,rowIndex)
    {  if (this.Type == this.TYPE_CONST)
          return this.Value;
        return aRowSet.getValuePrivate(rowIndex,this.FetchCode);
    }
   this.isValid = function(aRowSet,rowIndex)
   {
     return this.getValue() ==  this.getNewValue(aRowSet,rowIndex) ;
   }
}
/******************************************************************************
*
*   动态下拉列表数据源
*
******************************************************************************/
function ListDataSourceDynamic(factory,xmlNode)
{
  this.ListDataSourceType="Dynamic";//addbyzr at 2007-5-22。区别list是动态还是静态下拉数据源
  this.Name ="-1";
  this.Title = "";
  this.EditTypeId = null;
  this.ParameterList = new Array();  //动态数据源的参数列表（数组）
  this.options =  new Array();
  this.LinkObjs = new Array();
  this.GroupCols = null;
  this.Cols = null;
  this.Timestamp = new Date();
  //gk add 2004-2-11
  this.hasNull = "N";
  this.nullId = "";
  //end gk add 2004-02-11
  this.Factory = factory;
  if (xmlNode)
  {
     this.Name = xmlNode.attributes.getNamedItem("Name").nodeValue;
     this.Title =   xmlNode.attributes.getNamedItem("Title").nodeValue;
     if ( xmlNode.attributes.getNamedItem("Cols"))
         this.Cols = splitString( xmlNode.attributes.getNamedItem("Cols").nodeValue,",");
     if ( xmlNode.attributes.getNamedItem("GroupCols"))
        this.GroupCols = splitString( xmlNode.attributes.getNamedItem("GroupCols").nodeValue,",");

     for(var i=0;i<xmlNode.childNodes.length;i++)
     {  if (xmlNode.childNodes[i].nodeName == "ListDataSource"){
            this.EditTypeId = xmlNode.childNodes[i].attributes.getNamedItem("ID").nodeValue;
            if ( xmlNode.childNodes[i].attributes.getNamedItem("NullFlag")
                && xmlNode.childNodes[i].attributes.getNamedItem("NullFlag").nodeValue=='Y'){
                   this.hasNull = 'Y';
                   if ( xmlNode.childNodes[i].attributes.getNamedItem("NullID"))
                          this.nullId = xmlNode.childNodes[i].attributes.getNamedItem("NullID").nodeValue;
            }
        }else if (xmlNode.childNodes[i].nodeName == "ListParameter")
            this.ParameterList[this.ParameterList.length] = ( new SourceParameter(factory,xmlNode.childNodes[i]));
     }
  }
  this.getName =ListDataSource_getName;
  this.getTitle = ListDataSource_getTitle;
  this.linkObj = ListDataSource_linkObj;
  this.removeLink = ListDataSource_removeLink;
  this.active = ListDataSource_active;
  this.getOptions = ListDataSource_getOptions;
  this.findTextById = ListDataSource_findTextById;
  this.findIdByText = ListDataSource_findIdByText;
  this.fillListBox  = ListDataSource_fillListBox;
  this.clear = ListDataSource_clear;
  this.addOption=ListDataSource_addOption;
  //---add by zhouQiqi----2008-08-29---
  this.removeOption = ListDataSource_removeOption;
  //---end-----------------------------
  this.isValid = function(aRowSet,rowIndex)
  {
    for(var i=0;i<this.ParameterList.length;i++)
       if (this.ParameterList[i].isValid(aRowSet,rowIndex) == false)
           return false;
     return true;
  }
  this.refresh = function(aRowSet,rowIndex)
  {
    if (this.isValid(aRowSet,rowIndex) == true)
       return;
    //---------------------------- 取服务器数据

    var str = "<?xml version='1.0' encoding='GB2312'?> \n";
    if (this.hasNull == "N")
      str += "<ListDataSource ID='" + this.EditTypeId +"' >"
    else
      str += "<ListDataSource ID='" + this.EditTypeId +"$"+this.hasNull+"$"+this.nullId+"' >"

    for(var i=0;i<this.ParameterList.length;i++)
    {
       this.ParameterList[i].Value = this.ParameterList[i].getNewValue(aRowSet,rowIndex);
       if(!this.ParameterList[i].Value)
         return;
       str +="<Parameter Name='"+ this.ParameterList[i].getName()  +"' Value='"+ this.ParameterList[i].Value +"'/>";
    }
    str +="</ListDataSource>";


    var reStr = PostInfotoServer(gListSrcQueryURL + "?eventid=dynamic" ,str);
    var xmlNode =getXmlNodeFromStr(reStr);
   //--------------------------------
    this.options = ListDataSource_fillOptions(xmlNode,this.Cols);
    this.Timestamp = new Date();
  }
}
/**
  静态下拉列表数据源
**/
function ListDataSourceStatic(factory,XmlNode)
{
  this.ListDataSourceType="Static";//addbyzr at 2007-5-22。区别list是动态还是静态下拉数据源
  this.Name ="-1";
  this.Title = "";
  this.GroupCols = null;
  this.Cols = null;
  this.LinkObjs = new Array();
  this.options =  new Array();
  this.IsValid = false;
  this.Factory = factory;
  if (XmlNode)
  {
     this.Name = XmlNode.attributes.getNamedItem("Name").nodeValue;
     if (XmlNode.attributes.getNamedItem("Title"))
       this.Title =XmlNode.attributes.getNamedItem("Title").nodeValue;
     if ( XmlNode.attributes.getNamedItem("Cols"))
         this.Cols = splitString( XmlNode.attributes.getNamedItem("Cols").nodeValue,",");
     if ( XmlNode.attributes.getNamedItem("GroupCols"))
        this.GroupCols = splitString( XmlNode.attributes.getNamedItem("GroupCols").nodeValue,",");
     this.options = ListDataSource_fillOptions(XmlNode,this.Cols);
  }
  this.getName =ListDataSource_getName;
  this.setName =ListDataSource_setName;
  this.getTitle = ListDataSource_getTitle;
  this.isValid = function() { return this.IsValid;}
  this.linkObj = ListDataSource_linkObj;
  this.removeLink = ListDataSource_removeLink;
  this.active = ListDataSource_active;
  this.getOptions = ListDataSource_getOptions;
  this.findTextById = ListDataSource_findTextById;
  this.findIdByText = ListDataSource_findIdByText;
  this.fillListBox  = ListDataSource_fillListBox;
  this.clear = ListDataSource_clear;
  this.addOption=ListDataSource_addOption;
  //---add by zhouQiqi----2008-08-29---
  this.removeOption = ListDataSource_removeOption;
  //---end-----------------------------
}
/******************************************************************************
*
* ListDataSourceRowSet：从数据集中建立Option选项的对象
*
******************************************************************************/
function ListDataSourceRowSet(factory,name,title,rowSet,textFieldTypeName,idFieldTypeName)
{
  this.Factory = factory;
  this.Name = name;
  this.Title = title
  this.RowSet = rowSet;
  this.TextFieldTypeName =  textFieldTypeName;
  this.IdFieldTypeName = idFieldTypeName;
  this.getName =ListDataSource_getName;
  this.getTitle = ListDataSource_getTitle;
  this.linkObj = ListDataSource_linkObj;
  this.removeLink = ListDataSource_removeLink;
  this.active = ListDataSource_active;
  this.fillListBox  = ListDataSource_fillListBox;
  this.clear = ListDataSource_clear;
  this.addOption=ListDataSource_addOption;
  //---add by zhouQiqi----2008-08-29---
  this.removeOption = ListDataSource_removeOption;
  //---end-----------------------------
  this.getOptions = function()
            {
              var result = new Array();
              if(this.RowSet.getActive() == false) return result;
              var tmpOption = null;
              tmpOption = new Option();
              tmpOption.value = "-1";
              tmpOption.text ="";
              result[result.length] = (tmpOption);
              var rowcount = this.RowSet.count();
              var textCol,idCol;
              for(var i=0;i<rowcount;i++)
              {
                tmpOption = new Option();
                textCol = this.RowSet.get(i).findDataObj(this.TextFieldTypeName);
                if (textCol)
                {   tmpOption.text = textCol.getValue();
                    if (this.IdFieldTypeName)
                    {
                       idCol = this.RowSet.get(i).findDataObj(this.IdFieldTypeName);
                       if(idCol)
                          tmpOption.value = idCol.getValue();
                    }
                    result[result.length] = (tmpOption);
                }
              }
              return result;
            }
}

function ListDataSource_getName()  { return this.Name;  }
function ListDataSource_setName(newName){this.Name=newName;}
function ListDataSource_getTitle()  { return this.Title;  }
function ListDataSource_linkObj(obj)
        { if(this.LinkObjs==null)
             this.LinkObjs=new Array();
             this.LinkObjs[this.LinkObjs.length]=obj;
             if(this.Active==true)
                obj.refreshOption();
         }
function ListDataSource_removeLink(obj)
        {var a=this.LinkObjs;
         for(var i=0;i<a.length;i++)
            if(a[i]==obj)
            {  this.LinkObjs=arrayRemove(a,i);
               break;
            }
        }
function ListDataSource_active()
{
      for(var i=0;i<this.LinkObjs.length;i++)
      {
        this.LinkObjs[i].ReloadOption();
      }
}

function ListDataSource_clear(){
  this.options.length =0;
}

function ListDataSource_addOption(value,text){
	var optionArr=this.options;
	tmpOption = new Option();
    tmpOption.Id=value;
    tmpOption.Text=text;
    optionArr[optionArr.length]=tmpOption;
}

//---add by zhouQiqi----2008-08-29---
//---delete option by id--------------------
function ListDataSource_removeOption(id){
  var newArr=new Array();
  for(var i = 0 ;i<this.options.length;i++)
  {
    if(this.options[i].Id!=id)
    {
      newArr.push(this.options[i])
    }
  }
  this.options=newArr;
}
//---end-----------------------------

function ListDataSource_fillListBox(aRowSet,rowIndex,aListBox,aDisColName,aValue){

    if (this.refresh) this.refresh(aRowSet,rowIndex);
    aListBox.options.length =0;

    var tmpOption = null;
    var index;
    var isFind = false;
	var selIndex = 0;

    if ((this.options)&&(this.options.length >0))
    {
      for(var i=0;i<this.options.length;i++)
      {  tmpOption = new Option();
         tmpOption.value = this.options[i].Id;
         if (!aDisColName)
            tmpOption.text = this.options[i].Text;
         else{
             index = indexOfArray(this.Cols,aDisColName);
             if (index>=0)
               tmpOption.text = this.options[i].DataCols[index];
         }
         if( isFind == false && aValue == tmpOption.value ){
           selIndex = i
           isFind = true;
         }else
           tmpOption.selected = false;
         aListBox.options.add(tmpOption);
      }
	  aListBox.selectedIndex = selIndex;
    }
}


function ListDataSource_getOptions(DisColName)
{   if (this.refresh) this.refresh();
    var result = new Array();
    var tmpOption = null;
    var index
    if ((this.options)&&(this.options.length >0))
    { for(var i=0;i<this.options.length;i++)
      {  tmpOption = new Option();
         tmpOption.value = this.options[i].Id;
         if (!DisColName)
            tmpOption.text = this.options[i].Text;
         else
         {   index = indexOfArray(this.Cols,DisColName);
             if (index>=0)
               tmpOption.text = this.options[i].DataCols[index];
         }
         result[result.length] = (tmpOption);
      }
    }
    return result;
}
//----------------------guankun 2003-03-24修改-------------
function ListDataSource_findIdByText(aText,aDisColName)
{
  if (this.options == null) return null;
  var haveId = false;
  if ((this.options.length >0)&&(this.options[0].Id))
    haveId = true;

   for(var i =0;i< this.options.length;i++)
   {
     if (aDisColName){
     var tmpIndex = indexOfArray(this.Cols,aDisColName);
     if (tmpIndex < 0) {
     	alert("字段" + aDisColName + "不存在!");
     	return null;
     }else{
       if (this.options[i].DataCols[tmpIndex] == aText){
       	  return this.options[i].Id;
       	}
     }
    } // end aDisColName != null;
    else { //和Text匹配
      //alert(this.options[i].Text + " && aText = " + aText);
      if (this.options[i].Text == aText){
      	  return this.options[i].Id;
      	}
    }
   } // end for
   return null;
}
//end ----------------------guankun 2003-03-24修改-------------
function ListDataSource_findTextById(id,disColName)
{
  if (this.options == null) return null;
  var haveId = false;
  //modify by qianghui
  //if ((this.options.length >0)&&(this.options[0].Id))
  if ((this.options.length >0)&&((this.options[0].Id)||(this.options[0].Id =="")))
    haveId = true;

  for(var i =0;i< this.options.length;i++)
   { if (((haveId)&&(this.options[i].Id == id)) || (!haveId) && (this.options[i].Text == id))
     { if (!disColName){
     	  return this.options[i].Text;
        }
       else
       {  var index = indexOfArray(this.Cols,disColName);

          if (index>=0)
            return this.options[i].DataCols[index];
       }
     }
   }
   return null;
}
function ListDataSource_fillOptions(XmlNode,cols)
{ var result = new Array();
  var tmpNode;
  var tmpOption = null;
  var haveId = false;
  var haveCols = false;
  if ((cols)&&(cols.length >0))
     haveCols = true;

  if ((XmlNode.childNodes.length >0) && (XmlNode.childNodes[0].attributes.getNamedItem("I")))
    haveId = true;
  var colIndex = 0;
  for(var i=0;i<XmlNode.childNodes.length;i++)
  {  tmpNode = XmlNode.childNodes(i);
     tmpOption = new AIOption();
     if(haveId)
        tmpOption.Id = tmpNode.attributes.getNamedItem("I").nodeValue;
     tmpOption.Text = tmpNode.attributes.getNamedItem("T").nodeValue;
     if(haveCols == true)
     {
        tmpOption.DataCols = new Array(cols.length);
        for(var j=0;j<tmpNode.childNodes.length;j++)
        { colIndex = indexOfArray(cols,tmpNode.childNodes(j).attributes.getNamedItem("Name").nodeValue);
         // alert(colIndex +'---' + tmpNode.childNodes(j).attributes.getNamedItem("Name").text);
          tmpOption.DataCols[colIndex] = tmpNode.childNodes(j).text;
        }
     }
     result[result.length] = (tmpOption);
  }
  return result;
}
function AIOption()
{
  this.Id = null;
  this.Text = null;
  this.DataCols = null;
}

