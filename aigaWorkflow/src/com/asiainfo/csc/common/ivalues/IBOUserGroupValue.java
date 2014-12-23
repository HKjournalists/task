package com.asiainfo.csc.common.ivalues;
import com.ai.appframe2.common.DataStructInterface;
import java.sql.Timestamp;
public interface IBOUserGroupValue extends DataStructInterface{

  public final static  String S_GroupId = "GROUP_ID";
  public final static  String S_StaffId = "STAFF_ID";
  public final static  String S_GroupName = "GROUP_NAME";


public long getGroupId();

public long getStaffId();

public String getGroupName();


public  void setGroupId(long value);

public  void setStaffId(long value);

public  void setGroupName(String value);
}
