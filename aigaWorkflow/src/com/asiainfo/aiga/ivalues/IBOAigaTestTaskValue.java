package com.asiainfo.aiga.ivalues;
import com.ai.appframe2.common.DataStructInterface;
import java.sql.Timestamp;
public interface IBOAigaTestTaskValue extends DataStructInterface{

  public final static  String S_IsCrossCycle = "IS_CROSS_CYCLE";
  public final static  String S_IsPoint2pointTest = "IS_POINT2POINT_TEST";
  public final static  String S_TestFirm = "TEST_FIRM";
  public final static  String S_PerfTaskId = "PERF_TASK_ID";
  public final static  String S_FactCompleteTime = "FACT_COMPLETE_TIME";
  public final static  String S_CreateTime = "CREATE_TIME";
  public final static  String S_TestPersionOpinion = "TEST_PERSION_OPINION";
  public final static  String S_DistributeStaffid = "DISTRIBUTE_STAFFID";
  public final static  String S_TaskId = "TASK_ID";
  public final static  String S_SubType = "SUB_TYPE";
  public final static  String S_SubmitStaffId = "SUBMIT_STAFF_ID";
  public final static  String S_DistributeStaffname = "DISTRIBUTE_STAFFNAME";
  public final static  String S_PlanTag = "PLAN_TAG";
  public final static  String S_TestWorkDay = "TEST_WORK_DAY";
  public final static  String S_ReqPersion = "REQ_PERSION";
  public final static  String S_DevAdmin = "DEV_ADMIN";
  public final static  String S_IsJointTest = "IS_JOINT_TEST";
  public final static  String S_CurrentStatus = "CURRENT_STATUS";
  public final static  String S_IsPerformanceTest = "IS_PERFORMANCE_TEST";
  public final static  String S_BigType = "BIG_TYPE";
  public final static  String S_TaskPhase = "TASK_PHASE";
  public final static  String S_OnLineTime = "ON_LINE_TIME";
  public final static  String S_PlanId = "PLAN_ID";
  public final static  String S_Priority = "PRIORITY";
  public final static  String S_TestProgress = "TEST_PROGRESS";
  public final static  String S_DevPersion = "DEV_PERSION";
  public final static  String S_PlCompleteTime = "PL_COMPLETE_TIME";
  public final static  String S_TestGroup = "TEST_GROUP";
  public final static  String S_TestSituation = "TEST_SITUATION";
  public final static  String S_DevFirm = "DEV_FIRM";
  public final static  String S_ReqType = "REQ_TYPE";
  public final static  String S_ReqTag = "REQ_TAG";
  public final static  String S_UetTaskId = "UET_TASK_ID";
  public final static  String S_ReqId = "REQ_ID";
  public final static  String S_DefectNumber = "DEFECT_NUMBER";
  public final static  String S_InitialSituation = "INITIAL_SITUATION";
  public final static  String S_SubmitStaffName = "SUBMIT_STAFF_NAME";
  public final static  String S_RunPersion = "RUN_PERSION";
  public final static  String S_TestType = "TEST_TYPE";
  public final static  String S_TaskName = "TASK_NAME";
  public final static  String S_DevTag = "DEV_TAG";
  public final static  String S_TaskTag = "TASK_TAG";
  public final static  String S_DevWorkDay = "DEV_WORK_DAY";
  public final static  String S_IsImportanceReq = "IS_IMPORTANCE_REQ";
  public final static  String S_DistributeTime = "DISTRIBUTE_TIME";


public int getIsCrossCycle();

public int getIsPoint2pointTest();

public long getTestFirm();

public long getPerfTaskId();

public Timestamp getFactCompleteTime();

public Timestamp getCreateTime();

public String getTestPersionOpinion();

public String getDistributeStaffid();

public long getTaskId();

public long getSubType();

public long getSubmitStaffId();

public String getDistributeStaffname();

public String getPlanTag();

public String getTestWorkDay();

public String getReqPersion();

public String getDevAdmin();

public int getIsJointTest();

public long getCurrentStatus();

public int getIsPerformanceTest();

public long getBigType();

public long getTaskPhase();

public Timestamp getOnLineTime();

public long getPlanId();

public long getPriority();

public String getTestProgress();

public String getDevPersion();

public Timestamp getPlCompleteTime();

public String getTestGroup();

public String getTestSituation();

public long getDevFirm();

public String getReqType();

public String getReqTag();

public long getUetTaskId();

public long getReqId();

public int getDefectNumber();

public String getInitialSituation();

public String getSubmitStaffName();

public int getRunPersion();

public long getTestType();

public String getTaskName();

public String getDevTag();

public String getTaskTag();

public String getDevWorkDay();

public int getIsImportanceReq();

public String getDistributeTime();


public  void setIsCrossCycle(int value);

public  void setIsPoint2pointTest(int value);

public  void setTestFirm(long value);

public  void setPerfTaskId(long value);

public  void setFactCompleteTime(Timestamp value);

public  void setCreateTime(Timestamp value);

public  void setTestPersionOpinion(String value);

public  void setDistributeStaffid(String value);

public  void setTaskId(long value);

public  void setSubType(long value);

public  void setSubmitStaffId(long value);

public  void setDistributeStaffname(String value);

public  void setPlanTag(String value);

public  void setTestWorkDay(String value);

public  void setReqPersion(String value);

public  void setDevAdmin(String value);

public  void setIsJointTest(int value);

public  void setCurrentStatus(long value);

public  void setIsPerformanceTest(int value);

public  void setBigType(long value);

public  void setTaskPhase(long value);

public  void setOnLineTime(Timestamp value);

public  void setPlanId(long value);

public  void setPriority(long value);

public  void setTestProgress(String value);

public  void setDevPersion(String value);

public  void setPlCompleteTime(Timestamp value);

public  void setTestGroup(String value);

public  void setTestSituation(String value);

public  void setDevFirm(long value);

public  void setReqType(String value);

public  void setReqTag(String value);

public  void setUetTaskId(long value);

public  void setReqId(long value);

public  void setDefectNumber(int value);

public  void setInitialSituation(String value);

public  void setSubmitStaffName(String value);

public  void setRunPersion(int value);

public  void setTestType(long value);

public  void setTaskName(String value);

public  void setDevTag(String value);

public  void setTaskTag(String value);

public  void setDevWorkDay(String value);

public  void setIsImportanceReq(int value);

public  void setDistributeTime(String value);
}
