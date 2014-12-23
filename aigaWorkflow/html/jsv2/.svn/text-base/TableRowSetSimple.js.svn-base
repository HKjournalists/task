/**
  hexg ,2007-5-9
  简化的表格JS控件，表格只支持只读操作，不支持修改、删除、新增操作；
  该表格支持原来表格控件的各种事件响应

 // 刘红楠新增
  setRowColFontColor(rowIndex,colName,color):设置制定单元格字体颜色
  setRowColBgColor(rowIndex,colName,color):设置制定单元格背景颜色

*/

var g_TableRowSetManager = new TableRowSetManager();
//表格管理对象
function TableRowSetManager(){
  this.List = new Array();
  
  this.push = function(obj){
    this.List[obj.DBGridPK] = obj;
    return obj.DBGridPK;
  }
  
  this.get = function(pk){
    var result = this.List[pk];
    if(!result){
      var obj = document.all("TableRowSet_ParentDiv_" + pk);
      if(obj == null) return null;

      //根据obj.onlyQuery不同值来创建不同的tablerowset
      if(obj.onlyQuery != null && 
          (obj.onlyQuery==false || obj.onlyQuery=='false')){
        result = new TableRowSet(pk);  
      }else{
        result = new TableRowSetSimple(pk);
      }
    }
    return result;
  }
  
  this.remove = function(pk){
    this.List[pk] = null;
  }

  this.reinitial = function(pk){
    this.get(pk).reinitial();
  }
}


function TableRowSetSimple(aName,aPkName){
  this.DBGridPK = aName;
  this.pkName = aPkName; //数据集的主键字段名称
  g_TableRowSetManager.push(this);
  this.initial();
}

TableRowSetSimple.prototype.count = Public_Table_count; 
TableRowSetSimple.prototype.realcount = Public_Table_realcount;
TableRowSetSimple.prototype.hasTotalRow = Public_Table_hasTotalRow;
TableRowSetSimple.prototype.resize = Public_Table_resize;
TableRowSetSimple.prototype.getColCount = Public_Table_getColCount;
TableRowSetSimple.prototype.getVisiColCount = Public_Table_getVisiColCount;
TableRowSetSimple.prototype.getColIndex = Public_Table_getColIndex;
TableRowSetSimple.prototype.getNameByIndex = Public_Table_getNameByIndex;
TableRowSetSimple.prototype.setTitle = Public_Table_setTitle;
TableRowSetSimple.prototype.setTitleByIndex = Public_Table_setTitleByIndex;
TableRowSetSimple.prototype.getTitle = Public_Table_getTitle;
TableRowSetSimple.prototype.getTitleByIndex = Public_Table_getTitleByIndex;
TableRowSetSimple.prototype.getServerPK = Public_Table_getServerPK;
TableRowSetSimple.prototype.getCurRowIndex = Public_Table_getRow;
TableRowSetSimple.prototype.getTotalRowCount = Public_Table_getTotalRowCount;
TableRowSetSimple.prototype.getColWidth = Public_Table_getColWidth;
TableRowSetSimple.prototype.setColWidth = Public_Table_setColWidth;
TableRowSetSimple.prototype.getMutilSelectColIndex = Public_Table_getMutilSelectColIndex
TableRowSetSimple.prototype.getSelectedRows = Public_Table_getSelectedRows
TableRowSetSimple.prototype.getRowId = Public_Table_getRowId
TableRowSetSimple.prototype.getRow = Public_Table_getRow;
TableRowSetSimple.prototype.getCol = Public_Table_getCol;
TableRowSetSimple.prototype.setPageSize = Public_Table_setPageSize;
TableRowSetSimple.prototype.toExcelUrl = Public_Table_toExcelUrl;
TableRowSetSimple.prototype.selectAll = Public_Table_selectAll;
TableRowSetSimple.prototype.rowSelected = Public_Table_rowSelected;
TableRowSetSimple.prototype.isSelected = Public_Table_isSelected;
TableRowSetSimple.prototype.disabledSelect =Public_Table_disabledSelect;
TableRowSetSimple.prototype.setAllSelectCheckBoxSts = Public_Table_setAllSelectCheckBoxSts;
TableRowSetSimple.prototype.getColNames = Public_Table_getColNames;
TableRowSetSimple.prototype.visibleSelect  = Public_Table_visibleSelect;
TableRowSetSimple.prototype.getStartRowIndex = Public_Table_getStartRowIndex;
TableRowSetSimple.prototype.getEndRowIndex = Public_Table_getEndRowIndex;
TableRowSetSimple.prototype.setRow = Public_Table_setRow;
TableRowSetSimple.prototype.setFocus = Public_Table_setFocus;
TableRowSetSimple.prototype.setFocusByName = Public_Table_setFocusByName;
TableRowSetSimple.prototype.print = Public_Table_print;
TableRowSetSimple.prototype.refreshForObd = Public_Table_refreshForObd;
TableRowSetSimple.prototype.refresh = Public_Table_refresh;
TableRowSetSimple.prototype.refreshByDefineQeruy = Public_Table_refreshByDefineQeruy;

//  刘红楠新增
//  setRowColFontColor(rowIndex,colName,color):设置制定单元格字体颜色
//  setRowColBgColor(rowIndex,colName,color):设置制定单元格背景颜色
TableRowSet.prototype.setRowColFontColor = Public_SimpleTable_setRowColFontColor;
TableRowSet.prototype.setRowColBgColor = Public_SimpleTable_setRowColBgColor;


TableRowSetSimple.prototype.getValue = Public_SimpleTable_getValue;
TableRowSetSimple.prototype.getDisplayText = Public_SimpleTable_getDisplayText;
TableRowSetSimple.prototype.toXmlString = Public_SimpleTable_toXmlString;
TableRowSetSimple.prototype.toXmlStringOfSelects = Public_SimpleTable_toXmlStringOfSelects;
TableRowSetSimple.prototype.setColVisible = Public_Table_setColVisible;

TableRowSetSimple.prototype.getTableObject = Private_Table_getTableObject;
TableRowSetSimple.prototype.getRowObj = Private_Table_getRowObj;
TableRowSetSimple.prototype.restoreTableInfo = Private_Table_restoreTableInfo;
TableRowSetSimple.prototype.recordTableInfo = Private_Table_recordTableInfo;
TableRowSetSimple.prototype.adjustHeadDivWidth = Private_Table_adjustHeadDivWidth;
TableRowSetSimple.prototype.getRowHeadColCount = Private_Table_getRowHeadColCount;
TableRowSetSimple.prototype.modifyRowSequence  = Private_Table_modifyRowSequence;
TableRowSetSimple.prototype.currentRowChange = Private_Table_currentRowChange;

TableRowSetSimple.prototype.initial = Private_SimpleTable_initial;
TableRowSetSimple.prototype.reinitial = Private_SimpleTable_reinitial;
TableRowSetSimple.prototype.getCell = Private_SimpleTable_getCell;
TableRowSetSimple.prototype.getCellByName = Private_SimpleTable_getCellByName;
TableRowSetSimple.prototype.sort = Private_SimpleTable_sort;
TableRowSetSimple.prototype.tdOnFocus = Private_SimpleTable_tdOnFocus
TableRowSetSimple.prototype.toXmlStringRow = Private_SimpleTable_toXmlStringRow;
TableRowSetSimple.prototype.toXmlStringOfRows = Private_SimpleTable_toXmlStringOfRows;
TableRowSetSimple.prototype.clear = Private_SimpleTable_clear;
TableRowSetSimple.prototype.setColSortFunction = Public_SimpleTable_setColSortFunction;
TableRowSetSimple.prototype.setColSortIcon = Private_SimpleTable_setColSortIcon;
TableRowSetSimple.prototype.getClassName = Private_SimpleTable_getClassName;

TableRowSetSimple.prototype.adjustTableSize = PrivateIE_Table_adjustTableSize

//设置表格某一列的排序方法
function Public_SimpleTable_setColSortFunction(colName ,sortFunction){
  var f = null;
  if(typeof(sortFunction)=='function'){
    f = sortFunction;
  }
  else if(typeof(sortFunction)=='string'){
    eval("f=" + sortFunction);
  }else{
    return;
  }
  //将排序方法放入全局变量
  if(this.sortFunctionArray ==null){
    this.sortFunctionArray = new Array();
  }
  colName = colName.toUpperCase();
  this.sortFunctionArray[colName] = f;
}

//获取指定列的值
function Public_SimpleTable_getValue(rowIndex,colName){
  var tmpRow = this.getRowObj(rowIndex);
  if (tmpRow == null)
     return null;

  colName = colName.toUpperCase();
  var colEditType = this.colEditType[colName];

  //如果是虚拟列，则直接返回TR的属性
  if(colEditType == null){
    return eval("tmpRow." + colName);
  }

  var colIndex = parseInt(this.colIndexs[colName]);
  var cell = tmpRow.cells(colIndex + this.getRowHeadColCount());
  
  if(cell.I !=null && typeof(cell.I)!='undefined'){
    return cell.I;
  }
  //如果不是虚拟列，则根据编辑类型取值
  if(colEditType == g_DBHTML_STRING){
    return cell.innerHTML;
  }else if(colEditType == g_DBTREE_STRING){
    return cell.childNodes(cell.childNodes.length -1).innerText;
  }else{
    return cell.innerText;
  }
}

//获取显示文本
function Public_SimpleTable_getDisplayText(rowIndex,colName){
  var tmpRow = this.getRowObj(rowIndex);
  if (tmpRow == null)
     return null;

  colName = colName.toUpperCase();
  var colEditType = this.colEditType[colName];

  //如果是虚拟列，则直接返回TR的属性
  if(colEditType == null){
    return eval("tmpRow." + colName);
  }

  var colIndex = parseInt(this.colIndexs[colName]);
  var cell = tmpRow.cells(colIndex + this.getRowHeadColCount());

  if(cell.T !=null && typeof(cell.T)!='undefined'){
    return cell.T;
  }
  
  //如果不是虚拟列，则根据编辑类型取值
  if(colEditType == g_DBHTML_STRING){
    return cell.innerHTML;
  }else if(colEditType == g_DBTREE_STRING){
    return cell.childNodes(cell.childNodes.length -1).innerText;
  }else{
    return cell.innerText;
  }
}


//隐藏、显示表格的列,flag: true表示显示； false表示隐藏。这种该列必须事先在dbgrid的col tag中定义，并且不隐藏字段
function Public_Table_setColVisible(colName ,flag){
	colName = colName.toUpperCase();
	var index = this.getColIndex(colName);
	if(index<0){
		alert('无效的列名');
		return;	
	} 
	
	index = index + this.getRowHeadColCount();
	
	//标题单元格
	var cell = this.HeadTable.rows(0).cells(index );
	
    if(cell == null){
    	alert('根据列名找不到对应的列');
    	return;	
    }
     
    //隐藏列
    if(flag == false || flag == "false"){
    	//如果已经隐藏了则直接返回
    	if(cell.preWidth !=null){
    		return;
    	}
    	
    	//保存表格先前的长度
		cell.preWidth= cell.width;
		
		//因为cell.width不能接受0这个参数，所以隐藏的时候必须用style.with，
		//反之，显示的时候必须先把对象的style.width属性清空，再用width这个属性进行宽度设置
		cell.style.width="0px";
		
		this.HeadTable.width = parseInt(this.HeadTable.width) - cell.preWidth;
      	
      	if (this.DataTable !=null && this.DataTable.rows.length >0){
	      	this.DataTable.rows(0).cells(index).style.width="0px";
	      	this.DataTable.width = parseInt(this.DataTable.width) - cell.preWidth;
	    }
	    
      	 
    }
    //显示列
	else if(flag ==true || flag == "true"){
    	//如果没有隐藏，则直接返回
    	if(cell.preWidth ==null){
    		return;
    	} 
      	
      	cell.style.width=null;
		cell.width= cell.preWidth  ;
      	this.HeadTable.width = parseInt(this.HeadTable.width) + parseInt(cell.preWidth);
      	
      	if (this.DataTable !=null && this.DataTable.rows.length >0){
      		this.DataTable.rows(0).cells(index).style.width=null;
	      	this.DataTable.rows(0).cells(index).width = cell.preWidth;
	      	this.DataTable.width = parseInt(this.DataTable.width)  + parseInt(cell.preWidth);
	    }	

    	cell.preWidth = null;    	
    	this.adjustTableSize(this.DBGridPK);
    }
	else{
		alert('无效的隐藏或显示参数，请用 true或则false');
	}
	
	
	var head_div = window.document.all("HeadDiv_" + this.DBGridPK);
	var data_div = window.document.all("TableDiv_" + this.DBGridPK);
	Private_Table_adjustHeadDivWidth(head_div,data_div);
}

//获取指定行的状态
function Public_SimpleTable_getRowSts(rowIndex){
  return "O";
}

//将选择的行打包成xml数据
function  Public_SimpleTable_toXmlStringOfSelects(colnames,isIncludeDisplayAttr){
  return this.toXmlStringOfRows(this.getSelectedRows(),colnames,isIncludeDisplayAttr);
}
//将指定的行打包成XML数据
function  Private_SimpleTable_toXmlStringOfRows(aRows,colnames,isIncludeDisplayAttr){
  var result = new Array();

  var colIndexs = new Array();
  if(colnames == null || colnames.length == 0){
    for(var i=0;i< this.getColCount();i++){
      colIndexs[i] = i;
    }
  }else{
    var tmpNames = (""+colnames).split(",");
    for(var i=0;i<tmpNames.length;i++){
      colIndexs[i] = this.getColIndex(tmpNames[i]);
    }
  }

  for(var i=0;i<aRows.length;i++){
    var s= this.toXmlStringRow(aRows[i],false,colIndexs,isIncludeDisplayAttr);
    if(s.length >0)
      result[result.length] = (s);
  }

  if(result.length ==0)
    return "";

  return "<RowSet Name='" + this.HeadTable.setname + "' FullName='" +  this.HeadTable.setfullname + "' "
            + " Sts='U'>"+ result.join("") + "</RowSet>";
}
//获取表格的XML String
function  Public_SimpleTable_toXmlString(isOnlySendModifyData,colnames,isIncludeDisplayAttr){
  var result = new Array();
  var colIndexs = new Array();
  if(colnames == null || colnames.length == 0){
    for(var i=0;i< this.getColCount();i++){
      colIndexs[i] = i;
    }
  }else{
    var tmpNames = (""+colnames).split(",");
    for(var i=0;i<tmpNames.length;i++){
      colIndexs[i] = this.getColIndex(tmpNames[i]);
    }
  }

  for(var i=0;i<this.count();i++){
    var s= this.toXmlStringRow(i,isOnlySendModifyData,colIndexs,isIncludeDisplayAttr);
    if(s.length >0)
      result[result.length] = (s);
    }

  if(result.length ==0)return "";

  return "<RowSet Name='" + this.HeadTable.setname + "' FullName='" +  this.HeadTable.setfullname + "' "
          + " Sts='U'>" + result.join("") + "</RowSet>";
}
//将指定的行打包成XML数据
function Private_SimpleTable_toXmlStringRow(rowIndex,isOnlySendModifyData,colIndexs,isIncludeDisplayAttr){
  if(isOnlySendModifyData == null) isOnlySendModifyData = true;
  if(isIncludeDisplayAttr ==null) isIncludeDisplayAttr = false;

  var sts = "O";
  if (isOnlySendModifyData == true)
    return "";

  var result = new Array();
  result[result.length] = ("<Row ID='" + this.getRowId(rowIndex) + "' Sts='" + sts + "'>");

  for(var i=0;i< colIndexs.length;i++){
    var colName = this.getNameByIndex(colIndexs[i]);
    var xmlStr = "<Col Name='" + colName  + "'" + " Sts='" + sts + "'";
        
    var value = this.getValue(rowIndex ,colName);
    var text =null;
    if(isIncludeDisplayAttr) {
      text = value;
    }

    if (value)
      xmlStr += " OldID='" + Private_Table_checkAndTrans(value) + "'";
    if (text)
      xmlStr += " OldText ='" + Private_Table_checkAndTrans(text) +"' ";
    xmlStr = xmlStr + "/>"
    
    result[result.length] = xmlStr;
  }
  result[result.length] = ("</Row>");
  
  return result.join("");
}


//初始化表格
function  Private_SimpleTable_initial(){
  this.CurRow = -1;
  this.CurCol = -1;

  this.TableRowSetDiv = document.all("TableRowSet_" + this.DBGridPK);
  this.HeadAndTableDiv = document.all("HeadAndTableDiv_" + this.DBGridPK);
  this.HeadDiv  = document.all("HeadDiv_" + this.DBGridPK);
  this.TableDiv  = document.all("TableDiv_" + this.DBGridPK);
  this.FootDiv = document.all("FootDiv_" + this.DBGridPK);

  this.HeadTable = document.all("HeadTable_" + this.DBGridPK);
  this.FootTable = document.all("FootTable_" + this.DBGridPK);
  this.DataTable = document.all("DataTable_" + this.DBGridPK);
 
  this.DBTreeColName = this.HeadTable.DBTreeColName;
  this.currPage =parseInt(this.DataTable.currPage);
  this.pageCount = parseInt(this.DataTable.pageCount);
  this.totalRowCount =  parseInt(this.FootTable.totalRowCount);
  
  this.isMutilSelect = false;
  this.isRowSequence = false;
  if (!this.TableRowSetDiv.isRowSequence)
      this.isRowSequence = false;
  else
      this.isRowSequence = true;

  if (!this.TableRowSetDiv.isMutilSelect)
      this.isMutilSelect = false;
  else
      this.isMutilSelect = true;
  
  //设置每一列的编辑模式
  this.colEditType = new Array();
  this.colDataType = new Array();
  this.colIndexs = new Array();
  //存放所有字段信息
  this.visioColCount =0;
  this.colNames = new Array();
  
  var cells = this.HeadTable.rows(0).cells;

  var headCount = this.getRowHeadColCount();
  for(i=0;i<cells.length-headCount;i++){
    this.colEditType[cells[i+ headCount].FieldID] = cells[i + headCount].editType;
    this.colDataType[cells[i+ headCount].FieldID] = cells[i + headCount].dataType;
    this.colIndexs[cells[i+ headCount].FieldID] = "" + i;
    this.colNames[i] = cells[i+ headCount].FieldID;
    this.visioColCount = this.visioColCount+1;
  }
  
  //隐藏列
  var tmpHideColNames = this.HeadTable.rows(0).FieldIDs;
 
  if(tmpHideColNames){
    var list = splitString(tmpHideColNames,",");
    for(var i=0;i<list.length;i++){
      this.colIndexs[list[i].toUpperCase()] = i + this.visioColCount;
      this.colNames[ i + this.visioColCount] = list[i];
    }
  }
  
  //判断是否有合计行
  this.m_hasTotalRow = false;
  var allCount = this.DataTable.rows.length;
  if (allCount > 0 ){
    var totalRow = this.DataTable.rows(allCount - 1);
    if (totalRow.IsTotal)
      this.m_hasTotalRow = true;
  }
  
  //初始化当前的行高度,add by hexg 20060625 ,
  //如果用户配置了行高并且行高不为-1的话，则按照用户的rowheight作为缺省的行高
  if(this.TableRowSetDiv.RowHeight == null && this.TableRowSetDiv.RowHeight>0)
    this.DefaultRowHeight =this.TableRowSetDiv.RowHeight;

  if(this.TableRowSetDiv.S_OnGridDbClick){
    eval("this.OnGridDbClick = " + this.TableRowSetDiv.S_OnGridDbClick);
  }
  if(this.TableRowSetDiv.S_OnTitleDbClick){
    eval("this.S_OnTitleDbClick = " + this.TableRowSetDiv.S_OnTitleDbClick);
  }
  if(this.TableRowSetDiv.S_OnValueChange){
    eval("this.OnValueChange = " + this.TableRowSetDiv.S_OnValueChange);
  }
  if(this.TableRowSetDiv.S_OnRowFocusChange){
    eval("this.OnRowFocusChange = " + this.TableRowSetDiv.S_OnRowFocusChange);
  }
  if(this.TableRowSetDiv.S_OnCellFocusChange){
    eval("this.OnCellFocusChange = " + this.TableRowSetDiv.S_OnCellFocusChange);
  }
  //失去焦点事件
  if(this.TableRowSetDiv.S_OnFocusOut){
    eval("this.OnFocusOut = " +this.TableRowSetDiv.S_OnFocusOut);
  }
  if(this.TableRowSetDiv.S_OnContextMenu){
      eval("this.OnContextMenu = " + this.TableRowSetDiv.S_OnContextMenu);
  }
  if(this.TableRowSetDiv.S_OnBeforeTurnPage){
      eval("this.OnBeforeTurnPage = " + this.TableRowSetDiv.S_OnBeforeTurnPage);
  }
  if(this.TableRowSetDiv.S_OnAfterTurnPage){
      eval("this.OnAfterTurnPage = " + this.TableRowSetDiv.S_OnAfterTurnPage);
  }
  if(this.TableRowSetDiv.S_OnRowSelected){
      eval("this.OnRowSelected = " + this.TableRowSetDiv.S_OnRowSelected);
  }
  if(this.TableRowSetDiv.S_OnDBLink){
      eval("this.OnDBLink = " + this.TableRowSetDiv.S_OnDBLink);
  }
  if(this.TableRowSetDiv.S_OnResize){
      eval("this.OnResize = " + this.TableRowSetDiv.S_OnResize);
  }
  
  
  
  this.getTableObject().onmouseover= Private_SimpleTable_showColTips;
  
}

//重新初始化表格，在刷新、翻页的时候调用
function Private_SimpleTable_reinitial(){
  this.CurRow = -1;
  this.CurCol = -1;

  this.TableRowSetDiv = document.all("TableRowSet_" + this.DBGridPK);
  this.HeadAndTableDiv = document.all("HeadAndTableDiv_" + this.DBGridPK);
  this.HeadDiv  = document.all("HeadDiv_" + this.DBGridPK);
  this.TableDiv  = document.all("TableDiv_" + this.DBGridPK);
  this.FootDiv = document.all("FootDiv_" + this.DBGridPK);

  this.HeadTable = document.all("HeadTable_" + this.DBGridPK);
  this.FootTable = document.all("FootTable_" + this.DBGridPK);
  this.DataTable = document.all("DataTable_" + this.DBGridPK);
  
  this.DBTreeColName = this.HeadTable.DBTreeColName;
  this.currPage =parseInt(this.DataTable.currPage);
  this.pageCount = parseInt(this.DataTable.pageCount);
  this.totalRowCount =  parseInt(this.FootTable.totalRowCount);
  
 //设置每一列的编辑模式
  this.colEditType = new Array();
  this.colIndexs = new Array();
  //存放所有字段信息
  this.visioColCount =0;
  this.colNames = new Array();
  
  var cells = this.HeadTable.rows(0).cells;

  var headCount = this.getRowHeadColCount();
  for(i=0;i<cells.length-headCount;i++){
    this.colEditType[cells[i+ headCount].FieldID] = cells[i + headCount].editType;
    this.colIndexs[cells[i+ headCount].FieldID] = "" + i;
    this.colNames[i] = cells[i+ headCount].FieldID;
    this.visioColCount = this.visioColCount+1;
  }
  
  //隐藏列
  var tmpHideColNames = this.HeadTable.rows(0).FieldIDs;
  if(tmpHideColNames){
    var list = splitString(tmpHideColNames,",");
    for(var i=0;i<list.length;i++){
      this.colIndexs[list[i].toUpperCase()] = i + this.visioColCount;
      this.colNames[ i + this.visioColCount] = list[i];
    }
  }
  
  this.getTableObject().onmouseover= Private_SimpleTable_showColTips;
    
  //设置新的PK
  var tableTagInfo = document.all("TableTagInfo_" + this.DBGridPK);
  if(tableTagInfo != null && tableTagInfo.newGridPK !=null && tableTagInfo.newGridPK !=''){
  	var parentDiv = document.all("TableRowSet_ParentDiv_"+ this.DBGridPK);
  	parentDiv.PK = tableTagInfo.newGridPK;
  }
}


function Private_SimpleTable_showColTips(){  
var obj = window.event.srcElement;
  
	if(event.srcElement.tagName !='TD')return;
else{
   obj = obj.parentNode;
   obj.className="td_hover";
  }
	//如果已经显示过了则不再设置
	if(event.srcElement.title != null && event.srcElement.title != "" )return;
	
  	event.srcElement.title = event.srcElement.innerText;
}


//根据行号和列名获取所在单元格对象
function Private_SimpleTable_getCellByName(index,name){
  var colIndex = this.getColIndex(name);
  var cell = this.getCell(index,colIndex);
  return cell;
}

//根据行号和列索引获取单元格对象
function Private_SimpleTable_getCell(rowIndex,colIndex){
  var tmpRow = this.getRowObj(rowIndex);
  if (tmpRow == null)return null;
  
  if((colIndex == null)|| colIndex<0|| colIndex >= this.getVisiColCount())
      return null;
      
  return tmpRow.cells(colIndex +   this.getRowHeadColCount());
}

//排序
function Private_SimpleTable_sort(colName,sortType,sortFunction){ //false 降序
  var valueArray = new Array(); //需要排序的列的值
  var valueRowArray = new Array();
  var nullRowArray = new Array();//空值对应的行编号数组
  var tmpValue = "";
  var tmpArray;
  var tmpList = new Array();
  var rowCount = this.count();
  var currRowObj = this.getRowObj(this.CurRow);//记录当前行对象

  for(var i=0;i< rowCount ;i++){//根据值将行分组
    tmpValue = this.getDisplayText(i,colName);
    if (!tmpValue)
      nullRowArray.push(i);
    else{
      tmpArray = valueRowArray[tmpValue];
      if (!tmpArray){
        tmpArray = new Array();
        valueArray.push(tmpValue);
        valueRowArray[tmpValue] = tmpArray;
      }
      tmpArray.push(i);
    }
  }
  
  if (valueArray.length == 0)
    return false;
    
  var dataType = this.colDataType[colName];

  if(sortFunction !=null){ 
    valueArray = valueArray.sort(sortFunction);   
  }
  //如果是数字，则按数字排序，否则按照字符排序，日期也是按字符排序
  else if(dataType=='Float' || dataType=='Number'|| dataType=='Double'
    || dataType=='Short' || dataType=='int' || dataType=='Integer'
    || dataType=='Long'){
    valueArray = valueArray.sort(sortDigit);
  }else {
    valueArray = valueArray.sort(sortFunction);
  }
  if (sortType != false){
    for(var i=0;i<valueArray.length;i++){
      tmpArray = valueRowArray[valueArray[i]];
      for(var j=0;j< tmpArray.length;j++)
        tmpList.push(tmpArray[j]);
    }
  }else{
    for(var i = valueArray.length -1;i>=0;i--){
      tmpArray = valueRowArray[valueArray[i]];
      for(var j=0;j< tmpArray.length ;j++)
        tmpList.push(tmpArray[j]);
    }
  }

  for(var i=0;i<nullRowArray.length;i++)
    tmpList.push(nullRowArray[i]);

  for(var i=0;i<tmpList.length;i++){
    if(i == tmpList[i])continue;
    this.getRowObj(i).swapNode(this.getRowObj(tmpList[i]));

    for(var j= i + 1;j < tmpList.length;j++)
      if(tmpList[j] == i){
        tmpList[j] = tmpList[i];
        break;
    }
  }

  //重新设置第一行的宽度
  var tmpFirstRow = this.getRowObj(0);
  if(tmpFirstRow){
    for(var i = 0;i <  this.HeadTable.rows(0).cells.length ;i++)
      tmpFirstRow.cells(i).width = this.HeadTable.rows(0).cells(i).width;
  }
  //重新设置行的显示样式
  this.modifyRowSequence(0);

  var dataTalbe = this.getTableObject()
  var tmpIndex =this.getMutilSelectColIndex();
  for(var i=0;i < dataTalbe.rows.length;i++){
    if ((dataTalbe.rows(i).isSelected)&&(dataTalbe.rows(i).isSelected == true)){
      dataTalbe.rows(i).className ="GD-SelectRow";
      dataTalbe.rows(i).cells(tmpIndex).children(0).checked = true;
    }
  }

  //重新设置当前行行号
  if(currRowObj){
    this.CurRow = currRowObj.rowIndex;
    currRowObj.className = "GD-CurrentRow";
  }
}

//表格单元格失去焦点事件
function Private_SimpleTable_tdOnFocus(newRowId ,newColId){
  var oldRowIndex = this.CurRow;
  var oldColIndex = this.CurCol;
  newRowId =parseInt(newRowId);
  newColId =parseInt(newColId);
  var oldCell = this.getCell(this.CurRow,this.CurCol);
  if(oldCell)  oldCell.bgColor = "";

  this.currentRowChange(-1,oldRowIndex);

  var obj = this.getCell(newRowId,newColId);
  if (obj) obj.bgColor = this.CurCellBgColor;

  this.CurRow = newRowId;
  this.CurCol = newColId;

  this.currentRowChange(this.CurRow,-1);
  if (this.CurRow != oldRowIndex){
    if (this.OnRowFocusChange)
      this.OnRowFocusChange(oldRowIndex,newRowId);
  }
  if (this.OnCellFocusChange)
    this.OnCellFocusChange(oldRowIndex,oldColIndex,newRowId,newColId);
    
  return true;
}

//数据表格失去焦点
function PrivateIE_SimpleTable_dataOnFocusOut(aGridPK){
  var parentObj = g_TableRowSetManager.get(aGridPK);
  if(parentObj.CurRow < 0 || parentObj.CurCol < 0){
    return;
  }
  
  //判断是否有失去焦点这个用户事件
  var dbgrid = g_TableRowSetManager.get(aGridPK);
  if(dbgrid.OnFocusOut==null)return;
  
  //判断当前得到焦点的对象是否在这个head div中
  var head_div = document.getElementById("HeadAndTableDiv_" + aGridPK);
  var toElement = event.toElement;

  while(true){
    //说明得到焦点
    if(toElement==null ||toElement.tagName=='BODY')break;

    //说明在区域内部,没有失去焦点
    if(toElement== head_div)return;
      toElement = toElement.parentNode;
  }
  dbgrid.OnFocusOut();
}



var g_DBTREE_STRING = "DBTree";
var g_DBHTML_STRING = "DBHtml";

//动态设置表格的水平和垂直滚动条,更新滚动条与否设置表格抬头的宽度
function Private_Table_adjustHeadDivWidth(head_div ,data_div){
	try{
	  if(data_div.scrollHeight>data_div.clientHeight){
	      head_div.style.width=parseInt(data_div.style.width)-17;
	  }else{
	    head_div.style.width=data_div.style.width;
	  }
	
	  var srcollcontrolbar = document.getElementById("ScrollControlbar_" + data_div.DBGridPK);
	  if(srcollcontrolbar!=null){
	    srcollcontrolbar.style.width = parseInt(head_div.childNodes[0].width);
	  }
	}catch(e){}
}

//获取表格对象
function Private_Table_getTableObject(){
  return this.DataTable;
}

//获取行对象
function Private_Table_getRowObj(rowIndex){
  if(rowIndex == null){
    alert("指定的行号为null");
    return null;
  }
  rowIndex = parseInt(rowIndex);
  if ((rowIndex >=0)&&(rowIndex < this.realcount()))
     return this.getTableObject().rows(rowIndex);
  else
     return null;
}
//判断当前表格是否存在合计行
function Public_Table_hasTotalRow(){
  return this.m_hasTotalRow;
}
//获取当前表格记录的行数，不包括合计行
function Public_Table_count(){
  if (this.hasTotalRow() == true)
    return this.getTableObject().rows.length - 1;
  else
    return this.getTableObject().rows.length;
}
//获取当前表格数据的总行数，包括合计行
function Public_Table_realcount(){
  return this.getTableObject().rows.length;
}

//获取当前列的总数，包括隐藏列
function Public_Table_getColCount(){
  return this.colNames.length;
}
//获取表格可视列的总记录数
function Public_Table_getVisiColCount(){
  return this.visioColCount;
}
//根据列名获取该列的索引
function Public_Table_getColIndex(name){
  name = name.toUpperCase();
  var index = this.colIndexs[name];
  if(index == null)
    index = -1;
  return parseInt(index);
}
//根据索引号获取列名
function Public_Table_getNameByIndex(colIndex){
    return this.colNames[colIndex];
}
//获取当前查询条件下的总记录数
function Public_Table_getTotalRowCount(){ return this.totalRowCount;}
//重新设置表格的大小
function Public_Table_resize(width, height) {
try{
  var s = this.TableDiv.style.width;
  var index = s.indexOf("px");
  var oldWidth = parseInt(s.substring(0,index));

  s = this.TableDiv.style.height;
  index = s.indexOf("px");
  var oldHeight = parseInt(s.substring(0,index));

  if (width != "" && width != "-1") {
    width = parseInt(width);
    this.HeadAndTableDiv.style.width = width;
    this.TableDiv.style.width = width;
    this.FootDiv.style.width = width;
    this.FootTable.style.width = width;
  }else{
    width = this.HeadAndTableDiv.style.width;
  }
  if (height != "" && height != "-1") {
    height = parseInt(height);
    this.TableDiv.style.height = height;
  }else{
    height = this.TableDiv.style.height;
  }
  
   this.currentWidth = width;
   this.currentHeight = height;
   
  if(this.OnResize){
    this.OnResize(oldWidth,oldHeight,width,height);
  }
  
  this.adjustHeadDivWidth(this.HeadDiv,this.TableDiv);
  return true;
  }catch(e){
    alert(e + this.OnResize);
    return false;
  }
}

//获取多选框所在列的索引
function Public_Table_getMutilSelectColIndex(){
  var colIndex = 0;
  if(this.isRowSequence == true)
    colIndex = 1;
  return   colIndex;
}
//获取指定行的ID，即记录ID
function Public_Table_getRowId(rowIndex){
  var tmpRow = this.getRowObj(rowIndex);
  return tmpRow.I;
}
//获取当前表格所在的行号
function Public_Table_getRow(){
   return this.CurRow;
}
//获取当前表格所在的列号
function Public_Table_getCol(){
   return this.CurCol;
}
//获取当前所有选择的行号
function Public_Table_getSelectedRows(){
   var result = new Array();
   if (this.isMutilSelect== true){
     var colIndex =this.getMutilSelectColIndex();
     for(var i=0; i < this.count();i++){
       var tmpRow = this.getRowObj(i);
       if (tmpRow.cells(colIndex).children(0).checked == true)
         result[result.length] = (i);
     }
   }
   else if (this.CurRow >=0)
     result[result.length] = (this.CurRow);

   return result;
}
//设置表格每页的记录数量
function Public_Table_setPageSize(aPageSize){
  var parentDiv = document.all("TableRowSet_ParentDiv_"+ this.DBGridPK);
  var pk = parentDiv.PK;
  var tUrl = _gModuleName + "/gridturnpage?action=setpagesize&pk=" + pk +"&pagesize=" + aPageSize;
  PostInfotoServer(tUrl,"");
}
//获取将当前表格导出excel的URL地址
function Public_Table_toExcelUrl(filename ,onlyCurrentPageData ,useCurrentTitle,eachCount,userZipFormat){
  //判断是否只取当前页面
  var pageIndex = -1;
  if(onlyCurrentPageData!=null && (onlyCurrentPageData =='true' || onlyCurrentPageData ==true)){
    pageIndex = this.currPage;
    if(pageIndex==null || pageIndex=='') 
      pageIndex=-1;
  }
  
  if(useCurrentTitle==null)useCurrentTitle =false;
  
  var parentDiv = document.all("TableRowSet_ParentDiv_"+ this.DBGridPK);
  var pk = parentDiv.PK;
  
  //获取当前表格的所有的标题
  var titles =''
  if(useCurrentTitle){
    for(i=0;i<this.getVisiColCount();i++){
        titles = titles + this.colNames[i]+"=";
        titles = titles + this.getTitle(this.colNames[i]) + ";";
    }
    if(titles==''){
      alert('对不起,当前表格没有任何数据!');
      return;
    }
    titles = g_ConditonStrEncode(titles.substring(0,titles.length -1));
  }
  
  if(eachCount == null) eachCount = -1;
  if(userZipFormat == null){
  	userZipFormat = false;
  }
  
  var excelOutputPK = -1;
  var tableTagInfo = document.all("TableTagInfo_" + this.DBGridPK);
  if(tableTagInfo != null && tableTagInfo.excelOutputPK !=null && tableTagInfo.excelOutputPK !=''){
  	 excelOutputPK = tableTagInfo.excelOutputPK;
  }
  
  var tUrl = _gModuleName + "/gridturnpage?action=toexcel&pk=" + pk +"&excelOutputPK="+excelOutputPK
      +"&filename=" + g_ConditonStrEncode(filename) +"&pageIndex=" + pageIndex +
      "&columnTitle=" + titles+ "&eachCount="+eachCount + "&userZipFormat="+userZipFormat;
  
  return tUrl;
}
//让所有复选框全选获全不选，并指定是否响应事件
function Public_Table_selectAll(isSelected,isTriggerEvent){
  var colIndex =this.getMutilSelectColIndex();
  this.HeadTable.rows(0).cells(colIndex).children(0).checked = isSelected;
  for(var i=0; i < this.count();i++){
       var tmpRow = this.getRowObj(i);
       if(tmpRow.cells(colIndex).children(0) && tmpRow.cells(colIndex).children(0).style.display !="none"){
          tmpRow.isSelected = isSelected;
          tmpRow.cells(colIndex).children(0).checked = isSelected;
       }
  }
  if(isTriggerEvent != false){
       isTriggerEvent =true;
  }
  if(isTriggerEvent &&  this.OnRowSelected){
     this.OnRowSelected(-100,isSelected);
  }
}
//设置表格某一行的记录复选框的状态
function Public_Table_rowSelected(rowIndex,isSelected,isTriggerEvent){
  if (this.isMutilSelect== false){
    this.setRow(rowIndex);
    return;
  }

  var tmpRow = this.getRowObj(rowIndex);
  if (tmpRow==null)return;
  
  var colIndex =this.getMutilSelectColIndex();
  tmpRow.cells(colIndex).children(0).checked = isSelected;
  tmpRow.isSelected = isSelected;

  this.currentRowChange(rowIndex,this.CurRow);
  this.currentRowChange(this.CurRow,rowIndex);

  if(isTriggerEvent != false){
    isTriggerEvent =true;
  }
  if(isTriggerEvent && this.OnRowSelected){
    this.OnRowSelected(rowIndex,isSelected);
  }
}
//判断某一行复选框是否处于选中状态
function Public_Table_isSelected(rowIndex){
  var result = false;
  if (this.isMutilSelect== true){
    var tmpRow = this.getRowObj(rowIndex);
    var colIndex =this.getMutilSelectColIndex();
    if ((tmpRow) &&(tmpRow.cells(colIndex).children(0).checked == true))
         result = true;
  }else if(this.CurRow  == rowIndex){
    result = true;
  }
  return result;
}
//设置表格抬头的全选复选框的状态
function Public_Table_setAllSelectCheckBoxSts(flag){
  this.disabledSelect(-100,!flag)
}
//设置表格某一行复选框的状态，如果是抬头复选框，则rowIndex=-100
function Public_Table_disabledSelect(rowIndex,flag){
  if (this.isMutilSelect== true){
    var tmpRow;
    if(rowIndex == -100){
      tmpRow = this.HeadTable.rows(0);
    }else{
      tmpRow = this.getRowObj(rowIndex);
    }
    if(tmpRow){
      var colIndex =this.getMutilSelectColIndex();
      var obj = tmpRow.cells(colIndex).children(0);
      obj.disabled = flag;
    }
  }
}
//设置指定行的复选框显示或者隐藏
function Public_Table_visibleSelect(rowIndex,flag){
  var str = "none";
  if(flag == true)
    str = "block";

  if (this.isMutilSelect== true){
    var tmpRow;
    if(rowIndex == -100){
      tmpRow = this.HeadTable.rows(0);
    }else{
      tmpRow = this.getRowObj(rowIndex);
    }
    if(tmpRow){
      var colIndex =this.getMutilSelectColIndex();
      var obj = tmpRow.cells(colIndex).children(0);
      obj.style.display =str;
    }
  }
}
//根据列名设置title
function Public_Table_setTitle(colName,aTitle){
  var index = this.getColIndex(colName);
  this.setTitleByIndex(index,aTitle);
}
//根据索引设置表格标题
function Public_Table_setTitleByIndex(index,aTitle){
  if(index >=0){
    //将改变的title存放起来
    if(this.changeTitleArr == null){
      this.changeTitleArr = new Array();
    }
    this.changeTitleArr["" + index] = aTitle
    
    var cell = this.HeadTable.rows(0).cells(index + this.getRowHeadColCount());
    if(cell.childNodes.length<2){
      cell.innerText=aTitle;
    }else{
      cell.childNodes[1].innerText=aTitle;
    }
  }
}
//根据列名获取title
function Public_Table_getTitle(colName){
  var index = this.getColIndex(colName);
  if(index >=0 && index <this.getVisiColCount()){
    return this.getTitleByIndex(index);
  }
  else{
    alert(colName + '该列为隐藏列或者无效!');
  }
}
//根据索引获取表格标题
function Public_Table_getTitleByIndex(index){
  if(index >=0 && index <this.getVisiColCount()){
    var cell = this.HeadTable.rows(0).cells(index + this.getRowHeadColCount());
    if(cell.childNodes.length<2){
      return cell.innerText;
    }else{
      return cell.childNodes[1].innerText;
    }
  }else{
    alert('无效的index:' + index);
  }
}
//获取表格在服务器上主键
function Public_Table_getServerPK(){
  var parentDiv = document.all("TableRowSet_ParentDiv_"+ this.DBGridPK);
  return parentDiv.PK;
}
//获取表格列的宽度
function Public_Table_getColWidth(colIndex){
  if(colIndex == null || colIndex<0 || colIndex>=this.getVisiColCount()) return -1;
  
   var cell = this.HeadTable.rows(0).cells(colIndex + this.getRowHeadColCount());
   if(cell)
      return cell.width;
   else
      return -1;
}
//设置表格列的宽度
function Public_Table_setColWidth(colName,newWidth){
  var colIndex = this.getColIndex(colName);
  var incWidth  = newWidth - this.getColWidth(colIndex);
  for(var i=0;i< this.HeadTable.rows.length; i++){
    this.HeadTable.rows(i).cells(colIndex + this.getRowHeadColCount()).width = newWidth;
  }
  this.HeadTable.width = parseInt(this.HeadTable.width) + incWidth;

  if (this.DataTable && this.DataTable.rows.length >0){
    this.DataTable.rows(0).cells(colIndex+this.getRowHeadColCount()).width = newWidth;
    this.DataTable.width = parseInt(this.DataTable.width) + incWidth;
  }
}

//获取当前表格所有的列名,包括隐藏列
function Public_Table_getColNames(){ return this.colNames;}
//获取记录第一条索引
function Public_Table_getStartRowIndex(){
  return 0;
}
//获取记录最后一条索引
function Public_Table_getEndRowIndex(){
  return this.count() - 1;
}
//选中某一行
function Public_Table_setRow(rowIndex){
  this.tdOnFocus(rowIndex,this.CurCol);
}
//根据列名和行号选中某个单元格
function Public_Table_setFocusByName(rowIndex,colName){
  var index = this.getColIndex(colName);
  this.setFocus(rowIndex,index);
}
//根据列号和行号选中某个单元格
function Public_Table_setFocus(rowIndex,colIndex){
  rowIndex = parseInt(rowIndex);
  colIndex = parseInt(colIndex);
  this.tdOnFocus(rowIndex,colIndex);
}
//打印表格
function Public_Table_print(printTitle){
    var html = "<table border='1' borderColor='#000000' width ='" + this.HeadTable.width +"'"
    + "style='border-collapse: collapse;table-layout: fixed'>"
    + this.HeadTable.tHead.outerHTML
    + this.DataTable.tBodies(0).outerHTML
    +"</table>";
    if(!printTitle)
    printTitle="";
    var list= new Array();
    list[0] = printTitle;
    list[1] = html;
    window.showModalDialog( _gModuleName+ "/jsv2/print.htm",list,'resizable:no;help:no; status:no;resizable:yes;dialogWidth:600px;dialogHeight:400px');
}
//表格刷新
function Public_Table_refresh(aCondition,parameter,qryset,isShowErrMsg){
  return this.refreshByDefineQeruy(null,aCondition,parameter,qryset,isShowErrMsg);
}
function Public_Table_refreshForObd(parameters,qryset,aCondition,isShowErrMsg){
  var obj =  this.refresh(aCondition,parameters,qryset,isShowErrMsg);
  if(this.count()==0){
    this.visibleSelect(-100,false);
  }
  return obj;
}
function Public_Table_refreshByDefineQeruy(queryid,aCondition,parameter,qryset,isShowErrMsg){
  this.recordTableInfo();
  var obj= Private_Table_refreshLast(this.DBGridPK,aCondition,parameter,qryset,queryid,isShowErrMsg);
  this.restoreTableInfo();
  return obj;
}
function Private_Table_refreshData(aGridPK,aCondition,parameter,qryset,queryid,isShowErrMsg,qrysetXmlFlag){
  return Private_Table_refreshLast(aGridPK,aCondition,parameter,qryset,queryid,isShowErrMsg,qrysetXmlFlag);
}
function Private_Table_refreshLast(aGridPK,aCondition,parameter,qryset,queryid,isShowErrMsg,qrysetXmlFlag){
  var parentDiv = document.all("TableRowSet_ParentDiv_"+ aGridPK);
  if(parentDiv.canrefresh == "false"){
    alert("表格没有设置属性 needrefresh=true 不能执行refresh方法");
    return;
  }
  parentDiv.refreshOpt=true;
  var pk = parentDiv.PK;

  var conditionname = parentDiv.conditionname;
  if ((conditionname) && (aCondition))
    aCondition = conditionname + "=" +g_ConditonStrEncode(aCondition);

  var tUrl = _gModuleName + "/gridturnpage?";
  if(!queryid){
    tUrl = tUrl + "action=refresh&pk=" + pk +"&" + aCondition;
  }else{
    tUrl = tUrl + "action=refreshbydefinequery&pk=" + pk +"&queryid="+ queryid+"&"+ aCondition;
  }
  if(parameter)
    tUrl = tUrl + "&" + parameter;
  
  //针对百发比刷新的，把当前的宽度传到后台
  if(parentDiv.percentWidth != null && parentDiv.percentWidth != '' ){
  	tUrl = tUrl + "&tmpPercentWidth=" + document.all("HeadAndTableDiv_" +aGridPK).clientWidth ;
  }
  
  var tmpstr=""
  if(qryset != null){
    if(qryset.getClassName!=undefined && qryset.getClassName()=="UserDataClass"){
      tmpstr = tmpstr + qryset.toXmlString(true);
    }
    else if(typeof(qryset)=="string"){
      tmpstr = qryset;
    }else{
      var tmpstr  = "<RootInfo>"
      if(qrysetXmlFlag!=null && qrysetXmlFlag==false){
        tmpstr = tmpstr + qryset.toXmlString(false);
      }
      else{
        tmpstr = tmpstr + qryset.toXmlString(true);
      }
      tmpstr = tmpstr   + "</RootInfo>";
    }
  }

	var xmlNode =null;
	if(parentDiv.isSTable != null && parentDiv.isSTable !=""){
		xmlNode = g_TableRowSetManager.get(aGridPK).s_refresh(tUrl,tmpstr);
	}else{
	  //本地缓存
	  if(pk=='-1'){
		tUrl = tUrl + "&localcache=table";
		tmpstr = document.all("TableTagInfo_" + aGridPK).value +tmpstr;
	  }
	  var sRe=PostInfotoServer(tUrl,tmpstr);
	  var xml = new ActiveXObject("Msxml.DOMDocument");
	  xml.async = false;
	  xml.loadXML(sRe);
	  xmlNode = xml.documentElement;
   }

  //如果有错误，则显示错误信息后直接返回
  if(xmlNode.nodeName=="UD"){
    var ud =createUserDataClass(xmlNode);
    if(isShowErrMsg != false){
      var message =ud.getValueByName("MESSAGE");
      if(message){
        alert(message);
      }
    }
    return ud;
  }
  parentDiv.innerHTML = xmlNode.text;
  g_TableRowSetManager.reinitial(aGridPK);

  //没有任何错误信息，返回一个null；
  return null;
}

//当选择的行改变的时候设置行的背景颜色
function Private_Table_currentRowChange(newRowIndex,oldRowIndex){
  var tmpRow = null;
  if ((oldRowIndex >=this.getStartRowIndex())&&(oldRowIndex <= this.getEndRowIndex())){
    tmpRow = this.getRowObj(oldRowIndex);
    if(tmpRow){
      if ((tmpRow.isSelected)&&(tmpRow.isSelected == true)){
        tmpRow.className ="GD-SelectRow";
        //处理用户设置的某一行的特定颜色
        if(this.SelectBgColor)
          tmpRow.style.backgroundColor = this.SelectBgColor;
      }else{//
        if(oldRowIndex %2==0)
          tmpRow.className ="GD-Two";
        else
          tmpRow.className ="GD-One";
        if(tmpRow.SelfBgColor)
          tmpRow.backgroundColor = tmpRow.SelfBgColor;
        else
          tmpRow.backgroundColor = "";
      }
    }
  }
  if ((newRowIndex >=this.getStartRowIndex())&&(newRowIndex <= this.getEndRowIndex())){
    tmpRow = this.getRowObj(newRowIndex);
    if(tmpRow){
      tmpRow.className = "GD-CurrentRow";
      if(this.CurRowBgColor)
        tmpRow.backgroundColor = this.CurRowBgColor;
    }
  }
  //处理当前单元格的背景颜色
  if (this.CurCol >=0){
    var tmpCell = this.getCell(oldRowIndex,this.CurCol);
    if (tmpCell){
      tmpCell.bgColor = "";
      tmpCell.className="GD-TD";
    }
    tmpCell = this.getCell(newRowIndex,this.CurCol);
    if(tmpCell){
      tmpCell.className="GD-CurrentCell";
      if(this.CurCellBgColor)
        tmpCell.bgColor = this.CurCellBgColor;
    }
  }
}
//清除表格所有内容
function  Private_SimpleTable_clear(){
  var obj =this.getTableObject();
  for(var rowIndex = obj.rows.length- 1;rowIndex>=0;rowIndex--)
      obj.deleteRow(rowIndex);
}
//获取表格附加列所占的列数，如多选列或者行号列
function Private_Table_getRowHeadColCount(){
  var result =0;
  if (this.isMutilSelect == true)
     result = result+ 1;

  if (this.isRowSequence == true)
     result = result+ 1;
  return result;
}

//记录表格的大小，列宽 ，以及滚动条的位置 ，hexg ,2007-4-25
function Private_Table_recordTableInfo(){
  //存放列原先的宽度
  if(this.colWidthArray == null){
    this.colWidthArray = new Array();
  }
  
  //存放列原先哪些列被用户隐藏了
  if(this.colHideByUserArray == null){
    this.colHideByUserArray = new Array();
  }
  
  var cells = this.HeadTable.rows(0).cells;
  for(i=0;i<cells.length;i++){
  	//如果该列不隐藏，则记录当前宽度，否则，记录隐藏之前的宽度
  	if(cells(i).preWidth == null){
    	this.colWidthArray[i] = cells(i).width;
    	this.colHideByUserArray[i] = false;
    }else{
    	this.colWidthArray[i] = cells(i).preWidth;
    	this.colHideByUserArray[i] = true;
    }
  }
  //记录原先滚动条所在的垂直位置和水平位置
  this.scrollLeft = this.TableDiv.scrollLeft;
  this.scrollTop = this.TableDiv.scrollTop;
}

//还原表格的大小，列宽 ，滚动条的位置 ,以及动态设置过的title
function Private_Table_restoreTableInfo(){
  //设置原先的长和框
  if(this.currentWidth && this.currentHeight){
    this.resize(this.currentWidth,this.currentHeight);
  }

  //设置原先各个列的宽度
  if(this.colWidthArray != null){
    //设置抬头列宽
    var cells = this.HeadTable.rows(0).cells;
    for(i=0;i<this.colWidthArray.length;i++){
    	this.HeadTable.width = parseInt(this.HeadTable.width ) + (this.colWidthArray[i]-cells(i).width);
        cells(i).width = this.colWidthArray[i];
  }  
    //设置内容列宽
    var rows = this.DataTable.rows;
    if(rows.length>0){
      var cells = rows(0).cells;
        for(i=0;i<this.colWidthArray.length;i++){
          cells(i).width = this.colWidthArray[i];
        }  
    }
    
   	this.DataTable.width=this.HeadTable.width;
   	
   	//将原先隐藏的列再次隐藏
   	for(i=0;i<this.colHideByUserArray.length;i++){
    	if(this.colHideByUserArray[i] == true){
        	this.setColVisible(this.HeadTable.rows(0).cells(i).FieldID , false);
        }
	}  
  }
  
  //设置原先滚动条所在的垂直位置和水平位置
  if(this.scrollLeft!= null && this.TableDiv.scrollWidth>this.scrollLeft){
    this.TableDiv.scrollLeft = this.scrollLeft;
  }
  if(this.scrollTop!= null && this.TableDiv.scrollHeight>this.scrollTop){
    this.TableDiv.scrollTop = this.scrollTop;
  }
  
  //还原通过JS设置过的表格的TITLE
  if(this.changeTitleArr != null){
    for(var prop in this.changeTitleArr){
    	if(isNaN(parseInt(prop)))continue;
        this.setTitleByIndex(parseInt(prop) ,this.changeTitleArr[prop]);
    }
  }
  
  this.adjustHeadDivWidth(this.HeadDiv,this.TableDiv);
}
//重新设置表格各个行的样式
function Private_Table_modifyRowSequence(rowIndex){
   var dataTable = this.getTableObject();
   for(var i=rowIndex;i < dataTable.rows.length;i++){
      if(this.isRowSequence == true){
           dataTable.rows(i).cells(0).innerText = i+1;
      }
      if(dataTable.rows(i).IsTotal)
         dataTable.rows(i).className ="GD-Total-TR";
      else if(i%2==0)
         dataTable.rows(i).className ="GD-Two";
      else
         dataTable.rows(i).className ="GD-One";
   }
}

//按字符排序
function sortFunction(a,b){
  if(a == b)
    return 0;
  else if (a > b)
    return 1;
  else
    return -1;
}

//按数字排序
function sortDigit(a,b){
  var tmpA = parseFloat(a);
  var tmpB = parseFloat(b);
  if(isNaN(tmpA) == false && isNaN(tmpB)== false){
     if(tmpA == tmpB)
       return 0;
     else if (tmpA > tmpB)
       return 1;
     else
       return -1;
  }else{
     if(a == b)
       return 0;
     else if (a > b)
       return 1;
     else
       return -1;
  }
}

function Private_SimpleTable_getClassName(){ return "TableRowSetSimple";}

function Private_Table_checkAndTrans(str){
  str = str.toString();
  if(Private_Table_checkStr(str))
    return Private_Table_transStr(str);
  else
    return str;

}
function Private_Table_checkStr(str){
  if(str.indexOf("&")>=0||str.indexOf(">")>=0||str.indexOf("<")>=0||str.indexOf("'")>=0||str.indexOf('"')>=0)
    return true;
   else
    return false;
}
/**
进行特殊字符替换,add by zhuwg
 */
function Private_Table_transStr(str){
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
//====以下代码实现表格抬头托拉功能======
var g_Grid_Min_ColWidth = 10;
var g_Grid_Min_RowHeight = 10;
//鼠标在表格抬头移动时的响应事件
function Private_TableDrag_mouseMove(element){
    if (element.isContentEditable) return;
    if(element.isBeginDrop) return;
    
    var obj = window.event.srcElement;
     //alert(obj.tagName);
      //alert(Math.abs(event.offsetX - obj.clientWidth));
    if ((obj.tagName.toLowerCase() == "td"  || obj.tagName.toLowerCase() == "span") && Math.abs(event.offsetX - obj.clientWidth) <= 5){

       obj.runtimeStyle.cursor='col-resize';
      }
    else if ((element.IsRowResize =="true"||element.IsRowResize==true)&&(obj.tagName.toLowerCase() == "td"  || obj.tagName.toLowerCase() == "span") && Math.abs(event.offsetY - obj.clientHeight) <= 3)
      {obj.runtimeStyle.cursor='row-resize';        }
    else
{      obj.runtimeStyle.cursor='default';}
}
//表格抬头鼠标按下响应事件
function Private_TableDrag_mouseDown(element){
    if (element.isContentEditable) return;
    var obj = window.event.srcElement;
    if ((obj.tagName.toLowerCase() == "td")&&  Math.abs(event.offsetX - obj.clientWidth) <= 5)
    {             
      obj.runtimeStyle.cursor='col-resize';   
      element.isBeginDrop = true;
      obj.dragDrop();
      element.isBeginDrop = false;
      var incWidth = element.endScreenX - element.startScreenX;
      Private_TableDrag_setColWidth(element,obj.cellIndex,incWidth);
      obj.runtimeStyle.cursor='default';
    }else if ((element.IsRowResize =="true"||element.IsRowResize ==true)&&(obj.tagName.toLowerCase() == "td"  || obj.tagName.toLowerCase() == "span") && Math.abs(event.offsetY - obj.clientHeight) <= 3){
      obj.runtimeStyle.cursor='row-resize';   
      element.isBeginDrop = true;        
      obj.dragDrop();
      element.isBeginDrop = false;
      var incHeight = element.endScreenY - element.startScreenY;
      Private_TableDrag_setRowHeight(element,obj.parentNode,incHeight);
      obj.runtimeStyle.cursor='default';
    }
     else if((obj.tagName.toLowerCase() == "span")&&  Math.abs(event.offsetX - obj.clientWidth) <= 5)
    {
    obj = obj.parentNode;
     obj.runtimeStyle.cursor='col-resize';   
      element.isBeginDrop = true;
      obj.dragDrop();
      element.isBeginDrop = false;
      var incWidth = element.endScreenX - element.startScreenX;
      Private_TableDrag_setColWidth(element,obj.cellIndex,incWidth);
      obj.runtimeStyle.cursor='default';
    }    
    else if ((element.IsRowResize =="true"||element.IsRowResize ==true)&&(obj.tagName.toLowerCase() == "span") && Math.abs(event.offsetY - obj.clientHeight) <= 3){
      obj=obj.parentNode;
      obj.runtimeStyle.cursor='row-resize';   
      element.isBeginDrop = true;        
      obj.dragDrop();
      element.isBeginDrop = false;
      var incHeight = element.endScreenY - element.startScreenY;
      Private_TableDrag_setRowHeight(element,obj.parentNode,incHeight);
      obj.runtimeStyle.cursor='default';
    }          
}

//设置表头列宽
function Private_TableDrag_setColWidth(element,colIndex,incWidth){
  if ((element.IsCustomerColResizeFunc == "true") ||(element.IsCustomerColResizeFunc == true)){
    var newWidth  = parseInt(element.rows(0).cells(colIndex).width )+ incWidth;
    if(newWidth < 5){
     newWidth =5;
     incWidth = newWidth -parseInt(element.rows(0).cells(colIndex).width );
    }
    for(var i=0;i< element.rows.length; i++){
       element.rows(i).cells(colIndex).width = newWidth;
    }
    element.width = parseInt(element.width) + incWidth;

    var dataTable = document.all("DataTable_" + element.DBGridPK);
    if (dataTable && dataTable.rows.length >0){
      dataTable.rows(0).cells(colIndex).width = newWidth;
      dataTable.width = parseInt(dataTable.width) + incWidth;
    }
   
    var head_div = window.document.all("HeadDiv_" + element.DBGridPK);
    var data_div = window.document.all("TableDiv_" + element.DBGridPK);
    Private_Table_adjustHeadDivWidth(head_div,data_div);
    return;
  }
  if (aTable.rows.length <=0) return;
  
  var newWidth = parseInt(aTable.rows(0).cells(colIndex).clientWidth) + parseInt(incWidth);
  if (newWidth <g_Grid_Min_ColWidth){
     newWidth = g_Grid_Min_ColWidth;
     incWidth = newWidth - parseInt(aTable.rows(0).cells(colIndex).clientWidth);
  }
  aTable.style.width = parseInt(aTable.clientWidth) + incWidth + 1;
  aTable.width = aTable.style.width;
  
  for(var i=0;i<aTable.rows.length;i++)
   aTable.rows(i).cells(colIndex).width = newWidth;
} 

//设置表头行高
function Private_TableDrag_setRowHeight(aTable,aRow,incHeight){
  var newHeight = aRow.clientHeight + parseInt(incHeight);
  if (newHeight < g_Grid_Min_RowHeight){
     newHeight = g_Grid_Min_RowHeight;
     incHeight = newHeight -  aRow.clientHeight;
  }
  aTable.height = aTable.clientHeight +  incHeight + 1;
  aRow.height = newHeight;
  aTable.style.height = aTable.height;
}
//表格抬头拖拉结束响应事件
function Private_TableDrag_endDrag(element){        
  element.endScreenX =event.screenX;
  element.endScreenY =event.screenY;
  window.event.returnValue = false;
  window.event.cancelBubble = true;
}
//表格抬头拖拉开始响应事件
function Private_TableDrag_beginDrag(element){
  element.startScreenX =event.screenX;
  element.startScreenY =event.screenY;
}
//====以上代码实现表格抬头托拉功能======

//===以下代码为IE页面生成HTML代码时调用====
//双击表格抬头响应事件

function PrivateIE_Table_OnTitleDbClick(aGridPK){
  var obj = window.event.srcElement;
  //如果是div，则找它上一级
  if(obj.tagName.toLowerCase() =='span'){
    obj = obj.parentNode;
  }
  
  if (obj.FieldID && (obj.tagName.toLowerCase() == "td" || obj.tagName.toLowerCase() == "th")){
      var parentObj = g_TableRowSetManager.get(aGridPK);
      var parentDiv = document.all("TableRowSet_ParentDiv_"+ aGridPK);
  
      //将字段的sorttype存放在最外层的div中
      var fieldTypeSort = eval("parentDiv." + obj.FieldID +"_SortType");
      if(fieldTypeSort == true){
            fieldTypeSort = false;
            eval("parentDiv." + obj.FieldID +"_SortType=false");
      }else{
            fieldTypeSort = true;
            eval("parentDiv." + obj.FieldID +"_SortType=true");
      }
      
      //如果有双击事件，则执行双击事件，否则执行默认的排序方式
      if(parentObj.S_OnTitleDbClick){
        parentObj.S_OnTitleDbClick(obj.FieldID ,fieldTypeSort);
      }else {
        var sortFunction = null;
        if(parentObj.sortFunctionArray != null){
          sortFunction = parentObj.sortFunctionArray[obj.FieldID];
          if(typeof(sortFunction)=='undefined'){
            sortFunction = null;
          }
        }
	    parentObj.sort(obj.FieldID,fieldTypeSort,sortFunction);
      }
      
      //设置排序图标
      parentObj.setColSortIcon(obj.FieldID,fieldTypeSort);
  }
}

function TableRowSet_OnDBLink(aGridPK,aColName,aId){
  var parentObj = g_TableRowSetManager.get(aGridPK);
  if(parentObj.OnDBLink){
  	  TableRowSet_OnClick(aGridPK);
      parentObj.OnDBLink(aColName,aId);
  }
}

function TableRowSet_OnClick(aGridPK){
  var obj = window.event.srcElement;
  var parentObj = g_TableRowSetManager.get(aGridPK);
  if ((obj.tagName == "TD")){
    var rowid = parseInt(obj.parentNode.rowIndex);
    var colid = parseInt(obj.cellIndex) - parentObj.getRowHeadColCount();
    parentObj.tdOnFocus(rowid,colid);
  }else if((obj.tagName == "A" ||obj.tagName == "SPAN")){
    var rowid = parseInt(obj.parentNode.parentNode.rowIndex);
    var colid = parseInt(obj.parentNode.cellIndex) - parentObj.getRowHeadColCount();
    parentObj.tdOnFocus(rowid,colid);
  }else if((obj.tagName == "INPUT" && obj.type=="checkbox" && obj.AG)){
    var rowid = parseInt(obj.parentNode.parentNode.rowIndex);
    var colid = parseInt(obj.parentNode.cellIndex) - parentObj.getRowHeadColCount();
    var tmpRow = parentObj.getRowObj(rowid);
    if (tmpRow){
         tmpRow.isSelected = obj.checked;
         parentObj.currentRowChange(rowid,parentObj.CurRow);
         parentObj.currentRowChange(parentObj.CurRow,rowid);
    }
    if(colid < 0 && parentObj.OnRowSelected){
       parentObj.OnRowSelected(rowid,obj.checked);
    }
  }
}

//设置表格某一列排序图标,sortType表示升序还是降序 ，值是true/false
function Private_SimpleTable_setColSortIcon(colName ,sortType){
   
colName = colName.toUpperCase();
  
  var cells = this.HeadTable.rows(0).cells;
  for(var i = this.getRowHeadColCount();i <  cells.length ;i++){
    //设置升序或降序图标
    if(cells[i].FieldID == colName){  
      if (sortType != false){
        cells[i].childNodes[0].className='GH-SORT-ASC';
      }else{
        cells[i].childNodes[0].className='GH-SORT-DESC';
      } 
    }  
    else{
      cells[i].childNodes[0].className='GH-SORT';
    }
   
  }
}

//单击表格全选框响应事件
function PrivateIE_Table_allSelectChange(aPK){
  var isSelected = window.event.srcElement.checked;
  var parentObj = g_TableRowSetManager.get(aPK);
  parentObj.selectAll(isSelected,true);
}
//实现抬头和数据滚动条的同步
function PrivateIE_Table_dataDivScroll(headDivName){
  var obj = window.event.srcElement;
  //更新滚动条
  var head_div = document.all(headDivName);
  Private_Table_adjustHeadDivWidth(head_div,obj);
  head_div.scrollLeft = obj.scrollLeft;
}
//鼠标在数据表格上右键
function PrivateIE_Table_dataDoContextMenu(aGridPK ,bOnFocus){
  var obj = window.event.srcElement;
  var parentObj = g_TableRowSetManager.get(aGridPK);
  if(parentObj){
    var rowid =-1;
    var colid =-1;
    if (obj.tagName == "TD" && bOnFocus == true){
        rowid = parseInt(obj.parentNode.rowIndex);
        colid = parseInt(obj.cellIndex) - parentObj.getRowHeadColCount();
        parentObj.tdOnFocus(rowid,colid);
    }
    if(parentObj.OnContextMenu)
      parentObj.OnContextMenu(rowid,colid)
  }
  window.event.returnValue = null;
}

//根据表格ID设置表格滚动条
function PrivateIE_Table_adjustTableSize(tableId){
	try{
	  //最外层的DIV
	  var outerDiv = document.all("HeadAndTableDiv_" + tableId);
	  
	  //设置表头DIV、内容DIV的大小
	  var head_div = window.document.all("HeadDiv_" + tableId);
	  var data_div = window.document.all("TableDiv_" + tableId);
	  
	  
	  head_div.style.width = outerDiv.clientWidth;
	  data_div.style.width = outerDiv.clientWidth;
	  
	
	  //设置表格尾巴DIV和table的宽度
	  var footdiv = document.all("FootDiv_"+ tableId);
	  var foottable = document.all("FootTable_"+ tableId);
	  foottable.width = outerDiv.offsetWidth;
	  footdiv.width = outerDiv.offsetWidth;
	  
	  //计算每个列的宽度
	  var head_table = document.all("HeadTable_" + tableId);
	  var headtable_cells = head_table.rows(0).cells;
	  
	 
	  var totalPercentWidth = 0;
	 
	  for(i=0;i<headtable_cells.length;i++){
	  	if(headtable_cells[i].percentWidth ==null || headtable_cells[i].percentWidth =='')continue;
	  	if(headtable_cells(i).preWidth != null && headtable_cells(i).preWidth!='')continue;
	  	
	  	//计算宽度
	  	if(totalPercentWidth==0){
			totalPercentWidth=outerDiv.clientWidth;
			if(data_div.scrollHeight>data_div.clientHeight ){
				totalPercentWidth = totalPercentWidth-17;
			}
			
			for(k=0;k<headtable_cells.length;k++){
				if(headtable_cells[k].FieldID ==null || headtable_cells[k].FieldID ==''){
					totalPercentWidth = totalPercentWidth -headtable_cells[k].offsetWidth;
				}
			}	
	  	}
	  	
	  	var percent =  headtable_cells[i].percentWidth.replace("%","");
	  	var incWidth = parseInt(percent)/100 * totalPercentWidth - headtable_cells[i].width-1;
	  	
	  	Private_TableDrag_setColWidth(head_table,i,incWidth)
	  }
	  	
	  Private_Table_adjustHeadDivWidth(head_div ,data_div);
  
	  //设置表格没有查询到记录的div
	  var dataTable = document.all("DataTable_" + tableId);
      if (dataTable ==null || dataTable.rows.length == 0){
      	 var parentDiv = document.all("TableRowSet_ParentDiv_"+ tableId);
      	 var noResultDiv = document.all("NoResultDiv_" + tableId);
      	 if(noResultDiv != null && parentDiv.refreshOpt==true){
      	 	noResultDiv.style.display='';
      	 	noResultDiv.style.height=data_div.clientHeight-20;
      	 }
      }
   }catch(e){
  	//如果是在加载的时候报错，则在onload的时候还要运行一次
  	if(event == null || event.srcElement == null){
		var adjust_onload= function(){
			PrivateIE_Table_adjustTableSize(tableId);
  		}
  		window.attachEvent('onload', adjust_onload);
  	}
  }
}

//在数据表格上双击
function PrivateIE_SimpleTable_dataOnDbClick(aGridPK){
  var obj = window.event.srcElement;
  var parentObj = g_TableRowSetManager.get(aGridPK);
  if ((obj.tagName == "TD")){
    var rowid = parseInt(obj.parentNode.rowIndex);
    var colid = parseInt(obj.cellIndex) - parentObj.getRowHeadColCount();
    parentObj.tdOnFocus(rowid,colid);
    if (parentObj.OnGridDbClick)
      parentObj.OnGridDbClick(rowid,colid);
  }
}

//表格翻页
function TableRowSet_turnPage(aGridPK,tag){
  var sTime = new Date();
  var parentObj = g_TableRowSetManager.get(aGridPK);
  if(parentObj.pageCount <=1)
   return;
  var pageIndex;

  if(tag =="first") pageIndex = 1;
  else if(tag =="previous") pageIndex = parentObj.currPage - 1;
  else if(tag =="next") pageIndex = parentObj.currPage + 1;
  else if(tag =="last") pageIndex = parentObj.pageCount;
  else if(tag =="goto"){
     var s = document.all("TableRowSet_"+ aGridPK + "_goToPage").value;
     if(s == null || s =="")
       return;
     pageIndex =parseInt(s);
      if( isNaN(parseInt(pageIndex))==true){
         alert("错误：新的页号不是数字！");
         return;
      }
  }
  if (pageIndex <1)  pageIndex = 1;
  else if(pageIndex > parentObj.pageCount) pageIndex = parentObj.pageCount;

  if(pageIndex == parentObj.currPage)
    return;

  if(parentObj.OnBeforeTurnPage){
      var b = parentObj.OnBeforeTurnPage(parentObj.currPage,pageIndex);
      if(b == false)
         return;
  }

  var parentDiv = document.all("TableRowSet_ParentDiv_"+ aGridPK);
  
  var xmlNode =null;
  if(parentDiv.isSTable == null || parentDiv.isSTable ==""){
		var pk = parentDiv.PK;
		var tUrl = _gModuleName + "/gridturnpage?action=turnpage&pk=" + pk +"&newpage=" + pageIndex;
		var xml= new ActiveXObject("Msxml.DOMDocument");
		xml.async = false;
		var b = xml.load(tUrl);
		xmlNode = xml.documentElement;
  }else{
  	xmlNode = parentObj.s_turnPage(aGridPK ,pageIndex);
  }

  parentObj.recordTableInfo();
  parentDiv.innerHTML = xmlNode.text;
  g_TableRowSetManager.reinitial(aGridPK);
  parentObj.restoreTableInfo();
}


//数据表格单击
function PrivateIE_Table_dataOnClick(aGridPK){
  var obj = window.event.srcElement;
  var parentObj = g_TableRowSetManager.get(aGridPK);
  if ((obj.tagName == "TD")){
    var rowid = parseInt(obj.parentNode.rowIndex);
    var colid = parseInt(obj.cellIndex) - parentObj.getRowHeadColCount();
    parentObj.tdOnFocus(rowid,colid);
  }else if((obj.tagName == "A" ||obj.tagName == "SPAN")){
    var rowid = parseInt(obj.parentNode.parentNode.rowIndex);
    var colid = parseInt(obj.parentNode.cellIndex) - parentObj.getRowHeadColCount();
    parentObj.tdOnFocus(rowid,colid);
  }else if((obj.tagName == "INPUT" && obj.type=="checkbox" && obj.AG)){
    var rowid = parseInt(obj.parentNode.parentNode.rowIndex);
    var colid = parseInt(obj.parentNode.cellIndex) - parentObj.getRowHeadColCount();
    var tmpRow = parentObj.getRowObj(rowid);
    if (tmpRow){
      tmpRow.isSelected = obj.checked;
      parentObj.currentRowChange(rowid,parentObj.CurRow);
      parentObj.currentRowChange(parentObj.CurRow,rowid);
    }
    if(colid < 0 && parentObj.OnRowSelected){
       parentObj.OnRowSelected(rowid,obj.checked);
    }
  }else if(obj.tagName =="INPUT" && obj.DBTreeExtend){//树节点的扩展
    var rowid = parseInt(obj.parentNode.parentNode.rowIndex);
    var colid = parseInt(obj.parentNode.cellIndex) - parentObj.getRowHeadColCount();
    var resultRowList = new Array();
    if(obj.parentNode.parentNode.isopen == false){
      obj.value ="-";
      parentObj.open(rowid,resultRowList,true);
    }else{
      obj.value ='+';
      parentObj.close(rowid,resultRowList,true);
    }
  }
}

function TableRowSet_onkeyfunc(func,aGridPK) {
	var obj = g_TableRowSetManager.get(aGridPK);
	try{
		eval(func+"('"+window.event.keyCode+"','"+obj.getRow()+"','"+obj.getCol()+"')");
	}catch(ex){
		alert(ex.name+":"+ex.message);
	}
}


function TableRowSet_clearPageGridsCache(){
	
	var divs = document.getElementsByTagName("div");
	var gridPks = new Array();
	for (var i = 0;i < divs.length;i++){
		if (divs[i].id.indexOf("TableRowSet_ParentDiv_") > -1 && divs[i].PK !="-1"){
			gridPks.push(divs[i].PK);
		}
	}
	if (gridPks.length > 0){
	    var XMLSender = g_GetXMLHTTPRequest();
	    XMLSender.Open("POST",_gModuleName + "/gridturnpage?action=clearpks&pks="+gridPks.join(","),true);
	    XMLSender.setRequestHeader("Content-Type","multipart/form-data");
	    XMLSender.send(null);
	}
	window.detachEvent("onunload",TableRowSet_clearPageGridsCache);
}
if (typeof(_isClearCacheObj)!="undefined" && _isClearCacheObj == "Y"
	&& typeof(_isClearCacheFuncLoad)=="undefined"){
	window.attachEvent("onunload",TableRowSet_clearPageGridsCache);
	var _isClearCacheFuncLoad=true;
}




//-----------------------add------------------------------------------------
 
//鼠标离开  table内数据行的背景回到初始化
function Private_TableDrag_mouseOutTab(aGridPK){
  var obj = window.event.srcElement;
  var parentObj = g_TableRowSetManager.get(aGridPK);
  var tagname = obj.tagName;
  var rowid = parseInt(obj.parentNode.rowIndex);
     
  var i = rowid;
    
  if(tagname=="TD"){
    obj = obj.parentNode;
    if(rowid == parentObj.CurRow){
      obj.className="GD-CurrentRow";
    }
    else if(i%2==0){
      obj.className="GD-Two";
    }
    else{
      obj.className="GD-One";
    }
  }
}
//鼠标悬停 改变title的背景
function Private_TableDrag_mouseOver(element){
    if (element.isContentEditable) return;
   if(element.isBeginDrop) return;
    var obj = window.event.srcElement;
    var tagname = obj.tagName.toLowerCase();
     if(tagname=="td"){
   obj.className="title_hover";
   }
   if(tagname=="span"){
   obj = obj.parentNode;
   obj.className="title_hover";
   }

}
//鼠标离开  title的背景回到初始化
function Private_TableDrag_mouseOut(element){
     if (element.isContentEditable) return;
   if(element.isBeginDrop) return;
    
    var obj = window.event.srcElement;
   var tagname = obj.tagName.toLowerCase();
    if(tagname=="td"){
   obj.className="GH-TD";
   }
      if(tagname=="span"){
   obj = obj.parentNode;
   obj.className="GH-TD";
   }
 }

//  刘红楠新增
//  setRowColFontColor(rowIndex,colName,color):设置制定单元格字体颜色
//  setRowColBgColor(rowIndex,colName,color):设置制定单元格背景颜色

function TableRowSet_setRowColFontColor(rowIndex,colName,color){
  var obj = this.getRowObj(rowIndex);
  var index = this.getColIndex(colName);
  if (obj){
  	if(obj.cells.length <= index)
      obj.cells[index].style.color=color;
      }
}      

function TableRowSet_setRowColBgColor(rowIndex,colName,color){
  var obj = this.getRowObj(rowIndex);
  var index = this.getColIndex(colName);
  if (obj){
  	if(obj.cells.length <= index)
      obj.cells[index].style.backgroundColor=color;
      }
}
