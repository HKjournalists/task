package com.asiainfo.csc.attach.ivalues;
import com.ai.appframe2.common.DataStructInterface;
import java.sql.Timestamp;
public interface IBOAttachTypeValue extends DataStructInterface{

  public final static  String S_ParamType = "PARAM_TYPE";
  public final static  String S_SortId = "SORT_ID";
  public final static  String S_ParamDisc = "PARAM_DISC";
  public final static  String S_ParamRelaId = "PARAM_RELA_ID";
  public final static  String S_ParamName = "PARAM_NAME";
  public final static  String S_ParamValue = "PARAM_VALUE";
  public final static  String S_ParamNo = "PARAM_NO";
  public final static  String S_ParamId = "PARAM_ID";


public String getParamType();

public long getSortId();

public String getParamDisc();

public long getParamRelaId();

public String getParamName();

public long getParamValue();

public String getParamNo();

public long getParamId();


public  void setParamType(String value);

public  void setSortId(long value);

public  void setParamDisc(String value);

public  void setParamRelaId(long value);

public  void setParamName(String value);

public  void setParamValue(long value);

public  void setParamNo(String value);

public  void setParamId(long value);
}
