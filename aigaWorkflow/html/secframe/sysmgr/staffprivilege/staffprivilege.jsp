<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.ai.appframe2.privilege.UserInfoInterface" %>
<%@include file="/secframe/common/common.jsp"%>
<html>
<head>
<% 		
  
  UserInfoInterface curuser = SessionManager.getUser();
  long userId = curuser.getID();
  String userName = curuser.getName();
  

  
  //��ȡ��ǰ�û�ӵ�еĸ�λ��Ϣ
  String cond = "staff_id = :staff_id  and IS_AUTHOR = 'Y'  and state = 1 and AUTHOR_VALID_DATE<sysdate and AUTHOR_EXPIRE_DATE>sysdate ";
  request.setAttribute("condition", cond);
  HashMap map = new HashMap();
  map.put("staff_id" , new Long(userId));
  
  request.setAttribute("parameter" ,map);
  
  request.setAttribute("staff_id" ,new Long(userId));
  
%>
<title>�ּ���Ȩ</title>
</head>
<body onLoad="resizeTable()" onResize="resizeTable()">
<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
  <tr>
    <td class="tdhead"><table width="250" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
        <tr>
          <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
          <td style="height: 20px">����Ȩ��</td>
          <td align="right" style="height: 20px"></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" align="left"><ai:table
							setname="com.ai.secframe.bo.sysmgr.SysAuthor"
							tableid="author_table" 
							tablemodel="com.ai.secframe.web.sysmgr.SysMgrQueryModelForService"
							initial="true" multiselect="true" needrefresh="true"
							conditionname="condition" parametersname="parameter" editable="false" width="600"
							height="180" 
							implservice_name="com.ai.secframe.service.sysmgr.SysAuthor"
							implservice_querymethod="querySysAuthor"
							implservice_countmethod="querySysAuthorCount">
        <ai:col fieldname="STAFF_ID" width="100" editable="false" title="Ȩ��ӵ����" />
        <ai:col fieldname="STATION_ID" width="100" />
        <ai:col fieldname="IS_AUTHOR" width="100"  />
        <ai:col fieldname="IS_REAL_OPERATION"  width="100" />
        <ai:col fieldname="AUTHOR_VALID_DATE" width="130"   />
        <ai:col fieldname="AUTHOR_EXPIRE_DATE" width="130"  />
        <ai:col fieldname="AUTHOR_TYPE" width="100" />
        <ai:col fieldname="AUTHOR_ID" width="100" visible="false" />
      </ai:table>
      <div align="center" style="height:30px; padding-top:6px;">
        <input name="button"  type="button" id="btnAddReAuthor" class="btn-5word" onClick="addReAuthor()" value="��������Ȩ"/>
      </div></td>
  </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
  <tr>
    <td class="tdhead"><table width="250" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
        <tr>
          <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
          <td style="height: 20px">���ڳ�Ȩ��</td>
          <td align="right" style="height: 20px"></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" align="left"><ai:table
							setname="com.ai.secframe.bo.sysmgr.SysAuthor"
							tableid="own_table" footdisplay="none"
							tablemodel="com.ai.appframe2.web.datamodel.MethodModelForService"
							initial="true" multiselect="true" needrefresh="true"
							editable="true" width="600" height="150"
							implservice_name="com.ai.secframe.service.sysmgr.SysAuthor"
							implservice_querymethod="queryStaffReAuthor(long staff_id)">
        <ai:col fieldname="STAFF_ID" width="100" editable="false" title="����Ȩ����" />
        <ai:col fieldname="STATION_ID" width="100" editable="false" />
        <ai:col fieldname="IS_AUTHOR" width="100"  />
        <ai:col fieldname="IS_REAL_OPERATION"  width="100" />
        <ai:col fieldname="AUTHOR_VALID_DATE" width="130" />
        <ai:col fieldname="AUTHOR_EXPIRE_DATE" width="130" />
        <ai:col fieldname="AUTHOR_ID" width="100" visible="false" />
        <ai:col fieldname="AUTHOR_TYPE" width="100" editable="false" />
      </ai:table>
      <div align="center" style="height:30px; padding-top:6px;">
        <input name="button3"  type="button" id="deleteReAuthor" class="btn-4word" onClick="drawBackReAuthorData()" value="����Ȩ��"/>
        &nbsp;
        <input name="button3"  type="button" id="saveReAuthor" class="btn-2word" onClick="saveReAuthor()" value="����"/>
      </div></td>
  </tr>
</table>

</BODY>
<script type="text/javascript">
  var userName = "<%=userName%>";
  var ownAuthorData = g_TableRowSetManager.get("author_table");
  var reAuthorData = g_TableRowSetManager.get("own_table");
  
  function resizeTable(){
    var w = document.body.offsetWidth-50;
    ownAuthorData.resize(w,200);
    reAuthorData.resize(w,150);
  }
  
  //����Ȩ��ӵ����
  function refreshStaffName()
  {
   var count = ownAuthorData.count();
   for(i=0;i<count;i++){
    ownAuthorData.setValue(i,"STAFF_ID",userName);
   }
  }
  refreshStaffName();
  
  //��������Ȩ
  function addReAuthor(){
    //��ȡѡ���Ȩ������
    var list = ownAuthorData.getSelectedRows();
    if(list==null || list.length==0){
      alert('����ѡ������Ȩ������!');
      return;
    }
    
    
	var	arrStaff = new Array();
	var paraObj = new Object();
	paraObj.arrStaff = arrStaff;
	paraObj.singleFlag = false;
	paraObj.winObj = window;
    var ret = window.showModalDialog("../../orgmodel/staff/QSysStaffSelect.jsp?staffprivilege=staffprivilege",paraObj,"scroll:no;resizable:no;status:no;dialogHeight:700px;dialogWidth:900px");
    if(ret ==null) return;
    
    var user_ids = ret[0];
    var user_names = ret[1];

    if(!confirm("ȷʵҪ����ѡ���Ȩ�޵���Ȩ�� " + user_names + "��?"))return;
    
    //��ȡȨ�޵�����
    var author_ids = "";
    for(i=0;i<list.length;i++){
     
        author_ids = author_ids + ";" + ownAuthorData.getValue(list[i],"AUTHOR_ID");
     
    }
    
    //��ʼ��������
     var  result = PostInfotoServer( "<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysAuthoriseAction?action=addReAuthorStation&user_ids="
          +user_ids,author_ids);
    if(result=='OK'){
      reAuthorData.refresh("staff_id=<%=userId%>");
      ownAuthorData.refresh("<%="staff_id = " + userId + " and IS_AUTHOR = 'Y'  and state = 1 and AUTHOR_VALID_DATE<sysdate and AUTHOR_EXPIRE_DATE>sysdate "%>")
      refreshStaffName();
      alert('��Ȩ�ɹ�!');
    }else{
      alert(result);
    }
  }
  
  //��������Ȩ������
  function saveReAuthor(){
    if(reAuthorData.toXmlString(true)=="") {
      alert("����Ȩ����δ���κ��޸�!");
      return ;
    }
    
    var list = new Array();
    list.push(reAuthorData);
    
    var retMsg = saveRowSet("<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysAuthoriseAction?action=saveReAuthorStation",list);
    var msg = retMsg.getValueByName("retVal");

    if(msg=="OK"){
      reAuthorData.refresh("staff_id=<%=userId%>");
      alert("����Ȩ�����޸ĳɹ�!");
    }else{
      alert(msg);
    }
  }
  
  //��������Ȩ����
  function drawBackReAuthorData(){
    //��ȡѡ���Ȩ������
    var list = reAuthorData.getSelectedRows();
    if(list==null || list.length==0){
      alert('����ѡ��Ҫ���յ�����Ȩ����!');
      return;
    }
    
    if(!confirm("ȷʵҪ����Ȩ����"))return;
    
    //��ȡȨ�޵�����
    var author_ids = "";
    for(i=0;i<list.length;i++){
      if(i==0){
        author_ids = reAuthorData.getValue(0,"AUTHOR_ID");
      }else{
        author_ids = author_ids + ";" + reAuthorData.getValue(list[i],"AUTHOR_ID");
      }
    }
    
    //��ʼ��������
     var  result = PostInfotoServer( "<%=request.getContextPath()%>/business/com.ai.secframe.web.sysmgr.SysAuthoriseAction?action=drawBackReAuthorData"
         ,author_ids);
    if(result=='OK'){
      reAuthorData.refresh("staff_id=<%=userId%>");
      ownAuthorData.refresh("<%="staff_id = " + userId + " and IS_AUTHOR = 'Y'  and state = 1 and AUTHOR_VALID_DATE<sysdate and AUTHOR_EXPIRE_DATE>sysdate "%>")
      refreshStaffName();
      alert('Ȩ�޻��ճɹ�!');
    }else{
      alert(result);
    }
  }
</script>
</HTML>