<%@ page contentType="text/html; charset=GBK" %>

<HTML>
<script language="JavaScript" src=""></script>
<HEAD>
<TITLE>定义</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="<%=request.getContextPath()%>/jsv2/AppFrameCss.jsp" type="text/css">
</HEAD>
<script language=javascript>


function removeSelItemFromTable(tableObj,selItemArray)
{
  for (var j=selItemArray.length-1;j>=0;j--)
  {
    tableObj.deleteRow(selItemArray[j]);

  }

}

function addTableItem(tableObj,dimIndex,dimAttr,dimName,dimArea,isTotal,isCompess,orderType)
{
    if(tableObj==null)
	{
		if(dimArea==0 || dimArea=="0")
		 tableObj = allPivotTbl;
		if(dimArea==1 || dimArea=="1")
		 tableObj = rowPivotTbl;
		if(dimArea==2 || dimArea=="2")
		 tableObj = colPivotTbl;
	}
    var rowObj=tableObj.insertRow(tableObj.rows.length);
	var aCells=rowObj.cells;
	rowObj.dimIndex = dimIndex;
	rowObj.dimAttr=dimAttr;
	rowObj.dimName = dimName;
	rowObj.dimArea = dimArea;
	if(tableObj == allPivotTbl)
	{

	  var cell_1=rowObj.insertCell(aCells.length);
	  var cell_2=rowObj.insertCell(aCells.length);
	  var cell_3=rowObj.insertCell(aCells.length);
	  var cell_5=rowObj.insertCell(aCells.length);
	    cell_1.align="left";
	    cell_1.style.width=20;
		cell_2.align="left";
		cell_2.style.width=120;
		cell_3.align="center";
		cell_3.style.width=40;
		cell_5.align="left";
		cell_5.style.width=80;

	  cell_1.innerHTML="<input type=\"checkbox\"/>";
	  cell_2.innerText=dimName;
	  cell_3.innerHTML="<input type=\"checkbox\"/>";
	  cell_5.innerHTML="<select><option value='0'>原始顺序</option ><option value='asc'>升序</option><option value='desc'>降序</option></select>";
	}
	else
	{

	   var cell_1=rowObj.insertCell(aCells.length);
	    var cell_2=rowObj.insertCell(aCells.length);
	    var cell_3=rowObj.insertCell(aCells.length);
//	    var cell_4=rowObj.insertCell(aCells.length);
	    var cell_5=rowObj.insertCell(aCells.length);
		cell_1.align="left";
	    cell_1.style.width=20;
		cell_2.align="left";
		cell_2.style.width=120;
		cell_3.align="center";
		cell_3.style.width=40;
//		cell_4.align="center";
//		cell_4.style.width=40;
		cell_5.align="left";
		cell_5.style.width=80;

		cell_1.innerHTML="<input type=\"checkbox\"/>";
		cell_2.innerText=dimName;
		cell_3.innerHTML="<input type=\"checkbox\" />";
//		cell_4.innerHTML="<input type=\"checkbox\" checked=true/>";
		cell_5.innerHTML="<select><option value='0'>原始顺序</option ><option value='asc'>升序</option><option value='desc'>降序</option></select>";
	}
	//设置值isTotal,isCompess,orderType
	if(isTotal == 1 || isTotal == "1")
	{
	   cell_3.childNodes(0).checked = true;
	}
//	if(isCompess == 1 || isCompess == "1")
//	{
//	   cell_4.childNodes(0).checked = true;
//	}
	if(orderType)
	 cell_5.childNodes(0).value = orderType;

}

function addPivot(srcTblName,targetTblName)
{
   var srcTbl = document.all.item(srcTblName);
   var targetTbl = document.all.item(targetTblName)

   var rows = srcTbl.rows;
   var selOptions = new Array;
   for(var i=0;i<rows.length;i++)
	 {
	    if(rows[i].cells(0).childNodes(0).checked==true)
		  {
			var index = rows[i].dimIndex;
			var val = rows[i].dimAttr;
			var text = rows[i].dimName;
			addTableItem(targetTbl,index,val,text);
	    selOptions[selOptions.length] = i;
		  }
	 }
   removeSelItemFromTable(srcTbl,selOptions);

}

function getTableValueStr(tablObj,dimArea)
{
  var reVal2 = new Array();
  var reVal = new Array();
  var rows = tablObj.rows;
  if(rows.length==0)
  {
	 return "null";
  }
  for(var i=0;i<rows.length;i++)
  {
	reVal.length = 0;
	reVal[reVal.length] = rows[i].dimIndex;
	reVal[reVal.length] = rows[i].dimAttr;
	reVal[reVal.length] = rows[i].dimName;


	//dimArea
	reVal[reVal.length] = dimArea;

	//isTotal
	if(rows[i].cells(2).childNodes(0).checked==true)
	  reVal[reVal.length] = 1;
	else
      reVal[reVal.length] = 0;
	//isCompess
      reVal[reVal.length] = "1";
      reVal[reVal.length] = rows[i].cells(3).childNodes(0).value;
//	if(rows[i].cells.length == 4)
//	  {
//	         reVal[reVal.length] = 1;
//
//
//	  }
//    else
//	  {
//	    if(rows[i].cells(3).childNodes(0).checked==true)
//	    reVal[reVal.length] = 1;
//	    else
//	    reVal[reVal.length] = 0;
//	    reVal[reVal.length] = rows[i].cells(4).childNodes(0).value;
//	  }
    reVal2[reVal2.length] = reVal.join(",");

  }

  return reVal2.join("$$");
}

function okFunc(){
  var reVal = new Array();
  reVal[reVal.length] = getTableValueStr(document.all.item("allPivotTbl"),0);
  reVal[reVal.length] = getTableValueStr(document.all.item("rowPivotTbl"),1);
  reVal[reVal.length] = getTableValueStr(document.all.item("colPivotTbl"),2);
 // alert(reVal.join("|||"));
  window.returnValue = reVal.join("|||");
  //alert(reVal.join("|||"));
  top.close();


}

function cancelFunc(){
  window.returnValue = "cancel";
  top.close();
}


</script>
<BODY style="width:100%;height:100%;overflow:auto">
<table border=0 cellspacing=0 cellpadding=0 width="500" height="100%" id=mainTable class=main_tab>
	   <td align=center valign=top height="300"> <br>
		    <table width="96%" border="0" cellspacing="0" cellpadding="0">
			    <tr>
			       <td rowspan="3" valign="top">
					   <fieldset style="width:180;height:100%;text-align:center;font-size:12" align="middle" >
				    <LEGEND class=FormZName>可选内容</LEGEND>
				    <div align="left" style="width:260">
							<table id="allPivotTblHead" border="1" cellspacing="0" cellpadding="0" style="color:#F1F3F9;BORDER-RIGHT: 1px solid; BORDER-TOP: 0px solid; BORDER-LEFT: 1px solid;BORDER-BOTTOM: 0px solid; TABLE-LAYOUT: fixed; BORDER-COLLAPSE: collapse" borderColor="#404D5D"  border="0" >
							<tr class="GH-Head" bgColor="#7691C7" >
							  <td nowrap style="width:20" ></td>
							  <td nowrap style="width:120" align="center">维名称</td>
							  <td nowrap style="width:40" >小计</td>
							  <td nowrap style="width:80" align="center">排序</td>

							</tr>
							</table>
							</div>
							<div style="width:280;height:355;OVERFLOW-Y: scroll; OVERFLOW-X: no;" align="left">
							<table  id="allPivotTbl" style="TABLE-LAYOUT: fixed; BORDER-COLLAPSE: collapse" class="GH-TD" borderColor=#000000 bgColor=#fafcff border=1>




			  </table>
						  </div>
			       </fieldset>
				       </td>
			       <td align="center" valign="middle" width="50" nowrap>
					 <input type="button" class="AIButtonClass" value=">>" onclick="addPivot('allPivotTbl','rowPivotTbl')"/>
					  <br><br>
					  <input type="button" class="AIButtonClass" value="<<" onclick="addPivot('rowPivotTbl','allPivotTbl')"/>
					   </td>
			       <td valign="top">
					  <fieldset style="width:180;height:150;text-align:center;font-size:12">
				   <LEGEND class=FormZName>行内容</LEGEND>
						    <div align="left" style="width:260">
							<table id="rowPivotTblHead" border="1" cellspacing="0" cellpadding="0" style="color:#F1F3F9;BORDER-RIGHT: 1px solid; BORDER-TOP: 0px solid; BORDER-LEFT: 1px solid;BORDER-BOTTOM: 0px solid; TABLE-LAYOUT: fixed; BORDER-COLLAPSE: collapse" borderColor="#404D5D"  border="0" >
							<tr class="GH-Head" bgColor="#7691C7" >
							  <td nowrap style="width:20" ></td>
							  <td nowrap style="width:120" align="center">维名称</td>
							  <td nowrap style="width:40" >小计</td>
							  <td nowrap style="width:80" align="center">排序</td>



							</tr>
							</table>
							</div>
							<div style="width:280;height:140;OVERFLOW-Y: scroll; OVERFLOW-X: no;" align="left">
							<table  id="rowPivotTbl" style="TABLE-LAYOUT: fixed; BORDER-COLLAPSE: collapse" class="GH-TD" borderColor=#000000 bgColor=#fafcff border=1>
						  </table>
						  </div>
					      </fieldset>
				       </td>
			    </tr>
				<tr>
				   <td colspan="2" align= "center">
				      <input type="button" style="font-family:wingdings 3;" class="AIButtonClass" value="q" onclick="addPivot('rowPivotTbl','colPivotTbl')"/>
					  &nbsp;&nbsp;&nbsp;&nbsp;
					  <input type="button" style="font-family:wingdings 3;" class="AIButtonClass" value="p" onclick="addPivot('colPivotTbl','rowPivotTbl')"/>
				   </td>
				</tr>
			    <tr>
			       <td align="center" valign="middle" width="50" nowrap>
					  <input type="button" class="AIButtonClass" value=">>" onclick="addPivot('allPivotTbl','colPivotTbl')"/><br><br>
					  <input type="button" class="AIButtonClass" value="<<" onclick="addPivot('colPivotTbl','allPivotTbl')"/>
					   </td>
			       <td valign="top">
						   <fieldset style="width:180;height:150;text-align:center;font-size:12">
					     <LEGEND class=FormZName>列内容</LEGEND>
						    <div align="left" style="width:260">
							<table id="colPivotTblHead" border="1" cellspacing="0" cellpadding="0" style="color:#F1F3F9;BORDER-RIGHT: 1px solid; BORDER-TOP: 0px solid; BORDER-LEFT: 1px solid;BORDER-BOTTOM: 0px solid; TABLE-LAYOUT: fixed; BORDER-COLLAPSE: collapse" borderColor="#404D5D"  border="0" >
							<tr class="GH-Head" bgColor="#7691C7" >
							  <td nowrap style="width:20" ></td>
							  <td nowrap style="width:120" >维名称</td>
							  <td nowrap style="width:40" >小计</td>
							  <td nowrap style="width:80">排序</td>

							</tr>
							</table>
							</div>
							<div style="width:280;height:140;OVERFLOW-Y: scroll; OVERFLOW-X: no;" align="left">
							<table  id="colPivotTbl" style="TABLE-LAYOUT: fixed; BORDER-COLLAPSE: collapse" class="GH-TD" borderColor=#000000 bgColor=#fafcff border=1>




			  </table>
						  </div>
					      </fieldset>
				       </td>
		     </tr>
			</table>

	       </td>

	  <tr valign="top">
      <td align="center">
	  <input type="button" id = "okBtn" class="AIButtonClass" value="确    定" onclick="okFunc()"/>
	  &nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="AIButtonClass" id="cancelBtn" value="取     消" onclick = "cancelFunc()"/></td>
    </tr>
	</table>
	<br>
    <br>

</BODY>

<SCRIPT LANGUAGE="JavaScript" for="window" even="onload">
 <%
    String param = new String(request.getParameter("param").getBytes("ISO-8859-1"),"GB2312");

    /*bmh,地区,0,1,-1,0$$spbh,商品,0,1,-1,0|||year,年份,1,1,1,0$$month,月份,1,0,1,0|||Meas,量,2,0,1,0

*/
 %>
 var param = "<%=param%>";
 //alert(param);
   var allPivotTbl =document.all.item("allPivotTbl");
  var rowPivotTbl =document.all.item("rowPivotTbl");
  var colPivotTbl =document.all.item("colPivotTbl");

 var paramArray = param.split("|||");
 if(paramArray.length==3)
 {
    for(var i=0;i<paramArray.length;i++)
	 {
	var tmpDimArray = paramArray[i].split("$$");
		for(var j=0;j<tmpDimArray.length;j++)
		 {

		    if(tmpDimArray[j]!="null")
		    {
			var pivotArray = tmpDimArray[j].split(",");
			if(pivotArray.length == 7)
			 {


			   addTableItem(null,pivotArray[0],pivotArray[1],pivotArray[2],pivotArray[3],pivotArray[4],pivotArray[5],pivotArray[6]);
			 }
			else
			 {
			   alert("参数格式不正确");
			 }
		    }
		 }




	 }
 }
 else
 {
	 alert("参数长度应为3");
 }

  window.returnValue = "cancel";


</SCRIPT>
</HTML>
