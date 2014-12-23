package com.asiainfo.aiga.bo;

import java.sql.*;
import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.common.DataType;

import com.asiainfo.aiga.ivalues.*;

public class BOAigaTestPlanChangeBean extends DataContainer implements DataContainerInterface,IBOAigaTestPlanChangeValue{

  private static String  m_boName = "com.asiainfo.aiga.bo.BOAigaTestPlanChange";



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
  public BOAigaTestPlanChangeBean() throws AIException{
      super(ServiceManager.getObjectTypeFactory().getInstance(m_boName));
  }


 public static ObjectType getObjectTypeStatic() throws AIException{
   return ServiceManager.getObjectTypeFactory().getInstance(m_boName);
 }

 public void setObjectType(ObjectType  value) throws AIException{
   throw new AIException("此种数据容器不能重置业务对象类型");
 }


  public void initVersionContentO(long value){
     this.initProperty(S_VersionContentO,new Long(value));
  }
  public  void setVersionContentO(long value){
     this.set(S_VersionContentO,new Long(value));
  }
  public  void setVersionContentONull(){
     this.set(S_VersionContentO,null);
  }

  public long getVersionContentO(){
        return DataType.getAsLong(this.get(S_VersionContentO));
  
  }
  public long getVersionContentOInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_VersionContentO));
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

  public void initReqtimeN(Timestamp value){
     this.initProperty(S_ReqtimeN,value);
  }
  public  void setReqtimeN(Timestamp value){
     this.set(S_ReqtimeN,value);
  }
  public  void setReqtimeNNull(){
     this.set(S_ReqtimeN,null);
  }

  public Timestamp getReqtimeN(){
        return DataType.getAsDateTime(this.get(S_ReqtimeN));
  
  }
  public Timestamp getReqtimeNInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_ReqtimeN));
      }

  public void initVersionContentN(long value){
     this.initProperty(S_VersionContentN,new Long(value));
  }
  public  void setVersionContentN(long value){
     this.set(S_VersionContentN,new Long(value));
  }
  public  void setVersionContentNNull(){
     this.set(S_VersionContentN,null);
  }

  public long getVersionContentN(){
        return DataType.getAsLong(this.get(S_VersionContentN));
  
  }
  public long getVersionContentNInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_VersionContentN));
      }

  public void initReqtimeO(Timestamp value){
     this.initProperty(S_ReqtimeO,value);
  }
  public  void setReqtimeO(Timestamp value){
     this.set(S_ReqtimeO,value);
  }
  public  void setReqtimeONull(){
     this.set(S_ReqtimeO,null);
  }

  public Timestamp getReqtimeO(){
        return DataType.getAsDateTime(this.get(S_ReqtimeO));
  
  }
  public Timestamp getReqtimeOInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_ReqtimeO));
      }

  public void initAcId(long value){
     this.initProperty(S_AcId,new Long(value));
  }
  public  void setAcId(long value){
     this.set(S_AcId,new Long(value));
  }
  public  void setAcIdNull(){
     this.set(S_AcId,null);
  }

  public long getAcId(){
        return DataType.getAsLong(this.get(S_AcId));
  
  }
  public long getAcIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_AcId));
      }

  public void initChangeReason(String value){
     this.initProperty(S_ChangeReason,value);
  }
  public  void setChangeReason(String value){
     this.set(S_ChangeReason,value);
  }
  public  void setChangeReasonNull(){
     this.set(S_ChangeReason,null);
  }

  public String getChangeReason(){
       return DataType.getAsString(this.get(S_ChangeReason));
  
  }
  public String getChangeReasonInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ChangeReason));
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

  public void initFactcompletetimeN(Timestamp value){
     this.initProperty(S_FactcompletetimeN,value);
  }
  public  void setFactcompletetimeN(Timestamp value){
     this.set(S_FactcompletetimeN,value);
  }
  public  void setFactcompletetimeNNull(){
     this.set(S_FactcompletetimeN,null);
  }

  public Timestamp getFactcompletetimeN(){
        return DataType.getAsDateTime(this.get(S_FactcompletetimeN));
  
  }
  public Timestamp getFactcompletetimeNInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_FactcompletetimeN));
      }

  public void initChangePlanTag(String value){
     this.initProperty(S_ChangePlanTag,value);
  }
  public  void setChangePlanTag(String value){
     this.set(S_ChangePlanTag,value);
  }
  public  void setChangePlanTagNull(){
     this.set(S_ChangePlanTag,null);
  }

  public String getChangePlanTag(){
       return DataType.getAsString(this.get(S_ChangePlanTag));
  
  }
  public String getChangePlanTagInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ChangePlanTag));
      }

  public void initFactcompletetimeO(Timestamp value){
     this.initProperty(S_FactcompletetimeO,value);
  }
  public  void setFactcompletetimeO(Timestamp value){
     this.set(S_FactcompletetimeO,value);
  }
  public  void setFactcompletetimeONull(){
     this.set(S_FactcompletetimeO,null);
  }

  public Timestamp getFactcompletetimeO(){
        return DataType.getAsDateTime(this.get(S_FactcompletetimeO));
  
  }
  public Timestamp getFactcompletetimeOInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_FactcompletetimeO));
      }

  public void initChangeStaffName(String value){
     this.initProperty(S_ChangeStaffName,value);
  }
  public  void setChangeStaffName(String value){
     this.set(S_ChangeStaffName,value);
  }
  public  void setChangeStaffNameNull(){
     this.set(S_ChangeStaffName,null);
  }

  public String getChangeStaffName(){
       return DataType.getAsString(this.get(S_ChangeStaffName));
  
  }
  public String getChangeStaffNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ChangeStaffName));
      }

  public void initChangePlanId(long value){
     this.initProperty(S_ChangePlanId,new Long(value));
  }
  public  void setChangePlanId(long value){
     this.set(S_ChangePlanId,new Long(value));
  }
  public  void setChangePlanIdNull(){
     this.set(S_ChangePlanId,null);
  }

  public long getChangePlanId(){
        return DataType.getAsLong(this.get(S_ChangePlanId));
  
  }
  public long getChangePlanIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_ChangePlanId));
      }

  public void initCodecommitdateO(Timestamp value){
     this.initProperty(S_CodecommitdateO,value);
  }
  public  void setCodecommitdateO(Timestamp value){
     this.set(S_CodecommitdateO,value);
  }
  public  void setCodecommitdateONull(){
     this.set(S_CodecommitdateO,null);
  }

  public Timestamp getCodecommitdateO(){
        return DataType.getAsDateTime(this.get(S_CodecommitdateO));
  
  }
  public Timestamp getCodecommitdateOInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_CodecommitdateO));
      }

  public void initCodecommitdateN(Timestamp value){
     this.initProperty(S_CodecommitdateN,value);
  }
  public  void setCodecommitdateN(Timestamp value){
     this.set(S_CodecommitdateN,value);
  }
  public  void setCodecommitdateNNull(){
     this.set(S_CodecommitdateN,null);
  }

  public Timestamp getCodecommitdateN(){
        return DataType.getAsDateTime(this.get(S_CodecommitdateN));
  
  }
  public Timestamp getCodecommitdateNInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_CodecommitdateN));
      }


 
 }

