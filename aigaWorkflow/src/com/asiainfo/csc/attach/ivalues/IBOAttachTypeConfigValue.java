package com.asiainfo.csc.attach.ivalues;
import com.ai.appframe2.common.DataStructInterface;
import java.sql.Timestamp;
public interface IBOAttachTypeConfigValue extends DataStructInterface{

  public final static  String S_AttConfId = "ATT_CONF_ID";
  public final static  String S_IsCheck = "IS_CHECK";
  public final static  String S_Cond = "COND";
  public final static  String S_Zone = "ZONE";
  public final static  String S_AttTypeId = "ATT_TYPE_ID";


public long getAttConfId();

public String getIsCheck();

public String getCond();

public long getZone();

public long getAttTypeId();


public  void setAttConfId(long value);

public  void setIsCheck(String value);

public  void setCond(String value);

public  void setZone(long value);

public  void setAttTypeId(long value);
}
