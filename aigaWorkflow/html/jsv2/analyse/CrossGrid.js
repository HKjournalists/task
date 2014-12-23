/**
	模块名称:	CrossGrid交叉报表的通用js函数
	作者:		墙辉，钟锐
	获取对象：
	g_CrossGridManager.get(crossgridid)根据id得到CrossGrid对象
	方法说明：
	refresh 根据pivot轴的值变换，刷新UI的显示格局。
	refreshConfig 根据pivot的属性编号，重新构建ui的显示格局
	showConfigDlg 显示pivot的配置对话框
	clearSelRowCol 清除row或者列的选中状态
	toExcelUrl(pFileName)  转换为excel的url路径。pFileName－指定要保存的文件名称
	reloadData(para) 从查询数据集合。para为参数 格式为http参数传输标准格式 aa=1&bb=2&cc=3;



***********/
var g_CrossGrid_ImgFoldo =_gModuleName + "/jsv2/image/tree_pic/fold_o.gif";//分支节点open的图片
var g_CrossGrid_ImgFoldc =_gModuleName + "/jsv2/image/tree_pic/fold_c.gif";//分支节点close的图片

var g_CrossGrid_ImgLeafc=_gModuleName + "/jsv2/image/tree_pic/leaf_c.gif";
var g_CrossGrid_ImgLeafo=_gModuleName + "/jsv2/image/tree_pic/leaf_o.gif";

var g_CrossGridManager = new CrossGridManager();
//CrossGrid管理器
function CrossGridManager(){
 this.List = new Array();
 this.push = function(crossGridObj){
      this.List[crossGridObj.id] = crossGridObj;
      return crossGridObj.PK;
 }
 this.get = function(id){
    var result = this.List[id];
    if(!result){
       result = new CrossGrid(id);
    }
    return result;
 }
 this.remove = function(id){
   this.List[id] = null;
 }
}


function CrossGrid(pId)
{
  this.id = pId
  this.PK = -1;
  this.showType="crossgrid";

  this.configStr="";
  this.headCount = 0;
  this.rowHeadCount = 0;


  this.S_OnRowSelect = null;
  this.S_OnColSelect = null;

  this.selectCellArray = new Array();


  this.rowHeadValuesArray = null;
  this.colHeadValuesArray = null;

  CrossGrid.prototype.getConfigStr = CrossGrid_getConfigStr;

  CrossGrid.prototype.clearSelCells = CrossGrid_clearSelCells;
  CrossGrid.prototype.getUITableObj = CrossGrid_getUITableObj;
  CrossGrid.prototype.initial = CrossGrid_initial;
  CrossGrid.prototype.selectCol = CrossGrid_selectCol;
  CrossGrid.prototype.selectRow = CrossGrid_selectRow;
  CrossGrid.prototype.initHeadConfigInfo=CrossGrid_initHeadConfigInfo;



  CrossGrid.prototype.reloadData = CrossGrid_reloadData;
  CrossGrid.prototype.getRowHeadValues = CrossGrid_getRowHeadValues;
  CrossGrid.prototype.getColHeadValues = CrossGrid_getColHeadValues;
  CrossGrid.prototype.toExcelUrl = CrossGrid_toExcelUrl;
  CrossGrid.prototype.refresh = CrossGrid_refresh;
  CrossGrid.prototype.refreshConfig = CrossGrid_refreshConfig;
  CrossGrid.prototype.showConfigDlg = CrossGrid_showConfigDlg;




  this.initial();
}

function CrossGrid_initial(){
  g_CrossGridManager.push(this);
  var xmlNode = document.all("CrossGrid_ConfigInfo_" + this.id).XMLDocument.childNodes(0);
  if(xmlNode)
  {
    for(var i =0;i<xmlNode.childNodes.length;i++)
    {
      if(xmlNode.childNodes(i).nodeName == "pk")
	this.PK = xmlNode.childNodes(i).text;
      if(xmlNode.childNodes(i).nodeName == "configstr")
	this.configStr = xmlNode.childNodes(i).text;
      if(xmlNode.childNodes(i).nodeName =="showtype")
	this.showType = xmlNode.childNodes(i).text;
      if(xmlNode.childNodes(i).nodeName == "event")
      {
	for(var j=0;j<xmlNode.childNodes(i).childNodes.length;j++)
	{
	   if(xmlNode.childNodes(i).childNodes(j).nodeName == "onrowselect"){
	     eval("this.S_OnRowSelect = " + xmlNode.childNodes(i).childNodes(j).text);
	   }
	  if(xmlNode.childNodes(i).childNodes(j).nodeName == "oncolselect"){
	     eval("this.S_OnColSelect = " + xmlNode.childNodes(i).childNodes(j).text);
	   }
	}
      }

    }
    this.initHeadConfigInfo();

    //alert(this.configStr+",this.S_OnRowSelect="+this.S_OnRowSelect+"this.pk="+this.PK);
  }
  else{
     alert("初始化CrossGrid错误.please check the config xml");
  }

}

function CrossGrid_initHeadConfigInfo()
{
    this.headCount =0;
    this.rowHeadCount=0;
    if(this.configStr!=""){
       var paramArray = this.configStr.split("|||");
       if(paramArray.length==3)
	{
	    var tmpDimArray = paramArray[2].split("$$");
	    this.headCount = tmpDimArray.length;
	    tmpDimArray = paramArray[1].split("$$");
	    this.rowHeadCount = tmpDimArray.length;
	}
    }
  this.rowHeadValuesArray = null;
  this.colHeadValuesArray = null;
}


function CrossGrid_getConfigStr()
{
	return this.configStr;
}
function CrossGrid_refresh()
{
    if(document.all.item("CrossGrid_SelectArea_"+this.id)!=null)
    {
     var xml= new ActiveXObject("Msxml.DOMDocument");
     xml.async = false;
     var selectIndexs ="";

     var list = document.all.item("CrossGrid_SelectArea_"+this.id).getElementsByTagName("select");
      for(var i=0;i<list.length;i++)
      {
	  if(list[i].id.indexOf("cross_selsect") >=0)
	  {
	    if(selectIndexs.length >0 )
	    selectIndexs = selectIndexs +",";
	    selectIndexs = selectIndexs + list[i].value;
	   }
      }
      var url = _gModuleName+"/crossgridaction?action=refresh&pk="+this.PK+"&id="+this.id+"&showtype="+this.showType+"&selectindexs=" + selectIndexs+"&configstr="+this.configStr;

      var b = xml.load(url);
      var xmlNode = xml.documentElement;
      //alert(xmlNode.text);
      document.all("CrossGrid_GridData_"+this.id).innerHTML = xmlNode.text;


  }
}

function CrossGrid_reloadData(para){
  if(document.all.item("CrossGrid_SelectArea_"+this.id)!=null)
    {
     var xml= new ActiveXObject("Msxml.DOMDocument");
     xml.async = false;
     var selectIndexs ="";

     var list = document.all.item("CrossGrid_SelectArea_"+this.id).getElementsByTagName("select");
      for(var i=0;i<list.length;i++)
      {
	  if(list[i].id.indexOf("cross_selsect") >=0)
	  {
	    if(selectIndexs.length >0 )
	    selectIndexs = selectIndexs +",";
	    selectIndexs = selectIndexs + list[i].value;
	   }
      }
      var url = _gModuleName+"/crossgridaction?action=reloaddata&pk="+this.PK+"&id="+this.id+"&showtype="+this.showType+"&selectindexs=" + selectIndexs+"&configstr="+this.configStr;
      if(para!="")
	 url+=url+"&"+para;

      var b = xml.load(url);
      var xmlNode = xml.documentElement;
      //alert(xmlNode.text);
      document.all("CrossGrid_GridData_"+this.id).innerHTML = xmlNode.text;


  }
}


function CrossGrid_toExcelUrl(filename){

     var xml= new ActiveXObject("Msxml.DOMDocument");
     xml.async = false;
     var selectIndexs ="";

     var list = document.all.item("CrossGrid_SelectArea_"+this.id).getElementsByTagName("select");
      for(var i=0;i<list.length;i++)
      {
	  if(list[i].id.indexOf("cross_selsect") >=0)
	  {
	    if(selectIndexs.length >0 )
	    selectIndexs = selectIndexs +",";
	    selectIndexs = selectIndexs + list[i].value;
	   }
      }

   var url = _gModuleName+"/crossgridaction?action=toexcel&filename="+ filename+"&pk="+this.PK+"&id="+this.id
           + "&selectindexs=" + selectIndexs
	    +"&showtype="+this.showType+"&configstr="+g_ConditonStrEncode(this.configStr);
   return url;
}

function CrossGrid_refreshConfig(pConfigStr)
{
	var xml= new ActiveXObject("Msxml.DOMDocument");
	xml.async = false;
	var url = _gModuleName+ "/crossgridaction?action=refreshconfig&pk="+this.PK+"&id="+this.id+"&configstr=" + pConfigStr+"&showtype="+this.showType;
	var b = xml.load(url);
	var xmlNode = xml.documentElement;
	if(xmlNode)
	{
	for(var i =0;i<xmlNode.childNodes.length;i++)
	 {
	    var tmpNode = xmlNode.childNodes(i);
	    if (tmpNode.nodeName =="ConfigStr")
	    {
	      this.configStr = tmpNode.text;
	    }
	    if (tmpNode.nodeName =="SelectArea")
	    {
	      if(document.all.item("CrossGrid_SelectArea_"+this.id))
		document.all.item("CrossGrid_SelectArea_"+this.id).innerHTML = tmpNode.text;
	    }
	    if (tmpNode.nodeName =="Data")
	    {
	      if(document.all("CrossGrid_GridData_"+this.id))
	      //alert(tmpNode.text);
	       document.all("CrossGrid_GridData_"+this.id).innerHTML = tmpNode.text;
	    }
	 }
	 this.initHeadConfigInfo();

	}
	else
	{
	  alert("[CrossGrid.refreshConfig]根据配置重新刷新数据出现错误.xmlNode="+xmlNode);
	}


}

function CrossGrid_showConfigDlg()
{
       //alert(this.configStr);
       var msg = window.showModalDialog(_gModuleName+"/jsv2/analyse/pivotdefinedlg.jsp?param="+this.configStr,window,"scroll:no;resizable:no;status:no;dialogHeight:490px;dialogWidth:625px");
	//x = "bmh,地区,0,1,-1,0$$spbh,商品,0,1,-1,0|||year,年份,1,1,1,0$$month,月份,1,0,1,0|||Meas,量,2,0,1,0";
       if(msg!="cancel")
	{
	  this.refreshConfig(msg);
	}
}


function CrossGrid_clearSelCells()
{
  if(this.selectCellArray.length>0)
  {
    for(var i=0;i<this.selectCellArray.length;i++)
    {
      var cellObj = this.selectCellArray[i];
      
      //change by hexg 20060710
      if(cellObj.oldBGColor!=null){
      	cellObj.style.backgroundColor = cellObj.oldBGColor;
      }else{
      	cellObj.style.backgroundColor = "";
      }
    }
    this.selectCellArray.length = 0;
  }

}


function CrossGrid_getUITableObj()
{
   return document.all.item("CrossGrid_GridData_"+this.id).childNodes(0);
}


function CrossGrid_selectCol(tdObj)
{
    if(tdObj.collevel==null){
      return;
    }

    var tmpRow = tdObj.parentNode;
    var tableObj = this.getUITableObj();
    var colIndex = tdObj.cellIndex;
    var colHeadDataArray = new Array();
    var measDataArray = new Array();
    this.clearSelCells();

    //从最后列算colindex
    var rangeFromEnd = 0;
    for(var m=colIndex;m<tmpRow.cells.length;m++)
    {
      if(tmpRow.cells(m).colSpan && parseInt(tmpRow.cells(m).colSpan)>0)
      {
	 rangeFromEnd += parseInt(tmpRow.cells(m).colSpan);
      }
      else
      {

	rangeFromEnd +=1;

      }
    }
    for(var i=0;i<tableObj.rows.length;i++)
    {
      var cellLenth = tableObj.rows(i).cells.length;
      if(tableObj.rows(i).colPivot==null)
	  {
	       // alert("cellLenth-rangeFromEnd-1="+cellLenth-rangeFromEnd-1);
	       //保存旧的背景色
	       if(tableObj.rows(i).cells(cellLenth-rangeFromEnd).style.backgroundColor!=null)
	       	tableObj.rows(i).cells(cellLenth-rangeFromEnd).oldBGColor = tableObj.rows(i).cells(cellLenth-rangeFromEnd).style.backgroundColor;
	       
	       tableObj.rows(i).cells(cellLenth-rangeFromEnd).style.backgroundColor = "#C4CCFF";
	       measDataArray[measDataArray.length] = tableObj.rows(i).cells(cellLenth-rangeFromEnd).innerText;
	       this.selectCellArray[this.selectCellArray.length] = tableObj.rows(i).cells(cellLenth-rangeFromEnd);
	  }
      else
	  {

	     var cellRangeBegin = 0;
	     var cellRangeEnd = 0;
	     for(var n=cellLenth-1;n>=0;n--)
	       {
		 if(tableObj.rows(i).cells(n).colSpan && parseInt(tableObj.rows(i).cells(n).colSpan)>0)
		 {
		   cellRangeEnd =cellRangeBegin + parseInt(tableObj.rows(i).cells(n).colSpan);
		 }
		 else
		 {
		   cellRangeEnd = cellRangeBegin+1;
		 }
		 if(rangeFromEnd>=cellRangeBegin && rangeFromEnd<=cellRangeEnd){
		    colHeadDataArray[colHeadDataArray.length] = tableObj.rows(i).cells(n).innerText;
		    break;
		 }
		 else{
		    cellRangeBegin = cellRangeEnd;
		 }


	       }


	  }

    }//end for
    if(this.S_OnColSelect!=null)
      {
	      try
	       {
		  this.S_OnColSelect(colIndex,colHeadDataArray,measDataArray);
		 //eval(crossGridObj.S_OnColChange+"('"+colIndex+"','"+colHeadDataArray.join(",")+"','"+measDataArray.join(",")+"');");
	       }
	       catch(e)
	       {
		 alert("执行外部onColSelect方法失败.调用语句:"+this.S_OnColSelect);
		throw e;
	       }
     }

}


function CrossGrid_selectRow(tdObj)
{
   var rowHeadDataArray = new Array();
   var measDataArray = new Array();
   var tmpRow = tdObj.parentNode;
   var tmpTable = this.getUITableObj();;
   this.clearSelCells();

   if(this.showType=="treegrid")
    {

      for(var i=0;i < tmpRow.cells.length;i++)
      {
	if(tmpRow.cells(i).rowPivot)
	{
	   if(i==0 && tmpRow.cells(i).parentRows && tmpRow.cells(i).parentRows.length>1)
	   {
	    var parentRowsArray = tmpRow.cells(i).parentRows.split(",");
	    for(var j=0;j<parentRowsArray.length;j++)
	    {
	      if(parentRowsArray[j]!="" && isNaN(parseInt(parentRowsArray[j]))==false)
	      {
		var realRow = this.headCount-1+parseInt(parentRowsArray[j]);
		//alert("parentRow="+parentRowsArray[j]);
		rowHeadDataArray[rowHeadDataArray.length] = tmpTable.rows(realRow).cells(0).childNodes(2).innerText;
	      }
	    }

	  }
	  rowHeadDataArray[rowHeadDataArray.length] = tmpRow.cells(i).childNodes(2).innerText;
	}
	else{
	  measDataArray[measDataArray.length] = tmpRow.cells(i).innerText;
	}
	this.selectCellArray[this.selectCellArray.length] = tmpRow.cells(i);
	tmpRow.cells(i).style.backgroundColor = "#C4CCFF";


      }
    }
    //以下是DBGrid处理
    else
    {
    var tmpRows;

    if(tmpRow.parentRows)
       tmpRows = tmpRow.parentRows.split(',');
    else
       tmpRows = new Array();
    var currRowIndex = parseInt(tmpRow.rowIndex);
    var tmpRowLevel = 0;
    if(tmpRow.cells(0).rowlevel){
      tmpRowLevel = parseInt(tmpRow.cells(0).rowlevel);
    }




    for(var i=tmpRow.cells.length - 1;i >=0;i--)
      {
	this.selectCellArray[this.selectCellArray.length] = tmpRow.cells(i);
	if(tmpRow.cells(i).rowlevel)
	  rowHeadDataArray[rowHeadDataArray.length] = tmpRow.cells(i).innerText;
	else
	  measDataArray[measDataArray.length] = tmpRow.cells(i).innerText;
      }


    for(var i=tmpRows.length - 1;tmpRows != null && i >=0;i--){
      tmpRow = tmpTable.rows(parseInt(tmpRows[i]));
      for(var j= tmpRow.cells.length - 1;j>=0;j--){
	 if(tmpRow.cells(j).rowlevel && parseInt(tmpRow.cells(j).rowlevel) < tmpRowLevel){
	   this.selectCellArray[this.selectCellArray.length] = tmpRow.cells(j);
	   rowHeadDataArray[rowHeadDataArray.length] = tmpRow.cells(j).innerText;
	 }
      }
      tmpRowLevel = parseInt(tmpRow.cells(0).rowlevel);
    }
    //将数组反转
    this.selectCellArray = this.selectCellArray.reverse();
   // var str ="";
   for(var i =0;i < this.selectCellArray.length ;i++){
    //保存旧的背景色
    if(this.selectCellArray[i].style.backgroundColor!=null)
    	this.selectCellArray[i].oldBGColor = this.selectCellArray[i].style.backgroundColor;
    
    //设置选中时候的背景色
	this.selectCellArray[i].style.backgroundColor = "#C4CCFF";
	//str = str + "," + tmpTable.selectedCells[i].innerText;
   }
   rowHeadDataArray = rowHeadDataArray.reverse();
   measDataArray  = measDataArray.reverse();
  }
   if(this.S_OnRowSelect!=null)
   {
    try
     {
      this.S_OnRowSelect(tmpRow.rowIndex,rowHeadDataArray,measDataArray);
     }
    catch(e)
       {
	 alert("执行外部rowSelect方法失败.调用语句:"+this.S_OnRowSelect);
	 throw e;
       }
   }


}



function CrossGrid_GridData_OnClick(id){
  var srcObj = window.event.srcElement;
  var crossGridObj = g_CrossGridManager.get(id);
  if(crossGridObj && srcObj.tagName == "TD")
  {
    var tmpRow = srcObj.parentNode;
    //列选择
    if(tmpRow.colPivot)
    {
      crossGridObj.selectCol(srcObj);

    }
    //行选择
    else
    {
      crossGridObj.selectRow(srcObj);
    }

  }
}


function TreeGrid_Expansion(id,srcObj,realRowIndex)
{
 rowId = srcObj.parentNode.parentNode.rowIndex;
 var tmpParentId = parseInt(realRowIndex);
 var tmpParentId = ","+tmpParentId+",";
 if(srcObj.parentNode.parentRows!=null)
  {
    if(srcObj.parentNode.parentNode.nodetype=="leaf")
    {
      return;
    }
    var crossGridObj = g_CrossGridManager.get(id);
    var tableObj = crossGridObj.getUITableObj();
    var displayStr = "none";
    if(srcObj.parentNode.parentNode.isExpansion==null || srcObj.parentNode.parentNode.isExpansion=="true")
      {
	srcObj.parentNode.parentNode.isExpansion = "false";

      }
      else
      {
	srcObj.parentNode.parentNode.isExpansion = "true";
	displayStr="block";
      }
    for(var i=tableObj.rows.length-1;i>=parseInt(rowId)+1;i--)
    {
      var cellObj = tableObj.rows(i).cells(0);

      if(cellObj && cellObj.parentRows && cellObj.parentRows.indexOf(tmpParentId)>=0 )
      {
	   if(displayStr=="none")
	   {

	     tableObj.rows(i).style.display = displayStr;



	     if(tableObj.rows(i).nodetype=="dir")
	       {

		 var imgObj = cellObj.all.tags("IMG");
		 imgObj[0].src = g_CrossGrid_ImgFoldc;//"fold_c.gif";
		 tableObj.rows(i).isExpansion="false";

	       }

	   }
	   else
	   {
//           alert(tableObj.rows(i).level);
//           alert(srcObj.parentNode.parentNode.level);
	     if(parseInt(cellObj.rowPivot) == parseInt(srcObj.parentNode.rowPivot)+1)
	     {
	       tableObj.rows(i).style.display = displayStr;
	     }
	   }



      }

    }
    if(displayStr=="none")
	srcObj.src = g_CrossGrid_ImgFoldc;//"fold_c.gif";
    else
	srcObj.src = g_CrossGrid_ImgFoldo;//"fold_o.gif";


  }
}


function   CrossGrid_getRowHeadValues()
{
  if(this.rowHeadValuesArray == null)
  {
    this.rowHeadValuesArray =  new Array();
    var tableObj = this.getUITableObj();
    if(this.showType=="treegrid")
      {
	  for(var i=this.headCount;i<tableObj.rows.length;i++)
	    {
		  var tmpRow = tableObj.rows(i);
		  if(tmpRow.colPivot)
		    continue;

		  var rowHeadDataArray = new Array();
		  if(tmpRow.cells(0).parentRows && tmpRow.cells(0).parentRows.length>1)
		  {
		     var parentRowsArray = tmpRow.cells(0).parentRows.split(",");
		     for(var j=0;j<parentRowsArray.length;j++)
		       {
			 if(parentRowsArray[j]!="" && parseInt(parentRowsArray[j])!=NaN)
			  {
			     var realRow = this.headCount-1+parseInt(parentRowsArray[j]);
			     rowHeadDataArray[rowHeadDataArray.length] = tableObj.rows(realRow).cells(0).childNodes(2).innerText;
			   }
			}
		  }
		 //alert(tmpRow.cells(0).innerText);
		 rowHeadDataArray[rowHeadDataArray.length] = tmpRow.cells(0).childNodes(2).innerText;
		 this.rowHeadValuesArray[this.rowHeadValuesArray.length] = rowHeadDataArray;
		 rowHeadDataArray = null;
	     }

      }//end treeGrid
      //mcGrid的时候
     else
	{
	  var rowMaxLength = this.rowHeadCount;
	  for(var m=this.headCount;m<tableObj.rows.length;m++)
	   {
	     var rowHeadDataArray = new Array();
	     var tmpRow = tableObj.rows(m);
	     if(tmpRow.colPivot) continue;
	     rowMaxLength = this.rowHeadCount;
	     if(rowMaxLength>tmpRow.cells.length)
		 rowMaxLength =  parseInt(tmpRow.cells.length);

	     var tmpRows;
	     if(tmpRow.parentRows)
		tmpRows = tmpRow.parentRows.split(',');
	     else
		tmpRows = new Array();
	     var currRowIndex = parseInt(tmpRow.rowIndex);
	     var tmpRowLevel = 0;
	     if(tmpRow.cells(0).rowlevel)
	     {
	       tmpRowLevel = parseInt(tmpRow.cells(0).rowlevel);
	     }

	     for(var i=rowMaxLength - 1;i >=0;i--)
	     {
	      // alert("2:"+tmpRow.cells(i));
	       if(tmpRow.cells(i).rowlevel)
		  rowHeadDataArray[rowHeadDataArray.length] = tmpRow.cells(i).innerText;
	     }
	    for(var i=tmpRows.length - 1;tmpRows != null && i >=0;i--)
	    {
	      tmpRow = tableObj.rows(parseInt(tmpRows[i]));
	      for(var j= tmpRow.cells.length - 1;j>=0;j--)
	      {
		if(tmpRow.cells(j).rowlevel && parseInt(tmpRow.cells(j).rowlevel) < tmpRowLevel)
		{
		   rowHeadDataArray[rowHeadDataArray.length] = tmpRow.cells(j).innerText;
		 }
	      }
	      tmpRowLvel = parseInt(tmpRow.cells(0).rowlevel);
	    }
	    this.rowHeadValuesArray[this.rowHeadValuesArray.length] = rowHeadDataArray.reverse();
	    rowHeadDataArray = null;

	   }


	}
  }
  return this.rowHeadValuesArray;

}
//获取所有表头
function CrossGrid_getColHeadValues()
{
  if(this.colHeadValuesArray == null)
  {
    this.colHeadValuesArray = new Array;

    if(this.headCount>0)
    {
	for(var i=0;i<this.headCount;i++)
	{
	  var rowObj = this.getUITableObj().rows(i);

	  var j=1;
	  if(i==this.headCount-1)
	  {
	    if(this.showType=="treegrid")
	       j=1;
	    else
	       j=this.rowHeadCount;
	  }
	  var range = 0;

	  for(;j<rowObj.cells.length;j++)
	  {
	    var cellObj = rowObj.cells(j);
	    //alert("1:"+cellObj.colSpan);
	    if(cellObj.colSpan)
	    {
	      for(var m=range;m<range+(parseInt(cellObj.colSpan));m++)
	      {
		if(this.colHeadValuesArray[m] == null)
		 this.colHeadValuesArray[m] = new Array();
		//alert("2:"+cellObj.innerText);
		this.colHeadValuesArray[m][i] = cellObj.innerText;
	      }
	      range+=parseInt(cellObj.colSpan);

	    }
	  }



	}
      //alert("3:"+this.colHeadValuesArray.length);
      //alert("4:"+this.getUITableObj().rows(this.headCount-1).cells.length);
    }
    //当量在row不在col的情况下。检查第一行是否定义为行头
    else if(this.getUITableObj().rows(0).colPivot)
    {
      for(var i=this.rowHeadCount-1;i<this.getUITableObj().rows(0).cells.length;i++)
      {
	this.colHeadValuesArray[i] = new Array(this.getUITableObj().rows(0).cells(i));
      }
    }
  }
  return this.colHeadValuesArray;
}




