package com.asiainfo.aiga.bo;

import java.sql.*;
import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.common.DataType;

import com.asiainfo.aiga.ivalues.*;

public class BOAigaLinkTimeConfigBean extends DataContainer implements DataContainerInterface,IBOAigaLinkTimeConfigValue{

  private static String  m_boName = "com.asiainfo.aiga.bo.BOAigaLinkTimeConfig";



  public final static  String S_Base = "BASE";
  public final static  String S_Mark = "MARK";
  public final static  String S_DayNum = "DAY_NUM";
  public final static  String S_Id = "ID";
  public final static  String S_LinkNo = "LINK_NO";
  public final static  String S_Operate = "OPERATE";
  public BOAigaLinkTimeConfigBean() throws AIException{
      super(ServiceManager.getObjectTypeFactory().getInstance(m_boName));
  }


 public static ObjectType getObjectTypeStatic() throws AIException{
   return ServiceManager.getObjectTypeFactory().getInstance(m_boName);
 }

 public void setObjectType(ObjectType  value) throws AIException{
   throw new AIException("此种数据容器不能重置业务对象类型");
 }


  public void initBase(long value){
     this.initProperty(S_Base,new Long(value));
  }
  public  void setBase(long value){
     this.set(S_Base,new Long(value));
  }
  public  void setBaseNull(){
     this.set(S_Base,null);
  }

  public long getBase(){
        return DataType.getAsLong(this.get(S_Base));
  
  }
  public long getBaseInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_Base));
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

  public void initDayNum(long value){
     this.initProperty(S_DayNum,new Long(value));
  }
  public  void setDayNum(long value){
     this.set(S_DayNum,new Long(value));
  }
  public  void setDayNumNull(){
     this.set(S_DayNum,null);
  }

  public long getDayNum(){
        return DataType.getAsLong(this.get(S_DayNum));
  
  }
  public long getDayNumInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_DayNum));
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

  public void initLinkNo(String value){
     this.initProperty(S_LinkNo,value);
  }
  public  void setLinkNo(String value){
     this.set(S_LinkNo,value);
  }
  public  void setLinkNoNull(){
     this.set(S_LinkNo,null);
  }

  public String getLinkNo(){
       return DataType.getAsString(this.get(S_LinkNo));
  
  }
  public String getLinkNoInitialValue(){
        return DataType.getAsString(this.getOldObj(S_LinkNo));
      }

  public void initOperate(long value){
     this.initProperty(S_Operate,new Long(value));
  }
  public  void setOperate(long value){
     this.set(S_Operate,new Long(value));
  }
  public  void setOperateNull(){
     this.set(S_Operate,null);
  }

  public long getOperate(){
        return DataType.getAsLong(this.get(S_Operate));
  
  }
  public long getOperateInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_Operate));
      }


 
 }

