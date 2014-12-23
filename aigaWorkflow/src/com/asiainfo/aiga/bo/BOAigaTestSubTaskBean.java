package com.asiainfo.aiga.bo;

import java.sql.*;
import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.common.DataType;

import com.asiainfo.aiga.ivalues.*;

public class BOAigaTestSubTaskBean extends DataContainer implements DataContainerInterface,IBOAigaTestSubTaskValue{

  private static String  m_boName = "com.asiainfo.aiga.bo.BOAigaTestSubTask";



  public final static  String S_PossibleBack = "POSSIBLE_BACK";
  public final static  String S_JointEnvironment = "JOINT_ENVIRONMENT";
  public final static  String S_FactCompleteTime = "FACT_COMPLETE_TIME";
  public final static  String S_CreateTime = "CREATE_TIME";
  public final static  String S_Creator = "CREATOR";
  public final static  String S_TaskId = "TASK_ID";
  public final static  String S_SubTaskType = "SUB_TASK_TYPE";
  public final static  String S_SubTaskTag = "SUB_TASK_TAG";
  public final static  String S_SubType = "SUB_TYPE";
  public final static  String S_JoinType = "JOIN_TYPE";
  public final static  String S_PossibleTestReason = "POSSIBLE_TEST_REASON";
  public final static  String S_Usable = "USABLE";
  public final static  String S_SubmitStaffId = "SUBMIT_STAFF_ID";
  public final static  String S_OperId = "OPER_ID";
  public final static  String S_ReviewTime = "REVIEW_TIME";
  public final static  String S_IsPerformance = "IS_PERFORMANCE";
  public final static  String S_TestWorkDay = "TEST_WORK_DAY";
  public final static  String S_TestorId = "TESTOR_ID";
  public final static  String S_SubTaskStatus = "SUB_TASK_STATUS";
  public final static  String S_PossibleProduct = "POSSIBLE_PRODUCT";
  public final static  String S_OperName = "OPER_NAME";
  public final static  String S_BigType = "BIG_TYPE";
  public final static  String S_SubTaskId = "SUB_TASK_ID";
  public final static  String S_ScriptPerRate = "SCRIPT_PER_RATE";
  public final static  String S_CurPhase = "CUR_PHASE";
  public final static  String S_PossibleProductReason = "POSSIBLE_PRODUCT_REASON";
  public final static  String S_AuditRate = "AUDIT_RATE";
  public final static  String S_PossibleTest = "POSSIBLE_TEST";
  public final static  String S_SubTaskClass = "SUB_TASK_CLASS";
  public final static  String S_JoinDebugValsOther = "JOIN_DEBUG_VALS_OTHER";
  public final static  String S_IsJointDebug = "IS_JOINT_DEBUG";
  public final static  String S_PlCompleteTime = "PL_COMPLETE_TIME";
  public final static  String S_JoinDebugVals = "JOIN_DEBUG_VALS";
  public final static  String S_ReviewResult = "REVIEW_RESULT";
  public final static  String S_ScriptFunRate = "SCRIPT_FUN_RATE";
  public final static  String S_ReqTag = "REQ_TAG";
  public final static  String S_SubTaskName = "SUB_TASK_NAME";
  public final static  String S_CreatorStaff = "CREATOR_STAFF";
  public final static  String S_SubmitStaffName = "SUBMIT_STAFF_NAME";
  public final static  String S_PossibleBackReason = "POSSIBLE_BACK_REASON";
  public final static  String S_TestorName = "TESTOR_NAME";
  public final static  String S_SubTaskPriority = "SUB_TASK_PRIORITY";
  public final static  String S_TaskTag = "TASK_TAG";
  public final static  String S_DevWorkDay = "DEV_WORK_DAY";
  public BOAigaTestSubTaskBean() throws AIException{
      super(ServiceManager.getObjectTypeFactory().getInstance(m_boName));
  }


 public static ObjectType getObjectTypeStatic() throws AIException{
   return ServiceManager.getObjectTypeFactory().getInstance(m_boName);
 }

 public void setObjectType(ObjectType  value) throws AIException{
   throw new AIException("此种数据容器不能重置业务对象类型");
 }


  public void initPossibleBack(long value){
     this.initProperty(S_PossibleBack,new Long(value));
  }
  public  void setPossibleBack(long value){
     this.set(S_PossibleBack,new Long(value));
  }
  public  void setPossibleBackNull(){
     this.set(S_PossibleBack,null);
  }

  public long getPossibleBack(){
        return DataType.getAsLong(this.get(S_PossibleBack));
  
  }
  public long getPossibleBackInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_PossibleBack));
      }

  public void initJointEnvironment(long value){
     this.initProperty(S_JointEnvironment,new Long(value));
  }
  public  void setJointEnvironment(long value){
     this.set(S_JointEnvironment,new Long(value));
  }
  public  void setJointEnvironmentNull(){
     this.set(S_JointEnvironment,null);
  }

  public long getJointEnvironment(){
        return DataType.getAsLong(this.get(S_JointEnvironment));
  
  }
  public long getJointEnvironmentInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_JointEnvironment));
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

  public void initCreator(String value){
     this.initProperty(S_Creator,value);
  }
  public  void setCreator(String value){
     this.set(S_Creator,value);
  }
  public  void setCreatorNull(){
     this.set(S_Creator,null);
  }

  public String getCreator(){
       return DataType.getAsString(this.get(S_Creator));
  
  }
  public String getCreatorInitialValue(){
        return DataType.getAsString(this.getOldObj(S_Creator));
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

  public void initSubTaskType(long value){
     this.initProperty(S_SubTaskType,new Long(value));
  }
  public  void setSubTaskType(long value){
     this.set(S_SubTaskType,new Long(value));
  }
  public  void setSubTaskTypeNull(){
     this.set(S_SubTaskType,null);
  }

  public long getSubTaskType(){
        return DataType.getAsLong(this.get(S_SubTaskType));
  
  }
  public long getSubTaskTypeInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_SubTaskType));
      }

  public void initSubTaskTag(String value){
     this.initProperty(S_SubTaskTag,value);
  }
  public  void setSubTaskTag(String value){
     this.set(S_SubTaskTag,value);
  }
  public  void setSubTaskTagNull(){
     this.set(S_SubTaskTag,null);
  }

  public String getSubTaskTag(){
       return DataType.getAsString(this.get(S_SubTaskTag));
  
  }
  public String getSubTaskTagInitialValue(){
        return DataType.getAsString(this.getOldObj(S_SubTaskTag));
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

  public void initJoinType(long value){
     this.initProperty(S_JoinType,new Long(value));
  }
  public  void setJoinType(long value){
     this.set(S_JoinType,new Long(value));
  }
  public  void setJoinTypeNull(){
     this.set(S_JoinType,null);
  }

  public long getJoinType(){
        return DataType.getAsLong(this.get(S_JoinType));
  
  }
  public long getJoinTypeInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_JoinType));
      }

  public void initPossibleTestReason(String value){
     this.initProperty(S_PossibleTestReason,value);
  }
  public  void setPossibleTestReason(String value){
     this.set(S_PossibleTestReason,value);
  }
  public  void setPossibleTestReasonNull(){
     this.set(S_PossibleTestReason,null);
  }

  public String getPossibleTestReason(){
       return DataType.getAsString(this.get(S_PossibleTestReason));
  
  }
  public String getPossibleTestReasonInitialValue(){
        return DataType.getAsString(this.getOldObj(S_PossibleTestReason));
      }

  public void initUsable(long value){
     this.initProperty(S_Usable,new Long(value));
  }
  public  void setUsable(long value){
     this.set(S_Usable,new Long(value));
  }
  public  void setUsableNull(){
     this.set(S_Usable,null);
  }

  public long getUsable(){
        return DataType.getAsLong(this.get(S_Usable));
  
  }
  public long getUsableInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_Usable));
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

  public void initOperId(long value){
     this.initProperty(S_OperId,new Long(value));
  }
  public  void setOperId(long value){
     this.set(S_OperId,new Long(value));
  }
  public  void setOperIdNull(){
     this.set(S_OperId,null);
  }

  public long getOperId(){
        return DataType.getAsLong(this.get(S_OperId));
  
  }
  public long getOperIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_OperId));
      }

  public void initReviewTime(Timestamp value){
     this.initProperty(S_ReviewTime,value);
  }
  public  void setReviewTime(Timestamp value){
     this.set(S_ReviewTime,value);
  }
  public  void setReviewTimeNull(){
     this.set(S_ReviewTime,null);
  }

  public Timestamp getReviewTime(){
        return DataType.getAsDateTime(this.get(S_ReviewTime));
  
  }
  public Timestamp getReviewTimeInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_ReviewTime));
      }

  public void initIsPerformance(long value){
     this.initProperty(S_IsPerformance,new Long(value));
  }
  public  void setIsPerformance(long value){
     this.set(S_IsPerformance,new Long(value));
  }
  public  void setIsPerformanceNull(){
     this.set(S_IsPerformance,null);
  }

  public long getIsPerformance(){
        return DataType.getAsLong(this.get(S_IsPerformance));
  
  }
  public long getIsPerformanceInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_IsPerformance));
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

  public void initTestorId(long value){
     this.initProperty(S_TestorId,new Long(value));
  }
  public  void setTestorId(long value){
     this.set(S_TestorId,new Long(value));
  }
  public  void setTestorIdNull(){
     this.set(S_TestorId,null);
  }

  public long getTestorId(){
        return DataType.getAsLong(this.get(S_TestorId));
  
  }
  public long getTestorIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_TestorId));
      }

  public void initSubTaskStatus(long value){
     this.initProperty(S_SubTaskStatus,new Long(value));
  }
  public  void setSubTaskStatus(long value){
     this.set(S_SubTaskStatus,new Long(value));
  }
  public  void setSubTaskStatusNull(){
     this.set(S_SubTaskStatus,null);
  }

  public long getSubTaskStatus(){
        return DataType.getAsLong(this.get(S_SubTaskStatus));
  
  }
  public long getSubTaskStatusInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_SubTaskStatus));
      }

  public void initPossibleProduct(long value){
     this.initProperty(S_PossibleProduct,new Long(value));
  }
  public  void setPossibleProduct(long value){
     this.set(S_PossibleProduct,new Long(value));
  }
  public  void setPossibleProductNull(){
     this.set(S_PossibleProduct,null);
  }

  public long getPossibleProduct(){
        return DataType.getAsLong(this.get(S_PossibleProduct));
  
  }
  public long getPossibleProductInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_PossibleProduct));
      }

  public void initOperName(String value){
     this.initProperty(S_OperName,value);
  }
  public  void setOperName(String value){
     this.set(S_OperName,value);
  }
  public  void setOperNameNull(){
     this.set(S_OperName,null);
  }

  public String getOperName(){
       return DataType.getAsString(this.get(S_OperName));
  
  }
  public String getOperNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_OperName));
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

  public void initSubTaskId(long value){
     this.initProperty(S_SubTaskId,new Long(value));
  }
  public  void setSubTaskId(long value){
     this.set(S_SubTaskId,new Long(value));
  }
  public  void setSubTaskIdNull(){
     this.set(S_SubTaskId,null);
  }

  public long getSubTaskId(){
        return DataType.getAsLong(this.get(S_SubTaskId));
  
  }
  public long getSubTaskIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_SubTaskId));
      }

  public void initScriptPerRate(String value){
     this.initProperty(S_ScriptPerRate,value);
  }
  public  void setScriptPerRate(String value){
     this.set(S_ScriptPerRate,value);
  }
  public  void setScriptPerRateNull(){
     this.set(S_ScriptPerRate,null);
  }

  public String getScriptPerRate(){
       return DataType.getAsString(this.get(S_ScriptPerRate));
  
  }
  public String getScriptPerRateInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ScriptPerRate));
      }

  public void initCurPhase(long value){
     this.initProperty(S_CurPhase,new Long(value));
  }
  public  void setCurPhase(long value){
     this.set(S_CurPhase,new Long(value));
  }
  public  void setCurPhaseNull(){
     this.set(S_CurPhase,null);
  }

  public long getCurPhase(){
        return DataType.getAsLong(this.get(S_CurPhase));
  
  }
  public long getCurPhaseInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_CurPhase));
      }

  public void initPossibleProductReason(String value){
     this.initProperty(S_PossibleProductReason,value);
  }
  public  void setPossibleProductReason(String value){
     this.set(S_PossibleProductReason,value);
  }
  public  void setPossibleProductReasonNull(){
     this.set(S_PossibleProductReason,null);
  }

  public String getPossibleProductReason(){
       return DataType.getAsString(this.get(S_PossibleProductReason));
  
  }
  public String getPossibleProductReasonInitialValue(){
        return DataType.getAsString(this.getOldObj(S_PossibleProductReason));
      }

  public void initAuditRate(String value){
     this.initProperty(S_AuditRate,value);
  }
  public  void setAuditRate(String value){
     this.set(S_AuditRate,value);
  }
  public  void setAuditRateNull(){
     this.set(S_AuditRate,null);
  }

  public String getAuditRate(){
       return DataType.getAsString(this.get(S_AuditRate));
  
  }
  public String getAuditRateInitialValue(){
        return DataType.getAsString(this.getOldObj(S_AuditRate));
      }

  public void initPossibleTest(long value){
     this.initProperty(S_PossibleTest,new Long(value));
  }
  public  void setPossibleTest(long value){
     this.set(S_PossibleTest,new Long(value));
  }
  public  void setPossibleTestNull(){
     this.set(S_PossibleTest,null);
  }

  public long getPossibleTest(){
        return DataType.getAsLong(this.get(S_PossibleTest));
  
  }
  public long getPossibleTestInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_PossibleTest));
      }

  public void initSubTaskClass(long value){
     this.initProperty(S_SubTaskClass,new Long(value));
  }
  public  void setSubTaskClass(long value){
     this.set(S_SubTaskClass,new Long(value));
  }
  public  void setSubTaskClassNull(){
     this.set(S_SubTaskClass,null);
  }

  public long getSubTaskClass(){
        return DataType.getAsLong(this.get(S_SubTaskClass));
  
  }
  public long getSubTaskClassInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_SubTaskClass));
      }

  public void initJoinDebugValsOther(String value){
     this.initProperty(S_JoinDebugValsOther,value);
  }
  public  void setJoinDebugValsOther(String value){
     this.set(S_JoinDebugValsOther,value);
  }
  public  void setJoinDebugValsOtherNull(){
     this.set(S_JoinDebugValsOther,null);
  }

  public String getJoinDebugValsOther(){
       return DataType.getAsString(this.get(S_JoinDebugValsOther));
  
  }
  public String getJoinDebugValsOtherInitialValue(){
        return DataType.getAsString(this.getOldObj(S_JoinDebugValsOther));
      }

  public void initIsJointDebug(long value){
     this.initProperty(S_IsJointDebug,new Long(value));
  }
  public  void setIsJointDebug(long value){
     this.set(S_IsJointDebug,new Long(value));
  }
  public  void setIsJointDebugNull(){
     this.set(S_IsJointDebug,null);
  }

  public long getIsJointDebug(){
        return DataType.getAsLong(this.get(S_IsJointDebug));
  
  }
  public long getIsJointDebugInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_IsJointDebug));
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

  public void initJoinDebugVals(String value){
     this.initProperty(S_JoinDebugVals,value);
  }
  public  void setJoinDebugVals(String value){
     this.set(S_JoinDebugVals,value);
  }
  public  void setJoinDebugValsNull(){
     this.set(S_JoinDebugVals,null);
  }

  public String getJoinDebugVals(){
       return DataType.getAsString(this.get(S_JoinDebugVals));
  
  }
  public String getJoinDebugValsInitialValue(){
        return DataType.getAsString(this.getOldObj(S_JoinDebugVals));
      }

  public void initReviewResult(long value){
     this.initProperty(S_ReviewResult,new Long(value));
  }
  public  void setReviewResult(long value){
     this.set(S_ReviewResult,new Long(value));
  }
  public  void setReviewResultNull(){
     this.set(S_ReviewResult,null);
  }

  public long getReviewResult(){
        return DataType.getAsLong(this.get(S_ReviewResult));
  
  }
  public long getReviewResultInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_ReviewResult));
      }

  public void initScriptFunRate(String value){
     this.initProperty(S_ScriptFunRate,value);
  }
  public  void setScriptFunRate(String value){
     this.set(S_ScriptFunRate,value);
  }
  public  void setScriptFunRateNull(){
     this.set(S_ScriptFunRate,null);
  }

  public String getScriptFunRate(){
       return DataType.getAsString(this.get(S_ScriptFunRate));
  
  }
  public String getScriptFunRateInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ScriptFunRate));
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

  public void initSubTaskName(String value){
     this.initProperty(S_SubTaskName,value);
  }
  public  void setSubTaskName(String value){
     this.set(S_SubTaskName,value);
  }
  public  void setSubTaskNameNull(){
     this.set(S_SubTaskName,null);
  }

  public String getSubTaskName(){
       return DataType.getAsString(this.get(S_SubTaskName));
  
  }
  public String getSubTaskNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_SubTaskName));
      }

  public void initCreatorStaff(String value){
     this.initProperty(S_CreatorStaff,value);
  }
  public  void setCreatorStaff(String value){
     this.set(S_CreatorStaff,value);
  }
  public  void setCreatorStaffNull(){
     this.set(S_CreatorStaff,null);
  }

  public String getCreatorStaff(){
       return DataType.getAsString(this.get(S_CreatorStaff));
  
  }
  public String getCreatorStaffInitialValue(){
        return DataType.getAsString(this.getOldObj(S_CreatorStaff));
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

  public void initPossibleBackReason(String value){
     this.initProperty(S_PossibleBackReason,value);
  }
  public  void setPossibleBackReason(String value){
     this.set(S_PossibleBackReason,value);
  }
  public  void setPossibleBackReasonNull(){
     this.set(S_PossibleBackReason,null);
  }

  public String getPossibleBackReason(){
       return DataType.getAsString(this.get(S_PossibleBackReason));
  
  }
  public String getPossibleBackReasonInitialValue(){
        return DataType.getAsString(this.getOldObj(S_PossibleBackReason));
      }

  public void initTestorName(String value){
     this.initProperty(S_TestorName,value);
  }
  public  void setTestorName(String value){
     this.set(S_TestorName,value);
  }
  public  void setTestorNameNull(){
     this.set(S_TestorName,null);
  }

  public String getTestorName(){
       return DataType.getAsString(this.get(S_TestorName));
  
  }
  public String getTestorNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_TestorName));
      }

  public void initSubTaskPriority(long value){
     this.initProperty(S_SubTaskPriority,new Long(value));
  }
  public  void setSubTaskPriority(long value){
     this.set(S_SubTaskPriority,new Long(value));
  }
  public  void setSubTaskPriorityNull(){
     this.set(S_SubTaskPriority,null);
  }

  public long getSubTaskPriority(){
        return DataType.getAsLong(this.get(S_SubTaskPriority));
  
  }
  public long getSubTaskPriorityInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_SubTaskPriority));
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


 
 }

