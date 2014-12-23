package com.asiainfo.csc.matrix.ivalues;
import com.ai.appframe2.common.DataStructInterface;
import java.sql.Timestamp;
public interface IBOAlmHisStakeholderValue extends DataStructInterface{

  public final static  String S_ObjId = "OBJ_ID";
  public final static  String S_CreateTime = "CREATE_TIME";
  public final static  String S_TemplateId = "TEMPLATE_ID";
  public final static  String S_LinkNo = "LINK_NO";
  public final static  String S_RoleCode = "ROLE_CODE";
  public final static  String S_HisStdholderId = "HIS_STDHOLDER_ID";
  public final static  String S_StdholderStaffOrgId = "STDHOLDER_STAFF_ORG_ID";
  public final static  String S_RoleId = "ROLE_ID";
  public final static  String S_StdholderStaffName = "STDHOLDER_STAFF_NAME";
  public final static  String S_OrderId = "ORDER_ID";
  public final static  String S_StdholderStaffId = "STDHOLDER_STAFF_ID";
  public final static  String S_StdholdeType = "STDHOLDE_TYPE";
  public final static  String S_ObjType = "OBJ_TYPE";
  public final static  String S_LinkId = "LINK_ID";
  public final static  String S_StdholderId = "STDHOLDER_ID";
  public final static  String S_StdholderStaffNo = "STDHOLDER_STAFF_NO";


public long getObjId();

public Timestamp getCreateTime();

public long getTemplateId();

public String getLinkNo();

public String getRoleCode();

public long getHisStdholderId();

public long getStdholderStaffOrgId();

public long getRoleId();

public String getStdholderStaffName();

public long getOrderId();

public long getStdholderStaffId();

public String getStdholdeType();

public String getObjType();

public long getLinkId();

public long getStdholderId();

public String getStdholderStaffNo();


public  void setObjId(long value);

public  void setCreateTime(Timestamp value);

public  void setTemplateId(long value);

public  void setLinkNo(String value);

public  void setRoleCode(String value);

public  void setHisStdholderId(long value);

public  void setStdholderStaffOrgId(long value);

public  void setRoleId(long value);

public  void setStdholderStaffName(String value);

public  void setOrderId(long value);

public  void setStdholderStaffId(long value);

public  void setStdholdeType(String value);

public  void setObjType(String value);

public  void setLinkId(long value);

public  void setStdholderId(long value);

public  void setStdholderStaffNo(String value);
}
