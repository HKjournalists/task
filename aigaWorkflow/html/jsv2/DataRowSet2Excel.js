/**
将datarowset导出到excel中
pDataRowSet -要导出的datarowset
pIsShowHeadText-是否显示表头
pHeadShowColNums--显示表头栏目的个数
pTitle--报表的标题

关于excel的常量定义与使用：
excel的使用可在Excel中录制宏，然后进行实际操作
如填充颜色、划线、合并单元格等，然后编辑该宏查看源代码。
关于查看宏中的常量定义，方法如下：
1、在Excel中按Alt+F11运行Visual Basic帮助
2、在Visual Basic帮助中按F2显示对象浏览器
3、在对象浏览器中输入需要查询的常量查看常量的数值。
*/
function g_DataRowSet2Excel(pDataRowSet,pIsShowHeadText,pHeadShowColNums,pTitle)
{
   if (pDataRowSet)
	{

				   var xlApp = null;
				  try {
								xlApp =new ActiveXObject("excel.APPLICATION");
								var xlBook = xlApp.Workbooks.Add;
								var xlSheet1 = xlBook.Worksheets(1);

								var rows=pDataRowSet.count();
								var cols = 0;
								if   (pHeadShowColNums!=null&&pHeadShowColNums!="0"){
								    cols=pHeadShowColNums;//如果设置了显示表头的栏目个数，则按此显示
								  }else{
								    cols = pDataRowSet.getVisiColCount();//否则显示所有的栏目
								  }

								var i,j;
								var curRow =0;




								var colName ="";
								var colVal ="";
				//显示报表表头
				//合并单元格，并显示
				 var  m=0;
				if   (pTitle){
				      xlSheet1.Range(xlSheet1.cells(1,1),xlSheet1.cells(1,cols)).Merge();//Select();
					xlSheet1.cells(1,1).value=pTitle;
					//居中。。。
					xlSheet1.cells(1,1).HorizontalAlignment = -4108;
					xlSheet1.cells(1,1).VerticalAlignment = -4108;
				      m=1;
				      curRow=1;
				 }

				//显示标题
								if(pIsShowHeadText)
								{
									  var n=0;
									  for(n=0;n<cols;n++)
										{
									      xlSheet1.cells(m+1,n+1).value = pDataRowSet.getTitleByIndex(n);
										}
									 curRow++;
									 m=m+1;//正式数据以外的行数
									 //设定表头的底色
									 xlSheet1.Range(xlSheet1.cells(2,1),xlSheet1.cells(2,cols)).Interior.ColorIndex = 37;
								}
								for(i=0;i<rows;i++){
								   for(j=0;j<cols;j++)
									  {

										colName = pDataRowSet.getNameByIndex(j);
										//alert(colName);
										colVal = pDataRowSet.getDisplayText(i,colName);
                    
										
										//设置为文本格式
										xlSheet1.cells(curRow+i+1,j+1).NumberFormatLocal = "@";
										//end of 单元格的格式
										xlSheet1.cells(curRow+i+1,j+1).value = colVal;
										colName ="";
										colVal ="";
									  }
								}
								   //划线。。。
								   xlSheet1.Range(xlSheet1.cells(2,1),xlSheet1.cells(rows+m,cols)).Borders.LineStyle = 1;//xlContinuous;
								   xlSheet1.Range(xlSheet1.cells(2,1),xlSheet1.cells(rows+m,cols)).Borders.ColorIndex = -4105;//xlContinuous;
								   //表头划双线
								   xlSheet1.Range(xlSheet1.cells(2,1),xlSheet1.cells(2,cols)).Borders(9).LineStyle =  -4119;//xlDouble=-4119  xlEdgeBottom = 9
								   xlApp.Visible = true;
//								xlApp.quit();
								//xlApp = null;

						}
					catch(e) {
								if(e.name=="Error")
								{
								  alert("对不起，要使用此功能必须将本站加入“受信任的站点”。");
								}
								else
								  alert("系统错误:"+e.message);
				if(xlApp)
								  {
									 xlApp.quit();
									 xlApp = null;
								  }


						}


    }
}