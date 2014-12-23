package com.asiainfo.csc.common.bo;

import java.sql.*;
import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.common.DataType;

import com.asiainfo.csc.common.ivalues.*;

public class BOStaffManagerRelatBean extends DataContainer implements DataContainerInterface,IBOStaffManagerRelatValue{

  private static String  m_boName = "com.asiainfo.csc.common.bo.BOStaffManagerRelat";



  public final static  String S_ReqType = "REQ_TYPE";
  public final static  String S_StaffId = "STAFF_ID";
  public final static  String S_ConfigDscr = "CONFIG_DSCR";
  public final static  String S_SysTag = "SYS_TAG";
  public final static  String S_StaffName = "STAFF_NAME";
  public final static  String S_StaffManagerRelatId = "STAFF_MANAGER_RELAT_ID";
  public BOStaffManagerRelatBean() throws AIException{
      super(ServiceManager.getObjectTypeFactory().getInstance(m_boName));
  }


 public static ObjectType getObjectTypeStatic() throws AIException{
   return ServiceManager.getObjectTypeFactory().getInstance(m_boName);
 }

 public void setObjectType(ObjectType  value) throws AIException{
   throw new AIException("此种数据容器不能重置业务对象类型");
 }


  public void initReqType(String value){
     this.initProperty(S_ReqType,value);
  }
  public  void setReqType(String value){
     this.set(S_ReqType,value);
  }
  public  void setReqTypeNull(){
     this.set(S_ReqType,null);
  }

  public String getReqType(){
       return DataType.getAsString(this.get(S_ReqType));
  
  }
  public String getReqTypeInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ReqType));
      }

  public void initStaffId(long value){
     this.initProperty(S_StaffId,new Long(value));
  }
  public  void setStaffId(long value){
     this.set(S_StaffId,new Long(value));
  }
  public  void setStaffIdNull(){
     this.set(S_StaffId,null);
  }

  public long getStaffId(){
        return DataType.getAsLong(this.get(S_StaffId));
  
  }
  public long getStaffIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_StaffId));
      }

  public void initConfigDscr(String value){
     this.initProperty(S_ConfigDscr,value);
  }
  public  void setConfigDscr(String value){
     this.set(S_ConfigDscr,value);
  }
  public  void setConfigDscrNull(){
     this.set(S_ConfigDscr,null);
  }

  public String getConfigDscr(){
       return DataType.getAsString(this.get(S_ConfigDscr));
  
  }
  public String getConfigDscrInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ConfigDscr));
      }

  public void initSysTag(long value){
     this.initProperty(S_SysTag,new Long(value));
  }
  public  void setSysTag(long value){
     this.set(S_SysTag,new Long(value));
  }
  public  void setSysTagNull(){
     this.set(S_SysTag,null);
  }

  public long getSysTag(){
        return DataType.getAsLong(this.get(S_SysTag));
  
  }
  public long getSysTagInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_SysTag));
      }

  public void initStaffName(String value){
     this.initProperty(S_StaffName,value);
  }
  public  void setStaffName(String value){
     this.set(S_StaffName,value);
  }
  public  void setStaffNameNull(){
     this.set(S_StaffName,null);
  }

  public String getStaffName(){
       return DataType.getAsString(this.get(S_StaffName));
  
  }
  public String getStaffNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_StaffName));
      }

  public void initStaffManagerRelatId(long value){
     this.initProperty(S_StaffManagerRelatId,new Long(value));
  }
  public  void setStaffManagerRelatId(long value){
     this.set(S_StaffManagerRelatId,new Long(value));
  }
  public  void setStaffManagerRelatIdNull(){
     this.set(S_StaffManagerRelatId,null);
  }

  public long getStaffManagerRelatId(){
        return DataType.getAsLong(this.get(S_StaffManagerRelatId));
  
  }
  public long getStaffManagerRelatIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_StaffManagerRelatId));
      }


 
 }

