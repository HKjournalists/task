<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="java.util.HashMap" %>
<%@include file="/secframe/common/common.jsp"%>
<html>
<head>
<title>添加岗位类型</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body>
<table width="600"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px">可选岗位类型</td>
                <td align="right" style="height: 20px"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="center"><ai:listbox ds="com.ai.secframe.bo.sysmgr.AllStationType" id="src_type_list"  
          	listsize="20" showtype="list" width="250" multiselect="false"  initial="true"/>
          </td>
        </tr>
      </table></td>
    <td align="center" valign="middle">
	<input name="" type="button" class="btn-2word" value=">>>" id="add_btn" onclick="addItem()"/>
	<br/><br>

	<input name="" type="button" class="btn-2word" value="<<<" id="delete_btn" onclick="delItem()"/>
	</td>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px">已选岗位类型</td>
                <td align="right" style="height: 20px"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF"  align="center">
		  <ai:listbox ds="" id="dest_type_list"  
          	listsize="20" showtype="list" width="250" multiselect="false"  initial="false"/>
          </td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td colspan="3" align="center" style=" padding-top:10px;">	
	<input name="" type="button" class="btn-2word" value="确定" id="confirm_btn" onclick="confirm()"/>&nbsp;&nbsp;
	<input name="" type="button" class="btn-2word" value="取消" id="cancel_btn" onclick="cancel()"/>
	</td>
  </tr>
</table>
</body>
</html><SCRIPT LANGUAGE="JavaScript" for="window" even="onload">
	var dst_list = g_getListBox("dest_type_list");
	var src_list = g_getListBox("src_type_list");
	var gParam = dialogArguments;

  //将已经有的岗位类型去掉
  for(var i=0;i<gParam.length;i++){
    src_list.delItem(gParam[i]);   		
  }
</script>
<script type="text/javascript">
	function addItem(){
	    if(src_list.getID()==null || src_list.getID() ==''){
			alert('请先选择要增加一个岗位类型!');
			return;
		}
		dst_list.addItem(src_list.getID(),src_list.getValue());
		src_list.delItem(src_list.getID());
	}

	function delItem() {
	    if(dst_list.getID()==null || dst_list.getID() ==''){
			alert('请先选择一个要删除岗位类型!');
			return;
		}
		src_list.addItem(dst_list.getID(),dst_list.getValue());
		dst_list.delItem(dst_list.getID());
    }

	function confirm()
	{
	    if (dst_list.getAllItem().length < 1)
	    {
	      alert("请选择一个岗位类型!");
	      return false;
	    }
	    var result = "";
		result = dst_list.getAllItem();
	    window.returnValue = result;
	    window.close();
	}

	function cancel()
	{
	    window.returnValue = null;
	    window.close();
	}
	function listboxInit(){
		
	}
</script>
