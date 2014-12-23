package com.asiainfo.csc.common.ivalues;
import com.ai.appframe2.common.DataStructInterface;
import java.sql.Timestamp;
public interface IBOStaffManagerRelatValue extends DataStructInterface{

  public final static  String S_ReqType = "REQ_TYPE";
  public final static  String S_StaffId = "STAFF_ID";
  public final static  String S_ConfigDscr = "CONFIG_DSCR";
  public final static  String S_SysTag = "SYS_TAG";
  public final static  String S_StaffName = "STAFF_NAME";
  public final static  String S_StaffManagerRelatId = "STAFF_MANAGER_RELAT_ID";


public String getReqType();

public long getStaffId();

public String getConfigDscr();

public long getSysTag();

public String getStaffName();

public long getStaffManagerRelatId();


public  void setReqType(String value);

public  void setStaffId(long value);

public  void setConfigDscr(String value);

public  void setSysTag(long value);

public  void setStaffName(String value);

public  void setStaffManagerRelatId(long value);
}
