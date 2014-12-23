/**
获取Listbox对象:
	g_getListBox(id)：获取下来列表框对象。之后可以使用方法:
方法:
	getID():获取ID值
	getValue()：获取文本值
	setValue(value):设置下拉数据源的指定value的项目为选中状态
	addItem(id,value):增加一个option
	delItem(id):删除指定value的option
	delSelItem():删除选定的option
	refresh(para):根据参数重新刷新数据
	delAllItem():删除下拉框所有数据
	getAllItem():返回列表中所有的值和text，返回类型为array。里面为object，object.id为值，obj.value为文本
	setDisabled(value):设置下拉框的可用和不可用的状态，true代表不可用,false代表,
									下拉框可用和不可用的样式在AppFrameCss.jsp中定义
	filterValue(input_value):根据input_value的值自动过滤下拉列表				
事件: 
	OnItemChange ,参数 id, text
	OnItemClick,  参数 id, text
	OnItemDblClick,参数 id, text
*/

function g_getListBox(id){
	var UIObject = document.all(id);
	if(UIObject == null){
	    alert("未能找到下拉列表对象：" + id);
	    return;
	}
    if(UIObject.getID == null){
	   // alert("Initial");
	   UIObject.getID = DBListBoxTag_getID;
	   UIObject.getValue = DBListBoxTag_getValue;
	       UIObject.setValue = DBListBoxTag_setValue;
	       UIObject.addItem = DBListBoxTag_addItem;
	       UIObject.delItem = DBListBoxTag_delItem;
	       UIObject.delSelItem = DBListBoxTag_delSelItem;
	       UIObject.getAllItem = DBListBoxTag_getAllItem;
	       UIObject.delAllItem = DBListBoxTag_delAllItem;
	       UIObject.refresh = DBListBoxTag_refresh;
	       
	       //add by hexg
	       UIObject.setDisabled = DBListBoxTag_setDisabled;
           UIObject.clearFilterBackupData = DBListBoxTag_clearFilterBackupData;
           UIObject.filterValue = DBListBoxTag_filterValue;
           UIObject.replaceRefresh = DBListBoxTag_replaceRefresh;
    }
	return UIObject;
}

function DBListBoxTag_getID()
{

   if(this.showtype && this.showtype=="list")
	{
	   if(this.selectedIndex<0) return "";
	   var reValArray = new Array();
	   for(var i=0;i<this.options.length;i++)
		{
	   if(this.options(i).selected)
			{
			   reValArray[reValArray.length] = this.options(i).value;
			}
		}
       return reValArray.join(",");
	}
	else
	{
       if(this.selectedIndex<0) return "";
	    var selectOption = this.options(this.selectedIndex);
       if((selectOption) &&(selectOption.value))
	    return selectOption.value;
       return "";
	}

}

function DBListBoxTag_getValue()
{
	if(this.showtype && this.showtype=="list")
	{
	   if(this.selectedIndex<0) return "";
	   var reValArray = new Array();
	   for(var i=0;i<this.options.length;i++)
		{
	   if(this.options(i).selected)
			{
			   reValArray[reValArray.length] = this.options(i).text;
			}
		}
       return reValArray.join(",");
	}
	else
	{
	if(this.selectedIndex<0) return "";
			var selectOption = this.options(this.selectedIndex);
		if (selectOption)
			return selectOption.text
		else
			return "";
	}
}

function DBListBoxTag_setValue(id)
{
   if (id || id ==0 )
   {
     if(this.showtype && this.showtype=="list")
	   {
	   var selIdArray = id.split(",");

		   if(selIdArray)
		   {
		      for(var i=0;i<this.options.length;i++)
			{

			      for(var j=0;j<selIdArray.length;j++)
				   {
		      if(this.options[i].value == selIdArray[j] || (!this.options[i].value) && this.options[i].text ==selIdArray[j])
				   {
			     this.options[i].selected = true;
			     break;
		       }
				   }
				}
		   }


	   }
     else
	   {
	  for(var i=0;i<this.options.length;i++)
		  {
	     if(this.options[i].value == id || (!this.options[i].value) && this.options[i].text ==id)
			 {
		    this.options[i].selected = true;
		    return;
	     }
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


function DBListBoxTag_addItem(id,text)
{
  this.options[this.options.length] = new Option(text,id,false);
  this.clearFilterBackupData();
}

function DBListBoxTag_delItem(id)
{

     for(var i=this.options.length-1;i>=0;i--)
	  {
	   if(this.options(i).value == id)
	    {
		this.options.remove(i);
	    }
	  }
    this.clearFilterBackupData();

}

function DBListBoxTag_delSelItem()
{
     if(this.showtype && this.showtype=="list")
	{
	   if(this.selectedIndex<0) return ;
	   for(var i=this.options.length-1;i>=0;i--)
		{
		  if(this.options(i).selected)
			{
			    this.options.remove(i);
			}
		}

	}
     else
	{
	  if(this.selectedIndex<0) return ;
	  var selectOption = this.options(this.selectedIndex);
	  if (selectOption)
		this.options.remove(this.selectedIndex);

	}
    this.clearFilterBackupData();
}
function DBListBoxTag_refresh(pPara,nullId,nullText)
{	
	var hasNull =true
	//如果用户外部没有传递默认显示的文本则显示TAG中的文本和ID
	if(nullId==null || nullText==null){
		hasNull = this.hasNull;
		nullId = this.nullId;
		nullText = this.nullText;
	}
   var ListDataSourceStatic = createStaticListDataSource(this.ds,pPara,hasNull,nullId,nullText);
   if(ListDataSourceStatic!=null)
     {
       this.options.length = 0;
       ListDataSourceStatic.fillListBox(null,0,this,null,null);
     }
   this.clearFilterBackupData();
}

function DBListBoxTag_replaceRefresh(pPara,nullId,nullText)
{ 
  var hasNull =true
  //如果用户外部没有传递默认显示的文本则显示TAG中的文本和ID
  if(nullId==null || nullText==null){
    hasNull = this.hasNull;
    nullId = this.nullId;
    nullText = this.nullText;
  }
  //清空当前数据
  this.options.length = 0;
  this.clearFilterBackupData();
  
  //从服务器获取
  var tUrl = gListSrcQueryURL + "?eventid=html&dsid=" + this.ds;
  if (pPara)
      tUrl = tUrl + "&" + pPara;
  if(hasNull){
      tUrl = tUrl + "&hasNull=true";
  }
  if(nullId){
      tUrl = tUrl + "&nullId=" + nullId;
  }
  if(nullText){
      tUrl = tUrl + "&nullText=" + nullText;
  }
  var reStr = PostInfotoServer(tUrl ,'');
  
  var index = this.outerHTML.indexOf(">");
  var str = this.outerHTML.substring(0,index+1);
  this.outerHTML = str + reStr;
}

//值改变响应事件
function g_ListBoxTag_OnChange(listBoxObjId)
{
  var listBoxObj = g_getListBox(listBoxObjId);
  if(listBoxObj!=null && listBoxObj.options && listBoxObj.selectedIndex>=0)
  {
    var id = listBoxObj.getID();
    var text = listBoxObj.getValue();
    if(listBoxObj.OnItemChange && listBoxObj.OnItemChange!="")
    {
      eval(listBoxObj.OnItemChange+"('"+id+"','"+text+"')");
    }
  }
}

//单击事件响应函数
function g_ListBoxTag_OnClick(listBoxObjId)
{
  var listBoxObj = g_getListBox(listBoxObjId);
  if(listBoxObj!=null && listBoxObj.options && listBoxObj.selectedIndex>=0)
  {
    var id = listBoxObj.getID();
    var text = listBoxObj.getValue();
    if(listBoxObj.OnItemClick && listBoxObj.OnItemClick!="")
    {
      eval(listBoxObj.OnItemClick+"('"+id+"','"+text+"')");
    }
  }
}
//双击响应事件
function g_ListBoxTag_OnDblClick(listBoxObjId)
{
  var listBoxObj = g_getListBox(listBoxObjId);
  if(listBoxObj!=null && listBoxObj.options && listBoxObj.selectedIndex>=0)
  {
    var id = listBoxObj.getID();
    var text = listBoxObj.getValue();
    if(listBoxObj.OnItemDblClick && listBoxObj.OnItemDblClick!="")
    {
      eval(listBoxObj.OnItemDblClick+"('"+id+"','"+text+"')");
    }
  }
}

function DBListBoxTag_getAllItem()
{

  var reValArray = new Array();
  for(var i=0;i<this.options.length;i++)
    {
	reValArray[reValArray.length] = {id:this.options(i).value,value:this.options(i).text};
    }
  return reValArray;

}


function DBListBoxTag_delAllItem()
{
  this.options.length = 0;
  this.clearFilterBackupData();
}

//设置下拉框禁用或者可用状态 ,如果参数为NULL则
function DBListBoxTag_setDisabled(disabled_flag){
	if(disabled_flag){
		this.disabled = true;
		this.className = 'DBListBox_disabled_style';
	}
	else
	{
		this.disabled = false;
		this.className = 'DBListBox_normal_style';
	}
}

//过滤下拉列表的数据
function DBListBoxTag_filterValue(input_value){
  //将过滤的内容放入公共变量
  
  if(this.p_selectNames == null){
	  this.p_selectNames = new Array();
	  this.p_selectOptions = new Array();
	  this.p_filterValues = new Array();
	  this.p_includeText = new Array();
  }
  selectNames = this.p_selectNames;
  selectOptions = this.p_selectOptions;
  filterValues = this.p_filterValues;
  includeText = this.p_includeText;
  
  fireFilter(input_value,this);
}
//清空备份数据
function DBListBoxTag_clearFilterBackupData(){
  selectNames = this.p_selectNames;
  selectOptions = this.p_selectOptions;
  filterValues = this.p_filterValues;
  includeText = this.p_includeText;
  clearOption(this);
}




//==========以下是下拉框过滤功能===========
var selectNames = null;
var selectOptions = null;
var filterValues = null;
var includeText = null;

//添加包括的内容
function addIncludeText(in_text){
  includeText[includeText.length] = in_text;
}

//清空已备份选项数据
function clearOption(select_obj){
  if(selectNames ==null) {
    return;
  }
  //查出已备份数据
  var index_new = -1;
  for(var i=0;i<selectNames.length; i++){
    if(select_obj.name == selectNames[i]){
      index_new = i;
      break;
    }
  }
  //清空已备份的数据
  selectOptions[index_new] = null;
  selectNames[index_new] = null;
  filterValues[index_new] = null;
} 

//备份选项数据
function backupOption(input_value,select_obj,index){
  //检查选项是否已有备份
  if(index > 0 && selectOptions[index] != null){
    retrun;
  }
  var backup_selectOptions = new Array(select_obj.options.length);
  for(var i=0;i<backup_selectOptions.length; i++){
      backup_selectOptions[i] = select_obj.options[i];
  }
  var index_new = selectNames.length;
  selectNames[index_new] = select_obj.name;
  selectOptions[index_new] = backup_selectOptions;
} 

//还原选项数据
function restoreOption(input_value,select_obj,index){
  if(index < 0){
    retrun;
  }
  var backup_selectOptions = selectOptions[index];
  if(backup_selectOptions==null){
    return;
  }
  if(backup_selectOptions.length != select_obj.options.length){
    select_obj.options.length = 0;
    for(var i=0;i<backup_selectOptions.length; i++){
        select_obj.options[i] = backup_selectOptions[i];
    }
  }
  filterValues[index] = "";
  //设置缺省选中
  if(select_obj.options.length >= 1){
    select_obj.options[0].selected = true;
  }
  if(select_obj.onchange){
    select_obj.onchange(select_obj);       
  }
}

//过滤选项数据 ,index表示备份选项的索引
function doFilter(input_value,select_obj,index){
  if(input_value == ""){
    return;
  }
  //过滤内容
  var caseSensitive = false;
  var keystr = input_value;
  if(!caseSensitive){   
    keystr = keystr.toUpperCase();
  }
  //如果有备份，取备份中的数据来过滤
  var index_new = -1;
  for(var i=0;i<selectNames.length; i++){
    if(select_obj.name == selectNames[i]){
      index_new = i;
      break;
    }
  }
  var filter_Options;
  if(index_new == -1){
    filter_Options = select_obj.options;
  }else{
    filter_Options = selectOptions[index_new];
  }
  //过滤
  var new_selectOptions = new Array(0);
  var selectLength = filter_Options.length
  for(var i=0;i<selectLength; i++){
    var searchText = filter_Options[i].text;
    if(!caseSensitive){   
      searchText = searchText.toUpperCase();
    }
    var include = false;
    for(var j=0;j<includeText.length; j++){
      if(searchText==includeText[i]){
        include = true;
        break;
      }
    }
      if(include || searchText.indexOf(keystr)!= -1){
          new_selectOptions[new_selectOptions.length]= filter_Options[i];
      }
  }
  //如果过滤出内容
  if(select_obj.options.length != new_selectOptions.length){
    select_obj.options.length = 0;
    for(var i=0;i<new_selectOptions.length; i++){
      select_obj.options[i] = new_selectOptions[i];
    }
    //设置缺省选中
    if(select_obj.options.length >= 1){
      select_obj.options[0].selected = true;
    }
    if(select_obj.onchange){
      select_obj.onchange(select_obj);
    }
  }
  //备份过滤命令
  filterValues[index] = input_value;
}

//通过特定值过滤下拉选项框中内容,总的入口
function fireFilter(input_value,select_obj){
  if(select_obj==null){
    return;
  }
  if(select_obj.disable){
    return;
  }
  var input_value = Trim(input_value); 
  //检查选项是否有备份
  var index = -1;
  for(var i=0;i<selectNames.length; i++){
    if(select_obj.name == selectNames[i]){
      index = i;
      break;
    }
  }
  //判断需要作的动作
  var action = new Array();
  
  //如果是第一次过滤则备份数据
  if(index == -1){
    action[action.length] = "backupOption";
  }
  
  //如果输入的过滤的数据不为空并且不是第一过滤，则要还原一下数据
  if(input_value=="" && index >=0){
    action[action.length] = "restoreOption";
  }
  //开始过滤数据
  if(input_value!=""){
    action[action.length] = "doFilter";
  }
  //执行action中的操作
  for(var i=0;i<action.length; i++){
    eval(action[i]+"(input_value,select_obj,index)");
  }
}



//去除左右空格
function Trim(str){
    return RTrim(LTrim(str));
}
function LTrim(str){
    var whitespace = new String(" \t\n\r");
    var s = new String(str);
    if (whitespace.indexOf(s.charAt(0)) != -1){
        var j=0, i = s.length;
        while (j < i && whitespace.indexOf(s.charAt(j)) != -1){
            j++;
        }
        s = s.substring(j, i);
    }
    return s;
}
function RTrim(str){
    var whitespace = new String(" \t\n\r");
    var s = new String(str);
    if (whitespace.indexOf(s.charAt(s.length-1)) != -1){
        var i = s.length - 1;
        while (i >= 0 && whitespace.indexOf(s.charAt(i)) != -1){
            i--;
        }
        s = s.substring(0, i+1);
    }
    return s;
}
