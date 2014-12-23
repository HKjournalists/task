package com.asiainfo.csc.common.ivalues;
import com.ai.appframe2.common.DataStructInterface;
import java.sql.Timestamp;
public interface IBOStaffRoleOrgDistViewValue extends DataStructInterface{

  public final static  String S_ParentOrganizeId = "PARENT_ORGANIZE_ID";
  public final static  String S_OrganizeName = "ORGANIZE_NAME";
  public final static  String S_GroupId = "GROUP_ID";
  public final static  String S_StaffId = "STAFF_ID";
  public final static  String S_DistrictId = "DISTRICT_ID";
  public final static  String S_StaffName = "STAFF_NAME";
  public final static  String S_RoleName = "ROLE_NAME";
  public final static  String S_RoleCode = "ROLE_CODE";
  public final static  String S_RoleId = "ROLE_ID";
  public final static  String S_OrganizeId = "ORGANIZE_ID";
  public final static  String S_Code = "CODE";


public long getParentOrganizeId();

public String getOrganizeName();

public long getGroupId();

public long getStaffId();

public long getDistrictId();

public String getStaffName();

public String getRoleName();

public String getRoleCode();

public long getRoleId();

public long getOrganizeId();

public String getCode();


public  void setParentOrganizeId(long value);

public  void setOrganizeName(String value);

public  void setGroupId(long value);

public  void setStaffId(long value);

public  void setDistrictId(long value);

public  void setStaffName(String value);

public  void setRoleName(String value);

public  void setRoleCode(String value);

public  void setRoleId(long value);

public  void setOrganizeId(long value);

public  void setCode(String value);
}
