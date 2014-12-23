/**
 * 自定义查询下拉列表对应的tag类相匹配的js方法。
 */
function g_ListBoxOnChange(listBoxObj)
{
  if(listBoxObj!=null && listBoxObj.options && listBoxObj.selectedIndex>=0)
  {
    var id = listBoxObj.options[listBoxObj.selectedIndex].value;
    var text = listBoxObj.options[listBoxObj.selectedIndex].text;
    if(listBoxObj.S_OnChange && listBoxObj.S_OnChange!="")
    {
      eval(listBoxObj.S_OnChange+"('"+id+"','"+text+"')");
    }
  }
}
/**
 * 弹出对话框，显示自定义查询的设置对话框
* pFuncCode 功能模块编码
* pStaffId 员工的staffid值，如果为空显示当前登陆员工的staffid
* return true/false 表示数据是否更新过。
 */
function g_ShowDefineQryDlg(pFuncCode,pStaffId)
{
   var staffId = pStaffId;
   if(pStaffId==null)
	   staffId = g_GetUserInfo().STAFF_ID;
   var flag = window.showModalDialog( _gModuleName+ "/webframe/defineqry/querydefinedlg.jsp?STAFF_ID="+staffId+"&FUNC_CODE="+pFuncCode,window,"scroll:no;resizable:no;status:no;dialogHeight:530px;dialogWidth:745px");
   return flag;
}


/**
* 对自定义查询的列表进行refresh，id为自定义下拉列表tag类的id值
*/
function g_RefreshDefineQryListBox(id)
{
   var obj = document.all.item(id);
   if(obj!=null && obj.FUNC_CODE && obj.STAFF_ID)
   {
     var funcCode = obj.FUNC_CODE;
     var staffId = obj.STAFF_ID;
     //alert(funcCode+","+staffId);
     var ListDataSourceStatic = createStaticListDataSource("com.ai.appframe2.defineqry.bean.DSDefineQryListBox","arg0="+funcCode+"&arg1="+staffId);
     if(ListDataSourceStatic!=null)
     {
       obj.options.length = 0;
       ListDataSourceStatic.fillListBox(null,0,obj,null,null);
     }


   }
}