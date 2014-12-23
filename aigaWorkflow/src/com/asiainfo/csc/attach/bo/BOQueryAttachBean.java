package com.asiainfo.csc.attach.bo;

import java.sql.*;
import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.common.DataType;

import com.asiainfo.csc.attach.ivalues.*;

public class BOQueryAttachBean extends DataContainer implements DataContainerInterface,IBOQueryAttachValue{

  private static String  m_boName = "com.asiainfo.csc.attach.bo.BOQueryAttach";



  public final static  String S_AttId = "ATT_ID";
  public final static  String S_AttName = "ATT_NAME";
  public final static  String S_AttDesc = "ATT_DESC";
  public final static  String S_SubmitterTag = "SUBMITTER_TAG";
  public final static  String S_SubmitTime = "SUBMIT_TIME";
  public final static  String S_Status = "STATUS";
  public final static  String S_SubmitLink = "SUBMIT_LINK";
  public final static  String S_AttTypeName = "ATT_TYPE_NAME";
  public final static  String S_AttType = "ATT_TYPE";
  public final static  String S_AttPath = "ATT_PATH";
  public BOQueryAttachBean() throws AIException{
      super(ServiceManager.getObjectTypeFactory().getInstance(m_boName));
  }


 public static ObjectType getObjectTypeStatic() throws AIException{
   return ServiceManager.getObjectTypeFactory().getInstance(m_boName);
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

  public void initAttName(String value){
     this.initProperty(S_AttName,value);
  }
  public  void setAttName(String value){
     this.set(S_AttName,value);
  }
  public  void setAttNameNull(){
     this.set(S_AttName,null);
  }

  public String getAttName(){
       return DataType.getAsString(this.get(S_AttName));
  
  }
  public String getAttNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_AttName));
      }

  public void initAttDesc(String value){
     this.initProperty(S_AttDesc,value);
  }
  public  void setAttDesc(String value){
     this.set(S_AttDesc,value);
  }
  public  void setAttDescNull(){
     this.set(S_AttDesc,null);
  }

  public String getAttDesc(){
       return DataType.getAsString(this.get(S_AttDesc));
  
  }
  public String getAttDescInitialValue(){
        return DataType.getAsString(this.getOldObj(S_AttDesc));
      }

  public void initSubmitterTag(String value){
     this.initProperty(S_SubmitterTag,value);
  }
  public  void setSubmitterTag(String value){
     this.set(S_SubmitterTag,value);
  }
  public  void setSubmitterTagNull(){
     this.set(S_SubmitterTag,null);
  }

  public String getSubmitterTag(){
       return DataType.getAsString(this.get(S_SubmitterTag));
  
  }
  public String getSubmitterTagInitialValue(){
        return DataType.getAsString(this.getOldObj(S_SubmitterTag));
      }

  public void initSubmitTime(Timestamp value){
     this.initProperty(S_SubmitTime,value);
  }
  public  void setSubmitTime(Timestamp value){
     this.set(S_SubmitTime,value);
  }
  public  void setSubmitTimeNull(){
     this.set(S_SubmitTime,null);
  }

  public Timestamp getSubmitTime(){
        return DataType.getAsDateTime(this.get(S_SubmitTime));
  
  }
  public Timestamp getSubmitTimeInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_SubmitTime));
      }

  public void initStatus(long value){
     this.initProperty(S_Status,new Long(value));
  }
  public  void setStatus(long value){
     this.set(S_Status,new Long(value));
  }
  public  void setStatusNull(){
     this.set(S_Status,null);
  }

  public long getStatus(){
        return DataType.getAsLong(this.get(S_Status));
  
  }
  public long getStatusInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_Status));
      }

  public void initSubmitLink(String value){
     this.initProperty(S_SubmitLink,value);
  }
  public  void setSubmitLink(String value){
     this.set(S_SubmitLink,value);
  }
  public  void setSubmitLinkNull(){
     this.set(S_SubmitLink,null);
  }

  public String getSubmitLink(){
       return DataType.getAsString(this.get(S_SubmitLink));
  
  }
  public String getSubmitLinkInitialValue(){
        return DataType.getAsString(this.getOldObj(S_SubmitLink));
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

  public void initAttType(String value){
     this.initProperty(S_AttType,value);
  }
  public  void setAttType(String value){
     this.set(S_AttType,value);
  }
  public  void setAttTypeNull(){
     this.set(S_AttType,null);
  }

  public String getAttType(){
       return DataType.getAsString(this.get(S_AttType));
  
  }
  public String getAttTypeInitialValue(){
        return DataType.getAsString(this.getOldObj(S_AttType));
      }

  public void initAttPath(String value){
     this.initProperty(S_AttPath,value);
  }
  public  void setAttPath(String value){
     this.set(S_AttPath,value);
  }
  public  void setAttPathNull(){
     this.set(S_AttPath,null);
  }

  public String getAttPath(){
       return DataType.getAsString(this.get(S_AttPath));
  
  }
  public String getAttPathInitialValue(){
        return DataType.getAsString(this.getOldObj(S_AttPath));
      }


 
 }

