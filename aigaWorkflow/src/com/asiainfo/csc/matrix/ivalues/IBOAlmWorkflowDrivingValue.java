package com.asiainfo.csc.matrix.ivalues;
import com.ai.appframe2.common.DataStructInterface;
import java.sql.Timestamp;
public interface IBOAlmWorkflowDrivingValue extends DataStructInterface{

  public final static  String S_LinkRelativePhase = "LINK_RELATIVE_PHASE";
  public final static  String S_PassiveTemplateId = "PASSIVE_TEMPLATE_ID";
  public final static  String S_DrivingId = "DRIVING_ID";
  public final static  String S_ActivePoint = "ACTIVE_POINT";
  public final static  String S_PassivePoint = "PASSIVE_POINT";
  public final static  String S_ActiveTemplateId = "ACTIVE_TEMPLATE_ID";


public long getLinkRelativePhase();

public long getPassiveTemplateId();

public long getDrivingId();

public String getActivePoint();

public String getPassivePoint();

public long getActiveTemplateId();


public  void setLinkRelativePhase(long value);

public  void setPassiveTemplateId(long value);

public  void setDrivingId(long value);

public  void setActivePoint(String value);

public  void setPassivePoint(String value);

public  void setActiveTemplateId(long value);
}
