package com.asiainfo.aiga.bo;

import java.sql.*;
import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.common.DataType;

import com.asiainfo.aiga.ivalues.*;

public class BOAigaTestTaskChangeBean extends DataContainer implements DataContainerInterface,IBOAigaTestTaskChangeValue{

  private static String  m_boName = "com.asiainfo.aiga.bo.BOAigaTestTaskChange";



  public final static  String S_PlanidN = "PLANID_N";
  public final static  String S_ChagneStaffName = "CHAGNE_STAFF_NAME";
  public final static  String S_ChangeTaskId = "CHANGE_TASK_ID";
  public final static  String S_ChangeReson = "CHANGE_RESON";
  public final static  String S_CreateTime = "CREATE_TIME";
  public final static  String S_PlanidO = "PLANID_O";
  public final static  String S_OnlineTimeN = "ONLINE_TIME_N";
  public final static  String S_OnlineTimeO = "ONLINE_TIME_O";
  public final static  String S_ChangeTaskTag = "CHANGE_TASK_TAG";
  public final static  String S_ChangeStaffId = "CHANGE_STAFF_ID";
  public final static  String S_AtcId = "ATC_ID";
  public BOAigaTestTaskChangeBean() throws AIException{
      super(ServiceManager.getObjectTypeFactory().getInstance(m_boName));
  }


 public static ObjectType getObjectTypeStatic() throws AIException{
   return ServiceManager.getObjectTypeFactory().getInstance(m_boName);
 }

 public void setObjectType(ObjectType  value) throws AIException{
   throw new AIException("此种数据容器不能重置业务对象类型");
 }


  public void initPlanidN(long value){
     this.initProperty(S_PlanidN,new Long(value));
  }
  public  void setPlanidN(long value){
     this.set(S_PlanidN,new Long(value));
  }
  public  void setPlanidNNull(){
     this.set(S_PlanidN,null);
  }

  public long getPlanidN(){
        return DataType.getAsLong(this.get(S_PlanidN));
  
  }
  public long getPlanidNInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_PlanidN));
      }

  public void initChagneStaffName(String value){
     this.initProperty(S_ChagneStaffName,value);
  }
  public  void setChagneStaffName(String value){
     this.set(S_ChagneStaffName,value);
  }
  public  void setChagneStaffNameNull(){
     this.set(S_ChagneStaffName,null);
  }

  public String getChagneStaffName(){
       return DataType.getAsString(this.get(S_ChagneStaffName));
  
  }
  public String getChagneStaffNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ChagneStaffName));
      }

  public void initChangeTaskId(long value){
     this.initProperty(S_ChangeTaskId,new Long(value));
  }
  public  void setChangeTaskId(long value){
     this.set(S_ChangeTaskId,new Long(value));
  }
  public  void setChangeTaskIdNull(){
     this.set(S_ChangeTaskId,null);
  }

  public long getChangeTaskId(){
        return DataType.getAsLong(this.get(S_ChangeTaskId));
  
  }
  public long getChangeTaskIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_ChangeTaskId));
      }

  public void initChangeReson(String value){
     this.initProperty(S_ChangeReson,value);
  }
  public  void setChangeReson(String value){
     this.set(S_ChangeReson,value);
  }
  public  void setChangeResonNull(){
     this.set(S_ChangeReson,null);
  }

  public String getChangeReson(){
       return DataType.getAsString(this.get(S_ChangeReson));
  
  }
  public String getChangeResonInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ChangeReson));
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

  public void initPlanidO(long value){
     this.initProperty(S_PlanidO,new Long(value));
  }
  public  void setPlanidO(long value){
     this.set(S_PlanidO,new Long(value));
  }
  public  void setPlanidONull(){
     this.set(S_PlanidO,null);
  }

  public long getPlanidO(){
        return DataType.getAsLong(this.get(S_PlanidO));
  
  }
  public long getPlanidOInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_PlanidO));
      }

  public void initOnlineTimeN(Timestamp value){
     this.initProperty(S_OnlineTimeN,value);
  }
  public  void setOnlineTimeN(Timestamp value){
     this.set(S_OnlineTimeN,value);
  }
  public  void setOnlineTimeNNull(){
     this.set(S_OnlineTimeN,null);
  }

  public Timestamp getOnlineTimeN(){
        return DataType.getAsDateTime(this.get(S_OnlineTimeN));
  
  }
  public Timestamp getOnlineTimeNInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_OnlineTimeN));
      }

  public void initOnlineTimeO(Timestamp value){
     this.initProperty(S_OnlineTimeO,value);
  }
  public  void setOnlineTimeO(Timestamp value){
     this.set(S_OnlineTimeO,value);
  }
  public  void setOnlineTimeONull(){
     this.set(S_OnlineTimeO,null);
  }

  public Timestamp getOnlineTimeO(){
        return DataType.getAsDateTime(this.get(S_OnlineTimeO));
  
  }
  public Timestamp getOnlineTimeOInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_OnlineTimeO));
      }

  public void initChangeTaskTag(String value){
     this.initProperty(S_ChangeTaskTag,value);
  }
  public  void setChangeTaskTag(String value){
     this.set(S_ChangeTaskTag,value);
  }
  public  void setChangeTaskTagNull(){
     this.set(S_ChangeTaskTag,null);
  }

  public String getChangeTaskTag(){
       return DataType.getAsString(this.get(S_ChangeTaskTag));
  
  }
  public String getChangeTaskTagInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ChangeTaskTag));
      }

  public void initChangeStaffId(long value){
     this.initProperty(S_ChangeStaffId,new Long(value));
  }
  public  void setChangeStaffId(long value){
     this.set(S_ChangeStaffId,new Long(value));
  }
  public  void setChangeStaffIdNull(){
     this.set(S_ChangeStaffId,null);
  }

  public long getChangeStaffId(){
        return DataType.getAsLong(this.get(S_ChangeStaffId));
  
  }
  public long getChangeStaffIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_ChangeStaffId));
      }

  public void initAtcId(long value){
     this.initProperty(S_AtcId,new Long(value));
  }
  public  void setAtcId(long value){
     this.set(S_AtcId,new Long(value));
  }
  public  void setAtcIdNull(){
     this.set(S_AtcId,null);
  }

  public long getAtcId(){
        return DataType.getAsLong(this.get(S_AtcId));
  
  }
  public long getAtcIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_AtcId));
      }


 
 }

