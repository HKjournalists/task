/**  
 　
 　作者 ： 钟锐   2005/09/23

 　使用范例　：　FormDemo.jsp
   FormRowSetManager ：Form数据集管理器。对页面内的所有表格组件进行管理。
      构造方法：在页面加载时自动创建。
      开发人员可以使用的方法：
	get(pk)：根据Form数据数据集的唯一标识获取Form数据集对象。
      其它方法：
	push(formRowSet):向管理器中增加一个Form数据集。
	remove(pk)：删除一个数据集对象。
      用法说明：
	开发人员只能使用get(pk)方法获取Form数据对象，然后调用数据对象的相关方法。例如：
	  var rowset = g_FormRowSetManager.get("staff");


   FormRowSet： 表单数据集组件
      构造方法：通过AIDBFormTag类构造HTML文本
      开发人员可以使用方法：
	isEditable() form是否可编辑，如果form的每一个字段都不可编辑，return false，否则返回true
	isColEditable(fieldname) form的某个字段是否可编辑
	setEditSts(value)　：　设置表格的编辑状态　value = true(可编辑),false(不可编辑)
	setColEditSts(fieldName,value)：根据列名设置列的可编辑属性 value = true(可编辑),false(不可编辑)
	getValue(fieldName)：获取指定单元的数据值
	getDisplayText(fieldName)：获取指定单元的显示值
    
    
    getFormRowSetInfo()返回当前FORMROWSET的基本信息，是一个属组，每个数组中的值为每个字段的
                    英文名、中文名、状态、老值和新值、老的显示值和新的显示值，下面是每个属性的名称：
                  fieldName:英文名,fieldTitle:中文名,fieldSts:状态,
                  oldValue:老值 ,newValue:新值,oldText:老的显示值,newText:新的显示值
                  如var arr = formRowSet.getFormRowSetInfo();
                  alert(arr[0].fieldName)
	setValue(fieldName,value,Text)：根据行号，列名设置数据值, value数据值 text显示值
	toXmlString(flag)：将数据转化为Xml字符串。flag==true（默认）只将改动的内容转换为xml，false将所有老内容转换为xml。
	setStsToOld()：设置form数据集状态为“O”为老数据
	setStsToDel()：设置form数据集合的状态未删除状态
	setStsToNew():设置form数据集合为新增行状态，如果原字段有值，该字段为N，如果没有值，该字段为NN
	newRow()：新增一行数据，此时行状态为NN,form的数据全部被清空
	refresh(conditon,parameter,qryset):根据条件进行数据刷新,但不更新列说明信息
	refreshForObd(parameters,qryset):查询参数，查询的SET数据集
	setFocus(fieldName):设置制定字段为选中状态
	getSts():返回当前的行状态，NN－新增状态，N新增但某些列做了修改，U修改状态，O老状态，D删除状态
	getTitle(fieldName) 获取指定列的列名称

	getEditType(fieldname)获取指定列的编辑类型.是文本框下拉框.
	getColNames() 返回所有字段的名称。如ORGAIZE_ID,REMRKS
	clearValue(pFieldName) 清空指定字段值，状态不变
    getFieldSts(pFieldName) 获取字段的状态,NN为空 ,N表示新建,O表示没修改,D表示删除,U表示修改
    getOldValue(pFieldName)获取字段的老值
	clearListBox(fieldName):清除下拉框选项
	refreshDynamicListBox(fieldName):刷新动态下拉数据源的数据，匹配id为下拉文本,fieldName为字段名称，可为","分割
  getListBoxAllItem(fieldName):获取下拉数据源所有的值和text，返回类型为array。
	                          里面为object，object.id为值，obj.value为文本  // add by linhl at 20091031
	                            
    setImeModeSts(fieldName,sts);//开启或关闭某个字段的中文输入控制，sts=true表示开启，false表示关闭
    
	 支持的事件：
	OnValueChange ： 参数说明：col,oldValue,newValue,dbformpk
	onFoucsIn:    字段获得焦点事件，参数FieldName  val,text
	onFoucsOut:   字段失去焦点事件，参数FieldName  val,text
        ondblink:触发超连接或者openwin的按钮时调用该方法：参数formid，fieldname，val，text，para
        其中para来自与set中设置的opName属性中的数据

	新增校验方法(Appframe3.0新增。使用是必须include CommUtil.js文件)
	1.FormRowSet.isFieldNull(pFieldNames,isShowAlert)
		判断DBForm的指定字段是否为空，如果为空返回true，并alert警告。否则返回false
		 pFieldNames -- 校验的字段名称串，每个字符以"," 分割,如果为空表示全部进行校验
		 isShowAlert -- 为空是否弹出alert警告
		返回值-true/false
       2.FormRowSet.validate(pFieldNames,isJudgeNull,isShowAlert)
		       字段合法性校验。根据set配置的字段类型，最大长度，精度对用户的输入进行判定。并alert警告，否则返回false
		支持String，数字，浮点，date，datetime等类型，类型以set的类型匹配。
		 pFieldNames -- 校验的字段名称串，每个字符以"," 分割,如果为空表示全部进行校验
		 isJudgeNull -- 是否进行是否为空的判定，功能与isFieldNull方法类似
		 isShowAlert -- 为空是否弹出alert警告
       3.verfiy(fieldName) [deprecated]
          字段合法性校验,为validate方法的兼容方法。参数说明同validate

***********/
  //dbform组件与其对应的class的对应数组
  var g_FormFieldstyleArray =
	{ DBEdit:"dbform_inputfield_style",
	 DBListBox:"dbform_listbox_input_style",
	 DBLable:"dbform_lable_style",
	 DBDate:"dbform_dbdate_input_style",
	 DBDateTime:"dbform_dbdate_input_style",
	 DBPassword:"dbform_password_style",
	 DBTextArea:"dbform_textarea_style",
	 DBCheckBox:"dbform_checkbox_style",
	 DBLink:"dbform_dblink_style",
	 DBOpenWin:"dbform_dbopenwin_editor_style",
	 DBSpan:"dbform_dbspan_style",
         DBHtml:"dbform_dbhtml_style",
         DBFile:"dbform_dbfile_style"
    }
  var g_FormFieldDisabledStyleArray =
	{ DBEdit:"dbform_disable_style",
	  DBListBox:"dbform_listbox_input_disable_style",
	  DBLable:"dbform_disable_lable_style",
	  DBDate:"dbform_disable_date_style",
	  DBDateTime:"dbform_disable_date_style",
	  DBPassword:"dbform_disable_style",
	  DBTextArea:"dbform_disable_textArea_style",
	  DBCheckBox:"dbform_disable_checkBox_style",
	  DBLink:"dbform_disable_link_style",
	  DBOpenWin:"dbform_disable_openWin_style",
	  DBFile:"dbform_disable_File_style"


    }




//控件名称的全局定义
 var g_Form_DBEdit = "DBEdit";
 var g_Form_DBListBox = "DBListBox";
 var g_Form_DBLable = "DBLable";
 var g_Form_DBDate = "DBDate";
 var g_Form_DBDateTime = "DBDateTime";
 var g_Form_DBPassword = "DBPassword";
 var g_Form_DBTextArea = "DBTextArea";
 var g_Form_DBCheckBox="DBCheckBox";
 var g_Form_DBLink = "DBLink";
 var g_Form_DBSpan = "DBSpan";
 var g_Form_DBHtml = "DBHtml";
 var g_Form_DBFile ="DBFile";

  //是一个文本一个按钮的控件，用于营业系统的自动生成页面，该组件的事件处理方法与dblink共用
 var g_Form_DBOpenWin = "DBOpenWin";
 
 var g_Form_ShowMaskString = "***";


//formrowset的inital错误获取函数
function FormRowSet_getInitErrorData(pFormId){
      if(document.all("FormRowSet_CUSTOM_ERROR_" + pFormId)==null)
      {
         return null;
      }
      else
      {
      var errorXmlNode = document.all("FormRowSet_CUSTOM_ERROR_" + pFormId).XMLDocument.childNodes(0);
      //alert(errorXmlNode);
      if(errorXmlNode==null)
      {
      return null;
      }
      else{
      return createUserDataClass(errorXmlNode,false);
      }
      }
  }

//formrowset的管理器
function FormRowSetManager(){
 this.List = new Array();
 this.push = function(formRowSet){
      this.List[formRowSet.DBFormPK] = formRowSet;
      return formRowSet.DBFormPK;
 }
 this.get = function(pk){
    var result = this.List[pk];
    if(!result){
       result = new FormRowSet(pk);
    }

    return result;
 }
 this.remove = function(pk){
   this.List[pk] = null;
 }
}
var g_FormRowSetManager = new FormRowSetManager();

function FormRowSet(aName){
  this.DBFormPK = aName;
  g_FormRowSetManager.push(this);
  this.SeqId="-1";
  this.setName="";//set的名称
  this.setFName="";//set的fullname
   
  this.Sts = "O";
  this.RowId = "-1";
  this.IsEditable = "true";
  this.ListDataSource = null;
  this.fieldNameArray = new Array();//页面中使用<tag:dbformfield>说明的有效字段名称
  this.conditionName = "";
  
  this.canModifyFieldNames="";//mo中可编辑的字段名称，以,分割
  this.showFieldNames =""; //mo中可查看的字段，以,分割
  
  this.OnValueChangeFunc =null;
  this.OnFocusInFunc = null;
  this.OnFocusOutFunc= null;
  this.OnKeyPressFunc= null;
  this.OnKeyDownFunc= null;
  this.OnBeforePasteFunc= null;
  this.OnDBLinkFunc= null;
  this.AfterRefreshPlugInFuncName = "g_AIAfterDBFormRefreshFunc";
  this.initial();

}

/**
 * DBForm的对外接口方法
 */
FormRowSet.prototype.isEditable = FormRowSet_isEditable;
FormRowSet.prototype.isColEditable = FormRowSet_isColEditable;
FormRowSet.prototype.setEditSts = FormRowSet_setEditSts;
FormRowSet.prototype.setColEditSts = FormRowSet_setColEditSts;

FormRowSet.prototype.getColNames = FormRowSet_getValidFieldNames;
FormRowSet.prototype.setValue = FormRowSet_setValue;
FormRowSet.prototype.getValue = FormRowSet_getValue;
FormRowSet.prototype.clearValue = FormRowSet_clearValue;
FormRowSet.prototype.getDisplayText = FormRowSet_getDisplayText;
FormRowSet.prototype.setFocus = FormRowSet_setFocus;
FormRowSet.prototype.getSts = FormRowSet_getSts;
FormRowSet.prototype.getTitle = FormRowSet_getTitle;
FormRowSet.prototype.getEditType = FormRowSet_getEditType;
FormRowSet.prototype.clearListBox =FormRowSet_clearListBox
FormRowSet.prototype.addListBoxElement =FormRowSet_addListBoxElement;
FormRowSet.prototype.toXmlString = FormRowSet_toXmlString;


FormRowSet.prototype.setStsToOld = FormRowSet_setStsToOld;
FormRowSet.prototype.setStsToDel = FormRowSet_setStsToDel;
FormRowSet.prototype.setStsToNew = FormRowSet_setStsToNew;
FormRowSet.prototype.removeListBoxOption = FormRowSet_removeListBoxOption;

FormRowSet.prototype.newRow = FormRowSet_newRow;


FormRowSet.prototype.refresh = FormRowSet_refresh;
FormRowSet.prototype.refreshForObd = FormRowSet_refreshForObd;

FormRowSet.prototype.refreshDynamicListBox = FormRowSet_refreshDynamicListBox;
FormRowSet.prototype.refreshListBox = FormRowSet_refreshListBox;
FormRowSet.prototype.getListBoxAllItem = FormRowSet_getListBoxAllItem;



//设置事件关联的方法名称
FormRowSet.prototype.onValueChange = FormRowSet_SetOnValueChangeFunc;
FormRowSet.prototype.onFocusIn = FormRowSet_SetOnFocusInFunc;
FormRowSet.prototype.onFocusOut = FormRowSet_SetOnFocusOutFunc;
FormRowSet.prototype.onDBLink = FormRowSet_SetOnDBLinkFunc;

FormRowSet.prototype.isFieldNull = FormRowSet_isFieldNull;
FormRowSet.prototype.validate = FormRowSet_validate;
FormRowSet.prototype.verify = FormRowSet_verify;

FormRowSet.prototype.setImeModeSts = FormRowSet_setImeModeSts;
FormRowSet.prototype.removeListBoxOption = FormRowSet_removeListBoxOption;

FormRowSet.prototype.onKeyPress = FormRowSet_SetOnKeyPressFunc;
FormRowSet.prototype.onKeyDown = FormRowSet_SetOnKeyDownFunc;
FormRowSet.prototype.onBeforePaste = FormRowSet_SetOnBeforePasteFunc;

/**
 * DBFrom的内部方法
 */
FormRowSet.prototype.getClassName = FormRowSet_getClassName;
FormRowSet.prototype.initial = FormRowSet_initial;

FormRowSet.prototype.exeOnValueChange = FormRowSet_exeOnValueChange;
FormRowSet.prototype.exeOnFocusIn  = FormRowSet_exeOnFocusIn;
FormRowSet.prototype.exeOnFocusOut = FormRowSet_exeOnFocusOut;
FormRowSet.prototype.exeOnDBLink = FormRowSet_exeOnDBLink;
FormRowSet.prototype.getValuePrivate = FormRowSet_getValuePrivate;
FormRowSet.prototype.getFieldShowText =FormRowSet_getFieldShowText;
FormRowSet.prototype.getOldValue = FormRowSet_getOldValue;
FormRowSet.prototype.getOldDisplayText =FormRowSet_getOldDisplayText;
FormRowSet.prototype.getFieldSts =FormRowSet_getFieldSts
FormRowSet.prototype.getFormRowSetInfo =FormRowSet_getFormRowSetInfo
FormRowSet.prototype.setID = FormRowSet_setID;

FormRowSet.prototype.exeOnKeyPress = FormRowSet_exeOnKeyPress;
FormRowSet.prototype.exeOnKeyDown = FormRowSet_exeOnKeyDown;
FormRowSet.prototype.exeOnBeforePaste = FormRowSet_exeOnBeforePaste;



/***************************************************************
* 内部方法实现
******************************************************************/


function FormRowSet_getClassName()
{
  return "FormRowSet";
}

function FormRowSet_setID(id){
  this.RowId = id;
}
function  FormRowSet_initial()
{
  var xmlNode = document.all("FormXml_" + this.DBFormPK).XMLDocument.childNodes(0);
  this.SeqId = xmlNode.attributes.getNamedItem("seqid").nodeValue;
  this.setName=xmlNode.attributes.getNamedItem("setname").nodeValue;
  this.setFName=xmlNode.attributes.getNamedItem("setfname").nodeValue;
  for(var i = 0;i < xmlNode.childNodes.length;i++)
  {
	  var tmpNode = xmlNode.childNodes(i);
      if ( tmpNode.nodeName == "HEAD")
	     this.ListDataSource = new ListDataSourceFactory(tmpNode);
      else if( tmpNode.nodeName  == "PKVALLIST")
	      {
		    if(tmpNode.childNodes(0)!=null)
		 {
		       this.RowId = tmpNode.childNodes(0).text;
		 }
		  }
	  else if( tmpNode.nodeName  == "ROWSTS")
	     {
		  this.Sts = tmpNode.text;

	 }
      else if( tmpNode.nodeName  == "EDITABLE")
	     {
		  this.IsEditable = tmpNode.text;

	 }
      else if( tmpNode.nodeName  == "CONDITIONNAME")
	     {
		  this.conditionName = tmpNode.text;

	 }
	 else if(tmpNode.nodeName == "CAN_MODIFY_COL")
	 	{
	 		this.canModifyFieldNames = tmpNode.text;
	 	}
	 else if(tmpNode.nodeName=="SHOW_COL")
	 	{
	 		this.showFieldNames = tmpNode.text;
	 	}	
	  else if(tmpNode.nodeName  == "EVENTLIST")
		  {
		   for(var j=0;j<tmpNode.childNodes.length;j++)
			 {
			    if(tmpNode.childNodes(j).nodeName == "EVENT")
				 {
				   var cNode = tmpNode.childNodes(j);
				  try
				  {
				    if(cNode.attributes.getNamedItem("NAME").nodeValue == "ONVALCHANGE")
					 {
					   eval("this.OnValueChangeFunc =" + cNode.text);
					 }
				    if(cNode.attributes.getNamedItem("NAME").nodeValue == "ONDBLINK")
					 {
					   eval("this.OnDBLinkFunc = "+cNode.text);
					 }
				    if(cNode.attributes.getNamedItem("NAME").nodeValue == "ONFOCUSIN")
					{
					   eval("this.OnFocusInFunc = "+cNode.text);
					}
				    if(cNode.attributes.getNamedItem("NAME").nodeValue == "ONFOCUSOUT")
					{
					   eval("this.OnFocusOutFunc ="+ cNode.text);
					}
				    if(cNode.attributes.getNamedItem("NAME").nodeValue == "ONKEYPRESS")
				       {
					   eval("this.OnKeyPressFunc = "+cNode.text);
				       }
				    if(cNode.attributes.getNamedItem("NAME").nodeValue == "ONKEYDOWN")
				    {
					     eval("this.OnKeyDownFunc = "+cNode.text);
				    }
				    if(cNode.attributes.getNamedItem("NAME").nodeValue == "ONBEFOREPASTE")
				    {
					     eval("this.OnBeforePasteFunc = "+cNode.text);
				    }
				  }
				  catch(e)
				  {
				    alert("[FormRowSet.initial]初始化时绑定外部关联事件方法出错。请检查方法是否存在.\n方法名称:"+cNode.text);
					throw e;
				  }

				 }
			 }
	     }
  }
 
  
    var allSpanObjs = document.all.tags("SPAN");
    for(var i=0;i<allSpanObjs.length;i++)
    {
      if(allSpanObjs[i].DBFormPK && allSpanObjs[i].FieldName && allSpanObjs[i].DBFormPK==this.DBFormPK)
      {
	    this.fieldNameArray[this.fieldNameArray.length] = allSpanObjs[i].FieldName;
      }
    }
  
  




}



function FormRowSet_exeOnValueChange(pFieldName,pOldVal,pOldText,pNewVal,pNewText)
{
  
  
  if(this.OnValueChangeFunc!=null)
    {

      //异步执行用户定制的onvaluechange的方法.
      try
	    {
	      this.OnValueChangeFunc(pFieldName,pOldVal,pNewVal,this.DBFormPK);     
	      /**
	       var runFun = function(){
	         
			   }
         window.setTimeout("runFun();runFun=null;",0);
         */

	      
	      
	      
	    }
      catch(e)
       {
	  alert("[FormRowSet.exeOnValueChange]执行外部关联的OnValChange方法出现错误.\n方法信息:"+this.OnValueChangeFunc);
	  throw e;
       }
    }
}


function FormRowSet_exeOnFocusIn(pFieldName,pVal,pText)
{
    if(this.OnFocusInFunc!=null)
    {

      try
	{
	   this.OnFocusInFunc(pFieldName,pVal,pText);
	}
       catch(e)
       {
	  alert("[FormRowSet.exeOnFocusIn]执行外部关联的OnFocusIn方法出现错误.\n方法信息:"+this.OnFocusInFunc);
	  throw e;
       }
    }
}


function FormRowSet_exeOnFocusOut(pFieldName,pVal,pText)
{
    if(this.OnFocusOutFunc!=null)
    {

      try
	{
	  this.OnFocusOutFunc(pFieldName,pVal,pText);
	}
       catch(e)
       {
	  alert("[FormRowSet.exeOnFocusOut]执行外部关联的OnFocusOut方法出现错误.\n方法信息:"+this.OnFocusOutFunc);
	  throw e;
       }
    }
}


function FormRowSet_exeOnDBLink(pDBFormPK,pFieldName,pVal,pText,pPara)
{
  var reVal = null;
  if(this.OnDBLinkFunc!=null)
  {
    try
    {
       reVal = this.OnDBLinkFunc(pDBFormPK,pFieldName,pVal,pText,pPara);

    }
    catch(e)
    {
      alert("[FormRowSet.exeOnDBLink]执行外部关联的OnDBLink方法出现错误.\n方法信息:"+this.OnDBLinkFunc);
      throw e;
    }
  }
  return reVal;
}


function FormRowSet_exeOnKeyPress(pFieldName,pField)
{
   if(this.OnKeyPressFunc!=null)
  {
    try
    {
       this.OnKeyPressFunc(pFieldName,pField);

    }
    catch(e)
    {
      alert("[FormRowSet.exeOnKeyPress]执行外部关联的OnKeyPress方法出现错误.\n方法信息:"+this.OnKeyPressFunc+".ex:"+e);;
      throw e;
    }
  }
}

function FormRowSet_exeOnKeyDown(pFieldName,pField)
{
   if(this.OnKeyDownFunc!=null)
  {
    try
    {
       this.OnKeyDownFunc(pFieldName,pField);

    }
    catch(e)
    {
      alert("[FormRowSet.exeOnKeyDown]执行外部关联的OnKeyDown方法出现错误.\n方法信息:"+this.OnKeyDownFunc+".ex:"+e);;
      throw e;
    }
  }
}

function FormRowSet_exeOnBeforePaste(pFieldName)
{
   if(this.OnBeforePasteFunc!=null)
  {
    try
    {
       this.OnBeforePasteFunc(pFieldName);

    }
    catch(e)
    {
      alert("[FormRowSet.exeOnBeforePaste]执行外部关联的OnBeforePaste方法出现错误.\n方法信息:"+this.OnBeforePasteFunc+".ex:"+e);;
      throw e;
    }
  }
}

function  FormRowSet_getValuePrivate(rowIndex,fieldName)
{
  return this.getValue(fieldName);
}

//得到页面FormField不同组件真正显示在页面组件上面的值。这里要进行showField的mask掩码判断
function FormRowSet_getFieldShowText(pFieldName,pDisplayText)
{
	 var reVal = pDisplayText;
	 if(this.showFieldNames.length!=0 && this.showFieldNames.indexOf(pFieldName+",")<0)
	   {
	     reVal= g_Form_ShowMaskString;    
	   }
	 return reVal;    
}

function FormRowSet_getOldValue(pFieldName)
{
	var reVal="";
	var fieldObj = FormRowSet_All_getFieldSpanObj(this.DBFormPK,pFieldName);
  if(fieldObj)
  {
  	reVal = fieldObj.OldI;
  }
  return reVal;
	
}
function FormRowSet_getOldDisplayText(pFieldName)
{
	var reVal="";
	var fieldObj = FormRowSet_All_getFieldSpanObj(this.DBFormPK,pFieldName);
  if(fieldObj)
  {
  	reVal = fieldObj.OldT;
  }
  return reVal;
}






/***************************************************************
 *
* 外部方法实现
 ******************************************************************/
function FormRowSet_isEditable()
{
  var fieldNames = this.getColNames();
  if(fieldNames==null)
  {
    return false;
  }
  var reFlag = false;
  for(var i=0;i<fieldNames.length;i++)
  {

    if(this.isColEditable(fieldNames[i])==true)
      {
	reFlag = true;
	break;
      }
  }
  return reFlag;
}

function FormRowSet_isColEditable(pFieldName)
{
  var fieldObj = FormRowSet_All_getFieldSpanObj(this.DBFormPK,pFieldName);
  if(fieldObj)
  {
    if(fieldObj.IsEditable=="true")
      return true;
    else
      return false;
  }
  else
  {
      alert("[FormRowSet.isColEditable]无法找到名称对应的字段对象.FieldName="+pFieldName);
      return null;
  }
}


function FormRowSet_setEditSts(pFlag)
{
   for(var i=0;i<this.fieldNameArray.length;i++)
   {
      this.setColEditSts(this.fieldNameArray[i],pFlag);
   }
}

function FormRowSet_setColEditSts(pFieldName,pFlag)
{

     var fieldObj = FormRowSet_All_getFieldSpanObj(this.DBFormPK,pFieldName)

     if(fieldObj!=null && fieldObj.Action_OnSetEditable)
     {
			 /*
			 1.判断可修改字段列表是否为空，
			   如果不为空，则列表中的字段才可以设置为可编辑，其他字段都不可。
			   如果为空，则再判断可查看字段是否为空。
			   如果mask可查看字段不为空，则只有可查看的字段可设置编辑字段，其他mask的字段不可编辑
			   如果mask可查看字段为空 则正常进行判断。
			 */
			 if(pFlag)
			 {
	       /**
	       当字段属于‘可查看字段’中，或者’可查看字段‘为空。则下一步
	       当字段属于 ’可编辑字段‘ 或者 ’可编辑字段为空‘
	       则可编辑
	       */
	       if(this.showFieldNames.length==0 || this.showFieldNames.indexOf(fieldObj.FieldName+",")>=0)
	       {
	         if(this.canModifyFieldNames.length==0 || this.canModifyFieldNames.indexOf(fieldObj.FieldName+",")>=0)
           	{
           		fieldObj.Action_OnSetEditable(pFlag);
           	}
	       }  
			 
			 }
      else
      	{
      		fieldObj.Action_OnSetEditable(pFlag);
      	}
     }
}


function FormRowSet_getValidFieldNames()
{
  return this.fieldNameArray;
}


function FormRowSet_setValue(pFieldName,pVal,pText,isTrigerEvent)
{
   var fieldObj = FormRowSet_All_getFieldSpanObj(this.DBFormPK,pFieldName);
   if(fieldObj)
   {
     if(pText==null || pText=="")
	       pText  = pVal;
	 if(isTrigerEvent!=null && isTrigerEvent==false)
       fieldObj.Action_SetValue(pVal,pText,false);
     else
       fieldObj.Action_SetValue(pVal,pText,true); 
   }
}

function FormRowSet_getValue(pFieldName)
{
   var fieldObj = FormRowSet_All_getFieldSpanObj(this.DBFormPK,pFieldName);
   if(fieldObj)
   {
     return  fieldObj.Action_GetValue();

   }
   else{
      //alert("[FormRowSet.getValue]无法找到名称对应的字段对象.FieldName="+pFieldName);
      return null;
   }
}

function FormRowSet_getDisplayText(pFieldName)
{
   var fieldObj = FormRowSet_All_getFieldSpanObj(this.DBFormPK,pFieldName);
   if(fieldObj)
   {
      return fieldObj.Action_GetDisplayText();

   }
   else{
      //alert("[FormRowSet.getDisplayText]无法找到名称对应的字段对象.FieldName="+pFieldName);
      return null;
   }
}

function FormRowSet_toXmlString(flag)
{
   if(flag == null) flag = true;
   var headXmlArray = new Array();
   var result = new Array();

   var oldSts = this.Sts;

   for(var i=0;i<this.fieldNameArray.length;i++){
     var fieldObj = FormRowSet_All_getFieldSpanObj(this.DBFormPK,this.fieldNameArray[i]);
     this.getValue(this.fieldNameArray[i]);
     
     if(oldSts!=this.Sts){
       break;
     }
   }

   for(var i=0;i<this.fieldNameArray.length;i++)
   {
     var fieldObj = FormRowSet_All_getFieldSpanObj(this.DBFormPK,this.fieldNameArray[i]);
     if(fieldObj)
     {
       result[result.length] = fieldObj.Action_ToXmlString(flag);
     }
   }
   if(flag){
     if(this.Sts=="O") return "";
   }
   if(FormRowSet_All_StringTrim(result.join(""))==""){
	return "";
     }
   else
     {
	     headXmlArray[headXmlArray.length] ="<RowSet Name='";
	headXmlArray[headXmlArray.length] = this.setName;
	headXmlArray[headXmlArray.length] = "' FullName='";
	headXmlArray[headXmlArray.length] = this.setFName;
	headXmlArray[headXmlArray.length] = "' ";
	headXmlArray[headXmlArray.length] = " Sts='U'>";
	headXmlArray[headXmlArray.length] = "<Row ";
	if(this.Sts=="U" || this.Sts=="D"){
		headXmlArray[headXmlArray.length] = " ID='";
		headXmlArray[headXmlArray.length] = this.RowId;
		headXmlArray[headXmlArray.length] = "' ";
	}
	headXmlArray[headXmlArray.length] = "Sts='";
	headXmlArray[headXmlArray.length] = this.Sts;
	headXmlArray[headXmlArray.length] = "'>";
	result[result.length] ="</Row>";
	result[result.length] ="</RowSet>";
	return headXmlArray.join("")+result.join("");
     }

}

function FormRowSet_setFocus(pFieldName)
{
  var fieldObj = FormRowSet_All_getFieldSpanObj(this.DBFormPK,pFieldName);
  if(fieldObj)
  {
    if(fieldObj.IsEditable=="false")
     return;
    if(fieldObj.Action_OnFocus)
    {
      fieldObj.Action_OnFocus();

    }
    else
    {
	//hexg,没有后续操作可以加try catch直接过滤
	  try{
      	fieldObj.childNodes(0).focus();
      }catch(e){}
    }

  }

}

function FormRowSet_setStsToOld()
{
  this.Sts = "O";
  for(var i=0;i<this.fieldNameArray.length;i++)
     {
	  var selObj = FormRowSet_All_getFieldSpanObj(this.DBFormPK,this.fieldNameArray[i]);
	   if(selObj)
		{
		  selObj.Sts = "O";
		  selObj.OldI = selObj.I;
		  selObj.OldT = selObj.T;
		}
     }
}

function FormRowSet_setStsToDel()
{
  this.Sts = "D";
}
//设置form数据集合为新增行状态，如果原字段有值，该字段状态为N，如果没有值，该字段状态为NN。只有当所有字段都没有值时，行状态为NN，否则为N
function FormRowSet_setStsToNew()
{
   var isNNFlag = true;
   for(var i=0;i<this.fieldNameArray.length;i++)
	{
		selObj = FormRowSet_All_getFieldSpanObj(this.DBFormPK,this.fieldNameArray[i]);
	  if(selObj)
		{
		  if(selObj.I!="")
		   {
			  selObj.Sts = "N";
			  selObj.OldI = "";
			  selObj.OldT = "";
			  isNNFlag = false;
		   }
		  else
		   {
			  selObj.Sts = "NN";
			  selObj.OldI = "";
			  selObj.OldT = "";

		    }

		}
      }
      if(isNNFlag)
	this.Sts = "NN";
      else
	this.Sts = "N";
}

function FormRowSet_newRow()
{
   for(var i=0;i<this.fieldNameArray.length;i++)
	{
	  selObj = FormRowSet_All_getFieldSpanObj(this.DBFormPK,this.fieldNameArray[i]);
	  if(selObj)
	  {
	     selObj.Action_SetValue("","",false);
	     selObj.Sts = "NN";
	     selObj.OldI = "";
	     selObj.OldT = "";
	  }
	}
   this.Sts = "NN";

}
function FormRowSet_getSts()
{

  return this.Sts;
}
function FormRowSet_getTitle(pFieldName)
{
   selObj = FormRowSet_All_getFieldSpanObj(this.DBFormPK,pFieldName);
   if(selObj){
     return selObj.tt;
   }
   else
     return null;
}


function FormRowSet_getEditType(pFieldName)
{
  selObj = FormRowSet_All_getFieldSpanObj(this.DBFormPK,pFieldName);
  if(selObj)
  {
    return selObj.EditType;
  }
  else
  {
    alert("[FormRowSet.getEditType]无法找到名称对应的字段对象.FieldName="+pFieldName);
    return null;
  }
}

function FormRowSet_SetOnValueChangeFunc(pFuncName)
{

  if(pFuncName == null || FormRowSet_All_StringTrim(pFuncName)=="")
    {
      this.OnValueChangeFunc = null;
    }
    else
    {
      try
      {
	eval("this.OnValueChangeFunc ="+pFuncName);

      }
      catch(e)
      {
	alert("[FormRowSet.onValueChange]绑定方法时出现错误。请检查该Javascript方法(function)是否存在。方法名称:"+pFuncName);
	throw e;
      }

    }

}



function FormRowSet_SetOnFocusInFunc(pFuncName)
{

    if(pFuncName==null || FormRowSet_All_StringTrim(pFuncName)=="")
    {
      this.OnFocusInFunc = null;
    }
    else
    {
      try
      {
	eval("this.OnFocusInFunc ="+pFuncName);
      }
      catch(e)
      {
	alert("[FormRowSet.setOnFocusIn]绑定方法时出现错误。请检查该Javascript方法(function)是否存在。方法名称:"+pFuncName);
	throw e;
      }

    }

}

function FormRowSet_SetOnFocusOutFunc(pFuncName)
{

    if(pFuncName == null || FormRowSet_All_StringTrim(pFuncName)=="")
    {
      this.OnFocusOutFunc = null;
    }
    else
    {
      try
      {
	eval("this.OnFocusOutFunc ="+pFuncName);
      }
      catch(e)
      {
	alert("[FormRowSet.OnFocusOut]绑定方法时出现错误。请检查该Javascript方法(function)是否存在。方法名称:"+pFuncName);
	throw e;
      }

    }

}


function FormRowSet_SetOnKeyPressFunc(pFuncName)
{

    if(pFuncName==null || FormRowSet_All_StringTrim(pFuncName)=="")
    {
      this.OnKeyPressFunc = null;
    }
    else
    {
      try
      {
	eval("this.OnKeyPressFunc ="+pFuncName);
      }
      catch(e)
      {
	alert("[FormRowSet.OnKeyPress]绑定方法时出现错误。请检查该Javascript方法(function)是否存在。方法名称:"+pFuncName);
	throw e;
      }

    }

}

function FormRowSet_SetOnKeyDownFunc(pFuncName)
{

    if(pFuncName==null || FormRowSet_All_StringTrim(pFuncName)=="")
    {
      this.OnKeyDownFunc = null;
    }
    else
    {
      try
      {
	eval("this.OnKeyDownFunc ="+pFuncName);
      }
      catch(e)
      {
	alert("[FormRowSet.OnKeyDown]绑定方法时出现错误。请检查该Javascript方法(function)是否存在。方法名称:"+pFuncName);
	throw e;
      }

    }

}

function FormRowSet_SetOnBeforePasteFunc(pFuncName)
{

    if(pFuncName==null || FormRowSet_All_StringTrim(pFuncName)=="")
    {
      this.OnBeforePasteFunc = null;
    }
    else
    {
      try
      {
	eval("this.OnBeforePasteFunc ="+pFuncName);
      }
      catch(e)
      {
	alert("[FormRowSet.OnBeforePaste]绑定方法时出现错误。请检查该Javascript方法(function)是否存在。方法名称:"+pFuncName);
	throw e;
      }

    }

}

function FormRowSet_SetOnDBLinkFunc(pFuncName)
{
  if(pFuncName==null || FormRowSet_All_StringTrim(pFuncName)=="")
    {
      this.OnDBLinkFunc = null;
    }
    else
    {
      try
      {
	eval("this.OnDBLinkFunc ="+pFuncName);
      }
      catch(e)
      {
	alert("[FormRowSet.OnDBLink]绑定方法时出现错误。请检查该Javascript方法(function)是否存在。方法名称:"+pFuncName);
	throw e;
      }

    }

}

function FormRowSet_refreshListBox(pFieldName,pCondition,isTriggerEvent)
{
  if(pFieldName==null || FormRowSet_All_StringTrim(pFieldName)=="")
  {
    return;
  }
  
  if(isTriggerEvent!=null && isTriggerEvent==true){
    isTriggerEvent=true;
  }
  else{
    isTriggerEvent=false;
  }
    
  var fieldObj = FormRowSet_All_getFieldSpanObj(this.DBFormPK,pFieldName);
  if(fieldObj && (fieldObj.EditType).toLowerCase() == g_Form_DBListBox.toLowerCase()){
     //get listsource name
     var ls=fieldObj.ls;
     var oldLsObj = this.ListDataSource.find(ls);
     if(oldLsObj!=null && oldLsObj.ListDataSourceType){
       if(oldLsObj.ListDataSourceType=="Static"){
          var lsFName=fieldObj.lsf;
          //
          var tUrl =_gModuleName +  "/dbformrefresh?action=refreshlist&pk="+this.SeqId+"&F_SETNAME="+this.setFName+"&F_FIELDNAME="+pFieldName
                   +"&F_DSID="+fieldObj.lsf;
          if (pCondition && FormRowSet_All_StringTrim(pCondition)!=""){
            tUrl+="&F_ISCOND=y&"+pCondition;
          }
          else{
            tUrl+="&F_ISCOND=n";
          }
         
          var sRe=PostInfotoServer(tUrl,'');
          var xml = g_GetXMLDocument();
          xml.loadXML(sRe);
          var newLsObj=new ListDataSourceStatic(null,xml.documentElement);
          if(newLsObj){
            newLsObj.setName(oldLsObj.getName());
            this.ListDataSource.replace(newLsObj);
            if(fieldObj.Action_SetValue){
               fieldObj.Action_SetValue(fieldObj.Action_GetValue(),"",false);
            }
          }  
       
       }
       else{
         var tmpEditor = FormRowSet_Field_DBListBox_getEditor(this,pFieldName,curVal,curText);
         if(tmpEditor.selectedIndex!=null && tmpEditor.selectedIndex==0 && curVal != tmpEditor.getID() && isTriggerEvent)
         {
	       fieldObj.Action_SetValue(tmpEditor.getID(),tmpEditor.getValue(),true);
         }
         else
         {
	       fieldObj.Action_SetValue(tmpEditor.getID(),tmpEditor.getValue(),false);
         }
       }
       
       
     }
     
  }
}


function FormRowSet_refreshDynamicListBox(pFieldNames)
{
  if(pFieldNames==null || FormRowSet_All_StringTrim(pFieldNames)=="")
  {
    return;
  }
  var fieldNameArray = pFieldNames.split(",");
  for(var i=0;i<fieldNameArray.length;i++)
  {
     var fieldObj = FormRowSet_All_getFieldSpanObj(this.DBFormPK,fieldNameArray[i]);

     if(fieldObj && (fieldObj.EditType).toLowerCase() == g_Form_DBListBox.toLowerCase())
     {
       var curVal = fieldObj.Action_GetValue();
       var curText = fieldObj.Action_GetDisplayText();
       var tmpEditor = FormRowSet_Field_DBListBox_getEditor(this,fieldNameArray[i],curVal,curText);
       if(tmpEditor.selectedIndex!=null && tmpEditor.selectedIndex==0 && curVal != tmpEditor.getID())
       {
	 fieldObj.Action_SetValue(tmpEditor.getID(),tmpEditor.getValue(),true);

       }
       else
       {
	fieldObj.Action_SetValue(tmpEditor.getID(),tmpEditor.getValue(),false);
       }
     }
  }
}

function FormRowSet_refresh(whereCon,parameters,qryset,isShowErrorAlert)
{
	if(whereCon==null)whereCon="";
	if(parameters==null)parameters="";
  var reFlag = "-1";//默认返回，如果为"0",返回成功，"-1"为缺省refresh失败返回值
  var pk = this.SeqId;
  var aCondition = whereCon;
  if(this.conditionName!=null && this.conditionName!="")
	{
	  aCondition = this.conditionName+"="+g_ConditonStrEncode(aCondition);
	}
  var tUrl =_gModuleName +  "/dbformrefresh?action=refresh&pk="+pk+"&"+aCondition;
  if(parameters)
    tUrl = tUrl + "&" + parameters;

  var tmpstr = "";
  if(qryset!=null){
      tmpstr  = "<RootInfo>"
      if(qryset != null)
	 tmpstr = tmpstr + qryset.toXmlString(false);
      tmpstr = tmpstr   + "</RootInfo>";

   }
   tmpstr = document.all("DBFormTagInfo_" + this.DBFormPK ).value+tmpstr;
   var sRe=PostInfotoServer(tUrl,tmpstr);
   var xml = new ActiveXObject("Msxml.DOMDocument");
   xml.async = false;
   xml.loadXML(sRe);
   var xmlNode = xml.documentElement;
   if(xmlNode)
	{
       var ud = createUserDataClass(xmlNode);
       if(ud.getValueByName("FLAG")=="SUCCESS")
       {
		   this.RowId=ud.getValueByName("PKVAL");
		   this.Sts = ud.getValueByName("STS");
		   if(this.Sts=="NN")
			{
			  this.newRow();
			}
		  else
			{

			  for(var i=0;i<this.fieldNameArray.length;i++)
			     {
				  var spanObj = FormRowSet_All_getFieldSpanObj(this.DBFormPK,this.fieldNameArray[i]);
				  if(spanObj)
				     {

					var newVal = ud.getValueByName(this.fieldNameArray[i]);
					 var newText = ud.getValueByName(this.fieldNameArray[i]+"_AIDISPLAY_VAL");

					if(newVal==null) newVal = "";
					if(newText==null) newText = newVal;
					this.clearValue(this.fieldNameArray[i]);

				  	spanObj.Action_SetValue(newVal,newText,false);

				    }
			    }
			  this.setStsToOld();
			  this.Sts = ud.getValueByName("STS");
			}
	  reFlag=null;

	}
       else if(ud.getValueByName("FLAG")=="ERROR_USER")
	{

            reFlag=ud;
	}
       else{
           if(isShowErrorAlert!=false)
           {
             var msg = ud.getValueByName("MESSAGE");
             alert("FormRowSet刷新时出现错误。详细信息:"+msg);
           }
	   reFlag=ud;
	}

       //调用插件方法，如果有插件方法，则执行插件方法，（改方法纯粹是为平台升级时，减少应用代码的改变量而增加的，平常使用时不考虑）
       if(this.AfterRefreshPlugInFuncName!=null && this.AfterRefreshPlugInFuncName!="")
       {
	  var afterRefreshFuncObj = null;
	  try
	  {
		  eval("afterRefreshFuncObj="+this.AfterRefreshPlugInFuncName);
	  }
	  catch(e)
	  {
		      afterRefreshFuncObj =null;
	  }
	  if(afterRefreshFuncObj!=null)
	  {
	    afterRefreshFuncObj(this,reFlag);
	  }
       }

       return reFlag;



    }
}
function FormRowSet_refreshForObd(parameters,qryset,isShowErrorAlert)
{
   return this.refresh(null,parameters,qryset,isShowErrorAlert);
}

//将某个指定字段的值全部清空
function FormRowSet_clearValue(pFieldName)
{
  var spanObj = FormRowSet_All_getFieldSpanObj(this.DBFormPK,pFieldName);
  if(spanObj)
  {
	spanObj.Action_SetValue("","",false);
	spanObj.I = "";
	spanObj.T = "";
	spanObj.OldI = "";
	spanObj.OldT = "";
	spanObj.OldValue=null;

  }
}

/**
 判断DBForm的指定字段是否为空，如果为空返回true，并alert警告。否则返回false
 pFieldNames -- 校验的字段名称串，每个字符以"," 分割,如果为空表示全部进行校验
 isShowAlert -- 为空是否alert警告
*/
function FormRowSet_isFieldNull(pFieldNames,isShowAlert)
{

  if(isShowAlert==null) isShowAlert = true;
  var flag = false;

  var fieldArray = this.getColNames();

  if(pFieldNames!=null && g_StringTrim(pFieldNames)!="")
  {
    fieldArray = pFieldNames.split(",");
  }

  for(var i=0;i<fieldArray.length ;i++)
  {
    var fieldValue = this.getValue(fieldArray[i]);
    if(fieldValue==null || g_StringTrim(fieldValue)=="")
    {
       if(isShowAlert)
       {
	  var fieldTitle = this.getTitle(fieldArray[i]);
	  alert("字段'"+fieldTitle+"'不可为空，请检查");
       }
       flag = true;
       break;
    }
  }
  return flag;

}

//获取字段的状态 NN为空 ,N表示新建,O表示没修改,D表示删除,U表示修改
function FormRowSet_getFieldSts(pFieldName)
{
  var fieldObj = FormRowSet_All_getFieldSpanObj(this.DBFormPK,pFieldName);
 
  var OldId = fieldObj.OldI;
  var NewId = fieldObj.Action_GetValue();

  //当修改状态时，如果以前有值，然后改为"",则设置字段状态为D状态。
  if(fieldObj.Sts=="U")
  {
    if(OldId && !NewId) fieldObj.Sts = "D";
  }
  else if(fieldObj.Sts=="D"){
    if(OldId!=null && NewId!=null && NewId!='') fieldObj.Sts = "U";
  }

  return fieldObj.Sts;
}

//返回当前FORMROWSET的基本信息，包括每个字段的英文名、中文名、状态、老值和新值、老的显示值和新的显示值
//fieldName:英文名,fieldTitle:中文名,fieldSts:状态,
//        oldValue:老值 ,newValue:新值,oldText:老的显示值,newText:新的显示值
function FormRowSet_getFormRowSetInfo(){
  var formRowSetInfo = new Array();
  var fieldArray = this.getColNames();
 
  for(var i=0;i<fieldArray.length ;i++)
  {
    var fieldValue = this.getValue(fieldArray[i]);
    var fieldTitle = this.getTitle(fieldArray[i]);
    
    var fieldObj = FormRowSet_All_getFieldSpanObj(this.DBFormPK,fieldArray[i]);
    var OldId = fieldObj.OldI;
    var OldText = fieldObj.OldT;
    var NewId = fieldObj.Action_GetValue();
    var NewText = fieldObj.Action_GetDisplayText();

    //当修改状态时，如果以前有值，然后改为"",则设置字段状态为D状态。
    if(fieldObj.Sts=="U")
    {
      if(OldId && !NewId) fieldObj.Sts = "D";
    }
    else if(fieldObj.Sts=="D"){
      if(OldId!=null && NewId!=null && NewId!='') fieldObj.Sts = "U";
    }
  
    var info={fieldName:fieldArray[i],fieldTitle:fieldTitle,fieldSts:fieldObj.Sts,
        oldValue:OldId ,newValue:NewId,oldText:OldText,newText:NewText};
    formRowSetInfo[formRowSetInfo.length] = info;
  }
  
  return formRowSetInfo;
}
function FormRowSet_validate(pFieldNames,isJudgeNull,isShowAlert)
{
  if(isShowAlert==null) isShowAlert = true;
  
  var fieldArray = this.getColNames();
  if(pFieldNames!=null && g_StringTrim(pFieldNames)!="")
  {
    fieldArray = pFieldNames.split(",");
  }

  for(var i=0;i<fieldArray.length ;i++){
     var fieldValue = this.getValue(fieldArray[i]);  
     var fieldTitle = this.getTitle(fieldArray[i]);  
     
     if(((FormRowSet_All_getFieldSpanObj(this.DBFormPK,fieldArray[i]).isn=="N"  || isJudgeNull==true) && (fieldValue==null ||  g_StringTrim(fieldValue)=="")) 
     	 )
     {
     	
       if(isShowAlert)
       {
         //"字段'"+fieldTitle+"'不可为空，请检查"
				 var msg = g_I18NMessage("appframe_core","form_validate_null",new Array(fieldTitle));
	       alert(msg);
         this.setFocus(fieldArray[i]);
       }
      return false;
    }
     //如果字段可空,后面校验不需要做 
    if(fieldValue==null ||  g_StringTrim(fieldValue)==""){
      continue;
    }
    var dataType = FormRowSet_All_getFieldSpanObj(this.DBFormPK,fieldArray[i]).da;
    var maxLen = FormRowSet_All_getFieldSpanObj(this.DBFormPK,fieldArray[i]).ml;
    var decimal = FormRowSet_All_getFieldSpanObj(this.DBFormPK,fieldArray[i]).dec;
    if(FormRowSet_All_isValidate(fieldValue,fieldTitle,dataType,maxLen,decimal,isShowAlert)==false)
    {

      return false;
    }
  }
  return true;

}

function FormRowSet_All_isValidate(pVal,pTitle,pDataType,pMaxLen,pDecimal,pIsShowAlert)
{

  if(pDecimal==null ||  g_StringTrim(pMaxLen)=="")  pDecimal=0;
  var reVal = true;
  var maxLen = -1;
  if(pMaxLen!=null &&  g_StringTrim(pMaxLen)!="" && parseInt(pMaxLen)!=NaN)
  {
    maxLen = parseInt(pMaxLen);
  }
  if(pDataType == "Float" || pDataType=="Double")
  {
    if(maxLen!=-1 && g_GetStrLen(pVal)>maxLen)
    {
      reVal = false;
      if(pIsShowAlert)
      {
	alert("字段'"+pTitle+"' 输入超长。请输入不超过"+pMaxLen+"位的浮点数");
      }
    }
    if(reVal==true && g_IsFloat(pVal,pDecimal)==false)
    {
      reVal = false;
      if(pIsShowAlert)
      {
	alert("字段'"+pTitle+"' 输入不合法。请输入浮点数且精度不超过"+pDecimal+"位");
      }
    }
    //对于带精度的小数，整数的位数 不能超过(maxLen-pDecimal) hexg ,2006-11-28
    var tmp = "" +parseInt(pVal);
    if(tmp.length>(maxLen-pDecimal)){
      alert("字段'"+pTitle+"' 输入不合法。请输入浮点数且整数位不超过"+(maxLen-pDecimal)+"位");
      reVal = false;
    }
    
  }
  else if(pDataType == "String")
  {
   // alert(g_GetStrLen(pVal));
    if(maxLen!=-1 && g_GetStrLen(pVal)>maxLen)
    {
      reVal = false;
      if(pIsShowAlert)
      {
	alert("字段'"+pTitle+"' 输入超长。请输入不超过"+maxLen+"位的字符串");
      }
    }
  }
  else if(pDataType == "Integer" || pDataType=="Long"  || pDataType=="Short" || pDataType=="int")
  {
    if(g_IsDigit(pVal)==false)
    {
      reVal = false;
      if(pIsShowAlert)
      {
	alert("字段'"+pTitle+"' 输入不合法，请输入数字");
      }
    }
    if(reVal==true && maxLen!=-1 && g_GetStrLen(pVal)>maxLen)
    {
      reVal = false;
      if(pIsShowAlert)
      {
	alert("字段'"+pTitle+"' 输入超长。请输入不超过"+maxLen+"位的数字");
      }
    }
  }
  else if(pDataType == "Date" )
  {
     if(g_IsDate(pVal)==false)
    {
      reVal = false;
      if(pIsShowAlert)
      {
	alert("字段'"+pTitle+"' 输入不合法，请输入正确格式的日期.如:2005-09-18");
      }
    }
  }
  else if(pDataType=="DateTime")
  {
    if(g_IsDateTime(pVal)==false)
    {
      reVal = false;
      if(pIsShowAlert)
      {
	alert("字段'"+pTitle+"' 输入不合法，请输入正确格式的日期时间.如:2005-09-18 12:09:00");
      }
    }
  }

  else if(pDataType == "PostCode")
  {
    if(g_IsPostalCode(pVal)==false)
    {
      reVal = false;
      if(pIsShowAlert)
      {
	alert("字段'"+pTitle+"' 输入不合法，邮政编码应为6位数字.如:210000");
      }
    }
  }
  
  return reVal;

}

function FormRowSet_verify(pFieldName)
{
  return this.validate(pFieldName,true,true);
}
function FormRowSet_addListBoxElement(pFieldName,value,text)
{
	var listDataSourceName = FormRowSet_All_getFieldSpanObj(this.DBFormPK,pFieldName).ls;
    var source = this.ListDataSource.find(listDataSourceName);
    if(source!=null){
    	source.addOption(value,text);
    }
}
function FormRowSet_clearListBox(pFieldName)
{
  var listDataSourceName = FormRowSet_All_getFieldSpanObj(this.DBFormPK,pFieldName).ls;
  var source = this.ListDataSource.find(listDataSourceName);

  if(source!=null)
     source.clear();
  var spanObj = FormRowSet_All_getFieldSpanObj(this.DBFormPK,pFieldName);

  if(spanObj)
  {
     spanObj.Action_SetValue("","",false);
  }
}

function FormRowSet_getListBoxAllItem(pFieldName){
  if(pFieldName==null)
  {
    return;
  }
  pFieldName = FormRowSet_All_StringTrim(pFieldName);
  if(pFieldName == ""){
    return;
  }
  var fieldObj = FormRowSet_All_getFieldSpanObj(this.DBFormPK,pFieldName).ls;
  var source = this.ListDataSource.find(fieldObj);

  if(source!=null){
    var reValArray = new Array();
    for(var i=0;i<source.options.length;i++){
	    reValArray[reValArray.length] = {id:source.options[i].Id,value:source.options[i].Text};
    }
    return reValArray;
  }
}

//---add by zhouQiqi----2008-08-29---
//---delete option by id--------------------
function FormRowSet_removeListBoxOption(pFieldName,id)
{
  var listDataSourceName = FormRowSet_All_getFieldSpanObj(this.DBFormPK,pFieldName).ls;
  var source = this.ListDataSource.find(listDataSourceName);

  if(source!=null)
     source.removeOption(id);
  var spanObj = FormRowSet_All_getFieldSpanObj(this.DBFormPK,pFieldName);
  if(spanObj)
  {
     spanObj.Action_SetValue("","",false);
  }
}

/**********************************************************************************
*所有控件的统一使用的方法
*
*
**********************************************************************************/
function FormRowSet_Span_OnFocusIn(spanObj)
{

  if(spanObj)
  {
     if(spanObj.isFieldInital == "false")
     {
       FormRowSet_AllField_initial(spanObj);

     }

    if(spanObj.IsEditable=="false")
      return;


    var fromObj = window.event.fromElement;
    //如果fromElement是span的孩子对象，不算焦点得到
    for(var i=0;i<spanObj.childNodes.length;i++)
    {

      if(fromObj == spanObj.childNodes(i))
	{
	  FormRowSet_All_CancelBubble();
	  return false;
	}
    }

    if(spanObj.Action_OnFocus)
    {
      spanObj.Action_OnFocus();
    }
    //进入编辑状态.
    spanObj.isEditing=true;

    var dbFormObj = g_FormRowSetManager.get(spanObj.DBFormPK);
    dbFormObj.exeOnFocusIn(spanObj.FieldName,spanObj.I,spanObj.T);



  }


}

function FormRowSet_Span_OnFocusOut(spanObj)
{
  if(spanObj && spanObj.DBFormPK)
  {
    if(spanObj.IsEditable == "false")
      return;
    var targetObj = null;
    if(window.event)
      targetObj = window.event.toElement;
    if(targetObj==null)
       return;
    for(var i=0;i<spanObj.childNodes.length;i++)
    {

    if(targetObj == spanObj.childNodes(i) || targetObj.parentNode == spanObj.childNodes(i))
    {
      return;
    }
   }
   if(spanObj.Action_OnBlur)
    {
	spanObj.Action_OnBlur(spanObj);
    }
   //进入编辑状态.
   spanObj.isEditing=false;
   var dbFormObj = g_FormRowSetManager.get(spanObj.DBFormPK);
   dbFormObj.exeOnFocusOut(spanObj.FieldName,spanObj.I,spanObj.T);

  }


}


function FormRowSet_AllField_initial(obj)
{
   var spanObj =obj
   if(spanObj && spanObj.DBFormPK && spanObj.EditType && 
   		(spanObj.isFieldInital).toLowerCase()=="false")
   {
   	 var tmp_span_editType = spanObj.EditType.toLowerCase();
   	 
     eval("spanObj.Action_GetValue=FormRowSet_AllField_GetValue");
     eval("spanObj.Action_GetDisplayText=FormRowSet_AllField_GetDisplayText");
     eval("spanObj.Action_ToXmlString=FormRowSet_AllField_toXmlString");
    
     

     if(tmp_span_editType == g_Form_DBListBox.toLowerCase())
     {
       eval("spanObj.Action_OnFocus=FormRowSet_Field_DBListBox_OnFocus");
       eval("spanObj.Action_OnSetEditable= FormRowSet_Field_DBListBox_OnSetEditable");

       eval("spanObj.Action_SetValue=FormRowSet_Field_DBListBox_SetValue");
       eval("spanObj.Action_OnBlur=FormRowSet_Field_DBListBox_onBlur");
       eval("spanObj.Action_SetTips=FormRowSet_AllField_SetDisplayTextAsTitle");


     }
     else if(tmp_span_editType == g_Form_DBEdit.toLowerCase() )
     {
	 eval("spanObj.Action_OnSetEditable= FormRowSet_AllField_OnSetEditable");
	 eval("spanObj.Action_SetValue=FormRowSet_AllField_SetValue");
	 eval("spanObj.Action_OnBlur=FormRowSet_AllField_OnBlur");
	 eval("spanObj.Action_SetTips=FormRowSet_AllField_SetValueAsTitle");
     }
     else if(tmp_span_editType == g_Form_DBPassword.toLowerCase())
     {
	eval("spanObj.Action_OnSetEditable= FormRowSet_AllField_OnSetEditable");
	eval("spanObj.Action_SetValue=FormRowSet_AllField_SetValue");
	eval("spanObj.Action_OnBlur=FormRowSet_AllField_OnBlur");
     }
     else if(tmp_span_editType == g_Form_DBLable.toLowerCase())
     {
	 eval("spanObj.Action_SetValue=FormRowSet_AllField_ShowText_SetValue");
	 eval("spanObj.Action_SetTips=FormRowSet_AllField_SetDisplayTextAsTitle");
     }

     else if(tmp_span_editType == g_Form_DBLink.toLowerCase())
     {
	eval("spanObj.Action_SetValue=FormRowSet_Field_DBLink_SetValue");
     }

     else if(tmp_span_editType == g_Form_DBCheckBox.toLowerCase())
     {
	eval("spanObj.Action_OnSetEditable= FormRowSet_Field_DBCheckBox_OnSetEditable");
	eval("spanObj.Action_SetValue=FormRowSet_Field_DBCheckBox_OnSetValue");


     }
     else if(tmp_span_editType == g_Form_DBDate.toLowerCase() 
     	|| tmp_span_editType == g_Form_DBDateTime.toLowerCase())
     {
     //hexg 
	eval("spanObj.Action_OnSetEditable= FormRowSet_Field_DBDate_OnSetEditable");
	eval("spanObj.Action_SetValue=FormRowSet_AllField_SetValue");
	eval("spanObj.Action_OnBlur=FormRowSet_DateTimeField_OnBlur");
	eval("spanObj.Action_GetValue=FormRowSet_DATE_GetValue");
     }
     else if(tmp_span_editType == g_Form_DBTextArea.toLowerCase())
     {
       eval("spanObj.Action_OnSetEditable= FormRowSet_AllField_OnSetEditable");
       eval("spanObj.Action_SetValue=FormRowSet_Field_DBTextArea_SetValue");
       eval("spanObj.Action_OnBlur=FormRowSet_AllField_OnBlur");
       eval("spanObj.Action_GetDisplayText=FormRowSet_Field_DBTextArea_GetDisplayText");
       eval("spanObj.Action_GetValue=FormRowSet_Field_DBTextArea_GetValue");


     }
     else if(tmp_span_editType == g_Form_DBOpenWin.toLowerCase())
     {
       eval("spanObj.Action_SetValue=FormRowSet_AllField_ShowText_SetValue");
       eval("spanObj.Action_OnSetEditable= FormRowSet_Field_DBOpenWin_OnSetEditable");
     }
     else if(tmp_span_editType == g_Form_DBSpan.toLowerCase())
     {
	 eval("spanObj.Action_SetValue=FormRowSet_Field_DBSpan_SetValue");
	 eval("spanObj.Action_SetTips=FormRowSet_AllField_SetDisplayTextAsTitle");
     }
     else if(tmp_span_editType == g_Form_DBHtml.toLowerCase())
     {
        eval("spanObj.Action_SetValue=FormRowSet_Field_DBHtml_SetValue");
     }
     else if(tmp_span_editType == g_Form_DBFile.toLowerCase())
     {
       eval("spanObj.Action_SetValue=FormRowSet_Field_DBLink_SetValue");
     }

     spanObj.isFieldInital ="true";

   }

}

//hexg 20060607
//增加对日期和时间在失去焦点的时候得判断
function FormRowSet_DateTimeField_OnBlur(spanObj){
	if(spanObj && spanObj.DBFormPK && spanObj.EditType)
	{	
		var bValid = false;
		var value = spanObj.childNodes(0).value;
		
		//如果输入为空，默认为合法值
		if(value==''){
			bValid = true;
		}else{
			if((spanObj.EditType).toLowerCase() == g_Form_DBDate.toLowerCase()) {
				bValid = g_IsDate(value);
				if(!bValid){
					alert("'" +value +"' 是非法的日期值！");
				}
			}
			else if((spanObj.EditType).toLowerCase() == g_Form_DBDateTime.toLowerCase()){
				bValid = g_IsDateTime(value);
				if(!bValid){
					alert("'" +value +"' 非法的时间值！");
				}
			}
		}
		
		if(bValid){
			spanObj.Action_SetValue(spanObj.childNodes(0).value,spanObj.childNodes(0).value,true);
		}else{
			spanObj.Action_SetValue('','',true);
	    }
	}
}

function FormRowSet_All_getFieldSpanObj(pDBFormPK,pFieldName)
{
  var obj =  document.all("FormRowSet_"+pDBFormPK+"_"+pFieldName.toUpperCase());
  if(obj && obj.isFieldInital)
  {
    if(obj.isFieldInital=="false")
      FormRowSet_AllField_initial(obj);
  }
  return obj;
}

function FormRowSet_All_getStyleName(pEditType,pFlag)
{
  var name = null;
  if(pFlag == true)
  {
     name = g_FormFieldstyleArray[pEditType];
     if(name==null)
     {
       alert("[FormRowSet_All_getStyleName]没有找到控件对应的css的class的名称。编辑类型为:"+pEditType);
     }
  }
  else
  {
     name =  g_FormFieldDisabledStyleArray[pEditType];
     if(name==null)
     {
       alert("[FormRowSet_All_getStyleName]没有找到控件对应的css的diabled class的名称。编辑类型为:"+pEditType);
     }

  }
  return name;
}

//对于日期框的getvalue，不再对日期的合法性进行校验
function FormRowSet_DATE_GetValue()
{
 	if(this && this.isEditing && this.DBFormPK && this.EditType)
	{	
		var value = this.childNodes(0).value;
		this.Action_SetValue(this.childNodes(0).value,this.childNodes(0).value,true);
	}
  return this.I;
}

function FormRowSet_AllField_GetValue()
{
  if(this.isEditing && this.Action_OnBlur)
    {
      this.Action_OnBlur(this);
    }
  return this.I;
}
function FormRowSet_AllField_GetDisplayText()
{
  if(this.isEditing && this.Action_OnBlur)
    {
	this.Action_OnBlur(this);
    }
  return this.T;
}


function FormRowSet_AllField_SetValue(pVal,pDisplayText,pIsCreateEvent)
{
  var dbFormObj = g_FormRowSetManager.get(this.DBFormPK);
  if(pDisplayText==null)pDisplayText = pVal;
  
  this.childNodes(0).value = dbFormObj.getFieldShowText(this.FieldName,pDisplayText);
  FormRowSet_AllField_Private_SetValue(this,pVal,pDisplayText,pIsCreateEvent);

}
function FormRowSet_AllField_ShowText_SetValue(pVal,pDisplayText,pIsCreateEvent)
{
  var dbFormObj = g_FormRowSetManager.get(this.DBFormPK);
  this.childNodes(0).value =dbFormObj.getFieldShowText(this.FieldName,pDisplayText);
  FormRowSet_AllField_Private_SetValue(this,pVal,pDisplayText,pIsCreateEvent);


}


function FormRowSet_AllField_Private_SetValue(pSpanObj,pVal,pDisplayText,pIsCreateEvent)
{

  if(pIsCreateEvent==null) pIsCreateEvent = false;
  if(pDisplayText == null) pDisplayText = pVal;
  var isDiff = false;
  var oldVal="";
  var oldText="";
  if(pSpanObj.oldVal==null)
    pSpanObj.oldVal=pSpanObj.I;

  if(pSpanObj.oldVal!=pVal)
  {
    isDiff = true;
    oldVal = pSpanObj.oldVal==null?"":pSpanObj.oldVal;
    oldText= pSpanObj.oldText;
  }


  pSpanObj.oldVal =pVal;
  pSpanObj.oldText = pDisplayText;
  pSpanObj.I = ""+pVal;
  pSpanObj.T = pDisplayText;
  //修改sts

  if(pSpanObj.OldI!=pSpanObj.I)
  {

    if(pSpanObj.Sts == "O")
      {
       pSpanObj.Sts = "U";
      }
     else if(pSpanObj.Sts == "NN" || pSpanObj.Sts=="N")
      {
       pSpanObj.Sts = "N";
      }
  }
  if(pSpanObj.Action_SetTips)
  {
    pSpanObj.Action_SetTips();
  }
  var dbFormObj = g_FormRowSetManager.get(pSpanObj.DBFormPK);

  

  if(pIsCreateEvent!=null && pIsCreateEvent==true && isDiff)
  {
    if(dbFormObj.Sts =="O")
    {
      dbFormObj.Sts = "U";
    }
    if(dbFormObj.Sts =="NN" || dbFormObj.Sts=="N")
    {
      dbFormObj.Sts ="N";
    }
    dbFormObj.exeOnValueChange(pSpanObj.FieldName,oldVal,oldText,pSpanObj.I,pSpanObj.T);
  }

}




function FormRowSet_AllField_OnBlur(spanObj)
{
  //var spanObj = srcObj.parentElement;
  if(spanObj && spanObj.DBFormPK && spanObj.EditType)
  {
    spanObj.Action_SetValue(spanObj.childNodes(0).value,spanObj.childNodes(0).value,true);
  }
}

function FormRowSet_AllField_OnSetEditable(pFlag)
{
  FormRowSet_AllField_Private_OnSetEditable(this,pFlag)
}

function FormRowSet_AllField_Private_OnSetEditable(pSpanObj,pFlag)
{

  if(pSpanObj.onfocusout)
     pSpanObj.onfocusout();

  var styleName = FormRowSet_All_getStyleName(pSpanObj.EditType,pFlag);
  if(pFlag == true)
    {
      pSpanObj.childNodes(0).readOnly = false;
      pSpanObj.childNodes(0).className =styleName;
      pSpanObj.IsEditable = "true";
    }
  else
    {
      pSpanObj.childNodes(0).readOnly = true;

      pSpanObj.childNodes(0).className =styleName;
      pSpanObj.IsEditable = "false";
    }

}

function FormRowSet_AllField_toXmlString(pFlag)
{

	var reValArray = new Array();
	if(this.Sts=="NN")
		return "";
    
	//新增，且修改过数据
	if(this.Sts=="N")
     {
	  //如果是新增数据，并经过改动，但最后改动的value数据为""，则认为是NN,不输出到xml中
	  if(this.I==null || this.I==""){
		return "";
	  }
     }
     var OldId = this.OldI;
     var OldText = this.OldT;
     //防止NewId是数字的时候，并且为0时出现问题，所以前头加引号
     var NewId = ""+this.Action_GetValue();
     var NewText = ""+this.Action_GetDisplayText();
     
     if(OldId == OldText)
		OldText = "";
     if(NewId == NewText)
       NewText = "";

     if (this.Sts =="O")
	{

	  if(pFlag)
	  {
	    if (OldId)
	      reValArray[reValArray.length] = (" OldID='" + FormRowSet_All_CheckAndTrans(OldId) + "' ");
	    if (OldText)
	      reValArray[reValArray.length] = (" OldText ='" + FormRowSet_All_CheckAndTrans(OldText) +"' ");
	  }
	  else
	  {
	    if(OldId!=null && OldText!=null)
	    {

		reValArray[reValArray.length] = (" OldID='" + FormRowSet_All_CheckAndTrans(OldId) + "' ");
		reValArray[reValArray.length] = ("OldText ='" + FormRowSet_All_CheckAndTrans(OldText) +"' ");
	    }

	  }
	if(FormRowSet_All_StringTrim(reValArray.join(""))!="")
	{
	  reValArray[reValArray.length]=">";
	}



	}
    //其他状态时，包括U,D,N(新增)
    else
	{

	  //当修改状态时，如果以前有值，然后改为"",则设置字段状态为D状态。
	  if(this.Sts=="U")
	  {
      
	  	if((OldId!=null && OldId!='') && (NewId==null || NewId=='')){
         this.Sts = "D";
        }
	  }
	  //hexg ,20060923增加以下代码
	  else if(this.Sts=="D"){
	  	if(OldId!=null && NewId!=null && NewId!='') this.Sts = "U";
	  }
	  
	  if (OldId)
	       reValArray[reValArray.length] = (" OldID='" + FormRowSet_All_CheckAndTrans(OldId) + "'");
	  if (OldText)
	       reValArray[reValArray.length] = (" OldText ='" + FormRowSet_All_CheckAndTrans(OldText) +"' ");
	  if(this.Sts == "U")
	  {
	    if(NewId!=null)
	    reValArray[reValArray.length] = ( " ID ='" + FormRowSet_All_CheckAndTrans(NewId) +"' ");
	  }
	 else
	 {
	   if(NewId)
	      reValArray[reValArray.length] = ( " ID ='" + FormRowSet_All_CheckAndTrans(NewId) +"' ");
	 }




	 if (NewText){
	    NewText = FormRowSet_All_CheckAndTrans(NewText);
	    if(NewText.replace(" ","").length ==0){
	       reValArray[reValArray.length] = " NewText=\"" + NewText + "\">";
	    }else
	       reValArray[reValArray.length] =(">"+ FormRowSet_All_CheckAndTrans(NewText));
	  }
	else
	 {
	   if(FormRowSet_All_StringTrim(reValArray.join(""))!="")
	    {
	     reValArray[reValArray.length]=">";
	    }
	 }





	}

     if(FormRowSet_All_StringTrim(reValArray.join(""))!="")
     {
       return "<Col Name='"+this.FieldName + "' Sts= '"+this.Sts+"' "+reValArray.join("")+"</Col>";
     }
     else
     {
	return "";
     }



}

function  FormRowSet_All_StringTrim(str){
  return str.replace(/(^\s*)|(\s*$)/g, "");
}



//进行特殊字符替换
function FormRowSet_All_TransStr(str)
  {

    if(str=="")return str;
    strArray=str.split("&");
    tmpStr=strArray[0];
    if(strArray.length>1)
	for(i=1;i<strArray.length;i++)
    {
      tmpStr+="&amp;";
      tmpStr+=strArray[i];
    }
    str=tmpStr;
    while(str.indexOf(">")>=0)
    {
      index=str.indexOf(">");
      str=str.substring(0,index)+"&gt;"+str.substring(index+1,str.length);
    }
    while(str.indexOf("<")>=0)
    {
      index=str.indexOf("<");
      str=str.substring(0,index)+"&lt;"+str.substring(index+1,str.length);
    }
    while(str.indexOf("'")>=0)
    {
      index=str.indexOf("'");
      str=str.substring(0,index)+"&apos;"+str.substring(index+1,str.length);
    }
    while(str.indexOf('"')>=0)
    {
      index=str.indexOf('"');
      str=str.substring(0,index)+"&quot;"+str.substring(index+1,str.length);
    }
    return str;
  }
function FormRowSet_All_CheckAndTrans(str){
   str = str.toString();
   if(FormRowSet_All_CheckStr(str))
     return FormRowSet_All_TransStr(str);
   else
     return str;

}
function FormRowSet_All_CheckStr(str)
  {

    if(str.indexOf("&")>=0||str.indexOf(">")>=0||str.indexOf("<")>=0||str.indexOf("'")>=0||str.indexOf('"')>=0)
      return true;
    else
      return false;
  }
function FormRowSet_All_CancelBubble()
{

     window.event.returnValue = false;
     window.event.cancelBubble=true;

}


function FormRowSet_AllField_getCursorPosition(pUIObj)
{
  var qswh="@#%#^&#*$";
  //pUIObj.focus();
  rng=document.selection.createRange();
  rng.text=qswh;
  var pos=pUIObj.value.indexOf(qswh);
  rng.moveStart("character", -qswh.length);
  rng.text="";
  //window.status = pos;
  return pos;
}

function FormRowSet_AllField_OnKeyPress(pUIObj)
{
	if(pUIObj && pUIObj.parentNode.DBFormPK)
  {
    var dbFormPk = pUIObj.parentNode.DBFormPK;
    var fieldName = pUIObj.parentNode.FieldName;
    var dbFormObj = g_FormRowSetManager.get(dbFormPk);
    dbFormObj.exeOnKeyPress(fieldName,pUIObj);
  }
}

function FormRowSet_AllField_OnKeyDown(pUIObj)
{
	if(pUIObj.caretRange==null)
	{
	   pUIObj.caretRange =document.selection.createRange(); 
	}
	if(pUIObj && pUIObj.parentNode.DBFormPK)
  {
    var dbFormPk = pUIObj.parentNode.DBFormPK;
    var fieldName = pUIObj.parentNode.FieldName;
    var dbFormObj = g_FormRowSetManager.get(dbFormPk);
    dbFormObj.exeOnKeyDown(fieldName,pUIObj);
  }
}
//字段公用的keyup事件方法
function FormRowSet_AllField_OnKeyUp(pUIObj)
{
  if(pUIObj.readOnly || pUIObj.disabled){
    return;
  }
  if(pUIObj && pUIObj.parentNode.DBFormPK)
  {
    var dbFormPk = pUIObj.parentNode.DBFormPK;
    var fieldName = pUIObj.parentNode.FieldName;
    var dataType = pUIObj.parentNode.da;
    var maxLen = pUIObj.parentNode.ml;

    var changePosFlag = false;
    if(pUIObj.caretRange!=null)
    {
      	var inputText =  pUIObj.caretRange.text; 
      	
        var bFilter =false;
        
      	if(dataType == "Integer" || dataType=="Long" || dataType=="Short" || dataType=="int")
        {
          var tmp = inputText;
          inputText = inputText.replace(/[^\d\-]/g,'');
          if(inputText != tmp){
            bFilter =true;
          }
        }
        //待增加float限制
       if(dataType == "Float" || dataType=="Double"){
          var tmp = inputText;
          inputText = inputText.replace(/[^(\d ,\.\-)]/g,'');
          if(inputText != tmp){
            bFilter =true;
          }
        }
        
        if(dataType=="PostCode")
        {
          var tmp = inputText;
          maxLen = 6;
          inputText = inputText.replace(/[^\d]/g,'');
          if(inputText != tmp){
            bFilter =true;
          }
        }
        //长度限制的时候处理
        if((g_GetStrLen(pUIObj.value)-maxLen)>0)
        {
			var valid_len = g_GetStrLen(inputText) - (g_GetStrLen(pUIObj.value)-maxLen);
			
            if(valid_len==0){
				pUIObj.caretRange.text='';
			}
			else{
				pUIObj.caretRange.text = g_getSubStrInByte(inputText,valid_len);	
			}
		}
        //如果没有超过长度限制,并且输入的值被过滤掉,则响应一下
        else if(bFilter){
            pUIObj.caretRange.text = inputText;
        }
     
      
    }
    pUIObj.caretRange = null;
  }

}


//字段公用的onbeforepatst方法
function FormRowSet_AllField_OnBeforePaste(pUIObj)
{
  if(pUIObj && pUIObj.parentNode.DBFormPK && clipboardData.getData('text')!=null)
  {
    var dbFormPk = pUIObj.parentNode.DBFormPK;
    var fieldName = pUIObj.parentNode.FieldName;
    var dataType = pUIObj.parentNode.da;
    var maxLen = pUIObj.parentNode.ml;
    
    var dbFormObj = g_FormRowSetManager.get(dbFormPk);
    dbFormObj.exeOnBeforePaste(fieldName);
           
    if(dataType == "Integer" || dataType=="Long" || dataType=="Short" || dataType=="int")
    {
      clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''));
    }
    if(dataType=="PostCode")
    {
      maxLen = 6;
      clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''));
    }
    
    if(g_GetStrLen(pUIObj.value)-maxLen)
    {
      var valid_len = g_GetStrLen(document.selection.createRange().text) - (g_GetStrLen(pUIObj.value)-maxLen);
      var pastedata = g_getSubStrInByte(clipboardData.getData('text'),valid_len);
		
        
		if(pastedata==''){
			window.event.returnValue=false
		}else{
            if(clipboardData.getData('text').length>pastedata.length){
	          alert('复制的内容超过允许的长度，数据被截取！');
	        }
			clipboardData.setData('text',pastedata);
		}
	 }
  }

}


//设置控件的value值为title属性
function FormRowSet_AllField_SetValueAsTitle()
{
  var newTitle = this.I;
  this.childNodes(0).title = newTitle;
}
//设置控件的displayText为title属性
function FormRowSet_AllField_SetDisplayTextAsTitle()
{
   var newTitle = this.T;
   this.childNodes(0).title = newTitle;
}






/**********************************************************************************/











/****************DBListBox**********************************************************/



function FormRowSet_Field_DBListBox_OnFocus()
{
    if(this.editor!=null) {
   		return;
   	}
   	
    var dbFormObj = g_FormRowSetManager.get(this.DBFormPK);
    var tmpWidth = this.childNodes(0).style.pixelWidth;
    var tmpHeight = this.childNodes(0).style.pixelHeight;
    
    this.editor = FormRowSet_Field_DBListBox_getEditor(dbFormObj,this.FieldName,this.I,this.T);
    
    if(this.listOptionEditable =='true'){
    	this.childNodes(0).readOnly = false;
    	this.childNodes(0).onfocusout = null;
    	
    	this.editor.setRect(tmpWidth,(tmpHeight));
    	var newSpanObject = document.createElement("span");
    	
		newSpanObject.style.cssText="overflow:hidden;display:inline";
	    newSpanObject.style.width=20;
	    newSpanObject.appendChild(this.editor);
	    this.appendChild(newSpanObject);
	    
	   
	    
	    this.childSpan = newSpanObject;
	    
	    this.childNodes(0).style.width = tmpWidth-newSpanObject.style.pixelWidth;
	    this.editor.style.marginLeft = this.childNodes(0).offsetLeft - newSpanObject.offsetLeft;
	    
	    if(this.I == null || this.I ==''){
	    	if(this.editor.selectedIndex !=null  && this.editor.selectedIndex==0 && this.I!= this.editor.getID()){
     			this.Action_SetValue(this.editor.getID(),this.editor.getValue(),true);
    		}
	    }
	    else{
		    var options  =this.editor.options;
		  	var isSelfOption = true;
		  	for(i=0;i<options.length;i++){
		  		if(options[i].value == this.I){
		  			isSelfOption = false;
		  			break;
		  		}
		  	}
		  	
		  	if(isSelfOption == true){
		  		options[options.length] = new Option(this.I , this.I,true,true);
		  	}
	  	}
    }else{
    	this.childNodes(0).style.display="none";
    	this.appendChild(this.editor);
    	this.editor.setRect(tmpWidth,(tmpHeight));
    	
  		if(this.editor.selectedIndex !=null  && this.editor.selectedIndex==0 && this.I!= this.editor.getID())
   		{
     		this.Action_SetValue(this.editor.getID(),this.editor.getValue(),true);
    	}
    }   
    
   
    
    //防止整个页面不可见时执行这段代码出错,如果失去焦点失败，则让其失去焦点
    try{
    	this.editor.focus();
    }catch(e){
    	this.Action_OnBlur(this);
    }
}

function FormRowSet_Field_DBListBox_OnSetEditable(pFlag)
{
  if(this.childNodes.length==2)
  {
    this.Action_OnBlur(this);
  }
  FormRowSet_AllField_Private_OnSetEditable(this,pFlag);


}

//下拉列表编辑器的setValue方法
function FormRowSet_Field_DBListBox_Editor_SetValue(id,displayText){
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
function FormRowSet_Field_DBListBox_Editor_getID(){
      if(this.selectedIndex<0) return "";
	    var selectOption = this.options(this.selectedIndex);
	if((selectOption) &&(selectOption.value))
	    return selectOption.value;
	 return "";

}
 function FormRowSet_Field_DBListBox_Editor_setRect(pWidth,pHeight)
{
  if(pWidth && parseInt(pWidth,10)>0)
     this.style.pixelWidth=pWidth;
  if(pHeight && parseInt(pHeight,10)>0)
     this.style.pixelHeight = pHeight;

}
function FormRowSet_Field_DBListBox_Editor_getValue(){
      if(this.selectedIndex<0) return "";
	  var selectOption = this.options(this.selectedIndex);
      if (selectOption)
	return selectOption.text
      else
	return "";
}



function FormRowSet_Field_DBListBox_getEditor(pDBFormObj,pFieldName,pVal,pText)
{
   var dispAttr = FormRowSet_All_getFieldSpanObj(pDBFormObj.DBFormPK,pFieldName).lsdis;
   var ls = FormRowSet_All_getFieldSpanObj(pDBFormObj.DBFormPK,pFieldName).ls;
   var UIObject = document.createElement("select");
   UIObject.UIType ="DBListBox";
   UIObject.setValue=FormRowSet_Field_DBListBox_Editor_SetValue;
   UIObject.getID = FormRowSet_Field_DBListBox_Editor_getID;
   UIObject.getValue = FormRowSet_Field_DBListBox_Editor_getValue;
   UIObject.setRect = FormRowSet_Field_DBListBox_Editor_setRect;
  
   var listsource = pDBFormObj.ListDataSource.find(ls);
   if(listsource){
      listsource.fillListBox(pDBFormObj,0,UIObject,dispAttr,pVal);
   }
   UIObject.setValue(pVal,pText);
   UIObject.className ="dbform_listbox_list_style";
   UIObject.onchange = FormRowSet_Field_DBListBox_ListBoxOnChange;
   return UIObject;
  
}

function FormRowSet_Field_DBListBox_onBlur(spanObj)
{	
  var textObject = spanObj.childNodes(0);
  if(this.editor!=null && spanObj.listOptionEditable =='true' ){
  	var options  =this.editor.options;
  	var isSelfOption = true;
  	for(i=0;i<options.length;i++){
  		if(options[i].text == textObject.value){
  			isSelfOption = false;
  			break;
  		}
  	}
  	
  	if(isSelfOption == true){
  		options[options.length] = new Option(textObject.value , textObject.value,true,true);
  	}
  }
  
  if(spanObj.childNodes.length==2 && this.editor!=null)
  {
     var newText = spanObj.editor.getValue();
     var newVal =  spanObj.editor.getID();
     if(newText=="") newText = newVal;
     spanObj.Action_SetValue(newVal,newText,true);
     spanObj.childNodes(0).style.display="inline";
     
     if(spanObj.childSpan != null){
     	spanObj.childNodes(0).onfocusout=FormRowSet_All_CancelBubble;
     	spanObj.removeChild(spanObj.childSpan);
     	this.childNodes(0).style.width = this.childNodes(0).style.pixelWidth+spanObj.childSpan.style.pixelWidth
     }else if(spanObj.editor!=null){
	     spanObj.removeChild(spanObj.editor);
     }
     spanObj.editor = null;
     spanObj.childSpan = null;
  }
}

function FormRowSet_Field_DBListBox_ListBoxOnChange()
{
  var srcObj = event.srcElement;
  if(srcObj && srcObj.parentNode && typeof(srcObj.parentNode.DBFormPK) =='undefined'){
  	srcObj = srcObj.parentNode;
  }

  if(srcObj && srcObj.parentNode && srcObj.parentNode.DBFormPK)
  {
     var spanObj = srcObj.parentNode;
     var newText = spanObj.editor.getValue();
     var newVal =  spanObj.editor.getID();
     if(newText=="") newText = newVal;
     
     spanObj.Action_SetValue(newVal,newText,true);
  }
}
function FormRowSet_Field_DBListBox_SetValue(pVal,pDisplayText,pIsCreateEvent)
{
  var dbFormObj = g_FormRowSetManager.get(this.DBFormPK);
  var newText = "";
  if(dbFormObj.ListDataSource!=null || dbFormObj.ListDataSource!="")
  {
	var newText=null;
	var lsName=FormRowSet_All_getFieldSpanObj(this.DBFormPK,this.FieldName).ls;
	var lsDispName=FormRowSet_All_getFieldSpanObj(this.DBFormPK,this.FieldName).lsdis;
	if(lsName!=""){
		  var listsource = dbFormObj.ListDataSource.find(lsName);
		  if(listsource)
		     newText = listsource.findTextById(pVal,lsDispName);
		}
	//modified by hexg 20060614
	if(newText==null)
	    newText =pDisplayText;
  }
  //modify by zr 2007-2-7.如果下拉列表存在，还需要设置下拉列表的显示值
  if(this.editor!=null){
	     this.editor.setValue(pVal,newText);
  }

  FormRowSet_AllField_Private_SetValue(this,pVal,newText,pIsCreateEvent);
  
  var dbFormObj = g_FormRowSetManager.get(this.DBFormPK);
  this.childNodes(0).value = dbFormObj.getFieldShowText(this.FieldName, this.T);

}


/*************************************************end dblistbox******************************/



/*************begin dbcheckbox**************************************************************/
function FormRowSet_Field_DBCheckBox_OnClick(checkObj)
{
  var spanObj = checkObj.parentElement;
  if(spanObj && spanObj.DBFormPK)
  {
    if(checkObj.checked)
    {
      spanObj.Action_SetValue(checkObj.CV,checkObj.CV,true);
    }
    else
    {
      spanObj.Action_SetValue(checkObj.UCV,checkObj.UCV,true);
    }
  }
}
function FormRowSet_Field_DBCheckBox_OnSetValue(pVal,pDisplayText,pIsCreateEvent)
{

  if(pVal==this.childNodes(0).CV)
  {
    this.childNodes(0).checked= true;
  }
  else{
    pVal = this.childNodes(0).UCV;
    this.childNodes(0).checked = false;
  }
  FormRowSet_AllField_Private_SetValue(this,pVal,pVal,pIsCreateEvent);
}

function FormRowSet_Field_DBCheckBox_OnSetEditable(pFlag)
{
  if(pFlag)
  {
     this.childNodes(0).disabled = false;
     this.IsEditable = "true";
  }
  else
  {
     this.childNodes(0).disabled = true;
     this.IsEditable = "false";
  }


}

/*************end dbcheckbox***************************************************************/


/*************start dbdate,dbdateTime***************************************************************/
function FormRowSet_Field_DBDate_Btn_OnClick(btnObj)
{
  var spanObj = btnObj.parentElement;
  if(spanObj && spanObj.DBFormPK)
  {
    var oldDate = spanObj.Action_GetValue();
    var showType = "date";
    if((spanObj.EditType).toLowerCase() == g_Form_DBDateTime.toLowerCase())
       showType = "datetime";
    var paramObj = {showtype:showType,definedate:oldDate};
    var dlgLeft = event.screenX;
    var dlgTop = event.screenY;
    var height = "280";
    if(showType=="datetime")
       height = "320";
//    var newDate = openCalendarDlg(paramObj,"scroll:no;resizable:no;status:no;dialogLeft:"+dlgLeft+";dialogTop:"+dlgTop+";dialogHeight:"+height+"px;dialogWidth:240px");
    var newDate = window.showModalDialog(_gModuleName + "/jsv2/DBCalendarDlg.htm",paramObj,"scroll:no;resizable:no;status:no;dialogLeft:"+dlgLeft+";dialogTop:"+dlgTop+";dialogHeight:"+height+"px;dialogWidth:240px");
    if(newDate && newDate != "none")
       spanObj.Action_SetValue(newDate,newDate,true);

  }
}

function FormRowSet_Field_DBDate_OnSetEditable(pFlag)
{
  FormRowSet_AllField_Private_OnSetEditable(this,pFlag);
  if(pFlag)
   this.childNodes(1).disabled = false;
  else
   this.childNodes(1).disabled = true;
}

/*************end dbdate,dbdateTime***************************************************************/

/********************dblink***********************************************************************/
function FormRowSet_Field_OnDBLinkClick(pDBFormPK,pFieldName)
{
  var formObj =  g_FormRowSetManager.get(pDBFormPK);
  var val = formObj.getValue(pDBFormPK);
  var text = formObj.getDisplayText(pDBFormPK);
  formObj.exeOnDBLink(pDBFormPK,pFieldName,val,text);
}
function FormRowSet_Field_DBLink_SetValue(pVal,pDisplayText,pIsCreateEvent)
{
  FormRowSet_AllField_Private_SetValue(this,pVal,pDisplayText,pIsCreateEvent);
  if(pDisplayText == null)  pDisplayText= pVal;
  var dbFormObj = g_FormRowSetManager.get(this.DBFormPK);
  this.childNodes(0).innerText = dbFormObj.getFieldShowText(this.FieldName,pDisplayText);
  
}



/********************end dblink*******************************************************************/


/******************dbopenwin*********************************************************************/
function FormRowSet_Field_DBOpenWin_BtnClick(btnObj,pPara)
{
  var spanObj = btnObj.parentElement;
  if(spanObj && spanObj.DBFormPK)
  {
     var formObj =  g_FormRowSetManager.get(spanObj.DBFormPK);
     var val = formObj.getValue(spanObj.FieldName);
     var text = formObj.getDisplayText(spanObj.FieldName);
     var returnObj = formObj.exeOnDBLink(spanObj.DBFormPK,spanObj.FieldName,val,text,pPara);
     if(returnObj!=null && returnObj.id!=null)
     {
	 val = returnObj.id;
	 if(returnObj.text!=null)
	   {
	     text = returnObj.text;
	   }
	 else
	   {
	    text = val;
	    }
	spanObj.Action_SetValue(val,text,true);
      }
  }
}

function FormRowSet_Field_DBOpenWin_OnSetEditable(pFlag)
{
  FormRowSet_AllField_Private_OnSetEditable(this,pFlag);
  //第一个文本框永不可编辑.
  this.childNodes(0).disabled = true;
  if(pFlag)
   this.childNodes(1).disabled = false;
  else
   this.childNodes(1).disabled = true;
}
/***************** end openwin*******************************************************************/


/******************dbfile*********************************************************************/
function FormRowSet_Field_DBFile_BtnClick(btnObj,pBusiType) 
{
	if(pBusiType==null||pBusiType==""){
		alert("未配置业务类型！");
		return;
	}
	//根据业务类型获取保存路径
	//var rr=PostInfo(_gModuleName+"/business/com.ai.frame.attach.AttachAction?action=getSavePath&BUSI_TYPE="+pBusiType,"");
	//var aSavePath=rr.getValueByName("SAVE_PATH");	
	//调用uploadFileNew.jsp
	retObj=window.showModalDialog(_gModuleName+"/webframe/attach/uploadFileNew.jsp",window,"scroll:no;resizable:no;status:no;dialogHeight:400px;dialogWidth:500px");
	if (retObj!=null){
	  //设置文件名
	  var spanObj = btnObj.parentElement;
	  if(spanObj && spanObj.DBFormPK)
	  {	  	
	  	var sVirtualFile=retObj.virtualFileName;	  
	  	var fileName=retObj.fileName;	 	
	  	spanObj.Action_SetValue(sVirtualFile,fileName,true);
	  }	
	}
}

function FormRowSet_Field_OnDBFileClick(btnObj,pBusiType){
  var spanObj = btnObj.parentElement;
  if(spanObj && spanObj.DBFormPK)
  {
     var formObj =  g_FormRowSetManager.get(spanObj.DBFormPK);
     var filename = formObj.getValue(spanObj.FieldName);
     var disptext = formObj.getDisplayText(spanObj.FieldName);
     filename=g_StringTrim(filename);
     if(filename == '')return;
     
     window.open (_gModuleName+'/business/com.ai.frame.attach.AttachAction?action=doDownload&FILE_NAME='+filename+"&BUSI_TYPE="+pBusiType); 
   }	
}
/***************** end dbfile*******************************************************************/

/****************DBTextArea*********************************************************/
function  FormRowSet_Field_DBTextArea_SetValue(pVal,pDisplayText,pIsCreateEvent)
{ 
	
   //hexg ,2006-8-18
   var tmp_pVal = pVal.replace(/\x0d\x0a/g,'@~');
   
   FormRowSet_AllField_Private_SetValue(this,tmp_pVal,tmp_pVal,pIsCreateEvent);
   var dbFormObj = g_FormRowSetManager.get(this.DBFormPK);
 
  //hexg
   tmp_pVal = pVal.replace(/@~/g,'\x0d\x0a');
   this.childNodes(0).value = dbFormObj.getFieldShowText(this.FieldName,tmp_pVal);
}
function  FormRowSet_Field_DBTextArea_GetValue()
{
   if(this.Action_OnBlur)
    {
	this.Action_OnBlur(this);
    }
       
  //var re =/[\r][\n]/g;
 // return this.I.replace(re,"\\n");
 return this.I;
}
function FormRowSet_Field_DBTextArea_GetDisplayText()
{
   if(this.Action_OnBlur)
    {
	this.Action_OnBlur(this);
    }
  //var re =/[\r][\n]/g;
  //return this.T.replace(re,"\\n");
   return this.T;
}

/****************DBSpan*********************************************************/
function  FormRowSet_Field_DBSpan_SetValue(pVal,pDisplayText,pIsCreateEvent)
{
   FormRowSet_AllField_Private_SetValue(this,pVal,pDisplayText,pIsCreateEvent);
   var dbFormObj = g_FormRowSetManager.get(this.DBFormPK);
   this.childNodes(0).innerText = dbFormObj.getFieldShowText(this.FieldName,pDisplayText);
  
}
/*******************************************************************************/


/****************DBHtml*********************************************************/
function  FormRowSet_Field_DBHtml_SetValue(pVal,pDisplayText,pIsCreateEvent)
{
   FormRowSet_AllField_Private_SetValue(this,pVal,pDisplayText,pIsCreateEvent);
   var dbFormObj = g_FormRowSetManager.get(this.DBFormPK);
   this.childNodes(0).innerHTML = dbFormObj.getFieldShowText(this.FieldName,pDisplayText);
   
}
/*******************************************************************************/

//设置一个字段的中文输入是否开启
function FormRowSet_setImeModeSts(fieldName,sts){
  var fieldObj = FormRowSet_All_getFieldSpanObj(this.DBFormPK,fieldName);
  if(!fieldObj) return;
  if(sts){
    fieldObj.childNodes(0).style.imeMode ='auto';
  }else{
    fieldObj.childNodes(0).style.imeMode ='disabled';
  }
}