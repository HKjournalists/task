package com.asiainfo.aiga.bo;

import java.sql.*;
import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.common.DataType;

import com.asiainfo.aiga.ivalues.*;

public class BOAigaSubTaskProblemBean extends DataContainer implements DataContainerInterface,IBOAigaSubTaskProblemValue{

  private static String  m_boName = "com.asiainfo.aiga.bo.BOAigaSubTaskProblem";



  public final static  String S_StpStatus = "STP_STATUS";
  public final static  String S_SubTaskId = "SUB_TASK_ID";
  public final static  String S_StpPhase = "STP_PHASE";
  public final static  String S_CreateTime = "CREATE_TIME";
  public final static  String S_CreateStaffId = "CREATE_STAFF_ID";
  public final static  String S_StpMainClass = "STP_MAIN_CLASS";
  public final static  String S_StpName = "STP_NAME";
  public final static  String S_SubTaskType = "SUB_TASK_TYPE";
  public final static  String S_SubTaskTag = "SUB_TASK_TAG";
  public final static  String S_StpSubClass = "STP_SUB_CLASS";
  public final static  String S_StartMark = "START_MARK";
  public final static  String S_SubTaskName = "SUB_TASK_NAME";
  public final static  String S_StpTag = "STP_TAG";
  public final static  String S_StpDscr = "STP_DSCR";
  public final static  String S_DefectDscr = "DEFECT_DSCR";
  public final static  String S_Id = "ID";
  public final static  String S_StpInto = "STP_INTO";
  public final static  String S_CreateStaffName = "CREATE_STAFF_NAME";
  public BOAigaSubTaskProblemBean() throws AIException{
      super(ServiceManager.getObjectTypeFactory().getInstance(m_boName));
  }


 public static ObjectType getObjectTypeStatic() throws AIException{
   return ServiceManager.getObjectTypeFactory().getInstance(m_boName);
 }

 public void setObjectType(ObjectType  value) throws AIException{
   throw new AIException("此种数据容器不能重置业务对象类型");
 }


  public void initStpStatus(long value){
     this.initProperty(S_StpStatus,new Long(value));
  }
  public  void setStpStatus(long value){
     this.set(S_StpStatus,new Long(value));
  }
  public  void setStpStatusNull(){
     this.set(S_StpStatus,null);
  }

  public long getStpStatus(){
        return DataType.getAsLong(this.get(S_StpStatus));
  
  }
  public long getStpStatusInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_StpStatus));
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

  public void initStpPhase(long value){
     this.initProperty(S_StpPhase,new Long(value));
  }
  public  void setStpPhase(long value){
     this.set(S_StpPhase,new Long(value));
  }
  public  void setStpPhaseNull(){
     this.set(S_StpPhase,null);
  }

  public long getStpPhase(){
        return DataType.getAsLong(this.get(S_StpPhase));
  
  }
  public long getStpPhaseInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_StpPhase));
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

  public void initCreateStaffId(long value){
     this.initProperty(S_CreateStaffId,new Long(value));
  }
  public  void setCreateStaffId(long value){
     this.set(S_CreateStaffId,new Long(value));
  }
  public  void setCreateStaffIdNull(){
     this.set(S_CreateStaffId,null);
  }

  public long getCreateStaffId(){
        return DataType.getAsLong(this.get(S_CreateStaffId));
  
  }
  public long getCreateStaffIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_CreateStaffId));
      }

  public void initStpMainClass(long value){
     this.initProperty(S_StpMainClass,new Long(value));
  }
  public  void setStpMainClass(long value){
     this.set(S_StpMainClass,new Long(value));
  }
  public  void setStpMainClassNull(){
     this.set(S_StpMainClass,null);
  }

  public long getStpMainClass(){
        return DataType.getAsLong(this.get(S_StpMainClass));
  
  }
  public long getStpMainClassInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_StpMainClass));
      }

  public void initStpName(String value){
     this.initProperty(S_StpName,value);
  }
  public  void setStpName(String value){
     this.set(S_StpName,value);
  }
  public  void setStpNameNull(){
     this.set(S_StpName,null);
  }

  public String getStpName(){
       return DataType.getAsString(this.get(S_StpName));
  
  }
  public String getStpNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_StpName));
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

  public void initStpSubClass(long value){
     this.initProperty(S_StpSubClass,new Long(value));
  }
  public  void setStpSubClass(long value){
     this.set(S_StpSubClass,new Long(value));
  }
  public  void setStpSubClassNull(){
     this.set(S_StpSubClass,null);
  }

  public long getStpSubClass(){
        return DataType.getAsLong(this.get(S_StpSubClass));
  
  }
  public long getStpSubClassInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_StpSubClass));
      }

  public void initStartMark(long value){
     this.initProperty(S_StartMark,new Long(value));
  }
  public  void setStartMark(long value){
     this.set(S_StartMark,new Long(value));
  }
  public  void setStartMarkNull(){
     this.set(S_StartMark,null);
  }

  public long getStartMark(){
        return DataType.getAsLong(this.get(S_StartMark));
  
  }
  public long getStartMarkInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_StartMark));
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

  public void initStpTag(String value){
     this.initProperty(S_StpTag,value);
  }
  public  void setStpTag(String value){
     this.set(S_StpTag,value);
  }
  public  void setStpTagNull(){
     this.set(S_StpTag,null);
  }

  public String getStpTag(){
       return DataType.getAsString(this.get(S_StpTag));
  
  }
  public String getStpTagInitialValue(){
        return DataType.getAsString(this.getOldObj(S_StpTag));
      }

  public void initStpDscr(String value){
     this.initProperty(S_StpDscr,value);
  }
  public  void setStpDscr(String value){
     this.set(S_StpDscr,value);
  }
  public  void setStpDscrNull(){
     this.set(S_StpDscr,null);
  }

  public String getStpDscr(){
       return DataType.getAsString(this.get(S_StpDscr));
  
  }
  public String getStpDscrInitialValue(){
        return DataType.getAsString(this.getOldObj(S_StpDscr));
      }

  public void initDefectDscr(String value){
     this.initProperty(S_DefectDscr,value);
  }
  public  void setDefectDscr(String value){
     this.set(S_DefectDscr,value);
  }
  public  void setDefectDscrNull(){
     this.set(S_DefectDscr,null);
  }

  public String getDefectDscr(){
       return DataType.getAsString(this.get(S_DefectDscr));
  
  }
  public String getDefectDscrInitialValue(){
        return DataType.getAsString(this.getOldObj(S_DefectDscr));
      }

  public void initId(long value){
     this.initProperty(S_Id,new Long(value));
  }
  public  void setId(long value){
     this.set(S_Id,new Long(value));
  }
  public  void setIdNull(){
     this.set(S_Id,null);
  }

  public long getId(){
        return DataType.getAsLong(this.get(S_Id));
  
  }
  public long getIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_Id));
      }

  public void initStpInto(long value){
     this.initProperty(S_StpInto,new Long(value));
  }
  public  void setStpInto(long value){
     this.set(S_StpInto,new Long(value));
  }
  public  void setStpIntoNull(){
     this.set(S_StpInto,null);
  }

  public long getStpInto(){
        return DataType.getAsLong(this.get(S_StpInto));
  
  }
  public long getStpIntoInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_StpInto));
      }

  public void initCreateStaffName(String value){
     this.initProperty(S_CreateStaffName,value);
  }
  public  void setCreateStaffName(String value){
     this.set(S_CreateStaffName,value);
  }
  public  void setCreateStaffNameNull(){
     this.set(S_CreateStaffName,null);
  }

  public String getCreateStaffName(){
       return DataType.getAsString(this.get(S_CreateStaffName));
  
  }
  public String getCreateStaffNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_CreateStaffName));
      }


 
 }

