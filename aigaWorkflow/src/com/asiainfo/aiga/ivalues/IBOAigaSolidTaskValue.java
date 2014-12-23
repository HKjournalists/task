package com.asiainfo.aiga.ivalues;
import com.ai.appframe2.common.DataStructInterface;
import java.sql.Timestamp;
public interface IBOAigaSolidTaskValue extends DataStructInterface{

  public final static  String S_TaskPhase = "TASK_PHASE";
  public final static  String S_VersionContent = "VERSION_CONTENT";
  public final static  String S_CreateTime = "CREATE_TIME";
  public final static  String S_FactCompleteTime = "FACT_COMPLETE_TIME";
  public final static  String S_PlanId = "PLAN_ID";
  public final static  String S_PlCompleteTime = "PL_COMPLETE_TIME";
  public final static  String S_OnLineType = "ON_LINE_TYPE";
  public final static  String S_TaskId = "TASK_ID";
  public final static  String S_ChangeReason = "CHANGE_REASON";
  public final static  String S_ReqTime = "REQ_TIME";
  public final static  String S_SubmitStaffId = "SUBMIT_STAFF_ID";
  public final static  String S_IsSecurityTest = "IS_SECURITY_TEST";
  public final static  String S_PlanDscr = "PLAN_DSCR";
  public final static  String S_IsCodeScan = "IS_CODE_SCAN";
  public final static  String S_TaskStatus = "TASK_STATUS";
  public final static  String S_PlanName = "PLAN_NAME";
  public final static  String S_BeginTime = "BEGIN_TIME";
  public final static  String S_TaskType = "TASK_TYPE";
  public final static  String S_SubmitStaffName = "SUBMIT_STAFF_NAME";
  public final static  String S_PlanTag = "PLAN_TAG";
  public final static  String S_IsRegressionTest = "IS_REGRESSION_TEST";
  public final static  String S_IsPerformanceTest = "IS_PERFORMANCE_TEST";
  public final static  String S_BigType = "BIG_TYPE";
  public final static  String S_CodeCommitDate = "CODE_COMMIT_DATE";


public long getTaskPhase();

public long getVersionContent();

public Timestamp getCreateTime();

public Timestamp getFactCompleteTime();

public long getPlanId();

public Timestamp getPlCompleteTime();

public long getOnLineType();

public long getTaskId();

public String getChangeReason();

public Timestamp getReqTime();

public long getSubmitStaffId();

public long getIsSecurityTest();

public String getPlanDscr();

public long getIsCodeScan();

public long getTaskStatus();

public String getPlanName();

public Timestamp getBeginTime();

public long getTaskType();

public String getSubmitStaffName();

public String getPlanTag();

public long getIsRegressionTest();

public long getIsPerformanceTest();

public long getBigType();

public Timestamp getCodeCommitDate();


public  void setTaskPhase(long value);

public  void setVersionContent(long value);

public  void setCreateTime(Timestamp value);

public  void setFactCompleteTime(Timestamp value);

public  void setPlanId(long value);

public  void setPlCompleteTime(Timestamp value);

public  void setOnLineType(long value);

public  void setTaskId(long value);

public  void setChangeReason(String value);

public  void setReqTime(Timestamp value);

public  void setSubmitStaffId(long value);

public  void setIsSecurityTest(long value);

public  void setPlanDscr(String value);

public  void setIsCodeScan(long value);

public  void setTaskStatus(long value);

public  void setPlanName(String value);

public  void setBeginTime(Timestamp value);

public  void setTaskType(long value);

public  void setSubmitStaffName(String value);

public  void setPlanTag(String value);

public  void setIsRegressionTest(long value);

public  void setIsPerformanceTest(long value);

public  void setBigType(long value);

public  void setCodeCommitDate(Timestamp value);
}
