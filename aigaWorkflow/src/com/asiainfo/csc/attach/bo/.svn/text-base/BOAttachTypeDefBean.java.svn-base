package com.asiainfo.csc.attach.bo;

import java.sql.*;
import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.common.DataType;

import com.asiainfo.csc.attach.ivalues.*;

public class BOAttachTypeDefBean extends DataContainer implements DataContainerInterface,IBOAttachTypeDefValue{

  private static String  m_boName = "com.asiainfo.csc.attach.bo.BOAttachTypeDef";



  public final static  String S_AttTypeDesc = "ATT_TYPE_DESC";
  public final static  String S_AttTypeId = "ATT_TYPE_ID";
  public final static  String S_AttTypeName = "ATT_TYPE_NAME";
  public BOAttachTypeDefBean() throws AIException{
      super(ServiceManager.getObjectTypeFactory().getInstance(m_boName));
  }


 public static ObjectType getObjectTypeStatic() throws AIException{
   return ServiceManager.getObjectTypeFactory().getInstance(m_boName);
 }

 public void setObjectType(ObjectType  value) throws AIException{
   throw new AIException("此种数据容器不能重置业务对象类型");
 }


  public void initAttTypeDesc(String value){
     this.initProperty(S_AttTypeDesc,value);
  }
  public  void setAttTypeDesc(String value){
     this.set(S_AttTypeDesc,value);
  }
  public  void setAttTypeDescNull(){
     this.set(S_AttTypeDesc,null);
  }

  public String getAttTypeDesc(){
       return DataType.getAsString(this.get(S_AttTypeDesc));
  
  }
  public String getAttTypeDescInitialValue(){
        return DataType.getAsString(this.getOldObj(S_AttTypeDesc));
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

  public void initAttTypeName(String value){
     this.initProperty(S_AttTypeName,value);
  }
  public  void setAttTypeName(String value){
     this.set(S_AttTypeName,value);
  }
  public  void setAttTypeNameNull(){
     this.set(S_AttTypeName,null);
  }

  public String getAttTypeName(){
       return DataType.getAsString(this.get(S_AttTypeName));
  
  }
  public String getAttTypeNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_AttTypeName));
      }


 
 }

