package com.asiainfo.csc.matrix.ivalues;
import com.ai.appframe2.common.DataStructInterface;
import java.sql.Timestamp;
public interface IBOTopoViewValue extends DataStructInterface{

  public final static  String S_Tpoint = "TPOINT";
  public final static  String S_Servid = "SERVID";
  public final static  String S_DrivnoFun = "DRIVNO_FUN";
  public final static  String S_DrivConNo = "DRIV_CON_NO";
  public final static  String S_Fpoint = "FPOINT";
  public final static  String S_Fun = "FUN";
  public final static  String S_Cond = "COND";
  public final static  String S_Drivnos = "DRIVNOS";
  public final static  String S_TemplateId = "TEMPLATE_ID";
  public final static  String S_Action = "ACTION";
  public final static  String S_No = "NO";


public long getTpoint();

public String getServid();

public String getDrivnoFun();

public String getDrivConNo();

public long getFpoint();

public String getFun();

public String getCond();

public String getDrivnos();

public long getTemplateId();

public String getAction();

public String getNo();


public  void setTpoint(long value);

public  void setServid(String value);

public  void setDrivnoFun(String value);

public  void setDrivConNo(String value);

public  void setFpoint(long value);

public  void setFun(String value);

public  void setCond(String value);

public  void setDrivnos(String value);

public  void setTemplateId(long value);

public  void setAction(String value);

public  void setNo(String value);
}
