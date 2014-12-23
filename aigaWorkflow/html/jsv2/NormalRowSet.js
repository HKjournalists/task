/**
 　
 　作者 ： 墙辉   2004/05/08
   NormalRowSetManager： 数据集组件管理器
      构造方法：	１、通过 g_NormalRowSetManager.create(name,url) 从服务器读取数据
               xml格式：
	               <?xml version ='1.0' encoding = 'gb2312'?>

               　　　　<BOLCKDATA>
                        .......................
                      </BOLCKDATA>
              ２、通过 g_NormalRowSetManager.createRowSets(names,url) 从服务器读取数据
              　　　　　names:是数据级名称数组，要与后台传回的数据顺序对应，如果有自定义数据，要放在RowSet的后面输出
               xml格式：
	               <?xml version ='1.0' encoding = 'gb2312'?>

               　　　　<BOLCKDATA>
                        .......................
                      </BOLCKDATA>
               　　　　<BOLCKDATA>
                        .......................
                      </BOLCKDATA>
               　　　　<BOLCKDATA>
                        .......................
                      </BOLCKDATA>
		      <UD>
                        ......................
                      </UD>
      开发人员可以使用的方法：
        get(pk)：根据表格数据数据集的唯一标识获取表格数据集对象。
        getUserData():获得后台传回的自定义数据　UserDataClass 对象
      其它方法：
        push(tableRowSet):向管理器中增加一个表格数据集。
        remove(pk)：删除一个数据集对象。
      用法说明：
        开发人员只能使用get(pk)方法获取表格数据对象，然后调用数据对象的相关方法。例如：
          var rowset = g_NormalRowSetManager.get("staff");


   NormalRowSet： 数据集组件

      开发人员可以使用方法：
        getRow()：获取当前行号
        setRow(rowIndex)：设置当前行号
        getNameByIndex(colIndex): 获得列名

        newRow()：新增一行
        deleteRow(rowIndex)：删除一行

        count()：有效的行数
        isSelected(rowIndex)：测试某一行是否选中
        rowSelected(rowIndex,isSelected)：设置某一行的选中状态　isSelected = true(选中) false(不选中)
        getSelectedRows() : 获取选中行行号数组
        getValue(rowIndex,colName)：获取指定单元的数据值
        getDisplayText(rowIndex,colName)：获取指定单元的显示值
	setValue(rowNumber,fieldTypeName,id,displayText)：根据行号，列名设置数据值, id 数据值,displayText 显示值
	toXmlString()：将数据转化为Xml字符串。

***********/


var g_NormalRowSetManager = new NormalRowSetManager();

function NormalRowSetManager(){
 this.List = new Array();
 this.UserData = null;
 this.push = function(normalRowSet){
      this.List[normalRowSet.RowSetName] = normalRowSet;
      return normalRowSet.RowSetName;
 }
 this.get = function(pk){
    var result = this.List[pk];
    return result;
 }
 this.getUserData = function(){ return this.UserData };
 this.remove = function(pk){
   this.List[pk] = null;
 }
 this.createByXml = function(aName,xmlObjID){
     var xmlNode = document.all(xmlObjID).XMLDocument.childNodes(0);
 	 if(!userValidCheckByNode(xmlNode))
	 return;

     if (xmlNode.nodeName == "BOLCKDATA"){
           return new NormalRowSet(aName,xmlNode);
      }else{
      	showMessage("运行期错误--createRowSetFactory()","数据块的根节点要求为BOLCKDATA！！xmlNode.xml="+xmlNode.xml);
     }

 }
 this.create = function(aName,url) {
      var xml= new ActiveXObject("Msxml.DOMDocument");
      xml.async = false;
      var bload = xml.load(url);
      if (!bload){
      	showMessage("运行期错误--createRowSetFactory()","从Url获取的字符串不符合xml规范！！Url="+url);
      }

      var xmlNode = xml.documentElement;

      if(!userValidCheckByNode(xmlNode))
	 return;

      if (xmlNode.nodeName == "BOLCKDATA"){
           return new NormalRowSet(aName,xmlNode);
      }else{
      	showMessage("运行期错误--createRowSetFactory()","数据块的根节点要求为BOLCKDATA！！xmlNode.xml="+xmlNode.xml);
      }
    }
 this.createRowSets = function(aNames,url) {
      var xml= new ActiveXObject("Msxml.DOMDocument");
      xml.async = false;
      var bload = xml.load(url);
      if (!bload){
      	showMessage("运行期错误--createRowSetFactory()","从Url获取的字符串不符合xml规范！！Url="+url);
      }

      var xmlNode = xml.documentElement;

      if(!userValidCheckByNode(xmlNode))
	 return;

      for(var i=0;i<xmlNode.childNodes.length;i++){
         if (xmlNode.childNodes(i).nodeName == "BOLCKDATA"){
             new NormalRowSet(aNames[i],xmlNode.childNodes(i));
         }else if (xmlNode.childNodes(i).nodeName == "UD"){
            this.UserData = createUserDataClass(xmlNode.childNodes(i));
         }
      }
    }
}
function NormalRowSet(aName,xmlNode){
  this.RowSetName = aName;
  g_NormalRowSetManager.push(this)
  this.CurRow = -1;
  this.CurCol = -1;
  this.NewRowDataId = 0;
  this.OnValueChange = null;
  this.OnRowFocusChange = null;
  this.IsEditable = true;
  this.isMutilSelect = true;
  this.colIndexs = new Array();
  this.colNames = new Array();

  this.ListDataSource = null;
  this.FieldTypeSet = null;

  this.deleteRows = new Array();
  this.rows = new Array();
  this.initial(xmlNode);
}
NormalRowSet.prototype.initial = NormalRowSet_initial;
NormalRowSet.prototype.getName = NormalRowSet_getName;
NormalRowSet.prototype.setValue = NormalRowSet_setValue;

NormalRowSet.prototype.getCellSts =NormalRowSet_getCellSts;
NormalRowSet.prototype.getCellStsFromCell =NormalRowSet_getCellStsFromCell;

NormalRowSet.prototype.getValue = NormalRowSet_getValue;
NormalRowSet.prototype.getValueFromCell = NormalRowSet_getValueFromCell;
NormalRowSet.prototype.getValuePrivate = NormalRowSet_getValuePrivate;

NormalRowSet.prototype.getDisplayText = NormalRowSet_getDisplayText;
NormalRowSet.prototype.getDisplayTextFromCell = NormalRowSet_getDisplayTextFromCell;

NormalRowSet.prototype.getOldValue = NormalRowSet_getOldValue;
NormalRowSet.prototype.getOldValueFromCell = NormalRowSet_getOldValueFromCell;

NormalRowSet.prototype.getOldDisplayText = NormalRowSet_getOldDisplayText;
NormalRowSet.prototype.getOldDisplayTextFromCell = NormalRowSet_getOldDisplayTextFromCell;

NormalRowSet.prototype.getRowObj = NormalRowSet_getRowObj;
NormalRowSet.prototype.getCurRowIndex = NormalRowSet_getCurRowIndex;
NormalRowSet.prototype.getCell = NormalRowSet_getCell;
NormalRowSet.prototype.getCellByName = NormalRowSet_getCellByName;
NormalRowSet.prototype.realcount = NormalRowSet_realcount;
NormalRowSet.prototype.count = NormalRowSet_count;
NormalRowSet.prototype.getColCount = NormalRowSet_getColCount;

NormalRowSet.prototype.toXmlStringCell = NormalRowSet_toXmlStringCell;
NormalRowSet.prototype.toXmlString = NormalRowSet_toXmlString;
NormalRowSet.prototype.toXmlStringDeleteRow = NormalRowSet_toXmlStringDeleteRow;
NormalRowSet.prototype.toXmlStringRow = NormalRowSet_toXmlStringRow;
NormalRowSet.prototype.copyCell = NormalRowSet_copyCell;

NormalRowSet.prototype.newRow = NormalRowSet_newRow;
NormalRowSet.prototype.deleteRow = NormalRowSet_deleteRow;

NormalRowSet.prototype.setRow = NormalRowSet_setRow;

NormalRowSet.prototype.isCellEditable = NormalRowSet_isCellEditable;
NormalRowSet.prototype.getColIndex = NormalRowSet_getColIndex;
NormalRowSet.prototype.getNameByIndex = NormalRowSet_getNameByIndex;

NormalRowSet.prototype.getRowSts = NormalRowSet_getRowSts;
NormalRowSet.prototype.setRowSts = NormalRowSet_setRowSts;

NormalRowSet.prototype.getSelectedRows = NormalRowSet_getSelectedRows;
NormalRowSet.prototype.rowSelected = NormalRowSet_rowSelected;
NormalRowSet.prototype.isSelected = NormalRowSet_isSelected;

NormalRowSet.prototype.getRow = NormalRowSet_getRow;
NormalRowSet.prototype.getFieldType = NormalRowSet_getFieldType;

NormalRowSet.prototype.getNewRowDataId = NormalRowSet_getNewRowDataId;
NormalRowSet.prototype.getRowId = NormalRowSet_getRowId;

NormalRowSet.prototype.setStsToOld = NormalRowSet_setStsToOld;
NormalRowSet.prototype.getClassName = NormalRowSet_getClassName;

NormalRowSet.prototype.getColNames = NormalRowSet_getColNames;

NormalRowSet.prototype.verify = NormalRowSet_verify;

function NormalRowSet_verify(rowIndex,colName){
  return this.getFieldType(colName).verify(this.getValue(rowIndex,colName)) ;
}
function NormalRowSet_getColNames(){ return this.colNames;}

function NormalRowSet_getClassName(){ return "NormalRowSet";}

function  NormalRowSet_getName(){
  return this.RowSetName;
}
function  NormalRowSet_initial(xmlNode){
  if(xmlNode == null) {
     alert("NormalRowSet初始化失败，xmlNode不能为空");
     return;
   }
   var dataNode;
   for(var i = 0;i < xmlNode.childNodes.length;i++){
     var tmpNode = xmlNode.childNodes(i);
      if ( tmpNode.nodeName == "HEAD")
         this.ListDataSource = new ListDataSourceFactory(tmpNode);
      else if ( tmpNode.nodeName == "FieldTypeSet"){
         this.FieldTypeSet = new FieldTypeSetClass(tmpNode);
         for(var j=0;j <this.FieldTypeSet.FieldList.length;j++){
            this.colNames[j] = this.FieldTypeSet.FieldList[j].getName();
            this.colIndexs[this.FieldTypeSet.FieldList[j].getName().toUpperCase()] = j;
         }
      }else if  ( tmpNode.nodeName == "RowSet")
          dataNode = tmpNode;

   }

   //处理数据
 //this.rows.length = dataNode.childNodes.length;
 for(var i=0;i<dataNode.childNodes.length;i++){
   var tmpNode = dataNode.childNodes(i);
   this.rows[i] = new Array();
   this.rows[i].Sts ='O';
   this.rows[i].I = "-1";

   if (tmpNode.attributes.getNamedItem("Authority") && tmpNode.attributes.getNamedItem("Authority") =='R')
          this.rows[i].roweditable = false;
   if (tmpNode.attributes.getNamedItem("I"))
          this.rows[i].I = tmpNode.attributes.getNamedItem("I").nodeValue;
   //处理单元格
   for(var j=0; j< tmpNode.childNodes.length;j++){
     var tmpCellNode = tmpNode.childNodes(j);
     var tmpName = this.FieldTypeSet.getNameById(tmpCellNode.nodeName);
     if (tmpName == null)
        alert("不能找到《"+ tmpCellNode.nodeName +"》的数据域类型！");
     var colIndex = this.getColIndex(tmpName);
     var tmpCell = new NormalRowSet_VCell();
     this.rows[i][colIndex] = tmpCell;

      if (tmpCellNode.text)
         tmpCell.innerText = tmpCellNode.text;

      if (tmpCellNode.attributes.getNamedItem("I")){
        if(tmpCell.innerText)
           tmpCell.I = tmpCellNode.attributes.getNamedItem("I").nodeValue;
        else
          tmpCell.innerText = tmpCellNode.attributes.getNamedItem("I").nodeValue;
      }
   }
  }
 }


function NormalRowSet_getRowId(rowIndex){
  var tmpRow = this.getRowObj(rowIndex);
  return tmpRow.I;
}

function NormalRowSet_getNewRowDataId (){
    this.NewRowDataId = this.NewRowDataId + 1;
    return this.FieldTypeSet.getName() + '_' + this.NewRowDataId;
 }

function NormalRowSet_getFieldType(colIndex){
  return  this.FieldTypeSet.getFieldByName(this.colNames[colIndex]);
}
function NormalRowSet_getRow(){
   return this.CurRow;
}

function NormalRowSet_rowSelected(rowIndex,isSelected){
    if (this.isMutilSelect== true){
      var tmpRow = this.getRowObj(rowIndex);
      if (tmpRow)
         tmpRow.checked = isSelected;
    }else{
      this.setRow(rowIndex);
    }
}
function NormalRowSet_isSelected(rowIndex){
    var result = false;
    if (this.isMutilSelect== true){
      var tmpRow = this.getRowObj(rowIndex);
      if ((tmpRow) &&(tmpRow.checked == true))
        result = true;
    }else if(this.CurRow  == rowIndex)
       result = true;
   return result;
}

function NormalRowSet_getSelectedRows(){
   var result = new Array();
   if (this.isMutilSelect== true){
     for(var i=0; i < this.count();i++){
       var tmpRow = this.getRowObj(i);
       if (tmpRow && tmpRow.checked == true)
         result[result.length] = (i);
     }
   }
   else if (this.CurRow >=0)
     result[result.length] = (this.CurRow);
   return result;
}
function NormalRowSet_getCurRowIndex(){
  return this.CurRow;
}

function NormalRowSet_setRowSts(rowIndex,sts){
   //U,O,N,D
   var tmpRow = this.getRowObj(rowIndex);
   tmpRow.Sts = sts;
}


function NormalRowSet_getRowSts(rowIndex){
   var tmpRow = this.getRowObj(rowIndex);
   if ((tmpRow)&& (tmpRow.Sts))
       return tmpRow.Sts;
   else
       return "O";
}

function NormalRowSet_newRow(){
   var rowIndex =this.count();
    var tmpRow = new Array();
   tmpRow.I = this.getNewRowDataId();
   tmpRow.Sts = "NN";

   for(var i=0;i<this.getColCount();i++)
       tmpRow[tmpRow.length] = (new NormalRowSet_VCell());

   this.rows[this.rows.length] = (tmpRow);
   this.setRow(rowIndex);
   return rowIndex;
}

function NormalRowSet_getNameByIndex(colIndex){
    return this.colNames[colIndex];
}

function NormalRowSet_getColIndex(name){
  name = name.toUpperCase();
  var index = this.colIndexs[name];
  if(index == null)
    index = -1;
  return index;
}

function NormalRowSet_getColCount(){
  return this.colNames.length;
}

function NormalRowSet_setRowEditSts(rowIndex,value){
   var tmpRow = this.getRowObj(rowIndex);
   tmpRow.roweditable = value;
}

function NormalRowSet_getRowEditSts(rowIndex){
   var tmpRow = this.getRowObj(rowIndex);
   if (!tmpRow)
     return false;

   if(tmpRow.roweditable == false || tmpRow.roweditable == "false")
        return false;

   return true;
}

function NormalRowSet_isCellEditable(rowIndex,colIndex){
   if((rowIndex <0) ||(rowIndex >= this.count())||(colIndex <0)||(colIndex >=this.getColCount()))
     return false;

   var rowEditable = this.getRowEditSts(rowIndex);
   return  this.IsEditable&&rowEditable&&this.getFieldType(colIndex).getAuthority();
}

function NormalRowSet_getRowObj(rowIndex){
  if(rowIndex == null){
    alert("指定的行号为null");
    return null;
  }
  rowIndex = parseInt(rowIndex);
  if ((rowIndex >=0)&&(rowIndex < this.count()))
     return this.rows[rowIndex];
  else
     return null;
}
function NormalRowSet_setRow(rowIndex){

  var oldRowIndex = this.CurRow;
  rowIndex =parseInt(rowIndex);
  this.CurRow = rowIndex;
  if (this.CurRow != oldRowIndex){
    if (this.OnRowFocusChange)
      this.OnRowFocusChange(oldRowIndex,rowIndex);
  }
  return true;

}

function  NormalRowSet_deleteRow(rowIndex){
   if(rowIndex == null)
     rowIndex = this.CurRow;
   rowIndex = parseInt(rowIndex);

    var count = this.count();

   if ((rowIndex >=0) && (rowIndex < count)){
      var sts = this.getRowSts(rowIndex);

      if((sts!='NN')&& (sts!='N'))
        this.deleteRows[this.deleteRows.length] = (this.rows[rowIndex]);

      for(var i = rowIndex ;i < count - 1 ; i++  ){
           this.rows[i] = this.rows[i + 1];
      }

      this.rows.length = count - 1;

      if ( this.CurRow > rowIndex)
           this.CurRow  = this.CurRow - 1;
      else if( this.CurRow == rowIndex){
          if(this.CurRow == this.count())
              this.setRow(this.CurRow - 1);
      }
   }
}

function NormalRowSet_count(){
       return this.rows.length;
 }

function NormalRowSet_realcount(){
    return this.count();
  }

function NormalRowSet_getCellByName(index,name){
   var colIndex = this.getColIndex(name);
   var cell = this.getCell(index,colIndex);
   return cell;
  }

function NormalRowSet_getCell(rowIndex,colIndex){
   var tmpRow = this.getRowObj(rowIndex);
   if (tmpRow == null)
     return null;
   if((colIndex == null)||(colIndex<0)||(colIndex >= this.getColCount()))
      return null;
   var tmpCell = this.rows[rowIndex][colIndex];
   if(tmpCell == null){
     tmpCell = new NormalRowSet_VCell();
     this.rows[rowIndex][colIndex] = tmpCell;
   }
   return tmpCell;
 }


function NormalRowSet_setValue(index,name,aId,aDisplayText){

    var cell = this.getCellByName(index,name);
    if (!cell) return false;

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
    cell.isModify = true;

    var sts = this.getRowSts(index);
    if (sts =='O')
       this.setRowSts(index,'U');
    else if (sts == "NN"){
       this.setRowSts(index,'N');
    }

    if (this.OnValueChange)
       this.OnValueChange(index,name,this.getOldValueFromCell(cell),this.getValueFromCell(cell));
    return true;
}

function NormalRowSet_getCellStsFromCell(cell){

    if(!cell)   return "O";
    var OldId = this.getOldValueFromCell(cell);
    var NewId = this.getValueFromCell(cell);
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
function NormalRowSet_getCellSts(index,name){
    var cell = this.getCellByName(index,name);
    return this.getCellStsFromCell(cell);
}

function NormalRowSet_getDisplayText(index,name){
    var cell = this.getCellByName(index,name);
    return this.getDisplayTextFromCell(cell);
}
function NormalRowSet_getDisplayTextFromCell(cell){
   if(!cell)    return "";
   return cell.innerText;
}
function NormalRowSet_getValuePrivate(index,name){
  return this.getValue(index,name);
}

function NormalRowSet_getValue(index,name){
    var cell = this.getCellByName(index,name);
    return this.getValueFromCell(cell);
}
function NormalRowSet_getValueFromCell(cell){
    if(!cell)     return "";
    if (cell.I)
      return cell.I;
    else
      return cell.innerText;
}
function NormalRowSet_getOldValue(index,name){
    var cell = this.getCellByName(index,name);
    return this.getOldValueFromCell(cell);
}
function NormalRowSet_getOldValueFromCell(cell){
    if(!cell)   return "";
    if(cell.OldI) return cell.OldI;
    if(cell.OldValue) return cell.OldValue;
    return "";
}

function NormalRowSet_getOldDisplayText(index,name){
    var cell = this.getCellByName(index,name);
    return this.getOldDisplayTextFromCell(cell);
}
function NormalRowSet_getOldDisplayTextFromCell(cell){
    if(!cell)   return "";
    if(cell.OldValue) return cell.OldValue;
    if(cell.OldI) return cell.OldI;
    return "";
}

function  NormalRowSet_setStsToOld(){
  this.deleteRows.length=0;
  for(var i=0;i<this.realcount();i++){
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

//modify by qianghui 2004/09/03 add parameter isOnlySendModifyData
function  NormalRowSet_toXmlString(isOnlySendModifyData){
     var result = new Array();

     for(var i=0;i<this.realcount();i++){
         var s= this.toXmlStringRow(i,isOnlySendModifyData);
         if(s.length >0)
            result[result.length] = (s);
     }

     for(var i=0;i<this.deleteRows.length;i++)
         result[result.length] = (this.toXmlStringDeleteRow(i));

     if(result.length ==0)
       return "";

     return "<RowSet Name='" + this.FieldTypeSet.getName() + "' FullName='" +  this.FieldTypeSet.getFullName() + "' "
            + " Sts='U'>"
            + result.join("")
            + "</RowSet>";

}

function NormalRowSet_toXmlStringDeleteRow(rowIndex){
     var sts = "D";
     var result = new Array();
     result[result.length] = ("<Row ID='" + this.deleteRows[rowIndex].I + "' Sts='" + sts + "'>");
     for(var i=0;i< this.getColCount();i++){
        result[result.length] = (this.toXmlStringCell(this.deleteRows[rowIndex][i],this.getNameByIndex(i)));
     }
     result[result.length] = ("</Row>");
     return result.join("");
}

//modify by qianghui 2004/09/03 add parameter isOnlySendModifyData

function NormalRowSet_toXmlStringRow(rowIndex,isOnlySendModifyData){
   if(isOnlySendModifyData == null) isOnlySendModifyData = true;

    var sts = this.getRowSts(rowIndex);

    if ((isOnlySendModifyData == true) &&((sts == "O")||(sts =="NN")))
       return "";

    var result = new Array();
     result[result.length] = ("<Row ID='" + this.getRowId(rowIndex) + "' Sts='" + sts + "'>");
     for(var i=0;i< this.getColCount();i++){
        result[result.length] = (this.toXmlStringCell(this.getCell(rowIndex,i),this.getNameByIndex(i)));
     }
     result[result.length] = ("</Row>");
     return result.join("");
}

function NormalRowSet_toXmlStringCell(cell,name){
  var sts = this.getCellStsFromCell(cell);
  if (sts =="NN") return "";
  var xmlStr = "<Col Name='" +  name + "'"
             + " Sts='" + sts + "'";

  var OldId = this.getOldValueFromCell(cell);
  var OldText = this.getOldDisplayTextFromCell(cell);
  var NewId = this.getValueFromCell(cell);
  var NewText = this.getDisplayTextFromCell(cell);

  if(OldId == OldText)
    OldText = "";
  if(NewId == NewText)
    NewText = "";

 if (sts =="O"){
      if (NewId)
         xmlStr += " OldID='" + NormalRowSet_checkAndTrans(NewId) + "'";
      if (NewText)
         xmlStr += " OldText ='" + NormalRowSet_checkAndTrans(NewText) +"' ";
      xmlStr = xmlStr + "/>"

 }else{
      if (OldId)
         xmlStr += " OldID='" + NormalRowSet_checkAndTrans(OldId) + "'";
      if (OldText)
         xmlStr += " OldText ='" + NormalRowSet_checkAndTrans(OldText) +"' ";

       if(NewId)
         xmlStr += " ID ='" + NormalRowSet_checkAndTrans(NewId) +"' ";

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

function NormalRowSet_checkAndTrans(str){
   str = str.toString();
   if(NormalRowSet_checkStr(str))
     return NormalRowSet_transStr(str);
   else
     return str;

}
function NormalRowSet_checkStr(str)
  {

    if(str.indexOf("&")>=0||str.indexOf(">")>=0||str.indexOf("<")>=0||str.indexOf("'")>=0||str.indexOf('"')>=0)
      return true;
    else
      return false;
  }

//进行特殊字符替换,add by zhuwg
function NormalRowSet_transStr(str)
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

function NormalRowSet_copyCell(sourceCell,destCell){
  if(sourceCell.I)  destCell.I = sourceCell.I;
  if (sourceCell.OldI)  destCell.OldI = sourceCell.OldI;
  if (sourceCell.OldValue)  destCell.OldValue = sourceCell.OldValue;
  if (sourceCell.Value)  destCell.Value = sourceCell.Value;
  if (sourceCell.innerText)  destCell.innerText = sourceCell.innerText;
  if (sourceCell.isModify)  destCell.isModify = sourceCell.isModify;
  if (sourceCell.isFirstModify)  destCell.isFirstModify = sourceCell.isFirstModify;
}

function NormalRowSet_getEditer(rowIndex,colIndex,aId,aDisplayText){
   var fieldType = this.getFieldType(colIndex);
   return fieldType.getEditer(this,rowIndex,this.ListDataSource,aId,aDisplayText);
}

function  NormalRowSet_VCell(){
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

