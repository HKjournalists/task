package com.asiainfo.csc.attach.bo;

import java.sql.*;
import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.common.DataType;

import com.asiainfo.csc.attach.ivalues.*;

public class BOPackageBean extends DataContainer implements DataContainerInterface,IBOPackageValue{

  private static String  m_boName = "com.asiainfo.csc.attach.bo.BOPackage";



  public final static  String S_AttId = "ATT_ID";
  public final static  String S_ObjNo = "OBJ_NO";
  public final static  String S_ObjId = "OBJ_ID";
  public final static  String S_ObjType = "OBJ_TYPE";
  public final static  String S_AttPackDesc = "ATT_PACK_DESC";
  public final static  String S_AttPackId = "ATT_PACK_ID";

  public static ObjectType S_TYPE = null;
  static{
    try {
      S_TYPE = ServiceManager.getObjectTypeFactory().getInstance(m_boName);
    }catch(Exception e){
      throw new RuntimeException(e);
    }
  }
  public BOPackageBean() throws AIException{
      super(S_TYPE);
  }

 public static ObjectType getObjectTypeStatic() throws AIException{
   return S_TYPE;
 }

 public void setObjectType(ObjectType  value) throws AIException{
   throw new AIException("此种数据容器不能重置业务对象类型");
 }


  public void initAttId(long value){
     this.initProperty(S_AttId,new Long(value));
  }
  public  void setAttId(long value){
     this.set(S_AttId,new Long(value));
  }
  public  void setAttIdNull(){
     this.set(S_AttId,null);
  }

  public long getAttId(){
        return DataType.getAsLong(this.get(S_AttId));
  
  }
  public long getAttIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_AttId));
      }

  public void initObjNo(String value){
     this.initProperty(S_ObjNo,value);
  }
  public  void setObjNo(String value){
     this.set(S_ObjNo,value);
  }
  public  void setObjNoNull(){
     this.set(S_ObjNo,null);
  }

  public String getObjNo(){
       return DataType.getAsString(this.get(S_ObjNo));
  
  }
  public String getObjNoInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ObjNo));
      }

  public void initObjId(long value){
     this.initProperty(S_ObjId,new Long(value));
  }
  public  void setObjId(long value){
     this.set(S_ObjId,new Long(value));
  }
  public  void setObjIdNull(){
     this.set(S_ObjId,null);
  }

  public long getObjId(){
        return DataType.getAsLong(this.get(S_ObjId));
  
  }
  public long getObjIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_ObjId));
      }

  public void initObjType(long value){
     this.initProperty(S_ObjType,new Long(value));
  }
  public  void setObjType(long value){
     this.set(S_ObjType,new Long(value));
  }
  public  void setObjTypeNull(){
     this.set(S_ObjType,null);
  }

  public long getObjType(){
        return DataType.getAsLong(this.get(S_ObjType));
  
  }
  public long getObjTypeInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_ObjType));
      }

  public void initAttPackDesc(String value){
     this.initProperty(S_AttPackDesc,value);
  }
  public  void setAttPackDesc(String value){
     this.set(S_AttPackDesc,value);
  }
  public  void setAttPackDescNull(){
     this.set(S_AttPackDesc,null);
  }

  public String getAttPackDesc(){
       return DataType.getAsString(this.get(S_AttPackDesc));
  
  }
  public String getAttPackDescInitialValue(){
        return DataType.getAsString(this.getOldObj(S_AttPackDesc));
      }

  public void initAttPackId(long value){
     this.initProperty(S_AttPackId,new Long(value));
  }
  public  void setAttPackId(long value){
     this.set(S_AttPackId,new Long(value));
  }
  public  void setAttPackIdNull(){
     this.set(S_AttPackId,null);
  }

  public long getAttPackId(){
        return DataType.getAsLong(this.get(S_AttPackId));
  
  }
  public long getAttPackIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_AttPackId));
      }


 
 }

