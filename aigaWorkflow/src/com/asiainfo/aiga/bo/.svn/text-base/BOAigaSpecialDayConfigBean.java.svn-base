package com.asiainfo.aiga.bo;

import java.sql.*;
import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.common.DataType;

import com.asiainfo.aiga.ivalues.*;

public class BOAigaSpecialDayConfigBean extends DataContainer implements DataContainerInterface,IBOAigaSpecialDayConfigValue{

  private static String  m_boName = "com.asiainfo.aiga.bo.BOAigaSpecialDayConfig";



  public final static  String S_Mark = "MARK";
  public final static  String S_Id = "ID";
  public final static  String S_SpecialDay = "SPECIAL_DAY";
  public BOAigaSpecialDayConfigBean() throws AIException{
      super(ServiceManager.getObjectTypeFactory().getInstance(m_boName));
  }


 public static ObjectType getObjectTypeStatic() throws AIException{
   return ServiceManager.getObjectTypeFactory().getInstance(m_boName);
 }

 public void setObjectType(ObjectType  value) throws AIException{
   throw new AIException("此种数据容器不能重置业务对象类型");
 }


  public void initMark(String value){
     this.initProperty(S_Mark,value);
  }
  public  void setMark(String value){
     this.set(S_Mark,value);
  }
  public  void setMarkNull(){
     this.set(S_Mark,null);
  }

  public String getMark(){
       return DataType.getAsString(this.get(S_Mark));
  
  }
  public String getMarkInitialValue(){
        return DataType.getAsString(this.getOldObj(S_Mark));
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

  public void initSpecialDay(Timestamp value){
     this.initProperty(S_SpecialDay,value);
  }
  public  void setSpecialDay(Timestamp value){
     this.set(S_SpecialDay,value);
  }
  public  void setSpecialDayNull(){
     this.set(S_SpecialDay,null);
  }

  public Timestamp getSpecialDay(){
        return DataType.getAsDateTime(this.get(S_SpecialDay));
  
  }
  public Timestamp getSpecialDayInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_SpecialDay));
      }


 
 }

