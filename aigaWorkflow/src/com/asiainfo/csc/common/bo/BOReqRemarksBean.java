package com.asiainfo.csc.common.bo;

import java.sql.*;
import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.common.DataType;

import com.asiainfo.csc.common.ivalues.*;

public class BOReqRemarksBean extends DataContainer implements DataContainerInterface,IBOReqRemarksValue{

  private static String  m_boName = "com.asiainfo.csc.common.bo.BOReqRemarks";



  public final static  String S_ObjTag = "OBJ_TAG";
  public final static  String S_Remarks = "REMARKS";
  public final static  String S_CreateTime = "CREATE_TIME";
  public final static  String S_ObjType = "OBJ_TYPE";
  public final static  String S_RemarkId = "REMARK_ID";
  public final static  String S_ChangeTime = "CHANGE_TIME";

  public static ObjectType S_TYPE = null;
  static{
    try {
      S_TYPE = ServiceManager.getObjectTypeFactory().getInstance(m_boName);
    }catch(Exception e){
      throw new RuntimeException(e);
    }
  }
  public BOReqRemarksBean() throws AIException{
      super(S_TYPE);
  }

 public static ObjectType getObjectTypeStatic() throws AIException{
   return S_TYPE;
 }

 public void setObjectType(ObjectType  value) throws AIException{
   throw new AIException("此种数据容器不能重置业务对象类型");
 }


  public void initObjTag(String value){
     this.initProperty(S_ObjTag,value);
  }
  public  void setObjTag(String value){
     this.set(S_ObjTag,value);
  }
  public  void setObjTagNull(){
     this.set(S_ObjTag,null);
  }

  public String getObjTag(){
       return DataType.getAsString(this.get(S_ObjTag));
  
  }
  public String getObjTagInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ObjTag));
      }

  public void initRemarks(String value){
     this.initProperty(S_Remarks,value);
  }
  public  void setRemarks(String value){
     this.set(S_Remarks,value);
  }
  public  void setRemarksNull(){
     this.set(S_Remarks,null);
  }

  public String getRemarks(){
       return DataType.getAsString(this.get(S_Remarks));
  
  }
  public String getRemarksInitialValue(){
        return DataType.getAsString(this.getOldObj(S_Remarks));
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

  public void initObjType(int value){
     this.initProperty(S_ObjType,new Integer(value));
  }
  public  void setObjType(int value){
     this.set(S_ObjType,new Integer(value));
  }
  public  void setObjTypeNull(){
     this.set(S_ObjType,null);
  }

  public int getObjType(){
        return DataType.getAsInt(this.get(S_ObjType));
  
  }
  public int getObjTypeInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_ObjType));
      }

  public void initRemarkId(long value){
     this.initProperty(S_RemarkId,new Long(value));
  }
  public  void setRemarkId(long value){
     this.set(S_RemarkId,new Long(value));
  }
  public  void setRemarkIdNull(){
     this.set(S_RemarkId,null);
  }

  public long getRemarkId(){
        return DataType.getAsLong(this.get(S_RemarkId));
  
  }
  public long getRemarkIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_RemarkId));
      }

  public void initChangeTime(Timestamp value){
     this.initProperty(S_ChangeTime,value);
  }
  public  void setChangeTime(Timestamp value){
     this.set(S_ChangeTime,value);
  }
  public  void setChangeTimeNull(){
     this.set(S_ChangeTime,null);
  }

  public Timestamp getChangeTime(){
        return DataType.getAsDateTime(this.get(S_ChangeTime));
  
  }
  public Timestamp getChangeTimeInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_ChangeTime));
      }


 
 }

