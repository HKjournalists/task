<%@ page language="java" pageEncoding="GBK"%>
<%@ page contentType="text/html; charset=GBK"%>
<%@page import="com.asiainfo.csc.matrix.common.ConstDefine"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="<%=request.getContextPath()%>/csc/js/reqCommonJs.js"></script>
</head>
<body>
<ai:dbform formid="approvalFormTemp" setname="com.asiainfo.csc.matrix.web.SETAlmStakeholder" initial="false" editable="true">
	 <ai:dbformfield fieldname="STDHOLDER_ID" formid="approvalFormTemp" visible="false"/>
	 <ai:dbformfield fieldname="LINK_ID" formid="approvalFormTemp" visible="false"/>
	 <ai:dbformfield fieldname="LINK_NO" formid="approvalFormTemp" visible="false"/>
	 <ai:dbformfield fieldname="STDHOLDER_STAFF_ID" formid="approvalFormTemp" visible="false"/>
	 <ai:dbformfield fieldname="STDHOLDER_STAFF_NO" formid="approvalFormTemp" visible="false"/>
	 <ai:dbformfield fieldname="STDHOLDER_STAFF_NAME" formid="approvalFormTemp" visible="false"/>
	 <ai:dbformfield fieldname="STDHOLDE_TYPE" formid="approvalFormTemp" visible="false"/>
	 <ai:dbformfield fieldname="OBJ_ID" formid="approvalFormTemp" visible="false"/>
	 <ai:dbformfield fieldname="TEMPLATE_ID" formid="approvalFormTemp" visible="false"/>
</ai:dbform>
</body>
<script type="text/javascript">
reqCommonMethod.componentUrl = '<%=request.getContextPath()%>/business/com.asiainfo.csc.matrix.web.WorkflowComponentConfigAction?action=getComponentConfig';
reqCommonMethod.componentJsonUrl = '<%=request.getContextPath()%>/business/com.asiainfo.csc.matrix.web.WorkflowComponentConfigAction?action=getComponentConfigJson';
reqCommonMethod.addComponentUrl = '<%=request.getContextPath()%>/business/com.asiainfo.csc.matrix.web.WorkflowComponentConfigAction?action=addComponentConfig';
reqCommonMethod.stakeholderType = '<%=ConstDefine.STAKEHOLDERTYPE_WF%>';
reqCommonMethod.userId = "${userInfo.ID}";
reqCommonMethod.contextPath = '<%=request.getContextPath()%>';

</script>
</html>