<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/secframe/common/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>Ա������</title>
<%
		String staffId = request.getParameter("staffId");
		 %>
</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="33%"><ai:dbform formid="dbformStaff"
						setname="com.ai.secframe.bo.orgmodel.SysStaff"
						datamodel="com.ai.appframe2.web.datamodel.QueryModelForService"
						implservice_name="com.ai.secframe.service.orgmodel.SysStaff"
						implservice_querymethod="querySysStaff" initial="false"
						editable="false">
      <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px"> ����Ա��Ϣ</td>
                <td align="right" style="height: 20px"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="left" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" height="200">
              <tr>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">����</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack" nowrap="nowrap"><ai:dbformfield formid="dbformStaff" fieldname="CODE" width="60" height="20" editable="true" visible="true" /><input name="radom" type="button" class="btn-2word" id="radom" value="���" onClick="radom()"><input name="check" type="button" class="btn-2word" id="check" value="��֤" onClick="check()"></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">����״̬</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformStaff" fieldname="LOCK_FLAG"  width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">���Դ���</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformStaff" fieldname="TRY_TIMES" width="100" height="20" editable="true" visible="true" /></td>
              </tr>
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">����</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformStaff" fieldname="PASSWORD" width="100" height="20" editable="true"  visible="true"/></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1"> �ظ�����</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><input type="password" name="password2" id="password2"  style="width:100px" class="FormTD"></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">�Ƿ������޸�����</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformStaff" fieldname="ALLOW_CHANGE_PASSWORD" width="100" height="20" editable="true" visible="true" /></td>
              </tr>
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">��Ч����</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformStaff" fieldname="ACCT_EFFECT_DATE" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">ʧЧ����</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformStaff" fieldname="ACCT_EXPIRE_DATE" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1"> ���е�¼</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformStaff" fieldname="MULTI_LOGIN_FLAG" width="100" height="20" editable="true" visible="true" /></td>
              </tr>
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">�����޸���������</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformStaff" fieldname="CHG_PASSWD_ALARM_DAYS" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">�����޸�У�����</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformStaff" fieldname="RECENT_PASS_TIMES" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1"> ��С���볤��</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformStaff" fieldname="MIN_PASSWD_LENGTH" width="100" height="20" editable="true" visible="true" /></td>
              </tr>
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">IPMAC��</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformStaff" fieldname="BAND_TYPE" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">����Ա����</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformStaff" fieldname="OP_LVL" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">����Ա����</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformStaff" fieldname="OP_TYPE" width="100" height="20" editable="true" visible="true" /></td>
              </tr>
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">BOMC�û����</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformStaff" fieldname="EXT1" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">������Ŀ���</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformStaff" fieldname="EXT2" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">��չ����3</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformStaff" fieldname="EXT3" width="100" height="20" editable="true" visible="true" /></td>
              </tr>
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">��ע</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" colspan="9" class="font13pxboldblack"><ai:dbformfield formid="dbformStaff" fieldname="NOTES" width="300" height="20" editable="true" visible="true" />
                  <ai:dbformfield formid="dbformStaff" fieldname="STAFF_ID" width="150" height="20" editable="true" visible="false" />
                  <ai:dbformfield formid="dbformStaff" fieldname="EMPLOYEE_ID" width="150" height="20" editable="true" visible="false" />
                </td>
              </tr>
             <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
            </table></td>
        </tr>
      </table>
      </ai:dbform>
      </td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px">������֯
                  </td>
                <td align="right" style="height: 20px"><input class="btn-2word" name="addOrgRelate" type="button" id="addOrgRelate" onClick="addOrgRelate()" value="����">
                  <input name="delOrgRelate" class="btn-2word" type="button" id="delOrgRelate" onClick="delOrgRelate()" value="ɾ��"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="left"><ai:table tableid="orgRelat"
										setname="com.ai.secframe.bo.orgmodel.SysStaffOrgRelat"
										initial="false" multiselect="true" editable="true" footdisplay="none"
										tablemodel="com.ai.appframe2.web.datamodel.QueryModelForService"
										implservice_name="com.ai.secframe.service.orgmodel.SysStaffOrgRelat"
										implservice_querymethod="querySysStaffOrgRelat"
										implservice_countmethod="querySysStaffOrgRelatCount"
										width="100%" height="60" needrefresh="true">
              <ai:col fieldname="STAFF_ORG_RELAT_ID" width="100"
											editable="false" visible="false" />
              <ai:col fieldname="STAFF_ID" width="100" editable="false"
											visible="false" />
              <ai:col fieldname="ORGANIZE_ID" width="260" editable="false"
											visible="true" />
              <ai:col fieldname="IS_ADMIN_STAFF" width="100" editable="true"
											visible="true" />
              <ai:col fieldname="IS_BASE_ORG" width="100" editable="true"
											visible="true" />
			  <ai:col fieldname="STATE" width="100" editable="false"
											visible="true" />							
            </ai:table>
          </td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td><ai:dbform formid="dbformEmployee"
						setname="com.ai.secframe.bo.orgmodel.SysEmployee"
						datamodel="com.ai.appframe2.web.datamodel.QueryModelForService"
						implservice_name="com.ai.secframe.service.orgmodel.SysEmployee"
						implservice_querymethod="querySysEmployee" initial="false" 
						editable="false">
      <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B6D1DC">
        <tr>
          <td class="tdhead"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="font13pxboldblue">
              <tr>
                <td width="40" style="height: 20px">&nbsp;&nbsp;<img src="../../images/circle.gif" width="12" height="12" /></td>
                <td style="height: 20px">��Ա��Ϣ</td>
                <td align="right" style="height: 20px"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" align="left" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" height="200">
              <tr>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">����
                  </td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack" nowrap="nowrap"><ai:dbformfield formid="dbformEmployee" fieldname="EMPLOYEE_NAME" width="100" height="20" editable="true" visible="true" /><input name="selectEmployee" class="btn-1word" type="button" id="selectEmployee" onClick="selectEmployee()" value=".."></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">�ֻ���</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="BILL_ID" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">֤������</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="CARD_TYPE_ID" width="100" height="20" editable="true" visible="true" /></td>
              </tr>
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">֤������</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="CARD_NO" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1"> ���</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="SHORT_NAME" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">Ӣ������</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="ENGLISH_NAME" width="100" height="20" editable="true" visible="true" /></td>
              </tr>
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1"> �Ա�</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="GENDER" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">��������</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="BIRTHDAY" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1"> ����״��</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="MARRY_STATUS" width="100" height="20" editable="true" visible="true" /></td>
              </tr>
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">����</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="NATIONAL_TYPE" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">ѧ��</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="EDUCATION_LEVEL" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">����</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="INCOME_LEVEL" width="100" height="20" editable="true" visible="true" /></td>
              </tr>
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">������ò</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="POLITICS_FACE" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">ְλ</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="JOB_POSITION" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">ְ��˵��</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="JOB_DESC" width="100" height="20" editable="true" visible="true" /></td>
              </tr>
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">��ͥ�绰</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="HOME_TEL" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">�칫�绰</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="OFFICE_TEL" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">�ڽ�����</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="RELIGION" width="100" height="20" editable="true" visible="true" /></td>
              </tr>
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">������Ϣ</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="FAMILY_INFO" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">�Ը��ص�</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="CHARACTER_DESC" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">�ʱ�</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="POSTCODE" width="100" height="20" editable="true" visible="true" /></td>
              </tr>
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">email</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="EMAIL" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">�籣</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="ALARM_BILL_ID" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">����</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="CAR_NO" width="100" height="20" editable="true" visible="true" /></td>
              </tr>
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">������λ</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="JOB_COMPANY" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">��ϵ��ַ</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="CONTACT_ADDRESS" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">��ע</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="NOTES" width="100" height="20" editable="true" visible="true" /></td>
              </tr>
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
              <tr>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">Ա����չ1</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="EXT1" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">Ա����չ2</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="EXT2" width="100" height="20" editable="true" visible="true" /></td>
                <td width="1"></td>
                <td width="80" bgcolor="#E5EFF5" class="font13pxboldblue1">Ա����չ3</td>
                <td width="1"></td>
                <td bgcolor="#F1F3FB" class="font13pxboldblack"><ai:dbformfield formid="dbformEmployee" fieldname="EMPLOYEE_ID" width="150" height="20" editable="true" visible="false" />
                  <ai:dbformfield formid="dbformEmployee" fieldname="EXT3" width="100" height="20" editable="true" visible="true" /></td>
              </tr>
              <tr>
                <td height="1" class="font13pxboldblue1"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
                <td width="1"></td>
                <td class="font13pxboldblack"></td>
              </tr>
            </table></td>
        </tr>
      </table>
      </ai:dbform></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="center"><input class="btn-2word" name="addstaff" type="button" id="addstaff" value="����" onClick="addStaff()">
      <input name="save" onClick="save()" type="button" id="save" class="btn-2word" value="����">
      <input name="delete" type="button" id="delete" value="ͣ��" class="btn-2word" onClick="deleteStaff()">
      <input name="changePass" type="button" id="changePass" class="btn-4word" onClick="changePass()" value="�޸�����">
      <input onClick="resetPass()" name="reset" type="button" id="reset" class="btn-4word" value="��������">
      <input name="clearAuthor" onClick="clearAuthor()" type="button" id="clearAuthor" class="btn-4word" value="���Ȩ��">
      <input name="restart" type="button" onClick="restart()" id="restart" class="btn-2word" value="����">
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
</body>
<script language="javascript">
	var staffId = <%=staffId%>;
	var dbformStaff = g_FormRowSetManager.get("dbformStaff");
	var dbformEmployee = g_FormRowSetManager.get("dbformEmployee");
	var orgRelat = g_TableRowSetManager.get("orgRelat");
	var addFlag = false;
   //------------------------������� ֻ����ӵ�ʱ������� �����ֶβ������޸�
   function radom(){
   		var org_id=parent.cur_orgId;
  		if(org_id!=""&&org_id!=null){
			var msg = PostInfo("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysStaffAction?action=getCode&org_id="+org_id);
			var result = msg.getValueByName("retVal");
			//alert(result); 
			if(result=="-1"){
				alert("��ȡregCodeʧ�ܣ�");
			}else{
				//result = result.substr(0,1);
				 dbformStaff.setValue("CODE",result);
			}	
		}
   }
   //------------------------�������
   //------------------------������֤ ֻ����ӵ�ʱ����� �����ֶβ������޸�
   function check(){
   		var org_id=parent.cur_orgId;
  		var code = dbformStaff.getValue("CODE");
  		if(code.length!=7){
  			alert("���ű���Ϊ����������֯�������6λ���ֹ���");
  			return;
  		}
  		if(org_id!=""&&org_id!=null){
			var msg = PostInfo("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysStaffAction?action=checkCode&code="+code);
			var result = msg.getValueByName("retVal");
			//alert(result); 
			if(result=="-1"){
				alert("�˹����Ѿ���ʹ�ã����������룡");
				return;
			}else{
				alert("�˹��ſ���ʹ�ã�");
			}	
		}
   
   }
   //------------------------������֤
	
	//---------------������֯����
	function addOrgRelate(){
		var paramObj = new Object();
		var dbformRelat = orgSelectDialog(<%=com.ai.appframe2.common.SessionManager.getUser().getOrgId()%>);

		if(dbformRelat != null){			
			orgRelat.newRow();
			orgRelat.setValue(orgRelat.getRow(),"ORGANIZE_ID",dbformRelat[0].orgId,dbformRelat[0].orgName);
			orgRelat.setValue(orgRelat.getRow(),"IS_ADMIN_STAFF","N","N");
			orgRelat.setValue(orgRelat.getRow(),"IS_BASE_ORG","N","N");
			if(dbformStaff.getValue("STAFF_ID")>0)
				orgRelat.setValue(orgRelat.getRow(),"STAFF_ID",dbformStaff.getValue("STAFF_ID"),dbformStaff.getValue("STAFF_ID"));
		}
	}
	
	function delOrgRelate(){
		if( orgRelat.getSelectedRows()!=null&&orgRelat.getSelectedRows().length>0&&window.confirm("ȷ��Ҫɾ��ѡ�еĹ�����?") ){
		  		var selRows = orgRelat.getSelectedRows();
		  			for( i=selRows.length-1;i>=0;i--){	  			
		       		orgRelat.deleteRow(selRows[i]);
		     	}
		 }
		 else
		 {
		  alert("��ѡ��Ҫɾ���Ĺ�����");
		 }
	}
	//--------------������֯������ť

	//---------------��Աѡ�� selectEmployee
	function selectEmployee(){
		var result = window.showModalDialog("EmployeeList.jsp?type=selectEmployee","org","scroll:no;resizable:no;status:no;dialogHeight:590px;dialogWidth:400px");
		if(result=='undefined'||result==null){
			result="";
		} else {
			dbformEmployee.refresh("EMPLOYEE_ID="+result);
			dbformStaff.setValue("EMPLOYEE_ID",result);
			
		}
	}
	//-----------��Աѡ��
	
	//-------����Ա��
	function addStaff(){

		 if(parent.cur_orgId==null||parent.cur_orgId==''||parent.cur_orgId==-1)
		 {
		 	alert("ѡ��һ��Ҫ���Ա������֯��");
		 	parent.QueryByOrg();
		 	return ;
		 }
		 init(-1,-1);
		 dbformStaff.setValue("LOCK_FLAG","N");
	     dbformStaff.setColEditSts("LOCK_FLAG",false);
	     dbformStaff.setValue("TRY_TIMES","3");
	     dbformStaff.setColEditSts("TRY_TIMES",false);
	     dbformStaff.setValue("ALLOW_CHANGE_PASSWORD","Y");
	     dbformStaff.setColEditSts("ALLOW_CHANGE_PASSWORD",false);
	     dbformStaff.setValue("ACCT_EFFECT_DATE",g_GetSysDateTime().substr(0,10));
	     dbformStaff.setColEditSts("ACCT_EFFECT_DATE",false);
	     dbformStaff.setValue("ACCT_EXPIRE_DATE","2099-12-31");
	     dbformStaff.setColEditSts("ACCT_EXPIRE_DATE",false);
	     dbformStaff.setValue("MULTI_LOGIN_FLAG","Y");
	     dbformStaff.setColEditSts("MULTI_LOGIN_FLAG",false);
	     dbformStaff.setValue("CHG_PASSWD_ALARM_DAYS","30");
	     dbformStaff.setColEditSts("CHG_PASSWD_ALARM_DAYS",false);
	     dbformStaff.setValue("RECENT_PASS_TIMES","3");
	     dbformStaff.setColEditSts("RECENT_PASS_TIMES",false);
	     dbformStaff.setValue("MIN_PASSWD_LENGTH","6");
	  	 dbformStaff.setColEditSts("MIN_PASSWD_LENGTH",false);
	     if(parent.cur_orgId>0)
	     {
		  orgRelat.newRow();
		  orgRelat.setValue(orgRelat.getRow(),"ORGANIZE_ID",parent.cur_orgId,parent.cur_orgName);
		  orgRelat.setValue(orgRelat.getRow(),"IS_ADMIN_STAFF","N","N");
		  orgRelat.setValue(orgRelat.getRow(),"IS_BASE_ORG","Y","Y");
		  orgRelat.setValue(orgRelat.getRow(),"STATE","1","1");
	     }
	}
	//-------����Ա��
	
	//--------����--
	/**
		����Ҫ��֤����ĺϷ���	
	*/
	function save(){
		//----------�����жϹ����Ƿ������
		 if(dbformStaff.getValue("STAFF_ID")<=0)//˵���������û�
     	 {
     	 	var code = dbformStaff.getValue("CODE");
			var msg = PostInfo("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysStaffAction?action=checkCode&code="+code);
			var result = msg.getValueByName("retVal");
			//alert(result); 
			if(result=="-1"){
				alert("�˹����Ѿ���ʹ�ã����������룡");
				return;
			}
			var psw = dbformStaff.getValue("PASSWORD") ;
			if(psw.indexOf(" ")>=0 || psw.indexOf("&")>=0 || psw.indexOf("^")>=0)
			{
			  alert("�����м䲻�����п��ַ����ߡ�&��,��^���ַ�����");
			  dbformStaff.setFocus("PASSWORD");
			  return;
			}
				
			if((/^[0-9a-zA-Z]{6,}$/g.test(psw))){
			    if(/^[0-9]{6,}$/g.test(psw)||/^[a-z]+$/g.test(psw)||/^[A-Z]+$/g.test(psw)){
			   	alert("��������Ǵ�Сд��ĸ�����ֵ����");
			   	dbformStaff.setFocus("PASSWORD");
			     return;
				}
			
			}
				
			var tempStr='';
			var bNum=false;
			var bStr=false;
			var bUpperStr=false;
			for(var i=0;i<psw.length;i++){
				tempStr=psw.charAt(i);
				if(!isNaN(tempStr)){
				bNum=true;
				}
				if(/^[a-z]$/.test(tempStr)){
				bStr=true;
				}
				if(/^[A-Z]$/.test(tempStr)){
				bUpperStr=true;
				}
			}
			if(bNum!=true||bStr!=true||bUpperStr!=true){
			  alert("��������Ǵ�Сд��ĸ�����ֵ����");
			  dbformStaff.setFocus("PASSWORD");
			  return;
			}
			if(dbformStaff.getValue("PASSWORD").length<dbformStaff.getValue("MIN_PASSWD_LENGTH"))
		   {
		     alert("���볤�Ȳ���С����С���볤��"+dbformStaff.getValue("MIN_PASSWD_LENGTH"));
		     dbformStaff.setFocus("PASSWORD");
		     return ;
		   }
	
		   if( dbformStaff.getValue("PASSWORD") != document.all("password2").value ){
		      alert("ȷ���������������һ�£�");
		      document.all("password2").focus();
		      return;
		   }	
		 }//�����֤
		 
		 
		   	   	   
		   if( dbformStaff.getValue("TRY_TIMES") == null ||
		       dbformStaff.getValue("TRY_TIMES") == "" ){
		      alert("��¼���Դ�������Ϊ��");
		      dbformStaff.setFocus("TRY_TIMES");
		      return;
		   }	   	   
		   if( dbformStaff.getValue("ALLOW_CHANGE_PASSWORD") == null ||
		       dbformStaff.getValue("ALLOW_CHANGE_PASSWORD") == "" ){
		      alert("��ѡ���Ƿ������޸�����");
		      dbformStaff.setFocus("ALLOW_CHANGE_PASSWORD");
		      return;
		   }	   
		   if( dbformStaff.getValue("ACCT_EFFECT_DATE") == null ||
		       dbformStaff.getValue("ACCT_EFFECT_DATE") == "" ){
		      alert("�ʺ���Ч���ڲ���Ϊ��");
		      dbformStaff.setFocus("ACCT_EFFECT_DATE");
		      return;
		   }	   
		   if( dbformStaff.getValue("ACCT_EXPIRE_DATE") == null ||
		       dbformStaff.getValue("ACCT_EXPIRE_DATE") == "" ){
		      alert("�ʺ�ʧЧ���ڲ���Ϊ��");
		      dbformStaff.setFocus("ACCT_EXPIRE_DATE");
		      return;
		   }	   
		    if(dbformStaff.getValue("ACCT_EFFECT_DATE")!=null && dbformStaff.getValue("ACCT_EXPIRE_DATE")!=null)
		    {
				var effectDateArray = dbformStaff.getValue("ACCT_EFFECT_DATE").split("-");
				var effectDate = new Date(parseInt(effectDateArray[0],10),parseInt(effectDateArray[1]-1,10),parseInt(effectDateArray[2],10));
				var expireDateArray = dbformStaff.getValue("ACCT_EXPIRE_DATE").split("-");
				var expireDate = new Date(parseInt(expireDateArray[0],10),parseInt(expireDateArray[1]-1,10),parseInt(expireDateArray[2],10));
	
				if(effectDate.getTime()>=expireDate.getTime())
				{
				  alert("�����������,ʧЧ���ڲ�ӦС�ڻ��ߵ�����Ч����!");
				   dbformStaff.setFocus("ACCT_EXPIRE_DATE");
				  return;
				}
		    }	   
		   
		   if( dbformStaff.getValue("MULTI_LOGIN_FLAG") == null ||
		       dbformStaff.getValue("MULTI_LOGIN_FLAG") == "" ){
		      alert("��ѡ���Ƿ��������ͬʱ��¼");
		      dbformStaff.setFocus("MULTI_LOGIN_FLAG");
		      return;
		   }	   
		   if( dbformStaff.getValue("CHG_PASSWD_ALARM_DAYS") == null ||
		       dbformStaff.getValue("CHG_PASSWD_ALARM_DAYS") == "" ){
		      alert("�����޸�������������Ϊ��");
		      dbformStaff.setFocus("CHG_PASSWD_ALARM_DAYS");
		      return;
		   }	   
		   if( dbformStaff.getValue("RECENT_PASS_TIMES") == null ||
		       dbformStaff.getValue("RECENT_PASS_TIMES") == "" ){
		      alert("�����޸�У���������Ϊ��");
		      dbformStaff.setFocus("RECENT_PASS_TIMES");
		      return;
		   }		   
		   
		   if( dbformStaff.getValue("MIN_PASSWD_LENGTH") == null ||
		       dbformStaff.getValue("MIN_PASSWD_LENGTH") == "" ){
		      alert("��С���볤�Ȳ���Ϊ��");
		      dbformStaff.setFocus("MIN_PASSWD_LENGTH");
		      return;
	
		   }
		       	   	   	   
		   if(  orgRelat.getTotalRowCount() == 0){
		   		alert("Ա����֯��ϵ����������Ϊ��");
		   		return ;
		   	}
		   	var hasBaseOrg = false;
		   	var iBaseOrgs=0;
		   	var baseOrgId=-1;
		   	for( var iii =0 ;iii < orgRelat.getTotalRowCount() ; iii++){
		   		   
		   		  if( orgRelat.getValue(iii,"IS_BASE_ORG") == 'Y' ){
		   		  	hasBaseOrg = true;
		   		  	baseOrgId = orgRelat.getValue(iii,"ORGANIZE_ID");
		   		  	if(orgRelat.getValue(iii,"STATE") == '1')
		   		  	iBaseOrgs++;
		   		  	//break;
		   		  }  
		   		}
		   	if( !hasBaseOrg ){
		   		alert('����ѡ��һ��������֯Ϊֱ����֯');
		   		return ;	
		   	}
		   	if(hasBaseOrg && iBaseOrgs>1){
		   		alert('ֻ��ѡ��һ��������֯Ϊֱ����֯');
		   		return ;	
		   	}
			/*
	 		if(  orgRelat.getTotalRowCount() >1){
		   		alert("Ա����֯��ϵֻ����һ��");
		   		return ;
		   	}
			*/
		   	for( var jjj =0 ;jjj < orgRelat.getTotalRowCount() ; jjj++){
		   	for( var iii =0 ;iii < orgRelat.getTotalRowCount() ; iii++){
		   		   
		   		  if( orgRelat.getValue(iii,"ORGANIZE_ID") == orgRelat.getValue(jjj,"ORGANIZE_ID") && iii!=jjj){
		   		  	alert('��֯��'+orgRelat.getDisplayText(iii,"ORGANIZE_ID")+"�����Ա��ֻ����һ����ϵ��");
		   		    return ;
		   		  }  
		   		}
		   	}	
		   	
	
	       if( dbformStaff.getValue("MIN_PASSWD_LENGTH")>12  ){
		      alert("������С���Ȳ��ܴ���12");
		      dbformStaff.setFocus("MIN_PASSWD_LENGTH");
		      return;
		   }
		   
		    if( dbformStaff.getValue("RECENT_PASS_TIMES")>5  ){
		      alert("�������ƴ������ܴ���5");
		      dbformStaff.setFocus("MIN_PASSWD_LENGTH");
		      return;
		   }
		   //------------------��Ա��Ϣ��֤
		     if( dbformEmployee.getValue("EMPLOYEE_NAME") == null ||
		       dbformEmployee.getValue("EMPLOYEE_NAME") == "" ){
		      alert("��������Ϊ��");
		      dbformEmployee.setFocus("EMPLOYEE_NAME");
		      return;
		   }
	
		    var list = new Array();
		    if(dbformStaff.toXmlString(true)==""&&dbformEmployee.toXmlString(true)==""&&orgRelat.toXmlString(true)==""){
		    	alert('������δ�޸�,���豣��!');
		    	return;
		    }
		    list.push(dbformStaff);
		    list.push(dbformEmployee);
		    list.push(orgRelat);
		    
		    var msg = saveRowSet("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysStaffAction?action=saveSysStaff",list,false);
		    var ret = msg.getValueByName("retVal");
		    if( ret == 0 )
		    {
		      alert("Ա�����³ɹ�!");
		      //parent.tabParty_party_page.refreshCurStaff();
		      var staff_id=msg.getValueByName("staff_id");
		      if(!isNaN(staff_id))
		      {	
		       //window.parent.cur_staffId=staff_id;
				window.parent.refreshStaff();
			   	init(staff_id,-1);
		      }
	
		    }
		    else{
		     alert("������Ϣ:"+msg.getValueByName("errorMsg"));
		    }    
		
	}
	//--------����
	
	//-------delete()--ͣ��Ա���������޸�Ա����Ա����֯��ϵ�����ű��״̬-
	function deleteStaff(){
		 if(dbformStaff.getValue("STAFF_ID")==null ||dbformStaff.getValue("STAFF_ID")=="") 
        {
         alert("��ѡ��Ա��ͣ�ã�");
         return;
        }
        if(!checkOrgRole()){
		return;
		}
		if(!confirm("ȷʵҪͣ�� '"+ dbformStaff.getValue("CODE") + "' ��"))return;
		
		var msg = PostInfo("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysStaffAction?"+
			"action=deleteStaff&staff_id="+dbformStaff.getValue("STAFF_ID"));
		var result = msg.getValueByName("MESSAGE");       
       if(result=='1'){
        alert('ͣ�óɹ�!');
        window.parent.refreshStaff();   
       }else if(result=='-1'){
        alert('ͣ��ʧ��!����STAFF_IDΪ��');
       }else{
        alert(result);
       }
	}
	//---------------------�޸�����
	function changePass(){
	   if(!checkOrgRole()){
			return;
		}
		var isAllChangePassword = dbformStaff.getValue("ALLOW_CHANGE_PASSWORD");

		if( isAllChangePassword == "N" )
		{
			alert("Ա�������벻����Ķ�");
			return;
		}
   
		var opId =dbformStaff.getValue("STAFF_ID");
		window.showModalDialog("ChPassword.jsp?staff_id="+opId,"scroll:no;resizable:no;status:no;dialogHeight:230px;dialogWidth:380px");
	
	}
	//���ݵ�ǰ�û��޸�
	function chpassword()
  	{
		   if(!checkOrgRole()){
				return;
			}
		   var isAllChangePassword = dbformStaff.getValue("ALLOW_CHANGE_PASSWORD");
		
		   if( isAllChangePassword == "N" )
		   {
		     	alert("Ա�������벻����Ķ�");
				return;
		   }
		   
		    var staffId =dbformStaff.getValue("STAFF_ID");
		    window.showModalDialog("ChPassword.jsp?staff_id="+staffId,staffId,"scroll:no;resizable:no;status:no;dialogHeight:230px;dialogWidth:380px");

	}	

	//--------------------�޸�����
	//--------��������-----ϵͳ�Զ�����Ϣ
	function resetPass(){
		if(!checkOrgRole()){
			return;
		}
	   	var staff_id =dbformStaff.getValue("STAFF_ID");
	   	var msg = PostInfo("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysStaffAction?"+
					"action=autoChangePassword&staff_id="+staff_id);
		var rtnval=msg.getValueByName("reVal");
	  	if(rtnval!="OK"){
			alert(rtnval);
	  	}else{
			alert("�޸ĳɹ�");
		}
	}
	//--------��������-----
	//----���Ȩ��-----�����Ȩ���Ա����ɫ������
	function clearAuthor(){
		if(!checkOrgRole()){
			return;
		}
		if(!confirm("ȷʵҪ��� '"+ dbformStaff.getValue("CODE") + "' ��Ȩ����"))return;
		var staff_id =dbformStaff.getValue("STAFF_ID");
  		var msg = PostInfo("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysStaffAction?"+
				"action=delRole&staff_id="+staff_id);
		var rtnval=msg.getValueByName("retVal");
  		if(rtnval!="OK"){
    		alert(rtnval);
  		}else{
    		alert("�����ɹ�");
  		}
	}
	//----���Ȩ��-----
	//----����Ա��----�����޸�Ա��״̬��Ա����֯����״̬
	function restart(){
		if(!checkOrgRole()){
			return;
		}
		var staff_id =dbformStaff.getValue("STAFF_ID");
	   	var msg = PostInfo("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysStaffAction?"+
					"action=unDel&staff_id="+staff_id);
		var rtnval=msg.getValueByName("retVal");
	  	if(rtnval!="OK"){
	    	alert(rtnval);
	  	}else{
	    	alert("�޸ĳɹ�");
	    	window.parent.refreshStaff();
	  }
	}
	//------����Ա��----
	
	//------�жϵ�ǰ����Ա�Ƿ���Ȩ�޲����������
	function checkOrgRole(){
		var st_id = dbformStaff.getValue("STAFF_ID");
	  	if(st_id==null||st_id==''){
	  		return true;
	  	}
  		var msg = PostInfo("<%=request.getContextPath()%>/business/com.ai.secframe.web.orgmodel.SysStaffAction?action=checkOrgRole&staff_id="+st_id);
		var result = msg.getValueByName("retVal");
		if(result=="-1"){
			alert(msg.getValueByName("errorMsg"));
			return false;
		} else {
			return true;
		}
	}
	//--------------
	
	function init(sId,orgId){
		staffId = sId;
		if(sId==null||sId=='null'||sId==0||sId==''){
			dbformStaff.refresh("1<>1");
     		dbformStaff.setEditSts(false);
     		dbformEmployee.refresh("1<>1");
     		dbformEmployee.setEditSts(false);
     		orgRelat.refresh("1<>1");	
     		document.getElementById("radom").disabled = true;
     		document.getElementById("check").disabled = true;
     		document.getElementById("password2").disabled = true;
     		buttonInit(3);
     		//document.getElementById("passdiv").style.display="block";	
		} else if(sId==-1) {
			dbformStaff.refresh("STAFF_ID=-1");
     		dbformStaff.setEditSts(true);
     		dbformEmployee.refresh("EMPLOYEE_ID=-1");
     		dbformEmployee.setEditSts(true);
     		orgRelat.refresh("STAFF_ID=-1");
     		orgRelat.setEditSts(true);
     		dbformStaff.setColEditSts("PASSWORD",true);
     		document.getElementById("radom").disabled = false;
     		document.getElementById("check").disabled = false;
     		document.getElementById("password2").disabled = false;
     		buttonInit(1);
     		//document.getElementById("passdiv").style.display="block";
		} else {
			dbformStaff.refresh("STAFF_ID="+sId);
     		dbformStaff.setEditSts(true);
     		
     		dbformEmployee.refresh("EMPLOYEE_ID="+dbformStaff.getValue("EMPLOYEE_ID"));
     		dbformEmployee.setEditSts(true);
     		orgRelat.refresh("STAFF_ID="+sId);
     		for( var iii =0 ;iii < orgRelat.getTotalRowCount() ; iii++){
		   		if(orgRelat.getValue(iii,"STATE") == '1')
		   		  	orgRelat.setRowEditSts(iii,true);
		   		else
		   			orgRelat.setRowEditSts(iii,false);
		   	}
     		
     		dbformStaff.setColEditSts("CODE",false);
     		dbformStaff.setColEditSts("PASSWORD",false);
     		document.getElementById("radom").disabled = true;
     		document.getElementById("check").disabled = true;
     		document.getElementById("password2").disabled = true;
     		//document.getElementById("passdiv").style.display="none";
     		buttonInit(2);
		}
	}
	init(staffId,-1);	

	//--------���еİ�ť�Ŀ��� flag = 1 add�� 2 = update ��3 = init
	function buttonInit(flag){
		if(flag==1){
			document.getElementById("addOrgRelate").disabled = false;
			document.getElementById("delOrgRelate").disabled = false;
			document.getElementById("selectEmployee").disabled = false;
			document.getElementById("addstaff").disabled = true;
			document.getElementById("save").disabled = false;
			document.getElementById("delete").disabled = true;
			document.getElementById("changePass").disabled = true;
			document.getElementById("reset").disabled = true;
			document.getElementById("clearAuthor").disabled = true;
			document.getElementById("restart").disabled = true;
		} else if(flag ==2){
			document.getElementById("addOrgRelate").disabled = false;
			document.getElementById("delOrgRelate").disabled = false;
			document.getElementById("selectEmployee").disabled = false;
			document.getElementById("addstaff").disabled = false;
			document.getElementById("save").disabled = false;
			document.getElementById("delete").disabled = false;
			document.getElementById("changePass").disabled = false;
			document.getElementById("reset").disabled = false;
			document.getElementById("clearAuthor").disabled = false;
			document.getElementById("restart").disabled = false;
		} else if(flag ==3){
			document.getElementById("addOrgRelate").disabled = true;
			document.getElementById("delOrgRelate").disabled = true;
			document.getElementById("selectEmployee").disabled = true;
			document.getElementById("addstaff").disabled = false;
			document.getElementById("save").disabled = true;
			document.getElementById("delete").disabled = true;
			document.getElementById("changePass").disabled = true;
			document.getElementById("reset").disabled = true;
			document.getElementById("clearAuthor").disabled = true;
			document.getElementById("restart").disabled = true;
		}
	
	}
</script>
</html>