package com.asiainfo.csc.attach.bo;

import java.sql.*;
import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.common.DataType;

import com.asiainfo.csc.attach.ivalues.*;

public class BOAttachTypeConfigBean extends DataContainer implements DataContainerInterface,IBOAttachTypeConfigValue{

  private static String  m_boName = "com.asiainfo.csc.attach.bo.BOAttachTypeConfig";



  public final static  String S_AttConfId = "ATT_CONF_ID";
  public final static  String S_IsCheck = "IS_CHECK";
  public final static  String S_Cond = "COND";
  public final static  String S_Zone = "ZONE";
  public final static  String S_AttTypeId = "ATT_TYPE_ID";
  public BOAttachTypeConfigBean() throws AIException{
      super(ServiceManager.getObjectTypeFactory().getInstance(m_boName));
  }


 public static ObjectType getObjectTypeStatic() throws AIException{
   return ServiceManager.getObjectTypeFactory().getInstance(m_boName);
 }

 public void setObjectType(ObjectType  value) throws AIException{
   throw new AIException("此种数据容器不能重置业务对象类型");
 }


  public void initAttConfId(long value){
     this.initProperty(S_AttConfId,new Long(value));
  }
  public  void setAttConfId(long value){
     this.set(S_AttConfId,new Long(value));
  }
  public  void setAttConfIdNull(){
     this.set(S_AttConfId,null);
  }

  public long getAttConfId(){
        return DataType.getAsLong(this.get(S_AttConfId));
  
  }
  public long getAttConfIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_AttConfId));
      }

  public void initIsCheck(String value){
     this.initProperty(S_IsCheck,value);
  }
  public  void setIsCheck(String value){
     this.set(S_IsCheck,value);
  }
  public  void setIsCheckNull(){
     this.set(S_IsCheck,null);
  }

  public String getIsCheck(){
       return DataType.getAsString(this.get(S_IsCheck));
  
  }
  public String getIsCheckInitialValue(){
        return DataType.getAsString(this.getOldObj(S_IsCheck));
      }

  public void initCond(String value){
     this.initProperty(S_Cond,value);
  }
  public  void setCond(String value){
     this.set(S_Cond,value);
  }
  public  void setCondNull(){
     this.set(S_Cond,null);
  }

  public String getCond(){
       return DataType.getAsString(this.get(S_Cond));
  
  }
  public String getCondInitialValue(){
        return DataType.getAsString(this.getOldObj(S_Cond));
      }

  public void initZone(long value){
     this.initProperty(S_Zone,new Long(value));
  }
  public  void setZone(long value){
     this.set(S_Zone,new Long(value));
  }
  public  void setZoneNull(){
     this.set(S_Zone,null);
  }

  public long getZone(){
        return DataType.getAsLong(this.get(S_Zone));
  
  }
  public long getZoneInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_Zone));
      }

  public void initAttTypeId(long value){
     this.initProperty(S_AttTypeId,new Long(value));
  }
  public  void setAttTypeId(long value){
     this.set(S_AttTypeId,new Long(value));
  }
  public  void setAttTypeIdNull(){
     this.set(S_AttTypeId,null);
  }

  public long getAttTypeId(){
        return DataType.getAsLong(this.get(S_AttTypeId));
  
  }
  public long getAttTypeIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_AttTypeId));
      }


 
 }

