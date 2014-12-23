package com.asiainfo.csc.common.ivalues;
import com.ai.appframe2.common.DataStructInterface;
import java.sql.Timestamp;
public interface IprojectIdValue extends DataStructInterface{

  public final static  String S_StaffId = "STAFF_ID";
  public final static  String S_KindName = "KIND_NAME";


public long getStaffId();

public String getKindName();


public  void setStaffId(long value);

public  void setKindName(String value);
}
