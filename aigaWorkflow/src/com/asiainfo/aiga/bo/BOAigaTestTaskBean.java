package com.asiainfo.aiga.bo;

import java.sql.*;
import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.common.DataType;

import com.asiainfo.aiga.ivalues.*;

public class BOAigaTestTaskBean extends DataContainer implements DataContainerInterface,IBOAigaTestTaskValue{

  private static String  m_boName = "com.asiainfo.aiga.bo.BOAigaTestTask";



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

  public static ObjectType S_TYPE = null;
  static{
    try {
      S_TYPE = ServiceManager.getObjectTypeFactory().getInstance(m_boName);
    }catch(Exception e){
      throw new RuntimeException(e);
    }
  }
  public BOAigaTestTaskBean() throws AIException{
      super(S_TYPE);
  }

 public static ObjectType getObjectTypeStatic() throws AIException{
   return S_TYPE;
 }

 public void setObjectType(ObjectType  value) throws AIException{
   //此种数据容器不能重置业务对象类型
   throw new AIException("Cannot reset ObjectType");
 }


  public void initIsCrossCycle(int value){
     this.initProperty(S_IsCrossCycle,new Integer(value));
  }
  public  void setIsCrossCycle(int value){
     this.set(S_IsCrossCycle,new Integer(value));
  }
  public  void setIsCrossCycleNull(){
     this.set(S_IsCrossCycle,null);
  }

  public int getIsCrossCycle(){
        return DataType.getAsInt(this.get(S_IsCrossCycle));
  
  }
  public int getIsCrossCycleInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_IsCrossCycle));
      }

  public void initIsPoint2pointTest(int value){
     this.initProperty(S_IsPoint2pointTest,new Integer(value));
  }
  public  void setIsPoint2pointTest(int value){
     this.set(S_IsPoint2pointTest,new Integer(value));
  }
  public  void setIsPoint2pointTestNull(){
     this.set(S_IsPoint2pointTest,null);
  }

  public int getIsPoint2pointTest(){
        return DataType.getAsInt(this.get(S_IsPoint2pointTest));
  
  }
  public int getIsPoint2pointTestInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_IsPoint2pointTest));
      }

  public void initTestFirm(long value){
     this.initProperty(S_TestFirm,new Long(value));
  }
  public  void setTestFirm(long value){
     this.set(S_TestFirm,new Long(value));
  }
  public  void setTestFirmNull(){
     this.set(S_TestFirm,null);
  }

  public long getTestFirm(){
        return DataType.getAsLong(this.get(S_TestFirm));
  
  }
  public long getTestFirmInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_TestFirm));
      }

  public void initPerfTaskId(long value){
     this.initProperty(S_PerfTaskId,new Long(value));
  }
  public  void setPerfTaskId(long value){
     this.set(S_PerfTaskId,new Long(value));
  }
  public  void setPerfTaskIdNull(){
     this.set(S_PerfTaskId,null);
  }

  public long getPerfTaskId(){
        return DataType.getAsLong(this.get(S_PerfTaskId));
  
  }
  public long getPerfTaskIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_PerfTaskId));
      }

  public void initFactCompleteTime(Timestamp value){
     this.initProperty(S_FactCompleteTime,value);
  }
  public  void setFactCompleteTime(Timestamp value){
     this.set(S_FactCompleteTime,value);
  }
  public  void setFactCompleteTimeNull(){
     this.set(S_FactCompleteTime,null);
  }

  public Timestamp getFactCompleteTime(){
        return DataType.getAsDateTime(this.get(S_FactCompleteTime));
  
  }
  public Timestamp getFactCompleteTimeInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_FactCompleteTime));
      }

  public void initCreateTime(Timestamp value){
     this.initProperty(S_CreateTime,value);
  }
  public  void setCreateTime(Timestamp value){
     this.set(S_CreateTime,value);
  }
  public  void setCreateTimeNull(){
     this.set(S_CreateTime,null);
  }

  public Timestamp getCreateTime(){
        return DataType.getAsDateTime(this.get(S_CreateTime));
  
  }
  public Timestamp getCreateTimeInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_CreateTime));
      }

  public void initTestPersionOpinion(String value){
     this.initProperty(S_TestPersionOpinion,value);
  }
  public  void setTestPersionOpinion(String value){
     this.set(S_TestPersionOpinion,value);
  }
  public  void setTestPersionOpinionNull(){
     this.set(S_TestPersionOpinion,null);
  }

  public String getTestPersionOpinion(){
       return DataType.getAsString(this.get(S_TestPersionOpinion));
  
  }
  public String getTestPersionOpinionInitialValue(){
        return DataType.getAsString(this.getOldObj(S_TestPersionOpinion));
      }

  public void initDistributeStaffid(String value){
     this.initProperty(S_DistributeStaffid,value);
  }
  public  void setDistributeStaffid(String value){
     this.set(S_DistributeStaffid,value);
  }
  public  void setDistributeStaffidNull(){
     this.set(S_DistributeStaffid,null);
  }

  public String getDistributeStaffid(){
       return DataType.getAsString(this.get(S_DistributeStaffid));
  
  }
  public String getDistributeStaffidInitialValue(){
        return DataType.getAsString(this.getOldObj(S_DistributeStaffid));
      }

  public void initTaskId(long value){
     this.initProperty(S_TaskId,new Long(value));
  }
  public  void setTaskId(long value){
     this.set(S_TaskId,new Long(value));
  }
  public  void setTaskIdNull(){
     this.set(S_TaskId,null);
  }

  public long getTaskId(){
        return DataType.getAsLong(this.get(S_TaskId));
  
  }
  public long getTaskIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_TaskId));
      }

  public void initSubType(long value){
     this.initProperty(S_SubType,new Long(value));
  }
  public  void setSubType(long value){
     this.set(S_SubType,new Long(value));
  }
  public  void setSubTypeNull(){
     this.set(S_SubType,null);
  }

  public long getSubType(){
        return DataType.getAsLong(this.get(S_SubType));
  
  }
  public long getSubTypeInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_SubType));
      }

  public void initSubmitStaffId(long value){
     this.initProperty(S_SubmitStaffId,new Long(value));
  }
  public  void setSubmitStaffId(long value){
     this.set(S_SubmitStaffId,new Long(value));
  }
  public  void setSubmitStaffIdNull(){
     this.set(S_SubmitStaffId,null);
  }

  public long getSubmitStaffId(){
        return DataType.getAsLong(this.get(S_SubmitStaffId));
  
  }
  public long getSubmitStaffIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_SubmitStaffId));
      }

  public void initDistributeStaffname(String value){
     this.initProperty(S_DistributeStaffname,value);
  }
  public  void setDistributeStaffname(String value){
     this.set(S_DistributeStaffname,value);
  }
  public  void setDistributeStaffnameNull(){
     this.set(S_DistributeStaffname,null);
  }

  public String getDistributeStaffname(){
       return DataType.getAsString(this.get(S_DistributeStaffname));
  
  }
  public String getDistributeStaffnameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_DistributeStaffname));
      }

  public void initPlanTag(String value){
     this.initProperty(S_PlanTag,value);
  }
  public  void setPlanTag(String value){
     this.set(S_PlanTag,value);
  }
  public  void setPlanTagNull(){
     this.set(S_PlanTag,null);
  }

  public String getPlanTag(){
       return DataType.getAsString(this.get(S_PlanTag));
  
  }
  public String getPlanTagInitialValue(){
        return DataType.getAsString(this.getOldObj(S_PlanTag));
      }

  public void initTestWorkDay(String value){
     this.initProperty(S_TestWorkDay,value);
  }
  public  void setTestWorkDay(String value){
     this.set(S_TestWorkDay,value);
  }
  public  void setTestWorkDayNull(){
     this.set(S_TestWorkDay,null);
  }

  public String getTestWorkDay(){
       return DataType.getAsString(this.get(S_TestWorkDay));
  
  }
  public String getTestWorkDayInitialValue(){
        return DataType.getAsString(this.getOldObj(S_TestWorkDay));
      }

  public void initReqPersion(String value){
     this.initProperty(S_ReqPersion,value);
  }
  public  void setReqPersion(String value){
     this.set(S_ReqPersion,value);
  }
  public  void setReqPersionNull(){
     this.set(S_ReqPersion,null);
  }

  public String getReqPersion(){
       return DataType.getAsString(this.get(S_ReqPersion));
  
  }
  public String getReqPersionInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ReqPersion));
      }

  public void initDevAdmin(String value){
     this.initProperty(S_DevAdmin,value);
  }
  public  void setDevAdmin(String value){
     this.set(S_DevAdmin,value);
  }
  public  void setDevAdminNull(){
     this.set(S_DevAdmin,null);
  }

  public String getDevAdmin(){
       return DataType.getAsString(this.get(S_DevAdmin));
  
  }
  public String getDevAdminInitialValue(){
        return DataType.getAsString(this.getOldObj(S_DevAdmin));
      }

  public void initIsJointTest(int value){
     this.initProperty(S_IsJointTest,new Integer(value));
  }
  public  void setIsJointTest(int value){
     this.set(S_IsJointTest,new Integer(value));
  }
  public  void setIsJointTestNull(){
     this.set(S_IsJointTest,null);
  }

  public int getIsJointTest(){
        return DataType.getAsInt(this.get(S_IsJointTest));
  
  }
  public int getIsJointTestInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_IsJointTest));
      }

  public void initCurrentStatus(long value){
     this.initProperty(S_CurrentStatus,new Long(value));
  }
  public  void setCurrentStatus(long value){
     this.set(S_CurrentStatus,new Long(value));
  }
  public  void setCurrentStatusNull(){
     this.set(S_CurrentStatus,null);
  }

  public long getCurrentStatus(){
        return DataType.getAsLong(this.get(S_CurrentStatus));
  
  }
  public long getCurrentStatusInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_CurrentStatus));
      }

  public void initIsPerformanceTest(int value){
     this.initProperty(S_IsPerformanceTest,new Integer(value));
  }
  public  void setIsPerformanceTest(int value){
     this.set(S_IsPerformanceTest,new Integer(value));
  }
  public  void setIsPerformanceTestNull(){
     this.set(S_IsPerformanceTest,null);
  }

  public int getIsPerformanceTest(){
        return DataType.getAsInt(this.get(S_IsPerformanceTest));
  
  }
  public int getIsPerformanceTestInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_IsPerformanceTest));
      }

  public void initBigType(long value){
     this.initProperty(S_BigType,new Long(value));
  }
  public  void setBigType(long value){
     this.set(S_BigType,new Long(value));
  }
  public  void setBigTypeNull(){
     this.set(S_BigType,null);
  }

  public long getBigType(){
        return DataType.getAsLong(this.get(S_BigType));
  
  }
  public long getBigTypeInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_BigType));
      }

  public void initTaskPhase(long value){
     this.initProperty(S_TaskPhase,new Long(value));
  }
  public  void setTaskPhase(long value){
     this.set(S_TaskPhase,new Long(value));
  }
  public  void setTaskPhaseNull(){
     this.set(S_TaskPhase,null);
  }

  public long getTaskPhase(){
        return DataType.getAsLong(this.get(S_TaskPhase));
  
  }
  public long getTaskPhaseInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_TaskPhase));
      }

  public void initOnLineTime(Timestamp value){
     this.initProperty(S_OnLineTime,value);
  }
  public  void setOnLineTime(Timestamp value){
     this.set(S_OnLineTime,value);
  }
  public  void setOnLineTimeNull(){
     this.set(S_OnLineTime,null);
  }

  public Timestamp getOnLineTime(){
        return DataType.getAsDateTime(this.get(S_OnLineTime));
  
  }
  public Timestamp getOnLineTimeInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_OnLineTime));
      }

  public void initPlanId(long value){
     this.initProperty(S_PlanId,new Long(value));
  }
  public  void setPlanId(long value){
     this.set(S_PlanId,new Long(value));
  }
  public  void setPlanIdNull(){
     this.set(S_PlanId,null);
  }

  public long getPlanId(){
        return DataType.getAsLong(this.get(S_PlanId));
  
  }
  public long getPlanIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_PlanId));
      }

  public void initPriority(long value){
     this.initProperty(S_Priority,new Long(value));
  }
  public  void setPriority(long value){
     this.set(S_Priority,new Long(value));
  }
  public  void setPriorityNull(){
     this.set(S_Priority,null);
  }

  public long getPriority(){
        return DataType.getAsLong(this.get(S_Priority));
  
  }
  public long getPriorityInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_Priority));
      }

  public void initTestProgress(String value){
     this.initProperty(S_TestProgress,value);
  }
  public  void setTestProgress(String value){
     this.set(S_TestProgress,value);
  }
  public  void setTestProgressNull(){
     this.set(S_TestProgress,null);
  }

  public String getTestProgress(){
       return DataType.getAsString(this.get(S_TestProgress));
  
  }
  public String getTestProgressInitialValue(){
        return DataType.getAsString(this.getOldObj(S_TestProgress));
      }

  public void initDevPersion(String value){
     this.initProperty(S_DevPersion,value);
  }
  public  void setDevPersion(String value){
     this.set(S_DevPersion,value);
  }
  public  void setDevPersionNull(){
     this.set(S_DevPersion,null);
  }

  public String getDevPersion(){
       return DataType.getAsString(this.get(S_DevPersion));
  
  }
  public String getDevPersionInitialValue(){
        return DataType.getAsString(this.getOldObj(S_DevPersion));
      }

  public void initPlCompleteTime(Timestamp value){
     this.initProperty(S_PlCompleteTime,value);
  }
  public  void setPlCompleteTime(Timestamp value){
     this.set(S_PlCompleteTime,value);
  }
  public  void setPlCompleteTimeNull(){
     this.set(S_PlCompleteTime,null);
  }

  public Timestamp getPlCompleteTime(){
        return DataType.getAsDateTime(this.get(S_PlCompleteTime));
  
  }
  public Timestamp getPlCompleteTimeInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_PlCompleteTime));
      }

  public void initTestGroup(String value){
     this.initProperty(S_TestGroup,value);
  }
  public  void setTestGroup(String value){
     this.set(S_TestGroup,value);
  }
  public  void setTestGroupNull(){
     this.set(S_TestGroup,null);
  }

  public String getTestGroup(){
       return DataType.getAsString(this.get(S_TestGroup));
  
  }
  public String getTestGroupInitialValue(){
        return DataType.getAsString(this.getOldObj(S_TestGroup));
      }

  public void initTestSituation(String value){
     this.initProperty(S_TestSituation,value);
  }
  public  void setTestSituation(String value){
     this.set(S_TestSituation,value);
  }
  public  void setTestSituationNull(){
     this.set(S_TestSituation,null);
  }

  public String getTestSituation(){
       return DataType.getAsString(this.get(S_TestSituation));
  
  }
  public String getTestSituationInitialValue(){
        return DataType.getAsString(this.getOldObj(S_TestSituation));
      }

  public void initDevFirm(long value){
     this.initProperty(S_DevFirm,new Long(value));
  }
  public  void setDevFirm(long value){
     this.set(S_DevFirm,new Long(value));
  }
  public  void setDevFirmNull(){
     this.set(S_DevFirm,null);
  }

  public long getDevFirm(){
        return DataType.getAsLong(this.get(S_DevFirm));
  
  }
  public long getDevFirmInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_DevFirm));
      }

  public void initReqType(String value){
     this.initProperty(S_ReqType,value);
  }
  public  void setReqType(String value){
     this.set(S_ReqType,value);
  }
  public  void setReqTypeNull(){
     this.set(S_ReqType,null);
  }

  public String getReqType(){
       return DataType.getAsString(this.get(S_ReqType));
  
  }
  public String getReqTypeInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ReqType));
      }

  public void initReqTag(String value){
     this.initProperty(S_ReqTag,value);
  }
  public  void setReqTag(String value){
     this.set(S_ReqTag,value);
  }
  public  void setReqTagNull(){
     this.set(S_ReqTag,null);
  }

  public String getReqTag(){
       return DataType.getAsString(this.get(S_ReqTag));
  
  }
  public String getReqTagInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ReqTag));
      }

  public void initUetTaskId(long value){
     this.initProperty(S_UetTaskId,new Long(value));
  }
  public  void setUetTaskId(long value){
     this.set(S_UetTaskId,new Long(value));
  }
  public  void setUetTaskIdNull(){
     this.set(S_UetTaskId,null);
  }

  public long getUetTaskId(){
        return DataType.getAsLong(this.get(S_UetTaskId));
  
  }
  public long getUetTaskIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_UetTaskId));
      }

  public void initReqId(long value){
     this.initProperty(S_ReqId,new Long(value));
  }
  public  void setReqId(long value){
     this.set(S_ReqId,new Long(value));
  }
  public  void setReqIdNull(){
     this.set(S_ReqId,null);
  }

  public long getReqId(){
        return DataType.getAsLong(this.get(S_ReqId));
  
  }
  public long getReqIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_ReqId));
      }

  public void initDefectNumber(int value){
     this.initProperty(S_DefectNumber,new Integer(value));
  }
  public  void setDefectNumber(int value){
     this.set(S_DefectNumber,new Integer(value));
  }
  public  void setDefectNumberNull(){
     this.set(S_DefectNumber,null);
  }

  public int getDefectNumber(){
        return DataType.getAsInt(this.get(S_DefectNumber));
  
  }
  public int getDefectNumberInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_DefectNumber));
      }

  public void initInitialSituation(String value){
     this.initProperty(S_InitialSituation,value);
  }
  public  void setInitialSituation(String value){
     this.set(S_InitialSituation,value);
  }
  public  void setInitialSituationNull(){
     this.set(S_InitialSituation,null);
  }

  public String getInitialSituation(){
       return DataType.getAsString(this.get(S_InitialSituation));
  
  }
  public String getInitialSituationInitialValue(){
        return DataType.getAsString(this.getOldObj(S_InitialSituation));
      }

  public void initSubmitStaffName(String value){
     this.initProperty(S_SubmitStaffName,value);
  }
  public  void setSubmitStaffName(String value){
     this.set(S_SubmitStaffName,value);
  }
  public  void setSubmitStaffNameNull(){
     this.set(S_SubmitStaffName,null);
  }

  public String getSubmitStaffName(){
       return DataType.getAsString(this.get(S_SubmitStaffName));
  
  }
  public String getSubmitStaffNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_SubmitStaffName));
      }

  public void initRunPersion(int value){
     this.initProperty(S_RunPersion,new Integer(value));
  }
  public  void setRunPersion(int value){
     this.set(S_RunPersion,new Integer(value));
  }
  public  void setRunPersionNull(){
     this.set(S_RunPersion,null);
  }

  public int getRunPersion(){
        return DataType.getAsInt(this.get(S_RunPersion));
  
  }
  public int getRunPersionInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_RunPersion));
      }

  public void initTestType(long value){
     this.initProperty(S_TestType,new Long(value));
  }
  public  void setTestType(long value){
     this.set(S_TestType,new Long(value));
  }
  public  void setTestTypeNull(){
     this.set(S_TestType,null);
  }

  public long getTestType(){
        return DataType.getAsLong(this.get(S_TestType));
  
  }
  public long getTestTypeInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_TestType));
      }

  public void initTaskName(String value){
     this.initProperty(S_TaskName,value);
  }
  public  void setTaskName(String value){
     this.set(S_TaskName,value);
  }
  public  void setTaskNameNull(){
     this.set(S_TaskName,null);
  }

  public String getTaskName(){
       return DataType.getAsString(this.get(S_TaskName));
  
  }
  public String getTaskNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_TaskName));
      }

  public void initDevTag(String value){
     this.initProperty(S_DevTag,value);
  }
  public  void setDevTag(String value){
     this.set(S_DevTag,value);
  }
  public  void setDevTagNull(){
     this.set(S_DevTag,null);
  }

  public String getDevTag(){
       return DataType.getAsString(this.get(S_DevTag));
  
  }
  public String getDevTagInitialValue(){
        return DataType.getAsString(this.getOldObj(S_DevTag));
      }

  public void initTaskTag(String value){
     this.initProperty(S_TaskTag,value);
  }
  public  void setTaskTag(String value){
     this.set(S_TaskTag,value);
  }
  public  void setTaskTagNull(){
     this.set(S_TaskTag,null);
  }

  public String getTaskTag(){
       return DataType.getAsString(this.get(S_TaskTag));
  
  }
  public String getTaskTagInitialValue(){
        return DataType.getAsString(this.getOldObj(S_TaskTag));
      }

  public void initDevWorkDay(String value){
     this.initProperty(S_DevWorkDay,value);
  }
  public  void setDevWorkDay(String value){
     this.set(S_DevWorkDay,value);
  }
  public  void setDevWorkDayNull(){
     this.set(S_DevWorkDay,null);
  }

  public String getDevWorkDay(){
       return DataType.getAsString(this.get(S_DevWorkDay));
  
  }
  public String getDevWorkDayInitialValue(){
        return DataType.getAsString(this.getOldObj(S_DevWorkDay));
      }

  public void initIsImportanceReq(int value){
     this.initProperty(S_IsImportanceReq,new Integer(value));
  }
  public  void setIsImportanceReq(int value){
     this.set(S_IsImportanceReq,new Integer(value));
  }
  public  void setIsImportanceReqNull(){
     this.set(S_IsImportanceReq,null);
  }

  public int getIsImportanceReq(){
        return DataType.getAsInt(this.get(S_IsImportanceReq));
  
  }
  public int getIsImportanceReqInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_IsImportanceReq));
      }

  public void initDistributeTime(String value){
     this.initProperty(S_DistributeTime,value);
  }
  public  void setDistributeTime(String value){
     this.set(S_DistributeTime,value);
  }
  public  void setDistributeTimeNull(){
     this.set(S_DistributeTime,null);
  }

  public String getDistributeTime(){
       return DataType.getAsString(this.get(S_DistributeTime));
  
  }
  public String getDistributeTimeInitialValue(){
        return DataType.getAsString(this.getOldObj(S_DistributeTime));
      }


 
 }

