package com.asiainfo.csc.matrix.bo;

import java.sql.*;
import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.common.DataType;

import com.asiainfo.csc.matrix.ivalues.*;

public class BOAlmHisWorkflowCaseBean extends DataContainer implements DataContainerInterface,IBOAlmHisWorkflowCaseValue{

  private static String  m_boName = "com.asiainfo.csc.matrix.bo.BOAlmHisWorkflowCase";



  public final static  String S_State = "STATE";
  public final static  String S_WorkflowObjectId = "WORKFLOW_OBJECT_ID";
  public final static  String S_CreateStaffId = "CREATE_STAFF_ID";
  public final static  String S_EngineWorkflowId = "ENGINE_WORKFLOW_ID";
  public final static  String S_StateDate = "STATE_DATE";
  public final static  String S_WarningTimes = "WARNING_TIMES";
  public final static  String S_TaskId = "TASK_ID";
  public final static  String S_FinishDate = "FINISH_DATE";
  public final static  String S_Vars = "VARS";
  public final static  String S_QueueId = "QUEUE_ID";
  public final static  String S_EngineType = "ENGINE_TYPE";
  public final static  String S_TaskType = "TASK_TYPE";
  public final static  String S_Duration = "DURATION";
  public final static  String S_WarningDate = "WARNING_DATE";
  public final static  String S_ParentTaskId = "PARENT_TASK_ID";
  public final static  String S_TaskTemplateId = "TASK_TEMPLATE_ID";
  public final static  String S_UserTaskCount = "USER_TASK_COUNT";
  public final static  String S_Description = "DESCRIPTION";
  public final static  String S_WorkflowObjectTypeId = "WORKFLOW_OBJECT_TYPE_ID";
  public final static  String S_Label = "LABEL";
  public final static  String S_CurrentTaskId = "CURRENT_TASK_ID";
  public final static  String S_ErrorMessage = "ERROR_MESSAGE";
  public final static  String S_StartDate = "START_DATE";
  public final static  String S_IsExceptionWorkflow = "IS_EXCEPTION_WORKFLOW";
  public final static  String S_DistrictId = "DISTRICT_ID";
  public final static  String S_ErrorCount = "ERROR_COUNT";
  public final static  String S_OpStaffId = "OP_STAFF_ID";
  public final static  String S_CreateDate = "CREATE_DATE";
  public final static  String S_TaskTag = "TASK_TAG";
  public BOAlmHisWorkflowCaseBean() throws AIException{
      super(ServiceManager.getObjectTypeFactory().getInstance(m_boName));
  }


 public static ObjectType getObjectTypeStatic() throws AIException{
   return ServiceManager.getObjectTypeFactory().getInstance(m_boName);
 }

 public void setObjectType(ObjectType  value) throws AIException{
   throw new AIException("此种数据容器不能重置业务对象类型");
 }


  public void initState(long value){
     this.initProperty(S_State,new Long(value));
  }
  public  void setState(long value){
     this.set(S_State,new Long(value));
  }
  public  void setStateNull(){
     this.set(S_State,null);
  }

  public long getState(){
        return DataType.getAsLong(this.get(S_State));
  
  }
  public long getStateInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_State));
      }

  public void initWorkflowObjectId(String value){
     this.initProperty(S_WorkflowObjectId,value);
  }
  public  void setWorkflowObjectId(String value){
     this.set(S_WorkflowObjectId,value);
  }
  public  void setWorkflowObjectIdNull(){
     this.set(S_WorkflowObjectId,null);
  }

  public String getWorkflowObjectId(){
       return DataType.getAsString(this.get(S_WorkflowObjectId));
  
  }
  public String getWorkflowObjectIdInitialValue(){
        return DataType.getAsString(this.getOldObj(S_WorkflowObjectId));
      }

  public void initCreateStaffId(String value){
     this.initProperty(S_CreateStaffId,value);
  }
  public  void setCreateStaffId(String value){
     this.set(S_CreateStaffId,value);
  }
  public  void setCreateStaffIdNull(){
     this.set(S_CreateStaffId,null);
  }

  public String getCreateStaffId(){
       return DataType.getAsString(this.get(S_CreateStaffId));
  
  }
  public String getCreateStaffIdInitialValue(){
        return DataType.getAsString(this.getOldObj(S_CreateStaffId));
      }

  public void initEngineWorkflowId(String value){
     this.initProperty(S_EngineWorkflowId,value);
  }
  public  void setEngineWorkflowId(String value){
     this.set(S_EngineWorkflowId,value);
  }
  public  void setEngineWorkflowIdNull(){
     this.set(S_EngineWorkflowId,null);
  }

  public String getEngineWorkflowId(){
       return DataType.getAsString(this.get(S_EngineWorkflowId));
  
  }
  public String getEngineWorkflowIdInitialValue(){
        return DataType.getAsString(this.getOldObj(S_EngineWorkflowId));
      }

  public void initStateDate(Timestamp value){
     this.initProperty(S_StateDate,value);
  }
  public  void setStateDate(Timestamp value){
     this.set(S_StateDate,value);
  }
  public  void setStateDateNull(){
     this.set(S_StateDate,null);
  }

  public Timestamp getStateDate(){
        return DataType.getAsDateTime(this.get(S_StateDate));
  
  }
  public Timestamp getStateDateInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_StateDate));
      }

  public void initWarningTimes(long value){
     this.initProperty(S_WarningTimes,new Long(value));
  }
  public  void setWarningTimes(long value){
     this.set(S_WarningTimes,new Long(value));
  }
  public  void setWarningTimesNull(){
     this.set(S_WarningTimes,null);
  }

  public long getWarningTimes(){
        return DataType.getAsLong(this.get(S_WarningTimes));
  
  }
  public long getWarningTimesInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_WarningTimes));
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

  public void initFinishDate(Timestamp value){
     this.initProperty(S_FinishDate,value);
  }
  public  void setFinishDate(Timestamp value){
     this.set(S_FinishDate,value);
  }
  public  void setFinishDateNull(){
     this.set(S_FinishDate,null);
  }

  public Timestamp getFinishDate(){
        return DataType.getAsDateTime(this.get(S_FinishDate));
  
  }
  public Timestamp getFinishDateInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_FinishDate));
      }

  public void initVars(String value){
     this.initProperty(S_Vars,value);
  }
  public  void setVars(String value){
     this.set(S_Vars,value);
  }
  public  void setVarsNull(){
     this.set(S_Vars,null);
  }

  public String getVars(){
       return DataType.getAsString(this.get(S_Vars));
  
  }
  public String getVarsInitialValue(){
        return DataType.getAsString(this.getOldObj(S_Vars));
      }

  public void initQueueId(String value){
     this.initProperty(S_QueueId,value);
  }
  public  void setQueueId(String value){
     this.set(S_QueueId,value);
  }
  public  void setQueueIdNull(){
     this.set(S_QueueId,null);
  }

  public String getQueueId(){
       return DataType.getAsString(this.get(S_QueueId));
  
  }
  public String getQueueIdInitialValue(){
        return DataType.getAsString(this.getOldObj(S_QueueId));
      }

  public void initEngineType(String value){
     this.initProperty(S_EngineType,value);
  }
  public  void setEngineType(String value){
     this.set(S_EngineType,value);
  }
  public  void setEngineTypeNull(){
     this.set(S_EngineType,null);
  }

  public String getEngineType(){
       return DataType.getAsString(this.get(S_EngineType));
  
  }
  public String getEngineTypeInitialValue(){
        return DataType.getAsString(this.getOldObj(S_EngineType));
      }

  public void initTaskType(String value){
     this.initProperty(S_TaskType,value);
  }
  public  void setTaskType(String value){
     this.set(S_TaskType,value);
  }
  public  void setTaskTypeNull(){
     this.set(S_TaskType,null);
  }

  public String getTaskType(){
       return DataType.getAsString(this.get(S_TaskType));
  
  }
  public String getTaskTypeInitialValue(){
        return DataType.getAsString(this.getOldObj(S_TaskType));
      }

  public void initDuration(long value){
     this.initProperty(S_Duration,new Long(value));
  }
  public  void setDuration(long value){
     this.set(S_Duration,new Long(value));
  }
  public  void setDurationNull(){
     this.set(S_Duration,null);
  }

  public long getDuration(){
        return DataType.getAsLong(this.get(S_Duration));
  
  }
  public long getDurationInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_Duration));
      }

  public void initWarningDate(Timestamp value){
     this.initProperty(S_WarningDate,value);
  }
  public  void setWarningDate(Timestamp value){
     this.set(S_WarningDate,value);
  }
  public  void setWarningDateNull(){
     this.set(S_WarningDate,null);
  }

  public Timestamp getWarningDate(){
        return DataType.getAsDateTime(this.get(S_WarningDate));
  
  }
  public Timestamp getWarningDateInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_WarningDate));
      }

  public void initParentTaskId(long value){
     this.initProperty(S_ParentTaskId,new Long(value));
  }
  public  void setParentTaskId(long value){
     this.set(S_ParentTaskId,new Long(value));
  }
  public  void setParentTaskIdNull(){
     this.set(S_ParentTaskId,null);
  }

  public long getParentTaskId(){
        return DataType.getAsLong(this.get(S_ParentTaskId));
  
  }
  public long getParentTaskIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_ParentTaskId));
      }

  public void initTaskTemplateId(long value){
     this.initProperty(S_TaskTemplateId,new Long(value));
  }
  public  void setTaskTemplateId(long value){
     this.set(S_TaskTemplateId,new Long(value));
  }
  public  void setTaskTemplateIdNull(){
     this.set(S_TaskTemplateId,null);
  }

  public long getTaskTemplateId(){
        return DataType.getAsLong(this.get(S_TaskTemplateId));
  
  }
  public long getTaskTemplateIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_TaskTemplateId));
      }

  public void initUserTaskCount(long value){
     this.initProperty(S_UserTaskCount,new Long(value));
  }
  public  void setUserTaskCount(long value){
     this.set(S_UserTaskCount,new Long(value));
  }
  public  void setUserTaskCountNull(){
     this.set(S_UserTaskCount,null);
  }

  public long getUserTaskCount(){
        return DataType.getAsLong(this.get(S_UserTaskCount));
  
  }
  public long getUserTaskCountInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_UserTaskCount));
      }

  public void initDescription(String value){
     this.initProperty(S_Description,value);
  }
  public  void setDescription(String value){
     this.set(S_Description,value);
  }
  public  void setDescriptionNull(){
     this.set(S_Description,null);
  }

  public String getDescription(){
       return DataType.getAsString(this.get(S_Description));
  
  }
  public String getDescriptionInitialValue(){
        return DataType.getAsString(this.getOldObj(S_Description));
      }

  public void initWorkflowObjectTypeId(String value){
     this.initProperty(S_WorkflowObjectTypeId,value);
  }
  public  void setWorkflowObjectTypeId(String value){
     this.set(S_WorkflowObjectTypeId,value);
  }
  public  void setWorkflowObjectTypeIdNull(){
     this.set(S_WorkflowObjectTypeId,null);
  }

  public String getWorkflowObjectTypeId(){
       return DataType.getAsString(this.get(S_WorkflowObjectTypeId));
  
  }
  public String getWorkflowObjectTypeIdInitialValue(){
        return DataType.getAsString(this.getOldObj(S_WorkflowObjectTypeId));
      }

  public void initLabel(String value){
     this.initProperty(S_Label,value);
  }
  public  void setLabel(String value){
     this.set(S_Label,value);
  }
  public  void setLabelNull(){
     this.set(S_Label,null);
  }

  public String getLabel(){
       return DataType.getAsString(this.get(S_Label));
  
  }
  public String getLabelInitialValue(){
        return DataType.getAsString(this.getOldObj(S_Label));
      }

  public void initCurrentTaskId(String value){
     this.initProperty(S_CurrentTaskId,value);
  }
  public  void setCurrentTaskId(String value){
     this.set(S_CurrentTaskId,value);
  }
  public  void setCurrentTaskIdNull(){
     this.set(S_CurrentTaskId,null);
  }

  public String getCurrentTaskId(){
       return DataType.getAsString(this.get(S_CurrentTaskId));
  
  }
  public String getCurrentTaskIdInitialValue(){
        return DataType.getAsString(this.getOldObj(S_CurrentTaskId));
      }

  public void initErrorMessage(String value){
     this.initProperty(S_ErrorMessage,value);
  }
  public  void setErrorMessage(String value){
     this.set(S_ErrorMessage,value);
  }
  public  void setErrorMessageNull(){
     this.set(S_ErrorMessage,null);
  }

  public String getErrorMessage(){
       return DataType.getAsString(this.get(S_ErrorMessage));
  
  }
  public String getErrorMessageInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ErrorMessage));
      }

  public void initStartDate(Timestamp value){
     this.initProperty(S_StartDate,value);
  }
  public  void setStartDate(Timestamp value){
     this.set(S_StartDate,value);
  }
  public  void setStartDateNull(){
     this.set(S_StartDate,null);
  }

  public Timestamp getStartDate(){
        return DataType.getAsDateTime(this.get(S_StartDate));
  
  }
  public Timestamp getStartDateInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_StartDate));
      }

  public void initIsExceptionWorkflow(long value){
     this.initProperty(S_IsExceptionWorkflow,new Long(value));
  }
  public  void setIsExceptionWorkflow(long value){
     this.set(S_IsExceptionWorkflow,new Long(value));
  }
  public  void setIsExceptionWorkflowNull(){
     this.set(S_IsExceptionWorkflow,null);
  }

  public long getIsExceptionWorkflow(){
        return DataType.getAsLong(this.get(S_IsExceptionWorkflow));
  
  }
  public long getIsExceptionWorkflowInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_IsExceptionWorkflow));
      }

  public void initDistrictId(String value){
     this.initProperty(S_DistrictId,value);
  }
  public  void setDistrictId(String value){
     this.set(S_DistrictId,value);
  }
  public  void setDistrictIdNull(){
     this.set(S_DistrictId,null);
  }

  public String getDistrictId(){
       return DataType.getAsString(this.get(S_DistrictId));
  
  }
  public String getDistrictIdInitialValue(){
        return DataType.getAsString(this.getOldObj(S_DistrictId));
      }

  public void initErrorCount(long value){
     this.initProperty(S_ErrorCount,new Long(value));
  }
  public  void setErrorCount(long value){
     this.set(S_ErrorCount,new Long(value));
  }
  public  void setErrorCountNull(){
     this.set(S_ErrorCount,null);
  }

  public long getErrorCount(){
        return DataType.getAsLong(this.get(S_ErrorCount));
  
  }
  public long getErrorCountInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_ErrorCount));
      }

  public void initOpStaffId(String value){
     this.initProperty(S_OpStaffId,value);
  }
  public  void setOpStaffId(String value){
     this.set(S_OpStaffId,value);
  }
  public  void setOpStaffIdNull(){
     this.set(S_OpStaffId,null);
  }

  public String getOpStaffId(){
       return DataType.getAsString(this.get(S_OpStaffId));
  
  }
  public String getOpStaffIdInitialValue(){
        return DataType.getAsString(this.getOldObj(S_OpStaffId));
      }

  public void initCreateDate(Timestamp value){
     this.initProperty(S_CreateDate,value);
  }
  public  void setCreateDate(Timestamp value){
     this.set(S_CreateDate,value);
  }
  public  void setCreateDateNull(){
     this.set(S_CreateDate,null);
  }

  public Timestamp getCreateDate(){
        return DataType.getAsDateTime(this.get(S_CreateDate));
  
  }
  public Timestamp getCreateDateInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_CreateDate));
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


 
 }

