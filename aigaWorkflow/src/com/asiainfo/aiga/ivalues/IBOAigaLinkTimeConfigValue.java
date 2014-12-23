package com.asiainfo.aiga.ivalues;
import com.ai.appframe2.common.DataStructInterface;
import java.sql.Timestamp;
public interface IBOAigaLinkTimeConfigValue extends DataStructInterface{

  public final static  String S_Base = "BASE";
  public final static  String S_Mark = "MARK";
  public final static  String S_DayNum = "DAY_NUM";
  public final static  String S_Id = "ID";
  public final static  String S_LinkNo = "LINK_NO";
  public final static  String S_Operate = "OPERATE";


public long getBase();

public String getMark();

public long getDayNum();

public long getId();

public String getLinkNo();

public long getOperate();


public  void setBase(long value);

public  void setMark(String value);

public  void setDayNum(long value);

public  void setId(long value);

public  void setLinkNo(String value);

public  void setOperate(long value);
}
