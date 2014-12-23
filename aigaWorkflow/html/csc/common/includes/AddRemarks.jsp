<%@ page contentType="text/html;charset=GBK"%>
<%@ page isELIgnored="false" %>
<%@ include file="/secframe/common/common.jsp"%>
<%@ include file="/webframe/common/commonhead.jsp"%>
<%@ include file="/webframe/jspcommon/includedhead.jsp"%>
<%@ include file="/csc/common/css/aialm_style.jsp"%>
<%
	String objTag=request.getParameter("objTag");
	String objType=request.getParameter("objType");
	String remarkId=request.getParameter("remarkId");
 %>
<html>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/csc/common/css/aialm_style_css.jsp" type="text/css">
	<head>
	<title>������ע</title>
	</head>
	<body>
		<div>
			<table align="center" width="100%">
				<ai:dbform formid="frmRemarks" setname="com.asiainfo.csc.common.web.SETReqRemarks"
					initial="false" editable="true" onvalchange="">
					<ai:dbformfield fieldname="REMARK_ID" formid="frmRemarks" visible="false"/>
					<ai:dbformfield fieldname="OBJ_TAG" formid="frmRemarks" visible="false"/>
					<ai:dbformfield fieldname="OBJ_TYPE" formid="frmRemarks" visible="false"/>
					<ai:dbformfield fieldname="CREATE_TIME" formid="frmRemarks" visible="false"/>
					<ai:dbformfield fieldname="CHANGE_TIME" formid="frmRemarks" visible="false"/>
					<tr>
						<td class="title_e" align="right" width="80">��ע��Ϣ</td>
						<td class="aiEdit_3col"><ai:dbformfield fieldname="REMARKS" formid="frmRemarks" editable="true"  height="<%=aiEditArea_high_min%>" width="<%=aiEditArea_2cwmin%>"/></td>
		    		</tr>			
				</ai:dbform>
				<tr>
  					<td width="100%" align="right" colspan="2">
	            	  <input type="submit" class="btn-4word" value="������Ϣ" onclick="saveRemarks()"/>
	            	</td>
	            </tr>
			</table>
		</div>
	</body>
	<script type="text/javascript">
	var remarkForm = g_FormRowSetManager.get("frmRemarks");
	init();
	function init(){
		if('<%=remarkId%>'.length>0){
			remarkForm.refresh("REMARK_ID=<%=remarkId%>");
		}else{
			remarkForm.setValue("OBJ_TAG",'<%=objTag%>');
			remarkForm.setValue("OBJ_TYPE",'<%=objType%>');
		}
	}
	function saveRemarks(){
		var str=remarkForm.getValue('REMARKS');
	 	str=str.replace(/^\s+|\s+$/g,"");
		if(str.length==0){
			alert("��ע��Ϣ����Ϊ��");
			return;
		}else if(str.length>200){
	     	alert('��ע��Ϣ����200���ַ�,���ܱ���');
	     	return;
	  	}
		var list=new Array();
		list.push(remarkForm);
		var url ='<%=request.getContextPath()%>' + '/business/com.asiainfo.csc.common.web.RemarksAction?action=saveRemarks';
		var rtn = saveRowSet(url,list);
	  	if(rtn.getValueByName("retVal")=='Y'){
	   		window.dialogArguments.refreshRemarksList();
	   		window.close();
	   }
	}
	</script>
</html>
