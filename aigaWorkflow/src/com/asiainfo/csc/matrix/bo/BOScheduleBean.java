package com.asiainfo.csc.matrix.bo;

import java.sql.*;
import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.common.DataType;

import com.asiainfo.csc.matrix.ivalues.*;

public class BOScheduleBean extends DataContainer implements DataContainerInterface,IBOScheduleValue{

  private static String  m_boName = "com.asiainfo.csc.matrix.bo.BOSchedule";



  public final static  String S_StartDate = "START_DATE";
  public final static  String S_State = "STATE";
  public final static  String S_DistrictId = "DISTRICT_ID";
  public final static  String S_AddDate = "ADD_DATE";
  public final static  String S_ScheduleDate = "SCHEDULE_DATE";
  public final static  String S_EngineType = "ENGINE_TYPE";
  public final static  String S_EngineWorkflowId = "ENGINE_WORKFLOW_ID";
  public final static  String S_ScheduleId = "SCHEDULE_ID";
  public final static  String S_WorkflowId = "WORKFLOW_ID";
  public final static  String S_ScheduleServer = "SCHEDULE_SERVER";
  public final static  String S_QueueId = "QUEUE_ID";
  public BOScheduleBean() throws AIException{
      super(ServiceManager.getObjectTypeFactory().getInstance(m_boName));
  }


 public static ObjectType getObjectTypeStatic() throws AIException{
   return ServiceManager.getObjectTypeFactory().getInstance(m_boName);
 }

 public void setObjectType(ObjectType  value) throws AIException{
   throw new AIException("此种数据容器不能重置业务对象类型");
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

  public void initState(String value){
     this.initProperty(S_State,value);
  }
  public  void setState(String value){
     this.set(S_State,value);
  }
  public  void setStateNull(){
     this.set(S_State,null);
  }

  public String getState(){
       return DataType.getAsString(this.get(S_State));
  
  }
  public String getStateInitialValue(){
        return DataType.getAsString(this.getOldObj(S_State));
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

  public void initAddDate(Timestamp value){
     this.initProperty(S_AddDate,value);
  }
  public  void setAddDate(Timestamp value){
     this.set(S_AddDate,value);
  }
  public  void setAddDateNull(){
     this.set(S_AddDate,null);
  }

  public Timestamp getAddDate(){
        return DataType.getAsDateTime(this.get(S_AddDate));
  
  }
  public Timestamp getAddDateInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_AddDate));
      }

  public void initScheduleDate(Timestamp value){
     this.initProperty(S_ScheduleDate,value);
  }
  public  void setScheduleDate(Timestamp value){
     this.set(S_ScheduleDate,value);
  }
  public  void setScheduleDateNull(){
     this.set(S_ScheduleDate,null);
  }

  public Timestamp getScheduleDate(){
        return DataType.getAsDateTime(this.get(S_ScheduleDate));
  
  }
  public Timestamp getScheduleDateInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_ScheduleDate));
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

  public void initScheduleId(long value){
     this.initProperty(S_ScheduleId,new Long(value));
  }
  public  void setScheduleId(long value){
     this.set(S_ScheduleId,new Long(value));
  }
  public  void setScheduleIdNull(){
     this.set(S_ScheduleId,null);
  }

  public long getScheduleId(){
        return DataType.getAsLong(this.get(S_ScheduleId));
  
  }
  public long getScheduleIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_ScheduleId));
      }

  public void initWorkflowId(long value){
     this.initProperty(S_WorkflowId,new Long(value));
  }
  public  void setWorkflowId(long value){
     this.set(S_WorkflowId,new Long(value));
  }
  public  void setWorkflowIdNull(){
     this.set(S_WorkflowId,null);
  }

  public long getWorkflowId(){
        return DataType.getAsLong(this.get(S_WorkflowId));
  
  }
  public long getWorkflowIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_WorkflowId));
      }

  public void initScheduleServer(String value){
     this.initProperty(S_ScheduleServer,value);
  }
  public  void setScheduleServer(String value){
     this.set(S_ScheduleServer,value);
  }
  public  void setScheduleServerNull(){
     this.set(S_ScheduleServer,null);
  }

  public String getScheduleServer(){
       return DataType.getAsString(this.get(S_ScheduleServer));
  
  }
  public String getScheduleServerInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ScheduleServer));
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


 
 }

