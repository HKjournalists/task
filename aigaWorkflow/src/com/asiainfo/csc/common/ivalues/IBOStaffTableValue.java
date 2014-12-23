package com.asiainfo.csc.common.ivalues;
import com.ai.appframe2.common.DataStructInterface;
import java.sql.Timestamp;
public interface IBOStaffTableValue extends DataStructInterface{

  public final static  String S_ParentOrganizeId = "PARENT_ORGANIZE_ID";
  public final static  String S_OrganizeName = "ORGANIZE_NAME";
  public final static  String S_StaffId = "STAFF_ID";
  public final static  String S_OrgCode = "ORG_CODE";
  public final static  String S_EmployeeName = "EMPLOYEE_NAME";
  public final static  String S_BillId = "BILL_ID";
  public final static  String S_RoleCode = "ROLE_CODE";
  public final static  String S_StaffCode = "STAFF_CODE";
  public final static  String S_OrganizeId = "ORGANIZE_ID";


public long getParentOrganizeId();

public String getOrganizeName();

public long getStaffId();

public String getOrgCode();

public String getEmployeeName();

public String getBillId();

public String getRoleCode();

public String getStaffCode();

public long getOrganizeId();


public  void setParentOrganizeId(long value);

public  void setOrganizeName(String value);

public  void setStaffId(long value);

public  void setOrgCode(String value);

public  void setEmployeeName(String value);

public  void setBillId(String value);

public  void setRoleCode(String value);

public  void setStaffCode(String value);

public  void setOrganizeId(long value);
}
