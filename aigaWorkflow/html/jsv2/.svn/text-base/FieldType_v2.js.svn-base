function FieldTypeSetClass(xmlNode)
{
  this.Name = "";     //数据块的名称
  this.FullName = "";
  this.Title = null;    //数据块的标题
  this.Authority = null; //数据块的权限 N---新增 ,缺省为不能新增
  this.MainFieldName = null; //名称域的名称
  this.FieldList = new Array();//数据域类型列表
  this.FieldIndex = new Array();
  this.HasComputerField = false;
  this.NeedTotalFields = new Array(); //需要合计的域数组
  if (xmlNode)
  {
	    this.Name = xmlNode.attributes.getNamedItem("Name").nodeValue;
	this.FullName = xmlNode.attributes.getNamedItem("FullName").nodeValue;
	    this.Title = xmlNode.attributes.getNamedItem("Title").nodeValue;
	    this.MainFieldName = xmlNode.attributes.getNamedItem("MainField").nodeValue;
	    if (xmlNode.attributes.getNamedItem("Authority"))
	       this.Authority = xmlNode.attributes.getNamedItem("Authority").nodeValue

	    for(var i =0;i<xmlNode.childNodes.length;i++)
	{
	  var tmpNode = xmlNode.childNodes(i);
	  if (tmpNode.nodeName =="FieldList")
	  {
		for (var j=0;j<tmpNode.childNodes.length;j++){
		  this.FieldList[j] = new FieldType(this,tmpNode.childNodes(j));
		  this.FieldIndex[this.FieldList[j].getName()] = j;
		}

	  }
	    }

  }

  this.getClassName = function(){ return "FieldTypeSet";}
  this.getName = function()     {        return this.Name;        }
  this.getFullName = function()     {        return this.FullName;        }

  this.getTitle = function()    {        return this.Title;        }
  this.getMainFieldName = function()    {        return this.MainFieldName;        }

  this.getSameAttrNameFieldList = function(attrName)
  {  var result = new Array();
     if (!attrName || attrName == "") return result;
     for(var i=0;i<this.FieldList.length;i++)
       if(this.FieldList[i].getAttrName() == attrName)
	 result[result.length] = this.FieldList[i];
     return result;
  }
  this.getIndexByName = function(name){
     return this.FieldIndex[name] ;
  }
this.getNameById = function(id){
	if (this.FieldList)
	{
	    for (var i =0;i < this.FieldList.length;i++)   {
	     if (this.FieldList[i].ID == id)
		    return this.FieldList[i].getName();
	    }
	}
	return null;
}

this.free = function(){
	 alert("FieldTypeSet.free()还未完成！")
      }

this.count = function(){
	  return this.FieldList.length;
  }
this.getFieldByName = function(name){
            name = name.toUpperCase();
	    return this.FieldList[this.FieldIndex[name]];
    }

this.hasTotalRow = function(){
     if(this.NeedTotalFields.length >0)
       return true;
     else
       return false;
  }
this.addTotalField = function(name){
   var tmpfield = this.findTypeObj(name);
   this.NeedTotalFields[this.NeedTotalFields.length] = tmpfield;
}
this.isTotalField = function(aFieldName){
   for(var i=0;i<this.NeedTotalFields.length;i++)
    if (aFieldName == this.NeedTotalFields[i].getName())
      return true;
   return false;
}

this.addField = function(name,title,authority,editType,dataType,maxLength,decimal){
   if(!editType)
     editType = "DBLable";
   if (!dataType)
     dataType = S_DataType_Varchar;
   var tmpField = new FieldType(this);

   tmpField.ID = name;
   tmpField.Name = name;
   tmpField.Title = title;
   tmpField.Authority = authority;
   tmpField.EditType = new EditTypeClass();
   tmpField.EditType.Name = editType ;
   tmpField.DataType = DataTypeByName(dataType,maxLength,decimal);

   var index = this.FieldList.length;
   this.FieldList[index]  = tmpField;
   this.FieldIndex[tmpField.Name] = index;
  }


this.addComputerField = function(name,title,formual,dataType,maxLength,decimal){
   this.HasComputerField = true;
   var tmpComputerField = new FieldType(this);
   tmpComputerField.ID = name;
   tmpComputerField.Name = name;
   tmpComputerField.Title = title;
   tmpComputerField.IsComputerField = true;
   tmpComputerField.Formual = formual;
   tmpComputerField.Authority ="R";
   tmpComputerField.EditType = new EditTypeClass();
   tmpComputerField.EditType.Name = "DBLable" ;
   tmpComputerField.DataType = DataTypeByName(dataType,maxLength,decimal);

   var index = this.FieldList.length;
   this.FieldList[index]  = tmpComputerField;
   this.FieldIndex[tmpComputerField.Name] = index;

  }

}

/*
case "DBButton" :break;
	 case "DBLable" :break;
	 case "DBTitle": break;
	 case "DBEdit": break;
	 case "DBTextArea" :break;
	 case "DBListBox":    break;
	 case "DBCheckBox" :   break;
	 case "DBCheckBoxList" :  break;
	 case "DBText" : break;
	 case "DBListMutiple": break;
	 case "DBListText":    break;
	 case "DBRadioList": break;
	 case "DBListBox":    break;
	 case "DBDate" : break;
	 case "DBListBoxOth": break;
	 case "DBCheckBoxListOth": break;
	 case "DBRadioListOth": break;
	 case "DBLink":break;
	 case "DBPassword":break;
*/

function FieldType(parent,xmlNode)
{
	    this.ID = null;
	    this.Name =null;
	this.AttrName = null;
	this.Parent = null;
	    this.Title =null;
	    this.DefaultEditType = null ;//缺省为单行编辑框
	    this.DataType = "String";
	    this.DisDataType = "String";
       this.MaxLength = null;
       this.Decimal   =null;
	    this.Authority = true; //缺省为不可以修改
	    this.IsNull =true;
	this.IsPk = false;
	this.LinkOpName = null;
	this.DefaultValueId = null;
	this.DefaultValueText = null;
	this.ListDataSourceName = null;
	this.ListDataSourceDisColName = null;
	this.ChildDataSourceName = null;
	this.ChildDataSourceDisAttr = null;

	this.LinkOpName = null;

	 this.IsVisibled = true;
	 this.IsGridVisibled = true;
	 this.IsFormVisibled = true;

	 this.IsComputerField = false;  //是否计算域
	 this.Formual = "";             //计算表达式

	if(parent)
	   this.Parent = parent;
	if(xmlNode)
	{  var tmpNode;
	   for(var i=0;i< xmlNode.childNodes.length;i++)
	   {  tmpNode = xmlNode.childNodes(i);
	      switch (tmpNode.nodeName)
	      {
		      case "ID" : this.ID = tmpNode.text; break;
		      case "Name":
		      case "N" : //Name
			    this.Name = tmpNode.text.toUpperCase();
			    if (!this.AttrName)
				this.AttrName = this.Name;
			    break;
		      case "Title":
		      case "T" : this.Title = tmpNode.text; break; //Title
		      case "Authority" : {
			  if (tmpNode.text == "R")
			     this.Authority = false;
			  break;
		      }
		      case "IsNull" : if(tmpNode.text=="N") this.IsNull = false; else this.IsNull = true; break;
		      case "IsPk" : if(tmpNode.text=="Y") this.IsPk =true;else this.IsPk = false; break;
		      case "DataType":
		      case "Da" :{
			this.DataType = tmpNode.text;
			 if (tmpNode.attributes.getNamedItem("M"))
			     this.MaxLength = tmpNode.attributes.getNamedItem("M").nodeValue;
			 if (tmpNode.attributes.getNamedItem("D"))
			     this.Decimal = tmpNode.attributes.getNamedItem("D").nodeValue;
			break;
		      }
		      case "DisDataType" :  this.DisDataType =  tmpNode.text;break;
		      case "EditType":
		      case "Ed" :  {
			     this.DefaultEditType = tmpNode.text;
			     if (tmpNode.attributes.getNamedItem("CV"))
				 this.CV = tmpNode.attributes.getNamedItem("CV").nodeValue;
			     if (tmpNode.attributes.getNamedItem("UCV"))
				 this.UCV = tmpNode.attributes.getNamedItem("UCV").nodeValue;
			     break;//EditType
		      }
		     case "ListDataSource" :
			{
			   this.ListDataSourceName =  tmpNode.text;
			   if ( tmpNode.attributes.getNamedItem("DisAttr"))
			      this.ListDataSourceDisColName = tmpNode.attributes.getNamedItem("DisAttr").nodeValue;
			   break;
			}
		      case "ChildDataSource" :
			{
			   this.ChildDataSourceName =  tmpNode.text;
			   if ( tmpNode.attributes.getNamedItem("DisAttr"))
			      this.ChildDataSourceDisAttr = tmpNode.attributes.getNamedItem("DisAttr").nodeValue;
			   break;
			}
		      case "AttrName":
		      case "A":  this.AttrName =  tmpNode.text; break; //AttrName
		      case "DefaultValue":
		      {  this.DefaultValueText = tmpNode.text;
			 if ( tmpNode.attributes.getNamedItem("ID"))
			    this.DefaultValueId = tmpNode.attributes.getNamedItem("ID").nodeValue;

			 break;
		      }
		      case "LinkOp":
		      {
			      this.LinkOpName = tmpNode.text;
			      break;
		      }
		      case "FVisibled":
		      {
			      if (tmpNode.text && tmpNode.text == "N")
			      {
				this.IsVisibled = false;
				this.IsGridVisibled = false;
				this.IsFormVisibled = false;
			      }
			      break;
		      }
		      case "FormVisibled":
		      {
			      if (tmpNode.text && tmpNode.text == "N")
				this.IsFormVisibled = false;
			      else
				this.IsFormVisibled = true;
			      break;
		      }
		      case "GridVisibled":
		      {
			      if (tmpNode.text && tmpNode.text == "N")
				this.IsGridVisibled = false;
			      else
				this.IsGridVisibled = true;
			      break;
		      }
		      case "Formual":
		      {
			      this.Formual = tmpNode.text;
			      this.Parent.HasComputerField = true;
			      this.IsComputerField = true;
			      break;
		      }
		      /*********************end guankun --2002/12/25*********************************/
		      default: break;
		}
	   }
	}
	else
	  this.DefaultEditType = "DBEdit";//缺省为单行编辑框

	this.isVisibled = function(){       return this.IsVisibled;         }
	this.isFormVisibled = function(){   return this.IsFormVisibled;     }
	this.isGridVisibled = function(){    return this.IsGridVisibled;     }
	this.getClassName = function(){ return "FieldType";}

	this.getId = function()       { return this.ID;	}
	this.getName = function()     {        return this.Name;        }
	this.getAttrName = function()     {        return this.AttrName;        }
	this.getTitle = function()    {        return this.Title;        }

	this.getAuthority = function()    {        return this.Authority;        }
	this.setAuthority = function(authority){ this.Authority = authority;}

	this.getIsNull = function()    {        return this.IsNull;        }
	this.getIsPk = function()    {        return this.IsPk;        }
	this.getDataType = function()    {        return this.DataType;        }
	this.getMaxLength = function() { return this.MaxLength; }
	this.getDecimal = function() { return this.Decimal; }

	this.getDisDataType = function()    {        return this.DisDataType;        }

	this.getDefaultValueId = function() { return this.DefaultValueId;}
	this.setDefaultValueId = function(id) { this.DefaultValueId = id; }

	this.getDefaultValueText = function() { return this.DefaultValueText;}
	this.setDefaultValueText = function(text) { this.DefaultValueText = text; }


	this.getDefaultEditType = function()    {        return this.DefaultEditType;        }
	this.setDefaultEditType = function(editType){ this.DefaultEditType = editType;}

	this.getListDataSourceName = function()        {       return  this.ListDataSourceName;        }
	this.getListDataSourceDisColName = function(){return this.ListDataSourceDisColName;}
	this.getChildDataSourceName = function() { return this.ChildDataSourceName;}
	this.getChildDataSourceDisAttr = function() { return this.ChildDataSourceDisAttr;}

	this.getListDataTextById = function(aListDataSource,aId){
		//modified by hexg 20060615
		var reText =null;
		if(aListDataSource && this.ListDataSourceName){
		  var listsource = aListDataSource.find(this.ListDataSourceName);
				  if(listsource)
		     reText = listsource.findTextById(aId,this.ListDataSourceDisColName);
		}
		//if(reText==null)
		//  reText = "";
		return reText;
	 }

	this.getEditer = function (aRowSet,rowIndex,aListDataSource,aId,displayText){
		var obj = null;
	  var tmp_edit_type = (this.DefaultEditType).toLowerCase();

	  switch(tmp_edit_type){
	       case "dblable" :{ obj = DBLable(aId,displayText);break;}
	       case "dbtree": { obj = DBEditer(aId,displayText);break;}
	       case "dbedit": { obj = DBEditer(aId,displayText);break;}
	       case "dbeditdialog": { obj = DBEditDialog(aId,displayText);break;}
		   case "dbtextarea" :{obj =  DBTextArea(aId,displayText);break;}
	       case "dblistbox":{
		 		if(aListDataSource){
					var listsource = aListDataSource.find(this.ListDataSourceName);
					if(listsource)
			 			obj =  DBListBox(aRowSet,rowIndex,listsource,this.ListDataSourceDisColName,aId);
				}else
		     		alert("没有配置下拉数据源，请检查配置！");
		  		break;
	       }
	       case "dbcheckbox" :{obj = DBCheckBox(aId,this.CV,this.UCV); break;}
	       case "dbdate" :{
				   obj = DBDate(aId,displayText);break;}
	       case "dbdatetime" :{
					obj = DBDateTime(aId,displayText);break;}

		   case "dbpassword":{obj =DBPassword(aId,displayText);  break;}
	   }
	   if(obj!=null){
			obj.setDataType(this.getDataTypeObj());
		}

		return obj;
	}
	this.getDataTypeObj =function(){
	  if(!this.DataTypeObj)
	     this.DataTypeObj = DataType(this.DataType,this.MaxLength,this.Decimal);

		  return    this.DataTypeObj;
	}
	  this.checkKey = function(keyCode,str){  return this.getDataTypeObj().checkKey(keyCode,str);}
	  this.verify = function(value){
		    //检查是否可空
		    if ((this.IsNull == false)&&(((!value)||(value.length ==0))))
			{ alert("数据域《"+ this.Title +"》不能为空");
			return false;
		      }
		  if (this.getDataTypeObj().verify(value) == false)
		       return false;
		  else
			return true;
		  }
}


function DBCheckBox(aValue,aCheckValue,aUnCheckValue){
     var UIObject = document.createElement("input");
     UIObject.type = "checkbox";
     UIObject.UIType ="DBCheckBox";
     UIObject.CheckValue = aCheckValue;
     UIObject.UnCheckValue = aUnCheckValue;
     UIObject.getID = DBCheckBox_getID;
     UIObject.getValue = DBCheckBox_getValue;
     UIObject.setValue = DBCheckBox_setValue;
     UIObject.setDataType = AllEditor_setDataType;
	 UIObject.setRect = AllEditor_setRect;
	 UIObject.setEditable = DBCheckBox_setEditable;
    return UIObject;
}
function DBCheckBox_getID(){
  return this.getValue();
}
function DBCheckBox_getValue(){
  if(this.checked == true)
    return this.CheckValue;
  else
    return this.UnCheckValue;
}
function DBCheckBox_setValue(aId,displayText){

  if (aId == this.CheckValue)
    this.checked = true;
  else
    this.checked = false;

}

function DBCheckBox_setEditable(pFlag)
{
  if(pFlag)
	  this.disabled = false;
  else
	   this.disabled = true;
}

function DBEditer(id,displayText){
     var UIObject = document.createElement("input");
     UIObject.type ="text";
     UIObject.UIType ="DBEdit";
     UIObject.extendKeyPressEvent="";
     UIObject.value = id;
     UIObject.getID = DBEditer_getID;
     UIObject.getValue = DBEditer_getValue;
     UIObject.setValue = DBEditer_setValue;
     UIObject.setDataType = DBEditer_setDataType;
     UIObject.onkeypress  = AllEditor_checkKey;
     UIObject.setRect = AllEditor_setRect;
     return UIObject;
}
function DBEditer_getID(){ return this.value;}
function DBEditer_getValue(){ return this.value;}
function DBEditer_setValue(id,displayText){this.value = id;}
function DBEditer_setDataType(dataType){
   this.DataType = dataType;
   this.maxLength =  dataType.getMaxLength()  ;
  }

function DBEditDialog(id,displayText){
     var UIObject = document.createElement("input");
     UIObject.type ="text";
     UIObject.UIType ="DBEdit";
     UIObject.value = id;
     UIObject.getID = DBEditDialog_getID;
     UIObject.getValue = DBEditDialog_getValue;
     UIObject.setValue = DBEditDialog_setValue;
     UIObject.setDataType = DBEditDialog_setDataType;
     UIObject.onkeypress  = AllEditor_checkKey;
     UIObject.setRect = AllEditor_setRect;
     return UIObject;
}
function DBEditDialog_getID(){ return this.value;}
function DBEditDialog_getValue(){ return "";}
function DBEditDialog_setValue(id,displayText){this.value = id;}
function DBEditDialog_setDataType(dataType){
   this.DataType = dataType;
   this.maxLength =  dataType.getMaxLength()  ;
}




function DBPassword(id,displayText){
     var UIObject = document.createElement("input");
     UIObject.type ="password";
     UIObject.UIType ="DBPassword";
     UIObject.extendKeyPressEvent="";
     UIObject.value = id;
     UIObject.getID = DBPassword_getID;
     UIObject.getValue = DBPassword_getValue;
     UIObject.setValue = DBPassword_setValue;
     UIObject.setDataType = DBPassword_setDataType;
     UIObject.onkeypress  = AllEditor_checkKey;
	 UIObject.setRect = AllEditor_setRect;
     return UIObject;
}
function DBPassword_getID(){ return this.value;}
function DBPassword_getValue(){ return this.value;}
function DBPassword_setValue(id,displayText){this.value = id;}
function DBPassword_setDataType(dataType){
   this.DataType = dataType;
   this.maxLength = dataType.getMaxLength();
}



function DBTextArea(id,displayText){

	 var UIObject = document.createElement("textArea");
     UIObject.UIType ="DBTextArea";
     UIObject.style.overflowX="auto";
	 UIObject.style.overflowY="auto";
	 UIObject.value = id;
     UIObject.extendKeyPressEvent="";
     UIObject.getID = DBTextArea_getID;
     UIObject.getValue = DBTextArea_getValue;
     UIObject.setValue = DBTextArea_setValue;
     UIObject.setDataType = AllEditor_setDataType;
     UIObject.onkeypress  = AllEditor_checkKey;
	 UIObject.setRect = AllEditor_setRect;
     return UIObject;
}
function DBTextArea_getID(){ return this.value;}
function DBTextArea_getValue(){ return this.value;}
function DBTextArea_setValue(id,displayText){this.value = id;}


function DBDate(id,displayText){

	var UIObject = document.createElement("div");
	UIObject.style.display = "inline-block";
	UIObject.UIType ="DBDate";
	       UIObject.value = id;
	var inHtmlArray = new Array();
	inHtmlArray[inHtmlArray.length] ="<input type='text' onkeypress='DBDate_textkeypress()' onfocusout=\"DBDate_textonfocusout(this);\" value='";
	inHtmlArray[inHtmlArray.length]= id;
	inHtmlArray[inHtmlArray.length] = "'/><input type='button' style='width:25' value='->' onfocusout='DBDate_btnfocusout()'/>";

	UIObject.innerHTML= inHtmlArray.join("");

	UIObject.getID = DBDate_getID;
	UIObject.getValue = DBDate_getValue;
	UIObject.setValue = DBDate_setValue;
    UIObject.setDataType = AllEditor_setDataType;
	UIObject.setRect = DBDate_setRect;
	UIObject.onclick = DBDate_onClick;
	UIObject.onfocusout = DBDate_focusout;
	UIObject.onfocus = DBDate_onfocus;

    UIObject.select = DBDate_onSelect;
	return UIObject;
 }
function DBDate_getID(){ return this.value;}
function DBDate_getValue(){ return this.value;}
function DBDate_setValue(id,displayText){this.value = id; this.childNodes(0).value = this.value;}
function DBDate_setRect(pWidth,pHeight)
{
  if(pWidth && parseInt(pWidth,10)>25)
	{
	  this.childNodes(0).style.width = pWidth-25;
	  this.childNodes(0).style.height = pHeight;
	  this.childNodes(1).style.height = pHeight;
	}
  else
	{
      this.childNodes(0).style.width = 0;
	  this.childNodes(0).style.height = pHeight;
	  this.childNodes(1).style.height = pHeight;

	}
}
function DBDate_onClick()
{
  if(window.event.srcElement && window.event.srcElement.type=='button')
    {
       var dlgLeft = event.screenX;
       var dlgTop = event.screenY;
       var oldDate = event.srcElement.parentNode.getValue();
       var paramObj = {showtype:"date",definedate:oldDate};
	   var newDate = window.showModalDialog(_gModuleName + "/jsv2/DBCalendarDlg.htm",oldDate,"scroll:no;resizable:no;status:no;dialogLeft:"+dlgLeft+";dialogTop:"+dlgTop+";dialogHeight:280px;dialogWidth:230px");
       if (newDate!="none")
       {
	  event.srcElement.parentNode.setValue(newDate);
	  event.srcElement.parentNode.childNodes(0).value = event.srcElement.parentNode.value;

       }
	    event.srcElement.parentNode.childNodes(0).focus();
    }

}
function DBDate_textonfocusout(textObj)
{

  //检验日期有效性：
  var re = DBDate_verifyDate(textObj);
  if(re)
	{
	    textObj.parentNode.setValue(textObj.value);
	}



}
function DBDate_onSelect(){
  this.childNodes(0).select();
}

function DBDate_onfocus(){
  this.childNodes(0).focus();
  this.childNodes(0).select();
}
function DBDate_btnfocusout()
{

  window.event.cancelBubble = true;
  window.event.returnValue = null;


}

function DBDate_focusout()
{
	var obj = window.event.srcElement;
	var toObj = window.event.toElement;
	//alert(this.childNodes(0));
	if(toObj==this.childNodes(0) || toObj == this.childNodes(1))
	{
      window.event.cancelBubble = true;
	  window.event.returnVal = null;
	}
	else
	{
      window.event.cancelBubble = false;
	  window.event.returnVal = true;
	}

}

function DBDate_textkeypress()
{
  if ((event.keyCode<48||event.keyCode>57) && (event.keyCode !=27) && (event.keyCode !=47) && (event.keyCode !=45) && (event.keyCode !=13)) {
    event.returnValue = false;
  }
  //alert("aa");
}
function DBDate_verifyDate(aObj)
{
  var cDate = aObj.value;
  var sError = "日期输入格式不正确,应输入形如 2005"+
  	DATE_SEPARATOR +"06"+DATE_SEPARATOR+"01格式的数据";
  if(!g_IsDate(cDate)){
  	alert(sError);
  }
  return true;
}
var DBCalendar_gBegin=[1950,1,1];	// 日历显示的最早日期[Year,Month,Date]
var DBCalendar_gEnd=[2050,12,31];	// 日历显示的最后日期 [Year,Month,Date]
function DBDate_valDate(Y, M, D)
{
  var Months= new Array(31,28,31,30,31,30,31,31,30,31,30,31);
  var Leap = false;
  if ((Y < DBCalendar_gBegin[0]) || (Y > DBCalendar_gEnd[0]))
  {
    sError = "输入年份必须在"+DBCalendar_gBegin[0]+"--"+DBCalendar_gEnd[0]+"之间.";
    return(sError);
  }
  if((Y % 4 == 0) && ((Y % 100 != 0) || (Y %400 == 0)))
    Leap = true;
  if((D < 1) || (D > 31) || (M < 1) || (M > 12) || (Y < 0))
    return("");
  if((D > Months[M-1]) && !((M == 2) && (D > 28)))
     return("");
  if(!(Leap) && (M == 2) && (D > 28))
     return("");
  if((Leap) && (M == 2) && (D > 29))
    return("");
  return true;
}



function DBDateTime(id,displayText){

	var UIObject = document.createElement("div");
	UIObject.style.display = "inline-block";
	UIObject.UIType ="DBDateTime";
	       UIObject.value = id;
	var inHtmlArray = new Array();
	inHtmlArray[inHtmlArray.length] ="<input type='text' onkeypress='DBDate_textkeypress()' onfocusout=\"DBDateTime_textonfocusout(this);\" value='";
	inHtmlArray[inHtmlArray.length]= id;
	inHtmlArray[inHtmlArray.length] = "'/><input type='button' style='width:25' value='->' onfocusout='DBDate_btnfocusout()'/>";

	UIObject.innerHTML= inHtmlArray.join("");

	UIObject.getID = DBDate_getID;
	UIObject.getValue = DBDate_getValue;
	UIObject.setValue = DBDate_setValue;
    UIObject.setDataType = AllEditor_setDataType;
	UIObject.setRect = DBDate_setRect;
	UIObject.onclick = DBDateTime_onClick;
	UIObject.onfocusout = DBDate_focusout;
	UIObject.onfocus = DBDateTime_onfocus;

	UIObject.select = DBDate_onSelect;
	return UIObject;
 }
function DBDateTime_onfocus(){
  this.childNodes(0).focus();
  this.childNodes(0).select();
}
function DBDateTime_onClick()
{
  if(window.event.srcElement && window.event.srcElement.type=='button')
    {
       var dlgLeft = event.screenX;
       var dlgTop = event.screenY;
       var oldDate = event.srcElement.parentNode.getValue();
       var paramObj = {showtype:"datetime",definedate:oldDate};
       var newDate = window.showModalDialog(_gModuleName + "/jsv2/DBCalendarDlg.htm",paramObj,"scroll:off;resizable:no;status:no;dialogLeft:"+dlgLeft+";dialogTop:"+dlgTop+";dialogHeight:320px;dialogWidth:240px");
       if (newDate!="none")
       {
	     event.srcElement.parentNode.setValue(newDate);
	     event.srcElement.parentNode.childNodes(0).value = event.srcElement.parentNode.value;

       }
	   event.srcElement.parentNode.childNodes(0).focus();
    }

}
function DBDateTime_textonfocusout(textObj)
{

  //检验日期有效性：
  var re = DBDateTime_vertifyDateTime(textObj.value)
  if(re)
	{
	    textObj.parentNode.setValue(textObj.value);
	}

}
function DBDateTime_vertifyDateTime(str)
{
  if(str!=null && str.length==0){
   return;
  }
  var sError = "日期时间输入格式不正确,应输入形如 2005"+
  	DATE_SEPARATOR +"06"+DATE_SEPARATOR+"01 23:34:02格式的数据";

  if(DATE_SEPARATOR==null) DATE_SEPARATOR ="-";
   var regExpStr = "^\\d{4}" + DATE_SEPARATOR + "\\d{1,2}" + DATE_SEPARATOR + "\\d{1,2}\\s\\d{2}:\\d{1,2}:\\d{1,2}$";
   var patrn = new RegExp(regExpStr);

   if(!patrn.exec(str)) {
	   alert(sError);
	   return false;
   }
   var dateTimeArray = str.split(" ");
   if(dateTimeArray==null || dateTimeArray.length!=2)
	{
	   alert(sError);
	   return false;
	}
   var dateArray  = dateTimeArray[0].split(DATE_SEPARATOR);
   var timeArray = dateTimeArray[1].split(":");
   var d= new Date(dateArray[0],dateArray[1]-1,dateArray[2],timeArray[0],timeArray[1],timeArray[2]);
   var issame =(d && (d.getFullYear()==dateArray[0])&& (d.getMonth()+1==dateArray[1]) &&(d.getDate()==dateArray[2]) && (d.getHours() == timeArray[0]) && (d.getMinutes()== timeArray[1]) && (d.getSeconds()== timeArray[2])  );
   if (!issame)
       {
         alert(sError);
		 return false;
       }
   if(parseInt(d.getFullYear())< 1950 || parseInt(d.getFullYear())>2050)
	{
	  alert("输入年份必须在1950--2050之间.")
	  return false;
	}
   return true;
}










function DBLable(id,displayText){
     var UIObject = document.createElement("input");
     UIObject.type ="text";
     UIObject.UIType ="DBLable";
     UIObject.readOnly = true;
     UIObject.style.backgroundColor = "#ADD8E6";
      if(displayText==null || displayText=="")
		 displayText = id;
	 UIObject.value = displayText;
     UIObject.getID = DBLable_getID;
     UIObject.getValue = DBLable_getValue;
     UIObject.setValue = DBLable_setValue;
     UIObject.setDataType = AllEditor_setDataType;
	 UIObject.setRect = AllEditor_setRect;
     return UIObject;
}
function DBLable_getID(){ return this.id;}
function DBLable_getValue(){ return this.value;}
function DBLable_setValue(id,displayText)
{
  if(displayText==null || displayText=="")
	  displayText = id;
  this.value = displayText;
}



function DBListBox(aRowSet,rowIndex,aListSource,aDisColName,id,displayText){
     var UIObject = document.createElement("select");
     UIObject.UIType ="DBListBox";
     aListSource.fillListBox(aRowSet,rowIndex,UIObject,aDisColName,id);
     UIObject.getID = DBListBox_getID;
     UIObject.getValue = DBListBox_getValue;
     UIObject.setValue = DBListBox_setValue;
     UIObject.setDataType = AllEditor_setDataType;
	 UIObject.setRect = AllEditor_setRect;
    return UIObject;
}
function DBListBox_getID(){
      if(this.selectedIndex<0) return "";
	    var selectOption = this.options(this.selectedIndex);
	if((selectOption) &&(selectOption.value))
	    return selectOption.value;
	 return "";

 }
function DBListBox_getValue(){
      if(this.selectedIndex<0) return "";
	  var selectOption = this.options(this.selectedIndex);
      if (selectOption)
	return selectOption.text
      else
	return "";
}
function DBListBox_setValue(id,displayText){
   if (id || id ==0 ){
     for(var i=0;i<this.options.length;i++){
       if(this.options[i].value == id || (!this.options[i].value) && this.options[i].text ==id){
	 this.options[i].selected = true;
	 return;
       }
     }
   }
   else if(this.options.length>=1){
	 this.selectedIndex = 0;
      }
   else
	{
	  this.selectedIndex = -1;
	}
}

//公共函数
function AllEditor_setDataType(dataType){
   this.DataType = dataType;
}
function AllEditor_checkKey()
{
  var keyCode = window.event.keyCode;
  if(this.DataType){
       var b = this.DataType.checkKey(keyCode,this.getValue()) ;
       if ( b== false){
	 window.event.returnValue = false;
	 return ;
       }
       if((this.UIType != "DBTextArea")&&(g_GetStrLen(this.getValue() + String.fromCharCode(keyCode)) > this.DataType.getMaxLength())){
	 window.event.returnValue = false;
	 return ;
       }
  }
  if(this.extendKeyPressEvent!=null && this.extendKeyPressEvent!="")
  {
     eval(this.extendKeyPressEvent);
  }
}


function AllEditor_setRect(pWidth,pHeight)
{
  if(pWidth && parseInt(pWidth,10)>0)
     this.style.pixelWidth=pWidth;
  if(pHeight && parseInt(pHeight,10)>0)
     this.style.pixelHeight = pHeight;

}


