package com.asiainfo.aiga.ivalues;
import com.ai.appframe2.common.DataStructInterface;
import java.sql.Timestamp;
public interface IBOAigaTestPlanChangeValue extends DataStructInterface{

  public final static  String S_VersionContentO = "VERSION_CONTENT_O";
  public final static  String S_CreateTime = "CREATE_TIME";
  public final static  String S_ReqtimeN = "REQTIME_N";
  public final static  String S_VersionContentN = "VERSION_CONTENT_N";
  public final static  String S_ReqtimeO = "REQTIME_O";
  public final static  String S_AcId = "AC_ID";
  public final static  String S_ChangeReason = "CHANGE_REASON";
  public final static  String S_ChangeStaffId = "CHANGE_STAFF_ID";
  public final static  String S_FactcompletetimeN = "FACTCOMPLETETIME_N";
  public final static  String S_ChangePlanTag = "CHANGE_PLAN_TAG";
  public final static  String S_FactcompletetimeO = "FACTCOMPLETETIME_O";
  public final static  String S_ChangeStaffName = "CHANGE_STAFF_NAME";
  public final static  String S_ChangePlanId = "CHANGE_PLAN_ID";
  public final static  String S_CodecommitdateO = "CODECOMMITDATE_O";
  public final static  String S_CodecommitdateN = "CODECOMMITDATE_N";


public long getVersionContentO();

public Timestamp getCreateTime();

public Timestamp getReqtimeN();

public long getVersionContentN();

public Timestamp getReqtimeO();

public long getAcId();

public String getChangeReason();

public long getChangeStaffId();

public Timestamp getFactcompletetimeN();

public String getChangePlanTag();

public Timestamp getFactcompletetimeO();

public String getChangeStaffName();

public long getChangePlanId();

public Timestamp getCodecommitdateO();

public Timestamp getCodecommitdateN();


public  void setVersionContentO(long value);

public  void setCreateTime(Timestamp value);

public  void setReqtimeN(Timestamp value);

public  void setVersionContentN(long value);

public  void setReqtimeO(Timestamp value);

public  void setAcId(long value);

public  void setChangeReason(String value);

public  void setChangeStaffId(long value);

public  void setFactcompletetimeN(Timestamp value);

public  void setChangePlanTag(String value);

public  void setFactcompletetimeO(Timestamp value);

public  void setChangeStaffName(String value);

public  void setChangePlanId(long value);

public  void setCodecommitdateO(Timestamp value);

public  void setCodecommitdateN(Timestamp value);
}
