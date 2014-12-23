/**
 　
 　作者 ： 墙辉   2004/04/10

 　使用范例　：　AIGridDemo.jsp
   TableRowSetManager ：表格数据集管理器。对页面内的所有表格组件进行管理。
      构造方法：在页面加载时自动创建。
      开发人员可以使用的方法：
        get(pk)：根据表格数据数据集的唯一标识获取表格数据集对象。
      其它方法：
        push(tableRowSet):向管理器中增加一个表格数据集。
        remove(pk)：删除一个数据集对象。
      用法说明：
        开发人员只能使用get(pk)方法获取表格数据对象，然后调用数据对象的相关方法。例如：
          var rowset = g_TableRowSetManager.get("staff");
          var list = rowset.getSelectedRows();


   TableRowSet： 表格数据集组件
      构造方法：通过AIDBGrigTag类构造HTML文本
      开发人员可以使用方法：
        setEditSts(value)　：　设置表格的编辑状态　value = true(可编辑),false(不可编辑)
        setRowEditSts(rowIndex,value)：根据行号设置行的可编辑属性 value = true(可编辑),false(不可编辑)
        getRowEditSts(rowIndex)：根据行号获取行可编辑属性：true(可编辑),false(不可编辑)
        setCellEditSts(rowIndex,colName,value):设置某个单元个的编辑属性：true(可编辑),false(不可编辑)
        setColEditSts(colName,value)：根据列名设置列的可编辑属性 value = true(可编辑),false(不可编辑)
        setTableBgColor(color)：设置表格的背景颜色
        setHeadBgColor(color)：设置表头的颜色
        setCurRowBgColor(color)：设置表格的当前行背景颜色
        setCurCellBgColor(color)：设置当前单元格的背景颜色
        setRowBgColor(rowIndex,color):设置指定行的背景颜色
        setCurRowFontColor(color)：设置表格的当前行字体颜色
        setCurCellFontColor(color)：设置当前单元格的字体颜色
        setRowFontColor(rowIndex,color):设置指定行的字体颜色
        setBorderColor(color)：设置表格的边框颜色
        setBorder(num)：设置表格的边框宽度颜色

        // 刘红楠新增
        setRowColFontColor(rowIndex,colName,color):设置制定单元格字体颜色
        setRowColBgColor(rowIndex,colName,color):设置制定单元格背景颜色



        getRow()：获取当前行号
        setRow(rowIndex)：设置当前行号
        getCol(): 获取当前列号
        setFocus(rowIndex,colIndex)：将焦点设置到指定的单元格上
        setFocusByName(rowIndex,colName)：将焦点设置到指定的单元格上
        getNameByIndex(colIndex): 获得列名

        newRow(isScrollIntoView)：新增一行.isScrollIntoView：是否将新增的行滚动为科技：true，false
        deleteRow(rowIndex)：删除一行

        count()：有效的行数
        getTotalRowCount():获取总记录数
        isSelected(rowIndex)：测试某一行是否选中
        disabledSelect(rowIndex,flag):设置某一行的多选按钮为不可编辑。flag : true(不可编辑),false(可编辑)
        visibleSelect(rowIndex,flag):设置某一行的多选按钮为不可见。flag:true(可见),false(不可见)
        setAllSelectCheckBoxSts(value):设置全选按钮的编辑状态
        selectAll(isSelected,isTriggerEvent):设置所有行的选择状态 isSelected = true(选中) false(不选中),isTriggerEvent(true,false)是否要求触发事件
        rowSelected(rowIndex,isSelected,isTriggerEvent)：
        		设置某一行的选中状态　isSelected = true(选中) false(不选中),isTriggerEvent(true,false)是否要求触发事件
        getSelectedRows() : 获取选中行行号数组
        getServerPK():获得服务端缓冲数据编号

        getValue(rowIndex,colName)：获取指定单元的数据值
        getDisplayText(rowIndex,colName)：获取指定单元的显示值
        setValue(rowNumber,fieldTypeName,id,displayText)：根据行号，列名设置数据值, id 数据值,displayText 显示值
        toXmlString(isOnlySendModifyData,colnames,isIncludeDisplayAttr)：将数据转化为Xml字符串。
        toXmlStringOfSelects(colnames,isIncludeDisplayAttr):将选中数据行转化为Xml字符串。
        toXmlStringOfRows(rows,colnames,isIncludeDisplayAttr):将指定数据行转化为Xml字符串。

        refresh(condition,parameter,qryset,isShowErrMsg):输入查询条件刷新表格
        refreshForObd(parameters,qryset,,aCondition,isShowErrMsg):查询参数，查询的SET数据集
        refreshByDefineQeruy(queryid,aCondition,parameter,qryset,isShowErrMsg):根据自定义查询编号　和　额外条件进行查询

        setPageSize(aPagesize):设置每页显示的记录数量
        toExcelUrl(filename,onlyCurrentPageData ,useCurrentTitle):将表格所有数据从服务器端导为Excel.CSV 文件。filename：文件名称。
           onlyCurrentPageData :true/false,表示是否只下载当前页面的数据，默认为false
           useCurrentTitle 表示是否使用当前的标题当作导出excel文件的标题,默认为false
           eachCount 为防止数据量过大可进行分批查询，eachCount表示每批查询的数据量
            使用方式：
        		<a onclick="javascript:(this.href=g_TableRowSetManager.get('tableId').toExcelUrl('文件名称'))"
                        	href="#"> 文件下载.... </a>
        clearListBox(fieldName):清除下来框选项
        sort(colName,sortType):按字段进行页内排序。sortType(true:升序，false：降序)
        setTitle(colName,title):设置表头名称
		setTitleByIndex(index,title):根据index设置表头名称
		getTitle(colName):根据colName获取表头名称
		getTitleByIndex(index):根据index设置表头名称
        resize(width,height):设置表格宽度，但不会影响列的宽度
        setAlign(colName,alignType):设置单元格对齐方式：colName列名，alignType对齐方式(center,justify,left,right)
        getColCount获取表格列数目
        getVisiColCount获取可视列的数目

        //DBTree编辑方式增加的方法
        getChildList(rowIndex):获得儿子的行号数组
        getParentOfRow(rowIndex):获得直接的父亲行号
        setParent(rowIndex,parentRowIndex,colName):改变某一行的父亲，colname指编辑方式为DBTree的列名
        setColSortFunction(colname, sortfunction);为某一列指定排序的方法

		setColVisible(columnName ,flag):隐藏、显示表格的列,flag: true表示显示； false表示隐藏。这种该列必须事先在dbgrid的col tag中定义，并且不隐藏字段


      支持的事件：
        OnRowFocusChange ： 参数说明：OldRowIndex,NewRowIndex
        OnCellFocusChange： 参数说明：OldRowIndex,OldColIndex,NewRowIndex,NewColIndex
        OnValueChange ： 参数说明：row,col,oldValue,newValue
        OnGridDbClick ：参数说明：RowIndex,ColIndex
        OnContextMenu : 参数说明：RowIndex,ColIndex
        OnBeforeTurnPage : 参数说明：oldPage,newPage
        OnAfterTurnPage : 参数说明：newPage
        OnRowSelected:参数说明：RowIndex,isSelected (:true,false) RowIndex = -100 表示全部选中
        OnResize:参数说明：oldWidth,oldHeight,newWidth,newHeight
        OnFocusOut:无参数，表格失去焦点的时候响应

修改记录：
	1、对失去焦点问题的处理
	 增加函数TableRowSet_OnFocusOut
	 修改函数TableRowSet_setValue，增加对失去焦点的处理
	2、增加对RowSequence的处理，新增方法modifyRowSequence
        	修改方法：newRow，deleteRow，initial,getRowHeadColCount
          后台增加RowSequence属性，修改dbgrid_head.vm,
          新增class：DBGrid_THead_RowSequence，GD-Seq

        3、调整相关颜色的配置方式，增加css：DBGrid_Data_One,DBGrid_Data_Two,GD-CurrentRow,
        	GD-CurrentCell,GD-SelectRow。
           修改文件TableRowSet_OnClick，TableRowSet_currentRowChange

	4、增加对DBHtml编辑方式的除了，修改setValue，getValue，getDisplayText

***********/
//TableRowSet的inital错误获取函数
function TableRowSet_getInitErrorData(pTableId){
      if(document.all("TableRowSet_CUSTOM_ERROR_" + pTableId)==null)
      {
         return null;
      }
      else
      {
      var errorXmlNode = document.all("TableRowSet_CUSTOM_ERROR_" + pTableId).XMLDocument.childNodes(0);
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

/**
 *
    OnRowFocusChange ： 参数说明：OldRowIndex,NewRowIndex
    OnCellFocusChange： 参数说明：OldRowIndex,OldColIndex,NewRowIndex,NewColIndex
    OnGridDbClick ：参数说明：RowIndex,ColIndex
    OnValueChange : 参数说明：RowIndex,ColName,OldValue,NewValue
 *
 */
function TableRowSet(aName,aPkName){
  this.DBGridPK = aName;
  this.pkName = aPkName; //数据集的主键字段名称
  
  g_TableRowSetManager.push(this);
  this.initial();
}

//初始化表格
function  TableRowSet_initial(){
  this.DBHTML = "DBHtml";
  this.DBTree = "DBTree";
  this.CurRow = -1;
  this.CurCol = -1;
  this.NewRowDataId = 0;
  this.IsEditable = false;
  
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
  this.colIndexs = new Array();
  this.colNames = new Array();
  this.colIsHide = new  Array();   //数据列是否藏隐
  this.rowHideCols  = new  Array();// 在需要的时候存放行的隐藏列
  this.visioColCount =0;
  this.m_hasTotalRow = false;
  
  
  
  this.totalColNames = new Array();
  this.totalColTypes = new Array();

  this.permissionCanModifyCols = new Array();//权限控制系统决定的列的修改属性
  this.permissionMaskCols = new Array();//那些列是掩码字段，在进行设置值时，显示属性为××××
  this.MO_MASK_STRING ="***"; //用××*作掩码

  this.RowEditable = new Array();

  //能够修改的单元格，如果在此数组中没有或者true，表示可编辑
  //数组的key是：Row－col
  this.canModfiyCells = new Array();

  this.deleteRows = new Array();
  this.isMutilSelect = false;
  this.isRowSequence = false;
  
  //判断当前是否是只读模式
  this.onlyQuery = false;
  if(this.TableRowSetDiv.onlyQuery && this.TableRowSetDiv.onlyQuery=='true'){
    this.onlyQuery = true;
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
  if(this.TableRowSetDiv.S_OnValueChange)
    eval("this.OnValueChange = " + this.TableRowSetDiv.S_OnValueChange);
  if(this.TableRowSetDiv.S_OnRowFocusChange)
    eval("this.OnRowFocusChange = " + this.TableRowSetDiv.S_OnRowFocusChange);
  if(this.TableRowSetDiv.S_OnCellFocusChange)
    eval("this.OnCellFocusChange = " + this.TableRowSetDiv.S_OnCellFocusChange);

  //失去焦点事件
  if(this.TableRowSetDiv.S_OnFocusOut){
    var index = this.TableRowSetDiv.S_OnFocusOut;
    if(index >-1)this.TableRowSetDiv.S_OnFocusOut = this.TableRowSetDiv.S_OnFocusOut.substring(0,index);
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

  if (!this.TableRowSetDiv.isRowSequence)
      this.isRowSequence = false;
  else
      this.isRowSequence = true;

  if (!this.TableRowSetDiv.isMutilSelect)
      this.isMutilSelect = false;
  else
      this.isMutilSelect = true;

  if(this.TableRowSetDiv.Edit == "true")
    this.IsEditable = true;


  var headCount = this.getRowHeadColCount();
  var cells = this.HeadTable.rows(0).cells;

  for(var i=0;i< cells.length - headCount ;i++){
    var tmpCell = cells(i + headCount);
    this.colIndexs[tmpCell.FieldID.toUpperCase()] = i;
    this.colNames[i] = tmpCell.FieldID;
    this.colIsHide[i] = false;
    //获取权限控制属性
    if(tmpCell.CanModify && tmpCell.CanModify =="false")
      this.permissionCanModifyCols[i] = false;
    else
      this.permissionCanModifyCols[i] = true;
    if(tmpCell.IsMask && tmpCell.IsMask =="false")
      this.permissionMaskCols[i] = false;
    else
    {
     this.permissionMaskCols[i] = true;
     }
  }

  this.visioColCount =  cells.length - headCount;
  var tmpHideColNames = this.HeadTable.rows(0).FieldIDs;
  if(tmpHideColNames){
    var list = splitString(tmpHideColNames,",");
    for(var i=0;i< list.length;i++){
      this.colIndexs[list[i].toUpperCase()] = i + this.visioColCount;
      this.colNames[ i + this.visioColCount] = list[i];
      this.colIsHide[i + this.visioColCount] = true;
      this.permissionCanModifyCols[i + this.visioColCount] = false;
      this.permissionMaskCols[i + this.visioColCount] = false;
    }
  }

  //判断是否有合计行
  var allCount = this.DataTable.rows.length;
  if (allCount > 0 ){
    var totalRow = this.DataTable.rows(allCount - 1);
    if (totalRow.IsTotal)
      this.m_hasTotalRow = true;
  }
  
  var xmlNode = document.all("TableRowSet_FieldTypeSet_" + this.DBGridPK).XMLDocument.childNodes(0);
  for(var i = 0;i < xmlNode.childNodes.length;i++){
    var tmpNode = xmlNode.childNodes(i);
    if ( tmpNode.nodeName == "HEAD")
      this.ListDataSource = new ListDataSourceFactory(tmpNode);
    else if ( tmpNode.nodeName == "FieldTypeSet")
      this.FieldTypeSet = new FieldTypeSetClass(tmpNode);
  }
  
  for(var i=0;i< cells.length - headCount ;i++){
    var tmpCell = cells(i + headCount);
    if(tmpCell.TotalCol && tmpCell.TotalCol=="true"){
      this.addTotalCol(tmpCell.FieldID,this.FieldTypeSet.getFieldByName(tmpCell.FieldID).getDataType());
    }
  }
  
  this.getTableObject().onmouseover=TableRowSet_showColTips;
}

//表格重新初始化
function TableRowSet_reinitial(){
  this.CurRow = -1;
  this.CurCol = -1;
  this.NewRowDataId = 0;
  
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
  this.colIndexs = new Array();
  this.colNames = new Array();
  this.colIsHide = new  Array();   //数据列是否藏隐
  this.rowHideCols  = new  Array();// 在需要的时候存放行的隐藏列
  this.visioColCount =0;
  
  if(this.TableRowSetDiv.Edit == "true")
    this.IsEditable = true;
  else
    this.IsEditable = false;
  
  this.totalColNames = new Array();
  this.totalColTypes = new Array();

  this.permissionCanModifyCols = new Array();//权限控制系统决定的列的修改属性
  this.permissionMaskCols = new Array();//那些列是掩码字段，在进行设置值时，显示属性为××××
  this.MO_MASK_STRING ="***"; //用××*作掩码

  this.RowEditable = new Array();

  //能够修改的单元格，如果在此数组中没有或者true，表示可编辑
  //数组的key是：Row－col
  this.canModfiyCells = new Array();

  this.deleteRows = new Array();
  
  var headCount = this.getRowHeadColCount();
  var cells = this.HeadTable.rows(0).cells;

  for(var i=0;i< cells.length - headCount ;i++){
    var tmpCell = cells(i + headCount);
    this.colIndexs[tmpCell.FieldID.toUpperCase()] = i;
    this.colNames[i] = tmpCell.FieldID;
    this.colIsHide[i] = false;
    //获取权限控制属性
    if(tmpCell.CanModify && tmpCell.CanModify =="false")
      this.permissionCanModifyCols[i] = false;
    else
      this.permissionCanModifyCols[i] = true;
    if(tmpCell.IsMask && tmpCell.IsMask =="false")
      this.permissionMaskCols[i] = false;
    else
    {
     this.permissionMaskCols[i] = true;
     }
  }

  this.visioColCount =  cells.length - headCount;
  var tmpHideColNames = this.HeadTable.rows(0).FieldIDs;
  if(tmpHideColNames){
    var list = splitString(tmpHideColNames,",");
    for(var i=0;i< list.length;i++){
      this.colIndexs[list[i].toUpperCase()] = i + this.visioColCount;
      this.colNames[ i + this.visioColCount] = list[i];
      this.colIsHide[i + this.visioColCount] = true;
      this.permissionCanModifyCols[i + this.visioColCount] = false;
      this.permissionMaskCols[i + this.visioColCount] = false;
    }
  }
  
  var xmlNode = document.all("TableRowSet_FieldTypeSet_" + this.DBGridPK).XMLDocument.childNodes(0);
  for(var i = 0;i < xmlNode.childNodes.length;i++){
    var tmpNode = xmlNode.childNodes(i);
    if ( tmpNode.nodeName == "HEAD")
      this.ListDataSource = new ListDataSourceFactory(tmpNode);
  }
  
  for(var i=0;i< cells.length - headCount ;i++){
    var tmpCell = cells(i + headCount);
    if(tmpCell.TotalCol && tmpCell.TotalCol=="true"){
      this.addTotalCol(tmpCell.FieldID,this.FieldTypeSet.getFieldByName(tmpCell.FieldID).getDataType());
    }
  }
  
  this.getTableObject().onmouseover=TableRowSet_showColTips;
  
  //设置新的PK
  var tableTagInfo = document.all("TableTagInfo_" + this.DBGridPK);
  if(tableTagInfo != null && tableTagInfo.newGridPK !=null && tableTagInfo.newGridPK !=''){
  	var parentDiv = document.all("TableRowSet_ParentDiv_"+ this.DBGridPK);
  	parentDiv.PK = tableTagInfo.newGridPK;
  }
}

TableRowSet.prototype.reinitial = TableRowSet_reinitial;
TableRowSet.prototype.initial = TableRowSet_initial;
TableRowSet.prototype.resize = TableRowSet_resize;

TableRowSet.prototype.setValue = TableRowSet_setValue;

TableRowSet.prototype.getCellSts =TableRowSet_getCellSts;
TableRowSet.prototype.getCellStsFromCell =TableRowSet_getCellStsFromCell;

TableRowSet.prototype.getValue = TableRowSet_getValue;
TableRowSet.prototype.getValueFromCell = TableRowSet_getValueFromCell;
TableRowSet.prototype.getValuePrivate = TableRowSet_getValuePrivate;

TableRowSet.prototype.getDisplayText = TableRowSet_getDisplayText;
TableRowSet.prototype.getDisplayTextFromCell = TableRowSet_getDisplayTextFromCell;

TableRowSet.prototype.getOldValue = TableRowSet_getOldValue;
TableRowSet.prototype.getOldValueFromCell = TableRowSet_getOldValueFromCell;

TableRowSet.prototype.getOldDisplayText = TableRowSet_getOldDisplayText;
TableRowSet.prototype.getOldDisplayTextFromCell = TableRowSet_getOldDisplayTextFromCell;

TableRowSet.prototype.getRowObj = TableRowSet_getRowObj;
TableRowSet.prototype.getCurRowIndex = TableRowSet_getCurRowIndex;
TableRowSet.prototype.getCell = TableRowSet_getCell;
TableRowSet.prototype.getCellByName = TableRowSet_getCellByName;
TableRowSet.prototype.realcount = TableRowSet_realcount;
TableRowSet.prototype.count = TableRowSet_count;
TableRowSet.prototype.getTotalRowCount = TableRowSet_getTotalRowCount;
TableRowSet.prototype.modifyTotalRowCount = TableRowSet_modifyTotalRowCount;

TableRowSet.prototype.getColCount = TableRowSet_getColCount;
TableRowSet.prototype.getVisiColCount = TableRowSet_getVisiColCount;

TableRowSet.prototype.toXmlStringCell = TableRowSet_toXmlStringCell;
TableRowSet.prototype.toXmlString = TableRowSet_toXmlString;
TableRowSet.prototype.toXmlStringDeleteRow = TableRowSet_toXmlStringDeleteRow;
TableRowSet.prototype.toXmlStringRow = TableRowSet_toXmlStringRow;

TableRowSet.prototype.toXmlStringOfSelects = TableRowSet_toXmlStringOfSelects;
TableRowSet.prototype.toXmlStringOfRows = TableRowSet_toXmlStringOfRows;


TableRowSet.prototype.copyCell = TableRowSet_copyCell;

TableRowSet.prototype.hasTotalRow = TableRowSet_hasTotalRow;
TableRowSet.prototype.getTableObject = TableRowSet_getTableObject;
TableRowSet.prototype.clear = TableRowSet_clear;
TableRowSet.prototype.deleteRow = TableRowSet_deleteRow;
TableRowSet.prototype.removeDeleteRow = TableRowSet_removeDeleteRow;
TableRowSet.prototype.setRow = TableRowSet_setRow;
TableRowSet.prototype.getStartRowIndex = TableRowSet_getStartRowIndex;
TableRowSet.prototype.getEndRowIndex = TableRowSet_getEndRowIndex;
//TableRowSet.prototype.SelectBgColor = "#FFFFFF"; //确省行选中颜色
//TableRowSet.prototype.CurRowBgColor ="#C4CCFF"; //确省当前行格颜色
//TableRowSet.prototype.CurCellBgColor = "#FFFF8E"; //确省当前单元格颜色
TableRowSet.prototype.DefaultRowHeight =20;  //确省的行高
TableRowSet.prototype.DefaultTextareaHeight =50;  //确省的Textarea高度
TableRowSet.prototype.currentRowChange = TableRowSet_currentRowChange;
TableRowSet.prototype.setCellEditable = TableRowSet_setCellEditable;
TableRowSet.prototype.tdOnFocus = TableRowSet_tdOnFocus;
TableRowSet.prototype.setFocus = TableRowSet_setFocus;
TableRowSet.prototype.setFocusByName = TableRowSet_setFocusByName;

TableRowSet.prototype.getEditer = TableRowSet_getEditer;
TableRowSet.prototype.isCellEditable = TableRowSet_isCellEditable;
TableRowSet.prototype.getColIndex = TableRowSet_getColIndex;
TableRowSet.prototype.getNameByIndex = TableRowSet_getNameByIndex;

TableRowSet.prototype.setColEditSts = TableRowSet_setColEditSts;

TableRowSet.prototype.setEditSts = TableRowSet_setEditSts;
TableRowSet.prototype.setCellEditSts = TableRowSet_setCellEditSts;
TableRowSet.prototype.setRowEditSts = TableRowSet_setRowEditSts;
TableRowSet.prototype.getRowEditSts = TableRowSet_getRowEditSts;
TableRowSet.prototype.recomputerTotal = TableRowSet_recomputerTotal;
TableRowSet.prototype.recomputerTotalAll = TableRowSet_recomputerTotalAll;
TableRowSet.prototype.addTotalCol = TableRowSet_addTotalCol;
TableRowSet.prototype.newRow = TableRowSet_newRow;
TableRowSet.prototype.insertRow = TableRowSet_insertRow;

TableRowSet.prototype.getDeletRows = TableRowSet_getDeletRows;
TableRowSet.prototype.getRowSts = TableRowSet_getRowSts;
TableRowSet.prototype.setRowSts = TableRowSet_setRowSts;
TableRowSet.prototype.getColWidth = TableRowSet_getColWidth;
TableRowSet.prototype.setColWidth = TableRowSet_setColWidth;

TableRowSet.prototype.getRowHeadColCount = TableRowSet_getRowHeadColCount;
TableRowSet.prototype.getSelectedRows = TableRowSet_getSelectedRows;
TableRowSet.prototype.rowSelected = TableRowSet_rowSelected;
TableRowSet.prototype.isSelected = TableRowSet_isSelected;
TableRowSet.prototype.disabledSelect = TableRowSet_disabledSelect;
TableRowSet.prototype.setAllSelectCheckBoxSts = TableRowSet_setAllSelectCheckBoxSts;
TableRowSet.prototype.getRow = TableRowSet_getRow;
TableRowSet.prototype.getCol = TableRowSet_getCol;
TableRowSet.prototype.getFieldType = TableRowSet_getFieldType;

TableRowSet.prototype.getNewRowDataId = TableRowSet_getNewRowDataId;
TableRowSet.prototype.getRowId = TableRowSet_getRowId;

TableRowSet.prototype.setTableBgColor = TableRowSet_setTableBgColor;
TableRowSet.prototype.setHeadBgColor = TableRowSet_setHeadBgColor;
TableRowSet.prototype.setCurRowBgColor = TableRowSet_setCurRowBgColor;
TableRowSet.prototype.setCurRowFontColor = TableRowSet_setCurRowFontColor;
TableRowSet.prototype.setCurCellBgColor = TableRowSet_setCurCellBgColor;
TableRowSet.prototype.setCurCellFontColor = TableRowSet_setCurCellFontColor;
TableRowSet.prototype.setRowBgColor = TableRowSet_setRowBgColor;
TableRowSet.prototype.setRowFontColor = TableRowSet_setRowFontColor;

TableRowSet.prototype.setBorderColor = TableRowSet_setBorderColor;
TableRowSet.prototype.setBorder = TableRowSet_setBorder;

//  刘红楠新增
//  setRowColFontColor(rowIndex,colName,color):设置制定单元格字体颜色
//  setRowColBgColor(rowIndex,colName,color):设置制定单元格背景颜色
TableRowSet.prototype.setRowColFontColor = TableRowSet_setRowColFontColor;
TableRowSet.prototype.setRowColBgColor = TableRowSet_setRowColBgColor;


TableRowSet.prototype.refreshForObd = TableRowSet_refreshForObd;
TableRowSet.prototype.refresh = TableRowSet_refresh;
TableRowSet.prototype.refreshByDefineQeruy = TableRowSet_refreshByDefineQeruy;

TableRowSet.prototype.setStsToOld = TableRowSet_setStsToOld;
TableRowSet.prototype.getColNames = TableRowSet_getColNames;

TableRowSet.prototype.getClassName = TableRowSet_getClassName;

TableRowSet.prototype.verify = TableRowSet_verify;
TableRowSet.prototype.print = TableRowSet_print;
TableRowSet.prototype.queryModel = TableRowSet_queryModel;

TableRowSet.prototype.setTitle = TableRowSet_setTitle;
TableRowSet.prototype.setTitleByIndex = TableRowSet_setTitleByIndex;
TableRowSet.prototype.getTitle = TableRowSet_getTitle;
TableRowSet.prototype.getTitleByIndex = TableRowSet_getTitleByIndex;

TableRowSet.prototype.getServerPK = TableRowSet_getServerPK;
TableRowSet.prototype.selectAll = TableRowSet_selectAll;


TableRowSet.prototype.setPageSize = TableRowSet_setPageSize;
TableRowSet.prototype.toExcelUrl = TableRowSet_toExcelUrl;
TableRowSet.prototype.clearListBox  = TableRowSet_clearListBox;
TableRowSet.prototype.sort  = TableRowSet_sort;

TableRowSet.prototype.modifyRowSequence  = TableRowSet_modifyRowSequence;
TableRowSet.prototype.getMutilSelectColIndex  = TableRowSet_getMutilSelectColIndex;
TableRowSet.prototype.setAlign  = TableRowSet_setAlign;
TableRowSet.prototype.visibleSelect  = TableRowSet_visibleSelect;


//DBTree编辑方式增加的方法
TableRowSet.prototype.open = TableRowSet_open;
TableRowSet.prototype.close = TableRowSet_close;
TableRowSet.prototype.getChildList = TableRowSet_getChildList;
TableRowSet.prototype.setChildList = TableRowSet_setChildList;
TableRowSet.prototype.getIsOpen = TableRowSet_getIsOpen;
TableRowSet.prototype.recomputerChildRowIndex = TableRowSet_recomputerChildRowIndex;
TableRowSet.prototype.recomputerChildRowIndexOfTwo = TableRowSet_recomputerChildRowIndexOfTwo;
TableRowSet.prototype.getParentOfRow = TableRowSet_getParentOfRow;
TableRowSet.prototype.getLevel = TableRowSet_getLevel;
TableRowSet.prototype.setParent = TableRowSet_setParent;
TableRowSet.prototype.reDrawTreeCell = TableRowSet_reDrawTreeCell;
TableRowSet.prototype.reDrawTreeCellByField = TableRowSet_reDrawTreeCellByField;
TableRowSet.prototype.recomputerLevelOfChild = TableRowSet_recomputerLevelOfChild;
TableRowSet.prototype.moveRow = TableRowSet_moveRow;
TableRowSet.prototype.getLastRowIndexOfChild = TableRowSet_getLastRowIndexOfChild;

TableRowSet.prototype.restoreTableInfo = TableRowSet_restoreTableInfo;
TableRowSet.prototype.recordTableInfo = TableRowSet_recordTableInfo;
TableRowSet.prototype.setColSortFunction = TableRowSet_setColSortFunction;
TableRowSet.prototype.setColSortIcon = TableRowSet_setColSortIcon;
TableRowSet.prototype.resetFootInfo = TableRowSet_resetFootInfo;

TableRowSet.prototype.setColVisible = TableRowSet_setColVisible;
TableRowSet.prototype.adjustTableSize = PrivateIE_Table_adjustTableSize;

function  TableRowSet_setAlign(colName,alignType){
  var colIndex = this.getColIndex(colName) + this.getRowHeadColCount();
  for(var i=0;i< this.DataTable.rows.length;i++){
     this.DataTable.rows(i).cells(colIndex).align = alignType;
  }
}
function TableRowSet_getMutilSelectColIndex(){
  var colIndex = 0;
  if(this.isRowSequence == true)
    colIndex = 1;
  return   colIndex;
}

//设置表格某一列排序图标,sortType表示升序还是降序 ，值是true/false
function TableRowSet_setColSortIcon(colName ,sortType){
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

function TableRowSet_showColTips(){
 var obj = window.event.srcElement;
  if(event.srcElement == null || event.srcElement == "null") {
	  return;
  }
	if(event.srcElement.tagName !='TD')return;
else{
   obj = obj.parentNode;
   obj.className="td_hover";
  }
	//判断显示的title是否是tag显示，如果是，则不修改，否则实时设置单元格的title
	if(event.srcElement.tagPrompt == null || event.srcElement.tagPrompt==""){
		if(event.srcElement.title != null && event.srcElement.title != "" ){
			event.srcElement.tagPrompt = "true";
		}else{
			event.srcElement.tagPrompt = "false";
		}
	}
		
	if(event.srcElement.tagPrompt == "false" ){
		event.srcElement.title = event.srcElement.innerText;	
	}
}


//隐藏、显示表格的列,flag: true表示显示； false表示隐藏。这种该列必须事先在dbgrid的col tag中定义，并且不隐藏字段
function TableRowSet_setColVisible(colName ,flag){
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
	TableRowSet_setHeadDivWidth(head_div,data_div);
}



//设置表格某一列的排序方法
function TableRowSet_setColSortFunction(colName ,sortFunction){
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

function TableRowSet_OnTitleDbClick(aGridPK){
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

function TableRowSet_sort(colName,sortType,sortFunction){ //false 降序
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
	var dataType = this.FieldTypeSet.getFieldByName(colName).getDataType()
    
    //按照用户自定义的排序方法排序
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
     //alert(tmpList.join(','));
     for(var i=0;i<tmpList.length;i++){
	if(i == tmpList[i])
          continue;
        this.getRowObj(i).swapNode(this.getRowObj(tmpList[i]));

        //交换隐藏列的值
        if(this.rowHideCols[i]!=null || this.rowHideCols[tmpList[i]]!=null){
        	var tmp = this.rowHideCols[i];
        	this.rowHideCols[i] = this.rowHideCols[tmpList[i]];
        	this.rowHideCols[tmpList[i]] = tmp;
        }

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
     //alert(this.CurRow);
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
//根据列名和index设置title
function TableRowSet_setTitle(colName,aTitle){
  var index = this.getColIndex(colName);
  this.setTitleByIndex(index,aTitle);
}

function TableRowSet_setTitleByIndex(index,aTitle){
  if(index <0)return;
  
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
//根据列名和index获取title
function TableRowSet_getTitle(colName){
  var index = this.getColIndex(colName);
  if(index >=0){
	return this.getTitleByIndex(index);
  }
  else{
  	alert('无效的列名:' + colName);
  }
}
function TableRowSet_getTitleByIndex(index){
  if(index >=0){
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

function TableRowSet_queryModel(){
   var rowcount = this.count();
   for(var i= rowcount - 1 ;i>=0;i--)
      this.getTableObject().deleteRow(i);
   this.setStsToOld();
   this.newRow();
}
function TableRowSet_print(printTitle){
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

function TableRowSet_verify(rowIndex,colName){
  return this.getFieldType(colName).verify(this.getValue(rowIndex,colName)) ;
}
function TableRowSet_getColNames(){ return this.colNames;}

function TableRowSet_getClassName(){ return "TableRowSet";}
function TableRowSet_getTotalRowCount(){ return this.totalRowCount;}
function TableRowSet_modifyTotalRowCount(value){
   this.totalRowCount = value;
   if(	document.all("FootTable_" + this.DBGridPK + "_RowCount")){
	document.all("FootTable_" + this.DBGridPK + "_RowCount").innerText = " 共 " + this.totalRowCount +" 条 ";
   }
}

function TableRowSet_setTableBgColor(color){
  this.TableBgColor = color;
  this.DataTable.style.backgroundColor = this.TableBgColor;
}
function TableRowSet_setHeadBgColor(color){
   this.HeadTable.style.backgroundColor = color
}

function TableRowSet_setCurRowBgColor(color){
  this.CurRowBgColor = color;
  if (this.CurRow >=0){
    var obj = this.getRowObj(this.CurRow);
    if (obj)
      obj.style.backgroundColor = this.CurRowBgColor;
  }
}
function TableRowSet_setCurRowFontColor(color){
  if (this.CurRow >=0){
    var obj = this.getRowObj(this.CurRow);
      for (var i = 0;i < obj.cells.length;i ++){
    	obj.cells[i].style.color=color;
      }
  }
}
function TableRowSet_setRowBgColor(rowIndex,color){
  var obj = this.getRowObj(rowIndex);
  if (obj){
      obj.SelfBgColor = color;
      obj.style.backgroundColor = color;
  }
}
function TableRowSet_setRowFontColor(rowIndex,color){
  var obj = this.getRowObj(rowIndex);
  for (var i = 0;i < obj.cells.length;i ++){
	obj.cells[i].style.color=color;
  }
}
function TableRowSet_setCurCellBgColor(color){
  this.CurCellBgColor = color;
  var cell = this.getCell(this.CurRow,this.CurCol);
  if (cell){
    cell.style.backgroundColor = this.CurCellBgColor;
   }
}
function TableRowSet_setCurCellFontColor(color){
  var cell = this.getCell(this.CurRow,this.CurCol);
  if (cell){
    cell.style.color = color;
   }
}

function TableRowSet_setBorderColor(color){
  this.BorderColor = color;
  if (this.DataTable)
    this.DataTable.borderColor = color;
  if(this.HeadTable)
    this.HeadTable.borderColor = color;

}
function TableRowSet_setBorder(num){
    this.Border = num;
    if (this.DataTable)
      this.DataTable.border = num;
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

function TableRowSet_getRowId(rowIndex){
  var tmpRow = this.getRowObj(rowIndex);
  return tmpRow.I;
}

function TableRowSet_getNewRowDataId (){
    this.NewRowDataId = this.NewRowDataId + 1;
    return this.FieldTypeSet.getName() + '_' + this.NewRowDataId;
 }

function TableRowSet_getFieldType(colIndex){
  return  this.FieldTypeSet.getFieldByName(this.colNames[colIndex]);
}
function TableRowSet_getRow(){
   return this.CurRow;
}
function TableRowSet_getCol(){
   return this.CurCol;
}
function TableRowSet_allSelectChange(aPK){
  var isSelected = window.event.srcElement.checked;
  var parentObj = g_TableRowSetManager.get(aPK);
  parentObj.selectAll(isSelected,true);
}

function TableRowSet_selectAll(isSelected,isTriggerEvent){

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

function TableRowSet_rowSelected(rowIndex,isSelected,isTriggerEvent){
    if (this.isMutilSelect== true){

      var tmpRow = this.getRowObj(rowIndex);
      if (tmpRow){
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
    }else{
      this.setRow(rowIndex);
    }

}
function TableRowSet_isSelected(rowIndex){
    var result = false;
    if (this.isMutilSelect== true){
      var tmpRow = this.getRowObj(rowIndex);

      var colIndex =this.getMutilSelectColIndex();
      if ((tmpRow) &&(tmpRow.cells(colIndex).children(0).checked == true))
         result = true;
    }else if(this.CurRow  == rowIndex)
       result = true;

   return result;
}

function TableRowSet_setAllSelectCheckBoxSts(flag){
   this.disabledSelect(-100,!flag)
}

function TableRowSet_disabledSelect(rowIndex,flag){
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
function TableRowSet_visibleSelect(rowIndex,flag){
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


function TableRowSet_getSelectedRows(){
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
function TableRowSet_getRowHeadColCount(){
  var result =0;
  if (this.isMutilSelect == true)
     result = result+ 1;

  if (this.isRowSequence == true)
     result = result+ 1;
  return result;
}
function TableRowSet_getCurRowIndex(){
  return this.CurRow;
}
function TableRowSet_getColWidth(colIndex){
   var cell = this.HeadTable.rows(0).cells(colIndex + this.getRowHeadColCount());
   if(cell)
      return cell.width;
   else
      return -1;
}

function TableRowSet_setColWidth(colName,newWidth){
  var colIndex = this.getColIndex(colName);
  var incWidth  = newWidth - this.getColWidth(colIndex);
  for(var i=0;i< this.HeadTable.rows.length; i++){
       this.HeadTable.rows(i).cells(colIndex).width = newWidth;
   }
   this.HeadTable.width = parseInt(this.HeadTable.width) + incWidth;

   if (this.DataTable && this.DataTable.rows.length >0){
     this.DataTable.rows(0).cells(colIndex).width = newWidth;
     //for(var i=0;i< this.DataTable.rows.length; i++){
     //    this.DataTable.rows(i).cells(colIndex).width = newWidth;
     //}
     this.DataTable.width = parseInt(this.DataTable.width) + incWidth;
   }

}

function TableRowSet_setRowSts(rowIndex,sts){
   //U,O,N,D
   var tmpRow = this.getRowObj(rowIndex);
   tmpRow.Sts = sts;
}


function TableRowSet_getRowSts(rowIndex){
   var tmpRow = this.getRowObj(rowIndex);
   if ((tmpRow)&& (tmpRow.Sts))
       return tmpRow.Sts;
   else
       return "O";
}
function TableRowSet_getDeletRows(){
   return this.deleteRowPKs;
}

function TableRowSet_newRow(isScrollIntoView){
   var rowIndex =this.count();
   return this.insertRow(rowIndex,isScrollIntoView);
}

function TableRowSet_insertRow(rowIndex,isScrollIntoView){
   var noResultDiv = document.all("NoResultDiv_" + this.DBGridPK);
   if(noResultDiv != null){
      noResultDiv.style.display='none';
   }
   
   for(var i = this.count();i > rowIndex; i--){
		this.rowHideCols[i] = this.rowHideCols[i - 1]
   }
   this.rowHideCols[rowIndex] = null;	
   var tmpRow = this.getTableObject().insertRow(rowIndex);
   tmpRow.I = this.getNewRowDataId();
   tmpRow.height = this.DefaultRowHeight;
   for(var i = 0;i <  this.HeadTable.rows(0).cells.length ;i++){
        var cell = tmpRow.insertCell(-1);
        cell.className ="GD-TD";
        cell.width = this.HeadTable.rows(0).cells(i).width;
   }
   for(var i = 0;i < this.getColCount();i++){
　　 var fieldType = this.getFieldType(i);
     var aId = fieldType.getDefaultValueId();
     var aText =fieldType.getDefaultValueText();
     if(fieldType.getDefaultEditType() =="DBTree"){

          tmpRow.level = 0;
          //获得新增行的父亲行行号
          var parentIndex = this.getParentOfRow(tmpRow.rowIndex);
          //因为后续行的行号都增加了1，需要重新计算各行的儿子行数组
          this.recomputerChildRowIndex(this.getTableObject().rows.length - 1,tmpRow.rowIndex,this.getTableObject().rows.length - 1,1);
          //将当前行添加到父亲行的儿子队列中
          if(parentIndex >=0){
             var list = this.getChildList(parentIndex);
             list[list.length] = tmpRow.rowIndex;
             this.setChildList(parentIndex,list.sort());
             tmpRow.level = this.getLevel(parentIndex) + 1;
          }

        var tmpTd = this.getCell(tmpRow.rowIndex,i);
        var span = document.createElement("span");
        span.style.width = (tmpRow.level + 1) * 20;
        tmpTd.appendChild(span);
        var text = document.createElement("span");
        tmpTd.appendChild(text);
     }
     if(aId)
        this.setValue(rowIndex,this.getNameByIndex(i),aId,aText);

   }
   var mutilSelectIndex = 0;
   if(this.isRowSequence == true){
      tmpRow.cells(0).innerHTML = rowIndex + 1;
      tmpRow.cells(0).className ="GD-Seq";
      mutilSelectIndex = 1;
   }
   if(this.isMutilSelect == true){
      tmpRow.cells(mutilSelectIndex).innerHTML = " <input  type='checkbox' class='GD-S-C' AG='true'/>";
      tmpRow.cells(mutilSelectIndex).className ="GD-S";
   }

   tmpRow.Sts = "NN";

   if(this.CurRow == tmpRow.rowIndex){
      this.CurRow = this.CurRow + 1;
   }

   this.setRow(rowIndex);


   if(isScrollIntoView != false){
   	tmpRow.scrollIntoView();
   }

   this.modifyTotalRowCount(this.totalRowCount + 1);
   this.modifyRowSequence(tmpRow.rowIndex);
   TableRowSet_setHeadDivWidth(this.HeadDiv,this.TableDiv);
   return rowIndex;
}
function TableRowSet_modifyRowSequence(rowIndex){
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

function TableRowSet_getNameByIndex(colIndex){
    return this.colNames[colIndex];
}
function TableRowSet_addTotalCol(name,type){

  for(var i = 0;i < this.totalColNames.length;i++)
    if (this.totalColNames[i] == name)
      return;

  this.totalColNames[this.totalColNames.length] = (name);
  this.totalColTypes[this.totalColTypes.length] = (type);
  if (this.hasTotalRow() == false){
	   var rowIndex =this.count();
	   var tmpRow = this.getTableObject().insertRow(rowIndex);
           tmpRow.className="GD-Total-TR";
           for(var i = 0;i <  this.HeadTable.rows(0).cells.length ;i++){
                var cell = tmpRow.insertCell(-1);
                cell.className ="GD-Total-TD";
                cell.width = this.HeadTable.rows(0).cells(i).width;
           }
	   tmpRow.IsTotal = true;
	   this.m_hasTotalRow = true;
	   tmpRow.cells(   this.getRowHeadColCount()   ).innerText = "合计(" + this.count() + ")";
  }
}
function TableRowSet_setEditSts(value){
  if(!value) value = false;
  if(value && this.onlyQuery){
    alert('查询模式下不能设置表格的可编辑状态!');
    return ;
  }
  this.IsEditable = value;
}
function TableRowSet_setColEditSts(colName,value){
  if(!value) value = false;
  if(value && this.onlyQuery){
    alert('查询模式下不能设置表格的可编辑状态!');
    return ;
  }
  var index = this.getColIndex(colName);
  if (index >= 0){
    this.getFieldType(index).setAuthority(value);
  }
}
function TableRowSet_getColIndex(name){
  name = name.toUpperCase();
  var index = this.colIndexs[name];
  if(index == null)
    index = -1;
  return index;
}

function TableRowSet_setFocusByName(rowIndex,colName){
  var index = this.getColIndex(colName);
  this.setFocus(rowIndex,index);
}
function TableRowSet_setFocus(rowIndex,colIndex){
  rowIndex = parseInt(rowIndex);
  colIndex = parseInt(colIndex);
  this.tdOnFocus(rowIndex,colIndex);
}


function TableRowSet_tdOnFocus(newRowId ,newColId){
  var oldRowIndex = this.CurRow;
  var oldColIndex = this.CurCol;
  newRowId =parseInt(newRowId);
  newColId =parseInt(newColId);

  this.setCellEditable(this.CurRow,this.CurCol,false);  //清除原有控件
  var oldCell = this.getCell(this.CurRow,this.CurCol);
  if(oldCell)  oldCell.bgColor = "";


  this.currentRowChange(-1,oldRowIndex);

  this.setCellEditable(newRowId,newColId,true);

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
function TableRowSet_getColCount(){
  return this.colNames.length;
}

function TableRowSet_getVisiColCount(){
  return this.visioColCount;
}

function TableRowSet_tableFocusout(aDBGridPK){
   //var obj = window.event.srcElement;
   var parentObj = g_TableRowSetManager.get(aDBGridPK);

   if((parentObj.CurRow >=0)&&(parentObj.CurCol >=0)){
     var cell = parentObj.getCell(parentObj.CurRow,parentObj.CurCol);
     if ((cell)&&(cell.editer) && (cell.editer.getID() != cell.I)){

        //如果是第一次修改
       if(cell.isFirstModify == null || cell.isFirstModify == true){
            cell.OldI = cell.I;
      	    if(cell.Value)
                cell.OldValue = cell.Value;
         cell.isFirstModify = false;
       }

        cell.isModify = true;
        var sts = parentObj.getRowSts(parentObj.CurRow);
        if (sts =='O')
          parentObj.setRowSts(parentObj.CurRow,'U');
        else if (sts == "NN")
          parentObj.setRowSts(parentObj.CurRow,'N');
       parentObj.recomputerTotalAll();
   }
   }
}
function TableRowSet_setCellEditable(rowIndex,columnIndex,sts){

  if (!sts) sts = false;

  if ((rowIndex <0)||(rowIndex >= this.count())
      ||(columnIndex <0)||(columnIndex >= this.getColCount()))
     return;

   var cell = this.getCell(rowIndex,columnIndex);
   if ((cell)&&(sts == false)){
      if (cell.editer){
      	 var tmpId = cell.editer.getID();
         var tmpText = cell.editer.getValue();
         cell.editer = null;
         cell.innerText = "";
         this.setValue(rowIndex,this.getNameByIndex(columnIndex),tmpId,tmpText,true);

         //如果rowheight=-1，当所有单元格的内容为空时则高度会变成0 ，
         //这里就是当出现这种状况时设置TR高度
         if(this.TableRowSetDiv.RowHeight==-1){
         	var tr = cell.parentNode;
			var blank = true;
			for(k=0; k<tr.cells.length;k++){
				if(tr.cells(k).innerText!=''){
					blank=false;
					break;
				}
			}
			if(blank)tr.height=this.DefaultRowHeight;
         }
      }
   }else if((cell)&&(sts == true)&&(this.isCellEditable(rowIndex,columnIndex))){
       if (!cell.editer){//原来有editer就不用重新设置
         var tmpId = cell.innerText;
         var tmpText = "";
         if(cell.I){
            var tmpId = cell.I;
            var tmpText = cell.innerText;
         }
         var editer = this.getEditer(rowIndex,columnIndex,tmpId,tmpText);
         if (editer){

         	var cellWidth = this.getColWidth(columnIndex);//获取当前CELL的高度
                var cellHeight = cell.parentNode.clientHeight; //获取当前CELL的高度

	         cell.innerText = "";
	         cell.I = tmpId;
             	 cell.Value = tmpText;
	         cell.editer = editer;
	         var TmpUIObject = editer;
	         if (editer.UIObject)
	           TmpUIObject = editer.UIObject;

			var objHeight = this.DefaultRowHeight;
			if('DBTextArea'==this.getFieldType(columnIndex).DefaultEditType){
				objHeight = cellHeight;
			}
			/**
			 * 如果用户在tag中没有配置rowHeight，或者配置了rowHeight并且该值大于0，
			 * 则创建的textarea按表格的实际高度；如果用户配置的rowHeight=-1的话，
			 * 如果当前行的实际高度小于this.DefaultTextareaHeight,则按照
			 * this.DefaultTextareaHeight,否则按照实际高度创建。
			 */
			if(('DBTextArea'==this.getFieldType(columnIndex).DefaultEditType)
				&& (this.TableRowSetDiv.RowHeight==-1)){

				if(this.DefaultTextareaHeight>cellHeight)
					objHeight = this.DefaultTextareaHeight;
				else
					objHeight = cellHeight;

				TmpUIObject.onfocus=function(){
					//点击的时候去除滚动条
					if((this.style.pixelHeight<this.scrollHeight+10)){
						this.style.pixelHeight =this.scrollHeight+10;
					}
					//如果TR有设置高度则必须清空，否则表格的高度不会自动增长
					if(this.parentNode.parentNode.height!=''){
						this.parentNode.parentNode.height='';
					}
				}
				//当出现滚动条的时候加高高度
				TmpUIObject.onscroll=function(){
					this.style.pixelHeight =(this.style.pixelHeight-0) + 20;
				};
			}

            if(TmpUIObject.setRect){
               TmpUIObject.setRect(cellWidth - 3,objHeight - 3);
             }else{
	         	TmpUIObject.runtimeStyle.height = (objHeight - 3) +"px";
				TmpUIObject.runtimeStyle.width = cellWidth - 3;
             }
	         cell.appendChild(TmpUIObject);

	         TmpUIObject.setValue(tmpId,tmpText);
	         TmpUIObject.focus();
                 if(TmpUIObject.UIType == "DBEdit" || TmpUIObject.UIType == "DBTextArea"
                 	|| TmpUIObject.UIType == "DBPassword" || TmpUIObject.UIType == "DBDate"
                        || TmpUIObject.UIType == "DBDateTime"  ){
                      TmpUIObject.select();
                 }
         }
       }
   }else{
     cell.editer = null;
   }

}

function TableRowSet_setRowEditSts(rowIndex,value){
   var tmpRow = this.getRowObj(rowIndex);
   if(tmpRow)
   tmpRow.roweditable = value;
}

function TableRowSet_getRowEditSts(rowIndex){
   var tmpRow = this.getRowObj(rowIndex);
   if (!tmpRow)
     return false;

   if(tmpRow.roweditable == false || tmpRow.roweditable == "false")
        return false;

   return true;
}


function TableRowSet_setCellEditSts(rowIndex,colName,value){
  if(!value) value = false;
  var colIndex = this.getColIndex(colName);

  this.canModfiyCells[rowIndex +"-" + colIndex] = value;
}

function TableRowSet_isCellEditable(rowIndex,colIndex){
   if((rowIndex <0) ||(rowIndex >= this.count())||(colIndex <0)||(colIndex >=this.getColCount()))
     return false;

   var rowEditable = this.getRowEditSts(rowIndex);

   //获得单元格的编辑状态
   var tmpCellEditSts = this.canModfiyCells[rowIndex +"-" + colIndex];
   if(tmpCellEditSts == null){
     tmpCellEditSts = true;
    }
   return  this.IsEditable && rowEditable && tmpCellEditSts && this.getFieldType(colIndex).getAuthority() && this.permissionCanModifyCols[colIndex];
}

function TableRowSet_currentRowChange(newRowIndex,oldRowIndex){
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
        //alert(tmpRow.runtimeStyle.className);
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
      if (tmpCell){
        tmpCell.className="GD-CurrentCell";
        if(this.CurCellBgColor)
           tmpCell.bgColor = this.CurCellBgColor;
      }
  }
}
function TableRowSet_getRowObj(rowIndex){
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
function TableRowSet_getStartRowIndex(){
  return 0;
}
function TableRowSet_getEndRowIndex(){
  return this.count() - 1;
}

function TableRowSet_setRow(rowIndex){
  this.tdOnFocus(rowIndex,this.CurCol);
}
function  TableRowSet_removeDeleteRow(pk){
  var i = 0;
  var pkColIndex = this.getColIndex(this.pkName);
  for( i = 0; i < this.deleteRows.length;i++){
    if(this.getValueFromCell(this.deleteRows[i][pkColIndex]) == pk)
      break;
  }
  for(var j = i; j < this.deleteRows.length - 1 ;j++)
    this.deleteRows[j] = this.deleteRows[j - 1];

  var result = false;
  if(i < this.deleteRows.length){
    this.deleteRows.length = this.deleteRows.length - 1;
    result = true;
  }
  return result;
}

function  TableRowSet_clear(){
   for(var rowIndex = this.count()- 1;rowIndex>=0;rowIndex--)
      this.getTableObject().deleteRow(rowIndex);

   this.setStsToOld();
   this.currentRowChange(-1,-1);
   this.recomputerTotalAll();
   this.modifyTotalRowCount(0);
   this.resetFootInfo();
}
function TableRowSet_resetFootInfo(){
    if(	document.all("FootTable_" + this.DBGridPK)){
        var item = document.all["FootTable_"+this.DBGridPK];
        if(item.children.length>0){
            var tbody = item.childNodes[0];
            var rows = tbody.children;
            var tro = rows[0];
            var pageinfotd = tro.childNodes[tro.children.length-1];
            if(pageinfotd && pageinfotd.children.length==1){
                pageinfotd.childNodes[0].innerText="共1页 0条";
            }else if(pageinfotd && pageinfotd.children.length>1){
                pageinfotd.childNodes[0].innerText="共1页 0条";
                if(document.all("TableRowSet_" + this.DBGridPK + "_goToPage")){
                   document.all("TableRowSet_" + this.DBGridPK + "_goToPage").value = 1;
                }
            }
        }

    }
}
function  TableRowSet_deleteRow(rowIndex){
   if(rowIndex == null)
     rowIndex = this.CurRow;

   if ((rowIndex >=0) && (rowIndex < this.count())){
      var sts = this.getRowSts(rowIndex);
      if((sts!='NN')&& (sts!='N')){
        var tmpRow = new Array();
        tmpRow.I = this.getRowId(rowIndex);
        var tmpCell;
        for(var i=0;i<this.getColCount();i++){
           tmpCell = new TableRowSet_VCell();
           this.copyCell(this.getCell(rowIndex,i),tmpCell);
           tmpRow[tmpRow.length] = (tmpCell);
        }
        this.deleteRows[this.deleteRows.length] = (tmpRow);
      }
      for(var i = rowIndex ;i < this.count() - 1; i++){
           this.rowHideCols[i] = this.rowHideCols[i + 1]
      }
      this.rowHideCols[this.count() - 1] = null;

      //如果是删除第一行，需求将后续的一行的单元格的属性进行设置 qianghui 20060428
      var dataTable = this.getTableObject();
      if(rowIndex ==0 &&  dataTable.rows.length >1){
           for(var i = 0;i <  this.HeadTable.rows(0).cells.length ;i++){
               dataTable.rows(1).cells(i).width = this.HeadTable.rows(0).cells(i).width;
           }
      }

      //如果有儿子节点，将儿子节点的父亲设置为自己的父亲
      //同时将后面的节点索引减1
      var tmpChildList = this.getChildList(rowIndex);
      var tmpParentRowIndex = this.getParentOfRow(rowIndex);
      for(var i= tmpChildList.length-1 ;i>=0;i--){
          this.setParent(tmpChildList[i],tmpParentRowIndex);
      }
      if(this.DBTreeColName){
         //没有指定DBTree的列
         this.setParent(rowIndex,-1);
      }
      this.recomputerChildRowIndex(this.getTableObject().rows.length - 1,rowIndex,this.getTableObject().rows.length - 1,-1);

      this.getTableObject().deleteRow(rowIndex);

      if ( this.CurRow > rowIndex)
           this.CurRow  = this.CurRow - 1;
      else if( this.CurRow == rowIndex){
          if(this.CurRow == this.count())
              this.setRow(this.CurRow - 1);
      }
   }

   this.currentRowChange(this.CurRow,-1);
   this.recomputerTotalAll();

   this.modifyTotalRowCount(this.totalRowCount - 1);
   this.modifyRowSequence(rowIndex);

   //hexg ,20060903,更新headdiv的长度
   TableRowSet_setHeadDivWidth(this.HeadDiv,this.TableDiv);

}

function TableRowSet_resize(width, height) {
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

     //this.HeadDiv.style.width = width - 17;

     this.TableDiv.style.width = width;
     this.FootDiv.style.width = width;
     this.FootTable.style.width = width;
     //this.HeadTable.style.width = width;
     //this.DataTable.style.width = width;
    }else{
      width = this.HeadAndTableDiv.style.width;
    }
   if (height != "" && height != "-1") {
     height = parseInt(height);
     this.TableDiv.style.height = height;
   }else{
     height = this.TableDiv.style.height;
   }
   if(this.OnResize){
     this.OnResize(oldWidth,oldHeight,width,height);
   }

   //hexg
   this.currentWidth = width;
   this.currentHeight = height;

     //hexg ,20060903,更新headdiv的长度
     TableRowSet_setHeadDivWidth(this.HeadDiv,this.TableDiv);
   return true;
  }catch(e){
    alert(e + this.OnResize);
    return false;
  }


}


function TableRowSet_OnDBLink(aGridPK,aColName,aId){
  var parentObj = g_TableRowSetManager.get(aGridPK);
  if(parentObj.OnDBLink){
  	  TableRowSet_OnClick(aGridPK);
      parentObj.OnDBLink(aColName,aId);
  }
}

function TableRowSet_OnFocusOut(aGridPK){
    var parentObj = g_TableRowSetManager.get(aGridPK);
    if(parentObj.CurRow < 0 || parentObj.CurCol < 0){
       return;
    }
    var cell = parentObj.getCell(parentObj.CurRow,parentObj.CurCol);
    if (cell && cell.editer){
       //注释条件判断,否则当iframe中焦点失去时,会导致toElement为null,而无法触发onvalchange事件
       //if(window.event.toElement){
          var colName =parentObj.getNameByIndex(parentObj.CurCol);
          var tmpId = parentObj.getValue(parentObj.CurRow,colName);
          parentObj.setValue(parentObj.CurRow,colName,tmpId,"",true,true);
       //}
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
  }else if(obj.tagName =="INPUT" && obj.DBTreeExtend){//树节点的扩展
     var rowid = parseInt(obj.parentNode.parentNode.rowIndex);
     var colid = parseInt(obj.parentNode.cellIndex) - parentObj.getRowHeadColCount();
     //parentObj.tdOnFocus(rowid,colid);
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
function TableRowSet_OnDbClick(aGridPK){
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

function TableRowSet_DoContextMenu(aGridPK ,bOnFocus){
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

function TableRowSet_getTableObject(){
       return this.DataTable;
  }

function TableRowSet_hasTotalRow(){
    return this.m_hasTotalRow;
}
function TableRowSet_count(){
    if (this.hasTotalRow() == true)
        return this.getTableObject().rows.length - 1;
    else
        return this.getTableObject().rows.length;
  }

function TableRowSet_realcount(){
        return this.getTableObject().rows.length;
  }

function TableRowSet_getCellByName(index,name){
   var colIndex = this.getColIndex(name);
   var cell = this.getCell(index,colIndex);
   return cell;
  }

function TableRowSet_getCell(rowIndex,colIndex){

   var tmpRow = this.getRowObj(rowIndex);


   if (tmpRow == null)
     return null;
   if((colIndex == null)||(colIndex<0)||(colIndex >= this.getColCount()))
      return null;
   if (this.colIsHide[colIndex] ==false ){
        return tmpRow.cells(colIndex +   this.getRowHeadColCount());
   }
   else  {//获取隐藏的虚拟单元
     if(this.rowHideCols[rowIndex] ==  null){   //从数据Row的属性中提取隐藏列数据
        this.rowHideCols[rowIndex] =  new Array();
        for(var i= this.visioColCount;i< this.getColCount();i++){
          this.rowHideCols[rowIndex][i - this.visioColCount]  = new  TableRowSet_VCell();

          var tmpID = "";
          eval(" tmpID = tmpRow." + this.colNames[i]);

          //如果是属性中包含&nbsp;的话，则IE会将其转换成字节码为160的字符,16进制为A0
          var str_160 = String.fromCharCode(160);
          if(tmpID!=null && tmpID.indexOf(str_160)>-1){
          	tmpID = tmpID.replace(/\xA0/g,' ');
          	eval("tmpRow." + this.colNames[i] + " = tmpID");
          }

          var tmpText = "";
          eval(" tmpText = tmpRow." + this.colNames[i] +"_DISPLAY");
          if(!tmpText){
             this.rowHideCols[rowIndex][i - this.visioColCount ].innerText = tmpID;
          }else{
             this.rowHideCols[rowIndex][i - this.visioColCount ].innerText = tmpText;
             this.rowHideCols[rowIndex][i - this.visioColCount ].I = tmpID;
          }
       }
     }

     return this.rowHideCols[rowIndex][ colIndex - this.visioColCount];
   }

  }


function TableRowSet_setValue(index,name,aId,aDisplayText,isEditer,isFocusOut,isTrigerEvent){

	//默认触发值改变事件
	if (isTrigerEvent == null){
		isTrigerEvent = true;
	}
    var tmpColIndex = this.getColIndex(name);
    if(tmpColIndex >=0 && this.permissionMaskCols[tmpColIndex]){
        aDisplayText = this.MO_MASK_STRING;
    }

    if(!isEditer) isEditer = false;
    if(!isFocusOut) isFocusOut = false;

    var cell = this.getCellByName(index,name);
    if (!cell) return false;

    var editType = this.FieldTypeSet.getFieldByName(name).DefaultEditType;


//新增对失去焦点的处理，墙辉 2006-04-23
    if(isFocusOut==true){
    	if (aId == cell.I){
    	   return false;
        }
       if(cell.isFirstModify == null || cell.isFirstModify == true){
            cell.OldI = cell.I;
      	    if(cell.Value)
                cell.OldValue = cell.Value;
         cell.isFirstModify = false;
       }
       cell.I = aId;
       cell.isModify = true;

    }else if(cell.editer){
    	if (aId == cell.editer.getID())
    	   return false;
    	else{
           cell.editer.setValue(aId,aDisplayText);
           cell.isModify = true;
    	}
    }else if(isEditer == true){
    	if (aId == cell.I){
           if(!aDisplayText)
              cell.innerText = aId;
           else
              cell.innerText = aDisplayText;

           if(editType == this.DBHTML){
              cell.innerHTML = cell.innerText;
           }
           if(editType == this.DBTree){
                var tmpRow = this.getRowObj(index);
                var tmpStr =cell.innerText;
                cell.innerText ="";
                var span = document.createElement("span");
                var childRows = this.getChildList(index);
                if(childRows.length ==0 )
                   span.style.width = ( parseInt(tmpRow.level) + 1) * 20;
                else
                   span.style.width = parseInt(tmpRow.level) * 20;

                cell.appendChild(span);
                if(childRows.length >0){
                  var button =document.createElement("<input type='button' onfocus='this.blur()' class='TABLE_TREE_BUTTON'/>");
                  button.DBTreeExtend='true';
                  button.style.width =20;
                  button.style.height =18;
                  if(this.getIsOpen(index)== true)
                    button.value = "-";
                  else
                    button.value="+";
                  cell.appendChild(button);
                }

                var text = document.createElement("span");
                text.innerText = tmpStr;
                cell.appendChild(text);
                //alert(cell.outerHTML);
           }

    	   return false;
        }
        //如果是第一次修改
       if(cell.isFirstModify == null || cell.isFirstModify == true){
            cell.OldI = cell.I;
      	    if(cell.Value)
                cell.OldValue = cell.Value;
         cell.isFirstModify = false;
       }
        if (aDisplayText){
           cell.innerText = aDisplayText;
           cell.I = aId;
        }else{
           cell.innerText = aId;
           cell.I = null;
        }
        if(editType == this.DBHTML){
            cell.innerHTML = cell.innerText;
        }
           if(editType == this.DBTree){
                var tmpRow = this.getRowObj(index);
                var tmpStr =cell.innerText;
                cell.innerText ="";
                var span = document.createElement("span");
                var childRows = this.getChildList(index);
                if(childRows.length ==0 )
                   span.style.width = ( parseInt(tmpRow.level) + 1) * 20;
                else
                   span.style.width = parseInt(tmpRow.level) * 20;

                cell.appendChild(span);
                if(childRows.length >0){
                  var button =document.createElement("<input type='button' onfocus='this.blur()' class='TABLE_TREE_BUTTON'/>/>");
                  button.DBTreeExtend='true';
                  button.style.width =20;
                  button.style.height =18;
                  if(this.getIsOpen(index)== true)
                    button.value = "-";
                  else
                    button.value="+";
                  cell.appendChild(button);
                }

                var text = document.createElement("span");
                text.innerText = tmpStr;
                cell.appendChild(text);
            }
        cell.isModify = true;
    }else{//在通过函数设置时，将不进行是否真的修改判断，因为有时需要如此
        //第一次设置
　　　　 var fieldType = this.getFieldType(this.getColIndex(name));
        if(this.ListDataSource && fieldType.ListDataSourceName){ //有下拉数据选择
        　　aDisplayText = fieldType.getListDataTextById(this.ListDataSource,aId);
        }
        if(cell.isFirstModify == null || cell.isFirstModify == true){
          if(cell.I){
            cell.OldI = cell.I;
            cell.OldValue = cell.innerText;
          }else{
            cell.OldI = cell.innerText;
            cell.OldValue = "";
          }
         cell.isFirstModify = false;
        }

        if (aDisplayText){
           cell.innerText = aDisplayText;
           cell.I = aId;
        }else{
           cell.innerText = aId;
           cell.I = "";
        }
        if(editType == this.DBHTML){
           cell.innerHTML = cell.innerText;
        }
           if(editType == this.DBTree){
                var tmpRow = this.getRowObj(index);
                var tmpStr =cell.innerText;
                cell.innerText ="";
                var span = document.createElement("span");
                var childRows = this.getChildList(index);
                if(childRows.length ==0 )
                   span.style.width = ( parseInt(tmpRow.level) + 1) * 20;
                else
                   span.style.width = parseInt(tmpRow.level) * 20;

                cell.appendChild(span);
                if(childRows.length >0){
                  var button =document.createElement("<input type='button' onfocus='this.blur()' class='TABLE_TREE_BUTTON'/>");
                  button.DBTreeExtend='true';
                  button.style.width =20;
                  button.style.height =18;
                  if(this.getIsOpen(index)== true)
                    button.value = "-";
                  else
                    button.value="+";
                  cell.appendChild(button);
                }
                var text = document.createElement("span");
                text.innerText = tmpStr;
                cell.appendChild(text);
           }


        cell.isModify = true;
    }

    for(var i = 0; i< this.totalColNames.length;i++){
      if(name == this.totalColNames[i]){
        this.recomputerTotal(name,this.totalColTypes[i]);
        break;
      }
    }
    var sts = this.getRowSts(index);
    if (sts =='O')
       this.setRowSts(index,'U');
    else if (sts == "NN"){
       this.setRowSts(index,'N');
    }
    if (isTrigerEvent == true && this.OnValueChange)
       this.OnValueChange(index,name,this.getOldValueFromCell(cell),this.getValueFromCell(cell));
    return true;
}

function TableRowSet_getCellStsFromCell(cell){
    if(!cell)   return "O";
    var OldId = this.getOldValueFromCell(cell);
    var NewId = this.getValueFromCell(cell);
    //alert("{" + OldId + "}{"+NewId+"}{" + cell.isModify +"}");
    if (!cell.isModify){//没有修改
       if ((!OldId)&&(!NewId)) return "NN";
       else if ((!OldId)&&(NewId)) return "O";
       else  alert("系统状态判断失败!");
    }else{
       if ((OldId)&&(!NewId)) return "D";
       else if ((OldId)&&(NewId)) return "U";
       else if ((!OldId)&&(NewId)) return "N";
       else if ((!OldId)&&(!NewId)) return "O";
       else  alert("系统状态判断失败!");
    }
}
function TableRowSet_getCellSts(index,name){
    var cell = this.getCellByName(index,name);
    return this.getCellStsFromCell(cell);
}

function TableRowSet_getDisplayText(index,name){
    var cell = this.getCellByName(index,name);
    var editType = this.FieldTypeSet.getFieldByName(name).DefaultEditType;
    return this.getDisplayTextFromCell(cell,editType);
}
function TableRowSet_getDisplayTextFromCell(cell,editType){
   if(!cell)
       return "";
    if (cell.editer)
        return cell.editer.getValue();
    if(editType == this.DBHTML)
      return cell.innerHTML;
    else if(editType == this.DBTree){
      return cell.childNodes(cell.childNodes.length -1).innerText;
    }else
      return cell.innerText;
}
function TableRowSet_getValuePrivate(index,name){
  return this.getValue(index,name);
}

function TableRowSet_getValue(index,name){
    name = name.toUpperCase();
    var cell = this.getCellByName(index,name);
    var editType = this.FieldTypeSet.getFieldByName(name).DefaultEditType;
    return this.getValueFromCell(cell,editType);
}
function TableRowSet_getValueFromCell(cell,editType){
    if(!cell)
       return "";
    if (cell.editer)
       return cell.editer.getID();
    if (cell.I)
      return cell.I;
    else{
      if(editType == this.DBHTML)
        return cell.innerHTML;
      else if(editType == this.DBTree){
        return cell.childNodes(cell.childNodes.length -1).innerText;
      }else
        return cell.innerText;
    }
}
function TableRowSet_getOldValue(index,name){
    var cell = this.getCellByName(index,name);
    return this.getOldValueFromCell(cell);
}
function TableRowSet_getOldValueFromCell(cell){
    if(!cell)   return "";
    if(cell.OldI) return cell.OldI;
    if(cell.OldValue) return cell.OldValue;
    return "";
}

function TableRowSet_getOldDisplayText(index,name){
    var cell = this.getCellByName(index,name);
    return this.getOldDisplayTextFromCell(cell);
}
function TableRowSet_getOldDisplayTextFromCell(cell){
    if(!cell)   return "";
    if(cell.OldValue) return cell.OldValue;
    if(cell.OldI) return cell.OldI;
    return "";
}

function TableRowSet_recomputerTotalAll(){
 for(var i = 0; i< this.totalColNames.length;i++)
          this.recomputerTotal(this.totalColNames[i],this.totalColTypes[i]);
 if(this.hasTotalRow() == true){
     var cell =  this.getCell(this.count(),0);
     cell.innerText = "合计(" + this.count() + ")";
 }
}
function TableRowSet_recomputerTotal(name,type){
       var total = 0;
       for(var i=0;i<this.count();i++){
       	 var tValue = this.getValue(i,name);
       	 if (!tValue)
       	    tValue = 0;
       	 if ((type == "Double")|| (type == "Float"))
       	    total = total + parseFloat(tValue);
       	 else
       	    total = total + parseInt(tValue);
       }
       if (total == 0)
         total ="0";

       var cell = this.getCellByName(this.count(),name);
       cell.innerText = total;
}

function TableRowSet_TableDivScroll(headDivName){
     var obj = window.event.srcElement;
     //更新滚动条
     var head_div = document.all(headDivName);
     TableRowSet_setHeadDivWidth(head_div,obj);
     head_div.scrollLeft = obj.scrollLeft;
}

function  TableRowSet_setStsToOld(){
  this.deleteRows.length=0;
  for(var i=0;i<this.count();i++){
    var sts = this.getRowSts(i);
    if ((sts == "N")||(sts =="U") ){
       var row = this.getRowObj(i);
       row.Sts = "O";
       for(var j=0;j< this.getColCount();j++){
          var cell = this.getCell(i,j);
          cell.OldI = null;
          cell.OldValue = null;
          cell.isModify = false;
          cell.isFirstModify = true;
       }
     }
  }
}

//将制定行的数据打包
function  TableRowSet_toXmlStringOfSelects(colnames,isIncludeDisplayAttr){
   return this.toXmlStringOfRows(this.getSelectedRows(),colnames,isIncludeDisplayAttr);
}

function  TableRowSet_toXmlStringOfRows(aRows,colnames,isIncludeDisplayAttr){
     var result = new Array();

     var colIndexs = new Array();
     if(colnames == null || colnames.length == 0){
         for(var i=0;i< this.getColCount();i++){
           colIndexs[i] = i;
         }
     }else{
       var tmpNames = colnames.split(",");
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

     return "<RowSet Name='" + this.FieldTypeSet.getName() + "' FullName='" +  this.FieldTypeSet.getFullName() + "' "
            + " Sts='U'>"
            + result.join("")
            + "</RowSet>";
}

//modify by qianghui 2004/09/03 add parameter isOnlySendModifyData
//modify by qianghui 20050704 add parameter colnames(保存指定的列到后台，列名称数组)
function  TableRowSet_toXmlString(isOnlySendModifyData,colnames,isIncludeDisplayAttr){
    TableRowSet_tableFocusout(this.DBGridPK);
     var result = new Array();
     var colIndexs = new Array();
     if(colnames == null || colnames.length == 0){
         for(var i=0;i< this.getColCount();i++){
           colIndexs[i] = i;
         }
     }else{
       var tmpNames = colnames.split(",");
       for(var i=0;i<tmpNames.length;i++){
          colIndexs[i] = this.getColIndex(tmpNames[i]);
       }
     }


     for(var i=0;i<this.count();i++){
         var s= this.toXmlStringRow(i,isOnlySendModifyData,colIndexs,isIncludeDisplayAttr);
         if(s.length >0)
            result[result.length] = (s);
     }

     for(var i=0;i<this.deleteRows.length;i++){
         var s = this.toXmlStringDeleteRow(i,colIndexs,isIncludeDisplayAttr);
         if(s.length >0)
           result[result.length] = (s);
     }

     if(result.length ==0)
       return "";


     return "<RowSet Name='" + this.FieldTypeSet.getName() + "' FullName='" +  this.FieldTypeSet.getFullName() + "' "
            + " Sts='U'>"
            + result.join("")
            + "</RowSet>";

}

function TableRowSet_toXmlStringDeleteRow(rowIndex,colIndexs,isIncludeDisplayAttr){
     var sts = "D";
     var result = new Array();
     result[result.length] = ("<Row ID='" + this.deleteRows[rowIndex].I + "' Sts='" + sts + "'>");
     for(var i=0;i< colIndexs.length;i++){
        result[result.length] =
          this.toXmlStringCell(this.deleteRows[rowIndex][colIndexs[i]],this.getNameByIndex(colIndexs[i]),isIncludeDisplayAttr);
     }
     result[result.length] = ("</Row>");
     return result.join("");
}

//modify by qianghui 2004/09/03 add parameter isOnlySendModifyData

function TableRowSet_toXmlStringRow(rowIndex,isOnlySendModifyData,colIndexs,isIncludeDisplayAttr){

   if(isOnlySendModifyData == null) isOnlySendModifyData = true;

   var sts = this.getRowSts(rowIndex);
    if ((isOnlySendModifyData == true) &&((sts == "O")||(sts =="NN")))
       return "";
     var result = new Array();
     result[result.length] = ("<Row ID='" + this.getRowId(rowIndex) + "' Sts='" + sts + "'>");

     for(var i=0;i< colIndexs.length;i++){
        result[result.length] = this.toXmlStringCell(
        	this.getCell(rowIndex,colIndexs[i]),this.getNameByIndex(colIndexs[i]),isIncludeDisplayAttr);
     }
     result[result.length] = ("</Row>");
     return result.join("");
}

function TableRowSet_toXmlStringCell(cell,name,isIncludeDisplayAttr){
  var sts = this.getCellStsFromCell(cell);
  if (sts =="NN") return "";
  var xmlStr = "<Col Name='" +  name + "'"
             + " Sts='" + sts + "'";

  var OldId = this.getOldValueFromCell(cell);

  var OldText = this.getOldDisplayTextFromCell(cell);

  var NewId = this.getValueFromCell(cell);
  var NewText = this.getDisplayTextFromCell(cell);

  //如果不需要显示属性
  if(isIncludeDisplayAttr == false){
     OldText = "";
     NewText = "";
  }

  if(OldId == OldText)
    OldText = "";
  if(NewId == NewText)
    NewText = "";
 if (sts =="O"){
      if (NewId)
         xmlStr += " OldID='" + TableRowSet_checkAndTrans(NewId) + "'";
      if (NewText)
         xmlStr += " OldText ='" + TableRowSet_checkAndTrans(NewText) +"' ";
      xmlStr = xmlStr + "/>"
 }else{
      if (OldId)
         xmlStr += " OldID='" + TableRowSet_checkAndTrans(OldId) + "'";
      if (OldText)
         xmlStr += " OldText ='" + TableRowSet_checkAndTrans(OldText) +"' ";

       if(NewId){
       		//hexg
       		var str = TableRowSet_checkAndTrans(NewId);
			if('DBTextArea'==this.FieldTypeSet.getFieldByName(name).DefaultEditType){
	       		str = str.replace(/\x0d\x0a/g,'@~');
	       	}
         	xmlStr += " ID ='" + str +"' ";
		}


       if (NewText){
         NewText = TableRowSet_checkAndTrans(NewText);
          if(NewText.replace(" ","").length ==0){
             xmlStr =xmlStr+ " NewText=\"" + NewText + "\"/>";
          }else
	     xmlStr = xmlStr +">"+ NewText  + "</Col>";
       }else
          xmlStr = xmlStr + "/>"
 }
   return xmlStr;

}

function TableRowSet_clearListBox(fieldName){
  var listDataSourceName = this.FieldTypeSet.getFieldByName(fieldName).ListDataSourceName;
  var source = this.ListDataSource.find(listDataSourceName);
  source.clear();
}

function TableRowSet_copyCell(sourceCell,destCell){
  if(sourceCell.I)  destCell.I = sourceCell.I;
  if (sourceCell.OldI)  destCell.OldI = sourceCell.OldI;
  if (sourceCell.OldValue)  destCell.OldValue = sourceCell.OldValue;
  if (sourceCell.Value)  destCell.Value = sourceCell.Value;
  if (sourceCell.innerText)  destCell.innerText = sourceCell.innerText;
  if (sourceCell.isModify)  destCell.isModify = sourceCell.isModify;
  if (sourceCell.isFirstModify)  destCell.isFirstModify = sourceCell.isFirstModify;

}

function TableRowSet_getEditer(rowIndex,colIndex,aId,aDisplayText){
   var fieldType = this.getFieldType(colIndex);
   return fieldType.getEditer(this,rowIndex,this.ListDataSource,aId,aDisplayText);
}


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
	

  //在翻页和刷新后信息会丢失，需要重新进行设置
　  var tmpOnBeforeTurnPage =  parentObj.OnBeforeTurnPage;
　  var tmpOnAfterTurnPage  =  parentObj.OnAfterTurnPage;
    var tmpOnRowSelected = parentObj.OnRowSelected;
    //g_TableRowSetManager.remove(aGridPK);


	parentObj.recordTableInfo();
	parentDiv.innerHTML = xmlNode.text;
	g_TableRowSetManager.reinitial(aGridPK);
	parentObj.restoreTableInfo();

      g_TableRowSetManager.get(aGridPK).OnBeforeTurnPage = tmpOnBeforeTurnPage;
      g_TableRowSetManager.get(aGridPK).OnAfterTurnPage = tmpOnAfterTurnPage;
      g_TableRowSetManager.get(aGridPK).OnRowSelected = tmpOnRowSelected;
	
	  if(tmpOnAfterTurnPage){
	      g_TableRowSetManager.get(aGridPK).OnAfterTurnPage(pageIndex);
	  }

}

function  TableRowSet_getServerPK(){
  var parentDiv = document.all("TableRowSet_ParentDiv_"+ this.DBGridPK);
  return parentDiv.PK;
 }

function TableRowSet_refresh(aCondition,parameter,qryset,isShowErrMsg){
  return this.refreshByDefineQeruy(null,aCondition,parameter,qryset,isShowErrMsg);
}
function TableRowSet_refreshForObd(parameters,qryset,aCondition,isShowErrMsg){
  return this.refresh(aCondition,parameters,qryset,isShowErrMsg);
}
function TableRowSet_refreshByDefineQeruy(queryid,aCondition,parameter,qryset,isShowErrMsg){
  this.recordTableInfo();
  var obj= TableRowSet_refreshLast(this.DBGridPK,aCondition,parameter,qryset,queryid,isShowErrMsg);
  this.restoreTableInfo();
  return obj;
}
function TableRowSet_refreshData(aGridPK,aCondition,parameter,qryset,queryid,isShowErrMsg,qrysetXmlFlag){
  return TableRowSet_refreshLast(aGridPK,aCondition,parameter,qryset,queryid,isShowErrMsg,qrysetXmlFlag);
}
function TableRowSet_refreshLast(aGridPK,aCondition,parameter,qryset,queryid,isShowErrMsg,qrysetXmlFlag){
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
     }
   	 else{
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
   
	//STable刷新
	if(parentDiv.isSTable != null && parentDiv.isSTable !=""){
	   xmlNode = g_TableRowSetManager.get(aGridPK).s_refresh(tUrl,tmpstr);
	}
	else {
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

  //在翻页和刷新后信息会丢失，需要重新进行设置

  var tmpOnBeforeTurnPage ="";
  var tmpOnAfterTurnPage = "";
  var tmpOnRowSelected = "";
  if( g_TableRowSetManager.get(aGridPK)){
　   tmpOnBeforeTurnPage =  g_TableRowSetManager.get(aGridPK).OnBeforeTurnPage;
　   tmpOnAfterTurnPage =  g_TableRowSetManager.get(aGridPK).OnAfterTurnPage;
    tmpOnRowSelected = g_TableRowSetManager.get(aGridPK).OnRowSelected;
  }
  
   //g_TableRowSetManager.remove(aGridPK);
  parentDiv.innerHTML = xmlNode.text;
  g_TableRowSetManager.reinitial(aGridPK);

  if( g_TableRowSetManager.get(aGridPK)){
    g_TableRowSetManager.get(aGridPK).OnBeforeTurnPage = tmpOnBeforeTurnPage;
    g_TableRowSetManager.get(aGridPK).OnAfterTurnPage = tmpOnAfterTurnPage;
    g_TableRowSetManager.get(aGridPK).OnRowSelected = tmpOnRowSelected;
  }
  //没有任何错误信息，返回一个null；
  return null;
}


function TableRowSet_setPageSize(aPageSize){
  var parentDiv = document.all("TableRowSet_ParentDiv_"+ this.DBGridPK);
  var pk = parentDiv.PK;
  var tUrl = _gModuleName + "/gridturnpage?action=setpagesize&pk=" + pk +"&pagesize=" + aPageSize;
  PostInfotoServer(tUrl,"");
}
function TableRowSet_toExcelUrl(filename ,onlyCurrentPageData ,useCurrentTitle,eachCount,userZipFormat){
  //判断是否只取当前页面
  var pageIndex = -1;
  if(onlyCurrentPageData!=null && (onlyCurrentPageData =='true' || onlyCurrentPageData ==true)){
    pageIndex = this.currPage;
    if(pageIndex==null || pageIndex=='') 
      pageIndex=-1;
  }
  
  if(useCurrentTitle==null)useCurrentTitle =false;
  
  if(eachCount == null) eachCount = -1;
  
  var parentDiv = document.all("TableRowSet_ParentDiv_"+ this.DBGridPK);
  var pk = parentDiv.PK;
  var viColsWidth = '';
  //获取当前表格的所有的标题
  var titles =''
  if(useCurrentTitle){
	  for(i=0;i<this.getVisiColCount();i++){
	      titles = titles + this.colNames[i]+"=";
	      titles = titles + this.getTitle(this.colNames[i]) + ";";
	      viColsWidth = viColsWidth + this.getColWidth(i) + ",";
	  }
	  if(titles==''){
	    alert('对不起,当前表格没有任何数据!');
	    return;
	  }
    titles = g_ConditonStrEncode(titles.substring(0,titles.length -1));
    viColsWidth = viColsWidth.substring(0,viColsWidth.length -1);
  }

  if(userZipFormat == null){
  	userZipFormat = false;
  }
  
  var excelOutputPK = -1;
  var tableTagInfo = document.all("TableTagInfo_" + this.DBGridPK);
  if(tableTagInfo != null && tableTagInfo.excelOutputPK !=null && tableTagInfo.excelOutputPK !=''){
  	 excelOutputPK = tableTagInfo.excelOutputPK;
  }
//  var tUrl = _gModuleName + "/gridturnpage?action=toexcel&pk=" + pk +"&excelOutputPK="+excelOutputPK
//     +"&filename=" + g_ConditonStrEncode(filename) +"&pageIndex=" + pageIndex +
//      "&columnTitle=" + titles + "&eachCount="+eachCount + "&userZipFormat="+userZipFormat;
  var tUrl =_gModuleName + "/gridturnpage?action=toexcel&pk=" + pk +"&excelOutputPK="+excelOutputPK
      +"&filename=" + g_ConditonStrEncode(filename) +"&pageIndex=" + pageIndex + "&viColsWidth" + viColsWidth +
      "&columnTitle=" + titles + "&eachCount="+eachCount + "&userZipFormat="+userZipFormat;
  
  return tUrl;
}

function  TableRowSet_VCell(){
  this.I = null;
  this.OldI = null;
  this.OldValue = null;
  this.Value = "";
  this.innerText = "";
  this.isModify = false;
  this.isFirstModify = true;
  this.toString  = function(){
    return   "this.I = " + this.I + "\n"
           + "this.OldI = " + this.OldI + "\n"
           + "this.OldValue = " + this.OldValue + "\n"
           + "this.Value = " + this.Value + "\n"
           + "this.innerText = " + this.innerText + "\n"
           + "this.isFirstModify = " + this.isFirstModify + "\n"
           + "this.isModify = " + this.isModify + "\n";
  }
}

function TableRowSet_checkAndTrans(str){
   str = str.toString();
   if(TableRowSet_checkStr(str))
     return TableRowSet_transStr(str);
   else
     return str;

}
function TableRowSet_checkStr(str)
  {

    if(str.indexOf("&")>=0||str.indexOf(">")>=0||str.indexOf("<")>=0||str.indexOf("'")>=0||str.indexOf('"')>=0)
      return true;
    else
      return false;
  }

/**
进行特殊字符替换,add by zhuwg
 */
function TableRowSet_transStr(str)
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



function TableRowSet_setChildList(rowIndex,childList){
    var rowObj =  this.getRowObj(rowIndex);
    rowObj.childArray = childList;
}
function TableRowSet_getChildList(rowIndex){
    var rowObj =  this.getRowObj(rowIndex);
    if(!rowObj)
      return new Array();
    var list = rowObj.childArray;
    if(list == null){
       list = new Array();
       if(rowObj.child_list){
          var strList = rowObj.child_list.split(',');
          for(var i=0;i<strList.length;i++)
           list[i] = parseInt(strList[i]);
       }
       rowObj.childArray = list;
    }
    return list;
}

function TableRowSet_getIsOpen(rowIndex){
  var rowObj = this.getRowObj(rowIndex);
  if(rowObj.isopen =="true")
   return true;

  return rowObj.isopen == true;
}

function TableRowSet_open(rowIndex,rowList,isSource){
    var list = this.getChildList(rowIndex);
    for(var i=0;i<list.length;i++){
       rowList[rowList.length] = list[i];
       this.getRowObj(list[i]).style.display ="block";
       //递归调用
       if(this.getIsOpen(list[i]) == true || this.getIsOpen(list[i]) =="true"){
          this.open(list[i],rowList,false);
       }
    }
    if(isSource==true)
      this.getRowObj(rowIndex).isopen = true;
}

function TableRowSet_close(rowIndex,rowList,isSource){
    var list = this.getChildList(rowIndex);
    for(var i=0;i<list.length;i++){
       rowList[rowList.length] = list[i];
       this.getRowObj(list[i]).style.display ="none";
       this.close(list[i],rowList,false);
    }
    if(isSource==true)
       this.getRowObj(rowIndex).isopen = false;
}

function TableRowSet_getLevel(rowIndex){
  return parseInt(this.getRowObj(rowIndex).level);
}


function TableRowSet_getParentOfRow(rowIndex){
  var tmpRowIndex = rowIndex;
  while(tmpRowIndex >0){
    tmpRowIndex = tmpRowIndex - 1;
    var list = this.getChildList(tmpRowIndex);
    for(var i =0;i<list.length;i++){
      if(list[i] == rowIndex)
        return tmpRowIndex;
    }
  }
  return -1;
}
function TableRowSet_recomputerChildRowIndex(finishRowIndex,startRowIndex,endRowIndex,increase){
    //当在表格中增加了一条记录后，需要重新计算后面行的索引号
    //increase == 1,-1
    var dataTable = this.getTableObject();
    for(var i=0;i<=finishRowIndex;i++){
       var list = this.getChildList(i);
       if(list.length >0){
          //alert(i +'--'+ this.getChildList(i).join(",") +"- startRowIndex:" + startRowIndex+ "--end:" + endRowIndex +"--" + increase);
           for(var j=0;j<list.length;j++){
              if(list[j] >= startRowIndex && list[j] <= endRowIndex)
                list[j] = list[j] + increase ;
           }

          this.setChildList(i,this.getChildList(i).sort(sortDigit));
         // alert(i +'--'+ this.getChildList(i).join(",") +"- startRowIndex:" + startRowIndex+ "--end:" + endRowIndex +"--" + increase);
       }
    }
}

function TableRowSet_recomputerChildRowIndexOfTwo(finishRowIndex,s1,e1,i1,s2,e2,i2){
    //当在表格中增加了一条记录后，需要重新计算后面行的索引号
    //increase == 1,-1
    var dataTable = this.getTableObject();
    for(var i=0;i<=finishRowIndex;i++){
       var list = this.getChildList(i);
       if(list.length >0){
           for(var j=0;j<list.length;j++){
              if(list[j] >= s1 && list[j] <= e1)
                list[j] = list[j] + i1 ;
              else if(list[j] >= s2 && list[j] <= e2)
                list[j] = list[j] + i2 ;
           }

          this.setChildList(i,this.getChildList(i).sort(sortDigit));
       }
    }
}


function TableRowSet_getLastRowIndexOfChild(rowIndex){
       var list = this.getChildList(rowIndex);
       if(list.length == 0)
          return rowIndex;
       else
          return this.getLastRowIndexOfChild(list[list.length -1]);
}

function TableRowSet_setParent(rowIndex,parentRowIndex,isRedraw){
       if(isRedraw != false)
          isRedraw = true;
       //先从原来的父亲队列中移出
       var oldParentIndex = this.getParentOfRow(rowIndex);
       if(oldParentIndex >=0){
          var oldList = this.getChildList(oldParentIndex);
          var point;
          for(var i=0;i<oldList.length;i++){
             if(oldList[i] == rowIndex){
               point = i;
               break;
             }
          }
          for(var i = point;i<oldList.length -1;i++)
             oldList[i] = oldList[i+1];
          oldList.length = oldList.length -1;
          if(isRedraw == true)
    	     this.reDrawTreeCell(oldParentIndex,true);
       }

       if(parentRowIndex >=0){
          var list = this.getChildList(parentRowIndex);
          list[list.length] = rowIndex;
          this.getRowObj(rowIndex).level = this.getLevel(parentRowIndex) + 1;
          this.recomputerLevelOfChild(rowIndex);
          if(isRedraw == true)
             this.reDrawTreeCell(parentRowIndex,true);
          this.setChildList(parentRowIndex,this.getChildList(parentRowIndex));
       }else{
          this.getRowObj(rowIndex).level = 0;
          this.recomputerLevelOfChild(rowIndex);
          if(isRedraw == true)
              this.reDrawTreeCell(rowIndex,true);
       }

}
function TableRowSet_recomputerLevelOfChild(rowIndex){

  	if(rowIndex <0)
          return;

       var childLevel = this.getLevel(rowIndex) + 1;
       var list = this.getChildList(rowIndex);
       for(var i=0;i<list.length;i++){
          this.getRowObj(list[i]).level = childLevel;
          this.recomputerLevelOfChild(list[i]);
       }
}

function TableRowSet_reDrawTreeCell(rowIndex,isIncludeChild){
   var cell = this.getCellByName(rowIndex,this.DBTreeColName);
   var hasChild = false;
   var childList = this.getChildList(rowIndex);

   var span = this.getLevel(rowIndex) + 1;
   if(childList.length >0 )
     span = span - 1;


   var tmpValue = this.getValue(rowIndex,this.DBTreeColName);
   cell.innerText = "";

    var tmpSpan = document.createElement("span");
    tmpSpan.style.width = span * 20;
    cell.appendChild(tmpSpan);

    if(childList.length >0){
       var tmpButton = document.createElement("<input type='button'/>");
       tmpButton.DBTreeExtend = true
       tmpButton.style.width=20;
       tmpButton.style.height=18;
       if(this.getIsOpen(rowIndex) == true)
          tmpButton.value='-';
        else
          tmpButton.value='+';
        cell.appendChild(tmpButton);
    }
    var tmpText = document.createElement("span");
    tmpText.innerText = tmpValue;
    tmpText.style.width = '70%';
    cell.appendChild(tmpText);

   if( isIncludeChild == true){
     for(var i=0;i< childList.length;i++)
        this.reDrawTreeCell(childList[i],true);
   }
}

function TableRowSet_reDrawTreeCellByField(rowIndex,isIncludeChild,colName){
   var cell = this.getCellByName(rowIndex,colName);
   var hasChild = false;
   var childList = this.getChildList(rowIndex);

   var span = this.getLevel(rowIndex) + 1;
   if(childList.length >0 )
     span = span - 1;


   var tmpValue = this.getValue(rowIndex,colName);
   cell.innerText = "";

    var tmpSpan = document.createElement("span");
    tmpSpan.style.width = span * 20;
    cell.appendChild(tmpSpan);

    if(childList.length >0){
       var tmpButton = document.createElement("<input type='button' onfocus='this.blur()' class='TABLE_TREE_BUTTON'/>/>");
       tmpButton.DBTreeExtend = true;
       if(this.getIsOpen(rowIndex) == true)
          tmpButton.value='-';
        else
          tmpButton.value='+';
        cell.appendChild(tmpButton);
    }
    var tmpText = document.createElement("span");
    tmpText.innerText = tmpValue;
    tmpText.style.width = '70%';
    cell.appendChild(tmpText);

   /*if( isIncludeChild == true){
     for(var i=0;i< childList.length;i++)
        this.reDrawTreeCellByField(childList[i],true,colName);
   }*/
}

function TableRowSet_moveRow(rowIndex,toIndex){

  var currRowObj = this.getRowObj(this.CurRow);//记录当前行对象

  var endRowIndex = this.getLastRowIndexOfChild(rowIndex);

  //如果目标落在本区间中，不需要设置移动
  if((toIndex >= rowIndex -1) && (toIndex <=endRowIndex) )
     return;

  var linesize = endRowIndex - rowIndex + 1;
  var tmpList = new Array();

  var startIndex = -1;
  var destIndex =-1;
  if(rowIndex > toIndex){
     for(var i=0;i<linesize;i++)
        tmpList[toIndex + 1 + i] = rowIndex + i;
     for(var i=0;i< rowIndex - toIndex - 1;i++)
          tmpList[toIndex + 1 + linesize + i] = toIndex + 1 + i;
     startIndex =    toIndex + 1;
     this.recomputerChildRowIndexOfTwo(endRowIndex,rowIndex,endRowIndex,0 - (rowIndex - toIndex - 1),toIndex + 1,rowIndex - 1,linesize);
  }else{
     for(var i=0;i< toIndex - endRowIndex;i++)
        tmpList[rowIndex + i] = endRowIndex + 1 + i;

     for(var i=0;i< linesize ;i++)
        tmpList[rowIndex + toIndex - endRowIndex + i] = rowIndex + i;
      startIndex =  rowIndex;
     this.recomputerChildRowIndexOfTwo(toIndex,rowIndex,endRowIndex,toIndex - endRowIndex,endRowIndex + 1,toIndex,0 - linesize);
  }


   for(var i= startIndex;i< tmpList.length;i++){
      if(i == tmpList[i])
        continue;
      this.getRowObj(i).swapNode(this.getRowObj(tmpList[i]));
      //交换隐藏列的值
      if(this.rowHideCols[i]!=null || this.rowHideCols[tmpList[i]]!=null){
              var tmp = this.rowHideCols[i];
              this.rowHideCols[i] = this.rowHideCols[tmpList[i]];
              this.rowHideCols[tmpList[i]] = tmp;
      }

      for(var j= i + 1;j < tmpList.length;j++)
        if(tmpList[j] == i){
           tmpList[j] = tmpList[i];
           break;
        }
   }

   var tmpChild = this.getChildList(toIndex);
   if(tmpChild.length >0)
     this.setParent(toIndex + 1,toIndex,true);
   else{
     var parentRowIndex = this.getParentOfRow(toIndex);
     this.setParent(toIndex + 1,parentRowIndex,true);
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

//记录表格的大小，列宽 ，以及滚动条的位置 ，hexg ,2007-4-25
function TableRowSet_recordTableInfo(){
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

//还原表格的大小，列宽 ，滚动条的位置 ,以及动态设置过的title，hexg ,2007-4-25
function TableRowSet_restoreTableInfo(){
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
	
	this.DataTable.width=this.HeadTable.width;
    var rows = this.DataTable.rows;
    if(rows.length>0){
	    var datacells = rows(0).cells;
        for(i=0;i<this.colWidthArray.length;i++){
          	datacells(i).width = this.colWidthArray[i];
        }  
    }
	
   	//将原先隐藏的列再次隐藏
   	for(i=0;i<this.colHideByUserArray.length;i++){
    	if(this.colHideByUserArray[i] == true){
        	this.setColVisible(this.HeadTable.rows(0).cells(i).FieldID , false);
        }
	}  
  }
  

  //设置原先滚动条所在的垂直位置和水平位置
  if(this.scrollLeft!= null && parseInt(this.scrollLeft)>0 && this.TableDiv.scrollWidth>this.scrollLeft){
    this.TableDiv.scrollLeft = this.scrollLeft;
  }
  
  if(this.scrollTop!= null && parseInt(this.scrollTop)>0 &&  this.TableDiv.scrollHeight>this.scrollTop){
    this.TableDiv.scrollTop = this.scrollTop;
  }
  
  //还原通过JS设置过的表格的TITLE
  if(this.changeTitleArr != null){
    for(var prop in this.changeTitleArr){
    	if(isNaN(parseInt(prop)))continue;
        this.setTitleByIndex(parseInt(prop) ,this.changeTitleArr[prop]);
    }
  }
}

//更新表格标题区域的滚动区域的长度，主要是动态设置表格的水平和垂直滚动条，hexg ,2007-4-25
function TableRowSet_setHeadDivWidth(head_div ,data_div){
try{
	  if(data_div.scrollHeight>data_div.clientHeight){
	      head_div.style.width=parseInt(data_div.style.width)-17;
	  }else{
	    head_div.style.width=data_div.style.width;
	  }
	  var elementId = head_div.id.substring(8,head_div.id.length);
	  var srcollcontrolbar = document.getElementById("ScrollControlbar_" + elementId);
	  if(srcollcontrolbar!=null){
	    srcollcontrolbar.style.width = parseInt(head_div.childNodes[0].width);
	  }
  }catch(e){
  
  }
}

//====以下代码实现表格抬头托拉功能======
var g_Grid_Min_ColWidth = 10;
var g_Grid_Min_RowHeight = 10;
//鼠标在表格抬头移动时的响应事件
function Private_TableDrag_mouseMove(element){
    if (element.isContentEditable) return;
    if(element.isBeginDrop) return;
    
    var obj = window.event.srcElement;
    if ((obj.tagName.toLowerCase() == "td"  || obj.tagName.toLowerCase() == "span") && Math.abs(event.offsetX - obj.clientWidth) <= 5)
      obj.runtimeStyle.cursor='col-resize';
    else if ((element.IsRowResize =="true"||element.IsRowResize==true)&&(obj.tagName.toLowerCase() == "td"  || obj.tagName.toLowerCase() == "span") && Math.abs(event.offsetY - obj.clientHeight) <= 3)
      obj.runtimeStyle.cursor='row-resize';        
    else
      obj.runtimeStyle.cursor='default';
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
    }else if ((element.IsRowResize =="true"||element.IsRowResize ==true)&&(obj.tagName.toLowerCase() == "td") && Math.abs(event.offsetY - obj.clientHeight) <= 3){
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
    TableRowSet_setHeadDivWidth(head_div,data_div);
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

//根据百发比设置表格的宽度
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
	
	  TableRowSet_setHeadDivWidth(head_div ,data_div);
	  
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


function TableRowSet_onkeyfunc(func,aGridPK) {
	var obj = g_TableRowSetManager.get(aGridPK);
	try{
		eval(func+"('"+window.event.keyCode+"','"+obj.getRow()+"','"+obj.getCol()+"')");
	}catch(ex){
		alert(ex.name+":"+ex.message);
	}
}

//-----------------------add------------------------------------------------

//鼠标离开  table内数据行的背景回到初始化
function Private_TableDrag_mouseOutTab(aGridPK){
  var obj = window.event.srcElement;
  var parentObj = g_TableRowSetManager.get(aGridPK);
  if(obj == null || obj == "null") {
	  return;
  }
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


