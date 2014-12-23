package com.asiainfo.csc.attach.ivalues;
import com.ai.appframe2.common.DataStructInterface;
import java.sql.Timestamp;
public interface IBOQueryAttachValue extends DataStructInterface{

  public final static  String S_AttId = "ATT_ID";
  public final static  String S_AttName = "ATT_NAME";
  public final static  String S_AttDesc = "ATT_DESC";
  public final static  String S_SubmitterTag = "SUBMITTER_TAG";
  public final static  String S_SubmitTime = "SUBMIT_TIME";
  public final static  String S_Status = "STATUS";
  public final static  String S_SubmitLink = "SUBMIT_LINK";
  public final static  String S_AttTypeName = "ATT_TYPE_NAME";
  public final static  String S_AttType = "ATT_TYPE";
  public final static  String S_AttPath = "ATT_PATH";


public long getAttId();

public String getAttName();

public String getAttDesc();

public String getSubmitterTag();

public Timestamp getSubmitTime();

public long getStatus();

public String getSubmitLink();

public String getAttTypeName();

public String getAttType();

public String getAttPath();


public  void setAttId(long value);

public  void setAttName(String value);

public  void setAttDesc(String value);

public  void setSubmitterTag(String value);

public  void setSubmitTime(Timestamp value);

public  void setStatus(long value);

public  void setSubmitLink(String value);

public  void setAttTypeName(String value);

public  void setAttType(String value);

public  void setAttPath(String value);
}
