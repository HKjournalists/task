<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/webframe/jspcommon/includedhead.jsp"%>
<!--
/**
 * @since 2005.10
 * @author 李新波
 * @version 1.0
 * */
-->
<html>
<head>
<title>
用户自定义字段管理
</title>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/UserData_v2.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/jsv2/Globe_v2.jsp"></script>

</head>
<body bgcolor="#ffffff">
<label class="AreaTitleMx">用户自定义字段信息维护</label>
<table align="center"><br>
  <tr align="center">
    <td>
      <fieldset id="contentFieldset" style="width:620;text-align:center;font-size:12">
	<legend>用户自定义字段信息</legend>
	<ai:dbform formid="UserDefineFieldForm" setname="com.ai.appframe2.udfpage.SETUserDefinedProperty" initial="false">
	    <table align="center" style="width:600;text-align:center;font-size:12">
             <tr>
               <td><ai:dbformfield fieldname="PROP_ID" width="150" visible="false" formid="UserDefineFieldForm"/>
             </tr>
	     <tr>
               	<td class="FormTDName">页面布局：</td>
                <td class="FormTD">
                  <ai:dbformfield fieldname="PAGELAYOUT_ID" width="150" formid="UserDefineFieldForm"/>
                </td>
                <td class="FormTDName">业务对象：</td>
                <td class="FormTD">
                  <ai:dbformfield fieldname="BUSINESS_OBJECT_ID" width="150" formid="UserDefineFieldForm"/>
		</td>
             </tr>
             <tr>
                <td class="FormTDName">字段标题：</td>
		<td class="FormTD">
		   <ai:dbformfield fieldname="TITLE" width="150" formid="UserDefineFieldForm"/>
		</td>
                <td class="FormTDName">字段名称：</td>
                <td class="FormTD">
                  <ai:dbformfield fieldname="NAME" width="150" formid="UserDefineFieldForm"/>
		</td>
             </tr>
             <tr>
               <td class="FormTDName">编辑类型：</td>
		<td class="FormTD">
		   <ai:dbformfield fieldname="EDIT_TYPE" width="150" formid="UserDefineFieldForm"/>
		</td>
               <td class="FormTDName">是否必填：</td>
                <td class="FormTD">
                  <ai:dbformfield fieldname="IS_MUST" width="150" formid="UserDefineFieldForm"/>
		</td>
             </tr>
             <tr>
               <td class="FormTDName">缺省值：</td>
              	<td class="FormTD">
                  <ai:dbformfield fieldname="DEFAULT_VALUE" width="150" formid="UserDefineFieldForm"/>
		</td>
             </tr>
             <tr>
               <td class="FormTDName">属性值列表：</td>
		<td class="FormTD" colspan="3">
		   <ai:dbformfield fieldname="VALUE_LIST_ID" width="290" formid="UserDefineFieldForm"/>
                   <input type="button" value="添加" name="btn_input" onclick="Input()">(属性值之间用;相隔)
		</td>
             </tr>
             <tr>
                <td class="FormTDName">接口类：</td>
                <td class="FormTD" colspan="3">
                  <ai:dbformfield fieldname="INTERFACE_CLASS" width="450" formid="UserDefineFieldForm"/>
		</td>
             </tr>
             <tr>
		<td class="FormTDName">备注：</td>
		<td class="FormTD" colspan="3"><ai:dbformfield fieldname="STATE" visible="false" width="150" formid="UserDefineFieldForm"/>
		  <ai:dbformfield fieldname="REMARKS" width="450" formid="UserDefineFieldForm"/>
		</td>
	     </tr>
	  </table>
	</ai:dbform>
      </fieldset>
    </td>
  </tr>

    <tr align="center">
      <td>
	  <table align="center" style="width:600;text-align:center;font-size:12">
	  <tr align="center">
	    <td align="center">
	      <img src="/image/button/save.gif" style="cursor:hand;" align="absmiddle"   value="保存" name="btn_save" onclick="Save()" >
	    </td>
	  </tr>
	  </table>
    </td>
    </tr>
</table>

</body>
</html>

<script LANGUAGE="JavaScript" for="window" even="onload">
  var strParameterarr = window.dialogArguments;
  var strPropId = strParameterarr[0];
  var strPageLayoutId = strParameterarr[1];
  var strBusinessObjectId = strParameterarr[2];
  var strOperType = strParameterarr[3];
  init();

  function init() {
    if (strOperType != "add") {
    	g_FormRowSetManager.get("UserDefineFieldForm").refresh("PROP_ID = " + strPropId);
    }
    if ( strOperType == "add"){
      Add();
    }else if (strOperType == "modify"){
      Edit();
    }else{
      Delete();
    }
  }

  function Add(){
    setStatus(strOperType);
    g_FormRowSetManager.get("UserDefineFieldForm").newRow();
    //此处set值是为了NAME的下拉数据源的方法能够执行
    g_FormRowSetManager.get("UserDefineFieldForm").setValue("PROP_ID","-1");
    g_FormRowSetManager.get("UserDefineFieldForm").setValue("PAGELAYOUT_ID",strPageLayoutId);
    g_FormRowSetManager.get("UserDefineFieldForm").setValue("BUSINESS_OBJECT_ID",strBusinessObjectId);
    g_FormRowSetManager.get("UserDefineFieldForm").setColEditSts("BUSINESS_OBJECT_ID",false);
    g_FormRowSetManager.get("UserDefineFieldForm").setValue("STATE","U");
    g_FormRowSetManager.get("UserDefineFieldForm").setValue("IS_MUST","N","否");
  }

  function Save(){
    if(confirm("您确定要保存吗？")){
      	var strBusinessObjectId = g_FormRowSetManager.get("UserDefineFieldForm").getValue("BUSINESS_OBJECT_ID");
      	var strTitle = g_FormRowSetManager.get("UserDefineFieldForm").getValue("TITLE");
      	var strName  = g_FormRowSetManager.get("UserDefineFieldForm").getValue("NAME");
       	var strEditType = g_FormRowSetManager.get("UserDefineFieldForm").getValue("EDIT_TYPE");
       	//var strDecimalNum =  g_FormRowSetManager.get("UserDefineFieldForm").getValue("DECIMAL_NUM");
      	if ( strOperType != "delete" && strBusinessObjectId == null || strBusinessObjectId == ""){
           alert("业务对象不可为空,请输入!");
           return;
      	}
      	if ( strOperType != "delete" && strTitle == null || strTitle == ""){
           alert("字段标题不可为空,请输入!");
           return;
      	}
      	if ( strOperType != "delete" && strName == null || strName == ""){
           alert("字段名称不可为空,请输入!");
           return;
      	}
      	if ( strOperType != "delete" && strEditType == null || strEditType == ""){
           alert("编辑类型不可为空,请输入!");
           return;
      	}
        //判断字段标题是否存在
        var strIsTitleExist = PostInfotoServer("/business/com.ai.appframe2.udfpage.action.UserDefineFieldDataAction?action=getIsFieldTitleExists&PageLayoutId=" + strPageLayoutId + "&BusinessObjectId=" + strBusinessObjectId + "&Title=" + strTitle + "&FieldName=" + strName,'');
        if (strIsTitleExist == "Y"){
          alert("在对应的页面布局和业务对象自定义字段定义中,字段标题已经存在,请重新设置!");
          return;
        }
        //将设置的prop_id值清空
        if ( strOperType == "add"){
          g_FormRowSetManager.get("UserDefineFieldForm").setValue("PROP_ID","");
        }
    	var list = new Array();
    	list.push(g_FormRowSetManager.get("UserDefineFieldForm"));
    	saveRowSet('/business/com.ai.appframe2.udfpage.action.UserDefineFieldDataAction?action=saveUserDefineFieldData',list);
        window.close();
    }
  }

  function Delete(){
    var rowSet = g_FormRowSetManager.get("UserDefineFieldForm");
    rowSet.setValue("STATE",'E');
    setStatus(strOperType);
  }

  function Edit() {
    setStatus("modify");
    setStatus(strOperType);
    g_FormRowSetManager.get("UserDefineFieldForm").setColEditSts("BUSINESS_OBJECT_ID",false);
    g_FormRowSetManager.get("UserDefineFieldForm").setColEditSts("PAGELAYOUT_ID",false);
  }

  function setStatus(status){
    if(status == "delete"){
      g_FormRowSetManager.get("UserDefineFieldForm").setEditSts(false);
    }
    else if ((status == "add") || (status = "modify")){
      g_FormRowSetManager.get("UserDefineFieldForm").setEditSts(true);
      g_FormRowSetManager.get("UserDefineFieldForm").setColEditSts("BUSINESS_OBJECT_ID",false);
      g_FormRowSetManager.get("UserDefineFieldForm").setColEditSts("PAGELAYOUT_ID",false);
    }
  }

  function Input(){
    var strPropValue =  window.showModalDialog("/jsv2/udfpage/ValueListInputDlg.jsp",window,"scroll:yes;resizable:no;status:no;help:no;dialogHeight:200px;dialogWidth:300px");
    if (strPropValue != null && strPropValue != "" && strPropValue != "null"){
    	var strPropValues = g_FormRowSetManager.get("UserDefineFieldForm").getValue("VALUE_LIST_ID");
        if (strPropValues == null || strPropValues == ""){
          g_FormRowSetManager.get("UserDefineFieldForm").setValue("VALUE_LIST_ID",strPropValue);
        }else{
          g_FormRowSetManager.get("UserDefineFieldForm").setValue("VALUE_LIST_ID",strPropValues + ";" + strPropValue);
        }
    }
  }


</script>
